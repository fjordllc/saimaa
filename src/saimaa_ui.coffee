h = require "h"

class SaimaaUI
  constructor: (@editor) ->
    @createBlockUI()
    @createSelectionUI()

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

  createSelectionUI: ->
    @selectionUI = h "div.saimaa-selection-ui", { style: "display: none" }

    @strong = h "div.saimaa-selection-ui__action", "B"
    @selectionUI.appendChild @strong

    @em = h "div.saimaa-selection-ui__action", "EM"
    @selectionUI.appendChild @em

    @strike = h "div.saimaa-selection-ui__action", "S"
    @selectionUI.appendChild @strike

    @linkText = h "input#link_text.saimaa-selection-ui__action"
    @linkText.type = "text"
    @selectionUI.appendChild @linkText

    @link = h "div#link.saimaa-selection-ui__action", "LINK"
    @selectionUI.appendChild @link

    @editor.parentNode.insertBefore(@selectionUI, @editor.nextSibling)

module.exports = SaimaaUI