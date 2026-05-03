-- Migration: Create best_of_us_responses table
-- Run this in the Supabase SQL Editor before deploying best-of-us.html.
-- One row per user (upserted on user_id). RLS scoped to the authenticated user.

CREATE TABLE IF NOT EXISTS best_of_us_responses (
  id                UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id           UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE,
  thrive_response   TEXT,
  holdback_response TEXT,
  reliance_response TEXT,
  needs_response    TEXT,
  updated_at        TIMESTAMPTZ DEFAULT now(),
  created_at        TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE best_of_us_responses ENABLE ROW LEVEL SECURITY;

CREATE POLICY IF NOT EXISTS "users_select_own_best_of_us"
  ON best_of_us_responses FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY IF NOT EXISTS "users_insert_own_best_of_us"
  ON best_of_us_responses FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY IF NOT EXISTS "users_update_own_best_of_us"
  ON best_of_us_responses FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
