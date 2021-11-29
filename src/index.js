const express = require('express');
const path = require('path');
const exphbs = require('express-handlebars');
const methodOverride = require('method-override');
const session = require('express-session'); 
const helpers = require('./helpers/handlebars');
const flash = require('connect-flash');
const passport = require('passport');



// Initiliazations
const app = express();
require('./database');
require('./helpers/passport');

// Setting
app.set('port', process.env.PORT || 8000);
app.set('views', path.join(__dirname, 'views'));
app.set('layouts', path.join(app.get('views'), 'layouts'));
app.set('partials', path.join(app.get('layouts'), 'partials'));
app.engine('.hbs', exphbs({
    defaultLayout: 'main',
    layoutsDir: app.set('layouts'),
    partialsDir: app.get('partials'),
    extname: '.hbs',
    helpers: helpers
}));
app.set('view engine', 'hbs');


// Minddlewares
app.use(express.urlencoded({extended: false}));
app.use(methodOverride('_method'));
app.use(session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
}));
app.use(flash());
app.use(passport.initialize());
app.use(passport.session());

// Global Var
app.use((Req, Res, Next) =>{
    app.locals.success = Req.flash('success');
    app.locals.error = Req.flash('error');
    app.locals.user = Req.user;
    Next();
});

// Routes
app.use(require('./routes/index'));
app.use(require('./routes/auth'));
// User Routes
//app.use(require('./routes/user/users'));
// Admin Routes
app.use(require('./routes/admin/admin'));


// Static Files
app.use(express.static(path.join(__dirname, 'public')));



// Server is listening
app.listen(app.get('port'), () => {
    console.log('Server on port ', app.get('port'));
});