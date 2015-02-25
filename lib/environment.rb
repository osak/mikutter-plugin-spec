# 他のプラグインからEnvironmentがmiquireされると面倒なので
# あらかじめrequireだけして$LOAD_PATHに突っ込んでおく。
# Environmentの定義は抹消して新しくモックする。
miquire :lib, 'environment'
Object.__send__(:remove_const, :Environment)

module Environment
  NAME = "mikutter spec"
  ACRO = "msp"

  TWITTER_CONSUMER_KEY = nil
  TWITTER_CONSUMER_SECRET = nil
  TWITTER_AUTHENTICATE_REVISION = 1

  PIDFILE = nil

  # コンフィグファイルのディレクトリ
  CONFROOT = Dir.mktmpdir("mikutter-spec-")
  TMPDIR = File.join(CONFROOT, 'tmp')
  LOGDIR = File.join(CONFROOT, 'log')
  SETTINGDIR = File.join(CONFROOT, 'settings')
  CACHE = File.join(CONFROOT, 'cache')

  # プラグインディレクトリ
  PLUGIN_PATH = ""

  AutoTag = false
  NeverRetrieveOverlappedMumble = false
  REVISION = 9999
  VERSION = [3,2,2, REVISION]
end

# 一時ディレクトリの後始末
END{
  rmdir = ->(path) {
    if FileTest.directory?(path)
      next if path[0] = '.'
      Dir.foreach(path) do |f|
        rmdir.call(f)
      end
    else
      File.delete(path)
    end
  }
  rmdir.call(Environment::CONFROOT)
}

[Environment::TMPDIR, Environment::LOGDIR, Environment::SETTINGDIR, Environment::CACHE].each do |dir|
  Dir.mkdir(dir)
end

