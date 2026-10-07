#!/bin/sh
# install.sh — db2scli installer for Linux and macOS
# Usage: curl -fsSL https://raw.githubusercontent.com/Spoorthid1729/db2scli/main/install.sh | sh
set -e

REPO="Spoorthid1729/db2scli"
BINARY="db2scli"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"

# Resolve latest version from GitHub API
VERSION=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
          | grep '"tag_name"' | cut -d'"' -f4)

if [ -z "$VERSION" ]; then
  echo "Error: could not determine latest version. Check your internet connection or set VERSION manually."
  exit 1
fi

# Detect OS
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
case "$OS" in
  linux|darwin) ;;
  *) echo "Unsupported OS: $OS"; exit 1 ;;
esac

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
  x86_64)        ARCH="amd64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

ARCHIVE="${BINARY}_${VERSION}_${OS}_${ARCH}.tar.gz"
URL="https://github.com/$REPO/releases/download/${VERSION}/${ARCHIVE}"

echo "Installing $BINARY $VERSION ($OS/$ARCH)..."
echo "Downloading: $URL"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "$URL" -o "$TMP/$ARCHIVE"
tar -xzf "$TMP/$ARCHIVE" -C "$TMP"

# The binary inside the archive is named db2scli_<os>_<arch>
EXTRACTED="$TMP/${BINARY}_${OS}_${ARCH}"

if [ ! -f "$EXTRACTED" ]; then
  echo "Error: expected binary '$EXTRACTED' not found in archive."
  exit 1
fi

# Install — use sudo only if needed
if [ -w "$INSTALL_DIR" ]; then
  install -m 755 "$EXTRACTED" "$INSTALL_DIR/$BINARY"
else
  echo "Note: $INSTALL_DIR is not writable, trying with sudo..."
  sudo install -m 755 "$EXTRACTED" "$INSTALL_DIR/$BINARY"
fi

echo ""
echo "✓ $BINARY $VERSION installed to $INSTALL_DIR/$BINARY"
echo "  Run '$BINARY --help' to get started."
