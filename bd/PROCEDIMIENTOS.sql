use SARI
-----------------------------------------------------------------------------------------------------------
------------     procedimientos para obtener el curriculum          ---------------------------------------
-----------------------------------------------------------------------------------------------------------


-------------------------- Eliminacion de Persona -----------------------------------------------------
go
CREATE PROCEDURE ELIMINACION 
@NombreME VARCHAR(40), @ApellidoDAD VARCHAR(40),@ApellidoMOM VARCHAR(40)
as
set nocount on;
update Persona set Estatus='Baja'
 where Nombre=@NombreME and ApPaterno=@ApellidoDAD and ApMaterno=@ApellidoMOM
go


---------------------------------------------------------------------------------------------------------------

-------------------------------- Cambio de Contraseña ----------------------------------------------------------
go 
CREATE PROCEDURE CAMBIO_CONTRASEÑA
@Contraseña VARCHAR(30), @contraN VARCHAR(30),@Usuario VARCHAR(30)

as
set nocount on;
update Usuario set Password_2=@contraN
where Tipo_Usuario=@Usuario and Password_2=@Contraseña
go



--------------------------------------------------------------------------------------------------------------

-------------- 1.- Datos personales  -------------------------------------------------------------------------

GO
create PROCEDURE CONSULTA_INFO_PERSONAL
@NombreME VARCHAR(40), @ApellidoDAD VARCHAR(40),@ApellidoMOM VARCHAR(40)
as
set nocount on;

  select RFC,Curp,Nombre,ApPaterno,ApMaterno,Genero,Estado_civil,FechaNacimiento,Estatus
  from Persona
  where Nombre=@NombreME and ApPaterno=@ApellidoDAD and ApMaterno=@ApellidoMOM
go
  

  EXECUTE CONSULTA_INFO_PERSONAL 'katherin','amaro','coyotl'

--------------------- 2.-  recidencia           -----------------------------

go
CREATE PROCEDURE CONSULTA_DIR_PERSONA
@NombreME VARCHAR(40), @ApellidoDAD VARCHAR(40),@ApellidoMOM VARCHAR(40)
as
set nocount on;

select dr.Pais,dr.Calle,dr.Calle,dr.Colonia,dr.NumInterior,dr.NumExterior,dr.CodigoPostal
  
from Persona p inner join Requiere_de rd on p.idPersona=rd.idPersona inner join Direccion dr
on dr.idDireccion=rd.idDireccion 

WHERE p.Nombre=@NombreME and p.ApPaterno=@ApellidoDAD and p.ApMaterno=@ApellidoMOM

go

EXECUTE CONSULTA_DIR_PERSONA 'Vicente','Geronimo','Matinez'


----------  3.-  procedimiento en formacion  (estudios)  ----------------------------------

GO
CREATE PROCEDURE CONSULTA_FORMACION_ESTUDIOS
@NombreME VARCHAR(40), @ApellidoDAD VARCHAR(40),@ApellidoMOM VARCHAR(40)
as
set nocount on;
select  Nivel_Estudios,Pais,Institucion,Area,Titulo,Fecha_Inicio,Fecha_Terminos
from Estudios  e inner join Candidatos c on c.idCandidatos=e.idCandidatos inner join
Persona p on p.idPersona=c.idPersona 

 
WHERE p.Nombre=@NombreME and p.ApPaterno=@ApellidoDAD and p.ApMaterno=@ApellidoMOM
go

EXECUTE CONSULTA_FORMACION_ESTUDIOS 'Isis','Veronica','Veronica'

-------------------  4.- EXPERIENCIA (HISTORIAL LABORAL)  -----------------------

go
CREATE PROCEDURE CONSULTA_HISTORIAL_LABORAL
@NombreME VARCHAR(40), @ApellidoDAD VARCHAR(40),@ApellidoMOM VARCHAR(40)
as
set nocount on;
SELECT HL.Empresa,HL.Industri,HL.Area,HL.Puesto,HL.Fecha_Inicio,HL.Fecha_Fin,HL.Jefe_Imediato,HL.Telefono_Jefe
FROM   Hiistorial_Laboral HL inner join Candidatos ca on HL.idCandidatos=ca.idCandidatos inner join Persona pe 
on pe.idPersona=ca.idPersona

WHERE pe.Nombre=@NombreME and pe.ApPaterno=@ApellidoDAD and pe.ApMaterno=@ApellidoMOM
go


----------------------------------------------------------------------------------------------------------------------------------

----------------------------          PROCEDIMIENTO PARA LA CONSULTA EN SOLICITUD  -----------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------


-------------------------------------  1.-  SOLICITUD PARA COMPRA DE UN PRODUCTO    --------------------
--                      tendra un parametro para verificar el status de la solicitud ya sea
--                               a) en proceso
--                               b) autorizado
--                               c) no se que otro estatus
----------------------------------------------------------------------------------------------------------

GO

CREATE PROCEDURE CONSULTA_SOLICITUD_SATATUS
@STATUS_S VARCHAR(40)
as
set nocount on;

select sc.id_Compra,pr.Descripcion,sc.Status_2,sc.Monto,sc.Fecha,dp.Cantidad,dp.Precio_Venta,pna.Nombre,pna.ApPaterno,pna.ApMaterno
from Solicitud_Compra sc inner join Detalle_Producto dp on sc.id_Compra=dp.id_Compra inner join
Producto pr on pr.idProducto=dp.idProducto inner join Usuario uo on uo.idUsuario=sc.idUsuario inner join
Persona pna on pna.idPersona=uo.idPersona
WHERE sc.Status_2=@STATUS_S
go

EXECUTE CONSULTA_SOLICITUD_SATATUS  'En proceso'





---------------------------------------------------------------------------------------------------------------------------------

----------------------------          PROCEDIMIENTOS PARA MONTOS                 -----------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------------------------------------------
-----------------          1.- procedimiento para ver 
----------------           a) el tipo de solicitud 
----------------           b) grupo al que pertenece el producto  (moviliario, computo, oficina ........)
------------------------------------------------------------------------------------------------------------------------

go
CREATE PROCEDURE CONSULTA_MONTO_GRUPO
@TIPOMONTO VARCHAR(40),@GRUPOPRODUCT VARCHAR(40)
as
set nocount on;

select sc.id_Compra,pr.Descripcion,pro.Nombre_RazonSocial,pr.Grupo,sc.Status_2,sc.Tipo,sc.Monto,sc.Fecha,dp.Cantidad,dp.Precio_Venta,pna.Nombre,pna.ApPaterno,pna.ApMaterno
from Solicitud_Compra sc inner join Detalle_Producto dp on sc.id_Compra=dp.id_Compra inner join
Producto pr on pr.idProducto=dp.idProducto inner join Usuario uo on uo.idUsuario=sc.idUsuario inner join
Persona pna on pna.idPersona=uo.idPersona inner join Detalle_Servicios dts on dts.id_Compra=sc.id_Compra inner join 
Servicios srv on srv.idServicios=dts.idServicios inner join Atiende atd on atd.idServicios=srv.idServicios inner join 
Proveedor pro on pro.idProveedor=atd.idProveedor inner join Suministra smt on smt.idProveedor=pro.idProveedor inner join
Producto on pr.idProducto=smt.idProducto
WHERE sc.Tipo=@TIPOMONTO AND pr.Grupo=@GRUPOPRODUCT
go

EXECUTE CONSULTA_MONTO_GRUPO 'NN','moviliario'




------------------------------------------------------------------------------------------------------------------------
-----------------          2.- procedimiento para ver 
----------------            se obtendran todos los montos de a cuerdo a un rango de fechas
------------------------------------------------------------------------------------------------------------------------

go
CREATE PROCEDURE CONSULTA_MONTO_FECHAS
@fechaInicio date,@fechaFin date
as
set nocount on;

select sc.id_Compra,pr.Descripcion,pro.Nombre_RazonSocial,pr.Grupo,sc.Status_2,sc.Tipo,sc.Monto,sc.Fecha,dp.Cantidad,dp.Precio_Venta,pna.Nombre,pna.ApPaterno,pna.ApMaterno
from Solicitud_Compra sc inner join Detalle_Producto dp on sc.id_Compra=dp.id_Compra inner join
Producto pr on pr.idProducto=dp.idProducto inner join Usuario uo on uo.idUsuario=sc.idUsuario inner join
Persona pna on pna.idPersona=uo.idPersona inner join Detalle_Servicios dts on dts.id_Compra=sc.id_Compra inner join 
Servicios srv on srv.idServicios=dts.idServicios inner join Atiende atd on atd.idServicios=srv.idServicios inner join 
Proveedor pro on pro.idProveedor=atd.idProveedor inner join Suministra smt on smt.idProveedor=pro.idProveedor inner join
Producto on pr.idProducto=smt.idProducto

WHERE sc.Fecha between @fechaInicio and @fechaFin
go

EXECUTE CONSULTA_MONTO_FECHAS '2014/01/01','2017/08/31'