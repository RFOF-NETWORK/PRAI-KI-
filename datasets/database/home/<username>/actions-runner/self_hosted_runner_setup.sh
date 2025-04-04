#!/bin/bash

# 1. Ordner für den Runner erstellen
echo "Erstelle den Ordner für den Runner..."
mkdir actions-runner && cd actions-runner

# 2. Runner-Paket herunterladen
echo "Lade den Runner herunter..."
curl -o actions-runner-linux-x64-2.323.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.323.0/actions-runner-linux-x64-2.323.0.tar.gz

# Optional: Hash validieren
echo "Überprüfe die Integrität des Pakets..."
echo "0dbc9bf5a58620fc52cb6cc0448abcca964a8d74b5f39773b7afcad9ab691e19  actions-runner-linux-x64-2.323.0.tar.gz" | shasum -a 256 -c

# 3. Installer extrahieren
echo "Extrahiere die Runner-Dateien..."
tar xzf ./actions-runner-linux-x64-2.323.0.tar.gz

# 4. Runner konfigurieren
echo "Konfiguriere den Runner..."
./config.sh --url https://github.com/QCH-L-C/PRAI-KI- --token BKELILTUHECPG6IVMISHOXDH54DT2

# 5. Runner starten
echo "Starte den Runner..."
./run.sh

echo "Self-Hosted Runner Setup abgeschlossen!"




#!/bin/bash

# Überprüft Root-Berechtigungen
if [ "$EUID" -ne 0 ]; then
  echo "Bitte führe dieses Skript mit 'sudo' aus."
  exit
fi

echo "Starte Einrichtung des Self-Hosted Runners..."

# Variablen
RUNNER_VERSION="2.323.0"
RUNNER_FOLDER="/home/$(whoami)/actions-runner"
REPO_URL="https://github.com/QCH-L-C/PRAI-KI-"
TOKEN="YOUR_GITHUB_TOKEN"

# Erstelle Runner-Verzeichnis
mkdir -p $RUNNER_FOLDER && cd $RUNNER_FOLDER

# Lade Runner-Paket herunter
curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Optional: Überprüfe Integrität des Pakets
echo "Überprüfe Integrität des heruntergeladenen Runner-Pakets..."
echo "0dbc9bf5a58620fc52cb6cc0448abcca964a8d74b5f39773b7afcad9ab691e19  actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" | shasum -a 256 -c

# Entpacke Runner-Dateien
tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Konfiguriere Runner
./config.sh --url $REPO_URL --token $TOKEN

# Starte Runner-Service
sudo ./svc.sh install
sudo ./svc.sh start

echo "Self-Hosted Runner erfolgreich eingerichtet!"

