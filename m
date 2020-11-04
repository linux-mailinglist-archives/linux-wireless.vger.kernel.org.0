Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4A2A64CF
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 14:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgKDNEj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 08:04:39 -0500
Received: from mout01.posteo.de ([185.67.36.65]:49162 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbgKDNEi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 08:04:38 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 10C6916005F
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 14:04:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1604495052; bh=c2IskGZWu6/ApknMIfS6fcGLjiGo40VySao1YmoIuIE=;
        h=Subject:To:Cc:From:Date:From;
        b=cMf7lSnFfyrFmz+qkFMmTQTUCSgZNyimJiOilg3BXizR3XDhrL392rTqDNDQOo5FG
         DWQykDgTJ+4LyUnUS6n/y+FGpJ9ytz2dEhbC/EeITodIrmEQ6pQSzm3ia0GE5jBSkM
         Id1vxmugqvBXGp38xmvQV282dUIMs6XcHTDxakbAZXpJ0BsLDo3+leusCuD0wI8X9G
         /x9+soF4RdOUPW8NXbjgGxW+84PcKijSW73jbQ9Vbv/qGDpjz+dBTAibsjK+SDd7uF
         ZJJyd22sO/wuRhMQvsEuS+UsQgoa166Fnj5+U0erLdo+lAHxjMgkfkfxASF5D4cnOk
         QWjqmPdXlJItg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CR6L141Kzz9rxx;
        Wed,  4 Nov 2020 14:04:09 +0100 (CET)
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
To:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        ath11k@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <20201103160838.GA246433@bjorn-Precision-5520>
 <874km61732.fsf@nanos.tec.linutronix.de>
From:   Thomas Krause <thomaskrause@posteo.de>
Message-ID: <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de>
Date:   Wed, 4 Nov 2020 14:04:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <874km61732.fsf@nanos.tec.linutronix.de>
Content-Type: multipart/mixed;
 boundary="------------A19D7DB9D2032D15CFFFD468"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------A19D7DB9D2032D15CFFFD468
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


> Can I have a full dmesg please?
>
> Please enable CONFIG_IRQ_REMAP and CONFIG_INTEL_IOMMU (not strictly
> required, but it's a Dell BIOS after all). Also set
> CONFIG_INTEL_IOMMU_DEFAULT_ON.

I attached a full dmesg with the latest ath11k master and the 
configuration enabled. VT-d was enabled in BIOS. Most options have been 
already been present in the previous attempts (copied from the distro 
config) but CONFIG_INTEL_IOMMU_DEFAULT_ON needed to be set manually. I 
hope this helps, if there is more I can do to debug it on my side I'm 
happy to do so.


--------------A19D7DB9D2032D15CFFFD468
Content-Type: text/x-log; charset=UTF-8;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] Linux version 5.10.0-rc1-wt-ath+ (thomas@tk-9310) (gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0, GNU ld (GNU Binutils for Ubuntu) 2.35.1) #1 SMP Wed Nov 4 12:19:14 CET 2020
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.10.0-rc1-wt-ath+ root=/dev/mapper/ubuntu--vg-root ro quiet splash vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/split lock detection: warning about user-space split_locks
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000005f72afff] usable
[    0.000000] BIOS-e820: [mem 0x000000005f72b000-0x0000000063510fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000063511000-0x0000000063d71fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000063d72000-0x0000000063ffefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000063fff000-0x0000000063ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000064000000-0x0000000067ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000068600000-0x00000000687fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000069000000-0x00000000707fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000088f7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.70 by Dell
[    0.000000] efi: ACPI=0x63ffe000 ACPI 2.0=0x63ffe014 SMBIOS=0x5fdd7000 TPMFinalLog=0x63cd8000 ESRT=0x5fcecd18 MEMATTR=0x588b3018 RNG=0x5fcf0f98 TPMEventLog=0x5ad43018 
[    0.000000] efi: seeding entropy pool
[    0.000000] random: fast init done
[    0.000000] SMBIOS 3.2 present.
[    0.000000] DMI: Dell Inc. XPS 13 9310/0F7M4C, BIOS 1.1.1 10/05/2020
[    0.000000] tsc: Detected 2800.000 MHz processor
[    0.000000] tsc: Detected 2803.200 MHz TSC
[    0.000004] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000005] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000009] last_pfn = 0x88f800 max_arch_pfn = 0x400000000
[    0.000011] MTRR default type: write-back
[    0.000011] MTRR fixed ranges enabled:
[    0.000012]   00000-9FFFF write-back
[    0.000012]   A0000-BFFFF uncachable
[    0.000013]   C0000-FFFFF write-protect
[    0.000013] MTRR variable ranges enabled:
[    0.000014]   0 base 0080000000 mask 7F80000000 uncachable
[    0.000015]   1 base 0070000000 mask 7FF0000000 uncachable
[    0.000015]   2 base 006C000000 mask 7FFC000000 uncachable
[    0.000016]   3 base 2000000000 mask 6000000000 uncachable
[    0.000016]   4 base 1000000000 mask 7000000000 uncachable
[    0.000016]   5 base 4000000000 mask 4000000000 uncachable
[    0.000017]   6 disabled
[    0.000017]   7 disabled
[    0.000017]   8 disabled
[    0.000018]   9 disabled
[    0.000450] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000802] last_pfn = 0x64000 max_arch_pfn = 0x400000000
[    0.007947] esrt: Reserving ESRT space from 0x000000005fcecd18 to 0x000000005fcecda0.
[    0.007956] check: Scanning 1 areas for low memory corruption
[    0.007960] Using GB pages for direct mapping
[    0.008076] Secure boot disabled
[    0.008076] RAMDISK: [mem 0x22f82000-0x28496fff]
[    0.008091] ACPI: Early table checksum verification disabled
[    0.008094] ACPI: RSDP 0x0000000063FFE014 000024 (v02 DELL  )
[    0.008097] ACPI: XSDT 0x0000000063F79188 00010C (v01 DELL   Dell Inc 00000002      01000013)
[    0.008102] ACPI: FACP 0x0000000063FF5000 000114 (v06 DELL   Dell Inc 00000002      01000013)
[    0.008106] ACPI: DSDT 0x0000000063F98000 05903E (v02 DELL   Dell Inc 00000002      01000013)
[    0.008108] ACPI: FACS 0x0000000063D1B000 000040
[    0.008110] ACPI: SSDT 0x0000000063FFA000 00255D (v02 CpuRef CpuSsdt  00003000 INTL 20191018)
[    0.008112] ACPI: SSDT 0x0000000063FF6000 0038E4 (v02 DptfTb DptfTabl 00001000 INTL 20191018)
[    0.008114] ACPI: HPET 0x0000000063FF4000 000038 (v01 DELL   Dell Inc 00000002      01000013)
[    0.008116] ACPI: APIC 0x0000000063FF3000 00012C (v04 DELL   Dell Inc 00000002      01000013)
[    0.008118] ACPI: MCFG 0x0000000063FF2000 00003C (v01 DELL   Dell Inc 00000002      01000013)
[    0.008120] ACPI: SSDT 0x0000000063F97000 000D01 (v02 DELL   DellRtd3 00001000 INTL 20191018)
[    0.008121] ACPI: NHLT 0x0000000063F95000 001B54 (v00 DELL   Dell Inc 00000002      01000013)
[    0.008123] ACPI: SSDT 0x0000000063F92000 002BB5 (v02 SaSsdt SaSsdt   00003000 INTL 20191018)
[    0.008125] ACPI: SSDT 0x0000000063F90000 0012AA (v02 INTEL  IgfxSsdt 00003000 INTL 20191018)
[    0.008127] ACPI: SSDT 0x0000000063F84000 00B192 (v02 INTEL  TcssSsdt 00001000 INTL 20191018)
[    0.008129] ACPI: SSDT 0x0000000063F83000 000CD2 (v02 DELL   UsbCTabl 00001000 INTL 20191018)
[    0.008131] ACPI: LPIT 0x0000000063F82000 0000CC (v01 DELL   Dell Inc 00000002      01000013)
[    0.008133] ACPI: WSMT 0x0000000063F81000 000028 (v01 DELL   Dell Inc 00000002      01000013)
[    0.008135] ACPI: SSDT 0x0000000063F80000 000B75 (v02 DELL   PtidDevc 00001000 INTL 20191018)
[    0.008137] ACPI: SSDT 0x0000000063F7F000 00012A (v02 DELL   TbtTypeC 00000000 INTL 20191018)
[    0.008139] ACPI: DBGP 0x0000000063F7E000 000034 (v01 DELL   Dell Inc 00000002      01000013)
[    0.008141] ACPI: DBG2 0x0000000063F7D000 000054 (v00 DELL   Dell Inc 00000002      01000013)
[    0.008143] ACPI: SLIC 0x0000000063F7C000 000176 (v03 DELL   CBX3     06222004 MSFT 00010013)
[    0.008144] ACPI: BOOT 0x0000000063F7B000 000028 (v01 DELL   CBX3     00000002      01000013)
[    0.008146] ACPI: SSDT 0x0000000063F7A000 00060E (v02 DELL   Tpm2Tabl 00001000 INTL 20191018)
[    0.008148] ACPI: TPM2 0x0000000063FFD000 00004C (v04 DELL   Dell Inc 00000002      01000013)
[    0.008150] ACPI: MSDM 0x0000000063F78000 000055 (v03 DELL   CBX3     06222004 AMI  00010013)
[    0.008152] ACPI: DMAR 0x0000000063F77000 0000A8 (v02 INTEL  Dell Inc 00000002      01000013)
[    0.008154] ACPI: SSDT 0x0000000063F76000 000841 (v02 DELL   xh_Dell_ 00000000 INTL 20191018)
[    0.008156] ACPI: SSDT 0x0000000063F75000 000144 (v02 Intel  ADebTabl 00001000 INTL 20191018)
[    0.008158] ACPI: PTDT 0x0000000063F74000 000D44 (v00 DELL   Dell Inc 00000005 MSFT 0100000D)
[    0.008160] ACPI: BGRT 0x0000000063F73000 000038 (v01 DELL   Dell Inc 00000002      01000013)
[    0.008162] ACPI: FPDT 0x0000000063F72000 000034 (v01 DELL   Dell Inc 00000002      01000013)
[    0.008168] ACPI: Local APIC address 0xfee00000
[    0.008441] No NUMA configuration found
[    0.008441] Faking a node at [mem 0x0000000000000000-0x000000088f7fffff]
[    0.008447] NODE_DATA(0) allocated [mem 0x88f7d6000-0x88f7fffff]
[    0.008637] Zone ranges:
[    0.008638]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.008638]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.008639]   Normal   [mem 0x0000000100000000-0x000000088f7fffff]
[    0.008640]   Device   empty
[    0.008641] Movable zone start for each node
[    0.008643] Early memory node ranges
[    0.008643]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.008644]   node   0: [mem 0x0000000000100000-0x000000005f72afff]
[    0.008644]   node   0: [mem 0x0000000063fff000-0x0000000063ffffff]
[    0.008645]   node   0: [mem 0x0000000100000000-0x000000088f7fffff]
[    0.008929] Zeroed struct page in unavailable ranges: 37174 pages
[    0.008931] Initmem setup node 0 [mem 0x0000000000001000-0x000000088f7fffff]
[    0.008932] On node 0 totalpages: 8318666
[    0.008933]   DMA zone: 64 pages used for memmap
[    0.008933]   DMA zone: 22 pages reserved
[    0.008934]   DMA zone: 3998 pages, LIFO batch:0
[    0.008957]   DMA32 zone: 6045 pages used for memmap
[    0.008958]   DMA32 zone: 386860 pages, LIFO batch:63
[    0.010805]   Normal zone: 123872 pages used for memmap
[    0.010805]   Normal zone: 7927808 pages, LIFO batch:63
[    0.046187] Reserving Intel graphics memory at [mem 0x6c800000-0x707fffff]
[    0.046975] ACPI: PM-Timer IO Port: 0x1808
[    0.046976] ACPI: Local APIC address 0xfee00000
[    0.046981] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.046982] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.046982] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.046982] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.046983] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.046983] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.046983] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.046984] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.046984] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.046984] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.046985] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.046985] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.046985] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.046986] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.046986] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.046986] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.047022] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.047023] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.047024] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.047025] ACPI: IRQ0 used by override.
[    0.047026] ACPI: IRQ9 used by override.
[    0.047027] Using ACPI (MADT) for SMP configuration information
[    0.047028] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.047033] e820: update [mem 0x5ad50000-0x5ad6dfff] usable ==> reserved
[    0.047038] TSC deadline timer available
[    0.047038] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.047046] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.047047] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000fffff]
[    0.047047] PM: hibernation: Registered nosave memory: [mem 0x5ad50000-0x5ad6dfff]
[    0.047048] PM: hibernation: Registered nosave memory: [mem 0x5f72b000-0x63510fff]
[    0.047049] PM: hibernation: Registered nosave memory: [mem 0x63511000-0x63d71fff]
[    0.047049] PM: hibernation: Registered nosave memory: [mem 0x63d72000-0x63ffefff]
[    0.047050] PM: hibernation: Registered nosave memory: [mem 0x64000000-0x67ffffff]
[    0.047050] PM: hibernation: Registered nosave memory: [mem 0x68000000-0x685fffff]
[    0.047050] PM: hibernation: Registered nosave memory: [mem 0x68600000-0x687fffff]
[    0.047051] PM: hibernation: Registered nosave memory: [mem 0x68800000-0x68ffffff]
[    0.047051] PM: hibernation: Registered nosave memory: [mem 0x69000000-0x707fffff]
[    0.047051] PM: hibernation: Registered nosave memory: [mem 0x70800000-0xbfffffff]
[    0.047052] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xcfffffff]
[    0.047052] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xfed1ffff]
[    0.047052] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    0.047053] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfeffffff]
[    0.047053] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.047054] [mem 0x70800000-0xbfffffff] available for PCI devices
[    0.047055] Booting paravirtualized kernel on bare hardware
[    0.047056] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.047060] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.047164] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
[    0.047167] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
[    0.047168] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.047182] Built 1 zonelists, mobility grouping on.  Total pages: 8188663
[    0.047183] Policy zone: Normal
[    0.047183] Kernel command line: BOOT_IMAGE=/vmlinuz-5.10.0-rc1-wt-ath+ root=/dev/mapper/ubuntu--vg-root ro quiet splash vt.handoff=7
[    0.048019] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.048423] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.048474] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.050130] DMAR: [Firmware Bug]: Your BIOS is broken; DMAR reported at address 0!
               BIOS vendor: Dell Inc.; Ver: 1.1.1; Product Version: 
[    0.091268] Memory: 32407176K/33274664K available (14345K kernel code, 3506K rwdata, 5212K rodata, 2636K init, 6000K bss, 867228K reserved, 0K cma-reserved)
[    0.091273] random: get_random_u64 called from __kmem_cache_create+0x2d/0x540 with crng_init=1
[    0.091351] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.091358] ftrace: allocating 46263 entries in 181 pages
[    0.100864] ftrace: allocated 181 pages with 5 groups
[    0.100940] rcu: Hierarchical RCU implementation.
[    0.100941] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.100942] 	Rude variant of Tasks RCU enabled.
[    0.100942] 	Tracing variant of Tasks RCU enabled.
[    0.100943] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.100943] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.102847] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
[    0.103281] random: crng done (trusting CPU's manufacturer)
[    0.103295] Console: colour dummy device 80x25
[    0.103303] printk: console [tty0] enabled
[    0.103314] ACPI: Core revision 20200925
[    0.103583] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 99544814920 ns
[    0.103691] APIC: Switch to symmetric I/O mode setup
[    0.103693] DMAR: Host address width 39
[    0.103693] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.103697] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 69e2ff0505e
[    0.103698] DMAR: DRHD base: 0x000000fed84000 flags: 0x0
[    0.103701] DMAR: dmar1: reg_base_addr fed84000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.103702] DMAR: DRHD base: 0x000000fed86000 flags: 0x0
[    0.103706] DMAR: dmar2: reg_base_addr fed86000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.103707] DMAR: DRHD base: 0x00000000000000 flags: 0x1
[    0.103707] DMAR: Parse DMAR table failure.
[    0.104980] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.109990] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.127643] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[    0.127646] Calibrating delay loop (skipped), value calculated using timer frequency.. 5606.40 BogoMIPS (lpj=11212800)
[    0.127648] pid_max: default: 32768 minimum: 301
[    0.129518] LSM: Security Framework initializing
[    0.129527] Yama: becoming mindful.
[    0.129556] AppArmor: AppArmor initialized
[    0.129625] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.129682] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.129857] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.129885] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.129950] process: using mwait in idle threads
[    0.129951] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.129952] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.129954] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.129955] Spectre V2 : Mitigation: Enhanced IBRS
[    0.129955] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.129957] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.129957] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.130177] Freeing SMP alternatives memory: 40K
[    0.131733] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz (family: 0x6, model: 0x8c, stepping: 0x1)
[    0.131801] Performance Events: PEBS fmt4+-baseline, Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.131808] ... version:                5
[    0.131808] ... bit width:              48
[    0.131808] ... generic registers:      8
[    0.131809] ... value mask:             0000ffffffffffff
[    0.131809] ... max period:             00007fffffffffff
[    0.131809] ... fixed-purpose events:   4
[    0.131810] ... event mask:             0001000f000000ff
[    0.131857] rcu: Hierarchical SRCU implementation.
[    0.132296] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.132345] smp: Bringing up secondary CPUs ...
[    0.132390] x86: Booting SMP configuration:
[    0.132391] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.141093] smp: Brought up 1 node, 8 CPUs
[    0.141093] smpboot: Max logical packages: 1
[    0.141093] smpboot: Total of 8 processors activated (44851.20 BogoMIPS)
[    0.144518] devtmpfs: initialized
[    0.144518] x86/mm: Memory block size: 128MB
[    0.144701] PM: Registering ACPI NVS region [mem 0x63511000-0x63d71fff] (8785920 bytes)
[    0.144701] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.144701] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.144701] pinctrl core: initialized pinctrl subsystem
[    0.144701] PM: RTC time: 12:34:09, date: 2020-11-04
[    0.144701] NET: Registered protocol family 16
[    0.144701] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.144701] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.144723] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.144728] audit: initializing netlink subsys (disabled)
[    0.144733] audit: type=2000 audit(1604493249.040:1): state=initialized audit_enabled=0 res=1
[    0.144733] thermal_sys: Registered thermal governor 'fair_share'
[    0.144733] thermal_sys: Registered thermal governor 'bang_bang'
[    0.144733] thermal_sys: Registered thermal governor 'step_wise'
[    0.144733] thermal_sys: Registered thermal governor 'user_space'
[    0.144733] thermal_sys: Registered thermal governor 'power_allocator'
[    0.144733] EISA bus registered
[    0.144733] cpuidle: using governor ladder
[    0.144733] cpuidle: using governor menu
[    0.144733] Simple Boot Flag at 0x47 set to 0x80
[    0.144733] ACPI: bus type PCI registered
[    0.144733] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.144733] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[    0.144733] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
[    0.144733] PCI: Using configuration type 1 for base access
[    0.147650] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.148275] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.148275] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.148275] ACPI: Added _OSI(Module Device)
[    0.148275] ACPI: Added _OSI(Processor Device)
[    0.148275] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.148275] ACPI: Added _OSI(Processor Aggregator Device)
[    0.148275] ACPI: Added _OSI(Linux-Dell-Video)
[    0.148275] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.148275] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.202420] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.215261] ACPI: Dynamic OEM Table Load:
[    0.215268] ACPI: SSDT 0xFFFF934700DF7E00 0001CB (v02 PmRef  Cpu0Psd  00003000 INTL 20191018)
[    0.216201] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    0.218127] ACPI: Dynamic OEM Table Load:
[    0.218131] ACPI: SSDT 0xFFFF934700DB5400 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20191018)
[    0.219215] ACPI: Dynamic OEM Table Load:
[    0.219219] ACPI: SSDT 0xFFFF9347015C6800 000647 (v02 PmRef  Cpu0Ist  00003000 INTL 20191018)
[    0.220376] ACPI: Dynamic OEM Table Load:
[    0.220380] ACPI: SSDT 0xFFFF934700DB6C00 000266 (v02 PmRef  Cpu0Hwp  00003000 INTL 20191018)
[    0.221595] ACPI: Dynamic OEM Table Load:
[    0.221599] ACPI: SSDT 0xFFFF93470013A000 0008E7 (v02 PmRef  ApIst    00003000 INTL 20191018)
[    0.222798] ACPI: Dynamic OEM Table Load:
[    0.222801] ACPI: SSDT 0xFFFF9347015C3000 00048A (v02 PmRef  ApHwp    00003000 INTL 20191018)
[    0.223913] ACPI: Dynamic OEM Table Load:
[    0.223916] ACPI: SSDT 0xFFFF9347015C4000 0004D2 (v02 PmRef  ApPsd    00003000 INTL 20191018)
[    0.225037] ACPI: Dynamic OEM Table Load:
[    0.225040] ACPI: SSDT 0xFFFF9347015C7000 00048A (v02 PmRef  ApCst    00003000 INTL 20191018)
[    0.229625] ACPI: EC: EC started
[    0.229625] ACPI: EC: interrupt blocked
[    0.232144] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    0.232145] ACPI: \_SB_.PC00.LPCB.ECDV: Boot DSDT EC used to handle transactions
[    0.232145] ACPI: Interpreter enabled
[    0.232186] ACPI: (supports S0 S4 S5)
[    0.232187] ACPI: Using IOAPIC for interrupt routing
[    0.232222] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.233868] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.239996] ACPI: Power Resource [WRST] (on)
[    0.240014] ACPI: Power Resource [DRST] (on)
[    0.245952] ACPI: Power Resource [V0PR] (on)
[    0.246062] ACPI: Power Resource [V1PR] (on)
[    0.246166] ACPI: Power Resource [V2PR] (on)
[    0.249717] ACPI: Power Resource [WRST] (on)
[    0.257257] ACPI: Power Resource [TBT0] (on)
[    0.257292] ACPI: Power Resource [TBT1] (on)
[    0.257319] ACPI: Power Resource [D3C] (on)
[    0.497199] ACPI: Power Resource [PIN] (off)
[    0.497496] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    0.497500] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.499133] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.502179] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
[    0.505031] PCI host bridge to bus 0000:00
[    0.505032] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.505033] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.505033] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.505034] pci_bus 0000:00: root bus resource [mem 0x70800000-0xbfffffff window]
[    0.505034] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.505035] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.505059] pci 0000:00:00.0: [8086:9a14] type 00 class 0x060000
[    0.506292] pci 0000:00:02.0: [8086:9a49] type 00 class 0x030000
[    0.506300] pci 0000:00:02.0: reg 0x10: [mem 0x603c000000-0x603cffffff 64bit]
[    0.506304] pci 0000:00:02.0: reg 0x18: [mem 0x4000000000-0x400fffffff 64bit pref]
[    0.506307] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
[    0.506320] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.506321] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.506344] pci 0000:00:02.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bit]
[    0.506345] pci 0000:00:02.0: VF(n) BAR0 space: [mem 0x00000000-0x06ffffff 64bit] (contains BAR0 for 7 VFs)
[    0.506349] pci 0000:00:02.0: reg 0x34c: [mem 0x00000000-0x1fffffff 64bit pref]
[    0.506349] pci 0000:00:02.0: VF(n) BAR2 space: [mem 0x00000000-0xdfffffff 64bit pref] (contains BAR2 for 7 VFs)
[    0.507214] pci 0000:00:04.0: [8086:9a03] type 00 class 0x118000
[    0.507229] pci 0000:00:04.0: reg 0x10: [mem 0x603d180000-0x603d19ffff 64bit]
[    0.508179] pci 0000:00:06.0: [8086:9a09] type 01 class 0x060400
[    0.508267] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.508302] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.509228] pci 0000:00:07.0: [8086:9a23] type 01 class 0x060400
[    0.510098] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.510119] pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
[    0.510126] fbcon: Taking over console
[    0.510230] pci 0000:00:07.2: [8086:9a27] type 01 class 0x060400
[    0.511100] pci 0000:00:07.2: PME# supported from D0 D3hot D3cold
[    0.511121] pci 0000:00:07.2: DPC: RP PIO log size 0 is invalid
[    0.511234] pci 0000:00:0a.0: [8086:9a0d] type 00 class 0x118000
[    0.511240] pci 0000:00:0a.0: reg 0x10: [mem 0x603d1d0000-0x603d1d7fff 64bit]
[    0.511259] pci 0000:00:0a.0: enabling Extended Tags
[    0.512127] pci 0000:00:0d.0: [8086:9a13] type 00 class 0x0c0330
[    0.512139] pci 0000:00:0d.0: reg 0x10: [mem 0x603d1c0000-0x603d1cffff 64bit]
[    0.512192] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[    0.513071] pci 0000:00:0d.2: [8086:9a1b] type 00 class 0x0c0340
[    0.513081] pci 0000:00:0d.2: reg 0x10: [mem 0x603d140000-0x603d17ffff 64bit]
[    0.513088] pci 0000:00:0d.2: reg 0x18: [mem 0x603d1e9000-0x603d1e9fff 64bit]
[    0.513123] pci 0000:00:0d.2: supports D1 D2
[    0.513123] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.513966] pci 0000:00:0d.3: [8086:9a1d] type 00 class 0x0c0340
[    0.513976] pci 0000:00:0d.3: reg 0x10: [mem 0x603d100000-0x603d13ffff 64bit]
[    0.513983] pci 0000:00:0d.3: reg 0x18: [mem 0x603d1e8000-0x603d1e8fff 64bit]
[    0.514016] pci 0000:00:0d.3: supports D1 D2
[    0.514017] pci 0000:00:0d.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.514894] pci 0000:00:12.0: [8086:a0fc] type 00 class 0x070000
[    0.514915] pci 0000:00:12.0: reg 0x10: [mem 0x603d1b0000-0x603d1bffff 64bit]
[    0.514986] pci 0000:00:12.0: PME# supported from D0 D3hot
[    0.515927] pci 0000:00:14.0: [8086:a0ed] type 00 class 0x0c0330
[    0.515948] pci 0000:00:14.0: reg 0x10: [mem 0x603d1a0000-0x603d1affff 64bit]
[    0.516033] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.516924] pci 0000:00:14.2: [8086:a0ef] type 00 class 0x050000
[    0.516943] pci 0000:00:14.2: reg 0x10: [mem 0x603d1dc000-0x603d1dffff 64bit]
[    0.516956] pci 0000:00:14.2: reg 0x18: [mem 0x603d1e7000-0x603d1e7fff 64bit]
[    0.517907] pci 0000:00:15.0: [8086:a0e8] type 00 class 0x0c8000
[    0.517938] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.518983] pci 0000:00:15.1: [8086:a0e9] type 00 class 0x0c8000
[    0.519013] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.520051] pci 0000:00:16.0: [8086:a0e0] type 00 class 0x078000
[    0.520073] pci 0000:00:16.0: reg 0x10: [mem 0x603d1e4000-0x603d1e4fff 64bit]
[    0.520158] pci 0000:00:16.0: PME# supported from D3hot
[    0.521134] pci 0000:00:19.0: [8086:a0c5] type 00 class 0x0c8000
[    0.521164] pci 0000:00:19.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.522189] pci 0000:00:19.1: [8086:a0c6] type 00 class 0x0c8000
[    0.522219] pci 0000:00:19.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.523246] pci 0000:00:1c.0: [8086:a0b8] type 01 class 0x060400
[    0.523344] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.523371] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity
[    0.524304] pci 0000:00:1d.0: [8086:a0b3] type 01 class 0x060400
[    0.524403] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.524433] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    0.525404] pci 0000:00:1e.0: [8086:a0a8] type 00 class 0x078000
[    0.525433] pci 0000:00:1e.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.526472] pci 0000:00:1f.0: [8086:a082] type 00 class 0x060100
[    0.527455] pci 0000:00:1f.3: [8086:a0c8] type 00 class 0x040100
[    0.527497] pci 0000:00:1f.3: reg 0x10: [mem 0x603d1d8000-0x603d1dbfff 64bit]
[    0.527551] pci 0000:00:1f.3: reg 0x20: [mem 0x603d000000-0x603d0fffff 64bit]
[    0.527660] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.528571] pci 0000:00:1f.4: [8086:a0a3] type 00 class 0x0c0500
[    0.528593] pci 0000:00:1f.4: reg 0x10: [mem 0x603d1e0000-0x603d1e00ff 64bit]
[    0.528615] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.529501] pci 0000:00:1f.5: [8086:a0a4] type 00 class 0x0c8000
[    0.529519] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    0.530759] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
[    0.530774] pci 0000:01:00.0: reg 0x10: [mem 0x8c400000-0x8c403fff 64bit]
[    0.530951] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.530953] pci 0000:00:06.0:   bridge window [mem 0x8c400000-0x8c4fffff]
[    0.530985] pci 0000:00:07.0: PCI bridge to [bus 02-2b]
[    0.530988] pci 0000:00:07.0:   bridge window [mem 0x80000000-0x8c1fffff]
[    0.530992] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[    0.531021] pci 0000:00:07.2: PCI bridge to [bus 2c-55]
[    0.531025] pci 0000:00:07.2:   bridge window [mem 0x72000000-0x7e1fffff]
[    0.531028] pci 0000:00:07.2:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[    0.531101] pci 0000:56:00.0: [17cb:1101] type 00 class 0x028000
[    0.531124] pci 0000:56:00.0: reg 0x10: [mem 0x8c300000-0x8c3fffff 64bit]
[    0.531262] pci 0000:56:00.0: PME# supported from D0 D3hot D3cold
[    0.531334] pci 0000:56:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0000:00:1c.0 (capable of 7.876 Gb/s with 8.0 GT/s PCIe x1 link)
[    0.531418] pci 0000:00:1c.0: PCI bridge to [bus 56]
[    0.531422] pci 0000:00:1c.0:   bridge window [mem 0x8c300000-0x8c3fffff]
[    0.531487] pci 0000:57:00.0: [10ec:5260] type 00 class 0xff0000
[    0.531503] pci 0000:57:00.0: reg 0x10: [mem 0x8c200000-0x8c200fff]
[    0.531637] pci 0000:57:00.0: supports D1 D2
[    0.531638] pci 0000:57:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.531773] pci 0000:00:1d.0: PCI bridge to [bus 57]
[    0.531778] pci 0000:00:1d.0:   bridge window [mem 0x8c200000-0x8c2fffff]
[    0.551101] ACPI: EC: interrupt unblocked
[    0.551102] ACPI: EC: event unblocked
[    0.551109] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    0.551109] ACPI: EC: GPE=0x6e
[    0.551110] ACPI: \_SB_.PC00.LPCB.ECDV: Boot DSDT EC initialization complete
[    0.551111] ACPI: \_SB_.PC00.LPCB.ECDV: EC: Used to handle transactions and events
[    0.551191] iommu: Default domain type: Translated 
[    0.551191] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.551191] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.551191] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.551191] vgaarb: loaded
[    0.551191] SCSI subsystem initialized
[    0.551191] libata version 3.00 loaded.
[    0.551191] ACPI: bus type USB registered
[    0.551191] usbcore: registered new interface driver usbfs
[    0.551191] usbcore: registered new interface driver hub
[    0.551191] usbcore: registered new device driver usb
[    0.551191] pps_core: LinuxPPS API ver. 1 registered
[    0.551191] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.551191] PTP clock support registered
[    0.551191] EDAC MC: Ver: 3.0.0
[    0.552083] Registered efivars operations
[    0.552083] NetLabel: Initializing
[    0.552083] NetLabel:  domain hash size = 128
[    0.552083] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.552083] NetLabel:  unlabeled traffic allowed by default
[    0.552083] PCI: Using ACPI for IRQ routing
[    0.569343] PCI: pci_cache_line_size set to 64 bytes
[    0.569832] pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010fff]: no compatible bridge window
[    0.570262] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.570263] e820: reserve RAM buffer [mem 0x5ad50000-0x5bffffff]
[    0.570264] e820: reserve RAM buffer [mem 0x5f72b000-0x5fffffff]
[    0.570264] e820: reserve RAM buffer [mem 0x88f800000-0x88fffffff]
[    0.570268] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.570268] hpet0: 8 comparators, 64-bit 19.200000 MHz counter
[    0.573693] clocksource: Switched to clocksource tsc-early
[    0.577600] VFS: Disk quotas dquot_6.6.0
[    0.577600] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.577600] AppArmor: AppArmor Filesystem Enabled
[    0.577600] pnp: PnP ACPI init
[    0.577600] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.577600] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.577600] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.577600] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.577600] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.577600] system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.577600] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.577600] pnp 00:04: Plug and Play ACPI device, IDs DLL0991 PNP0f13 (active)
[    0.580221] pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.580237] system 00:05: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.580237] system 00:05: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.580238] system 00:05: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.580239] system 00:05: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    0.580239] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.580240] system 00:05: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.580241] system 00:05: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.580242] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.580998] system 00:06: [io  0x1800-0x18fe] could not be reserved
[    0.580998] system 00:06: [mem 0xfe000000-0xfe01ffff] has been reserved
[    0.580999] system 00:06: [mem 0xfe04c000-0xfe04ffff] has been reserved
[    0.580999] system 00:06: [mem 0xfe050000-0xfe0affff] has been reserved
[    0.581000] system 00:06: [mem 0xfe0d0000-0xfe0fffff] has been reserved
[    0.581001] system 00:06: [mem 0xfe200000-0xfe7fffff] has been reserved
[    0.581001] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    0.581002] system 00:06: [mem 0xfd000000-0xfd68ffff] has been reserved
[    0.581003] system 00:06: [mem 0xfd6b0000-0xfd6cffff] has been reserved
[    0.581003] system 00:06: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    0.581005] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.581242] system 00:07: [io  0x2000-0x20fe] has been reserved
[    0.581244] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.581409] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.584240] pnp: PnP ACPI: found 9 devices
[    0.589442] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.589474] NET: Registered protocol family 2
[    0.589601] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.589772] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.589991] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.590033] TCP: Hash tables configured (established 262144 bind 65536)
[    0.590140] MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
[    0.590229] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.590292] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.590344] NET: Registered protocol family 1
[    0.590348] NET: Registered protocol family 44
[    0.590351] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
[    0.590359] pci 0000:00:02.0: BAR 9: assigned [mem 0x4020000000-0x40ffffffff 64bit pref]
[    0.590361] pci 0000:00:02.0: BAR 7: assigned [mem 0x4010000000-0x4016ffffff 64bit]
[    0.590363] pci 0000:00:07.0: BAR 13: assigned [io  0x4000-0x4fff]
[    0.590363] pci 0000:00:07.2: BAR 13: assigned [io  0x5000-0x5fff]
[    0.590364] pci 0000:00:15.0: BAR 0: assigned [mem 0x4017000000-0x4017000fff 64bit]
[    0.590426] pci 0000:00:15.1: BAR 0: assigned [mem 0x4017001000-0x4017001fff 64bit]
[    0.590441] pci 0000:00:19.0: BAR 0: assigned [mem 0x4017002000-0x4017002fff 64bit]
[    0.590456] pci 0000:00:19.1: BAR 0: assigned [mem 0x4017003000-0x4017003fff 64bit]
[    0.590516] pci 0000:00:1e.0: BAR 0: assigned [mem 0x4017004000-0x4017004fff 64bit]
[    0.590530] pci 0000:00:1f.5: BAR 0: assigned [mem 0x70800000-0x70800fff]
[    0.590541] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.590549] pci 0000:00:06.0:   bridge window [mem 0x8c400000-0x8c4fffff]
[    0.590558] pci 0000:00:07.0: PCI bridge to [bus 02-2b]
[    0.590559] pci 0000:00:07.0:   bridge window [io  0x4000-0x4fff]
[    0.590561] pci 0000:00:07.0:   bridge window [mem 0x80000000-0x8c1fffff]
[    0.590563] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[    0.590567] pci 0000:00:07.2: PCI bridge to [bus 2c-55]
[    0.590568] pci 0000:00:07.2:   bridge window [io  0x5000-0x5fff]
[    0.590571] pci 0000:00:07.2:   bridge window [mem 0x72000000-0x7e1fffff]
[    0.590573] pci 0000:00:07.2:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[    0.590576] pci 0000:00:1c.0: PCI bridge to [bus 56]
[    0.590581] pci 0000:00:1c.0:   bridge window [mem 0x8c300000-0x8c3fffff]
[    0.590587] pci 0000:00:1d.0: PCI bridge to [bus 57]
[    0.590590] pci 0000:00:1d.0:   bridge window [mem 0x8c200000-0x8c2fffff]
[    0.590597] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.590598] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.590598] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.590599] pci_bus 0000:00: resource 7 [mem 0x70800000-0xbfffffff window]
[    0.590599] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
[    0.590600] pci_bus 0000:01: resource 1 [mem 0x8c400000-0x8c4fffff]
[    0.590600] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[    0.590601] pci_bus 0000:02: resource 1 [mem 0x80000000-0x8c1fffff]
[    0.590601] pci_bus 0000:02: resource 2 [mem 0x6000000000-0x601bffffff 64bit pref]
[    0.590602] pci_bus 0000:2c: resource 0 [io  0x5000-0x5fff]
[    0.590602] pci_bus 0000:2c: resource 1 [mem 0x72000000-0x7e1fffff]
[    0.590603] pci_bus 0000:2c: resource 2 [mem 0x6020000000-0x603bffffff 64bit pref]
[    0.590604] pci_bus 0000:56: resource 1 [mem 0x8c300000-0x8c3fffff]
[    0.590604] pci_bus 0000:57: resource 1 [mem 0x8c200000-0x8c2fffff]
[    0.590729] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.591483] PCI: CLS 0 bytes, default 64
[    0.591508] Trying to unpack rootfs image as initramfs...
[    0.703713] Freeing initrd memory: 87124K
[    0.703747] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.703748] software IO TLB: mapped [mem 0x0000000051a9c000-0x0000000055a9c000] (64MB)
[    0.703828] resource sanity check: requesting [mem 0xfedc0000-0xfedcdfff], which spans more than pnp 00:05 [mem 0xfedc0000-0xfedc7fff]
[    0.703834] caller tgl_uncore_imc_freerunning_init_box+0xb9/0x100 mapping multiple BARs
[    0.703950] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28680fa287f, max_idle_ns: 440795281151 ns
[    0.703968] clocksource: Switched to clocksource tsc
[    0.704132] check: Scanning for low memory corruption every 60 seconds
[    0.704472] Initialise system trusted keyrings
[    0.704482] Key type blacklist registered
[    0.704526] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.705035] zbud: loaded
[    0.705162] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.705279] fuse: init (API version 7.32)
[    0.705380] integrity: Platform Keyring initialized
[    0.712145] Key type asymmetric registered
[    0.712146] Asymmetric key parser 'x509' registered
[    0.712151] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
[    0.712208] io scheduler mq-deadline registered
[    0.712686] pcieport 0000:00:06.0: PME: Signaling with IRQ 120
[    0.712866] pcieport 0000:00:07.0: PME: Signaling with IRQ 121
[    0.712880] pcieport 0000:00:07.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.713081] pcieport 0000:00:07.2: PME: Signaling with IRQ 122
[    0.713094] pcieport 0000:00:07.2: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.713293] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[    0.713472] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    0.713548] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.713591] efifb: probing for efifb
[    0.713606] efifb: Ignoring BGRT: unexpected or invalid BMP data
[    0.713606] efifb: framebuffer at 0x4000000000, using 9000k, total 9000k
[    0.713607] efifb: mode is 1920x1200x32, linelength=7680, pages=1
[    0.713607] efifb: scrolling: redraw
[    0.713608] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.713661] Console: switching to colour frame buffer device 240x75
[    0.718244] fb0: EFI VGA frame buffer device
[    0.718248] intel_idle: MWAIT substates: 0x11121020
[    0.718434] Monitor-Mwait will be used to enter C-1 state
[    0.718438] Monitor-Mwait will be used to enter C-2 state
[    0.718442] Monitor-Mwait will be used to enter C-3 state
[    0.718446] ACPI: \_SB_.PR00: Found 3 idle states
[    0.718447] intel_idle: v0.5.1 model 0x8C
[    0.718604] intel_idle: Local APIC timer is reliable in all C-states
[    0.719431] ACPI: AC Adapter [AC] (on-line)
[    0.719472] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.719491] ACPI: Lid Switch [LID0]
[    0.719502] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.719511] ACPI: Power Button [PBTN]
[    0.719521] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    0.719527] ACPI: Sleep Button [SBTN]
[    0.721227] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.723887] serial 0000:00:12.0: enabling device (0000 -> 0002)
[    0.725134] Linux agpgart interface v0.103
[    0.727158] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)
[    0.743119] loop: module loaded
[    0.743419] libphy: Fixed MDIO Bus: probed
[    0.743419] tun: Universal TUN/TAP device driver, 1.6
[    0.743573] PPP generic driver version 2.4.2
[    0.743602] VFIO - User Level meta-driver version: 0.3
[    0.743757] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.743758] ehci-pci: EHCI PCI platform driver
[    0.743763] ehci-platform: EHCI generic platform driver
[    0.743769] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.743771] ohci-pci: OHCI PCI platform driver
[    0.743774] ohci-platform: OHCI generic platform driver
[    0.743777] uhci_hcd: USB Universal Host Controller Interface driver
[    0.743802] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.744554] i8042: Warning: Keylock active
[    0.747730] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.747731] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.748036] mousedev: PS/2 mouse device common for all mice
[    0.748081] battery: ACPI: Battery Slot [BAT0] (battery present)
[    0.748273] rtc_cmos 00:01: RTC can wake from S4
[    0.748918] rtc_cmos 00:01: registered as rtc0
[    0.749095] rtc_cmos 00:01: setting system clock to 2020-11-04T12:34:09 UTC (1604493249)
[    0.749138] rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes nvram
[    0.749140] i2c /dev entries driver
[    0.749162] device-mapper: uevent: version 1.0.3
[    0.749205] device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
[    0.749213] platform eisa.0: Probing EISA bus 0
[    0.749214] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.749214] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.749215] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.749215] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.749216] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.749216] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.749217] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.749217] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.749218] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.749218] platform eisa.0: EISA: Detected 0 cards
[    0.749220] intel_pstate: Intel P-state driver initializing
[    0.749796] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    0.749947] intel_pstate: HWP enabled
[    0.749976] ledtrig-cpu: registered to indicate activity on CPUs
[    0.749979] EFI Variables Facility v0.08 2004-May-17
[    0.751929] intel_pmc_core INT33A1:00:  initialized
[    0.751999] drop_monitor: Initializing network drop monitor service
[    0.752119] NET: Registered protocol family 10
[    0.755856] Segment Routing with IPv6
[    0.755876] NET: Registered protocol family 17
[    0.755967] Key type dns_resolver registered
[    0.756563] microcode: sig=0x806c1, pf=0x80, revision=0x60
[    0.756637] microcode: Microcode Update Driver: v2.2.
[    0.756773] resctrl: L2 allocation detected
[    0.756773] resctrl: L2DATA allocation detected
[    0.756773] resctrl: L2CODE allocation detected
[    0.756776] IPI shorthand broadcast: enabled
[    0.756781] sched_clock: Marking stable (756324155, 441923)->(763657306, -6891228)
[    0.756833] registered taskstats version 1
[    0.756839] Loading compiled-in X.509 certificates
[    0.757313] Loaded X.509 cert 'Build time autogenerated kernel key: e7023dac6afd3a5685011f478d7c4ec5045876be'
[    0.757336] zswap: loaded using pool lzo/zbud
[    0.757430] Key type ._fscrypt registered
[    0.757430] Key type .fscrypt registered
[    0.757431] Key type fscrypt-provisioning registered
[    0.757459] Key type trusted registered
[    0.758920] Key type encrypted registered
[    0.758922] AppArmor: AppArmor sha1 policy hashing enabled
[    0.759013] integrity: Loading X.509 certificate: UEFI:db
[    0.759028] integrity: Loaded X.509 cert 'Dell Inc.: Dell Bios DB Key: 637fa7a9f74471b406de0511557071fd41dd5487'
[    0.759028] integrity: Loading X.509 certificate: UEFI:db
[    0.759036] integrity: Loaded X.509 cert 'Dell Inc.: Dell Bios FW Aux Authority 2018: dd4df7c3f5ce7e5a77847915abc37b031f6b10bd'
[    0.759037] integrity: Loading X.509 certificate: UEFI:db
[    0.759047] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.759048] integrity: Loading X.509 certificate: UEFI:db
[    0.759061] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.759739] integrity: Loading X.509 certificate: UEFI:MokListRT
[    0.759748] integrity: Loaded X.509 cert 'SomeOrg: shim: a01ee84e9b37ace407961cc468c5909447878469'
[    0.759748] integrity: Loading X.509 certificate: UEFI:MokListRT
[    0.759980] integrity: Loaded X.509 cert 'Canonical Ltd. Master Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    0.759986] ima: Allocated hash algorithm: sha1
[    0.775791] ima: No architecture policies found
[    0.775797] evm: Initialising EVM extended attributes:
[    0.775798] evm: security.selinux
[    0.775798] evm: security.SMACK64
[    0.775798] evm: security.SMACK64EXEC
[    0.775799] evm: security.SMACK64TRANSMUTE
[    0.775799] evm: security.SMACK64MMAP
[    0.775799] evm: security.apparmor
[    0.775799] evm: security.ima
[    0.775800] evm: security.capability
[    0.775800] evm: HMAC attrs: 0x1
[    0.777852] PM:   Magic number: 12:631:581
[    0.777883] pci_bus 0000:02: hash matches
[    0.778146] RAS: Correctable Errors collector initialized.
[    0.784040] Freeing unused decrypted memory: 2036K
[    0.784362] Freeing unused kernel image (initmem) memory: 2636K
[    0.819802] Write protecting the kernel read-only data: 22528k
[    0.820621] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    0.820894] Freeing unused kernel image (rodata/data gap) memory: 932K
[    0.837568] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.837575] Run /init as init process
[    0.837577]   with arguments:
[    0.837578]     /init
[    0.837578]     splash
[    0.837579]   with environment:
[    0.837580]     HOME=/
[    0.837580]     TERM=linux
[    0.837581]     BOOT_IMAGE=/vmlinuz-5.10.0-rc1-wt-ath+
[    0.898169] hid: raw HID events driver (C) Jiri Kosina
[    0.900997] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.901029] wmi_bus wmi_bus-PNP0C14:02: WQBC data block query control method not found
[    0.901030] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.903428] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.904733] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    0.904738] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
[    0.905179] acpi PNP0C14:04: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.905226] acpi PNP0C14:05: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.905271] acpi PNP0C14:06: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.905836] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    0.905840] xhci_hcd 0000:00:0d.0: cache line size of 64 is not supported
[    0.905963] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
[    0.905964] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.905965] usb usb1: Product: xHCI Host Controller
[    0.905966] usb usb1: Manufacturer: Linux 5.10.0-rc1-wt-ath+ xhci-hcd
[    0.905966] usb usb1: SerialNumber: 0000:00:0d.0
[    0.906028] hub 1-0:1.0: USB hub found
[    0.906032] hub 1-0:1.0: 1 port detected
[    0.906149] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    0.906151] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
[    0.906152] xhci_hcd 0000:00:0d.0: Host supports USB 3.1 Enhanced SuperSpeed
[    0.906195] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.10
[    0.906196] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.906197] usb usb2: Product: xHCI Host Controller
[    0.906197] usb usb2: Manufacturer: Linux 5.10.0-rc1-wt-ath+ xhci-hcd
[    0.906197] usb usb2: SerialNumber: 0000:00:0d.0
[    0.906236] hub 2-0:1.0: USB hub found
[    0.906244] hub 2-0:1.0: 4 ports detected
[    0.906669] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.906674] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    0.907698] nvme nvme0: pci function 0000:01:00.0
[    0.907764] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000000009810
[    0.908014] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.908166] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
[    0.908167] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.908168] usb usb3: Product: xHCI Host Controller
[    0.908168] usb usb3: Manufacturer: Linux 5.10.0-rc1-wt-ath+ xhci-hcd
[    0.908169] usb usb3: SerialNumber: 0000:00:14.0
[    0.908217] hub 3-0:1.0: USB hub found
[    0.908234] hub 3-0:1.0: 12 ports detected
[    0.908985] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.908987] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[    0.908989] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[    0.909015] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.10
[    0.909015] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.909017] usb usb4: Product: xHCI Host Controller
[    0.909018] usb usb4: Manufacturer: Linux 5.10.0-rc1-wt-ath+ xhci-hcd
[    0.909018] usb usb4: SerialNumber: 0000:00:14.0
[    0.909086] hub 4-0:1.0: USB hub found
[    0.909099] hub 4-0:1.0: 4 ports detected
[    0.909207] usb: port power management may be unreliable
[    0.910841] rtsx_pci 0000:57:00.0: enabling device (0000 -> 0002)
[    0.911267] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    0.911391] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    0.911447] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    0.913858] nvme nvme0: missing or invalid SUBNQN field.
[    0.913880] nvme nvme0: Shutdown timeout set to 8 seconds
[    0.916691] cryptd: max_cpu_qlen set to 1000
[    0.920917] AVX2 version of gcm_enc/dec engaged.
[    0.920918] AES CTR mode by8 optimization enabled
[    0.926033] nvme nvme0: 8/0/0 default/read/poll queues
[    0.926669] i2c i2c-0: 8/8 memory slots populated (from DMI)
[    0.926671] i2c i2c-0: Systems with more than 4 memory slots not supported yet, not instantiating SPD
[    0.929250]  nvme0n1: p1 p2 p3 p4 p5
[    0.931675] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
[    0.931907] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    0.966773] checking generic (4000000000 8ca000) vs hw (603c000000 1000000)
[    0.966774] checking generic (4000000000 8ca000) vs hw (4000000000 10000000)
[    0.966775] fb0: switching to inteldrmfb from EFI VGA
[    0.966831] Console: switching to colour dummy device 80x25
[    0.966857] i915 0000:00:02.0: vgaarb: deactivate vga console
[    0.967670] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
[    0.968105] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    0.968223] i915 0000:00:02.0: [drm] Couldn't get system memory bandwidth
[    0.968815] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    0.969306] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/tgl_dmc_ver2_08.bin (v2.8)
[    0.978728] i2c_hid i2c-DLL0945:00: supply vdd not found, using dummy regulator
[    0.978745] i2c_hid i2c-DLL0945:00: supply vddl not found, using dummy regulator
[    1.003659] intel-lpss 0000:00:19.0: enabling device (0000 -> 0002)
[    1.003864] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    1.012376] [drm] Initialized i915 1.6.0 20200917 for 0000:00:02.0 on minor 0
[    1.014910] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    1.016829] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input6
[    1.018613] fbcon: i915drmfb (fb0) is primary device
[    1.035670] intel-lpss 0000:00:19.1: enabling device (0000 -> 0002)
[    1.035966] idma64 idma64.3: Found Intel integrated DMA 64-bit
[    1.067739] intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
[    1.068569] idma64 idma64.4: Found Intel integrated DMA 64-bit
[    1.156096] input: DLL0945:00 06CB:CDE6 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-11/i2c-DLL0945:00/0018:06CB:CDE6.0001/input/input7
[    1.156174] input: DLL0945:00 06CB:CDE6 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-11/i2c-DLL0945:00/0018:06CB:CDE6.0001/input/input8
[    1.156235] hid-generic 0018:06CB:CDE6.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL0945:00 06CB:CDE6] on i2c-DLL0945:00
[    1.319669] usb 3-4: new high-speed USB device number 2 using xhci_hcd
[    1.540621] usb 3-4: New USB device found, idVendor=0bda, idProduct=c820, bcdDevice= 2.00
[    1.540624] usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.540625] usb 3-4: Product: 802.11ac NIC
[    1.540627] usb 3-4: Manufacturer: Realtek
[    1.540628] usb 3-4: SerialNumber: 123456
[    1.577639] ish-hid {33AECD58-B679-4E54-9BD9-A04D34F0C226}: [hid-ish]: enum_devices_done OK, num_hid_devices=1
[    1.579308] hid-generic 001F:8087:0AC2.0002: hidraw1: <UNKNOWN> HID v2.00 Device [hid-ishtp 8087:0AC2] on 
[    1.675685] usb 3-6: new high-speed USB device number 3 using xhci_hcd
[    1.826107] usb 3-6: New USB device found, idVendor=0bda, idProduct=5517, bcdDevice= 4.21
[    1.826111] usb 3-6: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    1.826113] usb 3-6: Product: Integrated_Webcam_HD
[    1.826114] usb 3-6: Manufacturer: Integrated_Webcam_HD
[    1.826115] usb 3-6: SerialNumber: 200901010001
[    2.143937] Console: switching to colour frame buffer device 240x75
[    2.167063] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    7.027376] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
[    7.151724] systemd[1]: Inserted module 'autofs4'
[    7.164490] systemd[1]: systemd 246.6-1ubuntu1 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    7.187995] systemd[1]: Detected architecture x86-64.
[    7.247914] systemd[1]: Set hostname to <tk-9310>.
[    7.308624] systemd[1]: /lib/systemd/system/dbus.service:12: Unit configured to use KillMode=none. This is unsafe, as it disables systemd's process lifecycle management for the service. Please update your service to use a safer KillMode=, such as 'mixed' or 'control-group'. Support for KillMode=none is deprecated and will eventually be removed.
[    7.325537] systemd[1]: /lib/systemd/system/plymouth-start.service:17: Unit configured to use KillMode=none. This is unsafe, as it disables systemd's process lifecycle management for the service. Please update your service to use a safer KillMode=, such as 'mixed' or 'control-group'. Support for KillMode=none is deprecated and will eventually be removed.
[    7.347103] systemd[1]: Queued start job for default target Graphical Interface.
[    7.347885] systemd[1]: Created slice system-modprobe.slice.
[    7.347993] systemd[1]: Created slice system-postgresql.slice.
[    7.348075] systemd[1]: Created slice Cryptsetup Units Slice.
[    7.348182] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    7.348259] systemd[1]: Created slice User and Session Slice.
[    7.348284] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    7.348369] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    7.348400] systemd[1]: Reached target Remote File Systems.
[    7.348405] systemd[1]: Reached target Slices.
[    7.348442] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.348475] systemd[1]: Listening on LVM2 poll daemon socket.
[    7.348512] systemd[1]: Listening on Syslog Socket.
[    7.348550] systemd[1]: Listening on fsck to fsckd communication Socket.
[    7.348564] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    7.348925] systemd[1]: Listening on Journal Audit Socket.
[    7.348975] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.349014] systemd[1]: Listening on Journal Socket.
[    7.349064] systemd[1]: Listening on udev Control Socket.
[    7.349093] systemd[1]: Listening on udev Kernel Socket.
[    7.349438] systemd[1]: Mounting Huge Pages File System...
[    7.349824] systemd[1]: Mounting POSIX Message Queue File System...
[    7.350306] systemd[1]: Mounting Kernel Debug File System...
[    7.350701] systemd[1]: Mounting Kernel Trace File System...
[    7.351386] systemd[1]: Starting Journal Service...
[    7.351803] systemd[1]: Starting Availability of block devices...
[    7.352357] systemd[1]: Starting Set the console keyboard layout...
[    7.352795] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    7.353151] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    7.353168] systemd[1]: Condition check resulted in Load Kernel Module drm being skipped.
[    7.353503] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[    7.353539] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[    7.354338] systemd[1]: Starting Load Kernel Modules...
[    7.354887] systemd[1]: Starting Remount Root and Kernel File Systems...
[    7.355433] systemd[1]: Starting Coldplug All udev Devices...
[    7.356014] systemd[1]: Starting Uncomplicated firewall...
[    7.357078] systemd[1]: Mounted Huge Pages File System.
[    7.357170] systemd[1]: Mounted POSIX Message Queue File System.
[    7.357248] systemd[1]: Mounted Kernel Debug File System.
[    7.357328] systemd[1]: Mounted Kernel Trace File System.
[    7.357623] systemd[1]: Finished Availability of block devices.
[    7.357965] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    7.358251] systemd[1]: Finished Uncomplicated firewall.
[    7.361666] EXT4-fs (dm-2): re-mounted. Opts: errors=remount-ro
[    7.362351] lp: driver loaded but no devices found
[    7.362395] systemd[1]: Finished Remount Root and Kernel File Systems.
[    7.363091] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    7.363123] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[    7.363697] systemd[1]: Starting Load/Save Random Seed...
[    7.364136] ppdev: user-space parallel port driver
[    7.364284] systemd[1]: Starting Create System Users...
[    7.366769] systemd[1]: Finished Load Kernel Modules.
[    7.367528] systemd[1]: Mounting FUSE Control File System...
[    7.368206] systemd[1]: Mounting Kernel Configuration File System...
[    7.368794] systemd[1]: Starting Apply Kernel Variables...
[    7.369621] systemd[1]: Mounted FUSE Control File System.
[    7.369705] systemd[1]: Mounted Kernel Configuration File System.
[    7.372915] systemd[1]: Finished Create System Users.
[    7.373549] systemd[1]: Starting Create Static Device Nodes in /dev...
[    7.375964] systemd[1]: Finished Load/Save Random Seed.
[    7.378178] systemd[1]: Finished Apply Kernel Variables.
[    7.380695] systemd[1]: Finished Create Static Device Nodes in /dev.
[    7.381628] systemd[1]: Starting Rule-based Manager for Device Events and Files...
[    7.386758] systemd[1]: Finished Set the console keyboard layout.
[    7.398485] systemd[1]: Started Journal Service.
[    7.479923] input: Intel HID events as /devices/platform/INTC1051:00/input/input10
[    7.480078] intel-hid INTC1051:00: platform supports 5 button array
[    7.480128] input: Intel HID 5 button array as /devices/platform/INTC1051:00/input/input11
[    7.501054] ACPI BIOS Error (bug): Could not resolve symbol [\S1CC], AE_NOT_FOUND (20200925/psargs-330)
[    7.501063] No Local Variables are initialized for Method [_CRT]
[    7.501065] No Arguments are initialized for method [_CRT]

[    7.501067] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TMEM._CRT due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.501088] ACPI BIOS Error (bug): Could not resolve symbol [\S1HP], AE_NOT_FOUND (20200925/psargs-330)
[    7.501091] No Local Variables are initialized for Method [_HOT]
[    7.501093] No Arguments are initialized for method [_HOT]

[    7.501094] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TMEM._HOT due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.501113] ACPI BIOS Error (bug): Could not resolve symbol [\S1PV], AE_NOT_FOUND (20200925/psargs-330)
[    7.501117] No Local Variables are initialized for Method [_PSV]
[    7.501118] No Arguments are initialized for method [_PSV]

[    7.501120] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TMEM._PSV due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.501137] ACPI BIOS Error (bug): Could not resolve symbol [\S1AC], AE_NOT_FOUND (20200925/psargs-330)
[    7.501140] No Local Variables are initialized for Method [_AC0]
[    7.501141] No Arguments are initialized for method [_AC0]

[    7.501143] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TMEM._AC0 due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.505599] ACPI BIOS Error (bug): Could not resolve symbol [\S2CC], AE_NOT_FOUND (20200925/psargs-330)
[    7.505608] No Local Variables are initialized for Method [_CRT]
[    7.505610] No Arguments are initialized for method [_CRT]

[    7.505612] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TSKN._CRT due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.505632] ACPI BIOS Error (bug): Could not resolve symbol [\S2HP], AE_NOT_FOUND (20200925/psargs-330)
[    7.505636] No Local Variables are initialized for Method [_HOT]
[    7.505637] No Arguments are initialized for method [_HOT]

[    7.505639] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TSKN._HOT due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.505657] ACPI BIOS Error (bug): Could not resolve symbol [\S2PV], AE_NOT_FOUND (20200925/psargs-330)
[    7.505661] No Local Variables are initialized for Method [_PSV]
[    7.505662] No Arguments are initialized for method [_PSV]

[    7.505664] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TSKN._PSV due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.508786] ACPI BIOS Error (bug): Could not resolve symbol [\S3CC], AE_NOT_FOUND (20200925/psargs-330)
[    7.508793] No Local Variables are initialized for Method [_CRT]
[    7.508794] No Arguments are initialized for method [_CRT]

[    7.508796] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TVR._CRT due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.508814] ACPI BIOS Error (bug): Could not resolve symbol [\S3HP], AE_NOT_FOUND (20200925/psargs-330)
[    7.508818] No Local Variables are initialized for Method [_HOT]
[    7.508819] No Arguments are initialized for method [_HOT]

[    7.508821] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TVR._HOT due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.508838] ACPI BIOS Error (bug): Could not resolve symbol [\S3PV], AE_NOT_FOUND (20200925/psargs-330)
[    7.508842] No Local Variables are initialized for Method [_PSV]
[    7.508843] No Arguments are initialized for method [_PSV]

[    7.508845] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TVR._PSV due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.511930] ACPI BIOS Error (bug): Could not resolve symbol [\S4CC], AE_NOT_FOUND (20200925/psargs-330)
[    7.511936] No Local Variables are initialized for Method [_CRT]
[    7.511938] No Arguments are initialized for method [_CRT]

[    7.511940] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TAMB._CRT due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.511959] ACPI BIOS Error (bug): Could not resolve symbol [\S4HP], AE_NOT_FOUND (20200925/psargs-330)
[    7.511963] No Local Variables are initialized for Method [_HOT]
[    7.511964] No Arguments are initialized for method [_HOT]

[    7.511966] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TAMB._HOT due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.511984] ACPI BIOS Error (bug): Could not resolve symbol [\S4PV], AE_NOT_FOUND (20200925/psargs-330)
[    7.511987] No Local Variables are initialized for Method [_PSV]
[    7.511989] No Arguments are initialized for method [_PSV]

[    7.511991] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TAMB._PSV due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.512008] ACPI BIOS Error (bug): Could not resolve symbol [\S4AC], AE_NOT_FOUND (20200925/psargs-330)
[    7.512012] No Local Variables are initialized for Method [_AC0]
[    7.512013] No Arguments are initialized for method [_AC0]

[    7.512015] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.TAMB._AC0 due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.518544] ACPI BIOS Error (bug): Could not resolve symbol [\S5CC], AE_NOT_FOUND (20200925/psargs-330)
[    7.518552] No Local Variables are initialized for Method [_CRT]
[    7.518554] No Arguments are initialized for method [_CRT]

[    7.518556] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.THP._CRT due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.518575] ACPI BIOS Error (bug): Could not resolve symbol [\S5HP], AE_NOT_FOUND (20200925/psargs-330)
[    7.518579] No Local Variables are initialized for Method [_HOT]
[    7.518580] No Arguments are initialized for method [_HOT]

[    7.518582] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.THP._HOT due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.518601] ACPI BIOS Error (bug): Could not resolve symbol [\S5PV], AE_NOT_FOUND (20200925/psargs-330)
[    7.518604] No Local Variables are initialized for Method [_PSV]
[    7.518605] No Arguments are initialized for method [_PSV]

[    7.518607] ACPI Error: Aborting method \_SB.PC00.LPCB.ECDV.THP._PSV due to previous error (AE_NOT_FOUND) (20200925/psparse-529)
[    7.540608] Bluetooth: Core ver 2.22
[    7.540620] NET: Registered protocol family 31
[    7.540621] Bluetooth: HCI device and connection manager initialized
[    7.540624] Bluetooth: HCI socket layer initialized
[    7.540625] Bluetooth: L2CAP socket layer initialized
[    7.540628] Bluetooth: SCO socket layer initialized
[    7.545705] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
[    7.551854] intel_rapl_common: Found RAPL domain package
[    7.552645] proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THERMAL_PCI
[    7.580866] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    7.582762] Bluetooth: HCI UART driver ver 2.3
[    7.582764] Bluetooth: HCI UART protocol H4 registered
[    7.582765] Bluetooth: HCI UART protocol BCSP registered
[    7.582770] Bluetooth: HCI UART protocol LL registered
[    7.582771] Bluetooth: HCI UART protocol ATH3K registered
[    7.582775] Bluetooth: HCI UART protocol Three-wire (H5) registered
[    7.582812] Bluetooth: HCI UART protocol Intel registered
[    7.582841] Bluetooth: HCI UART protocol Broadcom registered
[    7.582847] Bluetooth: HCI UART protocol QCA registered
[    7.582847] Bluetooth: HCI UART protocol AG6XX registered
[    7.582852] Bluetooth: HCI UART protocol Marvell registered
[    7.588409] pstore: Using crash dump compression: deflate
[    7.588419] pstore: Registered efi as persistent store backend
[    7.595679] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    7.595830] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    7.604193] dw-apb-uart.4: ttyS4 at MMIO 0x4017004000 (irq = 16, base_baud = 6250000) is a 16550A
[    7.604441] input: Dell WMI hotkeys as /devices/platform/PNP0C14:02/wmi_bus/wmi_bus-PNP0C14:02/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input12
[    7.605755] hci_uart_qca serial0-0: failed to acquire enable gpio
[    7.609742] serial serial0: tty port ttyS4 registered
[    7.610656] Bluetooth: hci0: setting up ROME/QCA6390
[    7.617755] Bluetooth: hci0: Frame reassembly failed (-84)
[    7.698575] EXT4-fs (nvme0n1p4): mounted filesystem with ordered data mode. Opts: (null)
[    7.712164] ath11k_pci 0000:56:00.0: WARNING: ath11k PCI support is experimental!
[    7.720933] ath11k_pci 0000:56:00.0: BAR 0: assigned [mem 0x8c300000-0x8c3fffff 64bit]
[    7.720952] ath11k_pci 0000:56:00.0: enabling device (0000 -> 0002)
[    7.721000] ath11k_pci 0000:56:00.0: failed to get 32 MSI vectors, only -28 available
[    7.721003] ath11k_pci 0000:56:00.0: failed to enable msi: -28
[    7.721021] ath11k_pci: probe of 0000:56:00.0 failed with error -28
[    7.729699] input: DLL0945:00 06CB:CDE6 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-11/i2c-DLL0945:00/0018:06CB:CDE6.0001/input/input13
[    7.729776] input: DLL0945:00 06CB:CDE6 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-11/i2c-DLL0945:00/0018:06CB:CDE6.0001/input/input14
[    7.729850] hid-multitouch 0018:06CB:CDE6.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL0945:00 06CB:CDE6] on i2c-DLL0945:00
[    7.761465] intel_rapl_msr: PL4 support detected.
[    7.761491] intel_rapl_common: Found RAPL domain package
[    7.761493] intel_rapl_common: Found RAPL domain core
[    7.761494] intel_rapl_common: Found RAPL domain uncore
[    7.761496] intel_rapl_common: Found RAPL domain psys
[    7.764115] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040100
[    7.764119] snd_hda_intel 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
[    7.800477] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
[    7.811669] Adding 33554428k swap on /dev/mapper/ubuntu--vg-swap_1.  Priority:-2 extents:1 across:33554428k SSFS
[    7.817952] sof-audio-pci 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040100
[    7.817955] sof-audio-pci 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
[    7.817967] sof-audio-pci 0000:00:1f.3: enabling device (0000 -> 0002)
[    7.818679] sof-audio-pci 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040100
[    7.818789] sof-audio-pci 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    7.825738] sof-audio-pci 0000:00:1f.3: use msi interrupt mode
[    7.886390] sof-audio-pci 0000:00:1f.3: hda codecs found, mask 5
[    7.886393] sof-audio-pci 0000:00:1f.3: using HDA machine driver skl_hda_dsp_generic now
[    7.886399] sof-audio-pci 0000:00:1f.3: DMICs detected in NHLT tables: 2
[    7.940218] Bluetooth: hci0: QCA Product ID   :0x00000010
[    7.940220] Bluetooth: hci0: QCA SOC Version  :0x400a0200
[    7.940220] Bluetooth: hci0: QCA ROM Version  :0x00000200
[    7.940221] Bluetooth: hci0: QCA Patch Version:0x00000d2b
[    7.940221] Bluetooth: hci0: QCA controller version 0x02000200
[    7.940222] Bluetooth: hci0: QCA Downloading qca/htbtfw20.tlv
[    7.977205] sof-audio-pci 0000:00:1f.3: Firmware info: version 1:5:0-58b36
[    7.977208] sof-audio-pci 0000:00:1f.3: Firmware: ABI 3:16:0 Kernel ABI 3:17:0
[    7.977364] sof-audio-pci 0000:00:1f.3: warning: unknown ext header type 3 size 0x1c
[    7.977373] sof-audio-pci 0000:00:1f.3: warning: unknown ext header type 4 size 0x10
[    7.983357] sof-audio-pci 0000:00:1f.3: Topology: ABI 3:11:0 Kernel ABI 3:17:0
[    7.997455] sof-audio-pci 0000:00:1f.3: ASoC: Parent card not yet available, widget card binding deferred
[    8.017550] snd_hda_codec_realtek ehdaudio0D0: autoconfig for ALC289: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    8.017551] snd_hda_codec_realtek ehdaudio0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    8.017552] snd_hda_codec_realtek ehdaudio0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    8.017553] snd_hda_codec_realtek ehdaudio0D0:    mono: mono_out=0x0
[    8.017553] snd_hda_codec_realtek ehdaudio0D0:    inputs:
[    8.017554] snd_hda_codec_realtek ehdaudio0D0:      Headset Mic=0x19
[    8.017554] snd_hda_codec_realtek ehdaudio0D0:      Headphone Mic=0x1b
[    8.068759] snd_hda_codec_realtek ehdaudio0D0: ASoC: sink widget AIF1TX overwritten
[    8.068764] snd_hda_codec_realtek ehdaudio0D0: ASoC: source widget AIF1RX overwritten
[    8.068868] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget hifi3 overwritten
[    8.068871] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget hifi2 overwritten
[    8.068873] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget hifi1 overwritten
[    8.068876] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Codec Output Pin1 overwritten
[    8.068878] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Codec Input Pin1 overwritten
[    8.068881] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Analog Codec Playback overwritten
[    8.068885] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Digital Codec Playback overwritten
[    8.068888] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: sink widget Alt Analog Codec Playback overwritten
[    8.068891] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Analog Codec Capture overwritten
[    8.068894] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Digital Codec Capture overwritten
[    8.068898] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: source widget Alt Analog Codec Capture overwritten
[    8.068905] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3

[    8.068906] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 4

[    8.068907] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 5

[    8.068908] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 6

[    8.068909] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 7

[    8.068909] skl_hda_dsp_generic skl_hda_dsp_generic: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 8

[    8.083734] input: sof-hda-dsp Headphone Mic as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input16
[    8.083760] input: sof-hda-dsp HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input17
[    8.083788] input: sof-hda-dsp HDMI/DP,pcm=4 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input18
[    8.083823] input: sof-hda-dsp HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input19
[    8.608647] audit: type=1400 audit(1604493257.356:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=1223 comm="apparmor_parser"
[    8.609264] audit: type=1400 audit(1604493257.356:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oopslash" pid=1221 comm="apparmor_parser"
[    8.609540] audit: type=1400 audit(1604493257.356:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=1218 comm="apparmor_parser"
[    8.609543] audit: type=1400 audit(1604493257.356:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=1218 comm="apparmor_parser"
[    8.610965] audit: type=1400 audit(1604493257.356:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=1222 comm="apparmor_parser"
[    8.613725] audit: type=1400 audit(1604493257.360:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=1226 comm="apparmor_parser"
[    8.613729] audit: type=1400 audit(1604493257.360:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=1226 comm="apparmor_parser"
[    8.615041] audit: type=1400 audit(1604493257.360:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="tcpdump" pid=1229 comm="apparmor_parser"
[    8.616310] audit: type=1400 audit(1604493257.364:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/cups/backend/cups-pdf" pid=1219 comm="apparmor_parser"
[    8.616314] audit: type=1400 audit(1604493257.364:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cupsd" pid=1219 comm="apparmor_parser"
[    8.663760] mc: Linux media interface: v0.10
[    8.665307] usbcore: registered new interface driver btusb
[    8.668662] Bluetooth: hci1: RTL: examining hci_ver=08 hci_rev=826c lmp_ver=08 lmp_subver=a99e
[    8.668665] Bluetooth: hci1: RTL: unknown IC info, lmp subver a99e, hci rev 826c, hci ver 0008
[    8.668667] Bluetooth: hci1: RTL: assuming no firmware upload needed
[    8.669945] videodev: Linux video capture interface: v2.00
[    8.771761] Bluetooth: hci0: QCA Downloading qca/htnv20.bin
[    8.816047] uvcvideo: Found UVC 1.10 device Integrated_Webcam_HD (0bda:5517)
[    8.818187] input: Integrated_Webcam_HD: Integrate as /devices/pci0000:00/0000:00:14.0/usb3/3-6/3-6:1.0/input/input20
[    8.818687] uvcvideo: Found UVC 1.50 device Integrated_Webcam_HD (0bda:5517)
[    8.819297] input: Integrated_Webcam_HD: Integrate as /devices/pci0000:00/0000:00:14.0/usb3/3-6/3-6:1.2/input/input21
[    8.819531] usbcore: registered new interface driver uvcvideo
[    8.819533] USB Video Class driver (1.1.1)
[    8.974133] Bluetooth: hci0: QCA setup on UART is completed
[   10.039258] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.039259] Bluetooth: BNEP filters: protocol multicast
[   10.039263] Bluetooth: BNEP socket layer initialized
[   10.054450] NET: Registered protocol family 38
[   13.805606] rfkill: input handler disabled
[   14.075673] psmouse serio1: Failed to deactivate mouse on isa0060/serio1: -5
[   14.563726] psmouse serio1: Failed to enable mouse on isa0060/serio1
[   18.839784] input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input5
[   19.043772] psmouse serio1: Failed to enable mouse on isa0060/serio1
[   20.916310] Bluetooth: RFCOMM TTY layer initialized
[   20.916315] Bluetooth: RFCOMM socket layer initialized
[   20.916319] Bluetooth: RFCOMM ver 1.11
[   21.112484] rfkill: input handler enabled
[   22.946707] rfkill: input handler disabled
[   23.174208] kauditd_printk_skb: 93 callbacks suppressed
[   23.174210] audit: type=1400 audit(1604493271.920:105): apparmor="DENIED" operation="capable" profile="/usr/lib/snapd/snap-confine" pid=2831 comm="snap-confine" capability=4  capname="fsetid"
[   24.616261] audit: type=1326 audit(1604493273.364:106): auid=1000 uid=1000 gid=1000 ses=3 subj==snap.snap-store.ubuntu-software (enforce) pid=2831 comm="snap-store" exe="/snap/snap-store/481/usr/bin/snap-store" sig=0 arch=c000003e syscall=314 compat=0 ip=0x7f84aca0a959 code=0x50000

--------------A19D7DB9D2032D15CFFFD468
Content-Type: text/plain; charset=UTF-8;
 name="lspci.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lspci.txt"

MDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gMTF0aCBHZW4gQ29yZSBQ
cm9jZXNzb3IgSG9zdCBCcmlkZ2UvRFJBTSBSZWdpc3RlcnMgKHJldiAwMSkKCVN1YnN5c3Rl
bTogRGVsbCAxMXRoIEdlbiBDb3JlIFByb2Nlc3NvciBIb3N0IEJyaWRnZS9EUkFNIFJlZ2lz
dGVycwoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5W
LSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0K
CVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1mYXN0
ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQrID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVu
Y3k6IDAKCUNhcGFiaWxpdGllczogW2UwXSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246
IExlbj0xNCA8Pz4KCjAwOjAyLjAgVkdBIGNvbXBhdGlibGUgY29udHJvbGxlcjogSW50ZWwg
Q29ycG9yYXRpb24gVUhEIEdyYXBoaWNzIChyZXYgMDEpIChwcm9nLWlmIDAwIFtWR0EgY29u
dHJvbGxlcl0pCglEZXZpY2VOYW1lOiBUbyBCZSBGaWxsZWQgYnkgTy5FLk0uCglTdWJzeXN0
ZW06IERlbGwgVUhEIEdyYXBoaWNzCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBT
cGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBG
YXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBh
ckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQ
RVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJR
IDE1MwoJUmVnaW9uIDA6IE1lbW9yeSBhdCA2MDNjMDAwMDAwICg2NC1iaXQsIG5vbi1wcmVm
ZXRjaGFibGUpIFtzaXplPTE2TV0KCVJlZ2lvbiAyOiBNZW1vcnkgYXQgNDAwMDAwMDAwMCAo
NjQtYml0LCBwcmVmZXRjaGFibGUpIFtzaXplPTI1Nk1dCglSZWdpb24gNDogSS9PIHBvcnRz
IGF0IDMwMDAgW3NpemU9NjRdCglFeHBhbnNpb24gUk9NIGF0IDAwMGMwMDAwIFt2aXJ0dWFs
XSBbZGlzYWJsZWRdIFtzaXplPTEyOEtdCglDYXBhYmlsaXRpZXM6IFs0MF0gVmVuZG9yIFNw
ZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MGMgPD8+CglDYXBhYmlsaXRpZXM6IFs3MF0gRXhw
cmVzcyAodjIpIFJvb3QgQ29tcGxleCBJbnRlZ3JhdGVkIEVuZHBvaW50LCBNU0kgMDAKCQlE
ZXZDYXA6CU1heFBheWxvYWQgMTI4IGJ5dGVzLCBQaGFudEZ1bmMgMAoJCQlFeHRUYWctIFJC
RSsgRkxSZXNldCsKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0g
VW5zdXBSZXEtCgkJCVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25v
b3AtIEZMUmVzZXQtCgkJCU1heFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDEyOCBi
eXRlcwoJCURldlN0YToJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJl
cS0gQXV4UHdyLSBUcmFuc1BlbmQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBO
b3QgU3VwcG9ydGVkLCBUaW1lb3V0RGlzLSBOUk9QclByUC0gTFRSLQoJCQkgMTBCaXRUYWdD
b21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJl
Zml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdl
bmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLQoJCQkgQXRvbWljT3BzQ2FwOiAzMmJp
dC0gNjRiaXQtIDEyOGJpdENBUy0KCQlEZXZDdGwyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IDUw
dXMgdG8gNTBtcywgVGltZW91dERpcy0gTFRSLSBPQkZGIERpc2FibGVkLAoJCQkgQXRvbWlj
T3BzQ3RsOiBSZXFFbi0KCUNhcGFiaWxpdGllczogW2FjXSBNU0k6IEVuYWJsZSsgQ291bnQ9
MS8xIE1hc2thYmxlKyA2NGJpdC0KCQlBZGRyZXNzOiBmZWU4MDAwNCAgRGF0YTogNDAyNQoJ
CU1hc2tpbmc6IDAwMDAwMDAwICBQZW5kaW5nOiAwMDAwMDAwMAoJQ2FwYWJpbGl0aWVzOiBb
ZDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyCgkJRmxhZ3M6IFBNRUNsay0gRFNJKyBE
MS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEtLEQyLSxEM2hvdC0sRDNjb2xkLSkK
CQlTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBN
RS0KCUNhcGFiaWxpdGllczogWzEwMCB2MV0gUHJvY2VzcyBBZGRyZXNzIFNwYWNlIElEIChQ
QVNJRCkKCQlQQVNJRENhcDogRXhlYy0gUHJpdi0sIE1heCBQQVNJRCBXaWR0aDogMTQKCQlQ
QVNJREN0bDogRW5hYmxlLSBFeGVjLSBQcml2LQoJQ2FwYWJpbGl0aWVzOiBbMjAwIHYxXSBB
ZGRyZXNzIFRyYW5zbGF0aW9uIFNlcnZpY2UgKEFUUykKCQlBVFNDYXA6CUludmFsaWRhdGUg
UXVldWUgRGVwdGg6IDAwCgkJQVRTQ3RsOglFbmFibGUtLCBTbWFsbGVzdCBUcmFuc2xhdGlv
biBVbml0OiAwMAoJQ2FwYWJpbGl0aWVzOiBbMzAwIHYxXSBQYWdlIFJlcXVlc3QgSW50ZXJm
YWNlIChQUkkpCgkJUFJJQ3RsOiBFbmFibGUtIFJlc2V0LQoJCVBSSVN0YTogUkYtIFVQUkdJ
LSBTdG9wcGVkKwoJCVBhZ2UgUmVxdWVzdCBDYXBhY2l0eTogMDAwMDgwMDAsIFBhZ2UgUmVx
dWVzdCBBbGxvY2F0aW9uOiAwMDAwMDAwMAoJQ2FwYWJpbGl0aWVzOiBbMzIwIHYxXSBTaW5n
bGUgUm9vdCBJL08gVmlydHVhbGl6YXRpb24gKFNSLUlPVikKCQlJT1ZDYXA6CU1pZ3JhdGlv
bi0sIEludGVycnVwdCBNZXNzYWdlIE51bWJlcjogMDAwCgkJSU9WQ3RsOglFbmFibGUtIE1p
Z3JhdGlvbi0gSW50ZXJydXB0LSBNU0UtIEFSSUhpZXJhcmNoeS0KCQlJT1ZTdGE6CU1pZ3Jh
dGlvbi0KCQlJbml0aWFsIFZGczogNywgVG90YWwgVkZzOiA3LCBOdW1iZXIgb2YgVkZzOiAw
LCBGdW5jdGlvbiBEZXBlbmRlbmN5IExpbms6IDAwCgkJVkYgb2Zmc2V0OiAxLCBzdHJpZGU6
IDEsIERldmljZSBJRDogOWE0OQoJCVN1cHBvcnRlZCBQYWdlIFNpemU6IDAwMDAwNTUzLCBT
eXN0ZW0gUGFnZSBTaXplOiAwMDAwMDAwMQoJCVJlZ2lvbiAwOiBNZW1vcnkgYXQgMDAwMDAw
NDAxMDAwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKQoJCVJlZ2lvbiAyOiBNZW1v
cnkgYXQgMDAwMDAwNDAyMDAwMDAwMCAoNjQtYml0LCBwcmVmZXRjaGFibGUpCgkJVkYgTWln
cmF0aW9uOiBvZmZzZXQ6IDAwMDAwMDAwLCBCSVI6IDAKCUtlcm5lbCBkcml2ZXIgaW4gdXNl
OiBpOTE1CglLZXJuZWwgbW9kdWxlczogaTkxNQoKMDA6MDQuMCBTaWduYWwgcHJvY2Vzc2lu
ZyBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgOWEwMyAocmV2IDAxKQoJ
U3Vic3lzdGVtOiBEZWxsIERldmljZSAwOTkxCglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFz
dGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBT
RVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RC
MkIrIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNF
UlItIDxQRVJSLSBJTlR4LQoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDE2CglS
ZWdpb24gMDogTWVtb3J5IGF0IDYwM2QxODAwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJs
ZSkgW3NpemU9MTI4S10KCUNhcGFiaWxpdGllczogWzkwXSBNU0k6IEVuYWJsZS0gQ291bnQ9
MS8xIE1hc2thYmxlLSA2NGJpdC0KCQlBZGRyZXNzOiAwMDAwMDAwMCAgRGF0YTogMDAwMAoJ
Q2FwYWJpbGl0aWVzOiBbZDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6
IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEtLEQyLSxE
M2hvdC0sRDNjb2xkLSkKCQlTdGF0dXM6IEQwIE5vU29mdFJzdCsgUE1FLUVuYWJsZS0gRFNl
bD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogW2UwXSBWZW5kb3IgU3BlY2lmaWMg
SW5mb3JtYXRpb246IExlbj0wYyA8Pz4KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBwcm9jX3Ro
ZXJtYWwKCUtlcm5lbCBtb2R1bGVzOiBwcm9jZXNzb3JfdGhlcm1hbF9kZXZpY2UKCjAwOjA2
LjAgUENJIGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gMTF0aCBHZW4gQ29yZSBQcm9jZXNz
b3IgUENJZSBDb250cm9sbGVyIChyZXYgMDEpIChwcm9nLWlmIDAwIFtOb3JtYWwgZGVjb2Rl
XSkKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0g
VkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgrCglT
dGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+
VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5
OiAwCglJbnRlcnJ1cHQ6IHBpbiBEIHJvdXRlZCB0byBJUlEgMTIwCglCdXM6IHByaW1hcnk9
MDAsIHNlY29uZGFyeT0wMSwgc3Vib3JkaW5hdGU9MDEsIHNlYy1sYXRlbmN5PTAKCUkvTyBi
ZWhpbmQgYnJpZGdlOiBbZGlzYWJsZWRdCglNZW1vcnkgYmVoaW5kIGJyaWRnZTogOGM0MDAw
MDAtOGM0ZmZmZmYgW3NpemU9MU1dCglQcmVmZXRjaGFibGUgbWVtb3J5IGJlaGluZCBicmlk
Z2U6IFtkaXNhYmxlZF0KCVNlY29uZGFyeSBzdGF0dXM6IDY2TUh6LSBGYXN0QjJCLSBQYXJF
cnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQrIDxTRVJSLSA8UEVS
Ui0KCUJyaWRnZUN0bDogUGFyaXR5LSBTRVJSKyBOb0lTQS0gVkdBLSBWR0ExNi0gTUFib3J0
LSA+UmVzZXQtIEZhc3RCMkItCgkJUHJpRGlzY1Rtci0gU2VjRGlzY1Rtci0gRGlzY1RtclN0
YXQtIERpc2NUbXJTRVJSRW4tCglDYXBhYmlsaXRpZXM6IFs0MF0gRXhwcmVzcyAodjIpIFJv
b3QgUG9ydCAoU2xvdCspLCBNU0kgMDAKCQlEZXZDYXA6CU1heFBheWxvYWQgMjU2IGJ5dGVz
LCBQaGFudEZ1bmMgMAoJCQlFeHRUYWctIFJCRSsKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZh
dGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtCgkJCVJseGRPcmQtIEV4dFRhZy0gUGhhbnRG
dW5jLSBBdXhQd3ItIE5vU25vb3AtCgkJCU1heFBheWxvYWQgMjU2IGJ5dGVzLCBNYXhSZWFk
UmVxIDEyOCBieXRlcwoJCURldlN0YToJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJy
LSBVbnN1cFJlcS0gQXV4UHdyKyBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICMxLCBTcGVl
ZCAxNkdUL3MsIFdpZHRoIHg0LCBBU1BNIEwxLCBFeGl0IExhdGVuY3kgTDEgPDE2dXMKCQkJ
Q2xvY2tQTS0gU3VycHJpc2UtIExMQWN0UmVwKyBCd05vdCsgQVNQTU9wdENvbXArCgkJTG5r
Q3RsOglBU1BNIEwxIEVuYWJsZWQ7IFJDQiA2NCBieXRlcywgRGlzYWJsZWQtIENvbW1DbGsr
CgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0KCQlM
bmtTdGE6CVNwZWVkIDhHVC9zIChkb3duZ3JhZGVkKSwgV2lkdGggeDQgKG9rKQoJCQlUckVy
ci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlKyBCV01nbXQrIEFCV01nbXQtCgkJU2x0Q2Fw
OglBdHRuQnRuLSBQd3JDdHJsLSBNUkwtIEF0dG5JbmQtIFB3ckluZC0gSG90UGx1Zy0gU3Vy
cHJpc2UtCgkJCVNsb3QgIzAsIFBvd2VyTGltaXQgNzUuMDAwVzsgSW50ZXJsb2NrLSBOb0Nv
bXBsKwoJCVNsdEN0bDoJRW5hYmxlOiBBdHRuQnRuLSBQd3JGbHQtIE1STC0gUHJlc0RldC0g
Q21kQ3BsdC0gSFBJcnEtIExpbmtDaGctCgkJCUNvbnRyb2w6IEF0dG5JbmQgVW5rbm93biwg
UHdySW5kIFVua25vd24sIFBvd2VyLSBJbnRlcmxvY2stCgkJU2x0U3RhOglTdGF0dXM6IEF0
dG5CdG4tIFBvd2VyRmx0LSBNUkwtIENtZENwbHQtIFByZXNEZXQrIEludGVybG9jay0KCQkJ
Q2hhbmdlZDogTVJMLSBQcmVzRGV0KyBMaW5rU3RhdGUrCgkJUm9vdENhcDogQ1JTVmlzaWJs
ZS0KCQlSb290Q3RsOiBFcnJDb3JyZWN0YWJsZS0gRXJyTm9uLUZhdGFsLSBFcnJGYXRhbC0g
UE1FSW50RW5hKyBDUlNWaXNpYmxlLQoJCVJvb3RTdGE6IFBNRSBSZXFJRCAwMDAwLCBQTUVT
dGF0dXMtIFBNRVBlbmRpbmctCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBSYW5n
ZSBBQkMsIFRpbWVvdXREaXMrIE5ST1ByUHJQLSBMVFIrCgkJCSAxMEJpdFRhZ0NvbXArIDEw
Qml0VGFnUmVxLSBPQkZGIFZpYSBXQUtFIywgRXh0Rm10LSBFRVRMUFByZWZpeC0KCQkJIEVt
ZXJnZW5jeVBvd2VyUmVkdWN0aW9uIE5vdCBTdXBwb3J0ZWQsIEVtZXJnZW5jeVBvd2VyUmVk
dWN0aW9uSW5pdC0KCQkJIEZSUy0gTE4gU3lzdGVtIENMUyBOb3QgU3VwcG9ydGVkLCBUUEhD
b21wLSBFeHRUUEhDb21wLSBBUklGd2QrCgkJCSBBdG9taWNPcHNDYXA6IFJvdXRpbmcrIDMy
Yml0KyA2NGJpdCsgMTI4Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24gVGltZW91dDog
NTB1cyB0byA1MG1zLCBUaW1lb3V0RGlzLSBMVFIrIE9CRkYgRGlzYWJsZWQsIEFSSUZ3ZC0K
CQkJIEF0b21pY09wc0N0bDogUmVxRW4rIEVncmVzc0JsY2srCgkJTG5rQ2FwMjogU3VwcG9y
dGVkIExpbmsgU3BlZWRzOiAyLjUtMTZHVC9zLCBDcm9zc2xpbmstIFJldGltZXIrIDJSZXRp
bWVycysgRFJTLQoJCUxua0N0bDI6IFRhcmdldCBMaW5rIFNwZWVkOiA4R1QvcywgRW50ZXJD
b21wbGlhbmNlLSBTcGVlZERpcy0KCQkJIFRyYW5zbWl0IE1hcmdpbjogTm9ybWFsIE9wZXJh
dGluZyBSYW5nZSwgRW50ZXJNb2RpZmllZENvbXBsaWFuY2UtIENvbXBsaWFuY2VTT1MtCgkJ
CSBDb21wbGlhbmNlIERlLWVtcGhhc2lzOiAtNmRCCgkJTG5rU3RhMjogQ3VycmVudCBEZS1l
bXBoYXNpcyBMZXZlbDogLTMuNWRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZSsgRXF1YWxpemF0
aW9uUGhhc2UxKwoJCQkgRXF1YWxpemF0aW9uUGhhc2UyKyBFcXVhbGl6YXRpb25QaGFzZTMr
IExpbmtFcXVhbGl6YXRpb25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBDcm9z
c2xpbmtSZXM6IHVuc3VwcG9ydGVkCglDYXBhYmlsaXRpZXM6IFs4MF0gTVNJOiBFbmFibGUr
IENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQtCgkJQWRkcmVzczogZmVlMDQwMDQgIERhdGE6
IDQwMjEKCUNhcGFiaWxpdGllczogWzkwXSBTdWJzeXN0ZW06IERlbGwgMTF0aCBHZW4gQ29y
ZSBQcm9jZXNzb3IgUENJZSBDb250cm9sbGVyCglDYXBhYmlsaXRpZXM6IFthMF0gUG93ZXIg
TWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4
Q3VycmVudD0wbUEgUE1FKEQwKyxEMS0sRDItLEQzaG90KyxEM2NvbGQrKQoJCVN0YXR1czog
RDAgTm9Tb2Z0UnN0LSBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJp
bGl0aWVzOiBbMTAwIHYxXSBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcKCQlVRVN0YToJRExQ
LSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0g
TWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVNc2s6CURMUC0gU0RFUy0g
VExQLSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQrIFJ4T0YtIE1hbGZUTFAt
IEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQoJCVVFU3ZydDoJRExQKyBTREVTLSBUTFAtIEZD
UC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRisgTWFsZlRMUCsgRUNSQy0g
VW5zdXBSZXEtIEFDU1Zpb2wtCgkJQ0VTdGE6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJv
bGxvdmVyLSBUaW1lb3V0LSBBZHZOb25GYXRhbEVyci0KCQlDRU1zazoJUnhFcnItIEJhZFRM
UC0gQmFkRExMUC0gUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyKwoJCUFFUkNh
cDoJRmlyc3QgRXJyb3IgUG9pbnRlcjogMDAsIEVDUkNHZW5DYXAtIEVDUkNHZW5Fbi0gRUNS
Q0Noa0NhcC0gRUNSQ0Noa0VuLQoJCQlNdWx0SGRyUmVjQ2FwLSBNdWx0SGRyUmVjRW4tIFRM
UFBmeFByZXMtIEhkckxvZ0NhcC0KCQlIZWFkZXJMb2c6IDAwMDAwMDAwIDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAwCgkJUm9vdENtZDogQ0VScHRFbi0gTkZFUnB0RW4tIEZFUnB0RW4t
CgkJUm9vdFN0YTogQ0VSY3ZkLSBNdWx0Q0VSY3ZkLSBVRVJjdmQtIE11bHRVRVJjdmQtCgkJ
CSBGaXJzdEZhdGFsLSBOb25GYXRhbE1zZy0gRmF0YWxNc2ctIEludE1zZyAwCgkJRXJyb3JT
cmM6IEVSUl9DT1I6IDAwMDAgRVJSX0ZBVEFML05PTkZBVEFMOiAwMDAwCglDYXBhYmlsaXRp
ZXM6IFsyMjAgdjFdIEFjY2VzcyBDb250cm9sIFNlcnZpY2VzCgkJQUNTQ2FwOglTcmNWYWxp
ZCsgVHJhbnNCbGsrIFJlcVJlZGlyKyBDbXBsdFJlZGlyKyBVcHN0cmVhbUZ3ZCsgRWdyZXNz
Q3RybC0gRGlyZWN0VHJhbnMtCgkJQUNTQ3RsOglTcmNWYWxpZC0gVHJhbnNCbGstIFJlcVJl
ZGlyLSBDbXBsdFJlZGlyLSBVcHN0cmVhbUZ3ZC0gRWdyZXNzQ3RybC0gRGlyZWN0VHJhbnMt
CglDYXBhYmlsaXRpZXM6IFsyMDAgdjFdIEwxIFBNIFN1YnN0YXRlcwoJCUwxU3ViQ2FwOiBQ
Q0ktUE1fTDEuMisgUENJLVBNX0wxLjErIEFTUE1fTDEuMisgQVNQTV9MMS4xKyBMMV9QTV9T
dWJzdGF0ZXMrCgkJCSAgUG9ydENvbW1vbk1vZGVSZXN0b3JlVGltZT00NXVzIFBvcnRUUG93
ZXJPblRpbWU9NTB1cwoJCUwxU3ViQ3RsMTogUENJLVBNX0wxLjIrIFBDSS1QTV9MMS4xKyBB
U1BNX0wxLjIrIEFTUE1fTDEuMSsKCQkJICAgVF9Db21tb25Nb2RlPTQ1dXMgTFRSMS4yX1Ro
cmVzaG9sZD05ODMwNG5zCgkJTDFTdWJDdGwyOiBUX1B3ck9uPTUwdXMKCUNhcGFiaWxpdGll
czogWzE1MCB2MV0gUHJlY2lzaW9uIFRpbWUgTWVhc3VyZW1lbnQKCQlQVE1DYXA6IFJlcXVl
c3RlcjotIFJlc3BvbmRlcjorIFJvb3Q6KwoJCVBUTUNsb2NrR3JhbnVsYXJpdHk6IDRucwoJ
CVBUTUNvbnRyb2w6IEVuYWJsZWQ6KyBSb290U2VsZWN0ZWQ6KwoJCVBUTUVmZmVjdGl2ZUdy
YW51bGFyaXR5OiBVbmtub3duCglDYXBhYmlsaXRpZXM6IFsyODAgdjFdIFZpcnR1YWwgQ2hh
bm5lbAoJCUNhcHM6CUxQRVZDPTAgUmVmQ2xrPTEwMG5zIFBBVEVudHJ5Qml0cz0xCgkJQXJi
OglGaXhlZC0gV1JSMzItIFdSUjY0LSBXUlIxMjgtCgkJQ3RybDoJQXJiU2VsZWN0PUZpeGVk
CgkJU3RhdHVzOglJblByb2dyZXNzLQoJCVZDMDoJQ2FwczoJUEFUT2Zmc2V0PTAwIE1heFRp
bWVTbG90cz0xIFJlalNub29wVHJhbnMtCgkJCUFyYjoJRml4ZWQtIFdSUjMyLSBXUlI2NC0g
V1JSMTI4LSBUV1JSMTI4LSBXUlIyNTYtCgkJCUN0cmw6CUVuYWJsZSsgSUQ9MCBBcmJTZWxl
Y3Q9Rml4ZWQgVEMvVkM9ZmYKCQkJU3RhdHVzOglOZWdvUGVuZGluZy0gSW5Qcm9ncmVzcy0K
CUNhcGFiaWxpdGllczogW2EwMCB2MV0gRG93bnN0cmVhbSBQb3J0IENvbnRhaW5tZW50CgkJ
RHBjQ2FwOglJTlQgTXNnICMwLCBSUEV4dCsgUG9pc29uZWRUTFArIFN3VHJpZ2dlcisgUlAg
UElPIExvZyA0LCBETF9BY3RpdmVFcnIrCgkJRHBjQ3RsOglUcmlnZ2VyOjAgQ21wbC0gSU5U
LSBFcnJDb3ItIFBvaXNvbmVkVExQLSBTd1RyaWdnZXItIERMX0FjdGl2ZUVyci0KCQlEcGNT
dGE6CVRyaWdnZXItIFJlYXNvbjowMCBJTlQtIFJQQnVzeS0gVHJpZ2dlckV4dDowMCBSUCBQ
SU8gRXJyUHRyOjFmCgkJU291cmNlOgkwMDAwCglDYXBhYmlsaXRpZXM6IFthMzAgdjFdIFNl
Y29uZGFyeSBQQ0kgRXhwcmVzcwoJCUxua0N0bDM6IExua0VxdUludHJydXB0RW4tIFBlcmZv
cm1FcXUtCgkJTGFuZUVyclN0YXQ6IDAKCUNhcGFiaWxpdGllczogW2E5MCB2MV0gRGF0YSBM
aW5rIEZlYXR1cmUgPD8+CglDYXBhYmlsaXRpZXM6IFthOWMgdjFdIFBoeXNpY2FsIExheWVy
IDE2LjAgR1QvcyA8Pz4KCUNhcGFiaWxpdGllczogW2VkYyB2MV0gTGFuZSBNYXJnaW5pbmcg
YXQgdGhlIFJlY2VpdmVyIDw/PgoJS2VybmVsIGRyaXZlciBpbiB1c2U6IHBjaWVwb3J0Cgow
MDowNy4wIFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIFRpZ2VyIExha2UtTFAgVGh1
bmRlcmJvbHQgUENJIEV4cHJlc3MgUm9vdCBQb3J0ICMwIChyZXYgMDEpIChwcm9nLWlmIDAw
IFtOb3JtYWwgZGVjb2RlXSkKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWND
eWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RC
MkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJy
LSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlIt
IElOVHgtCglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTIx
CglCdXM6IHByaW1hcnk9MDAsIHNlY29uZGFyeT0wMiwgc3Vib3JkaW5hdGU9MmIsIHNlYy1s
YXRlbmN5PTAKCUkvTyBiZWhpbmQgYnJpZGdlOiAwMDAwNDAwMC0wMDAwNGZmZiBbc2l6ZT00
S10KCU1lbW9yeSBiZWhpbmQgYnJpZGdlOiA4MDAwMDAwMC04YzFmZmZmZiBbc2l6ZT0xOTRN
XQoJUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQgYnJpZGdlOiAwMDAwMDA2MDAwMDAwMDAw
LTAwMDAwMDYwMWJmZmZmZmYgW3NpemU9NDQ4TV0KCVNlY29uZGFyeSBzdGF0dXM6IDY2TUh6
LSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJv
cnQtIDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0bDogUGFyaXR5LSBTRVJSKyBOb0lTQS0gVkdB
LSBWR0ExNi0gTUFib3J0LSA+UmVzZXQtIEZhc3RCMkItCgkJUHJpRGlzY1Rtci0gU2VjRGlz
Y1Rtci0gRGlzY1RtclN0YXQtIERpc2NUbXJTRVJSRW4tCglDYXBhYmlsaXRpZXM6IFs0MF0g
RXhwcmVzcyAodjIpIFJvb3QgUG9ydCAoU2xvdCspLCBNU0kgMDAKCQlEZXZDYXA6CU1heFBh
eWxvYWQgMTI4IGJ5dGVzLCBQaGFudEZ1bmMgMAoJCQlFeHRUYWctIFJCRSsKCQlEZXZDdGw6
CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtCgkJCVJseGRPcmQt
IEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3AtCgkJCU1heFBheWxvYWQgMTI4
IGJ5dGVzLCBNYXhSZWFkUmVxIDEyOCBieXRlcwoJCURldlN0YToJQ29yckVyci0gTm9uRmF0
YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdyKyBUcmFuc1BlbmQtCgkJTG5rQ2Fw
OglQb3J0ICMyLCBTcGVlZCAyLjVHVC9zLCBXaWR0aCB4NCwgQVNQTSBMMSwgRXhpdCBMYXRl
bmN5IEwxIDwxNnVzCgkJCUNsb2NrUE0tIFN1cnByaXNlLSBMTEFjdFJlcCsgQndOb3QrIEFT
UE1PcHRDb21wKwoJCUxua0N0bDoJQVNQTSBMMSBFbmFibGVkOyBSQ0IgNjQgYnl0ZXMsIERp
c2FibGVkLSBDb21tQ2xrLQoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0lu
dC0gQXV0QldJbnQtCgkJTG5rU3RhOglTcGVlZCAyLjVHVC9zIChvayksIFdpZHRoIHgwIChk
b3duZ3JhZGVkKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQt
IEFCV01nbXQtCgkJU2x0Q2FwOglBdHRuQnRuLSBQd3JDdHJsLSBNUkwtIEF0dG5JbmQtIFB3
ckluZC0gSG90UGx1ZysgU3VycHJpc2UrCgkJCVNsb3QgIzAsIFBvd2VyTGltaXQgMC4wMDBX
OyBJbnRlcmxvY2stIE5vQ29tcGwrCgkJU2x0Q3RsOglFbmFibGU6IEF0dG5CdG4tIFB3ckZs
dC0gTVJMLSBQcmVzRGV0KyBDbWRDcGx0LSBIUElycSsgTGlua0NoZysKCQkJQ29udHJvbDog
QXR0bkluZCBVbmtub3duLCBQd3JJbmQgVW5rbm93biwgUG93ZXItIEludGVybG9jay0KCQlT
bHRTdGE6CVN0YXR1czogQXR0bkJ0bi0gUG93ZXJGbHQtIE1STC0gQ21kQ3BsdC0gUHJlc0Rl
dC0gSW50ZXJsb2NrLQoJCQlDaGFuZ2VkOiBNUkwtIFByZXNEZXQtIExpbmtTdGF0ZS0KCQlS
b290Q2FwOiBDUlNWaXNpYmxlLQoJCVJvb3RDdGw6IEVyckNvcnJlY3RhYmxlLSBFcnJOb24t
RmF0YWwtIEVyckZhdGFsLSBQTUVJbnRFbmErIENSU1Zpc2libGUtCgkJUm9vdFN0YTogUE1F
IFJlcUlEIDAwMDAsIFBNRVN0YXR1cy0gUE1FUGVuZGluZy0KCQlEZXZDYXAyOiBDb21wbGV0
aW9uIFRpbWVvdXQ6IFJhbmdlIEFCQywgVGltZW91dERpcysgTlJPUHJQclAtIExUUisKCQkJ
IDEwQml0VGFnQ29tcC0gMTBCaXRUYWdSZXEtIE9CRkYgVmlhIFdBS0UjLCBFeHRGbXQtIEVF
VExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwg
RW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBMTiBTeXN0ZW0gQ0xTIE5v
dCBTdXBwb3J0ZWQsIFRQSENvbXAtIEV4dFRQSENvbXAtIEFSSUZ3ZCsKCQkJIEF0b21pY09w
c0NhcDogUm91dGluZy0gMzJiaXQtIDY0Yml0LSAxMjhiaXRDQVMtCgkJRGV2Q3RsMjogQ29t
cGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMtIExUUisgT0JGRiBE
aXNhYmxlZCwgQVJJRndkLQoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0gRWdyZXNzQmxjay0K
CQlMbmtDYXAyOiBTdXBwb3J0ZWQgTGluayBTcGVlZHM6IDIuNUdUL3MsIENyb3NzbGluay0g
UmV0aW1lci0gMlJldGltZXJzLSBEUlMtCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6
IDIuNUdUL3MsIEVudGVyQ29tcGxpYW5jZS0gU3BlZWREaXMtCgkJCSBUcmFuc21pdCBNYXJn
aW46IE5vcm1hbCBPcGVyYXRpbmcgUmFuZ2UsIEVudGVyTW9kaWZpZWRDb21wbGlhbmNlLSBD
b21wbGlhbmNlU09TLQoJCQkgQ29tcGxpYW5jZSBEZS1lbXBoYXNpczogLTZkQgoJCUxua1N0
YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6IC0zLjVkQiwgRXF1YWxpemF0aW9uQ29t
cGxldGUtIEVxdWFsaXphdGlvblBoYXNlMS0KCQkJIEVxdWFsaXphdGlvblBoYXNlMi0gRXF1
YWxpemF0aW9uUGhhc2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGltZXIt
IDJSZXRpbWVycy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2FwYWJpbGl0aWVzOiBb
ODBdIE1TSTogRW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0LQoJCUFkZHJlc3M6
IGZlZTA4MDA0ICBEYXRhOiA0MDIxCglDYXBhYmlsaXRpZXM6IFs5MF0gU3Vic3lzdGVtOiBE
ZWxsIFRpZ2VyIExha2UtTFAgVGh1bmRlcmJvbHQgUENJIEV4cHJlc3MgUm9vdCBQb3J0CglD
YXBhYmlsaXRpZXM6IFthMF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczog
UE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVudD0wbUEgUE1FKEQwKyxEMS0sRDItLEQz
aG90KyxEM2NvbGQrKQoJCVN0YXR1czogRDAgTm9Tb2Z0UnN0LSBQTUUtRW5hYmxlLSBEU2Vs
PTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYwXSBOdWxsCglDYXBhYmls
aXRpZXM6IFsyMjAgdjFdIEFjY2VzcyBDb250cm9sIFNlcnZpY2VzCgkJQUNTQ2FwOglTcmNW
YWxpZCsgVHJhbnNCbGsrIFJlcVJlZGlyKyBDbXBsdFJlZGlyKyBVcHN0cmVhbUZ3ZCsgRWdy
ZXNzQ3RybC0gRGlyZWN0VHJhbnMtCgkJQUNTQ3RsOglTcmNWYWxpZC0gVHJhbnNCbGstIFJl
cVJlZGlyLSBDbXBsdFJlZGlyLSBVcHN0cmVhbUZ3ZC0gRWdyZXNzQ3RybC0gRGlyZWN0VHJh
bnMtCglDYXBhYmlsaXRpZXM6IFthMDAgdjFdIERvd25zdHJlYW0gUG9ydCBDb250YWlubWVu
dAoJCURwY0NhcDoJSU5UIE1zZyAjMCwgUlBFeHQrIFBvaXNvbmVkVExQLSBTd1RyaWdnZXIt
IFJQIFBJTyBMb2cgMCwgRExfQWN0aXZlRXJyLQoJCURwY0N0bDoJVHJpZ2dlcjowIENtcGwt
IElOVC0gRXJyQ29yLSBQb2lzb25lZFRMUC0gU3dUcmlnZ2VyLSBETF9BY3RpdmVFcnItCgkJ
RHBjU3RhOglUcmlnZ2VyLSBSZWFzb246MDAgSU5ULSBSUEJ1c3ktIFRyaWdnZXJFeHQ6MDAg
UlAgUElPIEVyclB0cjoxZgoJCVNvdXJjZToJMDAwMAoJS2VybmVsIGRyaXZlciBpbiB1c2U6
IHBjaWVwb3J0CgowMDowNy4yIFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIFRpZ2Vy
IExha2UtTFAgVGh1bmRlcmJvbHQgUENJIEV4cHJlc3MgUm9vdCBQb3J0ICMyIChyZXYgMDEp
IChwcm9nLWlmIDAwIFtOb3JtYWwgZGVjb2RlXSkKCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNN
YXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmct
IFNFUlItIEZhc3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFz
dEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+
U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglJbnRlcnJ1cHQ6IHBpbiBDIHJvdXRl
ZCB0byBJUlEgMTIyCglCdXM6IHByaW1hcnk9MDAsIHNlY29uZGFyeT0yYywgc3Vib3JkaW5h
dGU9NTUsIHNlYy1sYXRlbmN5PTAKCUkvTyBiZWhpbmQgYnJpZGdlOiAwMDAwNTAwMC0wMDAw
NWZmZiBbc2l6ZT00S10KCU1lbW9yeSBiZWhpbmQgYnJpZGdlOiA3MjAwMDAwMC03ZTFmZmZm
ZiBbc2l6ZT0xOTRNXQoJUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQgYnJpZGdlOiAwMDAw
MDA2MDIwMDAwMDAwLTAwMDAwMDYwM2JmZmZmZmYgW3NpemU9NDQ4TV0KCVNlY29uZGFyeSBz
dGF0dXM6IDY2TUh6LSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxU
QWJvcnQtIDxNQWJvcnQtIDxTRVJSLSA8UEVSUi0KCUJyaWRnZUN0bDogUGFyaXR5LSBTRVJS
KyBOb0lTQS0gVkdBLSBWR0ExNi0gTUFib3J0LSA+UmVzZXQtIEZhc3RCMkItCgkJUHJpRGlz
Y1Rtci0gU2VjRGlzY1Rtci0gRGlzY1RtclN0YXQtIERpc2NUbXJTRVJSRW4tCglDYXBhYmls
aXRpZXM6IFs0MF0gRXhwcmVzcyAodjIpIFJvb3QgUG9ydCAoU2xvdCspLCBNU0kgMDAKCQlE
ZXZDYXA6CU1heFBheWxvYWQgMTI4IGJ5dGVzLCBQaGFudEZ1bmMgMAoJCQlFeHRUYWctIFJC
RSsKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEt
CgkJCVJseGRPcmQtIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3AtCgkJCU1h
eFBheWxvYWQgMTI4IGJ5dGVzLCBNYXhSZWFkUmVxIDEyOCBieXRlcwoJCURldlN0YToJQ29y
ckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0gQXV4UHdyKyBUcmFuc1Bl
bmQtCgkJTG5rQ2FwOglQb3J0ICM0LCBTcGVlZCAyLjVHVC9zLCBXaWR0aCB4NCwgQVNQTSBM
MSwgRXhpdCBMYXRlbmN5IEwxIDwxNnVzCgkJCUNsb2NrUE0tIFN1cnByaXNlLSBMTEFjdFJl
cCsgQndOb3QrIEFTUE1PcHRDb21wKwoJCUxua0N0bDoJQVNQTSBMMSBFbmFibGVkOyBSQ0Ig
NjQgYnl0ZXMsIERpc2FibGVkLSBDb21tQ2xrLQoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0
V2lkRGlzLSBCV0ludC0gQXV0QldJbnQtCgkJTG5rU3RhOglTcGVlZCAyLjVHVC9zIChvayks
IFdpZHRoIHgwIChkb3duZ3JhZGVkKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0
aXZlLSBCV01nbXQtIEFCV01nbXQtCgkJU2x0Q2FwOglBdHRuQnRuLSBQd3JDdHJsLSBNUkwt
IEF0dG5JbmQtIFB3ckluZC0gSG90UGx1ZysgU3VycHJpc2UrCgkJCVNsb3QgIzAsIFBvd2Vy
TGltaXQgMC4wMDBXOyBJbnRlcmxvY2stIE5vQ29tcGwrCgkJU2x0Q3RsOglFbmFibGU6IEF0
dG5CdG4tIFB3ckZsdC0gTVJMLSBQcmVzRGV0KyBDbWRDcGx0LSBIUElycSsgTGlua0NoZysK
CQkJQ29udHJvbDogQXR0bkluZCBVbmtub3duLCBQd3JJbmQgVW5rbm93biwgUG93ZXItIElu
dGVybG9jay0KCQlTbHRTdGE6CVN0YXR1czogQXR0bkJ0bi0gUG93ZXJGbHQtIE1STC0gQ21k
Q3BsdC0gUHJlc0RldC0gSW50ZXJsb2NrLQoJCQlDaGFuZ2VkOiBNUkwtIFByZXNEZXQtIExp
bmtTdGF0ZS0KCQlSb290Q2FwOiBDUlNWaXNpYmxlLQoJCVJvb3RDdGw6IEVyckNvcnJlY3Rh
YmxlLSBFcnJOb24tRmF0YWwtIEVyckZhdGFsLSBQTUVJbnRFbmErIENSU1Zpc2libGUtCgkJ
Um9vdFN0YTogUE1FIFJlcUlEIDAwMDAsIFBNRVN0YXR1cy0gUE1FUGVuZGluZy0KCQlEZXZD
YXAyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IFJhbmdlIEFCQywgVGltZW91dERpcysgTlJPUHJQ
clAtIExUUisKCQkJIDEwQml0VGFnQ29tcC0gMTBCaXRUYWdSZXEtIE9CRkYgVmlhIFdBS0Uj
LCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90
IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBMTiBT
eXN0ZW0gQ0xTIE5vdCBTdXBwb3J0ZWQsIFRQSENvbXAtIEV4dFRQSENvbXAtIEFSSUZ3ZCsK
CQkJIEF0b21pY09wc0NhcDogUm91dGluZy0gMzJiaXQtIDY0Yml0LSAxMjhiaXRDQVMtCgkJ
RGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMt
IExUUisgT0JGRiBEaXNhYmxlZCwgQVJJRndkLQoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0g
RWdyZXNzQmxjay0KCQlMbmtDYXAyOiBTdXBwb3J0ZWQgTGluayBTcGVlZHM6IDIuNUdUL3Ms
IENyb3NzbGluay0gUmV0aW1lci0gMlJldGltZXJzLSBEUlMtCgkJTG5rQ3RsMjogVGFyZ2V0
IExpbmsgU3BlZWQ6IDIuNUdUL3MsIEVudGVyQ29tcGxpYW5jZS0gU3BlZWREaXMtCgkJCSBU
cmFuc21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRpbmcgUmFuZ2UsIEVudGVyTW9kaWZpZWRD
b21wbGlhbmNlLSBDb21wbGlhbmNlU09TLQoJCQkgQ29tcGxpYW5jZSBEZS1lbXBoYXNpczog
LTZkQgoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6IC0zLjVkQiwgRXF1
YWxpemF0aW9uQ29tcGxldGUtIEVxdWFsaXphdGlvblBoYXNlMS0KCQkJIEVxdWFsaXphdGlv
blBoYXNlMi0gRXF1YWxpemF0aW9uUGhhc2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0K
CQkJIFJldGltZXItIDJSZXRpbWVycy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2Fw
YWJpbGl0aWVzOiBbODBdIE1TSTogRW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0
LQoJCUFkZHJlc3M6IGZlZTEwMDA0ICBEYXRhOiA0MDIxCglDYXBhYmlsaXRpZXM6IFs5MF0g
U3Vic3lzdGVtOiBEZWxsIFRpZ2VyIExha2UtTFAgVGh1bmRlcmJvbHQgUENJIEV4cHJlc3Mg
Um9vdCBQb3J0CglDYXBhYmlsaXRpZXM6IFthMF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9u
IDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVudD0wbUEgUE1FKEQw
KyxEMS0sRDItLEQzaG90KyxEM2NvbGQrKQoJCVN0YXR1czogRDAgTm9Tb2Z0UnN0LSBQTUUt
RW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYwXSBO
dWxsCglDYXBhYmlsaXRpZXM6IFsyMjAgdjFdIEFjY2VzcyBDb250cm9sIFNlcnZpY2VzCgkJ
QUNTQ2FwOglTcmNWYWxpZCsgVHJhbnNCbGsrIFJlcVJlZGlyKyBDbXBsdFJlZGlyKyBVcHN0
cmVhbUZ3ZCsgRWdyZXNzQ3RybC0gRGlyZWN0VHJhbnMtCgkJQUNTQ3RsOglTcmNWYWxpZC0g
VHJhbnNCbGstIFJlcVJlZGlyLSBDbXBsdFJlZGlyLSBVcHN0cmVhbUZ3ZC0gRWdyZXNzQ3Ry
bC0gRGlyZWN0VHJhbnMtCglDYXBhYmlsaXRpZXM6IFthMDAgdjFdIERvd25zdHJlYW0gUG9y
dCBDb250YWlubWVudAoJCURwY0NhcDoJSU5UIE1zZyAjMCwgUlBFeHQrIFBvaXNvbmVkVExQ
LSBTd1RyaWdnZXItIFJQIFBJTyBMb2cgMCwgRExfQWN0aXZlRXJyLQoJCURwY0N0bDoJVHJp
Z2dlcjowIENtcGwtIElOVC0gRXJyQ29yLSBQb2lzb25lZFRMUC0gU3dUcmlnZ2VyLSBETF9B
Y3RpdmVFcnItCgkJRHBjU3RhOglUcmlnZ2VyLSBSZWFzb246MDAgSU5ULSBSUEJ1c3ktIFRy
aWdnZXJFeHQ6MDAgUlAgUElPIEVyclB0cjoxZgoJCVNvdXJjZToJMDAwMAoJS2VybmVsIGRy
aXZlciBpbiB1c2U6IHBjaWVwb3J0CgowMDowYS4wIFNpZ25hbCBwcm9jZXNzaW5nIGNvbnRy
b2xsZXI6IEludGVsIENvcnBvcmF0aW9uIERldmljZSA5YTBkIChyZXYgMDEpCglTdWJzeXN0
ZW06IERlbGwgRGV2aWNlIDA5OTEKCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXItIFNw
ZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZh
c3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFy
RXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBF
UlItIElOVHgtCglSZWdpb24gMDogTWVtb3J5IGF0IDYwM2QxZDAwMDAgKDY0LWJpdCwgbm9u
LXByZWZldGNoYWJsZSkgW3NpemU9MzJLXQoJQ2FwYWJpbGl0aWVzOiBbNzBdIEV4cHJlc3Mg
KHYyKSBSb290IENvbXBsZXggSW50ZWdyYXRlZCBFbmRwb2ludCwgTVNJIDAwCgkJRGV2Q2Fw
OglNYXhQYXlsb2FkIDEyOCBieXRlcywgUGhhbnRGdW5jIDAKCQkJRXh0VGFnKyBSQkUtIEZM
UmVzZXQtCgkJRGV2Q3RsOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3Vw
UmVxLQoJCQlSbHhkT3JkLSBFeHRUYWctIFBoYW50RnVuYy0gQXV4UHdyLSBOb1Nub29wLQoJ
CQlNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4UmVhZFJlcSAxMjggYnl0ZXMKCQlEZXZTdGE6
CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtIEF1eFB3ci0gVHJh
bnNQZW5kLQoJCURldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogTm90IFN1cHBvcnRlZCwg
VGltZW91dERpcy0gTlJPUHJQclAtIExUUi0KCQkJIDEwQml0VGFnQ29tcC0gMTBCaXRUYWdS
ZXEtIE9CRkYgTm90IFN1cHBvcnRlZCwgRXh0Rm10LSBFRVRMUFByZWZpeC0KCQkJIEVtZXJn
ZW5jeVBvd2VyUmVkdWN0aW9uIE5vdCBTdXBwb3J0ZWQsIEVtZXJnZW5jeVBvd2VyUmVkdWN0
aW9uSW5pdC0KCQkJIEZSUy0KCQkJIEF0b21pY09wc0NhcDogMzJiaXQtIDY0Yml0LSAxMjhi
aXRDQVMtCgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRp
bWVvdXREaXMtIExUUi0gT0JGRiBEaXNhYmxlZCwKCQkJIEF0b21pY09wc0N0bDogUmVxRW4t
CglDYXBhYmlsaXRpZXM6IFtkMF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFn
czogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVudD0wbUEgUE1FKEQwLSxEMS0sRDIt
LEQzaG90LSxEM2NvbGQtKQoJCVN0YXR1czogRDAgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxlLSBE
U2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYxXSBEZXNpZ25hdGVk
IFZlbmRvci1TcGVjaWZpYzogVmVuZG9yPTgwODYgSUQ9MDAwMiBSZXY9MSBMZW49MTYgPD8+
CglDYXBhYmlsaXRpZXM6IFsxMTAgdjFdIERlc2lnbmF0ZWQgVmVuZG9yLVNwZWNpZmljOiBW
ZW5kb3I9ODA4NiBJRD0wMDAzIFJldj0xIExlbj0xNiA8Pz4KCUNhcGFiaWxpdGllczogWzEy
MCB2MV0gRGVzaWduYXRlZCBWZW5kb3ItU3BlY2lmaWM6IFZlbmRvcj04MDg2IElEPTAwMDQg
UmV2PTEgTGVuPTE2IDw/PgoKMDA6MGQuMCBVU0IgY29udHJvbGxlcjogSW50ZWwgQ29ycG9y
YXRpb24gVGlnZXIgTGFrZS1MUCBUaHVuZGVyYm9sdCBVU0IgQ29udHJvbGxlciAocmV2IDAx
KSAocHJvZy1pZiAzMCBbWEhDSV0pCglTdWJzeXN0ZW06IERlbGwgVGlnZXIgTGFrZS1MUCBU
aHVuZGVyYm9sdCBVU0IgQ29udHJvbGxlcgoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3Rl
cisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VS
Ui0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJC
KyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNF
UlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBwaW4gPyByb3V0ZWQg
dG8gSVJRIDEyNQoJUmVnaW9uIDA6IE1lbW9yeSBhdCA2MDNkMWMwMDAwICg2NC1iaXQsIG5v
bi1wcmVmZXRjaGFibGUpIFtzaXplPTY0S10KCUNhcGFiaWxpdGllczogWzcwXSBQb3dlciBN
YW5hZ2VtZW50IHZlcnNpb24gMgoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhD
dXJyZW50PTM3NW1BIFBNRShEMC0sRDEtLEQyLSxEM2hvdCssRDNjb2xkKykKCQlTdGF0dXM6
IEQwIE5vU29mdFJzdCsgUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFi
aWxpdGllczogWzgwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS84IE1hc2thYmxlLSA2NGJpdCsK
CQlBZGRyZXNzOiAwMDAwMDAwMGZlZTA4MDA0ICBEYXRhOiA0MDIyCglDYXBhYmlsaXRpZXM6
IFs5MF0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MTQgPD8+CglDYXBhYmls
aXRpZXM6IFtiMF0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MDAgPD8+CglL
ZXJuZWwgZHJpdmVyIGluIHVzZTogeGhjaV9oY2QKCUtlcm5lbCBtb2R1bGVzOiB4aGNpX3Bj
aQoKMDA6MGQuMiBVU0IgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gVGlnZXIgTGFr
ZS1MUCBUaHVuZGVyYm9sdCBOSEkgIzAgKHJldiAwMSkgKHByb2ctaWYgNDAgW1VTQjQgSG9z
dCBJbnRlcmZhY2VdKQoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xl
LSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0g
RGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERF
VlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5U
eC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxNgoJUmVn
aW9uIDA6IE1lbW9yeSBhdCA2MDNkMTQwMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUp
IFtzaXplPTI1NktdCglSZWdpb24gMjogTWVtb3J5IGF0IDYwM2QxZTkwMDAgKDY0LWJpdCwg
bm9uLXByZWZldGNoYWJsZSkgW3NpemU9NEtdCglDYXBhYmlsaXRpZXM6IFs4MF0gUG93ZXIg
TWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxKyBEMisgQXV4
Q3VycmVudD0zNzVtQSBQTUUoRDArLEQxKyxEMissRDNob3QrLEQzY29sZCspCgkJU3RhdHVz
OiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBh
YmlsaXRpZXM6IFs4OF0gTVNJOiBFbmFibGUtIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQr
CgkJQWRkcmVzczogMDAwMDAwMDAwMDAwMDAwMCAgRGF0YTogMDAwMAoJQ2FwYWJpbGl0aWVz
OiBbYTBdIE1TSS1YOiBFbmFibGUrIENvdW50PTE2IE1hc2tlZC0KCQlWZWN0b3IgdGFibGU6
IEJBUj0yIG9mZnNldD0wMDAwMDAwMAoJCVBCQTogQkFSPTIgb2Zmc2V0PTAwMDAwZmEwCglL
ZXJuZWwgZHJpdmVyIGluIHVzZTogdGh1bmRlcmJvbHQKCUtlcm5lbCBtb2R1bGVzOiB0aHVu
ZGVyYm9sdAoKMDA6MGQuMyBVU0IgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gVGln
ZXIgTGFrZS1MUCBUaHVuZGVyYm9sdCBOSEkgIzEgKHJldiAwMSkgKHByb2ctaWYgNDAgW1VT
QjQgSG9zdCBJbnRlcmZhY2VdKQoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3Bl
Y0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFz
dEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJF
cnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVS
Ui0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAx
NgoJUmVnaW9uIDA6IE1lbW9yeSBhdCA2MDNkMTAwMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRj
aGFibGUpIFtzaXplPTI1NktdCglSZWdpb24gMjogTWVtb3J5IGF0IDYwM2QxZTgwMDAgKDY0
LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NEtdCglDYXBhYmlsaXRpZXM6IFs4MF0g
UG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxKyBE
MisgQXV4Q3VycmVudD0zNzVtQSBQTUUoRDArLEQxKyxEMissRDNob3QrLEQzY29sZCspCgkJ
U3RhdHVzOiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUt
CglDYXBhYmlsaXRpZXM6IFs4OF0gTVNJOiBFbmFibGUtIENvdW50PTEvMSBNYXNrYWJsZS0g
NjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDAwMDAwMDAwMCAgRGF0YTogMDAwMAoJQ2FwYWJp
bGl0aWVzOiBbYTBdIE1TSS1YOiBFbmFibGUrIENvdW50PTE2IE1hc2tlZC0KCQlWZWN0b3Ig
dGFibGU6IEJBUj0yIG9mZnNldD0wMDAwMDAwMAoJCVBCQTogQkFSPTIgb2Zmc2V0PTAwMDAw
ZmEwCglLZXJuZWwgZHJpdmVyIGluIHVzZTogdGh1bmRlcmJvbHQKCUtlcm5lbCBtb2R1bGVz
OiB0aHVuZGVyYm9sdAoKMDA6MTIuMCBTZXJpYWwgY29udHJvbGxlcjogSW50ZWwgQ29ycG9y
YXRpb24gVGlnZXIgTGFrZS1MUCBJbnRlZ3JhdGVkIFNlbnNvciBIdWIgKHJldiAyMCkgKHBy
b2ctaWYgMDAgWzgyNTBdKQoJU3Vic3lzdGVtOiBEZWxsIFRpZ2VyIExha2UtTFAgSW50ZWdy
YXRlZCBTZW5zb3IgSHViCglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3lj
bGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJC
LSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0g
REVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJ
TlR4KwoJTGF0ZW5jeTogMAoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDE2CglS
ZWdpb24gMDogTWVtb3J5IGF0IDYwM2QxYjAwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJs
ZSkgW3NpemU9NjRLXQoJQ2FwYWJpbGl0aWVzOiBbODBdIFBvd2VyIE1hbmFnZW1lbnQgdmVy
c2lvbiAzCgkJRmxhZ3M6IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBN
RShEMCssRDEtLEQyLSxEM2hvdCssRDNjb2xkLSkKCQlTdGF0dXM6IEQwIE5vU29mdFJzdCsg
UE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzkwXSBW
ZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExlbj0xNCA8Pz4KCUtlcm5lbCBkcml2ZXIg
aW4gdXNlOiBpbnRlbF9pc2hfaXBjCglLZXJuZWwgbW9kdWxlczogaW50ZWxfaXNoX2lwYwoK
MDA6MTQuMCBVU0IgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gVGlnZXIgTGFrZS1M
UCBVU0IgMy4yIEdlbiAyeDEgeEhDSSBIb3N0IENvbnRyb2xsZXIgKHJldiAyMCkgKHByb2ct
aWYgMzAgW1hIQ0ldKQoJU3Vic3lzdGVtOiBEZWxsIFRpZ2VyIExha2UtTFAgVVNCIDMuMiBH
ZW4gMngxIHhIQ0kgSG9zdCBDb250cm9sbGVyCglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFz
dGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBT
RVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RC
MkIrIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+
U0VSUi0gPFBFUlItIElOVHgtCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTQy
CglSZWdpb24gMDogTWVtb3J5IGF0IDYwM2QxYTAwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNo
YWJsZSkgW3NpemU9NjRLXQoJQ2FwYWJpbGl0aWVzOiBbNzBdIFBvd2VyIE1hbmFnZW1lbnQg
dmVyc2lvbiAyCgkJRmxhZ3M6IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9Mzc1
bUEgUE1FKEQwLSxEMS0sRDItLEQzaG90KyxEM2NvbGQrKQoJCVN0YXR1czogRDMgTm9Tb2Z0
UnN0KyBQTUUtRW5hYmxlKyBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVzOiBb
ODBdIE1TSTogRW5hYmxlKyBDb3VudD0xLzggTWFza2FibGUtIDY0Yml0KwoJCUFkZHJlc3M6
IDAwMDAwMDAwZmVlMTAwMDQgIERhdGE6IDQwMjIKCUNhcGFiaWxpdGllczogWzkwXSBWZW5k
b3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExlbj0xNCA8Pz4KCUNhcGFiaWxpdGllczogW2Iw
XSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IExlbj0wMCA8Pz4KCUtlcm5lbCBkcml2
ZXIgaW4gdXNlOiB4aGNpX2hjZAoJS2VybmVsIG1vZHVsZXM6IHhoY2lfcGNpCgowMDoxNC4y
IFJBTSBtZW1vcnk6IEludGVsIENvcnBvcmF0aW9uIFRpZ2VyIExha2UtTFAgU2hhcmVkIFNS
QU0gKHJldiAyMCkKCVN1YnN5c3RlbTogRGVsbCBUaWdlciBMYWtlLUxQIFNoYXJlZCBTUkFN
CglDb250cm9sOiBJL08tIE1lbS0gQnVzTWFzdGVyLSBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZH
QVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQoJU3Rh
dHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRB
Ym9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJUmVnaW9uIDA6
IE1lbW9yeSBhdCA2MDNkMWRjMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNh
YmxlZF0gW3NpemU9MTZLXQoJUmVnaW9uIDI6IE1lbW9yeSBhdCA2MDNkMWU3MDAwICg2NC1i
aXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0gW3NpemU9NEtdCglDYXBhYmlsaXRp
ZXM6IFs4MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBE
U0ktIEQxLSBEMi0gQXV4Q3VycmVudD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2Nv
bGQtKQoJCVN0YXR1czogRDAgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxl
PTAgUE1FLQoKMDA6MTUuMCBTZXJpYWwgYnVzIGNvbnRyb2xsZXIgWzBjODBdOiBJbnRlbCBD
b3Jwb3JhdGlvbiBUaWdlciBMYWtlLUxQIFNlcmlhbCBJTyBJMkMgQ29udHJvbGxlciAjMCAo
cmV2IDIwKQoJU3Vic3lzdGVtOiBEZWxsIFRpZ2VyIExha2UtTFAgU2VyaWFsIElPIEkyQyBD
b250cm9sbGVyCglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1l
bVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJ
TlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VM
PWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJ
TGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRlcwoJSW50ZXJydXB0OiBwaW4g
QSByb3V0ZWQgdG8gSVJRIDI3CglSZWdpb24gMDogTWVtb3J5IGF0IDQwMTcwMDAwMDAgKDY0
LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3ZpcnR1YWxdIFtzaXplPTRLXQoJQ2FwYWJpbGl0
aWVzOiBbODBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6IFBNRUNsay0g
RFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEtLEQyLSxEM2hvdC0sRDNj
b2xkLSkKCQlTdGF0dXM6IEQzIE5vU29mdFJzdCsgUE1FLUVuYWJsZS0gRFNlbD0wIERTY2Fs
ZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzkwXSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRp
b246IExlbj0xNCA8Pz4KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBpbnRlbC1scHNzCglLZXJu
ZWwgbW9kdWxlczogaW50ZWxfbHBzc19wY2kKCjAwOjE1LjEgU2VyaWFsIGJ1cyBjb250cm9s
bGVyIFswYzgwXTogSW50ZWwgQ29ycG9yYXRpb24gVGlnZXIgTGFrZS1MUCBTZXJpYWwgSU8g
STJDIENvbnRyb2xsZXIgIzEgKHJldiAyMCkKCVN1YnN5c3RlbTogRGVsbCBUaWdlciBMYWtl
LUxQIFNlcmlhbCBJTyBJMkMgQ29udHJvbGxlcgoJQ29udHJvbDogSS9PLSBNZW0rIEJ1c01h
c3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0g
U0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0
QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5T
RVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAsIENhY2hlIExpbmUgU2l6ZTogNjQgYnl0
ZXMKCUludGVycnVwdDogcGluIEIgcm91dGVkIHRvIElSUSA0MAoJUmVnaW9uIDA6IE1lbW9y
eSBhdCA0MDE3MDAxMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFt2aXJ0dWFsXSBb
c2l6ZT00S10KCUNhcGFiaWxpdGllczogWzgwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24g
MwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDAt
LEQxLSxEMi0sRDNob3QtLEQzY29sZC0pCgkJU3RhdHVzOiBEMyBOb1NvZnRSc3QrIFBNRS1F
bmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFs5MF0gVmVuZG9y
IFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MTQgPD8+CglLZXJuZWwgZHJpdmVyIGluIHVz
ZTogaW50ZWwtbHBzcwoJS2VybmVsIG1vZHVsZXM6IGludGVsX2xwc3NfcGNpCgowMDoxNi4w
IENvbW11bmljYXRpb24gY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gVGlnZXIgTGFr
ZS1MUCBNYW5hZ2VtZW50IEVuZ2luZSBJbnRlcmZhY2UgKHJldiAyMCkKCVN1YnN5c3RlbTog
RGVsbCBUaWdlciBMYWtlLUxQIE1hbmFnZW1lbnQgRW5naW5lIEludGVyZmFjZQoJQ29udHJv
bDogSS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0g
UGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2Fw
KyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxU
QWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVy
cnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxNzEKCVJlZ2lvbiAwOiBNZW1vcnkgYXQgNjAz
ZDFlNDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT00S10KCUNhcGFiaWxp
dGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGst
IERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDAtLEQxLSxEMi0sRDNob3QrLEQz
Y29sZC0pCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2Nh
bGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFs4Y10gTVNJOiBFbmFibGUrIENvdW50PTEvMSBN
YXNrYWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDBmZWUwMjAwNCAgRGF0YTogNDAy
NQoJQ2FwYWJpbGl0aWVzOiBbYTRdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogTGVu
PTE0IDw/PgoJS2VybmVsIGRyaXZlciBpbiB1c2U6IG1laV9tZQoJS2VybmVsIG1vZHVsZXM6
IG1laV9tZQoKMDA6MTkuMCBTZXJpYWwgYnVzIGNvbnRyb2xsZXIgWzBjODBdOiBJbnRlbCBD
b3Jwb3JhdGlvbiBUaWdlciBMYWtlLUxQIFNlcmlhbCBJTyBJMkMgQ29udHJvbGxlciAjNCAo
cmV2IDIwKQoJU3Vic3lzdGVtOiBEZWxsIFRpZ2VyIExha2UtTFAgU2VyaWFsIElPIEkyQyBD
b250cm9sbGVyCglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1l
bVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJ
TlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VM
PWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJ
TGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRlcwoJSW50ZXJydXB0OiBwaW4g
QSByb3V0ZWQgdG8gSVJRIDMxCglSZWdpb24gMDogTWVtb3J5IGF0IDQwMTcwMDIwMDAgKDY0
LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NEtdCglDYXBhYmlsaXRpZXM6IFs4MF0g
UG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBE
Mi0gQXV4Q3VycmVudD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2NvbGQtKQoJCVN0
YXR1czogRDMgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJ
Q2FwYWJpbGl0aWVzOiBbOTBdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogTGVuPTE0
IDw/PgoJS2VybmVsIGRyaXZlciBpbiB1c2U6IGludGVsLWxwc3MKCUtlcm5lbCBtb2R1bGVz
OiBpbnRlbF9scHNzX3BjaQoKMDA6MTkuMSBTZXJpYWwgYnVzIGNvbnRyb2xsZXIgWzBjODBd
OiBJbnRlbCBDb3Jwb3JhdGlvbiBUaWdlciBMYWtlLUxQIFNlcmlhbCBJTyBJMkMgQ29udHJv
bGxlciAjNSAocmV2IDIwKQoJU3Vic3lzdGVtOiBEZWxsIFRpZ2VyIExha2UtTFAgU2VyaWFs
IElPIEkyQyBDb250cm9sbGVyCglDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVj
Q3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0
QjJCLSBEaXNJTlR4LQoJU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVy
ci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJS
LSBJTlR4LQoJTGF0ZW5jeTogMCwgQ2FjaGUgTGluZSBTaXplOiA2NCBieXRlcwoJSW50ZXJy
dXB0OiBwaW4gQiByb3V0ZWQgdG8gSVJRIDMyCglSZWdpb24gMDogTWVtb3J5IGF0IDQwMTcw
MDMwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3ZpcnR1YWxdIFtzaXplPTRLXQoJ
Q2FwYWJpbGl0aWVzOiBbODBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6
IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEtLEQyLSxE
M2hvdC0sRDNjb2xkLSkKCQlTdGF0dXM6IEQzIE5vU29mdFJzdCsgUE1FLUVuYWJsZS0gRFNl
bD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzkwXSBWZW5kb3IgU3BlY2lmaWMg
SW5mb3JtYXRpb246IExlbj0xNCA8Pz4KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBpbnRlbC1s
cHNzCglLZXJuZWwgbW9kdWxlczogaW50ZWxfbHBzc19wY2kKCjAwOjFjLjAgUENJIGJyaWRn
ZTogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIGEwYjggKHJldiAyMCkgKHByb2ctaWYgMDAg
W05vcm1hbCBkZWNvZGVdKQoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5
Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIy
Qi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnIt
IERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0g
SU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAxMjMK
CUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTU2LCBzdWJvcmRpbmF0ZT01Niwgc2VjLWxh
dGVuY3k9MAoJSS9PIGJlaGluZCBicmlkZ2U6IFtkaXNhYmxlZF0KCU1lbW9yeSBiZWhpbmQg
YnJpZGdlOiA4YzMwMDAwMC04YzNmZmZmZiBbc2l6ZT0xTV0KCVByZWZldGNoYWJsZSBtZW1v
cnkgYmVoaW5kIGJyaWRnZTogW2Rpc2FibGVkXQoJU2Vjb25kYXJ5IHN0YXR1czogNjZNSHot
IEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9y
dCsgPFNFUlItIDxQRVJSLQoJQnJpZGdlQ3RsOiBQYXJpdHktIFNFUlIrIE5vSVNBLSBWR0Et
IFZHQTE2LSBNQWJvcnQtID5SZXNldC0gRmFzdEIyQi0KCQlQcmlEaXNjVG1yLSBTZWNEaXNj
VG1yLSBEaXNjVG1yU3RhdC0gRGlzY1RtclNFUlJFbi0KCUNhcGFiaWxpdGllczogWzQwXSBF
eHByZXNzICh2MikgUm9vdCBQb3J0IChTbG90KyksIE1TSSAwMAoJCURldkNhcDoJTWF4UGF5
bG9hZCAyNTYgYnl0ZXMsIFBoYW50RnVuYyAwCgkJCUV4dFRhZy0gUkJFKwoJCURldkN0bDoJ
Q29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcS0KCQkJUmx4ZE9yZC0g
RXh0VGFnLSBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9vcC0KCQkJTWF4UGF5bG9hZCAxMjgg
Ynl0ZXMsIE1heFJlYWRSZXEgMTI4IGJ5dGVzCgkJRGV2U3RhOglDb3JyRXJyLSBOb25GYXRh
bEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3IrIFRyYW5zUGVuZC0KCQlMbmtDYXA6
CVBvcnQgIzEsIFNwZWVkIDVHVC9zLCBXaWR0aCB4MSwgQVNQTSBMMSwgRXhpdCBMYXRlbmN5
IEwxIDwxNnVzCgkJCUNsb2NrUE0tIFN1cnByaXNlLSBMTEFjdFJlcCsgQndOb3QrIEFTUE1P
cHRDb21wKwoJCUxua0N0bDoJQVNQTSBMMSBFbmFibGVkOyBSQ0IgNjQgYnl0ZXMsIERpc2Fi
bGVkLSBDb21tQ2xrKwoJCQlFeHRTeW5jaC0gQ2xvY2tQTS0gQXV0V2lkRGlzLSBCV0ludC0g
QXV0QldJbnQtCgkJTG5rU3RhOglTcGVlZCA1R1QvcyAob2spLCBXaWR0aCB4MSAob2spCgkJ
CVRyRXJyLSBUcmFpbi0gU2xvdENsaysgRExBY3RpdmUrIEJXTWdtdCsgQUJXTWdtdC0KCQlT
bHRDYXA6CUF0dG5CdG4tIFB3ckN0cmwtIE1STC0gQXR0bkluZC0gUHdySW5kLSBIb3RQbHVn
LSBTdXJwcmlzZS0KCQkJU2xvdCAjMCwgUG93ZXJMaW1pdCAxMC4wMDBXOyBJbnRlcmxvY2st
IE5vQ29tcGwrCgkJU2x0Q3RsOglFbmFibGU6IEF0dG5CdG4tIFB3ckZsdC0gTVJMLSBQcmVz
RGV0LSBDbWRDcGx0LSBIUElycS0gTGlua0NoZy0KCQkJQ29udHJvbDogQXR0bkluZCBVbmtu
b3duLCBQd3JJbmQgVW5rbm93biwgUG93ZXItIEludGVybG9jay0KCQlTbHRTdGE6CVN0YXR1
czogQXR0bkJ0bi0gUG93ZXJGbHQtIE1STC0gQ21kQ3BsdC0gUHJlc0RldCsgSW50ZXJsb2Nr
LQoJCQlDaGFuZ2VkOiBNUkwtIFByZXNEZXQtIExpbmtTdGF0ZSsKCQlSb290Q2FwOiBDUlNW
aXNpYmxlLQoJCVJvb3RDdGw6IEVyckNvcnJlY3RhYmxlLSBFcnJOb24tRmF0YWwtIEVyckZh
dGFsLSBQTUVJbnRFbmErIENSU1Zpc2libGUtCgkJUm9vdFN0YTogUE1FIFJlcUlEIDAwMDAs
IFBNRVN0YXR1cy0gUE1FUGVuZGluZy0KCQlEZXZDYXAyOiBDb21wbGV0aW9uIFRpbWVvdXQ6
IFJhbmdlIEFCQywgVGltZW91dERpcysgTlJPUHJQclAtIExUUisKCQkJIDEwQml0VGFnQ29t
cC0gMTBCaXRUYWdSZXEtIE9CRkYgTm90IFN1cHBvcnRlZCwgRXh0Rm10LSBFRVRMUFByZWZp
eC0KCQkJIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uIE5vdCBTdXBwb3J0ZWQsIEVtZXJnZW5j
eVBvd2VyUmVkdWN0aW9uSW5pdC0KCQkJIEZSUy0gTE4gU3lzdGVtIENMUyBOb3QgU3VwcG9y
dGVkLCBUUEhDb21wLSBFeHRUUEhDb21wLSBBUklGd2QrCgkJCSBBdG9taWNPcHNDYXA6IFJv
dXRpbmctIDMyYml0LSA2NGJpdC0gMTI4Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24g
VGltZW91dDogNTB1cyB0byA1MG1zLCBUaW1lb3V0RGlzLSBMVFIrIE9CRkYgRGlzYWJsZWQs
IEFSSUZ3ZC0KCQkJIEF0b21pY09wc0N0bDogUmVxRW4tIEVncmVzc0JsY2stCgkJTG5rQ2Fw
MjogU3VwcG9ydGVkIExpbmsgU3BlZWRzOiAyLjUtNUdUL3MsIENyb3NzbGluay0gUmV0aW1l
ci0gMlJldGltZXJzLSBEUlMtCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDVHVC9z
LCBFbnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBOb3Jt
YWwgT3BlcmF0aW5nIFJhbmdlLCBFbnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5j
ZVNPUy0KCQkJIENvbXBsaWFuY2UgRGUtZW1waGFzaXM6IC02ZEIKCQlMbmtTdGEyOiBDdXJy
ZW50IERlLWVtcGhhc2lzIExldmVsOiAtNmRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZS0gRXF1
YWxpemF0aW9uUGhhc2UxLQoJCQkgRXF1YWxpemF0aW9uUGhhc2UyLSBFcXVhbGl6YXRpb25Q
aGFzZTMtIExpbmtFcXVhbGl6YXRpb25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGltZXJz
LSBDcm9zc2xpbmtSZXM6IHVuc3VwcG9ydGVkCglDYXBhYmlsaXRpZXM6IFs4MF0gTVNJOiBF
bmFibGUrIENvdW50PTEvMSBNYXNrYWJsZS0gNjRiaXQtCgkJQWRkcmVzczogZmVlMjAwMDQg
IERhdGE6IDQwMjEKCUNhcGFiaWxpdGllczogWzkwXSBTdWJzeXN0ZW06IERlbGwgRGV2aWNl
IDA5OTEKCUNhcGFiaWxpdGllczogW2EwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJ
CUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDArLEQx
LSxEMi0sRDNob3QrLEQzY29sZCspCgkJU3RhdHVzOiBEMyBOb1NvZnRSc3QtIFBNRS1FbmFi
bGUrIERTZWw9MCBEU2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIEFkdmFu
Y2VkIEVycm9yIFJlcG9ydGluZwoJCVVFU3RhOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBs
dFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJl
cS0gQUNTVmlvbC0KCQlVRU1zazoJRExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21w
bHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zp
b2wtCgkJVUVTdnJ0OglETFArIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFicnQt
IFVueENtcGx0LSBSeE9GKyBNYWxmVExQKyBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlD
RVN0YToJUnhFcnItIEJhZFRMUC0gQmFkRExMUC0gUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5v
bkZhdGFsRXJyLQoJCUNFTXNrOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0g
VGltZW91dC0gQWR2Tm9uRmF0YWxFcnIrCgkJQUVSQ2FwOglGaXJzdCBFcnJvciBQb2ludGVy
OiAwMCwgRUNSQ0dlbkNhcC0gRUNSQ0dlbkVuLSBFQ1JDQ2hrQ2FwLSBFQ1JDQ2hrRW4tCgkJ
CU11bHRIZHJSZWNDYXAtIE11bHRIZHJSZWNFbi0gVExQUGZ4UHJlcy0gSGRyTG9nQ2FwLQoJ
CUhlYWRlckxvZzogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAKCQlSb290
Q21kOiBDRVJwdEVuLSBORkVScHRFbi0gRkVScHRFbi0KCQlSb290U3RhOiBDRVJjdmQtIE11
bHRDRVJjdmQtIFVFUmN2ZC0gTXVsdFVFUmN2ZC0KCQkJIEZpcnN0RmF0YWwtIE5vbkZhdGFs
TXNnLSBGYXRhbE1zZy0gSW50TXNnIDAKCQlFcnJvclNyYzogRVJSX0NPUjogMDAwMCBFUlJf
RkFUQUwvTk9ORkFUQUw6IDAwMDAKCUNhcGFiaWxpdGllczogWzIyMCB2MV0gQWNjZXNzIENv
bnRyb2wgU2VydmljZXMKCQlBQ1NDYXA6CVNyY1ZhbGlkKyBUcmFuc0JsaysgUmVxUmVkaXIr
IENtcGx0UmVkaXIrIFVwc3RyZWFtRndkKyBFZ3Jlc3NDdHJsLSBEaXJlY3RUcmFucy0KCQlB
Q1NDdGw6CVNyY1ZhbGlkLSBUcmFuc0Jsay0gUmVxUmVkaXItIENtcGx0UmVkaXItIFVwc3Ry
ZWFtRndkLSBFZ3Jlc3NDdHJsLSBEaXJlY3RUcmFucy0KCUNhcGFiaWxpdGllczogWzE1MCB2
MV0gUHJlY2lzaW9uIFRpbWUgTWVhc3VyZW1lbnQKCQlQVE1DYXA6IFJlcXVlc3RlcjotIFJl
c3BvbmRlcjorIFJvb3Q6KwoJCVBUTUNsb2NrR3JhbnVsYXJpdHk6IDRucwoJCVBUTUNvbnRy
b2w6IEVuYWJsZWQ6KyBSb290U2VsZWN0ZWQ6KwoJCVBUTUVmZmVjdGl2ZUdyYW51bGFyaXR5
OiBVbmtub3duCglDYXBhYmlsaXRpZXM6IFsyMDAgdjFdIEwxIFBNIFN1YnN0YXRlcwoJCUwx
U3ViQ2FwOiBQQ0ktUE1fTDEuMisgUENJLVBNX0wxLjErIEFTUE1fTDEuMisgQVNQTV9MMS4x
KyBMMV9QTV9TdWJzdGF0ZXMrCgkJCSAgUG9ydENvbW1vbk1vZGVSZXN0b3JlVGltZT00MHVz
IFBvcnRUUG93ZXJPblRpbWU9NDR1cwoJCUwxU3ViQ3RsMTogUENJLVBNX0wxLjIrIFBDSS1Q
TV9MMS4xKyBBU1BNX0wxLjIrIEFTUE1fTDEuMSsKCQkJICAgVF9Db21tb25Nb2RlPTcwdXMg
TFRSMS4yX1RocmVzaG9sZD05ODMwNG5zCgkJTDFTdWJDdGwyOiBUX1B3ck9uPTQ0dXMKCUNh
cGFiaWxpdGllczogW2EwMCB2MV0gRG93bnN0cmVhbSBQb3J0IENvbnRhaW5tZW50CgkJRHBj
Q2FwOglJTlQgTXNnICMwLCBSUEV4dCsgUG9pc29uZWRUTFArIFN3VHJpZ2dlcisgUlAgUElP
IExvZyA0LCBETF9BY3RpdmVFcnIrCgkJRHBjQ3RsOglUcmlnZ2VyOjAgQ21wbC0gSU5ULSBF
cnJDb3ItIFBvaXNvbmVkVExQLSBTd1RyaWdnZXItIERMX0FjdGl2ZUVyci0KCQlEcGNTdGE6
CVRyaWdnZXItIFJlYXNvbjowMCBJTlQtIFJQQnVzeS0gVHJpZ2dlckV4dDowMCBSUCBQSU8g
RXJyUHRyOjFmCgkJU291cmNlOgkwMDAwCglLZXJuZWwgZHJpdmVyIGluIHVzZTogcGNpZXBv
cnQKCjAwOjFkLjAgUENJIGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIGEwYjMg
KHJldiAyMCkgKHByb2ctaWYgMDAgW05vcm1hbCBkZWNvZGVdKQoJQ29udHJvbDogSS9PKyBN
ZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBT
dGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1czogQ2FwKyA2Nk1Iei0g
VURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtIDxN
QWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCUxhdGVuY3k6IDAKCUludGVycnVwdDogcGlu
IEQgcm91dGVkIHRvIElSUSAxMjQKCUJ1czogcHJpbWFyeT0wMCwgc2Vjb25kYXJ5PTU3LCBz
dWJvcmRpbmF0ZT01Nywgc2VjLWxhdGVuY3k9MAoJSS9PIGJlaGluZCBicmlkZ2U6IFtkaXNh
YmxlZF0KCU1lbW9yeSBiZWhpbmQgYnJpZGdlOiA4YzIwMDAwMC04YzJmZmZmZiBbc2l6ZT0x
TV0KCVByZWZldGNoYWJsZSBtZW1vcnkgYmVoaW5kIGJyaWRnZTogW2Rpc2FibGVkXQoJU2Vj
b25kYXJ5IHN0YXR1czogNjZNSHotIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRB
Ym9ydC0gPFRBYm9ydC0gPE1BYm9ydCsgPFNFUlItIDxQRVJSLQoJQnJpZGdlQ3RsOiBQYXJp
dHktIFNFUlIrIE5vSVNBLSBWR0EtIFZHQTE2LSBNQWJvcnQtID5SZXNldC0gRmFzdEIyQi0K
CQlQcmlEaXNjVG1yLSBTZWNEaXNjVG1yLSBEaXNjVG1yU3RhdC0gRGlzY1RtclNFUlJFbi0K
CUNhcGFiaWxpdGllczogWzQwXSBFeHByZXNzICh2MikgUm9vdCBQb3J0IChTbG90KyksIE1T
SSAwMAoJCURldkNhcDoJTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIFBoYW50RnVuYyAwCgkJCUV4
dFRhZy0gUkJFKwoJCURldkN0bDoJQ29yckVyci0gTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBV
bnN1cFJlcS0KCQkJUmx4ZE9yZC0gRXh0VGFnLSBQaGFudEZ1bmMtIEF1eFB3ci0gTm9Tbm9v
cC0KCQkJTWF4UGF5bG9hZCAyNTYgYnl0ZXMsIE1heFJlYWRSZXEgMTI4IGJ5dGVzCgkJRGV2
U3RhOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLSBBdXhQd3Ir
IFRyYW5zUGVuZC0KCQlMbmtDYXA6CVBvcnQgIzEyLCBTcGVlZCA4R1QvcywgV2lkdGggeDEs
IEFTUE0gTDEsIEV4aXQgTGF0ZW5jeSBMMSA8MTZ1cwoJCQlDbG9ja1BNLSBTdXJwcmlzZS0g
TExBY3RSZXArIEJ3Tm90KyBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gTDEgRW5hYmxl
ZDsgUkNCIDY0IGJ5dGVzLCBEaXNhYmxlZC0gQ29tbUNsaysKCQkJRXh0U3luY2gtIENsb2Nr
UE0tIEF1dFdpZERpcy0gQldJbnQtIEF1dEJXSW50LQoJCUxua1N0YToJU3BlZWQgOEdUL3Mg
KG9rKSwgV2lkdGggeDEgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0aXZl
KyBCV01nbXQrIEFCV01nbXQtCgkJU2x0Q2FwOglBdHRuQnRuLSBQd3JDdHJsLSBNUkwtIEF0
dG5JbmQtIFB3ckluZC0gSG90UGx1Zy0gU3VycHJpc2UtCgkJCVNsb3QgIzExLCBQb3dlckxp
bWl0IDEwLjAwMFc7IEludGVybG9jay0gTm9Db21wbCsKCQlTbHRDdGw6CUVuYWJsZTogQXR0
bkJ0bi0gUHdyRmx0LSBNUkwtIFByZXNEZXQtIENtZENwbHQtIEhQSXJxLSBMaW5rQ2hnLQoJ
CQlDb250cm9sOiBBdHRuSW5kIFVua25vd24sIFB3ckluZCBVbmtub3duLCBQb3dlci0gSW50
ZXJsb2NrLQoJCVNsdFN0YToJU3RhdHVzOiBBdHRuQnRuLSBQb3dlckZsdC0gTVJMLSBDbWRD
cGx0LSBQcmVzRGV0KyBJbnRlcmxvY2stCgkJCUNoYW5nZWQ6IE1STC0gUHJlc0RldC0gTGlu
a1N0YXRlKwoJCVJvb3RDYXA6IENSU1Zpc2libGUtCgkJUm9vdEN0bDogRXJyQ29ycmVjdGFi
bGUtIEVyck5vbi1GYXRhbC0gRXJyRmF0YWwtIFBNRUludEVuYSsgQ1JTVmlzaWJsZS0KCQlS
b290U3RhOiBQTUUgUmVxSUQgMDAwMCwgUE1FU3RhdHVzLSBQTUVQZW5kaW5nLQoJCURldkNh
cDI6IENvbXBsZXRpb24gVGltZW91dDogUmFuZ2UgQUJDLCBUaW1lb3V0RGlzKyBOUk9QclBy
UC0gTFRSKwoJCQkgMTBCaXRUYWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBOb3QgU3VwcG9y
dGVkLCBFeHRGbXQtIEVFVExQUHJlZml4LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24g
Tm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBM
TiBTeXN0ZW0gQ0xTIE5vdCBTdXBwb3J0ZWQsIFRQSENvbXAtIEV4dFRQSENvbXAtIEFSSUZ3
ZCsKCQkJIEF0b21pY09wc0NhcDogUm91dGluZy0gMzJiaXQtIDY0Yml0LSAxMjhiaXRDQVMt
CgkJRGV2Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXRE
aXMtIExUUisgT0JGRiBEaXNhYmxlZCwgQVJJRndkLQoJCQkgQXRvbWljT3BzQ3RsOiBSZXFF
bi0gRWdyZXNzQmxjay0KCQlMbmtDYXAyOiBTdXBwb3J0ZWQgTGluayBTcGVlZHM6IDIuNS04
R1QvcywgQ3Jvc3NsaW5rLSBSZXRpbWVyLSAyUmV0aW1lcnMtIERSUy0KCQlMbmtDdGwyOiBU
YXJnZXQgTGluayBTcGVlZDogOEdUL3MsIEVudGVyQ29tcGxpYW5jZS0gU3BlZWREaXMtCgkJ
CSBUcmFuc21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRpbmcgUmFuZ2UsIEVudGVyTW9kaWZp
ZWRDb21wbGlhbmNlLSBDb21wbGlhbmNlU09TLQoJCQkgQ29tcGxpYW5jZSBEZS1lbXBoYXNp
czogLTZkQgoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFzaXMgTGV2ZWw6IC0zLjVkQiwg
RXF1YWxpemF0aW9uQ29tcGxldGUrIEVxdWFsaXphdGlvblBoYXNlMSsKCQkJIEVxdWFsaXph
dGlvblBoYXNlMisgRXF1YWxpemF0aW9uUGhhc2UzKyBMaW5rRXF1YWxpemF0aW9uUmVxdWVz
dC0KCQkJIFJldGltZXItIDJSZXRpbWVycy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJ
Q2FwYWJpbGl0aWVzOiBbODBdIE1TSTogRW5hYmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0
Yml0LQoJCUFkZHJlc3M6IGZlZTQwMDA0ICBEYXRhOiA0MDIxCglDYXBhYmlsaXRpZXM6IFs5
MF0gU3Vic3lzdGVtOiBEZWxsIERldmljZSAwOTkxCglDYXBhYmlsaXRpZXM6IFthMF0gUG93
ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMKCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0g
QXV4Q3VycmVudD0wbUEgUE1FKEQwKyxEMS0sRDItLEQzaG90KyxEM2NvbGQrKQoJCVN0YXR1
czogRDAgTm9Tb2Z0UnN0LSBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQoJQ2Fw
YWJpbGl0aWVzOiBbMTAwIHYxXSBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcKCQlVRVN0YToJ
RExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhP
Ri0gTWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVNc2s6CURMUC0gU0RF
Uy0gVExQLSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZU
TFAtIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQoJCVVFU3ZydDoJRExQKyBTREVTLSBUTFAt
IEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRisgTWFsZlRMUCsgRUNS
Qy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJQ0VTdGE6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAt
IFJvbGxvdmVyLSBUaW1lb3V0LSBBZHZOb25GYXRhbEVyci0KCQlDRU1zazoJUnhFcnItIEJh
ZFRMUC0gQmFkRExMUC0gUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyKwoJCUFF
UkNhcDoJRmlyc3QgRXJyb3IgUG9pbnRlcjogMDAsIEVDUkNHZW5DYXAtIEVDUkNHZW5Fbi0g
RUNSQ0Noa0NhcC0gRUNSQ0Noa0VuLQoJCQlNdWx0SGRyUmVjQ2FwLSBNdWx0SGRyUmVjRW4t
IFRMUFBmeFByZXMtIEhkckxvZ0NhcC0KCQlIZWFkZXJMb2c6IDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwIDAwMDAwMDAwCgkJUm9vdENtZDogQ0VScHRFbi0gTkZFUnB0RW4tIEZFUnB0
RW4tCgkJUm9vdFN0YTogQ0VSY3ZkLSBNdWx0Q0VSY3ZkLSBVRVJjdmQtIE11bHRVRVJjdmQt
CgkJCSBGaXJzdEZhdGFsLSBOb25GYXRhbE1zZy0gRmF0YWxNc2ctIEludE1zZyAwCgkJRXJy
b3JTcmM6IEVSUl9DT1I6IDAwMDAgRVJSX0ZBVEFML05PTkZBVEFMOiAwMDAwCglDYXBhYmls
aXRpZXM6IFsyMjAgdjFdIEFjY2VzcyBDb250cm9sIFNlcnZpY2VzCgkJQUNTQ2FwOglTcmNW
YWxpZCsgVHJhbnNCbGsrIFJlcVJlZGlyKyBDbXBsdFJlZGlyKyBVcHN0cmVhbUZ3ZCsgRWdy
ZXNzQ3RybC0gRGlyZWN0VHJhbnMtCgkJQUNTQ3RsOglTcmNWYWxpZC0gVHJhbnNCbGstIFJl
cVJlZGlyLSBDbXBsdFJlZGlyLSBVcHN0cmVhbUZ3ZC0gRWdyZXNzQ3RybC0gRGlyZWN0VHJh
bnMtCglDYXBhYmlsaXRpZXM6IFsxNTAgdjFdIFByZWNpc2lvbiBUaW1lIE1lYXN1cmVtZW50
CgkJUFRNQ2FwOiBSZXF1ZXN0ZXI6LSBSZXNwb25kZXI6KyBSb290OisKCQlQVE1DbG9ja0dy
YW51bGFyaXR5OiA0bnMKCQlQVE1Db250cm9sOiBFbmFibGVkOisgUm9vdFNlbGVjdGVkOisK
CQlQVE1FZmZlY3RpdmVHcmFudWxhcml0eTogVW5rbm93bgoJQ2FwYWJpbGl0aWVzOiBbMjAw
IHYxXSBMMSBQTSBTdWJzdGF0ZXMKCQlMMVN1YkNhcDogUENJLVBNX0wxLjIrIFBDSS1QTV9M
MS4xKyBBU1BNX0wxLjIrIEFTUE1fTDEuMSsgTDFfUE1fU3Vic3RhdGVzKwoJCQkgIFBvcnRD
b21tb25Nb2RlUmVzdG9yZVRpbWU9NDB1cyBQb3J0VFBvd2VyT25UaW1lPTQ0dXMKCQlMMVN1
YkN0bDE6IFBDSS1QTV9MMS4yKyBQQ0ktUE1fTDEuMSsgQVNQTV9MMS4yKyBBU1BNX0wxLjEr
CgkJCSAgIFRfQ29tbW9uTW9kZT02MHVzIExUUjEuMl9UaHJlc2hvbGQ9OTgzMDRucwoJCUwx
U3ViQ3RsMjogVF9Qd3JPbj02MHVzCglDYXBhYmlsaXRpZXM6IFthMzAgdjFdIFNlY29uZGFy
eSBQQ0kgRXhwcmVzcwoJCUxua0N0bDM6IExua0VxdUludHJydXB0RW4tIFBlcmZvcm1FcXUt
CgkJTGFuZUVyclN0YXQ6IDAKCUNhcGFiaWxpdGllczogW2EwMCB2MV0gRG93bnN0cmVhbSBQ
b3J0IENvbnRhaW5tZW50CgkJRHBjQ2FwOglJTlQgTXNnICMwLCBSUEV4dCsgUG9pc29uZWRU
TFArIFN3VHJpZ2dlcisgUlAgUElPIExvZyA0LCBETF9BY3RpdmVFcnIrCgkJRHBjQ3RsOglU
cmlnZ2VyOjAgQ21wbC0gSU5ULSBFcnJDb3ItIFBvaXNvbmVkVExQLSBTd1RyaWdnZXItIERM
X0FjdGl2ZUVyci0KCQlEcGNTdGE6CVRyaWdnZXItIFJlYXNvbjowMCBJTlQtIFJQQnVzeS0g
VHJpZ2dlckV4dDowMCBSUCBQSU8gRXJyUHRyOjFmCgkJU291cmNlOgkwMDAwCglLZXJuZWwg
ZHJpdmVyIGluIHVzZTogcGNpZXBvcnQKCjAwOjFlLjAgQ29tbXVuaWNhdGlvbiBjb250cm9s
bGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBUaWdlciBMYWtlLUxQIFNlcmlhbCBJTyBVQVJUIENv
bnRyb2xsZXIgIzAgKHJldiAyMCkKCVN1YnN5c3RlbTogRGVsbCBUaWdlciBMYWtlLUxQIFNl
cmlhbCBJTyBVQVJUIENvbnRyb2xsZXIKCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIr
IFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlIt
IEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0g
UGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0g
PFBFUlItIElOVHgtCglMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6IDY0IGJ5dGVzCglJ
bnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTYKCVJlZ2lvbiAwOiBNZW1vcnkgYXQg
NDAxNzAwNDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT00S10KCUNhcGFi
aWxpdGllczogWzgwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVD
bGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDAtLEQxLSxEMi0sRDNob3Qt
LEQzY29sZC0pCgkJU3RhdHVzOiBEMCBOb1NvZnRSc3QrIFBNRS1FbmFibGUtIERTZWw9MCBE
U2NhbGU9MCBQTUUtCglDYXBhYmlsaXRpZXM6IFs5MF0gVmVuZG9yIFNwZWNpZmljIEluZm9y
bWF0aW9uOiBMZW49MTQgPD8+CglLZXJuZWwgZHJpdmVyIGluIHVzZTogaW50ZWwtbHBzcwoJ
S2VybmVsIG1vZHVsZXM6IGludGVsX2xwc3NfcGNpCgowMDoxZi4wIElTQSBicmlkZ2U6IElu
dGVsIENvcnBvcmF0aW9uIFRpZ2VyIExha2UtTFAgTFBDIENvbnRyb2xsZXIgKHJldiAyMCkK
CVN1YnN5c3RlbTogRGVsbCBUaWdlciBMYWtlLUxQIExQQyBDb250cm9sbGVyCglDb250cm9s
OiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQ
YXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBDYXAt
IDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0gPFRB
Ym9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoKMDA6MWYu
MyBNdWx0aW1lZGlhIGF1ZGlvIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIFRpZ2Vy
IExha2UtTFAgU21hcnQgU291bmQgVGVjaG5vbG9neSBBdWRpbyBDb250cm9sbGVyIChyZXYg
MjApCglTdWJzeXN0ZW06IERlbGwgVGlnZXIgTGFrZS1MUCBTbWFydCBTb3VuZCBUZWNobm9s
b2d5IEF1ZGlvIENvbnRyb2xsZXIKCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNw
ZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZh
c3RCMkItIERpc0lOVHgrCglTdGF0dXM6IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFy
RXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBF
UlItIElOVHgtCglMYXRlbmN5OiA2NAoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJR
IDE3NAoJUmVnaW9uIDA6IE1lbW9yeSBhdCA2MDNkMWQ4MDAwICg2NC1iaXQsIG5vbi1wcmVm
ZXRjaGFibGUpIFtzaXplPTE2S10KCVJlZ2lvbiA0OiBNZW1vcnkgYXQgNjAzZDAwMDAwMCAo
NjQtYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xTV0KCUNhcGFiaWxpdGllczogWzUw
XSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMwoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEt
IEQyLSBBdXhDdXJyZW50PTU1bUEgUE1FKEQwLSxEMS0sRDItLEQzaG90KyxEM2NvbGQrKQoJ
CVN0YXR1czogRDAgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1F
LQoJQ2FwYWJpbGl0aWVzOiBbODBdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogTGVu
PTE0IDw/PgoJQ2FwYWJpbGl0aWVzOiBbNjBdIE1TSTogRW5hYmxlKyBDb3VudD0xLzEgTWFz
a2FibGUtIDY0Yml0KwoJCUFkZHJlc3M6IDAwMDAwMDAwZmVlMDQwMDQgIERhdGE6IDQwMjUK
CUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBzb2YtYXVkaW8tcGNpCglLZXJuZWwgbW9kdWxlczog
c25kX2hkYV9pbnRlbCwgc25kX3NvZl9wY2kKCjAwOjFmLjQgU01CdXM6IEludGVsIENvcnBv
cmF0aW9uIFRpZ2VyIExha2UtTFAgU01CdXMgQ29udHJvbGxlciAocmV2IDIwKQoJU3Vic3lz
dGVtOiBEZWxsIFRpZ2VyIExha2UtTFAgU01CdXMgQ29udHJvbGxlcgoJQ29udHJvbDogSS9P
KyBNZW0rIEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJy
LSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0KCVN0YXR1czogQ2FwLSA2Nk1I
ei0gVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9y
dC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJSW50ZXJydXB0OiBwaW4gQSByb3V0
ZWQgdG8gSVJRIDE2CglSZWdpb24gMDogTWVtb3J5IGF0IDYwM2QxZTAwMDAgKDY0LWJpdCwg
bm9uLXByZWZldGNoYWJsZSkgW3NpemU9MjU2XQoJUmVnaW9uIDQ6IEkvTyBwb3J0cyBhdCBl
ZmEwIFtzaXplPTMyXQoJS2VybmVsIGRyaXZlciBpbiB1c2U6IGk4MDFfc21idXMKCUtlcm5l
bCBtb2R1bGVzOiBpMmNfaTgwMQoKMDA6MWYuNSBTZXJpYWwgYnVzIGNvbnRyb2xsZXIgWzBj
ODBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBUaWdlciBMYWtlLUxQIFNQSSBDb250cm9sbGVyIChy
ZXYgMjApCglTdWJzeXN0ZW06IERlbGwgVGlnZXIgTGFrZS1MUCBTUEkgQ29udHJvbGxlcgoJ
Q29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FT
bm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsKCVN0YXR1
czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJv
cnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0KCVJlZ2lvbiAwOiBN
ZW1vcnkgYXQgNzA4MDAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NEtd
CgowMTowMC4wIE5vbi1Wb2xhdGlsZSBtZW1vcnkgY29udHJvbGxlcjogU2Ftc3VuZyBFbGVj
dHJvbmljcyBDbyBMdGQgTlZNZSBTU0QgQ29udHJvbGxlciBTTTk4MS9QTTk4MS9QTTk4MyAo
cHJvZy1pZiAwMiBbTlZNIEV4cHJlc3NdKQoJU3Vic3lzdGVtOiBTYW1zdW5nIEVsZWN0cm9u
aWNzIENvIEx0ZCBOVk1lIFNTRCBDb250cm9sbGVyIFNNOTgxL1BNOTgxL1BNOTgzCglDb250
cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29w
LSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4KwoJU3RhdHVzOiBD
YXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRBYm9ydC0g
PFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQoJTGF0ZW5jeTogMAoJSW50
ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDE2CglOVU1BIG5vZGU6IDAKCVJlZ2lvbiAw
OiBNZW1vcnkgYXQgOGM0MDAwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9
MTZLXQoJQ2FwYWJpbGl0aWVzOiBbNDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJ
RmxhZ3M6IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEt
LEQyLSxEM2hvdC0sRDNjb2xkLSkKCQlTdGF0dXM6IEQwIE5vU29mdFJzdCsgUE1FLUVuYWJs
ZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0KCUNhcGFiaWxpdGllczogWzUwXSBNU0k6IEVuYWJs
ZS0gQ291bnQ9MS8zMiBNYXNrYWJsZS0gNjRiaXQrCgkJQWRkcmVzczogMDAwMDAwMDAwMDAw
MDAwMCAgRGF0YTogMDAwMAoJQ2FwYWJpbGl0aWVzOiBbNzBdIEV4cHJlc3MgKHYyKSBFbmRw
b2ludCwgTVNJIDAwCgkJRGV2Q2FwOglNYXhQYXlsb2FkIDI1NiBieXRlcywgUGhhbnRGdW5j
IDAsIExhdGVuY3kgTDBzIHVubGltaXRlZCwgTDEgdW5saW1pdGVkCgkJCUV4dFRhZy0gQXR0
bkJ0bi0gQXR0bkluZC0gUHdySW5kLSBSQkUrIEZMUmVzZXQrIFNsb3RQb3dlckxpbWl0IDc1
LjAwMFcKCQlEZXZDdGw6CUNvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBS
ZXEtCgkJCVJseGRPcmQrIEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3ArIEZM
UmVzZXQtCgkJCU1heFBheWxvYWQgMjU2IGJ5dGVzLCBNYXhSZWFkUmVxIDUxMiBieXRlcwoJ
CURldlN0YToJQ29yckVycisgTm9uRmF0YWxFcnItIEZhdGFsRXJyLSBVbnN1cFJlcSsgQXV4
UHdyLSBUcmFuc1BlbmQtCgkJTG5rQ2FwOglQb3J0ICMwLCBTcGVlZCA4R1QvcywgV2lkdGgg
eDQsIEFTUE0gTDEsIEV4aXQgTGF0ZW5jeSBMMSA8NjR1cwoJCQlDbG9ja1BNKyBTdXJwcmlz
ZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gTDEgRW5h
YmxlZDsgUkNCIDY0IGJ5dGVzLCBEaXNhYmxlZC0gQ29tbUNsaysKCQkJRXh0U3luY2gtIENs
b2NrUE0rIEF1dFdpZERpcy0gQldJbnQtIEF1dEJXSW50LQoJCUxua1N0YToJU3BlZWQgOEdU
L3MgKG9rKSwgV2lkdGggeDQgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERMQWN0
aXZlLSBCV01nbXQtIEFCV01nbXQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0OiBS
YW5nZSBBQkNELCBUaW1lb3V0RGlzKyBOUk9QclByUC0gTFRSKwoJCQkgMTBCaXRUYWdDb21w
LSAxMEJpdFRhZ1JlcS0gT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQtIEVFVExQUHJlZml4
LQoJCQkgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRlZCwgRW1lcmdlbmN5
UG93ZXJSZWR1Y3Rpb25Jbml0LQoJCQkgRlJTLSBUUEhDb21wLSBFeHRUUEhDb21wLQoJCQkg
QXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQtIDEyOGJpdENBUy0KCQlEZXZDdGwyOiBDb21w
bGV0aW9uIFRpbWVvdXQ6IDUwdXMgdG8gNTBtcywgVGltZW91dERpcy0gTFRSKyBPQkZGIERp
c2FibGVkLAoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0KCQlMbmtDYXAyOiBTdXBwb3J0ZWQg
TGluayBTcGVlZHM6IDIuNS04R1QvcywgQ3Jvc3NsaW5rLSBSZXRpbWVyLSAyUmV0aW1lcnMt
IERSUy0KCQlMbmtDdGwyOiBUYXJnZXQgTGluayBTcGVlZDogOEdUL3MsIEVudGVyQ29tcGxp
YW5jZS0gU3BlZWREaXMtCgkJCSBUcmFuc21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRpbmcg
UmFuZ2UsIEVudGVyTW9kaWZpZWRDb21wbGlhbmNlLSBDb21wbGlhbmNlU09TLQoJCQkgQ29t
cGxpYW5jZSBEZS1lbXBoYXNpczogLTZkQgoJCUxua1N0YTI6IEN1cnJlbnQgRGUtZW1waGFz
aXMgTGV2ZWw6IC02ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRlKyBFcXVhbGl6YXRpb25QaGFz
ZTErCgkJCSBFcXVhbGl6YXRpb25QaGFzZTIrIEVxdWFsaXphdGlvblBoYXNlMysgTGlua0Vx
dWFsaXphdGlvblJlcXVlc3QtCgkJCSBSZXRpbWVyLSAyUmV0aW1lcnMtIENyb3NzbGlua1Jl
czogdW5zdXBwb3J0ZWQKCUNhcGFiaWxpdGllczogW2IwXSBNU0ktWDogRW5hYmxlKyBDb3Vu
dD0zMyBNYXNrZWQtCgkJVmVjdG9yIHRhYmxlOiBCQVI9MCBvZmZzZXQ9MDAwMDMwMDAKCQlQ
QkE6IEJBUj0wIG9mZnNldD0wMDAwMjAwMAoJQ2FwYWJpbGl0aWVzOiBbMTAwIHYyXSBBZHZh
bmNlZCBFcnJvciBSZXBvcnRpbmcKCQlVRVN0YToJRExQLSBTREVTLSBUTFAtIEZDUC0gQ21w
bHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBS
ZXEtIEFDU1Zpb2wtCgkJVUVNc2s6CURMUC0gU0RFUy0gVExQLSBGQ1AtIENtcGx0VE8tIENt
cGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtIEVDUkMtIFVuc3VwUmVxLSBBQ1NW
aW9sLQoJCVVFU3ZydDoJRExQKyBTREVTKyBUTFAtIEZDUCsgQ21wbHRUTy0gQ21wbHRBYnJ0
LSBVbnhDbXBsdC0gUnhPRisgTWFsZlRMUCsgRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJ
Q0VTdGE6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJvbGxvdmVyLSBUaW1lb3V0LSBBZHZO
b25GYXRhbEVycisKCQlDRU1zazoJUnhFcnItIEJhZFRMUC0gQmFkRExMUC0gUm9sbG92ZXIt
IFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyKwoJCUFFUkNhcDoJRmlyc3QgRXJyb3IgUG9pbnRl
cjogMDAsIEVDUkNHZW5DYXArIEVDUkNHZW5Fbi0gRUNSQ0Noa0NhcCsgRUNSQ0Noa0VuLQoJ
CQlNdWx0SGRyUmVjQ2FwKyBNdWx0SGRyUmVjRW4tIFRMUFBmeFByZXMtIEhkckxvZ0NhcC0K
CQlIZWFkZXJMb2c6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwCglDYXBh
YmlsaXRpZXM6IFsxNDggdjFdIERldmljZSBTZXJpYWwgTnVtYmVyIDAwLTAwLTAwLTAwLTAw
LTAwLTAwLTAwCglDYXBhYmlsaXRpZXM6IFsxNTggdjFdIFBvd2VyIEJ1ZGdldGluZyA8Pz4K
CUNhcGFiaWxpdGllczogWzE2OCB2MV0gU2Vjb25kYXJ5IFBDSSBFeHByZXNzCgkJTG5rQ3Rs
MzogTG5rRXF1SW50cnJ1cHRFbi0gUGVyZm9ybUVxdS0KCQlMYW5lRXJyU3RhdDogMAoJQ2Fw
YWJpbGl0aWVzOiBbMTg4IHYxXSBMYXRlbmN5IFRvbGVyYW5jZSBSZXBvcnRpbmcKCQlNYXgg
c25vb3AgbGF0ZW5jeTogMzE0NTcyOG5zCgkJTWF4IG5vIHNub29wIGxhdGVuY3k6IDMxNDU3
MjhucwoJQ2FwYWJpbGl0aWVzOiBbMTkwIHYxXSBMMSBQTSBTdWJzdGF0ZXMKCQlMMVN1YkNh
cDogUENJLVBNX0wxLjIrIFBDSS1QTV9MMS4xKyBBU1BNX0wxLjIrIEFTUE1fTDEuMSsgTDFf
UE1fU3Vic3RhdGVzKwoJCQkgIFBvcnRDb21tb25Nb2RlUmVzdG9yZVRpbWU9MTB1cyBQb3J0
VFBvd2VyT25UaW1lPTEwdXMKCQlMMVN1YkN0bDE6IFBDSS1QTV9MMS4yKyBQQ0ktUE1fTDEu
MSsgQVNQTV9MMS4yKyBBU1BNX0wxLjErCgkJCSAgIFRfQ29tbW9uTW9kZT0wdXMgTFRSMS4y
X1RocmVzaG9sZD05ODMwNG5zCgkJTDFTdWJDdGwyOiBUX1B3ck9uPTUwdXMKCUtlcm5lbCBk
cml2ZXIgaW4gdXNlOiBudm1lCglLZXJuZWwgbW9kdWxlczogbnZtZQoKNTY6MDAuMCBOZXR3
b3JrIGNvbnRyb2xsZXI6IFF1YWxjb21tIERldmljZSAxMTAxIChyZXYgMDEpCglTdWJzeXN0
ZW06IEJpZ2Zvb3QgTmV0d29ya3MsIEluYy4gRGV2aWNlIGE1MDEKCUNvbnRyb2w6IEkvTy0g
TWVtKyBCdXNNYXN0ZXItIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0g
U3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtCglTdGF0dXM6IENhcCsgNjZNSHot
IFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0LSA8VEFib3J0LSA8
TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglSZWdpb24gMDogTWVtb3J5IGF0IDhjMzAw
MDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTFNXQoJQ2FwYWJpbGl0aWVz
OiBbNDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6IFBNRUNsay0gRFNJ
LSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCssRDEtLEQyLSxEM2hvdCssRDNjb2xk
KykKCQlTdGF0dXM6IEQwIE5vU29mdFJzdCsgUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0w
IFBNRS0KCUNhcGFiaWxpdGllczogWzUwXSBNU0k6IEVuYWJsZS0gQ291bnQ9MS8zMiBNYXNr
YWJsZSsgNjRiaXQtCgkJQWRkcmVzczogMDAwMDAwMDAgIERhdGE6IDAwMDAKCQlNYXNraW5n
OiAwMDAwMDAwMCAgUGVuZGluZzogMDAwMDAwMDAKCUNhcGFiaWxpdGllczogWzcwXSBFeHBy
ZXNzICh2MikgRW5kcG9pbnQsIE1TSSAwMAoJCURldkNhcDoJTWF4UGF5bG9hZCAxMjggYnl0
ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5IEwwcyB1bmxpbWl0ZWQsIEwxIHVubGltaXRlZAoJ
CQlFeHRUYWctIEF0dG5CdG4tIEF0dG5JbmQtIFB3ckluZC0gUkJFKyBGTFJlc2V0LSBTbG90
UG93ZXJMaW1pdCAxMC4wMDBXCgkJRGV2Q3RsOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0
YWxFcnItIFVuc3VwUmVxLQoJCQlSbHhkT3JkKyBFeHRUYWctIFBoYW50RnVuYy0gQXV4UHdy
LSBOb1Nub29wKwoJCQlNYXhQYXlsb2FkIDEyOCBieXRlcywgTWF4UmVhZFJlcSA1MTIgYnl0
ZXMKCQlEZXZTdGE6CUNvcnJFcnIrIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEr
IEF1eFB3cisgVHJhbnNQZW5kLQoJCUxua0NhcDoJUG9ydCAjMCwgU3BlZWQgOEdUL3MsIFdp
ZHRoIHgxLCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRlbmN5IEwwcyA8MXVzLCBMMSA8NjR1cwoJ
CQlDbG9ja1BNLSBTdXJwcmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29tcCsKCQlM
bmtDdGw6CUFTUE0gTDEgRW5hYmxlZDsgUkNCIDY0IGJ5dGVzLCBEaXNhYmxlZC0gQ29tbUNs
aysKCQkJRXh0U3luY2gtIENsb2NrUE0tIEF1dFdpZERpcy0gQldJbnQtIEF1dEJXSW50LQoJ
CUxua1N0YToJU3BlZWQgNUdUL3MgKGRvd25ncmFkZWQpLCBXaWR0aCB4MSAob2spCgkJCVRy
RXJyLSBUcmFpbi0gU2xvdENsaysgRExBY3RpdmUtIEJXTWdtdC0gQUJXTWdtdC0KCQlEZXZD
YXAyOiBDb21wbGV0aW9uIFRpbWVvdXQ6IFJhbmdlIEFCQ0QsIFRpbWVvdXREaXMrIE5ST1By
UHJQLSBMVFIrCgkJCSAxMEJpdFRhZ0NvbXAtIDEwQml0VGFnUmVxLSBPQkZGIE5vdCBTdXBw
b3J0ZWQsIEV4dEZtdC0gRUVUTFBQcmVmaXgtCgkJCSBFbWVyZ2VuY3lQb3dlclJlZHVjdGlv
biBOb3QgU3VwcG9ydGVkLCBFbWVyZ2VuY3lQb3dlclJlZHVjdGlvbkluaXQtCgkJCSBGUlMt
IFRQSENvbXArIEV4dFRQSENvbXAtCgkJCSBBdG9taWNPcHNDYXA6IDMyYml0LSA2NGJpdC0g
MTI4Yml0Q0FTLQoJCURldkN0bDI6IENvbXBsZXRpb24gVGltZW91dDogNTB1cyB0byA1MG1z
LCBUaW1lb3V0RGlzLSBMVFIrIE9CRkYgRGlzYWJsZWQsCgkJCSBBdG9taWNPcHNDdGw6IFJl
cUVuLQoJCUxua0NhcDI6IFN1cHBvcnRlZCBMaW5rIFNwZWVkczogMi41LThHVC9zLCBDcm9z
c2xpbmstIFJldGltZXItIDJSZXRpbWVycy0gRFJTLQoJCUxua0N0bDI6IFRhcmdldCBMaW5r
IFNwZWVkOiA1R1QvcywgRW50ZXJDb21wbGlhbmNlLSBTcGVlZERpcy0KCQkJIFRyYW5zbWl0
IE1hcmdpbjogTm9ybWFsIE9wZXJhdGluZyBSYW5nZSwgRW50ZXJNb2RpZmllZENvbXBsaWFu
Y2UtIENvbXBsaWFuY2VTT1MtCgkJCSBDb21wbGlhbmNlIERlLWVtcGhhc2lzOiAtNmRCCgkJ
TG5rU3RhMjogQ3VycmVudCBEZS1lbXBoYXNpcyBMZXZlbDogLTZkQiwgRXF1YWxpemF0aW9u
Q29tcGxldGUtIEVxdWFsaXphdGlvblBoYXNlMS0KCQkJIEVxdWFsaXphdGlvblBoYXNlMi0g
RXF1YWxpemF0aW9uUGhhc2UzLSBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0KCQkJIFJldGlt
ZXItIDJSZXRpbWVycy0gQ3Jvc3NsaW5rUmVzOiB1bnN1cHBvcnRlZAoJQ2FwYWJpbGl0aWVz
OiBbMTAwIHYyXSBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcKCQlVRVN0YToJRExQLSBTREVT
LSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0gTWFsZlRM
UC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wtCgkJVUVNc2s6CURMUC0gU0RFUy0gVExQLSBG
Q1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtIEVDUkMt
IFVuc3VwUmVxLSBBQ1NWaW9sLQoJCVVFU3ZydDoJRExQKyBTREVTKyBUTFAtIEZDUCsgQ21w
bHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRisgTWFsZlRMUCsgRUNSQy0gVW5zdXBS
ZXEtIEFDU1Zpb2wtCgkJQ0VTdGE6CVJ4RXJyLSBCYWRUTFAtIEJhZERMTFAtIFJvbGxvdmVy
LSBUaW1lb3V0LSBBZHZOb25GYXRhbEVycisKCQlDRU1zazoJUnhFcnItIEJhZFRMUC0gQmFk
RExMUC0gUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5vbkZhdGFsRXJyKwoJCUFFUkNhcDoJRmly
c3QgRXJyb3IgUG9pbnRlcjogMDAsIEVDUkNHZW5DYXArIEVDUkNHZW5Fbi0gRUNSQ0Noa0Nh
cCsgRUNSQ0Noa0VuLQoJCQlNdWx0SGRyUmVjQ2FwLSBNdWx0SGRyUmVjRW4tIFRMUFBmeFBy
ZXMtIEhkckxvZ0NhcC0KCQlIZWFkZXJMb2c6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAw
IDAwMDAwMDAwCglDYXBhYmlsaXRpZXM6IFsxNDggdjFdIFNlY29uZGFyeSBQQ0kgRXhwcmVz
cwoJCUxua0N0bDM6IExua0VxdUludHJydXB0RW4tIFBlcmZvcm1FcXUtCgkJTGFuZUVyclN0
YXQ6IDAKCUNhcGFiaWxpdGllczogWzE1OCB2MV0gVHJhbnNhY3Rpb24gUHJvY2Vzc2luZyBI
aW50cwoJCU5vIHN0ZWVyaW5nIHRhYmxlIGF2YWlsYWJsZQoJQ2FwYWJpbGl0aWVzOiBbMWU0
IHYxXSBMYXRlbmN5IFRvbGVyYW5jZSBSZXBvcnRpbmcKCQlNYXggc25vb3AgbGF0ZW5jeTog
MzE0NTcyOG5zCgkJTWF4IG5vIHNub29wIGxhdGVuY3k6IDMxNDU3MjhucwoJQ2FwYWJpbGl0
aWVzOiBbMWVjIHYxXSBMMSBQTSBTdWJzdGF0ZXMKCQlMMVN1YkNhcDogUENJLVBNX0wxLjIr
IFBDSS1QTV9MMS4xKyBBU1BNX0wxLjIrIEFTUE1fTDEuMSsgTDFfUE1fU3Vic3RhdGVzKwoJ
CQkgIFBvcnRDb21tb25Nb2RlUmVzdG9yZVRpbWU9NzB1cyBQb3J0VFBvd2VyT25UaW1lPTB1
cwoJCUwxU3ViQ3RsMTogUENJLVBNX0wxLjIrIFBDSS1QTV9MMS4xKyBBU1BNX0wxLjIrIEFT
UE1fTDEuMSsKCQkJICAgVF9Db21tb25Nb2RlPTB1cyBMVFIxLjJfVGhyZXNob2xkPTk4MzA0
bnMKCQlMMVN1YkN0bDI6IFRfUHdyT249NDR1cwoJS2VybmVsIG1vZHVsZXM6IGF0aDExa19w
Y2kKCjU3OjAwLjAgVW5hc3NpZ25lZCBjbGFzcyBbZmYwMF06IFJlYWx0ZWsgU2VtaWNvbmR1
Y3RvciBDby4sIEx0ZC4gUlRTNTI2MCBQQ0kgRXhwcmVzcyBDYXJkIFJlYWRlciAocmV2IDAx
KQoJU3Vic3lzdGVtOiBEZWxsIFJUUzUyNjAgUENJIEV4cHJlc3MgQ2FyZCBSZWFkZXIKCUNv
bnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25v
b3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgrCglTdGF0dXM6
IENhcCsgNjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9ZmFzdCA+VEFib3J0
LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtCglMYXRlbmN5OiAwCglJ
bnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMTQ0CglSZWdpb24gMDogTWVtb3J5IGF0
IDhjMjAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTRLXQoJQ2FwYWJp
bGl0aWVzOiBbNDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzCgkJRmxhZ3M6IFBNRUNs
ay0gRFNJLSBEMSsgRDIrIEF1eEN1cnJlbnQ9Mzc1bUEgUE1FKEQwLSxEMSssRDIrLEQzaG90
KyxEM2NvbGQrKQoJCVN0YXR1czogRDAgTm9Tb2Z0UnN0LSBQTUUtRW5hYmxlLSBEU2VsPTAg
RFNjYWxlPTAgUE1FLQoJQ2FwYWJpbGl0aWVzOiBbNTBdIE1TSTogRW5hYmxlKyBDb3VudD0x
LzEgTWFza2FibGUtIDY0Yml0KwoJCUFkZHJlc3M6IDAwMDAwMDAwZmVlMjAwMDQgIERhdGE6
IDQwMjIKCUNhcGFiaWxpdGllczogWzcwXSBFeHByZXNzICh2MikgRW5kcG9pbnQsIE1TSSAw
MAoJCURldkNhcDoJTWF4UGF5bG9hZCA1MTIgYnl0ZXMsIFBoYW50RnVuYyAwLCBMYXRlbmN5
IEwwcyB1bmxpbWl0ZWQsIEwxIHVubGltaXRlZAoJCQlFeHRUYWctIEF0dG5CdG4tIEF0dG5J
bmQtIFB3ckluZC0gUkJFKyBGTFJlc2V0LSBTbG90UG93ZXJMaW1pdCAxMC4wMDBXCgkJRGV2
Q3RsOglDb3JyRXJyLSBOb25GYXRhbEVyci0gRmF0YWxFcnItIFVuc3VwUmVxLQoJCQlSbHhk
T3JkKyBFeHRUYWctIFBoYW50RnVuYy0gQXV4UHdyLSBOb1Nub29wLQoJCQlNYXhQYXlsb2Fk
IDI1NiBieXRlcywgTWF4UmVhZFJlcSA1MTIgYnl0ZXMKCQlEZXZTdGE6CUNvcnJFcnIrIE5v
bkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXErIEF1eFB3cisgVHJhbnNQZW5kLQoJCUxu
a0NhcDoJUG9ydCAjMCwgU3BlZWQgOEdUL3MsIFdpZHRoIHgxLCBBU1BNIEwwcyBMMSwgRXhp
dCBMYXRlbmN5IEwwcyB1bmxpbWl0ZWQsIEwxIHVubGltaXRlZAoJCQlDbG9ja1BNKyBTdXJw
cmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBBU1BNT3B0Q29tcCsKCQlMbmtDdGw6CUFTUE0gTDEg
RW5hYmxlZDsgUkNCIDY0IGJ5dGVzLCBEaXNhYmxlZC0gQ29tbUNsay0KCQkJRXh0U3luY2gt
IENsb2NrUE0rIEF1dFdpZERpcy0gQldJbnQtIEF1dEJXSW50LQoJCUxua1N0YToJU3BlZWQg
OEdUL3MgKG9rKSwgV2lkdGggeDEgKG9rKQoJCQlUckVyci0gVHJhaW4tIFNsb3RDbGsrIERM
QWN0aXZlLSBCV01nbXQtIEFCV01nbXQtCgkJRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1lb3V0
OiBOb3QgU3VwcG9ydGVkLCBUaW1lb3V0RGlzKyBOUk9QclByUC0gTFRSKwoJCQkgMTBCaXRU
YWdDb21wLSAxMEJpdFRhZ1JlcS0gT0JGRiBWaWEgbWVzc2FnZS9XQUtFIywgRXh0Rm10LSBF
RVRMUFByZWZpeC0KCQkJIEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uIE5vdCBTdXBwb3J0ZWQs
IEVtZXJnZW5jeVBvd2VyUmVkdWN0aW9uSW5pdC0KCQkJIEZSUy0gVFBIQ29tcC0gRXh0VFBI
Q29tcC0KCQkJIEF0b21pY09wc0NhcDogMzJiaXQtIDY0Yml0LSAxMjhiaXRDQVMtCgkJRGV2
Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMtIExU
UisgT0JGRiBEaXNhYmxlZCwKCQkJIEF0b21pY09wc0N0bDogUmVxRW4tCgkJTG5rQ2FwMjog
U3VwcG9ydGVkIExpbmsgU3BlZWRzOiAyLjUtOEdUL3MsIENyb3NzbGluay0gUmV0aW1lci0g
MlJldGltZXJzLSBEUlMtCgkJTG5rQ3RsMjogVGFyZ2V0IExpbmsgU3BlZWQ6IDhHVC9zLCBF
bnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQoJCQkgVHJhbnNtaXQgTWFyZ2luOiBOb3JtYWwg
T3BlcmF0aW5nIFJhbmdlLCBFbnRlck1vZGlmaWVkQ29tcGxpYW5jZS0gQ29tcGxpYW5jZVNP
Uy0KCQkJIENvbXBsaWFuY2UgRGUtZW1waGFzaXM6IC02ZEIKCQlMbmtTdGEyOiBDdXJyZW50
IERlLWVtcGhhc2lzIExldmVsOiAtNmRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZSsgRXF1YWxp
emF0aW9uUGhhc2UxKwoJCQkgRXF1YWxpemF0aW9uUGhhc2UyKyBFcXVhbGl6YXRpb25QaGFz
ZTMrIExpbmtFcXVhbGl6YXRpb25SZXF1ZXN0LQoJCQkgUmV0aW1lci0gMlJldGltZXJzLSBD
cm9zc2xpbmtSZXM6IHVuc3VwcG9ydGVkCglDYXBhYmlsaXRpZXM6IFsxMDAgdjJdIEFkdmFu
Y2VkIEVycm9yIFJlcG9ydGluZwoJCVVFU3RhOglETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBs
dFRPLSBDbXBsdEFicnQtIFVueENtcGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJl
cS0gQUNTVmlvbC0KCQlVRU1zazoJRExQLSBTREVTLSBUTFAtIEZDUC0gQ21wbHRUTy0gQ21w
bHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zp
b2wtCgkJVUVTdnJ0OglETFArIFNERVMrIFRMUC0gRkNQKyBDbXBsdFRPLSBDbXBsdEFicnQt
IFVueENtcGx0LSBSeE9GKyBNYWxmVExQKyBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0KCQlD
RVN0YToJUnhFcnItIEJhZFRMUC0gQmFkRExMUC0gUm9sbG92ZXItIFRpbWVvdXQtIEFkdk5v
bkZhdGFsRXJyKwoJCUNFTXNrOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0g
VGltZW91dC0gQWR2Tm9uRmF0YWxFcnIrCgkJQUVSQ2FwOglGaXJzdCBFcnJvciBQb2ludGVy
OiAwMCwgRUNSQ0dlbkNhcCsgRUNSQ0dlbkVuLSBFQ1JDQ2hrQ2FwKyBFQ1JDQ2hrRW4tCgkJ
CU11bHRIZHJSZWNDYXAtIE11bHRIZHJSZWNFbi0gVExQUGZ4UHJlcy0gSGRyTG9nQ2FwLQoJ
CUhlYWRlckxvZzogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAKCUNhcGFi
aWxpdGllczogWzE0OCB2MV0gRGV2aWNlIFNlcmlhbCBOdW1iZXIgMDAtMDAtMDAtMDEtMDAt
NGMtZTAtMDAKCUNhcGFiaWxpdGllczogWzE1OCB2MV0gU2Vjb25kYXJ5IFBDSSBFeHByZXNz
CgkJTG5rQ3RsMzogTG5rRXF1SW50cnJ1cHRFbi0gUGVyZm9ybUVxdS0KCQlMYW5lRXJyU3Rh
dDogMAoJQ2FwYWJpbGl0aWVzOiBbMTY4IHYxXSBMYXRlbmN5IFRvbGVyYW5jZSBSZXBvcnRp
bmcKCQlNYXggc25vb3AgbGF0ZW5jeTogMzE0NTcyOG5zCgkJTWF4IG5vIHNub29wIGxhdGVu
Y3k6IDMxNDU3MjhucwoJQ2FwYWJpbGl0aWVzOiBbMTcwIHYxXSBMMSBQTSBTdWJzdGF0ZXMK
CQlMMVN1YkNhcDogUENJLVBNX0wxLjIrIFBDSS1QTV9MMS4xKyBBU1BNX0wxLjIrIEFTUE1f
TDEuMSsgTDFfUE1fU3Vic3RhdGVzKwoJCQkgIFBvcnRDb21tb25Nb2RlUmVzdG9yZVRpbWU9
NjB1cyBQb3J0VFBvd2VyT25UaW1lPTYwdXMKCQlMMVN1YkN0bDE6IFBDSS1QTV9MMS4yKyBQ
Q0ktUE1fTDEuMSsgQVNQTV9MMS4yKyBBU1BNX0wxLjErCgkJCSAgIFRfQ29tbW9uTW9kZT0w
dXMgTFRSMS4yX1RocmVzaG9sZD05ODMwNG5zCgkJTDFTdWJDdGwyOiBUX1B3ck9uPTYwdXMK
CUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBydHN4X3BjaQoJS2VybmVsIG1vZHVsZXM6IHJ0c3hf
cGNpCgo=
--------------A19D7DB9D2032D15CFFFD468--
