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

## Volumes

- `n8n_data` : Données persistantes de n8n
- `./workflows` : Dossier local pour stocker les workflows

## Configuration

Les variables d'environnement peuvent être modifiées dans le fichier `docker-compose.yml` :
- `N8N_BASIC_AUTH_USER` : Nom d'utilisateur
- `N8N_BASIC_AUTH_PASSWORD` : Mot de passe
- `GENERIC_TIMEZONE` : Fuseau horaire
