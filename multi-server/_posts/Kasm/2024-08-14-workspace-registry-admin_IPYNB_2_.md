---
layout: post
title: Multi-Server Workspace Registry
description: How to configure the Kasm Muti-Server Workspaces
categories: ['Kasm']
menu: nav/kasm_cloud.html
toc: True
comments: True
permalink: /kasm/multiserver/workspace-registry
author: Rachit Jaiswal
---

## Workspace Registry Administration
Manual configuration is required to activite Workspaces that are published from the Nighthawk Registry.

### Workspace Server Configs
Each time you perform a Terraform deployment you should make these adjustments to the server.

- CPU and Memory override.   As admin.kasm.local user goes to `Compute` / Docker Agents on the left panel. Go to triple dots (...) on the far right of listed Docker Agent override values as follows:

```
# Values have been increased according to use case expectations

CPU Cores: 2  ---> CPU Cores Override: 6
Memory: 4110970880 ---> Memory Override: 12123456789
```

- Proxy Port adjustment.  As admin.kasm.local user goes to `Zones` on the left panel.  Go to triple dots (...) on the far right of the listed Zone set the value as follows:

```
# Nginx reverse proxy eliminates need for this setting

Proxy Port: 8443 ---> Proxy Port: 0
```

### Workspaces Configs
Each time you set up a server you need to consider configuring these items.

- Workspace Registry Add.  As admin.kasm.local user go to `Workspaces` on left panel and select `Workspace Registry`.  First, get link by following link and clicking [Workspace Registry Link](https://nighthawkcoders.github.io/kasm_registry/).  Add the copied link to the `Add New`.  The "Del Norte HS Computer Science" registry should appear, select small icons in box to filter.
- Install Workspace.  Click in the box of the desired and pick Install to add the workspace to the server's workspace.  This can take a while "10 minutes".  After installation, you need to make the following adjustments to the installed workspace.   For each workspace, admin.kasm.local user goes to `Workspaces` on the left panel and observes the catalog of installed workspace(s).  Go to triple dots (...) on the far right of the listed Workspace and set the value as follows:
```
# Persistent Home Directory (Kasm recommend different setting per workspace, here we use coders)

Persistent Profile Path:  /mnt/kasm_profiles/coders/{username}

# Setup Sudo and more.  This will require adding of File Mapping at bottom of page

Name: kasm_post_run_root.sh
Description: Install root updates
Destination Path: /dockerstartup/kasm_post_run_root.sh
Executable: Slide to True

Large box for Jammy:
set -ex
echo "kasm-user  ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
```
