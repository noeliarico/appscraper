var gplay = require('google-play-scraper');

gplay.search({
    term: process.argv[2],
    num: process.argv[3],
    lang: process.argv[4],
    country: process.argv[5],
    fullDetail: process.argv[6],
    price: process.argv[7]
}).then(JSON.stringify).then(console.log);

