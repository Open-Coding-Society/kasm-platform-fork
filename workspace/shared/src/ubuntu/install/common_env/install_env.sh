#!/usr/bin/env bash
set -ex

################################################################################
# Development Environment Installation Driver
# 
# This script orchestrates the build-time development environment setup:
# 1. Python virtual environments and requirements
# 2. Ruby gems and Jekyll toolchain  
# 3. System shell configuration (aliases, PATH)
#
# Note: User-specific configuration runs after system permissions via Dockerfile
#
# Educational Note: This demonstrates the "driver pattern" - one script that
# coordinates multiple installation phases in the correct order.
################################################################################

echo "=== 🌍 Installing Development Environment ==="
echo "This will set up Python, Ruby, and shell configuration for development..."

# Ensure all scripts have execute permissions
echo "Setting execute permissions on all scripts..."
chmod +x /usr/bin/install_python_requirements.sh /usr/bin/install_ruby_gems.sh /usr/bin/install_system_bash.sh /usr/bin/configure_user_bash.sh

# Phase 1: Install Python virtual environments and requirements
echo ""
echo "=== [1/3] Installing Python Requirements ==="
/usr/bin/install_python_requirements.sh

# Phase 2: Install Ruby gems and Jekyll toolchain  
echo ""
echo "=== [2/3] Installing Ruby Gems ==="
/usr/bin/install_ruby_gems.sh

# Phase 3: Configure shell environment (system-level)
echo ""
echo "=== [3/3] Configuring System Shell Environment ==="
/usr/bin/install_system_bash.sh

echo ""
echo "=== ✅ Development Environment Installation Complete! ==="
echo "    - Python virtual environments: flaskenv, pagesenv"
echo "    - Ruby gems: Jekyll, Bundler, and dependencies"  
echo "    - System shell: aliases and PATH configured"
echo "    - User profile: Will be configured after system permissions are set"
