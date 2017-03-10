class Krp < Formula
  desc "Utility to adjust keyrepeat settings for MacOS."
  homepage "https://github.com/koekeishiya/krp"
  url "https://github.com/koekeishiya/krp/releases/download/v0.0.3/krp-0.0.3.zip"
  sha256 "dd3cb556d27a9eca56607dc73e2ead82ff91ce6f36517f38ec76b479be03ebb0"

  def install
    bin.install "krp"
  end

  test do
    system "#{bin}/krp", "--version"
  end
end
