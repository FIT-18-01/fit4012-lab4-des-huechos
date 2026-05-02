#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

plaintext="0001001000110100010101100111100010011010101111001101111011110001"
key="0001001100110100010101110111100110011011101111001101111111110001"
expected="1001000010001010011111100010110001110000110010100011011011000011"

output=$(printf "1\n%s\n%s\n" "$plaintext" "$key" | ./des)

if [ "$output" != "$expected" ]; then
  echo "DES sample test failed"
  echo "expected: $expected"
  echo "got:      $output"
  exit 1
fi

echo "DES sample test passed"
