# ThriveHQ — Claude Session Briefing

## What This App Is
ThriveHQ is a membership-gated PWA for ADHD coaching clients. Built with vanilla HTML/CSS/JS, hosted on GitHub Pages, backed by Supabase.

**Live URL:** https://cathcoach4u.github.io/coach4Uapp-thrivehq/
**Repo:** cathcoach4u/coach4Uapp-thrivehq

---

## Supabase
- **URL:** `https://eekefsuaefgpqmjdyniy.supabase.co`
- **Anon Key:** `sb_publishable_pcXHwQVMpvEojb4K3afEMw_RMvgZM-Y`
- **Auth method:** Email + password (NOT magic link)

### Key Tables
- `users` — membership data. Must have a row with `membership_status = 'active'` for access
- `brain_pulse_assessments` — scores for capacity/wellbeing/strengths/execution
- `resources` — resource links shown on resources page

### Add a new member
```sql
INSERT INTO users (id, email, membership_status)
SELECT id, email, 'active'
FROM auth.users
WHERE LOWER(email) = LOWER('member@email.com');
```

### Reactivate expired member
```sql
UPDATE users SET membership_status = 'active'
WHERE LOWER(email) = LOWER('member@email.com');
```

---

## Tech Stack
- Pure HTML, CSS, JavaScript — no frameworks
- Supabase JS v2 loaded via CDN on each page
- GitHub Pages for hosting
- PWA (manifest.json + sw.js)

---

## Critical Rules — Read Before Editing

1. **Always inline Supabase init in each HTML page** — do NOT use external `js/supabase.js`. GitHub Pages does not load external JS files reliably. Every page must have this directly:
```html
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/dist/umd/supabase.min.js"></script>
<script>
  const SUPABASE_URL = 'https://eekefsuaefgpqmjdyniy.supabase.co';
  const SUPABASE_ANON_KEY = 'sb_publishable_pcXHwQVMpvEojb4K3afEMw_RMvgZM-Y';
  const sb = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
</script>
```

2. **Redirect URLs must use `window.location.href`** — not `window.location.origin`. GitHub Pages serves from a subdirectory so `origin` alone causes 404s:
```js
const basePath = window.location.href.replace('forgot-password.html', '');
const resetRedirect = basePath + 'reset-password.html';
```

3. **Always set `style.display` explicitly in JS** — never rely on CSS class toggling alone to show/hide messages. Always do:
```js
msg.style.display = 'block'; // to show
msg.style.display = 'none';  // to hide
```

4. **Every protected page must check membership** before showing content:
```js
const { data: { user } } = await sb.auth.getUser();
if (!user) { window.location.href = 'index.html'; return; }
const { data: ud } = await sb.from('users').select('membership_status').eq('id', user.id).single();
if (ud?.membership_status !== 'active') { /* show expired message */ return; }
```

---

## File Structure
```
index.html              — Login (email + password)
forgot-password.html   — Request reset link
reset-password.html    — Set new password from email link
dashboard.html         — Main dashboard (membership-gated)
brain-pulse-detail.html — Assessment detail view
resources.html         — Resources hub
account.html           — Profile & membership info
css/style.css          — All styles (Coach4U teal theme)
manifest.json          — PWA manifest
sw.js                  — Service worker
```

---

## Colour Theme
```css
--primary:   #003366   /* Navy */
--accent:    #0D9488   /* Teal */
--capacity:  #0D9488
--wellbeing: #5DADE2
--strengths: #B19CD9
--execution: #7851A9
```
Login page background: `linear-gradient(135deg, #003366 0%, #0D9488 100%)`

---

## PWA Status
- `manifest.json` and `sw.js` are in place
- App is installable
- ⚠️ Offline caching not fully working on GitHub Pages subdirectory — paths in sw.js are root-relative but GitHub Pages serves from `/coach4Uapp-thrivehq/`. Will be fixed when a custom domain is connected.

---

## Membership Philosophy
All Coach4U external apps gate access by membership status. Users cannot self-serve — admin team manages membership via Supabase SQL. Expired members see: `"Your membership has expired. Contact support@coach4u.com.au to renew."`

---

## Start of Session Checklist
- [ ] Check recent commits: review what was last changed
- [ ] Confirm which page/feature we are working on
- [ ] Check that Supabase credentials above are still current
- [ ] Ask: "What are we working on today?" if not already clear

## End of Session Checklist
- [ ] All changes pushed to main (via PR, squash merge)
- [ ] No open branches or PRs left behind
- [ ] If new pages added — check they have Supabase inlined and membership check
- [ ] If SQL changes needed — provide the SQL to the user
- [ ] Update this CLAUDE.md if new decisions, rules, or features were added
- [ ] Confirm live URL still works: https://cathcoach4u.github.io/coach4Uapp-thrivehq/
