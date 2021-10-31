declare @result int;
declare @mensaje varchar(200);

EXECUTE  sp_CambiarEstacionDestinoLinea 1,3,@result output,  @mensaje output;

 PRINT '           '
  PRINT @result
 PRINT @mensaje 