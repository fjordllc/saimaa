module.exports = function (config) {
  config.set({
    frameworks: ["jasmine"],
    files: [
      "src/**/*.coffee",
      "test/**/*_test.coffee",
      "html/**/*.html"
    ],
    preprocessors: {
      "src/**/*.coffee": ["webpack"],
      "test/**/*_test.coffee": ["webpack"],
      "html/**/*.html": "html2js"
    },
    webpack: {
      entry: {
        app: __dirname + '/src/saimaa.coffee'
      },
      output: {
        path: __dirname + '/',
        filename: "index.js"
      },
      resolve: {
        extensions: ['.coffee', '.js']
      },
      module: {
        loaders: [
          { test: /\.coffee$/, loader: 'coffee-loader' }
        ]
      }
    },
    browsers: ["Chrome"],
    reporters: ["mocha"],
    logLevel: config.LOG_DEBUG
  })
};