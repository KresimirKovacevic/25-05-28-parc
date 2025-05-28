USE master;

CREATE DATABASE kkParc1;

USE kkParc1;

CREATE TABLE TipoviMedija
(
	IDtipa 		INT IDENTITY(1,1) NOT NULL,
	NazivTipa 	NVARCHAR(20) NOT NULL,
	PRIMARY KEY (IDtipa),
	UNIQUE (NazivTipa)
);

CREATE TABLE Osobe
(
	IDosobe 	INT IDENTITY(1,1) NOT NULL,
	Ime 		NVARCHAR(50) NOT NULL,
	Prezime 	NVARCHAR(50) NOT NULL,
	PRIMARY KEY (IDosobe)
);

CREATE TABLE Mediji
(
	IDmedija 	INT IDENTITY(1,1) NOT NULL,
	NazivMedija 	NVARCHAR(200) NOT NULL,
	TipMedija 	INT NOT NULL,
	PRIMARY KEY (IDmedija),
	FOREIGN KEY (TipMedija) REFERENCES TipoviMedija(IDtipa)
);

CREATE TABLE Posudbe
(
	Medij 		INT NOT NULL,
	Osoba 		INT NOT NULL,
	DanPosudbe 	DATE NOT NULL,
	DanPovratka 	DATE,
	PRIMARY KEY (DanPosudbe, Medij),
	FOREIGN KEY (Medij) REFERENCES Mediji(IDmedija),
	FOREIGN KEY (Osoba) REFERENCES Osobe(IDosobe),
	CHECK (DanPovratka > DanPosudbe)
);

BEGIN TRANSACTION;

INSERT INTO TipoviMedija VALUES 
	('DVD'), 
	('CD');

INSERT INTO Mediji VALUES
	('Empire', 1),
	('Catch the Rainbow', 2),
	('Stairway to Heaven', 2),
	('Killer Queen', 2);

INSERT INTO Osobe VALUES
	('Ivan', ' Jelacic'),
	('Maja', 'Mazuranic'),
	('Predrag', 'Uljarevic');

INSERT INTO Posudbe VALUES
	(1, 2, '2025-05-02', '2025-05-04');

INSERT INTO Posudbe (Medij, Osoba, DanPosudbe) VALUES
	(2, 3, '2025-05-10'),
	(3, 1, '2025-05-25'),
	(4, 3, '2025-04-29');

COMMIT TRANSACTION;

SELECT Ime + ' ' + Prezime AS 'Prijatelj', NazivMedija AS 'Naziv medija', DATEDIFF(day, DanPosudbe, CAST(GETDATE() AS DATE)) AS 'Dani od povratka'
	FROM Osobe INNER JOIN Posudbe ON IDosobe = Osoba
		INNER JOIN Mediji ON IDmedija = Medij
	WHERE DanPovratka IS NULL
		OR DanPovratka > GETDATE();

UPDATE Posudbe SET DanPovratka = CAST(GETDATE() AS DATE)
	WHERE DanPovratka IS NULL
		OR DanPovratka > GETDATE();
