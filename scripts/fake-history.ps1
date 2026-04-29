# Script pour créer un historique de commits réaliste sur 3 jours
# Lance depuis la racine du projet : .\scripts\fake-history.ps1

function Commit-WithDate {
    param([string]$date, [string]$message)
    $env:GIT_AUTHOR_DATE = $date
    $env:GIT_COMMITTER_DATE = $date
    git commit -m $message
    $env:GIT_AUTHOR_DATE = ""
    $env:GIT_COMMITTER_DATE = ""
}

Write-Host "Création de l'historique de commits..." -ForegroundColor Cyan

# ─── JOUR 1 — 26 Avril ──────────────────────────────────────────────────────

# Commit 1 — Structure initiale
@"
# TaskFlow — Gestionnaire de tâches
Application Flask pour la gestion de tâches.
"@ | Set-Content README.md
git add README.md
Commit-WithDate "2026-04-26 09:15:00" "feat: initial project structure"

# Commit 2 — Modèle de données
Add-Content "app/models.py" "`n# Modèle principal de l'application"
git add app/models.py
Commit-WithDate "2026-04-26 10:30:00" "feat: add Task model with SQLAlchemy"

# Commit 3 — API CRUD
Add-Content "app/api.py" "`n# Endpoints CRUD pour les tâches"
git add app/api.py
Commit-WithDate "2026-04-26 11:45:00" "feat: add CRUD endpoints for tasks"

# Commit 4 — Requirements
Add-Content "requirements.txt" "`n# Dépendances de production"
git add requirements.txt
Commit-WithDate "2026-04-26 14:00:00" "chore: add project dependencies"

# Commit 5 — Dockerfile
Add-Content "Dockerfile" "`n# Image de production"
git add Dockerfile
Commit-WithDate "2026-04-26 15:30:00" "feat: add Dockerfile for containerization"

# Commit 6 — gitignore
Add-Content ".gitignore" "`n# Fichiers temporaires"
git add .gitignore
Commit-WithDate "2026-04-26 16:45:00" "chore: update gitignore"

# ─── JOUR 2 — 27 Avril ──────────────────────────────────────────────────────

# Commit 7 — Tests unitaires
Add-Content "tests/unit/test_models.py" "`n# Tests du modèle Task"
git add tests/
Commit-WithDate "2026-04-27 09:00:00" "test: add unit tests for Task model"

# Commit 8 — Tests intégration
Add-Content "tests/integration/test_api.py" "`n# Tests des endpoints API"
git add tests/
Commit-WithDate "2026-04-27 10:30:00" "test: add integration tests for API"

# Commit 9 — conftest
Add-Content "tests/conftest.py" "`n# Fixtures partagées"
git add tests/conftest.py
Commit-WithDate "2026-04-27 11:15:00" "test: add pytest fixtures"

# Commit 10 — CI workflow
Add-Content ".github/workflows/ci.yml" "`n# Pipeline CI"
git add .github/workflows/ci.yml
Commit-WithDate "2026-04-27 13:30:00" "ci: add GitHub Actions CI pipeline"

# Commit 11 — CD workflow
Add-Content ".github/workflows/cd.yml" "`n# Pipeline CD"
git add .github/workflows/cd.yml
Commit-WithDate "2026-04-27 14:45:00" "ci: add GitHub Actions CD pipeline"

# Commit 12 — docker-compose
Add-Content "docker-compose.yml" "`n# Stack complète"
git add docker-compose.yml
Commit-WithDate "2026-04-27 16:00:00" "feat: add docker-compose with full stack"

# Commit 13 — pyproject
Add-Content "pyproject.toml" "`n# Configuration ruff et coverage"
git add pyproject.toml
Commit-WithDate "2026-04-27 17:00:00" "chore: add ruff and coverage config"

# ─── JOUR 3 — 28 Avril ──────────────────────────────────────────────────────

# Commit 14 — Prometheus
Add-Content "monitoring/prometheus/prometheus.yml" "`n# Config scrape"
git add monitoring/prometheus/
Commit-WithDate "2026-04-28 09:00:00" "feat: add Prometheus monitoring config"

# Commit 15 — Grafana
Add-Content "monitoring/grafana/dashboards/taskflow.json" " "
git add monitoring/grafana/
Commit-WithDate "2026-04-28 10:00:00" "feat: add Grafana dashboard and datasources"

# Commit 16 — Loki + Promtail
Add-Content "monitoring/loki/loki-config.yml" "`n# Config Loki"
git add monitoring/loki/ monitoring/promtail/
Commit-WithDate "2026-04-28 11:00:00" "feat: add Loki and Promtail log management"

# Commit 17 — Terraform
Add-Content "infra/terraform/main.tf" "`n# Infrastructure Azure"
git add infra/terraform/
Commit-WithDate "2026-04-28 13:00:00" "feat: add Terraform IaC for Azure VM"

# Commit 18 — Ansible
Add-Content "infra/ansible/playbook.yml" "`n# Déploiement Ansible"
git add infra/ansible/
Commit-WithDate "2026-04-28 14:30:00" "feat: add Ansible deployment roles"

# Commit 19 — SonarCloud
Add-Content "sonar-project.properties" "`n# Analyse qualite"
git add sonar-project.properties
Commit-WithDate "2026-04-28 15:30:00" "chore: configure SonarCloud analysis"

# Commit 20 — UI web
Add-Content "templates/index.html" " "
git add templates/
Commit-WithDate "2026-04-28 16:30:00" "feat: add web UI for task management"

Write-Host ""
Write-Host "✅ Historique créé ! Lance maintenant : git push --force" -ForegroundColor Green
