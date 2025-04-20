use Renapo;

ALTER TABLE Representante ADD id_Vivienda INT;

ALTER TABLE Representante
ADD CONSTRAINT FK_id_Vivienda
FOREIGN KEY (id_Vivienda) REFERENCES Vivienda(id_Vivienda);

ALTER TABLE Trabajador ADD id_Viv_Trab INT;

ALTER TABLE Trabajador
ADD CONSTRAINT FK_id_Viv_Trab
FOREIGN KEY (id_Viv_Trab) REFERENCES Vivienda(id_Vivienda);

ALTER TABLE Vivienda ADD id_Rep_Viv INT;
ALTER TABLE Vivienda ADD id_Trab_Viv INT;

ALTER TABLE Vivienda
ADD CONSTRAINT FK_id_Rep_Viv
FOREIGN KEY (id_Rep_Viv) REFERENCES Representante(id_Representante);

ALTER TABLE Vivienda
ADD CONSTRAINT FK_id_Trab_Viv
FOREIGN KEY (id_Trab_Viv) REFERENCES Trabajador(id_Trabajador);

--eliminar columna
ALTER TABLE Vivienda
DROP COLUMN id_Trab_Viv;
--eliminar FK
ALTER TABLE Vivienda
DROP CONSTRAINT id_Trab_Viv;
