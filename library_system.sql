    CREATE DATABASE IF NOT EXISTS library_system;

    USE library_system;

    CREATE TABLE books (
        book_id INT PRIMARY KEY AUTO_INCREMENT,
        title VARCHAR(50) NOT NULL,
        author varchar(100) NOT NULL,
        publication_year INT NOT NULL,
        genre VARCHAR(50) DEFAULT "Unknown",
        available BOOLEAN DEFAULT TRUE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );

    INSERT INTO books (title, author, publication_year, genre)
    VALUES
    ("1984", "George Orwell", 1949, "Dystopian"),
    ("Moby-Dick", "Herman Melville", 1851, "Adventure");

    UPDATE books
    SET available = FALSE
    WHERE title = "1984";

    DELETE FROM books
    WHERE publication_year < 1900;

    INSERT INTO books (title, author, publication_year, genre)
    VALUES ("Moby-Dick", "Herman Melville", 1905, "Adventure");

    ALTER TABLE books
    ADD COLUMN price DECIMAL(5, 2);

    UPDATE books
    SET price = 10.50
    WHERE title = "1984";

    UPDATE books 
    SET price = 8.99
    WHERE title = "Moby-Dick";

    ALTER TABLE books
    RENAME COLUMN available TO is_available;

    CREATE TABLE authors (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(100) NOT NULL
    );

    ALTER TABLE books
    ADD COLUMN author_id INT;

    ALTER TABLE books
    DROP COLUMN author;

    ALTER TABLE books
    ADD CONSTRAINT foreign_key_id_author
    FOREIGN KEY (author_id) REFERENCES authors(id);

    INSERT INTO authors (name)
    VALUES 
    ('George Orwell'),
    ("Herman Melville");



