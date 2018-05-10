class Khd < Formula
  desc "Simple hotkey-daemon for OSX."
  homepage "https://github.com/koekeishiya/khd"
  url "https://github.com/koekeishiya/khd/archive/v3.0.0.zip"
  sha256 "20574c2fae6b435624fa44bd6b658a9146617aab05af59d149277bf6b40729f4"
  head "https://github.com/koekeishiya/khd.git"

  option "with-logging", "Redirect stdout and stderr to log files"

  def install
    (var/"log/khd").mkpath
    system "make", "install"
    bin.install "#{buildpath}/bin/khd"
    (pkgshare/"examples").install "#{buildpath}/examples/khdrc"
  end

  def caveats; <<~EOS
    Copy the example configuration into your home directory:
      cp #{opt_pkgshare}/examples/khdrc ~/.khdrc

    If the formula has been built with --with-logging, logs will be found in
      #{var}/log/khd/khd.[out|err].log
    EOS
  end

  plist_options :manual => "khd"

  if build.with? "logging"
      def plist; <<~EOS
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/khd</string>
          </array>
          <key>EnvironmentVariables</key>
          <dict>
            <key>PATH</key>
            <string>#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
          </dict>
          <key>KeepAlive</key>
          <true/>
          <key>StandardOutPath</key>
          <string>#{var}/log/khd/khd.out.log</string>
          <key>StandardErrorPath</key>
          <string>#{var}/log/khd/khd.err.log</string>
          <key>Sockets</key>
          <dict>
            <key>Listeners</key>
            <dict>
              <key>SockServiceName</key>
              <string>3021</string>
              <key>SockType</key>
              <string>dgram</string>
              <key>SockFamily</key>
              <string>IPv4</string>
          </dict>
        </dict>
        </dict>
        </plist>
        EOS
      end
  else
      def plist; <<~EOS
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/khd</string>
          </array>
          <key>EnvironmentVariables</key>
          <dict>
            <key>PATH</key>
            <string>#{HOMEBREW_PREFIX}/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
          </dict>
          <key>KeepAlive</key>
          <true/>
          <key>Sockets</key>
          <dict>
            <key>Listeners</key>
            <dict>
              <key>SockServiceName</key>
              <string>3021</string>
              <key>SockType</key>
              <string>dgram</string>
              <key>SockFamily</key>
              <string>IPv4</string>
          </dict>
        </dict>
        </dict>
        </plist>
        EOS
      end
  end

  test do
    assert_match "khd #{version}", shell_output("#{bin}/khd --version")
  end
end
