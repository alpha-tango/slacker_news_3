CREATE TABLE articles(
  id serial PRIMARY KEY,
  url varchar(255) NOT NULL,
  title varchar(100) NOT NULL,
  description varchar (750) NOT NULL,
  created_at timestamp NOT NULL
);

CREATE TABLE comments(
  id serial PRIMARY KEY,
  article_id integer NOT NULL,
  author varchar(31) NOT NULL,
  created_at timestamp NOT NULL
);
