SaimaaUtil = require "./saimaa_util"
SaimaaDOM = require "./saimaa_dom"

class Saimaa
  constructor: (@source) ->
    @initEditor()
    @dom = new SaimaaDOM @editor

    @editor.addEventListener "keydown", (event) => @onKeyDown(event)
    @editor.addEventListener "keyup", (event) => @onKeyUp(event)

  initEditor: ->
    @editor = document.createElement "div"
    @editor.contentEditable = true
    @editor.className = @source.className

    @source.parentNode.insertBefore(@editor, @source)
    @source.style.display = "none"

  onKeyDown: (event) ->
    if @editor.children.length == 0
      @dom.formatBlock("p")
    else
      if event.keyCode == 13
#       event.preventDefault()
#       @newLine()
        "aaa"


  onKeyUp: (event) ->
    "bar"

module.exports = Saimaa