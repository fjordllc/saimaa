// Generated by CoffeeScript 1.12.7
(function() {
  module.exports = {
    ie: function() {
      var result, ua;
      ua = window.navigator.userAgent;
      result = ua.match(/MSIE/) || ua.match(/Trident/);
      return !!result;
    },
    ie11: function() {
      return document.documentMode === 11;
    }
  };

}).call(this);