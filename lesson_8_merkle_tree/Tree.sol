// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Merkle tree
    /*
                 (Hroot)
                    ^
      (H1-2-3-4)          H5-6-7-8
         ^                 ^
     H1-2  H3-4       H5-6   (H7-8)
      ^     ^          ^       ^
    H1 H2 H3 H4    (H5) (H6) H7 H8
    T1 T2 T3 T4    (T5) T6 T7 T8   // количество транзакций всегда 2 ** n   // Чтобы проверить на подлинность T5 нужно посчитать H5 H6  H7-8  H1-2-3-4 и на основе него получить корневой хеш Hroot


          H            ?
          ^            ^    
      H      H      H    x  // не возможно построить хеш из-за недостатка транзакций
      ^      ^      ^
    H1 H2  H3 H4  H5 H6  // количество транзакций не равно 2 ** n
    */

contract Tree {
/*
//   H1-2      H3-4
     4         5
// H1   H2   H3   H4
   0    1    2    3
// TX1  TX2  TX3  TX4
*/
    bytes32[] public hashes;
    string[4] transactions = [
        "TX1: Sherlock -> John",
        "TX2: John -> Sherlock",
        "TX3: John -> Mary",
        "TX4: Mary -> Sherlock"];

        constructor() {
            for(uint i = 0; i < transactions.length; i++) {
                hashes.push(makeHash(transactions[i]));
            }

            uint count = transactions.length; // 4 - на 1 итерации т.к. количество = 4  // 1 - на 2 итерации т.к. количество = 4/2 = 2  , а 2-1 = 1
            // на третьей итерации count = 1,  1 - 1 = 0, цикл не выполнится 0 !< 0
            uint offset = 0;

            while(count > 0) {
                for(uint i = 0; i < count - 1; i += 2) {
                    hashes.push(keccak256(
                        abi.encodePacked(
                            hashes[offset + i], hashes[offset + i + 1])));
                            /*
                                    0       0          0            1
                                    0   +   2  (2)     2   +  0  +  1  (3)
                                    4       0          4            1  (5)
                            */
                }
                offset += count; // на 2 итерации offset = 4 т.к. count = 4   // 0/4/6/7
                count = count / 2; // на 2 итерации count = 4/2 = 2
            }
        }

    function verify(string memory transaction, uint index, bytes32 root, bytes32[] memory proof) public pure returns(bool) {
        //"TX3: John -> Mary"
        // 2
        // i=6 (ROOT) hashes  0x09b224c621fb4ff030cb745cf19402c0a25ffb707b359ace8780aeeacb0ac988
        // i=3 hashes  0x69a40d72d1258df801a7ae1e36dd586717a112334f8d9ca4664a339168874ef5
        // i=4 hashes  0x58e9a664a4c1e26694e09437cad198aebc6cd3c881ed49daea6e83e79b77fead

        /*
             Hroot
               6
          H1-2   H3-4
           4      5
        H1  H2  H3  H4      // если индекс четный, то для построения общего хеша мы берем элемент который находится справа 
        0   1   2   3
        TX1 TX2 TX3 TX4     // если индекс нечетный, то для тогда берем элемент слева
        */

        bytes32 hash = makeHash(transaction);
        for(uint i = 0; i < proof.length; i++) {
            bytes32 element = proof[i];
            if(index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, element));
            } else {
                hash = keccak256(abi.encodePacked(element, hash));
            }
            index = index / 2;
        }
        return hash == root;
    }

    function encode(string memory input) public pure returns(bytes memory) {
        return abi.encodePacked(input);
    }

    function makeHash(string memory input) public pure returns(bytes32) {
        return keccak256(encode(input));  // makeHash может принимать только строку, а encodePacked отдает байты
    } 
}
