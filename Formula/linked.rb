class Linked < Formula
  desc "Fast LinkedIn CLI — read, post, message, and network from your terminal"
  homepage "https://github.com/Softorize/linked"
  license "MIT"
  version "0.1.1"

  on_macos do
    on_arm do
      url "https://github.com/Softorize/linked/releases/download/v#{version}/linked-macos-arm64.tar.gz"
      sha256 "f54452d9c59a0be95fe83e23d560fc75c6b8c2b830bb2977544609edde2fd715"
    end

    on_intel do
      url "https://github.com/Softorize/linked/releases/download/v#{version}/linked-macos-arm64.tar.gz"
      sha256 "4e81e67bb8e1f126f84f7f462c84da12295a78d0563aa53d29696b9c5c9b92e5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Softorize/linked/releases/download/v#{version}/linked-linux-x64.tar.gz"
      sha256 "40bd4fde34dd01578eb49f5298254047e8d26017c6b7075877342ba87a5634e0"
    end
  end

  depends_on "node@20"

  def install
    libexec.install Dir["*"]
    # Create a wrapper script that uses the bundled Node.js
    (bin/"linked").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node@20"].opt_bin}/node" "#{libexec}/dist/cli.js" "$@"
    EOS
    chmod 0755, bin/"linked"
  end

  test do
    assert_match "linked", shell_output("#{bin}/linked --version")
  end
end
