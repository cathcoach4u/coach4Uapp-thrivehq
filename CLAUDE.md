# ThriveHQ — Claude Code Guide

## Shared Design System

All Coach4U apps share a common stylesheet and conventions hosted at:

- **Repo:** https://github.com/cathcoach4u/coach4u-shared
- **Stylesheet:** https://cathcoach4u.github.io/coach4u-shared/css/style.css
- **Full setup guide:** https://github.com/cathcoach4u/coach4u-shared/blob/main/SETUP.md

Link the stylesheet in every HTML page `<head>`:

```html
<link rel="stylesheet" href="https://cathcoach4u.github.io/coach4u-shared/css/style.css">
```

## Critical Rules

### Supabase init — always inline
GitHub Pages does not reliably load external `.js` modules. Always initialise Supabase **inline** in a `<script type="module">` block inside each HTML page. Never import from an external config file for auth or data operations.

```html
<script type="module">
  import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm';
  const supabase = createClient(
    'https://eekefsuaefgpqmjdyniy.supabase.co',
    'sb_publishable_pcXHwQVMpvEojb4K3afEMw_RMvgZM-Y'
  );
</script>
```

### Reset password redirect URL
Use `window.location.href` (not `window.location.origin`) when building the `redirectTo` URL for `resetPasswordForEmail`. Using `origin` alone drops the path and breaks Supabase's allowed-redirect matching.

### Membership gating
Every page (except login/forgot/reset) must check `users.membership_status = 'active'` after confirming a session exists. Redirect to `inactive.html` if the check fails.

## Supabase Project

| | |
|---|---|
| URL | `https://eekefsuaefgpqmjdyniy.supabase.co` |
| Anon Key | `sb_publishable_pcXHwQVMpvEojb4K3afEMw_RMvgZM-Y` |

## Auth Flow

- Login: email + password only (no magic link)
- Forgot password → `forgot-password.html`
- Reset password → `reset-password.html`

## Add a New Member (SQL)

```sql
INSERT INTO users (id, email, membership_status)
SELECT id, email, 'active'
FROM auth.users
WHERE LOWER(email) = LOWER('email@here.com');
```
