#Carga de datos de restaurantes guardados en un archivo de texto plano data.json en MongoDB, este archivo esta ubicado en el directorio de descargas del usuario michael. Notese que para versiones actualizadas de MongoDB se necesita la autenticacion explicita (via consola en Linux), en este caso se usa el puerto por defecto de MongoDB, el host es localhost <=> 127.0.0.1, el usuario es admin creado previamente y este usuario cuenta con los privilegios de administrador de base de datos en MongoDB y la contraseña (para completar la autenticacion) se ingresa por consola (en este caso, para no exponer tal contraseña)
mongoimport -d dbRestaurants -c restaurants --uri mongodb://localhost:27017 -u admin --authenticationDatabase admin --file /home/michael/Descargas/data.json

#El comando anterior en su version no simplificada es equivalente al siguiente comando
mongoimport --db dbRestaurants --collection restaurants --uri mongodb://localhost:27017 --username admin --authenticationDatabase admin --file /home/michael/Descargas/data.json

#Posterior a la carga de datos, se obtiene la siguiente respuesta, para luego trabajar en las consultas en el interprete de Mongo
#2022-10-19T13:31:33.814-0500	connected to: mongodb://localhost:27017
#2022-10-19T13:31:33.896-0500	3772 document(s) imported successfully. 0 document(s) failed to import.
