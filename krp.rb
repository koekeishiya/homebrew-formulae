class Krp < Formula
  desc "Utility to adjust keyrepeat settings for MacOS."
  homepage "https://github.com/koekeishiya/krp"
  url "https://github.com/koekeishiya/krp/releases/download/v1.0.0/krp-1.0.0.zip"
  sha256 "8fe6ead50a5a623f2e9667c85c08badfb0f4adfdd56b891163afe0ce270c09d0"

  def install
    bin.install "krp"
  end

  test do
    system "#{bin}/krp", "--version"
  end
end
