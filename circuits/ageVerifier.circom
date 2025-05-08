pragma circom 2.0.0;

include "circomlib/merkle.circom";// If using merkle tree constraints
include "circom/poseidon.circom";

template AgeVerifier(depth){
    signal input age;
    signal input merkleRoot;
    signal input pathElements[depth];
    signal input pathIndices;

    signal private  input leafHash;
    
}