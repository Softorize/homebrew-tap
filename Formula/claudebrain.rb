class Claudebrain < Formula
  desc "Watch Claude Code think - live synapse-graph visualizer for sessions and tools"
  homepage "https://github.com/Softorize/claudebrain"
  license "MIT"
  version "0.3.0"
  url "https://github.com/Softorize/claudebrain/releases/download/v#{version}/claudebrain-#{version}.tgz"
  sha256 "6114c309f7d9cfb85b8d3b62a7ca6b63957407d85cdc13ef0a6357156789b4e8"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      Wire up Claude Code (shows a diff of ~/.claude/settings.json and asks first):
        claudebrain install-hooks
      then start the viewer:
        claudebrain start
      Only sessions started after installing hooks report events.
      Undo anytime with: claudebrain uninstall-hooks
    EOS
  end

  test do
    assert_match "claudebrain", shell_output("#{bin}/claudebrain help")
    assert_match version.to_s, shell_output("#{bin}/claudebrain version")
  end
end
