# ThriveHQ — Claude Code Guide

> Template: https://github.com/cathcoach4u/coach4u-shared/blob/main/templates/CLAUDE.md
> Shared design system: https://github.com/cathcoach4u/coach4u-shared
> Full setup guide: https://github.com/cathcoach4u/coach4u-shared/blob/main/SETUP.md
> **Design system version: 2.0**

## Pages in this repo

| Page | Auth required | Notes |
|---|---|---|
| `index.html` | No | Login page. Redirects active members to `dashboard.html`, inactive to `inactive.html` |
| `forgot-password.html` | No | Password reset request |
| `reset-password.html` | No | Password reset form |
| `inactive.html` | No | Shown to authenticated members with inactive/expired membership |
| `links.html` | No | Public Linktree-style links page (Teams, WhatsApp, coaching flow) |
| `weekly-coaching-flow.html` | No | Public weekly coaching flow page (Planning Tuesday, Focus Thursday) |
| `session-rhythm.html` | No | Public 2026 session rhythm calendar (session blocks and breaks) |
| `dashboard.html` | Yes | Main member dashboard with Brain Pulse results and quick links |
| `brain-pulse.html` | Yes | 4-pillar Brain Pulse assessment form |
| `brain-pulse-detail.html` | Yes | Per-pillar coaching focus detail |
| `resources.html` | Yes | Member resources from Supabase |
| `account.html` | Yes | Member profile and membership details |

## Shared Stylesheet

Copy `css/style.css` from `coach4u-shared` into this repo. Each app owns its own local copy.

Link in every HTML page `<head>`:

```html
<link rel="stylesheet" href="css/style.css">
```

Do NOT add Google Fonts link tags. The stylesheet uses the Aptos system font stack — no external fonts needed.

## Brand Lock (v2.0)

| Token | Value | Usage |
|---|---|---|
| `--primary` | `#003366` | Navy — header bg, headings, titles |
| `--accent` | `#0D9488` | Teal — card borders, buttons, links, section heading underlines |
| `--bg` | `#ffffff` | White page background |
| `--text` | `#333333` | Body text |
| `--text-muted` | `#888888` | Secondary / muted text |
| Font | Aptos system stack | No Google Fonts. Stack: `'Aptos', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif` |

**Do NOT introduce:** black, additional blues, alternate teals, extra greys, or Google Fonts.

### Card rule
All cards use `border: 2px solid var(--accent)` (teal) with teal box-shadow and hover lift (`transform: translateY(-2px)`). Use `.card-neutral` only for structural/admin panels where the teal border is too strong.

### Section headings
13px uppercase, `letter-spacing: 0.8px`, `border-bottom: 2px solid var(--accent)`. Use `.section-title` on h3 elements or `.section-heading` as a div.

### Gradient panels
`linear-gradient(135deg, #003366 0%, #0D9488 100%)` — used for membership card, about-panel, login page background.

## Footer

Every page (public and authenticated) includes the Coach4U footer:

```html
<footer style="text-align:center; font-size:14px; color:#999; padding:24px 0;">
  Strengths-Based Coaching and Counselling | <a href="https://coach4u.com.au" style="color:#999;">coach4u.com.au</a>
</footer>
```

On auth/login pages the footer is `position:fixed; bottom:0; width:100%` so it sits below the centred card without pushing layout.

## Supabase Project

| | |
|---|---|
| URL | `https://eekefsuaefgpqmjdyniy.supabase.co` |
| Anon Key | `sb_publishable_pcXHwQVMpvEojb4K3afEMw_RMvgZM-Y` |

## Critical Rules

**Supabase init — always inline.** GitHub Pages does not reliably load external `.js` modules. Always initialise Supabase inline in a `<script>` block. Never import from an external config file.

**Reset password redirect.** Use `window.location.href` (not `window.location.origin`) when building the `redirectTo` URL.

**Membership gating.** Every authenticated page must verify `users.membership_status = 'active'` after confirming a session. Redirect to `inactive.html` if not active. This includes the login page — after a successful sign-in, check membership and redirect to `inactive.html` if inactive rather than showing an inline error.

**Do NOT set `flex-direction: column` on `body`.** Auth pages use their own centred layout. Adding it globally breaks the login page.

**theme-color meta** on every page: `<meta name="theme-color" content="#003366">`

**Header version** on authenticated pages: `v2.0 — [date]` shown in `.header-version` span (hidden on screens ≤640px).

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
- "Sign In to Members Portal" button linking to `index.html`
- Coaching flow and session rhythm link to local pages (`weekly-coaching-flow.html`, `session-rhythm.html`)
- To update links, edit `links.html` directly — no Supabase involved

## weekly-coaching-flow.html and session-rhythm.html

Public pages (no authentication). Linked from `links.html`.
- Same brand: navy-to-teal gradient hero, white body, teal-bordered cards
- "Back to Links" button returns to `links.html`
- No Supabase — static content only
- To update content, edit the HTML directly

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

- Background: navy → teal gradient
- Card: white, centred, max 380px
- Button: full-width, navy (`var(--primary)`)
- Forgot password link: teal (`var(--accent)`), below the button
- Same layout applies to `forgot-password.html` and `reset-password.html`

## Sign Out — Standard Placement

Sign Out is **always top-right of the header** on every authenticated page. Never stacks below the title on mobile.

```html
<header class="site-header">
  <div class="header-inner">
    <div class="header-left">
      <a href="dashboard.html" class="header-back">← Back</a> <!-- omit on dashboard -->
      <span class="header-title">[Page Name]</span>
      <span class="header-version" id="headerVersion"></span>
    </div>
    <button class="sign-out-btn" onclick="signOut()">Sign Out</button>
  </div>
</header>
```

```js
async function signOut() {
  await supabase.auth.signOut();
  window.location.href = 'index.html';
}

// Set version in header
document.getElementById('headerVersion').textContent =
  'v2.0 — ' + new Date().toLocaleDateString('en-AU', { day: 'numeric', month: 'long', year: 'numeric' });
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
