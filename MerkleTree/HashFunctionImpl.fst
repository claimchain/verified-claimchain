module HashFunctionImpl

open SHA2_256

let hashFunc = sha2_256 hash input len 
let lengthHash = hash_hashsize_256 
