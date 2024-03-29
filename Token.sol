 pragma solidity ^0.8.2;

contract Token {
   mapping (address => uint) public balances;
   mapping (address => mapping(address => uint)) public allowance;
   uint public totalSupply = 10000 * 10 ** 18;  /* количество токенов */
   string public name = "My token";  /* название токена */
   string public symbol = "MRS";     /* символ для биржи */
   uint public decimals = 18;        /* количество после запятой */
 
   event Transfer(address indexed from, address indexed to, uint value);
   event Approval(address indexed owner, address indexed spender, uint value);
   
   constructor(){
       balances[msg.sender] = totalSupply;
   }
   
   function balancesOf(address owner) public view returns(uint){
       return balances[owner];
   }
   
   function transfer(address to, uint value) public returns(bool){
       require(balancesOf(msg.sender) >= value, 'balance too low');
       balances[to] += value;
       balances[msg.sender] -= value;
       emit Transfer(msg.sender, to, value);
       return true;
   }
   
   function transferFrom(address from, address to, uint value) public returns(bool){
       require(balancesOf(from) >= value,'balance too low');
       require(allowance[from][msg.sender] >= value, 'allowance too low');
       balances[to] += value;
       balances[from] -= value;
       emit Transfer(from, to, value);
       return true;
   }
   
   function approve(address spender, uint value) public returns(bool){
       allowance[msg.sender][spender] = value;
       emit Approval(msg.sender, spender, value);
       return true;
   }
}
