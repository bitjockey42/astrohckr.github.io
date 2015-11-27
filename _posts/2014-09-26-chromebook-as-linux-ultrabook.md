---
layout: post
title: Chromebook as Linux Ultrabook
date: 2014-09-26 22:38:47
tags:
  - linux
  - chromebook
---

I recently got an [Acer C720](http://us.acer.com/ac/en/US/content/series/c720) Chromebook with the intention of using it as a sort of poor person's Macbook Air since I'm back to a college-student budget. And who can ever forget how obsessed I am with Linux?

"Don't you already have a fancy Macbook Pro with the fancy retina screen?", you may ask.

Well, yes, I do, but 95% of the time I do not need to lug around a 15-inch laptop. Plus, there's just something about an 11.6-inch laptop that's rather appealing (good things come in small packages?).

My (not so) little brother has one of these models, so I had the chance to play with it before purchasing one for myself. If you are particularly picky about the screen, I would not get this device as the display is pretty average (it's no IPS panel, that's for sure).

## Haswell

One of the nifty things about this particular chromebook is that it ships with an Intel Haswell board, which means battery life is tremendous. My usage of this thing this past week has confirmed that the battery life is indeed ridiculously fantastic.

The Intel processor the Acer C720 ships with is the dual-core Celeron 2995U, which has made it more performant than many other Chromebook models which tend to ship with an ARM-based processor or a single-core processor.

## Upgrade the SSD

The other nifty thing is that, with a bit of grit, you can swap the SSD with one with a bigger capacity with these [instructions](http://www.androidcentral.com/how-upgrade-ssd-your-acer-c720-chromebook). I ordered a 128 GB SSD from [MyDigitalSSD](http://www.amazon.com/MyDigitalSSD-Super-Cache-Solid-State/dp/B00EZ2E8NO/ref=sr_1_1/181-5627223-1975448?ie=UTF8&qid=1411791213&sr=8-1&keywords=MyDigitalSSD+SuperCache+2+SSD). I'll update this post once I receive it and swap out the SSD.

The RAM is sadly either 2GB or 4GB and cannot be upgraded since it's soldered onto the board. I got the 4GB model so that I can use this thing for some programming.

## Linux Setup

Installing Linux on this model is really easy once you get it set up to Developer mode and enable the built-in SeaBIOS (should you decide to dual-boot or run only Linux). Read [here](http://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices/acer-c720-chromebook) for instructions.

Now normally I would load up my favorite distro, Arch Linux, on a laptop, but since I am too lazy to deal with the shenanigans the live installation media pulls for 64-bit installations (it causes the chromebook to just restart after trying to load the Live distribution), I went with [this](https://www.distroshare.com/distros/get/14/) distribution based on the latest LTS Ubuntu 14.04 with the Xfce desktop environment. This distro is pre-configured to work out of the box for the Acer C720, so there is little to no fiddling with configs to make things work if your time is limited. Props to hugegreenbug for putting this together.

I am actually writing this post from the Xubuntu installation using the Xfce lightweight text editor "Mousepad", which I've never used before.

## TODO

Once I receive the SSD replacement, I'll try and see if I can set up a real Rails development environment. I've successfully installed ruby 2.1.2 and whatever gems are required to get this jekyll blog running locally, but those are fairly thin applications.
