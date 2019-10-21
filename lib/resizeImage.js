var gm = require('gm').subClass({imageMagick: true});
var get = require('lodash/get')

var gmLimit = gm
module.exports = function resize(image, width, height, options) {
  var filetype = get(options, 'filetype', '').toLowerCase()
  if (filetype.indexOf('gif') > -1) {
    var streamImg = gm(image).coalesce()
    return gm(streamImg).limit('memory', '2GB')
.resize(width, height, '>').stream()
  } else if (filetype.indexOf('png') > -1) {
    return gm(image).limit('memory', '1GB').limit('map', '1GB')
.strip().resize(width, height, '>').stream();
  } else {
    return gm(image).limit('memory', '1GB').limit('map', '1GB')
.resize(width, height, '>').stream();
  }
}
