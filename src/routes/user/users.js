const express = require('express');
const router = express.Router();

router.get('/users/signin', (Req, Res) => {
    Res.render('users/signin');
});

router.get('/users/signup', (Req, Res) => {
    Res.render('users/signup');
});

router.post('/users/signin', (Req, Res) => {
    Res.send("nashe");
});

module.exports = router;