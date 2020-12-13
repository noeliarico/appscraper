var gplay = require('google-play-scraper');

gplay.app({appId: process.argv[2]})
  .then(JSON.stringify).then(console.log);
