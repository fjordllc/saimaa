SaimaaDOM = require "../src/saimaa_dom"

assert = (expr) ->
  expect(expr).toBe(true)

assertEqual = (expected, actual) ->
  expect(expected).toEqual(actual)

showCaret = ->
  selection = window.getSelection()
  if selection.rangeCount > 0
    range = selection.getRangeAt(0)
    console.log "anchor", selection.anchorNode, "start", range.startContainer, range.startOffset, "end", range.endContainer, range.endOffset
  else
    console.log "no range."

describe "SaimaaDOM", ->
  beforeEach ->
    document.body.innerHTML = __html__["html/contenteditable.html"]
    @editor = document.querySelector ".is-wysiwyg"
    @saimaa = new SaimaaDOM @editor
    @editor.focus()

  it "add", ->
    @saimaa.add document.createTextNode "aaa"
    @saimaa.add document.createTextNode "bbb"
    @saimaa.add document.createTextNode "ccc"
    assertEqual  @saimaa.html(), "aaabbbccc"

  it "append", ->
    div = document.createElement "div"
    br = document.createElement "br"
    div.appendChild br
    @saimaa.append div
    assertEqual @saimaa.html(), "<div><br></div>"

  it "appendP", ->
    @saimaa.appendP()
    assertEqual @saimaa.html(), "<p><br></p>"


  it "appendLi", ->
    @saimaa.appendLi()
    assertEqual @saimaa.html(), "<li><br></li>"

  it "changeOl", ->
    @saimaa.changeOl()
    assertEqual @saimaa.html(),"<ol><li><br></li></ol>"
    assertEqual @saimaa.caretNode().outerHTML,"<li><br></li>"

  it "changeH2", ->
    @editor.innerHTML = "<p>aaa</p>"
    @saimaa.changeH2()
    assertEqual @saimaa.html(),"<h2>aaa</h2>"

  it "changeH3", ->
    @editor.innerHTML = "<p>aaa</p>"
    @saimaa.changeH3()
    assertEqual @saimaa.html(), "<h3>aaa</h3>"

  it "changeH4", ->
    @editor.innerHTML = "<p>aaa</p>"
    @saimaa.changeH4()
    assertEqual @saimaa.html(), "<h4>aaa</h4>"

  it "changeUl", ->
    @saimaa.changeUl()
    assertEqual @saimaa.html(),"<ul><li><br></li></ul>"
    assertEqual @saimaa.caretNode().outerHTML, "<li><br></li>"

  it "changeOl", ->
    @saimaa.appendP()
    @saimaa.changeOl()
    assertEqual @saimaa.html(), "<ol><li><br></li></ol>"
    assertEqual @saimaa.caretNode().outerHTML, "<li><br></li>"

  it "inLi", ->
    expect(@saimaa.inLi()).toBe(false)
    @saimaa.append(document.createElement("li"))
    assert @saimaa.inLi()

  it "inP", ->
    @saimaa.appendP()
    assert @saimaa.inP()

  it "inTitle", ->
    p = document.createElement("p")
    p.className = "titg stle"
    @saimaa.append(p)
    assert @saimaa.inTitle()