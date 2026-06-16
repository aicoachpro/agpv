#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info() {
  printf '\033[1;34mINFO\033[0m %s\n' "$1"
}

write_if_missing() {
  local path="$1"
  if [ -e "$ROOT/$path" ]; then
    info "skip existing: $path"
    return
  fi
  mkdir -p "$ROOT/$(dirname "$path")"
  cat >"$ROOT/$path"
  info "created: $path"
}

write_if_missing .gitignore <<'EOT'
# Node
node_modules/
dist/
build/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
package-lock.json
pnpm-lock.yaml
.vscode/
.idea/
.DS_Store

# Python
__pycache__/
*.py[cod]
*.pyo
.venv/
venv/
env/

# Env
.env
.env.local
.env.*.local
.env.observability

# Journal and reports
journal/reports/local/
journal/reports/ci/
coverage/
coverage-final.json

# Observability
observability/.env.observability

# Vault sync local config
.vault-sync/local.json
EOT

write_if_missing ARCHITECTURE_DESIGN.md <<'EOT'
# Architektur-Design

## Projekt
- Name: AGPV Provisionsabrechnung
- Start-Version: 0.1.0
- Beschreibung: Upload einer Excel-Provisionsabrechnung, die der Agenturpartner in eine Provisionsabrechnung inklusive Buchungsnote umwandelt, damit die tatsächlichen Provisionen ermittelt werden können.

## 1. Ziel
Dieses Dokument dient als zentrales Hub für:
- /ideation
- /architecture-review
- /implement

## 2. Design-Rationale
- Runtime: Claude Code
- Backlog: GitHub Issues
- Governance: Lite
- Execution Isolation: none
- Deployment: Solo-Mac
- Add-ons: Privacy / DSGVO, EU AI Act
- Research-Provider: Perplexity MCP

## 3. Architektur
### 3.1 Frontend
- Aufgabe: Excel-Upload, Anzeige der Abrechnung, Validierung
- Technologie: Web-Frontend (React/Vue/Vanilla JS)

### 3.2 Backend
- Aufgabe: Verarbeitung der Excel-Datei, Erzeugen der Provisionsabrechnung, Buchungsnote, Provisionsermittlung
- Technologie: Node.js / JavaScript

### 3.3 API
- Aufgabe: Schnittstelle zwischen Frontend und Verarbeitung
- Endpunkte: Upload, Status, Ergebnis

### 3.4 Daten
- Excel-Import
- Verarbeitete Abrechnung
- Buchungsnote
- Ausgabe der tatsächlichen Provisionen

## 9. Referenzen
- `CONVENTIONS.md`
- `GOVERNANCE.md`
- `SECURITY.md`
- `PRIVACY.md`
- `AI_SYSTEM.md`
- `specs/TEMPLATE.md`
- `docs/project/Architektur-Vorgaben.md`
- `docs/project/Components/frontend.md`
- `docs/project/Components/backend.md`
- `docs/project/Components/api.md`
- `docs/project/Components/db.md`
- `DEVELOPMENT_PROCESS.md`
- `.claude/sensitive-paths.json`
- `.claude/personal-data-paths.json`
- `.claude/environment.json`
- `lighthouserc.json`
EOT

write_if_missing CONVENTIONS.md <<'EOT'
# CONVENTIONS

## Runtime
- runtime_target: claude-code

## Backlog
- backlog_adapter: github

## Governance
- governance_mode: lite
- execution_isolation: none

## Lighthouse
- lighthouse_ci: yes

## Sensitive Paths
- sensitive_paths: .claude/sensitive-paths.json

## Privacy
- privacy_addon: enabled
- eu_ai_act_addon: enabled

## Project metadata
- project_name: AGPV Provisionsabrechnung
- issue_prefix: AGPV
- documentation_language: de
EOT

write_if_missing GOVERNANCE.md <<'EOT'
# GOVERNANCE

## Projekt
- Projektname: AGPV Provisionsabrechnung
- Issue-Prefix: AGPV
- Backlog: GitHub Issues
- Governance-Modus: Lite

## Add-ons
- Privacy / DSGVO
- EU AI Act

## Prozesse
- Developer-Onboarding wird erzeugt und gepflegt.
- Spec-File-Pflicht: vor jeder Code-Änderung muss ein Spec-File existieren.
- Merge-Modus: nur fehlende Governance-Dateien ergänzen.

## Audit-Trail
- Session-Referenzen werden in Specs aufgenommen.
- `.claude/scripts/audit-trace.sh` kann später eingebunden werden.

## Dokumentation
- Projekt-SSoT: `docs/project/`
EOT

write_if_missing SECURITY.md <<'EOT'
# SECURITY

## Übersicht
Dieses Dokument beschreibt Sicherheitsgrundlagen für das Projekt.

## Sensitive Pfade
- `.claude/sensitive-paths.json` wird genutzt, um mandatory human review zu triggern.

## Logging und Auditing
- Strukturierte Logs werden empfohlen.
- Audit-Trail-Anforderungen zur Nachverfolgung von Änderungen.

## Privacy / DSGVO
- Siehe `PRIVACY.md`
EOT

write_if_missing PRIVACY.md <<'EOT'
# PRIVACY / DSGVO

## Projektname
AGPV Provisionsabrechnung

## Beschreibung
Dieses Projekt verarbeitet Provisionsdaten, die personenbezogene Informationen enthalten können. Die Datenschutzanforderungen müssen dokumentiert und eingehalten werden.

## Verarbeitungsverzeichnis
- Zweck: Verarbeitung von Excel-Provisionsabrechnungen
- Datenarten: Name, Agentur, Provision, Verkaufsdaten, Buchungsdaten

## Löschkonzept
- Dauer: Daten nur solange speichern wie für die Abrechnung benötigt
- Verfahren: Automatisierte Löschung nach abgeschlossenem Abrechnungszyklus

## Rollen
- Verantwortlicher: Projektbetreiber
- Datenschutzbeauftragter: [Einsetzen]

## Hinweis
Dieses Dokument ist eine Vorlage. Projekt-spezifische Details müssen ergänzt werden.
EOT

write_if_missing AI_SYSTEM.md <<'EOT'
# AI SYSTEM STECKBRIEF

## Projekt
- Name: AGPV Provisionsabrechnung

## Zweck
Die KI-Komponente unterstützt bei der Verarbeitung von Excel-Provisionsabrechnungen und der Erstellung einer Buchungsnote.

## KI-Runtime
- Claude Code

## Daten
- Eingabedaten: Excel-Tabellen mit Provisionssätzen
- Ausgabedaten: Provisionsabrechnung, Buchungsnote, tatsächliche Provisionen

## Transparenz
- Der Operator muss prüfen, welche Felder in die Verarbeitung eingehen.
- Automatische Bewertungen müssen nachvollziehbar bleiben.

## Human Oversight
- Kritische Ergebnisse müssen durch verantwortliche Personen geprüft werden.

## Offen
- Detaillierte Einordnung nach EU AI Act ist später zu ergänzen.
EOT

write_if_missing AGENTS.md <<'EOT'
# AGENTS

## Einstieg
Dieses Projekt nutzt Claude Code als primäre Runtime.

## Regeln
- `CLAUDE.md` ist die aktive Runtime-Dokumentation.
- `AGENTS.md` dient als portabler Codex-Einstieg.
- Alle neuen Dateien müssen in `ARCHITECTURE_DESIGN.md §9` und `INDEX.md` dokumentiert werden.

## Workflow
- Agenten folgen den Konventionen in `CONVENTIONS.md`
- Bei Abweichungen gilt: Dokumentation hat Vorrang.
EOT

write_if_missing CLAUDE.md <<'EOT'
# CLAUDE

## Projekt
- Name: AGPV Provisionsabrechnung
- Runtime: Claude Code

## Model-Routing-Policy (BOO-84)
- Standard: Default-Modelle für Claude Code nutzen
- Override: `--model <tier>` möglich
- Audit-Trail: Jeder Override wird dokumentiert

## Prompt-Caching (BOO-84)
- Prompt-Caching wird empfohlen, um Tokenkosten zu reduzieren
- Projekt-spezifische Caches sollten in `journal/` oder `.claude/cache/` verwaltet werden

## Wichtige Dateien
- `CONVENTIONS.md`
- `ARCHITECTURE_DESIGN.md`
- `PRIVACY.md`
- `AI_SYSTEM.md`
EOT

write_if_missing INDEX.md <<'EOT'
# Projekt-Index

## Projekt
- Name: AGPV Provisionsabrechnung
- Projekt-SSoT: `docs/project/`
- Hub: `ARCHITECTURE_DESIGN.md`

## Wichtige Artefakte
- `CONVENTIONS.md`
- `GOVERNANCE.md`
- `SECURITY.md`
- `PRIVACY.md`
- `AI_SYSTEM.md`
- `ARCHITECTURE_DESIGN.md`
- `specs/`
- `docs/project/Components/`
EOT

write_if_missing COMPONENT_INVENTORY.md <<'EOT'
# Component Inventory

## Frontend
- Zweck: Excel-Upload, Visualisierung, Validierung
- Status: geplant

## Backend
- Zweck: Verarbeitung, Business-Logik, Ergebnisgenerierung
- Status: geplant

## API
- Zweck: Schnittstelle zwischen Frontend und Backend
- Status: geplant

## DB
- Zweck: Datenhaltung der Abrechnungswerte
- Status: geplant
EOT

write_if_missing .env.example <<'EOT'
# Beispiel-Umgebungsvariablen

# API
API_URL=https://api.example.com
API_KEY=

# Research
PERPLEXITY_MCP_KEY=

# Datenschutz
PRIVACY_MODE=on
EOT

write_if_missing .prettierrc <<'EOT'
{
  "printWidth": 100,
  "tabWidth": 2,
  "singleQuote": true,
  "trailingComma": "all",
  "endOfLine": "lf"
}
EOT

write_if_missing eslint.config.mjs <<'EOT'
export default {
  linterOptions: {
    reportUnusedDisableDirectives: true,
  },
  languageOptions: {
    ecmaVersion: 2024,
    sourceType: 'module',
  },
  plugins: {
    '@typescript-eslint': {},
  },
  rules: {
    'no-unused-vars': 'warn',
    'no-console': 'off',
  },
};
EOT

write_if_missing .semgrep.yml <<'EOT'
rules:
  - id: p/security-audit
    rule: warn
  - id: p/secrets
    rule: warn
  - id: p/javascript
    rule: warn
#  - id: p/owasp-top-ten
#    rule: warn
EOT

write_if_missing .semgrepignore <<'EOT'
node_modules/
dist/
build/
journal/reports/
.venv/
__pycache__/
EOT

write_if_missing lighthouserc.json <<'EOT'
{
  "ci": {
    "collect": {
      "url": "http://localhost",
      "numberOfRuns": 1,
      "settings": {
        "throttlingMethod": "simulate",
        "throttling": {
          "rttMs": 300,
          "throughputKbps": 1600,
          "cpuSlowdownMultiplier": 4
        }
      }
    },
    "assert": {
      "assertions": {
        "categories.performance": ["error", {"minScore": 0.9}],
        "categories.accessibility": ["error", {"minScore": 0.9}],
        "metrics.lcp": ["error", {"maxNumericValue": 2500}],
        "metrics.cumulative_layout_shift": ["error", {"maxNumericValue": 0.1}],
        "metrics.total_blocking_time": ["error", {"maxNumericValue": 300}]
      }
    },
    "upload": {
      "target": "filesystem",
      "outputDir": "journal/reports/ci/run-\${{ github.run_id }}/"
    }
  }
}
EOT

write_if_missing .github/workflows/lighthouse.yml <<'EOT'
name: Lighthouse CI

on:
  push:
    branches: [main]
  pull_request:

jobs:
  lighthouse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: treosh/lighthouse-ci-action@v12
        with:
          configPath: lighthouserc.json
          outputPath: journal/reports/ci/run-\${{ github.run_id }}/lighthouse.json
EOT

write_if_missing .github/workflows/eslint.yml <<'EOT'
name: ESLint

on:
  push:
    branches: [main]
  pull_request:

jobs:
  eslint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm install
      - run: npx eslint .
      - name: Upload SARIF
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: eslint-report.sarif
EOT

write_if_missing .github/workflows/semgrep.yml <<'EOT'
name: Semgrep

on:
  push:
    branches: [main]
  pull_request:

jobs:
  semgrep:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: returntocorp/semgrep-action@v1
        with:
          config: .semgrep.yml
          output: .ci-reports/semgrep.sarif
      - name: Upload SARIF
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: .ci-reports/semgrep.sarif
EOT

write_if_missing .claude/environment.json <<'EOT'
{
  "environment": "mac",
  "tools_available": {
    "eslint": false,
    "semgrep": false
  },
  "paths": {
    "journal_reports": "journal/reports",
    "specs": "specs"
  },
  "metadata": {
    "created_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "bootstrap_version": "3.0",
    "stack": "mixed",
    "deployment_scenario": "solo-mac"
  }
}
EOT

write_if_missing .claude/settings.json <<'EOT'
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          { "type": "command", "command": "bash .claude/hooks/spec-gate.sh" },
          { "type": "command", "command": "bash .claude/hooks/doc-version-sync.sh" }
        ]
      },
      {
        "matcher": "Edit|Write|MultiEdit",
        "hooks": [
          { "type": "command", "command": "bash .claude/hooks/pre-edit-bodyguard.sh" }
        ]
      }
    ]
  }
}
EOT

write_if_missing .claude/sensitive-paths.json <<'EOT'
{
  "project": "AGPV Provisionsabrechnung",
  "patterns": [
    "src/auth/**",
    "src/payment/**",
    "src/**/pii/**",
    "**/*personal*",
    "**/*customer*",
    "**/*billing*"
  ],
  "note": "Bitte projektspezifische Pfade ergänzen."
}
EOT

write_if_missing .claude/personal-data-paths.json <<'EOT'
{
  "project": "AGPV Provisionsabrechnung",
  "patterns": [
    "**/user*",
    "**/customer*",
    "**/profile*",
    "**/*pii*",
    "**/auth/profile/**",
    "**/billing/**"
  ]
}
EOT

write_if_missing .claude/dpo/controls/eu-ai-act.yml <<'EOT'
# EU AI Act optionaler Kontrollkatalog
# Dieser Katalog wird nur geladen, wenn er ins Projekt kopiert wurde.

controls:
  - id: eu-ai-act-1
    title: "KI-Systemsteckbrief vorhanden"
    description: "Das Projekt verfügt über ein dokumentierten KI-System-Steckbrief."
  - id: eu-ai-act-2
    title: "Human Oversight spezifiziert"
    description: "Human Oversight für KI-Entscheidungen ist dokumentiert."
EOT

write_if_missing docs/project/Architektur-Vorgaben.md <<'EOT'
# Architektur-Vorgaben

## Ziel
Dokumentiert grundlegende Architekturentscheidungen für das Projekt.

## Technik
- Frontend: Web-Frontend
- Backend: Node.js / JavaScript
- API: REST/GraphQL je nach Bedarf
- Datenhaltung: SQL/NoSQL je Projektbedarf

## Quality Gates
- Linting
- Semgrep
- Privacy-Checks
- EU AI Act Dokumentation

## Hinweise
- Alle neuen Komponenten in `ARCHITECTURE_DESIGN.md §9` eintragen.
EOT

write_if_missing docs/project/Components/frontend.md <<'EOT'
# Component: Frontend

## Zweck
- Excel-Upload
- Visualisierung der Abrechnungsergebnisse
- Interaktion mit der API

## Stack
- JavaScript / HTML / CSS
- Optional: React oder Vue

## Offene Fragen
- Welche Bibliothek zur Excel-Verarbeitung?
- Wie erfolgt die Authentifizierung?

## Referenzen
- `ARCHITECTURE_DESIGN.md`
EOT

write_if_missing docs/project/Components/backend.md <<'EOT'
# Component: Backend

## Zweck
- Verarbeitung der Excel-Datei
- Erzeugen der Provisionsabrechnung
- Berechnung der tatsächlichen Provisionen

## Stack
- Node.js
- Express / Fastify

## Offene Fragen
- Persistenzmodell
- Fehlerbehandlung bei ungültigen Excel-Daten

## Referenzen
- `ARCHITECTURE_DESIGN.md`
EOT

write_if_missing docs/project/Components/api.md <<'EOT'
# Component: API

## Zweck
- Schnittstelle zwischen Frontend und Backend
- Upload-Endpunkt für Excel-Dateien
- Ergebnisabruf

## Endpunkte
- POST /upload
- GET /status/:id
- GET /result/:id

## Referenzen
- `ARCHITECTURE_DESIGN.md`
EOT

write_if_missing docs/project/Components/db.md <<'EOT'
# Component: DB

## Zweck
- Speicherung von Rohdaten
- Speicherung von Abrechnungen und Buchungsnotizen
- Historie und Audit-Trail

## Optionen
- SQL-Datenbank
- Dokumentenorientierte DB

## Referenzen
- `ARCHITECTURE_DESIGN.md`
EOT

write_if_missing specs/TEMPLATE.md <<'EOT'
# Spec Template

## ID
AGPVXXX

## Titel
[Kurzer Titel der Story]

## Status
- [ ] Backlog
- [ ] In Progress
- [ ] In Review
- [ ] Done

## Purpose
[Wozu dient diese Story?]

## Akzeptanzkriterien
- [ ] Kriterium 1
- [ ] Kriterium 2
- [ ] Kriterium 3

## Tech Notes
[Technische Details, API, Datenmodell]

## Referenzen
- ARCHITECTURE_DESIGN.md
- CONVENTIONS.md
- PRIVACY.md

## Session-Referenz
- TODO: /implement Session-ID
EOT

write_if_missing DEVELOPMENT_PROCESS.md <<'EOT'
# Development Process

## Ziel
Beschreibt den Entwicklungsprozess und verweist auf `GOVERNANCE.md`.

## Schritte
1. Spezifikation anlegen/aktualisieren
2. Code entwickeln
3. Tests schreiben
4. Review durchführen
5. Merge

## Hinweise
- Dev-Prozess folgt den Governance-Regeln in `GOVERNANCE.md`
EOT

write_if_missing CHANGELOG.md <<'EOT'
# Changelog

## 0.1.0
- Initiale Governance- und Projektbasis angelegt
EOT

write_if_missing docs/backlog/record-template.md <<'EOT'
# Backlog Record Template

- id: AGPV000
- title:
- status:
- priority:
- estimate:
- intent:
- acceptance_criteria:
- links:
- adapter: github
EOT
