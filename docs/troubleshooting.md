# Troubleshooting

## No emails arrive

1. Open **PPMF | Logs** and look for `owner notification failed` or `run failed`.
2. Check the **Office 365 Outlook** connection used by the solution. If it shows
   *"Unauthorized"* or *"connection isn't working"*, open **Connections**, choose
   **Fix connection**, and sign in again.
3. Confirm at least one valid address is saved in the configuration app.

## The scan finds nothing / checks no environments

The scan only covers environments with **Enabled = Yes**. Environments added before
installation may be disabled. Turn them on in the configuration app.

## "Flows: Not checked - Instance URL missing"

The environment row has no Dataverse URL (for example, an environment without Dataverse).
Run the inventory again. If it's still missing, the environment has no Dataverse and
flow mapping isn't available there.

## Log rows fail to save

Text columns in **PPMF | Logs** are limited to 500 characters. The shipped flows truncate
values. If you add your own logging, wrap values in `take(string(...), 500)`.

## The configuration app shows black boxes and no text (published app only)

This happens when the theme is defined as a **named formula** record in `App.Formulas`:
Studio shows the colors, but the published player can return blank values, which renders
as black. PPMF sets the theme in `App.OnStart` instead:

```powerfx
Set(BrandTheme, { Primary: RGBA(0, 40, 104, 1), /* ... */ })
```

If you change the theme, keep it in `App.OnStart`, choose **Run OnStart** in Studio, then
save and publish.

## "Run inventory" shows "Inventory failed"

Check the newest `Inventory Flow - run failed` row in the logs. The usual causes are an
expired **Power Platform for Admins V2** connection or the account lacking admin rights.

## Admin connectors return 403 / Forbidden

The connection owner needs the Power Platform administrator (or Dynamics 365
administrator) role. See [Permissions](installation.md#permissions).
