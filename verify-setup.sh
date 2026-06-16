#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FAIL=0
WARN=0

info() { printf '\033[1;34mINFO\033[0m %s\n' "$1"; }
warn() { WARN=$((WARN + 1)); printf '\033[1;33mWARN\033[0m %s\n' "$1"; }
fail() { FAIL=$((FAIL + 1)); printf '\033[1;31mFAIL\033[0m %s\n' "$1"; }

check_file() {
  local f="$1"
  if [ -f "$ROOT/$f" ]; then
    info "found $f"
  else
    fail "missing $f"
  fi
}

check_dir() {
  local d="$1"
  if [ -d "$ROOT/$d" ]; then
    info "found $d"
  else
    fail "missing dir $d"
  fi
}

info "Verify setup in $ROOT"

if git -C "$ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  info "git repo detected"
else
  fail "not a git repository"
fi

check_file ARCHITECTURE_DESIGN.md
check_file CONVENTIONS.md
check_file GOVERNANCE.md
check_file SECURITY.md
check_file PRIVACY.md
check_file AI_SYSTEM.md
check_file AGENTS.md
check_file CLAUDE.md
check_file INDEX.md
check_file COMPONENT_INVENTORY.md
check_file .env.example
check_file .claude/environment.json
check_file .claude/settings.json
check_file .claude/sensitive-paths.json
check_file .claude/personal-data-paths.json
check_file .claude/dpo/controls/eu-ai-act.yml
check_file .github/workflows/lighthouse.yml
check_file .github/workflows/eslint.yml
check_file .github/workflows/semgrep.yml
check_file .semgrep.yml
check_file .semgrepignore
check_file lighthouserc.json
check_file specs/TEMPLATE.md
check_file docs/project/Architektur-Vorgaben.md
check_file docs/project/Components/frontend.md
check_file docs/project/Components/backend.md
check_file docs/project/Components/api.md
check_file docs/project/Components/db.md
check_file DEVELOPMENT_PROCESS.md
check_file CHANGELOG.md

check_dir docs/project
check_dir docs/project/Components
check_dir specs
check_dir .claude/dpo/controls

if [ -f "$ROOT/.gitignore" ]; then
  if grep -qF "journal/reports/local/" "$ROOT/.gitignore"; then
    info ".gitignore contains journal/reports/local/"
  else
    warn ".gitignore missing journal/reports/local/"
  fi
  if grep -qF ".env" "$ROOT/.gitignore"; then
    info ".gitignore contains .env"
  else
    warn ".gitignore missing .env"
  fi
else
  fail "missing .gitignore"
fi

echo
info "Summary: FAIL=$FAIL WARN=$WARN"

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi

exit 0
