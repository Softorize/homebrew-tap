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
  version "0.1.3"
  license :cannot_represent # closed source, paid plan — ADR-0006

  on_macos do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_arm64.tar.gz"
      sha256 "38881919b59f1659e94d54642e392db823baaaabfa13a4e4da6082d182838abb"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_amd64.tar.gz"
      sha256 "028693f15adf54ff2c6786d89659caa2d7a22a0cc00421436ad6c74aa0dd78d1"
    end
  end

  on_linux do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_arm64.tar.gz"
      sha256 "d2f2493797fe246a86cf3571793e65fa81d65ca7a5a18613dc3ba2babadac9d2"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_amd64.tar.gz"
      sha256 "43ff2b73e3d8b3cf7273093040f64b114bb57335dfb81c1112744f7e50176f4b"
    end
  end

  def install
    bin.install "cpass"
  end

  test do
    assert_match "cpass #{version}", shell_output("#{bin}/cpass version")
  end
end
