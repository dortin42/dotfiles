require "cli"
require "json"

module Cli
  module Commands
    class Install < Cli::Command
      def call(_args, _name)
        CLI::UI::StdoutRouter.enable

        CLI::UI::Frame.open("{{*}} {{bold:Install:}}", color: :yellow, failure_text: "{{x}} {{bold:Installation failed}}", success_text: "{{v}} {{bold:Installation successfully}}") do
          CLI::UI::Frame.open("{{*}} {{bold:Git steps:}}", color: :green, failure_text: "{{x}} {{bold:Git config failed}}", success_text: "{{v}} {{bold:Git configured successfully}}") do
            raise(CLI::Kit::Abort, "{{x}} {{bold:You don't have git}}") unless system("git --version")
            CLI::UI::Spinner.spin("{{bold:Waiting}}") { sleep 1.0 }
            asd = STDIN.gets.chomp
            puts asd
          end
        end
      end

      def self.help
        "Install configs.\nUsage: {{command:#{Cli::TOOL_NAME} install}}"
      end

      protected

        def git_configs
          puts "Your git username"
          git_username = STDIN.gets.chomp
          puts "Your git email"
          git_email = STDIN.gets.chomp
          system("git config --global color.ui true")
          system("git config --global user.name #{git_username}")
          system("git config --global user.email #{git_email}")
          system("ssh-keygen -t rsa -b 4096 -C #{git_email}")
        end

        def dotfiles
          system("curl -fLso ~/.local/share/fonts/droid.otf --create-dirs https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf")
          system("curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash")
          system("gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB")
          system("curl -sSL https://get.rvm.io | bash -s stable --ruby")
        end
    end
  end
end
