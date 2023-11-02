// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

contract Level_5 {
    function solution(int256 a, int256 b) external pure returns (int256) {
        assembly {
            let sum := add(a, b)
            
            // check overflow by making sure sum is greater than a or b
            let overflow := or(gt(sum, a), gt(sum, b))
            
            // Check if the sum is odd
            if iszero(and(sum, 1)) {
                // If sum is even, divide it by 2 without rounding up
                let average := div(sum, 2)
                // Store the result in the output slot
                sstore(0, average)
            } else {
                // If sum is odd, add 1 to round up and then divide by 2
                sum := add(sum, 1)
                let average := div(sum, 2)
                // Store the result in the output slot
                sstore(0, average)
            }
            
            // evaluate overflow to be not true, or else error
            require(iszero(overflow), "Addition overflow");
            
            // Return the result
            return(sload(0))
        }
    }
}