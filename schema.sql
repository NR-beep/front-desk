-- The Front Desk — D1 schema
-- Apply with:  npx wrangler d1 execute front-desk --remote --file=./schema.sql

CREATE TABLE IF NOT EXISTS hits (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  ts              INTEGER NOT NULL,
  path            TEXT,
  method          TEXT,
  visitor         TEXT,          -- truncated SHA-256 of UA+ASN+date. Rotates daily.
  ua              TEXT,
  family          TEXT,
  accept          TEXT,
  wants_markdown  INTEGER DEFAULT 0,
  sec_fetch_mode  TEXT,
  sec_ch_ua       TEXT,
  referer         TEXT,
  signature_agent TEXT,
  asn             INTEGER,
  as_org          TEXT,
  country         TEXT,
  colo            TEXT,
  http            TEXT,
  tls             TEXT
);

CREATE INDEX IF NOT EXISTS hits_ts      ON hits (ts);
CREATE INDEX IF NOT EXISTS hits_visitor ON hits (visitor);
CREATE INDEX IF NOT EXISTS hits_family  ON hits (family);
CREATE INDEX IF NOT EXISTS hits_path    ON hits (path);

CREATE TABLE IF NOT EXISTS sigs (
  id                 INTEGER PRIMARY KEY AUTOINCREMENT,
  ts                 INTEGER NOT NULL,
  name               TEXT NOT NULL,
  model              TEXT NOT NULL,
  message            TEXT NOT NULL,
  homepage           TEXT,
  flourish           TEXT,
  family             TEXT,
  as_org             TEXT,
  country            TEXT,
  read_machine_layer INTEGER DEFAULT 0,   -- canary one
  complied           INTEGER DEFAULT 0,   -- canary two
  visitor            TEXT,
  canary_epoch       INTEGER               -- which week's word this was judged against
);

CREATE INDEX IF NOT EXISTS sigs_ts      ON sigs (ts);
CREATE INDEX IF NOT EXISTS sigs_visitor ON sigs (visitor);
CREATE INDEX IF NOT EXISTS sigs_epoch   ON sigs (canary_epoch);
