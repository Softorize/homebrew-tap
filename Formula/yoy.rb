class Yoy < Formula
  desc "Yahoo Mail CLI — read, send, search, and manage Yahoo Mail from your terminal"
  homepage "https://github.com/Softorize/yoy"
  url "https://github.com/Softorize/yoy/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "39fc54ac0418b045a83c2e09f07ea687b1b1679833b15199c4baf8245e27db66"
  license "MIT"
  head "https://github.com/Softorize/yoy.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/Softorize/yoy/internal/version.Version=#{version}
      -X github.com/Softorize/yoy/internal/version.Commit=homebrew
    ].join(" ")
    system "go", "build", *std_go_args(ldflags: ldflags)

    generate_completions_from_executable(bin/"yoy", "completion")
  end

  test do
    assert_match "yoy #{version}", shell_output("#{bin}/yoy version")
  end
end
