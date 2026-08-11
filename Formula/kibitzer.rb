class Kibitzer < Formula
  desc "Diff-aware code/doc inspection hook for Claude Code"
  homepage "https://github.com/tstapler/kibitzer"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.3/kibitzer-aarch64-apple-darwin.tar.xz"
      sha256 "594b15ae3b6b7779b16930f3fd9f99d8b9c5ba8397ba48982786f45b7a0d8f62"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.3/kibitzer-x86_64-apple-darwin.tar.xz"
      sha256 "edf86b2cf41ef39888735ff76909eb5946b9360d012be23adea9d34b957a700f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.3/kibitzer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f6fc26d9d54384553e225bd51268066a24441873e084fd124dda5d11683f5600"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.3/kibitzer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ba10ecaeaf590386390713830ff276085cae5e079f35f9ea0932bdeee928313b"
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
