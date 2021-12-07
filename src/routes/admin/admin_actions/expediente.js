const requires = require('../admin_requires');
const router   =  requires.router;
const pool     =  requires.pool;
const isauth   =  requires.isauth;

// -Lista-
router.get('/allexpediente/',  isauth.isLoggedIn, isauth.isVip, async (Req, Res) => { 
    const promises = [];


    promises.push (new Promise( (resolve, reject) => {
                pool.query('SELECT * FROM expediente WHERE activo = 1', (error, results) => {
                    if(error){
                        reject(error);
                    }else{
                        resolve(results);
                    }
                });

            })
    );

    promises.push (new Promise( (resolve, reject) => {
            pool.query('SELECT * FROM obra', (error, results) => {
                if(error){
                    reject(error);
                }else{
                    resolve(results);
                }
            });
        })
    );

   promises.push (new Promise( (resolve, reject) => {
        pool.query('SELECT * FROM exp_con', (error, results) => {
            if(error){
                reject(error);
            }else{
                const promises_expcon = [];
                if(results.length){
                    if(results.length > 1){
                        results.forEach(element => {
                            promises_expcon.push(
                                new Promise((res, rej) => {
                                    pool.query('SELECT * FROM contratista WHERE ID_CONT = ? AND activo = 1', [element.ID_CONT], (error, results) => {
                                        if(error){
                                            rej(error);
                                        }else{
                                            if(results.length){
                                                Object.assign(element, results[0]);
                                            }

                                            pool.query('SELECT * FROM contratista_nombre WHERE ID_CONTN = ?', [element.ID_CONTN], (error, results) => {
                                                if(error){
                                                    rej(error);
                                                }else{
                                                    if(results.length){
                                                        Object.assign(element, results[0]);
                                                    }

                                                    res(element);
                                                }
                                            })
                                        }
                                    })
                                })
                            );
                        });
                    }
                }else{
                    resolve();
                }


                Promise.all(promises_expcon).then((v)=>{
                    resolve(v);
                });
            }
        });
      })
    );

    promises.push ( new Promise ((resolve, reject) => {
        pool.query ('SELECT * FROM nro_orden', (error, results) => {
            if (error) {
                reject (error);
            } else {
                resolve (results);
            }
        }) 
    })
    );

    Promise.all(promises).then(values => {
        if(values[0].length){
            values[0].forEach(element => {
                values[1].find((single) => {
                    if(element.ID_OBRA === single.ID_OBRA){
                        Object.assign(element, single);
                    }
                })

                values[2].find((single) => {
                    if(element.ID_EXP === single.ID_EXP){
                        Object.assign(element, single);
                    }
                })



                values[3].find((single) => {
                    if(element.ID_NRORD === single.ID_NRORD_AI){
                        Object.assign(element, single);
                    }
                })
            });

        Res.render('admin/allexpediente', {expedientes: values[0]});
        }else{
          Res.render('admin/allexpediente');
        }
    });
});



//-ADD
router.get('/add/expediente', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => { 
    const promises = [];


    promises.push (new Promise( (resolve, reject) => {
                pool.query('SELECT * FROM institucion WHERE activo = 1', (error, results) => {
                    if(error){
                        reject(error);
                    }else{
                        resolve(results);
                    }
                });

            })
    );
    

            


    promises.push (new Promise( (resolve, reject) => {
        pool.query('SELECT * FROM contratista WHERE activo = 1', async (error, results) => {
                if(error){
                    reject(error);
                }else if(results.length){
                    const name_promises = [];
                    if(results.length > 1){
                        results.forEach(element => {
                            name_promises.push(
                                new Promise( (resolve, reject) => {
                                    pool.query('SELECT * FROM contratista_nombre WHERE ID_CONTN = ?', [element.ID_CONTN], (error, results) => {
                                        if(error){
                                            reject(error);
                                        }else{
                                            if(results.length){
                                                element.cont_name = results[0].nombre + " " +  results[0].apellido;
                                                resolve(true);
                                            }else {
                                                resolve();
                                            }
                                        }
                                    });
                                })
                            )
                        });      
                    }else{
                        name_promises.push(
                            new Promise( (resolve, reject) => {
                                pool.query('SELECT * FROM contratista_nombre WHERE ID_CONTN = ?', [results[0].ID_CONTN], (error, res) => {
                                    if(error){
                                        reject(error);
                                    }else{
                                        if(res.length){
                                            results[0].cont_name = res[0].nombre + " " +  res[0].apellido;
   
                                            
                                            resolve(true);
                                        }else {
                                            resolve();
                                        }
                                    }
                                });
                            })
                        )
                    }

                    Promise.all(name_promises).then(() => {
                        resolve(results);
                    });
                }else{
                    resolve();
                }
        })
    }));


    promises.push(
        new Promise((resolve, reject) =>{
            pool.query('SELECT * FROM tipo_oficina', async (error, results) => {
                if(error){
                    reject(error);
                }else{
                    resolve(results);
                }
            })
        })
    );


    // :)
    Promise.all(promises).then(values => {
        const  inst = values[0];
        const contratista = values[1];
        const oficina = values[2];

        Res.render('admin/expediente/addexpediente', {inst, contratista, oficina});
    });
});

router.post('/add/expediente', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => { 
    if(
    Req.body.fecha_pedido != '' &&
    Req.body.fecha_contrato != '' &&
    Req.body.ID_OFICINA != '' &&
    Req.body.obra_realizada != '' &&
    Req.body.ID_CONTRATACION != '' &&
    Req.body.ID_FONDO != '' &&
    Req.body.monto_numeros != '' &&
    Req.body.inst != '' &&
    Req.body.contratista != '' &&
    Req.body.presupuesto_entreado != '' &&
    Req.body.ID_ESTADO != ''
    ){

    const promises = [];
    const inst = Req.body.inst.split("###");

   promises.push (new Promise( (resolve, reject) => {
        const year = new Date(Req.body.fecha_pedido).getFullYear();
        pool.query('SELECT * FROM `exp_pk` WHERE `anio_expediente` = ? ORDER BY	`ID_EXP_AU` DESC;', [year], (error, results) => {
            if(error){
                reject(error);
            }else{
                var ID_EXP;
                var num_exp;
                if(results.length){
                    num_exp = results[0].nro_expediente+1;
                    ID_EXP =  num_exp+"|"+year;
                }else{
                    num_exp = 1;
                    ID_EXP =  num_exp+"|"+year;
                }

                //console.log(results[0]);


                pool.query('INSERT INTO exp_pk (ID_EXP, nro_expediente, anio_expediente	) VALUES (?, ?, ?)', [ID_EXP, num_exp, year], (error) => {
                    if(error){
                        reject(error);
                    }else{
                        resolve(ID_EXP);
                    }
                });

            }

        });

        })
    );
    
    promises.push (new Promise( (resolve, reject) => {
        const year = new Date(Req.body.fecha_pedido).getFullYear();
        const month = new Date(Req.body.fecha_pedido).getMonth()+1;
        var nro_orden;
        pool.query('SELECT * FROM `nro_orden` WHERE `anio_orden` = ? AND `mes_orden` = ? ORDER BY `ID_NRORD_AI` DESC;', [year, month], (error, results) => {
            if(error){
                reject(error);
            }else{
                if(results.length){
                    nro_orden = results[0].nro_orden+1;
                }else{
                    nro_orden = 1;
                }
            }

           pool.query('INSERT INTO nro_orden (nro_orden, anio_orden, mes_orden) VALUES (?, ?, ?)', [nro_orden, year, month], (error, results) => {
                if(error){
                    reject(error);
                }else{
                    resolve(results.insertId);
                }
            });
            
        });

        })
    );
            

    var single_promise = new Promise((res) => {res();});;
    promises.push (new Promise( (resolve, reject) => {
        if(Req.body.ID_OFICINA === 'otro' && Req.body.otra_oficina != ''){
            if(Req.body.otra_oficina === '' || Req.body.otra_oficina === undefined) {
                reject('Es obligatoria la oficina'); 
                Req.flash('error', 'Es obligatoria la oficina');
                Res.redirect('/add/expediente');
            }

            single_promise = new Promise ((res, rej) => { pool.query('INSERT INTO tipo_oficina (tipo) VALUES (?)', [Req.body.otra_oficina], (error, results) => {
                    if(error){
                        rej(error);
                    }else{
                        res(results.insertId);
                    }
                })
            })
        }


        const OBRA = {
            ID_ESTADO: Req.body.ID_ESTADO,
            fecha_contrato: Req.body.fecha_contrato,
            monto_numeros: Req.body.monto_numeros,
            ID_CONTRATACION: Req.body.ID_CONTRATACION,
            obra_realizada: Req.body.obra_realizada,
            ID_FONDO: Req.body.ID_FONDO,
            ID_OFICINA: Req.body.ID_OFICINA,
        }


        single_promise.then( ID_FONDO => {
            if(ID_FONDO){
                OBRA.ID_OFICINA = ID_FONDO;
            }   



            pool.query('INSERT INTO obra SET ?', [OBRA], (error, results) => {
                if(error){
                    reject(error);
                }else{
                    if(Req.body.fecha_garantia != ''){
                        pool.query('INSERT INTO fecha_garantia (ID_OBRA, fecha_garantia) VALUES (?, ?)', [results.insertId, Req.body.fecha_garantia]);
                    }

                    resolve(results.insertId);
                }
            });
        })

        })
    );

    // :)
    Promise.all(promises).then(IDS => {
        const EXP = {
            ID_EXP: IDS[0],
            ID_NRORD: IDS[1],
            fecha_pedido: Req.body.fecha_pedido,
            informe_tecnico:Req.body.informe_tecnico,
            postpone_date:(Req.body.postpone_date === '')? null : Req.body.postpone_date,
            CUE:inst[0],
            ID_EST: inst[1],
            ID_OBRA:IDS[2],
            ID_ESTADO:Req.body.ID_ESTADO
        }

        if(Req.body.contratista != null) { pool.query('INSERT INTO exp_con (ID_CONT, ID_EXP, presupuesto_entregado) VALUES (?, ?, ?)', [Req.body.contratista, IDS[0], Req.body.presupuesto_entregado]); }
        pool.query('INSERT INTO expediente SET ?', [EXP], (error, results) => {
            if(error){
                throw error;
            }else{
                Req.flash('success', 'Se creo el expediente correctamente...');
                Res.redirect('/allexpediente/');
            }
        });
    });

    }else{  
        Req.flash('error', 'Ingrese todos los datos requeridos!');
        Res.redirect('/add/expediente');
    }

});

//-EDIT-//
router.get('/edit/expediente/:ID_EXP', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => { 
    const promises = [];
    const ID_EXP = Req.params.ID_EXP;


    promises.push (new Promise( (resolve, reject) => {
                pool.query('SELECT * FROM institucion WHERE activo = 1', (error, results) => {
                    if(error){
                        reject(error);
                    }else{
                        if(results.length){
                            resolve(results);
                        }
                    }
                });

            })
    );
    

            


    promises.push (new Promise( (resolve, reject) => {
        pool.query('SELECT * FROM contratista WHERE activo = 1', async (error, results) => {
                if(error){
                    reject(error);
                }else if(results.length){
                    const name_promises = [];
                    if(results.length > 1){
                        results.forEach(element => {
                            name_promises.push(
                                new Promise( (resolve, reject) => {
                                    pool.query('SELECT * FROM contratista_nombre WHERE ID_CONTN = ?', [element.ID_CONTN], (error, results) => {
                                        if(error){
                                            reject(error);
                                        }else{
                                            if(results.length){
                                                element.cont_name = results[0].nombre + " " +  results[0].apellido;
                                                resolve(true);
                                            }
                                        }
                                    });
                                })
                            )
                        });      
                    }else{
                        name_promises.push(
                            new Promise( (resolve, reject) => {
                                pool.query('SELECT * FROM contratista_nombre WHERE ID_CONTN = ?', [results[0].ID_CONTN], (error, results) => {
                                    if(error){
                                        reject(error);
                                    }else{
                                        if(results.length){
                                            results[0].cont_name = results[0].nombre + " " +  results[0].apellido;
                                            resolve(results);
                                        }
                                    }
                                });
                            })
                        )
                    }

                    Promise.all(name_promises).then(() => {
                        resolve(results);
                    });
                }
        })
    }));


    promises.push(
        new Promise((resolve, reject) =>{
            pool.query('SELECT * FROM tipo_oficina', async (error, results) => {
                if(error){
                    reject(error);
                }else{
                    resolve(results);
                }
            })
        })
    );

    promises.push(
        new Promise((resolve, reject) =>{
            pool.query('SELECT * FROM expediente WHERE ID_EXP = ?', [ID_EXP], async (error, results) => {
                if(error){
                    reject(error);
                }else{
                    const ret_obj = {};
                    if (results.length > 0) {
                        Object.assign(ret_obj, results[0]);
                        pool.query('SELECT * FROM obra WHERE ID_OBRA = ?', [results[0].ID_OBRA], async (error, res) => {
                                if(error){
                                    throw error;
                                }else{
                                    if ( res.length > 0) { 
                                        Object.assign(ret_obj, res[0]);
                                        pool.query('SELECT * FROM fecha_garantia WHERE ID_OBRA = ?', [res[0].ID_OBRA], async (error, r) => {
                                            if(error){
                                                throw error;
                                            }else{
                                                if (r.length > 0) {
                                                    Object.assign(ret_obj, r[0]);
                                                } resolve (ret_obj) ;
                                            }
                                        })
                                    } else {
                                        resolve (ret_obj) ;
                                    }
                                }

                        })
                    } else {
                        resolve (ret_obj) ;
                    }
  
                }
            })
        })
    );

    promises.push(
        new Promise((resolve, reject) =>{
            pool.query('SELECT * FROM exp_con WHERE ID_EXP = ?', [ID_EXP], async (error, results) => {
                if(error){
                    reject(error);
                }else{
                    resolve(results[0]);
                }
            })
        })
    );
    

    // :)
    Promise.all(promises).then(values => {
        const  inst = values[0];
        const contratista = values[1];
        const oficina = values[2];

        const EXP = values [3];
        Object.assign(EXP,  values [4]);



        
        Res.render('admin/expediente/editexpediente', {inst, contratista, oficina, EXP});
    });
});

router.post('/edit/expediente/:ID_EXP', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => {
    if(
        Req.body.fecha_pedido != '' &&
        Req.body.fecha_contrato != '' &&
        Req.body.ID_OFICINA != '' &&
        Req.body.obra_realizada != '' &&
        Req.body.ID_CONTRATACION != '' &&
        Req.body.ID_FONDO != '' &&
        Req.body.monto_numeros != '' &&
        Req.body.inst != '' &&
        Req.body.contratista != '' &&
        Req.body.presupuesto_entreado != '' &&
        Req.body.ID_ESTADO != ''
    )   {
        
        const FIR_IDEXP = Req.params.ID_EXP;
        const promises = [];
        const inst = Req.body.inst.split("###");
    

        


        const Single = new Promise ((Resolve, Reject) => {
            pool.query('SELECT * FROM expediente WHERE ID_EXP = ?', [FIR_IDEXP], (error, results) => {
                if (error) {
                    Reject (error) ;
                } else {
                    if (!results.length) {
                        Reject ("No se encuentran los valores") ;
                    } else {
                        Resolve (results[0]) ;
                    }
                    
                }
            })
        }).then(
            
            EXP => {
                var single_promise = new Promise((res) => {res();});;
                promises.push (new Promise( (resolve, reject) => {
                    if(Req.body.ID_OFICINA === 'otro' && Req.body.otra_oficina != ''){
                        if(Req.body.otra_oficina === '' || Req.body.otra_oficina === undefined) {

                            reject('Es obligatoria la oficina'); 
                            Req.flash('error', 'Es obligatoria la oficina');
                            Res.redirect('/add/expediente');
                        }
            
                        single_promise = new Promise ((res, rej) => { pool.query('INSERT INTO tipo_oficina (tipo) VALUES (?)', [Req.body.otra_oficina], (error, results) => {
                                if(error){
                                    rej(error);
                                }else{
                                    res(results.insertId);
                                }
                            })
                        })
                    }
            
            
                    const OBRA = {
                        ID_ESTADO: Req.body.ID_ESTADO,
                        fecha_contrato: Req.body.fecha_contrato,
                        monto_numeros: Req.body.monto_numeros,
                        ID_CONTRATACION: Req.body.ID_CONTRATACION,
                        obra_realizada: Req.body.obra_realizada,
                        ID_FONDO: Req.body.ID_FONDO,
                        ID_OFICINA: Req.body.ID_OFICINA,
                    }
            
            
                    single_promise.then( ID_FONDO => {
                        if(ID_FONDO){
                            OBRA.ID_OFICINA = ID_FONDO;
                        }   
            

            
            
                        pool.query('UPDATE obra SET ? WHERE ID_OBRA = ?', [OBRA, EXP.ID_OBRA], (error, results) => {
                            if(error){
                                reject(error);
                            }else{            
                                resolve(EXP.ID_OBRA);
                            }
                        });
                    })
            
                    })
                );


                promises.push (
                    new Promise ((Resolve, Reject) => {
                        pool.query('SELECT * FROM fecha_garantia WHERE ID_OBRA = ? ', [EXP.ID_OBRA], (error, results) => {
                            if (error) {
                                Reject (error) ;
                            } else {
                                if (results.length) {
                                    if(Req.body.fecha_garantia != ''){
                                        pool.query('UPDATE fecha_garantia SET fecha_garantia = ? WHERE ID_OBRA = ?', [Req.body.fecha_garantia, EXP.ID_OBRA]);
                                    } else {
                                        pool.query('DELETE FROM fecha_garantia WHERE ID_OBRA = ?', [EXP.ID_OBRA]);
                                    }
                                } else {
                                    if(Req.body.fecha_garantia != ''){
                                        pool.query('INSERT INTO fecha_garantia (ID_OBRA, fecha_garantia) VALUES (?, ?)', [EXP.ID_OBRA, Req.body.fecha_garantia]);
                                    }
                                }


                                Resolve();
                            }
                        })
                    })
                ) ;  

                Promise.all(promises).then(IDS => {
                    const EXP = {
                        informe_tecnico:Req.body.informe_tecnico,
                        postpone_date:(Req.body.postpone_date === '')? null : Req.body.postpone_date,
                        CUE:inst[0],
                        ID_EST:inst[1],
                        ID_OBRA:IDS[0],
                        ID_ESTADO:Req.body.ID_ESTADO
                    }
                    //console.log(EXP);
                    const one = new Promise ((Resolve, Reject) => {
                        pool.query('SELECT * FROM exp_con WHERE ID_EXP = ?', [FIR_IDEXP], (error, results) => {
                            if (error) {
                                throw error;
                            } else {
                                if (results.length) {
                                    pool.query('UPDATE exp_con SET ID_CONT = ?, ID_EXP = ?, presupuesto_entregado = ? WHERE ID_EXP = ?', [Req.body.contratista, FIR_IDEXP, Req.body.presupuesto_entregado, FIR_IDEXP], (error) => {
                                        Resolve();
                                    });
                                } else {
                                    pool.query('INSERT INTO exp_con (ID_CONT, ID_EXP, presupuesto_entregado) VALUES (?, ?, ?)', [Req.body.contratista, FIR_IDEXP, Req.body.presupuesto_entregado], (error) => {
                                        Resolve();
                                    });
                                }
                            }
                        });
                   
                        
                        
                    })

                    pool.query('UPDATE expediente SET ? WHERE ID_EXP = ?', [EXP, FIR_IDEXP], (error) => {
                        if(error){
                            throw error;
                        }else{
                            Promise.resolve(one).then(function(){
                                Req.flash('success', 'Se modifico el expediente correctamente...');
                                Res.redirect('/allexpediente/');
                            })

                        }
                    });
                });
            


            }
        )
    
    }else{  
        Req.flash('error', 'Ingrese todos los datos requeridos!');
        Res.redirect('/add/expediente');
    }
    
});

//-DELETE-//
router.get('/delete/expediente/:ID_EXP', isauth.isLoggedIn, isauth.isVip,async (Req, Res) => {
    const ID = Req.params.ID_EXP;
    pool.query('UPDATE expediente SET activo = 0 WHERE ID_EXP = ?', [ID], function(error) {
        if (error){ throw error; }
        else {
            Req.flash('success', 'Se elimino el expediente correctamente...');
            Res.redirect('/allexpediente/');
        }
    })
});




module.exports = router;