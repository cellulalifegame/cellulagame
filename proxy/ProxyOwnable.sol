import "@openzeppelin/contracts/utils/Context.sol";

/// @dev The proxy contract uses the owner permission management library, and the function name is distinguished from the proxy contract

abstract contract ProxyOwnable is Context {

    event ProxyOwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**

    * @dev Initializes the contract setting the deployer as the initial owner.

    */

    constructor() {

        _transferProxyOwnership(_msgSender());

    }

    /**

    * @dev Returns the address of the current owner.

    */

    function proxyOwner() public view returns (address) {

        return _loadProxyOwner();

    }

    /**

    * @dev Throws if called by any account other than the owner.

    */

    modifier onlyProxyOwner() {

        require(proxyOwner() == _msgSender(), "ProxyOwnable: caller is not the owner");

        _;

    }

    /**

    * @dev Leaves the contract without owner. It will not be possible to call

    * `onlyOwner` functions anymore. Can only be called by the current owner.

    *

    * NOTE: Renouncing ownership will leave the contract without an owner,

    * thereby removing any functionality that is only available to the owner.

    */

    function renounceProxyOwnership() public virtual onlyProxyOwner {

        _transferProxyOwnership(address(0));

    }

    /**

    * @dev Transfers ownership of the contract to a new account (`newOwner`).

    * Can only be called by the current owner.

    */

    function transferProxyOwnership(address newOwner) public virtual onlyProxyOwner {

        require(newOwner != address(0), "Ownable: new owner is the zero address");



        _transferProxyOwnership(newOwner);

    }

    /**

    * @dev Transfers ownership of the contract to a new account (`newOwner`).

    * Internal function without access restriction.

    */

    function _transferProxyOwnership(address newOwner) internal virtual {

        address oldOwner = _loadProxyOwner();

        _storeProxyOwner(newOwner);

        emit ProxyOwnershipTransferred(oldOwner, newOwner);

    }

/// @dev store owner

    function _storeProxyOwner(address owner) internal virtual;

    /// @dev read owner

    function _loadProxyOwner() internal view virtual returns (address);

}