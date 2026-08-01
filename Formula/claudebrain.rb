class Claudebrain < Formula
  desc "Watch Claude Code think - live synapse-graph visualizer for sessions and tools"
  homepage "https://github.com/Softorize/claudebrain"
  license "MIT"
  version "0.4.0"
  url "https://github.com/Softorize/claudebrain/releases/download/v#{version}/claudebrain-#{version}.tgz"
  sha256 "0e5f69bc6cd6605124671bbb7755b4a008cf7b06f665133ca6daaeabcc2d2a4c"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  service do
    run [opt_bin/"claudebrain", "start", "--no-open"]
    keep_alive true
    log_path var/"log/claudebrain.log"
    error_log_path var/"log/claudebrain.log"
  end

  def caveats
    <<~EOS
      Wire up Claude Code (shows a diff of ~/.claude/settings.json and asks first):
        claudebrain install-hooks
      then start the viewer:
        claudebrain start
      Only sessions started after installing hooks report events.
      Undo anytime with: claudebrain uninstall-hooks
      Run the viewer server persistently (auto-restarts, starts at login):
        brew services start claudebrain
    EOS
  end

  test do
    assert_match "claudebrain", shell_output("#{bin}/claudebrain help")
    assert_match version.to_s, shell_output("#{bin}/claudebrain version")
  end
end
