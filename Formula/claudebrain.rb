class Claudebrain < Formula
  desc "Watch Claude Code think - live synapse-graph visualizer for sessions and tools"
  homepage "https://github.com/Softorize/claudebrain"
  license "MIT"
  version "0.1.0"
  url "https://github.com/Softorize/claudebrain/releases/download/v#{version}/claudebrain-#{version}.tgz"
  sha256 "9b6cc5891c4499d4806a4259674e3011634e51db16bdd3fbee8b57def7b2a745"

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
