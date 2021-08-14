const mysql = require('mysql');
const { promisify } = require('util'); //Callback to Promise
const { database } = require('./keys')

/*
 
Callbacks. 
La llamada asíncrona recibe como parámetro una función. ... 
La llamada asíncrona retorna como resultado 
"provisional" una Promise. 
Este es un objeto que contendrá en el futuro el resultado.

https://www.youtube.com/watch?v=hUnZZ_Welqs
*/


const pool = mysql.createPool(database);
pool.getConnection((err, connection) => {
    if (err) {
        if(err.code === 'PROTOCOL_CONNECTION_LOST'){
            console.error('DATABASE CONNECTION WAS CLOSED');
        }

        if(err.code === 'ER_CON_COUNT_ERROR'){
            console.error('DATABASE HAS TO MANY CONNECTIONS');
        }

        if(err.code === 'ECONNREFUSED'){
            console.error('DATABASE CONNECTION WAS REFUSED');
        }
    }

    if(connection) connection.release();
    console.log('DB is Connected');
    return;
});

pool.query = promisify(pool.query);
module.exports = pool;

