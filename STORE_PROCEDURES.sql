CREATE OR ALTER  PROCEDURE CambiarEstacionDestinoLinea(
	@linea int, 
	@estacionDestino int,  @mensaje varchar(100) out)
AS
BEGIN

	set @mensaje = '';
	if NOT EXISTS (select Codigo from Estacion where Codigo = @estacionDestino) 
	begin
		set @mensaje = 'Estacion destino pasada como parametro no existe'
	end

	update LineaMetro set CodigoEstacionFinal = @estacionDestino where Numero = @linea;
END
GO
