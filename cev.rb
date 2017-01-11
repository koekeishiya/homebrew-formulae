class Cev < Formula
  desc "Keycode grabber for OSX."
  homepage "https://github.com/koekeishiya/cev"
  url "https://github.com/koekeishiya/cev/releases/download/v0.0.1/cev-0.0.1.zip"
  sha256 "aea5d6650880d343d186ad4a990ab90adb02d262803e8258ea7fe446cb642be9"

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
