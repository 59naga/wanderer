wanderer= require '../src'

describe 'wanderer',->
  describe '.seekSync',()->
    it '*.md: directory alphanumeric sorted',->
      files= wanderer.seekSync 'test/*.md'

      expect(files).toEqual ["test/bar.md","test/baz.md","test/foo.md"]

    it '*.md baz.md: ignore duplicate)',->
      files= wanderer.seekSync 'test/*.md','test/baz.md'
      expect(files).toEqual ["test/bar.md","test/baz.md","test/foo.md"]

    it 'test/*.md !bar.md: negative glob',->
      files= wanderer.seekSync ['test/*.md','!test/bar.md']

      expect(files).toEqual ["test/baz.md","test/foo.md"]

  describe '.seek',->
    it '*.md: directory alphanumeric sorted',(done)->
      seeker= wanderer.seek 'test/*.md'
      seeker.on 'end',(files)->

        expect(files).toEqual ["test/bar.md","test/baz.md","test/foo.md"]
        done()

    it '*.md baz.md: ignore duplicate)',(done)->
      seeker= wanderer.seek 'test/*.md','test/baz.md'
      seeker.on 'end',(files)->

        expect(files).toEqual ["test/bar.md","test/baz.md","test/foo.md"]
        done()

    it 'test/*.md !bar.md: negative glob',(done)->
      seeker= wanderer.seek ['test/*.md','!test/bar.md']
      seeker.on 'end',(files)->

        expect(files).toEqual ["test/baz.md","test/foo.md"]
        done()

  describe '.normalize',()->
    it 'simple',->
      [globs,options]= wanderer.normalize 'hoge'

      expect(globs).toEqual ['hoge']

    it 'multiple',->
      [globs,options]= wanderer.normalize 'hoge','fuga'

      expect(globs).toEqual ['hoge','fuga']

      [globs,options]= wanderer.normalize ['hoge','fuga']

      expect(globs).toEqual ['hoge','fuga']

    it 'options',->
      [globs,options]= wanderer.normalize 'hoge',cwd:'hogekosan'

      expect(globs).toEqual ['hoge']
      expect(options.cwd).toEqual 'hogekosan'

    it 'all change',->
      [globs,options]= wanderer.normalize 'hoge','fuga','piyo',{cwd:'hogekosan is power',sort:false,unique:false,map:false}

      expect(globs).toEqual ['hoge','fuga','piyo']
      expect(options).toEqual cwd:'hogekosan is power',sort:false,unique:false,map:false

    it 'null to error',->
      death= -> wanderer.normalize()

      expect(death).toThrow()
