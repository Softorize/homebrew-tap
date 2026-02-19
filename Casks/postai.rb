cask "postai" do
  version "1.5.0"
  sha256 "b7a2d27291f450c5ec5105a82beb3b48815e18e234734196d5f61cb5eeea1036"

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
