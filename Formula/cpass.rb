# cpass (ClaudePass) ships from a PRIVATE source repo — gumruyanzh/claudepass
# — by design (ADR-0006: closed source, freemium). GoReleaser (CLA-16)
# builds the release binaries there, but they are published publicly at
# https://claudepass.com/dl/<version>/ (see claudepass's deploy/ directory
# and deploy/README.md), so `brew install` needs no GitHub token at all —
# the default Homebrew download strategy just curls a public URL, same as
# any other formula.
#
# sha256 values below come from the v0.1.1 release checksums.txt.

class Cpass < Formula
  desc "Secret manager for AI coding agents — Agents see Handles, never Secret values"
  homepage "https://claudepass.com"
  version "0.1.1"
  license :cannot_represent # closed source, paid plan — ADR-0006

  on_macos do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_arm64.tar.gz"
      sha256 "c0b877437e4aae417a04ca6762db9dcc15aaa29a8e33f659d58c9983c9d900ea"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_amd64.tar.gz"
      sha256 "d7d4c5aaa72f2f7fe9e5695f462a1a6d73e1078276ff67e4925189b762c707d3"
    end
  end

  on_linux do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_arm64.tar.gz"
      sha256 "5dd5911b394c26a9a68f3e29e2cd3616594eaafebbb9db821e4e8d2d0a8268ed"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_amd64.tar.gz"
      sha256 "38dd95d0c28105caf294c378c6f02b8113a8be5dc5c01b41f4639eeff71feae3"
    end
  end

  def install
    bin.install "cpass"
  end

  test do
    assert_match "cpass #{version}", shell_output("#{bin}/cpass version")
  end
end
