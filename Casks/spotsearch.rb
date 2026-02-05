cask "spotsearch" do
  version "1.4.0"
  sha256 "7df26ab857809f9e81d8dcf46d2a6abdd106cb441e6843aa4a6bcac76d677e15"

  url "https://github.com/Softorize/spotsearch/releases/download/v#{version}/SpotSearch-#{version}-arm64.dmg"
  name "SpotSearch"
  desc "Fast, lightweight file search application for macOS"
  homepage "https://github.com/Softorize/spotsearch"

  depends_on macos: ">= :ventura"

  app "SpotSearch.app"

  zap trash: [
    "~/Library/Application Support/SpotSearch",
    "~/Library/Preferences/com.spotsearch.app.plist",
  ]
end
