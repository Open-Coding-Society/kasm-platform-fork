# KASM Workspace - Docker Compose Guide

This guide shows how to use Docker Compose to easily build and run both Noble and Kali KASM environments from the shared workspace directory.

## 🎯 Advantages of Docker Compose Approach

- **Single workspace**: Work from `/workspace` directory with shared files
- **Target selection**: Easily choose Noble or Kali (or both)
- **Consistent commands**: Same commands work for both environments
- **Port management**: Automatic port assignment (no conflicts)
- **Easy cleanup**: Stop/start multiple containers with one command

## 📋 Quick Reference Commands

### Build Commands

```bash
# Build Noble image only
docker-compose --profile noble build

# Build Kali image only  
docker-compose --profile kali build

# Build both images
docker-compose --profile noble --profile kali build

# Force rebuild (no cache)
docker-compose --profile noble build --no-cache
docker-compose --profile kali build --no-cache
```

### Run Commands

```bash
# Run Noble environment (uses existing image)
docker-compose --profile noble up -d

# Run Kali environment (uses existing image)
docker-compose --profile kali up -d

# Run both environments (for comparison)
docker-compose --profile noble --profile kali up -d

# Run with build (build if needed, then start)
docker-compose --profile noble up -d --build

# Run with live output (see startup progress)
docker-compose --profile noble up --build
```

### Monitor Progress

```bash
# Build with visible progress
docker-compose --profile noble build --progress=plain

# Monitor container startup
docker-compose logs -f noble
docker-compose logs -f kali

# Check container status
docker-compose ps

# Monitor resource usage
docker stats
```

### Stop Commands

```bash
# Stop Noble environment
docker-compose --profile noble down

# Stop Kali environment
docker-compose --profile kali down

# Stop all environments
docker-compose down

# Stop and remove volumes/networks
docker-compose down -v
```

## 🌐 Access Your Environments

### Noble Ubuntu Desktop

- **URL**: https://localhost:6901
- **Username**: `kasm_user`
- **Password**: `password`

### Kali Linux Desktop  

- **URL**: https://localhost:6902
- **Username**: `kasm_user`
- **Password**: `password`

## 🚀 Common Workflows

### Development Workflow (Single Environment)

```bash
cd /Users/johnmortensen/open/kasm-platform-fork/workspace

# Build and run Noble for development
docker-compose --profile noble up -d --build

# Access at https://localhost:6901
# Do your development work...

# Stop when done
docker-compose --profile noble down
```

### Testing Workflow (Compare Both Environments)

```bash
cd /Users/johnmortensen/open/kasm-platform-fork/workspace

# Build both environments
docker-compose --profile noble --profile kali build

# Run both for side-by-side testing
docker-compose --profile noble --profile kali up -d

# Access both:
# Noble: https://localhost:6901
# Kali:  https://localhost:6902

# Stop both when done
docker-compose down
```

### Publishing to Docker Hub Workflow

```bash
# 1. Login to Docker Hub
docker login

# 2. Build and tag images for Docker Hub
docker-compose build
docker tag kasm-noble-test:latest yourusername/kasm-noble-pages:latest
docker tag kasm-kali-test:latest yourusername/kasm-kali-pages:latest

# 3. Push to Docker Hub
docker push yourusername/kasm-noble-pages:latest
docker push yourusername/kasm-kali-pages:latest

# 4. Tag with version numbers (recommended)
docker tag yourusername/kasm-noble-pages:latest yourusername/kasm-noble-pages:v1.0
docker tag yourusername/kasm-kali-pages:latest yourusername/kasm-kali-pages:v1.0
docker push yourusername/kasm-noble-pages:v1.0
docker push yourusername/kasm-kali-pages:v1.0
```

### KASM Multiserver Integration

Once published to Docker Hub, integrate with KASM:

```bash
# 1. In KASM Admin Panel, add new workspace images:
# Image: yourusername/kasm-noble-pages:latest
# Image: yourusername/kasm-kali-pages:latest

# 2. Configure workspace settings:
# - Enable GPU (if needed)
# - Set memory limits (4GB recommended)
# - Configure persistent storage mapping

# 3. Deploy across KASM multiserver infrastructure
# Images will be automatically pulled from Docker Hub
```

### Clean Rebuild Workflow

```bash
# Stop everything and clean up
docker-compose down -v
docker system prune -f

# Rebuild from scratch
docker-compose --profile noble --profile kali build --no-cache

# Start fresh
docker-compose --profile noble --profile kali up -d
```

## 🔧 Advanced Usage

### View Logs

```bash
# View Noble logs
docker-compose logs noble

# View Kali logs  
docker-compose logs kali

# Follow logs in real-time
docker-compose logs -f noble
```

### Shell Access

```bash
# Access Noble container shell
docker-compose exec noble bash

# Access Kali container shell
docker-compose exec kali bash
```

### Container Status

```bash
# View running containers
docker-compose ps

# View all containers (including stopped)
docker-compose ps -a
```

## 🎯 Profile System Explained

The `profiles` feature lets you selectively build/run environments:

- `--profile noble`: Only Noble Ubuntu environment
- `--profile kali`: Only Kali Linux environment  
- `--profile noble --profile kali`: Both environments

This prevents accidentally running both when you only need one.

## 📊 Resource Usage

### Running Single Environment

- **Memory**: ~2-4 GB per container
- **Ports Used**: 
  - Noble: 6901
  - Kali: 6902

### Running Both Environments

- **Memory**: ~4-8 GB total
- **Ports Used**: Both 6901 and 6902
- **Use Case**: Side-by-side testing/comparison

## 🛠️ Troubleshooting

### Port Conflicts

```bash
# Check what's using the ports
lsof -i :6901
lsof -i :6902

# Stop conflicting containers
docker-compose down
```

### Build Issues

```bash
# Clean rebuild
docker-compose build --no-cache --pull

# Check Docker daemon is running
docker info
```

### Container Won't Start

```bash
# Check logs for errors
docker-compose logs noble
docker-compose logs kali

# Check container status
docker-compose ps
```

## ✅ Benefits Over Individual Docker Commands

1. **Simplified Commands**: No need to remember complex docker run commands
2. **Consistent Configuration**: Same settings applied every time
3. **Easy Multi-Environment**: Run both Noble and Kali simultaneously
4. **Shared Context**: Both use same workspace directory and shared files
5. **Version Control**: docker-compose.yml can be committed to git
6. **Team Collaboration**: Same commands work for all developers

This approach makes it much easier to work with both KASM environments from your shared workspace!
