h = require "h"

class SaimaaDOM
  constructor: (@editor) ->
    @lastNode = null

  caretNode: ->
    anchorNode = window.getSelection().anchorNode
    if anchorNode.nodeType == Node.TEXT_NODE
      anchorNode.parentNode
    else
      anchorNode

  formatBlock: (tag) ->
    @moveCaret @lastNode if @lastNode
    document.execCommand("formatBlock", false, tag)
    @saveLastNode()

  moveCaret: (node) ->
    window.getSelection().getRangeAt(0).setStartAfter node

  saveLastNode: ->
    if @editor != @caretNode() and @editor.contains @caretNode()
      @lastNode = @caretNode()

module.exports = SaimaaDOM
