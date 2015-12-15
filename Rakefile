require 'fileutils'
require 'shellwords'

HOME = ENV['HOME']

class Installer
  EXCEPTIONS = ['.bash_profile']
  
  class << self
    def osx?; Dir.exist?('/Library'); end

    def link(source, destination)
      FileUtils.ln_s(source, destination)
    end

    def link_verbose(src, dest)
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
  
  def install
    dotfiles.each do |src|
      dest = "~/#{src}"

      self.class.link_verbose(src, dest)
    end
  end

  def dotfiles
    Dir['.*'] - ['.git', '.', '..'] - EXCEPTIONS
  end
end

task :default => :install

desc 'Install dotfile symlinks into default locations'
task :install => [:screen, :bash_profile] do
  Installer.new.install
end

task :screen => ".screen-profiles/logo" do
  mkdir_p "#{HOME}/bin"
  Installer.link_verbose("bin/screen-profiles-status", "#{HOME}/bin/screen-profiles-status")
end

file ".screen-profiles/logo" do |t|
  puts "Creating a default #{t.name}"
  File.open(t.name, "w") {|f| f.write("\005{= wr}#{`hostname`} @ ") }
end

task :bash_profile do
  dest = Installer.osx? ? "#{HOME}/.bash_profile" : "#{HOME}/.bashrc"
  
  if `grep -c 'dotfiles/.bash_profile' '#{Shellwords.escape dest}'`.to_i == 0
    puts "Sourcing .bash_profile from #{dest}"
    File.open(dest, 'a') do |f|
      f.puts <<-SH.gsub(/^\s+/, '')

        source #{File.dirname(__FILE__)}/.bash_profile
        
        export PSCOLOR=$COLOR_BLUE
        export PSHOST="changeme"
        export PSBOLD=1
        export PSUNDERLINE=0
      SH
    end
  else
    puts ".bash_profile already mentioned in #{dest}; not modifying"
  end
end
