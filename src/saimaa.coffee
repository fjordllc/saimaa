h = require "h"
SaimaaUtil = require "./saimaa_util"
SaimaaDOM = require "./saimaa_dom"
SaimaaUI = require "./saimaa_ui"

class Saimaa
  constructor: (@source) ->
    @initEditor()
    @dom = new SaimaaDOM @editor
    @ui = new SaimaaUI @editor

    @editor.addEventListener "keydown", (event) => @onKeyDown event
    @editor.addEventListener "keyup", (event) => @onKeyUp event
    @editor.addEventListener "click", (event) => @onClick event

  initEditor: ->
    @editor = document.createElement "div"
    @editor.contentEditable = true
    @editor.className = @source.className

    @source.parentNode.insertBefore @editor, @source
    @source.style.display = "none"

  h2: (event) -> @dom.formatBlock "h2"
  h3: (event) -> @dom.formatBlock "h3"
  h4: (event) -> @dom.formatBlock "h4"
  ol: (event) -> @dom.changeOl()
  ul: (event) -> @dom.changeUl()
  bq: (event) -> @dom.changeBlockquote()

  clear: (event) ->
    document.execCommand "removeFormat", false
    @dom.formatBlock "p"
    document.execCommand "outdent", false

  newLine: ->
    if @dom.inP() and !@dom.inTitle()
      @dom.addBr()
    else
      @dom.appendP()

  onClick: (event) ->
    console.log event.target
    for child in @editor.children
      child.classList.remove "active"

    if @editor != event.target and @editor.contains(event.target)
      event.target.classList.add "active"

      @ui.blockUI.style.display = "flex"
      height = @ui.blockUI.clientHeight
      @ui.blockUI.style.top = "#{parseInt(event.target.offsetTop - height)}px"
      @ui.blockUI.style.left = "#{parseInt(event.target.offsetLeft)}px"

      @ui.h2.addEventListener "click", (event) => @h2 event
      @ui.h3.addEventListener "click", (event) => @h3 event
      @ui.h4.addEventListener "click", (event) => @h4 event
      @ui.ol.addEventListener "click", (event) => @ol event
      @ui.ul.addEventListener "click", (event) => @ul event
      @ui.bq.addEventListener "click", (event) => @bq event
      @ui.clear.addEventListener "click", (event) => @clear event

  onKeyDown: (event) ->

    if @editor.children.length == 0
      @dom.formatBlock("p")
      @dom.changeTitle()

    if event.keyCode == 13
     event.preventDefault()
     @newLine()

    @dom.afterDoubleBr()

    @dom.saveLastNode()

  onKeyUp: (event) ->
    "aaa"

module.exports = Saimaa