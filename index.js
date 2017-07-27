/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

var Saimaa, SaimaaDOM, SaimaaUtil;

SaimaaUtil = __webpack_require__(1);

SaimaaDOM = __webpack_require__(2);

Saimaa = (function() {
  function Saimaa(source) {
    this.source = source;
    this.initEditor();
    this.dom = new SaimaaDOM(this.editor);
    this.editor.addEventListener("keydown", (function(_this) {
      return function(event) {
        return _this.onKeyDown(event);
      };
    })(this));
    this.editor.addEventListener("keyup", (function(_this) {
      return function(event) {
        return _this.onKeyUp(event);
      };
    })(this));
  }

  Saimaa.prototype.initEditor = function() {
    this.editor = document.createElement("div");
    this.editor.contenteditable = true;
    this.editor.className = this.source.className;
    this.source.parentNode.insertBefore(this.editor, this.source);
    return this.source.style.display = "none";
  };

  Saimaa.prototype.onKeyDown = function(event) {
    return "foo";
  };

  Saimaa.prototype.onKeyUp = function(event) {
    return "bar";
  };

  Saimaa.prototype.foo = function() {
    return console.log("foo!!!");
  };

  return Saimaa;

})();

module.exports = Saimaa;


/***/ }),
/* 1 */
/***/ (function(module, exports) {

var SaimaaUtil;

SaimaaUtil = (function() {
  function SaimaaUtil() {}

  SaimaaUtil.ie = function() {
    var ua;
    ua = window.navigator.userAgent;
    ua.match(/MSIE/) || ua.match(/Trident/);
    if (ie) {
      return true;
    } else {
      return false;
    }
  };

  SaimaaUtil.ie11 = function() {
    return document.documentMode === 11;
  };

  return SaimaaUtil;

})();

module.exports = SaimaaUtil;


/***/ }),
/* 2 */
/***/ (function(module, exports) {

var SaimaaDOM;

SaimaaDOM = (function() {
  function SaimaaDOM(editor) {
    this.editor = editor;
  }

  SaimaaDOM.prototype.h = function(tag, child) {
    var node;
    if (child == null) {
      child = null;
    }
    node = document.createElement(tag);
    if (child) {
      node.appendChild(child);
    }
    return node;
  };

  SaimaaDOM.prototype.html = function() {
    return this.editor.innerHTML;
  };

  SaimaaDOM.prototype.caretNode = function() {
    var node, result;
    node = window.getSelection().anchorNode;
    if ((node != null) && node.nodeType === Node.TEXT_NODE || ((node.tagName != null) && node.tagName === "BR")) {
      result = node.parentNode;
    } else {
      result = node;
    }
    return result;
  };

  SaimaaDOM.prototype.append = function(node) {
    this.editor.insertBefore(node, this.caretNode().nextSibling);
    return this.moveCaret(node);
  };

  SaimaaDOM.prototype.appendP = function() {
    var br, p;
    p = this.h("p");
    br = this.h("br");
    p.appendChild(br);
    return this.append(p);
  };

  SaimaaDOM.prototype.appendLi = function() {
    var li;
    li = document.createElement("li");
    li.appendChild(document.createElement("br"));
    return this.append(li);
  };

  SaimaaDOM.prototype.changeTag = function(tag) {
    var childNode, i, len, newNode, oldCaretNode, ref;
    newNode = this.h(tag);
    oldCaretNode = this.caretNode();
    ref = oldCaretNode.childNodes;
    for (i = 0, len = ref.length; i < len; i++) {
      childNode = ref[i];
      newNode.appendChild(childNode);
    }
    this.append(newNode);
    this.moveCaret(newNode);
    return this.editor.removeChild(oldCaretNode);
  };

  SaimaaDOM.prototype.changeList = function(tag) {
    var br, li, list, oldCaretNode;
    oldCaretNode = this.caretNode();
    list = this.h(tag);
    li = this.h("li");
    br = this.h("br");
    li.appendChild(br);
    list.appendChild(li);
    this.append(list);
    this.moveCaret(br);
    return this.editor.removeChild(oldCaretNode);
  };

  SaimaaDOM.prototype.changeUl = function() {
    return this.changeList("ul");
  };

  SaimaaDOM.prototype.changeOl = function() {
    return this.changeList("ol");
  };

  SaimaaDOM.prototype.changeH2 = function() {
    return this.changeTag("h2");
  };

  SaimaaDOM.prototype.changeH3 = function() {
    return this.changeTag("h3");
  };

  SaimaaDOM.prototype.changeH4 = function() {
    return this.changeTag("h4");
  };

  SaimaaDOM.prototype.changeBlockquote = function() {
    var bq, childNodes, i, lastNode, len, node;
    childNodes = this.caretNode().childNodes;
    lastNode = childNodes;
    bq = this.h("blockquote");
    for (i = 0, len = childNodes.length; i < len; i++) {
      node = childNodes[i];
      bq.appendChild(node);
    }
    return this.append(bq);
  };

  SaimaaDOM.prototype.formatBlock = function(tag) {};

  SaimaaDOM.prototype.moveCaret = function(node) {
    var range, selection;
    range = document.createRange();
    selection = window.getSelection();
    range.setStart(node, 0);
    range.collapse(true);
    selection.removeAllRanges();
    return selection.addRange(range);
  };

  return SaimaaDOM;

})();

module.exports = SaimaaDOM;


/***/ })
/******/ ]);