const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const pool = require('../database');
const encdec  = require('../helpers/encryptPW');

passport.use('local.signin', new LocalStrategy({
        usernameField: 'email',
        passwordField: 'password',
        passReqToCallback: true
}, async (Req, username, password, done) => {
    const rows = await pool.query('SELECT * FROM users WHERE email = ?', [username]);
    if(rows.length > 0){
        const user = rows[0];
        const validPassword = await encdec.matchPassword(password, user.password);
        
        if(validPassword){
            done(null, user, Req.flash('success', 'Welcome '+user.Nombre));
        }else{
            done(null, false, Req.flash('error', 'Incorrect Password!'));
        }
    } else {
        return done(null, false, Req.flash('error', 'El email es incorrecto'));
    }
}));

passport.use('local.signup', new LocalStrategy({
    usernameField: 'email',
    passwordField: 'password',
    passReqToCallback: true
}, async (Req, username, password, done)=>{
    const {name, rol} = Req.body;
    const newUser = {
        Nombre: name,
        Rol: rol,
        Email: username,
        password
    };

    const rows = await pool.query('SELECT * FROM users WHERE email = ?', [username]);
    if(rows.length > 0){
        return done(null, false, Req.flash('error', 'Ese email ya esta en uso!'));
    }

    newUser.password = await encdec.encryptPassword(newUser.password);
    const result = await pool.query('INSERT INTO users SET ?', [newUser]);
    newUser.ID = result.insertId;
    return done(null, newUser);
}));


passport.serializeUser((user, done) => {
    done(null, user.ID);
});

passport.deserializeUser(async (ID, done) => {
    const rows = await pool.query('SELECT * FROM users WHERE id = ?', [ID]);
    done(null, rows[0]);
});