const express = require('express');
const router = express.Router();
const pool = require('../../database');
const  isauth = require('../../helpers/isauth');


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

// - Lista
router.get('/allcontratista/', isauth.isLoggedIn, isauth.isVip, async (Req, Res) => {
    pool.query('SELECT * FROM contratista', async (error, results) => {
        if (error) {
            throw error;
        } else {
            const array_ID = results;
            var size = array_ID.length-1;
            var array_Names = [];


            array_ID.forEach((item, index) => {
                pool.query('SELECT * FROM contratista_nombre WHERE ID_CONTN = ?', [item.ID_CONTN], async (error, results) => {
                    if (error) {
                        throw error;
                    } else {
                        if(results.length){
                            let name = results[0].nombre + ' ' + results[0].apellido;
                            array_ID[index].name = name;
                        }else{
                            let name = '';
                            array_ID[index].name = name;
                        }

                        if(size === index){
                            console.log(array_ID);
                            Res.render('admin/allcontratistas', {array_ID, array_Names});
                        }
                    }
                });
            });

        }
    });
});     

// - Add
router.get('/add/contratista', isauth.isLoggedIn, isauth.isVip, (Req, Res) => {
    Res.render('admin/contratista/addcontratista');
});

router.post('/add/contratista', isauth.isLoggedIn, isauth.isVip, (Req, Res) => {
    Res.send('Hacer');
});


module.exports = router;