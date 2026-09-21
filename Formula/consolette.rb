class Consolette < Formula
  desc "Provider-agnostic LLM router: proxies Anthropic/Bedrock/OpenAI-compatible upstreams with fallback, weighted routing, and rate limiting"
  homepage "https://github.com/tstapler/consolette"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/consolette/releases/download/v0.3.0/consolette-aarch64-apple-darwin.tar.xz"
      sha256 "435c13a267cdbb38b35d9416a32d134b19aad711b17bf08a4269159648710eb4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/consolette/releases/download/v0.3.0/consolette-x86_64-apple-darwin.tar.xz"
      sha256 "af4d84d6c6114287be716c30c0466f7d651808372d13f2727608f8b752211cd5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/consolette/releases/download/v0.3.0/consolette-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f672eccad26ceb3bee6bef86b7232da8fd6c15b07917e90a1b0330ea96003615"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/consolette/releases/download/v0.3.0/consolette-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5c4342c23cd2fabef1b81d70b1c4395f6e92a73b75af02deb9b295741b37dad4"
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
      bin.install "cmdcrush", "consolette", "mcp-proxy", "readme-check"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cmdcrush", "consolette", "mcp-proxy", "readme-check"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cmdcrush", "consolette", "mcp-proxy", "readme-check"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cmdcrush", "consolette", "mcp-proxy", "readme-check"
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
