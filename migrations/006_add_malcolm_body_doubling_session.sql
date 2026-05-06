-- Add Malcolm Joosse as Monday FocusHQ body doubling host
-- Run in Supabase SQL Editor
-- Update meeting_url to Malcolm's actual Teams/Zoom link before running

INSERT INTO body_doubling_sessions (host_name, day_of_week, day_order, start_time, end_time, meeting_url, active)
VALUES (
  'Malcolm Joosse',
  'Monday',
  1,
  '11:00 AM',
  '12:00 PM',
  'https://teams.microsoft.com/meet/46980694079511?p=gKZWzjMnOZ0by7IZxu',
  true
);
