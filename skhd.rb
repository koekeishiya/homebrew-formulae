class Skhd < Formula
  desc "Simple hotkey-daemon for macOS."
  homepage "https://github.com/koekeishiya/skhd"
  url "https://github.com/koekeishiya/skhd/releases/download/v0.0.5/skhd-0.0.5.zip"
  sha256 "2e778be7d44d32ba7cf66212047a7419b7a5fc636c2ffdcb9ef7ff6e047b2932"

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
