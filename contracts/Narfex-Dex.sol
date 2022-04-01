/**
 *Submitted for verification at BscScan.com on 2022-02-24
*/

// File: @openzeppelin/contracts/utils/Counters.sol


// OpenZeppelin Contracts v4.4.1 (utils/Counters.sol)

pragma solidity ^0.8.0;

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 */
library Counters {
    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1;
        }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol


// OpenZeppelin Contracts v4.4.1 (access/Ownable.sol)

pragma solidity ^0.8.0;


/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: contracts/MyWallet.sol


pragma solidity >=0.4.22 <0.9.0;




contract MyWallet is Ownable{

  struct Token{
      bytes32 ticker;
      address tokenAddress;
  }
   bytes32[] public tickerList;
   mapping(bytes32 => Token) public tokenMapping;
   mapping(address => mapping(bytes32 => uint)) public balances;
   
   modifier tokenExist(bytes32 _ticker){
      require(tokenMapping[_ticker].tokenAddress != address(0),"Wallet: token doesn't exist");
      _;
   }

   function addToken(bytes32 _ticker,address _tickerAddress) external onlyOwner{
      require(tokenMapping[_ticker].tokenAddress == address(0),"Wallet: Token already exist");
      tokenMapping[_ticker] = Token(_ticker,_tickerAddress);
      tickerList.push(_ticker);
   } 
   
   function deposit(uint _amount,bytes32 _ticker) external tokenExist(_ticker){
       IERC20 instance = IERC20(tokenMapping[_ticker].tokenAddress);
       require(instance.balanceOf(_msgSender()) >= _amount,"Deposit balance in your token contract");
       balances[_msgSender()][_ticker] += _amount;
       instance.transferFrom(_msgSender(), address(this), _amount);
   
   }

   function depositETH() public payable{
      balances[_msgSender()]["ETH"] += msg.value;
    }
   
   function withdraw(uint _amount,bytes32 _ticker)external tokenExist(_ticker){
        require(balances[_msgSender()][_ticker] >= _amount,"Wallet: insufficient balance");
        balances[_msgSender()][_ticker] -= _amount;
        IERC20(tokenMapping[_ticker].tokenAddress).transfer(_msgSender(), _amount);
   }
   
}
// File: contracts/Dex.sol



pragma solidity >=0.4.22 <0.9.0;




contract Dex is MyWallet{

    using Counters for Counters.Counter; 
    
    enum Side{
        BUY,
        SELL
    }

   struct Order{
       uint id;
       address trader;
       Side side;
       bytes32 ticker;
       uint amount;
       uint price;
       bool filled;
   }

    struct marketOrder{
       uint id;
       address trader;
       Side side;
       bytes32 ticker;
       uint amount;
       bool filled;
   }
   
   mapping(bytes32 => mapping(uint => Order[]))public orderBook;
   mapping(bytes32 => mapping(uint => marketOrder[]))public marketOrderBook;
   Counters.Counter private _counterIds;
   Counters.Counter private _marketIds;

   function getBalance(bytes32 ticker) public view returns (uint256) {
       return balances[msg.sender][ticker];
   }
  
   function getOrderBook(bytes32 _ticker,Side side) public view returns(Order[] memory){
       return orderBook[_ticker][uint(side)];
   }

   function getMarketOrderBook(bytes32 _ticker,Side side) public view returns(marketOrder[] memory){
       return marketOrderBook[_ticker][uint(side)];
   }
 
   function createLimitOrder(Side side,bytes32 ticker,uint amount, uint price) public{
        if(side == Side.BUY){
            require(getBalance("ETH") >= amount * price,'Cost exdeeds the ETH balance');
        }
        else if(side == Side.SELL){
            require(getBalance(ticker) >= amount,'Insufficient tokens to sell');
        }

        uint256 newCounterId = _counterIds.current();
        Order[] storage orders = orderBook[ticker][uint(side)];
        orders.push(Order(newCounterId,msg.sender,side,ticker,amount,price, false));
         
        uint j =  orders.length > 0 ? orders.length-1 : 0;
         if(side == Side.BUY){
            for( ; j > 0 ; j--){
                 if(orders[j].price > orders[j-1].price){
                    Order memory temp = orders[j];
                    orders[j] = orders[j-1];
                    orders[j-1] = temp;
                }
                else{
                    break;
                }
            }
            if(marketOrderBook[ticker][1].length > 0){
              settleOrder(orders, marketOrderBook[ticker][1], ticker, Side.SELL,0);
            }
            
         }
         else if(side == Side.SELL){
            for(; j > 0 ; j--){
                 if(orders[j].price < orders[j-1].price){
                    Order memory temp = orders[j];
                    orders[j] = orders[j-1];
                    orders[j-1] = temp;
                }
                else{
                    break;
                }
            }
            if(marketOrderBook[ticker][0].length > 0){
              settleOrder(orders, marketOrderBook[ticker][0], ticker, Side.BUY,0);
            }
            
         }
          _counterIds.increment();
    }
   
   function createMarketOrder(Side side, bytes32 ticker, uint amount) public {
    
        if(Side.SELL == side){
            require(amount <= getBalance(ticker),"Insufficent tokens to sell");
        
            uint newCounterId = _marketIds.current();
            marketOrder[] storage marketOrders = marketOrderBook[ticker][1];
            Order[] storage orders = orderBook[ticker][0];
            if(orders.length == 0){
              marketOrders.push(marketOrder(newCounterId,msg.sender,side,ticker,amount, false));
              _marketIds.increment();
            }
            else{
              settleOrder(orders, marketOrders, ticker, side,amount);
            }
            
        }
        else if(Side.BUY == side){
            uint newCounterId = _marketIds.current();
            marketOrder[] storage marketOrders = marketOrderBook[ticker][0];
            Order[] storage orders = orderBook[ticker][1]; 
            if(orders.length == 0){
               marketOrders.push(marketOrder(newCounterId,msg.sender,side,ticker,amount, false));
               _marketIds.increment();
            }
            else{
              settleOrder(orderBook[ticker][1], marketOrderBook[ticker][0], ticker, side,amount);
            }
        }
         
   }

   function settleOrder(Order[] storage orders, marketOrder[] storage marketOrders, bytes32 ticker, Side side,uint amount) private {
            
       while(orders.length > 0 && (marketOrders.length > 0 || amount > 0)){
           address trader;
           uint expectedAmount = 0;
           if(marketOrders.length > 0){
               trader = marketOrders[0].trader;
               amount = marketOrders[0].amount;
           }
           else{
               trader = msg.sender;
           }
           if (side == Side.BUY) {
                require(balances[trader]["ETH"] > orders[0].price * orders[0].amount,"Insufficient ETH");
            }
           
            if (amount >= orders[0].amount) {
                amount -= orders[0].amount;
                orders[0].filled = true;
                expectedAmount = orders[0].amount;
                orders[0].amount = 0;
            }
         
            else if(amount < orders[0].amount){
                orders[0].amount -= amount;
                expectedAmount = amount;
                amount = 0;
            }
            
            if (side == Side.BUY) {
                settleTrade(orders[0], expectedAmount, orders[0].trader, trader, ticker);
            }
            else {
                settleTrade(orders[0], expectedAmount, trader, orders[0].trader, ticker);
            }
            
            if(marketOrders.length > 0){
                marketOrders[0].amount = amount;
                if(amount == 0){
                  marketOrders[0].filled = true;
                }
            }
            deleteOrders(orders, marketOrders);
        }
        if(marketOrders.length == 0 && amount > 0 && orders.length == 0 ){
           marketOrderBook[ticker][uint256(side)].push(marketOrder(_marketIds.current(),msg.sender,side,ticker,amount, false));
           _marketIds.increment();
        }
    }

   function deleteOrders(Order[] storage orders, marketOrder[] storage marketOrders) private {

    if (orders[0].filled) {
            
        for (uint j = 0; j < orders.length-1; j++){
            orders[j] = orders[j+1];
        }    
        orders.pop();
    }

    if(marketOrders.length > 0 && marketOrders[0].filled){
       for (uint j = 0; j < marketOrders.length-1; j++){
            marketOrders[j] = marketOrders[j+1];
        }    
            marketOrders.pop();
    }
   }
   
   function settleTrade(Order memory temp, uint amt, address seller, address buyer,bytes32 _ticker) private{
        uint cost = temp.price * amt;
        balances[seller]["ETH"] += cost; 
        balances[seller][_ticker] -= amt; 
        balances[buyer]["ETH"] -= cost; 
        balances[buyer][_ticker] += amt; 
   }
  
}