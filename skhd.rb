class Skhd < Formula
  desc "Simple hotkey-daemon for macOS."
  homepage "https://github.com/koekeishiya/skhd"
  url "https://github.com/koekeishiya/skhd/archive/v0.3.5.zip"
  sha256 "64e40b4f65e9db1c4a4ce333b4978bbd84fb72df62e5d17dd2b6a41bf008ee10"
  head "https://github.com/koekeishiya/skhd.git"

  option "with-logging", "Redirect stdout and stderr to log files"

  def install
    (var/"log/skhd").mkpath
    system "make", "install"
    bin.install "#{buildpath}/bin/skhd"
    (pkgshare/"examples").install "#{buildpath}/examples/skhdrc"
  end

  def caveats; <<~EOS
    Copy the example configuration into your home directory:
      cp #{opt_pkgshare}/examples/skhdrc ~/.skhdrc

    If the formula has been built with --with-logging, logs will be found in
      #{var}/log/skhd/skhd.[out|err].log
    EOS
  end

  if build.with? "logging"
    service do
      run "#{opt_bin}/skhd"
      environment_variables PATH: std_service_path_env
      keep_alive true
      log_path "#{var}/log/skhd/skhd.out.log"
      error_log_path "#{var}/log/skhd/skhd.err.log"
      process_type :interactive
    end
  else
    service do
      run "#{opt_bin}/skhd"
      environment_variables PATH: std_service_path_env
      keep_alive true
      process_type :interactive
    end
  end

  test do
    assert_match "skhd #{version}", shell_output("#{bin}/skhd --version")
  end
end
