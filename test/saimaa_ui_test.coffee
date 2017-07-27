SaimaaUI = require "../src/saimaa_ui"

describe "SaimaaUI", ->
  it "name", ->
    saimaa = new SaimaaUI()
    expect(saimaa.name()).toEqual("bar")