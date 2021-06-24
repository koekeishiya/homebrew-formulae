class Limelight < Formula
  desc "Standalone port of the yabai v2.4.3 border implementation"
  homepage "https://github.com/koekeishiya/limelight"
  head "https://github.com/koekeishiya/limelight.git"

  depends_on macos: :high_sierra

  def install
    man.mkpath

    system "make" if build.head?

    bin.install "#{buildpath}/bin/limelight"
    (pkgshare/"examples").install "#{buildpath}/examples/limelightrc"
    man1.install "#{buildpath}/doc/limelight.1"
  end

  def caveats
    <<~EOS
      Copy the example configuration into your home directory:
        cp #{opt_pkgshare}/examples/limelightrc ~/.limelightrc
    EOS
  end

  test do
    assert_match "limelight-v0.0.1", shell_output("#{bin}/limelight --version")
  end
end
