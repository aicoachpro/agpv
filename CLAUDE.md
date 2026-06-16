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
