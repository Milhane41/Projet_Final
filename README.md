# TaskFlow — Projet Usine Logicielle

API REST de gestion de tâches construite comme support pour une usine logicielle complète couvrant les chapitres 01 à 11.

## Démarrage rapide

```bash
# 1. Environnement Python
python -m venv venv
source venv/bin/activate   # Windows : venv\Scripts\activate
pip install -r requirements.txt

# 2. Lancer l'app
python run.py
# → http://127.0.0.1:5000/api/health

# 3. Stack complète (app + monitoring)
docker compose up -d
```

## Endpoints API

| Méthode | Route | Description |
|---|---|---|
| GET | `/api/health` | Health check |
| GET | `/api/tasks` | Lister les tâches (filtre: `?status=todo`) |
| GET | `/api/tasks/<id>` | Détail d'une tâche |
| POST | `/api/tasks` | Créer une tâche |
| PUT | `/api/tasks/<id>` | Modifier une tâche |
| DELETE | `/api/tasks/<id>` | Supprimer une tâche |
| GET | `/metrics` | Métriques Prometheus |

**Statuts valides** : `todo`, `in_progress`, `done`

## Tests

```bash
# Lancer tous les tests
pytest

# Avec couverture (seuil : 80%)
pytest --cov=app --cov-report=html

# Lint
ruff check app/ tests/
```

## Ports des services

| Service | URL |
|---|---|
| TaskFlow API | http://localhost:5000 |
| Prometheus | http://localhost:9090 |
| Grafana | http://localhost:3000 (admin/admin) |
| Loki | http://localhost:3100 |

## Infrastructure (IaC)

### Terraform (Docker local)

```bash
cd infra/terraform
terraform init
terraform plan
terraform apply
```

### Ansible (déploiement serveur)

```bash
# Adapter infra/ansible/inventory.ini avec l'IP de ta machine
cd infra/ansible
ansible-playbook -i inventory.ini playbook.yml
```

## CI/CD — Secrets GitHub requis

| Secret | Description |
|---|---|
| `SONAR_TOKEN` | Token SonarCloud ([sonarcloud.io](https://sonarcloud.io)) |
| `DEPLOY_HOST` | IP/hostname du serveur de déploiement |
| `DEPLOY_USER` | Utilisateur SSH |
| `DEPLOY_SSH_KEY` | Clé SSH privée |

> `GITHUB_TOKEN` est automatiquement fourni par GitHub Actions.

## SonarCloud

1. Créer un compte sur [sonarcloud.io](https://sonarcloud.io)
2. Lier ton repo GitHub
3. Récupérer le `projectKey` et l'`organization`
4. Mettre à jour `sonar-project.properties`
5. Ajouter `SONAR_TOKEN` dans les secrets du repo

## Stratégie GitOps

```
main       — production, protégée (PR obligatoire, CI doit passer)
dev        — intégration, cible des PR de feature
feature/*  — branches de développement
```

Commits au format conventionnel : `feat:`, `fix:`, `chore:`, `docs:`, `test:`

## Structure du projet

```
Projet Final/
├── app/                          # Code Flask (API + modèles)
├── tests/
│   ├── unit/                     # Tests unitaires (modèles)
│   └── integration/              # Tests d'intégration (API)
├── .github/
│   ├── workflows/
│   │   ├── ci.yml                # lint → test → sonar → docker build
│   │   └── cd.yml                # déploiement Ansible sur main
│   └── pull_request_template.md
├── infra/
│   ├── terraform/                # Provisioning Docker local
│   └── ansible/                  # Configuration & déploiement
├── monitoring/
│   ├── prometheus/               # Scrape config
│   ├── grafana/                  # Datasources + dashboard auto-provisionnés
│   ├── loki/                     # Stockage des logs
│   └── promtail/                 # Collecte des logs Docker
├── docker-compose.yml            # Stack complète locale
├── Dockerfile
├── pyproject.toml                # Config ruff + coverage
├── sonar-project.properties
└── docs/ARCHITECTURE.md
```
