const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const pool = require('../database');
const encdec  = require('../helpers/encryptPW');

passport.use('local.signin', new LocalStrategy({
        usernameField: 'name',
        passwordField: 'password',
        passReqToCallback: true
}, async (Req, username, password, done) => {
    const rows = await pool.query('SELECT * FROM user WHERE nombre = ?', [username]);
    if(rows.length > 0){
        const user = rows[0];
        console.log(user.password);
        console.log(password);
        const validPassword = await encdec.matchPassword(password, user.password);
        if(validPassword){
            done(null, user, Req.flash('success', 'Welcome '+ user.nombre));
        }else{
            done(null, false, Req.flash('error', 'Incorrect Password!'));
        }
    } else {
        return done(null, false, Req.flash('error', 'El nombre es incorrecto'));
    }
}));

/*passport.use('local.signup', new LocalStrategy({
    usernameField: 'name',
    passwordField: 'password',
    passReqToCallback: true
}, async (Req, username, password, done)=>{
    const {name} = Req.body;
    const newUser = {
        ID_ROL: 1,
        nombre: username,
        password
    };

    const rows = await pool.query('SELECT * FROM user WHERE nombre = ?', [username]);
    if(rows.length > 0){
        return done(null, false, Req.flash('error', 'Ese nombre ya esta en uso!'));
    }


    newUser.password = await encdec.encryptPassword(newUser.password);
    const result = await pool.query('INSERT INTO user SET ?', [newUser]);
    newUser.ID_USER = result.insertId;
    return done(null, newUser);
}));*/


passport.serializeUser((user, done) => {
    done(null, user.ID_USER);
});

passport.deserializeUser(async (ID, done) => {
    const rows = await pool.query('SELECT * FROM user WHERE ID_USER = ?', [ID]);
    done(null, rows[0]);
});