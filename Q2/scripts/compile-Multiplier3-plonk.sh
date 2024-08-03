#!/bin/bash

# [assignment] create your own bash script to compile Multiplier3.circom using PLONK below

cd contracts/circuits

mkdir Multiplier3_plonk

# if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
#     echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
# else
#     echo 'Downloading powersOfTau28_hez_final_10.ptau'
#     wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
# fi
snarkjs powersoftau new bn128 10 pot0_0000.ptau
echo "Compiling Multiplier3.circom with Plonk..."

# compile circuit

circom Multiplier3.circom --r1cs --wasm --sym -o Multiplier3_plonk
snarkjs r1cs info Multiplier3_plonk/Multiplier3.r1cs

# Start a new zkey and make a contribution


snarkjs powersoftau contribute pot0_0000.ptau pot0_0001.ptau --name="First contribution" -v
snarkjs powersoftau prepare phase2 pot0_0001.ptau pot0_final.ptau
snarkjs plonk setup Multiplier3_plonk/Multiplier3.r1cs pot0_final.ptau Multiplier3_plonk/circuit_final.zkey

# snarkjs plonk setup Multiplier3_plonk/Multiplier3.r1cs powersOfTau28_hez_final_10.ptau Multiplier3_plonk/circuit_0000.zkey
# snarkjs zkey contribute Multiplier3_plonk/circuit_0000.zkey Multiplier3_plonk/circuit_final.zkey --name="My name" -v -e="My random texty text"
snarkjs zkey export verificationkey Multiplier3_plonk/circuit_final.zkey Multiplier3_plonk/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier Multiplier3_plonk/circuit_final.zkey ../Multiplier3Verifier.sol