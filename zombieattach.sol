// Version du compilateur Solidity
pragma solidity ^0.8.9;

// Importation du contrat ZombieHelper
import "./zombiehelper.sol";

// Contrat ZombieAttack qui hérite de ZombieHelper
contract ZombieAttack is ZombieHelper {
  // Variable pour générer des nombres aléatoires
  uint randNonce = 0;
  // Probabilité de victoire d'une attaque (en pourcentage)
  uint attackVictoryProbability = 70;

  // Fonction interne pour générer un nombre aléatoire modulo un certain _modulus
  function randMod(uint _modulus) internal returns (uint) {
    randNonce++;
    // Génération d'un nombre aléatoire en utilisant keccak256 avec des valeurs actuelles
    return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
  }

  // Fonction pour attaquer un autre zombie
  function attack(uint _zombieId, uint _targetId) external onlyOwnerOf(_zombieId) {
    // Récupération du zombie attaquant
    Zombie storage myZombie = zombies[_zombieId];
    // Récupération du zombie cible
    Zombie storage enemyZombie = zombies[_targetId];
    // Génération d'un nombre aléatoire pour déterminer le résultat de l'attaque
    uint rand = randMod(100);
    // Vérification de la probabilité de victoire
    if (rand <= attackVictoryProbability) {
      // Le zombie attaquant a remporté le combat
      myZombie.winCount++;
      myZombie.level++;
      enemyZombie.lossCount++;
      // Nourrir et multiplier le zombie attaquant avec le code ADN de l'ennemi
      feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    } else {
      // Le zombie attaquant a perdu le combat
      myZombie.lossCount++;
      enemyZombie.winCount++;
      // Déclencher le délai de récupération pour le zombie attaquant
      _triggerCooldown(myZombie);
    }
  }
}
