const path = require("path");
const HtmlWebpackPlugin = require('html-webpack-plugin')
const BUILD_MODE =
  process.env.npm_lifecycle_event === "build" ? "production" : "development";

module.exports = {
  mode: BUILD_MODE,
  entry: './src/main.ts',
  output: {
    path: path.resolve(__dirname, "build"),
    filename: "bundle.js"
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
            {
              loader: "style-loader"
            },
            {
              loader: "css-loader"
            },
            {
              loader: "sass-loader",
              options: {
                includePaths: [path.resolve(__dirname, "assets")]
              }
            }
        ]
      },
      {
        test: /\.html$/,
        loader: "html-loader"
      },
      {
        test: [/\.elm$/],
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          { loader: "elm-hot-webpack-loader" },
          {
            loader: "elm-webpack-loader",
            options: BUILD_MODE === "production" ? {} : { debug: true, forceWatch: true }
          }
        ]
      },
      {
        test: /\.ts$/,
        use: 'ts-loader'
      }
    ]
  },
  devServer: {
    contentBase: 'build'
  },
  resolve: {
    extensions: [
      '.ts',
      '.elm',
      '.js'
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./static/index.html"
    })
  ]
};