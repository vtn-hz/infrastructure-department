const { format } = require('timeago.js');
const num_let = require('jc_numeros_letras');

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
    if (!(date instanceof Date)) { return ''; }


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

helpers.toFormatDef =  (date) => {
    if (!(date instanceof Date)) { return ''; }

    let day = date.getDate();
    let month = date.getMonth()+1;
    let year = date.getFullYear();


    if(day<10){
        day = "0" + day;
    }

    if(month<10){
        month = "0" + month;
    }
    
    return year + "-" + month + "-" + day;
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

helpers.selectedornot = (value, inelement) => {
    if(inelement === undefined){
        return "";
    }else{
        if(inelement instanceof Array){
            if(inelement.includes(value)){
                return "selected";
            }
            return "";
        }else{
            if(value === inelement){
                return "selected";
            }
            return "";
        }
    }
}

helpers.timenow = () => {
    let date_ob = new Date(Date.now());
    let d = date_ob.getDate();
    let m = date_ob.getMonth() + 1;
    let y = date_ob.getFullYear();


    if(d<10){
        d = "0" + d;
    }

    if(m<10){
        m = "0" + m;
    }


    return y + "-" + m + "-" + d;
}

helpers.numtolet = (num) => {
    return num_let.numeros_letras(num);
}


module.exports = helpers;       