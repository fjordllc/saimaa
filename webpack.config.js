module.exports = {
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
}