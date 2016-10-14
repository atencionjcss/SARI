
USE SARI
 
 CREATE TABLE Persona (
  idPersona INT IDENTITY(1,1)NOT NULL ,
  RFC VARCHAR(20) NULL,
  Curp VARCHAR(20) NULL,
  Nombre VARCHAR(20) NULL,
  ApPaterno VARCHAR(20) NULL,
  ApMaterno VARCHAR(20) NULL,
  Genero VARCHAR(20) NULL,
  Estado_civil VARCHAR(20) NULL,
  FechaNacimiento DATE NULL,
  Estatus VARCHAR(20) NULL,
  PRIMARY KEY(idPersona)
);

CREATE TABLE Privilegio (
  IdPrivilegio INT IDENTITY(1,1)NOT NULL,
  TipoPrivilegio VARCHAR(20) NULL,
  statusPrivilegio INT NULL,
  PRIMARY KEY(IdPrivilegio)
);

CREATE TABLE Direccion (
  idDireccion INT IDENTITY(1,1)NOT NULL,
  Pais VARCHAR(20) NULL,
  Estado VARCHAR(20) NULL,
  Calle VARCHAR(20) NULL,
  Colonia VARCHAR(30) NULL,
  NumInterior VARCHAR(10) NULL,
  NumExterior INT NULL,
  CodigoPostal INT NULL,
  Tipo_domicilio VARCHAR(50) NULL,
  PRIMARY KEY(idDireccion)
);

CREATE TABLE Jornada (
  idJornada INT IDENTITY(1,1)NOT NULL ,
  Turno VARCHAR(20) NULL,
  Tipo VARCHAR(20) NULL,
  Dia_Semana VARCHAR(20) NULL,
  HoraEntrada TIME NULL,
  HoraSalida TIME NULL,
  PRIMARY KEY(idJornada)
);

CREATE TABLE Servicios (
  idServicios INT IDENTITY(1,1)NOT NULL ,
  Precio Float NULL,
  Nombre VARCHAR(20) NULL,
  Identificador INT NULL,
  Descripcion VARCHAR(30) NULL,
  PRIMARY KEY(idServicios)
);

CREATE TABLE Telefono (
  idTelefono INT IDENTITY(1,1)NOT NULL,
  Numero BigInt NULL,
  Tipo VARCHAR(20) NULL,
  PRIMARY KEY(idTelefono)
);

CREATE TABLE Producto (
  idProducto INT IDENTITY(1,1)NOT NULL,
  Modelo VARCHAR(20) NULL,
  Marca VARCHAR(20) NULL,
  Descripcion VARCHAR(30) NULL,
  Fecha DATE NULL,
  Grupo VARCHAR(10) NULL,
  UnidadMedida VARCHAR (20)NULL,  --------------------  CAMBIO A VARCHAR LOS TIPOS PUEDEN SER (KG,METRO,PIEZAS, UNIDADES,UNIDAD)
  CantidadMedida FLOAT NULL,
  PrecioCompra FLOAT NULL,
  Stock VARCHAR(40) NULL,                ------------Tipo de inmueble 
  PRIMARY KEY(idProducto)
);

CREATE TABLE Proveedor (
  idProveedor INT IDENTITY(1,1)NOT NULL,
  Nombre_RazonSocial VARCHAR(30) NULL,
  Email VARCHAR(20) NULL,
  PRIMARY KEY(idProveedor)
);

CREATE TABLE Candidatos (
  idCandidatos INT IDENTITY(1,1)NOT NULL,
  idPersona INT NOT NULL,
  Email VARCHAR(20) NULL,                             -----------------Se eliminaron las calificaciones y se pasaron a la tabla test 
  No_IMSS BigInt NULL,
  PRIMARY KEY(idCandidatos),
  FOREIGN KEY(idPersona)
    REFERENCES Persona(idPersona)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Referencias (
  idReferencias INT IDENTITY(1,1)NOT NULL,
  idCandidatos INT NOT NULL,
  NombreReferen VARCHAR(20) NULL,
  DireccionReferen VARCHAR(70) NULL,
  OcupacionReferen VARCHAR(20) NULL,
  TelefonoReferen BigInt NULL,
  PRIMARY KEY(idReferencias),
  FOREIGN KEY(idCandidatos)
    REFERENCES Candidatos(idCandidatos)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Mas_Informacion (
  idMasInformacion INT IDENTITY(1,1)NOT NULL,
  idCandidatos INT NOT NULL,
  Herramientas_Oficina VARCHAR(20) NULL,
  Herra_Info VARCHAR(20) NULL,
  Cursos VARCHAR(20) NULL,
  ConocimientosTecn VARCHAR(20) NULL,
  ConocimientosFinanci VARCHAR(20) NULL,
  PRIMARY KEY(idMasInformacion),
  FOREIGN KEY(idCandidatos)
    REFERENCES Candidatos(idCandidatos)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);


CREATE TABLE PreferenciasLaborales (
  idPreferenciasLaborales INT IDENTITY(1,1)NOT NULL,
  idCandidatos INT NOT NULL,
  Turno VARCHAR(20) NULL,
  Area VARCHAR (20) NULL,               -------------  SE REFIERE A UAN AREA DETERMINADA DE TRABAJO SISTEMAS RH CONTADURIA ....
  Puesto VARCHAR(20) NULL,
  Sueldo FLOAT NULL,
  Objetivo VARCHAR(50) NULL,
  Extra VARCHAR(60) NULL,
  PRIMARY KEY(idPreferenciasLaborales),
  FOREIGN KEY(idCandidatos)
    REFERENCES Candidatos(idCandidatos)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Hiistorial_Laboral (
  idHiistorial_Laboral INT IDENTITY(1,1)NOT NULL,
  idCandidatos INT NOT NULL,
  Empresa VARCHAR(20) NULL,
  Fecha_Inicio DATE NULL,
  Fecha_Fin DATE NULL,
  Area VARCHAR(20) NULL,
  Puesto VARCHAR(20) NULL,
  Industri VARCHAR(20) NULL,
  Sueldo FLOAT NULL,
  Motivo_Salida VARCHAR(50) NULL,
  Jefe_Imediato VARCHAR(20) NULL,
  Puesto_Jefe VARCHAR(20) NULL,
  Telefono_Jefe BigInt NULL,
  Contacto INT NULL,
  Comentarios VARCHAR(50) NULL,
  PRIMARY KEY(idHiistorial_Laboral),
  FOREIGN KEY(idCandidatos)
    REFERENCES Candidatos(idCandidatos)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Empleado (
  idEmpleado INT IDENTITY(1,1)NOT NULL,
  idPersona INT NOT NULL,
  Area VARCHAR(20) NULL,
  Puesto VARCHAR(20) NULL,
  Foto VARCHAR(150),
  PRIMARY KEY(idEmpleado),
  FOREIGN KEY(idPersona)
    REFERENCES Persona(idPersona)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Entradas (
  idEntrada INT IDENTITY(1,1)NOT NULL ,
  idEmpleado INT NOT NULL,
  Descripcion VARCHAR(60) NULL,
  Total FLOAT NULL,
  Fecha DATE NULL,
  Hora TIME NULL,
  PRIMARY KEY(idEntrada),
  FOREIGN KEY(idEmpleado)
    REFERENCES Empleado(idEmpleado)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Estudios (
  idEstudios INT IDENTITY(1,1)NOT NULL ,
  idCandidatos INT NOT NULL,
  Nivel_Estudios VARCHAR(20) NULL,
  Pais VARCHAR(20) NULL,
  Institucion VARCHAR(80) NULL,
  Area VARCHAR(20) NULL,
  Titulo VARCHAR(100) NULL,
  Fecha_Inicio DATE NULL,
  Fecha_Terminos DATE NULL,
  Promedio FLOAT NULL,
  PRIMARY KEY(idEstudios),
  FOREIGN KEY(idCandidatos)
    REFERENCES Candidatos(idCandidatos)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Idioma (
  idIdioma INT IDENTITY(1,1)NOT NULL ,
  idCandidatos INT NOT NULL,
  Nombre VARCHAR(20) NULL,
  nivel VARCHAR(50),
  Descripcion VARCHAR(30) NULL,
  PRIMARY KEY(idIdioma),
  FOREIGN KEY(idCandidatos)
    REFERENCES Candidatos(idCandidatos)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE DetalleEntrada (
  idDetalleEntrada INT IDENTITY(1,1)NOT NULL,
  idEntrada INT NOT NULL,
  idProducto INT NOT NULL,
  No_Articulo INT NULL,
  PRIMARY KEY(idDetalleEntrada),
  FOREIGN KEY(idProducto)
    REFERENCES Producto(idProducto)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idEntrada)
    REFERENCES Entradas(idEntrada)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Suministra (
  idProducto INT NOT NULL,
  idProveedor INT NOT NULL,                        -----------------Se elimino el idSuministra, no tenia que estar uno ahi 
  PRIMARY KEY(idProducto, idProveedor),
  FOREIGN KEY(idProducto)
    REFERENCES Producto(idProducto)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idProveedor)
    REFERENCES Proveedor(idProveedor)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Atiende (
  idServicios INT NOT NULL,
  idProveedor INT NOT NULL,
  PRIMARY KEY(idServicios,idProveedor),
  FOREIGN KEY(idServicios)
    REFERENCES Servicios(idServicios)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idProveedor)
    REFERENCES Proveedor(idProveedor)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Contactos (
  idPersona INT NOT NULL,
  idTelefono INT NOT NULL,
  PRIMARY KEY(idPersona,idTelefono),
  FOREIGN KEY(idPersona)
    REFERENCES Persona(idPersona)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idTelefono)
    REFERENCES Telefono(idTelefono)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Cuenta (
  idProveedor INT NOT NULL,
  idDireccion INT NOT NULL,
  PRIMARY KEY(idProveedor, idDireccion),
  FOREIGN KEY(idProveedor)
    REFERENCES Proveedor(idProveedor)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idDireccion)
    REFERENCES Direccion(idDireccion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Requiere_de (
  idPersona INT NOT NULL,
  idDireccion INT NOT NULL,
  PRIMARY KEY(idPersona,idDireccion),
  FOREIGN KEY(idPersona)
    REFERENCES Persona(idPersona)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idDireccion)
    REFERENCES Direccion(idDireccion)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Proveedor_Telefono (
  idProveedor INT NOT NULL,
  idTelefono INT NOT NULL,
  PRIMARY KEY(idProveedor,idTelefono),
  FOREIGN KEY(idProveedor)
    REFERENCES Proveedor(idProveedor)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idTelefono)
    REFERENCES Telefono(idTelefono)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Asiste (
  idEmpleado INT NOT NULL,
  idJornada INT NOT NULL,
  PRIMARY KEY(idEmpleado,idJornada),
  FOREIGN KEY(idEmpleado)
    REFERENCES Empleado(idEmpleado)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idJornada)
    REFERENCES Jornada(idJornada)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Academico (
  idAcademico INT IDENTITY(1,1)NOT NULL,
  idEmpleado INT NOT NULL,
  TituloObtenido VARCHAR(200) NULL,                        ------------Se cambio su longuitud
  Inicio DATE NULL,
  Fin DATE NULL,
  Institucion VARCHAR(100) NULL,                             ------ Este igual
  PRIMARY KEY(idAcademico),
  FOREIGN KEY(idEmpleado)
    REFERENCES Empleado(idEmpleado)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Usuario (
  idUsuario INT IDENTITY(1,1)NOT NULL,
  idPersona INT NOT NULL,
  CorreoInicio VARCHAR(50) NULL,                -------------Se cambio nombre y longuitud
  Password1 VARCHAR(20) NULL,                       ----------------igual este
  PRIMARY KEY(idUsuario),
  FOREIGN KEY(idPersona)
    REFERENCES Persona(idPersona)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Solicitud_Compra (
  id_Compra INT IDENTITY(1,1)NOT NULL,
  idUsuario INT NOT NULL,
  Caracteristicas VARCHAR(20) NULL,
  Tipo VARCHAR(20) NULL,
  Fecha DATE NULL,
  Monto FLOAT NULL,
  Status_2 VARCHAR(20) NULL,
  PRIMARY KEY(id_Compra),
  FOREIGN KEY(idUsuario)
    REFERENCES Usuario(idUsuario)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Salida (
  idSalida INT IDENTITY(1,1)NOT NULL ,
  idEmpleado INT NOT NULL,
  Descripcion VARCHAR(30) NULL,
  Fecha DATE NULL,
  Hora TIME NULL,
  PRIMARY KEY(idSalida),
  FOREIGN KEY(idEmpleado)
    REFERENCES Empleado(idEmpleado)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Test(
	idTest INT IDENTITY(1,1)NOT NULL,                     -------------Se eliminaron las tablas de las preguntas y esta tabla esta en su lugar
	idUsuario INT NOT NULL,
	HS INT NULL,                   --------------Datos que se valoran
	CDRH INT NULL,
	CEPI INT NULL,
	HERI INT NULL,
	SCTRI INT NULL,
	PersonalidadEmpuje VARCHAR(50) NULL,              -------------Estos tres ultimos son del test los tipos de personalidad
	PersonalidadOficina VARCHAR(50) NULL,
	Departamento VARCHAR(50) NULL,
	PRIMARY KEY(idTest),
	FOREIGN KEY(idUsuario)
		REFERENCES Usuario(idUsuario)
		  ON DELETE NO ACTION
		  ON UPDATE NO ACTION
);

CREATE TABLE Area (
  idArea INT IDENTITY(1,1)NOT NULL ,
  idEmpleado INT NOT NULL,
  Telefono BigInt NULL,
  Area VARCHAR(20) NULL,
  Descripcion VARCHAR(30) NULL,
  Caracteristicas VARCHAR(30) NULL,
  PRIMARY KEY(idArea),
  FOREIGN KEY(idEmpleado)
    REFERENCES Empleado(idEmpleado)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Habilidad (
  idHabilidad INT IDENTITY(1,1)NOT NULL,
  idEmpleado INT NOT NULL,
  Descripcion VARCHAR(30) NULL,
  Tipo VARCHAR(30) NULL,
  PRIMARY KEY(idHabilidad),
  FOREIGN KEY(idEmpleado)
    REFERENCES Empleado(idEmpleado)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Detalle_Producto (
  idDetalle_Producto INT IDENTITY(1,1)NOT NULL,
  id_Compra INT NOT NULL,
  idProducto INT NOT NULL,
  Cantidad INT NULL,
  Precio_Venta FLOAT NULL,
  PRIMARY KEY(idDetalle_Producto),
  FOREIGN KEY(idProducto)
    REFERENCES Producto(idProducto)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(id_Compra)
    REFERENCES Solicitud_Compra(id_Compra)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE DetalleSalida (
  idDetalleSalida INT IDENTITY(1,1)NOT NULL,
  idSalida INT NOT NULL,
  idProducto INT NOT NULL,
  No_Articulos INT NULL,
  PRIMARY KEY(idDetalleSalida),
  FOREIGN KEY(idProducto)
    REFERENCES Producto(idProducto)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idSalida)
    REFERENCES Salida(idSalida)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Detalle_Servicios (
  id_Compra INT NOT NULL,
  idServicios INT NOT NULL,
  PRIMARY KEY(id_Compra,idServicios),
  FOREIGN KEY(id_Compra)
    REFERENCES Solicitud_Compra(id_Compra)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idServicios)
    REFERENCES Servicios(idServicios)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Proporcionan (
  idUsuario INT NOT NULL,
  IdPrivilegio INT NOT NULL,
  PRIMARY KEY(idUsuario, IdPrivilegio),
  FOREIGN KEY(idUsuario)
    REFERENCES Usuario(idUsuario)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(IdPrivilegio)
    REFERENCES Privilegio(IdPrivilegio)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);



