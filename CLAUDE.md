# ThriveHQ — Claude Code Guide

> Template: https://github.com/cathcoach4u/coach4u-shared/blob/main/templates/CLAUDE.md
> Shared design system: https://github.com/cathcoach4u/coach4u-shared
> Full setup guide: https://github.com/cathcoach4u/coach4u-shared/blob/main/SETUP.md
> **Design system version: 2.0**

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

## Supabase Project

| | |
|---|---|
| URL | `https://eekefsuaefgpqmjdyniy.supabase.co` |
| Anon Key | `sb_publishable_pcXHwQVMpvEojb4K3afEMw_RMvgZM-Y` |

## Critical Rules

**Supabase init — always inline.** GitHub Pages does not reliably load external `.js` modules. Always initialise Supabase inline in a `<script>` block. Never import from an external config file.

**Reset password redirect.** Use `window.location.href` (not `window.location.origin`) when building the `redirectTo` URL.

**Membership gating.** Every page except login/forgot/reset must verify `users.membership_status = 'active'` after confirming a session. Redirect to `inactive.html` if not.

**Do NOT set `flex-direction: column` on `body`.** Auth pages use their own centred layout. Adding it globally breaks the login page.

**theme-color meta** on every page: `<meta name="theme-color" content="#003366">`

## Auth Flow

- Login: email + password only (no magic link)
- Forgot password → `forgot-password.html`
- Reset password → `reset-password.html`

## Login Page Pattern

All auth pages use `<body class="login-page">` with the shared CSS classes:

```html
<body class="login-page">
  <div class="login-card">
    <div class="login-logo"><h1>[App Name]</h1></div>
    <p class="login-title">Welcome back</p>
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

Sign Out is **always top-right of the header** on every app page (except auth pages).

```html
<header class="site-header">
  <div class="header-inner">
    <div class="header-left">
      <a href="dashboard.html" class="header-back">← Back</a> <!-- omit on dashboard -->
      <span class="header-title">[Page Name]</span>
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
