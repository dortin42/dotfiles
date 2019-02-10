require "cli"

module Cli
  module Commands
    class Help < Cli::Command
      def call(_args, _name)
        puts CLI::UI.fmt("{{bold:Available commands}}")
        puts ""

        Cli::Commands::Registry.resolved_commands.each do |name, klass|
          next if name == "help"

          puts CLI::UI.fmt("{{command:#{Cli::TOOL_NAME} #{name}}}")
          if help = klass.help
            puts CLI::UI.fmt(help)
          end
          puts ""
        end
      end
    end
  end
end
