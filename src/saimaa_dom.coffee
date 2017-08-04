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

  add: (node) ->
    selection = window.getSelection()
    if selection.rangeCount > 0
      range = selection.getRangeAt(0)
      console.log "anchor", selection.anchorNode, "start", range.startContainer, range.startOffset, "end", range.endContainer, range.endOffset
      range.insertNode node
      console.log "anchor", selection.anchorNode, "start", range.startContainer, range.startOffset, "end", range.endContainer, range.endOffset
      range.setStartAfter node
      console.log "anchor", selection.anchorNode, "start", range.startContainer, range.startOffset, "end", range.endContainer, range.endOffset

  append: (node) ->
    if @editor == @caretNode()
      @editor.appendChild node
    else
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

    if @editor != oldCaretNode
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
    if SaimaaUtil.ie()
      t = "<#{tag}>"
    else
      t = tag

    document.execCommand("formatBlock", false, t)

  inLi: ->
    @caretNode().tagName.toLowerCase() == "li"

  inP: ->
    @caretNode().tagName.toLowerCase() == "p"

  inTitle: ->
    @caretNode().className.toLowerCase() == "title"

  moveCaret: (node) ->
    range = document.createRange()
    selection = window.getSelection()
    range.setStart node, 0
    range.collapse true
    selection.removeAllRanges()
    selection.addRange range

module.exports = SaimaaDOM