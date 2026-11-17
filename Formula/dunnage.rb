class Dunnage < Formula
  desc "Reclaim disk space safely; dry run by default"
  homepage "https://github.com/tstapler/dunnage"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/tstapler/dunnage/releases/download/v0.3.1/dunnage-0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "940e31ebb08a234d25b89a242ebbf32c55aea5dd8f1df20b204f33596dda0c2f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tstapler/dunnage/releases/download/v0.3.1/dunnage-0.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2ab80b26d04a1c4e7da7d9a72240cb4c37292e95a86be7c77fc2a5b4bc4d7e83"
    end
    on_intel do
      url "https://github.com/tstapler/dunnage/releases/download/v0.3.1/dunnage-0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "469311834ed5464a35a1f55f5248725783bf3f92cdd8cd2f84320d4382653c31"
    end
  end

  def install
    bin.install "dunnage"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dunnage --version")
  end
end
