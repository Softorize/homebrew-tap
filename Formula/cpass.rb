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
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_arm64.tar.gz"
      sha256 "7fb614e6c7df16b13b362827c035c30b9ce6173ee32066f2ff1018e78fd6eec0"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_amd64.tar.gz"
      sha256 "30c3d1dfd12d5a939d260f8bf727067bb5e5b6689ef9bab29f3dff2a852a482d"
    end
  end

  on_linux do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_arm64.tar.gz"
      sha256 "2e44c0f5d1463078e8882b4f047faceacf5facee9d592287f0974c2f4e4895dc"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_amd64.tar.gz"
      sha256 "e6cf53e7849e2f852abf49981c3ab4487af9078cff67cf2eac5898fd335bb2b4"
    end
  end

  def install
    bin.install "cpass"
  end

  test do
    assert_match "cpass #{version}", shell_output("#{bin}/cpass version")
  end
end
