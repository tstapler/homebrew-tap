class Kibitzer < Formula
  desc "Advisory, diff-aware code/doc quality checks for AI agents, CI, and local dev"
  homepage "https://github.com/tstapler/kibitzer"
  version "0.1.21"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.21/kibitzer-aarch64-apple-darwin.tar.xz"
      sha256 "3323e47fc2c268cccafd1edd03758e75ab989eadbbcce9d6a44b64a2922cec1f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.21/kibitzer-x86_64-apple-darwin.tar.xz"
      sha256 "969fe9ee841879f1ae3e2d2f3dadeb4e736acec1966d8ae81d69908c1c90c074"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.21/kibitzer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a2bed623fd0a2068b3faee6b754d2a0e4331d89a698c5c6563eaaa2975a8e03b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.21/kibitzer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5d934a87d7ab1f3b46a0186246246c0760651836f06ba3bf945f4b6ccb9933ad"
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
