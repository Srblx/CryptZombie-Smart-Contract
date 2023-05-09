// Contrat ERC721 pour les tokens non fongibles
contract ERC721 {
  // Événement émis lors d'un transfert de token
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);

  // Événement émis lors d'une approbation de transfert de token
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

  // Retourne le solde de tokens d'un propriétaire
  function balanceOf(address _owner) public view returns (uint256 _balance);

  // Retourne l'adresse du propriétaire d'un token donné
  function ownerOf(uint256 _tokenId) public view returns (address _owner);

  // Transfère un token à une adresse spécifique
  function transfer(address _to, uint256 _tokenId) public;

  // Approuve une adresse pour transférer un token donné
  function approve(address _to, uint256 _tokenId) public;

  // Effectue le transfert d'un token approuvé à l'adresse du preneur
  function takeOwnership(uint256 _tokenId) public;
}
