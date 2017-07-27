Saimaa = require "../src/saimaa"

describe "Saimaa", ->
  beforeEach ->
    document.body.innerHTML = __html__["html/textarea.html"]
    @source = document.querySelector ".is-wysiwyg"
    @saimaa = new Saimaa @source
    @saimaa.editor.focus()

  it "initialize", ->
    div = document.querySelector ".is-wysiwyg"
    div.innerHTML = "<p><br></p>"
    expect @saimaa.dom.html()
      .toEqual "<p><br></p>"