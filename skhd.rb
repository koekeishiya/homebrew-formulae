class Skhd < Formula
  desc "Simple hotkey-daemon for macOS."
  homepage "https://github.com/koekeishiya/skhd"
  url "https://github.com/koekeishiya/skhd/releases/download/v0.0.6/skhd-0.0.6.zip"
  sha256 "d992545e0951974ba3da80c042649e96e49ae7d8a43609a8df6e73724277c5d7"

  def install
    bin.install "skhd"
    prefix.install %w[skhdrc]
  end

  plist_options :startup => false

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
      <string>#{bin}/skhd</string>
      </array>
      <key>EnvironmentVariables</key>
      <dict>
          <key>PATH</key>
          <string>#{bin}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
      </dict>
      <key>KeepAlive</key>
      <true/>
      <key>StandardOutPath</key>
      <string>/tmp/skhd.out</string>
      <key>StandardErrorPath</key>
      <string>/tmp/skhd.err</string>
    </dict>
    </plist>
    EOS
  end

  def caveats; <<-EOS.undent
    Copy the example config from #{prefix}/skhdrc into your home directory.
      cp #{prefix}/skhdrc ~/.skhdrc
    EOS
  end

  test do
    system "#{bin}/skhd", "--version"
  end
end
