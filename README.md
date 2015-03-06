# ![wanderer][.svg] Wanderer [![NPM version][npm-image]][npm] [![Build Status][travis-image]][travis] [![Coverage Status][coveralls-image]][coveralls]

> Shorthand file seeker. inspired [gulp.src][1]

## Installation
```bash
npm install wanderer --save
```

## Usage
```js
var wanderer= require('wanderer');
var files= wanderer.seekSync('*.md');
console.log(files); // [ 'CHANGELOG.md', 'LICENSE.md', 'README.md' ]
```

or wanderer.seek:
```js
var wanderer= require('wanderer');
wanderer.seek('*.md').on('end',function(files){
  console.log(files); // [ 'CHANGELOG.md', 'LICENSE.md', 'README.md' ]
});
```

Can use [glob][2]. and, Can use nagative glob:

```js
var files= Wanderer.seekSync('*.md','!CHANGELOG.md');
console.log(files); // [ 'LICENSE.md', 'README.md' ]
```

## Argument formats:
* `(glob)`
* `(glob,options)`
* `(glob,glob,...,options)`
* `([glob,glob,...],options)`

## Options

Pass as it is to [glob.sync][3]

## CLI
```bash
npm install wanderer --global
```

Enabled `wanderer` command. e.g. `wanderer 'glob' 'glob' 'glob'...`
Prints to stdout.

example:
```bash
wanderer '**/*.json' '!**/bower.json' '!**/package.json'
# coverage/coverage.json
# node_modules/coveralls/node_modules/js-yaml/examples/dumper.json
# node_modules/coveralls/node_modules/js-yaml/node_modules/argparse/node_modules/underscore.string/component.json
# node_modules/coveralls/node_modules/log-driver/coverage/coverage.json
# ...
```

License
=========================
MIT by 59naga

[.svg]: https://cdn.rawgit.com/59naga/wanderer/master/.svg

[npm-image]: https://badge.fury.io/js/wanderer.svg
[npm]: https://npmjs.org/package/wanderer
[travis-image]: https://travis-ci.org/59naga/wanderer.svg?branch=master
[travis]: https://travis-ci.org/59naga/wanderer
[coveralls-image]: https://coveralls.io/repos/59naga/wanderer/badge.svg?branch=master
[coveralls]: https://coveralls.io/r/59naga/wanderer?branch=master

[1]: https://github.com/gulpjs/gulp/blob/master/docs/API.md#gulp-api-docs
[2]: https://github.com/isaacs/node-glob#glob-primer
[3]: https://github.com/isaacs/node-glob#globsyncpattern-options
