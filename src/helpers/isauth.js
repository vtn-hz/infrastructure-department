module.exports = {
    isLoggedIn(Req, Res, next){
        if (Req.isAuthenticated()) {
            return next();
        }   

        return Res.redirect('/signin');
    },


    isNotLoggedIn(Req, Res, next){
        if (Req.isAuthenticated()) {
            return Res.redirect('/profile');
        }   

        return next();
    },

    isNorm(Req, Res, next){
        if(Req.user.ID_ROL == 1){
            return next();
        }

        return Res.send('404');
    },

    isVip(Req, Res, next){
        if(Req.user.ID_ROL == 2){
            return next();
        }

        return Res.send('404');
    }

};