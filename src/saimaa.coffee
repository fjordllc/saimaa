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
    @editor.contenteditable = true
    @editor.className = @source.className

    @source.parentNode.insertBefore(@editor, @source)
    @source.style.display = "none"

  onKeyDown: (event) ->
    "foo"

  onKeyUp: (event) ->
    "bar"

  foo: ->
    console.log "foo!!!"

module.exports = Saimaa