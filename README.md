# CineManager — Sistema de Gestión de Películas

Proyecto académico para el **SENA** desarrollado con **Java Web + Maven**, desplegado en **Payara Server 7**.

## Tecnologías

- Java 21
- Jakarta EE 11 (Servlets, JSP)
- JDBC (MySQL Connector/J)
- MySQL 8.0
- Bootstrap 5
- Payara Server 7

## Arquitectura

Patrón **MVC** (Modelo - Vista - Controlador):

```
src/main/java
├── controlador/       Servlets (PeliculaServlet, GeneroServlet, DirectorServlet)
├── dao/               Acceso a datos con JDBC y PreparedStatement
├── modelo/            POJOs (Pelicula, Genero, Director)
└── util/              Conexión a base de datos

src/main/webapp
├── views/             JSP con Bootstrap 5
└── index.jsp          Redirección al listado de películas
```

## Base de datos

```sql
CREATE DATABASE cine;

CREATE TABLE genero (
    idGenero INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE director (
    idDirector INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL
);

CREATE TABLE pelicula (
    idPelicula INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    fechaEstreno DATE,
    duracion INT,
    clasificacion VARCHAR(10),
    idDirector INT,
    precio DECIMAL(10,2),
    idGenero INT,
    FOREIGN KEY (idDirector) REFERENCES director(idDirector),
    FOREIGN KEY (idGenero) REFERENCES genero(idGenero)
);
```

### Conexión

| Propiedad | Valor |
|-----------|-------|
| Host | 127.0.0.1 |
| Puerto | 3306 |
| Base de datos | cine |
| Usuario | root |
| Contraseña | (vacía) |

## Cómo ejecutar

1. Iniciar MySQL (servicio de Windows)
2. Abrir proyecto en NetBeans
3. Iniciar Payara Server desde NetBeans
4. Botón derecho sobre el proyecto → **Deploy**
5. Abrir `http://localhost:8080/GuiaJEE/`

## Funcionalidades

- CRUD completo de **Películas** (con selección de género y director desde la BD)
- CRUD completo de **Géneros**
- CRUD completo de **Directores**
- Listados con INNER JOIN para mostrar nombres en lugar de IDs
- Interfaz responsiva con Bootstrap 5
