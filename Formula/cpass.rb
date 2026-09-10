# cpass (ClaudePass) ships from a PRIVATE source repo — gumruyanzh/claudepass
# — by design (ADR-0006: closed source, freemium). GoReleaser (CLA-16)
# builds the release binaries there, but they are published publicly at
# https://claudepass.com/dl/<version>/ (see claudepass's deploy/ directory
# and deploy/README.md), so `brew install` needs no GitHub token at all —
# the default Homebrew download strategy just curls a public URL, same as
# any other formula.
#
# sha256 values below come from the v0.1.2 release checksums.txt.

class Cpass < Formula
  desc "Secret manager for AI coding agents — Agents see Handles, never Secret values"
  homepage "https://claudepass.com"
  version "0.1.2"
  license :cannot_represent # closed source, paid plan — ADR-0006

  on_macos do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_arm64.tar.gz"
      sha256 "6017f3a8d2668a8994e71b11653911f09209ce7791fea7a5775f4e4217aece09"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_amd64.tar.gz"
      sha256 "18d3b7eeab35f7c8fc1604a1f39f5475fa9af98afa5c5a5a822d34786a191daf"
    end
  end

  on_linux do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_arm64.tar.gz"
      sha256 "b01c362d017c57a390d5b16227e8a9157fffa4fc663017d34635452f2f6cfb07"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_amd64.tar.gz"
      sha256 "a5e4c54bf4bb0123ad4383fd80d2d0216d5ac271490b06145be6b6ecd5757b4d"
    end
  end

  def install
    bin.install "cpass"
  end

  test do
    assert_match "cpass #{version}", shell_output("#{bin}/cpass version")
  end
end
