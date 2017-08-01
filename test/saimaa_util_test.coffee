SaimaaUtil = require "../src/saimaa_util"

describe "SaimaaUtil", ->
  it "ie", ->
    expect(SaimaaUtil.ie()).toEqual(false)

  it "ie11", ->
    expect(SaimaaUtil.ie11()).toEqual(false)