h = require "h"

class SaimaaUI
  constructor: (@editor) ->
    @createBlockUI()
    @createSelectUI()

  createBlockUI: ->
    @blockUI = h "div.saimaa-block-ui", { style: "display: none" }

    @h2 = h "div.saimaa-block-ui__action.is-h2", "H2"
    @blockUI.appendChild @h2

    @h3 = h "div.saimaa-block-ui__action.is-h3", "H3"
    @blockUI.appendChild @h3

    @h4 = h "div.saimaa-block-ui__action.is-h4", "H4"
    @blockUI.appendChild @h4

    @ol = h "div.saimaa-block-ui__action.is-ol", "OL"
    @blockUI.appendChild @ol

    @ul = h "div.saimaa-block-ui__action.is-ul", "UL"
    @blockUI.appendChild @ul

    @bq = h "div.saimaa-block-ui__action.is-bq", "BQ"
    @blockUI.appendChild @bq

    @clear = h "div.saimaa-block-ui__action.is-clear", "CLEAR"
    @blockUI.appendChild @clear

    @editor.parentNode.insertBefore(@blockUI, @editor.nextSibling)

  createSelectUI: ->
    @selectUI = h "div.saimaa-select-ui", { style: "display: none" }
    @editor.parentNode.insertBefore(@selectUI, @editor.nextSibling)

module.exports = SaimaaUI