---
layout: post
title: Manual Addition of Docker Images to Kasm
description: When Kasm registry is not working, even with third party additions, there are ways to directly import a docker image from dockerhub.
type: ccc
courses: {}
menu: nav/kasm_cloud.html
toc: True
comments: True
permalink: /kasm/config/manual_docker_add
author: Rachit Jaiswal
---

<h2>Step 1: Navigation</h2>

<p>In the Kasm administrative panel, navigate to <code>Workspaces &gt; Workspaces</code>, then click the blue <code>Add Workspace</code> button.</p>

<p><img width="1495" alt="image" src="https://github.com/nighthawkcoders/kasmv2/assets/56803677/891129d1-cca3-4c26-ad6f-3f7d0bd73399"></p>

<p>On another tab, open the registry for the images: <a href="https://nighthawkcoders.github.io/kasm_registry/1.0/">https://nighthawkcoders.github.io/kasm_registry/1.0/</a></p>

<h2>Step 2: Filling everything out</h2>

<p>Follow the below configuration, use information you can get from the registries, whatever is not here you can leave blank:</p>

<p>Workspace Type &gt; Container

Registry Entry &gt; <em>BLANK</em>

Friendly Name &gt; <em>Name you want users to see</em>

Description &gt; <em>Description</em>

Thumbnail URL &gt; <em>From registry</em>

Enabled &gt; Yes

Docker Image &gt; <em>Get from image info in registry, ie <code>nighthawkcoders/pusd-student-ubuntu:1.14.0-rolling</code></em>

Cores &gt; <em>From registry: JSON config</em>

Memory (MB) &gt; <em>From registry: JSON config</em>

GPU Count &gt; <em>From registry: JSON config</em>

Uncompressed Image Size (MB) &gt; <em>From registry: JSON config</em>

CPU Allocation Method &gt; <em>From registry: JSON config</em>

Docker Registry &gt; <em>From registry: JSON config</em>

Docker Registry Username &gt; nighthawkcoders

Web Filter Policy &gt; Inherit (autofilled)

All <em>(JSON)</em> fields should be left with: <code>{}</code></p>

<h3>Persistent Setup Using Volume Storage</h3>
<p>In Persistent Profile Path: <code>/mnt/kasm_profiles/{image_id}/{user_id}</code> (location to store user data)
To restrict storage size, put this in Docker Run Config Override:
<code>json
{
  "KASM_PROFILE_SIZE_LIMIT": "2000000"
}</code></p>
