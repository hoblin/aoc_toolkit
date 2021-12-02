module AocToolkit
  class Cli
    def initialize(argv)
      @argv = argv
    end

    def run
      AocToolkit.bootstrap
    end
  end
end
