class Kibitzer < Formula
  desc "Advisory, diff-aware code/doc quality checks for AI agents, CI, and local dev"
  homepage "https://github.com/tstapler/kibitzer"
  version "0.1.30"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.30/kibitzer-aarch64-apple-darwin.tar.xz"
      sha256 "e1d9709c89e7d06d653363b417eb7e036eb12b44fd59aa3044119b7650c08546"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.30/kibitzer-x86_64-apple-darwin.tar.xz"
      sha256 "778f772aaff542d77c30b3c42fc04606a607869720c415e51835fc1ed2f3aecc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.30/kibitzer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "00315816a5036ea66fb81b47efd7c678de9b980408020ccec19099056c005cc2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.30/kibitzer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "68a0a17a5c9c08724ea6734ff44022e494ab8d11685156ed0691a9718edf6578"
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
