Return-Path: <linux-wireless+bounces-39138-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BikAMtxeV2pPKgEAu9opvQ
	(envelope-from <linux-wireless+bounces-39138-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 12:20:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E76375CE75
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 12:20:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=openadk.org header.s=2022 header.b=OpzvhuMV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39138-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39138-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46D793017275
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 10:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE16C43A7E2;
	Wed, 15 Jul 2026 10:16:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06BD2DCC1C;
	Wed, 15 Jul 2026 10:16:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110601; cv=none; b=htOsu/5ZGdlXoQpuTSoOHFPtafwv0okHHVbQWIlTOLfG0m6WO3ctDQhtTyDTRGXDEpOmlMvWVxE/ZbINUr3Eg/p4QHKBVaqC9L+fTTisYma8DMn631FfDqFLliGCzJNQqSSsH9oqya7yk1htyuKZYGJ5S8pV56Vm4tb6odwWDk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110601; c=relaxed/simple;
	bh=JHm/HXjNh9XCDVCX+IzB3eAkiJe1CF9F0aP7Gv7Ymyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqtIwjexGt0jNTG84ZUlyt9U9EFpZIcK4ZllyvSQlnxWpePQeyJ7HDF2sfl4VtOijE3TRDE/ttxqWrHgsUALPLOvem7XjqP0X5bIKYJBwz7vDxvT77EBDTDr+Ux4FQHd6aPvJ+F9ivgjrvEe/9kt6RSi711FRjfc/S1zT3hKaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org; spf=pass smtp.mailfrom=openadk.org; dkim=fail (0-bit key) header.d=openadk.org header.i=@openadk.org header.b=OpzvhuMV reason="key not found in DNS"; arc=none smtp.client-ip=89.238.66.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1784110596; bh=JHm/HXjNh9XCDVCX+IzB3eAkiJe1CF9F0aP7Gv7Ymyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpzvhuMVfmUpZZc7WUsqNlXO4Iqa1VFLxtlPEoavULUmuzdzYlMU8prdWucDX/pmJ
	 C3BN2DCHQjJhx44iSm1GftEAJe7aoJKHZomZvmcF3yXj5NQ095sbRpB+r9dens9DsT
	 NthJH2M9pWByPTag3aDmWM3Ys8kt+In3GpJQ83A6BYhy6RQGEjRYcBYz9YOYDugvxv
	 ssrjXL/b4yrqrtr83zocp2zuCmk1qwhJX3BH1RUBHspsYIeigphSLx/lxoTCkRZ0Zk
	 tlavsohOBXdNmv9XS7Mo/4bbdt2e+/k4q4F3L6jFrpUu6PZX3awIFX0dhRwT5FWjmM
	 z7h4cxGbNNXOw==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id AB4F431E0205; Wed, 15 Jul 2026 12:16:35 +0200 (CEST)
Date: Wed, 15 Jul 2026 12:16:34 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael =?utf-8?B?QsO8c2No?= <m@bues.ch>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Waldemar Brodkorb <wbx@openadk.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/3] MIPS: BCM47XX: convert buttons to software nodes
Message-ID: <aldeAg3BtnqfVgRZ@waldemar-brodkorb.de>
Mail-Followup-To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael =?utf-8?B?QsO8c2No?= <m@bues.ch>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Waldemar Brodkorb <wbx@openadk.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260713-b4-bcm47xx-swnode-v2-0-2b879f0c193c@gmail.com>
 <4a8d64e1-5f8c-4ac0-afb0-2d68c3f53ada@app.fastmail.com>
 <ala9C6XMB3-ywpph@waldemar-brodkorb.de>
 <alci_45CzdVznaN2@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VTGnAz6Ij+xdSpvL"
Content-Disposition: inline
In-Reply-To: <alci_45CzdVznaN2@google.com>
X-Operating-System: Linux 6.12.90+deb13.1-amd64 x86_64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[openadk.org];
	FORGED_RECIPIENTS(0.00)[m:dmitry.torokhov@gmail.com,m:arnd@arndb.de,m:zajec5@gmail.com,m:m@bues.ch,m:hauke@hauke-m.de,m:tsbogend@alpha.franken.de,m:wbx@openadk.org,m:brgl@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39138-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[wbx@openadk.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	R_DKIM_PERMFAIL(0.00)[openadk.org:s=2022];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,bues.ch,hauke-m.de,alpha.franken.de,openadk.org,kernel.org,vger.kernel.org,oss.qualcomm.com];
	DKIM_TRACE(0.00)[openadk.org:~];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wbx@openadk.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[waldemar-brodkorb.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,openadk.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E76375CE75


--VTGnAz6Ij+xdSpvL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

H Dmitry,
Dmitry Torokhov wrote,

> Hi Waldemar,
> 
> On Wed, Jul 15, 2026 at 12:49:47AM +0200, Waldemar Brodkorb wrote:
> > Hi,
> > Arnd Bergmann wrote,
> > 
> > > On Mon, Jul 13, 2026, at 23:58, Dmitry Torokhov wrote:
> > > > This series converts the legacy gpio-keys platform device on BCM47XX
> > > > boards to use software nodes and static properties.
> > > >
> > > > To do this properly without relying on legacy name-based matching
> > > > (which is being removed from gpiolib), we introduce and register
> > > > software nodes for the underlying GPIO controllers (BCMA and SSB)
> > > > and reference them in the button properties.
> > > >
> > > > The first two patches add the software nodes to bcma-gpio and
> > > > ssb-gpio respectively. The third patch performs the conversion
> > > > for the BCM47XX buttons.
> > > >
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > > As Johannes mentioned on v1 this best should go through MIPS tree.
> > > 
> > > Adding Waldemar to Cc. He has recently done some work to
> > > get this platform working again in FreeWRT and should
> > > be able to test your patches on hardware.
> > 
> > I normally use LTS kernel on the hardware (Linksys WRT54GS v1.0).
> > But for testing I updated to 7.1.3. Attached is the dmesg without
> > Dmitry's patches.  Button works, I can go into failsafe mode after
> > pressing the reset button on bootup.
> > 
> > With Dmitry's three patches applied I directly getting into failsafe
> > mode without pressing any button. Dmesg looks similar, but I get
> > following kernel message:
> > platform gpio-keys.0: deferred probe pending: gpio-keys: failed to get gpio
> > 
> > Looking at /dev I see no /dev/input/event0 device node anymore.
> > 
> > Attached is the small failsafe script I use on bootup.
> > Hope this helps.
> > 
> > Do I need to change my failsafe script for the new stuff or is
> > something else broken now? Do I miss some new kernel config option?
> > Or is the patch only for latest Linus git repo.
> 
> Thank you very much for testing. I think 7.1 should work. Could you
> please apply the test patch below and send me new dmesg? Hopefully I'll
> be able to figure out where I messed up.
> 
> Thanks.

Attached. Should we shorten the CC List next time?

best regards
 Waldemar

--VTGnAz6Ij+xdSpvL
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="dmesg-debug.txt"

Linux version 7.1.3 (wbx@macbook) (mipsel-freewrt-linux-uclibc-gcc (GCC) 16.1.0, GNU ld (GNU Binutils) 2.46.1) #1 Wed Jul 15 11:24:45 CEST 2026
printk: legacy bootconsole [early0] enabled
CPU0 revision is: 00029007 (Broadcom BMIPS3300)
bcm47xx: Using ssb bus
ssb: Found chip with id 0x4712, rev 0x01 and package 0x00
can not parse nvram name (null)ag0(null) with value 255 got -34
ssb: Sonics Silicon Backplane found at address 0x18000000
Primary instruction cache 8kB, VIPT, 2-way, linesize 16 bytes.
Primary data cache 4kB, 2-way, VIPT, no aliases, linesize 16 bytes
Zone ranges:
  Normal   [mem 0x0000000000000000-0x0000000001ffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000001ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000001ffffff]
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Kernel command line: root=/dev/mtdblock4 rootfstype=squashfs init=/etc/preinit noinitrd console=ttyS0,115200
Unknown kernel command line parameters "noinitrd", will be passed to user space.
printk: log buffer data + meta data: 131072 + 409600 = 540672 bytes
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
Built 1 zonelists, mobility grouping on.  Total pages: 8192
mem auto-init: stack:all(zero), heap alloc:off, heap free:off
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS: 256
MIPS: machine is Linksys WRT54G/GS/GL
clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
sched_clock: 32 bits at 100MHz, resolution 10ns, wraps every 21474836475ns
Console: colour dummy device 80x25
Calibrating delay loop... 198.65 BogoMIPS (lpj=397312)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
VFS: Finished mounting rootfs on nullfs
Memory: 25676K/32768K available (4009K kernel code, 556K rwdata, 956K rodata, 228K init, 268K bss, 6348K reserved, 0K cma-reserved)
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
posixtimers hash table entries: 512 (order: 0, 2048 bytes, linear)
futex hash table entries: 256 (4096 bytes on 1 NUMA nodes, total 4 KiB, linear).
NET: Registered PF_NETLINK/PF_ROUTE protocol family
clocksource: Switched to clocksource MIPS
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0x40000000-0x7fffffff]
pci_bus 0000:00: root bus resource [io  0x0100-0x07ff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci 0000:00:00.0: PCI: Fixing up bridge 0000:00:00.0
pci 0000:00:00.0: PCI: Fixing up device 0000:00:00.0
pci 0000:00:00.0: PCI: Fixing latency timer of device 0000:00:00.0 to 168
pci 0000:00:00.0: ssb_pcicore_fixup_pcibridge+0x0/0xf8 took 17901 usecs
pci 0000:00:00.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:01.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:01.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:02.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:02.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:03.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:03.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:03.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:04.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:04.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:04.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:05.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:05.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:05.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:06.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:06.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:06.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:07.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:07.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:07.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:08.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:08.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:08.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:09.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:09.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:09.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:0a.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:0a.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:0a.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:0b.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:0b.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:0b.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:0c.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:0c.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:0c.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:0d.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:0d.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:0d.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:0e.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:0e.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:0e.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci 0000:00:0f.0: [14e4:4712] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:0f.0: BAR 0 [mem 0x00000000-0x00001fff]
pci 0000:00:0f.0: BAR 1 [mem 0x00000000-0x07ffffff pref]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
ssb: XXX: ssb_gpio_init called, bustype=0
ssb: XXX: software_node_register(&ssb_gpio_swnode) returned 0
ssb: XXX: chipcommon chip->fwnode set to (ptrval)
gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
NET: Registered PF_INET protocol family
IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 1024 (order: 0, 4096 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 1024 (order: 0, 4096 bytes, linear)
TCP bind hash table entries: 1024 (order: 1, 8192 bytes, linear)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
PCI: CLS 0 bytes, default 16
bcm47xx: XXX: bcm47xx_buttons_add called, bus_type=0, gpio_swnode=(ptrval) (&ssb_gpio_swnode=(ptrval))
Initialise system trusted keyrings
workingset: timestamp_bits=30 (anon: 26) max_order=13 bucket_order=0 (anon: 0)
squashfs: version 4.0 (2009/01/31) Phillip Lougher
Key type asymmetric registered
Asymmetric key parser 'x509' registered
io scheduler mq-deadline registered
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
printk: legacy console [ttyS0] disabled
serial8250.0: ttyS0 at MMIO 0xb8000300 (irq = 3, base_baud = 3125000) is a 16550A
printk: legacy console [ttyS0] enabled
printk: legacy bootconsole [early0] disabled
serial8250.0: ttyS1 at MMIO 0xb8000400 (irq = 3, base_baud = 3125000) is a 16550A
physmap-flash physmap-flash.0: physmap platform flash device: [mem 0x1c000000-0x1e000000]
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x000089 Chip ID 0x000017
physmap-flash.0: Found an alias at 0x800000 for the chip at 0x0
physmap-flash.0: Found an alias at 0x1000000 for the chip at 0x0
physmap-flash.0: Found an alias at 0x1800000 for the chip at 0x0
Intel/Sharp Extended Query Table at 0x0031
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=0x0,size=0x20000,blocks=64
4 bcm47xxpart partitions found on MTD device physmap-flash.0
Creating 4 MTD partitions on "physmap-flash.0":
0x000000000000-0x000000040000 : "boot"
0x000000040000-0x0000007c0000 : "firmware"
failed to parse "brcm,trx-magic" DT attribute, using default: -89
3 trx partitions found on MTD device firmware
Creating 3 MTD partitions on "firmware":
0x00000000001c-0x000000000938 : "loader"
mtd: partition "loader" doesn't start on an erase/write block boundary -- force read-only
0x000000000938-0x0000001c0800 : "linux"
mtd: partition "linux" doesn't start on an erase/write block boundary -- force read-only
0x0000001c0800-0x000000780000 : "rootfs"
mtd: partition "rootfs" doesn't start on an erase/write block boundary -- force read-only
0x0000007c0000-0x0000007e0000 : "fwcf"
0x0000007e0000-0x000000800000 : "nvram"
b44 ssb0:1: could not find PHY at 30, use fixed one
Generic PHY fixed-0:00: attached PHY driver (mii_bus:phy_addr=fixed-0:00, irq=POLL)
b44 ssb0:1 eth0: Broadcom 44xx/47xx 10/100 PCI ethernet driver 00:0f:66:c8:74:47
NET: Registered PF_PACKET protocol family
8021q: 802.1Q VLAN Support v1.8
Loading compiled-in X.509 certificates
XXX: software_node_get_reference_args: refnode is NULL for swnode=(ptrval) (gpio-keys), fwnode=(ptrval)
VFS: Mounted root (squashfs filesystem) readonly on device 31:4.
devtmpfs: mounted
VFS: Pivoted into new rootfs
Freeing unused kernel image (initmem) memory: 228K
This architecture does not have kernel memory protection.
Run /etc/preinit as init process
  with arguments:
    /etc/preinit
    noinitrd
  with environment:
    HOME=/
    TERM=linux
random: crng init done
b44 ssb0:1 eth0: Link is up at 100 Mbps, half duplex
b44 ssb0:1 eth0: Flow control is off for TX and off for RX
b44 ssb0:1 eth0: Link is Up - 100Mbps/Full - flow control off
XXX: software_node_get_reference_args: refnode is NULL for swnode=8d67cb1c ((efault)), fwnode=b3963255
platform gpio-keys.0: deferred probe pending: gpio-keys: failed to get gpio

--VTGnAz6Ij+xdSpvL--

