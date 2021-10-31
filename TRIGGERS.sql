CREATE TRIGGER trg_Auditoria
ON TrenEstacionLineaMetro
AFTER insert,update,delete
AS
BEGIN
--insert
IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
insert into dbo.[AuditoriaLineaMetro]
  SELECT CURRENT_USER,host_name(),getdate(),'INSERT',*
  FROM inserted

--delete
IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
insert into dbo.[AuditoriaLineaMetro]
SELECT CURRENT_USER,host_name(),getdate(),'DELETE',*
FROM deleted

--update
IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
insert into dbo.[AuditoriaLineaMetro]

SELECT CURRENT_USER,host_name(),getdate(),'UPDATE',i.*
FROM inserted i, deleted d
WHERE i.CodigoEstacion = d.CodigoEstacion and
i.NumeroLinea = d.NumeroLinea and i.NumeroTren = d.NumeroTren

END