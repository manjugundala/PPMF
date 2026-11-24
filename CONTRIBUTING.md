# Contributing to PPMF

Thanks for helping improve PPMF.

## Report a problem or idea
Open an [issue](https://github.com/manjugundala/PPMF/issues) with:
- what you expected and what happened,
- the relevant **PPMF | Logs** rows (remove names and email addresses), and
- your solution version.

## Change the solution
1. Import `solution/PPMF_<version>.zip` (unmanaged) into a **development** environment.
2. Make your changes inside the **Power Platform Monitoring Framework** solution.
3. Follow the existing patterns:
   - Try/Catch scopes with logging to **PPMF | Logs**; truncate log values to 500 characters.
   - Read settings from **PPMF | Configuration**; respect **Environments → Enabled**.
   - Use `BrandTheme` colors in apps.
4. Increase the solution version, export **unmanaged and managed**, and unpack the
   unmanaged zip into `src/` (`pac solution unpack --zipfile ... --folder src --packagetype Unmanaged`).
5. Update `CHANGELOG.md` and the docs, then open a pull request.

## Code of conduct
Be respectful and constructive.
