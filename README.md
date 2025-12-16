# 🧪 Projet Test et Validation - Formulaire d'Inscription

[![Robot Framework](https://img.shields.io/badge/Robot%20Framework-000000?style=for-the-badge&logo=robot-framework&logoColor=white)](https://robotframework.org/)
[![Selenium](https://img.shields.io/badge/Selenium-43B02A?style=for-the-badge&logo=selenium&logoColor=white)](https://www.selenium.dev/)
[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![LaTeX](https://img.shields.io/badge/LaTeX-008080?style=for-the-badge&logo=latex&logoColor=white)](https://www.latex-project.org/)

> Suite de tests automatisés complète pour valider un formulaire d'inscription web avec Robot Framework et Selenium.

## 📋 Table des Matières

- [À Propos](#-à-propos)
- [Fonctionnalités](#-fonctionnalités)
- [Prérequis](#-prérequis)
- [Installation](#-installation)
- [Utilisation](#-utilisation)
- [Architecture des Tests](#-architecture-des-tests)
- [Résultats](#-résultats)
- [Documentation](#-documentation)
- [Contribution](#-contribution)
- [Licence](#-licence)

## 🎯 À Propos

Ce projet implémente une suite complète de **14 tests automatisés** pour valider le formulaire d'inscription du site [Demo Web Shop (Tricentis)](https://demowebshop.tricentis.com/register). Les tests couvrent les aspects fonctionnels, sécuritaires, et de performance.

### Application Testée

- **Site web :** Demo Web Shop - Tricentis
- **URL :** https://demowebshop.tricentis.com/register
- **Type :** Formulaire d'inscription e-commerce

## ✨ Fonctionnalités

### 🔍 Tests de Validation Fonctionnelle (5 tests)
- ✅ Vérification des champs obligatoires
- ✅ Validation du format email
- ✅ Correspondance des mots de passe
- ✅ Cas nominal d'inscription réussie
- ✅ Test des limites (mot de passe court)

### 🛡️ Tests de Sécurité (4 tests)
- 🔒 Protection contre les injections XSS
- 🔒 Protection contre les injections SQL
- 🔒 Protection contre les injections HTML
- 🔒 Test de robustesse (chaînes très longues)

### 🖥️ Tests de Validation Serveur (3 tests)
- 🌐 Détection des emails en doublon
- 🌐 Validation côté client (attributs HTML)
- 🌐 Persistance des données (inscription + login)

### 👤 Tests d'Expérience Utilisateur (1 test)
- 💬 Clarté des messages d'erreur

### ⚡ Tests de Performance (1 test)
- ⏱️ Temps de réponse du serveur

## 📊 Résultats Clés

| Métrique | Valeur |
|----------|--------|
| **Score de Qualité Global** | 83/100 |
| **Tests Exécutés** | 14 |
| **Taux de Réussite** | 100% |
| **Catégories Couvertes** | 5 |
| **Vulnérabilités Détectées** | 2 (moyennes) |

## 🔧 Prérequis

### Logiciels Requis

- **Python** >= 3.7
- **Google Chrome** (dernière version)
- **ChromeDriver** (compatible avec votre version de Chrome)
- **Robot Framework** >= 4.0
- **SeleniumLibrary** >= 5.0

### Pour la Documentation LaTeX

- **LaTeX** (TeXLive, MiKTeX, ou MacTeX)
- Packages : `tikz`, `pgfplots`, `tcolorbox`, `listings`, etc.

## 🚀 Installation

### 1. Cloner le Projet

```bash
git clone https://github.com/votre-username/test-validation-formulaire.git
cd test-validation-formulaire
```

### 2. Créer un Environnement Virtuel (Recommandé)

```bash
# Créer l'environnement virtuel
python -m venv venv

# Activer l'environnement
# Sur Windows
venv\Scripts\activate
# Sur Linux/Mac
source venv/bin/activate
```

### 3. Installer les Dépendances

```bash
pip install -r requirements.txt
```

**Contenu de `requirements.txt` :**
```
robotframework>=6.0
robotframework-seleniumlibrary>=6.0
selenium>=4.0
```

### 4. Installer ChromeDriver

#### Option A : Installation Automatique
```bash
pip install webdriver-manager
```

#### Option B : Installation Manuelle
1. Télécharger depuis [ChromeDriver Downloads](https://chromedriver.chromium.org/downloads)
2. Placer le binaire dans votre PATH système

### 5. Vérifier l'Installation

```bash
robot --version
python -c "import selenium; print(selenium.__version__)"
```

## 📖 Utilisation

### Exécuter Tous les Tests

```bash
robot tests/formulaire_inscription.robot
```

### Exécuter un Test Spécifique

```bash
robot -t "Test 01 : Vérifier les Champs Obligatoires" tests/formulaire_inscription.robot
```

### Exécuter par Catégorie

```bash
# Tests de sécurité uniquement
robot -i securite tests/formulaire_inscription.robot

# Tests de validation uniquement
robot -i validation tests/formulaire_inscription.robot
```

### Générer des Rapports Détaillés

```bash
robot --outputdir results --loglevel DEBUG tests/formulaire_inscription.robot
```

Les rapports générés se trouvent dans le dossier `results/` :
- `report.html` - Rapport de synthèse
- `log.html` - Log détaillé avec captures d'écran
- `output.xml` - Données brutes

### Options Utiles

```bash
# Exécution en mode headless (sans interface graphique)
robot -v BROWSER:headlesschrome tests/formulaire_inscription.robot

# Exécution avec Firefox
robot -v BROWSER:Firefox tests/formulaire_inscription.robot

# Ralentir l'exécution pour observer
robot -v SELENIUM_SPEED:1s tests/formulaire_inscription.robot
```

## 🏗️ Architecture des Tests

```
test-validation-formulaire/
│
├── tests/
│   └── formulaire_inscription.robot    # Suite de tests principale
│
├── docs/
│   ├── rapport_latex.tex               # Documentation LaTeX
│   └── rapport_latex.pdf               # PDF compilé
│
├── results/                             # Rapports générés (gitignore)
│   ├── log.html
│   ├── report.html
│   └── output.xml
│
├── screenshots/                         # Captures d'écran (gitignore)
│
├── requirements.txt                     # Dépendances Python
├── .gitignore
└── README.md
```

## 📝 Structure d'un Test

Chaque test Robot Framework suit cette structure :

```robot
Test XX : Nom Descriptif du Test
    [Documentation]    Description détaillée du test
    Maximize Browser Window
    Set Selenium Speed    0.5s
    
    # Actions
    Click Element    ${LOC_BOUTON}
    Input Text       ${LOC_EMAIL}    test@example.com
    
    # Vérifications
    Page Should Contain    Message attendu
    
    Log    Succès : Critère validé
```

## 🎨 Variables Configurables

Dans la section `*** Variables ***` du fichier de test :

| Variable | Valeur par Défaut | Description |
|----------|-------------------|-------------|
| `${URL}` | https://demowebshop... | URL de l'application |
| `${BROWSER}` | Chrome | Navigateur utilisé |
| `${PRENOM}` | Jean | Prénom de test |
| `${NOM}` | Dupont | Nom de test |
| `${EMAIL}` | jean.dupont.test010@test.com | Email de test |
| `${PASSWORD}` | Secret123! | Mot de passe test |

⚠️ **Important :** Modifier l'email entre chaque exécution pour éviter les doublons.

## 📈 Catégories de Tests

### 1️⃣ Validation Fonctionnelle

Tests vérifiant que le formulaire fonctionne correctement selon les spécifications.

**Critères ISO 25010 :**
- Complétude
- Exactitude
- Cohérence

### 2️⃣ Tests de Sécurité

Tests vérifiant la résistance aux attaques courantes.

**Menaces testées :**
- XSS (Cross-Site Scripting)
- SQL Injection
- HTML Injection
- Buffer Overflow

### 3️⃣ Validation Serveur

Tests vérifiant que le serveur valide correctement les données.

**Aspects couverts :**
- Détection des doublons
- Persistance des données
- Validation des règles métier

### 4️⃣ Expérience Utilisateur

Tests vérifiant la qualité de l'interface utilisateur.

**Critères évalués :**
- Clarté des messages
- Feedback approprié
- Guidage de l'utilisateur

### 5️⃣ Performance

Tests mesurant les performances du système.

**Métriques :**
- Temps de réponse serveur
- Charge système

## 🔍 Tests Détaillés

<details>
<summary><strong>Test 01 : Vérifier les Champs Obligatoires</strong></summary>

**Objectif :** Vérifier que le formulaire empêche la soumission si des champs obligatoires sont vides.

**Critère :** Complétude

**Scénario :**
1. Accéder au formulaire
2. Cliquer sur "Register" sans remplir les champs
3. Vérifier les messages d'erreur

**Messages attendus :**
- "First name is required."
- "Last name is required."
- "Email is required."
- "Password is required."

</details>

<details>
<summary><strong>Test 06 : Sécurité - Injection XSS</strong></summary>

**Objectif :** Tester la protection contre l'injection de code JavaScript malveillant.

**Payload :**
```html
<script>alert('Hacked')</script>
```

**Résultat attendu :**
- Aucune alerte JavaScript ne doit s'afficher
- Le serveur doit bloquer ou échapper le contenu
- Message d'erreur approprié

**Résultat observé :** ✅ Bloqué (erreur 500)

</details>

<details>
<summary><strong>Test 10 : Email Déjà Existant</strong></summary>

**Objectif :** Vérifier que le serveur détecte les emails en doublon.

**Scénario :**
1. Inscription avec un email unique
2. Déconnexion
3. Tentative d'inscription avec le même email
4. Vérification du message d'erreur

**Message attendu :** "The specified email already exists"

</details>

## 📚 Documentation

### Générer le Rapport PDF

```bash
cd docs
pdflatex rapport_latex.tex
pdflatex rapport_latex.tex  # Deux fois pour les références
```

Le rapport PDF contient :
- ✅ Analyse détaillée de chaque test
- ✅ Graphiques et visualisations
- ✅ Recommandations priorisées
- ✅ Score de qualité global
- ✅ Annexes techniques

## 🐛 Problèmes Connus et Solutions

### Erreur : "ChromeDriver not found"

**Solution :**
```bash
pip install webdriver-manager
```

### Erreur : "Element not found"

**Cause :** La page n'est pas complètement chargée

**Solution :** Augmenter le délai Selenium :
```robot
Set Selenium Speed    1s
```

### Email déjà existant

**Cause :** Le test a déjà été exécuté avec cet email

**Solution :** Modifier la variable `${EMAIL}` dans le fichier :
```robot
${EMAIL}    jean.dupont.test011@test.com  # Incrémenter le numéro
```

### Tests échouent aléatoirement

**Cause :** Problèmes de timing réseau

**Solution :** Ajouter des attentes explicites :
```robot
Wait Until Page Contains Element    ${LOC_BOUTON}    timeout=10s
```

## 🔐 Bonnes Pratiques de Sécurité

⚠️ **Ne jamais** commettre dans Git :
- Identifiants réels
- Mots de passe de production
- Clés API
- Données personnelles

✅ **Recommandations :**
- Utiliser des données de test fictives
- Isoler les tests dans un environnement dédié
- Nettoyer les données après chaque exécution

## 🤝 Contribution

Les contributions sont les bienvenues ! Voici comment participer :

### 1. Fork le Projet

```bash
git clone https://github.com/votre-username/test-validation-formulaire.git
```

### 2. Créer une Branche

```bash
git checkout -b feature/nouveau-test
```

### 3. Commit vos Changements

```bash
git commit -m "Ajout d'un test pour la validation du téléphone"
```

### 4. Push vers la Branche

```bash
git push origin feature/nouveau-test
```

### 5. Ouvrir une Pull Request

### Standards de Code

- Suivre la convention de nommage Robot Framework
- Commenter les tests complexes
- Ajouter une documentation pour chaque nouveau test
- Tester localement avant de soumettre

## 📋 TODO List

- [ ] Ajouter des tests de compatibilité multi-navigateurs
- [ ] Implémenter des tests de charge
- [ ] Ajouter des tests d'accessibilité (WCAG)
- [ ] Intégrer dans un pipeline CI/CD
- [ ] Ajouter des tests API REST
- [ ] Créer des tests de régression visuels
- [ ] Ajouter support pour l'exécution parallèle

## 📊 Statistiques du Projet

![Tests](https://img.shields.io/badge/Tests-14-green)
![Couverture](https://img.shields.io/badge/Couverture-83%25-yellow)
![Sécurité](https://img.shields.io/badge/Sécurité-Haute-success)
![Status](https://img.shields.io/badge/Status-Actif-brightgreen)

## 🏆 Résultats et Métriques

### Score de Qualité par Catégorie

| Catégorie | Score | Status |
|-----------|-------|--------|
| Fonctionnalité | 95% | ✅ Excellent |
| Utilisabilité | 85% | ✅ Bon |
| Fiabilité | 85% | ✅ Bon |
| Sécurité | 90% | ✅ Excellent |
| Maintenabilité | 80% | ✅ Bon |
| Performance | 70% | ⚠️ Acceptable |

### Vulnérabilités Identifiées

| Priorité | Type | Description | Status |
|----------|------|-------------|--------|
| 🔴 Haute | Robustesse | Chaînes très longues causent erreur 500 | À corriger |
| 🟡 Moyenne | Gestion d'erreurs | Messages d'erreur 500 non explicites | À améliorer |

## 📞 Contact et Support

- **Auteur :** [Votre Nom]
- **Email :** votre.email@example.com
- **LinkedIn :** [Votre Profil](https://linkedin.com/in/votre-profil)
- **Issues :** [GitHub Issues](https://github.com/votre-username/test-validation-formulaire/issues)

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

---

<div align="center">

**⭐ Si ce projet vous a été utile, n'oubliez pas de lui donner une étoile ! ⭐**

Fait avec ❤️ et [Robot Framework](https://robotframework.org/)

</div>
