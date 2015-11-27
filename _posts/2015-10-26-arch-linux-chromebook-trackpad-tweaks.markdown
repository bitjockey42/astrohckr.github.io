---
layout: post
title: Arch Linux Chromebook Trackpad Tweaks
date: 2015-10-26 11:01
tags: linux, chromebook, chromeos
---

I thought I'd take some time to document some Chromebook trackpad tweaks that could be useful on Arch Linux in particular. Note that I'm running this natively rather from [`crouton`](https://github.com/dnschneid/crouton).

## Using the Chromium OS Trackpad Driver on Linux

While the Synaptics driver works decently with the Acer C720 chromebook, I've that [xf86-input-cmt](https://github.com/hugegreenbug/xf86-input-cmt), the Linux port of the Chromium OS Trackpad driver more preferable because its behavior is much more similar to what's on Chrome OS (since, Chromium OS driver and all).

### Installation

[`xf86-input-cmt`](https://aur.archlinux.org/packages/xf86-input-cmt/) depends on these packages in the AUR which you'll need to install first:

- [libevdevc](https://aur.archlinux.org/packages/libevdevc/)
- [libgestures](https://aur.archlinux.org/packages/libgestures/)
- [xf86-input-cmt-setup](https://aur.archlinux.org/packages/xf86-input-cmt-setup/)

### Configuration

Copy one of the configs [here](https://github.com/hugegreenbug/xf86-input-cmt/tree/master/xorg-conf) that corresponds to the Chromebook model you use and save it under `/etc/X11/xorg.conf.d/` (eg. `peppy`). If you're not sure what that is, go [here](https://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices), look for your Chromebook model and check the Board Name.

For me, the model is the Acer C720, which corresponds to the `peppy` board name, so I copied [this](https://raw.githubusercontent.com/hugegreenbug/xf86-input-cmt/master/xorg-conf/50-trackpad-cmt-peppy.conf) into `/etc/X11/xorg.conf.d` as `50-trackpad-cmt-peppy.conf`.

Restart the X server, then, you should be good to go!.

## Enable Natural Scrolling, aka "Australian Scrolling"

I've gotten used to "Natural Scrolling", which is called "Australian Scrolling" in Chrome OS. To enable it, use [xorg-xinput](https://www.archlinux.org/packages/?sort=&q=xorg-xinput), which can also be used to configure the other options.

First, determine the `id` of the trackpad.

```
xinput
```

This outputs something like this:

```
⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
⎜   ↳ Cypress APA Trackpad (cyapa)            	id=12	[slave  pointer  (2)]
⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ Power Button                            	id=6	[slave  keyboard (3)]
    ↳ Video Bus                               	id=7	[slave  keyboard (3)]
    ↳ Power Button                            	id=8	[slave  keyboard (3)]
    ↳ Sleep Button                            	id=9	[slave  keyboard (3)]
    ↳ Sleep Button                            	id=10	[slave  keyboard (3)]
    ↳ HD WebCam                               	id=11	[slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard            	id=13	[slave  keyboard (3)]
```

The corresponding entry here is `Cypress APA Trackpad`, so the `id` you need to pass is `12`.

Then, determine what the property number corresponds to `Australian Scrolling`:

```
xinput --list-props 12|grep 'Australian Scrolling'
```

This outputs:

```
           Australian Scrolling (448): 0
```

The number in the parentheses is the property ID you need to modify.

To enable "Australian Scrolling", simply run `set-prop` with the `id` of the trackpad, the ID of the property, and then `1`:

```
xinput --set-prop 12 448 1
```

This will immediately enable natural scrolling.
