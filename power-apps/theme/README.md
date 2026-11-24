# BrandTheme for Power Apps

A reusable theme in Texas-flag colors, matched to the infintgroup.com palette.

## Use it

1. In Power Apps Studio, select **App → OnStart**.
2. Paste the contents of [`BrandTheme.OnStart.fx`](BrandTheme.OnStart.fx).
3. Select **App → … → Run OnStart** so Studio picks it up.
4. Set control properties, for example:

```powerfx
Fill:      BrandTheme.Primary
Color:     BrandTheme.TextOnPrimary
HoverFill: BrandTheme.PrimaryHover
Font:      BrandTheme.FontBody
```

## Why OnStart and not a named formula?

A theme record defined as a **named formula** in `App.Formulas` rendered correctly in
Studio but came back blank in the published player (controls turned black). A global
variable set in `App.OnStart` works in both. Avoid naming it `Theme`, which collides
with the built-in `App.Theme`.

## Palette

| Token | Color |
|---|---|
| `Primary` | `#002868` (Old Glory Blue) |
| `PrimaryDark` / `PrimaryHover` | `#00205B` / `#001A4D` |
| `PrimaryLight` | `#E6EAF2` |
| `Accent` / `Error` | `#BF0D3E` |
| `Background` | `#F5F7FA` |
| `Text` / `TextSecondary` | `#1D2124` / `#646464` |
| `Success` / `Warning` | `#107C10` / `#8A5A00` |
