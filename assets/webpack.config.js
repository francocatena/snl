const Path              = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

const config = {
  entry: './js/app.js',

  devtool: 'source-map',

  output: {
    path: Path.resolve(__dirname, '../priv/static'),
    filename: 'js/app.js'
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: [
          /node_modules/,
          /deps/
        ],
        loader: 'babel-loader',
        options: {
          presets: ['env']
        }
      },

      {
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: ['css-loader', 'sass-loader']
        })
      }
    ]
  },

  plugins: [
    new CopyWebpackPlugin([{ from: './static' }]),
    new ExtractTextPlugin('css/app.css')
  ],

  resolve: {
    alias: {
      phoenix: `${__dirname}/../deps/phoenix/web/static/js/phoenix.js`
    }
  }
};

module.exports = config;
