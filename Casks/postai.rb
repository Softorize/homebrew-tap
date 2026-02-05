cask "postai" do
  version "1.3.4"
  sha256 "60dda08c9a3ca52daae94b3102d2c649e3b458a26aa17f7dcf549773d2bd7fb9"

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
