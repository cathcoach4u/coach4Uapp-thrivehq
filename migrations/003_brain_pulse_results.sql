-- Run in: Development Supabase (https://eekefsuaefgpqmjdyniy.supabase.co)
-- Purpose: Store brain pulse results synced from Internal Hub by admin
--
-- Data flow:
--   Internal Hub brain_pulse_submissions (contact_id)
--   → Admin Dashboard sync button (uses hub_profile_id to resolve user_id)
--   → brain_pulse_results (user_id)
--   → ThriveHQ brain-pulse.html (reads own rows via RLS)

CREATE TABLE IF NOT EXISTS brain_pulse_results (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id        UUID        NOT NULL,                    -- dev DB users.id (ThriveHQ auth user)
  contact_id     UUID        NOT NULL,                    -- Internal Hub contacts.id (reference)
  submission_id  UUID        NOT NULL UNIQUE,             -- Internal Hub brain_pulse_submissions.id
  capacity_total SMALLINT    NOT NULL,                    -- 5–50
  wellbeing_total SMALLINT   NOT NULL,                    -- 5–50
  strengths_total SMALLINT   NOT NULL,                    -- 5–50
  ef_total       SMALLINT    NOT NULL,                    -- 5–50 (execution function)
  grand_total    SMALLINT    NOT NULL,                    -- 20–200
  stage          TEXT        NOT NULL,                    -- Overwhelmed/Consolidating/Building/Grounded/Anchored
  lowest_room    TEXT,                                    -- capacity/wellbeing/strengths/ef
  submitted_at   TIMESTAMPTZ NOT NULL,                    -- original created_at from Internal Hub
  synced_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE brain_pulse_results ENABLE ROW LEVEL SECURITY;

-- ThriveHQ members can only read their own results
CREATE POLICY "Users read own brain pulse results"
  ON brain_pulse_results FOR SELECT
  USING (auth.uid() = user_id);

-- Admin (authenticated) can insert and upsert results
CREATE POLICY "Authenticated users can insert brain pulse results"
  ON brain_pulse_results FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can update brain pulse results"
  ON brain_pulse_results FOR UPDATE
  USING (auth.role() = 'authenticated');

-- Index for fast per-user queries (ThriveHQ reads)
CREATE INDEX IF NOT EXISTS idx_brain_pulse_results_user_id
  ON brain_pulse_results (user_id, submitted_at DESC);
