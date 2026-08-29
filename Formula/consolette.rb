class Consolette < Formula
  desc "consolette — CLI / MCP tool"
  homepage "https://github.com/tstapler/consolette"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/consolette/releases/download/v0.1.1/consolette-aarch64-apple-darwin.tar.xz"
      sha256 "6d158ef7438de0a45668ae3247b94d223371d27a96e0bfd9d2ba7048d44a600a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/consolette/releases/download/v0.1.1/consolette-x86_64-apple-darwin.tar.xz"
      sha256 "563fa547d41346da2f948af601762e846931c131212cb594729bd2145f53c0f0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/consolette/releases/download/v0.1.1/consolette-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a873f98a90357ba0a5b75ff8c12d0dad438100fb4c1b9bfb5590af32a4c5a659"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/consolette/releases/download/v0.1.1/consolette-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3692df2c7248fa1a4917b892495a14949a4e724f985c2ddedcab5bbaa8ece7ed"
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
      bin.install "cmdcrush", "consolette", "mcp-proxy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cmdcrush", "consolette", "mcp-proxy"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cmdcrush", "consolette", "mcp-proxy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cmdcrush", "consolette", "mcp-proxy"
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
