/**
 * @title Ownable
 * @dev Le contrat Ownable a une adresse de propriétaire et fournit des fonctions de contrôle
 * d'autorisation de base, ce qui simplifie la mise en œuvre des "permissions d'utilisateur".
 */
contract Ownable {
  address public owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev Le constructeur Ownable définit l'adresse d'origine (`owner`) du contrat comme étant l'expéditeur
   * du compte.
   */
  constructor() public {
    owner = msg.sender;
  }


  /**
   * @dev Lève une exception si l'appel n'est pas effectué par le propriétaire.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Permet au propriétaire actuel de transférer le contrôle du contrat à un nouveau propriétaire.
   * @param newOwner L'adresse à laquelle transférer la propriété.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
}
