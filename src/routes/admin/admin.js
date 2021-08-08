const express = require('express');
const router = express.Router();
const connection = require('../../database');

router.get('/allpetitions/', (Req, Res) => {
    Res.render('admin/allpetitions');
});

router.get('/allusers/', (Req, Res) => {
    connection.query('SELECT * FROM users', (err, rows, fields) => {
        if(err){
            console.log(err);
        }
        Res.render('admin/allusers', {rows: rows});
        
    });
});

module.exports = router;