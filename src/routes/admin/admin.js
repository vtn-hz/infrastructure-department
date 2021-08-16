const express = require('express');
const router = express.Router();
const connection = require('../../database');

router.get('/allpetitions/', (Req, Res) => {
    Res.render('admin/allpetitions');
});

router.get('/allusers/', (Req, Res) => {
        connection.query('SELECT * FROM users', (Err, Rows, Field) => {
            if(Err){
                console.log(Err);
            }
            
            Res.render('admin/allusers', {Rows});
        });
         
});

module.exports = router;