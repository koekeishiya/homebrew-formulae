class Cev < Formula
  desc "Keycode grabber for OSX."
  homepage "https://github.com/koekeishiya/cev"
  url "https://github.com/koekeishiya/cev/releases/download/v0.0.1/cev-0.0.1.zip"
  sha256 "db21e7a680d6ef6ca93ccd6dbfac1d8dfc2700799d8eb74fcdb2808c277b6a87"

  def install
    bin.install "cev"
  end

  def caveats; <<-EOS.undent
    Secure Keyboard Entry must be disabled. Cev must be ran as root!
    EOS
  end

  test do
    system "#{bin}/cev", "--version"
  end
end
