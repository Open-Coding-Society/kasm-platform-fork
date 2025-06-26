---
layout: post
title: Manual Addition of Docker Images to Kasm (UPDATED)
description: When Kasm registry is not working, even with third party additions, there are ways to directly import a docker image from dockerhub.
type: ccc
courses: {}
menu: nav/kasm_cloud.html
toc: True
comments: True
permalink: /kasm/config/manual_docker_add_updated
author: Rachit Jaiswal
---

<p>When Kasm registry is not working, even with third party additions, there are ways to directly import a docker image from dockerhub.</p>

<h2>Step 1: Navigation</h2>

<p>In the Kasm administrative panel, navigate to <code>Workspaces &gt; Workspaces</code>, then click the blue <code>Add Workspace</code> button.</p>

<p>On another tab, open the registry for the images: <a href="https://nighthawkcoders.github.io/kasm_registry/1.0/">https://nighthawkcoders.github.io/kasm_registry/1.0/</a></p>

<h2>Step 2: Filling everything out</h2>

<p>Follow the below configuration, use information you can get from the registries, whatever is not here you can leave blank:</p>

<ul>
<li>Workspace Type &gt; Container</li>
<li>Registry Entry &gt; <em>BLANK</em></li>
<li>Friendly Name &gt; <em>Name you want users to see</em></li>
<li>Description &gt; <em>Description</em></li>
<li>Thumbnail URL &gt; <em>From registry</em></li>
<li>Enabled &gt; Yes</li>
<li>Docker Image &gt; <em>Get from image info in registry, ie <code>nighthawkcoders/pusd-student-ubuntu:1.14.0-rolling</code></em></li>
<li>Cores &gt; <em>From registry: JSON config</em></li>
<li>Memory (MB) &gt; <em>From registry: JSON config</em></li>
<li>GPU Count &gt; <em>From registry: JSON config</em></li>
<li>Uncompressed Image Size (MB) &gt; <em>From registry: JSON config</em></li>
<li>CPU Allocation Method &gt; <em>From registry: JSON config</em></li>
<li>Docker Registry &gt; <em>From registry: JSON config</em></li>
<li>Docker Registry Username &gt; nighthawkcoders</li>
<li>Web Filter Policy &gt; Inherit (autofilled)</li>
<li>All <em>(JSON)</em> fields should be left with: <code>{}</code></li>
</ul>
