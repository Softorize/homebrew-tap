# cpass (ClaudePass) ships from a PRIVATE source repo — gumruyanzh/claudepass
# — by design (ADR-0006: closed source, freemium). GoReleaser (CLA-16)
# publishes binary-only GitHub Releases there, so `brew install` needs a
# way to read those release assets without repo access to the source.
#
# Two ways to get there, and this formula takes the first:
#
#   1. HOMEBREW_GITHUB_API_TOKEN (what this formula does). Anyone installing
#      it exports a token with read access to gumruyanzh/claudepass before
#      running `brew install`; GitHubPrivateReleaseDownloadStrategy below
#      uses it to pull the asset through the GitHub API. Zero extra
#      infrastructure, but every installer needs a token — fine for the
#      owner and invited testers, not for a walk-up "free tier" user.
#
#   2. A public releases-only mirror repo that the private repo's release
#      workflow pushes binaries (never source) to, so this formula's `url`
#      could point at a public repo needing no token at all. That is the
#      right long-term shape for PRD story 51 ("install via Homebrew and
#      use immediately"), but stands up a second GitHub repo plus a
#      cross-repo publish credential — real infra, decided against for
#      this pass. Filed as a follow-up (see ClaudePass CLA board) rather
#      than built silently here.
#
# sha256 values below come from the v0.1.1 release checksums.txt.

require "json"

class GitHubPrivateReleaseDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super
    parse_url_pattern
    set_github_token
  end

  def parse_url_pattern
    url_pattern = %r{https://github\.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(.+)}
    match = @url.match(url_pattern)
    raise CurlDownloadStrategyError, "Invalid URL pattern for a GitHub Release: #{@url}" unless match

    _, @owner, @repo, @tag, @filename = *match
  end

  def set_github_token
    @github_token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
    return if @github_token

    raise CurlDownloadStrategyError, <<~EOS
      HOMEBREW_GITHUB_API_TOKEN is not set.
      #{@owner}/#{@repo} is a private repository; brew needs a token with
      read access to it to download release assets:
        export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
      then retry the install.
    EOS
  end

  def asset_download_url
    metadata_url = "https://api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}"
    headers = ["Authorization: token #{@github_token}", "Accept: application/vnd.github+json"]
    metadata, = curl_output("--fail", "--silent", *headers.flat_map { |h| ["--header", h] }, metadata_url)
    assets = JSON.parse(metadata).fetch("assets", [])
    asset = assets.find { |a| a["name"] == @filename }
    id = asset && asset["id"]
    raise CurlDownloadStrategyError, "No asset named #{@filename} in #{@owner}/#{@repo}@#{@tag}" unless id

    "https://api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{id}"
  end

  def _fetch(url:, resolved_url:, timeout:)
    ohai "Downloading #{@filename} from #{@owner}/#{@repo}@#{@tag} (private repo, authenticated)"
    curl_download(asset_download_url,
                   "--header", "Authorization: token #{@github_token}",
                   "--header", "Accept: application/octet-stream",
                   to: temporary_path)
  end
end

class Cpass < Formula
  desc "Secret manager for AI coding agents — Agents see Handles, never Secret values"
  homepage "https://github.com/gumruyanzh/claudepass"
  version "0.1.1"
  license :cannot_represent # closed source, paid plan — ADR-0006

  on_macos do
    on_arm do
      url "https://github.com/gumruyanzh/claudepass/releases/download/v#{version}/cpass_darwin_arm64.tar.gz",
          using: GitHubPrivateReleaseDownloadStrategy
      sha256 "c0b877437e4aae417a04ca6762db9dcc15aaa29a8e33f659d58c9983c9d900ea"
    end

    on_intel do
      url "https://github.com/gumruyanzh/claudepass/releases/download/v#{version}/cpass_darwin_amd64.tar.gz",
          using: GitHubPrivateReleaseDownloadStrategy
      sha256 "d7d4c5aaa72f2f7fe9e5695f462a1a6d73e1078276ff67e4925189b762c707d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gumruyanzh/claudepass/releases/download/v#{version}/cpass_linux_arm64.tar.gz",
          using: GitHubPrivateReleaseDownloadStrategy
      sha256 "5dd5911b394c26a9a68f3e29e2cd3616594eaafebbb9db821e4e8d2d0a8268ed"
    end

    on_intel do
      url "https://github.com/gumruyanzh/claudepass/releases/download/v#{version}/cpass_linux_amd64.tar.gz",
          using: GitHubPrivateReleaseDownloadStrategy
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
