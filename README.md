# Bases de Datos

<img src="https://www.hostname.cl/uploads/2020/11/BD.png" width="500px">

Creación de bases de datos, especificación de los tipos de datos, estructuras y restricciones de los datos a almacenarse; almacenamiento de los datos por el _DBMS_; consultas y actualizaciones; compartición de los datos. 


Uso del lenguaje <a href="https://es.wikipedia.org/wiki/SQL">SQL</a>, y del motor y gestor de bases de datos <a href="https://www.postgresql.org/">PostgreSQL</a>, basado completamente en <a href="https://es.wikipedia.org/wiki/%C3%81lgebra_relacional">***Álgebra relacional***</a>.

## Conceptos

**BASE DE DATOS:** Conjunto de información perteneciente a un mismo contexto/dominio, ordenada de forma sistemática para su posterior acceso, análisis y/o transmisión. Puede ser de sólo lectura (_estática_), o modificable y actualizable (_dinámica_).

**ENTIDAD:** En el dominio, hace referencia a un objeto exclusivo que cuenta con un conjunto de _atributos_. En SQL, sería cada tabla.

**ATRIBUTO:** Dato individual de una entidad/tabla (el dato de un código podría ser _123456_, un nombre _"Elon Musk"_).

**RELACIÓN:** Asociación entre dos entidades con un significado específico. 

**CAMPO:** Cada atributo de la tabla, refiriéndonos a su estructura (_códigoId_, _nombre_, etc...).

**DBMS:** Database Management System -> Sistema Gestor de Bases de Datos: Software de sistema para crear y administrar bases de datos, ofreciendo al usuario y al programador una forma sistemática de manejar los datos. En este caso, uso PostgreSQL como DBMS.

**DDL:** Data Definition Language -> Lenguaje de definición de datos: Lenguaje que nos permite definir las estructuras que almacenarán los datos, así como los procedimientos y las funciones que permitan consultarlos. Nos permite también modificar las estructuras y/o eliminarlas. **CREATE**-**ALTER**-**DROP**. 

**DML:** Data Manipulation Language -> Lenguaje de manipulación de datos: Lenguaje que nos permite realizar tareas de consulta sobre los datos. También podemos introducir nuevos datos y/o eliminarlos, sin afectar la estructura de cada tabla. **SELECT**-**INSERT**-**UPDATE**-**DELETE**.



