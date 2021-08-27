const express = require('express');
const router = express.Router();
const  { isLoggedIn, isNorm } = require('../../helpers/isauth');
const pool = require('../../database');

router.get('/add/petition', isLoggedIn, isNorm, (Req, Res) => {
    Res.render('users/user_request');
});

router.post('/add/petition', isLoggedIn, isNorm, async (Req, Res) => {
    const newPet = {
        ID_USER: Req.user.ID,
        name: Req.body.name,
        problem: Req.body.problem
    };

    console.log(newPet);
    await pool.query('INSERT INTO  problems set ?', [newPet]);
    Req.flash('success', 'Se envio la petición correctamente!');
    Res.redirect('/petitions/');
});

router.get('/petitions/', isLoggedIn, isNorm, async (Req, Res) =>{
    const problems = await pool.query('SELECT * FROM problems WHERE ID_USER = ?', [Req.user.ID]);
    Res.render('users/user_petlist', {problems});
});

router.get('/delete/petition/:id', isLoggedIn, isNorm, async (Req, Res)=>{
    const { id } = Req.params;
    const user_id = await pool.query('SELECT ID_USER FROM problems WHERE ID_PROBLEM = ?', [id]);

   if(user_id[0].ID_USER === Req.user.ID){
        await pool.query('DELETE FROM problems WHERE ID_PROBLEM = ?', [id]);
        Req.flash('success', 'Se eliminó la petición correctamente!');
        Res.redirect('/petitions');
    }

    Req.flash('error', 'Ocurrio un error al intentar eliminar la petición...');
    Res.redirect('/petitions');
});


router.get('/edit/petition/:id', isLoggedIn, isNorm, async (Req, Res)=>{
    const { id } = Req.params;
    const user_req = await pool.query('SELECT * FROM problems WHERE ID_PROBLEM = ?', [id]);
    
    if(user_req[0].ID_USER === Req.user.ID){
        console.log(user_req[0]);
        Res.render('users/user_editpet', user_req[0]);
    }else{
        Req.flash('error', 'Ocurrio un error al intentar editar la petición...');
        Res.redirect('/petitions');
    }
});


router.post('/edit/petition/:id', isLoggedIn, isNorm, async (Req, Res)=>{
    const { id } = Req.params;
    const user_id = await pool.query('SELECT ID_USER FROM problems WHERE ID_PROBLEM = ?', [id]);

    if(user_id[0].ID_USER === Req.user.ID){
        const  body = Req.body;
        await pool.query('UPDATE problems SET ? WHERE ID_PROBLEM = ?', [body, id]);
        Req.flash('success', 'Se edito la petición correctamente!');
        Res.redirect('/petitions');
    }

    Req.flash('error', 'Ocurrio un error al intentar editar la petición...');
    Res.redirect('/petitions');
});


module.exports = router;