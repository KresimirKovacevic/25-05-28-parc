CREATE PROCEDURE DohvatiPopisNedostajucihMedija
	AS
	BEGIN
		SELECT Ime + ' ' + Prezime AS 'Prijatelj', NazivMedija AS 'Naziv medija', DATEDIFF(day, DanPosudbe, CAST(GETDATE() AS DATE)) AS 'Dani od posudbe'
			FROM Osobe INNER JOIN Posudbe ON IDosobe = Osoba
				INNER JOIN Mediji ON IDmedija = Medij
			WHERE DanPovratka IS NULL
				OR DanPovratka > GETDATE();
	END;