---
layout: post
title: 'Arch Linux Macbook Pro 10,1 Post-Install Configuration and Tweaks'
date: 2015-12-08 14:09
tags:
  - guides
  - arch Linux
  - tweaks
  - configuration
---

This is a continuation of my previous post on Arch Linux on the Macbook Pro 10,1. This focuses on post-installation tweaks you can make on Arch Linux.

* TOC
{:toc}

## DKMS, Broadcom WiFi

This Macbook ships with a Broadcom BCM4331 WiFi card.

As noted in the [ArchWiki](https://wiki.archlinux.org/index.php/MacBookPro10,x#Wi-Fi), there are two options for the driver. `b43-firmware` is the reverse-engineered driver. `broadcom-wl` and `broadcom-wl-dkms` use the propriety Broadcom driver and are loaded as `wl` by the kernel, if installed and loaded.

I prefer to use [DKMS](https://wiki.archlinux.org/index.php/Dynamic_Kernel_Module_Support) in conjunction with the `broadcom-wl-dkms` driver, as it will be rebuilt every time a kernel update is applied.

To set up `dkms`, install with `pacman`:

{% highlight sh %}
pacman -S dkms
{% endhighlight %}

Then have it run at boot with `systemd`:

{% highlight sh %}
systemctl enable dkms
{% endhighlight %}

[broadcom-wl-dkms](https://aur.archlinux.org/packages/broadcom-wl-dkms) can be installed from the AUR.

## Hybrid Graphics

The model that I have of 2012 Retina Macbook Pro ships with dual GPUs.

I don't use the official propriety [NVIDIA](https://wiki.archlinux.org/index.php/NVIDIA) driver as the tweaks below don't seem possible with them.  

I use [Nouveau](https://wiki.archlinux.org/index.php/Nouveau) and [Intel](https://wiki.archlinux.org/index.php/Intel_graphics#Installation).

{% highlight sh %}
pacman -S xf86-video-nouveau xf86-video-intel
{% endhighlight %}

### Switch between Nvidia card and integrated GPU (requires reboot)

[gpu-switch](https://github.com/0xbb/gpu-switch) is a script enabling you to switch between the Intel and Nvidia cards.

I'm working on packaging this up for AUR, but for the time being, you can clone this repo and run the script as root:

{% highlight sh %}
cd /usr/local/src
git clone https://github.com/0xbb/gpu-switch.git
ln -s /usr/local/src/gpu-switch/gpu-switch /usr/bin/
{% endhighlight %}

To switch to the intel card:

{% highlight sh %}
gpu-switch -i
{% endhighlight %}

To switch to the discrete GPU:

{% highlight sh %}
gpu-switch -d
{% endhighlight %}

### Poweroff discrete GPU for better battery life with vgaswitcheroo



## Touchpad



## Fan Control with mbpfan

## Power Management

### tlp

### powertop
