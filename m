Return-Path: <linux-wireless+bounces-4438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC98873A14
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 16:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3B61C23B1C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA194DA1B;
	Wed,  6 Mar 2024 15:04:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97D131E4B
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737474; cv=none; b=nA09jXVnK/GEWbIxAwEHciqUQOTk7dIi1KbrR/DxwbTXwyM2T3eJZeEIhMKtK8MvR8ZYavvgPVmeQXWb7qiXJPxXte6XrQyktxDj2SHQCXNR6Zo923ZRT/tWGyr/A49k5ilE1LUNbenFndsz079bzn+WAK+MMyv1yADOUBAh2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737474; c=relaxed/simple;
	bh=yrW4jzZPo5yDUGGlsssCweVf3KtmxhRvCDCcvHr6gLI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cQG+DKBRWT1Twk/cawNd/k/zUdi4roAa19pdUgTgxb7vaqKWLY63zn9gTx/0brA2+IUQaL8qKGHcGx/OMDbPALkFiCINoBvvvjPj7ahX7OdP+eyDr6b4OdbdNerdd0SqKihNIWTheJNGbziUUmOeEFCLbKYOyi5J/M+aWYLWvy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jkbsc.co.uk; spf=pass smtp.mailfrom=jkbsc.co.uk; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jkbsc.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jkbsc.co.uk
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D20A2000B
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 15:04:28 +0000 (UTC)
Date: Wed, 6 Mar 2024 15:04:27 +0000
From: John Beattie <jkb@jkbsc.co.uk>
To: linux-wireless@vger.kernel.org
Subject: intel ax201 microcode error
Message-ID: <20240306150427.GA250467@fladday.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: jkb@jkbsc.co.uk

Hi,

I have an issue with my wifi related to microcode and possibly the iwlwifi
driver. Apologies if this is the wrong forum, if there is a better alternative
please let me know.


I have a NUC10I7FNH3 running mint 20.1, inxi output below.

My wifi connection gets reset from time to time triggered by a microcode error,
dmesg extract below.  I wanted to check that the right microcode was being
loaded at boot, so I checked lspci & dmesg which give me conflicting
information.  First that the device is recognised by lspci as a Wireless-AC 9462
(Wi-Fi 5) but also that iwlwifi detects the device as Wi-Fi 6 AX201 and loads
firmware which I think is associated with the AX201. Specifically, firmware
version 50.3e391d3e.0, see notes at the bottom.

lspci reports it as Wireless-AC 9462. I used setpci to read the PCI ID registers
and got the same answer: 8086:02f0, which corresponds to Wireless-AC 9462.  As
stated above, the machine has an AX201 module installed, which might be
8086:06f0, but there is no PCI device with that ID present.

Hence first question: does this matter, given that the iwlwifi driver appears to
load correct microcode?  Or, is any other part of the system going to make wrong
decisions given that the device is wrongly reported everywhere else.

Web searches show me that this mixup has been seen before. But I haven't found a
page which addresses the mix-up directly, just pages which talk about upgrading
the kernel or downgrading the driver or other fixes, all aiming to get wifi
working.

If it does matter that the PCI ID is wrong, how do I fix it?

But the main question is, does anyone have any advice for how to address my
problem where the wifi resets due to a microcode fault?

Many thanks for reading this.

John Beattie



- - - - - -
$ inxi -Fx
System:    Host: fladday Kernel: 5.4.0-170-generic x86_64 bits: 64 compiler: gcc v: 9.4.0 Desktop: MATE 1.24.0 
           Distro: Linux Mint 20.1 Ulyssa base: Ubuntu 20.04 focal 
Machine:   Type: Mini-pc System: Intel Client Systems product: NUC10i7FNH v: K61081-306 serial: <superuser/root required> 
           Mobo: Intel model: NUC10i7FNB v: K61360-305 serial: <superuser/root required> UEFI: Intel 
           v: FNCML357.0046.2020.0928.1457 date: 09/28/2020 
CPU:       Topology: 6-Core model: Intel Core i7-10710U bits: 64 type: MT MCP arch: N/A L2 cache: 12.0 MiB 
           flags: avx avx2 lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx bogomips: 38399 
           Speed: 2021 MHz min/max: 400/4700 MHz Core speeds (MHz): 1: 700 2: 705 3: 739 4: 705 5: 700 6: 700 7: 700 8: 700 
           9: 700 10: 701 11: 700 12: 700 
Graphics:  Device-1: Intel driver: i915 v: kernel bus ID: 00:02.0 
           Display: x11 server: X.Org 1.20.13 driver: modesetting unloaded: fbdev,vesa resolution: 1920x1080~75Hz 
           OpenGL: renderer: Mesa Intel UHD Graphics (CML GT2) v: 4.6 Mesa 21.2.6 direct render: Yes 
Audio:     Device-1: Intel driver: snd_hda_intel v: kernel bus ID: 00:1f.3 
           Sound Server: ALSA v: k5.4.0-170-generic 
Network:   Device-1: Intel Wireless-AC 9462 driver: iwlwifi v: kernel port: 3000 bus ID: 00:14.3 
           IF: wlp0s20f3 state: up mac: b0:a4:60:16:4a:4a 
           Device-2: Intel Ethernet I219-V driver: e1000e v: 3.2.6-k port: efa0 bus ID: 00:1f.6 
           IF: eno1 state: down mac: 1c:69:7a:a1:c4:ed 
Drives:    Local Storage: total: 1.14 TiB used: 1007.63 GiB (86.1%) 
           ID-1: /dev/nvme0n1 model: 256GB PCS PCIe M.2 SSD size: 238.47 GiB 
           ID-2: /dev/sda vendor: Seagate model: ST1000LM048-2E7172 size: 931.51 GiB 
Partition: ID-1: / size: 231.49 GiB used: 131.08 GiB (56.6%) fs: ext4 dev: /dev/dm-1 
           ID-2: /boot size: 703.1 MiB used: 218.9 MiB (31.1%) fs: ext4 dev: /dev/nvme0n1p2 
           ID-3: swap-1 size: 976.0 MiB used: 66.0 MiB (6.8%) fs: swap dev: /dev/dm-2 
Sensors:   System Temperatures: cpu: 54.0 C mobo: 49.0 C 
           Fan Speeds (RPM): N/A 
Info:      Processes: 631 Uptime: 2d 5h 27m Memory: 31.07 GiB used: 11.94 GiB (38.4%) Init: systemd runlevel: 5 Compilers: 
           gcc: 9.4.0 Shell: bash v: 5.0.17 inxi: 3.0.38 


$ dmesg | grep iwlwifi  ## boot up, also microcode error

[  558.190932] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[  558.198922] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 58.3.35.22
[  558.198925] iwlwifi 0000:00:14.3: Found debug destination: EXTERNAL_DRAM
[  558.198926] iwlwifi 0000:00:14.3: Found debug configuration: 0
[  558.199149] iwlwifi 0000:00:14.3: loaded firmware version 50.3e391d3e.0 op_mode iwlmvm
[  558.232626] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz, REV=0x354
[  558.240075] iwlwifi 0000:00:14.3: Applying debug destination EXTERNAL_DRAM
[  558.240408] iwlwifi 0000:00:14.3: Allocated 0x00400000 bytes for firmware monitor.
[  558.385652] iwlwifi 0000:00:14.3: base HW address: b0:a4:60:16:4a:4a
[  558.399945] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[  559.486208] iwlwifi 0000:00:14.3: Applying debug destination EXTERNAL_DRAM
[  559.630840] iwlwifi 0000:00:14.3: FW already configured (0) - re-configuring
[  559.635571] iwlwifi 0000:00:14.3: BIOS contains WGDS but no WRDS

[85884.104825] iwlwifi 0000:00:14.3: Microcode SW error detected. Restarting 0x0.
[85884.104921] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[85884.104926] iwlwifi 0000:00:14.3: Status: 0x00000040, count: 6
[85884.104931] iwlwifi 0000:00:14.3: Loaded firmware version: 50.3e391d3e.0
[85884.104937] iwlwifi 0000:00:14.3: 0x00004433 | ADVANCED_SYSASSERT          
[85884.104941] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[85884.104944] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[85884.104948] iwlwifi 0000:00:14.3: 0x004C9534 | branchlink2
[85884.104952] iwlwifi 0000:00:14.3: 0x00000E56 | interruptlink1
[85884.104956] iwlwifi 0000:00:14.3: 0x00000E56 | interruptlink2
[85884.104959] iwlwifi 0000:00:14.3: 0x0003070E | data1
[85884.104963] iwlwifi 0000:00:14.3: 0x00000001 | data2
[85884.104967] iwlwifi 0000:00:14.3: 0x00000001 | data3
[85884.104970] iwlwifi 0000:00:14.3: 0x75012D45 | beacon time
[85884.104974] iwlwifi 0000:00:14.3: 0xC80B22BD | tsf low
[85884.104978] iwlwifi 0000:00:14.3: 0x0000001C | tsf hi
[85884.104982] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[85884.104985] iwlwifi 0000:00:14.3: 0xDDBCBBD1 | time gp2
[85884.104989] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[85884.104993] iwlwifi 0000:00:14.3: 0x00000032 | uCode version major
[85884.104996] iwlwifi 0000:00:14.3: 0x3E391D3E | uCode version minor
[85884.105000] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[85884.105004] iwlwifi 0000:00:14.3: 0x00C89004 | board version
[85884.105007] iwlwifi 0000:00:14.3: 0x809AFC0F | hcmd
[85884.105011] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[85884.105015] iwlwifi 0000:00:14.3: 0x00400000 | isr1
[85884.105019] iwlwifi 0000:00:14.3: 0x08E00002 | isr2
[85884.105022] iwlwifi 0000:00:14.3: 0x04C36F8C | isr3
[85884.105026] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[85884.105029] iwlwifi 0000:00:14.3: 0x0057019C | last cmd Id
[85884.105033] iwlwifi 0000:00:14.3: 0x00016854 | wait_event
[85884.105037] iwlwifi 0000:00:14.3: 0x000000D4 | l2p_control
[85884.105040] iwlwifi 0000:00:14.3: 0x00000020 | l2p_duration
[85884.105044] iwlwifi 0000:00:14.3: 0x00000007 | l2p_mhvalid
[85884.105048] iwlwifi 0000:00:14.3: 0x00000081 | l2p_addr_match
[85884.105052] iwlwifi 0000:00:14.3: 0x00000009 | lmpm_pmg_sel
[85884.105055] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[85884.105059] iwlwifi 0000:00:14.3: 0x000078AC | flow_handler
[85884.105101] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[85884.105105] iwlwifi 0000:00:14.3: Status: 0x00000040, count: 7
[85884.105109] iwlwifi 0000:00:14.3: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[85884.105113] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[85884.105117] iwlwifi 0000:00:14.3: 0x80465E6A | umac branchlink2
[85884.105120] iwlwifi 0000:00:14.3: 0xC0086BD4 | umac interruptlink1
[85884.105124] iwlwifi 0000:00:14.3: 0x804834A4 | umac interruptlink2
[85884.105127] iwlwifi 0000:00:14.3: 0x00000400 | umac data1
[85884.105131] iwlwifi 0000:00:14.3: 0x804834A4 | umac data2
[85884.105135] iwlwifi 0000:00:14.3: 0x00000000 | umac data3
[85884.105138] iwlwifi 0000:00:14.3: 0x00000032 | umac major
[85884.105142] iwlwifi 0000:00:14.3: 0x3E391D3E | umac minor
[85884.105145] iwlwifi 0000:00:14.3: 0xDDBCBBE2 | frame pointer
[85884.105149] iwlwifi 0000:00:14.3: 0xC0885F40 | stack pointer
[85884.105153] iwlwifi 0000:00:14.3: 0x00590400 | last host cmd
[85884.105157] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[85884.105175] iwlwifi 0000:00:14.3: Fseq Registers:
[85884.105193] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[85884.105214] iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
[85884.105234] iwlwifi 0000:00:14.3: 0x00070043 | FSEQ_CNVIO_INIT_VERSION
[85884.105254] iwlwifi 0000:00:14.3: 0x0000A481 | FSEQ_OTP_VERSION
[85884.105273] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[85884.105292] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[85884.105312] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[85884.105331] iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
[85884.105351] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[85884.105374] iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
[85884.105395] iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[85884.105415] iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[85884.105616] iwlwifi 0000:00:14.3: Collecting data: trigger 2 fired.



$ lspci | grep Network
00:14.3 Network controller: Intel Corporation Wireless-AC 9462

# setpci -d 8086:02f0 0.L
02f08086

# setpci -d 8086:06f0 0.L
setpci: Warning: No devices selected for "0.l".

# lshw:
*-network:0
             description: Wireless interface
             product: Wireless-AC 9462
             vendor: Intel Corporation
             physical id: 14.3
             bus info: pci@0000:00:14.3
             logical name: wlp0s20f3
             version: 00
             serial: b0:a4:60:16:4a:4a
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress msix bus_master cap_list ethernet physical wireless
             configuration: broadcast=yes driver=iwlwifi driverversion=5.4.0-170-generic firmware=50.3e391d3e.0 ip=192.168.0.16 latency=0 link=yes multicast=yes wireless=IEEE 802.11

# rfkill list
0: hci0: Bluetooth
	Soft blocked: yes
	Hard blocked: no
1: phy0: Wireless LAN
	Soft blocked: no
	Hard blocked: no



Firmware version & microcode filename.  From
https://packages.debian.org/bullseye/firmware-iwlwifi I find this mapping,
starting with the firmware version which is mentioned in my dmesg:

   50.3e391d3e.0 (iwlwifi-Qu-b0-hr-b0-50.ucode)

From Intel
(https://www.intel.com/content/www/us/en/support/articles/000005511/wireless.html)
I get this:

Intel Wi-Fi 6 AX201 160MHz	5.2+	iwlwifi-Qu-48.13675109.0.tgz

This tgz, downloaded from the Intel web page, includes
iwlwifi-Qu-b0-hr-b0-48.ucode which might be an earlier version of the file
listed on the debian page, i.e. -48 instead of -50.

So the line in the dmesg which reports that firmware version 50.3e391d3e.0 was
loaded is close but doesn't exactly conform to the information on the intel
webpage.  However, I think it is for AX201, not for 9462, so it is right in that
sense.

