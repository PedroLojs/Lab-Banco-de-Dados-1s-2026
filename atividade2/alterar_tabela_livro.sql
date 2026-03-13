ALTER TABLE livro 
DROP COLUMN autor, 
DROP COLUMN editora, 
DROP COLUMN categoria;

ALTER TABLE livro 
ADD COLUMN data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
ADD COLUMN id_usuario INT,
ADD COLUMN id_autor INT,
ADD COLUMN id_editora INT,
ADD COLUMN id_categoria INT,
ADD FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
ADD FOREIGN KEY (id_autor) REFERENCES autor(id_autor),
ADD FOREIGN KEY (id_editora) REFERENCES editora(id_editora),
ADD FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria);