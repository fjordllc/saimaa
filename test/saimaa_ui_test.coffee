assert = require "assert"
SaimaaUI = require "../src/saimaa_ui"

describe "SaimaaUI", ->
  beforeEach ->
    document.body.innerHTML = __html__["html/contenteditable.html"]
    @editor = document.querySelector ".is-wysiwyg"
    @saimaa = new SaimaaUI @editor
    @editor.focus()

  it "initialize", ->
    assert true