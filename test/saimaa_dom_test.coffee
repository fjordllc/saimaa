assert = require "assert"
h = require "h"
SaimaaDOM = require "../src/saimaa_dom"

describe "SaimaaDOM", ->
  beforeEach ->
    document.body.innerHTML = __html__["html/contenteditable.html"]
    @editor = document.querySelector ".is-wysiwyg"
    @saimaa = new SaimaaDOM @editor
    @editor.focus()
    @editor.innerHTML = ""

  it "add", ->
    @saimaa.add document.createTextNode "aaa"
    @saimaa.add document.createTextNode "bbb"
    @saimaa.add document.createTextNode "ccc"
    assert.equal @saimaa.html(), "aaabbbccc"

#  it "append", ->
#    div = h "div"
#    br = h "br"
#    div.appendChild br
#    @saimaa.append div
#    assert.equal @saimaa.html(), "<div><br></div>"
#
#  it "appendP", ->
#    @saimaa.appendP()
#    assert.equal @saimaa.html(), "<p><br></p>"
#
#    @saimaa.appendP()
#    assert.equal @saimaa.html(), "<p><br></p><p><br></p>"
#
#  it "appendLi", ->
#    @saimaa.appendLi()
#    assert.equal @saimaa.html(), "<li><br></li>"
#    @saimaa.appendLi()
#    assert.equal @saimaa.html(), "<li><br></li><li><br></li>"
#
#  it "changeH2", ->
#    @editor.innerHTML = "<p>aaa</p>"
#    @saimaa.changeH2()
#    assert.equal @saimaa.html(),"<h2>aaa</h2>"
#
#  it "changeH3", ->
#    @editor.innerHTML = "<p>aaa</p>"
#    @saimaa.changeH3()
#    assert.equal @saimaa.html(), "<h3>aaa</h3>"
#
#  it "changeH4", ->
#    @editor.innerHTML = "<p>aaa</p>"
#    @saimaa.changeH4()
#    assert.equal @saimaa.html(), "<h4>aaa</h4>"

  it "changeUl", ->
    @saimaa.changeUl()
    assert.equal @saimaa.html(),"<ul><li><br></li></ul>"

  it "changeOl", ->
    @saimaa.changeOl()
    assert.equal @saimaa.html(), "<ol><li><br></li></ol>"

  it "changeBlockquote", ->
    br = h "br"
    p = h "p", br
    @editor.appendChild p
    @saimaa.changeBlockquote()
    assert.equal @saimaa.html(), "<blockquote><br></blockquote>"

#  it "inLi", ->
#    br = h "br"
#    p = h "li", br
#    @saimaa.append p, br
#    assert @saimaa.inLi()
#
#  it "inBlankLi", ->
#    br = h "br"
#    p = h "li", br
#    @saimaa.append p, br
#    assert @saimaa.inBlankLi()
#
#  it "not inBlankLi", ->
#    text = document.createTextNode "aaa"
#    br = h "br"
#    p = h "li"
#    p.appendChild text
#    p.appendChild br
#    @saimaa.append p, br
#    assert.not @saimaa.inBlankLi()
#
#  it "inP", ->
#    @saimaa.appendP()
#    assert @saimaa.inP()
#
#  it "inTitle", ->
#    br = h "br"
#    p = h "p", br
#    p.className = "title"
#    @saimaa.append p, br
#    assert @saimaa.inTitle()
#
  it "tailBr", ->
    @saimaa.appendP()
    assert @saimaa.tailBr()
#
#  it "not tailBr", ->
#    p = h "p", "aaa"
#    @editor.appendChild p
#    window.getSelection().getRangeAt(0).setStartAfter p
#    assert.not @saimaa.tailBr()

  it "caretLeft", ->
    @saimaa.appendP()
    range = window.getSelection().getRangeAt 0
    assert.deepEqual @saimaa.caretLeft().outerHTML, "<br>"

  it "caretRightAll", ->
    p = h "p"
    aaa = document.createTextNode "aaa"
    bbb = document.createTextNode "bbb"
    ccc = document.createTextNode "ccc"
    br = h "br"
    br2 = h "br"
    p.appendChild aaa
    p.appendChild br
    p.appendChild bbb
    p.appendChild br2
    p.appendChild ccc
    @editor.appendChild p
    window.getSelection().getRangeAt(0).setStartAfter br
    assert.deepEqual @saimaa.caretRightAll(), [br2, ccc]

  it "removeCaretRightAll", ->
    p = h "p"
    aaa = document.createTextNode "aaa"
    bbb = document.createTextNode "bbb"
    ccc = document.createTextNode "ccc"
    br = h "br"
    br2 = h "br"
    p.appendChild aaa
    p.appendChild br
    p.appendChild bbb
    p.appendChild br2
    p.appendChild ccc
    @editor.appendChild p
    window.getSelection().getRangeAt(0).setStartAfter br
    assert.deepEqual @saimaa.removeCaretRightAll(), [br2, ccc]