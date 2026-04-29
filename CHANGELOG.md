# Changelog — ThriveHQ

## [Unreleased]

### Changed
- Design system updated from v1.1 to v1.3
- Primary brand colour updated from `#003366` to `#1B3664`
- Accent colour updated from `#0D9488` (teal) to `#5684C4` (mid-blue)
- Body text colour updated from `#212529` to `#2D2D2D`
- Border colour updated from `#DEE2E6` to `#DDDDDD`
- Google Fonts (Inter Bold, Montserrat Regular) added to all pages
- CSS font tokens updated to `--font: Inter` and `--font-heading: Montserrat`
- Header CSS selectors corrected to match HTML (`.header-left`, `.header-title`, `.header-back`)
- Login button hover colour updated to dark tint of new primary

### Removed
- Dead external JS files `js/auth.js` and `js/supabase.js` (Supabase is initialised inline on every page per CLAUDE.md)

### Fixed
- Exclamation marks removed from user-facing copy
- Service worker no longer attempts to cache non-existent `/js/app.js`
- Favicon and manifest `theme_color` updated to `#1B3664`
