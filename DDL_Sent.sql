-------------------------Sentencias DDL -----------------------

CREATE SCHEMA DeliPizza;

GO

CREATE DATABASE DeliPizza;

GO 

USE DeliPizza;

GO

CREATE TABLE Productos (
	id int IDENTITY(1,1) not null,
	tipo varchar(30) NOT NULL,
	nombre varchar(50) NOT NULL,
	precio decimal NOT NULL,	
	PRIMARY KEY (id)
);

GO 

CREATE TABLE Clientes (
	Id int  IDENTITY(1,1) NOT Null,
	Nombre varchar(50) NOT NULL,
	Apellido varchar(50) NOT NULL,
	Direccion varchar(255),	
	PRIMARY KEY (Id)
);

GO

CREATE TABLE Descuentos(
	id int IDENTITY(1,1) NOT NULL,
	descuento int NOT NULL,
	PRIMARY KEY (id),	
)

GO 

CREATE TABLE Compras (
	id int IDENTITY(1,1) NOT NULL,
	cliente int ,
	producto int NOT NULL,
	descuento int,
	PRIMARY KEY(id),
	FOREIGN KEY(cliente) REFERENCES Clientes(id),
	FOREIGN KEY(producto) REFERENCES Productos(id),
	FOREIGN KEY(descuento) REFERENCES Descuentos (id)
);

GO

EXEC sp_help Compras