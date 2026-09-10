class Kibitzer < Formula
  desc "Advisory, diff-aware code/doc quality checks for AI agents, CI, and local dev"
  homepage "https://github.com/tstapler/kibitzer"
  version "0.1.16"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.16/kibitzer-aarch64-apple-darwin.tar.xz"
      sha256 "a674afa47c63cc6f3068365a2d32f857121247f6445d710dce0dc7644a811ff7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.16/kibitzer-x86_64-apple-darwin.tar.xz"
      sha256 "778706ae2057fbef2d84eb128a11611f24b6684cd0a62e98ab98fd9f22b0caf9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.16/kibitzer-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "37105135b71c4ef8951679f78ff4380a6a3a30ca66abfd9b4a9a5f6ea32c5f15"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tstapler/kibitzer/releases/download/v0.1.16/kibitzer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6b2dcf8d8331375d650c93524f8cd7b9b870e0ebaa257e908b31fbff2f9e6df0"
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
