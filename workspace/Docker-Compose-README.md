# KASM Workspace - Docker Compose Guide

This guide shows how to use Docker Compose to easily build and run both Noble and Kali KASM environments from the shared workspace directory.

## 🎯 Advantages of Docker Compose Approach

- **Single workspace**: Work from `/workspace` directory with shared files
- **Target selection**: Easily choose Noble or Kali (or both)
- **Consistent commands**: Same commands work for both environments
- **Port management**: Automatic port assignment (no conflicts)
- **Easy cleanup**: Stop/start multiple containers with one command

## Shortcut Guide to Docker Compose

**Prerequisites**: Ensure Docker Desktop is installed and running. Adjust path according to your GitHub repository location.

### Common / Abbreviated Steps (Both Environments)

**Single Terminal Approach (Synchronous):**

```bash
# Step 1 - Build and Run both containers
cd /Users/johnmortensen/open/kasm-platform-fork/workspace
docker-compose --profile noble --profile kali up -d --build

# Step 2 - Test both environments
## Noble: https://localhost:6901/
## Kali: https://localhost:6902/

# Step 3 - Stop and Remove containers
docker-compose down

# Step 4 - Clean Docker resources
docker system prune -f
```

**Multi-Terminal Approach (Async Speed):**

```bash
# Terminal 1: Noble Environment
cd /Users/johnmortensen/open/kasm-platform-fork/workspace
docker-compose --profile noble up -d --build

# Terminal 2: Kali Environment (run simultaneously)
cd /Users/johnmortensen/open/kasm-platform-fork/workspace  
docker-compose --profile kali up -d --build

# Both complete faster due to parallel execution
# Test: Noble at https://localhost:6901/ & Kali at https://localhost:6902/

# Either terminal: Stop both when done
docker-compose down
docker system prune -f
```

**Clean Rebuild (Force from scratch):**

```bash
# Step 1 - Stop and clean everything
docker-compose down -v
docker system prune -f

# Step 2 - Force rebuild both (no cache)
docker-compose --profile noble --profile kali build --no-cache

# Step 3 - Start both environments
docker-compose --profile noble --profile kali up -d

# Step 4 - Test both, then cleanup when done
docker-compose down
```

## 📋 Quick Reference Commands

### Build Commands

```bash
# Build Noble image only
docker-compose --profile noble build

# Build Kali image only  
docker-compose --profile kali build

# Build both images
docker-compose --profile noble --profile kali build

# Force rebuild both (no cache)
docker-compose --profile noble --profile kali build --no-cache

# Force rebuild (no cache)
docker-compose --profile noble build --no-cache
docker-compose --profile kali build --no-cache
```

### Run Commands

```bash
# Run Noble environment
docker-compose --profile noble up -d

# Run Kali environment
docker-compose --profile kali up -d

# Run both environments (for comparison)
docker-compose --profile noble --profile kali up -d

# Run with build (build if needed, then start)
docker-compose --profile noble up -d --build

# Force rebuild and run (two-step process)
docker-compose --profile noble build --no-cache
docker-compose --profile noble up -d
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

### Clean Rebuild Workflow

```bash
# Stop everything and clean up
docker-compose down -v
docker system prune -f

# Force rebuild from scratch (no cache)
docker-compose --profile noble --profile kali build --no-cache

# Start fresh
docker-compose --profile noble --profile kali up -d
```

### Sync vs Async Execution

**Synchronous (blocking - waits for completion):**
```bash
# Build command blocks until complete
docker-compose --profile noble --profile kali build --no-cache

# Then start containers (waits for build to finish)
docker-compose --profile noble --profile kali up -d
```

**Asynchronous one-liner (runs build, then immediately starts):**
```bash
# Build and start in one command (blocks during build, then starts)
docker-compose --profile noble --profile kali up -d --build
```

**Background execution (truly async):**
```bash
# Start containers in background (returns immediately)
docker-compose --profile noble --profile kali up -d

# View progress without blocking
docker-compose logs -f noble
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
