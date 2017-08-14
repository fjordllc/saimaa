module.exports = {
  lines: function(el) {
    return el.value.split("\n");
  },
  caretPosition: function(el) {
    return el.selectionStart;
  },
  insert: function(el, text, position) {
    el.value = el.value.substr(0, position) + text + el.value.substr(position, el.value.length);
  },
  insertAtCaret: function(el, text) {
    this.insert(el, text, this.caretPosition(el));
  }
};