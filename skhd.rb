class Skhd < Formula
  desc "Simple hotkey-daemon for macOS"
  homepage "https://github.com/koekeishiya/skhd"
  url "https://github.com/koekeishiya/skhd/archive/refs/tags/v0.3.5.tar.gz"
  sha256 "5e3adcd0cb13b3f260ae72957603a1f587c34dd9abb8d990f036baa567bdaf23"
  head "https://github.com/koekeishiya/skhd.git"

  def install
    (var/"log/skhd").mkpath
    system "make", "install"
    bin.install "#{buildpath}/bin/skhd"
    (pkgshare/"examples").install "#{buildpath}/examples/skhdrc"
  end

  def caveats
    <<~EOS
    Copy the example configuration into your home directory:
      cp #{opt_pkgshare}/examples/skhdrc ~/.skhdrc

    If the formula has been built with --with-logging, logs will be found in
      #{var}/log/skhd/skhd.[out|err].log
    EOS
  end

  service do
    run [
      HOMEBREW_PREFIX/"bin/skhd",
    ]
    require_root false
    working_dir HOMEBREW_PREFIX/"bin"
    environment_variables PATH: HOMEBREW_PREFIX/"bin:/usr/bin:/bin:/usr/sbin:/sbin"
    process_type :interactive
    keep_alive true
    log_path var/"log/skhd/skhd.out.log"
    error_log_path var/"log/skhd/skhd.err.log"
  end

  test do
    assert_match "skhd #{version}", shell_output("#{bin}/skhd --version")
  end
end
