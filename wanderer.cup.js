var wanderer;
// Avoid conflicts with another version
if(typeof require('module')._extensions['.coffee']==='undefined'){
  require('coffee-script/register');
}
wanderer=require('./wanderer.coffee');

// d_| dripped

module.exports= wanderer;