CREATE TABLE data_table (
  id VARCHAR(32) NOT NULL,
  data TEXT NOT NULL,
  access VARCHAR(14) NOT NULL,
  PRIMARY KEY (id)
);

CREATE INDEX data_table_access_idx ON data_table (access);