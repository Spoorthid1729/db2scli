class Db2scli < Formula
  desc "CLI for IBM Db2 Serverless REST API"
  homepage "https://github.com/Spoorthid1729/db2scli"
  license "Apache-2.0"

  # These four variables are patched by CI on every release (see release-cli.yml)
  version "0.0.0"
  darwin_amd64_sha256 = "PLACEHOLDER"
  darwin_arm64_sha256 = "PLACEHOLDER"
  linux_amd64_sha256  = "PLACEHOLDER"
  linux_arm64_sha256  = "PLACEHOLDER"

  on_macos do
    on_arm do
      url "https://github.com/Spoorthid1729/db2scli/releases/download/v#{version}/db2scli_v#{version}_darwin_arm64.tar.gz"
      sha256 darwin_arm64_sha256
    end
    on_intel do
      url "https://github.com/Spoorthid1729/db2scli/releases/download/v#{version}/db2scli_v#{version}_darwin_amd64.tar.gz"
      sha256 darwin_amd64_sha256
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Spoorthid1729/db2scli/releases/download/v#{version}/db2scli_v#{version}_linux_arm64.tar.gz"
      sha256 linux_arm64_sha256
    end
    on_intel do
      url "https://github.com/Spoorthid1729/db2scli/releases/download/v#{version}/db2scli_v#{version}_linux_amd64.tar.gz"
      sha256 linux_amd64_sha256
    end
  end

  def install
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    os   = OS.mac? ? "darwin" : "linux"
    bin.install "db2scli_#{os}_#{arch}" => "db2scli"
  end

  test do
    assert_match "db2scli", shell_output("#{bin}/db2scli --help")
  end
end
