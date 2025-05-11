pragma circom 2.0.0;

include "circomlib/merkle.circom"; 
include "circomlib/poseidon.circom";

template AgeVerifier(depth) {
    signal input age;
    signal input merkleRoot;
    signal input pathElements[depth];
    signal input pathIndices[depth];

    signal private input leafHash;

    component isOver18 = GreaterEqThan(8);
    isOver18.in[0] <== age;
    isOver18.in[1] <== 18;
    isOver18.out === 1;


    signal computedLeaf;
    computedLeaf <== leafHash;

    component rootCalc = MerkleTreeInclusionProof(depth);
    for (var i = 0; i < depth; i++) {
        rootCalc.pathElements[i] <== pathElements[i];
        rootCalc.pathIndices[i] <== pathIndices[i];
    }
    rootCalc.leaf <== computedLeaf;

    rootCalc.root === merkleRoot;
}

component main = AgeVerifier(3);
