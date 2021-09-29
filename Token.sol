pragma solidity ^0.8.2;

contract Token {
    mapping(address => uint256) public balanaces;
    mapping(address => mapping(address => uint256)) public allowance;
    uint256 public totoaSupply = 1000 * 10**18;
    string name = "Fi Token";
    string symbol = "FKN";
    uint256 public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );

    constructor() {
        balanaces[msg.sender] = totoaSupply;
    }

    function balanceOf(address owner) public view returns (uint256) {
        return balanaces[owner];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(balanceOf(msg.sender) >= amount, "balance too low");
        balanaces[to] += amount;
        balanaces[msg.sender] -= amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        require(balanceOf(from) >= amount, "balance too low");
        require(allowance[from][msg.sender] >= amount, "allowance too low");

        balanaces[from] += amount;
        balanaces[to] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
}
