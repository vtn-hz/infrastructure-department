module.exports = {
    router: require('express').Router(),
    pool: require('../../database'),
    isauth: require('../../helpers/isauth'),
};