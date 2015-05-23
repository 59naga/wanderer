# Dependencies
optimist= require 'optimist'

glob= require 'glob'
minimatch= require 'minimatch'

EventEmitter= require('events').EventEmitter

wanderer=
  cli: ->
    argv= optimist.argv

    console.log wanderer.seekSync(argv._).join '\n'
    
    process.exit 0

  seekSync: ->
    [globs,options]= wanderer.normalize arguments...

    files= wanderer.bring globs,options
    files= wanderer.unique files
    files.sort()
    files

  seek: ->
    # TODO: without glob.sync version
    files= wanderer.seekSync arguments...

    seeker= new EventEmitter
    process.nextTick ->
      seeker.emit 'data',file for file in files
      seeker.emit 'end',files

    seeker

  bring: (globs,options={})->
    positives= globs.filter (pattern)-> pattern[0] isnt '!'
    negatives= globs.filter (pattern)-> pattern[0] is '!'

    files= []
    positives.forEach (positive)->
      files= files.concat glob.sync positive,options
      files= files.filter (file)->

        negatives.every (negative)->
          no is minimatch file,negative.slice(1)
    files

  normalize: (args...)->
    throw new Error 'invaild arguments' if args[0] is undefined

    globs= []
    options= {}
    for arg in args
      globs.push arg if typeof arg is 'string'
      globs= globs.concat arg if arg instanceof Array

      if not (arg instanceof Array) and typeof arg is 'object'
        options= arg

    [globs,options]

  unique: (files)->
    for file,i in files
      while(files.indexOf(file,i+1) isnt -1)
        files.splice files.indexOf(file,i+1),1
    files

module.exports= wanderer