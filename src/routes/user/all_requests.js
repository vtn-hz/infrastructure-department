const express = require('express');
const router = express.Router();

router.get('/allrequests', (Req, Res) => {
    Res.send('All petitions');
});

module.exports = router;