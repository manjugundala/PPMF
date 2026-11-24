# Logging

Every PPMF run writes to **PPMF | Logs** (`ppmf_logs`). Use it to audit runs, investigate
failures, and build dashboards.

## What gets logged

| Title | Level | When |
|---|---|---|
| `Detect Broken Connections - no issues` | Info | Scan finished, nothing broken |
| `Detect Broken Connections - broken connections found` | Warning | Scan found issues (findings JSON in Technical Details) |
| `Detect Broken Connections - app lookup failed` | Warning | App list couldn't be read for an environment |
| `Detect Broken Connections - flow lookup failed` | Warning | Flows couldn't be resolved for a connection |
| `Detect Broken Connections - owner notification failed` | Warning | An owner email couldn't be sent |
| `Detect Broken Connections - environment failed` | Error | An environment couldn't be scanned |
| `Detect Broken Connections - run failed` | Error | The run failed outside the environment loop |
| `Inventory Flow - run failed` | Error | Environment inventory failed |

## Useful views

Create these as Dataverse views on **PPMF | Logs**, or use the queries in
**Advanced find**:

- **Errors in the last 7 days:** Log Level = Error, Occurred On = Last 7 days, sorted newest first.
- **Today's findings:** Title contains `broken connections found`, Occurred On = Today.
- **By environment:** group by Environment Name.

Web API example:

```http
GET [org]/api/data/v9.2/ppmf_logses?$select=ppmf_ppmflogs1,ppmf_summarymessage,ppmf_occurredon
  &$filter=ppmf_loglevel eq 426170002
  &$orderby=ppmf_occurredon desc&$top=50
```

## Retention

Logs are not deleted automatically. Use a Dataverse **bulk delete** job, for example
"delete Info rows older than 90 days", to control storage.
