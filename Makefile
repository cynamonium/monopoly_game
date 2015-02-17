webpack:
		# http://webpack.github.io/docs/configuration.html#devtool -> source maps!
		assets/node_modules/webpack/bin/webpack.js  \
				--config assets/webpack.config.js \
				--watch \
				--colors \
				--progress \
				--devtool eval-source-map
			 #--devtool inline-source-map

csscomb:
		assets/node_modules/csscomb/bin/csscomb -v --config assets/.csscomb.json assets/src/

karma:
		assets/node_modules/karma/bin/karma start  assets/karma.conf.js
