#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

plaintext="1010110011101000101010010110001111000011001100101010101010110011"
extra="1100110011001100"
input="$plaintext$extra"
key="0001001100110100010101110111100110011011101111001101111111110001"

ciphertext=$(printf "1\n%s\n%s\n" "$input" "$key" | ./des)
if [ $(( ${#ciphertext} % 64 )) -ne 0 ]; then
  echo "Multi-block ciphertext length is not multiple of 64"
  exit 1
fi

recovered=$(printf "2\n%s\n%s\n" "$ciphertext" "$key" | ./des)
expected="$input$(printf '%0.s0' $(seq 1 $((64 - ${#extra}))))"

if [ "$recovered" != "$expected" ]; then
  echo "Multi-block padding test failed"
  echo "input:     $input"
  echo "recovered: $recovered"
  echo "expected:  $expected"
  exit 1
fi

echo "Multi-block padding test passed"
