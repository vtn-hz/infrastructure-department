const requires = require('../admin_requires');
const router   =  requires.router;
const pool     =  requires.pool;
const isauth   =  requires.isauth;

// -LIST
router.get('/allinstitucion/', isauth.isLoggedIn, isauth.isVip, async (Req, Res) => {
    const promises = [];

    promises.push(
        new Promise ((resolve, reject) => {  pool.query('SELECT * FROM institucion WHERE activo = 1', async (error, results) => {
            if(error){
                reject(error);
            }else{
                resolve(results);
            }
        })})
    );

    promises.push(
        new Promise ((resolve, reject) => {  pool.query('SELECT * FROM encargados', async (error, results) => {
            if(error){
                reject(error);
            }else{
                resolve(results);
            }
        })})
    );

    promises.push(
        new Promise ((resolve, reject) => {  pool.query('SELECT * FROM inst_enc', async (error, results) => {
            if(error){
                reject(error);
            }else{
                resolve(results);
            }
        })})
    );

    
    Promise.all(promises).then( (results) =>{
        if(results[2].length > 1){
            results[2].forEach(element => {
                results[0].find((single) => {  
                    if(single.CUE===element.CUE && single.ID_EST===element.ID_EST){
                        results[1].find((single2) => {  
                            if(single2.ID_ENCARGADO===element.ID_ENCARGADO){
                                if(single2.ID_TIPOENC == 1){
                                    single.nombre_director = single2.nombre;
                                    single.apellido_director = single2.apellido;
                                }else{
                                    single.nombre_inspector = single2.nombre;
                                    single.apellido_inspector = single2.apellido;      
                                }
                            }
                        });
                    }
                });
            });
        }

       // console.log(results[0]);
        Res.render('admin/allinstitucion', {ints: results[0]});

    });                                                     





});

// -ADD
router.get('/add/institucion', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => {
    pool.query('SELECT * FROM encargados',  async (error, results) => {
        if(error){
            throw error;
        }else{
            if(results.length){
                const directores = [];
                const inspectores = [];


                results.forEach(element => {
                    if(element.ID_TIPOENC == 1){
                        directores.push ( new Promise ((Resolve, Reject) => { 
                            
                            const TEL = new Promise ((Resolve, Reject) => { pool.query('SELECT * FROM enc_tel WHERE ID_ENCARGADO = ?', [element.ID_ENCARGADO], async (error, results) => {
                                if(results.length){
                                    pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[0].ID_TEL], (error, results) => {
                                        if (error) {
                                            Reject (error) ;
                                        } else {
                                            if (results.length) {
                                                Resolve (results[0]) ;
                                            }
                                        }
                                    });
                                } else {
									 Resolve({});
								}
                            })});


                            const EMAIL = new Promise ((Resolve, Reject) => {  pool.query('SELECT * FROM enc_email WHERE ID_ENCARGADO = ?', [element.ID_ENCARGADO], async (error, results) => {
                                if(results.length){
                                    pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[0].ID_EMAIL], (error, results) => {
                                        if (error) {
                                            Reject (error) ;
                                        } else {
                                            if (results.length) {
                                                Resolve (results[0]) ;
                                            } else {
												 Resolve({});
											}
                                        }
                                    });
                                } else{
									Resolve({});
								}
                            })});

                            Promise.all ([TEL, EMAIL]) .then (VALUES => {
                                Object.assign(element, VALUES[0]);
                                Object.assign(element, VALUES[1]);
                                Resolve(element);
                            })
                        })
                        );
                    
                    }else{
                        inspectores.push ( new Promise ((Resolve, Reject) => { 
                            
                            const TEL = new Promise ((Resolve, Reject) => { pool.query('SELECT * FROM enc_tel WHERE ID_ENCARGADO = ?', [element.ID_ENCARGADO], async (error, results) => {
                                if(results.length){
                                    pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[0].ID_TEL], (error, results) => {
                                        if (error) {
                                            Reject (error) ;
                                        } else {
                                            if (results.length) {
                                                Resolve (results[0]) ;
                                            } else {
												Resolve({});
											}
                                        }
                                    });
                                } else {
									Resolve({});
								}
                            })});


                            const EMAIL = new Promise ((Resolve, Reject) => {  pool.query('SELECT * FROM enc_email WHERE ID_ENCARGADO = ?', [element.ID_ENCARGADO], async (error, results) => {
                                if(results.length){
                                    pool.query('SELECT * FROM email WHERE ID_EMAIL = ?', [results[0].ID_EMAIL], (error, results) => {
                                        if (error) {
                                            Reject (error) ;
                                        } else {
                                            if (results.length) {
                                                Resolve (results[0]) ;
                                            } else {
												Resolve({});
											}
                                        }
                                    });
                                } else {
									Resolve({});
								}
                            })});

                            Promise.all ([TEL, EMAIL]) .then (VALUES => {
                                Object.assign(element, VALUES[0]);
                                Object.assign(element, VALUES[1]);
                                Resolve(element);
                            })
                        })
                        );
                    }
                });


                new Promise ((Resolve) => {

                    const director = new Promise ((Resolve) => { Promise.all (directores) . then (all => {
                        Resolve (all);
                    })});


                    const inspector = new Promise ((Resolve) => { Promise.all (inspectores) . then (all => {
                        Resolve (all);
                    })});


                    Promise.all ([director, inspector]) .then (values => {Resolve(values)});
                }).then(
                    ALL => {
                        Res.render('admin/institucion/addinstitucion', {director: ALL[0], inspector: ALL[1]});
                    }
                );


              
            }else{
                Res.render('admin/institucion/addinstitucion');
            }
        }
    });
});

router.post('/add/institucion', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => { 
    pool.query('SELECT * FROM institucion WHERE CUE = ? OR ID_EST = ?', [Req.body.CUE, Req.body.ESTABLECIMIENTO], async (error, resu) => {
        if(!resu.length){ 
            const Promises = [
                new Promise ((Resolve, Reject) => {
                    pool.query('INSERT INTO institucion (CUE, ID_EST, nombre_establecimiento, ID_MODALIDAD) VALUES (?, ?, ?, ?)', [Req.body.CUE, Req.body.ESTABLECIMIENTO, Req.body.nombre_escuela, Req.body.NIVEL],  async (error, results) => {
                        if (error) {
                            Reject (error) ;
                        } else {
                            if(Req.body.directores != null){
                                pool.query('INSERT INTO inst_enc (CUE, ID_EST, ID_ENCARGADO) VALUES (?, ?, ?)', [Req.body.CUE, Req.body.ESTABLECIMIENTO, Req.body.directores]);
                            }
            
                            if(Req.body.inspectores != null){
                                pool.query('INSERT INTO inst_enc (CUE, ID_EST, ID_ENCARGADO) VALUES (?, ?, ?)', [Req.body.CUE, Req.body.ESTABLECIMIENTO, Req.body.inspectores]);
                            }
    
                            
                            Resolve ([Req.body.CUE, Req.body.ESTABLECIMIENTO]);
                        }



                    });
                }), 

                new Promise ((Resolve, Reject) => {
                    pool.query('INSERT INTO domicilio (ID_LOCALIDAD, nmb_calle, nro_calle) VALUES (?, ?, ?)', [Req.body.LOCALIDAD, Req.body.nmb_calle, Req.body.nro_calle],  async (error, results) => {
                        if (error) {
                            Reject (error) ;
                        } else {
                            Resolve (results.insertId) ;
                        }
                    });
                }),

                new Promise ((Resolve, Reject) => {
                    pool.query('INSERT INTO telefono (telefono) VALUES (?)', [Req.body.telefono_escuela],  async (error, results) => {
                        if (error) {
                            Reject (error) ;
                        } else {
                            Resolve (results.insertId) ;
                        }
                    });
                })
            ];
            



            Promise.all (Promises).then (IDS => {
                pool.query('INSERT INTO inst_dom (CUE, ID_EST, ID_DOM) VALUES (?, ?, ?)', [IDS[0][0], IDS[0][1], IDS[1]]);
                pool.query('INSERT INTO inst_tel (CUE, ID_EST, ID_TEL) VALUES (?, ?, ?)', [IDS[0][0], IDS[0][1], IDS[2]]);
                Req.flash('success', 'Se creo la instutucón correctamente!');
                Res.redirect('/allinstitucion/');
            });
        }else{
            Req.flash('error', 'Esa institución ya esta creada con anterioridad!');
            Res.redirect('/allinstitucion/');
        }
    });
   
});

//-EDIT-//
router.get('/edit/institucion/:CUE/:ID_EST', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => {
    const { CUE, ID_EST } = Req.params;
    const promises = [];

    promises.push( new Promise ((Resolve) => {
                const micro_enc = [
                    new Promise((Resolve, Reject) => {
                        pool.query('SELECT * FROM `encargados` WHERE ID_TIPOENC = 1', (error, results) => {
                            if(error){
                                Reject(error);
                            }else{
                                Resolve(results);
                            }
                        })
                    }),
                    new Promise((Resolve, Reject) => {
                        pool.query('SELECT * FROM `encargados` WHERE ID_TIPOENC = 2', (error, results) => {
                            if(error){
                                Reject(error);
                            }else{
                                Resolve(results);
                            }
                        })
                    }),
                    new Promise((Resolve, Reject) => {
                        pool.query('SELECT * FROM `enc_tel`', (error, results) => {
                            if(error){
                                Reject(error);
                            }else{
                                const enc_tel_promise = [];
                                if(results.length){
                                    results.forEach(element => {
                                        enc_tel_promise.push(
                                            new Promise((Resolve, Reject) => {
                                                pool.query('SELECT * FROM `telefono` WHERE ID_TEL = ?', [element.ID_TEL], (error, results) => {
                                                    if(error){
                                                        Reject(error);
                                                    }else{
                                                        Object.assign(element, results[0]);
                                                        Resolve(element);
                                                    }
                                                })
                                            
                                            })
                                        );
                                    });

                                    Promise.all(enc_tel_promise).then(values => {Resolve(values)});
                                }else{
                                    Resolve();
                                }
                            }
                        })
                    }),
                    new Promise((Resolve, Reject) => {
                        pool.query('SELECT * FROM `enc_email`', (error, results) => {
                            if(error){
                                Reject(error);
                            }else{
                                const enc_email_promise = [];
                                if(results.length){
                                    results.forEach(element => {
                                        enc_email_promise.push(
                                            new Promise((Resolve, Reject) => {
                                                pool.query('SELECT * FROM `email` WHERE ID_EMAIL = ?', [element.ID_EMAIL], (error, results) => {
                                                    if(error){
                                                        Reject(error);
                                                    }else{
                                                        Object.assign(element, results[0]);
                                                        Resolve(element);
                                                    }
                                                })
                                            
                                            })
                                        );
                                    });
                                    Promise.all(enc_email_promise).then(values => {Resolve(values)});
                                }else{
                                    Resolve();
                                }
                            }
                        })
                    }),
                ];


                Promise.all(micro_enc).then(values => {
                    values[2].forEach(element => {
                        values[0].find(dir_single => {
                            if(element.ID_ENCARGADO === dir_single.ID_ENCARGADO ){
                                Object.assign(dir_single, element);
                            }
                        })

                        values[1].find(ins_single => {
                            if(element.ID_ENCARGADO === ins_single.ID_ENCARGADO ){
                                Object.assign(ins_single, element);
                            }
                        })
                    });

                    values[3].forEach(element => {
                        values[0].find(dir_single => {
                            if(element.ID_ENCARGADO === dir_single.ID_ENCARGADO ){
                                Object.assign(dir_single, element);
                            }
                        })

                        values[1].find(ins_single => {
                            if(element.ID_ENCARGADO === ins_single.ID_ENCARGADO ){
                                Object.assign(ins_single, element);
                            }
                        })
                    });

                    Resolve([values[0], values[1]]);
                });
    })
    );

    promises.push(
        new Promise ((Resolve, Reject) => {  pool.query('SELECT * FROM institucion WHERE CUE=? AND ID_EST=? ', [CUE, ID_EST],  (error, results) => {
            if(error){
                Reject (error);
            }else{
                if(results.length){
                    Resolve(results[0]);
                }else{
                    Reject('NOT FOUND');
                }   
            }
        })
        })
    );

    promises.push(
        new Promise ((Resolve, Reject) => {  pool.query('SELECT * FROM inst_dom WHERE CUE=? AND ID_EST=? ', [CUE, ID_EST],  (error, results) => {
            if(error){
                Reject (error);
            }else{
                if(results.length){
                    pool.query('SELECT * FROM domicilio WHERE  ID_DOM = ?', [results[0].ID_DOM],  (error, results) => {
                        Resolve(results[0]);
                    });
                }else{
                    Resolve({NULL: null});
                }   
            }
        })
        })
    );

    promises.push(
        new Promise ((Resolve, Reject) => {  pool.query('SELECT * FROM inst_tel WHERE CUE=? AND ID_EST=? ', [CUE, ID_EST],  (error, results) => {
            if(error){
                Reject (error);
            }else{
                if(results.length){
                    pool.query('SELECT * FROM telefono WHERE ID_TEL = ?', [results[0].ID_TEL],  (error, results) => {
                        Resolve(results[0]);
                    });
                }else{
                    Resolve({NULL: null});
                }   
            }
        })
        })
    );

    promises.push(
        new Promise ((Resolve, Reject) => {  pool.query('SELECT * FROM inst_enc WHERE CUE=? AND ID_EST=? ', [CUE, ID_EST],  (error, results) => {
            if(error){
                Reject (error);
            }else{
                if(results.length){
                    if(results.length > 1){
                        Resolve([results[0], results[1]]);
                    }else{
                        Resolve([results[0]]);
                    }
                }else{
                    Resolve([{NULL: null}]);
                }   
            }
        })
        })
    );

    Promise.all(promises).then(values => {
        Object.assign(values[1], values[2]);
        Object.assign(values[1], values[3]);
        Object.assign(values[1], values[4]);


        Res.render('admin/institucion/editinstitucion', {directores: values[0][0], inspectores: values[0][1],  institucion: values[1] })
    })

});

router.post('/edit/institucion/:CUE/:ID_EST', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => {
    //revisar
    const { CUE, ID_EST } = Req.params;
    const Promises = [];
    var isRep;

    if(Req.body.CUE === Req.params.CUE && Req.body.ESTABLECIMIENTO === Req.params.ID_EST){
        
        isRep = new Promise((Resolve, Reject) => {Resolve(0)})
        
    }else{
        
        isRep = new Promise((Resolve, Reject) => {
            //corregir
                pool.query('SELECT * FROM institucion WHERE CUE = ? OR ID_EST = ?', [Req.body.CUE, Req.body.ESTABLECIMIENTO], async (error, results) => {
                    if(error){
                        Reject(error);
                    }else{
                        Resolve(results.length);
                    }
                });
            })
        
    }

    Promise.resolve(isRep).then( values => {
        if(!values){
            //corregir
            Promises.push(
                new Promise((Resolve, Reject) => {
                    pool.query('SELECT * FROM inst_dom WHERE CUE = ? AND ID_EST = ?', [CUE, ID_EST], async (error, results) => {
                        if(error){
                            Reject(error);
                        }else{
                            if(results.length){
                                if(Req.body.nmb_calle != '' && Req.body.nro_calle != ''){
                                    pool.query('UPDATE `domicilio` SET `nmb_calle` = ?, `nro_calle` = ?, `ID_LOCALIDAD` = ? WHERE ID_DOM = ?', [Req.body.nmb_calle, Req.body.nro_calle, Req.body.LOCALIDAD, results[0].ID_DOM], (error) => {
                                        if(error){  
                                            Reject(error)
                                        }else{
                                            Resolve();
                                        }
                                    });
                                }else{
                                    pool.query('DELETE `domicilio` WHERE ID_DOM = ?', [results[0].ID_DOM]);
                                    pool.query('DELETE `inst_dom` WHERE CUE = ? AND ID_EST = ? AND ID_DOM = ?', [results[0].CUE, results[0].ID_EST, results[0].ID_DOM]);
                                    Resolve();
                                }   
                            }else{  
                                if(Req.body.nmb_calle != '' && Req.body.nro_calle != ''){
                                    pool.query('INSERT INTO domicilio (ID_LOCALIDAD, nmb_calle, nro_calle) VALUES (?, ?, ?)', [Req.body.LOCALIDAD, Req.body.nmb_calle, Req.body.nro_calle],  async (error, results) => {
                                        if(error){
                                            Reject(error);
                                        }else{
                                            pool.query('INSERT INTO inst_dom (CUE, ID_EST, ID_DOM) VALUES (?, ?, ?)', [CUE, ID_EST, results.insertId]);
                                            Resolve();
                                        }
                                    });
                                }
                            }
                        }
                    });
                })
            );


            Promises.push(
                new Promise((Resolve, Reject) => {
                    pool.query('SELECT * FROM `inst_tel` WHERE CUE = ? AND ID_EST = ?', [CUE, ID_EST], async (error, results) => {
                        if(error){
                            Reject(error);
                        }else{
                            if(results.length){
                                if(Req.body.telefono_escuela != ''){
                                    pool.query('UPDATE `telefono` SET `telefono` = ? WHERE ID_TEL = ?', [Req.body.telefono_escuela, results[0].ID_TEL], (error) => {
                                        if(error){  
                                            Reject(error)
                                        }else{                                                                                                  
                                            Resolve();
                                        }
                                    });
                                }else{
                                    pool.query('DELETE `telefono` WHERE ID_TEL = ?', [results[0].ID_TEL]);
                                    pool.query('DELETE `inst_tel` WHERE CUE = ? AND ID_EST = ? AND ID_TEL = ?', [results[0].CUE, results[0].ID_EST, results[0].ID_TEL]);
                                    Resolve();
                                }   
                            }else{  
                                if(Req.body.telefono_escuela != ''){
                                    pool.query('INSERT INTO telefono (telefono) VALUES (?)', [Req.body.telefono_escuela],  async (error, results) => {
                                        if(error){
                                            Reject(error);
                                        }else{
                                            pool.query('INSERT INTO inst_tel (CUE, ID_EST, ID_TEL) VALUES (?, ?, ?)', [CUE, ID_EST, results.insertId]);
                                            Resolve();
                                        }
                                    });
                                }
                            }
                        }
                    });
                })  
            );


            Promises.push(
                new Promise((Resolve, Reject) => {
                    pool.query('DELETE FROM `inst_enc` WHERE CUE = ? AND ID_EST = ?', [CUE, ID_EST], async (error) => {
                        if(error){
                            Reject(error);
                        }else{
                            let promise1, promise2;


                            if(Req.body.directores != ''){
                                promise1 = new Promise((Resolve, Reject) => {
                                    pool.query('INSERT INTO inst_enc (CUE, ID_EST, ID_ENCARGADO) VALUES (?,?,?) ', [Req.body.CUE, Req.body.ESTABLECIMIENTO, Req.body.directores], (error) => {
                                        if(error){
                                            Reject(error);
                                        }else{
                                            Resolve();
                                        }   
                                    });
                                });
                            }else{
                                promise1 = new Promise((Resolve, Reject) => {Resolve()});
                            }

                            if(Req.body.inspectores != ''){
                                promise2 = new Promise((Resolve, Reject) => {
                                    pool.query('INSERT INTO inst_enc (CUE, ID_EST, ID_ENCARGADO) VALUES (?,?,?) ', [Req.body.CUE, Req.body.ESTABLECIMIENTO, Req.body.inspectores], (error) => {
                                        if(error){
                                            Reject(error);
                                        }else{
                                            Resolve();
                                        }   
                                    });
                                });
                            }else{
                                promise2 = new Promise((Resolve, Reject) => {Resolve()});
                            }


                            Promise.all([promise1, promise2]).then(Resolve());
                        }
                    });
                })  
            );

            Promises.push(
                 new Promise((Resolve, Reject) => {
                    const INST = new Promise ((Resolve, Reject) => { pool.query('UPDATE `institucion` SET CUE = ?, ID_EST = ?, nombre_establecimiento = ?, ID_MODALIDAD = ? WHERE CUE=? AND ID_EST=?', [Req.body.CUE, Req.body.ESTABLECIMIENTO, Req.body.nombre_escuela, Req.body.NIVEL, CUE, ID_EST], async (error) => {
                        if(error){
                            Reject(error);
                        }else{
                           Resolve();
                        }
                    })})

                    const INST_DOM = new Promise ((Resolve, Reject) => { pool.query('UPDATE `inst_dom` SET CUE = ?, ID_EST = ? WHERE CUE=? AND ID_EST=?', [Req.body.CUE, Req.body.ESTABLECIMIENTO, CUE, ID_EST], async (error) => {
                        if(error){
                            Reject(error);
                        }else{
                           Resolve();
                        }
                    })})


                    const INST_TEL = new Promise ((Resolve, Reject) => { pool.query('UPDATE `inst_tel` SET CUE = ?, ID_EST = ? WHERE CUE=? AND ID_EST=?', [Req.body.CUE, Req.body.ESTABLECIMIENTO, CUE, ID_EST], async (error) => {
                        if(error){
                            Reject(error);
                        }else{
                           Resolve();
                        }
                    })})

                    Promise.all([INST, INST_DOM, INST_TEL]).then(Resolve())
                })  
            );


            Promise.all(Promises).then(function(){
                Req.flash('success', 'Se edito la instutucón correctamente!');
                Res.redirect('/allinstitucion/');
            });
        }else{
            Req.flash('error', 'Esa institución ya esta creada con anterioridad!');
            Res.redirect('/edit/institucion/'+CUE+'/'+ID_EST);
        }
    });
});

//-DELETE-//
router.get('/delete/institucion/:CUE/:ID_EST', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => {
    const {CUE, ID_EST} = Req.params;
   
    pool.query('UPDATE `institucion` SET `activo` = 0 WHERE CUE=? AND ID_EST=?', [CUE, ID_EST], (error) => {
        if(error){
            Req.flash('error', 'No se pudo editar la instutucón');
            Res.redirect('/allinstitucion/');
            throw error;
        }else{
            Req.flash('success', 'Se edito la instutucón correctamente!');
            Res.redirect('/allinstitucion/');
        }
    });
});


//-Encargados-//
router.get('/add/encargado', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => { 
    Res.render('admin/institucion/encargados/addencargado');
});
 
router.post('/add/encargado', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => { 
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
            }else{
                ENC_TEL.ID_ENCARGADO = results.insertId;
            }

            if(ENC_EMA.ID_EMAIL){
                ENC_EMA.ID_ENCARGADO = results.insertId;
                pool.query('INSERT INTO enc_email SET ?', [ENC_EMA]);
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
            }else{
                ENC_TEL.ID_TEL = results.insertId;
            }
        });
    }

    Res.redirect('/allinstitucion/');
});

module.exports = router;
