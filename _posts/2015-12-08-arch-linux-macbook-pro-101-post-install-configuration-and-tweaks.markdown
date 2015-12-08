---
layout: post
title: 'Arch Linux Macbook Pro 10,1 Post-Install Configuration and Tweaks'
date: '2015-12-08 14:43'
tags:
  - guides
  - arch Linux
  - tweaks
  - configuration
---

This is a continuation of my [previous](http://ajwrit.es/2015/12/05/triple-boot-os-x-windows-81-and-arch-linux-on-2012-retina-macbook-pro/) post on Arch Linux on the Macbook Pro 10,1. This focuses on post-installation tweaks you can make on Arch Linux for this particular model. These are also applicable to the Macbook Pro 10,2, the 13-inch model without the discrete graphics.

* TOC
{:toc}

## DKMS, Broadcom WiFi

This Macbook ships with a Broadcom BCM4331 WiFi card.

As noted in the [ArchWiki](https://wiki.archlinux.org/index.php/MacBookPro10,x#Wi-Fi), there are two options for the driver. `b43-firmware` is the reverse-engineered driver. `broadcom-wl` and `broadcom-wl-dkms` use the propriety Broadcom driver and are loaded as `wl` by the kernel, if installed and loaded.

I prefer to use [DKMS](https://wiki.archlinux.org/index.php/Dynamic_Kernel_Module_Support) in conjunction with the `broadcom-wl-dkms` driver, as it will be rebuilt every time a kernel update is applied.

To set up `dkms`, install with `pacman`:
{% highlight sh %}
$ pacman -S dkms
{% endhighlight %}

Then have it run at boot with `systemd`:

{% highlight sh %}
$ systemctl enable dkms
{% endhighlight %}

[broadcom-wl-dkms](https://aur.archlinux.org/packages/broadcom-wl-dkms) can be installed from the AUR.

## Hybrid Graphics

The model that I have of 2012 Retina Macbook Pro ships with dual GPUs.

I don't use the official propriety [NVIDIA](https://wiki.archlinux.org/index.php/NVIDIA) driver as the tweaks below don't seem possible with them.  

I use [Nouveau](https://wiki.archlinux.org/index.php/Nouveau) and [Intel](https://wiki.archlinux.org/index.php/Intel_graphics#Installation).

{% highlight sh %}
$ pacman -S xf86-video-nouveau xf86-video-intel
{% endhighlight %}

### Switch between Nvidia card and integrated GPU (requires reboot)

[gpu-switch](https://github.com/0xbb/gpu-switch) is a script enabling you to switch between the Intel and Nvidia cards.

I'm working on packaging this up for AUR, but for the time being, you can clone this repo and run the script as root:

{% highlight sh %}
$ cd /usr/local/src
$ git clone https://github.com/0xbb/gpu-switch.git
$ ln -s /usr/local/src/gpu-switch/gpu-switch /usr/bin/
{% endhighlight %}

To switch to the intel card:

{% highlight sh %}
$ gpu-switch -i
{% endhighlight %}

To switch to the discrete GPU:

{% highlight sh %}
$ gpu-switch -d
{% endhighlight %}

Then, reboot.

### Poweroff discrete GPU for better battery life with vgaswitcheroo

To poweroff the discrete GPU after you've switched to the integrated card:

{% highlight sh %}
$ sudo su
$ echo OFF > /sys/kernel/debug/vgaswitcheroo/switch
{% endhighlight %}

Then check if it's off:

{% highlight sh %}
$ cat /sys/kernel/debug/vgaswitcheroo/switch
{% endhighlight %}

Output should be something like this:

{% highlight text %}
0:DIS-Audio: :Off:0000:01:00.1
1:DIS: :Off:0000:01:00.0
2:IGD:+:Pwr:0000:00:02.0
{% endhighlight %}

The `+` indicates the active GPU.

If you want this to be automatically done on boot, install [systemd-vgaswitcheroo-units](https://aur.archlinux.org/packages/systemd-vgaswitcheroo-units) from the AUR and enable `vgaswitcheroo.service`.

## Touchpad

You can use [xf86-input-mtrack](https://aur.archlinux.org/packages/xf86-input-mtrack-git/) for this.

Then create a configuration under `/etc/X11/xorg.conf.d/50-mtrack.conf`.

A sample configuration:

{% highlight apache linenos=table %}
Section "InputClass"
  Identifier "touchpad"
  Driver "mtrack"
  MatchIsTouchpad "on"
  MatchDevicePath "/dev/input/event*"
  Option "Sensitivity" "0.45"
  Option "TapButton1" "1"
  Option "TapButton2" "3"
  Option "TapButton3" "2"
  Option "TapButton4" "0"
  Option "ClickFinger1" "1"
  Option "ClickFinger2" "0"
  Option "ClickFinger3" "0"
  Option "ButtonMoveEmulate" "false"
  Option "FingerHigh" "10"
  Option "FingerLow" "1"
  Option "IgnoreThumb" "true"
  Option "IgnorePalm" "true"
  Option "TapDragEnable" "false"
EndSection
{% endhighlight %}

## Fan Control with mbpfan

Install [mbpfan-git](https://aur.archlinux.org/packages/mbpfan-git/) for enabling fan control.

{% highlight sh %}
$ mbpfan -t
$ systemctl enable mbpfan
{% endhighlight %}

## Power Management

### tlp

`tlp` automatically tunes your computer for better battery life when the laptop is unplugged.

Install `tlp` from the official repos, then enable the `tlp` and `tlp-service`.

{% highlight sh %}
$ systemctl enable tlp
$ systemctl enable tlp-sleep
{% endhighlight %}

### powertop

Use `powertop` from the official repos, which you can use to both look at power consumption and tweak system configurations to increase battery life. `powertop` has a

You'll need to `--calibrate` to make sure the measurements from `powertop` are accurate. This will run a cycle that will turn off the display, wifi, to establish benchmarks.

{% highlight sh %}
$ powertop --calibrate
{% endhighlight %}

Then, you can use `auto-tune` to tweak the recommended tunables automatically. See [here](https://wiki.archlinux.org/index.php/Powertop#Tips_and_tricks) for how.

### thermald to prevent overheating

Without any tweaks, this system can run pretty hot. My palms were sweating buckets before I set up the fan control and this package here:

[thermald](https://aur.archlinux.org/packages/thermald/) is an essential component of my Arch Linux system as it prevents overheating by triggering cooling at certain temperatures.

## Close

Hope this helps, and as before, please leave a comment if there are more tweaks that should be added.
