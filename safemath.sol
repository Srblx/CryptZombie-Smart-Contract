// Version du compilateur Solidity
pragma solidity ^0.8.9;

/**
 * @title SafeMath
 * @dev Opérations mathématiques avec des vérifications de sécurité qui déclenchent une erreur en cas d'échec
 */
library SafeMath {

  /**
  * @dev Multiplie deux nombres, déclenche une erreur en cas de dépassement.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Division entière de deux nombres, tronquant le quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity déclenche automatiquement une erreur en cas de division par 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // Il n'y a aucun cas où cela ne serait pas vrai
    return c;
  }

  /**
  * @dev Soustrait deux nombres, déclenche une erreur en cas de dépassement (c'est-à-dire si le sous-trahend est supérieur au minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Ajoute deux nombres, déclenche une erreur en cas de dépassement.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}
