# Architecture

PPMF is a single Dataverse solution (`PPMF`, publisher prefix `ppmf_`) made of three
tables, cloud flows, one canvas app, and connection references. Nothing runs outside
Power Platform.

## Components

```mermaid
flowchart TB
    subgraph Solution["PPMF solution"]
        direction TB
        subgraph Tables
            T1[("ppmf_config<br/>PPMF | Configuration")]
            T2[("ppmf_environments<br/>PPMF | Environments")]
            T3[("ppmf_logs<br/>PPMF | Logs")]
            T4[("ppmf_emailtemplates<br/>PPMF | Email Templates")]
        end
        subgraph Flows["Cloud flows"]
            F1["Inventory Flow"]
            F2["Connections | Detect Broken Connections"]
            F3["Logger Flow (child)"]
            F4["Roadmap monitors (placeholders)"]
        end
        A1["PPMF - Configuration App"]
        subgraph Refs["Connection references"]
            R1["Microsoft Dataverse"]
            R2["Power Apps for Admins"]
            R3["Office 365 Outlook"]
            R4["Power Platform for Admins V2"]
        end
    end
    A1 --> T1 & T2
    A1 --> F1
    F1 --> T2 & T3
    F2 --> T1 & T2 & T3
    F1 -.-> R4 & R1
    F2 -.-> R1 & R2 & R3
```

| Component | Type | Purpose |
|---|---|---|
| `PPMF \| Configuration` | Table | Framework settings (admin email recipients, last inventory run). One row named `Default`. |
| `PPMF \| Environments` | Table | One row per environment, with an **Enabled** switch that controls monitoring. |
| `PPMF \| Logs` | Table | Structured log of every run, warning and error. |
| `PPMF \| Email Templates` | Table | Reusable email subjects and bodies (reserved for future monitors). |
| `PPMF \| Inventory Flow` | Instant flow (Power Apps trigger) | Discovers environments and upserts them into **Environments**. |
| `PPMF \| Connections \| Detect Broken Connections` | Scheduled flow (daily) | Finds broken connections, maps their impact, notifies owners and admins, logs results. |
| `PPMF - Configuration App` | Canvas app | Admin UI for settings, inventory and environment selection. |

## End-to-end: detecting broken connections

```mermaid
sequenceDiagram
    autonumber
    participant S as Scheduler (daily)
    participant F as Detect Broken Connections
    participant C as PPMF | Configuration
    participant E as PPMF | Environments
    participant PA as Power Apps for Admins
    participant D as Environment Dataverse
    participant O as Office 365 Outlook
    participant L as PPMF | Logs

    S->>F: Recurrence trigger
    F->>C: Read "Default" row (admin emails)
    F->>E: List environments where Enabled = Yes
    loop Each enabled environment (sequential)
        F->>PA: Get Connections as Admin
        F->>F: Keep connections whose status is not "Connected"
        alt Broken connections found
            F->>PA: Get Apps as Admin
            loop Each broken connection
                F->>F: Match apps by connector + owner
                F->>D: Connection references bound to this connection
                F->>D: Flows whose definition uses the connection or its references
                F->>F: Append finding (owner, error, apps, flows, fix link)
            end
        end
        Note over F,L: If anything in this environment fails,<br/>log an Error and continue with the next one
    end
    alt Findings exist
        F->>O: Summary table to admin recipients
        loop Each connection owner
            F->>O: Personal table + how to fix
        end
        F->>L: Warning "broken connections found" (+ findings JSON)
    else None
        F->>L: Info "no issues"
    end
```

### How impact is determined

Finding *which* apps and flows a broken connection affects is the core of PPMF.
Power Platform stores this relationship differently for flows and apps, so PPMF uses
two strategies:

```mermaid
flowchart LR
    BC["Broken connection<br/>(id, connector, owner)"]
    subgraph Flows
        CR["Connection references<br/>where connectionid = id"]
        WF["workflows (category 5)<br/>clientdata contains id<br/>OR any reference name"]
    end
    subgraph Apps
        AP["Apps as Admin<br/>connectionReferences contain connector<br/>AND owner = connection owner"]
    end
    BC --> CR --> WF
    BC --> WF
    BC --> AP
```

- **Flows (exact match).** Cloud flows store their connections in the `clientdata`
  definition of the Dataverse `workflow` row. Non-solution flows embed the connection
  name. Solution flows embed a connection-reference logical name, which PPMF resolves
  through the `connectionreference` table. Each flow is listed with its On/Off state.
- **Canvas apps (likely match).** App metadata records the connectors an app uses, not
  which user's connection it uses at run time. PPMF reports apps that use the same
  connector **and** are owned by the connection's owner. The emails say this is a
  "likely affected" list.

## Error-handling model

Every flow follows the same Try / Catch / Log pattern:

```mermaid
flowchart TB
    T["Try scope"] -->|Succeeded| OK["Continue"]
    T -->|Failed / TimedOut| CA["Catch scope"]
    CA --> FF["Filter failed actions<br/>from result('Try')"]
    FF --> LG["Write Error row to PPMF | Logs<br/>(step, code, message, run link)"]
    LG --> AL["Alert admin recipients"]
    AL --> TR["Terminate: Failed"]
```

- **Per-environment isolation.** The environment loop has its own Try/Catch. One
  environment failing (permissions, region outage) logs an error and the scan continues.
- **Soft failures are warnings.** A failed app lookup, flow lookup or single owner email
  writes a Warning row; the rest of the run continues.
- **Bounded log fields.** Every value written to the Logs table is truncated to the column
  size (500 characters), so logging itself cannot fail on long error text.
- **Traceability.** Each log row carries the run ID, flow ID and a deep link to the run.

## Configuration app

```mermaid
flowchart LR
    U["Admin"] --> S["Configuration screen"]
    S -->|Save recipients<br/>validated emails| CFG[("Configuration")]
    S -->|Run inventory<br/>after confirmation| INV["Inventory Flow"]
    INV -->|status, message| S
    S -->|Enabled switch| ENV[("Environments")]
```

The app uses a single global theme record (`BrandTheme`, set in `App.OnStart`) in
Texas-flag colors. See [power-apps/theme](../power-apps/theme).

## Security model

- Flows run as the **flow owner's** connections (connection references). The owner needs
  Power Platform administrator rights to list connections and apps in every environment,
  and read access to each environment's Dataverse to resolve flows.
- Owners only receive their **own** connections; admins receive the full summary.
- No credentials, tokens or secrets are stored in PPMF tables.
