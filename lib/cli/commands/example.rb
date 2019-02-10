require "cli"
require "json"

module Cli
  module Commands
    class Example < Cli::Command
      def call(_args, _name)
        CLI::UI::StdoutRouter.enable

        CLI::UI::Frame.open("{{*}} {{bold:a}}", color: :green) do
          CLI::UI::Frame.open("{{i}} b", color: :magenta) do
            CLI::UI::Frame.open("{{?}} c", color: :cyan) do
              sg = CLI::UI::SpinGroup.new
              sg.add("wow") do |spinner|
                sleep(2.5)
                spinner.update_title("second round!")
                sleep 1.0
              end
              sg.add("such spin") { sleep(1.6) }
              sg.add("many glyph") { sleep(2.0) }
              sg.wait
            end
          end
          CLI::UI::Frame.divider("{{v}} lol")
          puts CLI::UI.fmt "{{info:words}} {{red:oh no!}} {{green:success!}}"
          sg = CLI::UI::SpinGroup.new
          sg.add("more spins") { sleep(0.5); raise "oh no" }
          sg.wait

          CLI::UI::Progress.progress do |bar|
            100.times do
              bar.tick
            end
          end
        end

        raise(CLI::Kit::Abort, "you got unlucky!") if rand < 0.05
      end

      def self.help
        "A dummy command.\nUsage: {{command:#{Cli::TOOL_NAME} example}}"
      end
    end
  end
end
