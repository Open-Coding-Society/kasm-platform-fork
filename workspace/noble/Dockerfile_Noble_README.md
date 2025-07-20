# KASM Noble Image - Docker Desktop Guide

## Ubuntu Noble Overview

🎯 Ubuntu Noble 24.04 LTS is a stable, long-term support release optimized for development and productivity. Unlike Kali (which is security-focused), Noble provides a reliable foundation for general software development, web development, and educational environments.

### Noble Summary

- **LTS Foundation**: Ubuntu 24.04 LTS provides 5 years of security updates and stability
- **APT Package Management**: Mature Debian-based package system with extensive repositories
- **Development-Optimized**: Pre-configured for modern development workflows
- **Educational Focus**: Clean separation of concerns for teaching programming concepts
- **Production Ready**: Stable base suitable for both development and deployment environments
- **Wide Hardware Support**: Excellent compatibility across different architectures

### Development Tools Included

#### GitHub Pages Web Development

- Jekyll static site generator for GitHub Pages (`pagesenv`)
- Ruby gems and Bundler for dependency management
- Jupyter notebook support for interactive development
- Python pip packages for data science and web development

#### Python Backend Development

- Flask web framework with virtual environment support (`flaskenv`)
- Support for Flask repository templates and starter projects
- SQLAlchemy ORM for database operations
- JWT (JSON Web Tokens) for authentication
- SQLite database integration for development
- Pandas and NumPy for data analysis and ML integration
- Requests library for API consumption
- Gunicorn WSGI server for production deployment

#### Java Enterprise Development

- Java 21+ with modern language features
- Support for Spring repository templates and enterprise patterns
- Spring Boot framework for rapid application development
- Spring Security for authentication and authorization
- Maven build system with POM dependency management
- JPA/Hibernate for object-relational mapping
- Spring Data for database operations
- RESTful API development with Spring MVC

#### Development Tools

- Visual Studio Code with proper terminal integration
- Docker support for containerized development
- Modern build tools and compilers
- Database clients and development utilities
- GitHub integration

## Shortcut Guide to Noble Docker

**Prerequisites**: Ensure Docker Desktop is installed and running from the steps above. Adjust instruction below according to user and location that you pulled and named your GitHub repository.

### Common / Abbreviated steps from Command Line

```bash
# Step 1
# Build and Run container
cd /Users/johnmortensen/open/kasm-platform-fork/workspace
docker build -f noble/Dockerfile -t kasm-noble-workspace:latest .
docker run -d --name kasm-noble-workspace-container -p 6901:6901 --shm-size=512m -e VNC_PW=password kasm-noble-workspace:latest
# Step 2
# Run on browser and test using: 
## https://localhost:6901/
# Step 3
# Stop and Remove container
docker stop kasm-noble-workspace-container
docker rm kasm-noble-workspace-container
# Step 4
# Visit Docker Desktop to cleanup
# images: select and delete
# builds: select and delete
# Step 5
# Clean Docker resources
docker system prune -f
```

## 📥 Prerequisites - Install Docker Desktop

### For macOS

1. **Download Docker Desktop for Mac**:
   - Visit: <https://www.docker.com/products/docker-desktop/>
   - Click "Download for Mac" (choose Apple Silicon or Intel based on your Mac)
   - Open the downloaded `.dmg` file
   - Drag Docker to Applications folder

2. **Launch Docker Desktop**:
   - Open Docker Desktop from Applications
   - Complete the initial setup and sign in (optional)
   - Wait for Docker to start (you'll see the whale icon in the menu bar)
   - Verify installation: Open Terminal and run `docker --version`

### For Windows with WSL2:

1. **Enable WSL2**:
   - Open PowerShell as Administrator
   - Run: `wsl --install`
   - Restart your computer

2. **Download Docker Desktop for Windows**:
   - Visit: <https://www.docker.com/products/docker-desktop/>
   - Click "Download for Windows"
   - Run the installer and enable WSL2 integration
   - Restart when prompted

3. **Configure WSL2 Integration**:
   - Open Docker Desktop Settings
   - Go to "Resources" → "WSL Integration"
   - Enable integration with your WSL2 distributions
   - Apply & Restart

## 🏗️ Building the Image

**Prerequisites**: Ensure Docker Desktop is installed and running from the steps above.

### Option 1: Using Docker Desktop UI

1. Go to the "Images" tab
2. Click "Build an image"
3. Set build context to: `/Users/johnmortensen/open/kasm-platform-fork/workspace`
4. Set Dockerfile path to: `noble/Dockerfile`
5. Name the image: `kasm-noble-workspace:latest`
6. Click "Build"

### Option 2: Using Terminal (Recommended)

```bash
cd /Users/johnmortensen/open/kasm-platform-fork/workspace
docker build -f noble/Dockerfile -t kasm-noble-workspace:latest .
```

### Option 3: Clean Rebuild (Force rebuild without cache)

```bash
# Clean up existing images and containers first
docker stop kasm-noble-workspace-container 2>/dev/null || true
docker rm kasm-noble-workspace-container 2>/dev/null || true

# Clean build without cache
cd /Users/johnmortensen/open/kasm-platform-fork/workspace
docker build --no-cache -f noble/Dockerfile -t kasm-noble-workspace:latest .
```

### Option 4: Deep Clean + Rebuild (Free up maximum space)

```bash
# Stop and remove all containers using KASM images
docker stop $(docker ps -q --filter ancestor=kasm-noble-workspace:latest) 2>/dev/null || true
docker rm $(docker ps -aq --filter ancestor=kasm-noble-workspace:latest) 2>/dev/null || true

# Remove KASM images
docker rmi kasm-noble-workspace:latest 2>/dev/null || true

# Clean Docker system (removes unused containers, networks, images)
docker system prune -f

# Clean build cache
docker builder prune -f

# Rebuild from scratch
cd /Users/johnmortensen/open/kasm-platform-fork/workspace
docker build --no-cache --pull -f noble/Dockerfile -t kasm-noble-workspace:latest .
```

## 🚀 Running the Container

### Via Docker Desktop UI:

1. Go to "Images" tab
2. Find `kasm-noble-workspace:latest`
3. Click "Run" button
4. Configure ports:
   - Host Port 6901 → Container Port 6901 (Web/VNC)
5. Set environment variable: `VNC_PW=password`
6. Set shared memory: `--shm-size=512m`
7. Click "Run"

### Via Terminal:

**Minimal Command (recommended):**

```bash
docker run -d --name kasm-noble-workspace-container -p 6901:6901 --shm-size=512m -e VNC_PW=password kasm-noble-workspace:latest
```

**If you get "container name already in use" error:**

```bash
# Stop and remove the existing container first
docker stop kasm-noble-workspace-container 2>/dev/null || true
docker rm kasm-noble-workspace-container 2>/dev/null || true

# Then run the container again
docker run -d --name kasm-noble-workspace-container -p 6901:6901 --shm-size=512m -e VNC_PW=password kasm-noble-workspace:latest
```

**Full Command (with optional features):**

```bash
docker run -d \
  --name kasm-noble-workspace-container \
  -p 6901:6901 \
  --shm-size=512m \
  -e VNC_PW=password \
  kasm-noble-workspace:latest
```

**Interactive Command (for debugging):**

```bash
docker run -it --rm -p 6901:6901 --shm-size=512m -e VNC_PW=password kasm-noble-workspace:latest
```

## 🌐 Accessing Your KASM Workspace

Once the container is running:

- **Web Access**: <https://localhost:6901>
- **VNC Access**: localhost:6901
- **Username**: `kasm_user` (note: underscore, not hyphen)
- **Password**: `password`

## 🧪 Testing Your Development Environment

After accessing the workspace, test the development tools:

```bash
# Test virtual environments
flaskenv  # Should activate Flask environment
pagesenv  # Should activate Pages environment

# Test Ruby gems and Jekyll
jekyll --version
bundle --version

# Test VS Code integration
code --version

# Test Node.js ecosystem
node --version
npm --version

# Test Python development tools
python3 --version
pip --version

# Check development environment setup
echo $GEM_HOME
echo $PATH
```

### 🚀 Real-World Test: GitHub Pages Development

Test the complete development workflow:

```bash
mkdir open
cd open
git clone https://github.com/Open-Coding-Society/pages.git
cd pages
pagesenv
bundle install
make
```

**Expected Result:**

```text
Server started in 12 seconds
    Server address: http://127.0.0.1:4500/
```

### 🐍 Python Flask Development Test

Test Flask development environment:

```bash
flaskenv
pip list | grep Flask
python3 -c "import flask; print(f'Flask {flask.__version__} ready')"
```

### 🛠️ Development Tools Validation

Test development workflow integration:

```bash
# Test Git configuration
git --version
git config --list

# Test Docker integration
docker --version

# Test development shortcuts and aliases
ls -la ~/.bashrc
```

cd open
git clone <https://github.com/Open-Coding-Society/pages.git>
cd pages
pagesenv
bundle install
make

```

**Expected Result:**

```text
Server started in 12 seconds
    Server address: http://127.0.0.1:4500/
```

This comprehensive testing validates:

- ✅ Git operations work correctly with proper configuration
- ✅ Python virtual environments (`flaskenv`, `pagesenv`) activate properly
- ✅ Ruby gems and Bundler are pre-installed and functional
- ✅ Jekyll development server starts without issues
- ✅ Node.js and npm are available for modern web development
- ✅ VS Code integration with proper terminal prompt behavior
- ✅ Flask development environment is ready for Python web development
- ✅ No startup delays for any development environments
- ✅ Docker integration available for containerized development
- ✅ All development shortcuts and aliases are configured

## 🛑 Stopping and Managing Containers

### Stop the Container

**Via Docker Desktop UI:**

1. Go to "Containers" tab
2. Find your running `kasm-noble-workspace-container`
3. Click "Stop" button

**Via Terminal:**

```bash
# Stop by container name:
docker stop kasm-noble-workspace-container

# Or stop by image (stops all containers using this image):
docker stop $(docker ps -q --filter ancestor=kasm-noble-workspace:latest)
```

### Remove the Container

**Via Docker Desktop UI:**

1. After stopping, click "Delete" button

**Via Terminal:**

```bash
# Remove by container name:
docker rm kasm-noble-workspace-container

# Or remove all stopped containers:
docker container prune -f
```

### Free Up Port 6901

If you get "port already in use" errors:

```bash
# Find what's using port 6901
lsof -i :6901

# Kill any process using port 6901 (macOS/Linux)
sudo lsof -ti:6901 | xargs kill -9

# Or stop all KASM containers
docker stop $(docker ps -q --filter ancestor=kasm-noble-workspace:latest)
```

## 🍪 Clearing Login Cookies

If you need to clear your login session or troubleshoot authentication:

### Method 1: Browser Developer Tools

1. Open your browser's Developer Tools (F12)
2. Go to "Application" or "Storage" tab
3. Find "Cookies" → "<https://localhost:6901>"
4. Delete all cookies for this domain

### Method 2: Browser Settings

1. Go to browser settings/preferences
2. Navigate to Privacy/Security settings
3. Click "Clear browsing data" or "Clear cookies"
4. Select "Cookies and site data"
5. Choose time range and clear

### Method 3: Incognito/Private Mode

- Use browser's incognito/private mode for a fresh session
- No cookies are stored, so each session starts clean

### Method 4: Different Browser

- Switch to a different browser for testing
- Useful for comparing behavior across browsers

**When to Clear Cookies:**

- Authentication issues or login loops
- Testing different user scenarios
- Switching between different KASM containers
- Troubleshooting session-related problems
