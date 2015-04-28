---
layout: post
title: Chromebook Chronicles Part 2
date: 2015-04-28  3:30:24
tags:
 - linux
 - chromebook
 - acer

---

I have been using the Acer C720 Chromebook as a linux laptop for a couple months now.

## SSD Upgrade

While I'm fairly satisfied with the results, I would not recommend an SSD upgrade from MyDigitalSSD. I have had not 1, but 2 SSD failures from them. I am sadly, hardly alone in this problem.

At the moment, I'm trying out a 256GB Transcend SSD (model MTS400). Only time will tell whether this will be more reliable drive than the MyDigital.

Note: If considering the above, make sure to disable ALPM to resolve SATA power management errors. Read more [here](https://wiki.archlinux.org/index.php/Solid_State_Drives#Resolving_SATA_power_management_related_errors).

## Linux

While I've taken no less than 3 distributions for a spin (Ubuntu, eOS - aka elementary, Arch Linux), I always go back to [Arch](http://archlinux.org).

This is mostly due to my being somewhat of a control freak when it comes to my computing choices. 

[eOS Freya](http://elementary.io) is a polished, refined distribution, with [Ubuntu 14.04 LTS](http://releases.ubuntu.com/14.04/) as its core underpinnings. I like, one can even say, love, that the eOS apps are visually consistent and lightweight. 

With Arch, however, I can set up a fairly lightweight system even when using [Cinnamon](https://wiki.archlinux.org/index.php/Cinnamon). 

## Installation

If you're used to Arch, then installation is more or less the same here as it is in the [Beginner's Guide](https://wiki.archlinux.org/index.php/Beginners%27_guide).

NOTE: Install `netctl` on the `arch-chroot` step. `wpa_supplicant` version `2.4.1` has a bug where you cannot authenticate with WPA, so I would recommend downloading `2.3.1` from somewhere, like at the [Arch Rollback Machine](http://seblu.net/a/arm/packages/w/wpa_supplicant/), so install it manually.

You can simply download it to the chroot-ed system with `wget http://seblu.net/a/arm/packages/w/wpa_supplicant/wpa_supplicant-2.3-1-x86_64.pkg.tar.xz`.

And then install: `pacman -U wpa_supplicant-2.3-1-x86_64.pkg.tar.xz`. 

## Tweaks

Here are the tweaks I made on setup:

### SSD optimization

My `/etc/fstab` looks more or less like this:

```
/dev/sda1           /boot  ext2  defaults,relatime,stripe=4                 0 2
/dev/sda2           /      ext4  defaults,noatime,discard,data=writeback    0 1
/dev/mapper/home    /home  ext4  defaults,noatime,discard,data=ordered      0 2
```

`/dev/mapper/home` maps to the encrypted `/home` partition that I set up on installation.

`discard` and `data` in the options is to enable `TRIM` on the SSD. 

### Fixing suspend/resume

[With kernel parameters](https://wiki.archlinux.org/index.php/Chrome_OS_devices#With_kernel_parameters)

As of this writing, kernel 4.0 hasn't yet reached `core`, so I did have to add this to `/etc/default/grub`:

```
GRUB_CMDLINE_LINUX_DEFAULT="tpm_tis.interrupts=0 modprobe.blacklist=ehci_pci"
```

### TLP for Power Management

[TLP](https://wiki.archlinux.org/index.php/TLP)

I modified specific configurations in `/etc/default/tlp`:

Here is one:

```
DISK_IDLE_SECS_ON_AC=0
DISK_IDLE_SECS_ON_BAT=0
```

CPU Frequency:

```
CPU_SCALING_GOVERNOR_ON_AC=performance
CPU_SCALING_GOVERNOR_ON_BAT=ondemand
```

TO disable aggressive SATA powermanagement due to a bug in my SSD:

```
SATA_LINKPWR_ON_AC=max_performance
SATA_LINKPWR_ON_BAT=max_performance
```

### Touchpad

[Chromium OS input drivers](https://wiki.archlinux.org/index.php/Chrome_OS_devices#Chromium_OS_input_drivers)

I installed [these](https://aur.archlinux.org/packages/xf86-input-cmt-xorg/) input drivers rather than go with synaptics since it appears to work better.

### Modules

The only real changes I've made is in `/etc/modprobe.d/ath9k.conf`:

```
options ath9k btcoex_enable=1 bt_ant_diversity=1 ps_enable=0
```

This is to enable bluetooth and wifi coexistence.

Power saving can also be enabled by setting the `ps_enable=1` flag, but according to the Arch wiki there are system freezes associated with that. 

### zram

[Zram or zswap setup](https://wiki.archlinux.org/index.php/Maximizing_performance#Zram_or_zswap)

[zram](https://www.kernel.org/doc/Documentation/blockdev/zram.txt) is a kernel module with which you can replace swap partitions for faster performance. 

### Preload

[Go-preload](https://wiki.archlinux.org/index.php/Preload#Go-preload)

This was mostly to speed up performance for Firefox and Chrome, though lately I've been using Opera more as it seems far more lean than either Chrome or Firefox.


## That's it for now.

Time will tell how well this setup will go. My next project is to do this on my rMBP, which currently is running Mavericks (due to Yosemite issues).

