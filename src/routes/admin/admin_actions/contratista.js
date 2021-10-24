const requires = require('../admin_requires');
const router   =  requires.router;
const pool     =  requires.pool;
const isauth   =  requires.isauth;

// - LIST
router.get('/allcontratista/', /*isauth.isLoggedIn, isauth.isVip,*/ async (Req, Res) => {
    pool.query('SELECT * FROM contratista WHERE activo = 1', async (error, results) => {
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
                                //console.log(array_ID);
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

// - EDIT
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
                    CONT[0].email_1 = EMAIL1[0].ID_EMAIL;
                }
            }else{  
                let EMAIL1 = await pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[0].ID_EMAIL]);
                if  (EMAIL1.length > 0){
                    CONT[0].email1 = EMAIL1[0].email;
                    CONT[0].email_1 = EMAIL1[0].ID_EMAIL;
                }
                let EMAIL2 = await pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[1].ID_EMAIL]);
                if  (EMAIL2.length > 0){
                    CONT[0].email2 = EMAIL2[0].email;
                    CONT[0].email_2 = EMAIL2[0].ID_EMAIL;
                }
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
                    CONT[0].tel_1 =  TEL1[0].ID_TEL;
                }
            }else{  
                let TEL1 = await pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[0].ID_TEL]);
                if  (TEL1.length > 0){
                    CONT[0].tel1 = TEL1[0].telefono;
                    CONT[0].tel_1 =  TEL1[0].ID_TEL;
                }
                let TEL2 = await pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[1].ID_TEL]);
                if  (TEL2.length > 0)    {
                    CONT[0].tel2 = TEL2[0].telefono;
                    CONT[0].tel_2 = TEL2[0].ID_TEL;
                }
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
    const promises = [];

    promises.push( new Promise ((Resolve, Reject) => {pool.query('SELECT * FROM contratista WHERE ID_CONT = ?', [ID_CONT], async (error, results)  => {
        if(error){
            Reject(error);
        }else{
            const micro = [
                new Promise ((Resolve, Reject) => {
                    pool.query('SELECT * FROM contratista_nombre WHERE ID_CONTN = ?', [results[0].ID_CONTN], async (error, results)  => {
                        if(error){
                            Reject(error);
                        }else{
                           if(results.length){
                                if(Req.body.nombre != '' && Req.body.apellido != ''){
                                    pool.query('UPDATE contratista_nombre SET nombre = ?, apellido = ? WHERE ID_CONTN = ?', [Req.body.nombre, Req.body.apellido, results[0].ID_CONTN]);
                                    Resolve(results[0].ID_CONTN);
                                }else{
                                    pool.query('DELETE FROM contratista_nombre WHERE ID_CONTN = ?', [results[0].ID_CONTN]);
                                    Resolve(null);
                                }

                            }else{
                                if(Req.body.nombre != '' && Req.body.apellido != ''){
                                    pool.query('INSERT INTO contratista_nombre (nombre, apellido) VALUES (?, ?)', [Req.body.nombre, Req.body.apellido], (error, results) => {
                                        if(error){
                                            Reject(error);
                                        }else{
                                            Resolve(results.insertId);
                                        }
                                    });
                                }else{
                                    Resolve(null);
                                }
                            }
                        }

                    })
                }),
                new Promise ((Resolve, Reject) => {
                    pool.query('SELECT * FROM representante WHERE ID_REPR = ?', [results[0].ID_REPR], async (error, results)  => {
                        if(error){
                            Reject(error);
                        }else{
                            if(results.length){
                                if(Req.body.nombre_repre != '' && Req.body.apellido_repre != ''){
                                    pool.query('UPDATE representante SET nombre = ?, apellido = ? WHERE ID_REPR = ?', [Req.body.nombre_repre, Req.body.apellido_repre, results[0].ID_REPR]);
                                    Resolve(results[0].ID_REPR);
                                }else{
                                    pool.query('DELETE FROM representante WHERE ID_REPR = ?', [results[0].ID_REPR]);
                                    Resolve(null);
                                }
                            }else{
                                if(Req.body.nombre_repre != '' && Req.body.apellido_repre != ''){
                                    pool.query('INSERT INTO representante (nombre, apellido) VALUES (?, ?)', [Req.body.nombre_repre, Req.body.apellido_repre], (error, results) => {
                                        if(error){
                                            Reject(error);
                                        }else{
                                            Resolve(results.insertId);
                                        }
                                    });
                                }else{
                                    Resolve(null);
                                }
                            }
                        }

                    })
                }),
            ];

            Promise.all(micro).then(values => {
                Resolve(values);
            });

        }
    })
    })
    )

    promises.push(
        new Promise ((Resolve, Reject) => {
            pool.query('SELECT * FROM contratista_domicilio WHERE ID_CONT = ?', [ID_CONT], async (error, results)  => {
                if(error){
                    Reject(error);
                }else{
                    if(results.length){
                        if(Req.body.nmb_calle != '' && Req.body.nro_calle != '' && Req.body.LOCALIDAD != ''){
                            pool.query('UPDATE domicilio SET ID_LOCALIDAD = ?, nro_calle = ?, nro_calle = ? WHERE ID_DOM = ?', [Req.body.LOCALIDAD, Req.body.nmb_calle, Req.body.nro_calle, results[0].ID_DOM]);
                            Resolve(true);
                        }else{
                            pool.query('DELETE FROM domicilio WHERE ID_DOM = ?', [results[0].ID_DOM]);
                            pool.query('DELETE FROM contratista_domicilio WHERE ID_DOM = ?', [results[0].ID_DOM]);
                            Resolve(null);
                        }
                    }else{
                        if(Req.body.nmb_calle != '' && Req.body.nro_calle != '' && Req.body.LOCALIDAD != ''){
                            pool.query('INSERT INTO domicilio (ID_LOCALIDAD, nmb_calle, nro_calle) VALUES (?, ?, ?)', [Req.body.LOCALIDAD, Req.body.nmb_calle, Req.body.nro_calle], (error, results) => {
                                if(error){
                                    Reject(error);
                                }else{
                                    pool.query('INSERT INTO contratista_domicilio (ID_DOM, ID_CONT) VALUES (?, ?)', [results.insertId, ID_CONT]);
                                    Resolve(true);
                                }
                            });
                        }else{
                            Resolve(null);
                        }
                    }
                }

            })
        })
    );

    promises.push(
        new Promise ((Resolve, Reject) => {
            pool.query('SELECT * FROM contratista_telefono WHERE ID_CONT = ?', [ID_CONT], async (error, results)  => {
                if(error){
                    Reject(error);
                }else{
                    const micro_TEL = [];
                    if(results.length){
                        if(Req.body.telefono_a != ''){
                            pool.query('UPDATE telefono SET telefono = ? WHERE ID_TEL = ?', [Req.body.telefono_a, Req.body.tel_1]);
                        }else{
                            pool.query('DELETE FROM telefono WHERE ID_TEL = ?', [Req.body.tel_1]);
                            pool.query('DELETE FROM contratista_telefono WHERE ID_CONT = ? AND ID_TEL = ?', [ID_CONT, Req.body.tel_1]);
                        }

                        if(results.length > 1){
                            if(Req.body.telefono_b != ''){
                                pool.query('UPDATE telefono SET telefono = ? WHERE ID_TEL = ?', [Req.body.telefono_b, Req.body.tel_2]);
                            }else{
                                pool.query('DELETE FROM telefono WHERE ID_TEL = ?', [Req.body.tel_2]);
                                pool.query('DELETE FROM contratista_telefono WHERE ID_CONT = ? AND ID_TEL = ?', [ID_CONT, Req.body.tel_2]);
                            }
                        }else{
                            if(Req.body.telefono_b != ''){
                                micro_TEL.push ( new Promise ((Resolve, Reject) => { 
                                    pool.query('INSERT INTO telefono (telefono) VALUES (?)', [Req.body.telefono_b] , (error, results) => {
                                        if(error){
                                            Reject(error);
                                        }else{
                                            pool.query('INSERT INTO contratista_telefono (ID_CONT, ID_TEL) VALUES (?, ?)', [ID_CONT, results.insertId]);
                                            Resolve(true);
                                        }
                                    })
                                })
                                );
                            }
                        }

                        Promise.all(micro_TEL).then(Resolve(true));
                    }else{
                        const micro_TEL = [];
                        if(Req.body.telefono_a != ''){
                            micro_TEL.push ( new Promise ((Resolve, Reject) => { 
                                pool.query('INSERT INTO telefono (telefono) VALUES (?)', [Req.body.telefono_a], (error, results) => {
                                    if(error){
                                        Reject(error);
                                    }else{
                                        pool.query('INSERT INTO contratista_telefono (ID_CONT, ID_TEL) VALUES (?, ?)', [ID_CONT, results.insertId]);
                                        Resolve(null);
                                    }
                                })
                            })
                            );
                        }

                        if(Req.body.telefono_b != ''){
                            micro_TEL.push ( new Promise ((Resolve, Reject) => { 
                                pool.query('INSERT INTO telefono (telefono) VALUES (?)', [Req.body.telefono_b] , (error, results) => {
                                    if(error){
                                        Reject(error);
                                    }else{
                                        pool.query('INSERT INTO contratista_telefono (ID_CONT, ID_TEL) VALUES (?, ?)', [ID_CONT, results.insertId]);
                                        Resolve(null);
                                    }
                                })
                            })
                            );
                        }

                        Promise.all(micro_TEL).then(Resolve(null));
                    }
                }

            })
        })
    );

    promises.push(
        new Promise ((Resolve, Reject) => {
            pool.query('SELECT * FROM con_email WHERE ID_CONT = ?', [ID_CONT], async (error, results)  => {
                if(error){
                    Reject(error);
                }else{
                    const micro_EMAIL = [];
                    if(results.length){
                        if(Req.body.email_a != ''){
                            pool.query('UPDATE email SET email = ? WHERE ID_EMAIL = ?', [Req.body.email_a, Req.body.email_1]);
                        }else{
                            pool.query('DELETE FROM email WHERE ID_EMAIL = ?', [Req.body.email_1]);
                            pool.query('DELETE FROM con_email WHERE ID_CONT = ? AND ID_EMAIL = ?', [ID_CONT, Req.body.email_1]);
                        }

                        if(results.length > 1){
                            if(Req.body.email_b != ''){
                                pool.query('UPDATE email SET email = ? WHERE ID_EMAIL = ?', [Req.body.email_b, Req.body.email_2]);
                            }else{
                                pool.query('DELETE FROM email WHERE ID_EMAIL = ?', [Req.body.email_2]);
                                pool.query('DELETE FROM con_email WHERE ID_CONT = ? AND ID_EMAIL = ?', [ID_CONT, Req.body.email_2]);
                            }
                        }else{
                            if(Req.body.email_b != ''){
                                micro_EMAIL.push ( new Promise ((Resolve, Reject) => { 
                                    pool.query('INSERT INTO email (email) VALUES (?)', [Req.body.email_b] , (error, results) => {
                                        if(error){
                                            Reject(error);
                                        }else{
                                            pool.query('INSERT INTO con_email (ID_CONT, ID_EMAIL) VALUES (?, ?)', [ID_CONT, results.insertId]);
                                            Resolve(true);
                                        }
                                    })
                                })
                                );
                            }
                        }

                        Promise.all(micro_EMAIL).then(Resolve(true));
                    }else{
                        const micro_EMAIL = [];
                        if(Req.body.email_a != ''){
                            micro_EMAIL.push ( new Promise ((Resolve, Reject) => { 
                                pool.query('INSERT INTO email (email) VALUES (?)', [Req.body.email_a], (error, results) => {
                                    if(error){
                                        Reject(error);
                                    }else{
                                        pool.query('INSERT INTO con_email (ID_CONT, ID_EMAIL) VALUES (?, ?)', [ID_CONT, results.insertId]);
                                        Resolve(null);
                                    }
                                })
                            })
                            );
                        }

                        if(Req.body.email_b != ''){
                            micro_EMAIL.push ( new Promise ((Resolve, Reject) => { 
                                pool.query('INSERT INTO email (email) VALUES (?)', [Req.body.email_b] , (error, results) => {
                                    if(error){
                                        Reject(error);
                                    }else{
                                        pool.query('INSERT INTO con_email (ID_CONT, ID_EMAIL) VALUES (?, ?)', [ID_CONT, results.insertId]);
                                        Resolve(null);
                                    }
                                })
                            })
                            );
                        }

                        Promise.all(micro_EMAIL).then(Resolve(null));
                    }
                }

            })
        })
    );

    promises.push(
        new Promise ((Resolve, Reject) => {
            pool.query('SELECT * FROM con_rub WHERE ID_CONT = ?', [ID_CONT], async (error, results)  => {
                if(error){
                    Reject(error);
                }else{
                    
                    var macro;
                    if(results.length){
                        macro = new Promise ((Resolve, Reject) => {
                            pool.query('DELETE FROM con_rub WHERE ID_CONT = ?', [ID_CONT], (error) => {
                                if(error){
                                    Reject(error);
                                }else{
                                    const micro = [];
                                    if(Req.body.rubro instanceof Array){
                                        Req.body.rubro.forEach(element => {
                                            micro.push (new Promise (() => {pool.query('INSERT INTO con_rub (CONT_RUB, ID_RUBRO, ID_CONT) VALUES (?, ?, ?)', [ID_CONT+"/"+element, element, ID_CONT], (error) => {
                                                if (error) { Reject(error); } else { Resolve(); }
                                            })
                                        }));
                                        })
                                    }else{
                                        micro.push (new Promise (() => {pool.query('INSERT INTO con_rub (CONT_RUB, ID_RUBRO, ID_CONT) VALUES (?, ?, ?)', [ID_CONT+"/"+Req.body.rubro, Req.body.rubro, ID_CONT], (error) => {
                                            if (error) { Reject(error); } else { Resolve(); }
                                        })})
                                        );
                                    }

                                    Promise.all(micro).then(Resolve());
                                }
                            })
                        });
                    }else{
                        macro = new Promise ((Resolve, Reject) => {
                            const micro = [];
                            if(Req.body.rubro instanceof Array){
                                Req.body.rubro.forEach(element => {
                                    micro.push (new Promise (() => {pool.query('INSERT INTO con_rub (CONT_RUB, ID_RUBRO, ID_CONT) VALUES (?, ?, ?)', [ID_CONT+"/"+element, element, ID_CONT], (error) => {
                                        if (error) { Reject(error); } else { Resolve(); }
                                    })
                                }));
                                })
                            }else{
                                micro.push (new Promise (() => {pool.query('INSERT INTO con_rub (CONT_RUB, ID_RUBRO, ID_CONT) VALUES (?, ?, ?)', [ID_CONT+"/"+Req.body.rubro, Req.body.rubro, ID_CONT], (error) => {
                                    if (error) { Reject(error); } else { Resolve(); }
                                })})
                                );
                            }
                            Promise.all(micro).then(Resolve());
                        });
                    }

                    Promise.resolve(macro).then(Resolve(true));
                }
            })
        })
    );

    Promise.all(promises).then(values => {
        pool.query('UPDATE contratista SET ID_CONTN = ?, CUIT = ?, fecha_certificacion = ?, ID_REPR = ? WHERE ID_CONT = ?', [values[0][0], Req.body.CUIT, Req.body.fecha_certificacion, values[0][1], ID_CONT], (error) => {
            if(error){
                throw error;
            }else{
                Req.flash('success', 'Se edito el contratista correctamente!');
                Res.redirect('/allcontratista/');
            }
        });
    });
});

router.get('/delete/contratista/:ID_CONT', /*isauth.isLoggedIn, isauth.isVip,*/ (Req, Res) => {
    const { ID_CONT } = Req.params;
    pool.query('UPDATE contratista SET activo = 0 WHERE ID_CONT = ?', [ID_CONT], (error) => {
        if(error){
            throw error;
        }else{
            Req.flash('success', 'Se elimino el contratista correctamente!');
            Res.redirect('/allcontratista/');
        }
    });
});

module.exports = router;