#!/usr/bin/env bash
#
# install_skills.sh
#
# Installs the baygent-skills bayesian-workflow and causal-inference skills
# into the CURRENT WORKING DIRECTORY's .claude/skills/ folder, so that
# Claude Code will pick them up as project-local skills when launched from
# that directory.
#
# This script is idempotent: running it twice will overwrite the existing
# installation with the copies from workshop_session4/baygent-skills/.
#
# Usage:
#   cd /path/to/your/research/project
#   bash /Users/cy/dev/hdsi/workshop_session4/install_skills.sh
#
# After running, restart any open Claude Code sessions in that project.
#
# To install globally instead (so the skills work in every Claude Code
# session regardless of directory), pass --global:
#   bash install_skills.sh --global

set -euo pipefail

# Source directory is always the workshop_session4 clone, regardless of
# where the script is invoked from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/baygent-skills"

# Target directory defaults to ./.claude/skills/ in the caller's CWD.
# Pass --global to target ~/.claude/skills/ instead.
if [ "${1:-}" = "--global" ]; then
  TARGET_DIR="${HOME}/.claude/skills"
  SCOPE="global"
else
  TARGET_DIR="${PWD}/.claude/skills"
  SCOPE="project-local (${PWD})"
fi

if [ ! -d "${SOURCE_DIR}" ]; then
  echo "ERROR: ${SOURCE_DIR} does not exist." >&2
  echo "The baygent-skills clone is missing. Did you move install_skills.sh" >&2
  echo "out of the workshop_session4 directory?" >&2
  exit 1
fi

mkdir -p "${TARGET_DIR}"

echo "Installing skills into ${SCOPE}:"
for skill in bayesian-workflow causal-inference; do
  src="${SOURCE_DIR}/${skill}"
  dst="${TARGET_DIR}/${skill}"
  if [ ! -d "${src}" ]; then
    echo "  WARNING: ${src} not found, skipping." >&2
    continue
  fi
  if [ -d "${dst}" ]; then
    echo "  overwriting ${dst}"
    rm -rf "${dst}"
  fi
  cp -r "${src}" "${dst}"
  echo "  installed ${skill} -> ${dst}"
done

echo ""
echo "Done. Restart Claude Code to pick up the new skills."
echo ""
echo "To verify:"
echo "  ls ${TARGET_DIR}"
echo ""
echo "To test activation, paste a trigger query from"
echo "  ${SCRIPT_DIR}/exercises/track_b1_trigger_queries.md"
echo "into Claude Code and confirm the skill activates."
