// Version du compilateur Solidity
pragma solidity ^0.8.9;

// Importation des contrats ZombieAttack, ERC721 et de la bibliothèque SafeMath
import "./zombieattack.sol";
import "./erc721.sol";
import "./safemath.sol";

// Contrat ZombieOwnership qui hérite de ZombieAttack et ERC721
contract ZombieOwnership is ZombieAttack, ERC721 {

  // Utilisation de la bibliothèque SafeMath pour les calculs sécurisés
  using SafeMath for uint256;

  // Mapping pour stocker les approbations des zombies
  mapping (uint => address) zombieApprovals;

  // Retourne le nombre de zombies possédés par une adresse donnée
  function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownerZombieCount[_owner];
  }

  // Retourne l'adresse du propriétaire d'un zombie donné
  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return zombieToOwner[_tokenId];
  }

  // Fonction interne pour effectuer le transfert de propriété d'un zombie
  function _transfer(address _from, address _to, uint256 _tokenId) private {
    // Mise à jour du nombre de zombies pour le nouveau propriétaire
    ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
    // Mise à jour du nombre de zombies pour l'ancien propriétaire
    ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].sub(1);
    // Mise à jour du propriétaire du zombie
    zombieToOwner[_tokenId] = _to;
    // Émission de l'événement de transfert
    Transfer(_from, _to, _tokenId);
  }

  // Fonction publique pour transférer la propriété d'un zombie à une autre adresse
  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

  // Fonction publique pour approuver le transfert d'un zombie à une adresse spécifique
  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    // Enregistrement de l'approbation du transfert
    zombieApprovals[_tokenId] = _to;
    // Émission de l'événement d'approbation
    Approval(msg.sender, _to, _tokenId);
  }

  // Fonction publique pour accepter la propriété d'un zombie approuvé
  function takeOwnership(uint256 _tokenId) public {
    // Vérification que l'adresse du preneur correspond à l'approbation
    require(zombieApprovals[_tokenId] == msg.sender);
    // Récupération de l'adresse actuelle du propriétaire
    address owner = ownerOf(_tokenId);
    // Transfert de la propriété du zombie
    _transfer(owner, msg.sender, _tokenId);
  }
}
