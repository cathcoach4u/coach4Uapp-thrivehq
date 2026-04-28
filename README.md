# ThriveHQ — ADHD-Friendly Coaching App

A Progressive Web App (PWA) for ThriveHQ external clients. Features Brain Pulse assessments, resources, and ADHD-friendly coaching support.

## Setup

### 1. Create Supabase Database
Run the SQL schema in your Supabase dashboard:
```bash
# See sql/schema.sql for full schema
```

### 2. Update Supabase Credentials
Edit `js/supabase.js` with your Supabase project details:
```javascript
const SUPABASE_URL = 'your-project.supabase.co';
const SUPABASE_ANON_KEY = 'your-anon-key';
```

### 3. Deploy
Push to GitHub and enable GitHub Pages hosting.

## Features (Phase 1)

- ✅ Magic link authentication
- ✅ Brain Pulse dashboard (Capacity, Wellbeing, Strengths, Execution)
- ✅ Assessment detail pages with coaching focus
- ✅ Resources hub
- ✅ Account/profile page
- ✅ PWA-installable (mobile + desktop)
- ✅ Offline support via service worker
- ✅ Teal color theme

## Technology Stack

- **Frontend:** HTML, CSS, JavaScript (vanilla)
- **Backend:** Supabase (PostgreSQL + Auth)
- **Hosting:** GitHub Pages
- **PWA:** Service Worker + Manifest
