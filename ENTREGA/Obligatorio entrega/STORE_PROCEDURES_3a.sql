use [ObligatorioBD2_GestionMetro];
GO

-- 3a
CREATE PROCEDURE sp_CambiarEstacionDestinoLinea
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

-- 3b

CREATE FUNCTION dbo.obtenerNombreEstacion(@inicio date, @fin date)  
RETURNS varchar(200)   
AS   
-- dado un rango de fechas, retornar el nombre de la estación por la
-- que pasaron más trenes en dicho rango  
BEGIN  
    DECLARE @ret varchar(200);
	
	DECLARE @IdEstacion int;

	SELECT top 1 @IdEstacion = CodigoEstacion
  FROM [dbo].[TrenEstacionLineaMetro]
  where fecha > @inicio and fecha < @fin 
  group by CodigoEstacion order by count(NumeroTren) desc

    select @ret = Descripcion from dbo.Estacion where Codigo = @IdEstacion

    RETURN @ret;  
END; 