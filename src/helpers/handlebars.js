const { format } = require('timeago.js');

const helpers = {};

helpers.timeago = (timestamp) =>{
    return format(timestamp);
}

helpers.isVip = (rol) => {
    if(rol === 2){
        return true; 
    }

    return false;
}

module.exports = helpers;