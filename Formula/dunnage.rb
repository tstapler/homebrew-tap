class Dunnage < Formula
  desc "Reclaim disk space safely; dry run by default"
  homepage "https://github.com/tstapler/dunnage"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/tstapler/dunnage/releases/download/v0.1.1/dunnage-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "b5eab381983220c026a708c589c8480c17ac3ad23aee727009ea1623f27b1286"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tstapler/dunnage/releases/download/v0.1.1/dunnage-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1ad482e6ef6ce96f0b7197ca58fb4ca3d4294d88e8df7c624f3470c3baf2ef04"
    end
    on_intel do
      url "https://github.com/tstapler/dunnage/releases/download/v0.1.1/dunnage-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3a1b1cb88dd46599bc00b5217ecd218b2a40ccebefb1f25832a487a37ec94721"
    end
  end

  def install
    bin.install "dunnage"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dunnage --version")
  end
end
