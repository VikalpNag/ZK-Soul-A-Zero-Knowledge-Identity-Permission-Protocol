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

    //Reconstruct the leaf hash(could be Poseidon hash of age)
    signal computedLeaf;
    computedLeaf<==leafHash;

    component rootCalc=MerkleTreeInclusionProof(depth);
    for(var i=0;i<depth;i++){
        rootCalc.pathElements[i]<==pathElements[i];
        rootCalc.pathIndices[i]<==pathIndices[i];
    }
    rootCalc.leaf<==computedLeaf;
    rootCalc.root===merkleRoot;
}

component main=AgeVerifier(3);