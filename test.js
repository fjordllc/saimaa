var assert = require("assert");
var util = require("./index.js");

describe("textarea-caret-util", function() {
  var textarea = null;

  beforeEach(function(){
    document.body.innerHTML = "<!DOCTYPE html><html lang=\"ja\"><head><meta charset=\"UTF-8\"><title>Test</title></head><body><textarea></textarea></body></html>";
    textarea = document.querySelector("textarea");
  });

  it("lines", function() {
    textarea.value = "aaa\nbbb\nccc";
    assert.deepEqual(util.lines(textarea), ["aaa", "bbb", "ccc"]);
  });

  it("caretPosition", function() {
    assert.equal(util.caretPosition(textarea), 0);
  });

  it("insert", function() {
    textarea.value = "aaa\nbbb\nccc";
    util.insert(textarea, "OOO\n", 4);
    assert.equal(textarea.value, "aaa\nOOO\nbbb\nccc");
  });

  it("insertAtCaret", function() {
    textarea.value = "aaa\nbbb\nccc";
    textarea.setSelectionRange(8, 8);
    util.insertAtCaret(textarea, "OOO\n");
    assert.equal(textarea.value, "aaa\nbbb\nOOO\nccc");
  });
});