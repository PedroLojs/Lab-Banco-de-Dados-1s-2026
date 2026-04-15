CREATE DATABASE biblioteca_pessoal;
USE biblioteca_pessoal;

CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(128) NOT NULL UNIQUE,
    descricao TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    ano_nascimento INT,
    ano_morte INT,
    apresentacao TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_ano_nascimento CHECK (ano_nascimento IS NULL OR ano_nascimento > 0),
    CONSTRAINT chk_ano_morte CHECK (
        ano_morte IS NULL OR 
        (ano_nascimento IS NOT NULL AND ano_morte >= ano_nascimento)
    )
);

CREATE TABLE Editora (
    id_editora INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    cidade VARCHAR(64),
    estado VARCHAR(64),
    pais VARCHAR(64),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Livro (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_autor INT NOT NULL,
    id_editora INT,
    id_categoria INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    sinopse TEXT,
    ano_publicacao INT,
    lido BOOLEAN DEFAULT FALSE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_usuario 
        FOREIGN KEY (id_usuario) 
        REFERENCES Usuario(id_usuario) 
        ON DELETE CASCADE,

    CONSTRAINT fk_autor 
        FOREIGN KEY (id_autor) 
        REFERENCES Autor(id_autor) 
        ON DELETE RESTRICT,

    CONSTRAINT fk_categoria 
        FOREIGN KEY (id_categoria) 
        REFERENCES Categoria(id_categoria) 
        ON DELETE RESTRICT,

    CONSTRAINT fk_editora 
        FOREIGN KEY (id_editora) 
        REFERENCES Editora(id_editora) 
        ON DELETE RESTRICT,

    CONSTRAINT chk_ano_publicacao CHECK (ano_publicacao IS NULL OR ano_publicacao > 0)
);

INSERT INTO Usuario (nome, email, senha) VALUES
('Ana Silva', 'ana@email.com', '123'),
('Bruno Souza', 'bruno@email.com', '123'),
('Carla Mendes', 'carla@email.com', '123');

INSERT INTO Categoria (nome, descricao) VALUES
('Ficção Científica', 'Livros com temas futuristas e científicos'),
('Fantasia', 'Mundos imaginários e mágicos'),
('Romance', 'Histórias centradas em relações humanas'),
('Clássicos', 'Obras consagradas da literatura'),
('Suspense', 'Narrativas de tensão e mistério'),
('Filosofia', 'Reflexões filosóficas');

INSERT INTO Autor (nome, ano_nascimento, ano_morte) VALUES
('George Orwell', 1903, 1950),
('J.R.R. Tolkien', 1892, 1973),
('Jane Austen', 1775, 1817),
('Machado de Assis', 1839, 1908),
('Agatha Christie', 1890, 1976),
('Isaac Asimov', 1920, 1992),
('Fyodor Dostoevsky', 1821, 1881),
('J.K. Rowling', 1965, NULL),
('Stephen King', 1947, NULL),
('Aldous Huxley', 1894, 1963);

INSERT INTO Editora (nome, cidade, estado, pais) VALUES
('Penguin Books', 'Londres', NULL, 'Reino Unido'),
('HarperCollins', 'Nova York', 'NY', 'EUA'),
('Companhia das Letras', 'São Paulo', 'SP', 'Brasil'),
('Editora Record', 'Rio de Janeiro', 'RJ', 'Brasil'),
('Rocco', 'Rio de Janeiro', 'RJ', 'Brasil');

INSERT INTO Livro (id_usuario, id_autor, id_editora, id_categoria, titulo, ano_publicacao, lido) VALUES
(1,1,1,4,'1984',1949,TRUE),
(1,1,1,1,'Animal Farm',1945,TRUE),
(1,2,1,2,'The Hobbit',1937,TRUE),
(1,2,1,2,'The Lord of the Rings',1954,FALSE),
(1,3,1,3,'Pride and Prejudice',1813,TRUE),
(1,3,1,3,'Sense and Sensibility',1811,FALSE),
(1,4,3,4,'Dom Casmurro',1899,TRUE),
(1,4,3,4,'Memórias Póstumas de Brás Cubas',1881,FALSE),
(1,5,2,5,'Murder on the Orient Express',1934,TRUE),
(1,5,2,5,'And Then There Were None',1939,FALSE),
(1,6,2,1,'Foundation',1951,TRUE),
(1,6,2,1,'I, Robot',1950,FALSE),
(1,7,1,6,'Crime and Punishment',1866,TRUE),
(1,7,1,6,'The Brothers Karamazov',1880,FALSE),

(2,8,5,2,'Harry Potter and the Sorcerer''s Stone',1997,TRUE),
(2,8,5,2,'Harry Potter and the Chamber of Secrets',1998,TRUE),
(2,8,5,2,'Harry Potter and the Prisoner of Azkaban',1999,FALSE),
(2,9,2,5,'The Shining',1977,TRUE),
(2,9,2,5,'It',1986,FALSE),
(2,9,2,5,'Misery',1987,TRUE),
(2,10,1,1,'Brave New World',1932,TRUE),
(2,10,1,1,'Island',1962,FALSE),
(2,1,1,1,'Homage to Catalonia',1938,FALSE),
(2,6,2,1,'The Caves of Steel',1953,TRUE),
(2,6,2,1,'The Naked Sun',1957,FALSE),
(2,5,2,5,'Death on the Nile',1937,TRUE),
(2,3,1,3,'Emma',1815,FALSE),
(2,4,3,4,'Quincas Borba',1891,TRUE),

(3,7,1,6,'Notes from Underground',1864,TRUE),
(3,7,1,6,'The Idiot',1869,FALSE),
(3,2,1,2,'Silmarillion',1977,FALSE),
(3,2,1,2,'Unfinished Tales',1980,FALSE),
(3,8,5,2,'Harry Potter and the Goblet of Fire',2000,TRUE),
(3,8,5,2,'Harry Potter and the Order of the Phoenix',2003,FALSE),
(3,9,2,5,'Carrie',1974,TRUE),
(3,9,2,5,'Pet Sematary',1983,FALSE),
(3,10,1,1,'Doors of Perception',1954,TRUE),
(3,6,2,1,'Prelude to Foundation',1988,FALSE),
(3,6,2,1,'Forward the Foundation',1993,FALSE),
(3,5,2,5,'The ABC Murders',1936,TRUE),
(3,4,3,4,'Helena',1876,FALSE),
(3,3,1,3,'Mansfield Park',1814,TRUE);

SELECT l.titulo
FROM Livro l
JOIN Autor a ON l.id_autor = a.id_autor
WHERE a.nome = 'J.K. Rowling';

SELECT l.titulo
FROM Livro l
JOIN Categoria c ON l.id_categoria = c.id_categoria
WHERE c.nome = 'Filosofia';

UPDATE Categoria
SET nome = 'Censurado'
WHERE nome = 'Filosofia';

DELETE l
FROM Livro l
JOIN Categoria c ON l.id_categoria = c.id_categoria
WHERE c.nome = 'Censurado';