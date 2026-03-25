#!/bin/bash
set -e

echo "🔨 Building CraftNexus Escrow Contract..."

# Check if stellar CLI is installed
STELLAR_BIN=""
if command -v stellar &> /dev/null; then
    STELLAR_BIN="stellar"
elif [ -x "./.local-bin/stellar-cli-bin" ]; then
    STELLAR_BIN="./.local-bin/stellar-cli-bin"
else
    echo "❌ Stellar CLI not found. Please run: ./scripts/install-stellar-cli.sh"
    exit 1
fi

# Build the contract
$STELLAR_BIN contract build

# Check if build was successful
if [ -f "target/wasm32v1-none/release/craft_nexus_contract.wasm" ]; then
    echo "✅ Contract built successfully!"
    echo "📦 WASM file: target/wasm32v1-none/release/craft_nexus_contract.wasm"
    
    # Show file size
    SIZE=$(du -h target/wasm32v1-none/release/craft_nexus_contract.wasm | cut -f1)
    echo "📊 Size: $SIZE"
else
    echo "❌ Build failed. WASM file not found."
    exit 1
fi
