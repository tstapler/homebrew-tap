class Dunnage < Formula
  desc "Reclaim disk space safely; dry run by default"
  homepage "https://github.com/tstapler/dunnage"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/tstapler/dunnage/releases/download/v0.2.1/dunnage-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "2ebdc384d61594b30c1e8964ab00916370e67d9a4b9e6d09b4212c3daf0e685b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tstapler/dunnage/releases/download/v0.2.1/dunnage-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6249162509e81f707af5dc966206b94aef96a8e78f599476e45ac5300483f90e"
    end
    on_intel do
      url "https://github.com/tstapler/dunnage/releases/download/v0.2.1/dunnage-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d5095f889a580b7589ee1e08bb2504638a54bde40bc9540e63ecabc570a3985f"
    end
  end

  def install
    bin.install "dunnage"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dunnage --version")
  end
end
