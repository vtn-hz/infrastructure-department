const { compareSync } = require('bcryptjs');
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
router.get('/allcontratista/', /*isauth.isLoggedIn, isauth.isVip,*/ async (Req, Res) => {
    pool.query('SELECT * FROM contratista', async (error, results) => {
        if (error) {
            throw error;
        } else {
            if(results.length){
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
                                return Res.render('admin/allcontratistas', {array_ID, array_Names});
                            }
                        }
                    });
                });
            }else{
                Res.render('admin/allcontratistas');
            }
            
        }
    });
});     

// - ADD
router.get('/add/contratista', /*isauth.isLoggedIn, isauth.isVip,*/ (Req, Res) => {
    Res.render('admin/contratista/addcontratista');
});

router.post('/add/contratista', /*isauth.isLoggedIn, isauth.isVip,*/async (Req, Res) => {
    const ID_NAME = await pool.query('INSERT INTO contratista_nombre (nombre, apellido) VALUES (?, ?)', [Req.body.nombre, Req.body.apellido]);
    const ID_REPR = (Req.body.nombre_repre && Req.body.apellido_repre)? await pool.query('INSERT INTO representante (nombre, apellido) VALUES (?, ?)', [Req.body.nombre_repre, Req.body.apellido_repre]) : null;

    const CONT = {
        ID_CONTN: ID_NAME.insertId,
        CUIT: Req.body.CUIT,
        fecha_certificacion:Req.body.fecha_certificacion,
        ID_REPR: (ID_REPR)? ID_REPR.insertId : ID_REPR
    }

    const ID_CONT = await pool.query('INSERT INTO contratista SET ?', [CONT]);


   const ID_DOM = await pool.query('INSERT INTO domicilio (ID_LOCALIDAD, nmb_calle, nro_calle) VALUES (?, ?, ?)', [Req.body.LOCALIDAD, Req.body.nmb_calle, Req.body.nro_calle]);
    pool.query('INSERT INTO contratista_domicilio (ID_DOM, ID_CONT) VALUES (?, ?)', [ID_DOM.insertId, ID_CONT.insertId]);


    const EMAIL_1 = await pool.query('INSERT INTO email (email) VALUES (?)', [Req.body.email_a]);
    const EMAIL_2 = (Req.body.email_b)? await pool.query('INSERT INTO email (email) VALUES (?)', [Req.body.email_b]) : null;
    pool.query('INSERT INTO con_email (ID_CONT, ID_EMAIL) VALUES (?, ?)', [ID_CONT.insertId, EMAIL_1.insertId]);
    if(EMAIL_2){ pool.query('INSERT INTO con_email (ID_CONT, ID_EMAIL) VALUES (?, ?)', [ID_CONT.insertId, EMAIL_2.insertId]); }

    const TEL_1 = await pool.query('INSERT INTO telefono (telefono) VALUES (?)', [Req.body.telefono_a]);
    const TEL_2 = (Req.body.telefono_b)? await pool.query('INSERT INTO telefono (telefono) VALUES (?)', [Req.body.telefono_b]) : null;
    pool.query('INSERT INTO contratista_telefono (ID_CONT, ID_TEL) VALUES (?, ?)', [ID_CONT.insertId, TEL_1.insertId]);
    if(TEL_2){ pool.query('INSERT INTO contratista_telefono (ID_CONT, ID_TEL) VALUES (?, ?)', [ID_CONT.insertId, TEL_2.insertId]); }

    const Rubros = Req.body.rubro;

    if(Rubros instanceof Array){
        Rubros.forEach(element => {
            pool.query('INSERT INTO con_rub (CONT_RUB, ID_RUBRO, ID_CONT) VALUES (?, ?, ?)', [ID_CONT.insertId+"/"+element, element, ID_CONT.insertId]);
        });
    }else{
        pool.query('INSERT INTO con_rub (CONT_RUB, ID_RUBRO, ID_CONT) VALUES (?, ?, ?)', [ID_CONT.insertId+"/"+Rubros, Rubros, ID_CONT.insertId]);
    }


     
    Req.flash('success', 'Se registró el contratista correctamente!');
    Res.redirect('/allcontratista/');
  
});

// - Edit
router.get('/edit/contratista/:ID_CONT', /*isauth.isLoggedIn, isauth.isVip,*/ async (Req, Res) => {
    const { ID_CONT } = Req.params;
    const  CONT = await pool.query('SELECT * FROM contratista WHERE ID_CONT = ?', [ID_CONT]);
    //Setear a CONT, asi no repetir las lineas de codigos como se mesutra abajo
    CONT[0].nombre = '';
    CONT[0].apellido = '';
    CONT[0].localidad = '';
    CONT[0].nmb_calle = '';
    CONT[0].nro_calle = '';
    CONT[0].email1 = '';
    CONT[0].email2 = '';
    CONT[0].tel1 = '';
    CONT[0].tel2 = '';
    CONT[0].nombre_repre = '';
    CONT[0].apellido_repre = '';
    CONT[0].rubro = [];

    
    var pms = [false, false, false, false, false, false];

    pool.query('SELECT * FROM contratista_nombre WHERE ID_CONTN = ?', [CONT[0].ID_CONTN], async (error, results) => {
            if(results.length > 0){
                CONT[0].nombre = results[0].nombre;
                CONT[0].apellido = results[0].apellido;
            }

            pms[0] = true;
            if(pms.every((istrue) => {
                return istrue;
            })){
                Res.render('admin/contratista/editcontratista', CONT[0]);
            }
    });

    pool.query('SELECT * FROM contratista_domicilio WHERE ID_CONT = ?', [ID_CONT], async (error, results) => {
        if(results.length > 0){
            const DOM = await pool.query('SELECT * FROM domicilio WHERE ID_DOM = ?', [results[0].ID_DOM]);
            if(DOM.length > 0){
                CONT[0].localidad = DOM[0].ID_LOCALIDAD;
                CONT[0].nmb_calle = DOM[0].nmb_calle;
                CONT[0].nro_calle = DOM[0].nro_calle;
            }
        }

        pms[1] = true;
        if(pms.every((istrue) => {
            return istrue;
        })){
            Res.render('admin/contratista/editcontratista', CONT[0]);
        }
    });



    pool.query('SELECT * FROM con_email WHERE ID_CONT = ?', [ID_CONT], async (error, results) => {
        if(results.length > 0){
            if(results.length == 1){
                let EMAIL1 = await pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[0].ID_EMAIL]);
                if(EMAIL1.length > 0){
                    CONT[0].email1 = EMAIL1[0].email;
                }
            }else{  
                let EMAIL1 = await pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[0].ID_EMAIL]);
                if  (EMAIL1.length > 0)    {CONT[0].email1 = EMAIL1[0].email;}
                let EMAIL2 = await pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[1].ID_EMAIL]);
                if  (EMAIL2.length > 0)    {CONT[0].email2 = EMAIL2[0].email;}
            }

            
        }
        
        pms[2] = true;
        if(pms.every((istrue) => {
            return istrue;
        })){
            Res.render('admin/contratista/editcontratista', CONT[0]);
        }
    });


    pool.query('SELECT * FROM contratista_telefono WHERE ID_CONT = ?', [ID_CONT], async (error, results) => {
        if(results.length > 0){
            if(results.length == 1){
                let TEL1 = await pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[0].ID_TEL]);
                if(TEL1.length > 0){
                    CONT[0].tel1 = TEL1[0].telefono;
                }
            }else{  
                let TEL1 = await pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[0].ID_TEL]);
                if  (TEL1.length > 0)    {CONT[0].tel1 = TEL1[0].telefono;}
                let TEL2 = await pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[1].ID_TEL]);
                if  (TEL2.length > 0)    {CONT[0].tel2 = TEL2[0].telefono;}
            }
        }   

        pms[3] = true;
        if(pms.every((istrue) => {
            return istrue;
        })){
            Res.render('admin/contratista/editcontratista', CONT[0]);
        }
    });


    pool.query('SELECT ID_RUBRO FROM con_rub WHERE ID_CONT = ?', [ID_CONT], async (error, results) => {
        if(results.length > 0){
            results.forEach(element => {
                CONT[0].rubro.push(element.ID_RUBRO);
            });
        }

        pms[4] = true;
        if(pms.every((istrue) => {
            return istrue;
        })){
            Res.render('admin/contratista/editcontratista', CONT[0]);
        }
    });


    pool.query('SELECT * FROM representante WHERE ID_REPR = ?', [CONT[0].ID_REPR], async (error, results) => {
        if(results.length > 0){
            CONT[0].nombre_repre = results[0].nombre;
            CONT[0].apellido_repre = results[0].apellido;
        }

        pms[5] = true;
        if(pms.every((istrue) => {
            return istrue;
        })){
            Res.render('admin/contratista/editcontratista', CONT[0]);
        }
    });


   
});

router.post('/edit/contratista/:ID_CONT', /*isauth.isLoggedIn, isauth.isVip,*/ async (Req, Res) => {
    const { ID_CONT } = Req.params;
    const  CONT = await pool.query('SELECT * FROM contratista WHERE ID_CONT = ?', [ID_CONT]);
    //Setear a CONT, asi no repetir las lineas de codigos como se mesutra abajo
    /*CONT[0].nombre = '';
    CONT[0].apellido = '';
    CONT[0].localidad = '';
    CONT[0].nmb_calle = '';
    CONT[0].nro_calle = '';
    CONT[0].email1 = '';
    CONT[0].email2 = '';
    CONT[0].tel1 = '';
    CONT[0].tel2 = '';
    CONT[0].nombre_repre = '';
    CONT[0].apellido_repre = '';
    CONT[0].rubro = [];

    
    var pms = [false, false, false, false, false, false];

    pool.query('SELECT * FROM contratista_nombre WHERE ID_CONTN = ?', [CONT[0].ID_CONTN], async (error, results) => {
            if(results.length > 0){
                CONT[0].nombre = results[0].nombre;
                CONT[0].apellido = results[0].apellido;
            }

            pms[0] = true;
            if(pms.every((istrue) => {
                return istrue;
            })){
                Res.render('admin/contratista/editcontratista', CONT[0]);
            }
    });

    pool.query('SELECT * FROM contratista_domicilio WHERE ID_CONT = ?', [ID_CONT], async (error, results) => {
        if(results.length > 0){
            const DOM = await pool.query('SELECT * FROM domicilio WHERE ID_DOM = ?', [results[0].ID_DOM]);
            if(DOM.length > 0){
                CONT[0].localidad = DOM[0].ID_LOCALIDAD;
                CONT[0].nmb_calle = DOM[0].nmb_calle;
                CONT[0].nro_calle = DOM[0].nro_calle;
            }
        }

        pms[1] = true;
        if(pms.every((istrue) => {
            return istrue;
        })){
            Res.render('admin/contratista/editcontratista', CONT[0]);
        }
    });



    pool.query('SELECT * FROM con_email WHERE ID_CONT = ?', [ID_CONT], async (error, results) => {
        if(results.length > 0){
            if(results.length == 1){
                let EMAIL1 = await pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[0].ID_EMAIL]);
                if(EMAIL1.length > 0){
                    CONT[0].email1 = EMAIL1[0].email;
                }
            }else{  
                let EMAIL1 = await pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[0].ID_EMAIL]);
                if  (EMAIL1.length > 0)    {CONT[0].email1 = EMAIL1[0].email;}
                let EMAIL2 = await pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[1].ID_EMAIL]);
                if  (EMAIL2.length > 0)    {CONT[0].email2 = EMAIL2[0].email;}
            }

            
        }
        
        pms[2] = true;
        if(pms.every((istrue) => {
            return istrue;
        })){
            Res.render('admin/contratista/editcontratista', CONT[0]);
        }
    });


    pool.query('SELECT * FROM contratista_telefono WHERE ID_CONT = ?', [ID_CONT], async (error, results) => {
        if(results.length > 0){
            if(results.length == 1){
                let TEL1 = await pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[0].ID_TEL]);
                if(TEL1.length > 0){
                    CONT[0].tel1 = TEL1[0].telefono;
                }
            }else{  
                let TEL1 = await pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[0].ID_TEL]);
                if  (TEL1.length > 0)    {CONT[0].tel1 = TEL1[0].telefono;}
                let TEL2 = await pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[1].ID_TEL]);
                if  (TEL2.length > 0)    {CONT[0].tel2 = TEL2[0].telefono;}
            }
        }   

        pms[3] = true;
        if(pms.every((istrue) => {
            return istrue;
        })){
            Res.render('admin/contratista/editcontratista', CONT[0]);
        }
    });


    pool.query('SELECT ID_RUBRO FROM con_rub WHERE ID_CONT = ?', [ID_CONT], async (error, results) => {
        if(results.length > 0){
            results.forEach(element => {
                CONT[0].rubro.push(element.ID_RUBRO);
            });
        }

        pms[4] = true;
        if(pms.every((istrue) => {
            return istrue;
        })){
            Res.render('admin/contratista/editcontratista', CONT[0]);
        }
    });


    pool.query('SELECT * FROM representante WHERE ID_REPR = ?', [CONT[0].ID_REPR], async (error, results) => {
        if(results.length > 0){
            CONT[0].nombre_repre = results[0].nombre;
            CONT[0].apellido_repre = results[0].apellido;
        }

        pms[5] = true;
        if(pms.every((istrue) => {
            return istrue;
        })){
            Res.render('admin/contratista/editcontratista', CONT[0]);
        }
    });
     */

   
});

//-   Escuelas     -//
// -LIST
router.get('/allinstitucion/', /*isauth.isLoggedIn, isauth.isVip,*/ async (Req, Res) => {
    pool.query('SELECT * FROM institucion', async (error, results) => {
        if (error) {
            throw error;
        } else {
            if(results.length){
                var array_ID = results;
                var isterminate = 0;
    
                array_ID.forEach((item, index) => {
                    pool.query('SELECT * FROM inst_enc WHERE CUE = ? OR ID_EST = ?', [item.CUE, item.ID_EST], async (error, results) => {
                        if (error) {
                            throw error;
                        } else {

                            //Si por alguna razon en el error de la base de datos, en el caso de que NINGUNA escuela imposiblemente
                            //no cuente con un encargado, ERROR. Buscar solucion posterior -> Falta ErrorManage
                            // Posible solución -> hacer una busqueda anteriror con todos los IDS -> sacrificio -> rendimiento
                            if(results.length){
                                results.forEach((single_encargado) => {
                                    isterminate++;
                                    pool.query('SELECT * FROM encargados WHERE ID_ENCARGADO = ?', [single_encargado.ID_ENCARGADO], async (error, results) => {
                                        isterminate--;
                                        if(results[0].ID_TIPOENC == 1){
                                            array_ID[index].nombre_director = results[0].nombre;
                                            array_ID[index].apellido_director = results[0].apellido;
                                        }else{
                                            array_ID[index].nombre_inspector = results[0].nombre;
                                            array_ID[index].apellido_inspector = results[0].apellido;
                                        }
                                        
                                        if(!isterminate){
                                           console.log(array_ID); 
                                           return  Res.render('admin/allinstitucion', {array_ID});
                                        }
    
                                    });
                                });
    
                            }   


                        }
                    });
                });
            }else{
                Res.render('admin/allinstitucion', {array_ID});
            }
            

        }
    });
});

// -ADD
router.get('/add/institucion', /*isauth.isLoggedIn, isauth.isVip,*/async (Req, Res) => {
    pool.query('SELECT * FROM encargados',  async (error, results) => {
        if(error){
            throw error;
        }else{
            if(results.length){
                const  directores = [];
                const  inspectores = [];
                const size_t = results.length;
                /*const end = () => {if(directores.length+inspectores.length === size_t) { console.log(directores); console.log(inspectores);  Res.render('admin/institucion/addinstitucion', {directores, inspectores}); }}
                Funciona sin la funcion end, de no funcionar activar.
                */
                results.forEach(element => {
                    if(element.ID_TIPOENC == 1){
                        pool.query('SELECT * FROM enc_tel WHERE ID_ENCARGADO = ?', [element.ID_ENCARGADO], async (error, results) => {
                            if(results.length){
                                TEL = await pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[0].ID_TEL]);
                                
                                if(TEL.length){
                                    element.TEL = TEL[0].telefono; 
                                }else{
                                    element.TEL = "";
                                }
                            }else{
                                element.TEL = "";
                            }

                            if(element.hasOwnProperty('EMAIL')){
                                directores.push(element);
                            }

                            //end();
                        });

                        pool.query('SELECT * FROM enc_email WHERE ID_ENCARGADO = ?', [element.ID_ENCARGADO], async (error, results) => {
                            if(results.length){
                                EMAIL = await pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[0].ID_EMAIL]);
                                if(EMAIL.length){
                                    element.EMAIL = EMAIL[0].email;
                                }else{
                                    element.EMAIL = "";
                                }
                                
                            }else{
                                element.EMAIL = "";
                            }

                            if(element.hasOwnProperty('TEL')){
                                directores.push(element);
                            }

                            //end();
                        });


                        
                    }else{
                        pool.query('SELECT * FROM enc_tel WHERE ID_ENCARGADO = ?', [element.ID_ENCARGADO], async (error, results) => {
                            if(results.length){
                                //console.log(results[0].ID_TEL);
                                TEL = await pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[0].ID_TEL]);
                                //console.log(TEL);
                                if(TEL.length){
                                    console.log(TEL[0]);
                                    element.TEL = TEL[0].telefono; 
                                }else{
                                    element.TEL = "";
                                }
                                
                            }else{
                                element.TEL = "";
                            }

                            if(element.hasOwnProperty('EMAIL')){
                                inspectores.push(element);
                            }
                            
                            //end();
                        });

                        pool.query('SELECT * FROM enc_email WHERE ID_ENCARGADO = ?', [element.ID_ENCARGADO], async (error, results) => {
                            if(results.length){
                                EMAIL = await pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[0].ID_EMAIL]);
                                if(EMAIL.length){
                                    element.EMAIL = EMAIL[0].email;
                                }else{
                                    element.EMAIL = "";
                                }
                                
                            }else{
                                element.EMAIL = "";
                            }

                            if(element.hasOwnProperty('TEL')){
                                inspectores.push(element);
                            }


                           // end();                        
                        });
                    }

                    
                });
                Res.render('admin/institucion/addinstitucion', {directores, inspectores});
            }else{
                Res.render('admin/institucion/addinstitucion');
            }
        }
    });
});

router.post('/add/institucion', /*isauth.isLoggedIn, isauth.isVip,*/async (Req, Res) => { 
    pool.query('SELECT * FROM institucion WHERE CUE = ? OR ID_EST = ?', [Req.body.CUE, Req.body.ESTABLECIMIENTO], async (error, resu) => {
        if(!resu.length){
            var INS_DOM = {
                CUE: 0,
                ID_EST: 0,
                ID_DOM: 0  
            };
        
        
            var INS_TEL = {
                CUE: 0,
                ID_EST: 0,
                ID_TEL: 0  
            };

            pool.query('INSERT INTO institucion (CUE, ID_EST, nombre_establecimiento, ID_MODALIDAD) VALUES (?, ?, ?, ?)', [Req.body.CUE, Req.body.ESTABLECIMIENTO, Req.body.nombre_escuela, Req.body.NIVEL],  async (error, results) => {
                if(INS_DOM.ID_DOM){
                    INS_DOM.CUE = Req.body.CUE;
                    INS_DOM.ID_EST = Req.body.ESTABLECIMIENTO;
                    pool.query('INSERT INTO inst_dom SET ?', [INS_DOM]);
                    console.log(INS_DOM);
                }else{
                    INS_DOM.CUE = Req.body.CUE;
                    INS_DOM.ID_EST = Req.body.ESTABLECIMIENTO;
                }

                if(INS_TEL.ID_TEL){
                    INS_TEL.CUE = Req.body.CUE;
                    INS_TEL.ID_EST = Req.body.ESTABLECIMIENTO;
                    pool.query('INSERT INTO inst_tel SET ?', [INS_TEL]);
                    console.log(INS_TEL);
                }else{
                    INS_TEL.CUE = Req.body.CUE;
                    INS_TEL.ID_EST = Req.body.ESTABLECIMIENTO;
                }


                if(Req.body.directores){
                    pool.query('INSERT INTO inst_enc (CUE, ID_EST, ID_ENCARGADO) VALUES (?, ?, ?)', [Req.body.CUE, Req.body.ESTABLECIMIENTO, Req.body.directores]);
                }

                if(Req.body.inspectores){
                    pool.query('INSERT INTO inst_enc (CUE, ID_EST, ID_ENCARGADO) VALUES (?, ?, ?)', [Req.body.CUE, Req.body.ESTABLECIMIENTO, Req.body.inspectores]);
                }
            });


            pool.query('INSERT INTO domicilio (ID_LOCALIDAD, nmb_calle, nro_calle) VALUES (?, ?, ?)', [Req.body.LOCALIDAD, Req.body.nmb_calle, Req.body.nro_calle],  async (error, results) => {
                if(INS_DOM.CUE && INS_DOM.ID_EST){
                    INS_DOM.ID_DOM = results.insertId;
                    pool.query('INSERT INTO inst_dom SET ?', [INS_DOM]);
                    console.log(INS_DOM);
                }else{
                    INS_DOM.ID_DOM = results.insertId;
                }
            });


            pool.query('INSERT INTO telefono (telefono) VALUES (?)', [Req.body.telefono_escuela],  async (error, results) => {
                if(INS_TEL.CUE && INS_TEL.ID_EST){
                    INS_TEL.ID_TEL = results.insertId;
                    pool.query('INSERT INTO inst_tel SET ?', [INS_TEL]);
                    console.log(INS_TEL);
                }else{
                    INS_TEL.ID_TEL = results.insertId;
                }
            });

            Req.flash('success', 'Se creo la instutucón correctamente!');
            Res.redirect('/allinstitucion/');
        }else{
            Req.flash('error', 'Esa institución ya esta creada con anterioridad!');
            Res.redirect('/allinstitucion/');
        }
    });
   
});

//-Encargados-//
router.get('/add/encargado', /*isauth.isLoggedIn, isauth.isVip,*/async (Req, Res) => { 
    Res.render('admin/institucion/encargados/addencargado');
});
 
router.post('/add/encargado', /*isauth.isLoggedIn, isauth.isVip,*/async (Req, Res) => { 
    var ENC_TEL = {
        ID_ENCARGADO: 0,
        ID_TEL: 0  
    };


    var ENC_EMA = {
        ID_ENCARGADO: 0,
        ID_EMAIL: 0  
    };


    pool.query('INSERT INTO encargados (nombre, apellido, ID_TIPOENC) VALUES (?, ?, ?)', [Req.body.nombre, Req.body.apellido, Req.body.TIPO],  async (error, results) => {
        if(error){
            throw error;
        }else{
            if(ENC_TEL.ID_TEL){
                ENC_TEL.ID_ENCARGADO = results.insertId;
                pool.query('INSERT INTO enc_tel SET ?', [ENC_TEL]);
                console.log(ENC_TEL);
            }else{
                ENC_TEL.ID_ENCARGADO = results.insertId;
            }

            if(ENC_EMA.ID_EMAIL){
                ENC_EMA.ID_ENCARGADO = results.insertId;
                pool.query('INSERT INTO enc_email SET ?', [ENC_EMA]);
                console.log(ENC_EMA);
            }else{
                ENC_EMA.ID_ENCARGADO = results.insertId;
            }
        }
    });

    if(Req.body.email){
        pool.query('INSERT INTO email (email) VALUES (?)', [Req.body.email],  async (error, results) => {
            if(ENC_EMA.ID_ENCARGADO){
                ENC_EMA.ID_EMAIL = results.insertId;
                pool.query('INSERT INTO enc_email SET ?', [ENC_EMA]);
                console.log(ENC_EMA);
            }else{
                ENC_EMA.ID_EMAIL = results.insertId;
            }
        });
    }

    if(Req.body.telefono){
        pool.query('INSERT INTO telefono (telefono) VALUES (?)', [Req.body.telefono],  async (error, results) => {
            if(ENC_TEL.ID_ENCARGADO){
                ENC_TEL.ID_TEL = results.insertId;
                pool.query('INSERT INTO enc_tel SET ?', [ENC_TEL]);
                console.log(ENC_TEL);
            }else{
                ENC_TEL.ID_TEL = results.insertId;
            }
        });
    }

    Res.redirect('/allinstitucion/');
});








module.exports = router;