class Yabai < Formula
  desc "A tiling window manager for macOS based on binary space partitioning."
  homepage "https://github.com/koekeishiya/yabai"
  url "https://github.com/koekeishiya/yabai/releases/download/v3.3.10/yabai-v3.3.10.tar.gz"
  sha256 "4fe78b2030b1cf775a2b6ee4a4193009a94d78ef1bebd7d46f70dcda439dc618"
  head "https://github.com/koekeishiya/yabai.git"

  depends_on :macos => :high_sierra

  def install
    (var/"log/yabai").mkpath
    man.mkpath

    if build.head?
      system "make", "-j1", "install"
      system "codesign", "--force", "-s", "-", "#{buildpath}/bin/yabai"
    end

    bin.install "#{buildpath}/bin/yabai"
    (pkgshare/"examples").install "#{buildpath}/examples/yabairc"
    (pkgshare/"examples").install "#{buildpath}/examples/skhdrc"
    man1.install "#{buildpath}/doc/yabai.1"
  end

  def caveats; <<~EOS
    Copy the example configuration into your home directory:
      cp #{opt_pkgshare}/examples/yabairc ~/.yabairc
      cp #{opt_pkgshare}/examples/skhdrc ~/.skhdrc

    Logs will be found in
      #{var}/log/yabai/yabai.[out|err].log
    EOS
  end

  plist_options :manual => "yabai"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/yabai</string>
      </array>
      <key>EnvironmentVariables</key>
      <dict>
        <key>PATH</key>
        <string>#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
      </dict>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>StandardOutPath</key>
      <string>#{var}/log/yabai/yabai.out.log</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/yabai/yabai.err.log</string>
      <key>ProcessType</key>
      <string>Interactive</string>
      <key>Nice</key>
      <integer>-20</integer>
    </dict>
    </plist>
    EOS
  end

  test do
    assert_match "yabai-v#{version}", shell_output("#{bin}/yabai --version")
  end
end
