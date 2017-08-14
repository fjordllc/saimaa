module.exports = function (config) {
  config.set({
    frameworks: ["jasmine"],
    files: [
      "index.js",
      "test.js",
      "test.html"
    ],
    preprocessors: {
      "index.js": ["webpack"],
      "test.js": ["webpack"],
      "test.html": "html2js"
    },
    browsers: ["Chrome"],
    reporters: ["mocha"],
    logLevel: config.LOG_DEBUG
  })
};