require 'fileutils'
require 'shellwords'

HOME = ENV['HOME']

class Installer
  EXCEPTIONS = ['.bash_profile']
  
  class << self
    def osx?; Dir.exist?('/Library'); end
  end
  
  def install
    dotfiles.each do |src|
      dest = "~/.#{src}"

      source = File.expand_path(src)
      destination = File.expand_path(dest)

      if File.exist?(destination)
        puts "#{dest} exists"
      else
        puts "Linking #{dest}"
        link(source, destination)
      end
    end
  end

  def dotfiles
    Dir['.*'] - ['.git', '.', '..'] - EXCEPTIONS
  end

  def link(source, destination)
    FileUtils.ln_s(source, destination)
  end
end

task :default => :install

desc 'Install'
task :install => [:screen, :bash_profile] do
  Installer.new.install
end

task :screen do
  mkdir_p "#{HOME}/bin"
  FileUtils.ln_s("#{HOME}/bin/screen-profiles-status", "bin/screen-profiles-status")
end

task :bash_profile do
  dest = Installer.osx? ? "#{HOME}/.bash_profile" : "#{HOME}/.bashrc"
  
  unless `grep -c 'dotfiles/.bash_profile' '#{Shellwords.escape dest}'`.to_i > 0
    File.open(dest, 'a') do |f|
      f.puts <<-SH
        source #{File.dirname(__FILE__)}/.bash_profile
        
        export PSCOLOR=$COLOR_BLUE
        export PSHOST="changeme"
        export PSBOLD=1
        export PSUNDERLINE=0
      SH
    end
  end
end