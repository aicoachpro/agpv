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
