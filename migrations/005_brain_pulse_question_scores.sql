-- Run in: Development Supabase (https://eekefsuaefgpqmjdyniy.supabase.co)
-- Purpose: Add individual question scores to brain_pulse_results
--          so ThriveHQ can display the full two-page report

ALTER TABLE brain_pulse_results
  ADD COLUMN IF NOT EXISTS capacity_1          SMALLINT,
  ADD COLUMN IF NOT EXISTS capacity_2          SMALLINT,
  ADD COLUMN IF NOT EXISTS capacity_3          SMALLINT,
  ADD COLUMN IF NOT EXISTS capacity_4          SMALLINT,
  ADD COLUMN IF NOT EXISTS capacity_5          SMALLINT,
  ADD COLUMN IF NOT EXISTS wellbeing_purpose   SMALLINT,
  ADD COLUMN IF NOT EXISTS wellbeing_social    SMALLINT,
  ADD COLUMN IF NOT EXISTS wellbeing_financial SMALLINT,
  ADD COLUMN IF NOT EXISTS wellbeing_physical  SMALLINT,
  ADD COLUMN IF NOT EXISTS wellbeing_community SMALLINT,
  ADD COLUMN IF NOT EXISTS strengths_1         SMALLINT,
  ADD COLUMN IF NOT EXISTS strengths_2         SMALLINT,
  ADD COLUMN IF NOT EXISTS strengths_3         SMALLINT,
  ADD COLUMN IF NOT EXISTS strengths_4         SMALLINT,
  ADD COLUMN IF NOT EXISTS strengths_5         SMALLINT,
  ADD COLUMN IF NOT EXISTS ef_initiation       SMALLINT,
  ADD COLUMN IF NOT EXISTS ef_sustained        SMALLINT,
  ADD COLUMN IF NOT EXISTS ef_inhibition       SMALLINT,
  ADD COLUMN IF NOT EXISTS ef_planning         SMALLINT,
  ADD COLUMN IF NOT EXISTS ef_memory           SMALLINT;
