CREATE TABLE IF NOT EXISTS messages (
  id serial PRIMARY KEY,
  message varchar(255) NOT NULL,
  created_at timestamp DEFAULT current_timestamp
);

TRUNCATE TABLE messages;


