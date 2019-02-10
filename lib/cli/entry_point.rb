require "cli"

module Cli
  module EntryPoint
    def self.call(args)
      cmd, command_name, args = Cli::Resolver.call(args)
      Cli::Executor.call(cmd, command_name, args)
    end
  end
end
