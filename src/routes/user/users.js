const express = require('express');
const pool = require('../../database');
const router = express.Router();
const connection = require('../../database');

router.get('/users/signin', (Req, Res) => {
    Res.render('users/signin');
});

router.post('/users/signin', async (Req, Res) => {
    const {name, rol, email, password} = Req.body;
    const newUser = {
        Nombre: name,
        Rol: rol,
        Email: email,
        password
    };
    console.log(newUser);

    await connection.query('INSERT INTO  users set ?', [newUser]);
    Res.send("Se registro!");
});

router.get('/users/signup', (Req, Res) => {
    Res.render('users/signup');
});

router.get('/add/petition', (Req, Res) => {
    Res.render('users/user_request');
});

router.post('/add/petition', async (Req, Res) => {
    console.log(Req.body);
    await connection.query('INSERT INTO  problems set ?', [Req.body]);
    Res.redirect('/petitions/');
});

router.get('/petitions/',  async (Req, Res) =>{
    const problems = await connection.query('SELECT * FROM problems');
    Res.render('users/user_petlist', {problems});
});

module.exports = router;