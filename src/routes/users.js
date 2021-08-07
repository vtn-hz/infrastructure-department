const express = require('express');
const router = express.Router();

router.get('user/signin', (Req, Res) => {
    Res.send('Ingresando a la app');
});

router.get('user/singup', (Req, Res) => {
    Res.send('Formularia de auth');
});

module.exports = router;