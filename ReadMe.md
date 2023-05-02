Génération automatique de code et fichier de paramètres de génération de code Nethereum
Le plus simple est de générer automatiquement du code pour votre api, pour cela vous devez créer un fichier nommé « nethereum-gen.settings » à la racine de votre projet, avec le contenu suivant.

Ce fichier peut également être généré automatiquement pour vous si vous appuyez sur F1 et tapez 'Solidity Create 'nethereum-gen.settings'


{
    "projectName": "Solidity.Samples",
    "namespace": "Solidity.Samples",
    "lang":0,
    "autoCodeGen":true,
    "projectPath": "../SoliditySamples"
}
« lang » indique dans quelle langue générer le code, 0 = CSharp, 1 = Vb.Net et 3 = FSharp
Les paramètres "projectName" et "namespace" seront également utilisés pour la génération manuelle du code.

Utilisez le "projectPath" pour définir le chemin relatif de votre projet .Net, cela permet de travailler en mode "solution" afin que vous puissiez travailler à la fois dans Visual Studio Code et Visual Studio (Fat) avec votre projet .Net, ou deux fenêtres de vscode.




Contrat pour générer des zombies
Utilisation de la blockchain Ethereum pour stocker les données des zombies
Création de nouveaux zombies en "mangeant" des victimes
Gestion d'argent en Solidity
Contrats avec propriétaire, aux coûts en gas (gaz), à l'optimisation de code et à la sécurité en Solidity
Fonction combat de zombies
Utilisation de fonctions payable pour accepter de l'argent des joueurs
Création de crypto-collectibles basés sur des zombies
Jetons (tokens) et au standard ERC721
Web3.js, une bibliothèque JavaScript pour interagir avec la blockchain Ethereum
