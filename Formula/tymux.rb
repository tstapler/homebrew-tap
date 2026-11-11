class Tymux < Formula
  desc "Terminal multiplexer daemon (tymuxd) and CLI (tymux)"
  homepage "https://github.com/tstapler/tymux"
  version "1.17.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tstapler/tymux/releases/download/v1.17.5/tymux-aarch64-apple-darwin.tar.gz"
      sha256 "23be2f111e79da04ea9c255dfbe236a96f1426764d7d1ac4c365cb88297e452f"
    end
    on_intel do
      url "https://github.com/tstapler/tymux/releases/download/v1.17.5/tymux-x86_64-apple-darwin.tar.gz"
      sha256 "6018176b9e79b671c33611078336d2b8c57e58d710e73d3f3e62fa9d5b861208"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tstapler/tymux/releases/download/v1.17.5/tymux-aarch64-unknown-linux-musl.tar.gz"
      sha256 "77a20de0f6f5d0a52493c852668193c7bf7e75471f2bab8543a987778b4b6d84"
    end
    on_intel do
      url "https://github.com/tstapler/tymux/releases/download/v1.17.5/tymux-x86_64-unknown-linux-musl.tar.gz"
      sha256 "71b9584eea4481bc49b1db33452fcf47a077e64d5c00d0eb2b415dd7c30068db"
    end
  end

  def install
    bin.install "tymuxd", "tymux"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tymuxd --version")
  end
end
