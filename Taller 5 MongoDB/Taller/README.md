# Taller 5: MongoDB (Parte 1)

Usted hace parte de un equipo de análisis de datos para una empresa que realiza inteligencia de negocios. Se ha encargado el análisis de una base de datos de restaurantes de múltiples ciudades. Para ello, se solicitan una serie de consultas sobre la base de datos.

La estructura de los documentos de la base de datos es la siguiente:
```
{
	"address": {"building": "1007", "coord": [-73.856077, 40.848447], "street": "Morris Park Ave", "zipcode": "10462"},
	"borough": "Bronx",
	"cuisine": "Bakery",
	"grades": [{
		"date": {
			"$date": 1393804800000
		},
		"grade": "A",
		"score": 2
		}, {
		"date": {
			"$date": 1378857600000
		},
		"grade": "A",
		"score": 6
		}, {
		"date": {
			"$date": 1358985600000
		},
		"grade": "A",
		"score": 10
		}, {
		"date": {
			"$date": 1322006400000
		},
		"grade": "A",
		"score": 9
		}, {
		"date": {
			"$date": 1299715200000
		},
		"grade": "B",
		"score": 14
	}],
	"name": "Morris Park Bake Shop",
	"restaurant_id": "30075445"
}
```

1. Descargar el archivo del siguiente enlace:  [https: //www.dropbox.com/s/qnzyj8ht9gqm88w/data.json?dl=0](https: //www.dropbox.com/s/qnzyj8ht9gqm88w/data.json?dl=0).
2. Crear la base de datos e ingresar los documentos del archivo en la misma (Es necesario averiguar cómo cargar un archivo JSON en MongoDB).
3. Implementar las siguientes consultas: 
	1. Todos los restaurantes de la base de datos.
	2. Todos los restaurantes:  únicamente los campos restaurant_id, name, cuisine.
	3. Todos los restaurantes:  únicamente los campos restaurant_id, name, zipcode y SIN _id.
	4. Restaurante en el borough “Manhattan”.
	5. Restaurantes con score mayor que 90.
	6. Restaurante con score mayor que 80 y menor que 90.
	7. Restaurantes ubicados en latitude menor a -95.754168.
	8. Restaurantes para los cuales cuisine es diferente de “American”, tiene un grade de “A” y no pertenece al borough “Brooklyn”.
	9. Restaurantes en los cuales el nombre comienza por la palabra “Wil”. (Hint:  usar expresión regular sobre el campo name).
	10. Restaurantes en los cuales la cuisine NO es “American” NI “Chinese” O el name comienza por la palabra “Wil”. (Hint:  utilizar los operadores $or y $and).
	11. Restaurantes ordenados en ascendentemente por el name.
	12. Restaurantes para los cuales el address.street existe. (Hint:  utilizar operador $exists).

## Entregable
Archivo de texto plano con todas las queries de creación de base de datos, carga de datos y consultas.

```

//En los siguientes pasos se realiza la verificacion de la importacion del archivo data.json a la coleccion restaurants de la base de datos dbRestaurants
//Se muestran las bases de datos almacenadas (Se indica el nombre de cada base de datos junto a su espacio de memoria usado para su almacenamiento)
show dbs;

//Se selecciona la base de datos dbRestaurants (Si no existe, se crea esta nueva base de datos)
use dbRestaurants;

//Se muestran las colecciones de documentos almacenadas en la base de datos actual (en este caso la base de datos seleccionada es dbRestaurants)
show collections;

//Se cuenta del numero de documentos registrados en la coleccion de restaurantes (En bases de datos relacionales se asimila al numero de registros (conteo de filas) de una tabla dada)
db.restaurants.countDocuments();

//En los siguientes pasos se indica la solucion del Taller de MongoDB (Primera parte)
//Consulta 1: Se muestran todos los restaurantes
db.restaurants.find();

//Consulta 2: Se muestran todos los restaurantes pero proyectando solo las claves/campos id del restaurante, nombre y especialidad
db.restaurants.find({}, {restaurant_id: 1, name: 1, cuisine: 1});

//Consulta 3: Se muestran todos los restaurantes pero proyectando solo las claves/campos id del restaurante, nombre y address.zipcode (esta ultima es una clave dentro de un documento embedido), y en este caso sin la clave _id
db.restaurants.find({}, {restaurant_id: 1, name: 1, "address.zipcode": 1, _id: 0});

//Consulta 4: Se muestran los restaurantes ubicados en la ciudad de Manhattan, pero proyectando solo las claves/campos id del restaurante, nombre y ciudad, y en este caso sin la clave _id
db.restaurants.find({borough: "Manhattan"}, {restaurant_id: 1, name: 1, borough: 1, _id: 0});

//Consulta 5: Se muestran los restaurantes que tengan al menos un puntaje mayor a 90 (En la clave grades, su valor es un arreglo de documentos en el cual está presente la subclave score), pero proyectando solo las claves/campos id del restaurante, nombre y listado de puntajes, y en este caso sin la clave _id
db.restaurants.find({"grades.score": {$gt: 90}}, {restaurant_id: 1, name: 1, "grades.score": 1, _id: 0});

//Consulta 6: Se muestran los restaurantes que tengan al menos un puntaje mayor a 80 y menor a 90 (En la clave grades, su valor es un arreglo de documentos en el cual está presente la subclave score), pero proyectando solo las claves/campos id del restaurante, nombre y listado de puntajes, y en este caso sin la clave _id
db.restaurants.find({"grades.score": {$gt: 80, $lt: 90}}, {restaurant_id: 1, name: 1, "grades.score": 1, _id: 0});

//Consulta 7: Se muestran los restaurantes ubicados en latitud menor a -95.754168 (En la clave address, su valor es un documento cuya subclave coord tiene como valor un arreglo, en este caso se debe tener en cuenta el orden de los valores (Posicion 0: Latitud, Posicion 1: Longitud)), pero proyectando solo las claves/campos id del restaurante, nombre y ubicacion de coordenadas, y en este caso sin la clave _id
db.restaurants.find({"address.coord.0": {$lt: -95.754168}}, {restaurant_id: 1, name: 1, "address.coord": 1, _id: 0});

//Consulta 8: Se muestran los restaurantes de especialidad distinta a la cocina americana, tienen alguna calificacion de valor A y no estan en la ciudad de Brooklyn, pero proyectando solo las claves/campos id del restaurante, nombre, especialidad, calificaciones y ciudad, y en este caso sin la clave _id
db.restaurants.find({cuisine: {$ne: "American "}, "grades.grade": "A", borough: {$ne: "Brooklyn"}}, {restaurant_id: 1, name: 1, cuisine: 1, "grades.grade": 1, borough: 1, _id: 0});

//Consulta 9: Se muestran los restaurantes cuyo nombre empieza por Wil, pero proyectando solo las claves/campos id del restaurante y nombre, y en este caso sin la clave _id
db.restaurants.find({name: {$regex: /^Wil.*/}}, {restaurant_id: 1, name: 1, _id: 0});

//Consulta 10: Se muestran los restaurantes cuya especialidad no sea cocina americana ni cocina china, o cuyo nombre empeza por Wil, en este caso, notese el uso de las proposiciones de la forma (!p AND !q) OR r <=> r OR (!p AND !q), para esto se usan los operadores $and y $or adecuadamente, pero proyectando solo las claves/campos id del restaurante, nombre y especialidad, y en este caso sin la clave _id
db.restaurants.find({$or: [{name: {$regex: /^Wil.*/}}, {$and: [{cuisine: {$ne: "American "}}, {cuisine: {$ne: "Chinese"}}]}]}, {restaurant_id: 1, name: 1, cuisine: 1, _id: 0});

//Consulta 11: Se muestran todos los restaurantes pero proyectando solo las claves/campos id del restaurante y nombre, en este caso sin la clave _id, con los documentos ordenados ascendentemente por la clave name
db.restaurants.find({}, {restaurant_id: 1, name: 1, _id: 0}).sort({name: 1});

//Consulta 12: Se muestran los restaurantes para los cuales existe la clave street en la clave address
db.restaurants.find({"address.street": {$exists: true}}, {restaurant_id: 1, name: 1, "address.street": 1, _id: 0});

//Consulta 13: Se muestran todos los restaurantes pero proyectando solo las claves/campos id del restaurante y nombre, en este caso sin la clave _id, con los documentos ordenados descendentemente por la clave name
db.restaurants.find({}, {restaurant_id: 1, name: 1, _id: 0}).sort({name: -1});


```
