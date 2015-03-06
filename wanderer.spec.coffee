wanderer= require './'

describe 'wanderer',->
  describe '.seekSync',()->
    it '*.md',->
      globs= '*.md'
      options= {}

      expect(wanderer.seekSync globs,options).toEqual ["CHANGELOG.md","LICENSE.md","README.md"]

    it '`!` ignore prefix',()->
      files= wanderer.seekSync ['*.md','!LICENSE.md']
      expect(files).toEqual ["CHANGELOG.md","README.md"]

    it '(ignore duplicate)',()->
      files= wanderer.seekSync '*.md','README.md'
      expect(files).toEqual ["CHANGELOG.md","LICENSE.md","README.md"]

  describe '.seek',()->
    it '*.md',(done)->
      globs= '*.md'

      seeker= wanderer.seek '*.md'
      seeker.on 'end',(files)->
        
        expect(files).toEqual ["CHANGELOG.md","LICENSE.md","README.md"]
        done()

    it '`!` ignore prefix',()->
      seeker= wanderer.seek ['*.md','!LICENSE.md']
      seeker.on 'end',(files)->
        expect(files).toEqual ["CHANGELOG.md","README.md"]

    it '(ignore duplicate)',()->
      seeker= wanderer.seek '*.md','README.md'
      seeker.on 'end',(files)->
        expect(files).toEqual ["CHANGELOG.md","LICENSE.md","README.md"]

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
