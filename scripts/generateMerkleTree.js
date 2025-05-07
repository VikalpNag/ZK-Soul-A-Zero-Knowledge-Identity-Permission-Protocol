const { MerkleTree } = require("merkletreejs");
const keccak256 = require("keccak256");

const credentials = ["age:23", "citizen:yes", "country:India"];

const leaves = credentials.map((c) => keccak256(c));
const tree = new MerkleTree(leaves, keccak256, { sortPairs: true });
const root = tree.getHexRoot();

const proof = tree.getHexProof(leaves[0]); //for example : proof for age:23

console.log("Merkle Root : ", root);
console.log("Proof of first credential:", proof);
