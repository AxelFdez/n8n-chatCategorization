# n8n Chat Categorization

Projet de catégorisation de chat avec n8n.

## Prérequis

- Docker et Docker Compose installés

## Démarrage

1. Lancer n8n avec Docker Compose :
```bash
docker-compose up -d
```

2. Accéder à l'interface n8n :
```
http://localhost:5678
```

3. Identifiants par défaut :
   - Username: `admin`
   - Password: `admin`

## Arrêter n8n

```bash
docker-compose down
```

## Export des workflows

Pour versionner vos workflows sans exposer les credentials sensibles :

```bash
npm run export
```

Ce script exporte tous vos workflows depuis la base de données n8n vers le dossier `workflows/` au format JSON. Les workflows peuvent ensuite être versionnés avec Git.

**Important** : Les credentials (API keys, tokens, passwords) ne sont PAS inclus dans l'export pour des raisons de sécurité. Vous devrez les reconfigurer manuellement après l'import.

## Volumes

- `n8n_data/` : Données persistantes de n8n (non versionné pour sécurité)
- `workflows/` : Workflows exportés au format JSON (versionnés)

## Configuration

Les variables d'environnement peuvent être modifiées dans le fichier `docker-compose.yml` :
- `N8N_BASIC_AUTH_USER` : Nom d'utilisateur
- `N8N_BASIC_AUTH_PASSWORD` : Mot de passe
- `GENERIC_TIMEZONE` : Fuseau horaire
