// Version du compilateur Solidity
pragma solidity ^0.8.9;

// Importation du contrat Ownable
import "./ownable.sol";
// Importation de la bibliothèque SafeMath
import "./safemath.sol";

// Contrat ZombieFactory qui hérite de Ownable
contract ZombieFactory is Ownable {
  // Utilisation de la bibliothèque SafeMath pour les calculs sécurisés
  using SafeMath for uint256;

  // Événement émis lors de la création d'un nouveau zombie
  event NewZombie(uint zombieId, string name, uint dna);

  // Nombre de chiffres dans l'ADN d'un zombie
  uint dnaDigits = 16;
  // Modulo utilisé pour limiter la taille de l'ADN
  uint dnaModulus = 10 ** dnaDigits;
  // Temps de récupération (cooldown) d'un zombie
  uint cooldownTime = 1 days;

  // Structure pour représenter un zombie
  struct Zombie {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
  }

  // Tableau de zombies
  Zombie[] public zombies;

  // Mapping pour associer un zombie à son propriétaire
  mapping (uint => address) public zombieToOwner;
  // Mapping pour compter le nombre de zombies d'un propriétaire
  mapping (address => uint) ownerZombieCount;

  // Fonction interne pour créer un zombie
  function _createZombie(string _name, uint _dna) internal {
    // Ajout du nouveau zombie au tableau et récupération de son ID
    uint id = zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0)) - 1;
    // Association du zombie à son propriétaire
    zombieToOwner[id] = msg.sender;
    // Incrémentation du nombre de zombies du propriétaire
    ownerZombieCount[msg.sender]++;
    // Émission de l'événement NewZombie
    emit NewZombie(id, _name, _dna);
  }

  // Fonction privée pour générer un ADN aléatoire à partir d'une chaîne de caractères
  function _generateRandomDna(string _str) private view returns (uint) {
    // Génération d'un nombre aléatoire en utilisant keccak256 avec la chaîne de caractères en entrée
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    // Retourne le nombre aléatoire modulo le modulo d'ADN pour limiter la taille
    return rand % dnaModulus;
  }

  // Fonction publique pour créer un zombie aléatoire
  function createRandomZombie(string _name) public {
    // Vérification que le propriétaire n'a pas déjà de zombie
    require(ownerZombieCount[msg.sender] == 0);
    // Génération d'un ADN aléatoire à partir du nom
    uint randDna = _generateRandomDna(_name);
    // Réduction de l'ADN à des groupes de 2 chiffres
    randDna = randDna - randDna % 100;
    // Création du zombie avec l'ADN généré
    _createZombie(_name, randDna);
  }
}
