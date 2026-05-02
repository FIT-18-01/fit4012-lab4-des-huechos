#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

plaintext="1010110011101000101010010110001111000011001100101010101010110011"
key="0001001100110100010101110111100110011011101111001101111111110001"

ciphertext=$(printf "1\n%s\n%s\n" "$plaintext" "$key" | ./des)
recovered=$(printf "2\n%s\n%s\n" "$ciphertext" "$key" | ./des)

if [ "$recovered" != "$plaintext" ]; then
  echo "DES round-trip test failed"
  echo "plaintext:  $plaintext"
  echo "ciphertext: $ciphertext"
  echo "recovered:  $recovered"
  exit 1
fi

echo "DES round-trip test passed"
