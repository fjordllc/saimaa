h = require "h"
SaimaaUtil = require "./saimaa_util"

class SaimaaDOM
  constructor: (@editor) ->

  html: ->
    @editor.innerHTML

  caretNode: ->
    node = window.getSelection().anchorNode
    #console.log "node:", node, "nodeType", node.nodeType, Node.TEXT_NODE, "tagName", node.tagName, "parent", node.parentNode
    if node? and node.nodeType == Node.TEXT_NODE or (node.tagName? and node.tagName == "BR")
      result = node.parentNode
    else
      result = node
    #console.log "return node", result
    result

  append: (node) ->
    @editor.insertBefore(node, @caretNode().nextSibling)
    @moveCaret node

  appendP: ->
    p = h "p"
    br = h "br"
    p.appendChild br
    @append p

  appendLi: ->
    li = document.createElement "li"
    li.appendChild document.createElement "br"
    @append li

  changeTag: (tag) ->
    newNode = h tag
    oldCaretNode = @caretNode()
    for childNode in oldCaretNode.childNodes
      newNode.appendChild childNode
    @append newNode
    @moveCaret newNode
    @editor.removeChild oldCaretNode

  changeList: (tag) ->
    oldCaretNode = @caretNode()
    list = h tag
    li = h "li"
    br = h "br"
    li.appendChild br
    list.appendChild li
    @append list
    @moveCaret br
    @editor.removeChild oldCaretNode
    #console.log "after caret", @caretNode(), "parentNode", @caretNode().parentNode

  changeUl: -> @changeList "ul"

  changeOl: -> @changeList "ol"

  changeH2: -> @changeTag "h2"

  changeH3: -> @changeTag "h3"

  changeH4: -> @changeTag "h4"

  changeBlockquote: ->
    childNodes = @caretNode().childNodes
    lastNode = childNodes
    bq = h "blockquote"
    for node in childNodes
      bq.appendChild node
    @append bq

  formatBlock: (tag) ->
    console.log SaimaaUtil
    if SaimaaUtil.ie()
      document.execCommand("formatBlock", false, "<#{tag}>")
    else
      document.execCommand("formatBlock", false, tag)

  moveCaret: (node) ->
    range = document.createRange()
    selection = window.getSelection()
    range.setStart node, 0
    range.collapse true
    selection.removeAllRanges()
    selection.addRange range

module.exports = SaimaaDOM