# KASM Noble Image - Docker Desktop Guide

## 📥 Prerequisites - Install Docker Desktop

### For macOS:
1. **Download Docker Desktop for Mac**:
   - Visit: https://www.docker.com/products/docker-desktop/
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
   - Visit: https://www.docker.com/products/docker-desktop/
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
3. Set build context to: `/Users/johnmortensen/open/kasm-platform-fork/workspace/noble`
4. Name the image: `kasm-noble-test:latest`
5. Click "Build"

### Option 2: Using Terminal (if CLI issues persist)
```bash
cd /Users/johnmortensen/open/kasm-platform-fork/workspace/noble
docker build -t kasm-noble-test:latest .
```

### Option 3: Clean Rebuild (Force rebuild without cache)
```bash
# Clean up existing images and containers first
docker stop kasm-noble-test-container 2>/dev/null || true
docker rm kasm-noble-test-container 2>/dev/null || true
docker rm kasm-noble-test-container 2>/dev/null || true
# Clean build without cache
cd /Users/johnmortensen/open/kasm-platform-fork/workspace/noble
docker build --no-cache -t kasm-noble-test:latest .
```

### Option 4: Deep Clean + Rebuild (Free up maximum space)
```bash
# Stop and remove all containers using KASM images
docker stop $(docker ps -q --filter ancestor=kasm-noble-test:latest) 2>/dev/null || true
docker rm $(docker ps -aq --filter ancestor=kasm-noble-test:latest) 2>/dev/null || true

# Remove KASM images
docker rmi kasm-noble-test:latest 2>/dev/null || true

# Clean Docker system (removes unused containers, networks, images)
docker system prune -f

# Clean build cache
docker builder prune -f

# Rebuild from scratch
cd /Users/johnmortensen/open/kasm-platform-fork/workspace/noble
docker build --no-cache --pull -t kasm-noble-test:latest .
```

## 🚀 Running the Container

### Via Docker Desktop UI:
1. Go to "Images" tab
2. Find `kasm-noble-test:latest`
3. Click "Run" button
4. Configure ports:
   - Host Port 6901 → Container Port 6901 (Web/VNC)
5. Set environment variable: `VNC_PW=password`
6. Set shared memory: `--shm-size=512m`
7. Click "Run"

### Via Terminal:

**Minimal Command (recommended):**
```bash
docker run -d -p 6901:6901 --shm-size=512m -e VNC_PW=password kasm-noble-test:latest
```

**Full Command (with optional features):**
```bash
docker run -d \
  --name kasm-noble-test-container \
  -p 6901:6901 \
  --shm-size=512m \
  -e VNC_PW=password \
  kasm-noble-test:latest
```

**Interactive Command (for debugging):**
```bash
docker run -it --rm -p 6901:6901 --shm-size=512m -e VNC_PW=password kasm-noble-test:latest
```

## 🌐 Accessing Your KASM Workspace

Once the container is running:
- **Web Access**: https://localhost:6901
- **VNC Access**: localhost:6901
- **Username**: `kasm_user` (note: underscore, not hyphen)
- **Password**: `password`

## 🧪 Testing Your Enhanced Tools

After accessing the workspace, test:

```bash
# Test virtual environments
flaskenv  # Should activate Flask environment
pagesenv  # Should activate Pages environment

# Test Ruby gems
jekyll --version
bundle --version

# Test VS Code
code --version

# Check environment
echo $GEM_HOME
echo $PATH
```
