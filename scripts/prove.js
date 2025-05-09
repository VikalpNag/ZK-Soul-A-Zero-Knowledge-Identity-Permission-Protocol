const snarkjs = require("snarkjs");
const fs = require("fs");

const generateProof = async () => {
    const input = {
        age: "23",
        leafHash: "123456...",
        merkleRoot: "0x...",
        pathElements: [...],
        pathIndices: [...]
    };

    const { proof, publicSignals } = await snarkjs.groth16.fullProve(
        input,
        "build/ageVerifier.wasm",
        "build/ageVerifier_final.zkey"
    );

    fs.writeFileSync("proof.json", JSON.stringify(proof, null, 2));
    fs.writeFileSync("public.json", JSON.stringify(publicSignals, null, 2));

};

generateProof();
