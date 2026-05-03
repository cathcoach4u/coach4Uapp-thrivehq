-- Migration: Create brain_pulse_assessments table
-- Run this in the Supabase SQL Editor if the table does not already exist.
-- All INSERT/SELECT operations are scoped to the authenticated user via RLS.

CREATE TABLE IF NOT EXISTS brain_pulse_assessments (
  id               UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id          UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  assessment_date  DATE        NOT NULL DEFAULT CURRENT_DATE,
  capacity_score   SMALLINT    NOT NULL DEFAULT 0 CHECK (capacity_score  BETWEEN 0 AND 50),
  wellbeing_score  SMALLINT    NOT NULL DEFAULT 0 CHECK (wellbeing_score BETWEEN 0 AND 50),
  strengths_score  SMALLINT    NOT NULL DEFAULT 0 CHECK (strengths_score BETWEEN 0 AND 50),
  execution_score  SMALLINT    NOT NULL DEFAULT 0 CHECK (execution_score BETWEEN 0 AND 50),
  created_at       TIMESTAMPTZ DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE brain_pulse_assessments ENABLE ROW LEVEL SECURITY;

-- Users can only read their own assessments
CREATE POLICY IF NOT EXISTS "users_select_own_assessments"
  ON brain_pulse_assessments FOR SELECT
  USING (auth.uid() = user_id);

-- Users can only insert their own assessments
CREATE POLICY IF NOT EXISTS "users_insert_own_assessments"
  ON brain_pulse_assessments FOR INSERT
  WITH CHECK (auth.uid() = user_id);
