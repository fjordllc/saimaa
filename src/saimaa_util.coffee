class SaimaaUtil
  @ie = ->
    ua = window.navigator.userAgent
    ua.match(/MSIE/) or ua.match(/Trident/)
    if ie then true else false

  @ie11: ->
    document.documentMode == 11

module.exports = SaimaaUtil