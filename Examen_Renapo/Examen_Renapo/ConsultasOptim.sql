-- mostrar ciertos numeros de datos

use Renapo;
GO

select * from dbo.Da
WHERE @edad > 20;
