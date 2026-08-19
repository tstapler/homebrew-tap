class Kibitzer < Formula
  desc "Advisory, diff-aware code/doc quality checks for AI agents, CI, and local dev"
  homepage "https://github.com/tstapler/kibitzer"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.7/kibitzer-aarch64-apple-darwin.tar.xz"
      sha256 "9c923921531ed00b8228f419afeef01b18bad8ece00a8bbfdf1b59ed7765fed8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.7/kibitzer-x86_64-apple-darwin.tar.xz"
      sha256 "eae32e7e4e1bf1a7f43f6ad8a91810c4044878cd36427921d5fa2c8a5b02de04"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.7/kibitzer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "abc73ee298e0b18802be50a31ca9eb5338b859fd848780785e7761329233c905"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.7/kibitzer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bf76f7963ff4108ac4f396cf78be346602c49743005e56ca9e90b8b3fc7bde1d"
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
