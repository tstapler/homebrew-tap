class Dunnage < Formula
  desc "Reclaim disk space safely; dry run by default"
  homepage "https://github.com/tstapler/dunnage"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/tstapler/dunnage/releases/download/v0.2.0/dunnage-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "232bfda525bc76e7874cda44b61c622fe564ea94a057f85b9381cd410796fd28"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tstapler/dunnage/releases/download/v0.2.0/dunnage-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "03141ab79614d02863e68683f69a399ec0a1b3cde8883a47fc6e086c60b618f2"
    end
    on_intel do
      url "https://github.com/tstapler/dunnage/releases/download/v0.2.0/dunnage-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "11f13ade02c6a671495995c7f7fdb8a2dcdc278a38f294cffaf99c57be7ac4bf"
    end
  end

  def install
    bin.install "dunnage"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dunnage --version")
  end
end
