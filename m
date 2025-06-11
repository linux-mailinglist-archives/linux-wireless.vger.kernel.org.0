Return-Path: <linux-wireless+bounces-23991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E14DAD58D8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2693A3352
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484792690EC;
	Wed, 11 Jun 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PTHqWP8O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26527D782
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652518; cv=none; b=Q1V8wtgBXRmiUKlfPFJ9qHnkCsmiuSdiIDouVtmuOvY/5Lh8pLJVs6D6GPuSgqjIkS6GLeBeB6DrQ7EwxqvUNFhC1JcWkXp5Vg6aVoryvNQhfgbWQRi8prECnRqeOWRmLtmY5cQfL6MCQaEMNsdRi++d/OygKdCAoCjSS3qkugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652518; c=relaxed/simple;
	bh=XGGJAPqSxk8PqyCIfVDuW3QxHQ6LpeOzjnN8wKKkQ/M=;
	h=To:From:Subject:Message-Id:Date; b=p0E1lapzyUdPUCNo3T9h8JKIPdUBYtu+CwKSmFhEn6ZIOWa60j5Y5EiTCTBAaouRnrzqgMl3O3OuGu6eWRcPZ6VMu9Bp5Dy4ulZTX7a7MG9mCIgarHSB7Beq2axJlEyd65PS/TWh73Ok12mMRCnNPEPgBaOqoyp/5MI8s8fklk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PTHqWP8O; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=To:From:Subject:Message-Id:Date; bh=+s0IX4ORKPoQm0Y
	MMP5/Khmr5rMp4qfFzYbS6u6zTlo=; b=PTHqWP8O79qCn8jXpyYjd+tkiw2mrND
	6NSjMQcS9JRpyLWevf1WZ3Iv09KSFmcNmajEWzDFSFgn/u8vGhHvMFr22OmrtwJ4
	1a9TXOjMdyXPh0S1w4dlYryzzdsaEqFCaz0dJd4tDjVTvc+p7z2DB4eb4pNI5bba
	AZY7UkRhx0mw=
Received: from MBP (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3QO4YlEloIZgXHg--.63598S3;
	Wed, 11 Jun 2025 22:35:05 +0800 (CST)
To: linux-wireless@vger.kernel.org
From: lonthn@163.com
Subject: [rtw89] PCI Passthrough Issue: rtl8852be on ARM VM (Ubuntu host/OpenWrt guest)
X-CM-TRANSID:_____wC3QO4YlEloIZgXHg--.63598S3
Message-Id:<68499419.220006.00001@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvAXoWDJr4UWr4DAFyrurWkWrWDXFb_yoWrCr4xCo
	Z7AayDArW8Gry5Aay8Xa17urW8Jayrta4xXF17Zw1UA3Z7Ar4UGF13tw1fZ39IqF1Utr1U
	Awn7Kr4DGw18CFn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RKeHyUUUUU
Date: Wed, 11 Jun 2025 22:35:06 +0800 (CST)
X-CM-SenderInfo: horq3xrq6rljoofrz/1tbiXA5pB2hJjqJdNgAAsa
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Hi rtw89 maintainers,
I'm having trouble passing through an rtl8852be PCIe device to an ARM KVM guest and hope you could help. Key details:

==== Environment ====
* Host: Ubuntu 5.10.160 (ARM)
* Guest: Openwrt 6.6.73
* Working case: Identical setup works for rtl8125 passthrough

==== Issue ====
Guest fails to initialize rtl8852be with timeout errors.

==== Diagnostic snippets ====
* Host lspci output:
0000:00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3588 (rev 01)
0000:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
0002:20:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3588 (rev 01)
0002:21:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b852
0004:40:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3588 (rev 01)
0004:41:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
* Guest lspci output:
00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
00:01.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
00:01.1 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
00:01.2 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
00:01.3 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
00:01.4 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
00:01.5 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
00:01.6 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
00:01.7 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
01:00.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 01)
02:00.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 01)
03:00.0 USB controller: Red Hat, Inc. QEMU XHCI Host Controller (rev 01)
04:00.0 Communication controller: Red Hat, Inc. Virtio 1.0 console (rev 01)
05:00.0 SCSI storage controller: Red Hat, Inc. Virtio 1.0 block device (rev 01)
06:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
07:00.0 Unclassified device [0002]: Red Hat, Inc. Virtio 1.0 filesystem (rev 01)
08:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
* Guest dmesg output:
root@OpenWrt:~# dmesg
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x414fd0b0]
[    0.000000] Linux version 6.6.73 (builder@buildhost) (aarch64-openwrt-linux-musl-gcc (OpenWrt GCC 13.3.0 r28427-6df0e3d02a) 13.3.0, GNU ld (GNU Binutils) 2.42) #0 SMP Mon Feb  3 23:09:37 2025
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: SMBIOS 3.0=0x7bef0000 MEMATTR=0x7a32c018 ACPI 2.0=0x78450000 MEMRESERVE=0x78439e98
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000078450000 000024 (v02 BOCHS )
[    0.000000] ACPI: XSDT 0x0000000078440000 000054 (v01 BOCHS  BXPCFACP 00000001      01000013)
[    0.000000] ACPI: FACP 0x0000000078400000 00010C (v05 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x0000000078410000 004842 (v02 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: APIC 0x00000000783F0000 000100 (v03 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.000000] ACPI: GTDT 0x00000000783E0000 000060 (v02 BOCHS  BXPCGTDT 00000001 BXPC 00000001)
[    0.000000] ACPI: MCFG 0x00000000783D0000 00003C (v01 BOCHS  BXPCMCFG 00000001 BXPC 00000001)
[    0.000000] ACPI: SPCR 0x00000000783C0000 000050 (v02 BOCHS  BXPCSPCR 00000001 BXPC 00000001)
[    0.000000] ACPI: IORT 0x00000000783B0000 00007C (v00 BOCHS  BXPCIORT 00000001 BXPC 00000001)
[    0.000000] ACPI: SPCR: console: pl011,mmio,0x9000000,9600
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '9600')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 0x0000000040000000-0x000000007fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x7fdf8380-0x7fdfafff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x000000007fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x000000007845ffff]
[    0.000000]   node   0: [mem 0x0000000078460000-0x000000007874ffff]
[    0.000000]   node   0: [mem 0x0000000078750000-0x000000007bc1ffff]
[    0.000000]   node   0: [mem 0x000000007bc20000-0x000000007bffffff]
[    0.000000]   node   0: [mem 0x000000007c000000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000007fffffff]
[    0.000000] cma: Reserved 32 MiB at 0x000000007cc00000 on node -1
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 20 pages/cpu s42664 r8192 d31064 u81920
[    0.000000] pcpu-alloc: s42664 r8192 d31064 u81920 alloc=20*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Hardware dirty bit management
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: Spectre-BHB
[    0.000000] CPU features: detected: SSBS not fully self-synchronizing
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: BOOT_IMAGE=/efi/openwrt/vmlinux root=PARTUUID=f1ca51dc-2a14-ee69-dc42-f06e03b77b02 rootwait earlycon console=tty1 noinitrd
[    0.000000] Unknown kernel command line parameters "BOOT_IMAGE=/efi/openwrt/vmlinux", will be passed to user space.
[    0.000000] random: crng init done
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 258048
[    0.000000] Policy zone: DMA
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: SWIOTLB bounce buffer size adjusted to 1MB
[    0.000000] software IO TLB: area num 2.
[    0.000000] software IO TLB: mapped [mem 0x000000007cb00000-0x000000007cc00000] (1MB)
[    0.000000] Memory: 966508K/1048576K available (11648K kernel code, 1546K rwdata, 3024K rodata, 3584K init, 473K bss, 49300K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=2.
[    0.000000] Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: 0xffff800080010150
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000080a0000
[    0.000000] ITS [mem 0x08080000-0x0809ffff]
[    0.000000] ITS@0x0000000008080000: allocated 8192 Devices @40050000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x0000000008080000: allocated 8192 Interrupt Collections @40060000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] GICv3: using LPI property table @0x0000000040070000
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000040080000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000000] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000953] Console: colour dummy device 80x25
[    0.001438] printk: console [tty1] enabled
[    0.001890] printk: bootconsole [pl11] disabled
[    0.002437] ACPI: Core revision 20230628
[    0.002517] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.002524] pid_max: default: 32768 minimum: 301
[    0.002652] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.002673] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.003392] ACPI PPTT: No PPTT table found, CPU and cache topology may be inaccurate
[    0.003407] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.003614] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=2.
[    0.003705] rcu: Hierarchical SRCU implementation.
[    0.003707] rcu: Max phase no-delay instances is 1000.
[    0.003808] Platform MSI: ITS@0x8080000 domain created
[    0.003819] PCI/MSI: ITS@0x8080000 domain created
[    0.003830] fsl-mc MSI: ITS@0x8080000 domain created
[    0.003852] Remapping and enabling EFI services.
[    0.004107] smp: Bringing up secondary CPUs ...
[    0.016124] CPU features: detected: Qualcomm erratum 1009, or ARM erratum 1286807, 2441009
[    0.016138] CPU features: detected: ARM errata 1165522, 1319367, or 1530923
[    0.016182] Detected VIPT I-cache on CPU1
[    0.016244] GICv3: CPU1: found redistributor 1 region 0:0x00000000080c0000
[    0.016336] GICv3: CPU1: using allocated LPI pending table @0x0000000040090000
[    0.016427] CPU1: Booted secondary processor 0x0000000001 [0x412fd050]
[    0.016741] smp: Brought up 1 node, 2 CPUs
[    0.016764] SMP: Total of 2 processors activated.
[    0.016768] CPU features: detected: 32-bit EL0 Support
[    0.016773] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.016776] CPU features: detected: Common not Private translations
[    0.016779] CPU features: detected: CRC32 instructions
[    0.016783] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.016789] CPU features: detected: Privileged Access Never
[    0.016792] CPU features: detected: RAS Extension Support
[    0.016797] CPU features: detected: Speculative Store Bypassing Safe (SSBS)
[    0.016926] CPU: All CPU(s) started at EL1
[    0.016935] alternatives: applying system-wide alternatives
[    0.019021] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.019034] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.019249] pinctrl core: initialized pinctrl subsystem
[    0.019529] SMBIOS 3.0.0 present.
[    0.019535] DMI: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[    0.019833] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.020359] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
[    0.020387] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.020415] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.020624] thermal_sys: Registered thermal governor 'step_wise'
[    0.020637] cpuidle: using governor ladder
[    0.020643] cpuidle: using governor menu
[    0.020696] ASID allocator initialised with 65536 entries
[    0.020749] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.020802] Serial: AMBA PL011 UART driver
[    0.020943] Modules: 27648 pages in range for non-PLT usage
[    0.020944] Modules: 519168 pages in range for PLT usage
[    0.021547] cryptd: max_cpu_qlen set to 1000
[    0.021840] ACPI: Added _OSI(Module Device)
[    0.021843] ACPI: Added _OSI(Processor Device)
[    0.021846] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.021847] ACPI: Added _OSI(Processor Aggregator Device)
[    0.027568] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.027972] ACPI: Interpreter enabled
[    0.027976] ACPI: Using GIC for interrupt routing
[    0.027992] ACPI: MCFG table detected, 1 entries
[    0.029900] ARMH0011:00: ttyAMA0 at MMIO 0x9000000 (irq = 12, base_baud = 0) is a SBSA
[    0.029927] printk: console [ttyAMA0] enabled
[    0.103947] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.104481] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.105263] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    0.105804] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability]
[    0.106524] acpi PNP0A08:00: ECAM area [mem 0x4010000000-0x401fffffff] reserved by PNP0C02:00
[    0.107210] acpi PNP0A08:00: ECAM at [mem 0x4010000000-0x401fffffff] for [bus 00-ff]
[    0.107865] ACPI: Remapped I/O 0x000000003eff0000 to [io  0x0000-0xffff window]
[    0.108569] PCI host bridge to bus 0000:00
[    0.108892] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff window]
[    0.109479] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
[    0.110016] pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff window]
[    0.110621] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.111092] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
[    0.111837] pci 0000:00:01.0: [1b36:000c] type 01 class 0x060400
[    0.114063] pci 0000:00:01.0: reg 0x10: [mem 0x10786000-0x10786fff]
[    0.117592] pci 0000:00:01.1: [1b36:000c] type 01 class 0x060400
[    0.119604] pci 0000:00:01.1: reg 0x10: [mem 0x10785000-0x10785fff]
[    0.124326] pci 0000:00:01.2: [1b36:000c] type 01 class 0x060400
[    0.125955] pci 0000:00:01.2: reg 0x10: [mem 0x10784000-0x10784fff]
[    0.128737] pci 0000:00:01.3: [1b36:000c] type 01 class 0x060400
[    0.130295] pci 0000:00:01.3: reg 0x10: [mem 0x10783000-0x10783fff]
[    0.133325] pci 0000:00:01.4: [1b36:000c] type 01 class 0x060400
[    0.136478] pci 0000:00:01.4: reg 0x10: [mem 0x10782000-0x10782fff]
[    0.139262] pci 0000:00:01.5: [1b36:000c] type 01 class 0x060400
[    0.140832] pci 0000:00:01.5: reg 0x10: [mem 0x10781000-0x10781fff]
[    0.144052] pci 0000:00:01.6: [1b36:000c] type 01 class 0x060400
[    0.145975] pci 0000:00:01.6: reg 0x10: [mem 0x10780000-0x10780fff]
[    0.150819] pci 0000:01:00.0: [1af4:1041] type 00 class 0x020000
[    0.151406] pci 0000:01:00.0: reg 0x14: [mem 0x10600000-0x10600fff]
[    0.152002] pci 0000:01:00.0: reg 0x20: [mem 0x8000000000-0x8000003fff 64bit pref]
[    0.152669] pci 0000:01:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    0.154222] pci 0000:02:00.0: [1af4:1041] type 00 class 0x020000
[    0.154809] pci 0000:02:00.0: reg 0x14: [mem 0x10500000-0x10500fff]
[    0.155394] pci 0000:02:00.0: reg 0x20: [mem 0x8000100000-0x8000103fff 64bit pref]
[    0.156046] pci 0000:02:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    0.157543] pci 0000:03:00.0: [1b36:000d] type 00 class 0x0c0330
[    0.158820] pci 0000:03:00.0: reg 0x10: [mem 0x10400000-0x10403fff 64bit]
[    0.160288] pci 0000:04:00.0: [1af4:1043] type 00 class 0x078000
[    0.160933] pci 0000:04:00.0: reg 0x14: [mem 0x10300000-0x10300fff]
[    0.161499] pci 0000:04:00.0: reg 0x20: [mem 0x8000200000-0x8000203fff 64bit pref]
[    0.163034] pci 0000:05:00.0: [1af4:1042] type 00 class 0x010000
[    0.164588] pci 0000:05:00.0: reg 0x14: [mem 0x10200000-0x10200fff]
[    0.166703] pci 0000:05:00.0: reg 0x20: [mem 0x8000300000-0x8000303fff 64bit pref]
[    0.170412] pci 0000:06:00.0: [10ec:b852] type 00 class 0x028000
[    0.171119] pci 0000:06:00.0: reg 0x10: [io  0x0000-0x00ff]
[    0.171666] pci 0000:06:00.0: reg 0x18: [mem 0x10100000-0x101fffff 64bit]
[    0.172677] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.174430] pci 0000:07:00.0: [1af4:1049] type 00 class 0x000200
[    0.175038] pci 0000:07:00.0: reg 0x14: [mem 0x10000000-0x10000fff]
[    0.175655] pci 0000:07:00.0: reg 0x20: [mem 0x8000400000-0x8000403fff 64bit pref]
[    0.179598] pci 0000:00:01.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    0.181263] pci 0000:00:01.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 01] add_size 100000 add_align 100000
[    0.182271] pci 0000:00:01.0: bridge window [mem 0x00100000-0x001fffff] to [bus 01] add_size 100000 add_align 100000
[    0.183211] pci 0000:00:01.1: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
[    0.183911] pci 0000:00:01.1: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 02] add_size 100000 add_align 100000
[    0.184904] pci 0000:00:01.1: bridge window [mem 0x00100000-0x001fffff] to [bus 02] add_size 100000 add_align 100000
[    0.185802] pci 0000:00:01.2: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[    0.186521] pci 0000:00:01.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    0.187499] pci 0000:00:01.2: bridge window [mem 0x00100000-0x001fffff] to [bus 03] add_size 100000 add_align 100000
[    0.188410] pci 0000:00:01.3: bridge window [io  0x1000-0x0fff] to [bus 04] add_size 1000
[    0.189135] pci 0000:00:01.3: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 04] add_size 100000 add_align 100000
[    0.190148] pci 0000:00:01.3: bridge window [mem 0x00100000-0x001fffff] to [bus 04] add_size 100000 add_align 100000
[    0.191094] pci 0000:00:01.4: bridge window [io  0x1000-0x0fff] to [bus 05] add_size 1000
[    0.191816] pci 0000:00:01.4: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 05] add_size 100000 add_align 100000
[    0.192818] pci 0000:00:01.4: bridge window [mem 0x00100000-0x001fffff] to [bus 05] add_size 100000 add_align 100000
[    0.193770] pci 0000:00:01.5: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 06] add_size 200000 add_align 100000
[    0.194800] pci 0000:00:01.5: bridge window [mem 0x00100000-0x001fffff] to [bus 06] add_size 100000 add_align 100000
[    0.195736] pci 0000:00:01.6: bridge window [io  0x1000-0x0fff] to [bus 07] add_size 1000
[    0.196442] pci 0000:00:01.6: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 07] add_size 100000 add_align 100000
[    0.197425] pci 0000:00:01.6: bridge window [mem 0x00100000-0x001fffff] to [bus 07] add_size 100000 add_align 100000
[    0.198361] pci 0000:00:01.0: BAR 14: assigned [mem 0x10000000-0x101fffff]
[    0.198964] pci 0000:00:01.0: BAR 15: assigned [mem 0x8000000000-0x80001fffff 64bit pref]
[    0.199664] pci 0000:00:01.1: BAR 14: assigned [mem 0x10200000-0x103fffff]
[    0.200264] pci 0000:00:01.1: BAR 15: assigned [mem 0x8000200000-0x80003fffff 64bit pref]
[    0.200978] pci 0000:00:01.2: BAR 14: assigned [mem 0x10400000-0x105fffff]
[    0.201560] pci 0000:00:01.2: BAR 15: assigned [mem 0x8000400000-0x80005fffff 64bit pref]
[    0.202267] pci 0000:00:01.3: BAR 14: assigned [mem 0x10600000-0x107fffff]
[    0.202869] pci 0000:00:01.3: BAR 15: assigned [mem 0x8000600000-0x80007fffff 64bit pref]
[    0.203583] pci 0000:00:01.4: BAR 14: assigned [mem 0x10800000-0x109fffff]
[    0.204161] pci 0000:00:01.4: BAR 15: assigned [mem 0x8000800000-0x80009fffff 64bit pref]
[    0.204854] pci 0000:00:01.5: BAR 14: assigned [mem 0x10a00000-0x10bfffff]
[    0.205451] pci 0000:00:01.5: BAR 15: assigned [mem 0x8000a00000-0x8000bfffff 64bit pref]
[    0.206167] pci 0000:00:01.6: BAR 14: assigned [mem 0x10c00000-0x10dfffff]
[    0.206751] pci 0000:00:01.6: BAR 15: assigned [mem 0x8000c00000-0x8000dfffff 64bit pref]
[    0.207421] pci 0000:00:01.0: BAR 0: assigned [mem 0x10e00000-0x10e00fff]
[    0.208455] pci 0000:00:01.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.208965] pci 0000:00:01.1: BAR 0: assigned [mem 0x10e01000-0x10e01fff]
[    0.209939] pci 0000:00:01.1: BAR 13: assigned [io  0x2000-0x2fff]
[    0.210476] pci 0000:00:01.2: BAR 0: assigned [mem 0x10e02000-0x10e02fff]
[    0.211441] pci 0000:00:01.2: BAR 13: assigned [io  0x3000-0x3fff]
[    0.211955] pci 0000:00:01.3: BAR 0: assigned [mem 0x10e03000-0x10e03fff]
[    0.212932] pci 0000:00:01.3: BAR 13: assigned [io  0x4000-0x4fff]
[    0.213455] pci 0000:00:01.4: BAR 0: assigned [mem 0x10e04000-0x10e04fff]
[    0.214449] pci 0000:00:01.4: BAR 13: assigned [io  0x5000-0x5fff]
[    0.214960] pci 0000:00:01.5: BAR 0: assigned [mem 0x10e05000-0x10e05fff]
[    0.215953] pci 0000:00:01.5: BAR 13: assigned [io  0x6000-0x6fff]
[    0.216480] pci 0000:00:01.6: BAR 0: assigned [mem 0x10e06000-0x10e06fff]
[    0.217451] pci 0000:00:01.6: BAR 13: assigned [io  0x7000-0x7fff]
[    0.218021] pci 0000:01:00.0: BAR 6: assigned [mem 0x10000000-0x1007ffff pref]
[    0.218634] pci 0000:01:00.0: BAR 4: assigned [mem 0x8000000000-0x8000003fff 64bit pref]
[    0.219378] pci 0000:01:00.0: BAR 1: assigned [mem 0x10080000-0x10080fff]
[    0.219955] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.220371] pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
[    0.221728] pci 0000:00:01.0:   bridge window [mem 0x10000000-0x101fffff]
[    0.222805] pci 0000:00:01.0:   bridge window [mem 0x8000000000-0x80001fffff 64bit pref]
[    0.224513] pci 0000:02:00.0: BAR 6: assigned [mem 0x10200000-0x1027ffff pref]
[    0.225159] pci 0000:02:00.0: BAR 4: assigned [mem 0x8000200000-0x8000203fff 64bit pref]
[    0.225864] pci 0000:02:00.0: BAR 1: assigned [mem 0x10280000-0x10280fff]
[    0.226439] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.226847] pci 0000:00:01.1:   bridge window [io  0x2000-0x2fff]
[    0.228106] pci 0000:00:01.1:   bridge window [mem 0x10200000-0x103fffff]
[    0.231733] pci 0000:00:01.1:   bridge window [mem 0x8000200000-0x80003fffff 64bit pref]
[    0.233121] pci 0000:03:00.0: BAR 0: assigned [mem 0x10400000-0x10403fff 64bit]
[    0.233778] pci 0000:00:01.2: PCI bridge to [bus 03]
[    0.234200] pci 0000:00:01.2:   bridge window [io  0x3000-0x3fff]
[    0.235261] pci 0000:00:01.2:   bridge window [mem 0x10400000-0x105fffff]
[    0.236168] pci 0000:00:01.2:   bridge window [mem 0x8000400000-0x80005fffff 64bit pref]
[    0.237518] pci 0000:04:00.0: BAR 4: assigned [mem 0x8000600000-0x8000603fff 64bit pref]
[    0.238324] pci 0000:04:00.0: BAR 1: assigned [mem 0x10600000-0x10600fff]
[    0.238907] pci 0000:00:01.3: PCI bridge to [bus 04]
[    0.239333] pci 0000:00:01.3:   bridge window [io  0x4000-0x4fff]
[    0.240400] pci 0000:00:01.3:   bridge window [mem 0x10600000-0x107fffff]
[    0.241317] pci 0000:00:01.3:   bridge window [mem 0x8000600000-0x80007fffff 64bit pref]
[    0.244198] pci 0000:05:00.0: BAR 4: assigned [mem 0x8000800000-0x8000803fff 64bit pref]
[    0.245358] pci 0000:05:00.0: BAR 1: assigned [mem 0x10800000-0x10800fff]
[    0.246145] pci 0000:00:01.4: PCI bridge to [bus 05]
[    0.246579] pci 0000:00:01.4:   bridge window [io  0x5000-0x5fff]
[    0.247576] pci 0000:00:01.4:   bridge window [mem 0x10800000-0x109fffff]
[    0.248471] pci 0000:00:01.4:   bridge window [mem 0x8000800000-0x80009fffff 64bit pref]
[    0.249795] pci 0000:06:00.0: BAR 2: assigned [mem 0x10a00000-0x10afffff 64bit]
[    0.250511] pci 0000:06:00.0: BAR 0: assigned [io  0x6000-0x60ff]
[    0.251025] pci 0000:00:01.5: PCI bridge to [bus 06]
[    0.251441] pci 0000:00:01.5:   bridge window [io  0x6000-0x6fff]
[    0.252490] pci 0000:00:01.5:   bridge window [mem 0x10a00000-0x10bfffff]
[    0.254463] pci 0000:00:01.5:   bridge window [mem 0x8000a00000-0x8000bfffff 64bit pref]
[    0.255791] pci 0000:07:00.0: BAR 4: assigned [mem 0x8000c00000-0x8000c03fff 64bit pref]
[    0.256517] pci 0000:07:00.0: BAR 1: assigned [mem 0x10c00000-0x10c00fff]
[    0.257087] pci 0000:00:01.6: PCI bridge to [bus 07]
[    0.257491] pci 0000:00:01.6:   bridge window [io  0x7000-0x7fff]
[    0.258529] pci 0000:00:01.6:   bridge window [mem 0x10c00000-0x10dfffff]
[    0.259420] pci 0000:00:01.6:   bridge window [mem 0x8000c00000-0x8000dfffff 64bit pref]
[    0.260757] pci_bus 0000:00: resource 4 [mem 0x10000000-0x3efeffff window]
[    0.261331] pci_bus 0000:00: resource 5 [io  0x0000-0xffff window]
[    0.261849] pci_bus 0000:00: resource 6 [mem 0x8000000000-0xffffffffff window]
[    0.262448] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    0.262913] pci_bus 0000:01: resource 1 [mem 0x10000000-0x101fffff]
[    0.263435] pci_bus 0000:01: resource 2 [mem 0x8000000000-0x80001fffff 64bit pref]
[    0.264708] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    0.265174] pci_bus 0000:02: resource 1 [mem 0x10200000-0x103fffff]
[    0.265696] pci_bus 0000:02: resource 2 [mem 0x8000200000-0x80003fffff 64bit pref]
[    0.266340] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
[    0.266822] pci_bus 0000:03: resource 1 [mem 0x10400000-0x105fffff]
[    0.267362] pci_bus 0000:03: resource 2 [mem 0x8000400000-0x80005fffff 64bit pref]
[    0.268017] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
[    0.268498] pci_bus 0000:04: resource 1 [mem 0x10600000-0x107fffff]
[    0.269042] pci_bus 0000:04: resource 2 [mem 0x8000600000-0x80007fffff 64bit pref]
[    0.269710] pci_bus 0000:05: resource 0 [io  0x5000-0x5fff]
[    0.270185] pci_bus 0000:05: resource 1 [mem 0x10800000-0x109fffff]
[    0.270716] pci_bus 0000:05: resource 2 [mem 0x8000800000-0x80009fffff 64bit pref]
[    0.271364] pci_bus 0000:06: resource 0 [io  0x6000-0x6fff]
[    0.271840] pci_bus 0000:06: resource 1 [mem 0x10a00000-0x10bfffff]
[    0.272383] pci_bus 0000:06: resource 2 [mem 0x8000a00000-0x8000bfffff 64bit pref]
[    0.273037] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
[    0.273513] pci_bus 0000:07: resource 1 [mem 0x10c00000-0x10dfffff]
[    0.274045] pci_bus 0000:07: resource 2 [mem 0x8000c00000-0x8000dfffff 64bit pref]
[    0.274796] ACPI: PCI: Interrupt link GSI0 configured for IRQ 35
[    0.275328] ACPI: PCI: Interrupt link GSI1 configured for IRQ 36
[    0.275850] ACPI: PCI: Interrupt link GSI2 configured for IRQ 37
[    0.276375] ACPI: PCI: Interrupt link GSI3 configured for IRQ 38
[    0.277363] iommu: Default domain type: Passthrough
[    0.277921] SCSI subsystem initialized
[    0.278823] libata version 3.00 loaded.
[    0.278988] ACPI: bus type USB registered
[    0.280230] usbcore: registered new interface driver usbfs
[    0.281786] usbcore: registered new interface driver hub
[    0.283297] usbcore: registered new device driver usb
[    0.285282] efivars: Registered efivars operations
[    0.288083] clocksource: Switched to clocksource arch_sys_counter
[    0.290250] pnp: PnP ACPI init
[    0.291470] system 00:00: [mem 0x4010000000-0x401fffffff window] could not be reserved
[    0.293626] pnp: PnP ACPI: found 1 devices
[    0.297348] NET: Registered PF_INET protocol family
[    0.299063] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.301821] tcp_listen_portaddr_hash hash table entries: 512 (order: 1, 8192 bytes, linear)
[    0.303954] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.305881] TCP established hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.307884] TCP bind hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.310301] TCP: Hash tables configured (established 8192 bind 8192)
[    0.312707] MPTCP token hash table entries: 1024 (order: 2, 24576 bytes, linear)
[    0.315214] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.316919] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[    0.319278] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.323114] pci 0000:03:00.0: enabling device (0000 -> 0002)
[    0.325811] PCI: CLS 0 bytes, default 64
[    0.327069] kvm [1]: HYP mode not available
[    0.328652] workingset: timestamp_bits=42 max_order=18 bucket_order=0
[    0.330014] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.331061] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.332666] 9p: Installing v9fs 9p2000 file system support
[    0.333906] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.335259] atomic64_test: passed
[    0.339735] ACPI: \_SB_.PCI0.GSI1: Enabled at IRQ 36
[    0.342972] pcieport 0000:00:01.0: PME: Signaling with IRQ 50
[    0.344316] pcieport 0000:00:01.0: AER: enabled with IRQ 50
[    0.349480] pcieport 0000:00:01.1: PME: Signaling with IRQ 51
[    0.350811] pcieport 0000:00:01.1: AER: enabled with IRQ 51
[    0.354647] pcieport 0000:00:01.2: PME: Signaling with IRQ 52
[    0.355822] pcieport 0000:00:01.2: AER: enabled with IRQ 52
[    0.360496] pcieport 0000:00:01.3: PME: Signaling with IRQ 53
[    0.361870] pcieport 0000:00:01.3: AER: enabled with IRQ 53
[    0.366723] pcieport 0000:00:01.4: PME: Signaling with IRQ 54
[    0.367994] pcieport 0000:00:01.4: AER: enabled with IRQ 54
[    0.375569] pcieport 0000:00:01.5: PME: Signaling with IRQ 55
[    0.377171] pcieport 0000:00:01.5: AER: enabled with IRQ 55
[    0.381268] pcieport 0000:00:01.6: PME: Signaling with IRQ 56
[    0.382243] pcieport 0000:00:01.6: AER: enabled with IRQ 56
[    0.384271] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.385843] ACPI: button: Power Button [PWRB]
[    0.387003] EINJ: EINJ table not found.
[    0.393835] virtio-pci 0000:01:00.0: enabling device (0000 -> 0002)
[    0.399155] virtio-pci 0000:02:00.0: enabling device (0000 -> 0002)
[    0.403927] virtio-pci 0000:04:00.0: enabling device (0000 -> 0002)
[    0.410983] virtio-pci 0000:07:00.0: enabling device (0000 -> 0002)
[    0.414689] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
[    0.416796] SuperH (H)SCI(F) driver initialized
[    0.448503] ACPI: bus type drm_connector registered
[    0.452978] loop: module loaded
[    0.453713] virtio_blk virtio3: 1/0/0 default/read/poll queues
[    0.455436] virtio_blk virtio3: [vda] 475711 512-byte logical blocks (244 MB/232 MiB)
[    0.461165] GPT:Primary header thinks Alt. header is not at the end of the disk.
[    0.462447] GPT:475680 != 475710
[    0.463028] GPT:Alternate GPT header not at the end of the disk.
[    0.464055] GPT:475680 != 475710
[    0.464637] GPT: Use GNU Parted to correct GPT errors.
[    0.465528]  vda: vda1 vda2 vda128
[    0.477358] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    0.478389] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
[    0.479847] xhci_hcd 0000:03:00.0: hcc params 0x00087001 hci version 0x100 quirks 0x0000000000000010
[    0.481957] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    0.482730] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 2
[    0.483816] xhci_hcd 0000:03:00.0: Host supports USB 3.0 SuperSpeed
[    0.485089] hub 1-0:1.0: USB hub found
[    0.485711] hub 1-0:1.0: 15 ports detected
[    0.486929] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.488477] hub 2-0:1.0: USB hub found
[    0.489107] hub 2-0:1.0: 15 ports detected
[    0.490588] usbcore: registered new interface driver usb-storage
[    0.492297] rtc-efi rtc-efi.0: registered as rtc0
[    0.493109] rtc-efi rtc-efi.0: setting system clock to 2025-05-29T01:22:07 UTC (1748481727)
[    0.494996] sdhci: Secure Digital Host Controller Interface driver
[    0.495900] sdhci: Copyright(c) Pierre Ossman
[    0.496672] Synopsys Designware Multimedia Card Interface Driver
[    0.497565] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.498972] pstore: Using crash dump compression: deflate
[    0.499643] pstore: Registered efi_pstore as persistent store backend
[    0.500721] hid: raw HID events driver (C) Jiri Kosina
[    0.501410] usbcore: registered new interface driver usbhid
[    0.502113] usbhid: USB HID core driver
[    0.502980] NET: Registered PF_INET6 protocol family
[    0.504328] Segment Routing with IPv6
[    0.504791] In-situ OAM (IOAM) with IPv6
[    0.505309] NET: Registered PF_PACKET protocol family
[    0.505934] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    0.507679] 8021q: 802.1Q VLAN Support v1.8
[    0.508240] 9pnet: Installing 9P2000 support
[    0.525863] clk: Disabling unused clocks
[    0.530430] EXT4-fs (vda2): mounted filesystem ff313567-e9f1-5a5d-9895-3ba130b4a864 ro with ordered data mode. Quota mode: disabled.
[    0.531801] VFS: Mounted root (ext4 filesystem) readonly on device 254:2.
[    0.533927] Freeing unused kernel memory: 3584K
[    0.534524] Run /sbin/init as init process
[    0.534977]   with arguments:
[    0.534977]     /sbin/init
[    0.534981]   with environment:
[    0.534982]     HOME=/
[    0.534984]     TERM=linux
[    0.534985]     BOOT_IMAGE=/efi/openwrt/vmlinux
[    0.547942] init: Console is alive
[    0.594741] kmodloader: loading kernel modules from /etc/modules-boot.d/*
[    0.600117] pps_core: LinuxPPS API ver. 1 registered
[    0.601031] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.606931] PTP clock support registered
[    0.609968] kmodloader: done loading kernel modules from /etc/modules-boot.d/*
[    0.620317] init: - preinit -
[    0.695254] 8021q: adding VLAN 0 to HW filter on device eth0
[    3.279475] mount_root: mounting /dev/root with options
[    3.310702] EXT4-fs (vda2): re-mounted ff313567-e9f1-5a5d-9895-3ba130b4a864 r/w. Quota mode: disabled.
[    3.500485] urandom-seed: Seeding with /etc/urandom.seed
[    3.512095] procd: - early -
[    4.041259] procd: - ubus -
[    4.095701] procd: - init -
[    4.283380] kmodloader: loading kernel modules from /etc/modules.d/*
[    4.292548] urngd: v1.0.2 started.
[    4.389751] MACsec IEEE 802.1AE
[    4.402218] VMware vmxnet3 virtual NIC driver - version 1.7.0.0-k-NAPI
[    4.409042] rvu_af: Marvell OcteonTX2 RVU Admin Function Driver
[    4.412428] rvu_nicpf: Marvell RVU NIC Physical Function Driver
[    4.414077] rvu_nicvf: Marvell RVU NIC Virtual Function Driver
[    4.418278] thunder_xcv, ver 1.0
[    4.419218] thunder_bgx, ver 1.0
[    4.419885] nicpf, ver 1.0
[    4.420771] nicvf, ver 1.0
[    4.423856] i2c_dev: i2c /dev entries driver
[    4.430700] compat: loading out-of-tree module taints kernel.
[    4.431577] Loading modules backported from Linux version v6.12.6-0-ge9d65b48ce1a
[    4.432481] Backport generated by backports.git v6.1.110-1-35-g410656ef04d2
[    4.434493] e1000e: Intel(R) PRO/1000 Network Driver
[    4.435118] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.451308] Intel(R) Wireless WiFi driver for Linux
[    4.470080] PPP generic driver version 2.4.2
[    4.471145] NET: Registered PF_PPPOX protocol family
[    4.478142] kmodloader: done loading kernel modules from /etc/modules.d/*
[    5.364103] 8021q: adding VLAN 0 to HW filter on device eth0
[    5.366509] br-lan: port 1(eth0) entered blocking state
[    5.366996] br-lan: port 1(eth0) entered disabled state
[    5.367477] virtio_net virtio0 eth0: entered allmulticast mode
[    5.368157] virtio_net virtio0 eth0: entered promiscuous mode
[    5.371519] br-lan: port 1(eth0) entered blocking state
[    5.372008] br-lan: port 1(eth0) entered forwarding state
[    5.382624] 8021q: adding VLAN 0 to HW filter on device eth1
[  746.342783] rtw89_8852be 0000:06:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
[  746.346984] rtw89_8852be 0000:06:00.0: probe driver without chanctx
[  746.346998] rtw89_8852be 0000:06:00.0: probe driver without MLO cap
[  746.347659] ACPI: \: failed to evaluate _DSM e8c3a8d2-694b-004f-82bd-fe8607803aa7 (0x1001)
[  746.351864] rtw89_8852be 0000:06:00.0: acpi dsm fail to evaluate func: 5
[  746.351874] rtw89_8852be 0000:06:00.0: acpi: cannot get TAS: -2
[  746.351997] rtw89_8852be 0000:06:00.0: enabling device (0000 -> 0003)
[  746.363559] rtw89_8852be 0000:06:00.0: full firmware has been early requested
[  746.369036] rtw89_8852be 0000:06:00.0: Firmware version 0.29.29.5 (da87cccd), cmd version 0, type 5
[  746.373384] rtw89_8852be 0000:06:00.0: Firmware version 0.29.29.5 (da87cccd), cmd version 0, type 3
[  746.377254] rtw89_8852be 0000:06:00.0: [BTC] use version def[6] = 0x001d1d00
[  747.783549] rtw89_8852be 0000:06:00.0: [ERR]FWDL path ready
[  747.784119] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x1E0 = 0x23
[  747.784652] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x83F0 = 0x70000
[  747.785193] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccff
[  747.785696] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f33
[  747.786196] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f47
[  747.786695] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f4b
[  747.787203] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccdd
[  747.787708] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f3f
[  747.788213] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  747.788719] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f53
[  747.789229] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  747.789736] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f4b
[  747.790247] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  747.790752] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  747.791257] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  747.791807] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f4d
[  747.792313] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f51
[  749.193857] rtw89_8852be 0000:06:00.0: [ERR]FWDL path ready
[  749.194369] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x1E0 = 0x23
[  749.194878] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x83F0 = 0x70000
[  749.195427] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ceeb
[  749.195920] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccdb
[  749.196405] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f4b
[  749.196898] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  749.197381] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f57
[  749.197865] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  749.198349] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  749.198851] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  749.199349] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  749.200034] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f45
[  749.200555] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  749.201044] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  749.201591] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f55
[  749.202090] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  749.202581] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f3b
[  750.604144] rtw89_8852be 0000:06:00.0: [ERR]FWDL path ready
[  750.604686] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x1E0 = 0x23
[  750.605161] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x83F0 = 0x70000
[  750.605684] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f4b
[  750.606178] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f3f
[  750.606673] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f47
[  750.607173] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  750.607673] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f3b
[  750.608176] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f55
[  750.608678] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  750.609182] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f43
[  750.609683] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  750.610187] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f33
[  750.610687] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f4d
[  750.611182] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccdb
[  750.611745] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccdf
[  750.612252] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f47
[  750.612751] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f31
[  752.014271] rtw89_8852be 0000:06:00.0: [ERR]FWDL path ready
[  752.014799] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x1E0 = 0x23
[  752.015295] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x83F0 = 0x70000
[  752.015809] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f49
[  752.016306] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  752.016797] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f4b
[  752.017293] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f3f
[  752.017786] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f2f
[  752.018272] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f53
[  752.018761] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  752.019240] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f47
[  752.019718] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  752.020193] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f31
[  752.020673] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  752.021182] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f37
[  752.021660] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  752.022136] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  752.022615] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  753.424221] rtw89_8852be 0000:06:00.0: [ERR]FWDL path ready
[  753.424772] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x1E0 = 0x23
[  753.425285] rtw89_8852be 0000:06:00.0: [ERR]fwdl 0x83F0 = 0x70000
[  753.425807] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  753.426301] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f45
[  753.426802] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f4b
[  753.427299] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f4b
[  753.427795] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  753.428292] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f3f
[  753.428779] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  753.429284] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f4d
[  753.429788] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccdb
[  753.430283] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  753.430807] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccdf
[  753.431351] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f55
[  753.431869] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb8901f2f
[  753.432349] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  753.432830] rtw89_8852be 0000:06:00.0: [ERR]fw PC = 0xb890ccd9
[  753.433323] rtw89_8852be 0000:06:00.0: failed to setup chip information
[  753.436017] rtw89_8852be: probe of 0000:06:00.0 failed with error -110

==== Questions ====
* Any known ARM passthrough quirks for this chip?
* Suggested debug steps for error -100?

Other logs available if needed. Thanks!
Best regards


