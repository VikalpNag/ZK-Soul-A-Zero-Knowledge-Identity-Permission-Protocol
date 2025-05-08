pragma circom 2.0.0;

include "circomlib/merkle.circom";// If using merkle tree constraints
include "circom/poseidon.circom";

template AgeVerifier(depth){
    signal input age;
    signal input merkleRoot;
    signal input pathElements[depth];
    signal input pathIndices;

    signal private  input leafHash;

    //Constraints : age must be >= 18
    component isOver18=GreaterEqThan(18);
    isOver18.in[0]<==age;
    isOver18.in[1]<==18;
    isOver.out===1;
}