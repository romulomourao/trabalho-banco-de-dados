DROP DATABASE IF EXISTS escola;
CREATE DATABASE escola;
USE escola;

CREATE TABLE cidade (
    cidade_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    CONSTRAINT pk_cidade PRIMARY KEY(cidade_id)    
);

CREATE TABLE disciplina(
  disciplina_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45),
  CONSTRAINT pk_disciplina PRIMARY KEY (disciplina_id)
);

CREATE TABLE pessoa (
  pessoa_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  cidade_id SMALLINT UNSIGNED NOT NULL,
  nome VARCHAR(45) NOT NULL,
  telefone VARCHAR(45),
  CONSTRAINT pk_pessoa PRIMARY KEY (pessoa_id),
  CONSTRAINT fk_pessoa_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (cidade_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE professor(
  professor_id SMALLINT UNSIGNED NOT NULL,
  rg VARCHAR(10) NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  titulacao VARCHAR(45),
  CONSTRAINT uk_professor_cpf UNIQUE KEY(cpf),
  CONSTRAINT uk_professor_rg UNIQUE KEY(rg),
  CONSTRAINT pk_professor PRIMARY KEY (professor_id),
  CONSTRAINT fk_professor_pessoa FOREIGN KEY (professor_id) REFERENCES pessoa (pessoa_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE escola(
  escola_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50),
  diretor_id SMALLINT UNSIGNED NOT NULL,
  cidade_id SMALLINT UNSIGNED NOT NULL,
  CONSTRAINT pk_escola PRIMARY KEY(escola_id),
  CONSTRAINT uk_escola_professor UNIQUE KEY (diretor_id),
  CONSTRAINT fk_escola_professor FOREIGN KEY (diretor_id) REFERENCES professor (professor_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_escola_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (cidade_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE turma(
  turma_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  escola_id SMALLINT UNSIGNED NOT NULL,
  nome VARCHAR(45) NOT NULL,
  CONSTRAINT pk_turma PRIMARY KEY (turma_id),
  CONSTRAINT fk_turma_escola FOREIGN KEY (escola_id) REFERENCES escola (escola_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE aluno(
  aluno_id SMALLINT UNSIGNED NOT NULL,
  turma_id SMALLINT UNSIGNED NOT NULL,
  matricula INT NOT NULL,
  data_nasc DATE NOT NULL,
  CONSTRAINT pk_aluno PRIMARY KEY (aluno_id),
  CONSTRAINT uk_aluno_pessoa UNIQUE KEY (matricula),
  CONSTRAINT fk_aluno_pessoa FOREIGN KEY (aluno_id) REFERENCES pessoa (pessoa_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_aluno_turma FOREIGN KEY (turma_id) REFERENCES turma (turma_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE contato(
  aluno_id SMALLINT UNSIGNED NOT NULL,
  nome VARCHAR(45) NOT NULL,
  telefone VARCHAR(45) NOT NULL,
  CONSTRAINT pk_contato PRIMARY KEY (aluno_id,nome),
  CONSTRAINT fk_aluno_contato FOREIGN KEY (aluno_id) REFERENCES aluno (aluno_id) ON DELETE RESTRICT ON UPDATE CASCADE 
);

CREATE TABLE professor_disciplina(
  disciplina_id SMALLINT UNSIGNED NOT NULL,
  professor_id SMALLINT UNSIGNED NOT NULL,
  CONSTRAINT pk_professor_disciplina PRIMARY KEY (disciplina_id, professor_id),
  CONSTRAINT fk_professor_disciplina_disciplina FOREIGN KEY (disciplina_id) REFERENCES disciplina (disciplina_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_professor_disciplina_professor FOREIGN KEY (professor_id) REFERENCES professor (professor_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ministra_turma(
  disciplina_id SMALLINT UNSIGNED NOT NULL,
  professor_id SMALLINT UNSIGNED NOT NULL,
  turma_id SMALLINT UNSIGNED NOT NULL,
  CONSTRAINT pk_ministra_turma PRIMARY KEY (disciplina_id, professor_id,turma_id),
  CONSTRAINT fk_ministra_turma_professor_disciplina FOREIGN KEY (disciplina_id, professor_id) REFERENCES professor_disciplina (disciplina_id, professor_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_ministra_turma_turma FOREIGN KEY (turma_id) REFERENCES turma (turma_id) ON DELETE CASCADE ON UPDATE CASCADE  
);

#Cidades
INSERT INTO cidade(nome) VALUES ("Rio de Janeiro"), ("Niterói"), ("Volta Redonda"), ("Rio das Ostras"), ("Resende"), ("Maricá");

#Disciplinas
INSERT INTO disciplina(nome) VALUES ("Matemática"),("Inglês"),("Química"),("Espanhol"),("Biologia"),("Filosofia"),("Educação Física"),("Geografia"),("História da América"),("História do Brasil"),("História Geral"),("Geografia do Brasil"),("Português"),("Literatura"),("Física"),("Sociologia "),("Redação"),("Artes");

#Pessoas
INSERT INTO pessoa(cidade_id, nome, telefone) VALUES ( 1,"Daniel Melo","(21) 6502-4376"),( 1,"Ana Silva","(21) 7650-8595"),( 1,"Carolina Pinto","(21) 4940-9643"),( 1,"Gabriel Oliveira","(21) 3028-5919"),( 1,"Nicole Rocha","(21) 4087-4927"),( 1,"Kauê Cavalcanti","(21) 2900-2656"),( 1,"Ryan Costa","(21) 6495-5737"),( 1,"André Rocha","(21) 5663-3216"),( 2,"Luís Almeida","(21) 2282-5728"),( 2,"Emily Rodrigues","(21) 9219-6557"),( 2,"Larissa Silva","(21) 3636-7527"),( 2,"Samuel Costa","(21) 3952-2772"),( 2,"Rodrigo Oliveira","(21) 6214-5729"),( 4,"Felipe Costa","(21) 2326-5774"),( 3,"Tiago Oliveira","(21) 4976-5741"),( 3,"Lavinia Carvalho","(21) 5223-9794"),( 3,"Bianca Souza","(21) 5033-7598"),( 3,"Vinicius Barbosa","(21) 5154-3647"),( 3,"José Pinto","(21) 2025-7722"),( 3,"Renan Oliveira","(21) 4321-3996"),( 4,"Larissa Cardoso","(21) 2261-8608"),( 4,"Julian Cavalcanti","(21) 5193-5808"),( 4,"Evelyn Dias","(21) 7453-5519"),( 4,"Alex Pinto","(21) 2135-2523"),( 4,"Igor Araujo","(21) 5996-5190"),( 4,"Larissa Pinto","(21) 7122-3031"),( 4,"Breno Ferreira","(21) 2434-4966"),( 4,"Estevan Barbosa","(21) 2277-7809"),( 5,"Felipe Pereira","(21) 3082-2715"),( 5,"Gabrielle Almeida","(21) 8370-4073"),( 5,"Evelyn Sousa","(21) 5906-4076"),( 5,"Marcos Carvalho","(21) 3600-4680"),( 5,"Ryan Costa","(21) 6790-4138"),( 5,"Letícia Alves","(21) 7185-9449"),( 5,"Leila Castro","(21) 8225-6842"),( 5,"Fernanda Costa","(21) 6522-4263"),( 5,"Victor Lima","(21) 3482-9220"),( 5,"Felipe Gomes","(21) 5574-7364"),( 5,"Matheus Silva","(21) 5990-6045"),( 6,"Kauê Ferreira","(21) 6839-7328"),( 6,"Miguel Pinto","(21) 6953-8260"),( 6,"Diego Azevedo","(21) 8471-5922"),( 6,"Davi Dias","(21) 8466-7501"),( 6,"Cauã Goncalves","(21) 4170-6206"),( 6,"Giovanna Rodrigues","(21) 8327-7153"),( 6,"Kaua Cunha","(21) 3531-6756"),( 6,"Murilo Rodrigues","(21) 4571-4774"),( 6,"Gabriel Alves","(21) 7406-6346"),( 6,"Gustavo Melo","(21) 7844-6513"),( 6,"Matheus Rocha","(21) 4125-5538"),( 3,"José Mendes","(21) 2357-4476"),( 6,"Alessandro Pimentel","(21) 8632-4366");

#Professor
INSERT INTO professor(professor_id, rg, cpf, titulacao) VALUES (1,"20.821.009-0" ,"102.223.536-03","Mestre"),(2,"13.820.793-5" ,"129.324.524-42","Especialista"),(3,"12.790.347-6" ,"093.399.249-16","Mestre"),(4,"14.091.510-6" ,"100.769.979-52","Mestre"),(5,"13.899.943-2" ,"109.287.639-19","Especialista"),(6,"12.790.350-6" ,"093.399-259-98","Especialista"),(7,"13.856.023-6" ,"021.052.776-59",null),(8,"13.951.736-9" ,"110.219.359-30","Especialista"),(9,"13.821.069-3" ,"107.777.819-80","Mestre"),(10,"10.282.018-5" , "102.347.829-50","Doutor"),(11,"24.362.016-1" , "090.390.819-13","Especialista"),(12,"17.488.058-0" , "101.447.907-10","Doutor");

#Escola
INSERT INTO escola(nome, diretor_id, cidade_id) VALUES ("ESCOLA MUNICIPAL JORNALISTA FREITAS NETO",1,1),("ESCOLA MUNICIPAL ROMEU DE AVELAR",2,1),("ESCOLA MUNICIPAL MARIO DAVID ANDREAZZA",3,2),("ESCOLA MUNICIPAL PROF. RUTH DE ALMEIDA BEZERRA",4,3),("ESCOLA MUNICIPAL SERAFINI COSTAPERARIA",5,4);

#Turma
INSERT INTO turma(escola_id, nome) VALUES (1,"A201"), (2,"C203"), (1, "A205"), (3,"B402"), (4,"V301"), (5,"L406");

#Aluno
INSERT INTO aluno(aluno_id, turma_id, matricula, data_nasc) VALUES (13,1,50243,"1991-01-09"),(14,6,65085,"1992-06-17"),(15,1,94096,"1992-12-16"),(16,1,32859,"1993-07-07"),(17,2,28749,"1993-09-22"),(18,2,90026,"1993-11-17"),(19,2,49557,"1994-05-18"),(20,2,66332,"1995-08-23"),(21,2,28257,"1995-11-29"),(22,2,21965,"1996-05-01"),(23,3,63675,"1996-12-04"),(24,3,95227,"1997-02-12"),(25,3,21457,"1997-04-16"),(26,3,32657,"1997-10-22"),(27,3,97657,"1998-01-28"),(28,3,22397,"1998-03-04"),(29,3,13375,"1998-04-01"),(30,3,15436,"1998-12-23"),(31,3,62577,"1999-01-06"),(32,3,32139,"2000-03-22"),(33,4,26186,"2000-05-24"),(34,4,19358,"2001-05-23"),(35,4,45355,"2002-09-11"),(36,4,13525,"2002-11-27"),(37,4,99651,"2002-12-11"),(38,4,12230,"1996-05-24"),(39,4,43449,"1996-10-19"),(40,4,27778,"1997-01-28"),(41,4,90640,"1998-02-28"),(42,4,60046,"1998-04-20"),(43,4,79041,"1998-06-25"),(44,4,18594,"1999-02-23"),(45,4,22568,"2000-07-03"),(46,4,52242,"2000-09-29"),(47,4,48292,"2000-10-11"),(48,4,57473,"2001-10-22"),(49,4,88227,"2001-12-03"),(50,4,37040,"2002-11-25"),(51,5,62001,"1998-12-02"),(52,5,62040,"2001-03-23");

#Contato
INSERT INTO contato(aluno_id, nome, telefone) VALUES (15,"Roberto Azevedo","(21) 5574-7364"),(15,"Maria Conceição Pires","(21) 5990-6045"),(16,"Lucas Martins de Oliveira","(21) 6839-7328"),(20,"José Mendes da Costa","(21) 6953-8260"),(30,"Fernanda Moura","(21) 8471-5922"),(48,"Newton Nunes Xavier","(21) 8466-7501");

#Professor_Disciplina
INSERT INTO professor_disciplina(professor_id,disciplina_id) VALUES (1,1),(12,1),(2,2),(3,18),(4,7),(5,8),(5,12),(6,3),(7,4),(8,6),(8,16),(9,5),(10,9),(10,10),(10,11),(10,8),(10,12),(12,15);

#Ministra_Turma

INSERT INTO ministra_turma(professor_id, disciplina_id, turma_id) VALUES (1,1,1), (1,1,2), (1,1,3), (1,1,4), (2,2,2), (3,18,2),(4,7,3),(5,8,4),(5,8,1),(5,12,1),(6,3,2), (7,4,2),(8,6,2),(8,16,2),(9,5,2), (10,9,4),(10,10,4),(10,11,4),(10,8,4);