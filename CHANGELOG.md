# Changelog

All notable changes to PPMF are documented here.
This project follows [Semantic Versioning](https://semver.org/) for solution versions.

## [1.0.0.0] - 2026-11-24

### Added
- **Detect Broken Connections** flow: daily scan of enabled environments for broken
  connections, with exact flow-impact mapping (direct connections and connection
  references), likely app impact, per-owner emails with fix links, admin summary,
  and structured logging.
- **Inventory Flow** returns status to the app, creates new environments as Enabled,
  preserves existing Enabled choices, and logs failures.
- **PPMF | Configuration** table (admin emails, last inventory run).
- **PPMF - Configuration App**: alert recipients with validation, inventory with
  confirmation, per-environment monitoring switches, search.
- **BrandTheme** (Texas-flag colors) for Power Apps, and brand icons.

### Changed
- **PPMF | Environments → Enabled** now defaults to Yes.
- **PPMF | Logs** text columns sized to 500 characters; all flow log writes are truncated to fit.

### Known issues
- **Logger Flow** creates empty rows (inputs not mapped). Flows log directly instead.
- Roadmap monitors ship as placeholders.
