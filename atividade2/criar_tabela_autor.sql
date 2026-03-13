CREATE TABLE Autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    ano_nascimento YEAR,
    ano_morte YEAR,
    apresentacao TEXT,
    data_cadrasto timestamp default current_timestamp,
    data_atualizacao timestamp default current_timestamp on update current_timestamp
)