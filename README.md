# 🚀 Solidarity - Plateforme de Crowdfunding Décentralisée  

## 📝 Description  
**CrowdChain** est un système de **crowdfunding décentralisé** permettant de créer des levées de fonds avec **récompenses NFT et tokens** pour les contributeurs.

---

## 🎯 Fonctionnalités Clés  

- 💫 **Création de campagnes de crowdfunding**  
- 💰 **Système de contribution en ETH**  
- 🎨 **Si l'objectif est atteint, chaque contributeur reçoit un NFT non-transférable (Soulbound Token)). Le NFT représente le pourcentage exact de leur contribution**  
- 🪙 **Distribution automatique de tokens. Le montant de tokens reçu est proportionnel au pourcentage de contribution**  
- ⏰ **Gestion du temps de campagne**  
- 💸 **Si l'objectif n'est pas atteint à la fin de la période, les fonds sont automatiquement remboursés**  

---

## 🛠️ Technologies  

- **Solidity** `^0.8.20`  
- **Forge & Foundry**  
- **OpenZeppelin**  
- **TypeScript (CLI)**  

---

## 🏗️ Structure du Projet
```bash
├── 📂 src/
│   ├── 
├── 📂 test/
     └── 
```

---

## 📋 Tâches Principales  

### 🔮 Smart Contracts Core  
- [x] Structure de base du contrat de crowdfunding  
- [x] Fonction de création de campagne
- [x] Système de contribution en ETH  
- [x] Logique de calcul des pourcentages  
- [x] Système de remboursement automatique  
- [x] Émissions d'événements pour chaque action importante  
- [x] Tests des fonctions core  

### 🎨 Système de NFT (SoulBound Token)  
- [x] Implémentation du contrat NFT non-transférable  
- [x] Structure des métadonnées (contribution, pourcentage, projet)  
- [x] Fonction de mint pour les contributeurs  
- [x] Blocage des transferts après mint  
- [x] Tests du système NFT  

### 🪙 Gestion des Tokens  
- [x] Contrat de création dynamique de tokens **ERC20 ou ERC1155**  
- [x] Système de distribution des tokens aux détenteurs de NFT  
- [x] Calcul des allocations basé sur les pourcentages  
- [x] Tests des fonctions de token  

### 🧪 Tests & Sécurité  
- [x] Tests d'intégration entre les contrats  
- [x] **Fuzzing tests** pour les entrées utilisateur  
- [x] Tests des cas limites (**0 ETH, max supply**)  
- [x] Tests des scénarios de remboursement  
- [x] Vérification des **overflows** dans les calculs  
- [x] Scripts de déploiement  

---

## 📚 Documentation  

- [ ] **Documentation technique des contrats (NatSpec)**  
- [ ] **Guide d'utilisation du CLI**  
- [ ] **Diagrammes de flux des processus**  
- [ ] **Documentation de déploiement**  

---

## 🌟 Bonus - Interface Web  

> **Interface web**  

---

## 🧪 Tests  

```sh
# Lancer tous les tests
forge test

# Tests avec traces détaillées
forge test -vv

# Tester une fonction spécifique
forge test --match-test testCreateCampaign -vv
```
## 📚 Commandes Utiles Forge
```bash
# Compiler le projet
forge build

# Déployer sur un testnet
forge script script/Deploy.s.sol:Deploy --rpc-url $RPC_URL --broadcast

# Générer un rapport de couverture des tests
forge coverage

# Rapport de consommation de gas
forge test --gas-report
```

---

## ✅ Checklist avant PR  

- [x] **Tous les tests passent** (`forge test`)  
- [x] **Coverage > 90%** (`forge coverage`)  
- [x] **Gas optimisé** (`forge snapshot`)  
- [x] **Code documenté** (**NatSpec**)  
- [x] **Émission d'événements pour actions importantes**  

---

## 🚨 Points d'Attention  

- 🔹 **Gestion précise des calculs de pourcentage**  
- 🔹 **Vérification des overflows**  
- 🔹 **Sécurisation des transferts ETH**  
- 🔹 **Tests des cas limites**  
- 🔹 **Documentation complète**  

---

## 🤝 Contribution  

✅ **PR bienvenues !** Assurez-vous de suivre ces étapes :  

1. **Fork** le projet  
2. **Créer une branche** (`feature/amazingFeature`)  
3. **Commit** (`git commit -m '✨ Add amazing feature'`)  
4. **Push** (`git push origin feature/amazingFeature`)  
5. **Ouvrir une PR**  

### 📌 Règles de Contribution  

- Utiliser **des commits clairs et explicites**.  
- Ajouter **des tests unitaires** pour toute nouvelle fonctionnalité.  
- Vérifier que le code est **compatible avec Solidity `^0.8.20`**.  
- Suivre les standards **OpenZeppelin** et **ERC** pertinents.  
- Documenter les nouvelles fonctionnalités en **NatSpec**.
  
---

### 📄 License
MIT
