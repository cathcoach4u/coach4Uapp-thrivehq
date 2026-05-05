-- Migration 004: user_relationships
-- Mirrors Internal Hub clients + client_members structure
-- One row per coaching group a user belongs to

CREATE TABLE IF NOT EXISTS user_relationships (
  id                UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id           UUID        NOT NULL,
  hub_client_id     UUID        NOT NULL,
  relationship_name TEXT        NOT NULL,
  role              TEXT        NOT NULL,
  member_role       TEXT,
  status            TEXT,
  synced_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, hub_client_id)
);

ALTER TABLE user_relationships ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users read own relationships"
  ON user_relationships FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Admin insert relationships"
  ON user_relationships FOR INSERT WITH CHECK (true);

CREATE POLICY "Admin update relationships"
  ON user_relationships FOR UPDATE USING (true);
