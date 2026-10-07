# db2scli

CLI for IBM Db2 Serverless REST API.

Binaries are built automatically from the private source repository and published here as GitHub Releases.

---

## Installation

### macOS & Linux — Homebrew

```bash
brew tap Spoorthid1729/db2scli
brew install db2scli
```

Upgrade later with:
```bash
brew upgrade db2scli
```

---

### Linux & macOS — curl installer

```bash
curl -fsSL https://raw.githubusercontent.com/Spoorthid1729/db2scli/main/install.sh | sh
```

By default the binary is installed to `/usr/local/bin/db2scli`. Override with:
```bash
INSTALL_DIR=$HOME/.local/bin curl -fsSL https://raw.githubusercontent.com/Spoorthid1729/db2scli/main/install.sh | sh
```

---

### Windows — Scoop

```powershell
scoop bucket add db2scli https://github.com/Spoorthid1729/db2scli
scoop install db2scli
```

Upgrade later with:
```powershell
scoop update db2scli
```

---

### Manual download

Download the binary for your platform directly from [Releases](https://github.com/Spoorthid1729/db2scli/releases):

| Platform      | File |
|---------------|------|
| macOS (Apple Silicon) | `db2scli_vX.Y.Z_darwin_arm64.tar.gz` |
| macOS (Intel) | `db2scli_vX.Y.Z_darwin_amd64.tar.gz` |
| Linux (x86-64)| `db2scli_vX.Y.Z_linux_amd64.tar.gz`  |
| Linux (ARM64) | `db2scli_vX.Y.Z_linux_arm64.tar.gz`  |
| Windows       | `db2scli_vX.Y.Z_windows_amd64.zip`   |

Extract and move the binary to any directory on your `PATH`.

---

## Quick start

```bash
# Set your server and credentials once
db2scli config init --server https://your-db2-api.example.com --api-key YOUR_KEY

# List projects
db2scli projects list-serverless-projects --region us-south --x-organization-id org-123

# Get help
db2scli --help
db2scli projects --help
```

---

## Verify checksums

Every release includes a `checksums.txt` (SHA-256). Verify your download:

```bash
# macOS / Linux
sha256sum -c checksums.txt --ignore-missing
```

---

## License

Apache 2.0
