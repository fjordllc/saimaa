SaimaaDOM = require "../src/saimaa_dom"

describe "SaimaaDOM", ->
  beforeEach ->
    document.body.innerHTML = __html__["html/contenteditable.html"]
    @editor = document.querySelector ".is-wysiwyg"
    @saimaa = new SaimaaDOM @editor
    @editor.focus()
    @editor.innerHTML = "<p><br></p>"

  it "append", ->
    div = document.createElement "div"
    br = document.createElement "br"
    div.appendChild br
    @saimaa.append div
    expect @saimaa.html()
      .toEqual "<p><br></p><div><br></div>"
    expect @saimaa.caretNode().outerHTML
      .toEqual "<div><br></div>"

  it "appendP", ->
    @saimaa.appendP()
    expect @saimaa.html()
      .toEqual "<p><br></p><p><br></p>"
    expect @saimaa.caretNode().outerHTML
      .toEqual "<p><br></p>"

  it "appendLi", ->
    @saimaa.appendLi()
    expect @saimaa.html()
      .toEqual "<p><br></p><li><br></li>"
    expect @saimaa.caretNode().outerHTML
      .toEqual "<li><br></li>"

  it "changeBlockquote", ->
    @saimaa.changeOl()
    expect @saimaa.html()
      .toEqual "<ol><li><br></li></ol>"
    expect @saimaa.caretNode().outerHTML
      .toEqual "<li><br></li>"

  it "changeH2", ->
    @editor.innerHTML = "<p>aaa</p>"
    @saimaa.changeH2()
    expect @saimaa.html()
      .toEqual "<h2>aaa</h2>"
    expect @saimaa.caretNode().outerHTML
      .toEqual "<h2>aaa</h2>"

  it "changeH3", ->
    @editor.innerHTML = "<p>aaa</p>"
    @saimaa.changeH3()
    expect @saimaa.html()
      .toEqual "<h3>aaa</h3>"
    expect @saimaa.caretNode().outerHTML
      .toEqual "<h3>aaa</h3>"

  it "changeH4", ->
    @editor.innerHTML = "<p>aaa</p>"
    @saimaa.changeH4()
    expect @saimaa.html()
      .toEqual "<h4>aaa</h4>"
    expect @saimaa.caretNode().outerHTML
      .toEqual "<h4>aaa</h4>"

  it "changeUl", ->
    @saimaa.changeUl()
    expect @saimaa.html()
      .toEqual "<ul><li><br></li></ul>"
    expect @saimaa.caretNode().outerHTML
      .toEqual "<li><br></li>"

  it "changeOl", ->
    @saimaa.appendP()
    @saimaa.changeOl()
    expect @saimaa.html()
      .toEqual "<p><br></p><ol><li><br></li></ol>"
    expect @saimaa.caretNode().outerHTML
      .toEqual "<li><br></li>"