// BrandTheme - Texas flag colors (Infint brand). Global theme for the app.
// Set in App.OnStart so it is available in Studio and the published player.
Set(
    BrandTheme,
    {
        // Brand
        Primary: RGBA(0, 40, 104, 1),          // #002868
        PrimaryDark: RGBA(0, 32, 91, 1),       // #00205B
        PrimaryHover: RGBA(0, 26, 77, 1),      // #001A4D
        PrimaryLight: RGBA(230, 234, 242, 1),  // #E6EAF2
        Accent: RGBA(191, 13, 62, 1),          // #BF0D3E
        AccentDark: RGBA(154, 10, 50, 1),      // #9A0A32
        AccentLight: RGBA(251, 231, 236, 1),   // #FBE7EC
        White: RGBA(255, 255, 255, 1),         // #FFFFFF
    
        // Surfaces
        Background: RGBA(245, 247, 250, 1),    // #F5F7FA
        Surface: RGBA(255, 255, 255, 1),       // #FFFFFF
        SurfaceAlt: RGBA(248, 251, 255, 1),    // #F8FBFF
        Border: RGBA(221, 221, 221, 1),        // #DDDDDD
        Divider: RGBA(236, 238, 242, 1),       // #ECEEF2
    
        // Text
        Text: RGBA(29, 33, 36, 1),             // #1D2124
        TextSecondary: RGBA(100, 100, 100, 1), // #646464
        TextOnPrimary: RGBA(255, 255, 255, 1), // #FFFFFF
        TextDisabled: RGBA(161, 159, 157, 1),  // #A19F9D
    
        // States
        Success: RGBA(16, 124, 16, 1),         // #107C10
        SuccessLight: RGBA(223, 246, 221, 1),  // #DFF6DD
        Warning: RGBA(138, 90, 0, 1),          // #8A5A00
        WarningLight: RGBA(255, 244, 206, 1),  // #FFF4CE
        Error: RGBA(191, 13, 62, 1),           // #BF0D3E
        ErrorLight: RGBA(251, 231, 236, 1),    // #FBE7EC
        Disabled: RGBA(237, 235, 233, 1),      // #EDEBE9
        Overlay: RGBA(0, 32, 91, 0.45),
    
        // Typography
        FontBody: "Roboto, 'Segoe UI', sans-serif",
        FontHeading: "Poppins, 'Segoe UI', sans-serif",
        SizeTitle: 20,
        SizeHeading: 15,
        SizeBody: 11,
        SizeCaption: 10,
    
        // Shape
        Radius: 4
    }
)