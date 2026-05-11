-- Update FocusHQ host display names (remove surnames) and add Sonia as Friday host
-- Run in Supabase SQL Editor

UPDATE body_doubling_sessions SET host_name = 'Cath'    WHERE host_name = 'Cath Baker';
UPDATE body_doubling_sessions SET host_name = 'Malcolm' WHERE host_name = 'Malcolm Joosse';

INSERT INTO body_doubling_sessions (host_name, day_of_week, day_order, start_time, end_time, meeting_url, active)
VALUES (
  'Sonia',
  'Friday',
  5,
  '12:00 PM',
  '1:00 PM',
  '',
  true
);
