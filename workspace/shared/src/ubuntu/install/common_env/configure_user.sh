#!/usr/bin/env bash
set -ex

# Simple User Configuration - Just add system bashrc to default profile
# KASM will copy this to kasm-user automatically at runtime

USER_BASHRC="/home/kasm-default-profile/.bashrc"

echo "=== Configuring default profile bashrc ==="

# Simply append our system bashrc sourcing to the existing KASM bashrc
if ! grep -q '/etc/bash.bashrc' "$USER_BASHRC" 2>/dev/null; then
    echo "" | sudo tee -a "$USER_BASHRC" > /dev/null
    echo "# Source system bashrc for development tools, aliases, and environment" | sudo tee -a "$USER_BASHRC" > /dev/null
    echo "source /etc/bash.bashrc" | sudo tee -a "$USER_BASHRC" > /dev/null
    echo "=== ✅ Added system bashrc sourcing to default profile ==="
else
    echo "=== ✅ System bashrc sourcing already configured ==="
fi

# Add our custom prompt for virtualenv support with double-prompt prevention
if ! grep -q 'set_custom_prompt' "$USER_BASHRC" 2>/dev/null; then
    echo "" | sudo tee -a "$USER_BASHRC" > /dev/null
    echo "# Custom prompt with virtualenv support (prevents double prompts)" | sudo tee -a "$USER_BASHRC" > /dev/null
    cat << 'EOF' | sudo tee -a "$USER_BASHRC" > /dev/null
set_custom_prompt() {
  # Only set prompt if not already set by virtual environment
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Check if prompt already contains virtualenv name
    local venv_name="$(basename $VIRTUAL_ENV)"
    if [[ "$PS1" != *"($venv_name)"* ]]; then
      export PS1="($venv_name) \u:\w\$ "
    fi
  else
    # No virtual environment, use clean prompt
    export PS1="\u:\w\$ "
  fi
}

# Set prompt initially
set_custom_prompt

# Override PROMPT_COMMAND to prevent conflicts
PROMPT_COMMAND="set_custom_prompt"
EOF
    echo "=== ✅ Added custom prompt with virtualenv support and double-prompt prevention ==="
else
    echo "=== ✅ Custom prompt already configured ==="
fi

echo "=== ✅ Default profile configuration complete - KASM will copy to kasm-user at runtime ==="
