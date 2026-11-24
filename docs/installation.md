# Installation

## Prerequisites

| Requirement | Why |
|---|---|
| A Dataverse environment to host PPMF (a dedicated "monitoring" environment is recommended) | The solution stores its tables and flows there |
| Power Automate premium licensing for the flow owner | The flows use Dataverse and admin connectors |
| A Power Platform administrator account (or Dynamics 365 administrator) to own the flows | Needed to list connections, apps and environments tenant-wide |
| Read access to the Dataverse of each monitored environment | Needed to resolve which flows use a connection |
| An Exchange Online mailbox for the flow owner | Sends the alert emails |

## Permissions

The connection references should be created with the **same administrator account** that
owns the flows:

| Connection reference | Connector | Used for |
|---|---|---|
| PPMF Dataverse Connection Reference | Microsoft Dataverse | Read/write PPMF tables; query flows and connection references in each environment |
| Power Apps for Admins | Power Apps for Admins | List connections (with status) and apps in each environment |
| Power Platform for Admins V2 | Power Platform for Admins V2 | List environments (inventory) |
| Office 365 Outlook | Office 365 Outlook | Send owner and admin emails |

> **Tip:** use a dedicated service account with a mailbox, not a personal account, so
> monitoring keeps working when people change roles. If that account's own connection
> breaks, PPMF will flag it too.

## Install the managed solution (recommended)

1. Download `solution/PPMF_1_0_0_0_managed.zip` from this repository.
2. Go to [make.powerapps.com](https://make.powerapps.com), select the monitoring environment,
   then **Solutions → Import solution**.
3. Browse to the zip and click **Next**.
4. On **Connections**, create or select a connection for each connection reference
   (see the table above). Sign in with the administrator account.
5. Click **Import** and wait for it to finish.
6. Open **Solutions → Power Platform Monitoring Framework → Cloud flows** and confirm
   every flow is **On**. Turn on any that are off.

## Install the unmanaged solution (for contributors)

Import `solution/PPMF_1_0_0_0.zip` the same way if you want to change the solution.
Use a development environment, not production.

## Post-install checklist

- [ ] Open **PPMF - Configuration App** and enter at least one admin email address.
- [ ] Click **Run inventory now** and confirm your environments appear.
- [ ] Switch **on** each environment you want monitored (new environments are on by default;
      environments that existed before installation may be off).
- [ ] Run **Detect Broken Connections** once manually (**Run** on the flow's details page)
      and confirm a row appears in **PPMF | Logs**.
- [ ] Share the configuration app with your other administrators (**Share** → add users and
      give them the security role that grants access to the PPMF tables).

## Upgrade

Import the newer managed solution over the existing one and choose **Upgrade**.
Your configuration and environment choices are stored as data and are kept.

## Uninstall

Delete the **Power Platform Monitoring Framework** solution. Deleting the managed solution
removes its tables **and their data**, including logs. Export the logs first if you need them.
