-- ==========================================
-- Library Management System
-- File: 02_Create_Tables.sql
-- ==========================================

USE LibraryDB;

-- 1. Authors Table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    country VARCHAR(50)
);

-- 2. Categories Table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    published_year YEAR,

    CONSTRAINT fk_book_author
        FOREIGN KEY (author_id)
        REFERENCES Authors(author_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_book_category
        FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
        ON DELETE CASCADE
);

-- 4. Members Table
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    join_date DATE DEFAULT (CURRENT_DATE)
);

-- 5. Librarians Table
CREATE TABLE Librarians (
    librarian_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- 6. Book_Issues Table
CREATE TABLE Book_Issues (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    issue_date DATE DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,

    CONSTRAINT fk_issue_book
        FOREIGN KEY (book_id)
        REFERENCES Books(book_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_issue_member
        FOREIGN KEY (member_id)
        REFERENCES Members(member_id)
        ON DELETE CASCADE
);

-- 7. Book_Returns Table
CREATE TABLE Book_Returns (
    return_id INT AUTO_INCREMENT PRIMARY KEY,
    issue_id INT NOT NULL,
    return_date DATE DEFAULT (CURRENT_DATE),
    fine DECIMAL(10,2) DEFAULT 0 CHECK (fine >= 0),

    CONSTRAINT fk_return_issue
        FOREIGN KEY (issue_id)
        REFERENCES Book_Issues(issue_id)
        ON DELETE CASCADE
);