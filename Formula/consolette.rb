class Consolette < Formula
  desc "Provider-agnostic LLM router: proxies Anthropic/Bedrock/OpenAI-compatible upstreams with fallback, weighted routing, and rate limiting"
  homepage "https://github.com/tstapler/consolette"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/consolette/releases/download/v0.2.0/consolette-aarch64-apple-darwin.tar.xz"
      sha256 "c211520ef860cc23be516d9857de495fa66c25dd43d4aa37a4d818b18f1a650f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/consolette/releases/download/v0.2.0/consolette-x86_64-apple-darwin.tar.xz"
      sha256 "a31b27d607e4013bab3325293e31a2d109f9648fb0eab096652e20fc4961d46e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/consolette/releases/download/v0.2.0/consolette-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a4456c9c6712c1cb28900ab1e6e83b2289f6dc4595525dde85fd26258ddf19ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/consolette/releases/download/v0.2.0/consolette-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0b05f6eb7bae86812bad94bf3445bf98cd513ef97719415a16c66e98779509ae"
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
