const express = require('express');
const router = express.Router();
const passport = require('passport');
const  isauth = require('../helpers/isauth');

router.get('/signup', isauth.isNotLoggedIn,(Req, Res) => {
    Res.render('auth/signup');
});

router.post('/signup', passport.
    authenticate('local.signup', {
        successRedirect: '/profile',
        failureRedirect: '/signup',
        failureFlash: true
  
}));

router.get('/signin', isauth.isNotLoggedIn,(Req, Res) => {
    Res.render('auth/signin');
});

router.post('/signin', (Req, Res, next) => {
    passport.authenticate('local.signin',{
        successRedirect: '/profile',
        failureRedirect: '/signin',
        failureFlash: true
    })(Req, Res, next);
});

router.get('/profile', isauth.isLoggedIn, (Req, Res) => {
    Res.render('users/profile');
});

router.get('/logout', (Req, Res) =>{
    Req.logOut();
    Res.redirect('/signin');
});

module.exports = router;