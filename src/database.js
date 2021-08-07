const mysql = require('mysql');
const { connect } = require('./routes');

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: ''
});

connection.connect((err) => {
    if(err){
        console.error('Error connecting: ' + err.stack);
        return;
    } console.log('Connected!');
});

connection.end();