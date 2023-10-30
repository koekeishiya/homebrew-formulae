class Yabai < Formula
  desc "A tiling window manager for macOS based on binary space partitioning."
  homepage "https://github.com/koekeishiya/yabai"
  url "https://github.com/koekeishiya/yabai/releases/download/v6.0.0/yabai-v6.0.0.tar.gz"
  sha256 "a8101238d70e4bc16cdb63d780d8bd9fd1e235eda2be07c7b77f6f75f9648eea"
  head "https://github.com/koekeishiya/yabai.git"

  depends_on :macos => :big_sur

  def install
    man.mkpath

    if build.head?
      system "make", "-j1", "install"
    end

    bin.install "#{buildpath}/bin/yabai"
    (pkgshare/"examples").install "#{buildpath}/examples/yabairc"
    (pkgshare/"examples").install "#{buildpath}/examples/skhdrc"
    man1.install "#{buildpath}/doc/yabai.1"
    puts "Would you like SA to be able to load automatically"
    print "Type yes/no: "
    if gets.chomp == "yes"
      system "echo \"$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai)) --load-sa\" | sudo tee /private/etc/sudoers.d/yabai"
    end
  end

  def caveats; <<~EOS
    Copy the example configuration into your home directory:
      cp #{opt_pkgshare}/examples/yabairc ~/.yabairc
      cp #{opt_pkgshare}/examples/skhdrc ~/.skhdrc

    If you want yabai to be managed by launchd (start automatically upon login):
      yabai --start-service

    When running as a launchd service logs will be found in:
      /tmp/yabai_<user>.[out|err].log

    README: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition
    EOS
  end

  test do
    assert_match "yabai-v#{version}", shell_output("#{bin}/yabai --version")
  end
end
