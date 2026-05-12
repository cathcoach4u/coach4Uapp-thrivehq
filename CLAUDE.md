# ThriveHQ — Claude Code Guide

> Template: https://github.com/cathcoach4u/coach4u-shared/blob/main/templates/CLAUDE.md
> Shared design system: https://github.com/cathcoach4u/coach4u-shared
> Full setup guide: https://github.com/cathcoach4u/coach4u-shared/blob/main/SETUP.md
> **Design system version: 2.3**

---

## Two Core Programmes

ThriveHQ serves two completely separate programmes. Keep pages, terminology, data, and links clearly separated between them.

### 1. Weekly Coaching Programme (Cath-led)

- **What:** Structured weekly group coaching sessions run by Cath.
- **Current session:** Planning Tuesdays, 6:00 PM AEST.
- **Schedule:** Tied to the school term calendar — sessions follow blocks and breaks across the year.
- **Join link:** Single shared Teams meeting link (in `links.html`).
- **Pages:**
  - `live-sessions.html` — shows the coaching session day and time
  - `session-rhythm.html` — 2026 term calendar showing session blocks and school holiday breaks
  - `weekly-coaching-flow.html` — format and flow of the weekly sessions
- **Data:** All static — no Supabase.

### 2. FocusHQ (Community Body Doubling)

- **What:** Peer-hosted body doubling sessions where community members show up and work alongside each other. No facilitation required.
- **Schedule:** Set by volunteer hosts. NOT tied to the school term calendar.
- **Branding:** Called **FocusHQ** (tagline: "Get things done, together.") — not "Body Doubling Sessions".
- **How to join:** Members go to the ThriveHQ WhatsApp community on the day (`https://chat.whatsapp.com/LemI9eH1yjmI3iIYOZvADV`) — the host posts a video link there. There are NO individual per-session join links.
- **Pages:**
  - `body-doubling.html` — shows session schedule (host + time) from Supabase; WhatsApp callout for joining; CTA to become a host
  - `hosting.html` — FocusHQ-branded page: become-a-host benefits and role steps. Static. Back link → `body-doubling.html`
- **Data:** `body_doubling_sessions` table in Supabase.
- **Current hosts:** Cath (Thursday 12–1pm AEST), Malcolm (Monday 11am–12pm AEST), Sonia (Friday 12–1pm AEST).

> **Critical distinction:** `session-rhythm.html` belongs to the Weekly Coaching Programme ONLY.
> Do NOT link it from `hosting.html`, `body-doubling.html`, or any FocusHQ page.

---

## Pages in this repo

| Page | Programme | Auth required | Notes |
|---|---|---|---|
| `login.html` | — | No | Login page. Redirects active members to `dashboard.html`, inactive to `inactive.html` |
| `forgot-password.html` | — | No | Password reset request |
| `reset-password.html` | — | No | Password reset form |
| `inactive.html` | — | No | Shown to authenticated members with inactive/expired membership |
| `links.html` | — | No | Public Linktree-style links page. No back link (root page). |
| `weekly-coaching-flow.html` | Coaching | No | Public weekly coaching flow. Back link → `links.html`. |
| `session-rhythm.html` | **Coaching only** | No | Public 2026 term calendar. Back link → `links.html`. NOT for FocusHQ. |
| `live-sessions.html` | Coaching | No | Public live coaching session time. Back link → `links.html`. |
| `body-doubling.html` | **FocusHQ** | No | FocusHQ schedule from Supabase. No per-session links. Back link → `links.html`. |
| `hosting.html` | **FocusHQ** | No | FocusHQ become-a-host page. Static. Back link → `body-doubling.html`. |
| `dashboard.html` | — | Yes | Main member dashboard with Brain Pulse results and quick links |
| `brain-pulse.html` | — | Yes | 4-pillar Brain Pulse assessment form |
| `brain-pulse-detail.html` | — | Yes | Per-pillar coaching focus detail |
| `resources.html` | — | Yes | Member resources from Supabase |
| `account.html` | — | Yes | Member profile and membership details |
| `best-of-us.html` | — | Yes | Activity — Best of Us values worksheet. Uses `css/activity.css` |

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
| Auth chrome | Yes | Yes or No | No |
| Used for | Authenticated dashboard and feature pages | Pages where user produces a personal output | Public read-only informational pages |

---

## Dashboard Stylesheet

Link in every dashboard/auth HTML page `<head>`:

```html
<link rel="stylesheet" href="css/style.css">
```

Do NOT add Google Fonts to dashboard pages. The stylesheet uses the Aptos system font stack.

## Brand Lock — Dashboard (v2.2)

| Token | Value | Usage |
|---|---|---|
| `--primary` | `#003366` | Navy — header bg, headings, titles |
| `--accent` | `#0D9488` | Teal — card borders, buttons, links |
| `--bg` | `#ffffff` | White page background |
| `--text` | `#333333` | Body text |
| `--text-muted` | `#888888` | Secondary / muted text |
| Font | Aptos system stack | No Google Fonts |

### Gradient panels
`linear-gradient(135deg, #003366 0%, #0D9488 100%)` — used for membership card, login page background, public page heroes.

---

## Login Page Standard (Gold Standard v2.2)

All auth pages use `<body class="login-page">` with `css/style.css`. No inline `<style>` blocks, no Google Fonts.

Required `<head>` structure:
```html
<link rel="manifest" href="manifest.json">
<meta name="theme-color" content="#003366">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="apple-mobile-web-app-title" content="Your Thrive HQ">
<link rel="stylesheet" href="css/style.css">
```

Post-login redirect: `dashboard.html`

Service worker on login page:
```html
<script>
  if ('serviceWorker' in navigator) navigator.serviceWorker.register('sw.js').catch(() => {});
</script>
```

---

## Activity Stylesheet

Link in every activity page `<head>`, alongside the Google Fonts import:

```html
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Montserrat:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/activity.css">
```

Add `class="activity-page"` to `<body>`.

## Brand Lock — Activity

| Token | Value | Usage |
|---|---|---|
| `--act-dark-blue` | `#1B3664` | Headings, selected tiles, primary button |
| `--act-light-blue` | `#5684C4` | Accent, step labels, progress done |
| `--act-dark-grey` | `#2D2D2D` | Body text |
| `--act-light-grey` | `#DDDDDD` | Borders, inactive progress |
| `--act-bg` | `#ffffff` | White page background |
| Font body | Montserrat | Tiles, body text |
| Font heading | Inter | Titles, labels, buttons |

**Never use teal (`#0D9488`) on activity pages.**

---

## Info Stylesheet

Link in every info page `<head>`:

```html
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/info.css">
```

Add `class="info-page"` to `<body>`.

### Info CSS class reference (v2.3)

```
.info-brand-bar      — navy header bar; teal gradient top strip
.info-back-link      — back navigation link inside the header
.info-brand-name     — brand/app name, bold 22px white
.info-brand-sub      — page subtitle, 13px uppercase muted white
.info-content        — 560px centred content well
.info-note           — teal left-strip callout block
.info-footer         — centred muted footer, sticky to bottom
```

### Back link rule
Every info page except `links.html` must have an `.info-back-link` inside `.info-brand-bar` pointing to the actual previous page:
- Pages reached from `links.html` → `href="links.html"`
- `hosting.html` (reached from `body-doubling.html`) → `href="body-doubling.html"`

---

## Supabase Project

| | |
|---|---|
| URL | `https://eekefsuaefgpqmjdyniy.supabase.co` |
| Anon Key | `sb_publishable_pcXHwQVMpvEojb4K3afEMw_RMvgZM-Y` |

Import always **unversioned**:
```js
import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm';
```

### body_doubling_sessions table

Public read-only. Fetched via direct `fetch()` (not Supabase JS client):

```javascript
fetch(SUPABASE_URL + '/rest/v1/body_doubling_sessions?active=eq.true&select=host_name,day_of_week,day_order,start_time,end_time&order=day_order.asc',
  { headers: { 'apikey': ANON_KEY, 'Authorization': 'Bearer ' + ANON_KEY } })
```

Columns: `id`, `host_name`, `day_of_week`, `day_order` (1–7), `start_time`, `end_time`, `meeting_url`, `active`, `created_at`.

> `meeting_url` exists but is NOT fetched or displayed. Joining happens via WhatsApp community.

---

## Critical Rules

**Supabase init — always ESM, always inline.** Use `<script type="module">` with unversioned import inline in each page. Never use the UMD CDN bundle. Never load from an external config file.

**Public Supabase reads — use direct fetch().** For unauthenticated public pages, use `fetch()` directly to the REST API.

**Inline onclick handlers with module scripts.** Functions called from inline `onclick` must be on the global scope: `window.funcName = function() {...}`.

**Reset password redirect.** Use `window.location.href` (not `window.location.origin`).

**Membership gating.** Every authenticated page must verify `users.membership_status = 'active'`. Redirect to `inactive.html` if not active.

**theme-color meta** on every page: `<meta name="theme-color" content="#003366">`

**VERSION constant** on authenticated pages: `const VERSION = '2026-05-07.3';` — bump on each deploy.

## Auth Flow

- Login: `login.html` — email + password
- Forgot password → `forgot-password.html`
- Reset password → `reset-password.html`
- Inactive membership → `inactive.html`

## Sign Out — Standard Placement

Sign Out is always top-right of the header on every authenticated page.

```html
<header class="site-header">
  <div class="header-inner">
    <div class="header-left">
      <a href="https://cathcoach4u.github.io/yourcoachingportal/" class="header-back">← Portal</a>
      <span class="header-title">ThriveHQ</span>
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
- Pillar accent colours (app-specific): Capacity `#0D9488`, Wellbeing `#5DADE2`, Strengths `#B19CD9`, Execution `#7851A9`.
- Header includes `← Portal` back link to `https://cathcoach4u.github.io/yourcoachingportal/` using `.header-back` class.
