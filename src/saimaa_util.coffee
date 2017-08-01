module.exports =
  ie: ->
    ua = window.navigator.userAgent
    result = ua.match(/MSIE/) or ua.match(/Trident/)
    !!result

  ie11: ->
    document.documentMode == 11