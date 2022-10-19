#Taller 5: MongoDB (Parte 1)

Usted hace parte de un equipo de análisis de datos para una empresa que realiza inteligencia de negocios. Se ha encargado el análisis de una base de datos de restaurantes de múltiples ciudades. Para ello, se solicitan una serie de consultas sobre la base de datos.

La estructura de los documentos de la base de datos es la siguiente:
```
{  
	"address":{  
		"building":"1007",
		"coord":[  
		-73.856077,
		40.848447
    ],
    "street":"Morris Park Ave",
    "zipcode":"10462"
  },
  "borough":"Bronx",
  "cuisine":"Bakery",
  "grades":[  
    {  
      "date":{  
        "$date":1393804800000
      },
      "grade":"A",
      "score":2
    },
    {  
      "date":{  
        "$date":1378857600000
      },
      "grade":"A",
      "score":6
    },
    {  
      "date":{  
        "$date":1358985600000
      },
      "grade":"A",
      "score":10
    },
    {  
      "date":{  
        "$date":1322006400000
      },
      "grade":"A",
      "score":9
    },
    {  
      "date":{  
        "$date":1299715200000
      },
      "grade":"B",
      "score":14
    }
  ],
  "name":"Morris Park Bake Shop",
  "restaurant_id":"30075445"
}
```

1. Descargar los documentos del siguiente enlace: [data.json](https://www.dropbox.com/s/qnzyj8ht9gqm88w/data.json?dl=0).
2. Crear la base de datos e ingresar los documentos del archivo en la misma (Es necesario averiguar cómo cargar un archivo JSON en MongoDB).
3. Implementar las siguientes consultas:
	a) Todos los restaurantes de la base de datos.
	b) Todos los restaurantes: únicamente los campos restaurant_id, name, cuisine.
	c) Todos los restaurantes: únicamente los campos restaurant_id, name, zipcode y SIN _id.
	d) Restaurante en el borough “Manhattan”.
	e) Restaurantes con score mayor que 90.
	f) Restaurante con score mayor que 80 y menor que 90.
	g) Restaurantes ubicados en latitude menor a -95.754168.
	h) Restaurantes para los cuales cuisine es diferente de “American”, tiene un grade de “A” y no pertenece al borough “Brooklyn”.
	i) Restaurantes en los cuales el nombre comienza por la palabra “Wil”. (Hint: usar expresión regular sobre el campo name).
	j) Restaurantes en los cuales la cuisine NO es “American” NI “Chinese” O el name comienza por la palabra “Wil”. (Hint: utilizar los operadores $or y $and).
	k) Restaurantes ordenados en ascendentemente por el name.
	l) Restaurantes para los cuales el address.street existe. (Hint: utilizar operador $exists).

##Entregable
Archivo de texto plano con todas las queries de creación de base de datos, carga de datos y consultas.

# 1. Proyecto sobre Ventas de Videojuegos

## Enlace de Demostración:  
[https://app.powerbi.com/view?r=eyJrIjoiNGJlNDI5ZjAtZjFkYy00MzkzLTkzZGItOGJlY2ZkNWM2ZWE5IiwidCI6IjU3N2ZjMWQ4LTA5MjItNDU4ZS04N2JmLWVjNGY0NTVlYjYwMCIsImMiOjR9](https://app.powerbi.com/view?r=eyJrIjoiNGJlNDI5ZjAtZjFkYy00MzkzLTkzZGItOGJlY2ZkNWM2ZWE5IiwidCI6IjU3N2ZjMWQ4LTA5MjItNDU4ZS04N2JmLWVjNGY0NTVlYjYwMCIsImMiOjR9)

## Objetivo
Desarrollar un reporte interactivo que permita analizar las **ventas** de millones de copias de videojuegos a nivel global.

Se requiere poder analizar las ventas a nivel de:
- Año
- Región
- Plataforma
- Género
- Editorial

## Información de Partida
Se proporciona un archivo de Excel llamado **VentasVideojuegos.xlsx**, el cual cuenta con la siguiente estructura:
- **Nombre:** Nombre del videojuego.
- **Plataforma:** Plataforma en la cual el videojuego está disponible.
- **Año:** Año de lanzamiento del videojuego.
- **Editorial:** Editorial del videojuego.
- **Ventas NA:** Ventas (en millones) reportadas en Norteamérica.
- **Ventas EU:** Ventas (en millones) reportadas en Europa.
- **Ventas JP:** Ventas (en millones) reportadas en Japón.
- **Ventas Otros:** Ventas (en millones) reportadas en otras regiones.
- **Ventas Global:** Ventas (en millones) reportadas en todas las regiones.

## Modelamiento Dimensional:
El siguiente modelo ER indica las relaciones entre hechos y dimensiones, además de la estructura de la información como se busca tenerla para analizarla según los objetivos:
![Modelo ER](https://github.com/mamurciac/Udemy-s-Power-BI-Course/blob/master/1.%20Proyecto%20Ventas%20Videojuegos/Modelo%20ER.png)

## Mapa de Transformaciones de Datos (Versión del Video):
- **Encabezados promovidos:** Se usa la primera fila como encabezado.
- **Tipo cambiado:** Se cambian los tipos de datos de las columnas necesarias a un tipo de dato adecuado según su naturaleza.
- **Columnas quitadas:** Se elimina la columna Ventas Global.
- **Columna de anulación de dinamización:** Se aplica anulación de dinamización de columnas a las columnas Ventas NA, Ventas EU, Ventas JP y Ventas Otros.
- **Columnas con nombre cambiado:** Se renombran las columnas Genero por Género, Atributo por Región y Valor por Ventas (Millones).
- **Valor reemplazado:** En la columna Región se reemplaza el valor "Ventas NA" por "Norteamérica".
- **Valor reemplazado:** En la columna Región se reemplaza el valor "Ventas EU" por "Europa".
- **Valor reemplazado:** En la columna Región se reemplaza el valor "Ventas JP" por "Japón".
- **Valor reemplazado:** En la columna Región se reemplaza el valor "Ventas Otros" por "Otros".

## Mapa de Transformaciones de Datos (Versión Optimizada):
- **Encabezados promovidos:** Se usa la primera fila como encabezado.
- **Tipo cambiado:** Se cambian los tipos de datos de las columnas necesarias a un tipo de dato adecuado según su naturaleza.
- **Columnas quitadas:** Se elimina la columna Ventas Global.
- **Columna de anulación de dinamización:** Se aplica anulación de dinamización de columnas a las columnas Ventas NA, Ventas EU, Ventas JP y Ventas Otros.
- **Columnas con nombre cambiado:** Se renombran las columnas Genero por Género y Valor por Ventas (Millones).
- **Columna condicional agregada:** Se llama Región, y se tienen las siguientes condiciones:
	- Si Atributo = "Ventas NA", su nuevo valor es "Norteamérica".
	- Si Atributo = "Ventas EU", su nuevo valor es "Europa".
	- Si Atributo = "Ventas JP", su nuevo valor es "Japón".
	- Si Atributo = "Ventas Otros", su nuevo valor es "Otros".
- **Columnas quitadas:** Se elimina la columna Atributo.
- **Columnas reordenadas:** Se reordenan las columnas necesarias.

## Vista previa del Mapa de Transformaciones:
![Mapa de Transformaciones](https://github.com/mamurciac/Udemy-s-Power-BI-Course/blob/master/1.%20Proyecto%20Ventas%20Videojuegos/Transformaci%C3%B3n%20de%20Datos%20%5BPower%20Query%5D.jpg)

## Modelo de Tablas:
Se verifica la traducción del modelo ER en el modelo relacional o modelo de tablas:
![Modelo Relacional](https://github.com/mamurciac/Udemy-s-Power-BI-Course/blob/master/1.%20Proyecto%20Ventas%20Videojuegos/Modelo%20Relacional.JPG)
