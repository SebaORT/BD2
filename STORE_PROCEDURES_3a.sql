CREATE OR ALTER  PROCEDURE sp_CambiarEstacionDestinoLinea
	@linea int, 
	@estacionDestino int,@result int output,  @mensaje varchar(100) output
AS
BEGIN

	set @mensaje = 'Se actualizo correctamente';
	set @result =0;

	if NOT EXISTS (select Codigo from Estacion where Codigo = @estacionDestino) 
	begin
		set @mensaje = 'Estacion destino pasada como parametro no existe'
		set @result = 2;
	end

		if EXISTS (select Numero from LineaMetro 
		where Numero = @linea and CodigoEstacionFinal = @estacionDestino) 
	begin
		set @mensaje = 'Estacion destino ya asignada a la linea'
		set @result = 1;
	end

	update LineaMetro set CodigoEstacionFinal = @estacionDestino where Numero = @linea;

END
GO