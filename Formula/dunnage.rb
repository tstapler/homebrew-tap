class Dunnage < Formula
  desc "Reclaim disk space safely; dry run by default"
  homepage "https://github.com/tstapler/dunnage"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/tstapler/dunnage/releases/download/v0.3.0/dunnage-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "8fa2669805eeba666c43013c902ecc99b22150c0cf79a0d9e52b157cc167f65f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tstapler/dunnage/releases/download/v0.3.0/dunnage-0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3dc43ec3c661e3d7704a655499cde1a1cb7820f52cafeef6542d6d1ba18f9a50"
    end
    on_intel do
      url "https://github.com/tstapler/dunnage/releases/download/v0.3.0/dunnage-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "be8e851acbd0a89590116f7552b81478481e591de3ef0ef8bf1b591e65943c35"
    end
  end

  def install
    bin.install "dunnage"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dunnage --version")
  end
end
