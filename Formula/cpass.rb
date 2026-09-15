# cpass (ClaudePass) — https://github.com/Elixion-ai/claudepass, free and
# open source under the MIT license (ADR-0011). GoReleaser builds the release
# binaries from tagged commits and they are mirrored at
# https://claudepass.com/dl/<version>/ (see the repo's deploy/README.md), so
# `brew install` just curls a public URL like any other formula.
#
# sha256 values below come from the release's checksums.txt.

class Cpass < Formula
  desc "Secret manager for AI coding agents — Agents see Handles, never Secret values"
  homepage "https://claudepass.com"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_arm64.tar.gz"
      sha256 "7fc2832cc2fc43e23835836369838dc1de1815a10520098ff91cceb997415fae"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_amd64.tar.gz"
      sha256 "64723b78f6ada0ff493651d8e988cb929824c311f7bdf4439901d729a4cedcd2"
    end
  end

  on_linux do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_arm64.tar.gz"
      sha256 "b852fb38e683337de15d6556d2f5f83e95debf412e201d6a065f969102ae4ca1"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_amd64.tar.gz"
      sha256 "7677b31c5c596884af905448d350de3a5644c761b00d2bac1c79f3bd11d9ee96"
    end
  end

  def install
    bin.install "cpass"
  end

  test do
    assert_match "cpass #{version}", shell_output("#{bin}/cpass version")
  end
end
