// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ManualToken {
    mapping(address => uint256) private s_balances;

    // function name() public pure returns (string memory) {
    //     return 'Manual Token';
    // }

    string public name = "Manual Token"; // this pretty much also works with our name function

    function totalSupply() public pure returns (uint256) {
        return 100 ether; // 1000000000000000000
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public {
        uint256 previousBalances = balanceOf(msg.sender) + balanceOf(_to); // balance of user sending the coins plus balance of user receiving the coins (at current state)
        s_balances[msg.sender] -= _amount; // or s_balance[msg.sender] = s_balances[msg.sender] - amount;
        s_balances[_to] += _amount; // or s_balance[_to] = s_balances[_to] + amount; Remember, s_balances[_to] is mapping us to the actual users balance, while balanceOf funciton is purely returning the current balance of the user.
        require(balanceOf(msg.sender) + balanceOf(_to) == previousBalances); // because this would be the same amount as the previous balance, we can assert this to be true.
    }
}
