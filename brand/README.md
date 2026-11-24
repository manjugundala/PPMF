# Brand assets: Texas flag theme

Shared icon and colors for all repositories and Power Platform apps.
Colors follow the Texas flag, matched to the infintgroup.com palette.

## Files

| File | Use |
|---|---|
| `brand-icon.svg` | Master icon (scalable) |
| `brand-icon-512.png` … `brand-icon-16.png` | App icons, avatars, README logos |
| `favicon.ico` | Websites / Power Pages (16, 32, 64 px) |
| `monitoring-icon.svg`, `monitoring-icon-245.png`, `monitoring-icon-512.png` | Monitoring app icon (PPMF) |
| `social-preview.png` | GitHub repo **Settings → Social preview** (1280×640) |
| `../power-apps/theme/BrandTheme.OnStart.fx` | Power Apps theme: paste into `App.OnStart` |

## Colors

| Role | Hex |
|---|---|
| Primary (Old Glory Blue) | `#002868` |
| Primary dark | `#00205B` |
| Accent (red) | `#BF0D3E` |
| Background | `#F5F7FA` |
| Text | `#1D2124` |
| Secondary text | `#646464` |

Fonts: **Poppins** (headings), **Roboto** (body), with Segoe UI as the fallback.

## Use in a README

```html
<p align="center"><img src="brand/brand-icon-128.png" width="96" alt="logo"></p>
```

## Use in Power Apps

1. Paste `power-apps/theme/BrandTheme.OnStart.fx` into `App.OnStart`, then choose **Run OnStart**.
2. Reference colors as `BrandTheme.Primary`, `BrandTheme.Accent`, `BrandTheme.FontBody` and so on.
3. Upload `brand-icon-256.png` under **Settings → General → Icon**.

> Use `App.OnStart` (a global variable), not a `Theme` named formula. The named-formula
> version rendered blank in the published player.
