Return-Path: <linux-wireless+bounces-19573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48AEA4970D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 11:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4411757D6
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068C25D1FD;
	Fri, 28 Feb 2025 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="mDhs/bHh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB825DD0F;
	Fri, 28 Feb 2025 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738048; cv=none; b=uhoLyBDIPf3ZlYgTiyBjkN9C8tMI+uFfSCNeo4se8IJ5W+oHU/y6LvBBC1CkiRtc79BxqgnMh5jljCb3TM1QoidIlfBzCD3P3fFwQ1f+gxK+xZV9SC1/lyVnCUkiRop8i+YNz7HMHBujHlwPhmaK9+H9GNGfL0LYXn7g5Zs62Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738048; c=relaxed/simple;
	bh=4krllKo7z2ckuH4TBpnSYU0vp6ONvcq5mJ1zaMn4CcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t/Z7nos1q76/MfSqwZm0giKH7X2M5nL5paJ+BZxNgJgDPob0LIgNpnyUCnpAGD6Cy0MxcFJ25Ws/YmkVhScKuu5NQQByHqMFdzAkca1pCvwptI1oWwDF8zWZq0v+CxYJ4zYlXUmr9FOjabzJ5k0Oe9G/4zA/8U5zIOQxQorjUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=mDhs/bHh; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1740737994; x=1741342794; i=christian@heusel.eu;
	bh=vmEFqJ56LnvWrP5Z/T3/6CxwTi7oeTW9qfy3kuXb9nU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mDhs/bHhu581OOTnTgXLsLAdt4OpV5l04QxSQZHT9CGssHp4tBsEBOAviQbmdmpz
	 kAm1X0M5kb0QdM+5wxDsvDxUGhGuZ4Pb2ieiUwwXKb48EYlusBzGCKyJjBZnSJEaS
	 ch1ABurKu8g0Vm63R3ekrJh1iuLq/3qWDP2h4x2Fpm0qKZgexuH0pKw48kw8ses+E
	 drPLyD/gpFkhBJVww2TxReDa9Nz2GAFCdARP1VgEX+gU0SMAWPcVo1yetC6TQ+Xd1
	 UiJ/9fss1oJra1yl0fthXOIP+15v6tSptX6v9QlGgh0tLzju2JKZH9pMvrm+j0A8k
	 EDn5zU2pPXW7mX+6Rg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1McGp2-1tHuRJ3Znw-00izC7; Fri, 28
 Feb 2025 11:19:54 +0100
Date: Fri, 28 Feb 2025 11:19:52 +0100
From: Christian Heusel <christian@heusel.eu>
To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, stable@vger.kernel.org
Cc: Benjamin Xiao <fossben@pm.me>, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org
Subject: [REGRESSION][BISECTED][STABLE] MT7925 wifi throughput halved with
 6.13.2
Message-ID: <b994a256-ee2f-4831-ad61-288ae7bc864b@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k65zb2ld7znvcohp"
Content-Disposition: inline
X-Provags-ID: V03:K1:OJwjJgfkpOqepGPvUTdBV26GZ07i9JzqAt87gYkxIZEKbxERckx
 SAm4F/bkJ09V1HH/FTNtJA8oASsnuq10LKB06Ppd9h62R4lDkxZ7tNkAl28S8G7d1xDa2gT
 PEXCP0VLlx0QkawtWhcZoi8H1XuAjMvnX8hezzTVVlLxF610lL3AKcij0xDDtEUQc3CEQD5
 TPaOdVoD/Z3rLf531MyNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j43Dhi4OnSQ=;pPrxw8z5Z4FEOj+UReFM/WLv3ek
 k6EI90zHjv/ditfhTm1P/su83Jle+PE4sZ7Lx6qEXFzY78U1w1eMYlyGhcfsZB6jypXExVms+
 76yu/2CQbnaBGURh5AqnhVL0W5LNuVg3SCqEqmwEpT1f78wy/gE+Ua0GhgrwcJmPI0Fz4q6+g
 s62KzQPu9E+VpL71TnsTc3O9Dh0+Xry6CJ9XTKwjUKOQelF4PYEsSUMZohaj4d/QTbG792rxl
 IMcjeR2edJf6+0WBVTvV9+A6CjAcebV1geldeonaBXafMoqcIX/kLQN/gMcHzYf11yon30CAp
 9QNAkGha2hTjeflxyp1Lc7RmneqlCMqfzPnOnWNaRhc2HEKkALshPORCdi5LfKrW7Eb/n4LpH
 bLos1d4MkOevwZdAEAow8IgSVtUBJc4mikMx5qBqAvIeNLVrtz6JXxbKEsLCmJOTQOnUY+7Dl
 RrxSiwAe9Ao92e4Dbvjfq4Eq8XfVTTXdPYWfO9bkGNEfivYy5ikAx5d66bBROe/Ye10KRGJrI
 lB9BEqzGzNnYMkLCr5koPsZ9SxDZZ81O2Z0vtnXfiWV5aoWKza9pvEFr7nV1RYa6AhshaIJx0
 Sg+tOFV14AHZbvXPOP0iEHylDFUzgQazFjY3KrgrXKJT4GOQ1pBeTIL+kwd4DAW3XJpwmFpRZ
 BjyysaA3KoB9HMaZimk8rUkA1BcX7hAsALT5vMPBCdA4+xK/h5HQro6rDN69bG+B3svBRP69x
 TAxyj0bsRQRYyQRUdrnPuw2zoKXwJ1bKs9r7iQ71sjv71rPV2iPvEhxi4yvIIQ4GjCZ9NIHHi
 CX8ET7k+SxYqW5XUAxgevSkHq4WkKo6FDcVdDOr4qRuBaqMc96aWnEy+AuAdNdfTSyobjcGhA
 kBsM0Ibdeh41xDiLtH6LmnZFo1q6DgERNPleqUu0FMKzCwv8L0+jigsl3/YiJnvoypZDjZXRs
 mp4DTjKNYWNfeDeAQuozuCGcgCjVKJyFAG1jOubRkdR7zOm9OI7BHiiiz9A2uzRRDpWEnW8ZJ
 I+TXC3yuSUUEm0QOmSiuq5vBivlC2KbgtsyHb4khp0T7hKpkoQwhZbKyORm5Qio8IqtBpKuEZ
 UNywojc++myXwgvG04BQLg3OgntgZJNSFYBjqFik4BwsuGcSznz2WnCqf9bDvh2CZAc9RFF2m
 oHfaWAC+rJEoD+R75ZTXQyeZ75MghygvChAXxUErFC+Urk8BJisnX06lhpiAsCiDby3Yxwg2g
 gXC2pYxps1I0LFEx4yyHNS5Rv8VNhBOPlTeoyURtbV8xstMleh4aLAIuCxIe3vWQE+Soyky3G
 IAIWybSFUZp0hYylQErLGq0xrKjpnyWyt70jxvOIWr2GOaOkjVXChD4wIkAz0khYu4ZISW6JX
 jOAZRZyYonk2iodQ==


--k65zb2ld7znvcohp
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="lzlqbxrg6pxvnqvz"
Content-Disposition: inline
Subject: [REGRESSION][BISECTED][STABLE] MT7925 wifi throughput halved with
 6.13.2
MIME-Version: 1.0


--lzlqbxrg6pxvnqvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everyone,

on the Arch Linux Bugtracker[1] Benjamin (also added in CC) reported
that his MT7925 wifi card has halved it's throughput when updating from
the v6.13.1 to the v6.13.2 stable kernel. The problem is still present
in the 6.13.5 stable kernel.

We have bisected this issue together and found the backporting of the
following commit responsible for this issue:

    4cf9f08632c0 ("wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO")

We unfortunately didn't have a chance to test the mainline releases as
the reporter uses the (out of tree) nvidia modules that were not
compatible with mainline release at the time of testing. We will soon
test against Mainline aswell.

I have attached dmesg outputs of a good and a bad boot aswell as his
other hardware specs and will be available to debug this further.

Cheers,
Christian

[1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/112

--lzlqbxrg6pxvnqvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inxi.txt"

System:
  Host: arch-desktop Kernel: 6.13.1-arch2-2 arch: x86_64 bits: 64
  Desktop: KDE Plasma v: 6.3.0 Distro: Arch Linux
Machine:
  Type: Desktop Mobo: Gigabyte model: X870E AORUS ELITE WIFI7
    serial: <superuser required> UEFI: American Megatrends LLC. v: F3i
    date: 12/19/2024
CPU:
  Info: 8-core model: AMD Ryzen 7 9800X3D bits: 64 type: MT MCP cache:
    L2: 8 MiB
  Speed (MHz): avg: 2983 min/max: 600/5269 cores: 1: 2983 2: 2983 3: 2983
    4: 2983 5: 2983 6: 2983 7: 2983 8: 2983 9: 2983 10: 2983 11: 2983 12: 2983
    13: 2983 14: 2983 15: 2983 16: 2983
Graphics:
  Device-1: NVIDIA GA102 [GeForce RTX 3090] driver: nvidia v: 565.77
  Device-2: Advanced Micro Devices [AMD/ATI] Granite Ridge [Radeon Graphics]
    driver: amdgpu v: kernel
  Device-3: Insta360 Link driver: snd-usb-audio,uvcvideo type: USB
  Display: wayland server: X.org v: 1.21.1.15 with: Xwayland v: 24.1.5
    compositor: kwin_wayland driver: X: loaded: nvidia unloaded: modesetting
    gpu: nvidia,nvidia-nvswitch resolution: 3840x2160~120Hz
  API: EGL v: 1.5 drivers: nvidia
    platforms: gbm,wayland,x11,surfaceless,device
  API: OpenGL v: 4.6.0 vendor: nvidia v: 565.77 renderer: NVIDIA GeForce
    RTX 3090/PCIe/SSE2
  API: Vulkan v: 1.4.303 drivers: N/A surfaces: xcb,xlib,wayland
  Info: Tools: api: clinfo, eglinfo, glxinfo, vulkaninfo
    de: kscreen-console,kscreen-doctor gpu: nvidia-smi wl: wayland-info
    x11: xdpyinfo, xprop, xrandr
Audio:
  Device-1: NVIDIA GA102 High Definition Audio driver: snd_hda_intel
  Device-2: Advanced Micro Devices [AMD/ATI] Rembrandt Radeon High
    Definition Audio driver: snd_hda_intel
  Device-3: Advanced Micro Devices [AMD] Family 17h/19h/1ah HD Audio
    driver: snd_hda_intel
  Device-4: SteelSeries ApS Arctis Nova 7
    driver: hid-generic,snd-usb-audio,usbhid type: USB
  Device-5: Audio-Technica ATR USB microphone
    driver: hid-generic,snd-usb-audio,usbhid type: USB
  Device-6: Insta360 Link driver: snd-usb-audio,uvcvideo type: USB
  API: ALSA v: k6.13.1-arch2-2 status: kernel-api
  Server-1: PipeWire v: 1.2.7 status: active
Network:
  Device-1: MEDIATEK driver: mt7925e
  IF: wlan0 state: up mac: 44:fa:66:66:57:a9
  Device-2: Realtek RTL8125 2.5GbE driver: r8169
  IF: enp14s0 state: down mac: 10:ff:e0:6a:b0:50
Bluetooth:
  Device-1: Foxconn / Hon Hai Wireless_Device driver: btusb type: USB
  Report: rfkill ID: hci0 state: up address: see --recommends
Drives:
  Local Storage: total: 8.15 TiB used: 2.33 TiB (28.6%)
  ID-1: /dev/nvme0n1 vendor: Samsung model: SSD 990 PRO 4TB size: 3.64 TiB
  ID-2: /dev/sda vendor: Western Digital model: WDS400T2B0A-00SM50
    size: 3.64 TiB
  ID-3: /dev/sdb vendor: SanDisk model: SDSSDHII960G size: 894.25 GiB
Partition:
  ID-1: / size: 3.61 TiB used: 1.34 TiB (37.1%) fs: btrfs dev: /dev/nvme0n1p2
  ID-2: /home size: 3.61 TiB used: 1.34 TiB (37.1%) fs: btrfs
    dev: /dev/nvme0n1p2
  ID-3: /var/log size: 3.61 TiB used: 1.34 TiB (37.1%) fs: btrfs
    dev: /dev/nvme0n1p2
Swap:
  ID-1: swap-1 type: partition size: 32 GiB used: 0 KiB (0.0%)
    dev: /dev/nvme0n1p3
Sensors:
  System Temperatures: cpu: 39.6 C mobo: 45.0 C gpu: amdgpu temp: 36.0 C
  Fan Speeds (rpm): N/A
Info:
  Memory: total: 60 GiB note: est. available: 60.44 GiB used: 5.44 GiB (9.0%)
  Processes: 452 Uptime: 12m Shell: Bash inxi: 3.3.37

--lzlqbxrg6pxvnqvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_slow_wifi.txt"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.13.1-1-00200-g4cf9f08632c0 (linux@archlinux)=
 (gcc (GCC) 14.2.1 20250207, GNU ld (GNU Binutils) 2.44) #1 SMP PREEMPT_DYN=
AMIC Wed, 12 Feb 2025 15:53:57 +0000
[    0.000000] Command line: BOOT_IMAGE=3D/@/boot/vmlinuz-linux root=3DUUID=
=3D04de5227-e261-4049-9f7b-6c95c0e36ef9 rw rootflags=3Dsubvol=3D@ nvidia.NV=
reg_EnableGpuFirmware=3D0
[    0.000000] x86/split lock detection: #DB: warning on user-space bus_loc=
ks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009afefff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009aff000-0x0000000009ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a21dfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000000a21e000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b020fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000000b021000-0x0000000088211fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000088212000-0x000000008e211fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000008e212000-0x000000008e47efff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000008e47f000-0x000000009047efff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000009047f000-0x00000000985fefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000985ff000-0x0000000099ff6fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000099ff7000-0x0000000099ffbfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000099ffc000-0x0000000099ffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000009a000000-0x000000009bffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000009d7f3000-0x000000009fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f7000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000fdde7ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000fdeec0000-0x00000010801fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x82042018-0x82068457] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x82033018-0x82041057] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x82028018-0x82032e57] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009afef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009aff000-0x0000000009ffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000a000000-0x000000000a1fff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000a200000-0x000000000a21df=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000000a21e000-0x000000000affff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000b000000-0x000000000b020f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000b021000-0x00000000820280=
17] usable
[    0.000000] reserve setup_data: [mem 0x0000000082028018-0x0000000082032e=
57] usable
[    0.000000] reserve setup_data: [mem 0x0000000082032e58-0x00000000820330=
17] usable
[    0.000000] reserve setup_data: [mem 0x0000000082033018-0x00000000820410=
57] usable
[    0.000000] reserve setup_data: [mem 0x0000000082041058-0x00000000820420=
17] usable
[    0.000000] reserve setup_data: [mem 0x0000000082042018-0x00000000820684=
57] usable
[    0.000000] reserve setup_data: [mem 0x0000000082068458-0x0000000088211f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000088212000-0x000000008e211f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008e212000-0x000000008e47ef=
ff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000008e47f000-0x000000009047ef=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000009047f000-0x00000000985fef=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000985ff000-0x0000000099ff6f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000099ff7000-0x0000000099ffbf=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000099ffc000-0x0000000099ffff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000009a000000-0x000000009bffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009d7f3000-0x000000009fffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f7000000-0x00000000ffffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x0000000fdde7ff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000fdeec0000-0x00000010801fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000fd00000000-0x000000ffffffff=
ff] reserved
[    0.000000] efi: EFI v2.9 by American Megatrends
[    0.000000] efi: ACPI=3D0x90466000 ACPI 2.0=3D0x90466014 TPMFinalLog=3D0=
x90432000 SMBIOS=3D0x97ada000 SMBIOS 3.0=3D0x97ad9000 MEMATTR=3D0x844c5318 =
ESRT=3D0x84509c18 INITRD=3D0x810fe518 RNG=3D0x8e28d018 TPMEventLog=3D0x8e28=
6018=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem240: MMIO range=3D[0xe0000000-0xefffffff] (25=
6MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
[    0.000000] efi: Remove mem241: MMIO range=3D[0xf7000000-0xfedfffff] (12=
6MB) from e820 map
[    0.000000] e820: remove [mem 0xf7000000-0xfedfffff] reserved
[    0.000000] efi: Not removing mem242: MMIO range=3D[0xfee00000-0xfee00ff=
f] (4KB) from e820 map
[    0.000000] efi: Remove mem243: MMIO range=3D[0xfee01000-0xffffffff] (17=
MB) from e820 map
[    0.000000] e820: remove [mem 0xfee01000-0xffffffff] reserved
[    0.000000] efi: Remove mem245: MMIO range=3D[0x1060000000-0x10801fffff]=
 (514MB) from e820 map
[    0.000000] e820: remove [mem 0x1060000000-0x10801fffff] reserved
[    0.000000] SMBIOS 3.7.0 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. X870E AORUS ELITE WIFI7/X=
870E AORUS ELITE WIFI7, BIOS F3i 12/19/2024
[    0.000000] DMI: Memory slots populated: 2/4
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 4691.451 MHz processor
[    0.000110] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000111] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000116] last_pfn =3D 0xfdde80 max_arch_pfn =3D 0x400000000
[    0.000122] MTRR map: 5 entries (3 fixed + 2 variable; max 20), built fr=
om 9 variable MTRRs
[    0.000123] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000287] e820: update [mem 0xa0000000-0xffffffff] usable =3D=3D> rese=
rved
[    0.000291] last_pfn =3D 0x9a000 max_arch_pfn =3D 0x400000000
[    0.003209] esrt: Reserving ESRT space from 0x0000000084509c18 to 0x0000=
000084509c50.
[    0.003216] e820: update [mem 0x84509000-0x84509fff] usable =3D=3D> rese=
rved
[    0.003232] Using GB pages for direct mapping
[    0.003551] Secure boot enabled
[    0.003552] RAMDISK: [mem 0x73b2d000-0x79261fff]
[    0.003680] ACPI: Early table checksum verification disabled
[    0.003683] ACPI: RSDP 0x0000000090466014 000024 (v02 ALASKA)
[    0.003685] ACPI: XSDT 0x0000000090465728 00010C (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.003689] ACPI: FACP 0x000000008E467000 000114 (v06 ALASKA A M I    01=
072009 AMI  00010013)
[    0.003693] ACPI: DSDT 0x000000008E3EA000 07309A (v203 ALASKA A M I    0=
1072009 INTL 20230628)
[    0.003694] ACPI: FACS 0x0000000090462000 000040
[    0.003696] ACPI: HWIN 0x000000008E47E000 00006C (v00 GBT    AMD      00=
050000 AMI  01000013)
[    0.003697] ACPI: SSDT 0x000000008E472000 00B9E4 (v02 GBT    GSWApp   00=
000001 INTL 20230628)
[    0.003698] ACPI: SSDT 0x000000008E469000 00816C (v02 AMD    Splinter 00=
000002 MSFT 05000000)
[    0.003699] ACPI: SSDT 0x000000008E468000 000221 (v02 ALASKA CPUSSDT  01=
072009 AMI  01072009)
[    0.003701] ACPI: FIDT 0x000000008E461000 00009C (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.003702] ACPI: MCFG 0x000000008E460000 00003C (v01 ALASKA A M I    01=
072009 MSFT 00010013)
[    0.003703] ACPI: HPET 0x000000008E45F000 000038 (v01 ALASKA A M I    01=
072009 AMI  00000005)
[    0.003704] ACPI: FPDT 0x000000008E45E000 000044 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.003705] ACPI: VFCT 0x000000008E3DF000 00AE84 (v01 ALASKA A M I    00=
000001 AMD  33504F47)
[    0.003706] ACPI: BGRT 0x000000008E466000 000038 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.003707] ACPI: SSDT 0x000000008E3DA000 004DEE (v02 AMD    AMD CPU  00=
000001 AMD  00000001)
[    0.003709] ACPI: TPM2 0x000000008E465000 00004C (v04 ALASKA A M I    00=
000001 AMI  00000000)
[    0.003710] ACPI: WPBT 0x000000008E464000 000034 (v01 ALASKA A M I    00=
000001 GBT  24112800)
[    0.003711] ACPI: SSDT 0x000000008E2A9000 00D214 (v02 AMD    DISCUSB4 00=
000002 INTL 20230628)
[    0.003712] ACPI: SSDT 0x000000008E463000 0006D4 (v02 AMD    CPMWLRC  00=
000001 INTL 20230628)
[    0.003713] ACPI: SSDT 0x000000008E2A7000 00169E (v02 AMD    CPMDFIG2 00=
000001 INTL 20230628)
[    0.003714] ACPI: SSDT 0x000000008E2A4000 002AA6 (v02 AMD    CDFAAIG2 00=
000001 INTL 20230628)
[    0.003715] ACPI: SSDT 0x000000008E462000 00078F (v02 AMD    CPMDFDG1 00=
000001 INTL 20230628)
[    0.003716] ACPI: SSDT 0x000000008E29A000 0097C3 (v02 AMD    CPMCMN   00=
000001 INTL 20230628)
[    0.003717] ACPI: SSDT 0x000000008E297000 0029D1 (v02 AMD    AOD      00=
000001 INTL 20230628)
[    0.003719] ACPI: WSMT 0x000000008E296000 000028 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.003720] ACPI: APIC 0x000000008E295000 00015E (v06 ALASKA A M I    01=
072009 AMI  00010013)
[    0.003721] ACPI: IVRS 0x000000008E294000 0000C8 (v02 AMD    AmdTable 00=
000001 AMD  00000001)
[    0.003722] ACPI: SSDT 0x000000008E293000 000500 (v02 AMD    MEMTOOL0 00=
000002 INTL 20230628)
[    0.003723] ACPI: SSDT 0x000000008E292000 0009D0 (v02 AMD    CPMMSOSC 00=
000001 INTL 20230628)
[    0.003724] ACPI: SSDT 0x000000008E291000 00047C (v02 AMD    AMDWOV   00=
000001 INTL 20230628)
[    0.003725] ACPI: SSDT 0x000000008E28F000 001046 (v02 AMD    CPMACPV4 00=
000001 INTL 20230628)
[    0.003726] ACPI: SSDT 0x000000008E28E000 00053E (v01 AMD    CPMAPMFD 00=
000001 INTL 20230628)
[    0.003727] ACPI: Reserving FACP table memory at [mem 0x8e467000-0x8e467=
113]
[    0.003728] ACPI: Reserving DSDT table memory at [mem 0x8e3ea000-0x8e45d=
099]
[    0.003728] ACPI: Reserving FACS table memory at [mem 0x90462000-0x90462=
03f]
[    0.003728] ACPI: Reserving HWIN table memory at [mem 0x8e47e000-0x8e47e=
06b]
[    0.003729] ACPI: Reserving SSDT table memory at [mem 0x8e472000-0x8e47d=
9e3]
[    0.003729] ACPI: Reserving SSDT table memory at [mem 0x8e469000-0x8e471=
16b]
[    0.003729] ACPI: Reserving SSDT table memory at [mem 0x8e468000-0x8e468=
220]
[    0.003729] ACPI: Reserving FIDT table memory at [mem 0x8e461000-0x8e461=
09b]
[    0.003730] ACPI: Reserving MCFG table memory at [mem 0x8e460000-0x8e460=
03b]
[    0.003730] ACPI: Reserving HPET table memory at [mem 0x8e45f000-0x8e45f=
037]
[    0.003730] ACPI: Reserving FPDT table memory at [mem 0x8e45e000-0x8e45e=
043]
[    0.003730] ACPI: Reserving VFCT table memory at [mem 0x8e3df000-0x8e3e9=
e83]
[    0.003731] ACPI: Reserving BGRT table memory at [mem 0x8e466000-0x8e466=
037]
[    0.003731] ACPI: Reserving SSDT table memory at [mem 0x8e3da000-0x8e3de=
ded]
[    0.003731] ACPI: Reserving TPM2 table memory at [mem 0x8e465000-0x8e465=
04b]
[    0.003732] ACPI: Reserving WPBT table memory at [mem 0x8e464000-0x8e464=
033]
[    0.003732] ACPI: Reserving SSDT table memory at [mem 0x8e2a9000-0x8e2b6=
213]
[    0.003732] ACPI: Reserving SSDT table memory at [mem 0x8e463000-0x8e463=
6d3]
[    0.003732] ACPI: Reserving SSDT table memory at [mem 0x8e2a7000-0x8e2a8=
69d]
[    0.003733] ACPI: Reserving SSDT table memory at [mem 0x8e2a4000-0x8e2a6=
aa5]
[    0.003733] ACPI: Reserving SSDT table memory at [mem 0x8e462000-0x8e462=
78e]
[    0.003733] ACPI: Reserving SSDT table memory at [mem 0x8e29a000-0x8e2a3=
7c2]
[    0.003733] ACPI: Reserving SSDT table memory at [mem 0x8e297000-0x8e299=
9d0]
[    0.003734] ACPI: Reserving WSMT table memory at [mem 0x8e296000-0x8e296=
027]
[    0.003734] ACPI: Reserving APIC table memory at [mem 0x8e295000-0x8e295=
15d]
[    0.003734] ACPI: Reserving IVRS table memory at [mem 0x8e294000-0x8e294=
0c7]
[    0.003734] ACPI: Reserving SSDT table memory at [mem 0x8e293000-0x8e293=
4ff]
[    0.003735] ACPI: Reserving SSDT table memory at [mem 0x8e292000-0x8e292=
9cf]
[    0.003735] ACPI: Reserving SSDT table memory at [mem 0x8e291000-0x8e291=
47b]
[    0.003735] ACPI: Reserving SSDT table memory at [mem 0x8e28f000-0x8e290=
045]
[    0.003735] ACPI: Reserving SSDT table memory at [mem 0x8e28e000-0x8e28e=
53d]
[    0.003775] No NUMA configuration found
[    0.003776] Faking a node at [mem 0x0000000000000000-0x0000000fdde7ffff]
[    0.003778] NODE_DATA(0) allocated [mem 0xfdde7bec0-0xfdde7ffff]
[    0.003811] Zone ranges:
[    0.003812]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.003812]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.003813]   Normal   [mem 0x0000000100000000-0x0000000fdde7ffff]
[    0.003814]   Device   empty
[    0.003814] Movable zone start for each node
[    0.003815] Early memory node ranges
[    0.003815]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.003815]   node   0: [mem 0x0000000000100000-0x0000000009afefff]
[    0.003816]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.003816]   node   0: [mem 0x000000000a21e000-0x000000000affffff]
[    0.003816]   node   0: [mem 0x000000000b021000-0x0000000088211fff]
[    0.003817]   node   0: [mem 0x00000000985ff000-0x0000000099ff6fff]
[    0.003817]   node   0: [mem 0x0000000099ffc000-0x0000000099ffffff]
[    0.003817]   node   0: [mem 0x0000000100000000-0x0000000fdde7ffff]
[    0.003820] Initmem setup node 0 [mem 0x0000000000001000-0x0000000fdde7f=
fff]
[    0.003823] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.003830] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.003880] On node 0, zone DMA32: 1281 pages in unavailable ranges
[    0.003885] On node 0, zone DMA32: 30 pages in unavailable ranges
[    0.004543] On node 0, zone DMA32: 33 pages in unavailable ranges
[    0.004646] On node 0, zone DMA32: 33773 pages in unavailable ranges
[    0.004647] On node 0, zone DMA32: 5 pages in unavailable ranges
[    0.040542] On node 0, zone Normal: 24576 pages in unavailable ranges
[    0.040569] On node 0, zone Normal: 8576 pages in unavailable ranges
[    0.041357] ACPI: PM-Timer IO Port: 0x808
[    0.041364] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.041374] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0=
-23
[    0.041377] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 2=
4-55
[    0.041378] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.041379] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.041381] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.041382] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.041390] e820: update [mem 0x8405e000-0x840b4fff] usable =3D=3D> rese=
rved
[    0.041400] CPU topo: Max. logical packages:   1
[    0.041401] CPU topo: Max. logical dies:       1
[    0.041401] CPU topo: Max. dies per package:   1
[    0.041403] CPU topo: Max. threads per core:   2
[    0.041403] CPU topo: Num. cores per package:     8
[    0.041404] CPU topo: Num. threads per package:  16
[    0.041404] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    0.041415] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.041416] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000fffff]
[    0.041416] PM: hibernation: Registered nosave memory: [mem 0x09aff000-0=
x09ffffff]
[    0.041417] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0=
x0a21dfff]
[    0.041418] PM: hibernation: Registered nosave memory: [mem 0x0b000000-0=
x0b020fff]
[    0.041418] PM: hibernation: Registered nosave memory: [mem 0x82028000-0=
x82028fff]
[    0.041419] PM: hibernation: Registered nosave memory: [mem 0x82032000-0=
x82032fff]
[    0.041419] PM: hibernation: Registered nosave memory: [mem 0x82033000-0=
x82033fff]
[    0.041419] PM: hibernation: Registered nosave memory: [mem 0x82041000-0=
x82041fff]
[    0.041420] PM: hibernation: Registered nosave memory: [mem 0x82042000-0=
x82042fff]
[    0.041420] PM: hibernation: Registered nosave memory: [mem 0x82068000-0=
x82068fff]
[    0.041421] PM: hibernation: Registered nosave memory: [mem 0x8405e000-0=
x840b4fff]
[    0.041421] PM: hibernation: Registered nosave memory: [mem 0x84509000-0=
x84509fff]
[    0.041422] PM: hibernation: Registered nosave memory: [mem 0x88212000-0=
x8e211fff]
[    0.041422] PM: hibernation: Registered nosave memory: [mem 0x8e212000-0=
x8e47efff]
[    0.041422] PM: hibernation: Registered nosave memory: [mem 0x8e47f000-0=
x9047efff]
[    0.041422] PM: hibernation: Registered nosave memory: [mem 0x9047f000-0=
x985fefff]
[    0.041423] PM: hibernation: Registered nosave memory: [mem 0x99ff7000-0=
x99ffbfff]
[    0.041423] PM: hibernation: Registered nosave memory: [mem 0x9a000000-0=
x9bffffff]
[    0.041424] PM: hibernation: Registered nosave memory: [mem 0x9c000000-0=
x9d7f2fff]
[    0.041424] PM: hibernation: Registered nosave memory: [mem 0x9d7f3000-0=
x9fffffff]
[    0.041424] PM: hibernation: Registered nosave memory: [mem 0xa0000000-0=
xfedfffff]
[    0.041424] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.041424] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.041425] [mem 0xa0000000-0xfedfffff] available for PCI devices
[    0.041426] Booting paravirtualized kernel on bare hardware
[    0.041428] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.044523] setup_percpu: NR_CPUS:320 nr_cpumask_bits:16 nr_cpu_ids:16 n=
r_node_ids:1
[    0.044905] percpu: Embedded 67 pages/cpu s237568 r8192 d28672 u524288
[    0.044908] pcpu-alloc: s237568 r8192 d28672 u524288 alloc=3D1*2097152
[    0.044909] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07=20
[    0.044911] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15=20
[    0.044919] Kernel command line: BOOT_IMAGE=3D/@/boot/vmlinuz-linux root=
=3DUUID=3D04de5227-e261-4049-9f7b-6c95c0e36ef9 rw rootflags=3Dsubvol=3D@ nv=
idia.NVreg_EnableGpuFirmware=3D0
[    0.044950] Unknown kernel command line parameters "BOOT_IMAGE=3D/@/boot=
/vmlinuz-linux", will be passed to user space.
[    0.045148] printk: log buffer data + meta data: 131072 + 458752 =3D 589=
824 bytes
[    0.047570] Dentry cache hash table entries: 8388608 (order: 14, 6710886=
4 bytes, linear)
[    0.048689] Inode-cache hash table entries: 4194304 (order: 13, 33554432=
 bytes, linear)
[    0.048741] Fallback order for Node 0: 0=20
[    0.048744] Built 1 zonelists, mobility grouping on.  Total pages: 16151=
789
[    0.048744] Policy zone: Normal
[    0.048823] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.048852] software IO TLB: area num 16.
[    0.103210] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, =
Nodes=3D1
[    0.103236] ftrace: allocating 51152 entries in 200 pages
[    0.121531] ftrace: allocated 200 pages with 3 groups
[    0.121569] Dynamic Preempt: full
[    0.121602] rcu: Preemptible hierarchical RCU implementation.
[    0.121603] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D16.
[    0.121603] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.121604] 	Trampoline variant of Tasks RCU enabled.
[    0.121604] 	Rude variant of Tasks RCU enabled.
[    0.121604] 	Tracing variant of Tasks RCU enabled.
[    0.121605] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.121605] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D16
[    0.121611] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D16.
[    0.121612] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.121613] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.123687] NR_IRQS: 20736, nr_irqs: 1096, preallocated irqs: 16
[    0.123860] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.123998] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.124017] Console: colour dummy device 80x25
[    0.124018] printk: legacy console [tty0] enabled
[    0.124043] ACPI: Core revision 20240827
[    0.124254] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.124265] APIC: Switch to symmetric I/O mode setup
[    0.124661] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
[    0.125420] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.140936] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x439fe184c33, max_idle_ns: 440795389281 ns
[    0.140938] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 9386.85 BogoMIPS (lpj=3D15638170)
[    0.140950] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.141009] LVT offset 1 assigned for vector 0xf9
[    0.141218] LVT offset 2 assigned for vector 0xf4
[    0.141281] Last level iTLB entries: 4KB 64, 2MB 64, 4MB 32
[    0.141282] Last level dTLB entries: 4KB 128, 2MB 128, 4MB 64, 1GB 0
[    0.141283] process: using mwait in idle threads
[    0.141284] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.141286] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.141286] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.141288] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.141288] Spectre V2 : User space: Mitigation: STIBP always-on protect=
ion
[    0.141289] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.141293] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.141294] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.141295] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.141295] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.141296] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.141296] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.141297] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.141297] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User =
registers'
[    0.141298] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.141299] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.141299] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.141300] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.141300] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.141301] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.141302] x86/fpu: Enabled xstate features 0xae7, context size is 2456=
 bytes, using 'compacted' format.
[    0.155013] Freeing SMP alternatives memory: 40K
[    0.155014] pid_max: default: 32768 minimum: 301
[    0.156580] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.156619] landlock: Up and running.
[    0.156621] Yama: becoming mindful.
[    0.156730] LSM support for eBPF active
[    0.156773] Mount-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)
[    0.156815] Mountpoint-cache hash table entries: 131072 (order: 8, 10485=
76 bytes, linear)
[    0.263727] smpboot: CPU0: AMD Ryzen 7 9800X3D 8-Core Processor (family:=
 0x1a, model: 0x44, stepping: 0x0)
[    0.263805] Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD P=
MU driver.
[    0.263822] ... version:                2
[    0.263822] ... bit width:              48
[    0.263823] ... generic registers:      6
[    0.263823] ... value mask:             0000ffffffffffff
[    0.263823] ... max period:             00007fffffffffff
[    0.263824] ... fixed-purpose events:   0
[    0.263824] ... event mask:             000000000000003f
[    0.263876] signal: max sigframe size: 3376
[    0.263890] rcu: Hierarchical SRCU implementation.
[    0.263890] rcu: 	Max phase no-delay instances is 1000.
[    0.263909] Timer migration: 2 hierarchy levels; 8 children per group; 2=
 crossnode level
[    0.264002] MCE: In-kernel MCE decoding enabled.
[    0.264019] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.264055] smp: Bringing up secondary CPUs ...
[    0.264091] smpboot: x86: Booting SMP configuration:
[    0.264091] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  =
#9 #10 #11 #12 #13 #14 #15
[    0.264958] Spectre V2 : Update user space SMT mitigation: STIBP always-=
on
[    0.264958] smp: Brought up 1 node, 16 CPUs
[    0.264958] smpboot: Total of 16 processors activated (150186.70 BogoMIP=
S)
[    0.265418] Memory: 63264164K/64607156K available (18432K kernel code, 2=
268K rwdata, 14108K rodata, 3564K init, 3112K bss, 1322912K reserved, 0K cm=
a-reserved)
[    0.267681] devtmpfs: initialized
[    0.267681] x86/mm: Memory block size: 128MB
[    0.269044] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a21=
dfff] (122880 bytes)
[    0.269044] ACPI: PM: Registering ACPI NVS region [mem 0x8e47f000-0x9047=
efff] (33554432 bytes)
[    0.269044] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.269044] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.269044] pinctrl core: initialized pinctrl subsystem
[    0.269044] PM: RTC time: 16:38:51, date: 2025-02-12
[    0.269044] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.269044] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.269044] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.269044] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.269044] audit: initializing netlink subsys (disabled)
[    0.269044] audit: type=3D2000 audit(1739378331.000:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.269044] thermal_sys: Registered thermal governor 'fair_share'
[    0.269044] thermal_sys: Registered thermal governor 'bang_bang'
[    0.269044] thermal_sys: Registered thermal governor 'step_wise'
[    0.269044] thermal_sys: Registered thermal governor 'user_space'
[    0.269044] thermal_sys: Registered thermal governor 'power_allocator'
[    0.269044] cpuidle: using governor ladder
[    0.269044] cpuidle: using governor menu
[    0.269044] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.269044] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for =
domain 0000 [bus 00-ff]
[    0.269044] PCI: Using configuration type 1 for base access
[    0.269044] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.271202] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.271202] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.271202] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.271202] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.271202] ACPI: Added _OSI(Module Device)
[    0.271202] ACPI: Added _OSI(Processor Device)
[    0.271202] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.271202] ACPI: Added _OSI(Processor Aggregator Device)
[    0.279641] ACPI: 17 ACPI AML tables successfully acquired and loaded
[    0.316261] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomai=
n+
[    0.316263] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomai=
n+
[    0.316638] ACPI: Interpreter enabled
[    0.316646] ACPI: PM: (supports S0 S3 S4 S5)
[    0.316647] ACPI: Using IOAPIC for interrupt routing
[    0.351824] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.351825] PCI: Ignoring E820 reservations for host bridge windows
[    0.351980] ACPI: Enabled 11 GPEs in block 00 to 1F
[    0.352748] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resource
[    0.353280] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resource
[    0.354271] ACPI: \_SB_.PCI0.GP19.XHC2.P0U2: New power resource
[    0.354332] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    0.354436] ACPI: \_SB_.PCI0.GPP1.P0NV: New power resource
[    0.354736] ACPI: \_SB_.PCI0.GPP7.PWRS: New power resource
[    0.354847] ACPI: \_SB_.PCI0.GPP7.UP00.PWRS: New power resource
[    0.354948] ACPI: \_SB_.PCI0.GPP7.UP00.DP00.PWRS: New power resource
[    0.355096] ACPI: \_SB_.PCI0.GPP7.UP00.DP00.NV00.PWRS: New power resource
[    0.355182] ACPI: \_SB_.PCI0.GPP7.UP00.DP08.PWRS: New power resource
[    0.355248] ACPI: \_SB_.PCI0.GPP7.UP00.DP08.EP00.PWRS: New power resource
[    0.355326] ACPI: \_SB_.PCI0.GPP7.UP00.DP10.PWRS: New power resource
[    0.355392] ACPI: \_SB_.PCI0.GPP7.UP00.DP10.WN00.PWRS: New power resource
[    0.355470] ACPI: \_SB_.PCI0.GPP7.UP00.DP18.PWRS: New power resource
[    0.355535] ACPI: \_SB_.PCI0.GPP7.UP00.DP18.LN00.PWRS: New power resource
[    0.355615] ACPI: \_SB_.PCI0.GPP7.UP00.DP20.PWRS: New power resource
[    0.355760] ACPI: \_SB_.PCI0.GPP7.UP00.DP20.NV00.PWRS: New power resource
[    0.355847] ACPI: \_SB_.PCI0.GPP7.UP00.DP28.PWRS: New power resource
[    0.355993] ACPI: \_SB_.PCI0.GPP7.UP00.DP28.EP00.PWRS: New power resource
[    0.356079] ACPI: \_SB_.PCI0.GPP7.UP00.DP30.PWRS: New power resource
[    0.356222] ACPI: \_SB_.PCI0.GPP7.UP00.DP30.EP00.PWRS: New power resource
[    0.356308] ACPI: \_SB_.PCI0.GPP7.UP00.DP38.PWRS: New power resource
[    0.356451] ACPI: \_SB_.PCI0.GPP7.UP00.DP38.EP00.PWRS: New power resource
[    0.356537] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.PWRS: New power resource
[    0.356638] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.PWRS: New power resource
[    0.356740] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP00.PWRS: New power re=
source
[    0.356888] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP00.NV00.PWRS: New pow=
er resource
[    0.356975] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP08.PWRS: New power re=
source
[    0.357042] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP08.EP00.PWRS: New pow=
er resource
[    0.357120] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP10.PWRS: New power re=
source
[    0.357220] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP10.WN00.PWRS: New pow=
er resource
[    0.357325] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP18.PWRS: New power re=
source
[    0.357425] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP18.LN00.PWRS: New pow=
er resource
[    0.357526] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP20.PWRS: New power re=
source
[    0.357675] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP20.NV00.PWRS: New pow=
er resource
[    0.357763] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP28.PWRS: New power re=
source
[    0.357829] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP28.EP00.PWRS: New pow=
er resource
[    0.357908] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP30.PWRS: New power re=
source
[    0.357974] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP30.EP00.PWRS: New pow=
er resource
[    0.358054] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP38.PWRS: New power re=
source
[    0.358121] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP38.EP00.PWRS: New pow=
er resource
[    0.358199] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP40.PWRS: New power re=
source
[    0.358345] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP40.EP00.PWRS: New pow=
er resource
[    0.358433] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP48.PWRS: New power re=
source
[    0.358499] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP48.EP00.PWRS: New pow=
er resource
[    0.358578] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP50.PWRS: New power re=
source
[    0.358644] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP50.EP00.PWRS: New pow=
er resource
[    0.358725] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP58.PWRS: New power re=
source
[    0.358791] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP58.EP00.PWRS: New pow=
er resource
[    0.358869] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP60.PWRS: New power re=
source
[    0.358969] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP60.XH00.PWRS: New pow=
er resource
[    0.359070] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP68.PWRS: New power re=
source
[    0.359170] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP68.SA00.PWRS: New pow=
er resource
[    0.359271] ACPI: \_SB_.PCI0.GPP7.UP00.DP48.PWRS: New power resource
[    0.359338] ACPI: \_SB_.PCI0.GPP7.UP00.DP48.EP00.PWRS: New power resource
[    0.359420] ACPI: \_SB_.PCI0.GPP7.UP00.DP50.PWRS: New power resource
[    0.359486] ACPI: \_SB_.PCI0.GPP7.UP00.DP50.EP00.PWRS: New power resource
[    0.359563] ACPI: \_SB_.PCI0.GPP7.UP00.DP58.PWRS: New power resource
[    0.359629] ACPI: \_SB_.PCI0.GPP7.UP00.DP58.EP00.PWRS: New power resource
[    0.359706] ACPI: \_SB_.PCI0.GPP7.UP00.DP60.PWRS: New power resource
[    0.359804] ACPI: \_SB_.PCI0.GPP7.UP00.DP60.XH00.PWRS: New power resource
[    0.361238] ACPI: \_SB_.PCI0.GPP7.UP00.DP68.PWRS: New power resource
[    0.361339] ACPI: \_SB_.PCI0.GPP7.UP00.DP68.SA00.PWRS: New power resource
[    0.361690] ACPI: \_SB_.PCI0.GPP8.PWRS: New power resource
[    0.366122] ACPI: \_SB_.PCI0.GPP8.U4UP.PWRS: New power resource
[    0.368730] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P0.PWRS: New power resource
[    0.371393] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P0.UP0D.PWRS: New power resource
[    0.371676] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P1.PWRS: New power resource
[    0.374233] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P1.UP1D.PWRS: New power resource
[    0.374428] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P2.PWRS: New power resource
[    0.376941] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P2.UXHC.PWRS: New power resource
[    0.379831] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P3.PWRS: New power resource
[    0.382344] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P3.UHI0.PWRS: New power resource
[    0.386161] ACPI: \_SB_.PRWL: New power resource
[    0.386169] ACPI: \_SB_.PRWB: New power resource
[    0.386426] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.386429] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.386478] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR DPC]
[    0.386733] PCI host bridge to bus 0000:00
[    0.386734] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.386736] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.386736] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.386736] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.386737] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dfff=
f window]
[    0.386738] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xdffffff=
f window]
[    0.386738] pci_bus 0000:00: root bus resource [mem 0x1060000000-0xfffff=
fffff window]
[    0.386739] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.386749] pci 0000:00:00.0: [1022:14d8] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.386810] pci 0000:00:00.2: [1022:14d9] type 00 class 0x080600 convent=
ional PCI endpoint
[    0.386860] pci 0000:00:01.0: [1022:14da] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.386898] pci 0000:00:01.1: [1022:14db] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.386910] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.386914] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.386916] pci 0000:00:01.1:   bridge window [mem 0xdd000000-0xde0fffff]
[    0.386920] pci 0000:00:01.1:   bridge window [mem 0xf000000000-0xf801ff=
ffff 64bit pref]
[    0.386970] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.387166] pci 0000:00:01.2: [1022:14db] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.387178] pci 0000:00:01.2: PCI bridge to [bus 02]
[    0.387182] pci 0000:00:01.2:   bridge window [mem 0xdf300000-0xdf3fffff]
[    0.387233] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.387316] pci 0000:00:02.0: [1022:14da] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.387353] pci 0000:00:02.1: [1022:14db] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.387365] pci 0000:00:02.1: PCI bridge to [bus 03-14]
[    0.387368] pci 0000:00:02.1:   bridge window [io  0xe000-0xefff]
[    0.387369] pci 0000:00:02.1:   bridge window [mem 0xde200000-0xdebfffff]
[    0.387379] pci 0000:00:02.1: enabling Extended Tags
[    0.387422] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.387557] pci 0000:00:02.2: [1022:14db] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.387569] pci 0000:00:02.2: PCI bridge to [bus 15-78]
[    0.387572] pci 0000:00:02.2:   bridge window [io  0x7000-0xcfff]
[    0.387573] pci 0000:00:02.2:   bridge window [mem 0xac000000-0xdc7fffff]
[    0.387578] pci 0000:00:02.2:   bridge window [mem 0xb000000000-0xefffff=
ffff 64bit pref]
[    0.387626] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.387718] pci 0000:00:03.0: [1022:14da] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.387760] pci 0000:00:04.0: [1022:14da] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.387804] pci 0000:00:08.0: [1022:14da] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.387844] pci 0000:00:08.1: [1022:14dd] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.387853] pci 0000:00:08.1: PCI bridge to [bus 79]
[    0.387855] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    0.387857] pci 0000:00:08.1:   bridge window [mem 0xdec00000-0xdf1fffff]
[    0.387860] pci 0000:00:08.1:   bridge window [mem 0xf810000000-0xf81fff=
ffff 64bit pref]
[    0.387864] pci 0000:00:08.1: enabling Extended Tags
[    0.387887] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.387947] pci 0000:00:08.3: [1022:14dd] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.387956] pci 0000:00:08.3: PCI bridge to [bus 7a]
[    0.387959] pci 0000:00:08.3:   bridge window [mem 0xdf200000-0xdf2fffff]
[    0.387966] pci 0000:00:08.3: enabling Extended Tags
[    0.387989] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.388052] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.388120] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.388194] pci 0000:00:18.0: [1022:14e0] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388213] pci 0000:00:18.1: [1022:14e1] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388230] pci 0000:00:18.2: [1022:14e2] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388248] pci 0000:00:18.3: [1022:14e3] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388265] pci 0000:00:18.4: [1022:14e4] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388282] pci 0000:00:18.5: [1022:14e5] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388299] pci 0000:00:18.6: [1022:14e6] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388316] pci 0000:00:18.7: [1022:14e7] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388378] pci 0000:01:00.0: [10de:2204] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.388385] pci 0000:01:00.0: BAR 0 [mem 0xdd000000-0xddffffff]
[    0.388391] pci 0000:01:00.0: BAR 1 [mem 0xf000000000-0xf7ffffffff 64bit=
 pref]
[    0.388397] pci 0000:01:00.0: BAR 3 [mem 0xf800000000-0xf801ffffff 64bit=
 pref]
[    0.388400] pci 0000:01:00.0: BAR 5 [io  0xf000-0xf07f]
[    0.388404] pci 0000:01:00.0: ROM [mem 0xde000000-0xde07ffff pref]
[    0.388440] pci 0000:01:00.0: PME# supported from D0 D3hot
[    0.388553] pci 0000:01:00.1: [10de:1aef] type 00 class 0x040300 PCIe En=
dpoint
[    0.388559] pci 0000:01:00.1: BAR 0 [mem 0xde080000-0xde083fff]
[    0.388646] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.388702] pci 0000:02:00.0: [144d:a80c] type 00 class 0x010802 PCIe En=
dpoint
[    0.388714] pci 0000:02:00.0: BAR 0 [mem 0xdf300000-0xdf303fff 64bit]
[    0.388893] pci 0000:00:01.2: PCI bridge to [bus 02]
[    0.388947] pci 0000:03:00.0: [1022:43f4] type 01 class 0x060400 PCIe Sw=
itch Upstream Port
[    0.388965] pci 0000:03:00.0: PCI bridge to [bus 04-14]
[    0.388969] pci 0000:03:00.0:   bridge window [io  0xe000-0xefff]
[    0.388970] pci 0000:03:00.0:   bridge window [mem 0xde200000-0xdebfffff]
[    0.388984] pci 0000:03:00.0: enabling Extended Tags
[    0.389027] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.389192] pci 0000:00:02.1: PCI bridge to [bus 03-14]
[    0.389258] pci 0000:04:00.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.389275] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.389294] pci 0000:04:00.0: enabling Extended Tags
[    0.389340] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.389436] pci 0000:04:04.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.389454] pci 0000:04:04.0: PCI bridge to [bus 06]
[    0.389472] pci 0000:04:04.0: enabling Extended Tags
[    0.389518] pci 0000:04:04.0: PME# supported from D0 D3hot D3cold
[    0.389612] pci 0000:04:05.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.389630] pci 0000:04:05.0: PCI bridge to [bus 07]
[    0.389648] pci 0000:04:05.0: enabling Extended Tags
[    0.389694] pci 0000:04:05.0: PME# supported from D0 D3hot D3cold
[    0.389789] pci 0000:04:06.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.389807] pci 0000:04:06.0: PCI bridge to [bus 08]
[    0.389825] pci 0000:04:06.0: enabling Extended Tags
[    0.389871] pci 0000:04:06.0: PME# supported from D0 D3hot D3cold
[    0.389966] pci 0000:04:07.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.389984] pci 0000:04:07.0: PCI bridge to [bus 09]
[    0.390002] pci 0000:04:07.0: enabling Extended Tags
[    0.390048] pci 0000:04:07.0: PME# supported from D0 D3hot D3cold
[    0.390145] pci 0000:04:08.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.390163] pci 0000:04:08.0: PCI bridge to [bus 0a-12]
[    0.390167] pci 0000:04:08.0:   bridge window [io  0xe000-0xefff]
[    0.390168] pci 0000:04:08.0:   bridge window [mem 0xde200000-0xde9fffff]
[    0.390182] pci 0000:04:08.0: enabling Extended Tags
[    0.390226] pci 0000:04:08.0: PME# supported from D0 D3hot D3cold
[    0.390355] pci 0000:04:0c.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.390373] pci 0000:04:0c.0: PCI bridge to [bus 13]
[    0.390376] pci 0000:04:0c.0:   bridge window [mem 0xdeb00000-0xdebfffff]
[    0.390389] pci 0000:04:0c.0: enabling Extended Tags
[    0.390420] pci 0000:04:0c.0: PME# supported from D0 D3hot D3cold
[    0.390488] pci 0000:04:0d.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.390506] pci 0000:04:0d.0: PCI bridge to [bus 14]
[    0.390510] pci 0000:04:0d.0:   bridge window [mem 0xdea00000-0xdeafffff]
[    0.390523] pci 0000:04:0d.0: enabling Extended Tags
[    0.390553] pci 0000:04:0d.0: PME# supported from D0 D3hot D3cold
[    0.390613] pci 0000:03:00.0: PCI bridge to [bus 04-14]
[    0.390642] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.390671] pci 0000:04:04.0: PCI bridge to [bus 06]
[    0.390700] pci 0000:04:05.0: PCI bridge to [bus 07]
[    0.390729] pci 0000:04:06.0: PCI bridge to [bus 08]
[    0.390758] pci 0000:04:07.0: PCI bridge to [bus 09]
[    0.390802] pci 0000:0a:00.0: [1022:43f4] type 01 class 0x060400 PCIe Sw=
itch Upstream Port
[    0.390830] pci 0000:0a:00.0: PCI bridge to [bus 0b-12]
[    0.390836] pci 0000:0a:00.0:   bridge window [io  0xe000-0xefff]
[    0.390838] pci 0000:0a:00.0:   bridge window [mem 0xde200000-0xde9fffff]
[    0.390859] pci 0000:0a:00.0: enabling Extended Tags
[    0.390930] pci 0000:0a:00.0: PME# supported from D0 D3hot D3cold
[    0.391221] pci 0000:04:08.0: PCI bridge to [bus 0a-12]
[    0.391308] pci 0000:0b:00.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.391336] pci 0000:0b:00.0: PCI bridge to [bus 0c]
[    0.391366] pci 0000:0b:00.0: enabling Extended Tags
[    0.391441] pci 0000:0b:00.0: PME# supported from D0 D3hot D3cold
[    0.391590] pci 0000:0b:02.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.391618] pci 0000:0b:02.0: PCI bridge to [bus 0d]
[    0.391626] pci 0000:0b:02.0:   bridge window [mem 0xde200000-0xde4fffff]
[    0.391648] pci 0000:0b:02.0: enabling Extended Tags
[    0.391720] pci 0000:0b:02.0: PME# supported from D0 D3hot D3cold
[    0.391868] pci 0000:0b:03.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.391896] pci 0000:0b:03.0: PCI bridge to [bus 0e]
[    0.391901] pci 0000:0b:03.0:   bridge window [io  0xe000-0xefff]
[    0.391904] pci 0000:0b:03.0:   bridge window [mem 0xde900000-0xde9fffff]
[    0.391926] pci 0000:0b:03.0: enabling Extended Tags
[    0.391998] pci 0000:0b:03.0: PME# supported from D0 D3hot D3cold
[    0.392146] pci 0000:0b:04.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.392174] pci 0000:0b:04.0: PCI bridge to [bus 0f]
[    0.392203] pci 0000:0b:04.0: enabling Extended Tags
[    0.392278] pci 0000:0b:04.0: PME# supported from D0 D3hot D3cold
[    0.392431] pci 0000:0b:08.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.392460] pci 0000:0b:08.0: PCI bridge to [bus 10]
[    0.392489] pci 0000:0b:08.0: enabling Extended Tags
[    0.392564] pci 0000:0b:08.0: PME# supported from D0 D3hot D3cold
[    0.392717] pci 0000:0b:0c.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.392745] pci 0000:0b:0c.0: PCI bridge to [bus 11]
[    0.392750] pci 0000:0b:0c.0:   bridge window [mem 0xde800000-0xde8fffff]
[    0.392772] pci 0000:0b:0c.0: enabling Extended Tags
[    0.392820] pci 0000:0b:0c.0: PME# supported from D0 D3hot D3cold
[    0.392907] pci 0000:0b:0d.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.392935] pci 0000:0b:0d.0: PCI bridge to [bus 12]
[    0.392940] pci 0000:0b:0d.0:   bridge window [mem 0xde600000-0xde7fffff]
[    0.392962] pci 0000:0b:0d.0: enabling Extended Tags
[    0.393009] pci 0000:0b:0d.0: PME# supported from D0 D3hot D3cold
[    0.393098] pci 0000:0a:00.0: PCI bridge to [bus 0b-12]
[    0.393140] pci 0000:0b:00.0: PCI bridge to [bus 0c]
[    0.393209] pci 0000:0d:00.0: [14c3:7925] type 00 class 0x028000 PCIe En=
dpoint
[    0.393239] pci 0000:0d:00.0: BAR 0 [mem 0xde200000-0xde3fffff 64bit]
[    0.393257] pci 0000:0d:00.0: BAR 2 [mem 0xde400000-0xde407fff 64bit]
[    0.393297] pci 0000:0d:00.0: enabling Extended Tags
[    0.393404] pci 0000:0d:00.0: PME# supported from D0 D3hot D3cold
[    0.393662] pci 0000:0b:02.0: PCI bridge to [bus 0d]
[    0.393734] pci 0000:0e:00.0: [10ec:8125] type 00 class 0x020000 PCIe En=
dpoint
[    0.393758] pci 0000:0e:00.0: BAR 0 [io  0xe000-0xe0ff]
[    0.393791] pci 0000:0e:00.0: BAR 2 [mem 0xde900000-0xde90ffff 64bit]
[    0.393811] pci 0000:0e:00.0: BAR 4 [mem 0xde910000-0xde913fff 64bit]
[    0.393970] pci 0000:0e:00.0: supports D1 D2
[    0.393970] pci 0000:0e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.394264] pci 0000:0b:03.0: PCI bridge to [bus 0e]
[    0.394308] pci 0000:0b:04.0: PCI bridge to [bus 0f]
[    0.394351] pci 0000:0b:08.0: PCI bridge to [bus 10]
[    0.394408] pci 0000:11:00.0: [1022:43fd] type 00 class 0x0c0330 PCIe Le=
gacy Endpoint
[    0.394426] pci 0000:11:00.0: BAR 0 [mem 0xde800000-0xde807fff 64bit]
[    0.394467] pci 0000:11:00.0: enabling Extended Tags
[    0.394520] pci 0000:11:00.0: PME# supported from D0 D3hot D3cold
[    0.394606] pci 0000:0b:0c.0: PCI bridge to [bus 11]
[    0.394662] pci 0000:12:00.0: [1022:43f6] type 00 class 0x010601 PCIe Le=
gacy Endpoint
[    0.394710] pci 0000:12:00.0: BAR 5 [mem 0xde680000-0xde6803ff]
[    0.394718] pci 0000:12:00.0: ROM [mem 0xde600000-0xde67ffff pref]
[    0.394724] pci 0000:12:00.0: enabling Extended Tags
[    0.394766] pci 0000:12:00.0: PME# supported from D0 D3hot D3cold
[    0.394838] pci 0000:0b:0d.0: PCI bridge to [bus 12]
[    0.394922] pci 0000:13:00.0: [1022:43fd] type 00 class 0x0c0330 PCIe Le=
gacy Endpoint
[    0.394933] pci 0000:13:00.0: BAR 0 [mem 0xdeb00000-0xdeb07fff 64bit]
[    0.394958] pci 0000:13:00.0: enabling Extended Tags
[    0.394991] pci 0000:13:00.0: PME# supported from D0 D3hot D3cold
[    0.395058] pci 0000:04:0c.0: PCI bridge to [bus 13]
[    0.395097] pci 0000:14:00.0: [1022:43f6] type 00 class 0x010601 PCIe Le=
gacy Endpoint
[    0.395127] pci 0000:14:00.0: BAR 5 [mem 0xdea80000-0xdea803ff]
[    0.395131] pci 0000:14:00.0: ROM [mem 0xdea00000-0xdea7ffff pref]
[    0.395135] pci 0000:14:00.0: enabling Extended Tags
[    0.395162] pci 0000:14:00.0: PME# supported from D0 D3hot D3cold
[    0.395209] pci 0000:04:0d.0: PCI bridge to [bus 14]
[    0.395297] pci 0000:15:00.0: [1b21:2421] type 01 class 0x060400 PCIe Sw=
itch Upstream Port
[    0.395315] pci 0000:15:00.0: PCI bridge to [bus 16-78]
[    0.395318] pci 0000:15:00.0:   bridge window [io  0x7000-0xcfff]
[    0.395320] pci 0000:15:00.0:   bridge window [mem 0xac000000-0xdc7fffff]
[    0.395326] pci 0000:15:00.0:   bridge window [mem 0xb000000000-0xefffff=
ffff 64bit pref]
[    0.395378] pci 0000:15:00.0: PME# supported from D0 D3hot D3cold
[    0.395492] pci 0000:00:02.2: PCI bridge to [bus 15-78]
[    0.395535] pci 0000:16:00.0: [1b21:2423] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.395553] pci 0000:16:00.0: PCI bridge to [bus 17-46]
[    0.395556] pci 0000:16:00.0:   bridge window [io  0xa000-0xcfff]
[    0.395558] pci 0000:16:00.0:   bridge window [mem 0xc4000000-0xdbffffff]
[    0.395564] pci 0000:16:00.0:   bridge window [mem 0xd000000000-0xefffff=
ffff 64bit pref]
[    0.395658] pci 0000:16:00.0: PME# supported from D0 D3hot D3cold
[    0.395963] pci 0000:16:01.0: [1b21:2423] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.395981] pci 0000:16:01.0: PCI bridge to [bus 47-76]
[    0.395984] pci 0000:16:01.0:   bridge window [io  0x7000-0x9fff]
[    0.395986] pci 0000:16:01.0:   bridge window [mem 0xac000000-0xc3ffffff]
[    0.395992] pci 0000:16:01.0:   bridge window [mem 0xb000000000-0xcfffff=
ffff 64bit pref]
[    0.396078] pci 0000:16:01.0: PME# supported from D0 D3hot D3cold
[    0.396379] pci 0000:16:02.0: [1b21:2423] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.396397] pci 0000:16:02.0: PCI bridge to [bus 77]
[    0.396400] pci 0000:16:02.0:   bridge window [mem 0xdc400000-0xdc7fffff]
[    0.396450] pci 0000:16:02.0: PME# supported from D0 D3hot D3cold
[    0.396525] pci 0000:16:03.0: [1b21:2423] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.396543] pci 0000:16:03.0: PCI bridge to [bus 78]
[    0.396546] pci 0000:16:03.0:   bridge window [mem 0xdc000000-0xdc3fffff]
[    0.396596] pci 0000:16:03.0: PME# supported from D0 D3hot D3cold
[    0.396676] pci 0000:15:00.0: PCI bridge to [bus 16-78]
[    0.396714] pci 0000:16:00.0: PCI bridge to [bus 17-46]
[    0.396753] pci 0000:16:01.0: PCI bridge to [bus 47-76]
[    0.396792] pci 0000:77:00.0: [1b21:2426] type 00 class 0x0c0330 PCIe Le=
gacy Endpoint
[    0.396803] pci 0000:77:00.0: BAR 0 [mem 0xdc400000-0xdc407fff 64bit]
[    0.396862] pci 0000:77:00.0: PME# supported from D0 D3hot D3cold
[    0.396933] pci 0000:16:02.0: PCI bridge to [bus 77]
[    0.396981] pci 0000:78:00.0: [1b21:2425] type 00 class 0x0c0340 PCIe Le=
gacy Endpoint
[    0.396991] pci 0000:78:00.0: BAR 0 [mem 0xdc000000-0xdc03ffff 64bit]
[    0.396997] pci 0000:78:00.0: BAR 2 [mem 0xdc040000-0xdc04ffff 64bit]
[    0.397044] pci 0000:78:00.0: PME# supported from D0 D3hot D3cold
[    0.397185] pci 0000:16:03.0: PCI bridge to [bus 78]
[    0.397253] pci 0000:79:00.0: [1002:13c0] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.397260] pci 0000:79:00.0: BAR 0 [mem 0xf810000000-0xf81fffffff 64bit=
 pref]
[    0.397265] pci 0000:79:00.0: BAR 2 [mem 0xdec00000-0xdedfffff 64bit pre=
f]
[    0.397268] pci 0000:79:00.0: BAR 4 [io  0xd000-0xd0ff]
[    0.397271] pci 0000:79:00.0: BAR 5 [mem 0xdf100000-0xdf17ffff]
[    0.397277] pci 0000:79:00.0: enabling Extended Tags
[    0.397309] pci 0000:79:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.397371] pci 0000:79:00.1: [1002:1640] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.397375] pci 0000:79:00.1: BAR 0 [mem 0xdf188000-0xdf18bfff]
[    0.397389] pci 0000:79:00.1: enabling Extended Tags
[    0.397409] pci 0000:79:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.397445] pci 0000:79:00.2: [1022:1649] type 00 class 0x108000 PCIe En=
dpoint
[    0.397479] pci 0000:79:00.2: BAR 2 [mem 0xdf000000-0xdf0fffff]
[    0.397485] pci 0000:79:00.2: BAR 5 [mem 0xdf18c000-0xdf18dfff]
[    0.397490] pci 0000:79:00.2: enabling Extended Tags
[    0.397541] pci 0000:79:00.3: [1022:15b6] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.397548] pci 0000:79:00.3: BAR 0 [mem 0xdef00000-0xdeffffff 64bit]
[    0.397564] pci 0000:79:00.3: enabling Extended Tags
[    0.397585] pci 0000:79:00.3: PME# supported from D0 D3hot D3cold
[    0.397624] pci 0000:79:00.4: [1022:15b7] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.397631] pci 0000:79:00.4: BAR 0 [mem 0xdee00000-0xdeefffff 64bit]
[    0.397647] pci 0000:79:00.4: enabling Extended Tags
[    0.397668] pci 0000:79:00.4: PME# supported from D0 D3hot D3cold
[    0.397706] pci 0000:79:00.6: [1022:15e3] type 00 class 0x040300 PCIe En=
dpoint
[    0.397711] pci 0000:79:00.6: BAR 0 [mem 0xdf180000-0xdf187fff]
[    0.397724] pci 0000:79:00.6: enabling Extended Tags
[    0.397744] pci 0000:79:00.6: PME# supported from D0 D3hot D3cold
[    0.397789] pci 0000:00:08.1: PCI bridge to [bus 79]
[    0.397813] pci 0000:7a:00.0: [1022:15b8] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.397824] pci 0000:7a:00.0: BAR 0 [mem 0xdf200000-0xdf2fffff 64bit]
[    0.397845] pci 0000:7a:00.0: enabling Extended Tags
[    0.397872] pci 0000:7a:00.0: PME# supported from D0 D3hot D3cold
[    0.397923] pci 0000:00:08.3: PCI bridge to [bus 7a]
[    0.401691] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.401710] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.401726] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.401746] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.401764] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.401778] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.401793] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.401807] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.402247] iommu: Default domain type: Translated
[    0.402247] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.402247] SCSI subsystem initialized
[    0.402247] libata version 3.00 loaded.
[    0.402247] ACPI: bus type USB registered
[    0.402247] usbcore: registered new interface driver usbfs
[    0.402247] usbcore: registered new interface driver hub
[    0.402247] usbcore: registered new device driver usb
[    0.413190] EDAC MC: Ver: 3.0.0
[    0.413306] efivars: Registered efivars operations
[    0.413306] NetLabel: Initializing
[    0.413306] NetLabel:  domain hash size =3D 128
[    0.413306] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.413306] NetLabel:  unlabeled traffic allowed by default
[    0.413306] mctp: management component transport protocol core
[    0.413306] NET: Registered PF_MCTP protocol family
[    0.413306] PCI: Using ACPI for IRQ routing
[    0.418662] PCI: pci_cache_line_size set to 64 bytes
[    0.418748] e820: reserve RAM buffer [mem 0x09aff000-0x0bffffff]
[    0.418750] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.418750] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.418751] e820: reserve RAM buffer [mem 0x82028018-0x83ffffff]
[    0.418751] e820: reserve RAM buffer [mem 0x82033018-0x83ffffff]
[    0.418752] e820: reserve RAM buffer [mem 0x82042018-0x83ffffff]
[    0.418752] e820: reserve RAM buffer [mem 0x8405e000-0x87ffffff]
[    0.418752] e820: reserve RAM buffer [mem 0x84509000-0x87ffffff]
[    0.418753] e820: reserve RAM buffer [mem 0x88212000-0x8bffffff]
[    0.418753] e820: reserve RAM buffer [mem 0x99ff7000-0x9bffffff]
[    0.418753] e820: reserve RAM buffer [mem 0x9a000000-0x9bffffff]
[    0.418754] e820: reserve RAM buffer [mem 0xfdde80000-0xfdfffffff]
[    0.418767] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.418767] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.418767] pci 0000:01:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.418767] pci 0000:79:00.0: vgaarb: bridge control possible
[    0.418767] pci 0000:79:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.418767] vgaarb: loaded
[    0.418767] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.418767] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.420939] clocksource: Switched to clocksource tsc-early
[    0.421264] VFS: Disk quotas dquot_6.6.0
[    0.421272] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.421328] pnp: PnP ACPI init
[    0.421397] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.421451] system 00:01: [mem 0xfe0000000-0x105fffffff window] has been=
 reserved
[    0.421609] system 00:03: [io  0x0a00-0x0a2f] has been reserved
[    0.421611] system 00:03: [io  0x0a30-0x0a3f] has been reserved
[    0.421612] system 00:03: [io  0x0a40-0x0a4f] has been reserved
[    0.421614] system 00:03: [mem 0xfe000000-0xfe01ffff] has been reserved
[    0.421757] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.421758] system 00:04: [io  0x040b] has been reserved
[    0.421759] system 00:04: [io  0x04d6] has been reserved
[    0.421760] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.421761] system 00:04: [io  0x0c14] has been reserved
[    0.421762] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.421762] system 00:04: [io  0x0c52] has been reserved
[    0.421763] system 00:04: [io  0x0c6c] has been reserved
[    0.421764] system 00:04: [io  0x0c6f] has been reserved
[    0.421765] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.421766] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.421767] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.421768] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.421769] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.421770] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.421771] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.421773] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.421774] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.421775] system 00:04: [mem 0xfeb00000-0xfeb00fff] has been reserved
[    0.421776] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.424613] pnp: PnP ACPI: found 5 devices
[    0.429674] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.429696] NET: Registered PF_INET protocol family
[    0.429752] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.435919] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7=
, 524288 bytes, linear)
[    0.435951] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.436044] TCP established hash table entries: 524288 (order: 10, 41943=
04 bytes, linear)
[    0.436292] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.436344] TCP: Hash tables configured (established 524288 bind 65536)
[    0.436426] MPTCP token hash table entries: 65536 (order: 8, 1572864 byt=
es, linear)
[    0.436514] UDP hash table entries: 32768 (order: 9, 2097152 bytes, line=
ar)
[    0.436615] UDP-Lite hash table entries: 32768 (order: 9, 2097152 bytes,=
 linear)
[    0.436686] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.436689] NET: Registered PF_XDP protocol family
[    0.436698] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.436700] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.436702] pci 0000:00:01.1:   bridge window [mem 0xdd000000-0xde0fffff]
[    0.436704] pci 0000:00:01.1:   bridge window [mem 0xf000000000-0xf801ff=
ffff 64bit pref]
[    0.436713] pci 0000:00:01.2: PCI bridge to [bus 02]
[    0.436715] pci 0000:00:01.2:   bridge window [mem 0xdf300000-0xdf3fffff]
[    0.436725] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.436735] pci 0000:04:04.0: PCI bridge to [bus 06]
[    0.436741] pci 0000:04:05.0: PCI bridge to [bus 07]
[    0.436747] pci 0000:04:06.0: PCI bridge to [bus 08]
[    0.436753] pci 0000:04:07.0: PCI bridge to [bus 09]
[    0.436759] pci 0000:0b:00.0: PCI bridge to [bus 0c]
[    0.436768] pci 0000:0b:02.0: PCI bridge to [bus 0d]
[    0.436771] pci 0000:0b:02.0:   bridge window [mem 0xde200000-0xde4fffff]
[    0.436778] pci 0000:0b:03.0: PCI bridge to [bus 0e]
[    0.436779] pci 0000:0b:03.0:   bridge window [io  0xe000-0xefff]
[    0.436782] pci 0000:0b:03.0:   bridge window [mem 0xde900000-0xde9fffff]
[    0.436789] pci 0000:0b:04.0: PCI bridge to [bus 0f]
[    0.436798] pci 0000:0b:08.0: PCI bridge to [bus 10]
[    0.436807] pci 0000:0b:0c.0: PCI bridge to [bus 11]
[    0.436810] pci 0000:0b:0c.0:   bridge window [mem 0xde800000-0xde8fffff]
[    0.436817] pci 0000:0b:0d.0: PCI bridge to [bus 12]
[    0.436820] pci 0000:0b:0d.0:   bridge window [mem 0xde600000-0xde7fffff]
[    0.436826] pci 0000:0a:00.0: PCI bridge to [bus 0b-12]
[    0.436828] pci 0000:0a:00.0:   bridge window [io  0xe000-0xefff]
[    0.436831] pci 0000:0a:00.0:   bridge window [mem 0xde200000-0xde9fffff]
[    0.436837] pci 0000:04:08.0: PCI bridge to [bus 0a-12]
[    0.436838] pci 0000:04:08.0:   bridge window [io  0xe000-0xefff]
[    0.436841] pci 0000:04:08.0:   bridge window [mem 0xde200000-0xde9fffff]
[    0.436845] pci 0000:04:0c.0: PCI bridge to [bus 13]
[    0.436847] pci 0000:04:0c.0:   bridge window [mem 0xdeb00000-0xdebfffff]
[    0.436851] pci 0000:04:0d.0: PCI bridge to [bus 14]
[    0.436853] pci 0000:04:0d.0:   bridge window [mem 0xdea00000-0xdeafffff]
[    0.436857] pci 0000:03:00.0: PCI bridge to [bus 04-14]
[    0.436858] pci 0000:03:00.0:   bridge window [io  0xe000-0xefff]
[    0.436860] pci 0000:03:00.0:   bridge window [mem 0xde200000-0xdebfffff]
[    0.436864] pci 0000:00:02.1: PCI bridge to [bus 03-14]
[    0.436865] pci 0000:00:02.1:   bridge window [io  0xe000-0xefff]
[    0.436867] pci 0000:00:02.1:   bridge window [mem 0xde200000-0xdebfffff]
[    0.436877] pci 0000:16:00.0: PCI bridge to [bus 17-46]
[    0.436878] pci 0000:16:00.0:   bridge window [io  0xa000-0xcfff]
[    0.436880] pci 0000:16:00.0:   bridge window [mem 0xc4000000-0xdbffffff]
[    0.436882] pci 0000:16:00.0:   bridge window [mem 0xd000000000-0xefffff=
ffff 64bit pref]
[    0.436885] pci 0000:16:01.0: PCI bridge to [bus 47-76]
[    0.436886] pci 0000:16:01.0:   bridge window [io  0x7000-0x9fff]
[    0.436888] pci 0000:16:01.0:   bridge window [mem 0xac000000-0xc3ffffff]
[    0.436889] pci 0000:16:01.0:   bridge window [mem 0xb000000000-0xcfffff=
ffff 64bit pref]
[    0.436892] pci 0000:16:02.0: PCI bridge to [bus 77]
[    0.436894] pci 0000:16:02.0:   bridge window [mem 0xdc400000-0xdc7fffff]
[    0.436898] pci 0000:16:03.0: PCI bridge to [bus 78]
[    0.436901] pci 0000:16:03.0:   bridge window [mem 0xdc000000-0xdc3fffff]
[    0.436905] pci 0000:15:00.0: PCI bridge to [bus 16-78]
[    0.436906] pci 0000:15:00.0:   bridge window [io  0x7000-0xcfff]
[    0.436908] pci 0000:15:00.0:   bridge window [mem 0xac000000-0xdc7fffff]
[    0.436909] pci 0000:15:00.0:   bridge window [mem 0xb000000000-0xefffff=
ffff 64bit pref]
[    0.436912] pci 0000:00:02.2: PCI bridge to [bus 15-78]
[    0.436913] pci 0000:00:02.2:   bridge window [io  0x7000-0xcfff]
[    0.436915] pci 0000:00:02.2:   bridge window [mem 0xac000000-0xdc7fffff]
[    0.436916] pci 0000:00:02.2:   bridge window [mem 0xb000000000-0xefffff=
ffff 64bit pref]
[    0.436926] pci 0000:00:08.1: PCI bridge to [bus 79]
[    0.436931] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    0.436932] pci 0000:00:08.1:   bridge window [mem 0xdec00000-0xdf1fffff]
[    0.436933] pci 0000:00:08.1:   bridge window [mem 0xf810000000-0xf81fff=
ffff 64bit pref]
[    0.436935] pci 0000:00:08.3: PCI bridge to [bus 7a]
[    0.436936] pci 0000:00:08.3:   bridge window [mem 0xdf200000-0xdf2fffff]
[    0.436939] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.436940] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.436940] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.436941] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.436941] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff windo=
w]
[    0.436942] pci_bus 0000:00: resource 9 [mem 0xa0000000-0xdfffffff windo=
w]
[    0.436942] pci_bus 0000:00: resource 10 [mem 0x1060000000-0xffffffffff =
window]
[    0.436943] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.436943] pci_bus 0000:01: resource 1 [mem 0xdd000000-0xde0fffff]
[    0.436944] pci_bus 0000:01: resource 2 [mem 0xf000000000-0xf801ffffff 6=
4bit pref]
[    0.436944] pci_bus 0000:02: resource 1 [mem 0xdf300000-0xdf3fffff]
[    0.436945] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    0.436945] pci_bus 0000:03: resource 1 [mem 0xde200000-0xdebfffff]
[    0.436946] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[    0.436946] pci_bus 0000:04: resource 1 [mem 0xde200000-0xdebfffff]
[    0.436946] pci_bus 0000:0a: resource 0 [io  0xe000-0xefff]
[    0.436947] pci_bus 0000:0a: resource 1 [mem 0xde200000-0xde9fffff]
[    0.436947] pci_bus 0000:0b: resource 0 [io  0xe000-0xefff]
[    0.436948] pci_bus 0000:0b: resource 1 [mem 0xde200000-0xde9fffff]
[    0.436948] pci_bus 0000:0d: resource 1 [mem 0xde200000-0xde4fffff]
[    0.436948] pci_bus 0000:0e: resource 0 [io  0xe000-0xefff]
[    0.436949] pci_bus 0000:0e: resource 1 [mem 0xde900000-0xde9fffff]
[    0.436949] pci_bus 0000:11: resource 1 [mem 0xde800000-0xde8fffff]
[    0.436950] pci_bus 0000:12: resource 1 [mem 0xde600000-0xde7fffff]
[    0.436950] pci_bus 0000:13: resource 1 [mem 0xdeb00000-0xdebfffff]
[    0.436951] pci_bus 0000:14: resource 1 [mem 0xdea00000-0xdeafffff]
[    0.436951] pci_bus 0000:15: resource 0 [io  0x7000-0xcfff]
[    0.436951] pci_bus 0000:15: resource 1 [mem 0xac000000-0xdc7fffff]
[    0.436952] pci_bus 0000:15: resource 2 [mem 0xb000000000-0xefffffffff 6=
4bit pref]
[    0.436952] pci_bus 0000:16: resource 0 [io  0x7000-0xcfff]
[    0.436953] pci_bus 0000:16: resource 1 [mem 0xac000000-0xdc7fffff]
[    0.436953] pci_bus 0000:16: resource 2 [mem 0xb000000000-0xefffffffff 6=
4bit pref]
[    0.436953] pci_bus 0000:17: resource 0 [io  0xa000-0xcfff]
[    0.436954] pci_bus 0000:17: resource 1 [mem 0xc4000000-0xdbffffff]
[    0.436954] pci_bus 0000:17: resource 2 [mem 0xd000000000-0xefffffffff 6=
4bit pref]
[    0.436955] pci_bus 0000:47: resource 0 [io  0x7000-0x9fff]
[    0.436955] pci_bus 0000:47: resource 1 [mem 0xac000000-0xc3ffffff]
[    0.436955] pci_bus 0000:47: resource 2 [mem 0xb000000000-0xcfffffffff 6=
4bit pref]
[    0.436956] pci_bus 0000:77: resource 1 [mem 0xdc400000-0xdc7fffff]
[    0.436956] pci_bus 0000:78: resource 1 [mem 0xdc000000-0xdc3fffff]
[    0.436957] pci_bus 0000:79: resource 0 [io  0xd000-0xdfff]
[    0.436957] pci_bus 0000:79: resource 1 [mem 0xdec00000-0xdf1fffff]
[    0.436958] pci_bus 0000:79: resource 2 [mem 0xf810000000-0xf81fffffff 6=
4bit pref]
[    0.436958] pci_bus 0000:7a: resource 1 [mem 0xdf200000-0xdf2fffff]
[    0.437028] pci 0000:01:00.1: extending delay after power-on from D3hot =
to 20 msec
[    0.437038] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.437287] pci 0000:79:00.1: D0 power state depends on 0000:79:00.0
[    0.437407] PCI: CLS 64 bytes, default 64
[    0.437422] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters support=
ed
[    0.437444] pci 0000:00:01.0: Adding to iommu group 0
[    0.437445] Trying to unpack rootfs image as initramfs...
[    0.437450] pci 0000:00:01.1: Adding to iommu group 1
[    0.437456] pci 0000:00:01.2: Adding to iommu group 2
[    0.437467] pci 0000:00:02.0: Adding to iommu group 3
[    0.437473] pci 0000:00:02.1: Adding to iommu group 4
[    0.437479] pci 0000:00:02.2: Adding to iommu group 5
[    0.437487] pci 0000:00:03.0: Adding to iommu group 6
[    0.437496] pci 0000:00:04.0: Adding to iommu group 7
[    0.437506] pci 0000:00:08.0: Adding to iommu group 8
[    0.437512] pci 0000:00:08.1: Adding to iommu group 9
[    0.437517] pci 0000:00:08.3: Adding to iommu group 10
[    0.437530] pci 0000:00:14.0: Adding to iommu group 11
[    0.437536] pci 0000:00:14.3: Adding to iommu group 11
[    0.437569] pci 0000:00:18.0: Adding to iommu group 12
[    0.437575] pci 0000:00:18.1: Adding to iommu group 12
[    0.437581] pci 0000:00:18.2: Adding to iommu group 12
[    0.437586] pci 0000:00:18.3: Adding to iommu group 12
[    0.437592] pci 0000:00:18.4: Adding to iommu group 12
[    0.437598] pci 0000:00:18.5: Adding to iommu group 12
[    0.437603] pci 0000:00:18.6: Adding to iommu group 12
[    0.437609] pci 0000:00:18.7: Adding to iommu group 12
[    0.437622] pci 0000:01:00.0: Adding to iommu group 13
[    0.437629] pci 0000:01:00.1: Adding to iommu group 13
[    0.437635] pci 0000:02:00.0: Adding to iommu group 14
[    0.437642] pci 0000:03:00.0: Adding to iommu group 15
[    0.437648] pci 0000:04:00.0: Adding to iommu group 16
[    0.437654] pci 0000:04:04.0: Adding to iommu group 17
[    0.437660] pci 0000:04:05.0: Adding to iommu group 18
[    0.437666] pci 0000:04:06.0: Adding to iommu group 19
[    0.437672] pci 0000:04:07.0: Adding to iommu group 20
[    0.437679] pci 0000:04:08.0: Adding to iommu group 21
[    0.437685] pci 0000:04:0c.0: Adding to iommu group 22
[    0.437691] pci 0000:04:0d.0: Adding to iommu group 23
[    0.437692] pci 0000:0a:00.0: Adding to iommu group 21
[    0.437693] pci 0000:0b:00.0: Adding to iommu group 21
[    0.437695] pci 0000:0b:02.0: Adding to iommu group 21
[    0.437696] pci 0000:0b:03.0: Adding to iommu group 21
[    0.437698] pci 0000:0b:04.0: Adding to iommu group 21
[    0.437699] pci 0000:0b:08.0: Adding to iommu group 21
[    0.437701] pci 0000:0b:0c.0: Adding to iommu group 21
[    0.437702] pci 0000:0b:0d.0: Adding to iommu group 21
[    0.437703] pci 0000:0d:00.0: Adding to iommu group 21
[    0.437705] pci 0000:0e:00.0: Adding to iommu group 21
[    0.437706] pci 0000:11:00.0: Adding to iommu group 21
[    0.437708] pci 0000:12:00.0: Adding to iommu group 21
[    0.437709] pci 0000:13:00.0: Adding to iommu group 22
[    0.437710] pci 0000:14:00.0: Adding to iommu group 23
[    0.437716] pci 0000:15:00.0: Adding to iommu group 24
[    0.437723] pci 0000:16:00.0: Adding to iommu group 25
[    0.437729] pci 0000:16:01.0: Adding to iommu group 26
[    0.437735] pci 0000:16:02.0: Adding to iommu group 27
[    0.437741] pci 0000:16:03.0: Adding to iommu group 28
[    0.437743] pci 0000:77:00.0: Adding to iommu group 27
[    0.437744] pci 0000:78:00.0: Adding to iommu group 28
[    0.437766] pci 0000:79:00.0: Adding to iommu group 29
[    0.437772] pci 0000:79:00.1: Adding to iommu group 30
[    0.437779] pci 0000:79:00.2: Adding to iommu group 31
[    0.437785] pci 0000:79:00.3: Adding to iommu group 32
[    0.437792] pci 0000:79:00.4: Adding to iommu group 33
[    0.437798] pci 0000:79:00.6: Adding to iommu group 34
[    0.437804] pci 0000:7a:00.0: Adding to iommu group 35
[    0.439068] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX =
GT [5] IA GA PC GA_vAPIC
[    0.439071] AMD-Vi: Interrupt remapping enabled
[    0.475960] AMD-Vi: Virtual APIC enabled
[    0.475968] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.475970] software IO TLB: mapped [mem 0x000000007d105000-0x0000000081=
105000] (64MB)
[    0.475987] LVT offset 0 assigned for vector 0x400
[    0.477077] perf: AMD IBS detected (0x00081bff)
[    0.477079] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/b=
ank).
[    0.484098] Initialise system trusted keyrings
[    0.484106] Key type blacklist registered
[    0.484124] workingset: timestamp_bits=3D41 max_order=3D24 bucket_order=
=3D0
[    0.484129] zbud: loaded
[    0.484188] fuse: init (API version 7.41)
[    0.484240] integrity: Platform Keyring initialized
[    0.484242] integrity: Machine keyring initialized
[    0.488596] Key type asymmetric registered
[    0.488597] Asymmetric key parser 'x509' registered
[    0.488608] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.488623] io scheduler mq-deadline registered
[    0.488624] io scheduler kyber registered
[    0.488627] io scheduler bfq registered
[    0.491407] ledtrig-cpu: registered to indicate activity on CPUs
[    0.491494] pcieport 0000:00:01.1: PME: Signaling with IRQ 29
[    0.491604] pcieport 0000:00:01.2: PME: Signaling with IRQ 30
[    0.491702] pcieport 0000:00:02.1: PME: Signaling with IRQ 31
[    0.491801] pcieport 0000:00:02.2: PME: Signaling with IRQ 32
[    0.491904] pcieport 0000:00:08.1: PME: Signaling with IRQ 33
[    0.491988] pcieport 0000:00:08.3: PME: Signaling with IRQ 34
[    0.493786] pcieport 0000:16:00.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    0.493978] pcieport 0000:16:01.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    0.494187] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.494307] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input0
[    0.494318] ACPI: button: Power Button [PWRB]
[    0.494332] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input1
[    0.495178] Freeing initrd memory: 89300K
[    0.495198] ACPI: button: Power Button [PWRF]
[    0.495363] Monitor-Mwait will be used to enter C-1 state
[    0.496184] Estimated ratio of average max frequency by base frequency (=
times 1024): 1086
[    1.483970] tsc: Refined TSC clocksource calibration: 4691.205 MHz
[    1.483979] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x439=
ef830147, max_idle_ns: 440795309423 ns
[    1.484008] clocksource: Switched to clocksource tsc
[    2.526789] ACPI: \_TZ_.TZ10: _PSL evaluation failure
[    2.526917] thermal LNXTHERM:00: registered as thermal_zone0
[    2.526918] ACPI: thermal: Thermal Zone [TZ10] (17 C)
[    2.527125] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.527773] Non-volatile memory driver v1.3
[    2.527774] Linux agpgart interface v0.103
[    2.620739] tpm_crb MSFT0101:00: Disabling hwrng
[    2.621018] ACPI: bus type drm_connector registered
[    2.622187] ahci 0000:12:00.0: version 3.0
[    2.622298] ahci 0000:12:00.0: SSS flag set, parallel bus scan disabled
[    2.622336] ahci 0000:12:00.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    2.622337] ahci 0000:12:00.0: 4/6 ports implemented (port mask 0xf)
[    2.622338] ahci 0000:12:00.0: flags: 64bit ncq sntf stag pm led clo onl=
y pmp pio slum part sxs deso sadm sds apst=20
[    2.622546] scsi host0: ahci
[    2.622618] scsi host1: ahci
[    2.622660] scsi host2: ahci
[    2.622720] scsi host3: ahci
[    2.622786] scsi host4: ahci
[    2.622833] scsi host5: ahci
[    2.622851] ata1: SATA max UDMA/133 abar m1024@0xde680000 port 0xde68010=
0 irq 50 lpm-pol 0
[    2.622853] ata2: SATA max UDMA/133 abar m1024@0xde680000 port 0xde68018=
0 irq 50 lpm-pol 0
[    2.622855] ata3: SATA max UDMA/133 abar m1024@0xde680000 port 0xde68020=
0 irq 50 lpm-pol 0
[    2.622857] ata4: SATA max UDMA/133 abar m1024@0xde680000 port 0xde68028=
0 irq 50 lpm-pol 0
[    2.622858] ata5: DUMMY
[    2.622859] ata6: DUMMY
[    2.622995] ahci 0000:14:00.0: SSS flag set, parallel bus scan disabled
[    2.623020] ahci 0000:14:00.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    2.623023] ahci 0000:14:00.0: 4/6 ports implemented (port mask 0xf)
[    2.623024] ahci 0000:14:00.0: flags: 64bit ncq sntf stag pm led clo onl=
y pmp pio slum part sxs deso sadm sds apst=20
[    2.623256] scsi host6: ahci
[    2.623296] scsi host7: ahci
[    2.623332] scsi host8: ahci
[    2.623366] scsi host9: ahci
[    2.623390] scsi host10: ahci
[    2.623414] scsi host11: ahci
[    2.623427] ata7: SATA max UDMA/133 abar m1024@0xdea80000 port 0xdea8010=
0 irq 51 lpm-pol 0
[    2.623428] ata8: SATA max UDMA/133 abar m1024@0xdea80000 port 0xdea8018=
0 irq 51 lpm-pol 0
[    2.623428] ata9: SATA max UDMA/133 abar m1024@0xdea80000 port 0xdea8020=
0 irq 51 lpm-pol 0
[    2.623429] ata10: SATA max UDMA/133 abar m1024@0xdea80000 port 0xdea802=
80 irq 51 lpm-pol 0
[    2.623430] ata11: DUMMY
[    2.623431] ata12: DUMMY
[    2.623502] xhci_hcd 0000:11:00.0: xHCI Host Controller
[    2.623505] xhci_hcd 0000:11:00.0: new USB bus registered, assigned bus =
number 1
[    2.679476] xhci_hcd 0000:11:00.0: hcc params 0x0200ef81 hci version 0x1=
10 quirks 0x0000000000000010
[    2.679728] xhci_hcd 0000:11:00.0: xHCI Host Controller
[    2.679729] xhci_hcd 0000:11:00.0: new USB bus registered, assigned bus =
number 2
[    2.679730] xhci_hcd 0000:11:00.0: Host supports USB 3.2 Enhanced SuperS=
peed
[    2.680478] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    2.680482] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.680483] usb usb1: Product: xHCI Host Controller
[    2.680484] usb usb1: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 x=
hci-hcd
[    2.680485] usb usb1: SerialNumber: 0000:11:00.0
[    2.680558] hub 1-0:1.0: USB hub found
[    2.680579] hub 1-0:1.0: 12 ports detected
[    2.680753] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    2.680769] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    2.680770] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.680771] usb usb2: Product: xHCI Host Controller
[    2.680772] usb usb2: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 x=
hci-hcd
[    2.680773] usb usb2: SerialNumber: 0000:11:00.0
[    2.680824] hub 2-0:1.0: USB hub found
[    2.680832] hub 2-0:1.0: 5 ports detected
[    2.680981] xhci_hcd 0000:13:00.0: xHCI Host Controller
[    2.680984] xhci_hcd 0000:13:00.0: new USB bus registered, assigned bus =
number 3
[    2.736949] xhci_hcd 0000:13:00.0: hcc params 0x0200ef81 hci version 0x1=
10 quirks 0x0000000000000010
[    2.737134] xhci_hcd 0000:13:00.0: xHCI Host Controller
[    2.737136] xhci_hcd 0000:13:00.0: new USB bus registered, assigned bus =
number 4
[    2.737136] xhci_hcd 0000:13:00.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    2.737931] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    2.737931] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.737932] usb usb3: Product: xHCI Host Controller
[    2.737932] usb usb3: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 x=
hci-hcd
[    2.737933] usb usb3: SerialNumber: 0000:13:00.0
[    2.737988] hub 3-0:1.0: USB hub found
[    2.737996] hub 3-0:1.0: 12 ports detected
[    2.739890] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    2.739897] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    2.739897] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.739898] usb usb4: Product: xHCI Host Controller
[    2.739898] usb usb4: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 x=
hci-hcd
[    2.739899] usb usb4: SerialNumber: 0000:13:00.0
[    2.739934] hub 4-0:1.0: USB hub found
[    2.739944] hub 4-0:1.0: 6 ports detected
[    2.740989] xhci_hcd 0000:77:00.0: xHCI Host Controller
[    2.740991] xhci_hcd 0000:77:00.0: new USB bus registered, assigned bus =
number 5
[    2.743586] xhci_hcd 0000:77:00.0: hcc params 0x0200ef81 hci version 0x1=
20 quirks 0x0000000200000010
[    2.743761] xhci_hcd 0000:77:00.0: xHCI Host Controller
[    2.743762] xhci_hcd 0000:77:00.0: new USB bus registered, assigned bus =
number 6
[    2.743763] xhci_hcd 0000:77:00.0: Host supports USB 3.2 Enhanced SuperS=
peed
[    2.743783] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    2.743783] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.743784] usb usb5: Product: xHCI Host Controller
[    2.743784] usb usb5: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 x=
hci-hcd
[    2.743785] usb usb5: SerialNumber: 0000:77:00.0
[    2.743825] hub 5-0:1.0: USB hub found
[    2.743828] hub 5-0:1.0: 2 ports detected
[    2.744245] usb usb6: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    2.744252] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    2.744253] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.744253] usb usb6: Product: xHCI Host Controller
[    2.744253] usb usb6: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 x=
hci-hcd
[    2.744254] usb usb6: SerialNumber: 0000:77:00.0
[    2.744287] hub 6-0:1.0: USB hub found
[    2.744289] hub 6-0:1.0: 2 ports detected
[    2.744754] xhci_hcd 0000:79:00.3: xHCI Host Controller
[    2.744756] xhci_hcd 0000:79:00.3: new USB bus registered, assigned bus =
number 7
[    2.745100] xhci_hcd 0000:79:00.3: hcc params 0x0120ffc5 hci version 0x1=
20 quirks 0x0000000200000010
[    2.745332] xhci_hcd 0000:79:00.3: xHCI Host Controller
[    2.745332] xhci_hcd 0000:79:00.3: new USB bus registered, assigned bus =
number 8
[    2.745333] xhci_hcd 0000:79:00.3: Host supports USB 3.1 Enhanced SuperS=
peed
[    2.745343] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    2.745344] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.745344] usb usb7: Product: xHCI Host Controller
[    2.745345] usb usb7: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 x=
hci-hcd
[    2.745345] usb usb7: SerialNumber: 0000:79:00.3
[    2.745383] hub 7-0:1.0: USB hub found
[    2.745385] hub 7-0:1.0: 2 ports detected
[    2.745761] usb usb8: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    2.745767] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    2.745768] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.745768] usb usb8: Product: xHCI Host Controller
[    2.745768] usb usb8: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 x=
hci-hcd
[    2.745769] usb usb8: SerialNumber: 0000:79:00.3
[    2.745803] hub 8-0:1.0: USB hub found
[    2.745809] hub 8-0:1.0: 2 ports detected
[    2.746253] xhci_hcd 0000:79:00.4: xHCI Host Controller
[    2.746255] xhci_hcd 0000:79:00.4: new USB bus registered, assigned bus =
number 9
[    2.746610] xhci_hcd 0000:79:00.4: hcc params 0x0120ffc5 hci version 0x1=
20 quirks 0x0000000200000010
[    2.746845] xhci_hcd 0000:79:00.4: xHCI Host Controller
[    2.746846] xhci_hcd 0000:79:00.4: new USB bus registered, assigned bus =
number 10
[    2.746846] xhci_hcd 0000:79:00.4: Host supports USB 3.1 Enhanced SuperS=
peed
[    2.746857] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    2.746857] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    2.746858] usb usb9: Product: xHCI Host Controller
[    2.746858] usb usb9: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 x=
hci-hcd
[    2.746859] usb usb9: SerialNumber: 0000:79:00.4
[    2.746902] hub 9-0:1.0: USB hub found
[    2.746908] hub 9-0:1.0: 2 ports detected
[    2.747296] usb usb10: We don't know the algorithms for LPM for this hos=
t, disabling LPM.
[    2.747302] usb usb10: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    2.747303] usb usb10: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    2.747303] usb usb10: Product: xHCI Host Controller
[    2.747304] usb usb10: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 =
xhci-hcd
[    2.747304] usb usb10: SerialNumber: 0000:79:00.4
[    2.747340] hub 10-0:1.0: USB hub found
[    2.747342] hub 10-0:1.0: 2 ports detected
[    2.747783] xhci_hcd 0000:7a:00.0: xHCI Host Controller
[    2.747784] xhci_hcd 0000:7a:00.0: new USB bus registered, assigned bus =
number 11
[    2.749046] xhci_hcd 0000:7a:00.0: USB3 root hub has no ports
[    2.749048] xhci_hcd 0000:7a:00.0: hcc params 0x0110ffc5 hci version 0x1=
20 quirks 0x0000000200000010
[    2.749286] xhci_hcd 0000:7a:00.0: xHCI Host Controller
[    2.749286] xhci_hcd 0000:7a:00.0: new USB bus registered, assigned bus =
number 12
[    2.749287] xhci_hcd 0000:7a:00.0: Host supports USB 3.0 SuperSpeed
[    2.749301] usb usb11: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    2.749301] usb usb11: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    2.749302] usb usb11: Product: xHCI Host Controller
[    2.749303] usb usb11: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 =
xhci-hcd
[    2.749303] usb usb11: SerialNumber: 0000:7a:00.0
[    2.749339] hub 11-0:1.0: USB hub found
[    2.749345] hub 11-0:1.0: 1 port detected
[    2.749536] usb usb12: We don't know the algorithms for LPM for this hos=
t, disabling LPM.
[    2.749542] usb usb12: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    2.749542] usb usb12: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    2.749543] usb usb12: Product: xHCI Host Controller
[    2.749543] usb usb12: Manufacturer: Linux 6.13.1-1-00200-g4cf9f08632c0 =
xhci-hcd
[    2.749544] usb usb12: SerialNumber: 0000:7a:00.0
[    2.749578] hub 12-0:1.0: USB hub found
[    2.749579] hub 12-0:1.0: config failed, hub doesn't have any ports! (er=
r -19)
[    2.749582] fbcon: Taking over console
[    2.749652] usbcore: registered new interface driver usbserial_generic
[    2.749654] usbserial: USB Serial support registered for generic
[    2.749687] rtc_cmos 00:02: RTC can wake from S4
[    2.749832] rtc_cmos 00:02: registered as rtc0
[    2.749862] rtc_cmos 00:02: setting system clock to 2025-02-12T16:38:54 =
UTC (1739378334)
[    2.749877] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
[    2.750655] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 o=
n minor 0
[    2.751270] Console: switching to colour frame buffer device 160x45
[    2.751871] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    2.752203] hid: raw HID events driver (C) Jiri Kosina
[    2.752228] drop_monitor: Initializing network drop monitor service
[    2.752281] NET: Registered PF_INET6 protocol family
[    2.755671] Segment Routing with IPv6
[    2.755671] RPL Segment Routing with IPv6
[    2.755674] In-situ OAM (IOAM) with IPv6
[    2.755683] NET: Registered PF_PACKET protocol family
[    2.756221] microcode: Current revision: 0x0b404023
[    2.756379] resctrl: L3 allocation detected
[    2.756379] resctrl: MB allocation detected
[    2.756379] resctrl: SMBA allocation detected
[    2.756380] resctrl: L3 monitoring detected
[    2.756389] IPI shorthand broadcast: enabled
[    2.756965] sched_clock: Marking stable (2755985201, 390481)->(275972100=
3, -3345321)
[    2.757030] registered taskstats version 1
[    2.757204] Loading compiled-in X.509 certificates
[    2.759466] Loaded X.509 cert 'Build time autogenerated kernel key: b1f6=
2fe9cf89f4cd0db529523a536caf3ee0a2e1'
[    2.760766] zswap: loaded using pool zstd/zsmalloc
[    2.760785] Demotion targets for Node 0: null
[    2.760824] Key type .fscrypt registered
[    2.760825] Key type fscrypt-provisioning registered
[    2.760909] integrity: Loading X.509 certificate: UEFI:db
[    2.762216] integrity: Loaded X.509 cert 'Database Key: 00947180a7e14d58=
a351b3cecc2879b4ad'
[    2.762216] integrity: Loading X.509 certificate: UEFI:db
[    2.762223] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    2.762224] integrity: Loading X.509 certificate: UEFI:db
[    2.762229] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    2.762376] PM:   Magic number: 13:155:641
[    2.763740] RAS: Correctable Errors collector initialized.
[    2.768309] clk: Disabling unused clocks
[    2.768312] PM: genpd: Disabling unused power domains
[    2.866945] pci_bus 0000:04: Allocating resources
[    2.931343] ata1: SATA link down (SStatus 0 SControl 330)
[    2.987338] usb 1-1: new full-speed USB device number 2 using xhci_hcd
[    3.047364] usb 3-7: new full-speed USB device number 2 using xhci_hcd
[    3.050710] usb 5-2: new high-speed USB device number 2 using xhci_hcd
[    3.084017] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.084644] ata7.00: ATA-11: WDC  WDS400T2B0A-00SM50, 415020WD, max UDMA=
/133
[    3.085203] ata7.00: 7814037168 sectors, multi 1: LBA48 NCQ (depth 32), =
AA
[    3.089243] ata7.00: Features: Dev-Sleep
[    3.094981] ata7.00: configured for UDMA/133
[    3.237834] ata2: SATA link down (SStatus 0 SControl 330)
[    3.245557] usb 5-2: New USB device found, idVendor=3D2e1a, idProduct=3D=
4c01, bcdDevice=3D 2.00
[    3.245562] usb 5-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.245563] usb 5-2: Product: Insta360 Link
[    3.245563] usb 5-2: Manufacturer: Insta360
[    3.363887] usb 1-1: New USB device found, idVendor=3D1038, idProduct=3D=
2202, bcdDevice=3D 1.11
[    3.363894] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.363895] usb 1-1: Product: Arctis Nova 7
[    3.363896] usb 1-1: Manufacturer: SteelSeries
[    3.471581] usb 3-7: New USB device found, idVendor=3D048d, idProduct=3D=
5711, bcdDevice=3D 0.03
[    3.471588] usb 3-7: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.471590] usb 3-7: Product: GIGABYTE Device=20
[    3.471591] usb 3-7: Manufacturer: ITE Tech. Inc.
[    3.545976] ata3: SATA link down (SStatus 0 SControl 330)
[    3.557376] usb 1-2: new full-speed USB device number 3 using xhci_hcd
[    3.687343] usb 3-9: new full-speed USB device number 3 using xhci_hcd
[    3.856313] ata4: SATA link down (SStatus 0 SControl 330)
[    3.856506] scsi 6:0:0:0: Direct-Access     ATA      WDC  WDS400T2B0A 20=
WD PQ: 0 ANSI: 5
[    3.856695] sd 6:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 =
TB/3.64 TiB)
[    3.856700] sd 6:0:0:0: [sda] Write Protect is off
[    3.856702] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.856707] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    3.856716] sd 6:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    3.877323]  sda: sda1
[    3.877391] sd 6:0:0:0: [sda] Attached SCSI disk
[    3.929893] usb 1-2: New USB device found, idVendor=3D046d, idProduct=3D=
c547, bcdDevice=3D 4.02
[    3.929900] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.929901] usb 1-2: Product: USB Receiver
[    3.929902] usb 1-2: Manufacturer: Logitech
[    3.996629] usb 3-9: New USB device found, idVendor=3D0909, idProduct=3D=
001a, bcdDevice=3D 1.00
[    3.996635] usb 3-9: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    3.996637] usb 3-9: Product: ATR USB microphone=20
[    3.996638] usb 3-9: Manufacturer: Audio-Technica
[    4.127422] usb 1-6: new high-speed USB device number 4 using xhci_hcd
[    4.184013] usb 3-12: new full-speed USB device number 4 using xhci_hcd
[    4.320784] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.321795] ata8.00: ATA-9: SanDisk SDSSDHII960G, X31200RL, max UDMA/133
[    4.321844] ata8.00: 1875385008 sectors, multi 1: LBA48 NCQ (depth 32), =
AA
[    4.322813] ata8.00: Features: Dev-Sleep
[    4.324483] ata8.00: configured for UDMA/133
[    4.324621] scsi 7:0:0:0: Direct-Access     ATA      SanDisk SDSSDHII 00=
RL PQ: 0 ANSI: 5
[    4.324815] sd 7:0:0:0: [sdb] 1875385008 512-byte logical blocks: (960 G=
B/894 GiB)
[    4.324821] sd 7:0:0:0: [sdb] Write Protect is off
[    4.324822] sd 7:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    4.324829] sd 7:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    4.324842] sd 7:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[    4.341803]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5
[    4.341886] sd 7:0:0:0: [sdb] Attached SCSI disk
[    4.350102] usb 1-6: New USB device found, idVendor=3D0489, idProduct=3D=
e124, bcdDevice=3D 1.00
[    4.350105] usb 1-6: New USB device strings: Mfr=3D5, Product=3D6, Seria=
lNumber=3D7
[    4.350106] usb 1-6: Product: Wireless_Device
[    4.350107] usb 1-6: Manufacturer: MediaTek Inc.
[    4.350107] usb 1-6: SerialNumber: 000000000
[    4.560625] usb 3-12: New USB device found, idVendor=3D046d, idProduct=
=3Dc548, bcdDevice=3D 5.02
[    4.560632] usb 3-12: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D0
[    4.560633] usb 3-12: Product: USB Receiver
[    4.560634] usb 3-12: Manufacturer: Logitech
[    4.632678] ata9: SATA link down (SStatus 0 SControl 300)
[    4.943973] ata10: SATA link down (SStatus 0 SControl 300)
[    4.944675] Freeing unused decrypted memory: 2028K
[    4.944957] Freeing unused kernel image (initmem) memory: 3564K
[    4.944962] Write protecting the kernel read-only data: 32768k
[    4.945086] Freeing unused kernel image (rodata/data gap) memory: 228K
[    4.962930] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.962934] rodata_test: all tests were successful
[    4.962937] Run /init as init process
[    4.962938]   with arguments:
[    4.962939]     /init
[    4.962939]   with environment:
[    4.962939]     HOME=3D/
[    4.962940]     TERM=3Dlinux
[    4.962940]     BOOT_IMAGE=3D/@/boot/vmlinuz-linux
[    4.967263] systemd[1]: Successfully made /usr/ read-only.
[    4.967357] systemd[1]: systemd 257.2-2-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[    4.967359] systemd[1]: Detected architecture x86-64.
[    4.967359] systemd[1]: Running in initrd.
[    4.967457] systemd[1]: Initializing machine ID from random generator.
[    5.016789] systemd[1]: Queued start job for default target Initrd Defau=
lt Target.
[    5.017842] systemd[1]: Expecting device /dev/disk/by-uuid/04de5227-e261=
-4049-9f7b-6c95c0e36ef9...
[    5.017934] systemd[1]: Reached target Path Units.
[    5.017970] systemd[1]: Reached target Slice Units.
[    5.018006] systemd[1]: Reached target Swaps.
[    5.018035] systemd[1]: Reached target Timer Units.
[    5.018100] systemd[1]: Listening on Journal Socket (/dev/log).
[    5.018148] systemd[1]: Listening on Journal Sockets.
[    5.018196] systemd[1]: Listening on udev Control Socket.
[    5.018237] systemd[1]: Listening on udev Kernel Socket.
[    5.018269] systemd[1]: Reached target Socket Units.
[    5.018693] systemd[1]: Starting Create List of Static Device Nodes...
[    5.018770] systemd[1]: Check battery level during early boot was skippe=
d because of an unmet condition check (ConditionDirectoryNotEmpty=3D/sys/cl=
ass/power_supply).
[    5.019119] systemd[1]: Started Display Boot-Time Emergency Messages In =
Full Screen.
[    5.019692] systemd[1]: Starting Journal Service...
[    5.019962] systemd[1]: Starting Load Kernel Modules...
[    5.020010] systemd[1]: TPM PCR Barrier (initrd) was skipped because of =
an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    5.020189] systemd[1]: Starting Create Static Device Nodes in /dev...
[    5.020516] systemd[1]: Starting Coldplug All udev Devices...
[    5.020754] systemd[1]: Finished Create List of Static Device Nodes.
[    5.022523] systemd[1]: Finished Load Kernel Modules.
[    5.022888] systemd[1]: Finished Create Static Device Nodes in /dev.
[    5.023030] systemd[1]: Reached target Preparation for Local File System=
s.
[    5.023081] systemd[1]: Reached target Local File Systems.
[    5.023524] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[    5.025652] systemd-journald[243]: Collecting audit messages is disabled.
[    5.030545] systemd[1]: Started Rule-based Manager for Device Events and=
 Files.
[    5.052188] systemd[1]: Started Journal Service.
[    5.085433] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  p=
ost: no)
[    5.085695] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/device:20/LNXVIDEO:00/input/input2
[    5.091993] nvme 0000:02:00.0: platform quirk: setting simple suspend
[    5.092027] nvme nvme0: pci function 0000:02:00.0
[    5.096011] nvme nvme0: D3 entry latency set to 10 seconds
[    5.098937] nvme nvme0: 16/0/0 default/read/poll queues
[    5.100762]  nvme0n1: p1 p2 p3
[    5.108971] raid6: skipped pq benchmark and selected avx512x4
[    5.108973] raid6: using avx512x2 recovery algorithm
[    5.111135] xor: automatically using best checksumming function   avx   =
   =20
[    5.151249] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    5.198356] usbcore: registered new interface driver usbhid
[    5.198358] usbhid: USB HID core driver
[    5.205093] hid-generic 0003:1038:2202.0001: hiddev96,hidraw0: USB HID v=
1.11 Device [SteelSeries Arctis Nova 7] on usb-0000:11:00.0-1/input3
[    5.205124] input: SteelSeries Arctis Nova 7 as /devices/pci0000:00/0000=
:00:02.1/0000:03:00.0/0000:04:08.0/0000:0a:00.0/0000:0b:0c.0/0000:11:00.0/u=
sb1/1-1/1-1:1.4/0003:1038:2202.0002/input/input3
[    5.257120] hid-generic 0003:1038:2202.0002: input,hidraw1: USB HID v1.1=
1 Device [SteelSeries Arctis Nova 7] on usb-0000:11:00.0-1/input4
[    5.257181] hid-generic 0003:1038:2202.0003: hiddev97,hidraw2: USB HID v=
1.11 Device [SteelSeries Arctis Nova 7] on usb-0000:11:00.0-1/input5
[    5.257250] hid-generic 0003:048D:5711.0004: hiddev98,hidraw3: USB HID v=
1.10 Device [ITE Tech. Inc. GIGABYTE Device ] on usb-0000:13:00.0-7/input0
[    5.257290] hid-generic 0003:048D:5711.0005: hiddev99,hidraw4: USB HID v=
1.10 Device [ITE Tech. Inc. GIGABYTE Device ] on usb-0000:13:00.0-7/input1
[    5.257330] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
02.1/0000:03:00.0/0000:04:08.0/0000:0a:00.0/0000:0b:0c.0/0000:11:00.0/usb1/=
1-2/1-2:1.0/0003:046D:C547.0006/input/input4
[    5.257356] hid-generic 0003:046D:C547.0006: input,hidraw5: USB HID v1.1=
1 Mouse [Logitech USB Receiver] on usb-0000:11:00.0-2/input0
[    5.257479] input: Logitech USB Receiver Keyboard as /devices/pci0000:00=
/0000:00:02.1/0000:03:00.0/0000:04:08.0/0000:0a:00.0/0000:0b:0c.0/0000:11:0=
0.0/usb1/1-2/1-2:1.1/0003:046D:C547.0007/input/input5
[    5.885937] [drm] amdgpu kernel modesetting enabled.
[    5.885948] amdgpu: vga_switcheroo: detected switching method \_SB_.PCI0=
=2EGP17.VGA_.ATPX handle
[    5.886009] amdgpu: ATPX version 1, functions 0x00000000
[    5.887146] hid-generic 0003:046D:C547.0007: input,hidraw6: USB HID v1.1=
1 Keyboard [Logitech USB Receiver] on usb-0000:11:00.0-2/input1
[    5.887208] hid-generic 0003:046D:C547.0008: hiddev100,hidraw7: USB HID =
v1.11 Device [Logitech USB Receiver] on usb-0000:11:00.0-2/input2
[    5.887259] input: Audio-Technica ATR USB microphone  Consumer Control a=
s /devices/pci0000:00/0000:00:02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/u=
sb3/3-9/3-9:1.3/0003:0909:001A.0009/input/input6
[    5.888976] amdgpu: Virtual CRAT table created for CPU
[    5.888981] amdgpu: Topology: Add CPU node
[    5.889050] amdgpu 0000:79:00.0: enabling device (0006 -> 0007)
[    5.889075] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0=
x13C0 0x1458:0xD000 0xCB).
[    5.889082] [drm] register mmio base: 0xDF100000
[    5.889082] [drm] register mmio size: 524288
[    5.890459] [drm] add ip block number 0 <nv_common>
[    5.890460] [drm] add ip block number 1 <gmc_v10_0>
[    5.890460] [drm] add ip block number 2 <navi10_ih>
[    5.890461] [drm] add ip block number 3 <psp>
[    5.890461] [drm] add ip block number 4 <smu>
[    5.890462] [drm] add ip block number 5 <dm>
[    5.890462] [drm] add ip block number 6 <gfx_v10_0>
[    5.890462] [drm] add ip block number 7 <sdma_v5_2>
[    5.890463] [drm] add ip block number 8 <vcn_v3_0>
[    5.890463] [drm] add ip block number 9 <jpeg_v3_0>
[    5.890471] amdgpu 0000:79:00.0: amdgpu: Fetched VBIOS from VFCT
[    5.890472] amdgpu: ATOM BIOS: 102-RAPHAEL-008
[    5.893038] amdgpu 0000:79:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re disabled as experimental (default)
[    5.893060] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    5.893063] amdgpu 0000:79:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 =
- 0x000000F47FFFFFFF (2048M used)
[    5.893064] amdgpu 0000:79:00.0: amdgpu: GART: 1024M 0x0000000000000000 =
- 0x000000003FFFFFFF
[    5.893069] [drm] Detected VRAM RAM=3D2048M, BAR=3D2048M
[    5.893069] [drm] RAM width 128bits DDR5
[    5.893112] [drm] amdgpu: 2048M of VRAM memory ready
[    5.893113] [drm] amdgpu: 30946M of GTT memory ready.
[    5.893121] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    5.893239] [drm] PCIE GART of 1024M enabled (table at 0x000000F47FC0000=
0).
[    5.893436] [drm] Loading DMUB firmware via PSP: version=3D0x05001C00
[    5.893642] [drm] use_doorbell being set to: [true]
[    5.893651] [drm] Found VCN firmware Version ENC: 1.31 DEC: 3 VEP: 0 Rev=
ision: 3
[    5.915549] amdgpu 0000:79:00.0: amdgpu: reserve 0xa00000 from 0xf47e000=
000 for PSP TMR
[    5.940455] hid-generic 0003:0909:001A.0009: input,hiddev101,hidraw8: US=
B HID v1.00 Device [Audio-Technica ATR USB microphone ] on usb-0000:13:00.0=
-9/input3
[    5.940530] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1.0/0003:046D:C5=
48.000A/input/input8
[    5.979786] amdgpu 0000:79:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    5.985240] amdgpu 0000:79:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
[    5.985240] amdgpu 0000:79:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[    5.987005] amdgpu 0000:79:00.0: amdgpu: SMU is initialized successfully!
[    5.987006] [drm] Seamless boot condition check passed
[    5.987292] [drm] Display Core v3.2.310 initialized on DCN 3.1.5
[    5.987293] [drm] DP-HDMI FRL PCON supported
[    5.987944] [drm] DMUB hardware initialized: version=3D0x05001C00
[    5.988911] [drm] kiq ring mec 2 pipe 1 q 0
[    5.991410] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    5.991414] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    5.992091] amdgpu: Virtual CRAT table created for GPU
[    5.992165] amdgpu: Topology: Add dGPU node [0x13c0:0x1002]
[    5.992166] kfd kfd: amdgpu: added device 1002:13c0
[    5.992172] amdgpu 0000:79:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 2,=
 active_cu_number 2
[    5.992174] amdgpu 0000:79:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on hub 0
[    5.992175] amdgpu 0000:79:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng =
1 on hub 0
[    5.992175] amdgpu 0000:79:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 4 on hub 0
[    5.992176] amdgpu 0000:79:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 5 on hub 0
[    5.992176] amdgpu 0000:79:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 6 on hub 0
[    5.992177] amdgpu 0000:79:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 7 on hub 0
[    5.992177] amdgpu 0000:79:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 8 on hub 0
[    5.992177] amdgpu 0000:79:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 9 on hub 0
[    5.992178] amdgpu 0000:79:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 10 on hub 0
[    5.992178] amdgpu 0000:79:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 11 on hub 0
[    5.992179] amdgpu 0000:79:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 12 on hub 0
[    5.992179] amdgpu 0000:79:00.0: amdgpu: ring sdma0 uses VM inv eng 13 o=
n hub 0
[    5.992179] amdgpu 0000:79:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on hub 8
[    5.992180] amdgpu 0000:79:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1 on hub 8
[    5.992180] amdgpu 0000:79:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4 on hub 8
[    5.992181] amdgpu 0000:79:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on hub 8
[    5.992364] amdgpu 0000:79:00.0: amdgpu: Runtime PM not available
[    5.992497] [drm] Initialized amdgpu 3.59.0 for 0000:79:00.0 on minor 1
[    5.995349] amdgpu 0000:79:00.0: [drm] Cannot find any crtc or sizes
[    5.995356] [drm] pre_validate_dsc:1600 MST_DSC dsc precompute is not ne=
eded
[    6.060984] BTRFS: device fsid 04de5227-e261-4049-9f7b-6c95c0e36ef9 devi=
d 1 transid 1260494 /dev/nvme0n1p2 (259:2) scanned by mount (358)
[    6.061125] BTRFS info (device nvme0n1p2): first mount of filesystem 04d=
e5227-e261-4049-9f7b-6c95c0e36ef9
[    6.061132] BTRFS info (device nvme0n1p2): using crc32c (crc32c-intel) c=
hecksum algorithm
[    6.061136] BTRFS info (device nvme0n1p2): using free-space-tree
[    6.150462] hid-generic 0003:046D:C548.000A: input,hidraw9: USB HID v1.1=
1 Keyboard [Logitech USB Receiver] on usb-0000:13:00.0-12/input0
[    6.150593] input: Logitech USB Receiver Mouse as /devices/pci0000:00/00=
00:00:02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1.1/0003:0=
46D:C548.000B/input/input9
[    6.150633] input: Logitech USB Receiver Consumer Control as /devices/pc=
i0000:00/0000:00:02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12=
:1.1/0003:046D:C548.000B/input/input10
[    6.203782] input: Logitech USB Receiver System Control as /devices/pci0=
000:00/0000:00:02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1=
=2E1/0003:046D:C548.000B/input/input11
[    6.203809] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1.1/0003:046D:C5=
48.000B/input/input12
[    6.203856] hid-generic 0003:046D:C548.000B: input,hiddev102,hidraw10: U=
SB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:13:00.0-12/input1
[    6.203915] hid-generic 0003:046D:C548.000C: hiddev103,hidraw11: USB HID=
 v1.11 Device [Logitech USB Receiver] on usb-0000:13:00.0-12/input2
[    6.203993] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1.3/0003:046D:C5=
48.000D/input/input13
[    6.204016] hid-generic 0003:046D:C548.000D: input,hidraw12: USB HID v1.=
11 Device [Logitech USB Receiver] on usb-0000:13:00.0-12/input3
[    6.242408] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1.3/0003:046D:C5=
48.000D/input/input14
[    6.242455] hid-multitouch 0003:046D:C548.000D: input,hidraw12: USB HID =
v1.11 Device [Logitech USB Receiver] on usb-0000:13:00.0-12/input3
[    6.544413] systemd-journald[243]: Received SIGTERM from PID 1 (systemd).
[    6.585029] systemd[1]: systemd 257.2-2-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[    6.585032] systemd[1]: Detected architecture x86-64.
[    6.585832] systemd[1]: Hostname set to <arch-desktop>.
[    6.800450] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    7.001917] systemd[1]: initrd-switch-root.service: Deactivated successf=
ully.
[    7.001975] systemd[1]: Stopped Switch Root.
[    7.002454] systemd[1]: systemd-journald.service: Scheduled restart job,=
 restart counter is at 1.
[    7.002786] systemd[1]: Created slice Slice /system/dirmngr.
[    7.003022] systemd[1]: Created slice Slice /system/getty.
[    7.003236] systemd[1]: Created slice Slice /system/gpg-agent.
[    7.003446] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    7.003652] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    7.004170] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    7.004625] systemd[1]: Created slice Slice /system/keyboxd.
[    7.004915] systemd[1]: Created slice Slice /system/modprobe.
[    7.005118] systemd[1]: Created slice Slice /system/systemd-fsck.
[    7.005274] systemd[1]: Created slice User and Session Slice.
[    7.005365] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    7.005478] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    7.005618] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    7.005697] systemd[1]: Expecting device /dev/disk/by-diskseq/3-part3...
[    7.005770] systemd[1]: Expecting device /dev/disk/by-uuid/04de5227-e261=
-4049-9f7b-6c95c0e36ef9...
[    7.005845] systemd[1]: Expecting device /dev/disk/by-uuid/4FD8-5055...
[    7.005919] systemd[1]: Expecting device /dev/disk/by-uuid/b9ab1ed9-97e5=
-49c6-9f67-027e90edfbd7...
[    7.005997] systemd[1]: Reached target Local Encrypted Volumes.
[    7.006075] systemd[1]: Reached target Login Prompts.
[    7.006157] systemd[1]: Stopped target Switch Root.
[    7.006237] systemd[1]: Stopped target Initrd File Systems.
[    7.006314] systemd[1]: Stopped target Initrd Root File System.
[    7.006393] systemd[1]: Reached target Local Integrity Protected Volumes.
[    7.006478] systemd[1]: Reached target Path Units.
[    7.006558] systemd[1]: Reached target Remote File Systems.
[    7.006635] systemd[1]: Reached target Slice Units.
[    7.006720] systemd[1]: Reached target Local Verity Protected Volumes.
[    7.006824] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.006937] systemd[1]: Listening on LVM2 poll daemon socket.
[    7.008811] systemd[1]: Listening on Process Core Dump Socket.
[    7.009622] systemd[1]: Listening on Credential Encryption/Decryption.
[    7.010192] systemd[1]: TPM PCR Measurements was skipped because of an u=
nmet condition check (ConditionSecurity=3Dmeasured-uki).
[    7.010200] systemd[1]: Make TPM PCR Policy was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    7.010221] systemd[1]: Listening on udev Control Socket.
[    7.010788] systemd[1]: Listening on udev Kernel Socket.
[    7.012081] systemd[1]: Mounting Huge Pages File System...
[    7.012605] systemd[1]: Mounting POSIX Message Queue File System...
[    7.013048] systemd[1]: Mounting Kernel Debug File System...
[    7.013525] systemd[1]: Mounting Kernel Trace File System...
[    7.014613] systemd[1]: Starting Create List of Static Device Nodes...
[    7.015386] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    7.015979] systemd[1]: Starting Load Kernel Module configfs...
[    7.016825] systemd[1]: Starting Load Kernel Module dm_mod...
[    7.017241] systemd[1]: Starting Load Kernel Module drm...
[    7.017688] systemd[1]: Starting Load Kernel Module fuse...
[    7.018083] systemd[1]: Starting Load Kernel Module loop...
[    7.018213] systemd[1]: systemd-fsck-root.service: Deactivated successfu=
lly.
[    7.018240] systemd[1]: Stopped File System Check on Root Device.
[    7.018361] systemd[1]: Clear Stale Hibernate Storage Info was skipped b=
ecause of an unmet condition check (ConditionPathExists=3D/sys/firmware/efi=
/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    7.018982] systemd[1]: Starting Journal Service...
[    7.019815] systemd[1]: Starting Load Kernel Modules...
[    7.020256] systemd[1]: TPM PCR Machine ID Measurement was skipped becau=
se of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    7.020608] systemd[1]: Starting Remount Root and Kernel File Systems...
[    7.020731] systemd[1]: Early TPM SRK Setup was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    7.021075] systemd[1]: Starting Load udev Rules from Credentials...
[    7.021935] systemd[1]: Starting Coldplug All udev Devices...
[    7.022359] loop: module loaded
[    7.022902] systemd[1]: Mounted Huge Pages File System.
[    7.023444] systemd[1]: Mounted POSIX Message Queue File System.
[    7.023611] systemd[1]: Mounted Kernel Debug File System.
[    7.023770] device-mapper: uevent: version 1.0.3
[    7.023844] systemd[1]: Mounted Kernel Trace File System.
[    7.023918] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    7.024057] systemd[1]: Finished Create List of Static Device Nodes.
[    7.024272] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    7.024327] systemd[1]: Finished Load Kernel Module configfs.
[    7.024494] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    7.024544] systemd[1]: Finished Load Kernel Module dm_mod.
[    7.024751] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    7.024803] systemd[1]: Finished Load Kernel Module drm.
[    7.024950] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    7.024991] systemd[1]: Finished Load Kernel Module fuse.
[    7.025120] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    7.025156] systemd[1]: Finished Load Kernel Module loop.
[    7.035327] systemd[1]: Mounting FUSE Control File System...
[    7.035940] systemd[1]: Mounting Kernel Configuration File System...
[    7.036046] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    7.036387] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    7.036728] systemd[1]: Finished Load udev Rules from Credentials.
[    7.036768] systemd-journald[432]: Collecting audit messages is disabled.
[    7.037210] systemd[1]: Mounted FUSE Control File System.
[    7.037433] i2c_dev: i2c /dev entries driver
[    7.037882] systemd[1]: Mounted Kernel Configuration File System.
[    7.038653] systemd[1]: Started Journal Service.
[    7.099138] BTRFS info (device nvme0n1p2 state M): force zstd compressio=
n, level 2
[    7.239161] mousedev: PS/2 mouse device common for all mice
[    7.243879] nvidia: loading out-of-tree module taints kernel.
[    7.243884] nvidia: module license 'NVIDIA' taints kernel.
[    7.243885] Disabling lock debugging due to kernel taint
[    7.243886] nvidia: module verification failed: signature and/or require=
d key missing - tainting kernel
[    7.243887] nvidia: module license taints kernel.
[    7.247334] Adding 33553404k swap on /dev/nvme0n1p3.  Priority:-2 extent=
s:1 across:33553404k SS
[    7.250358] mc: Linux media interface: v0.10
[    7.272642] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840=
 ms ovfl timer
[    7.272645] RAPL PMU: hw unit of domain package 2^-16 Joules
[    7.272713] ccp 0000:79:00.2: enabling device (0000 -> 0002)
[    7.273262] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    7.273341] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    7.273406] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    7.273777] platform regulatory.0: Direct firmware load for regulatory.d=
b failed with error -2
[    7.273779] cfg80211: failed to load regulatory.db
[    7.274032] ccp 0000:79:00.2: tee enabled
[    7.274202] ccp 0000:79:00.2: psp enabled
[    7.275017] input: PC Speaker as /devices/platform/pcspkr/input/input15
[    7.275020] ACPI: bus type thunderbolt registered
[    7.275045] thunderbolt 0000:78:00.0: enabling device (0000 -> 0002)
[    7.276402] videodev: Linux video capture interface: v2.00
[    7.439326] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000=
000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\GSA1=
=2ESMBI) (20240827/utaddress-204)
[    7.439332] ACPI: OSL: Resource conflict; ACPI support missing from driv=
er?
[    7.440561] nvidia-nvlink: Nvlink Core is being initialized, major devic=
e number 235

[    7.441162] nvidia 0000:01:00.0: vgaarb: VGA decodes changed: olddecodes=
=3Dio+mem,decodes=3Dnone:owns=3Dnone
[    7.447903] cryptd: max_cpu_qlen set to 1000
[    7.448035] Bluetooth: Core ver 2.22
[    7.448043] NET: Registered PF_BLUETOOTH protocol family
[    7.448043] Bluetooth: HCI device and connection manager initialized
[    7.448045] Bluetooth: HCI socket layer initialized
[    7.448046] Bluetooth: L2CAP socket layer initialized
[    7.448047] Bluetooth: SCO socket layer initialized
[    7.453509] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    7.453547] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO ad=
dress
[    7.453589] sp5100-tco sp5100-tco: initialized. heartbeat=3D60 sec (nowa=
yout=3D0)
[    7.458721] r8169 0000:0e:00.0 eth0: RTL8125D, 10:ff:e0:6a:b0:50, XID 68=
8, IRQ 141
[    7.458724] r8169 0000:0e:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    7.465351] r8169 0000:0e:00.0 enp14s0: renamed from eth0
[    7.471046] AES CTR mode by8 optimization enabled
[    7.476737] usb 5-2: Found UVC 1.10 device Insta360 Link (2e1a:4c01)
[    7.478711] usbcore: registered new interface driver btusb
[    7.481854] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[    7.481889] snd_hda_intel 0000:01:00.1: Disabling MSI
[    7.481892] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio clie=
nt
[    7.481962] snd_hda_intel 0000:79:00.1: enabling device (0000 -> 0002)
[    7.481986] snd_hda_intel 0000:79:00.1: Handle vga_switcheroo audio clie=
nt
[    7.482005] snd_hda_intel 0000:79:00.6: enabling device (0000 -> 0002)
[    7.483054] usbcore: registered new interface driver uvcvideo
[    7.484464] mt7925e 0000:0d:00.0: enabling device (0000 -> 0002)
[    7.487622] snd_hda_intel 0000:79:00.1: bound 0000:79:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[    7.488353] mt7925e 0000:0d:00.0: ASIC revision: 79250000
[    7.489560] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  565.77  Wed =
Nov 27 23:33:08 UTC 2024
[    7.492131] usb 5-2: Warning! Unlikely big volume range (=3D32767), cval=
->res is probably wrong.
[    7.492133] usb 5-2: [9] FU [Mic Capture Volume] ch =3D 1, val =3D -3276=
8/-1/1
[    7.498842] nvidia_uvm: module uses symbols nvUvmInterfaceDisableAccessC=
ntr from proprietary module nvidia, inheriting taint.
[    7.505761] input: HDA NVidia HDMI/DP,pcm=3D3 as /devices/pci0000:00/000=
0:00:01.1/0000:01:00.1/sound/card0/input20
[    7.505784] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:08.1/0000:79:00.1/sound/card1/input16
[    7.505808] input: HDA NVidia HDMI/DP,pcm=3D7 as /devices/pci0000:00/000=
0:00:01.1/0000:01:00.1/sound/card0/input21
[    7.505822] input: HD-Audio Generic HDMI/DP,pcm=3D7 as /devices/pci0000:=
00/0000:00:08.1/0000:79:00.1/sound/card1/input17
[    7.505861] input: HDA NVidia HDMI/DP,pcm=3D8 as /devices/pci0000:00/000=
0:00:01.1/0000:01:00.1/sound/card0/input22
[    7.505876] input: HD-Audio Generic HDMI/DP,pcm=3D8 as /devices/pci0000:=
00/0000:00:08.1/0000:79:00.1/sound/card1/input18
[    7.505903] input: HD-Audio Generic HDMI/DP,pcm=3D9 as /devices/pci0000:=
00/0000:00:08.1/0000:79:00.1/sound/card1/input19
[    7.505918] input: HDA NVidia HDMI/DP,pcm=3D9 as /devices/pci0000:00/000=
0:00:01.1/0000:01:00.1/sound/card0/input23
[    7.563703] mt7925e 0000:0d:00.0: HW/SW Version: 0x8a108a10, Build Time:=
 20241104132949a

[    7.603992] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver fo=
r UNIX platforms  565.77  Wed Nov 27 22:53:48 UTC 2024
[    7.604188] nvidia-uvm: Loaded the UVM driver, major device number 511.
[    7.605150] snd_hda_codec_realtek hdaudioC2D0: autoconfig for ALC1220: l=
ine_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    7.605154] snd_hda_codec_realtek hdaudioC2D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    7.605155] snd_hda_codec_realtek hdaudioC2D0:    hp_outs=3D1 (0x1b/0x0/=
0x0/0x0/0x0)
[    7.605157] snd_hda_codec_realtek hdaudioC2D0:    mono: mono_out=3D0x0
[    7.605157] snd_hda_codec_realtek hdaudioC2D0:    dig-out=3D0x1e/0x0
[    7.605158] snd_hda_codec_realtek hdaudioC2D0:    inputs:
[    7.605159] snd_hda_codec_realtek hdaudioC2D0:      Front Mic=3D0x19
[    7.605160] snd_hda_codec_realtek hdaudioC2D0:      Rear Mic=3D0x18
[    7.606983] Asymmetric key parser 'pkcs8' registered
[    7.607075] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[    7.608843] kvm_amd: TSC scaling supported
[    7.608844] kvm_amd: Nested Virtualization enabled
[    7.608845] kvm_amd: Nested Paging enabled
[    7.608845] kvm_amd: LBR virtualization supported
[    7.608847] kvm_amd: Virtual VMLOAD VMSAVE supported
[    7.608847] kvm_amd: Virtual GIF supported
[    7.608847] kvm_amd: Virtual NMI enabled
[    7.615152] input: HD-Audio Generic Front Mic as /devices/pci0000:00/000=
0:00:08.1/0000:79:00.6/sound/card2/input24
[    7.615176] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000=
:00:08.1/0000:79:00.6/sound/card2/input25
[    7.615191] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000=
:00:08.1/0000:79:00.6/sound/card2/input26
[    7.615205] input: HD-Audio Generic Front Headphone as /devices/pci0000:=
00/0000:00:08.1/0000:79:00.6/sound/card2/input27
[    7.629826] Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 2024=
1104133214
[    7.714435] intel_rapl_common: Found RAPL domain package
[    7.714437] intel_rapl_common: Found RAPL domain core
[    7.714617] amd_atl: AMD Address Translation Library initialized
[    7.864513] usbcore: registered new interface driver snd-usb-audio
[    7.902155] mt7925e 0000:0d:00.0: WM Firmware Version: ____000000, Build=
 Time: 20241104133053
[    8.474888] BTRFS: device label storage1 devid 1 transid 354709 /dev/sda=
1 (8:1) scanned by mount (651)
[    8.475165] BTRFS info (device sda1): first mount of filesystem b9ab1ed9=
-97e5-49c6-9f67-027e90edfbd7
[    8.475170] BTRFS info (device sda1): using crc32c (crc32c-intel) checks=
um algorithm
[    8.475172] BTRFS info (device sda1): using free-space-tree
[    8.478977] systemd-journald[432]: Received client request to flush runt=
ime journal.
[    8.516153] [drm] Initialized nvidia-drm 0.0.0 for 0000:01:00.0 on minor=
 2
[    8.516156] nvidia-drm: using linux/aperture workaround for Linux 6.13+
[    8.530468] Console: switching to colour dummy device 80x25
[    8.594036] nvidia 0000:01:00.0: vgaarb: deactivate vga console
[    8.657878] fbcon: nvidia-drmdrmfb (fb0) is primary device
[    8.992768] Console: switching to colour frame buffer device 240x67
[    9.012296] nvidia 0000:01:00.0: [drm] fb0: nvidia-drmdrmfb frame buffer=
 device
[    9.344154] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.344157] Bluetooth: BNEP filters: protocol multicast
[    9.344160] Bluetooth: BNEP socket layer initialized
[    9.597081] Realtek Internal NBASE-T PHY r8169-0-e00:00: attached PHY dr=
iver (mii_bus:phy_addr=3Dr8169-0-e00:00, irq=3DMAC)
[   11.790864] r8169 0000:0e:00.0 enp14s0: Link is Down
[   17.862437] nvme nvme0: using unchecked data buffer
[   19.597713] ahci 0000:14:00.0: port does not support device sleep
[   19.608731] ahci 0000:14:00.0: port does not support device sleep
[   19.623690] warning: `kdeconnectd' uses wireless extensions which will s=
top working for Wi-Fi 7 hardware; use nl80211
[   24.750030] wlan0: authenticate with e8:9f:80:e7:36:be (local address=3D=
44:fa:66:66:57:a9)
[   25.117477] wlan0: send auth to e8:9f:80:e7:36:be (try 1/3)
[   25.150170] wlan0: authenticate with e8:9f:80:e7:36:be (local address=3D=
44:fa:66:66:57:a9)
[   25.163298] wlan0: send auth to e8:9f:80:e7:36:be (try 1/3)
[   25.166475] wlan0: authenticated
[   25.167061] wlan0: associate with e8:9f:80:e7:36:be (try 1/3)
[   25.184422] wlan0: RX AssocResp from e8:9f:80:e7:36:be (capab=3D0x111 st=
atus=3D0 aid=3D2)
[   25.212987] wlan0: associated
[   25.574618] wlan0: Limiting TX power to 21 (24 - 3) dBm as advertised by=
 e8:9f:80:e7:36:be
[   26.117445] Bluetooth: hci0: Device setup in 18201864 usecs
[   26.117449] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.
[   26.286570] Bluetooth: hci0: AOSP extensions version v1.00
[   26.286575] Bluetooth: hci0: AOSP quality report is supported
[   26.286643] Bluetooth: MGMT ver 1.23
[   26.289988] NET: Registered PF_ALG protocol family
[   26.300806] Bluetooth: RFCOMM TTY layer initialized
[   26.300812] Bluetooth: RFCOMM socket layer initialized
[   26.300813] Bluetooth: RFCOMM ver 1.11

--lzlqbxrg6pxvnqvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_working.txt"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.13.1-1-00199-gff9da436ac13 (linux@archlinux)=
 (gcc (GCC) 14.2.1 20250207, GNU ld (GNU Binutils) 2.44) #1 SMP PREEMPT_DYN=
AMIC Wed, 12 Feb 2025 00:30:29 +0000
[    0.000000] Command line: BOOT_IMAGE=3D/@/boot/vmlinuz-linux root=3DUUID=
=3D04de5227-e261-4049-9f7b-6c95c0e36ef9 rw rootflags=3Dsubvol=3D@ nvidia.NV=
reg_EnableGpuFirmware=3D0
[    0.000000] x86/split lock detection: #DB: warning on user-space bus_loc=
ks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009afefff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009aff000-0x0000000009ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a21dfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000000a21e000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b020fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000000b021000-0x0000000088211fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000088212000-0x000000008e211fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000008e212000-0x000000008e47efff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000008e47f000-0x000000009047efff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000009047f000-0x00000000985fefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000985ff000-0x0000000099ff6fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000099ff7000-0x0000000099ffbfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000099ffc000-0x0000000099ffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000009a000000-0x000000009bffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000009d7f3000-0x000000009fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f7000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000fdde7ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000fdeec0000-0x00000010801fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x82039018-0x8205f457] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x8202a018-0x82038057] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x8201f018-0x82029e57] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009afef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009aff000-0x0000000009ffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000a000000-0x000000000a1fff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000a200000-0x000000000a21df=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000000a21e000-0x000000000affff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000b000000-0x000000000b020f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000b021000-0x000000008201f0=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000008201f018-0x0000000082029e=
57] usable
[    0.000000] reserve setup_data: [mem 0x0000000082029e58-0x000000008202a0=
17] usable
[    0.000000] reserve setup_data: [mem 0x000000008202a018-0x00000000820380=
57] usable
[    0.000000] reserve setup_data: [mem 0x0000000082038058-0x00000000820390=
17] usable
[    0.000000] reserve setup_data: [mem 0x0000000082039018-0x000000008205f4=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000008205f458-0x0000000088211f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000088212000-0x000000008e211f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000008e212000-0x000000008e47ef=
ff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000008e47f000-0x000000009047ef=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000009047f000-0x00000000985fef=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000985ff000-0x0000000099ff6f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000099ff7000-0x0000000099ffbf=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000099ffc000-0x0000000099ffff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000009a000000-0x000000009bffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009d7f3000-0x000000009fffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f7000000-0x00000000ffffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x0000000fdde7ff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000fdeec0000-0x00000010801fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000fd00000000-0x000000ffffffff=
ff] reserved
[    0.000000] efi: EFI v2.9 by American Megatrends
[    0.000000] efi: ACPI=3D0x90466000 ACPI 2.0=3D0x90466014 TPMFinalLog=3D0=
x90432000 SMBIOS=3D0x97ada000 SMBIOS 3.0=3D0x97ad9000 MEMATTR=3D0x844c5318 =
ESRT=3D0x84509c18 INITRD=3D0x810fe398 RNG=3D0x8e28d018 TPMEventLog=3D0x8e28=
6018=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem238: MMIO range=3D[0xe0000000-0xefffffff] (25=
6MB) from e820 map
[    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
[    0.000000] efi: Remove mem239: MMIO range=3D[0xf7000000-0xfedfffff] (12=
6MB) from e820 map
[    0.000000] e820: remove [mem 0xf7000000-0xfedfffff] reserved
[    0.000000] efi: Not removing mem240: MMIO range=3D[0xfee00000-0xfee00ff=
f] (4KB) from e820 map
[    0.000000] efi: Remove mem241: MMIO range=3D[0xfee01000-0xffffffff] (17=
MB) from e820 map
[    0.000000] e820: remove [mem 0xfee01000-0xffffffff] reserved
[    0.000000] efi: Remove mem243: MMIO range=3D[0x1060000000-0x10801fffff]=
 (514MB) from e820 map
[    0.000000] e820: remove [mem 0x1060000000-0x10801fffff] reserved
[    0.000000] SMBIOS 3.7.0 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. X870E AORUS ELITE WIFI7/X=
870E AORUS ELITE WIFI7, BIOS F3i 12/19/2024
[    0.000000] DMI: Memory slots populated: 2/4
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 4690.879 MHz processor
[    0.000110] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000111] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000117] last_pfn =3D 0xfdde80 max_arch_pfn =3D 0x400000000
[    0.000122] MTRR map: 5 entries (3 fixed + 2 variable; max 20), built fr=
om 9 variable MTRRs
[    0.000123] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000284] e820: update [mem 0xa0000000-0xffffffff] usable =3D=3D> rese=
rved
[    0.000289] last_pfn =3D 0x9a000 max_arch_pfn =3D 0x400000000
[    0.003215] esrt: Reserving ESRT space from 0x0000000084509c18 to 0x0000=
000084509c50.
[    0.003221] e820: update [mem 0x84509000-0x84509fff] usable =3D=3D> rese=
rved
[    0.003238] Using GB pages for direct mapping
[    0.003701] Secure boot enabled
[    0.003702] RAMDISK: [mem 0x7372d000-0x78e61fff]
[    0.003831] ACPI: Early table checksum verification disabled
[    0.003833] ACPI: RSDP 0x0000000090466014 000024 (v02 ALASKA)
[    0.003835] ACPI: XSDT 0x0000000090465728 00010C (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.003840] ACPI: FACP 0x000000008E467000 000114 (v06 ALASKA A M I    01=
072009 AMI  00010013)
[    0.003843] ACPI: DSDT 0x000000008E3EA000 07309A (v203 ALASKA A M I    0=
1072009 INTL 20230628)
[    0.003845] ACPI: FACS 0x0000000090462000 000040
[    0.003846] ACPI: HWIN 0x000000008E47E000 00006C (v00 GBT    AMD      00=
050000 AMI  01000013)
[    0.003847] ACPI: SSDT 0x000000008E472000 00B9E4 (v02 GBT    GSWApp   00=
000001 INTL 20230628)
[    0.003849] ACPI: SSDT 0x000000008E469000 00816C (v02 AMD    Splinter 00=
000002 MSFT 05000000)
[    0.003850] ACPI: SSDT 0x000000008E468000 000221 (v02 ALASKA CPUSSDT  01=
072009 AMI  01072009)
[    0.003851] ACPI: FIDT 0x000000008E461000 00009C (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.003853] ACPI: MCFG 0x000000008E460000 00003C (v01 ALASKA A M I    01=
072009 MSFT 00010013)
[    0.003854] ACPI: HPET 0x000000008E45F000 000038 (v01 ALASKA A M I    01=
072009 AMI  00000005)
[    0.003855] ACPI: FPDT 0x000000008E45E000 000044 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.003856] ACPI: VFCT 0x000000008E3DF000 00AE84 (v01 ALASKA A M I    00=
000001 AMD  33504F47)
[    0.003857] ACPI: BGRT 0x000000008E466000 000038 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.003858] ACPI: SSDT 0x000000008E3DA000 004DEE (v02 AMD    AMD CPU  00=
000001 AMD  00000001)
[    0.003860] ACPI: TPM2 0x000000008E465000 00004C (v04 ALASKA A M I    00=
000001 AMI  00000000)
[    0.003861] ACPI: WPBT 0x000000008E464000 000034 (v01 ALASKA A M I    00=
000001 GBT  24112800)
[    0.003862] ACPI: SSDT 0x000000008E2A9000 00D214 (v02 AMD    DISCUSB4 00=
000002 INTL 20230628)
[    0.003863] ACPI: SSDT 0x000000008E463000 0006D4 (v02 AMD    CPMWLRC  00=
000001 INTL 20230628)
[    0.003864] ACPI: SSDT 0x000000008E2A7000 00169E (v02 AMD    CPMDFIG2 00=
000001 INTL 20230628)
[    0.003865] ACPI: SSDT 0x000000008E2A4000 002AA6 (v02 AMD    CDFAAIG2 00=
000001 INTL 20230628)
[    0.003866] ACPI: SSDT 0x000000008E462000 00078F (v02 AMD    CPMDFDG1 00=
000001 INTL 20230628)
[    0.003867] ACPI: SSDT 0x000000008E29A000 0097C3 (v02 AMD    CPMCMN   00=
000001 INTL 20230628)
[    0.003868] ACPI: SSDT 0x000000008E297000 0029D1 (v02 AMD    AOD      00=
000001 INTL 20230628)
[    0.003870] ACPI: WSMT 0x000000008E296000 000028 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.003871] ACPI: APIC 0x000000008E295000 00015E (v06 ALASKA A M I    01=
072009 AMI  00010013)
[    0.003872] ACPI: IVRS 0x000000008E294000 0000C8 (v02 AMD    AmdTable 00=
000001 AMD  00000001)
[    0.003873] ACPI: SSDT 0x000000008E293000 000500 (v02 AMD    MEMTOOL0 00=
000002 INTL 20230628)
[    0.003874] ACPI: SSDT 0x000000008E292000 0009D0 (v02 AMD    CPMMSOSC 00=
000001 INTL 20230628)
[    0.003875] ACPI: SSDT 0x000000008E291000 00047C (v02 AMD    AMDWOV   00=
000001 INTL 20230628)
[    0.003876] ACPI: SSDT 0x000000008E28F000 001046 (v02 AMD    CPMACPV4 00=
000001 INTL 20230628)
[    0.003877] ACPI: SSDT 0x000000008E28E000 00053E (v01 AMD    CPMAPMFD 00=
000001 INTL 20230628)
[    0.003878] ACPI: Reserving FACP table memory at [mem 0x8e467000-0x8e467=
113]
[    0.003879] ACPI: Reserving DSDT table memory at [mem 0x8e3ea000-0x8e45d=
099]
[    0.003879] ACPI: Reserving FACS table memory at [mem 0x90462000-0x90462=
03f]
[    0.003880] ACPI: Reserving HWIN table memory at [mem 0x8e47e000-0x8e47e=
06b]
[    0.003880] ACPI: Reserving SSDT table memory at [mem 0x8e472000-0x8e47d=
9e3]
[    0.003880] ACPI: Reserving SSDT table memory at [mem 0x8e469000-0x8e471=
16b]
[    0.003880] ACPI: Reserving SSDT table memory at [mem 0x8e468000-0x8e468=
220]
[    0.003881] ACPI: Reserving FIDT table memory at [mem 0x8e461000-0x8e461=
09b]
[    0.003881] ACPI: Reserving MCFG table memory at [mem 0x8e460000-0x8e460=
03b]
[    0.003881] ACPI: Reserving HPET table memory at [mem 0x8e45f000-0x8e45f=
037]
[    0.003881] ACPI: Reserving FPDT table memory at [mem 0x8e45e000-0x8e45e=
043]
[    0.003882] ACPI: Reserving VFCT table memory at [mem 0x8e3df000-0x8e3e9=
e83]
[    0.003882] ACPI: Reserving BGRT table memory at [mem 0x8e466000-0x8e466=
037]
[    0.003882] ACPI: Reserving SSDT table memory at [mem 0x8e3da000-0x8e3de=
ded]
[    0.003882] ACPI: Reserving TPM2 table memory at [mem 0x8e465000-0x8e465=
04b]
[    0.003883] ACPI: Reserving WPBT table memory at [mem 0x8e464000-0x8e464=
033]
[    0.003883] ACPI: Reserving SSDT table memory at [mem 0x8e2a9000-0x8e2b6=
213]
[    0.003883] ACPI: Reserving SSDT table memory at [mem 0x8e463000-0x8e463=
6d3]
[    0.003883] ACPI: Reserving SSDT table memory at [mem 0x8e2a7000-0x8e2a8=
69d]
[    0.003884] ACPI: Reserving SSDT table memory at [mem 0x8e2a4000-0x8e2a6=
aa5]
[    0.003884] ACPI: Reserving SSDT table memory at [mem 0x8e462000-0x8e462=
78e]
[    0.003884] ACPI: Reserving SSDT table memory at [mem 0x8e29a000-0x8e2a3=
7c2]
[    0.003885] ACPI: Reserving SSDT table memory at [mem 0x8e297000-0x8e299=
9d0]
[    0.003885] ACPI: Reserving WSMT table memory at [mem 0x8e296000-0x8e296=
027]
[    0.003885] ACPI: Reserving APIC table memory at [mem 0x8e295000-0x8e295=
15d]
[    0.003885] ACPI: Reserving IVRS table memory at [mem 0x8e294000-0x8e294=
0c7]
[    0.003886] ACPI: Reserving SSDT table memory at [mem 0x8e293000-0x8e293=
4ff]
[    0.003886] ACPI: Reserving SSDT table memory at [mem 0x8e292000-0x8e292=
9cf]
[    0.003886] ACPI: Reserving SSDT table memory at [mem 0x8e291000-0x8e291=
47b]
[    0.003886] ACPI: Reserving SSDT table memory at [mem 0x8e28f000-0x8e290=
045]
[    0.003887] ACPI: Reserving SSDT table memory at [mem 0x8e28e000-0x8e28e=
53d]
[    0.003927] No NUMA configuration found
[    0.003927] Faking a node at [mem 0x0000000000000000-0x0000000fdde7ffff]
[    0.003929] NODE_DATA(0) allocated [mem 0xfdde7bec0-0xfdde7ffff]
[    0.003964] Zone ranges:
[    0.003965]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.003965]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.003966]   Normal   [mem 0x0000000100000000-0x0000000fdde7ffff]
[    0.003967]   Device   empty
[    0.003967] Movable zone start for each node
[    0.003967] Early memory node ranges
[    0.003967]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.003968]   node   0: [mem 0x0000000000100000-0x0000000009afefff]
[    0.003969]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.003969]   node   0: [mem 0x000000000a21e000-0x000000000affffff]
[    0.003969]   node   0: [mem 0x000000000b021000-0x0000000088211fff]
[    0.003969]   node   0: [mem 0x00000000985ff000-0x0000000099ff6fff]
[    0.003970]   node   0: [mem 0x0000000099ffc000-0x0000000099ffffff]
[    0.003970]   node   0: [mem 0x0000000100000000-0x0000000fdde7ffff]
[    0.003973] Initmem setup node 0 [mem 0x0000000000001000-0x0000000fdde7f=
fff]
[    0.003976] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.003983] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.004033] On node 0, zone DMA32: 1281 pages in unavailable ranges
[    0.004038] On node 0, zone DMA32: 30 pages in unavailable ranges
[    0.004698] On node 0, zone DMA32: 33 pages in unavailable ranges
[    0.004797] On node 0, zone DMA32: 33773 pages in unavailable ranges
[    0.004798] On node 0, zone DMA32: 5 pages in unavailable ranges
[    0.040694] On node 0, zone Normal: 24576 pages in unavailable ranges
[    0.040721] On node 0, zone Normal: 8576 pages in unavailable ranges
[    0.041509] ACPI: PM-Timer IO Port: 0x808
[    0.041516] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.041526] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0=
-23
[    0.041529] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 2=
4-55
[    0.041530] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.041531] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.041533] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.041534] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.041545] e820: update [mem 0x8405e000-0x840b4fff] usable =3D=3D> rese=
rved
[    0.041556] CPU topo: Max. logical packages:   1
[    0.041556] CPU topo: Max. logical dies:       1
[    0.041556] CPU topo: Max. dies per package:   1
[    0.041558] CPU topo: Max. threads per core:   2
[    0.041559] CPU topo: Num. cores per package:     8
[    0.041559] CPU topo: Num. threads per package:  16
[    0.041559] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    0.041570] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.041571] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000fffff]
[    0.041572] PM: hibernation: Registered nosave memory: [mem 0x09aff000-0=
x09ffffff]
[    0.041572] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0=
x0a21dfff]
[    0.041573] PM: hibernation: Registered nosave memory: [mem 0x0b000000-0=
x0b020fff]
[    0.041573] PM: hibernation: Registered nosave memory: [mem 0x8201f000-0=
x8201ffff]
[    0.041574] PM: hibernation: Registered nosave memory: [mem 0x82029000-0=
x82029fff]
[    0.041574] PM: hibernation: Registered nosave memory: [mem 0x8202a000-0=
x8202afff]
[    0.041575] PM: hibernation: Registered nosave memory: [mem 0x82038000-0=
x82038fff]
[    0.041575] PM: hibernation: Registered nosave memory: [mem 0x82039000-0=
x82039fff]
[    0.041576] PM: hibernation: Registered nosave memory: [mem 0x8205f000-0=
x8205ffff]
[    0.041576] PM: hibernation: Registered nosave memory: [mem 0x8405e000-0=
x840b4fff]
[    0.041577] PM: hibernation: Registered nosave memory: [mem 0x84509000-0=
x84509fff]
[    0.041577] PM: hibernation: Registered nosave memory: [mem 0x88212000-0=
x8e211fff]
[    0.041577] PM: hibernation: Registered nosave memory: [mem 0x8e212000-0=
x8e47efff]
[    0.041578] PM: hibernation: Registered nosave memory: [mem 0x8e47f000-0=
x9047efff]
[    0.041578] PM: hibernation: Registered nosave memory: [mem 0x9047f000-0=
x985fefff]
[    0.041578] PM: hibernation: Registered nosave memory: [mem 0x99ff7000-0=
x99ffbfff]
[    0.041579] PM: hibernation: Registered nosave memory: [mem 0x9a000000-0=
x9bffffff]
[    0.041579] PM: hibernation: Registered nosave memory: [mem 0x9c000000-0=
x9d7f2fff]
[    0.041579] PM: hibernation: Registered nosave memory: [mem 0x9d7f3000-0=
x9fffffff]
[    0.041580] PM: hibernation: Registered nosave memory: [mem 0xa0000000-0=
xfedfffff]
[    0.041580] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.041580] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.041581] [mem 0xa0000000-0xfedfffff] available for PCI devices
[    0.041582] Booting paravirtualized kernel on bare hardware
[    0.041583] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.044685] setup_percpu: NR_CPUS:320 nr_cpumask_bits:16 nr_cpu_ids:16 n=
r_node_ids:1
[    0.045064] percpu: Embedded 67 pages/cpu s237568 r8192 d28672 u524288
[    0.045067] pcpu-alloc: s237568 r8192 d28672 u524288 alloc=3D1*2097152
[    0.045068] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07=20
[    0.045070] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15=20
[    0.045078] Kernel command line: BOOT_IMAGE=3D/@/boot/vmlinuz-linux root=
=3DUUID=3D04de5227-e261-4049-9f7b-6c95c0e36ef9 rw rootflags=3Dsubvol=3D@ nv=
idia.NVreg_EnableGpuFirmware=3D0
[    0.045109] Unknown kernel command line parameters "BOOT_IMAGE=3D/@/boot=
/vmlinuz-linux", will be passed to user space.
[    0.045307] printk: log buffer data + meta data: 131072 + 458752 =3D 589=
824 bytes
[    0.047727] Dentry cache hash table entries: 8388608 (order: 14, 6710886=
4 bytes, linear)
[    0.048847] Inode-cache hash table entries: 4194304 (order: 13, 33554432=
 bytes, linear)
[    0.048899] Fallback order for Node 0: 0=20
[    0.048901] Built 1 zonelists, mobility grouping on.  Total pages: 16151=
789
[    0.048901] Policy zone: Normal
[    0.048978] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.049008] software IO TLB: area num 16.
[    0.103359] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, =
Nodes=3D1
[    0.103384] ftrace: allocating 51152 entries in 200 pages
[    0.121739] ftrace: allocated 200 pages with 3 groups
[    0.121779] Dynamic Preempt: full
[    0.121812] rcu: Preemptible hierarchical RCU implementation.
[    0.121812] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D16.
[    0.121813] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.121814] 	Trampoline variant of Tasks RCU enabled.
[    0.121814] 	Rude variant of Tasks RCU enabled.
[    0.121814] 	Tracing variant of Tasks RCU enabled.
[    0.121815] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.121815] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D16
[    0.121820] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D16.
[    0.121822] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.121822] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.123838] NR_IRQS: 20736, nr_irqs: 1096, preallocated irqs: 16
[    0.124011] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.124148] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.124166] Console: colour dummy device 80x25
[    0.124168] printk: legacy console [tty0] enabled
[    0.124193] ACPI: Core revision 20240827
[    0.124403] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.124415] APIC: Switch to symmetric I/O mode setup
[    0.124860] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
[    0.125617] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.141086] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x439dc53606d, max_idle_ns: 440795379278 ns
[    0.141088] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 9385.66 BogoMIPS (lpj=3D15636263)
[    0.141100] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.141158] LVT offset 1 assigned for vector 0xf9
[    0.141369] LVT offset 2 assigned for vector 0xf4
[    0.141431] Last level iTLB entries: 4KB 64, 2MB 64, 4MB 32
[    0.141432] Last level dTLB entries: 4KB 128, 2MB 128, 4MB 64, 1GB 0
[    0.141433] process: using mwait in idle threads
[    0.141434] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.141436] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.141436] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.141438] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.141439] Spectre V2 : User space: Mitigation: STIBP always-on protect=
ion
[    0.141439] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.141444] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.141445] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.141446] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.141446] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.141447] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.141447] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.141448] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.141448] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User =
registers'
[    0.141449] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.141450] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.141451] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.141451] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.141452] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.141452] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
[    0.141453] x86/fpu: Enabled xstate features 0xae7, context size is 2456=
 bytes, using 'compacted' format.
[    0.155146] Freeing SMP alternatives memory: 40K
[    0.155148] pid_max: default: 32768 minimum: 301
[    0.156718] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.156757] landlock: Up and running.
[    0.156759] Yama: becoming mindful.
[    0.156865] LSM support for eBPF active
[    0.156906] Mount-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)
[    0.156947] Mountpoint-cache hash table entries: 131072 (order: 8, 10485=
76 bytes, linear)
[    0.263845] smpboot: CPU0: AMD Ryzen 7 9800X3D 8-Core Processor (family:=
 0x1a, model: 0x44, stepping: 0x0)
[    0.263923] Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD P=
MU driver.
[    0.263939] ... version:                2
[    0.263939] ... bit width:              48
[    0.263940] ... generic registers:      6
[    0.263940] ... value mask:             0000ffffffffffff
[    0.263940] ... max period:             00007fffffffffff
[    0.263941] ... fixed-purpose events:   0
[    0.263941] ... event mask:             000000000000003f
[    0.263993] signal: max sigframe size: 3376
[    0.264006] rcu: Hierarchical SRCU implementation.
[    0.264006] rcu: 	Max phase no-delay instances is 1000.
[    0.264026] Timer migration: 2 hierarchy levels; 8 children per group; 2=
 crossnode level
[    0.264122] MCE: In-kernel MCE decoding enabled.
[    0.264139] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.264176] smp: Bringing up secondary CPUs ...
[    0.264211] smpboot: x86: Booting SMP configuration:
[    0.264212] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  =
#9 #10 #11 #12 #13 #14 #15
[    0.265112] Spectre V2 : Update user space SMT mitigation: STIBP always-=
on
[    0.265112] smp: Brought up 1 node, 16 CPUs
[    0.265112] smpboot: Total of 16 processors activated (150168.63 BogoMIP=
S)
[    0.265566] Memory: 63264168K/64607156K available (18432K kernel code, 2=
268K rwdata, 14108K rodata, 3564K init, 3112K bss, 1322908K reserved, 0K cm=
a-reserved)
[    0.267894] devtmpfs: initialized
[    0.267894] x86/mm: Memory block size: 128MB
[    0.269203] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a21=
dfff] (122880 bytes)
[    0.269203] ACPI: PM: Registering ACPI NVS region [mem 0x8e47f000-0x9047=
efff] (33554432 bytes)
[    0.269203] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.269203] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.269203] pinctrl core: initialized pinctrl subsystem
[    0.269203] PM: RTC time: 16:34:03, date: 2025-02-12
[    0.269203] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.269203] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.269203] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.269203] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.269203] audit: initializing netlink subsys (disabled)
[    0.269203] audit: type=3D2000 audit(1739378042.000:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.269203] thermal_sys: Registered thermal governor 'fair_share'
[    0.269203] thermal_sys: Registered thermal governor 'bang_bang'
[    0.269203] thermal_sys: Registered thermal governor 'step_wise'
[    0.269203] thermal_sys: Registered thermal governor 'user_space'
[    0.269203] thermal_sys: Registered thermal governor 'power_allocator'
[    0.269203] cpuidle: using governor ladder
[    0.269203] cpuidle: using governor menu
[    0.269203] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.269203] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for =
domain 0000 [bus 00-ff]
[    0.269203] PCI: Using configuration type 1 for base access
[    0.269203] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.271373] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.271373] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.271373] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.271373] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.271373] ACPI: Added _OSI(Module Device)
[    0.271373] ACPI: Added _OSI(Processor Device)
[    0.271373] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.271373] ACPI: Added _OSI(Processor Aggregator Device)
[    0.279781] ACPI: 17 ACPI AML tables successfully acquired and loaded
[    0.316082] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomai=
n+
[    0.316083] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomai=
n+
[    0.316448] ACPI: Interpreter enabled
[    0.316455] ACPI: PM: (supports S0 S3 S4 S5)
[    0.316456] ACPI: Using IOAPIC for interrupt routing
[    0.351817] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.351818] PCI: Ignoring E820 reservations for host bridge windows
[    0.351973] ACPI: Enabled 11 GPEs in block 00 to 1F
[    0.352743] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resource
[    0.353275] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resource
[    0.354422] ACPI: \_SB_.PCI0.GP19.XHC2.P0U2: New power resource
[    0.354422] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    0.354430] ACPI: \_SB_.PCI0.GPP1.P0NV: New power resource
[    0.354731] ACPI: \_SB_.PCI0.GPP7.PWRS: New power resource
[    0.354842] ACPI: \_SB_.PCI0.GPP7.UP00.PWRS: New power resource
[    0.354942] ACPI: \_SB_.PCI0.GPP7.UP00.DP00.PWRS: New power resource
[    0.355092] ACPI: \_SB_.PCI0.GPP7.UP00.DP00.NV00.PWRS: New power resource
[    0.355180] ACPI: \_SB_.PCI0.GPP7.UP00.DP08.PWRS: New power resource
[    0.355246] ACPI: \_SB_.PCI0.GPP7.UP00.DP08.EP00.PWRS: New power resource
[    0.355324] ACPI: \_SB_.PCI0.GPP7.UP00.DP10.PWRS: New power resource
[    0.355391] ACPI: \_SB_.PCI0.GPP7.UP00.DP10.WN00.PWRS: New power resource
[    0.355470] ACPI: \_SB_.PCI0.GPP7.UP00.DP18.PWRS: New power resource
[    0.355535] ACPI: \_SB_.PCI0.GPP7.UP00.DP18.LN00.PWRS: New power resource
[    0.355615] ACPI: \_SB_.PCI0.GPP7.UP00.DP20.PWRS: New power resource
[    0.355761] ACPI: \_SB_.PCI0.GPP7.UP00.DP20.NV00.PWRS: New power resource
[    0.355849] ACPI: \_SB_.PCI0.GPP7.UP00.DP28.PWRS: New power resource
[    0.355996] ACPI: \_SB_.PCI0.GPP7.UP00.DP28.EP00.PWRS: New power resource
[    0.356082] ACPI: \_SB_.PCI0.GPP7.UP00.DP30.PWRS: New power resource
[    0.356227] ACPI: \_SB_.PCI0.GPP7.UP00.DP30.EP00.PWRS: New power resource
[    0.356313] ACPI: \_SB_.PCI0.GPP7.UP00.DP38.PWRS: New power resource
[    0.356456] ACPI: \_SB_.PCI0.GPP7.UP00.DP38.EP00.PWRS: New power resource
[    0.356543] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.PWRS: New power resource
[    0.356644] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.PWRS: New power resource
[    0.356747] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP00.PWRS: New power re=
source
[    0.356896] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP00.NV00.PWRS: New pow=
er resource
[    0.356984] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP08.PWRS: New power re=
source
[    0.357051] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP08.EP00.PWRS: New pow=
er resource
[    0.357130] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP10.PWRS: New power re=
source
[    0.357230] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP10.WN00.PWRS: New pow=
er resource
[    0.357332] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP18.PWRS: New power re=
source
[    0.357432] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP18.LN00.PWRS: New pow=
er resource
[    0.357534] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP20.PWRS: New power re=
source
[    0.357681] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP20.NV00.PWRS: New pow=
er resource
[    0.357770] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP28.PWRS: New power re=
source
[    0.357838] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP28.EP00.PWRS: New pow=
er resource
[    0.357917] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP30.PWRS: New power re=
source
[    0.357984] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP30.EP00.PWRS: New pow=
er resource
[    0.358063] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP38.PWRS: New power re=
source
[    0.358130] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP38.EP00.PWRS: New pow=
er resource
[    0.358209] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP40.PWRS: New power re=
source
[    0.358357] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP40.EP00.PWRS: New pow=
er resource
[    0.358445] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP48.PWRS: New power re=
source
[    0.358512] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP48.EP00.PWRS: New pow=
er resource
[    0.358591] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP50.PWRS: New power re=
source
[    0.358658] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP50.EP00.PWRS: New pow=
er resource
[    0.358737] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP58.PWRS: New power re=
source
[    0.358804] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP58.EP00.PWRS: New pow=
er resource
[    0.358882] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP60.PWRS: New power re=
source
[    0.358981] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP60.XH00.PWRS: New pow=
er resource
[    0.359082] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP68.PWRS: New power re=
source
[    0.359184] ACPI: \_SB_.PCI0.GPP7.UP00.DP40.UP00.DP68.SA00.PWRS: New pow=
er resource
[    0.359286] ACPI: \_SB_.PCI0.GPP7.UP00.DP48.PWRS: New power resource
[    0.359352] ACPI: \_SB_.PCI0.GPP7.UP00.DP48.EP00.PWRS: New power resource
[    0.359431] ACPI: \_SB_.PCI0.GPP7.UP00.DP50.PWRS: New power resource
[    0.359496] ACPI: \_SB_.PCI0.GPP7.UP00.DP50.EP00.PWRS: New power resource
[    0.359574] ACPI: \_SB_.PCI0.GPP7.UP00.DP58.PWRS: New power resource
[    0.359639] ACPI: \_SB_.PCI0.GPP7.UP00.DP58.EP00.PWRS: New power resource
[    0.359716] ACPI: \_SB_.PCI0.GPP7.UP00.DP60.PWRS: New power resource
[    0.359816] ACPI: \_SB_.PCI0.GPP7.UP00.DP60.XH00.PWRS: New power resource
[    0.361299] ACPI: \_SB_.PCI0.GPP7.UP00.DP68.PWRS: New power resource
[    0.361400] ACPI: \_SB_.PCI0.GPP7.UP00.DP68.SA00.PWRS: New power resource
[    0.361752] ACPI: \_SB_.PCI0.GPP8.PWRS: New power resource
[    0.366191] ACPI: \_SB_.PCI0.GPP8.U4UP.PWRS: New power resource
[    0.368790] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P0.PWRS: New power resource
[    0.371451] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P0.UP0D.PWRS: New power resource
[    0.371736] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P1.PWRS: New power resource
[    0.374294] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P1.UP1D.PWRS: New power resource
[    0.374487] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P2.PWRS: New power resource
[    0.376991] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P2.UXHC.PWRS: New power resource
[    0.379881] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P3.PWRS: New power resource
[    0.382393] ACPI: \_SB_.PCI0.GPP8.U4UP.U4P3.UHI0.PWRS: New power resource
[    0.386210] ACPI: \_SB_.PRWL: New power resource
[    0.386218] ACPI: \_SB_.PRWB: New power resource
[    0.386475] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.386479] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.386527] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR DPC]
[    0.386782] PCI host bridge to bus 0000:00
[    0.386783] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.386785] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.386785] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.386786] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.386786] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dfff=
f window]
[    0.386787] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xdffffff=
f window]
[    0.386787] pci_bus 0000:00: root bus resource [mem 0x1060000000-0xfffff=
fffff window]
[    0.386788] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.386799] pci 0000:00:00.0: [1022:14d8] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.386859] pci 0000:00:00.2: [1022:14d9] type 00 class 0x080600 convent=
ional PCI endpoint
[    0.386908] pci 0000:00:01.0: [1022:14da] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.386945] pci 0000:00:01.1: [1022:14db] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.386957] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.386960] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.386962] pci 0000:00:01.1:   bridge window [mem 0xdd000000-0xde0fffff]
[    0.386967] pci 0000:00:01.1:   bridge window [mem 0xf000000000-0xf801ff=
ffff 64bit pref]
[    0.387016] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.387213] pci 0000:00:01.2: [1022:14db] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.387225] pci 0000:00:01.2: PCI bridge to [bus 02]
[    0.387228] pci 0000:00:01.2:   bridge window [mem 0xdf300000-0xdf3fffff]
[    0.387279] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.387362] pci 0000:00:02.0: [1022:14da] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.387398] pci 0000:00:02.1: [1022:14db] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.387411] pci 0000:00:02.1: PCI bridge to [bus 03-14]
[    0.387413] pci 0000:00:02.1:   bridge window [io  0xe000-0xefff]
[    0.387415] pci 0000:00:02.1:   bridge window [mem 0xde200000-0xdebfffff]
[    0.387424] pci 0000:00:02.1: enabling Extended Tags
[    0.387467] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.387602] pci 0000:00:02.2: [1022:14db] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.387615] pci 0000:00:02.2: PCI bridge to [bus 15-78]
[    0.387617] pci 0000:00:02.2:   bridge window [io  0x7000-0xcfff]
[    0.387618] pci 0000:00:02.2:   bridge window [mem 0xac000000-0xdc7fffff]
[    0.387623] pci 0000:00:02.2:   bridge window [mem 0xb000000000-0xefffff=
ffff 64bit pref]
[    0.387669] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.387760] pci 0000:00:03.0: [1022:14da] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.387802] pci 0000:00:04.0: [1022:14da] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.387846] pci 0000:00:08.0: [1022:14da] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.387884] pci 0000:00:08.1: [1022:14dd] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.387894] pci 0000:00:08.1: PCI bridge to [bus 79]
[    0.387896] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    0.387897] pci 0000:00:08.1:   bridge window [mem 0xdec00000-0xdf1fffff]
[    0.387900] pci 0000:00:08.1:   bridge window [mem 0xf810000000-0xf81fff=
ffff 64bit pref]
[    0.387904] pci 0000:00:08.1: enabling Extended Tags
[    0.387927] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.387985] pci 0000:00:08.3: [1022:14dd] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.387995] pci 0000:00:08.3: PCI bridge to [bus 7a]
[    0.387997] pci 0000:00:08.3:   bridge window [mem 0xdf200000-0xdf2fffff]
[    0.388004] pci 0000:00:08.3: enabling Extended Tags
[    0.388027] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
[    0.388091] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.388157] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.388232] pci 0000:00:18.0: [1022:14e0] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388250] pci 0000:00:18.1: [1022:14e1] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388267] pci 0000:00:18.2: [1022:14e2] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388284] pci 0000:00:18.3: [1022:14e3] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388301] pci 0000:00:18.4: [1022:14e4] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388317] pci 0000:00:18.5: [1022:14e5] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388335] pci 0000:00:18.6: [1022:14e6] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388352] pci 0000:00:18.7: [1022:14e7] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.388413] pci 0000:01:00.0: [10de:2204] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.388420] pci 0000:01:00.0: BAR 0 [mem 0xdd000000-0xddffffff]
[    0.388425] pci 0000:01:00.0: BAR 1 [mem 0xf000000000-0xf7ffffffff 64bit=
 pref]
[    0.388431] pci 0000:01:00.0: BAR 3 [mem 0xf800000000-0xf801ffffff 64bit=
 pref]
[    0.388434] pci 0000:01:00.0: BAR 5 [io  0xf000-0xf07f]
[    0.388438] pci 0000:01:00.0: ROM [mem 0xde000000-0xde07ffff pref]
[    0.388473] pci 0000:01:00.0: PME# supported from D0 D3hot
[    0.388583] pci 0000:01:00.1: [10de:1aef] type 00 class 0x040300 PCIe En=
dpoint
[    0.388589] pci 0000:01:00.1: BAR 0 [mem 0xde080000-0xde083fff]
[    0.388675] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.388730] pci 0000:02:00.0: [144d:a80c] type 00 class 0x010802 PCIe En=
dpoint
[    0.388742] pci 0000:02:00.0: BAR 0 [mem 0xdf300000-0xdf303fff 64bit]
[    0.388920] pci 0000:00:01.2: PCI bridge to [bus 02]
[    0.388973] pci 0000:03:00.0: [1022:43f4] type 01 class 0x060400 PCIe Sw=
itch Upstream Port
[    0.388991] pci 0000:03:00.0: PCI bridge to [bus 04-14]
[    0.388995] pci 0000:03:00.0:   bridge window [io  0xe000-0xefff]
[    0.388996] pci 0000:03:00.0:   bridge window [mem 0xde200000-0xdebfffff]
[    0.389009] pci 0000:03:00.0: enabling Extended Tags
[    0.389052] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.389214] pci 0000:00:02.1: PCI bridge to [bus 03-14]
[    0.389279] pci 0000:04:00.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.389296] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.389314] pci 0000:04:00.0: enabling Extended Tags
[    0.389360] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.389456] pci 0000:04:04.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.389473] pci 0000:04:04.0: PCI bridge to [bus 06]
[    0.389491] pci 0000:04:04.0: enabling Extended Tags
[    0.389537] pci 0000:04:04.0: PME# supported from D0 D3hot D3cold
[    0.389631] pci 0000:04:05.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.389649] pci 0000:04:05.0: PCI bridge to [bus 07]
[    0.389667] pci 0000:04:05.0: enabling Extended Tags
[    0.389712] pci 0000:04:05.0: PME# supported from D0 D3hot D3cold
[    0.389806] pci 0000:04:06.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.389824] pci 0000:04:06.0: PCI bridge to [bus 08]
[    0.389842] pci 0000:04:06.0: enabling Extended Tags
[    0.389887] pci 0000:04:06.0: PME# supported from D0 D3hot D3cold
[    0.389981] pci 0000:04:07.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.389999] pci 0000:04:07.0: PCI bridge to [bus 09]
[    0.390017] pci 0000:04:07.0: enabling Extended Tags
[    0.390062] pci 0000:04:07.0: PME# supported from D0 D3hot D3cold
[    0.390157] pci 0000:04:08.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.390175] pci 0000:04:08.0: PCI bridge to [bus 0a-12]
[    0.390178] pci 0000:04:08.0:   bridge window [io  0xe000-0xefff]
[    0.390180] pci 0000:04:08.0:   bridge window [mem 0xde200000-0xde9fffff]
[    0.390194] pci 0000:04:08.0: enabling Extended Tags
[    0.390237] pci 0000:04:08.0: PME# supported from D0 D3hot D3cold
[    0.390365] pci 0000:04:0c.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.390383] pci 0000:04:0c.0: PCI bridge to [bus 13]
[    0.390386] pci 0000:04:0c.0:   bridge window [mem 0xdeb00000-0xdebfffff]
[    0.390400] pci 0000:04:0c.0: enabling Extended Tags
[    0.390429] pci 0000:04:0c.0: PME# supported from D0 D3hot D3cold
[    0.390498] pci 0000:04:0d.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.390515] pci 0000:04:0d.0: PCI bridge to [bus 14]
[    0.390519] pci 0000:04:0d.0:   bridge window [mem 0xdea00000-0xdeafffff]
[    0.390532] pci 0000:04:0d.0: enabling Extended Tags
[    0.390562] pci 0000:04:0d.0: PME# supported from D0 D3hot D3cold
[    0.390622] pci 0000:03:00.0: PCI bridge to [bus 04-14]
[    0.390651] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.390681] pci 0000:04:04.0: PCI bridge to [bus 06]
[    0.390709] pci 0000:04:05.0: PCI bridge to [bus 07]
[    0.390737] pci 0000:04:06.0: PCI bridge to [bus 08]
[    0.390765] pci 0000:04:07.0: PCI bridge to [bus 09]
[    0.390810] pci 0000:0a:00.0: [1022:43f4] type 01 class 0x060400 PCIe Sw=
itch Upstream Port
[    0.390838] pci 0000:0a:00.0: PCI bridge to [bus 0b-12]
[    0.390843] pci 0000:0a:00.0:   bridge window [io  0xe000-0xefff]
[    0.390845] pci 0000:0a:00.0:   bridge window [mem 0xde200000-0xde9fffff]
[    0.390866] pci 0000:0a:00.0: enabling Extended Tags
[    0.390936] pci 0000:0a:00.0: PME# supported from D0 D3hot D3cold
[    0.391220] pci 0000:04:08.0: PCI bridge to [bus 0a-12]
[    0.391307] pci 0000:0b:00.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.391335] pci 0000:0b:00.0: PCI bridge to [bus 0c]
[    0.391364] pci 0000:0b:00.0: enabling Extended Tags
[    0.391438] pci 0000:0b:00.0: PME# supported from D0 D3hot D3cold
[    0.391587] pci 0000:0b:02.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.391615] pci 0000:0b:02.0: PCI bridge to [bus 0d]
[    0.391623] pci 0000:0b:02.0:   bridge window [mem 0xde200000-0xde4fffff]
[    0.391645] pci 0000:0b:02.0: enabling Extended Tags
[    0.391716] pci 0000:0b:02.0: PME# supported from D0 D3hot D3cold
[    0.391863] pci 0000:0b:03.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.391891] pci 0000:0b:03.0: PCI bridge to [bus 0e]
[    0.391896] pci 0000:0b:03.0:   bridge window [io  0xe000-0xefff]
[    0.391899] pci 0000:0b:03.0:   bridge window [mem 0xde900000-0xde9fffff]
[    0.391921] pci 0000:0b:03.0: enabling Extended Tags
[    0.391992] pci 0000:0b:03.0: PME# supported from D0 D3hot D3cold
[    0.392141] pci 0000:0b:04.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.392169] pci 0000:0b:04.0: PCI bridge to [bus 0f]
[    0.392198] pci 0000:0b:04.0: enabling Extended Tags
[    0.392272] pci 0000:0b:04.0: PME# supported from D0 D3hot D3cold
[    0.392423] pci 0000:0b:08.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.392452] pci 0000:0b:08.0: PCI bridge to [bus 10]
[    0.392481] pci 0000:0b:08.0: enabling Extended Tags
[    0.392555] pci 0000:0b:08.0: PME# supported from D0 D3hot D3cold
[    0.392708] pci 0000:0b:0c.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.392736] pci 0000:0b:0c.0: PCI bridge to [bus 11]
[    0.392741] pci 0000:0b:0c.0:   bridge window [mem 0xde800000-0xde8fffff]
[    0.392762] pci 0000:0b:0c.0: enabling Extended Tags
[    0.392810] pci 0000:0b:0c.0: PME# supported from D0 D3hot D3cold
[    0.392897] pci 0000:0b:0d.0: [1022:43f5] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.392925] pci 0000:0b:0d.0: PCI bridge to [bus 12]
[    0.392930] pci 0000:0b:0d.0:   bridge window [mem 0xde600000-0xde7fffff]
[    0.392951] pci 0000:0b:0d.0: enabling Extended Tags
[    0.392999] pci 0000:0b:0d.0: PME# supported from D0 D3hot D3cold
[    0.393087] pci 0000:0a:00.0: PCI bridge to [bus 0b-12]
[    0.393128] pci 0000:0b:00.0: PCI bridge to [bus 0c]
[    0.393196] pci 0000:0d:00.0: [14c3:7925] type 00 class 0x028000 PCIe En=
dpoint
[    0.393226] pci 0000:0d:00.0: BAR 0 [mem 0xde200000-0xde3fffff 64bit]
[    0.393243] pci 0000:0d:00.0: BAR 2 [mem 0xde400000-0xde407fff 64bit]
[    0.393283] pci 0000:0d:00.0: enabling Extended Tags
[    0.393389] pci 0000:0d:00.0: PME# supported from D0 D3hot D3cold
[    0.393649] pci 0000:0b:02.0: PCI bridge to [bus 0d]
[    0.393721] pci 0000:0e:00.0: [10ec:8125] type 00 class 0x020000 PCIe En=
dpoint
[    0.393745] pci 0000:0e:00.0: BAR 0 [io  0xe000-0xe0ff]
[    0.393778] pci 0000:0e:00.0: BAR 2 [mem 0xde900000-0xde90ffff 64bit]
[    0.393798] pci 0000:0e:00.0: BAR 4 [mem 0xde910000-0xde913fff 64bit]
[    0.393957] pci 0000:0e:00.0: supports D1 D2
[    0.393957] pci 0000:0e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.394252] pci 0000:0b:03.0: PCI bridge to [bus 0e]
[    0.394295] pci 0000:0b:04.0: PCI bridge to [bus 0f]
[    0.394337] pci 0000:0b:08.0: PCI bridge to [bus 10]
[    0.394395] pci 0000:11:00.0: [1022:43fd] type 00 class 0x0c0330 PCIe Le=
gacy Endpoint
[    0.394412] pci 0000:11:00.0: BAR 0 [mem 0xde800000-0xde807fff 64bit]
[    0.394453] pci 0000:11:00.0: enabling Extended Tags
[    0.394505] pci 0000:11:00.0: PME# supported from D0 D3hot D3cold
[    0.394591] pci 0000:0b:0c.0: PCI bridge to [bus 11]
[    0.394647] pci 0000:12:00.0: [1022:43f6] type 00 class 0x010601 PCIe Le=
gacy Endpoint
[    0.394695] pci 0000:12:00.0: BAR 5 [mem 0xde680000-0xde6803ff]
[    0.394702] pci 0000:12:00.0: ROM [mem 0xde600000-0xde67ffff pref]
[    0.394709] pci 0000:12:00.0: enabling Extended Tags
[    0.394751] pci 0000:12:00.0: PME# supported from D0 D3hot D3cold
[    0.394823] pci 0000:0b:0d.0: PCI bridge to [bus 12]
[    0.394907] pci 0000:13:00.0: [1022:43fd] type 00 class 0x0c0330 PCIe Le=
gacy Endpoint
[    0.394917] pci 0000:13:00.0: BAR 0 [mem 0xdeb00000-0xdeb07fff 64bit]
[    0.394943] pci 0000:13:00.0: enabling Extended Tags
[    0.394975] pci 0000:13:00.0: PME# supported from D0 D3hot D3cold
[    0.395041] pci 0000:04:0c.0: PCI bridge to [bus 13]
[    0.395078] pci 0000:14:00.0: [1022:43f6] type 00 class 0x010601 PCIe Le=
gacy Endpoint
[    0.395107] pci 0000:14:00.0: BAR 5 [mem 0xdea80000-0xdea803ff]
[    0.395112] pci 0000:14:00.0: ROM [mem 0xdea00000-0xdea7ffff pref]
[    0.395116] pci 0000:14:00.0: enabling Extended Tags
[    0.395142] pci 0000:14:00.0: PME# supported from D0 D3hot D3cold
[    0.395189] pci 0000:04:0d.0: PCI bridge to [bus 14]
[    0.395276] pci 0000:15:00.0: [1b21:2421] type 01 class 0x060400 PCIe Sw=
itch Upstream Port
[    0.395293] pci 0000:15:00.0: PCI bridge to [bus 16-78]
[    0.395297] pci 0000:15:00.0:   bridge window [io  0x7000-0xcfff]
[    0.395298] pci 0000:15:00.0:   bridge window [mem 0xac000000-0xdc7fffff]
[    0.395304] pci 0000:15:00.0:   bridge window [mem 0xb000000000-0xefffff=
ffff 64bit pref]
[    0.395356] pci 0000:15:00.0: PME# supported from D0 D3hot D3cold
[    0.395470] pci 0000:00:02.2: PCI bridge to [bus 15-78]
[    0.395514] pci 0000:16:00.0: [1b21:2423] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.395531] pci 0000:16:00.0: PCI bridge to [bus 17-46]
[    0.395535] pci 0000:16:00.0:   bridge window [io  0xa000-0xcfff]
[    0.395536] pci 0000:16:00.0:   bridge window [mem 0xc4000000-0xdbffffff]
[    0.395542] pci 0000:16:00.0:   bridge window [mem 0xd000000000-0xefffff=
ffff 64bit pref]
[    0.395636] pci 0000:16:00.0: PME# supported from D0 D3hot D3cold
[    0.395941] pci 0000:16:01.0: [1b21:2423] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.395958] pci 0000:16:01.0: PCI bridge to [bus 47-76]
[    0.395962] pci 0000:16:01.0:   bridge window [io  0x7000-0x9fff]
[    0.395963] pci 0000:16:01.0:   bridge window [mem 0xac000000-0xc3ffffff]
[    0.395969] pci 0000:16:01.0:   bridge window [mem 0xb000000000-0xcfffff=
ffff 64bit pref]
[    0.396054] pci 0000:16:01.0: PME# supported from D0 D3hot D3cold
[    0.396356] pci 0000:16:02.0: [1b21:2423] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.396374] pci 0000:16:02.0: PCI bridge to [bus 77]
[    0.396377] pci 0000:16:02.0:   bridge window [mem 0xdc400000-0xdc7fffff]
[    0.396426] pci 0000:16:02.0: PME# supported from D0 D3hot D3cold
[    0.396502] pci 0000:16:03.0: [1b21:2423] type 01 class 0x060400 PCIe Sw=
itch Downstream Port
[    0.396519] pci 0000:16:03.0: PCI bridge to [bus 78]
[    0.396523] pci 0000:16:03.0:   bridge window [mem 0xdc000000-0xdc3fffff]
[    0.396572] pci 0000:16:03.0: PME# supported from D0 D3hot D3cold
[    0.396652] pci 0000:15:00.0: PCI bridge to [bus 16-78]
[    0.396690] pci 0000:16:00.0: PCI bridge to [bus 17-46]
[    0.396728] pci 0000:16:01.0: PCI bridge to [bus 47-76]
[    0.396767] pci 0000:77:00.0: [1b21:2426] type 00 class 0x0c0330 PCIe Le=
gacy Endpoint
[    0.396778] pci 0000:77:00.0: BAR 0 [mem 0xdc400000-0xdc407fff 64bit]
[    0.396837] pci 0000:77:00.0: PME# supported from D0 D3hot D3cold
[    0.396906] pci 0000:16:02.0: PCI bridge to [bus 77]
[    0.396954] pci 0000:78:00.0: [1b21:2425] type 00 class 0x0c0340 PCIe Le=
gacy Endpoint
[    0.396963] pci 0000:78:00.0: BAR 0 [mem 0xdc000000-0xdc03ffff 64bit]
[    0.396969] pci 0000:78:00.0: BAR 2 [mem 0xdc040000-0xdc04ffff 64bit]
[    0.397016] pci 0000:78:00.0: PME# supported from D0 D3hot D3cold
[    0.397157] pci 0000:16:03.0: PCI bridge to [bus 78]
[    0.397224] pci 0000:79:00.0: [1002:13c0] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.397231] pci 0000:79:00.0: BAR 0 [mem 0xf810000000-0xf81fffffff 64bit=
 pref]
[    0.397236] pci 0000:79:00.0: BAR 2 [mem 0xdec00000-0xdedfffff 64bit pre=
f]
[    0.397239] pci 0000:79:00.0: BAR 4 [io  0xd000-0xd0ff]
[    0.397242] pci 0000:79:00.0: BAR 5 [mem 0xdf100000-0xdf17ffff]
[    0.397247] pci 0000:79:00.0: enabling Extended Tags
[    0.397279] pci 0000:79:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.397341] pci 0000:79:00.1: [1002:1640] type 00 class 0x040300 PCIe Le=
gacy Endpoint
[    0.397345] pci 0000:79:00.1: BAR 0 [mem 0xdf188000-0xdf18bfff]
[    0.397359] pci 0000:79:00.1: enabling Extended Tags
[    0.397379] pci 0000:79:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.397414] pci 0000:79:00.2: [1022:1649] type 00 class 0x108000 PCIe En=
dpoint
[    0.397443] pci 0000:79:00.2: BAR 2 [mem 0xdf000000-0xdf0fffff]
[    0.397449] pci 0000:79:00.2: BAR 5 [mem 0xdf18c000-0xdf18dfff]
[    0.397453] pci 0000:79:00.2: enabling Extended Tags
[    0.397504] pci 0000:79:00.3: [1022:15b6] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.397511] pci 0000:79:00.3: BAR 0 [mem 0xdef00000-0xdeffffff 64bit]
[    0.397527] pci 0000:79:00.3: enabling Extended Tags
[    0.397547] pci 0000:79:00.3: PME# supported from D0 D3hot D3cold
[    0.397585] pci 0000:79:00.4: [1022:15b7] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.397592] pci 0000:79:00.4: BAR 0 [mem 0xdee00000-0xdeefffff 64bit]
[    0.397607] pci 0000:79:00.4: enabling Extended Tags
[    0.397628] pci 0000:79:00.4: PME# supported from D0 D3hot D3cold
[    0.397667] pci 0000:79:00.6: [1022:15e3] type 00 class 0x040300 PCIe En=
dpoint
[    0.397672] pci 0000:79:00.6: BAR 0 [mem 0xdf180000-0xdf187fff]
[    0.397685] pci 0000:79:00.6: enabling Extended Tags
[    0.397704] pci 0000:79:00.6: PME# supported from D0 D3hot D3cold
[    0.397750] pci 0000:00:08.1: PCI bridge to [bus 79]
[    0.397774] pci 0000:7a:00.0: [1022:15b8] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.397785] pci 0000:7a:00.0: BAR 0 [mem 0xdf200000-0xdf2fffff 64bit]
[    0.397806] pci 0000:7a:00.0: enabling Extended Tags
[    0.397832] pci 0000:7a:00.0: PME# supported from D0 D3hot D3cold
[    0.397883] pci 0000:00:08.3: PCI bridge to [bus 7a]
[    0.401671] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.401690] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.401706] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.401726] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.401743] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.401758] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.401772] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.401787] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.402234] iommu: Default domain type: Translated
[    0.402234] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.402234] SCSI subsystem initialized
[    0.402234] libata version 3.00 loaded.
[    0.402234] ACPI: bus type USB registered
[    0.402234] usbcore: registered new interface driver usbfs
[    0.402234] usbcore: registered new interface driver hub
[    0.402234] usbcore: registered new device driver usb
[    0.413174] EDAC MC: Ver: 3.0.0
[    0.413287] efivars: Registered efivars operations
[    0.413287] NetLabel: Initializing
[    0.413287] NetLabel:  domain hash size =3D 128
[    0.413287] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.413287] NetLabel:  unlabeled traffic allowed by default
[    0.413287] mctp: management component transport protocol core
[    0.413287] NET: Registered PF_MCTP protocol family
[    0.413287] PCI: Using ACPI for IRQ routing
[    0.418555] PCI: pci_cache_line_size set to 64 bytes
[    0.418640] e820: reserve RAM buffer [mem 0x09aff000-0x0bffffff]
[    0.418641] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.418642] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.418642] e820: reserve RAM buffer [mem 0x8201f018-0x83ffffff]
[    0.418643] e820: reserve RAM buffer [mem 0x8202a018-0x83ffffff]
[    0.418643] e820: reserve RAM buffer [mem 0x82039018-0x83ffffff]
[    0.418643] e820: reserve RAM buffer [mem 0x8405e000-0x87ffffff]
[    0.418644] e820: reserve RAM buffer [mem 0x84509000-0x87ffffff]
[    0.418644] e820: reserve RAM buffer [mem 0x88212000-0x8bffffff]
[    0.418644] e820: reserve RAM buffer [mem 0x99ff7000-0x9bffffff]
[    0.418645] e820: reserve RAM buffer [mem 0x9a000000-0x9bffffff]
[    0.418645] e820: reserve RAM buffer [mem 0xfdde80000-0xfdfffffff]
[    0.418657] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.418657] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.418657] pci 0000:01:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.418657] pci 0000:79:00.0: vgaarb: bridge control possible
[    0.418657] pci 0000:79:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.418657] vgaarb: loaded
[    0.418657] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.418657] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.421089] clocksource: Switched to clocksource tsc-early
[    0.421404] VFS: Disk quotas dquot_6.6.0
[    0.421408] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.421457] pnp: PnP ACPI init
[    0.421494] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.421520] system 00:01: [mem 0xfe0000000-0x105fffffff window] has been=
 reserved
[    0.421602] system 00:03: [io  0x0a00-0x0a2f] has been reserved
[    0.421603] system 00:03: [io  0x0a30-0x0a3f] has been reserved
[    0.421604] system 00:03: [io  0x0a40-0x0a4f] has been reserved
[    0.421604] system 00:03: [mem 0xfe000000-0xfe01ffff] has been reserved
[    0.421677] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.421677] system 00:04: [io  0x040b] has been reserved
[    0.421678] system 00:04: [io  0x04d6] has been reserved
[    0.421679] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.421679] system 00:04: [io  0x0c14] has been reserved
[    0.421680] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.421680] system 00:04: [io  0x0c52] has been reserved
[    0.421681] system 00:04: [io  0x0c6c] has been reserved
[    0.421681] system 00:04: [io  0x0c6f] has been reserved
[    0.421682] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.421682] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.421683] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.421683] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.421683] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.421684] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.421685] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.421685] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.421686] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.421687] system 00:04: [mem 0xfeb00000-0xfeb00fff] has been reserved
[    0.421687] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.424391] pnp: PnP ACPI: found 5 devices
[    0.429364] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.429388] NET: Registered PF_INET protocol family
[    0.429445] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.435648] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7=
, 524288 bytes, linear)
[    0.435680] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.435773] TCP established hash table entries: 524288 (order: 10, 41943=
04 bytes, linear)
[    0.436021] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.436073] TCP: Hash tables configured (established 524288 bind 65536)
[    0.436139] MPTCP token hash table entries: 65536 (order: 8, 1572864 byt=
es, linear)
[    0.436227] UDP hash table entries: 32768 (order: 9, 2097152 bytes, line=
ar)
[    0.436329] UDP-Lite hash table entries: 32768 (order: 9, 2097152 bytes,=
 linear)
[    0.436401] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.436404] NET: Registered PF_XDP protocol family
[    0.436413] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.436414] pci 0000:00:01.1:   bridge window [io  0xf000-0xffff]
[    0.436416] pci 0000:00:01.1:   bridge window [mem 0xdd000000-0xde0fffff]
[    0.436418] pci 0000:00:01.1:   bridge window [mem 0xf000000000-0xf801ff=
ffff 64bit pref]
[    0.436427] pci 0000:00:01.2: PCI bridge to [bus 02]
[    0.436429] pci 0000:00:01.2:   bridge window [mem 0xdf300000-0xdf3fffff]
[    0.436439] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.436449] pci 0000:04:04.0: PCI bridge to [bus 06]
[    0.436455] pci 0000:04:05.0: PCI bridge to [bus 07]
[    0.436461] pci 0000:04:06.0: PCI bridge to [bus 08]
[    0.436467] pci 0000:04:07.0: PCI bridge to [bus 09]
[    0.436473] pci 0000:0b:00.0: PCI bridge to [bus 0c]
[    0.436482] pci 0000:0b:02.0: PCI bridge to [bus 0d]
[    0.436486] pci 0000:0b:02.0:   bridge window [mem 0xde200000-0xde4fffff]
[    0.436492] pci 0000:0b:03.0: PCI bridge to [bus 0e]
[    0.436493] pci 0000:0b:03.0:   bridge window [io  0xe000-0xefff]
[    0.436497] pci 0000:0b:03.0:   bridge window [mem 0xde900000-0xde9fffff]
[    0.436503] pci 0000:0b:04.0: PCI bridge to [bus 0f]
[    0.436512] pci 0000:0b:08.0: PCI bridge to [bus 10]
[    0.436522] pci 0000:0b:0c.0: PCI bridge to [bus 11]
[    0.436525] pci 0000:0b:0c.0:   bridge window [mem 0xde800000-0xde8fffff]
[    0.436531] pci 0000:0b:0d.0: PCI bridge to [bus 12]
[    0.436535] pci 0000:0b:0d.0:   bridge window [mem 0xde600000-0xde7fffff]
[    0.436541] pci 0000:0a:00.0: PCI bridge to [bus 0b-12]
[    0.436542] pci 0000:0a:00.0:   bridge window [io  0xe000-0xefff]
[    0.436546] pci 0000:0a:00.0:   bridge window [mem 0xde200000-0xde9fffff]
[    0.436552] pci 0000:04:08.0: PCI bridge to [bus 0a-12]
[    0.436553] pci 0000:04:08.0:   bridge window [io  0xe000-0xefff]
[    0.436555] pci 0000:04:08.0:   bridge window [mem 0xde200000-0xde9fffff]
[    0.436559] pci 0000:04:0c.0: PCI bridge to [bus 13]
[    0.436561] pci 0000:04:0c.0:   bridge window [mem 0xdeb00000-0xdebfffff]
[    0.436566] pci 0000:04:0d.0: PCI bridge to [bus 14]
[    0.436568] pci 0000:04:0d.0:   bridge window [mem 0xdea00000-0xdeafffff]
[    0.436572] pci 0000:03:00.0: PCI bridge to [bus 04-14]
[    0.436573] pci 0000:03:00.0:   bridge window [io  0xe000-0xefff]
[    0.436575] pci 0000:03:00.0:   bridge window [mem 0xde200000-0xdebfffff]
[    0.436579] pci 0000:00:02.1: PCI bridge to [bus 03-14]
[    0.436580] pci 0000:00:02.1:   bridge window [io  0xe000-0xefff]
[    0.436582] pci 0000:00:02.1:   bridge window [mem 0xde200000-0xdebfffff]
[    0.436592] pci 0000:16:00.0: PCI bridge to [bus 17-46]
[    0.436593] pci 0000:16:00.0:   bridge window [io  0xa000-0xcfff]
[    0.436595] pci 0000:16:00.0:   bridge window [mem 0xc4000000-0xdbffffff]
[    0.436597] pci 0000:16:00.0:   bridge window [mem 0xd000000000-0xefffff=
ffff 64bit pref]
[    0.436600] pci 0000:16:01.0: PCI bridge to [bus 47-76]
[    0.436600] pci 0000:16:01.0:   bridge window [io  0x7000-0x9fff]
[    0.436603] pci 0000:16:01.0:   bridge window [mem 0xac000000-0xc3ffffff]
[    0.436604] pci 0000:16:01.0:   bridge window [mem 0xb000000000-0xcfffff=
ffff 64bit pref]
[    0.436607] pci 0000:16:02.0: PCI bridge to [bus 77]
[    0.436609] pci 0000:16:02.0:   bridge window [mem 0xdc400000-0xdc7fffff]
[    0.436613] pci 0000:16:03.0: PCI bridge to [bus 78]
[    0.436616] pci 0000:16:03.0:   bridge window [mem 0xdc000000-0xdc3fffff]
[    0.436620] pci 0000:15:00.0: PCI bridge to [bus 16-78]
[    0.436621] pci 0000:15:00.0:   bridge window [io  0x7000-0xcfff]
[    0.436623] pci 0000:15:00.0:   bridge window [mem 0xac000000-0xdc7fffff]
[    0.436625] pci 0000:15:00.0:   bridge window [mem 0xb000000000-0xefffff=
ffff 64bit pref]
[    0.436627] pci 0000:00:02.2: PCI bridge to [bus 15-78]
[    0.436628] pci 0000:00:02.2:   bridge window [io  0x7000-0xcfff]
[    0.436630] pci 0000:00:02.2:   bridge window [mem 0xac000000-0xdc7fffff]
[    0.436631] pci 0000:00:02.2:   bridge window [mem 0xb000000000-0xefffff=
ffff 64bit pref]
[    0.436643] pci 0000:00:08.1: PCI bridge to [bus 79]
[    0.436648] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
[    0.436649] pci 0000:00:08.1:   bridge window [mem 0xdec00000-0xdf1fffff]
[    0.436650] pci 0000:00:08.1:   bridge window [mem 0xf810000000-0xf81fff=
ffff 64bit pref]
[    0.436652] pci 0000:00:08.3: PCI bridge to [bus 7a]
[    0.436653] pci 0000:00:08.3:   bridge window [mem 0xdf200000-0xdf2fffff]
[    0.436656] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.436657] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.436657] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.436658] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.436658] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff windo=
w]
[    0.436658] pci_bus 0000:00: resource 9 [mem 0xa0000000-0xdfffffff windo=
w]
[    0.436659] pci_bus 0000:00: resource 10 [mem 0x1060000000-0xffffffffff =
window]
[    0.436659] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    0.436660] pci_bus 0000:01: resource 1 [mem 0xdd000000-0xde0fffff]
[    0.436660] pci_bus 0000:01: resource 2 [mem 0xf000000000-0xf801ffffff 6=
4bit pref]
[    0.436661] pci_bus 0000:02: resource 1 [mem 0xdf300000-0xdf3fffff]
[    0.436661] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    0.436662] pci_bus 0000:03: resource 1 [mem 0xde200000-0xdebfffff]
[    0.436662] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[    0.436663] pci_bus 0000:04: resource 1 [mem 0xde200000-0xdebfffff]
[    0.436663] pci_bus 0000:0a: resource 0 [io  0xe000-0xefff]
[    0.436663] pci_bus 0000:0a: resource 1 [mem 0xde200000-0xde9fffff]
[    0.436664] pci_bus 0000:0b: resource 0 [io  0xe000-0xefff]
[    0.436664] pci_bus 0000:0b: resource 1 [mem 0xde200000-0xde9fffff]
[    0.436665] pci_bus 0000:0d: resource 1 [mem 0xde200000-0xde4fffff]
[    0.436665] pci_bus 0000:0e: resource 0 [io  0xe000-0xefff]
[    0.436666] pci_bus 0000:0e: resource 1 [mem 0xde900000-0xde9fffff]
[    0.436666] pci_bus 0000:11: resource 1 [mem 0xde800000-0xde8fffff]
[    0.436666] pci_bus 0000:12: resource 1 [mem 0xde600000-0xde7fffff]
[    0.436667] pci_bus 0000:13: resource 1 [mem 0xdeb00000-0xdebfffff]
[    0.436667] pci_bus 0000:14: resource 1 [mem 0xdea00000-0xdeafffff]
[    0.436668] pci_bus 0000:15: resource 0 [io  0x7000-0xcfff]
[    0.436668] pci_bus 0000:15: resource 1 [mem 0xac000000-0xdc7fffff]
[    0.436668] pci_bus 0000:15: resource 2 [mem 0xb000000000-0xefffffffff 6=
4bit pref]
[    0.436669] pci_bus 0000:16: resource 0 [io  0x7000-0xcfff]
[    0.436669] pci_bus 0000:16: resource 1 [mem 0xac000000-0xdc7fffff]
[    0.436670] pci_bus 0000:16: resource 2 [mem 0xb000000000-0xefffffffff 6=
4bit pref]
[    0.436670] pci_bus 0000:17: resource 0 [io  0xa000-0xcfff]
[    0.436670] pci_bus 0000:17: resource 1 [mem 0xc4000000-0xdbffffff]
[    0.436671] pci_bus 0000:17: resource 2 [mem 0xd000000000-0xefffffffff 6=
4bit pref]
[    0.436671] pci_bus 0000:47: resource 0 [io  0x7000-0x9fff]
[    0.436672] pci_bus 0000:47: resource 1 [mem 0xac000000-0xc3ffffff]
[    0.436672] pci_bus 0000:47: resource 2 [mem 0xb000000000-0xcfffffffff 6=
4bit pref]
[    0.436673] pci_bus 0000:77: resource 1 [mem 0xdc400000-0xdc7fffff]
[    0.436673] pci_bus 0000:78: resource 1 [mem 0xdc000000-0xdc3fffff]
[    0.436673] pci_bus 0000:79: resource 0 [io  0xd000-0xdfff]
[    0.436674] pci_bus 0000:79: resource 1 [mem 0xdec00000-0xdf1fffff]
[    0.436674] pci_bus 0000:79: resource 2 [mem 0xf810000000-0xf81fffffff 6=
4bit pref]
[    0.436675] pci_bus 0000:7a: resource 1 [mem 0xdf200000-0xdf2fffff]
[    0.436745] pci 0000:01:00.1: extending delay after power-on from D3hot =
to 20 msec
[    0.436756] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.436997] pci 0000:79:00.1: D0 power state depends on 0000:79:00.0
[    0.437118] PCI: CLS 64 bytes, default 64
[    0.437133] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters support=
ed
[    0.437153] Trying to unpack rootfs image as initramfs...
[    0.437155] pci 0000:00:01.0: Adding to iommu group 0
[    0.437162] pci 0000:00:01.1: Adding to iommu group 1
[    0.437168] pci 0000:00:01.2: Adding to iommu group 2
[    0.437178] pci 0000:00:02.0: Adding to iommu group 3
[    0.437184] pci 0000:00:02.1: Adding to iommu group 4
[    0.437190] pci 0000:00:02.2: Adding to iommu group 5
[    0.437199] pci 0000:00:03.0: Adding to iommu group 6
[    0.437208] pci 0000:00:04.0: Adding to iommu group 7
[    0.437217] pci 0000:00:08.0: Adding to iommu group 8
[    0.437223] pci 0000:00:08.1: Adding to iommu group 9
[    0.437229] pci 0000:00:08.3: Adding to iommu group 10
[    0.437241] pci 0000:00:14.0: Adding to iommu group 11
[    0.437247] pci 0000:00:14.3: Adding to iommu group 11
[    0.437281] pci 0000:00:18.0: Adding to iommu group 12
[    0.437286] pci 0000:00:18.1: Adding to iommu group 12
[    0.437292] pci 0000:00:18.2: Adding to iommu group 12
[    0.437298] pci 0000:00:18.3: Adding to iommu group 12
[    0.437303] pci 0000:00:18.4: Adding to iommu group 12
[    0.437309] pci 0000:00:18.5: Adding to iommu group 12
[    0.437315] pci 0000:00:18.6: Adding to iommu group 12
[    0.437320] pci 0000:00:18.7: Adding to iommu group 12
[    0.437334] pci 0000:01:00.0: Adding to iommu group 13
[    0.437341] pci 0000:01:00.1: Adding to iommu group 13
[    0.437347] pci 0000:02:00.0: Adding to iommu group 14
[    0.437353] pci 0000:03:00.0: Adding to iommu group 15
[    0.437360] pci 0000:04:00.0: Adding to iommu group 16
[    0.437366] pci 0000:04:04.0: Adding to iommu group 17
[    0.437372] pci 0000:04:05.0: Adding to iommu group 18
[    0.437378] pci 0000:04:06.0: Adding to iommu group 19
[    0.437384] pci 0000:04:07.0: Adding to iommu group 20
[    0.437390] pci 0000:04:08.0: Adding to iommu group 21
[    0.437396] pci 0000:04:0c.0: Adding to iommu group 22
[    0.437402] pci 0000:04:0d.0: Adding to iommu group 23
[    0.437404] pci 0000:0a:00.0: Adding to iommu group 21
[    0.437405] pci 0000:0b:00.0: Adding to iommu group 21
[    0.437407] pci 0000:0b:02.0: Adding to iommu group 21
[    0.437408] pci 0000:0b:03.0: Adding to iommu group 21
[    0.437409] pci 0000:0b:04.0: Adding to iommu group 21
[    0.437411] pci 0000:0b:08.0: Adding to iommu group 21
[    0.437412] pci 0000:0b:0c.0: Adding to iommu group 21
[    0.437414] pci 0000:0b:0d.0: Adding to iommu group 21
[    0.437415] pci 0000:0d:00.0: Adding to iommu group 21
[    0.437417] pci 0000:0e:00.0: Adding to iommu group 21
[    0.437418] pci 0000:11:00.0: Adding to iommu group 21
[    0.437419] pci 0000:12:00.0: Adding to iommu group 21
[    0.437421] pci 0000:13:00.0: Adding to iommu group 22
[    0.437422] pci 0000:14:00.0: Adding to iommu group 23
[    0.437428] pci 0000:15:00.0: Adding to iommu group 24
[    0.437434] pci 0000:16:00.0: Adding to iommu group 25
[    0.437440] pci 0000:16:01.0: Adding to iommu group 26
[    0.437447] pci 0000:16:02.0: Adding to iommu group 27
[    0.437453] pci 0000:16:03.0: Adding to iommu group 28
[    0.437454] pci 0000:77:00.0: Adding to iommu group 27
[    0.437456] pci 0000:78:00.0: Adding to iommu group 28
[    0.437477] pci 0000:79:00.0: Adding to iommu group 29
[    0.437483] pci 0000:79:00.1: Adding to iommu group 30
[    0.437491] pci 0000:79:00.2: Adding to iommu group 31
[    0.437497] pci 0000:79:00.3: Adding to iommu group 32
[    0.437503] pci 0000:79:00.4: Adding to iommu group 33
[    0.437510] pci 0000:79:00.6: Adding to iommu group 34
[    0.437516] pci 0000:7a:00.0: Adding to iommu group 35
[    0.438777] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX =
GT [5] IA GA PC GA_vAPIC
[    0.438780] AMD-Vi: Interrupt remapping enabled
[    0.494764] Freeing initrd memory: 89300K
[    1.250386] AMD-Vi: Virtual APIC enabled
[    1.250396] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.250397] software IO TLB: mapped [mem 0x000000007d105000-0x0000000081=
105000] (64MB)
[    1.250427] LVT offset 0 assigned for vector 0x400
[    1.250491] perf: AMD IBS detected (0x00081bff)
[    1.250496] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/b=
ank).
[    1.251313] Initialise system trusted keyrings
[    1.251319] Key type blacklist registered
[    1.251330] workingset: timestamp_bits=3D41 max_order=3D24 bucket_order=
=3D0
[    1.251334] zbud: loaded
[    1.251374] fuse: init (API version 7.41)
[    1.251410] integrity: Platform Keyring initialized
[    1.251411] integrity: Machine keyring initialized
[    1.255717] Key type asymmetric registered
[    1.255717] Asymmetric key parser 'x509' registered
[    1.255725] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    1.255742] io scheduler mq-deadline registered
[    1.255743] io scheduler kyber registered
[    1.255746] io scheduler bfq registered
[    1.256617] ledtrig-cpu: registered to indicate activity on CPUs
[    1.256691] pcieport 0000:00:01.1: PME: Signaling with IRQ 29
[    1.256792] pcieport 0000:00:01.2: PME: Signaling with IRQ 30
[    1.256886] pcieport 0000:00:02.1: PME: Signaling with IRQ 31
[    1.256979] pcieport 0000:00:02.2: PME: Signaling with IRQ 32
[    1.257094] pcieport 0000:00:08.1: PME: Signaling with IRQ 33
[    1.257172] pcieport 0000:00:08.3: PME: Signaling with IRQ 34
[    1.258802] pcieport 0000:16:00.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.258975] pcieport 0000:16:01.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+
[    1.259172] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.259263] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input0
[    1.259272] ACPI: button: Power Button [PWRB]
[    1.259282] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input1
[    1.260405] ACPI: button: Power Button [PWRF]
[    1.260561] Monitor-Mwait will be used to enter C-1 state
[    1.261301] Estimated ratio of average max frequency by base frequency (=
times 1024): 1086
[    2.257336] tsc: Refined TSC clocksource calibration: 4691.167 MHz
[    2.257346] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x439=
ed476f61, max_idle_ns: 440795356832 ns
[    2.257374] clocksource: Switched to clocksource tsc
[    3.380300] ACPI: \_TZ_.TZ10: _PSL evaluation failure
[    3.380445] thermal LNXTHERM:00: registered as thermal_zone0
[    3.380447] ACPI: thermal: Thermal Zone [TZ10] (17 C)
[    3.380659] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.381312] Non-volatile memory driver v1.3
[    3.381313] Linux agpgart interface v0.103
[    3.477405] tpm_crb MSFT0101:00: Disabling hwrng
[    3.477687] ACPI: bus type drm_connector registered
[    3.478841] ahci 0000:12:00.0: version 3.0
[    3.478956] ahci 0000:12:00.0: SSS flag set, parallel bus scan disabled
[    3.478993] ahci 0000:12:00.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    3.478995] ahci 0000:12:00.0: 4/6 ports implemented (port mask 0xf)
[    3.478995] ahci 0000:12:00.0: flags: 64bit ncq sntf stag pm led clo onl=
y pmp pio slum part sxs deso sadm sds apst=20
[    3.479202] scsi host0: ahci
[    3.479281] scsi host1: ahci
[    3.479347] scsi host2: ahci
[    3.479386] scsi host3: ahci
[    3.479430] scsi host4: ahci
[    3.479460] scsi host5: ahci
[    3.479471] ata1: SATA max UDMA/133 abar m1024@0xde680000 port 0xde68010=
0 irq 50 lpm-pol 0
[    3.479472] ata2: SATA max UDMA/133 abar m1024@0xde680000 port 0xde68018=
0 irq 50 lpm-pol 0
[    3.479474] ata3: SATA max UDMA/133 abar m1024@0xde680000 port 0xde68020=
0 irq 50 lpm-pol 0
[    3.479475] ata4: SATA max UDMA/133 abar m1024@0xde680000 port 0xde68028=
0 irq 50 lpm-pol 0
[    3.479476] ata5: DUMMY
[    3.479476] ata6: DUMMY
[    3.479569] ahci 0000:14:00.0: SSS flag set, parallel bus scan disabled
[    3.479592] ahci 0000:14:00.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    3.479593] ahci 0000:14:00.0: 4/6 ports implemented (port mask 0xf)
[    3.479594] ahci 0000:14:00.0: flags: 64bit ncq sntf stag pm led clo onl=
y pmp pio slum part sxs deso sadm sds apst=20
[    3.479742] scsi host6: ahci
[    3.479775] scsi host7: ahci
[    3.479814] scsi host8: ahci
[    3.479843] scsi host9: ahci
[    3.479871] scsi host10: ahci
[    3.479901] scsi host11: ahci
[    3.479912] ata7: SATA max UDMA/133 abar m1024@0xdea80000 port 0xdea8010=
0 irq 51 lpm-pol 0
[    3.479913] ata8: SATA max UDMA/133 abar m1024@0xdea80000 port 0xdea8018=
0 irq 51 lpm-pol 0
[    3.479915] ata9: SATA max UDMA/133 abar m1024@0xdea80000 port 0xdea8020=
0 irq 51 lpm-pol 0
[    3.479916] ata10: SATA max UDMA/133 abar m1024@0xdea80000 port 0xdea802=
80 irq 51 lpm-pol 0
[    3.479916] ata11: DUMMY
[    3.479917] ata12: DUMMY
[    3.480004] xhci_hcd 0000:11:00.0: xHCI Host Controller
[    3.480007] xhci_hcd 0000:11:00.0: new USB bus registered, assigned bus =
number 1
[    3.535980] xhci_hcd 0000:11:00.0: hcc params 0x0200ef81 hci version 0x1=
10 quirks 0x0000000000000010
[    3.536213] xhci_hcd 0000:11:00.0: xHCI Host Controller
[    3.536214] xhci_hcd 0000:11:00.0: new USB bus registered, assigned bus =
number 2
[    3.536214] xhci_hcd 0000:11:00.0: Host supports USB 3.2 Enhanced SuperS=
peed
[    3.536950] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    3.536951] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.536952] usb usb1: Product: xHCI Host Controller
[    3.536952] usb usb1: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 x=
hci-hcd
[    3.536953] usb usb1: SerialNumber: 0000:11:00.0
[    3.537001] hub 1-0:1.0: USB hub found
[    3.537015] hub 1-0:1.0: 12 ports detected
[    3.537140] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    3.537147] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    3.537148] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.537148] usb usb2: Product: xHCI Host Controller
[    3.537148] usb usb2: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 x=
hci-hcd
[    3.537149] usb usb2: SerialNumber: 0000:11:00.0
[    3.537183] hub 2-0:1.0: USB hub found
[    3.537190] hub 2-0:1.0: 5 ports detected
[    3.537264] xhci_hcd 0000:13:00.0: xHCI Host Controller
[    3.537265] xhci_hcd 0000:13:00.0: new USB bus registered, assigned bus =
number 3
[    3.593225] xhci_hcd 0000:13:00.0: hcc params 0x0200ef81 hci version 0x1=
10 quirks 0x0000000000000010
[    3.593394] xhci_hcd 0000:13:00.0: xHCI Host Controller
[    3.593395] xhci_hcd 0000:13:00.0: new USB bus registered, assigned bus =
number 4
[    3.593396] xhci_hcd 0000:13:00.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    3.594209] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    3.594210] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.594210] usb usb3: Product: xHCI Host Controller
[    3.594211] usb usb3: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 x=
hci-hcd
[    3.594211] usb usb3: SerialNumber: 0000:13:00.0
[    3.594262] hub 3-0:1.0: USB hub found
[    3.594271] hub 3-0:1.0: 12 ports detected
[    3.596160] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    3.596166] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    3.596167] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.596167] usb usb4: Product: xHCI Host Controller
[    3.596168] usb usb4: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 x=
hci-hcd
[    3.596168] usb usb4: SerialNumber: 0000:13:00.0
[    3.596202] hub 4-0:1.0: USB hub found
[    3.596211] hub 4-0:1.0: 6 ports detected
[    3.597252] xhci_hcd 0000:77:00.0: xHCI Host Controller
[    3.597254] xhci_hcd 0000:77:00.0: new USB bus registered, assigned bus =
number 5
[    3.599847] xhci_hcd 0000:77:00.0: hcc params 0x0200ef81 hci version 0x1=
20 quirks 0x0000000200000010
[    3.600026] xhci_hcd 0000:77:00.0: xHCI Host Controller
[    3.600027] xhci_hcd 0000:77:00.0: new USB bus registered, assigned bus =
number 6
[    3.600027] xhci_hcd 0000:77:00.0: Host supports USB 3.2 Enhanced SuperS=
peed
[    3.600047] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    3.600048] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.600049] usb usb5: Product: xHCI Host Controller
[    3.600049] usb usb5: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 x=
hci-hcd
[    3.600049] usb usb5: SerialNumber: 0000:77:00.0
[    3.600090] hub 5-0:1.0: USB hub found
[    3.600097] hub 5-0:1.0: 2 ports detected
[    3.600517] usb usb6: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    3.600524] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    3.600524] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.600525] usb usb6: Product: xHCI Host Controller
[    3.600525] usb usb6: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 x=
hci-hcd
[    3.600526] usb usb6: SerialNumber: 0000:77:00.0
[    3.600559] hub 6-0:1.0: USB hub found
[    3.600561] hub 6-0:1.0: 2 ports detected
[    3.601025] xhci_hcd 0000:79:00.3: xHCI Host Controller
[    3.601027] xhci_hcd 0000:79:00.3: new USB bus registered, assigned bus =
number 7
[    3.601371] xhci_hcd 0000:79:00.3: hcc params 0x0120ffc5 hci version 0x1=
20 quirks 0x0000000200000010
[    3.601604] xhci_hcd 0000:79:00.3: xHCI Host Controller
[    3.601605] xhci_hcd 0000:79:00.3: new USB bus registered, assigned bus =
number 8
[    3.601605] xhci_hcd 0000:79:00.3: Host supports USB 3.1 Enhanced SuperS=
peed
[    3.601616] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    3.601616] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.601617] usb usb7: Product: xHCI Host Controller
[    3.601617] usb usb7: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 x=
hci-hcd
[    3.601618] usb usb7: SerialNumber: 0000:79:00.3
[    3.601654] hub 7-0:1.0: USB hub found
[    3.601658] hub 7-0:1.0: 2 ports detected
[    3.602037] usb usb8: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    3.602044] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    3.602044] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.602045] usb usb8: Product: xHCI Host Controller
[    3.602045] usb usb8: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 x=
hci-hcd
[    3.602045] usb usb8: SerialNumber: 0000:79:00.3
[    3.602080] hub 8-0:1.0: USB hub found
[    3.602082] hub 8-0:1.0: 2 ports detected
[    3.602526] xhci_hcd 0000:79:00.4: xHCI Host Controller
[    3.602528] xhci_hcd 0000:79:00.4: new USB bus registered, assigned bus =
number 9
[    3.602882] xhci_hcd 0000:79:00.4: hcc params 0x0120ffc5 hci version 0x1=
20 quirks 0x0000000200000010
[    3.603108] xhci_hcd 0000:79:00.4: xHCI Host Controller
[    3.603109] xhci_hcd 0000:79:00.4: new USB bus registered, assigned bus =
number 10
[    3.603109] xhci_hcd 0000:79:00.4: Host supports USB 3.1 Enhanced SuperS=
peed
[    3.603119] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    3.603120] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    3.603120] usb usb9: Product: xHCI Host Controller
[    3.603121] usb usb9: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 x=
hci-hcd
[    3.603121] usb usb9: SerialNumber: 0000:79:00.4
[    3.603159] hub 9-0:1.0: USB hub found
[    3.603165] hub 9-0:1.0: 2 ports detected
[    3.603539] usb usb10: We don't know the algorithms for LPM for this hos=
t, disabling LPM.
[    3.603546] usb usb10: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    3.603546] usb usb10: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    3.603547] usb usb10: Product: xHCI Host Controller
[    3.603547] usb usb10: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 =
xhci-hcd
[    3.603547] usb usb10: SerialNumber: 0000:79:00.4
[    3.603581] hub 10-0:1.0: USB hub found
[    3.603587] hub 10-0:1.0: 2 ports detected
[    3.604031] xhci_hcd 0000:7a:00.0: xHCI Host Controller
[    3.604032] xhci_hcd 0000:7a:00.0: new USB bus registered, assigned bus =
number 11
[    3.605296] xhci_hcd 0000:7a:00.0: USB3 root hub has no ports
[    3.605297] xhci_hcd 0000:7a:00.0: hcc params 0x0110ffc5 hci version 0x1=
20 quirks 0x0000000200000010
[    3.605534] xhci_hcd 0000:7a:00.0: xHCI Host Controller
[    3.605535] xhci_hcd 0000:7a:00.0: new USB bus registered, assigned bus =
number 12
[    3.605535] xhci_hcd 0000:7a:00.0: Host supports USB 3.0 SuperSpeed
[    3.605549] usb usb11: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.13
[    3.605550] usb usb11: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    3.605550] usb usb11: Product: xHCI Host Controller
[    3.605551] usb usb11: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 =
xhci-hcd
[    3.605551] usb usb11: SerialNumber: 0000:7a:00.0
[    3.605586] hub 11-0:1.0: USB hub found
[    3.605588] hub 11-0:1.0: 1 port detected
[    3.605777] usb usb12: We don't know the algorithms for LPM for this hos=
t, disabling LPM.
[    3.605784] usb usb12: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.13
[    3.605784] usb usb12: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
[    3.605785] usb usb12: Product: xHCI Host Controller
[    3.605785] usb usb12: Manufacturer: Linux 6.13.1-1-00199-gff9da436ac13 =
xhci-hcd
[    3.605785] usb usb12: SerialNumber: 0000:7a:00.0
[    3.605818] hub 12-0:1.0: USB hub found
[    3.605820] hub 12-0:1.0: config failed, hub doesn't have any ports! (er=
r -19)
[    3.605823] fbcon: Taking over console
[    3.605893] usbcore: registered new interface driver usbserial_generic
[    3.605895] usbserial: USB Serial support registered for generic
[    3.605929] rtc_cmos 00:02: RTC can wake from S4
[    3.606076] rtc_cmos 00:02: registered as rtc0
[    3.606095] rtc_cmos 00:02: setting system clock to 2025-02-12T16:34:06 =
UTC (1739378046)
[    3.606111] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
[    3.606884] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 o=
n minor 0
[    3.607506] Console: switching to colour frame buffer device 160x45
[    3.608115] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    3.608447] hid: raw HID events driver (C) Jiri Kosina
[    3.608473] drop_monitor: Initializing network drop monitor service
[    3.608524] NET: Registered PF_INET6 protocol family
[    3.611456] Segment Routing with IPv6
[    3.611456] RPL Segment Routing with IPv6
[    3.611459] In-situ OAM (IOAM) with IPv6
[    3.611468] NET: Registered PF_PACKET protocol family
[    3.611950] microcode: Current revision: 0x0b404023
[    3.612095] resctrl: L3 allocation detected
[    3.612095] resctrl: MB allocation detected
[    3.612096] resctrl: SMBA allocation detected
[    3.612096] resctrl: L3 monitoring detected
[    3.612104] IPI shorthand broadcast: enabled
[    3.612679] sched_clock: Marking stable (3611702087, 390026)->(361512799=
0, -3035877)
[    3.612750] registered taskstats version 1
[    3.612956] Loading compiled-in X.509 certificates
[    3.615102] Loaded X.509 cert 'Build time autogenerated kernel key: ad68=
e83554d51a43bcd057912983d5f391bbc4a5'
[    3.616406] zswap: loaded using pool zstd/zsmalloc
[    3.616425] Demotion targets for Node 0: null
[    3.616464] Key type .fscrypt registered
[    3.616465] Key type fscrypt-provisioning registered
[    3.616536] integrity: Loading X.509 certificate: UEFI:db
[    3.618142] integrity: Loaded X.509 cert 'Database Key: 00947180a7e14d58=
a351b3cecc2879b4ad'
[    3.618143] integrity: Loading X.509 certificate: UEFI:db
[    3.618150] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    3.618150] integrity: Loading X.509 certificate: UEFI:db
[    3.618155] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    3.618313] PM:   Magic number: 13:602:590
[    3.618314] PM:   hash matches drivers/base/power/main.c:1591
[    3.619673] RAS: Correctable Errors collector initialized.
[    3.624469] clk: Disabling unused clocks
[    3.624471] PM: genpd: Disabling unused power domains
[    3.726115] pci_bus 0000:04: Allocating resources
[    3.791527] ata1: SATA link down (SStatus 0 SControl 330)
[    3.844031] usb 1-1: new full-speed USB device number 2 using xhci_hcd
[    3.900668] usb 3-7: new full-speed USB device number 2 using xhci_hcd
[    3.907120] usb 5-2: new high-speed USB device number 2 using xhci_hcd
[    3.943989] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.944979] ata7.00: ATA-11: WDC  WDS400T2B0A-00SM50, 415020WD, max UDMA=
/133
[    3.945150] ata7.00: 7814037168 sectors, multi 1: LBA48 NCQ (depth 32), =
AA
[    3.949175] ata7.00: Features: Dev-Sleep
[    3.954906] ata7.00: configured for UDMA/133
[    4.098285] ata2: SATA link down (SStatus 0 SControl 330)
[    4.102241] usb 5-2: New USB device found, idVendor=3D2e1a, idProduct=3D=
4c01, bcdDevice=3D 2.00
[    4.102248] usb 5-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    4.102250] usb 5-2: Product: Insta360 Link
[    4.102250] usb 5-2: Manufacturer: Insta360
[    4.220330] usb 1-1: New USB device found, idVendor=3D1038, idProduct=3D=
2202, bcdDevice=3D 1.11
[    4.220336] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    4.220338] usb 1-1: Product: Arctis Nova 7
[    4.220339] usb 1-1: Manufacturer: SteelSeries
[    4.330035] usb 3-7: New USB device found, idVendor=3D048d, idProduct=3D=
5711, bcdDevice=3D 0.03
[    4.330041] usb 3-7: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    4.330043] usb 3-7: Product: GIGABYTE Device=20
[    4.330044] usb 3-7: Manufacturer: ITE Tech. Inc.
[    4.405982] ata3: SATA link down (SStatus 0 SControl 330)
[    4.414015] usb 1-2: new full-speed USB device number 3 using xhci_hcd
[    4.543998] usb 3-9: new full-speed USB device number 3 using xhci_hcd
[    4.716295] ata4: SATA link down (SStatus 0 SControl 330)
[    4.716503] scsi 6:0:0:0: Direct-Access     ATA      WDC  WDS400T2B0A 20=
WD PQ: 0 ANSI: 5
[    4.716663] sd 6:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 =
TB/3.64 TiB)
[    4.716667] sd 6:0:0:0: [sda] Write Protect is off
[    4.716669] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.716674] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    4.716688] sd 6:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    4.740320]  sda: sda1
[    4.740434] sd 6:0:0:0: [sda] Attached SCSI disk
[    4.788356] usb 1-2: New USB device found, idVendor=3D046d, idProduct=3D=
c547, bcdDevice=3D 4.02
[    4.788362] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    4.788364] usb 1-2: Product: USB Receiver
[    4.788365] usb 1-2: Manufacturer: Logitech
[    4.854062] usb 3-9: New USB device found, idVendor=3D0909, idProduct=3D=
001a, bcdDevice=3D 1.00
[    4.854069] usb 3-9: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    4.854070] usb 3-9: Product: ATR USB microphone=20
[    4.854071] usb 3-9: Manufacturer: Audio-Technica
[    4.987424] usb 1-6: new high-speed USB device number 4 using xhci_hcd
[    5.040676] usb 3-12: new full-speed USB device number 4 using xhci_hcd
[    5.180779] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    5.181804] ata8.00: ATA-9: SanDisk SDSSDHII960G, X31200RL, max UDMA/133
[    5.181849] ata8.00: 1875385008 sectors, multi 1: LBA48 NCQ (depth 32), =
AA
[    5.182843] ata8.00: Features: Dev-Sleep
[    5.184530] ata8.00: configured for UDMA/133
[    5.184665] scsi 7:0:0:0: Direct-Access     ATA      SanDisk SDSSDHII 00=
RL PQ: 0 ANSI: 5
[    5.184831] sd 7:0:0:0: [sdb] 1875385008 512-byte logical blocks: (960 G=
B/894 GiB)
[    5.184836] sd 7:0:0:0: [sdb] Write Protect is off
[    5.184838] sd 7:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.184841] sd 7:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    5.184851] sd 7:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[    5.211841]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5
[    5.211915] sd 7:0:0:0: [sdb] Attached SCSI disk
[    5.213554] usb 1-6: New USB device found, idVendor=3D0489, idProduct=3D=
e124, bcdDevice=3D 1.00
[    5.213557] usb 1-6: New USB device strings: Mfr=3D5, Product=3D6, Seria=
lNumber=3D7
[    5.213559] usb 1-6: Product: Wireless_Device
[    5.213561] usb 1-6: Manufacturer: MediaTek Inc.
[    5.213562] usb 1-6: SerialNumber: 000000000
[    5.417038] usb 3-12: New USB device found, idVendor=3D046d, idProduct=
=3Dc548, bcdDevice=3D 5.02
[    5.417045] usb 3-12: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D0
[    5.417046] usb 3-12: Product: USB Receiver
[    5.417047] usb 3-12: Manufacturer: Logitech
[    5.492387] ata9: SATA link down (SStatus 0 SControl 300)
[    5.804286] ata10: SATA link down (SStatus 0 SControl 300)
[    5.805010] Freeing unused decrypted memory: 2028K
[    5.805256] Freeing unused kernel image (initmem) memory: 3564K
[    5.805260] Write protecting the kernel read-only data: 32768k
[    5.805380] Freeing unused kernel image (rodata/data gap) memory: 228K
[    5.823549] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    5.823553] rodata_test: all tests were successful
[    5.823562] Run /init as init process
[    5.823563]   with arguments:
[    5.823564]     /init
[    5.823564]   with environment:
[    5.823565]     HOME=3D/
[    5.823565]     TERM=3Dlinux
[    5.823566]     BOOT_IMAGE=3D/@/boot/vmlinuz-linux
[    5.828151] systemd[1]: Successfully made /usr/ read-only.
[    5.828223] systemd[1]: systemd 257.2-2-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[    5.828226] systemd[1]: Detected architecture x86-64.
[    5.828227] systemd[1]: Running in initrd.
[    5.828314] systemd[1]: Initializing machine ID from random generator.
[    5.880003] systemd[1]: Queued start job for default target Initrd Defau=
lt Target.
[    5.881095] systemd[1]: Expecting device /dev/disk/by-uuid/04de5227-e261=
-4049-9f7b-6c95c0e36ef9...
[    5.881187] systemd[1]: Reached target Path Units.
[    5.881224] systemd[1]: Reached target Slice Units.
[    5.881243] systemd[1]: Reached target Swaps.
[    5.881253] systemd[1]: Reached target Timer Units.
[    5.881295] systemd[1]: Listening on Journal Socket (/dev/log).
[    5.881320] systemd[1]: Listening on Journal Sockets.
[    5.881344] systemd[1]: Listening on udev Control Socket.
[    5.881362] systemd[1]: Listening on udev Kernel Socket.
[    5.881373] systemd[1]: Reached target Socket Units.
[    5.881767] systemd[1]: Starting Create List of Static Device Nodes...
[    5.881841] systemd[1]: Check battery level during early boot was skippe=
d because of an unmet condition check (ConditionDirectoryNotEmpty=3D/sys/cl=
ass/power_supply).
[    5.882181] systemd[1]: Started Display Boot-Time Emergency Messages In =
Full Screen.
[    5.882804] systemd[1]: Starting Journal Service...
[    5.883082] systemd[1]: Starting Load Kernel Modules...
[    5.883131] systemd[1]: TPM PCR Barrier (initrd) was skipped because of =
an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    5.883319] systemd[1]: Starting Create Static Device Nodes in /dev...
[    5.883545] systemd[1]: Starting Coldplug All udev Devices...
[    5.883757] systemd[1]: Finished Create List of Static Device Nodes.
[    5.885566] systemd[1]: Finished Load Kernel Modules.
[    5.886054] systemd[1]: Finished Create Static Device Nodes in /dev.
[    5.886212] systemd[1]: Reached target Preparation for Local File System=
s.
[    5.886257] systemd[1]: Reached target Local File Systems.
[    5.886662] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[    5.888176] systemd-journald[243]: Collecting audit messages is disabled.
[    5.893434] systemd[1]: Started Rule-based Manager for Device Events and=
 Files.
[    5.914462] systemd[1]: Started Journal Service.
[    5.949278] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  p=
ost: no)
[    5.949567] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/device:20/LNXVIDEO:00/input/input2
[    5.955691] nvme 0000:02:00.0: platform quirk: setting simple suspend
[    5.955728] nvme nvme0: pci function 0000:02:00.0
[    5.960660] nvme nvme0: D3 entry latency set to 10 seconds
[    5.963574] nvme nvme0: 16/0/0 default/read/poll queues
[    5.965368]  nvme0n1: p1 p2 p3
[    5.973531] raid6: skipped pq benchmark and selected avx512x4
[    5.973533] raid6: using avx512x2 recovery algorithm
[    5.975021] xor: automatically using best checksumming function   avx   =
   =20
[    6.014112] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    6.057824] usbcore: registered new interface driver usbhid
[    6.057828] usbhid: USB HID core driver
[    6.069318] hid-generic 0003:1038:2202.0001: hiddev96,hidraw0: USB HID v=
1.11 Device [SteelSeries Arctis Nova 7] on usb-0000:11:00.0-1/input3
[    6.069368] input: SteelSeries Arctis Nova 7 as /devices/pci0000:00/0000=
:00:02.1/0000:03:00.0/0000:04:08.0/0000:0a:00.0/0000:0b:0c.0/0000:11:00.0/u=
sb1/1-1/1-1:1.4/0003:1038:2202.0002/input/input3
[    6.120439] hid-generic 0003:1038:2202.0002: input,hidraw1: USB HID v1.1=
1 Device [SteelSeries Arctis Nova 7] on usb-0000:11:00.0-1/input4
[    6.120492] hid-generic 0003:1038:2202.0003: hiddev97,hidraw2: USB HID v=
1.11 Device [SteelSeries Arctis Nova 7] on usb-0000:11:00.0-1/input5
[    6.120555] hid-generic 0003:048D:5711.0004: hiddev98,hidraw3: USB HID v=
1.10 Device [ITE Tech. Inc. GIGABYTE Device ] on usb-0000:13:00.0-7/input0
[    6.120596] hid-generic 0003:048D:5711.0005: hiddev99,hidraw4: USB HID v=
1.10 Device [ITE Tech. Inc. GIGABYTE Device ] on usb-0000:13:00.0-7/input1
[    6.120637] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
02.1/0000:03:00.0/0000:04:08.0/0000:0a:00.0/0000:0b:0c.0/0000:11:00.0/usb1/=
1-2/1-2:1.0/0003:046D:C547.0006/input/input4
[    6.120661] hid-generic 0003:046D:C547.0006: input,hidraw5: USB HID v1.1=
1 Mouse [Logitech USB Receiver] on usb-0000:11:00.0-2/input0
[    6.120785] input: Logitech USB Receiver Keyboard as /devices/pci0000:00=
/0000:00:02.1/0000:03:00.0/0000:04:08.0/0000:0a:00.0/0000:0b:0c.0/0000:11:0=
0.0/usb1/1-2/1-2:1.1/0003:046D:C547.0007/input/input5
[    6.759278] [drm] amdgpu kernel modesetting enabled.
[    6.759291] amdgpu: vga_switcheroo: detected switching method \_SB_.PCI0=
=2EGP17.VGA_.ATPX handle
[    6.759351] amdgpu: ATPX version 1, functions 0x00000000
[    6.762342] amdgpu: Virtual CRAT table created for CPU
[    6.762348] amdgpu: Topology: Add CPU node
[    6.762405] amdgpu 0000:79:00.0: enabling device (0006 -> 0007)
[    6.762426] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0=
x13C0 0x1458:0xD000 0xCB).
[    6.762432] [drm] register mmio base: 0xDF100000
[    6.762433] [drm] register mmio size: 524288
[    6.763830] [drm] add ip block number 0 <nv_common>
[    6.763831] [drm] add ip block number 1 <gmc_v10_0>
[    6.763832] [drm] add ip block number 2 <navi10_ih>
[    6.763832] [drm] add ip block number 3 <psp>
[    6.763833] [drm] add ip block number 4 <smu>
[    6.763833] [drm] add ip block number 5 <dm>
[    6.763834] [drm] add ip block number 6 <gfx_v10_0>
[    6.763834] [drm] add ip block number 7 <sdma_v5_2>
[    6.763835] [drm] add ip block number 8 <vcn_v3_0>
[    6.763835] [drm] add ip block number 9 <jpeg_v3_0>
[    6.763844] amdgpu 0000:79:00.0: amdgpu: Fetched VBIOS from VFCT
[    6.763845] amdgpu: ATOM BIOS: 102-RAPHAEL-008
[    6.766420] amdgpu 0000:79:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re disabled as experimental (default)
[    6.766442] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
[    6.766445] amdgpu 0000:79:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 =
- 0x000000F47FFFFFFF (2048M used)
[    6.766446] amdgpu 0000:79:00.0: amdgpu: GART: 1024M 0x0000000000000000 =
- 0x000000003FFFFFFF
[    6.766451] [drm] Detected VRAM RAM=3D2048M, BAR=3D2048M
[    6.766451] [drm] RAM width 128bits DDR5
[    6.766506] [drm] amdgpu: 2048M of VRAM memory ready
[    6.766506] [drm] amdgpu: 30946M of GTT memory ready.
[    6.766514] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    6.766608] [drm] PCIE GART of 1024M enabled (table at 0x000000F47FC0000=
0).
[    6.766816] [drm] Loading DMUB firmware via PSP: version=3D0x05001C00
[    6.767020] [drm] use_doorbell being set to: [true]
[    6.767028] [drm] Found VCN firmware Version ENC: 1.31 DEC: 3 VEP: 0 Rev=
ision: 3
[    6.788921] amdgpu 0000:79:00.0: amdgpu: reserve 0xa00000 from 0xf47e000=
000 for PSP TMR
[    6.810490] hid-generic 0003:046D:C547.0007: input,hidraw6: USB HID v1.1=
1 Keyboard [Logitech USB Receiver] on usb-0000:11:00.0-2/input1
[    6.810567] hid-generic 0003:046D:C547.0008: hiddev100,hidraw7: USB HID =
v1.11 Device [Logitech USB Receiver] on usb-0000:11:00.0-2/input2
[    6.810606] input: Audio-Technica ATR USB microphone  Consumer Control a=
s /devices/pci0000:00/0000:00:02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/u=
sb3/3-9/3-9:1.3/0003:0909:001A.0009/input/input6
[    6.852918] amdgpu 0000:79:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[    6.858473] amdgpu 0000:79:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
[    6.858473] amdgpu 0000:79:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[    6.860010] amdgpu 0000:79:00.0: amdgpu: SMU is initialized successfully!
[    6.860011] [drm] Seamless boot condition check passed
[    6.860279] [drm] Display Core v3.2.310 initialized on DCN 3.1.5
[    6.860280] [drm] DP-HDMI FRL PCON supported
[    6.860939] [drm] DMUB hardware initialized: version=3D0x05001C00
[    6.861878] [drm] kiq ring mec 2 pipe 1 q 0
[    6.864683] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    6.864695] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    6.865094] amdgpu: Virtual CRAT table created for GPU
[    6.865170] amdgpu: Topology: Add dGPU node [0x13c0:0x1002]
[    6.865171] kfd kfd: amdgpu: added device 1002:13c0
[    6.865178] amdgpu 0000:79:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 2,=
 active_cu_number 2
[    6.865180] amdgpu 0000:79:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on hub 0
[    6.865181] amdgpu 0000:79:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng =
1 on hub 0
[    6.865181] amdgpu 0000:79:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 4 on hub 0
[    6.865182] amdgpu 0000:79:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 5 on hub 0
[    6.865182] amdgpu 0000:79:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 6 on hub 0
[    6.865183] amdgpu 0000:79:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 7 on hub 0
[    6.865183] amdgpu 0000:79:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 8 on hub 0
[    6.865183] amdgpu 0000:79:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 9 on hub 0
[    6.865184] amdgpu 0000:79:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 10 on hub 0
[    6.865184] amdgpu 0000:79:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 11 on hub 0
[    6.865185] amdgpu 0000:79:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 12 on hub 0
[    6.865185] amdgpu 0000:79:00.0: amdgpu: ring sdma0 uses VM inv eng 13 o=
n hub 0
[    6.865185] amdgpu 0000:79:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on hub 8
[    6.865186] amdgpu 0000:79:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1 on hub 8
[    6.865186] amdgpu 0000:79:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4 on hub 8
[    6.865187] amdgpu 0000:79:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on hub 8
[    6.865381] amdgpu 0000:79:00.0: amdgpu: Runtime PM not available
[    6.865517] [drm] Initialized amdgpu 3.59.0 for 0000:79:00.0 on minor 1
[    6.867090] hid-generic 0003:0909:001A.0009: input,hiddev101,hidraw8: US=
B HID v1.00 Device [Audio-Technica ATR USB microphone ] on usb-0000:13:00.0=
-9/input3
[    6.867137] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1.0/0003:046D:C5=
48.000A/input/input8
[    6.868421] amdgpu 0000:79:00.0: [drm] Cannot find any crtc or sizes
[    6.868428] [drm] pre_validate_dsc:1600 MST_DSC dsc precompute is not ne=
eded
[    6.938008] BTRFS: device fsid 04de5227-e261-4049-9f7b-6c95c0e36ef9 devi=
d 1 transid 1260481 /dev/nvme0n1p2 (259:2) scanned by mount (354)
[    6.938156] BTRFS info (device nvme0n1p2): first mount of filesystem 04d=
e5227-e261-4049-9f7b-6c95c0e36ef9
[    6.938169] BTRFS info (device nvme0n1p2): using crc32c (crc32c-intel) c=
hecksum algorithm
[    6.938174] BTRFS info (device nvme0n1p2): using free-space-tree
[    7.050465] hid-generic 0003:046D:C548.000A: input,hidraw9: USB HID v1.1=
1 Keyboard [Logitech USB Receiver] on usb-0000:13:00.0-12/input0
[    7.050598] input: Logitech USB Receiver Mouse as /devices/pci0000:00/00=
00:00:02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1.1/0003:0=
46D:C548.000B/input/input9
[    7.050651] input: Logitech USB Receiver Consumer Control as /devices/pc=
i0000:00/0000:00:02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12=
:1.1/0003:046D:C548.000B/input/input10
[    7.103783] input: Logitech USB Receiver System Control as /devices/pci0=
000:00/0000:00:02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1=
=2E1/0003:046D:C548.000B/input/input11
[    7.103817] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1.1/0003:046D:C5=
48.000B/input/input12
[    7.103867] hid-generic 0003:046D:C548.000B: input,hiddev102,hidraw10: U=
SB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:13:00.0-12/input1
[    7.103925] hid-generic 0003:046D:C548.000C: hiddev103,hidraw11: USB HID=
 v1.11 Device [Logitech USB Receiver] on usb-0000:13:00.0-12/input2
[    7.104003] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1.3/0003:046D:C5=
48.000D/input/input13
[    7.104030] hid-generic 0003:046D:C548.000D: input,hidraw12: USB HID v1.=
11 Device [Logitech USB Receiver] on usb-0000:13:00.0-12/input3
[    7.159860] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:=
02.1/0000:03:00.0/0000:04:0c.0/0000:13:00.0/usb3/3-12/3-12:1.3/0003:046D:C5=
48.000D/input/input14
[    7.159914] hid-multitouch 0003:046D:C548.000D: input,hidraw12: USB HID =
v1.11 Device [Logitech USB Receiver] on usb-0000:13:00.0-12/input3
[    7.414337] systemd-journald[243]: Received SIGTERM from PID 1 (systemd).
[    7.453357] systemd[1]: systemd 257.2-2-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPEN=
SSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETU=
P +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM=
2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP -SYSVINI=
T +LIBARCHIVE)
[    7.453360] systemd[1]: Detected architecture x86-64.
[    7.453882] systemd[1]: Hostname set to <arch-desktop>.
[    7.684170] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    7.865188] systemd[1]: initrd-switch-root.service: Deactivated successf=
ully.
[    7.865243] systemd[1]: Stopped Switch Root.
[    7.865726] systemd[1]: systemd-journald.service: Scheduled restart job,=
 restart counter is at 1.
[    7.866031] systemd[1]: Created slice Slice /system/dirmngr.
[    7.866268] systemd[1]: Created slice Slice /system/getty.
[    7.866483] systemd[1]: Created slice Slice /system/gpg-agent.
[    7.866696] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    7.866902] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    7.867119] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    7.867330] systemd[1]: Created slice Slice /system/keyboxd.
[    7.867534] systemd[1]: Created slice Slice /system/modprobe.
[    7.867734] systemd[1]: Created slice Slice /system/systemd-fsck.
[    7.867882] systemd[1]: Created slice User and Session Slice.
[    7.867972] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    7.868081] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    7.868220] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    7.868298] systemd[1]: Expecting device /dev/disk/by-diskseq/3-part3...
[    7.868372] systemd[1]: Expecting device /dev/disk/by-uuid/04de5227-e261=
-4049-9f7b-6c95c0e36ef9...
[    7.868445] systemd[1]: Expecting device /dev/disk/by-uuid/4FD8-5055...
[    7.868519] systemd[1]: Expecting device /dev/disk/by-uuid/b9ab1ed9-97e5=
-49c6-9f67-027e90edfbd7...
[    7.868596] systemd[1]: Reached target Local Encrypted Volumes.
[    7.868678] systemd[1]: Reached target Login Prompts.
[    7.868760] systemd[1]: Stopped target Switch Root.
[    7.868840] systemd[1]: Stopped target Initrd File Systems.
[    7.868919] systemd[1]: Stopped target Initrd Root File System.
[    7.868998] systemd[1]: Reached target Local Integrity Protected Volumes.
[    7.869082] systemd[1]: Reached target Path Units.
[    7.869159] systemd[1]: Reached target Remote File Systems.
[    7.869235] systemd[1]: Reached target Slice Units.
[    7.869317] systemd[1]: Reached target Local Verity Protected Volumes.
[    7.869417] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.869524] systemd[1]: Listening on LVM2 poll daemon socket.
[    7.871147] systemd[1]: Listening on Process Core Dump Socket.
[    7.871494] systemd[1]: Listening on Credential Encryption/Decryption.
[    7.871591] systemd[1]: TPM PCR Measurements was skipped because of an u=
nmet condition check (ConditionSecurity=3Dmeasured-uki).
[    7.871598] systemd[1]: Make TPM PCR Policy was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    7.871621] systemd[1]: Listening on udev Control Socket.
[    7.871711] systemd[1]: Listening on udev Kernel Socket.
[    7.872560] systemd[1]: Mounting Huge Pages File System...
[    7.873431] systemd[1]: Mounting POSIX Message Queue File System...
[    7.874283] systemd[1]: Mounting Kernel Debug File System...
[    7.874918] systemd[1]: Mounting Kernel Trace File System...
[    7.875525] systemd[1]: Starting Create List of Static Device Nodes...
[    7.875950] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    7.876685] systemd[1]: Starting Load Kernel Module configfs...
[    7.877560] systemd[1]: Starting Load Kernel Module dm_mod...
[    7.877958] systemd[1]: Starting Load Kernel Module drm...
[    7.878414] systemd[1]: Starting Load Kernel Module fuse...
[    7.878982] systemd[1]: Starting Load Kernel Module loop...
[    7.879536] systemd[1]: systemd-fsck-root.service: Deactivated successfu=
lly.
[    7.879559] systemd[1]: Stopped File System Check on Root Device.
[    7.879710] systemd[1]: Clear Stale Hibernate Storage Info was skipped b=
ecause of an unmet condition check (ConditionPathExists=3D/sys/firmware/efi=
/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    7.880268] systemd[1]: Starting Journal Service...
[    7.880763] systemd[1]: Starting Load Kernel Modules...
[    7.880852] systemd[1]: TPM PCR Machine ID Measurement was skipped becau=
se of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    7.881190] systemd[1]: Starting Remount Root and Kernel File Systems...
[    7.881364] systemd[1]: Early TPM SRK Setup was skipped because of an un=
met condition check (ConditionSecurity=3Dmeasured-uki).
[    7.881694] systemd[1]: Starting Load udev Rules from Credentials...
[    7.882112] systemd[1]: Starting Coldplug All udev Devices...
[    7.882946] systemd[1]: Mounted Huge Pages File System.
[    7.883188] systemd[1]: Mounted POSIX Message Queue File System.
[    7.883454] systemd[1]: Mounted Kernel Debug File System.
[    7.883583] systemd[1]: Mounted Kernel Trace File System.
[    7.883762] systemd[1]: Finished Create List of Static Device Nodes.
[    7.883972] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    7.884036] loop: module loaded
[    7.884037] device-mapper: uevent: version 1.0.3
[    7.884054] systemd[1]: Finished Load Kernel Module configfs.
[    7.884070] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    7.884270] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    7.884325] systemd[1]: Finished Load Kernel Module dm_mod.
[    7.884499] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    7.884543] systemd[1]: Finished Load Kernel Module drm.
[    7.884698] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    7.884742] systemd[1]: Finished Load Kernel Module fuse.
[    7.884893] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    7.884936] systemd[1]: Finished Load Kernel Module loop.
[    7.895404] systemd[1]: Mounting FUSE Control File System...
[    7.895728] systemd[1]: Mounting Kernel Configuration File System...
[    7.895862] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    7.896258] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    7.896782] systemd[1]: Finished Load udev Rules from Credentials.
[    7.897377] systemd[1]: Mounted FUSE Control File System.
[    7.897441] systemd-journald[427]: Collecting audit messages is disabled.
[    7.897589] systemd[1]: Mounted Kernel Configuration File System.
[    7.897696] i2c_dev: i2c /dev entries driver
[    7.899260] systemd[1]: Started Journal Service.
[    7.961276] BTRFS info (device nvme0n1p2 state M): force zstd compressio=
n, level 2
[    8.054276] mousedev: PS/2 mouse device common for all mice
[    8.061743] mc: Linux media interface: v0.10
[    8.063608] Adding 33553404k swap on /dev/nvme0n1p3.  Priority:-2 extent=
s:1 across:33553404k SS
[    8.073695] ccp 0000:79:00.2: enabling device (0000 -> 0002)
[    8.075925] ccp 0000:79:00.2: tee enabled
[    8.076150] ccp 0000:79:00.2: psp enabled
[    8.077680] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000=
000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\GSA1=
=2ESMBI) (20240827/utaddress-204)
[    8.077686] ACPI: OSL: Resource conflict; ACPI support missing from driv=
er?
[    8.090489] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    8.090531] input: PC Speaker as /devices/platform/pcspkr/input/input15
[    8.090536] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840=
 ms ovfl timer
[    8.090538] RAPL PMU: hw unit of domain package 2^-16 Joules
[    8.090565] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO ad=
dress
[    8.090664] sp5100-tco sp5100-tco: initialized. heartbeat=3D60 sec (nowa=
yout=3D0)
[    8.090670] ACPI: bus type thunderbolt registered
[    8.090694] thunderbolt 0000:78:00.0: enabling device (0000 -> 0002)
[    8.090783] videodev: Linux video capture interface: v2.00
[    8.090990] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    8.091079] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    8.091151] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    8.091410] platform regulatory.0: Direct firmware load for regulatory.d=
b failed with error -2
[    8.091414] cfg80211: failed to load regulatory.db
[    8.098805] r8169 0000:0e:00.0 eth0: RTL8125D, 10:ff:e0:6a:b0:50, XID 68=
8, IRQ 140
[    8.098808] r8169 0000:0e:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    8.099780] Bluetooth: Core ver 2.22
[    8.099789] NET: Registered PF_BLUETOOTH protocol family
[    8.099790] Bluetooth: HCI device and connection manager initialized
[    8.099792] Bluetooth: HCI socket layer initialized
[    8.099792] cryptd: max_cpu_qlen set to 1000
[    8.099793] Bluetooth: L2CAP socket layer initialized
[    8.099795] Bluetooth: SCO socket layer initialized
[    8.106642] AES CTR mode by8 optimization enabled
[    8.108018] nvidia: loading out-of-tree module taints kernel.
[    8.108024] nvidia: module license 'NVIDIA' taints kernel.
[    8.108025] Disabling lock debugging due to kernel taint
[    8.108026] nvidia: module verification failed: signature and/or require=
d key missing - tainting kernel
[    8.108027] nvidia: module license taints kernel.
[    8.115518] usbcore: registered new interface driver btusb
[    8.131158] r8169 0000:0e:00.0 enp14s0: renamed from eth0
[    8.167933] usb 5-2: Found UVC 1.10 device Insta360 Link (2e1a:4c01)
[    8.174372] usbcore: registered new interface driver uvcvideo
[    8.183469] usb 5-2: Warning! Unlikely big volume range (=3D32767), cval=
->res is probably wrong.
[    8.183472] usb 5-2: [9] FU [Mic Capture Volume] ch =3D 1, val =3D -3276=
8/-1/1
[    8.266562] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[    8.266595] snd_hda_intel 0000:01:00.1: Disabling MSI
[    8.266599] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio clie=
nt
[    8.266644] snd_hda_intel 0000:79:00.1: enabling device (0000 -> 0002)
[    8.266666] snd_hda_intel 0000:79:00.1: Handle vga_switcheroo audio clie=
nt
[    8.266683] snd_hda_intel 0000:79:00.6: enabling device (0000 -> 0002)
[    8.266687] Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 2024=
1104133214
[    8.295441] snd_hda_intel 0000:79:00.1: bound 0000:79:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])
[    8.296085] nvidia-nvlink: Nvlink Core is being initialized, major devic=
e number 235

[    8.296640] nvidia 0000:01:00.0: vgaarb: VGA decodes changed: olddecodes=
=3Dio+mem,decodes=3Dnone:owns=3Dnone
[    8.301855] snd_hda_codec_realtek hdaudioC4D0: autoconfig for ALC1220: l=
ine_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    8.301858] snd_hda_codec_realtek hdaudioC4D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    8.301859] snd_hda_codec_realtek hdaudioC4D0:    hp_outs=3D1 (0x1b/0x0/=
0x0/0x0/0x0)
[    8.301860] snd_hda_codec_realtek hdaudioC4D0:    mono: mono_out=3D0x0
[    8.301860] snd_hda_codec_realtek hdaudioC4D0:    dig-out=3D0x1e/0x0
[    8.301860] snd_hda_codec_realtek hdaudioC4D0:    inputs:
[    8.301861] snd_hda_codec_realtek hdaudioC4D0:      Front Mic=3D0x19
[    8.301862] snd_hda_codec_realtek hdaudioC4D0:      Rear Mic=3D0x18
[    8.305307] mt7925e 0000:0d:00.0: enabling device (0000 -> 0002)
[    8.307377] input: HDA NVidia HDMI/DP,pcm=3D3 as /devices/pci0000:00/000=
0:00:01.1/0000:01:00.1/sound/card2/input20
[    8.307402] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:08.1/0000:79:00.1/sound/card3/input16
[    8.307416] input: HD-Audio Generic HDMI/DP,pcm=3D7 as /devices/pci0000:=
00/0000:00:08.1/0000:79:00.1/sound/card3/input17
[    8.307422] input: HDA NVidia HDMI/DP,pcm=3D7 as /devices/pci0000:00/000=
0:00:01.1/0000:01:00.1/sound/card2/input21
[    8.307438] input: HD-Audio Generic HDMI/DP,pcm=3D8 as /devices/pci0000:=
00/0000:00:08.1/0000:79:00.1/sound/card3/input18
[    8.307452] input: HDA NVidia HDMI/DP,pcm=3D8 as /devices/pci0000:00/000=
0:00:01.1/0000:01:00.1/sound/card2/input22
[    8.307462] input: HD-Audio Generic HDMI/DP,pcm=3D9 as /devices/pci0000:=
00/0000:00:08.1/0000:79:00.1/sound/card3/input19
[    8.307468] input: HDA NVidia HDMI/DP,pcm=3D9 as /devices/pci0000:00/000=
0:00:01.1/0000:01:00.1/sound/card2/input23
[    8.308819] mt7925e 0000:0d:00.0: ASIC revision: 79250000
[    8.311905] input: HD-Audio Generic Front Mic as /devices/pci0000:00/000=
0:00:08.1/0000:79:00.6/sound/card4/input24
[    8.311921] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000=
:00:08.1/0000:79:00.6/sound/card4/input25
[    8.311936] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000=
:00:08.1/0000:79:00.6/sound/card4/input26
[    8.311949] input: HD-Audio Generic Front Headphone as /devices/pci0000:=
00/0000:00:08.1/0000:79:00.6/sound/card4/input27
[    8.327366] kvm_amd: TSC scaling supported
[    8.327367] kvm_amd: Nested Virtualization enabled
[    8.327368] kvm_amd: Nested Paging enabled
[    8.327368] kvm_amd: LBR virtualization supported
[    8.327370] kvm_amd: Virtual VMLOAD VMSAVE supported
[    8.327370] kvm_amd: Virtual GIF supported
[    8.327370] kvm_amd: Virtual NMI enabled
[    8.337717] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  565.77  Wed =
Nov 27 23:33:08 UTC 2024
[    8.345786] nvidia_uvm: module uses symbols nvUvmInterfaceDisableAccessC=
ntr from proprietary module nvidia, inheriting taint.
[    8.348568] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver fo=
r UNIX platforms  565.77  Wed Nov 27 22:53:48 UTC 2024
[    8.383780] mt7925e 0000:0d:00.0: HW/SW Version: 0x8a108a10, Build Time:=
 20241104132949a

[    8.433856] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[    8.434180] nvidia-uvm: Loaded the UVM driver, major device number 511.
[    8.472304] Asymmetric key parser 'pkcs8' registered
[    8.474416] intel_rapl_common: Found RAPL domain package
[    8.474417] intel_rapl_common: Found RAPL domain core
[    8.474797] amd_atl: AMD Address Translation Library initialized
[    8.555990] usbcore: registered new interface driver snd-usb-audio
[    8.722621] mt7925e 0000:0d:00.0: WM Firmware Version: ____000000, Build=
 Time: 20241104133053
[    9.326032] BTRFS: device label storage1 devid 1 transid 354709 /dev/sda=
1 (8:1) scanned by mount (641)
[    9.326764] BTRFS info (device sda1): first mount of filesystem b9ab1ed9=
-97e5-49c6-9f67-027e90edfbd7
[    9.326769] BTRFS info (device sda1): using crc32c (crc32c-intel) checks=
um algorithm
[    9.326771] BTRFS info (device sda1): using free-space-tree
[    9.331284] systemd-journald[427]: Received client request to flush runt=
ime journal.
[    9.345443] [drm] Initialized nvidia-drm 0.0.0 for 0000:01:00.0 on minor=
 2
[    9.345445] nvidia-drm: using linux/aperture workaround for Linux 6.13+
[    9.360449] Console: switching to colour dummy device 80x25
[    9.407268] nvidia 0000:01:00.0: vgaarb: deactivate vga console
[    9.471128] fbcon: nvidia-drmdrmfb (fb0) is primary device
[    9.958598] Console: switching to colour frame buffer device 240x67
[    9.978316] nvidia 0000:01:00.0: [drm] fb0: nvidia-drmdrmfb frame buffer=
 device
[   10.311117] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.311120] Bluetooth: BNEP filters: protocol multicast
[   10.311123] Bluetooth: BNEP socket layer initialized
[   10.560414] Realtek Internal NBASE-T PHY r8169-0-e00:00: attached PHY dr=
iver (mii_bus:phy_addr=3Dr8169-0-e00:00, irq=3DMAC)
[   12.727550] r8169 0000:0e:00.0 enp14s0: Link is Down
[   18.702319] nvme nvme0: using unchecked data buffer
[   20.704293] ahci 0000:14:00.0: port does not support device sleep
[   20.715493] ahci 0000:14:00.0: port does not support device sleep
[   20.738452] warning: `kdeconnectd' uses wireless extensions which will s=
top working for Wi-Fi 7 hardware; use nl80211
[   22.140908] wlan0: authenticate with e8:9f:80:e7:36:be (local address=3D=
44:fa:66:66:57:a9)
[   22.506714] wlan0: send auth to e8:9f:80:e7:36:be (try 1/3)
[   22.538627] wlan0: authenticate with e8:9f:80:e7:36:be (local address=3D=
44:fa:66:66:57:a9)
[   22.551794] wlan0: send auth to e8:9f:80:e7:36:be (try 1/3)
[   22.555040] wlan0: authenticated
[   22.557068] wlan0: associate with e8:9f:80:e7:36:be (try 1/3)
[   22.572713] wlan0: RX AssocResp from e8:9f:80:e7:36:be (capab=3D0x111 st=
atus=3D0 aid=3D2)
[   22.607112] wlan0: associated
[   22.981293] wlan0: Limiting TX power to 21 (24 - 3) dBm as advertised by=
 e8:9f:80:e7:36:be
[   26.753204] Bluetooth: hci0: Device setup in 18200837 usecs
[   26.753209] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.
[   26.922334] Bluetooth: hci0: AOSP extensions version v1.00
[   26.922339] Bluetooth: hci0: AOSP quality report is supported
[   26.922436] Bluetooth: MGMT ver 1.23
[   26.927268] NET: Registered PF_ALG protocol family
[   26.938731] Bluetooth: RFCOMM TTY layer initialized
[   26.938736] Bluetooth: RFCOMM socket layer initialized
[   26.938737] Bluetooth: RFCOMM ver 1.11

--lzlqbxrg6pxvnqvz--

--k65zb2ld7znvcohp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmfBjcgACgkQwEfU8yi1
JYVQSw/7B/lREIDybapNcsYygnPKUYPRSa8o6DaZ4JX9/SnTyB3VrDuAKnR/c5dK
GDzHBJf2pvmKzB6oNRwT5g1/4Nn4+EOWaRsy+FM5msL7BC2ilZTdexk7K//G9p22
wG9YYgF/xPAxeZptQs+hWJ27JaPixWjFS7YV+/ZcNXZ0pkWmnZw8YUVRwdpTlzUR
0rSDp+NtAOwXd6HIHgeHq8RpMYYOMeI32Y4V++Er5UrPtJmx4p3Q/xbRiEqQE/ia
Kz9syBumJsCORUjBFGovjsHsRHlakwT1Vhc/n6dqMj1R3L2g1ipnXeycBjo7T9nz
komoWhd93Iru5mzpNBNCB0id26dxnfvacaaPxU1wTVw6ZbBtn8sb5rNoKwn66W1I
HYcDhtlXnEb/cYXX1PGckjwPRH3TeA6DNUnC5cUi8T2hEvDyI8aiXw7BNcBJlFWQ
PjsVJBIVCaih+V6R6YbMsIM9CQ4FqAApPXrYJixVrJKr2qFHmgrzAped80cT/DCh
tPQFgeIbgTApIwKNj3x3Movax1/7eS2N26CkXij6PaDEsCTO2hNQ2kQX8Gpj1UNP
IQsZEsJWeLvoeQHyz7kGVrDNmUO3diGP4/H0BswkivegU7iHvIXiNTibEYnmzW8g
+SzOoBraEh6jfm/Teuyui+f8ZMj8gZyEItfZauXW0ctx28z0nfo=
=U0Mm
-----END PGP SIGNATURE-----

--k65zb2ld7znvcohp--

