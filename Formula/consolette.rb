class Consolette < Formula
  desc "Provider-agnostic LLM router: proxies Anthropic/Bedrock/OpenAI-compatible upstreams with fallback, weighted routing, and rate limiting"
  homepage "https://github.com/tstapler/consolette"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/consolette/releases/download/v0.4.0/consolette-aarch64-apple-darwin.tar.xz"
      sha256 "b757405c74c82567814cdce9c6ee70b9a1b15477c5c555fe370f31bcc9017f96"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/consolette/releases/download/v0.4.0/consolette-x86_64-apple-darwin.tar.xz"
      sha256 "3c54b371875f9e47d336016bf22e11fc7296a7f146722376875143c236e112df"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/consolette/releases/download/v0.4.0/consolette-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b6968b8cae433d6e4572e2e1ad99bb8f9ee3a7dfdbfb00742b6eeeeddacc2346"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/consolette/releases/download/v0.4.0/consolette-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "97fa16b8a45b88f4007da677b2057ebaf4a246978d788e1c36b081a58c3777cd"
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
