CREATE SCHEMA IF NOT EXISTS toeichust_vault_data;

CREATE TABLE toeichust_vault_data.vault_kv_store (
    parent_path TEXT COLLATE "C" NOT NULL,
    path TEXT COLLATE "C",
    key TEXT COLLATE "C",
    value BYTEA,
    CONSTRAINT pkey PRIMARY KEY (path, key)
);

CREATE INDEX parent_path_idx ON toeichust_vault_data.vault_kv_store (parent_path);