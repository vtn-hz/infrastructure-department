const requires = require('./admin_requires');
const router   =  requires.router;
const pool     =  requires.pool;
const isauth   =  requires.isauth;


/*router.get('/allpetitions/', isauth.isLoggedIn, isauth.isVip, async (Req, Res) => {
    const problems = await pool.query('SELECT * FROM problems');
    Res.render('admin/allpetitions', {problems});
});

router.get('/allusers/', isauth.isLoggedIn, isauth.isVip, (Req, Res) => {
        pool.query('SELECT * FROM users', (Err, Rows, Field) => {
            if(Err){
                console.log(Err);
            }
            
            Res.render('admin/allusers', {Rows});
        });
         
});

router.get('/delete/allpetition/:id',  isauth.isLoggedIn, isauth.isVip, async (Req, Res)=>{
    const { id } = Req.params;

    await pool.query('DELETE FROM problems WHERE ID_PROBLEM = ?', [id]);
    Req.flash('success', 'Se eliminó la petición correctamente!');
    Res.redirect('admin/allpetitions');
});

router.get('/edit/allpetition/:id',  isauth.isLoggedIn, isauth.isVip, async (Req, Res)=>{
    const { id } = Req.params;
    const user_req = await pool.query('SELECT * FROM problems WHERE ID_PROBLEM = ?', [id]);
    Res.render('users/user_editpet', user_req[0]);

});


router.post('/edit/allpetition/:id',  isauth.isLoggedIn, isauth.isVip, async (Req, Res)=>{
    const { id } = Req.params;
    const user_id = await pool.query('SELECT ID_USER FROM problems WHERE ID_PROBLEM = ?', [id]);
    const  body = Req.body;
    await pool.query('UPDATE problems SET ? WHERE ID_PROBLEM = ?', [body, id]);
    Req.flash('success', 'Se edito la petición correctamente!');
    Res.redirect('admin/allpetitions');
});

No borrar, hay que editar, porque con la nueva base de datos no funciona.

*/



//-   Contratista     -//
Object.assign(router, require('./admin_actions/contratista.js'));

//-   Escuelas     -//
Object.assign(router, require('./admin_actions/escuela.js'));

//-Expediente-//
Object.assign(router, require('./admin_actions/expediente.js'));

module.exports = router;