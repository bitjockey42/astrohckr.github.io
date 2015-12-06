---
layout: post
title: "Arch Linux Macbook Pro 10,1 Post-Install Configuration and Tweaks"
date: "2015-12-06 23:33"
---

### DKMS, Broadcom WiFi

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
