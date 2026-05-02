#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

plaintext="0001001000110100010101100111100010011010101111001101111011110001"
key="0001001100110100010101110111100110011011101111001101111111110001"
wrong_key="0001001100110100010101110111100110011011101111001101111111110010"

ciphertext=$(printf "1\n%s\n%s\n" "$plaintext" "$key" | ./des)
recovered=$(printf "2\n%s\n%s\n" "$ciphertext" "$wrong_key" | ./des)

if [ "$recovered" = "$plaintext" ]; then
  echo "Wrong key negative test failed: decrypt with wrong key matched plaintext"
  exit 1
fi

echo "Wrong key negative test passed"
