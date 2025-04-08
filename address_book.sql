CREATE DATABASE IF NOT EXISTS address_book;
USE address_book;

CREATE TABLE IF NOT EXISTS contacts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO contacts (first_name, last_name, email)
VALUES 
("Hugo", "Patou", "hugopat@live.be"),
("Pierre", "Paul", "PierrePaul@Jacques.com"),
("Pauline", "VanMachin", "PVM@Skynet.fr"),
("John", "Smith", "John.smith@becode.be");

UPDATE contacts
SET email = "NouveauEmail@MSN.eu"
WHERE id = 2;

DELETE FROM contacts
WHERE last_name = "Smith";

INSERT INTO contacts (first_name, last_name, email)
VALUES ("John", "Smith", "Nouveau.John@becode.be");

ALTER TABLE contacts
ADD COLUMN phone_number VARCHAR(12);

UPDATE contacts SET phone_number = "12/34.56.78" WHERE id = 1;
UPDATE contacts SET phone_number = "04/78/91/23" WHERE id = 2;
UPDATE contacts SET phone_number = "06/12.34.56.78" WHERE id = 3;
UPDATE contacts SET phone_number = "12/34-56-78-90" WHERE id = 4;