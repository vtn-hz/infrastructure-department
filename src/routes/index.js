const express = require('express');
const router = express.Router();

router.get('/', (Req, Res) => {
    Res.send('Index');
});


router.get('/about', (Req, Res) => {
    Res.send('About');
});

module.exports = router;