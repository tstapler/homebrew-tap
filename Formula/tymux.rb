class Tymux < Formula
  desc "Terminal multiplexer daemon (tymuxd) and CLI (tymux)"
  homepage "https://github.com/tstapler/tymux"
  version "1.17.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tstapler/tymux/releases/download/v1.17.6/tymux-aarch64-apple-darwin.tar.gz"
      sha256 "7c302a6af90ff540acbec4ecda50735eb0eb0386912d01f162417e3f46c715f1"
    end
    on_intel do
      url "https://github.com/tstapler/tymux/releases/download/v1.17.6/tymux-x86_64-apple-darwin.tar.gz"
      sha256 "cd7f8c09287a4659c6b0648e471fe7b859b134ad2592c5b33360d1656acfd5cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tstapler/tymux/releases/download/v1.17.6/tymux-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0a767680d41e575fb36fa3249628ca3d723f4affd8eec7bb981a68cdfee57ed0"
    end
    on_intel do
      url "https://github.com/tstapler/tymux/releases/download/v1.17.6/tymux-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7cf3fca6b311214cd89aea02d6db5ab841d7e3333328b9515fb2aca70d63832f"
    end
  end

  def install
    bin.install "tymuxd", "tymux"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tymuxd --version")
  end
end
