class Kibitzer < Formula
  desc "Advisory, diff-aware code/doc quality checks for AI agents, CI, and local dev"
  homepage "https://github.com/tstapler/kibitzer"
  version "0.1.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.11/kibitzer-aarch64-apple-darwin.tar.xz"
      sha256 "3bd25f4580fd4fd68a62addd5aa1b029015f7912a02eec98baf56c91b54036b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.11/kibitzer-x86_64-apple-darwin.tar.xz"
      sha256 "54a5f03aa7c55d7d72ac81a51e016c957cedf5803dc3bea83a1dd4e4926aef61"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.11/kibitzer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9257a6d3e60b5e78a7d26f0e52234070dcd0830e1eaa971174713dbc27bb3636"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.11/kibitzer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6ade2d7a0ba18098e8299a9fd2cbc4be1be24b52e63ca2d79e00c9f0c3e36d4e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "kibitzer"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kibitzer"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kibitzer"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kibitzer"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
