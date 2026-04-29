# Migrations

SQL migrations that have been run against the ThriveHQ Supabase project.

Add a new file per migration, named `YYYYMMDD_description.sql`.

## Supabase project

| | |
|---|---|
| URL | `https://eekefsuaefgpqmjdyniy.supabase.co` |

## Add a new member

```sql
INSERT INTO users (id, email, membership_status)
SELECT id, email, 'active'
FROM auth.users
WHERE LOWER(email) = LOWER('email@here.com');
```
