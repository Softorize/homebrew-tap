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
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_arm64.tar.gz"
      sha256 "5cadeb764e3a762ae1c4a4eb75f5abd196c9e10a74acec5699b52b4e52b78c4a"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_darwin_amd64.tar.gz"
      sha256 "4828033f357a3120f9a92b89952a007dfc5b1dbb6a499ab38d3a3435e1a23a40"
    end
  end

  on_linux do
    on_arm do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_arm64.tar.gz"
      sha256 "e05527407eeddd6fb48deeaf9850079713cbd2329c44368815479f8be1259813"
    end

    on_intel do
      url "https://claudepass.com/dl/v#{version}/cpass_linux_amd64.tar.gz"
      sha256 "08e417c24e011feff04e6e3b3789694cba10fa4b1930e6cba04d8107a67f2ba3"
    end
  end

  def install
    bin.install "cpass"
  end

  test do
    assert_match "cpass #{version}", shell_output("#{bin}/cpass version")
  end
end
