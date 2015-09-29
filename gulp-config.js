var env = 'public/',
  pkg   = require('./package.json');
module.exports = {
  pkg: {
    name: pkg.name
  },
  pluginOpts: {
    coffee: {
      bare: true
    },
    order: [
      '**/templates.js',
      '**/*.js'
    ],
    rename: {
      suffix: '.min'
    },
    template: {
      variable: 'var TEMPLATES',
      base: 'src/templates/',
      bare: false
    },
    jade: {
      pretty: true,
      data  : {
        name       : pkg.name,
        description: pkg.description
      }
    },
    gSize: {
      showFiles: true
    },
    browserSync: {
      port   : 1987,
      server : {
        baseDir: env
      }
    },
    prefix: [
      'last 3 versions',
      'Blackberry 10',
      'Android 3',
      'Android 4'
    ],
    wrap: '(function() { <%= contents %> }());',
    load: {
      rename: {
        'gulp-gh-pages'      : 'deploy',
        'gulp-util'          : 'gUtil',
        'gulp-minify-css'    : 'minify',
        'gulp-autoprefixer'  : 'prefix',
        'gulp-template-store': 'tmpl'
      }
    }
  },
  paths: {
    base: env,
    sources: {
      coffee   : 'src/coffee/**/*.coffee',
      docs     : 'src/jade/*.jade',
      jade     : 'src/jade/**/*.jade',
      stylus   : 'src/stylus/**/*.stylus',
      overwatch: env + '**/*.{html,js,css}',
      templates: 'src/templates/**/*.jade',
      vendor   : {
        js     : [
          'src/vendor/lodash/lodash.min.js'
        ],
        css    : [
          'src/vendor/normalize-css/normalize.css'
        ]
      }
    },
    destinations: {
      dist     : './dist',
      js       : env + 'js/',
      html     : env,
      css      : env + 'css/',
      templates: 'src/coffee/tmp/'
    }
  }
};
