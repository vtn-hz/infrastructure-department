const { format } = require('timeago.js');

const helpers = {};

helpers.timeago = (timestamp) => {
    return format(timestamp);
}

helpers.isVip = (rol) => {
    if(rol === 2){
        return true; 
    }

    return false;
}

helpers.toFormat =  (date) => {
    let day = date.getDate();
    let month = date.getMonth()+1;
    let year = date.getFullYear();


    if(day<10){
        day = "0" + day;
    }

    if(month<10){
        month = "0" + month;
    }
    
    return day + "/" + month + "/" + year;
}

helpers.checkornot = (value, inelement) => {
    if(inelement instanceof Array){
        if(inelement.includes(value)){
            return "checked";
        }
        return "";
    }else{
        if(value === inelement){
            return "checked";
        }
        return "";
    }
}

module.exports = helpers;       