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
  version "0.1.4"
  license :cannot_represent # closed source, paid plan — ADR-0006

  on_macos do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_arm64.tar.gz"
      sha256 "02306e04c33ea85c0b92db0151e53c1a3fe99bf0001734b29ba0fc97caed8e02"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_amd64.tar.gz"
      sha256 "e6814f329422934675938d6af3637803f57c609cbf6a420329e6ba011ed535cd"
    end
  end

  on_linux do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_arm64.tar.gz"
      sha256 "45581cf08c9aac123b79b55b38cc3f59555b65408322b24ca1de89e062e6c215"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_amd64.tar.gz"
      sha256 "7999d5c2d92ca3a57182a214b2794d1bbf2b8ba102f26c07084e40a39aacf9c0"
    end
  end

  def install
    bin.install "cpass"
  end

  test do
    assert_match "cpass #{version}", shell_output("#{bin}/cpass version")
  end
end
