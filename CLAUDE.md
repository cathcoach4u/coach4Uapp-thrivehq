# ThriveHQ — Claude Code Guide

> Template: https://github.com/cathcoach4u/coach4u-shared/blob/main/templates/CLAUDE.md
> Shared design system: https://github.com/cathcoach4u/coach4u-shared
> Full setup guide: https://github.com/cathcoach4u/coach4u-shared/blob/main/SETUP.md
> **Design system version: 2.1**

## Pages in this repo

| Page | Auth required | Notes |
|---|---|---|
| `index.html` | No | Login page. Redirects active members to `dashboard.html`, inactive to `inactive.html` |
| `forgot-password.html` | No | Password reset request |
| `reset-password.html` | No | Password reset form |
| `inactive.html` | No | Shown to authenticated members with inactive/expired membership |
| `links.html` | No | Public Linktree-style links page (Teams, WhatsApp, coaching flow) |
| `weekly-coaching-flow.html` | No | Public weekly coaching flow (Planning Tuesday, Focus Thursday). Info design. |
| `session-rhythm.html` | No | Public 2026 session rhythm calendar (session blocks and breaks). Info design. |
| `live-sessions.html` | No | Public live coaching session time (Planning Tuesdays 6 PM AEST). Dashboard design. |
| `body-doubling.html` | No | Public Body Doubling / Focus Thursdays (12–1 PM AEST). Dashboard design. |
| `hosting.html` | No | Public “Become a Body Doubling Host” page. Dashboard design. |
| `dashboard.html` | Yes | Main member dashboard with Brain Pulse results and quick links |
| `brain-pulse.html` | Yes | 4-pillar Brain Pulse assessment form |
| `brain-pulse-detail.html` | Yes | Per-pillar coaching focus detail |
| `resources.html` | Yes | Member resources from Supabase |
| `account.html` | Yes | Member profile and membership details |
| `best-of-us.html` | Yes | Activity — Best of Us values worksheet. Uses `css/activity.css` (`act-*` classes, Inter/Montserrat, `#1B3664`) |

---

## Three Design Systems

This repo uses three separate design systems. Use the right one — do not mix them.

| | Dashboard | Activity | Info |
|---|---|---|---|
| CSS file | `css/style.css` | `css/activity.css` | `css/style.css` + `css/info.css` |
| Font | Aptos system stack | Inter + Montserrat (Google Fonts) | Aptos system stack |
| Primary colour | `#003366` navy | `#1B3664` dark blue | `#003366` navy |
| Accent | `#0D9488` teal | `#5684C4` mid blue | `#0D9488` teal |
| Background | `#ffffff` white | `#ffffff` white | `#f0f2f5` grey |
| CSS prefix | none | `act-` | `info-` |
| Auth chrome | Yes (header + sign-out) | Yes (authenticated) or No (public) | No |
| Used for | Authenticated dashboard and feature pages | Pages where user produces a personal output | Public read-only informational pages |

**What is an activity?** A page where the user produces a personal output through interaction — selections, reflections, multi-step flows. Static or informational pages are NOT activities.

**What is an info page?** A public page that explains or displays programme information with no user inputs and no Supabase calls.

---

## Dashboard Stylesheet

Copy `css/style.css` from `coach4u-shared` into this repo. Each app owns its own local copy.

Link in every dashboard/auth HTML page `<head>`:

```html
<link rel="stylesheet" href="css/style.css">
```

Do NOT add Google Fonts link tags to dashboard pages. The stylesheet uses the Aptos system font stack.

## Brand Lock — Dashboard (v2.0)

| Token | Value | Usage |
|---|---|---|
| `--primary` | `#003366` | Navy — header bg, headings, titles |
| `--accent` | `#0D9488` | Teal — card borders, buttons, links, section heading underlines |
| `--bg` | `#ffffff` | White page background |
| `--text` | `#333333` | Body text |
| `--text-muted` | `#888888` | Secondary / muted text |
| Font | Aptos system stack | No Google Fonts. Stack: `'Aptos', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif` |

**Do NOT introduce:** black, additional blues, alternate teals, extra greys, or Google Fonts on dashboard pages.

### Card rule
All cards use `border: 2px solid var(--accent)` (teal) with teal box-shadow and hover lift (`transform: translateY(-2px)`). Use `.card-neutral` only for structural/admin panels where the teal border is too strong.

### Section headings
13px uppercase, `letter-spacing: 0.8px`, `border-bottom: 2px solid var(--accent)`. Use `.section-title` on h3 elements or `.section-heading` as a div.

### Gradient panels
`linear-gradient(135deg, #003366 0%, #0D9488 100%)` — used for membership card, about-panel, login page background, public page heroes.

---

## Activity Stylesheet

Copy `css/activity.css` from `coach4u-shared` into this repo. Each app owns its own local copy.

Link in every activity page `<head>`, alongside the Google Fonts import:

```html
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Montserrat:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/activity.css">
```

Add `class="activity-page"` to `<body>`.

For authenticated activity pages, also keep `site-header` from `style.css` for the Sign Out button — link both stylesheets.

## Brand Lock — Activity

| Token | Value | Usage |
|---|---|---|
| `--act-dark-blue` | `#1B3664` | Headings, selected tiles, primary button |
| `--act-light-blue` | `#5684C4` | Accent, step labels, progress done |
| `--act-dark-grey` | `#2D2D2D` | Body text |
| `--act-light-grey` | `#DDDDDD` | Borders, inactive progress |
| `--act-bg` | `#ffffff` | White page background |
| `--act-soft` | `#F5F7FB` | Tile resting background |
| Font body | Montserrat | Tiles, body text |
| Font heading | Inter | Titles, labels, buttons |

**Never use teal (`#0D9488`) on activity pages.** Teal belongs to the dashboard only.

### Activity CSS class reference
See `coach4u-shared/templates/CLAUDE.md` → “Activity / Tool Pattern” for the full `act-*` class reference.

### Activity pages in this repo

| Page | Pattern | Notes |
|---|---|---|
| `best-of-us.html` | Worksheet | All steps visible, sticky `.act-save-bar`. Authenticated — uses `site-header` + Sign Out. |

---

## Info Stylesheet

Copy `css/info.css` from `coach4u-shared` into this repo. Each app owns its own local copy.

Link in every info page `<head>`, alongside `style.css`:

```html
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/info.css">
```

Add `class="info-page"` to `<body>`. `info.css` handles the page chrome; `style.css` provides shared components (`.card`, `.btn`, `.section-title`).

### Info CSS class reference

```
.info-hero           — full-width navy-to-teal gradient banner
.info-hero-logo      — app name, bold 28px
.info-hero-title     — page title, 20px
.info-hero-desc      — subtitle (max 480px, 0.88 opacity)
.info-content        — 560px centred content well
.info-note           — teal left-strip callout block
.info-footer         — centred muted footer, sticky to bottom
```

### Info pages in this repo

| Page | Notes |
|---|---|
| `weekly-coaching-flow.html` | Session card details in inline `<style>`. Static, no Supabase. |
| `session-rhythm.html` | Rhythm row details in inline `<style>`. JS hides past date rows via `data-end` attributes. |

---

## Footer

Three footer patterns — use the right one per page type:

- **Info pages**: `<p class="info-footer">` inside `.info-content` (from `info.css`, sticky to bottom)
- **Login/auth pages**: `<footer class="site-footer">` (from `style.css`, sticky to bottom)
- **Authenticated pages**: no standalone footer — content ends at the last section

All footers use the same copy:
```
Strengths-Based Coaching and Counselling | <a href="https://coach4u.com.au">coach4u.com.au</a>
```

## Supabase Project

| | |
|---|---|
| URL | `https://eekefsuaefgpqmjdyniy.supabase.co` |
| Anon Key | `sb_publishable_pcXHwQVMpvEojb4K3afEMw_RMvgZM-Y` |

## Critical Rules

**Supabase init — always ESM, always inline.** Use `<script type="module">` with `import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2.105.1/+esm'` inline in each page. Never use the UMD CDN bundle (`supabase.min.js`). Never load Supabase from an external config file.

**Inline onclick handlers with module scripts.** Module scripts are scoped — functions defined inside them are not available to inline `onclick` attributes. Any function called from an inline `onclick` must be exposed on the global scope: `window.funcName = function() {...}`.

**Reset password redirect.** Use `window.location.href` (not `window.location.origin`) when building the `redirectTo` URL.

**Membership gating.** Every authenticated page must verify `users.membership_status = 'active'` after confirming a session. Redirect to `inactive.html` if not active.

**Do NOT set `flex-direction: column` on `body`.** Auth pages use their own centred layout. Adding it globally breaks the login page.

**theme-color meta** on every page: `<meta name="theme-color" content="#003366">`

**VERSION constant** on authenticated pages: `const VERSION = '2026-05-04.1';` — bump on each deploy. Display with `document.getElementById('headerVersion').textContent = 'v' + VERSION;`

## Auth Flow

- Login: email + password only (no magic link)
- Forgot password → `forgot-password.html`
- Reset password → `reset-password.html`
- Inactive membership → `inactive.html` (from login, and from any gated page)

## inactive.html

Shown when a member's `membership_status` is not `'active'`. The page:
- Uses the same `login-page` / `login-card` layout as auth pages
- Signs the user out and redirects to `index.html` when they click the button
- Has no membership check (to avoid redirect loops)
- Includes the Coach4U footer

## links.html

Public links page (no authentication). Used as a Linktree replacement.
- Navy-to-teal gradient hero
- Teal-bordered link cards with hover lift
- Sections: Connection Tools (Teams, WhatsApp), Weekly Flow & Calendar
- “Sign In to Members Portal” button linking to `index.html`
- Coaching flow and session rhythm link to local pages (`weekly-coaching-flow.html`, `session-rhythm.html`)
- To update links, edit `links.html` directly — no Supabase involved

## weekly-coaching-flow.html and session-rhythm.html

Public info pages (no authentication). Use the **info design system** (`css/style.css` + `css/info.css`).
- `body class="info-page"` — grey background from `info.css`
- `div.info-hero` — navy-to-teal gradient banner with logo, title, description
- `div.info-content` — 560px centred content well
- Cards use `.card` from `style.css`; section labels use `.section-title`
- Back link uses `.btn.btn-navy` from `style.css`
- Page-specific styles (rhythm rows, session card layout) in inline `<style>` block
- No Supabase — static content only
- `session-rhythm.html` uses `data-end` attributes + JS to auto-hide past session blocks

## Login Page Pattern

All auth pages use `<body class="login-page">` with the shared CSS classes:

```html
<body class="login-page">
  <div class="login-card">
    <div class="login-logo"><h1>[App Name]</h1></div>
    <p class="login-subtitle">Sign in to access your coaching resources.</p>
    <form id="signInForm">
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" required autocomplete="email">
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <div class="password-wrapper">
          <input type="password" id="password" required autocomplete="current-password">
          <button type="button" class="toggle-password" onclick="togglePassword()">Show</button>
        </div>
      </div>
      <div id="message" class="login-message"></div>
      <button type="submit" class="login-btn" id="submitBtn">Sign In</button>
    </form>
    <a href="forgot-password.html" class="login-forgot">Forgot password?</a>
  </div>
</body>
```

## Sign Out — Standard Placement

Sign Out is **always top-right of the header** on every authenticated page.

```html
<header class="site-header">
  <div class="header-inner">
    <div class="header-left">
      <a href="dashboard.html" class="header-back">← Back</a>
      <span class="header-title">[Page Name]</span>
      <span class="header-version" id="headerVersion"></span>
    </div>
    <button class="sign-out-btn" onclick="signOut()">Sign Out</button>
  </div>
</header>
```

## Add a New Member (SQL)

```sql
INSERT INTO users (id, email, membership_status)
SELECT id, email, 'active'
FROM auth.users
WHERE LOWER(email) = LOWER('email@here.com');
```

---
## App-Specific Notes

- ThriveHQ is the primary Coach4U app covering Brain Pulse, resources, and member account management.
- Brain Pulse: 4 pillars (Capacity, Wellbeing, Strengths, Execution), 5 questions each, scored 1–10. Max 200. Bands: Overwhelmed 20–60 | Unsteady 61–100 | Grounded 101–140 | Steady 141–170 | Anchored 171–200.
- Pillar accent colours are app-specific (not brand): Capacity `#0D9488`, Wellbeing `#5DADE2`, Strengths `#B19CD9`, Execution `#7851A9`.
