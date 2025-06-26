---
layout: post
title: Kasm Persistent Data Configuration Guide
description: How to configure Kasm to store data on the agent servers
type: ccc
courses: {}
menu: nav/kasm_cloud.html
toc: True
comments: True
permalink: /kasm/config/agent_persistent_data
author: Rachit Jaiswal
---

<p>Persistent data or persistent profiles is a setup that allows users to retain their data even after their images close using the storage availible on the agent servers. While this is beneficial, we recommend important data be backed up in Git, or moved into Drive.</p>

<h2>Step 1: Setup</h2>

<p>Go into the settings of the image that you are trying to modify.</p>

<p>Scroll down to Persistent Profile Path. Put: <code>/mnt/kasm_profiles/{image_id}/{user_id}</code> (location to store user data)</p>

<h2>OPTIONAL Restrict user storage (WORK IN PROGRESS)</h2>

<p>To restrict storage size, put this in Docker Run Config Override:</p>


```python
json
{
  "KASM_PROFILE_SIZE_LIMIT": "2000000"
}
```
```
