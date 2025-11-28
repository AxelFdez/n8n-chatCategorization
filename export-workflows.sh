#!/bin/bash

# Script pour exporter les workflows n8n depuis la base de données SQLite
# Les workflows sont sauvegardés dans le dossier workflows/ au format JSON

set -e

DB_PATH="./n8n_data/database.sqlite"
WORKFLOWS_DIR="./workflows"

# Vérifier que la base de données existe
if [ ! -f "$DB_PATH" ]; then
    echo "❌ Erreur: La base de données n'existe pas à $DB_PATH"
    echo "Assurez-vous que n8n a été démarré au moins une fois."
    exit 1
fi

# Créer le dossier workflows s'il n'existe pas
mkdir -p "$WORKFLOWS_DIR"

# Nettoyer les anciens exports
rm -f "$WORKFLOWS_DIR"/*.json

# Compter le nombre de workflows
WORKFLOW_COUNT=$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM workflow_entity;")
echo "📦 Export de $WORKFLOW_COUNT workflow(s)..."

# Exporter chaque workflow
sqlite3 "$DB_PATH" "SELECT id, name, nodes, connections, settings FROM workflow_entity;" | while IFS='|' read -r id name nodes connections settings; do
    if [ -n "$id" ] && [ -n "$name" ]; then
        # Nettoyer le nom pour créer un nom de fichier valide
        safe_name=$(echo "$name" | tr ' ' '_' | tr -cd '[:alnum:]_-' | head -c 50)
        filename="${safe_name}_${id}.json"
        filepath="$WORKFLOWS_DIR/$filename"

        echo "  → Export: $name"

        # Créer un JSON valide pour le workflow
        cat > "$filepath" << EOF
{
  "id": "$id",
  "name": "$name",
  "nodes": $nodes,
  "connections": $connections,
  "settings": $settings
}
EOF

        # Formater le JSON avec jq si disponible
        if command -v jq &> /dev/null; then
            jq '.' "$filepath" > "${filepath}.tmp" && mv "${filepath}.tmp" "$filepath"
        fi
    fi
done

echo ""
echo "✅ Export terminé! Les workflows sont dans $WORKFLOWS_DIR/"
echo ""
echo "⚠️  Note: Les credentials ne sont PAS inclus dans l'export pour des raisons de sécurité."
echo "   Vous devrez les reconfigurer manuellement après l'import des workflows."
