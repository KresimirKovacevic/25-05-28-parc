CREATE PROCEDURE PostaviSveDanasVraceno
	AS
	BEGIN
		UPDATE Posudbe SET DanPovratka = CAST(GETDATE() AS DATE)
			WHERE DanPovratka IS NULL
				OR DanPovratka > GETDATE();
	END;