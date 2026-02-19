cask "postai" do
  version "1.4.0"
  sha256 "94bc4855b72941fc0b4a35677fa342e172f36ff7911c692b8d303799938a20fe"

  url "https://github.com/Softorize/postai/releases/download/v#{version}/PostAI-#{version}-arm64.dmg",
      verified: "github.com/Softorize/postai/"

  name "PostAI"
  desc "Advanced API Testing Tool with AI Integration"
  homepage "https://github.com/Softorize/postai"

  depends_on macos: ">= :monterey"

  app "PostAI.app"

  zap trash: [
    "~/Library/Application Support/PostAI",
    "~/Library/Preferences/com.postai.app.plist",
    "~/Library/Caches/com.postai.app",
    "~/Library/Logs/PostAI",
  ]
end
