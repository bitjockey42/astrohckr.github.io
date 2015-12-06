---
layout: post
title: "Triple Boot OS X, Windows 8.1, and Arch Linux on 2012 retina Macbook Pro"
date: "2015-12-05 19:25"
tags:
  - triple boot
  - os x
  - windows
  - linux
  - guides
---

I took some time this week to set up a triple-boot system on my 2012 retina Macbook (15-inch version). Initially, I wanted to do an Arch Linux-only install, but OS X is needed for firmware updates, and I still have a boatload of Windows-only games to finish.

* TOC
{:toc}

I thought I'd write down what I did just in case it's useful to anyone out there.

## Macbook Pro 10,1 Notes

This is all running on the original, 15-inch retina Macbook Pro that was released in mid-2012, with an Apple 256GB SSD.

![specs](/assets/images/2015/12/Screenshot from 2015-12-05 19-28-12.png)

## Before you begin

This is not for the feint of heart, and requires a stable internet connection for the installation.

This will require 4 different flash drives, 1 for clean-installing OS X, 2 for installing Windows, and 1 for installing Arch Linux.

If you have an Android smartphone, I recommend installing [ArchWiki viewer](https://play.google.com/store/apps/details?id=com.jtmcn.archwiki.viewer&hl=en) to easily search and view the ArchWiki articles formatted for a mobile screen.

## Installing OS X 10.11 (El Capitan)

For triple-booting, it's best to start fresh.

I did [clean install](http://osxdaily.com/2015/10/01/clean-install-os-x-el-capitan-mac/) that wiped everything from the existing setup I had so as to expand OS X to use the full disk.

From within OS X, I updated El Capitan to 10.11.1 for bugfixes and security updates.

## Partitioning

The partition layout here is important, as Windows only sees 4 partitions, and if it is installed on say, partition 5, it will not boot.

While you can use another partition manager like GParted, using OS X's Disk Utility will be the easiest method as it also accounts for the 128MiB space between partitions that's needed to maintain a GPT disk.

Note: because OS X Lion and forward keep a hidden Recovery partition, when you create a "second" from Disk Utility, it's actually the third partition. For simplicity's sake, I've referred to succeeding partitions according to their numeric order as you would see them in Disk Utility.

First, resize the OS X partition to a smaller size with Disk Utility. For my disk, I resized it to 20GB since I do not plan on using it as a primary OS.

![El Capitan Disk Utility](/assets/images/2015/12/El-Cap-disk-utility.jpg)

Then, add two new partitions, adjusting their sizes to whatever your needs require. Since I run my games from an external drive, 60GB was sufficient for Windows. The rest of the space, I allocated for Arch Linux.

Change the second partition to a FAT filesystem. This is necessary because the Windows installer won't be able to reformat anything that is not already an NTFS partition or a FAT partition.

Keep the third partition as an OS X (Journaled) filesystem as we can reformat that later.

## Installing Windows

Some guides out there recommend installing Windows in EFI mode for better performance, faster boot, etc.

While EFI installation of Windows 8.1 is certainly doable on the Macbook Pro 10,1, because this Macbook model is not UEFI-compliant as 2013 and present models are, you will run into many problems post-install, particularly with drivers.

I would recommend sticking with the Bootcamp installation method for this reason.

Assuming you have a valid serial code for Windows 8.1, you can proceed with this step. ;)

### Set up Bootcamp

Download a [Windows 8.1 ISO](https://www.microsoft.com/en-us/software-download/windows8ISO).

Then, use Bootcamp Assistant to [create a USB installer](https://support.apple.com/en-us/HT201457) for Windows 8.1.

![Screenshot from OS X Daily](/assets/images/2015/12/make-windows-10-install-usb-drive-from-mac-os-x1.jpg)

Once that's done, use another USB drive to store the Bootcamp drivers (e.g. for graphics, sound, etc.) that will need to be installed from within the Windows installation.

### Boot into the Windows USB Installer

Many reboots and startup chimes here.

Power off the Macbook Pro.

Hold the Option/Alt key, then press the Power button. Keep holding the Option key even after the startup chime, until you see a bootscreen displaying a grid of different drives.

Select the yellow drive labeled "Windows". Follow the onscreen instructions until you get to the screen giving you the choice between an Upgrade and a Custom installation.

### Windows Setup

Choose the Custom installation. In the Partition list, select the FAT partition that was created from Disk Utility. Then click Format to convert the partition to NTFS.

After that, proceed with the installation until the installer warns you that the system will restart. You will want to hold the Option key after hearing the startup chime, then select the **grey** "Windows" drive.

You'll then see the Windows circle logo thing for a few minutes, after which the system will restart again. So you will need to hold the Option key again at boot after the startup chime to enter the Windows. post-setup screens on the new installation.

The post-setup screens will create a new user in Windows 8.1 and log you into the new system.

For some reason, Windows 8.1 will restart automatically after a few minutes of letting you check out the newly installed and set up system, so you'll want to hold the Option key again at boot and select "Windows".

Once you're logged in to your Windows 8.1 account, plug in the USB flash drive containing the Bootcamp drivers. With Windows Explorer, navigate to the drive and navigate into the Bootcamp directory.

There should be a `setup` or `setup.exe` in that folder. Double-click that, and follow the onscreen instructions. This will automatically install the drivers for the discrete Nvidia GPU, the Broadcom WiFi card, among other things. The screen may flash during the Nvidia drivers installation. This is normal.

After these drivers are installed, you'll want to reboot (again, I know), and update Windows.

Please make sure to eject all the USB drives you've used to install things.

## Installing Arch Linux

This part is more or less adapted from [this](http://loicpefferkorn.net/2015/01/arch-linux-on-macbook-pro-retina-2014-with-dm-crypt-lvm-and-suspend-to-disk/) incredible guide.

### Preparing an Arch Linux Live USB

Follow the instructions outlined in the [ArchWiki](https://wiki.archlinux.org/index.php/USB_flash_installation_media).

### Booting into the Arch Linux Live Installer

Poweroff the Macbook.

Plug in the Arch Linux USB created.

Hold the Option key, press the Power button, and continue holding the Option key until you get that boot drive selection again. Select the yellow drive labeled "EFI loader".

### Enlarge Virtual Console Font

Once you're automatically logged into the live environment as `root`, you'll notice the font is very tiny. Set the font like so:

```
setfont sun12x22
```

### Connecting to the Internet

There are a number of ways to go about this, but as of this writing, you do need to have an active internet connection to install all the packages as offline installation no longer seems viable. Please comment below if there is an option, and I will update this post accordingly.

#### Ethernet (Wired Connection)

As noted in the [ArchWiki](https://wiki.archlinux.org/index.php/MacBookPro10,x#Preparing_for_the_Installation), you can use a Thunderbolt to Ethernet adapter, a USB Ethernet adapter (which is cheaper than a Thunderbolt adapter) to connect to a wired source.

Figure out the interface name:

```
ip link
```

This will output a list of interfaces, e.g. `enp0s4`.

You'll need to bring that interface up:

```
set ip link enp0s4 up
```

Then establish an IP with `dhcpcd`:

```
dhcpcd
```

Check if you're connected:

```
ping -c 3 www.google.com
```

#### Smartphone Tethering

See [here](https://wiki.archlinux.org/index.php/android_tethering). In many cases, this will be more or less the same as connecting with an Ethernet adapter, but you will have to enable USB tethering on the smartphone after plugging in.

#### WiFi

This is a bit of a hack and requires you to have another Arch installation somewhere. See [here](http://loicpefferkorn.net/2015/01/arch-linux-on-macbook-pro-retina-2014-with-dm-crypt-lvm-and-suspend-to-disk/#wireless:385892e3ac2613dca78d22bd09dbae7d).


### Partitioning

In the past, Linux installation guides would recommend having 3 different partitions for a system: `/home`, `/`, and `/boot`.

With a triple-booting GPT system, you only need one partition to set up as the `/` or root for Linux, as `/boot` will correspond to the SSD's existing `ESP` partition where EFI bootfiles are kept.

Use `lsblk` to see where the Macbook's SSD is mapped to:

```
$ lsblk
NAME                                       MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda                                          8:0    0 233.8G  0 disk  
├─sda1                                       8:1    0   200M  0 part  
├─sda2                                       8:2    0    19G  0 part  
├─sda3                                       8:3    0 619.9M  0 part  
├─sda4                                       8:4    0  55.9G  0 part  
└─sda5                                       8:5    0   158G  0 part  
```

During installation, my SSD was mapped to `/dev/sda`, but sometimes, it is mapped to `/dev/sdb`, so it's best to check the output of `lsblk` first.

Then, use `cgdisk` for partitioning.

{% highlight sh %}
cgdisk /dev/sda
{% endhighlight %}

Select the partition you allocated for Linux, which for me was `/dev/sda5`, and then select `Type` in the menu. You will be prompted to enter a code for the type; enter `8304`, which corresponds to Linux root.

Then, select `Write`. Follow the instructions to confirm you want to go about that.

### DM-crypt and LVM setup

If you want to have Arch Linux boot from an encrypted partition, see [here](http://loicpefferkorn.net/2015/01/arch-linux-on-macbook-pro-retina-2014-with-dm-crypt-lvm-and-suspend-to-disk/#arch-linux-disk-partitioning:385892e3ac2613dca78d22bd09dbae7d).

If not, skip to the next part.

### Non-encrypted setup

Format the partition you've allocated for Arch Linux as `ext4`:

{% highlight sh %}
mkfs.ext4 /dev/sda5
{% endhighlight %}

Mount that partition:

{% highlight sh %}
mount /dev/sda5 /mnt
{% endhighlight %}

Mount `/dev/sda1` to `/mnt/boot`:

{% highlight sh %}
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
{% endhighlight %}

### Arch base installation

Now, we can proceed with using `pacstrap` to install the base packages:

{% highlight sh %}
pacstrap -i /mnt base base-devel
{% endhighlight %}

After those operations have completed, generate the `fstab` using labels:

{% highlight sh %}
genfstab -L -p /mnt >> /mnt/etc/fstab
{% endhighlight %}

### Configuration

These are more or less the same as the basic configuration laid out [here](https://wiki.archlinux.org/index.php/installation_guide#Configure_the_system), all done from within the `chroot`.

If you want to make the consolefont larger than it is in the default configuration, create a `/etc/vconsole.conf` file and set the `FONT` option:

{% highlight cfg %}
echo 'FONT=sun12x22' >> /etc/vconsole.conf
{% endhighlight %}

Then, you will need to modify the `HOOKS` array of `/etc/mkinitcpio.conf` to load `consolefont`:

{% highlight cfg %}
HOOKS="base udev autodetect modconf block consolefont keymap keyboard filesystems fsck"
{% endhighlight %}

If you chose to go with a DM-crypt/LVM setup, the `HOOKS` array will look like this:

{% highlight cfg %}
HOOKS="base udev autodetect modconf block consolefont keymap keyboard encrypt lvm2 filesystems fsck"
{% endhighlight %}

Then, run `mkinitpio` to regenerate the images:

{% highlight sh %}
mkinitcpio -p linux
{% endhighlight %}

### Bootloader

`systemd` now ships with a simple boot manager provided by `systemd-boot`.

What previously was `gummiboot` has been included in `systemd-boot` as `bootctl`.

Create the necessary directories:

{% highlight sh %}
mkdir -p /boot/loader/entries
{% endhighlight %}

Create a file, `/boot/loader/loader.conf` and put this in it:

{% highlight text linenos=table %}
default arch
timeout 4
{% endhighlight %}

Save the file.

Then, create `/boot/loader/entries/arch.conf`.

If you did a DM-Crypt/LVM setup, it should look like this:

{% highlight text linenos=table %}
title	Arch Linux
linux	/vmlinuz-linux
initrd	/initramfs-linux.img
options cryptdevice=/dev/sda5:vgcrypt:allow-discards root=/dev/mapper/vgcrypt-root rw
{% endhighlight %}

If you did a regular ole setup:

{% highlight text linenos=table %}
title	Arch Linux
linux	/vmlinuz-linux
initrd	/initramfs-linux.img
options root=/dev/sda5 rw
{% endhighlight %}

Then, finally, install:

{% highlight sh %}
bootctl install
{% endhighlight %}

## Close

Now, exit the `chroot`, and type `reboot`. You should now see a simple boot loader listing OS X and Arch Linux.

I'll be following up with another post going over some post-installation tweaks specific to Arch Linux.
