wanderer= require './'

describe 'wanderer',->
  describe '.seekSync',()->
    it '*.md',->
      globs= '*.md'
      options= {}

      expect(wanderer.seekSync globs,options).toEqual ["CHANGELOG.md","LICENSE.md","README.md"]

    it '`!` ignore prefix',()->
      files= wanderer.seekSync ['*.md','!LICENSE.md']
      expect(JSON.stringify files).toEqual('["CHANGELOG.md","README.md"]')

    it '(ignore duplicate)',()->
      files= wanderer.seekSync '*.md','README.md'
      expect(JSON.stringify files).toEqual('["CHANGELOG.md","LICENSE.md","README.md"]')

  describe '.seek',()->
    it '*.md',(done)->
      globs= '*.md'
      options= {}

      files= []
      seeker= wanderer.seek globs,options
      seeker.on 'data',(file)->
        files.push file
      seeker.on 'end',->
        
        expect(files).toEqual ["CHANGELOG.md","LICENSE.md","README.md"]
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
