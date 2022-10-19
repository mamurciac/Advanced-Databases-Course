# Taller 5: MongoDB (Parte 1, Manejo de Queries)
Usted hace parte de un equipo de análisis de datos para una empresa que realiza inteligencia de negocios. Se ha encargado el análisis de una base de datos de restaurantes de múltiples ciudades. Para ello, se solicitan una serie de consultas sobre la base de datos.

La estructura de los documentos de la base de datos es la siguiente:
```json
{
	"address": {
		"building": "1007",
		"coord": [-73.856077, 40.848447],
		"street": "Morris Park Ave",
		"zipcode": "10462"
	},
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

##Ejercicios
1. Descargar el archivo del siguiente enlace:  [https://www.dropbox.com/s/qnzyj8ht9gqm88w/data.json?dl=0](https://www.dropbox.com/s/qnzyj8ht9gqm88w/data.json?dl=0).
2. Crear la base de datos e ingresar los documentos del archivo en la misma (Es necesario averiguar cómo cargar un archivo JSON en MongoDB).
3. Implementar las siguientes consultas: 
	1. Todos los restaurantes de la base de datos.
	2. Todos los restaurantes: Únicamente los campos restaurant_id, name, cuisine.
	3. Todos los restaurantes: Únicamente los campos restaurant_id, name, zipcode y **sin _id**.
	4. Restaurantes en el borough "Manhattan".
	5. Restaurantes con score mayor que 90.
	6. Restaurantes con score mayor que 80 y menor que 90.
	7. Restaurantes ubicados en latitude menor a -95.754168.
	8. Restaurantes para los cuales cuisine es diferente de "American", tiene un grade de "A" y no pertenece al borough "Brooklyn".
	9. Restaurantes en los cuales el nombre comienza por la palabra "Wil". (Sugerencia: Usar expresión regular sobre el campo name).
	10. Restaurantes en los cuales la cuisine no es "American" NI "Chinese" o el name comienza por la palabra "Wil". (Sugerencia: Utilizar los operadores $or y $and).
	11. Restaurantes ordenados en ascendentemente por el name.
	12. Restaurantes para los cuales el address.street existe. (Sugerencia: Utilizar operador $exists).

## Entregable
Archivo de texto plano con todas las queries de creación de base de datos, carga de datos y consultas.

# Taller 5: MongoDB (Parte 2, Uso de Map - Reduce)
Continuando con la coleccion de restaurantess usada en el anterior taller, el siguiente ejemplo cuenta los restaurantes agrupados por zipcode usando Map - Reduce:

Cree la función map:
> var mapFunction = function() {
emit(this.address.zipcode, this.restaurant_id);
};
Cree la función reduce:
> var reduceFunction = function(zipcode, restaurants) {
return restaurants.length;
};
Ejecute el proceso map-reduce y guárdelo en la colección restaurants_count
> db.restaurants.mapReduce(
mapFunction,
reduceFunction,
{ out: "restaurants_count" }
)
Consulte la colección generada:
> show collections
> db.restaurants_count.find()

## Ejercicios
1. Cuente los restaurantes que están entre las latitudes -75, -74 y las longitudes 40 y 42
2. Calcule el promedio de los puntajes agrupados por zipcode
3. Liste restaurante top(de acuerdo a su score) de cada tipo de cuisine

Ejemplos de referencia: [https://docs.mongodb.com/manual/tutorial/map-reduce-examples/](https://docs.mongodb.com/manual/tutorial/map-reduce-examples/).
