class Krp < Formula
  desc "Utility to adjust keyrepeat settings for MacOS."
  homepage "https://github.com/koekeishiya/krp"
  url "https://github.com/koekeishiya/krp/releases/download/v0.0.2/krp-0.0.2.zip"
  sha256 "a716bc0b11ebf25d4378a88cc2a738f526a4e9cebc55eabe82abcf1ec1015027"

  def install
    bin.install "krp"
  end

  test do
    system "#{bin}/krp", "--version"
  end
end
