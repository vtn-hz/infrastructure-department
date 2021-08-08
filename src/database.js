const mysql = require('mysql');


const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'mercado'
});

connection.connect((err) => {
    if(err){
        console.error('Error connecting: ' + err.stack);
        return;
    } console.log('Connected!');
});

module.exports  = connection;



