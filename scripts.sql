
CREATE TABLE IF NOT EXISTS task_groups (
  id UUID PRIMARY KEY,
  name TEXT NOT NULL,
  color BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS tasks (
  id UUID PRIMARY KEY,
  title TEXT NOT NULL,
  subtitle TEXT,
  date TIMESTAMP NOT NULL,
  is_completed BOOLEAN NOT NULL,
  task_group_id UUID,
  CONSTRAINT fk_task_group
    FOREIGN KEY (task_group_id)
    REFERENCES task_groups(id)
    ON DELETE CASCADE
);


INSERT INTO task_groups (id, name, color) VALUES
  ('1f1a7311-36f8-4fd3-bc4c-3fa3e25e8ef2', 'Work', 4280391411),  
  ('1a5b6c7d-2e3f-4a5b-8c7d-8f9e0a1b2c3d', 'Personal', 4282339765), 
  ('5d2e4c6f-7e5d-3a4b-1c2d-0a9b8f7e6c5d', 'Shopping', 4294198070);



INSERT INTO tasks (id, title, subtitle, date, is_completed, task_group_id) VALUES
  ('ffbb1234-5678-9abc-def0-123456789abc', 'Project A', 'Complete initial draft', '2024-09-28 00:00:00', false, '1f1a7311-36f8-4fd3-bc4c-3fa3e25e8ef2'), -- Associado ao grupo Work
  ('abcd1234-5678-9abc-def0-0987654321ff', 'Grocery shopping', 'Buy fruits and vegetables', '2024-09-29 00:00:00', false, '5d2e4c6f-7e5d-3a4b-1c2d-0a9b8f7e6c5d'), -- Associado ao grupo Shopping
  ('1234abcd-5678-9abc-def0-fedcba987654', 'Exercise', 'Go for a run', '2024-09-30 00:00:00', true, '1a5b6c7d-2e3f-4a5b-8c7d-8f9e0a1b2c3d'), -- Associado ao grupo Personal
  ('ffcc2233-5678-9abc-def0-234567890abc', 'Prepare report', 'Monthly financial report', '2024-09-27 00:00:00', true, '1f1a7311-36f8-4fd3-bc4c-3fa3e25e8ef2'), -- Associado ao grupo Work
  ('aabb3344-5678-9abc-def0-876543210fed', 'Birthday gift', 'Buy a present for Sarah', '2024-09-30 00:00:00', false, '1a5b6c7d-2e3f-4a5b-8c7d-8f9e0a1b2c3d'); -- Associado ao grupo Personal



https://www.behance.net/gallery/184079511/To-Do-Mobile-App-ToDo-Trax?tracking_source=search_projects|todo+list&l=15