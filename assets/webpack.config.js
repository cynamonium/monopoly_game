var path              = require("path");
var webpack           = require('webpack');
var WatchIgnorePlugin = require('./vendor/watch_ignore_plugin')

production_paths = {
    output_filename:      "[name]-bundle-[hash].js",
    output_chunkFilename: "app.[id]-[chunkhash].js",
    css_filename:         "[name]-[hash].css",
    common_filename:      'common-[hash].js',
}

development_paths = {
    output_filename:      "[name]-bundle.js",
    output_chunkFilename: "app.[id].js",
    css_filename:         "[name].css",
    common_filename:      'common.js',
}


file_paths = development_paths; // or production_paths
if(process.env.RAILS_ENV === 'production'){
    file_paths = production_paths;
}


module.exports = {
    context: __dirname,
    entry: {
        app:          "./src/js/app",
        app_css:       "./src/css/view/app_css",
        bare_minimal: "./src/js/bare_minimal",
    },
    output: {
        path:          path.join(__dirname, '..', "public", "webpack"),
        filename:      file_paths.output_filename,
        chunkFilename: file_paths.output_chunkFilename,
        publicPath:    "/webpack/",  // for img paths in css-urls
        pathinfo:      true
    },
    plugins: [
        new webpack.optimize.DedupePlugin(),
        new webpack.DefinePlugin({
            IS_TEST: false,
        }),
        // ignore tests
        new webpack.IgnorePlugin(/.*/, /__tests__/),
        new WatchIgnorePlugin([
            path.join(__dirname, "node_modules"),
            path.join(__dirname, "bower_components")
        ]),
        //new webpack.optimize.UglifyJsPlugin({ output: {comments: false} })
    ],
    module: {
        loaders: [
            {
                test: /\.styl$/,
                loader: 'style!css!stylus-loader',
            },
            {
                test: /\.css$/,
                loader: "style!css",
            },
            {
                test: /\.coffee$/,
                loader: 'coffee-loader'
            },
            { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']},
            {
                test: /\.js$/,
                loader: 'jsx-loader?harmony'
            },
            { test: /\.woff(\?v=\d+\.\d+\.\d+)?$/,   loader: "url?limit=10000&minetype=application/font-woff" },
            { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,    loader: "url?limit=10000&minetype=application/octet-stream" },
            { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,    loader: "file" },
            { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,    loader: "url?limit=10000&minetype=image/svg+xml" },
            {
                test: /\.jpe?g$|\.gif$|\.png$|\.wav$|\.mp3$/,
                loader: "file-loader?name=[path][name]-[hash].[ext]&size=6"
            },

            // https://github.com/webpack/webpack/issues/177, workaround for sinon
            // + "sinon": "git+https://github.com/simple10/sinon-webpack" in package.json

        ],
        noParse: [
            // /__test__/,
            /jquery/,
            /react/,
        ],

    },
    resolve: {
        alias: {
            src:     path.join(__dirname, "src"),
            shared:  path.join(__dirname, "src", "shared"),
            // vendorized files
            jquery:  path.join('jquery/dist/jquery'),
            react:   path.join('react/react-with-addons'),
            moment:  path.join('momentjs/moment'),
            numeral: path.join('numeraljs/numeral'),
        },
        // you can now require('file') instead of require('file.coffee')
        extensions: ['', '.js', '.json', '.coffee', '.cjsx', '.css', '.less', '.styl'],
        modulesDirectories: ['node_modules', 'bower_components', 'src', 'src/js/vendor'],
    }
}
