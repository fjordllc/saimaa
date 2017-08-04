h = require "h"
SaimaaUtil = require "./saimaa_util"

class SaimaaDOM
  constructor: (@editor) ->
    @lastNode = null

  html: ->
    @editor.innerHTML

  caretNode: ->
    a = window.getSelection().anchorNode
    if a.nodeType == Node.TEXT_NODE then a.parentNode else a

  add: (node) ->
    selection = window.getSelection()
    if selection.rangeCount > 0
      range = selection.getRangeAt 0
      range.insertNode node
      range.setStartAfter node
      range.collapse true

  addBr: ->
    selection = window.getSelection()
    if selection.rangeCount > 0
      range = selection.getRangeAt 0
      br = h "br"
      br2 = h "br"
      range.insertNode br
      range.insertNode br2
      range.setStartAfter br
      range.collapse true

  append: (node, caretNode = null) ->
    oldCaretNode = @caretNode()

    for n in [1..2]
      @removeCaretLeft() if @caretLeftIsBr()

    if @editor == oldCaretNode
      @editor.appendChild node
    else
      oldCaretNode.parentNode.insertBefore(node, oldCaretNode.nextSibling)

    @moveCaret caretNode if caretNode

  appendP: ->
    rightNodes = @removeCaretRightAll() if @caretRightAll()
    if rightNodes
      node = rightNodes
      target = rightNodes[0]
    else
      target = h "br"
      node = h "p", target

    @append node, target

  appendLi: ->
    br = h "br"
    li = h "li", br
    @append li, br

  changeTag: (tag) ->
    newNode = h tag
    oldCaretNode = @caretNode()
    for childNode in oldCaretNode.childNodes
      newNode.appendChild childNode
    @append newNode
    @moveCaret newNode
    @editor.removeChild oldCaretNode

  changeList: (tag) ->
    @editor.focus()
    @moveCaret @lastNode if @lastNode

    ul = h tag
    li = h "li"
    br = h "br"
    li.appendChild br
    ul.appendChild li

    @append ul, br

    if @editor != @lastNode
      @editor.removeChild @lastNode

  changeUl: -> @changeList "ul"

  changeOl: -> @changeList "ol"

  changeH2: -> @formatBlock "h2"

  changeH3: -> @formatBlock "h3"

  changeH4: -> @formatBlock "h4"

  changeBlockquote: ->
    @editor.focus()
    @moveCaret @lastNode if @lastNode

    br = h "br"
    bq = h "blockquote", br

    @append bq, br

    if @editor != @lastNode
      @editor.removeChild @lastNode

  changeTitle: ->
    @editor.childNodes[0].classList.add "title"

  formatBlock: (tag) ->
    @moveCaret @lastNode if @lastNode

    if SaimaaUtil.ie()
      t = "<#{tag}>"
    else
      t = tag

    document.execCommand("formatBlock", false, t)
    @saveLastNode()

  tailBr: ->
    @caretNode().normalize()
    range = window.getSelection().getRangeAt(0)
    startContainer = range.startContainer
    if startContainer.nodeType == Node.ELEMENT_NODE and startContainer.childNodes.length > 0
      childNodes = startContainer.childNodes
      lastNode = childNodes[range.startOffset - 1]

      if @isTag(lastNode, "br")
        return true
    return false

  inLi: ->
    @caretNode().tagName.toLowerCase() == "li"

  inBlankLi: ->
    c = @caretNode()
    c.tagName.toLowerCase() == "li" and c.childNodes.length == 1 and @isTag(c.firstChild, "br")

  inP: ->
    @caretNode().tagName.toLowerCase() == "p"

  inTitle: ->
    @caretNode().className.toLowerCase() == "title"
    for name in @caretNode().classList
      return true if name == "title"
    return false

  breakLi: ->
    br = h "br"
    p = h "p"
    p.appendChild br

    oldCaretNode = @caretNode()
    ul = oldCaretNode.parentNode
    ul.parentNode.insertBefore(p, oldCaretNode.nextSibling)
    @moveCaret br

    ul.removeChild oldCaretNode

  moveCaret: (node) ->
    window.getSelection().getRangeAt(0).setStartAfter node

  saveLastNode: ->
    if @editor != @caretNode() and @editor.contains @caretNode()
      @lastNode = @caretNode()

  isTag: (node, tagName) ->
    node.nodeType == Node.ELEMENT_NODE and node.tagName.toLowerCase() == tagName

  removeCaretLeft: ->
    @caretNode().removeChild @caretLeft()

  caretLeft: ->
    oldCaret = @caretNode()
    oldCaret.normalize()
    range = window.getSelection().getRangeAt(0)
    startContainer = range.startContainer
    if startContainer.nodeType == Node.ELEMENT_NODE and startContainer.childNodes.length > 0
      childNodes = startContainer.childNodes
      leftNode = childNodes[range.startOffset - 1]
      return leftNode
    return null

  caretLeftIsBr: ->
    caretLeft = @caretLeft()
    caretLeft and caretLeft.nodeType == Node.ELEMENT_NODE and caretLeft.tagName.toLowerCase() == "br"

  caretRightAll: ->
    oldCaret = @caretNode()
    oldCaret.normalize()
    range = window.getSelection().getRangeAt(0)
    startContainer = range.startContainer
    if startContainer.nodeType == Node.ELEMENT_NODE and startContainer.childNodes.length > 0
      childNodes = startContainer.childNodes
      rightNodes = []
      n = range.startOffset + 1
      #console.log "n", n, "childNodes.length", childNodes.length, "childNodes", childNodes, "startOffset", range.startOffset
      length = childNodes.length
      while n < length
        #console.log "n", n, "childNodes[n]", childNodes[n]
        rightNodes.push childNodes[n]
        n++

      if rightNodes.length > 0
        return rightNodes
    return null

  removeCaretRightAll: ->
    oldCaret = @caretNode()
    oldCaret.normalize()
    range = window.getSelection().getRangeAt(0)
    startContainer = range.startContainer
    if startContainer.nodeType == Node.ELEMENT_NODE and startContainer.childNodes.length > 0
      childNodes = startContainer.childNodes
      rightNodes = []
      offset = range.startOffset + 1
      n = childNodes.length - 1
      #console.log "n", n, "childNodes.length", childNodes.length, "childNodes", childNodes, "startOffset", range.startOffset
      while n >= offset
        #console.log "n", n, "childNodes[n]", childNodes[n]
        rightNodes.unshift startContainer.removeChild(childNodes[n])
        n--

      if rightNodes.length > 0
        return rightNodes
    return null

module.exports = SaimaaDOM
