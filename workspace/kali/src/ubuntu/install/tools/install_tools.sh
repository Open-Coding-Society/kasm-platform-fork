#!/usr/bin/env bash
set -ex

# ====== Setup Constants ======
BASHRC_FILE="/etc/bash.bashrc"
LOGFILE="/tmp/kasm_install_tools.log"
exec > >(tee -a "$LOGFILE") 2>&1

# ====== Setup Functions ======
log() {
    echo "=== ✅ $1 ==="
}

err() {
    echo "❌ ERROR: $1" >&2
    exit 1
}

ensure_gem_installed() {
    local gem_name=$1
    if gem list -i "$gem_name" > /dev/null 2>&1; then
        log "Gem '$gem_name' already installed"
    else
        log "Installing gem '$gem_name'..."
        gem install "$gem_name" || err "Failed to install gem: $gem_name"
    fi
}

ensureEnvVar() {
    local var_name="$1"
    local var_value="$2"
    local bashrc_file="${3:-$BASHRC_FILE}"

    if grep -q "^export $var_name=" "$bashrc_file"; then
        log "$var_name already set in $bashrc_file"
    else
        echo "export $var_name=$var_value" | sudo tee -a "$bashrc_file" > /dev/null
        log "Set $var_name in $bashrc_file"
    fi
}

addToPATH() {
    local new_path="$1"
    local bashrc_file="${2:-$BASHRC_FILE}"

    local path_line="export PATH=\"$new_path:\$PATH\""

    if grep -q "^export PATH=\"$new_path:" "$bashrc_file"; then
        log "PATH already includes $new_path"
    else
        echo "$path_line" | sudo tee -a "$bashrc_file" > /dev/null
        log "Added $new_path to PATH in $bashrc_file"
    fi
}

# ====== Start Installation ======
echo "=== 🏗️ Starting KASM Tools Installation ==="

# ====== Package Installation ======
echo "=== [1/5] Installing base packages ==="
apt-get update && log "APT update complete"
apt-get install -y \
    curl \
    sudo \
    lsof \
    wget \
    nano \
    zip \
    build-essential \
    ruby-full \
    jupyter-notebook \
    sqlite3 \
    python3 \
    python3-pip \
    python3-venv \
    python-is-python3 \
    bundler \
    ca-certificates \
    software-properties-common \
    && log "APT packages installed"
    # Note: JDK packages not required as already provided by the base image 
    # default-jdk \
    # default-jre-headless \

# ====== User Permissions Setup ======
echo "=== [2/5] Setting up user permissions ==="
echo "kasm-user  ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers && log "Sudo configured for kasm-user"

# ====== Python Virtual Environments ======
echo "=== [3/5] Creating Python virtual environments ==="
mkdir -p /opt/venvs && chmod 755 /opt/venvs

# Flask Environment
if [ ! -d /opt/venvs/flaskenv ]; then
    log "Creating flaskenv..."
    python3 -m venv /opt/venvs/flaskenv
    source /opt/venvs/flaskenv/bin/activate
    pip install --upgrade pip
    pip install \
        Flask \
        requests \
        SQLAlchemy \
        Werkzeug \
        Flask-Login \
        Flask-SQLAlchemy \
        Flask-Migrate \
        Flask-RESTful \
        Flask-Cors \
        PyJWT \
        pandas \
        numpy \
        matplotlib \
        seaborn \
        scikit-learn \
        pymysql \
        psycopg2-binary \
        python-dotenv \
        boto3
    deactivate
    log "flaskenv ready"
else
    log "flaskenv already exists"
fi

# Pages Environment
if [ ! -d /opt/venvs/pagesenv ]; then
    log "Creating pagesenv..."
    python3 -m venv /opt/venvs/pagesenv
    source /opt/venvs/pagesenv/bin/activate
    pip install --upgrade pip
    pip install \
        nbconvert \
        nbformat \
        pyyaml \
        notebook \
        requests \
        python-dotenv \
        pandas \
        seaborn \
        scikit-learn \
        progress \
        newspaper3k \
        wikipedia \
        emoji \
        lxml_html_clean
    deactivate
    chmod -R a+rX /opt/venvs
    log "pagesenv ready"
else
    log "pagesenv already exists"
fi

# ====== Ruby Gems Setup ======
echo "=== [4/5] Installing Ruby Gems ==="
export GEM_HOME=/opt/gems
export PATH=$GEM_HOME/bin:$PATH
mkdir -p "$GEM_HOME"
chmod -R 777 "$GEM_HOME"

# Core gems
ensure_gem_installed bundler
ensure_gem_installed jekyll

# Ruby stdlib gems (Ruby 3+ modular gems)
ensure_gem_installed benchmark
ensure_gem_installed openssl
ensure_gem_installed zlib
ensure_gem_installed racc
ensure_gem_installed bigdecimal
ensure_gem_installed drb
ensure_gem_installed unicode-display_width
ensure_gem_installed logger
ensure_gem_installed etc
ensure_gem_installed fileutils
ensure_gem_installed ipaddr
ensure_gem_installed mutex_m
ensure_gem_installed ostruct
ensure_gem_installed rss
ensure_gem_installed strscan
ensure_gem_installed stringio
ensure_gem_installed time

chmod -R 777 "$GEM_HOME"
log "Ruby environment configured"

# ====== Environment Configuration ======
echo "=== [5/5] Configuring environment ==="

# Add aliases
grep -q 'alias flaskenv=' "$BASHRC_FILE" || echo 'alias flaskenv="source /opt/venvs/flaskenv/bin/activate"' | sudo tee -a "$BASHRC_FILE"
grep -q 'alias pagesenv=' "$BASHRC_FILE" || echo 'alias pagesenv="source /opt/venvs/pagesenv/bin/activate"' | sudo tee -a "$BASHRC_FILE"
grep -q 'alias code=' "$BASHRC_FILE" || echo 'alias code="code --no-sandbox"' | sudo tee -a "$BASHRC_FILE"

# Add to PATH
addToPATH "/opt/venvs/flaskenv/bin"
addToPATH "/opt/venvs/pagesenv/bin"
addToPATH "$GEM_HOME/bin"

# Set environment variables
ensureEnvVar "GEM_HOME" "/opt/gems"

# Add virtualenv prompt
if ! grep -q 'VIRTUAL_ENV' "$BASHRC_FILE"; then
    sudo tee -a "$BASHRC_FILE" > /dev/null <<'EOF'
# Show Python virtualenv in prompt
if [[ -n "$VIRTUAL_ENV" ]]; then
    venv="($(basename $VIRTUAL_ENV)) "
else
    venv=""
fi
export PS1="${venv}\u:\w\$ "
EOF
    log "Added virtualenv prompt logic to $BASHRC_FILE"
else
    log "Virtualenv prompt logic already exists in $BASHRC_FILE"
fi

log "Environment configuration complete"

# ====== Cleanup ======
if [ -z ${SKIP_CLEAN+x} ]; then
    apt-get autoclean
    rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*
    log "Cleanup complete"
fi

echo "=== ✅ KASM Tools Installation Complete ==="
