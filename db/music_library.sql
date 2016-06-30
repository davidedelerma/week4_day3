DROP TABLE albums;
DROP TABLE artists;

CREATE TABLE artists (
  id serial4 primary key,
  name varchar(255) not null
);

CREATE TABLE albums (
  id serial4 primary key,
  name varchar(255) not null,
  year int4 not null,
  artist_id int4 references artists(id) ON DELETE CASCADE
);