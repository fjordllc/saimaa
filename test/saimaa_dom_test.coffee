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