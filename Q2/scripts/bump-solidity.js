const fs = require("fs");
const solidityRegex = /pragma solidity \^\d+\.\d+\.\d+/;

const grothVerifierRegex = /contract Groth16Verifier/;

let content = fs.readFileSync("./contracts/HelloWorldVerifier.sol", {
  encoding: "utf-8",
});
let bumped = content.replace(solidityRegex, "pragma solidity ^0.8.0");
bumped = bumped.replace(grothVerifierRegex, "contract HelloWorldVerifier");

fs.writeFileSync("./contracts/HelloWorldVerifier.sol", bumped);

// Bump Groth Multiplier

let contentGroth = fs.readFileSync(
  "./contracts/Multiplier3Verifier_groth.sol",
  { encoding: "utf-8" }
);
let bumpedGroth = contentGroth.replace(solidityRegex, "pragma solidity ^0.8.0");
bumpedGroth = bumpedGroth.replace(
  grothVerifierRegex,
  "contract Multiplier3VerifierGroth"
);

fs.writeFileSync("./contracts/Multiplier3Verifier_groth.sol", bumpedGroth);

// Bump Plonk Multiplier

const plonkVerifierRegex = /contract PlonkVerifier/;

let contentPlonk = fs.readFileSync(
  "./contracts/Multiplier3Verifier_plonk.sol",
  { encoding: "utf-8" }
);
let bumpedPlonk = contentPlonk.replace(solidityRegex, "pragma solidity ^0.8.0");
bumpedPlonk = bumpedPlonk.replace(
  plonkVerifierRegex,
  "contract Multiplier3VerifierPlonk"
);

fs.writeFileSync("./contracts/Multiplier3Verifier_plonk.sol", bumpedPlonk);
