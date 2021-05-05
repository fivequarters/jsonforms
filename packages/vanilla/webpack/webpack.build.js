const merge = require('webpack-merge');
const baseConfig = require('../../../webpack/webpack.build.base.js');

module.exports = merge(baseConfig, {
    output: {
        filename: "jsonforms-vanilla.js",
        library: "JSONFormsVanilla"
      },
      externals: {
          react: 'React',
          '@jsonforms/core': 'JSONFormsCore'
    },
});
