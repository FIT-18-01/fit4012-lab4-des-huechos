#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

plaintext="0001001000110100010101100111100010011010101111001101111011110001"
key="0001001100110100010101110111100110011011101111001101111111110001"

ciphertext=$(printf "1\n%s\n%s\n" "$plaintext" "$key" | ./des)
# flip the first bit of ciphertext
first=${ciphertext:0:1}
if [ "$first" = "0" ]; then
  tampered="1${ciphertext:1}"
else
  tampered="0${ciphertext:1}"
fi

recovered=$(printf "2\n%s\n%s\n" "$tampered" "$key" | ./des)

if [ "$recovered" = "$plaintext" ]; then
  echo "Tamper negative test failed: tampered ciphertext recovered original plaintext"
  exit 1
fi

echo "Tamper negative test passed"
