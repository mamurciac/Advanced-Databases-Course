# Taller 5: MongoDB (Parte 1)

Usted hace parte de un equipo de análisis de datos para una empresa que realiza inteligencia de negocios. Se ha encargado el análisis de una base de datos de restaurantes de múltiples ciudades. Para ello, se solicitan una serie de consultas sobre la base de datos.

La estructura de los documentos de la base de datos es la siguiente:
```
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
//Se selecciona la base de datos agenda (Si no existe, se crea esta nueva base de datos)
use agenda;

//Se eliminan todos los registros de la base de datos (No se elimina la base de datos, simplemente se eliminan todos sus documentos de esa base de datos y por lo tanto la base de datos consistira en un documento vacio)
db.agenda.deleteMany({});

//Se agregan registros a la base de datos agenda (Se agregan estos registros individualmente)
db.agenda.insertOne({_id: 1, name: "Juan", age: 18, gender: "male", contact: {address: "Fake Street 123", phone: "555 123"}});
db.agenda.insertOne({_id: 2, name: "María", age: 18, gender: "female", contact: {address: "Fake Street 123", phone: "555 987"}});

//Se agregan registros a la base de datos agenda (Se agregan multiples registros en un solo comando, esto se logra juntando los multiples registros en un arreglo)
db.agenda.insertMany([{_id: 3, name: "Pedro", age: 19, gender: "male", contact: {address: "Nowhere", phone: "555 444"}}, {_id: 4, name: "Ana", age: 20, gender: "female", contact: {address: "Timesquare", phone: "321 678"}}]);

//Consulta 1: Se muestran todos los documentos en la coleccion
db.agenda.find();

//Consulta 2: Se muestran los documentos cuyo nombre sea Juan, es decir, se seleccionan los documentos que cumplen con una condicion simple
db.agenda.find({name: "Juan"});

//Consulta 3: Se muestran los documentos cuya edad sea 18 o 19, es decir, se seleccionan los documentos que contengan alguno de los valores en una lista
db.agenda.find({age: {$in: [18, 19]}});

//Consulta 4: Se muestran los documentos cuya edad no sea 18 ni 19, es decir, se seleccionan los documentos que no contengan ninguno de los valores en una lista
db.agenda.find({age: {$nin: [18, 19]}});

//Consulta 5: Se muestran los documentos cuya edad sea 18 y cuyo genero sea male
db.agenda.find({age: 18, gender: "male"});

//Consulta 6: Se muestran los documentos cuya edad sea 18 o cuyo genero sea male, en este caso se usa el operador $or
db.agenda.find({$or: [{age: 18}, {gender: "male"}]});

//Consulta 7: Se muestran los documentos cuya direccion de contacto sea Fake Street 123 y ademas cuya edad sea 18 o cuyo genero sea male, en este caso se usa el operador $or
db.agenda.find({"contact.address": "Fake Street 123", $or: [{age: 18}, {gender: "male"}]});

//Consulta 8: Se muestran los documentos cuya direccion de contacto sea Fake Street 123 y su telefono de contacto sea 555 987, en este caso se seleccionan documentos sobre documentos embebidos
db.agenda.find({contact: {address: "Fake Street 123", phone: "555 987"}});

//Consulta 9: Se muestran los documentos cuya edad sea mayor a los 18 años, en este caso se usa el operador $gt (greater than) para definir el operador relacional mayor que
db.agenda.find({age : {$gt: 18}});

//Consulta 10: Se muestran los documentos cuya edad sea al menos los 18 años, en este caso se usa el operador $gte (greater than equal) para definir el operador relacional mayor o igual que
db.agenda.find({age : {$gte: 18}});

//Consulta 11: Se muestran los documentos cuya edad sea menor a los 20 años, en este caso se usa el operador $lt (lower than) para definir el operador relacional menor que
db.agenda.find({age : {$lt: 20}});

//Consulta 12: Se muestran los documentos cuya edad sea a lo sumo los 20 años, en este caso se usa el operador $lte (lower than equal) para definir el operador relacional menor o igual que
db.agenda.find({age : {$lte: 20}});

//Consulta 13: Se muestran los documentos cuya edad sea distinta a los 19 años, en este caso se usa el operador $ne (not equal) para definir el operador relacional distinto de
db.agenda.find({age : {$ne: 19}});

//Consulta 14: Se muestran los documentos cuya edad sea 18, y se obtienen solamente los campos name y gender de los documentos que cumplan la condicion dada
db.agenda.find({age: 18}, {name: 1, gender: 1, _id: 0});

//Actualizacion 1: Se va a actualizar el numero de contacto como Lost al primer documento encontrado que cumpla que el nombre sea Juan
db.agenda.find({name: "Juan"});
db.agenda.update({name: "Juan"}, {$set: {"contact.phone": "Lost"}});
db.agenda.find({name: "Juan"});

//Actualizacion 2: Se van a actualizar la edad a 21 años de todos los documentos encontrados que cumplan que la edad sea 18
db.agenda.find({age: 21});
db.agenda.updateMany({age: 18}, {$set: {age: 21}});
db.agenda.find({age: 21});

//Eliminacion 1: Se va a eliminar el primer documento de todos los documentos encontrados que cumplan que la edad sea 19
db.agenda.find({age: 19});
db.agenda.deleteOne({age: 19});
db.agenda.find({age: 19});

//Eliminacion 2: Se van a eliminar todos los documentos que cumplan que la edad sea 21
db.agenda.find({age: 21});
db.agenda.deleteMany({age: 21});
db.agenda.find({age: 21});

test> //Se selecciona la base de datos agenda (Si no existe, se crea esta nueva base de datos)

test> use agenda;
switched to db agenda
agenda> 

agenda> //Se eliminan todos los registros de la base de datos (No se elimina la base de datos, simplemente se eliminan todos sus documentos de esa base de datos y por lo tanto la base de datos consistira en un documento vacio)

agenda> db.agenda.deleteMany({});
{ acknowledged: true, deletedCount: 0 }
agenda> 

agenda> //Se agregan registros a la base de datos agenda (Se agregan estos registros individualmente)

agenda> db.agenda.insertOne({_id: 1, name: "Juan", age: 18, gender: "male", contcontact: {address: "Fake Street 123", phone: "555 123"}});
{ acknowledged: true, insertedId: 1 }
agenda> db.agenda.insertOne({_id: 2, name: "María", age: 18, gender: "female", ccontact: {address: "Fake Street 123", phone: "555 987"}});
{ acknowledged: true, insertedId: 2 }
agenda> 

agenda> //Se agregan registros a la base de datos agenda (Se agregan multiples registros en un solo comando, esto se logra juntando los multiples registros en un arreglo)

agenda> db.agenda.insertMany([{_id: 3, name: "Pedro", age: 19, gender: "male", contact: {address: "Nowhere", phone: "555 444"}}, {_id: 4, name: "Ana", age: 20, gender: "female", contact: {address: "Timesquare", phone: "321 678"}}]);
{ acknowledged: true, insertedIds: { '0': 3, '1': 4 } }
agenda> 

agenda> //Consulta 1: Se muestran todos los documentos en la coleccion

agenda> db.agenda.find();
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: '555 123' }
  },
  {
    _id: 2,
    name: 'María',
    age: 18,
    gender: 'female',
    contact: { address: 'Fake Street 123', phone: '555 987' }
  },
  {
    _id: 3,
    name: 'Pedro',
    age: 19,
    gender: 'male',
    contact: { address: 'Nowhere', phone: '555 444' }
  },
  {
    _id: 4,
    name: 'Ana',
    age: 20,
    gender: 'female',
    contact: { address: 'Timesquare', phone: '321 678' }
  }
]
agenda> 

agenda> //Consulta 2: Se muestran los documentos cuyo nombre sea Juan, es decir, se seleccionan los documentos que cumplen con una condicion simple

agenda> db.agenda.find({name: "Juan"});
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: '555 123' }
  }
]
agenda> 

agenda> //Consulta 3: Se muestran los documentos cuya edad sea 18 o 19, es decir, se seleccionan los documentos que contengan alguno de los valores en una lista 

agenda> db.agenda.find({age: {$in: [18, 19]}});
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: '555 123' }
  },
  {
    _id: 2,
    name: 'María',
    age: 18,
    gender: 'female',
    contact: { address: 'Fake Street 123', phone: '555 987' }
  },
  {
    _id: 3,
    name: 'Pedro',
    age: 19,
    gender: 'male',
    contact: { address: 'Nowhere', phone: '555 444' }
  }
]
agenda> 

agenda> //Consulta 4: Se muestran los documentos cuya edad no sea 18 ni 19, es decir, se seleccionan los documentos que no contengan ninguno de los valores en una lista

agenda> db.agenda.find({age: {$nin: [18, 19]}});
[
  {
    _id: 4,
    name: 'Ana',
    age: 20,
    gender: 'female',
    contact: { address: 'Timesquare', phone: '321 678' }
  }
]
agenda> 

agenda> //Consulta 5: Se muestran los documentos cuya edad sea 18 y cuyo genero sea male

agenda> db.agenda.find({age: 18, gender: "male"});
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: '555 123' }
  }
]
agenda> 

agenda> //Consulta 6: Se muestran los documentos cuya edad sea 18 o cuyo genero sea male, en este caso se usa el operador $or

agenda> db.agenda.find({$or: [{age: 18}, {gender: "male"}]});
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: '555 123' }
  },
  {
    _id: 2,
    name: 'María',
    age: 18,
    gender: 'female',
    contact: { address: 'Fake Street 123', phone: '555 987' }
  },
  {
    _id: 3,
    name: 'Pedro',
    age: 19,
    gender: 'male',
    contact: { address: 'Nowhere', phone: '555 444' }
  }
]
agenda> 

agenda> //Consulta 7: Se muestran los documentos cuya direccion de contacto sea Fake Street 123 y ademas cuya edad sea 18 o cuyo genero sea male, en este caso se usa el operador $or

agenda> db.agenda.find({"contact.address": "Fake Street 123", $or: [{age: 18}, {gender: "male"}]});
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: '555 123' }
  },
  {
    _id: 2,
    name: 'María',
    age: 18,
    gender: 'female',
    contact: { address: 'Fake Street 123', phone: '555 987' }
  }
]
agenda> 

agenda> //Consulta 8: Se muestran los documentos cuya direccion de contacto sea Fake Street 123 y su telefono de contacto sea 555 987, en este caso se seleccionan documentos sobre documentos embebidos

agenda> db.agenda.find({contact: {address: "Fake Street 123", phone: "555 987"}});
[
  {
    _id: 2,
    name: 'María',
    age: 18,
    gender: 'female',
    contact: { address: 'Fake Street 123', phone: '555 987' }
  }
]
agenda> 

agenda> //Consulta 9: Se muestran los documentos cuya edad sea mayor a los 18 años, en este caso se usa el operador $gt (greater than) para definir el operador relacional mayor que

agenda> db.agenda.find({age : {$gt: 18}});
[
  {
    _id: 3,
    name: 'Pedro',
    age: 19,
    gender: 'male',
    contact: { address: 'Nowhere', phone: '555 444' }
  },
  {
    _id: 4,
    name: 'Ana',
    age: 20,
    gender: 'female',
    contact: { address: 'Timesquare', phone: '321 678' }
  }
]
agenda> 

agenda> //Consulta 10: Se muestran los documentos cuya edad sea al menos los 18 años, en este caso se usa el operador $gte (greater than equal) para definir el operador relacional mayor o igual que

agenda> db.agenda.find({age : {$gte: 18}});
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: '555 123' }
  },
  {
    _id: 2,
    name: 'María',
    age: 18,
    gender: 'female',
    contact: { address: 'Fake Street 123', phone: '555 987' }
  },
  {
    _id: 3,
    name: 'Pedro',
    age: 19,
    gender: 'male',
    contact: { address: 'Nowhere', phone: '555 444' }
  },
  {
    _id: 4,
    name: 'Ana',
    age: 20,
    gender: 'female',
    contact: { address: 'Timesquare', phone: '321 678' }
  }
]
agenda> 

agenda> //Consulta 11: Se muestran los documentos cuya edad sea menor a los 20 años, en este caso se usa el operador $lt (lower than) para definir el operador relacional menor que

agenda> db.agenda.find({age : {$lt: 20}});
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: '555 123' }
  },
  {
    _id: 2,
    name: 'María',
    age: 18,
    gender: 'female',
    contact: { address: 'Fake Street 123', phone: '555 987' }
  },
  {
    _id: 3,
    name: 'Pedro',
    age: 19,
    gender: 'male',
    contact: { address: 'Nowhere', phone: '555 444' }
  }
]
agenda> 

agenda> //Consulta 12: Se muestran los documentos cuya edad sea a lo sumo los 20 años, en este caso se usa el operador $lte (lower than equal) para definir el operador relacional menor o igual que

agenda> db.agenda.find({age : {$lte: 20}});
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: '555 123' }
  },
  {
    _id: 2,
    name: 'María',
    age: 18,
    gender: 'female',
    contact: { address: 'Fake Street 123', phone: '555 987' }
  },
  {
    _id: 3,
    name: 'Pedro',
    age: 19,
    gender: 'male',
    contact: { address: 'Nowhere', phone: '555 444' }
  },
  {
    _id: 4,
    name: 'Ana',
    age: 20,
    gender: 'female',
    contact: { address: 'Timesquare', phone: '321 678' }
  }
]
agenda> 

agenda> //Consulta 13: Se muestran los documentos cuya edad sea distinta a los 19 años, en este caso se usa el operador $ne (not equal) para definir el operador relacional distinto de

agenda> db.agenda.find({age : {$ne: 19}});
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: '555 123' }
  },
  {
    _id: 2,
    name: 'María',
    age: 18,
    gender: 'female',
    contact: { address: 'Fake Street 123', phone: '555 987' }
  },
  {
    _id: 4,
    name: 'Ana',
    age: 20,
    gender: 'female',
    contact: { address: 'Timesquare', phone: '321 678' }
  }
]
agenda> 

agenda> //Consulta 14: Se muestran los documentos cuya edad sea 18, y se obtienen solamente los campos name y gender de los documentos que cumplan la condicion dada

agenda> db.agenda.find({age: 18}, {name: 1, gender: 1, _id: 0});
[
  { name: 'Juan', gender: 'male' },
  { name: 'María', gender: 'female' }
]
agenda> 

agenda> //Actualizacion 1: Se va a actualizar el numero de contacto como Lost al primer documento encontrado que cumpla que el nombre sea Juan

agenda> db.agenda.find({name: "Juan"});
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: '555 123' }
  }
]
agenda> db.agenda.update({name: "Juan"}, {$set: {"contact.phone": "Lost"}});
DeprecationWarning: Collection.update() is deprecated. Use updateOne, updateMany, or bulkWrite.
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}
agenda> db.agenda.find({name: "Juan"});
[
  {
    _id: 1,
    name: 'Juan',
    age: 18,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: 'Lost' }
  }
]
agenda> 

agenda> //Actualizacion 2: Se van a actualizar la edad a 21 años de todos los documentos encontrados que cumplan que la edad sea 18

agenda> db.agenda.find({age: 21});

agenda> db.agenda.updateMany({age: 18}, {$set: {age: 21}});
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 2,
  modifiedCount: 2,
  upsertedCount: 0
}
agenda> db.agenda.find({age: 21});
[
  {
    _id: 1,
    name: 'Juan',
    age: 21,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: 'Lost' }
  },
  {
    _id: 2,
    name: 'María',
    age: 21,
    gender: 'female',
    contact: { address: 'Fake Street 123', phone: '555 987' }
  }
]
agenda> 

agenda> //Eliminacion 1: Se va a eliminar el primer documento de todos los documentos encontrados que cumplan que la edad sea 19

agenda> db.agenda.find({age: 19});
[
  {
    _id: 3,
    name: 'Pedro',
    age: 19,
    gender: 'male',
    contact: { address: 'Nowhere', phone: '555 444' }
  }
]
agenda> db.agenda.deleteOne({age: 19});
{ acknowledged: true, deletedCount: 1 }
agenda> db.agenda.find({age: 19});

agenda> 

agenda> //Eliminacion 2: Se van a eliminar todos los documentos que cumplan que la edad sea 21

agenda> db.agenda.find({age: 21});
[
  {
    _id: 1,
    name: 'Juan',
    age: 21,
    gender: 'male',
    contact: { address: 'Fake Street 123', phone: 'Lost' }
  },
  {
    _id: 2,
    name: 'María',
    age: 21,
    gender: 'female',
    contact: { address: 'Fake Street 123', phone: '555 987' }
  }
]
agenda> db.agenda.deleteMany({age: 21});
{ acknowledged: true, deletedCount: 2 }
agenda> db.agenda.find({age: 21});


```
