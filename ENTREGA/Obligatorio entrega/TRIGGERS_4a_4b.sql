use [ObligatorioBD2_GestionMetro];
GO

--4a - Auditar cualquier movimiento que exista en las Lineas
CREATE TRIGGER trg_Auditoria
ON TrenEstacionLineaMetro
AFTER insert,update,delete
AS
BEGIN
--insert
IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
insert into dbo.[AuditoriaLineaMetro]
  SELECT CURRENT_USER,host_name(),getdate(),'INSERT',*, null, null, null, null,null
  FROM inserted

--delete
IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
insert into dbo.[AuditoriaLineaMetro]
SELECT CURRENT_USER,host_name(),getdate(),'DELETE',*, null, null, null, null,null
FROM deleted

--update
IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
insert into dbo.[AuditoriaLineaMetro]

SELECT CURRENT_USER,host_name(),getdate(),'UPDATE',d.*,i.*
FROM inserted i, deleted d
WHERE i.CodigoEstacion = d.CodigoEstacion and
i.NumeroLinea = d.NumeroLinea and i.NumeroTren = d.NumeroTren

END;

GO

-- 4b 
CREATE TRIGGER trg_RegistrarPasoTrenes
ON TrenEstacionLineaMetro
AFTER insert
AS
BEGIN

--COALESCE devuelve el primer valor, o si es null devuelve 0
update Estacion set CantTrenes = CantTrenes + 
COALESCE ((SELECT  
      Count(NumeroTren)
  FROM inserted
  where CodigoEstacion = Estacion.Codigo
  group by CodigoEstacion), 0);

END;