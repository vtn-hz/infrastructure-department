const express = require('express');
const router = express.Router();

router.get('/', (Req, Res) => {
    Res.render('index');
});


/*router.get('/about', (Req, Res) => {
    var obj = {
        vtn: "Valentino",
        gnd: "Franco",
        ctn: "Centauro"

    };

    const helpers = {
        loud:  (aString) => { 
            return aString.toUpperCase(); 
        }
    };

    Res.render('about', {
        obj,
        helpers
            
    });
});
*/
module.exports = router;