Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7637EA033B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 15:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfH1NbE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 09:31:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:4147 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfH1NbD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 09:31:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 06:31:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="171543003"
Received: from salle-mobl.ger.corp.intel.com ([10.252.30.254])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2019 06:30:57 -0700
Message-ID: <05013b4e3289110716a9b3ac642281d53c25c2d6.camel@intel.com>
Subject: Re: [linuxwifi] iwlwifi triggering multiple warns  if no PW
 supplied after boot
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Oliver Neukum <oneukum@suse.com>, linuxwifi@intel.com
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 28 Aug 2019 16:30:56 +0300
In-Reply-To: <1566996555.2465.4.camel@suse.com>
References: <1566996555.2465.4.camel@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Oliver,

We have a bug reported in bugzilla to track this issue:

https://bugzilla.kernel.org/show_bug.cgi?id=204151

We're going to send a patch to fix it soon.

Thanks for reporting!

--
Cheers,
Luca.


On Wed, 2019-08-28 at 14:49 +0200, Oliver Neukum wrote:
> Hi,
> 
> on rc5 I am seeing a lot of warnings if I fail to provide
> the PW for my WLAN (WPA Personal) after autologin.
> 
> 	Reagrds
> 		Oliver
> 
> [    0.000000] microcode: microcode updated early to revision 0xcc, date = 2019-04-01
> [    0.000000] Linux version 5.3.0-rc5-default+ (oneukum@linux-k53f) (gcc version 7.4.1 20190424 [gcc-7-branch revision 270538] (SUSE Linux)) #296 SMP Tue Aug 20 14:53:40 CEST 2019
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.3.0-rc5-default+ root=UUID=0db78229-3181-4a25-be9d-99ef682ca3f2 resume=/dev/disk/by-uuid/d7c4e6e1-b5ea-42f6-8d46-2ebb39e51b52 splash=silent quiet showopts resume=/dev/sda2 splash=silent quiet showopts
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> [    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> [    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000390fafff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000390fb000-0x0000000039c7efff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000039c7f000-0x0000000039e7efff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000039e7f000-0x0000000039efefff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x0000000039eff000-0x0000000039efffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000039f00000-0x000000003e7fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f00fa000-0x00000000f00fafff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f00fd000-0x00000000f00fdfff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000008bf7fffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] e820: update [mem 0x2215d018-0x2216c257] usable ==> usable
> [    0.000000] e820: update [mem 0x2215d018-0x2216c257] usable ==> usable
> [    0.000000] e820: update [mem 0x2214c018-0x2215c057] usable ==> usable
> [    0.000000] e820: update [mem 0x2214c018-0x2215c057] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000009dfff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000009e000-0x000000000009efff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000000009f000-0x000000000009ffff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000002214c017] usable
> [    0.000000] reserve setup_data: [mem 0x000000002214c018-0x000000002215c057] usable
> [    0.000000] reserve setup_data: [mem 0x000000002215c058-0x000000002215d017] usable
> [    0.000000] reserve setup_data: [mem 0x000000002215d018-0x000000002216c257] usable
> [    0.000000] reserve setup_data: [mem 0x000000002216c258-0x00000000390fafff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000390fb000-0x0000000039c7efff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000039c7f000-0x0000000039e7efff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x0000000039e7f000-0x0000000039efefff] ACPI data
> [    0.000000] reserve setup_data: [mem 0x0000000039eff000-0x0000000039efffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000039f00000-0x000000003e7fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000f00fa000-0x00000000f00fafff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000f00fd000-0x00000000f00fdfff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x00000008bf7fffff] usable
> [    0.000000] efi: EFI v2.40 by HP
> [    0.000000] efi:  ACPI=0x39efe000  ACPI 2.0=0x39efe014  SMBIOS=0x398db000  MPS=0x3993b000  ESRT=0x3906b660 
> [    0.000000] SMBIOS 2.7 present.
> [    0.000000] DMI: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [    0.000000] tsc: Detected 2600.000 MHz processor
> [    0.001066] tsc: Detected 2599.992 MHz TSC
> [    0.001066] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.001067] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.001072] last_pfn = 0x8bf800 max_arch_pfn = 0x400000000
> [    0.001075] MTRR default type: write-back
> [    0.001075] MTRR fixed ranges enabled:
> [    0.001076]   00000-9FFFF write-back
> [    0.001076]   A0000-BFFFF uncachable
> [    0.001077]   C0000-FFFFF write-protect
> [    0.001077] MTRR variable ranges enabled:
> [    0.001079]   0 base 0080000000 mask 7F80000000 uncachable
> [    0.001079]   1 base 0040000000 mask 7FC0000000 uncachable
> [    0.001080]   2 base 003C000000 mask 7FFC000000 uncachable
> [    0.001080]   3 disabled
> [    0.001080]   4 disabled
> [    0.001081]   5 disabled
> [    0.001081]   6 disabled
> [    0.001081]   7 disabled
> [    0.001082]   8 disabled
> [    0.001082]   9 disabled
> [    0.001349] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.001453] last_pfn = 0x39f00 max_arch_pfn = 0x400000000
> [    0.008537] esrt: ESRT header is not in the memory map.
> [    0.008542] check: Scanning 1 areas for low memory corruption
> [    0.008546] Using GB pages for direct mapping
> [    0.008547] BRK [0x1c801000, 0x1c801fff] PGTABLE
> [    0.008549] BRK [0x1c802000, 0x1c802fff] PGTABLE
> [    0.008549] BRK [0x1c803000, 0x1c803fff] PGTABLE
> [    0.008590] BRK [0x1c804000, 0x1c804fff] PGTABLE
> [    0.008591] BRK [0x1c805000, 0x1c805fff] PGTABLE
> [    0.008763] BRK [0x1c806000, 0x1c806fff] PGTABLE
> [    0.008819] Secure boot disabled
> [    0.008820] RAMDISK: [mem 0x2216d000-0x22b68fff]
> [    0.008825] ACPI: Early table checksum verification disabled
> [    0.008827] ACPI: RSDP 0x0000000039EFE014 000024 (v02 HPQOEM)
> [    0.008830] ACPI: XSDT 0x0000000039EFD0E8 0000BC (v01 HPQOEM SLIC-BPC 00000000      01000013)
> [    0.008834] ACPI: FACP 0x0000000039EF1000 0000F4 (v05 HPQOEM SLIC-BPC 00000000 HP   00000001)
> [    0.008838] ACPI: DSDT 0x0000000039EC9000 024F46 (v02 HPQOEM 80D5     00000000 INTL 20121018)
> [    0.008840] ACPI: FACS 0x0000000039E6B000 000040
> [    0.008841] ACPI: SSDT 0x0000000039EFC000 000108 (v02 HP     ShmTable 00000001 INTL 20121018)
> [    0.008843] ACPI: TCPA 0x0000000039EFA000 000032 (v02 HPQOEM EDK2     00000002      01000013)
> [    0.008845] ACPI: SSDT 0x0000000039EF9000 0003B8 (v02 HPQOEM TcgTable 00001000 INTL 20121018)
> [    0.008847] ACPI: UEFI 0x0000000039E7A000 000042 (v01 HPQOEM EDK2     00000002      01000013)
> [    0.008849] ACPI: SSDT 0x0000000039EF3000 0051FA (v02 SaSsdt SaSsdt   00003000 INTL 20121018)
> [    0.008851] ACPI: SSDT 0x0000000039EF2000 0005B1 (v01 Intel  PerfTune 00001000 INTL 20121018)
> [    0.008853] ACPI: HPET 0x0000000039EF0000 000038 (v01 HPQOEM 80D5     00000001 HP   00000001)
> [    0.008855] ACPI: APIC 0x0000000039EEF000 0000BC (v01 HPQOEM 80D5     00000001 HP   00000001)
> [    0.008857] ACPI: MCFG 0x0000000039EEE000 00003C (v01 HPQOEM 80D5     00000001 HP   00000001)
> [    0.008859] ACPI: SSDT 0x0000000039EC8000 00019A (v02 HPQOEM Sata0Ide 00001000 INTL 20121018)
> [    0.008861] ACPI: SSDT 0x0000000039EC7000 000729 (v01 HPQOEM PtidDevc 00001000 INTL 20121018)
> [    0.008863] ACPI: SSDT 0x0000000039EC6000 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 20121018)
> [    0.008865] ACPI: NHLT 0x0000000039EC5000 00002D (v00 INTEL  EDK2     00000002      01000013)
> [    0.008867] ACPI: SSDT 0x0000000039EC3000 001BC7 (v01 HP     AMDSGTBL 00001000 INTL 20121018)
> [    0.008869] ACPI: ASF! 0x0000000039EC2000 0000A5 (v32 HPQOEM  UYA     00000001 TFSM 000F4240)
> [    0.008871] ACPI: FPDT 0x0000000039EC1000 000044 (v01 HPQOEM EDK2     00000002      01000013)
> [    0.008873] ACPI: BGRT 0x0000000039EC0000 000038 (v01 HPQOEM EDK2     00000002      01000013)
> [    0.008874] ACPI: SSDT 0x0000000039EFB000 000260 (v02 HP     PwrCtlEv 00000001 INTL 20121018)
> [    0.008880] ACPI: Local APIC address 0xfee00000
> [    0.009032] No NUMA configuration found
> [    0.009033] Faking a node at [mem 0x0000000000000000-0x00000008bf7fffff]
> [    0.009041] NODE_DATA(0) allocated [mem 0x8bf7d5000-0x8bf7fefff]
> [    0.009239] Zone ranges:
> [    0.009240]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.009241]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.009242]   Normal   [mem 0x0000000100000000-0x00000008bf7fffff]
> [    0.009242]   Device   empty
> [    0.009243] Movable zone start for each node
> [    0.009245] Early memory node ranges
> [    0.009246]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
> [    0.009246]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
> [    0.009247]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
> [    0.009247]   node   0: [mem 0x0000000000100000-0x00000000390fafff]
> [    0.009248]   node   0: [mem 0x0000000039eff000-0x0000000039efffff]
> [    0.009248]   node   0: [mem 0x0000000100000000-0x00000008bf7fffff]
> [    0.009483] Zeroed struct page in unavailable ranges: 28519 pages
> [    0.009484] Initmem setup node 0 [mem 0x0000000000001000-0x00000008bf7fffff]
> [    0.009485] On node 0 totalpages: 8358041
> [    0.009485]   DMA zone: 64 pages used for memmap
> [    0.009486]   DMA zone: 24 pages reserved
> [    0.009486]   DMA zone: 3997 pages, LIFO batch:0
> [    0.009529]   DMA32 zone: 3588 pages used for memmap
> [    0.009530]   DMA32 zone: 229628 pages, LIFO batch:63
> [    0.014392]   Normal zone: 126944 pages used for memmap
> [    0.014393]   Normal zone: 8124416 pages, LIFO batch:63
> [    0.014766] Reserving Intel graphics memory at [mem 0x3c800000-0x3e7fffff]
> [    0.015167] ACPI: PM-Timer IO Port: 0x1808
> [    0.015169] ACPI: Local APIC address 0xfee00000
> [    0.015173] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.015174] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.015174] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.015175] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.015175] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> [    0.015175] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> [    0.015176] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> [    0.015176] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
> [    0.015202] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> [    0.015204] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.015205] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.015206] ACPI: IRQ0 used by override.
> [    0.015206] ACPI: IRQ9 used by override.
> [    0.015208] Using ACPI (MADT) for SMP configuration information
> [    0.015209] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.015214] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
> [    0.015225] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.015226] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
> [    0.015227] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
> [    0.015228] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    0.015229] PM: Registered nosave memory: [mem 0x2214c000-0x2214cfff]
> [    0.015230] PM: Registered nosave memory: [mem 0x2215c000-0x2215cfff]
> [    0.015231] PM: Registered nosave memory: [mem 0x2215d000-0x2215dfff]
> [    0.015232] PM: Registered nosave memory: [mem 0x2216c000-0x2216cfff]
> [    0.015233] PM: Registered nosave memory: [mem 0x390fb000-0x39c7efff]
> [    0.015233] PM: Registered nosave memory: [mem 0x39c7f000-0x39e7efff]
> [    0.015233] PM: Registered nosave memory: [mem 0x39e7f000-0x39efefff]
> [    0.015234] PM: Registered nosave memory: [mem 0x39f00000-0x3e7fffff]
> [    0.015235] PM: Registered nosave memory: [mem 0x3e800000-0xf00f9fff]
> [    0.015235] PM: Registered nosave memory: [mem 0xf00fa000-0xf00fafff]
> [    0.015236] PM: Registered nosave memory: [mem 0xf00fb000-0xf00fcfff]
> [    0.015236] PM: Registered nosave memory: [mem 0xf00fd000-0xf00fdfff]
> [    0.015236] PM: Registered nosave memory: [mem 0xf00fe000-0xfdffffff]
> [    0.015237] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
> [    0.015237] PM: Registered nosave memory: [mem 0xfe011000-0xffffffff]
> [    0.015238] [mem 0x3e800000-0xf00f9fff] available for PCI devices
> [    0.015239] Booting paravirtualized kernel on bare hardware
> [    0.015241] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.083946] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
> [    0.084090] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
> [    0.084095] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
> [    0.084096] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
> [    0.084115] Built 1 zonelists, mobility grouping on.  Total pages: 8227421
> [    0.084115] Policy zone: Normal
> [    0.084116] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.3.0-rc5-default+ root=UUID=0db78229-3181-4a25-be9d-99ef682ca3f2 resume=/dev/disk/by-uuid/d7c4e6e1-b5ea-42f6-8d46-2ebb39e51b52 splash=silent quiet showopts resume=/dev/sda2 splash=silent quiet showopts
> [    0.085384] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
> [    0.085960] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.086021] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.099163] Memory: 712808K/33432164K available (12291K kernel code, 2107K rwdata, 3796K rodata, 2728K init, 14260K bss, 928868K reserved, 0K cma-reserved)
> [    0.099269] Kernel/User page tables isolation: enabled
> [    0.099282] ftrace: allocating 34930 entries in 137 pages
> [    0.109152] rcu: Hierarchical RCU implementation.
> [    0.109153] rcu: 	RCU event tracing is enabled.
> [    0.109153] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
> [    0.109154] 	Tasks RCU enabled.
> [    0.109155] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.109155] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
> [    0.111257] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
> [    0.111560] random: get_random_bytes called from start_kernel+0x33e/0x522 with crng_init=0
> [    0.111680] Console: colour dummy device 80x25
> [    0.111682] printk: console [tty0] enabled
> [    0.111698] ACPI: Core revision 20190703
> [    0.111941] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> [    0.112004] APIC: Switch to symmetric I/O mode setup
> [    0.113198] x2apic: IRQ remapping doesn't support X2APIC mode
> [    0.117357] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.135905] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x257a34a6eea, max_idle_ns: 440795264358 ns
> [    0.135908] Calibrating delay loop (skipped), value calculated using timer frequency.. 5199.98 BogoMIPS (lpj=10399968)
> [    0.135909] pid_max: default: 32768 minimum: 301
> [    0.142101] LSM: Security Framework initializing
> [    0.142128] SELinux:  Initializing.
> [    0.142147] *** VALIDATE SELinux ***
> [    0.142221] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.142267] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.142389] *** VALIDATE proc ***
> [    0.142428] *** VALIDATE cgroup1 ***
> [    0.142428] *** VALIDATE cgroup2 ***
> [    0.142468] mce: CPU0: Thermal monitoring enabled (TM1)
> [    0.142484] process: using mwait in idle threads
> [    0.142486] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    0.142486] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> [    0.142488] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.142489] Spectre V2 : Mitigation: Full generic retpoline
> [    0.142490] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.142490] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [    0.142491] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.142492] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
> [    0.142493] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [    0.142495] MDS: Mitigation: Clear CPU buffers
> [    0.142677] Freeing SMP alternatives memory: 32K
> [    0.145407] TSC deadline timer enabled
> [    0.145411] smpboot: CPU0: Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz (family: 0x6, model: 0x5e, stepping: 0x3)
> [    0.145481] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    0.145486] ... version:                4
> [    0.145486] ... bit width:              48
> [    0.145486] ... generic registers:      4
> [    0.145487] ... value mask:             0000ffffffffffff
> [    0.145487] ... max period:             00007fffffffffff
> [    0.145487] ... fixed-purpose events:   3
> [    0.145488] ... event mask:             000000070000000f
> [    0.145520] rcu: Hierarchical SRCU implementation.
> [    0.146211] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.146270] smp: Bringing up secondary CPUs ...
> [    0.146338] x86: Booting SMP configuration:
> [    0.146339] .... node  #0, CPUs:      #1 #2 #3 #4
> [    0.149635] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> [    0.149635]  #5 #6 #7
> [    0.151975] smp: Brought up 1 node, 8 CPUs
> [    0.151975] smpboot: Max logical packages: 1
> [    0.151975] smpboot: Total of 8 processors activated (41599.87 BogoMIPS)
> [    0.243910] node 0 initialised, 7947622 pages in 92ms
> [    0.244425] devtmpfs: initialized
> [    0.244425] x86/mm: Memory block size: 128MB
> [    0.250430] PM: Registering ACPI NVS region [mem 0x39c7f000-0x39e7efff] (2097152 bytes)
> [    0.250430] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.250430] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
> [    0.250430] pinctrl core: initialized pinctrl subsystem
> [    0.250430] PM: RTC time: 11:18:04, date: 2019-08-28
> [    0.250430] NET: Registered protocol family 16
> [    0.250430] audit: initializing netlink subsys (disabled)
> [    0.250430] audit: type=2000 audit(1566991084.140:1): state=initialized audit_enabled=0 res=1
> [    0.250430] cpuidle: using governor ladder
> [    0.250430] cpuidle: using governor menu
> [    0.250430] KVM setup pv remote TLB flush
> [    0.250430] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.250430] ACPI: bus type PCI registered
> [    0.250430] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.250430] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
> [    0.250430] PCI: not using MMCONFIG
> [    0.250430] PCI: Using configuration type 1 for base access
> [    0.253404] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.253408] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.253408] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.368146] alg: No test for lzo-rle (lzo-rle-generic)
> [    0.368146] alg: No test for lzo-rle (lzo-rle-scomp)
> [    0.372047] ACPI: Added _OSI(Module Device)
> [    0.372047] ACPI: Added _OSI(Processor Device)
> [    0.372047] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.372047] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.372047] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.372047] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.372047] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    0.406697] ACPI: 10 ACPI AML tables successfully acquired and loaded
> [    0.408523] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.472053] ACPI: Dynamic OEM Table Load:
> [    0.472066] ACPI: SSDT 0xFFFF98B35BEB5000 0005DC (v02 PmRef  Cpu0Ist  00003000 INTL 20121018)
> [    0.473618] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
> [    0.473940] ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field [CAP1] at bit offset/length 64/32 exceeds size of target Buffer (64 bits) (20190703/dsopcode-203)
> [    0.473947] ACPI Error: Aborting method \_SB._OSC due to previous error (AE_AML_BUFFER_LIMIT) (20190703/psparse-531)
> [    0.474578] ACPI: Dynamic OEM Table Load:
> [    0.474584] ACPI: SSDT 0xFFFF98B35BE7A800 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 20121018)
> [    0.476583] ACPI: Dynamic OEM Table Load:
> [    0.476589] ACPI: SSDT 0xFFFF98B35BEB5800 0005AA (v02 PmRef  ApIst    00003000 INTL 20121018)
> [    0.478426] ACPI: Dynamic OEM Table Load:
> [    0.478431] ACPI: SSDT 0xFFFF98B35BF9BE00 000119 (v02 PmRef  ApCst    00003000 INTL 20121018)
> [    0.483244] ACPI: EC: EC started
> [    0.483245] ACPI: EC: interrupt blocked
> [    3.816197] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as first EC
> [    3.816199] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0x6e, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    3.816200] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
> [    3.816200] ACPI: Interpreter enabled
> [    3.816247] ACPI: (supports S0 S3 S4 S5)
> [    3.816248] ACPI: Using IOAPIC for interrupt routing
> [    3.816290] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
> [    3.817466] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in ACPI motherboard resources
> [    3.817474] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    3.817876] ACPI: Enabled 9 GPEs in block 00 to 7F
> [    3.818416] ACPI: Power Resource [PG01] (on)
> [    3.818416] ACPI: Power Resource [PG02] (on)
> [    3.818644] ACPI: Power Resource [PG00] (on)
> [    4.031294] ACPI: Power Resource [WRST] (off)
> [    4.031294] ACPI: Power Resource [WRST] (off)
> [    4.031294] ACPI: Power Resource [WRST] (off)
> [    4.031605] ACPI: Power Resource [WRST] (off)
> [    4.032031] ACPI: Power Resource [WRST] (off)
> [    4.032478] ACPI: Power Resource [WRST] (off)
> [    4.032896] ACPI: Power Resource [WRST] (off)
> [    4.033317] ACPI: Power Resource [WRST] (off)
> [    4.033735] ACPI: Power Resource [WRST] (off)
> [    4.034155] ACPI: Power Resource [WRST] (off)
> [    4.034574] ACPI: Power Resource [WRST] (off)
> [    4.034993] ACPI: Power Resource [WRST] (off)
> [    4.035411] ACPI: Power Resource [WRST] (off)
> [    4.035829] ACPI: Power Resource [WRST] (off)
> [    4.040250] ACPI: Power Resource [WRST] (off)
> [    4.040670] ACPI: Power Resource [WRST] (off)
> [    4.041087] ACPI: Power Resource [WRST] (off)
> [    4.041505] ACPI: Power Resource [WRST] (off)
> [    4.041926] ACPI: Power Resource [WRST] (off)
> [    4.042346] ACPI: Power Resource [WRST] (off)
> [    4.045941] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
> [    4.045947] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    4.046173] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME]
> [    4.046389] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
> [    4.046390] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    4.048494] PCI host bridge to bus 0000:00
> [    4.048496] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    4.048497] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    4.048498] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    4.048498] pci_bus 0000:00: root bus resource [mem 0x3e800000-0xefffffff window]
> [    4.048499] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> [    4.048500] pci_bus 0000:00: root bus resource [bus 00-7e]
> [    4.048508] pci 0000:00:00.0: [8086:1910] type 00 class 0x060000
> [    4.049313] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
> [    4.049352] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> [    4.050226] pci 0000:00:02.0: [8086:191b] type 00 class 0x030000
> [    4.050234] pci 0000:00:02.0: reg 0x10: [mem 0xdb000000-0xdbffffff 64bit]
> [    4.050239] pci 0000:00:02.0: reg 0x18: [mem 0x50000000-0x5fffffff 64bit pref]
> [    4.050242] pci 0000:00:02.0: reg 0x20: [io  0x6000-0x603f]
> [    4.050254] pci 0000:00:02.0: BAR 2: assigned to efifb
> [    4.051118] pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
> [    4.051137] pci 0000:00:14.0: reg 0x10: [mem 0xdc320000-0xdc32ffff 64bit]
> [    4.051195] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    4.052019] pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
> [    4.052037] pci 0000:00:14.2: reg 0x10: [mem 0xdc34a000-0xdc34afff 64bit]
> [    4.052888] pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
> [    4.052912] pci 0000:00:16.0: reg 0x10: [mem 0xdc34b000-0xdc34bfff 64bit]
> [    4.052977] pci 0000:00:16.0: PME# supported from D3hot
> [    4.053819] pci 0000:00:17.0: [8086:a102] type 00 class 0x010601
> [    4.053834] pci 0000:00:17.0: reg 0x10: [mem 0xdc348000-0xdc349fff]
> [    4.053840] pci 0000:00:17.0: reg 0x14: [mem 0xdc34e000-0xdc34e0ff]
> [    4.053846] pci 0000:00:17.0: reg 0x18: [io  0x6080-0x6087]
> [    4.053851] pci 0000:00:17.0: reg 0x1c: [io  0x6088-0x608b]
> [    4.053857] pci 0000:00:17.0: reg 0x20: [io  0x6040-0x605f]
> [    4.053863] pci 0000:00:17.0: reg 0x24: [mem 0xdc34c000-0xdc34c7ff]
> [    4.053897] pci 0000:00:17.0: PME# supported from D3hot
> [    4.054732] pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
> [    4.054796] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    4.055655] pci 0000:00:1c.1: [8086:a111] type 01 class 0x060400
> [    4.055720] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> [    4.056626] pci 0000:00:1c.4: [8086:a114] type 01 class 0x060400
> [    4.056690] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> [    4.057559] pci 0000:00:1f.0: [8086:a150] type 00 class 0x060100
> [    4.058437] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
> [    4.058448] pci 0000:00:1f.2: reg 0x10: [mem 0xdc340000-0xdc343fff]
> [    4.059296] pci 0000:00:1f.3: [8086:a170] type 00 class 0x040380
> [    4.059318] pci 0000:00:1f.3: reg 0x10: [mem 0xdc344000-0xdc347fff 64bit]
> [    4.059340] pci 0000:00:1f.3: reg 0x20: [mem 0xdc330000-0xdc33ffff 64bit]
> [    4.059383] pci 0000:00:1f.3: PME# supported from D3hot D3cold
> [    4.060243] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
> [    4.060295] pci 0000:00:1f.4: reg 0x10: [mem 0xdc34d000-0xdc34d0ff 64bit]
> [    4.060344] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
> [    4.061223] pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
> [    4.061245] pci 0000:00:1f.6: reg 0x10: [mem 0xdc300000-0xdc31ffff]
> [    4.061333] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
> [    4.062206] pci 0000:01:00.0: [1002:6820] type 00 class 0x030000
> [    4.062226] pci 0000:01:00.0: reg 0x10: [mem 0x40000000-0x4fffffff 64bit pref]
> [    4.062235] pci 0000:01:00.0: reg 0x18: [mem 0xdc000000-0xdc03ffff 64bit]
> [    4.062241] pci 0000:01:00.0: reg 0x20: [io  0x3000-0x30ff]
> [    4.062253] pci 0000:01:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
> [    4.062303] pci 0000:01:00.0: supports D1 D2
> [    4.062304] pci 0000:01:00.0: PME# supported from D1 D2 D3hot
> [    4.062371] pci 0000:01:00.1: [1002:aab0] type 00 class 0x040300
> [    4.062388] pci 0000:01:00.1: reg 0x10: [mem 0xdc040000-0xdc043fff 64bit]
> [    4.062454] pci 0000:01:00.1: supports D1 D2
> [    4.062525] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    4.062526] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
> [    4.062528] pci 0000:00:01.0:   bridge window [mem 0xdc000000-0xdc0fffff]
> [    4.062530] pci 0000:00:01.0:   bridge window [mem 0x40000000-0x4fffffff 64bit pref]
> [    4.062833] pci 0000:02:00.0: [8086:24f3] type 00 class 0x028000
> [    4.062879] pci 0000:02:00.0: reg 0x10: [mem 0xdc100000-0xdc101fff 64bit]
> [    4.063089] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> [    4.063627] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    4.063630] pci 0000:00:1c.0:   bridge window [mem 0xdc100000-0xdc1fffff]
> [    4.063688] pci 0000:03:00.0: [10ec:525a] type 00 class 0xff0000
> [    4.063717] pci 0000:03:00.0: reg 0x14: [mem 0xdc200000-0xdc200fff]
> [    4.063816] pci 0000:03:00.0: supports D1 D2
> [    4.063817] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
> [    4.063984] pci 0000:00:1c.1: PCI bridge to [bus 03]
> [    4.063986] pci 0000:00:1c.1:   bridge window [io  0x4000-0x5fff]
> [    4.063987] pci 0000:00:1c.1:   bridge window [mem 0xdc200000-0xdc2fffff]
> [    4.064043] pci 0000:04:00.0: [8086:1578] type 01 class 0x060400
> [    4.064097] pci 0000:04:00.0: enabling Extended Tags
> [    4.064173] pci 0000:04:00.0: supports D1 D2
> [    4.064174] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    4.064220] pci 0000:04:00.0: 7.876 Gb/s available PCIe bandwidth, limited by 8 GT/s x1 link at 0000:00:1c.4 (capable of 31.504 Gb/s with 8 GT/s x4 link)
> [    4.064320] pci 0000:00:1c.4: PCI bridge to [bus 04-6e]
> [    4.064323] pci 0000:00:1c.4:   bridge window [mem 0xac000000-0xda0fffff]
> [    4.064326] pci 0000:00:1c.4:   bridge window [mem 0x60000000-0xa9ffffff 64bit pref]
> [    4.064374] pci 0000:05:00.0: [8086:1578] type 01 class 0x060400
> [    4.064431] pci 0000:05:00.0: enabling Extended Tags
> [    4.064510] pci 0000:05:00.0: supports D1 D2
> [    4.064510] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    4.064588] pci 0000:05:01.0: [8086:1578] type 01 class 0x060400
> [    4.064647] pci 0000:05:01.0: enabling Extended Tags
> [    4.064726] pci 0000:05:01.0: supports D1 D2
> [    4.064727] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    4.064807] pci 0000:05:02.0: [8086:1578] type 01 class 0x060400
> [    4.064864] pci 0000:05:02.0: enabling Extended Tags
> [    4.064941] pci 0000:05:02.0: supports D1 D2
> [    4.064942] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    4.065017] pci 0000:05:04.0: [8086:1578] type 01 class 0x060400
> [    4.065076] pci 0000:05:04.0: enabling Extended Tags
> [    4.065155] pci 0000:05:04.0: supports D1 D2
> [    4.065155] pci 0000:05:04.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    4.065247] pci 0000:04:00.0: PCI bridge to [bus 05-6e]
> [    4.065254] pci 0000:04:00.0:   bridge window [mem 0xac000000-0xda0fffff]
> [    4.065259] pci 0000:04:00.0:   bridge window [mem 0x60000000-0xa9ffffff 64bit pref]
> [    4.065295] pci 0000:05:00.0: PCI bridge to [bus 06]
> [    4.065302] pci 0000:05:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [    4.065343] pci 0000:05:01.0: PCI bridge to [bus 07-39]
> [    4.065350] pci 0000:05:01.0:   bridge window [mem 0xac000000-0xc3efffff]
> [    4.065355] pci 0000:05:01.0:   bridge window [mem 0x60000000-0x7fffffff 64bit pref]
> [    4.065407] pci 0000:3a:00.0: [8086:15b6] type 00 class 0x0c0330
> [    4.065439] pci 0000:3a:00.0: reg 0x10: [mem 0xc3f00000-0xc3f0ffff]
> [    4.065511] pci 0000:3a:00.0: enabling Extended Tags
> [    4.065611] pci 0000:3a:00.0: supports D1 D2
> [    4.065612] pci 0000:3a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    4.065669] pci 0000:3a:00.0: 7.876 Gb/s available PCIe bandwidth, limited by 8 GT/s x1 link at 0000:00:1c.4 (capable of 31.504 Gb/s with 8 GT/s x4 link)
> [    4.065757] pci 0000:05:02.0: PCI bridge to [bus 3a]
> [    4.065764] pci 0000:05:02.0:   bridge window [mem 0xc3f00000-0xc3ffffff]
> [    4.065806] pci 0000:05:04.0: PCI bridge to [bus 3b-6e]
> [    4.065813] pci 0000:05:04.0:   bridge window [mem 0xc4000000-0xd9ffffff]
> [    4.065818] pci 0000:05:04.0:   bridge window [mem 0x80000000-0xa9ffffff 64bit pref]
> [    4.067069] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    4.067128] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
> [    4.067186] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    4.067244] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    4.067301] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    4.067358] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    4.067415] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    4.067472] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    4.067807] ACPI: EC: interrupt unblocked
> [    4.067814] ACPI: EC: event unblocked
> [    4.067822] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0x6e, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    4.067823] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions and events
> [    4.067917] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    4.067917] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    4.067917] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> [    4.067917] pci 0000:00:02.0: vgaarb: no bridge control possible
> [    4.067918] pci 0000:01:00.0: vgaarb: bridge control possible
> [    4.067918] vgaarb: loaded
> [    4.067970] EDAC MC: Ver: 3.0.0
> [    4.068304] Registered efivars operations
> [    4.115938] PCI: Using ACPI for IRQ routing
> [    4.121248] PCI: pci_cache_line_size set to 64 bytes
> [    4.121808] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
> [    4.121808] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
> [    4.121809] e820: reserve RAM buffer [mem 0x2214c018-0x23ffffff]
> [    4.121810] e820: reserve RAM buffer [mem 0x2215d018-0x23ffffff]
> [    4.121810] e820: reserve RAM buffer [mem 0x390fb000-0x3bffffff]
> [    4.121811] e820: reserve RAM buffer [mem 0x39f00000-0x3bffffff]
> [    4.121812] e820: reserve RAM buffer [mem 0x8bf800000-0x8bfffffff]
> [    4.121890] NetLabel: Initializing
> [    4.121890] NetLabel:  domain hash size = 128
> [    4.121891] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    4.121902] NetLabel:  unlabeled traffic allowed by default
> [    4.121904] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    4.121904] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
> [    4.123922] clocksource: Switched to clocksource tsc-early
> [    4.134768] VFS: Disk quotas dquot_6.6.0
> [    4.134782] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    4.134812] *** VALIDATE hugetlbfs ***
> [    4.134833] pnp: PnP ACPI init
> [    4.134991] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
> [    4.134992] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
> [    4.134993] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
> [    4.134994] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reserved
> [    4.134995] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
> [    4.134999] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    4.135302] system 00:01: [io  0x2000-0x20fe] has been reserved
> [    4.135305] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    4.135438] system 00:02: [io  0x0680-0x069f] has been reserved
> [    4.135439] system 00:02: [io  0xffff] has been reserved
> [    4.135439] system 00:02: [io  0xffff] has been reserved
> [    4.135440] system 00:02: [io  0xffff] has been reserved
> [    4.135441] system 00:02: [io  0x1800-0x18fe] has been reserved
> [    4.135442] system 00:02: [io  0x164e-0x164f] has been reserved
> [    4.135444] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    4.135532] system 00:03: [io  0x0800-0x087f] has been reserved
> [    4.135534] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    4.135551] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    4.135589] system 00:05: [io  0x1854-0x1857] has been reserved
> [    4.135591] system 00:05: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
> [    4.135608] pnp 00:06: Plug and Play ACPI device, IDs HPQ8002 PNP0303 (active)
> [    4.135625] pnp 00:07: Plug and Play ACPI device, IDs SYN3042 SYN0100 SYN0002 PNP0f13 (active)
> [    4.135694] system 00:08: [io  0x0200-0x023f] has been reserved
> [    4.135695] system 00:08: [mem 0xfedf0000-0xfedfffff] has been reserved
> [    4.135698] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    4.136040] system 00:09: [mem 0xfed10000-0xfed17fff] has been reserved
> [    4.136041] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
> [    4.136042] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
> [    4.136043] system 00:09: [mem 0xf0000000-0xf7ffffff] could not be reserved
> [    4.136044] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    4.136045] system 00:09: [mem 0xfed90000-0xfed93fff] has been reserved
> [    4.136046] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
> [    4.136047] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
> [    4.136048] system 00:09: [mem 0xfee00000-0xfeefffff] has been reserved
> [    4.136049] system 00:09: [mem 0x3e800000-0x3e81ffff] has been reserved
> [    4.136051] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    4.136349] pnp 00:0a: Plug and Play ACPI device, IDs IFX0102 PNP0c31 (active)
> [    4.136409] pnp: PnP ACPI: found 11 devices
> [    4.137514] thermal_sys: Registered thermal governor 'fair_share'
> [    4.137515] thermal_sys: Registered thermal governor 'bang_bang'
> [    4.137515] thermal_sys: Registered thermal governor 'step_wise'
> [    4.137516] thermal_sys: Registered thermal governor 'user_space'
> [    4.142006] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    4.142030] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
> [    4.142033] pci 0000:00:1c.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
> [    4.142035] pci 0000:05:01.0: bridge window [io  0x1000-0x0fff] to [bus 07-39] add_size 1000
> [    4.142036] pci 0000:05:04.0: bridge window [io  0x1000-0x0fff] to [bus 3b-6e] add_size 1000
> [    4.142038] pci 0000:04:00.0: bridge window [io  0x1000-0x0fff] to [bus 05-6e] add_size 2000
> [    4.142039] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus 04-6e] add_size 3000
> [    4.142045] pci 0000:00:1c.1: BAR 15: assigned [mem 0x3e900000-0x3eafffff 64bit pref]
> [    4.142046] pci 0000:00:1c.4: BAR 13: assigned [io  0x7000-0x9fff]
> [    4.142048] pci 0000:01:00.0: BAR 6: assigned [mem 0xdc060000-0xdc07ffff pref]
> [    4.142050] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    4.142051] pci 0000:00:01.0:   bridge window [io  0x3000-0x3fff]
> [    4.142053] pci 0000:00:01.0:   bridge window [mem 0xdc000000-0xdc0fffff]
> [    4.142054] pci 0000:00:01.0:   bridge window [mem 0x40000000-0x4fffffff 64bit pref]
> [    4.142057] pci 0000:00:1c.0: PCI bridge to [bus 02]
> [    4.142059] pci 0000:00:1c.0:   bridge window [mem 0xdc100000-0xdc1fffff]
> [    4.142064] pci 0000:00:1c.1: PCI bridge to [bus 03]
> [    4.142065] pci 0000:00:1c.1:   bridge window [io  0x4000-0x5fff]
> [    4.142067] pci 0000:00:1c.1:   bridge window [mem 0xdc200000-0xdc2fffff]
> [    4.142069] pci 0000:00:1c.1:   bridge window [mem 0x3e900000-0x3eafffff 64bit pref]
> [    4.142073] pci 0000:04:00.0: BAR 13: assigned [io  0x7000-0x8fff]
> [    4.142074] pci 0000:05:01.0: BAR 13: assigned [io  0x7000-0x7fff]
> [    4.142075] pci 0000:05:04.0: BAR 13: assigned [io  0x8000-0x8fff]
> [    4.142076] pci 0000:05:00.0: PCI bridge to [bus 06]
> [    4.142080] pci 0000:05:00.0:   bridge window [mem 0xda000000-0xda0fffff]
> [    4.142087] pci 0000:05:01.0: PCI bridge to [bus 07-39]
> [    4.142089] pci 0000:05:01.0:   bridge window [io  0x7000-0x7fff]
> [    4.142093] pci 0000:05:01.0:   bridge window [mem 0xac000000-0xc3efffff]
> [    4.142096] pci 0000:05:01.0:   bridge window [mem 0x60000000-0x7fffffff 64bit pref]
> [    4.142101] pci 0000:05:02.0: PCI bridge to [bus 3a]
> [    4.142105] pci 0000:05:02.0:   bridge window [mem 0xc3f00000-0xc3ffffff]
> [    4.142112] pci 0000:05:04.0: PCI bridge to [bus 3b-6e]
> [    4.142114] pci 0000:05:04.0:   bridge window [io  0x8000-0x8fff]
> [    4.142117] pci 0000:05:04.0:   bridge window [mem 0xc4000000-0xd9ffffff]
> [    4.142120] pci 0000:05:04.0:   bridge window [mem 0x80000000-0xa9ffffff 64bit pref]
> [    4.142125] pci 0000:04:00.0: PCI bridge to [bus 05-6e]
> [    4.142127] pci 0000:04:00.0:   bridge window [io  0x7000-0x8fff]
> [    4.142130] pci 0000:04:00.0:   bridge window [mem 0xac000000-0xda0fffff]
> [    4.142133] pci 0000:04:00.0:   bridge window [mem 0x60000000-0xa9ffffff 64bit pref]
> [    4.142138] pci 0000:00:1c.4: PCI bridge to [bus 04-6e]
> [    4.142139] pci 0000:00:1c.4:   bridge window [io  0x7000-0x9fff]
> [    4.142142] pci 0000:00:1c.4:   bridge window [mem 0xac000000-0xda0fffff]
> [    4.142143] pci 0000:00:1c.4:   bridge window [mem 0x60000000-0xa9ffffff 64bit pref]
> [    4.142147] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    4.142148] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    4.142149] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    4.142149] pci_bus 0000:00: resource 7 [mem 0x3e800000-0xefffffff window]
> [    4.142150] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
> [    4.142151] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
> [    4.142151] pci_bus 0000:01: resource 1 [mem 0xdc000000-0xdc0fffff]
> [    4.142152] pci_bus 0000:01: resource 2 [mem 0x40000000-0x4fffffff 64bit pref]
> [    4.142153] pci_bus 0000:02: resource 1 [mem 0xdc100000-0xdc1fffff]
> [    4.142154] pci_bus 0000:03: resource 0 [io  0x4000-0x5fff]
> [    4.142154] pci_bus 0000:03: resource 1 [mem 0xdc200000-0xdc2fffff]
> [    4.142155] pci_bus 0000:03: resource 2 [mem 0x3e900000-0x3eafffff 64bit pref]
> [    4.142156] pci_bus 0000:04: resource 0 [io  0x7000-0x9fff]
> [    4.142156] pci_bus 0000:04: resource 1 [mem 0xac000000-0xda0fffff]
> [    4.142157] pci_bus 0000:04: resource 2 [mem 0x60000000-0xa9ffffff 64bit pref]
> [    4.142158] pci_bus 0000:05: resource 0 [io  0x7000-0x8fff]
> [    4.142158] pci_bus 0000:05: resource 1 [mem 0xac000000-0xda0fffff]
> [    4.142159] pci_bus 0000:05: resource 2 [mem 0x60000000-0xa9ffffff 64bit pref]
> [    4.142160] pci_bus 0000:06: resource 1 [mem 0xda000000-0xda0fffff]
> [    4.142160] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
> [    4.142161] pci_bus 0000:07: resource 1 [mem 0xac000000-0xc3efffff]
> [    4.142162] pci_bus 0000:07: resource 2 [mem 0x60000000-0x7fffffff 64bit pref]
> [    4.142162] pci_bus 0000:3a: resource 1 [mem 0xc3f00000-0xc3ffffff]
> [    4.142163] pci_bus 0000:3b: resource 0 [io  0x8000-0x8fff]
> [    4.142164] pci_bus 0000:3b: resource 1 [mem 0xc4000000-0xd9ffffff]
> [    4.142165] pci_bus 0000:3b: resource 2 [mem 0x80000000-0xa9ffffff 64bit pref]
> [    4.142292] NET: Registered protocol family 2
> [    4.142402] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
> [    4.142430] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    4.142635] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [    4.142716] TCP: Hash tables configured (established 262144 bind 65536)
> [    4.142737] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
> [    4.142786] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
> [    4.142871] NET: Registered protocol family 1
> [    4.142880] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    4.143124] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
> [    4.143510] pci 0000:04:00.0: enabling device (0006 -> 0007)
> [    4.143692] PCI: CLS 128 bytes, default 64
> [    4.143715] Trying to unpack rootfs image as initramfs...
> [    4.952647] Freeing initrd memory: 10224K
> [    4.952660] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    4.952661] software IO TLB: mapped [mem 0x269fc000-0x2a9fc000] (64MB)
> [    4.952743] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> [    4.952743] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [    4.952743] RAPL PMU: hw unit of domain package 2^-14 Joules
> [    4.952744] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [    4.952744] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [    4.952951] check: Scanning for low memory corruption every 60 seconds
> [    4.954257] Initialise system trusted keyrings
> [    4.954266] Key type blacklist registered
> [    4.954291] workingset: timestamp_bits=36 max_order=23 bucket_order=0
> [    4.954346] zbud: loaded
> [    4.954630] Platform Keyring initialized
> [    4.957929] Key type asymmetric registered
> [    4.957929] Asymmetric key parser 'x509' registered
> [    4.957934] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
> [    4.957961] io scheduler mq-deadline registered
> [    4.957961] io scheduler kyber registered
> [    4.957983] io scheduler bfq registered
> [    4.958402] pcieport 0000:00:1c.0: AER: enabled with IRQ 121
> [    4.958586] pcieport 0000:00:1c.1: AER: enabled with IRQ 122
> [    4.958696] pcieport 0000:00:1c.4: AER: enabled with IRQ 123
> [    4.959007] pcieport 0000:05:01.0: enabling device (0006 -> 0007)
> [    4.959266] pcieport 0000:05:04.0: enabling device (0006 -> 0007)
> [    4.959427] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    4.959457] efifb: probing for efifb
> [    4.959468] efifb: framebuffer at 0x50000000, using 3072k, total 3072k
> [    4.959469] efifb: mode is 1024x768x32, linelength=4096, pages=1
> [    4.959469] efifb: scrolling: redraw
> [    4.959470] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    4.959532] Console: switching to colour frame buffer device 128x48
> [    4.960651] fb0: EFI VGA frame buffer device
> [    4.960656] intel_idle: MWAIT substates: 0x11142120
> [    4.960657] intel_idle: v0.4.1 model 0x5E
> [    4.961041] intel_idle: lapic_timer_reliable_states 0xffffffff
> [    4.961648] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    4.962521] Non-volatile memory driver v1.3
> [    4.962535] Linux agpgart interface v0.103
> [    4.964787] tpm_tis 00:0a: 1.2 TPM (device-id 0x1B, rev-id 16)
> [    4.977217] tpm tpm0: TPM is disabled/deactivated (0x7)
> [    4.977228] tpm tpm0: tpm_read_log_acpi: TCPA log area empty
> [    4.977244] tpm_tis: probe of 00:0a failed with error -5
> [    4.978379] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> [    4.979880] i8042: Detected active multiplexing controller, rev 1.1
> [    4.980317] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    4.980320] serio: i8042 AUX0 port at 0x60,0x64 irq 12
> [    4.980339] serio: i8042 AUX1 port at 0x60,0x64 irq 12
> [    4.980351] serio: i8042 AUX2 port at 0x60,0x64 irq 12
> [    4.980363] serio: i8042 AUX3 port at 0x60,0x64 irq 12
> [    4.980424] mousedev: PS/2 mouse device common for all mice
> [    4.980506] rtc_cmos 00:04: RTC can wake from S4
> [    4.981011] rtc_cmos 00:04: registered as rtc0
> [    4.981022] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
> [    4.981028] intel_pstate: Intel P-state driver initializing
> [    4.981707] intel_pstate: HWP enabled
> [    4.981982] ledtrig-cpu: registered to indicate activity on CPUs
> [    4.981983] EFI Variables Facility v0.08 2004-May-17
> [    5.005809] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> [    5.043094] hidraw: raw HID events driver (C) Jiri Kosina
> [    5.043122] gnss: GNSS driver registered with major 245
> [    5.043201] NET: Registered protocol family 10
> [    5.046025] Segment Routing with IPv6
> [    5.046590] RAS: Correctable Errors collector initialized.
> [    5.046638] microcode: sig=0x506e3, pf=0x20, revision=0xcc
> [    5.046677] microcode: Microcode Update Driver: v2.2.
> [    5.046687] sched_clock: Marking stable (5050285914, -3611355)->(5131066482, -84391923)
> [    5.046784] registered taskstats version 1
> [    5.046786] Loading compiled-in X.509 certificates
> [    5.073081] Loaded X.509 cert 'Build time autogenerated kernel key: a45fcfd41e17b8be3dcf8daa0ea053a7d1b994a2'
> [    5.073097] zswap: loaded using pool lzo/zbud
> [    5.073177] page_owner is disabled
> [    5.075558] Key type encrypted registered
> [    5.076014] Couldn't get size: 0x800000000000000e
> [    5.076029] MODSIGN: Couldn't get UEFI db list
> [    5.076305] Couldn't get size: 0x800000000000000e
> [    5.076317] Couldn't get UEFI MokListRT
> [    5.076604] Couldn't get size: 0x800000000000000e
> [    5.076617] Couldn't get UEFI dbx list
> [    5.076619] ima: No TPM chip found, activating TPM-bypass!
> [    5.076623] ima: Allocated hash algorithm: sha256
> [    5.076627] No architecture policies found
> [    5.076636] evm: Initialising EVM extended attributes:
> [    5.076637] evm: security.selinux
> [    5.076637] evm: security.apparmor
> [    5.076637] evm: security.ima
> [    5.076638] evm: security.capability
> [    5.076638] evm: HMAC attrs: 0x1
> [    5.077608] PM:   Magic number: 15:553:328
> [    5.932336] input: PS/2 Generic Mouse as /devices/platform/i8042/serio2/input/input6
> [    5.964013] tsc: Refined TSC clocksource calibration: 2591.999 MHz
> [    5.964030] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x255cb5c6a11, max_idle_ns: 440795249002 ns
> [    5.964093] clocksource: Switched to clocksource tsc
> [    6.497818] random: fast init done
> [    6.673342] psmouse serio3: synaptics: queried max coordinates: x [..5664], y [..4742]
> [    6.704602] psmouse serio3: synaptics: queried min coordinates: x [1280..], y [1110..]
> [    6.704616] psmouse serio3: synaptics: Your touchpad (PNP: SYN3042 SYN0100 SYN0002 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
> [    6.765033] psmouse serio3: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf40223/0x840300/0x2e800/0x0, board id: 2706, fw id: 2017334
> [    6.802136] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio3/input/input7
> [    6.809189] Freeing unused decrypted memory: 2040K
> [    6.809926] Freeing unused kernel image memory: 2728K
> [    6.809999] Write protecting the kernel read-only data: 18432k
> [    6.811042] Freeing unused kernel image memory: 2012K
> [    6.811344] Freeing unused kernel image memory: 300K
> [    6.811410] Run /init as init process
> [    6.814657] autofs4: module verification failed: signature and/or required key missing - tainting kernel
> [    6.929941] systemd[1]: systemd 234 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN2 -IDN default-hierarchy=hybrid)
> [    6.948200] systemd[1]: Detected architecture x86-64.
> [    6.948203] systemd[1]: Running in initial RAM disk.
> [    6.948224] systemd[1]: Set hostname to <linux-k53f>.
> [    6.979189] random: systemd: uninitialized urandom read (16 bytes read)
> [    6.979197] systemd[1]: Reached target Timers.
> [    6.979231] random: systemd: uninitialized urandom read (16 bytes read)
> [    6.979262] systemd[1]: Listening on Journal Socket (/dev/log).
> [    6.979270] random: systemd: uninitialized urandom read (16 bytes read)
> [    6.979299] systemd[1]: Listening on Journal Socket.
> [    6.979572] systemd[1]: Created slice System Slice.
> [    6.979958] systemd[1]: Starting Setup Virtual Console...
> [    6.979977] systemd[1]: Reached target Slices.
> [    6.986764] SCSI subsystem initialized
> [    6.987047] alua: device handler registered
> [    6.987236] emc: device handler registered
> [    6.987403] rdac: device handler registered
> [    6.989187] device-mapper: uevent: version 1.0.3
> [    6.989222] device-mapper: ioctl: 4.40.0-ioctl (2019-01-18) initialised: dm-devel@redhat.com
> [    7.160216] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
> [    7.164225] ACPI: bus type USB registered
> [    7.164246] usbcore: registered new interface driver usbfs
> [    7.164257] usbcore: registered new interface driver hub
> [    7.164456] usbcore: registered new device driver usb
> [    7.166039] libata version 3.00 loaded.
> [    7.167825] ahci 0000:00:17.0: version 3.0
> [    7.167831] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    7.167836] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> [    7.167986] ahci 0000:00:17.0: SSS flag set, parallel bus scan disabled
> [    7.168904] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
> [    7.168908] xhci_hcd 0000:00:14.0: cache line size of 128 is not supported
> [    7.169085] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
> [    7.169087] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    7.169088] usb usb1: Product: xHCI Host Controller
> [    7.169089] usb usb1: Manufacturer: Linux 5.3.0-rc5-default+ xhci-hcd
> [    7.169090] usb usb1: SerialNumber: 0000:00:14.0
> [    7.169228] hub 1-0:1.0: USB hub found
> [    7.169248] hub 1-0:1.0: 16 ports detected
> [    7.170476] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    7.170479] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [    7.170482] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> [    7.170521] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.03
> [    7.170522] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    7.170523] usb usb2: Product: xHCI Host Controller
> [    7.170525] usb usb2: Manufacturer: Linux 5.3.0-rc5-default+ xhci-hcd
> [    7.170526] usb usb2: SerialNumber: 0000:00:14.0
> [    7.170676] hub 2-0:1.0: USB hub found
> [    7.170691] hub 2-0:1.0: 10 ports detected
> [    7.170807] usb: port power management may be unreliable
> [    7.171618] xhci_hcd 0000:3a:00.0: xHCI Host Controller
> [    7.171624] xhci_hcd 0000:3a:00.0: new USB bus registered, assigned bus number 3
> [    7.172750] xhci_hcd 0000:3a:00.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000200009810
> [    7.172967] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
> [    7.172970] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    7.172972] usb usb3: Product: xHCI Host Controller
> [    7.172973] usb usb3: Manufacturer: Linux 5.3.0-rc5-default+ xhci-hcd
> [    7.172975] usb usb3: SerialNumber: 0000:3a:00.0
> [    7.173098] hub 3-0:1.0: USB hub found
> [    7.173107] hub 3-0:1.0: 2 ports detected
> [    7.173272] xhci_hcd 0000:3a:00.0: xHCI Host Controller
> [    7.173275] xhci_hcd 0000:3a:00.0: new USB bus registered, assigned bus number 4
> [    7.173277] xhci_hcd 0000:3a:00.0: Host supports USB 3.0 SuperSpeed
> [    7.173307] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.03
> [    7.173307] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    7.173308] usb usb4: Product: xHCI Host Controller
> [    7.173309] usb usb4: Manufacturer: Linux 5.3.0-rc5-default+ xhci-hcd
> [    7.173309] usb usb4: SerialNumber: 0000:3a:00.0
> [    7.173424] hub 4-0:1.0: USB hub found
> [    7.173434] hub 4-0:1.0: 2 ports detected
> [    7.178069] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 3 ports 6 Gbps 0x12 impl SATA mode
> [    7.178071] ahci 0000:00:17.0: flags: 64bit ncq sntf stag pm led clo only pio slum part ems deso sadm sds apst 
> [    7.192723] scsi host0: ahci
> [    7.192872] scsi host1: ahci
> [    7.192978] scsi host2: ahci
> [    7.193085] scsi host3: ahci
> [    7.193180] scsi host4: ahci
> [    7.193221] ata1: DUMMY
> [    7.193223] ata2: SATA max UDMA/133 abar m2048@0xdc34c000 port 0xdc34c180 irq 129
> [    7.193224] ata3: DUMMY
> [    7.193224] ata4: DUMMY
> [    7.193225] ata5: SATA max UDMA/133 abar m2048@0xdc34c000 port 0xdc34c300 irq 129
> [    7.198795] random: crng init done
> [    7.198796] random: 7 urandom warning(s) missed due to ratelimiting
> [    7.504000] usb 1-2: new high-speed USB device number 2 using xhci_hcd
> [    7.508626] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    7.509338] ata2.00: ACPI cmd f5/00:00:00:00:00:e0 (SECURITY FREEZE LOCK) filtered out
> [    7.509453] ata2.00: ATA-9: SKhynix SC300 HFS256G32MND-3210A, C213W003, max UDMA/100
> [    7.509457] ata2.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    7.510413] ata2.00: ACPI cmd f5/00:00:00:00:00:e0 (SECURITY FREEZE LOCK) filtered out
> [    7.510679] ata2.00: configured for UDMA/100
> [    7.511082] scsi 1:0:0:0: Direct-Access     ATA      SKhynix SC300 HF W003 PQ: 0 ANSI: 5
> [    7.511606] scsi 1:0:0:0: Attached scsi generic sg0 type 0
> [    7.828802] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    7.830672] ata5.00: ACPI cmd f5/00:00:00:00:00:e0 (SECURITY FREEZE LOCK) filtered out
> [    7.830678] ata5.00: ACPI cmd b1/c1:00:00:00:00:e0 (DEVICE CONFIGURATION OVERLAY) filtered out
> [    7.830794] ata5.00: supports DRM functions and may not be fully accessible
> [    7.831709] ata5.00: disabling queued TRIM support
> [    7.831713] ata5.00: ATA-9: Samsung SSD 850 EVO M.2 1TB, EMT21B6Q, max UDMA/133
> [    7.831716] ata5.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    7.834114] ata5.00: ACPI cmd f5/00:00:00:00:00:e0 (SECURITY FREEZE LOCK) filtered out
> [    7.834120] ata5.00: ACPI cmd b1/c1:00:00:00:00:e0 (DEVICE CONFIGURATION OVERLAY) filtered out
> [    7.834247] ata5.00: supports DRM functions and may not be fully accessible
> [    7.835117] ata5.00: disabling queued TRIM support
> [    7.836821] ata5.00: configured for UDMA/133
> [    7.837106] scsi 4:0:0:0: Direct-Access     ATA      Samsung SSD 850  1B6Q PQ: 0 ANSI: 5
> [    7.837501] scsi 4:0:0:0: Attached scsi generic sg1 type 0
> [    7.843779] sd 1:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
> [    7.843781] sd 1:0:0:0: [sda] 4096-byte physical blocks
> [    7.843788] sd 1:0:0:0: [sda] Write Protect is off
> [    7.843789] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    7.843799] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    7.843804] sd 4:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
> [    7.843812] sd 4:0:0:0: [sdb] Write Protect is off
> [    7.843813] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    7.843827] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    7.844979]  sda: sda1 sda2 sda3 sda4 sda5
> [    7.845234]  sdb: sdb1 sdb2 sdb3 sdb4
> [    7.845458] sd 1:0:0:0: [sda] Attached SCSI disk
> [    7.846215] sd 4:0:0:0: [sdb] supports TCG Opal
> [    7.846216] sd 4:0:0:0: [sdb] Attached SCSI disk
> [    7.899004] PM: Image not found (code -22)
> [    7.943958] raid6: avx2x4   gen() 32458 MB/s
> [    8.011955] raid6: avx2x4   xor() 21877 MB/s
> [    8.055625] usb 1-2: New USB device found, idVendor=03f0, idProduct=9d1d, bcdDevice= 2.28
> [    8.055627] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    8.055627] usb 1-2: Product: HP lt4120 Snapdragon X5 LTE
> [    8.055628] usb 1-2: Manufacturer: HP
> [    8.055629] usb 1-2: SerialNumber: 0123456789ABCDEF
> [    8.079951] raid6: avx2x2   gen() 30457 MB/s
> [    8.147951] raid6: avx2x2   xor() 20080 MB/s
> [    8.203961] usb 1-7: new high-speed USB device number 3 using xhci_hcd
> [    8.215950] raid6: avx2x1   gen() 25627 MB/s
> [    8.283953] raid6: avx2x1   xor() 18032 MB/s
> [    8.351954] raid6: sse2x4   gen() 14683 MB/s
> [    8.395761] usb 1-7: New USB device found, idVendor=04f2, idProduct=b51d, bcdDevice=99.06
> [    8.395762] usb 1-7: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> [    8.395763] usb 1-7: Product: HP HD Camera
> [    8.395763] usb 1-7: Manufacturer: Generic
> [    8.395764] usb 1-7: SerialNumber: 200901010001
> [    8.419955] raid6: sse2x4   xor()  8762 MB/s
> [    8.487952] raid6: sse2x2   gen() 12713 MB/s
> [    8.527973] usb 1-8: new full-speed USB device number 4 using xhci_hcd
> [    8.555952] raid6: sse2x2   xor()  8548 MB/s
> [    8.623952] raid6: sse2x1   gen() 11328 MB/s
> [    8.677215] usb 1-8: New USB device found, idVendor=138a, idProduct=003f, bcdDevice= 1.04
> [    8.677216] usb 1-8: New USB device strings: Mfr=0, Product=0, SerialNumber=1
> [    8.677217] usb 1-8: SerialNumber: 00a072d48f98
> [    8.691955] raid6: sse2x1   xor()  6179 MB/s
> [    8.691956] raid6: using algorithm avx2x4 gen() 32458 MB/s
> [    8.691956] raid6: .... xor() 21877 MB/s, rmw enabled
> [    8.691957] raid6: using avx2x2 recovery algorithm
> [    8.693951] xor: automatically using best checksumming function   avx       
> [    8.709289] Btrfs loaded, crc32c=crc32c-intel, assert=on
> [    8.709642] BTRFS: device fsid 8f8323db-cb2f-4ee5-a772-1ab56776a07f devid 1 transid 8783 /dev/sda4
> [    8.711230] BTRFS: device fsid 0db78229-3181-4a25-be9d-99ef682ca3f2 devid 1 transid 1576301 /dev/sdb2
> [    8.738183] BTRFS info (device sdb2): disk space caching is enabled
> [    8.738184] BTRFS info (device sdb2): has skinny extents
> [    8.753299] BTRFS info (device sdb2): enabling ssd optimizations
> [    8.803986] usb 1-12: new full-speed USB device number 5 using xhci_hcd
> [    8.953047] usb 1-12: New USB device found, idVendor=8087, idProduct=0a2b, bcdDevice= 0.01
> [    8.953052] usb 1-12: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    8.960190] systemd-journald[238]: Received SIGTERM from PID 1 (systemd).
> [    8.987808] printk: systemd: 18 output lines suppressed due to ratelimiting
> [    9.223826] BTRFS info (device sdb2): disk space caching is enabled
> [    9.328933] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input9
> [    9.328976] ACPI: Sleep Button [SLPB]
> [    9.329030] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input10
> [    9.329067] ACPI: Lid Switch [LID]
> [    9.329115] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input11
> [    9.329153] ACPI: Power Button [PWRF]
> [    9.338082] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> [    9.342527] thermal LNXTHERM:00: registered as thermal_zone1
> [    9.342529] ACPI: Thermal Zone [CPUZ] (48 C)
> [    9.343663] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
> [    9.343715] ACPI: AC Adapter [AC] (on-line)
> [    9.343942] input: HP Wireless hotkeys as /devices/virtual/input/input12
> [    9.347418] thermal LNXTHERM:01: registered as thermal_zone2
> [    9.347420] ACPI: Thermal Zone [GFXZ] (0 C)
> [    9.351762] thermal LNXTHERM:02: registered as thermal_zone3
> [    9.351764] ACPI: Thermal Zone [EXTZ] (45 C)
> [    9.355566] thermal LNXTHERM:03: registered as thermal_zone4
> [    9.355568] ACPI: Thermal Zone [LOCZ] (48 C)
> [    9.359875] thermal LNXTHERM:04: registered as thermal_zone5
> [    9.359877] ACPI: Thermal Zone [BATZ] (35 C)
> [    9.360487] thermal LNXTHERM:05: registered as thermal_zone6
> [    9.360488] ACPI: Thermal Zone [PCHZ] (127 C)
> [    9.421036] tpm_inf_pnp 00:0a: Found TPM with ID IFX0102
> [    9.423532] intel_pmc_core INT33A1:00:  initialized
> [    9.445672] input: PC Speaker as /devices/platform/pcspkr/input/input13
> [    9.445933] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    9.446213] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
> [    9.446227] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    9.446424] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [    9.446459] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [    9.446843] pps_core: LinuxPPS API ver. 1 registered
> [    9.446844] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    9.447444] battery: ACPI: Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
> [    9.447449] battery: ACPI: Battery Slot [BAT0] (battery present)
> [    9.451263] ACPI Error: Needed [Buffer/String/Package], found [Integer] 0000000035444865 (20190703/exresop-560)
> [    9.451316] ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [Index] (20190703/dswexec-427)
> [    9.451361] ACPI Error: Aborting method \_SB.WMIV.WVPO due to previous error (AE_AML_OPERAND_TYPE) (20190703/psparse-531)
> [    9.451417] ACPI Error: Aborting method \_SB.WMIV.WMPV due to previous error (AE_AML_OPERAND_TYPE) (20190703/psparse-531)
> [    9.452943] ACPI Error: Needed [Buffer/String/Package], found [Integer] 000000005108f1ff (20190703/exresop-560)
> [    9.452997] ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [Index] (20190703/dswexec-427)
> [    9.453048] ACPI Error: Aborting method \_SB.WMIV.WVPO due to previous error (AE_AML_OPERAND_TYPE) (20190703/psparse-531)
> [    9.453123] ACPI Error: Aborting method \_SB.WMIV.WMPV due to previous error (AE_AML_OPERAND_TYPE) (20190703/psparse-531)
> [    9.458834] ACPI Error: Needed [Buffer/String/Package], found [Integer] 000000007c8ea1f6 (20190703/exresop-560)
> [    9.458892] ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [Index] (20190703/dswexec-427)
> [    9.458953] ACPI Error: Aborting method \_SB.WMIV.WVPO due to previous error (AE_AML_OPERAND_TYPE) (20190703/psparse-531)
> [    9.459018] ACPI Error: Aborting method \_SB.WMIV.WMPV due to previous error (AE_AML_OPERAND_TYPE) (20190703/psparse-531)
> [    9.460499] input: HP WMI hotkeys as /devices/virtual/input/input14
> [    9.464788] PTP clock support registered
> [    9.471855] hp_accel: hardware type HPZBook15 found
> [    9.472511] cryptd: max_cpu_qlen set to 1000
> [    9.475447] ACPI BIOS Error (bug): Attempt to CreateField of length zero (20190703/dsopcode-134)
> [    9.475494] ACPI Error: Aborting method \_SB.WMIV.WVPI due to previous error (AE_AML_OPERAND_VALUE) (20190703/psparse-531)
> [    9.475543] ACPI Error: Aborting method \_SB.WMIV.WMPV due to previous error (AE_AML_OPERAND_VALUE) (20190703/psparse-531)
> [    9.581887] BTRFS info (device sda4): disk space caching is enabled
> [    9.581889] BTRFS info (device sda4): has skinny extents
> [    9.586691] BTRFS info (device sda4): enabling ssd optimizations
> [    9.596936] lis3lv02d: 8 bits 3DC sensor found
> [    9.621582] Intel(R) Wireless WiFi driver for Linux
> [    9.621583] Copyright(c) 2003- 2015 Intel Corporation
> [    9.621951] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
> [    9.624151] iTCO_vendor_support: vendor-support=0
> [    9.624570] mei_wdt mei::05b79a6f-4628-4d7f-899d-a91514cb32ab:02: Could not reg notif event ret=-22
> [    9.624779] mei_wdt: probe of mei::05b79a6f-4628-4d7f-899d-a91514cb32ab:02 failed with error -22
> [    9.625128] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    9.625128] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    9.625152] e1000e 0000:00:1f.6: enabling device (0000 -> 0002)
> [    9.625393] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [    9.668796] iwlwifi 0000:02:00.0: loaded firmware version 36.9f0a2d68.0 op_mode iwlmvm
> [    9.691972] Adding 7349732k swap on /dev/sda2.  Priority:-2 extents:1 across:7349732k SSFS
> [    9.724379] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [    9.724527] iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
> [    9.724653] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [    9.725107] AVX2 version of gcm_enc/dec engaged.
> [    9.725107] AES CTR mode by8 optimization enabled
> [    9.814814] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
> [    9.880849] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) b0:5a:da:9a:c4:d5
> [    9.880853] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
> [    9.880918] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
> [   10.022857] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
> [   10.023630] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
> [   10.023963] snd_hda_intel 0000:01:00.1: Force to non-snoop mode
> [   10.064825] [drm] radeon kernel modesetting enabled.
> [   10.064952] radeon 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 0: 0x40000000 -> 0x4fffffff
> [   10.064958] radeon 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 2: 0xdc000000 -> 0xdc03ffff
> [   10.064962] checking generic (50000000 300000) vs hw (40000000 10000000)
> [   10.064965] checking generic (50000000 300000) vs hw (dc000000 40000)
> [   10.065067] radeon 0000:01:00.0: enabling device (0006 -> 0007)
> [   10.065719] [drm] initializing kernel modesetting (VERDE 0x1002:0x6820 0x103C:0x80D5 0x83).
> [   10.112926] ATOM BIOS: HP
> [   10.112948] [drm] GPU not posted. posting now...
> [   10.117763] radeon 0000:01:00.0: VRAM: 2048M 0x0000000000000000 - 0x000000007FFFFFFF (2048M used)
> [   10.117766] radeon 0000:01:00.0: GTT: 2048M 0x0000000080000000 - 0x00000000FFFFFFFF
> [   10.117779] [drm] Detected VRAM RAM=2048M, BAR=256M
> [   10.117780] [drm] RAM width 128bits DDR
> [   10.117851] [TTM] Zone  kernel: Available graphics memory: 16378182 KiB
> [   10.117852] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
> [   10.117853] [TTM] Initializing pool allocator
> [   10.117859] [TTM] Initializing DMA pool allocator
> [   10.117881] [drm] radeon: 2048M of VRAM memory ready
> [   10.117882] [drm] radeon: 2048M of GTT memory ready.
> [   10.117895] [drm] Loading verde Microcode
> [   10.148492] [drm] Internal thermal controller with fan control
> [   10.158847] [drm] radeon: dpm initialized
> [   10.164388] [drm] Found VCE firmware/feedback version 50.0.1 / 17!
> [   10.164405] [drm] GART: num cpu pages 524288, num gpu pages 524288
> [   10.167377] [drm] PCIE gen 3 link speeds already enabled
> [   10.180126] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
> [   10.180257] radeon 0000:01:00.0: WB enabled
> [   10.180260] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000080000c00 and cpu addr 0x0000000072a73ee8
> [   10.180261] radeon 0000:01:00.0: fence driver on ring 1 use gpu addr 0x0000000080000c04 and cpu addr 0x000000000b5fa09a
> [   10.180262] radeon 0000:01:00.0: fence driver on ring 2 use gpu addr 0x0000000080000c08 and cpu addr 0x0000000079bab2ca
> [   10.180264] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000080000c0c and cpu addr 0x000000002f8539c5
> [   10.180265] radeon 0000:01:00.0: fence driver on ring 4 use gpu addr 0x0000000080000c10 and cpu addr 0x00000000c4ba72c2
> [   10.180469] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0x00000000c5f1aa66
> [   10.200579] radeon 0000:01:00.0: fence driver on ring 6 use gpu addr 0x0000000080000c18 and cpu addr 0x00000000ebf84042
> [   10.200581] radeon 0000:01:00.0: fence driver on ring 7 use gpu addr 0x0000000080000c1c and cpu addr 0x00000000c35d01ec
> [   10.200593] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   10.200594] [drm] Driver supports precise vblank timestamp query.
> [   10.200595] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
> [   10.200634] radeon 0000:01:00.0: radeon: using MSI.
> [   10.200666] [drm] radeon: irq initialized.
> [   10.213660] FAT-fs (sdb4): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
> [   10.214873] SGI XFS with ACLs, security attributes, no debug enabled
> [   10.216852] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input15
> [   10.219001] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input16
> [   10.219123] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input17
> [   10.219201] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input18
> [   10.219292] input: HDA ATI HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input19
> [   10.219401] input: HDA ATI HDMI HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input20
> [   10.255356] XFS (sdb3): Mounting V5 Filesystem
> [   10.256783] XFS (sda3): Mounting V5 Filesystem
> [   10.260660] checking generic (50000000 300000) vs hw (50000000 10000000)
> [   10.260661] fb0: switching to inteldrmfb from EFI VGA
> [   10.260777] Console: switching to colour dummy device 80x25
> [   10.260833] i915 0000:00:02.0: vgaarb: deactivate vga console
> [   10.262887] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   10.262888] [drm] Driver supports precise vblank timestamp query.
> [   10.263710] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
> [   10.263718] radeon 0000:01:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=none
> [   10.290321] XFS (sda3): Ending clean mount
> [   10.296726] [drm] Finished loading DMC firmware i915/skl_dmc_ver1_27.bin (v1.27)
> [   10.316831] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 8260, REV=0x208
> [   10.318164] kvm: disabled by bios
> [   10.330159] XFS (sdb3): Ending clean mount
> [   10.345236] systemd-journald[474]: Received request to flush runtime journal from PID 1
> [   10.355364] XFS (sda5): Mounting V5 Filesystem
> [   10.389605] XFS (sda5): Ending clean mount
> [   10.442075] iwlwifi 0000:02:00.0: base HW address: 34:13:e8:36:80:58
> [   10.516446] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
> [   10.516680] thermal thermal_zone7: failed to read out thermal zone (-61)
> [   10.545993] Bluetooth: Core ver 2.22
> [   10.546008] NET: Registered protocol family 31
> [   10.546009] Bluetooth: HCI device and connection manager initialized
> [   10.546011] Bluetooth: HCI socket layer initialized
> [   10.546012] Bluetooth: L2CAP socket layer initialized
> [   10.546015] Bluetooth: SCO socket layer initialized
> [   10.557426] usbcore: registered new interface driver btusb
> [   10.557932] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
> [   10.561967] Bluetooth: hci0: Device revision is 5
> [   10.561968] Bluetooth: hci0: Secure boot is enabled
> [   10.561968] Bluetooth: hci0: OTP lock is disabled
> [   10.561969] Bluetooth: hci0: API lock is disabled
> [   10.561969] Bluetooth: hci0: Debug lock is disabled
> [   10.561970] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [   10.564008] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
> [   10.713364] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   10.713365] Bluetooth: BNEP filters: protocol multicast
> [   10.713368] Bluetooth: BNEP socket layer initialized
> [   10.731300] videodev: Linux video capture interface: v2.00
> [   10.733190] usbcore: registered new interface driver cdc_wdm
> [   10.739308] cdc_ether 1-2:2.0 usb0: register 'cdc_ether' at usb-0000:00:14.0-2, CDC Ethernet Device, ae:73:14:29:4a:80
> [   10.739334] usbcore: registered new interface driver cdc_ether
> [   10.739354] usbcore: registered new interface driver qmi_wwan
> [   10.865592] uvcvideo: Found UVC 1.00 device HP HD Camera (04f2:b51d)
> [   10.877661] input: HP HD Camera: HP HD Camera as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/input/input21
> [   10.877782] usbcore: registered new interface driver uvcvideo
> [   10.877783] USB Video Class driver (1.1.1)
> [   10.887706] [drm] ring test on 0 succeeded in 1 usecs
> [   10.887711] [drm] ring test on 1 succeeded in 1 usecs
> [   10.887715] [drm] ring test on 2 succeeded in 1 usecs
> [   10.887730] [drm] ring test on 3 succeeded in 10 usecs
> [   10.887736] [drm] ring test on 4 succeeded in 3 usecs
> [   10.912002] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input22
> [   11.064598] [drm] ring test on 5 succeeded in 2 usecs
> [   11.064625] [drm] UVD initialized successfully.
> [   11.174700] [drm] ring test on 6 succeeded in 20 usecs
> [   11.174712] [drm] ring test on 7 succeeded in 3 usecs
> [   11.174729] [drm] VCE initialized successfully.
> [   11.174868] [drm] ib test on ring 0 succeeded in 0 usecs
> [   11.174927] [drm] ib test on ring 1 succeeded in 0 usecs
> [   11.174986] [drm] ib test on ring 2 succeeded in 0 usecs
> [   11.175043] [drm] ib test on ring 3 succeeded in 0 usecs
> [   11.175098] [drm] ib test on ring 4 succeeded in 0 usecs
> [   11.190842] cdc_ether 1-2:2.0 usb0: unregister 'cdc_ether' usb-0000:00:14.0-2, CDC Ethernet Device
> [   11.411598] kvm: disabled by bios
> [   11.545606] usbcore: registered new interface driver cdc_ncm
> [   11.549345] kvm: disabled by bios
> [   11.640851] cdc_mbim 1-2:3.0: cdc-wdm0: USB WDM device
> [   11.641010] cdc_mbim 1-2:3.0 wwan0: register 'cdc_mbim' at usb-0000:00:14.0-2, CDC MBIM, ce:b8:c9:0c:7e:2f
> [   11.641067] usbcore: registered new interface driver cdc_mbim
> [   11.719869] kvm: disabled by bios
> [   11.719880] intel_rapl_common: Found RAPL domain package
> [   11.719881] intel_rapl_common: Found RAPL domain core
> [   11.719882] intel_rapl_common: Found RAPL domain uncore
> [   11.719883] intel_rapl_common: Found RAPL domain dram
> [   11.852028] [drm] ib test on ring 5 succeeded
> [   11.855105] kvm: disabled by bios
> [   11.970639] kvm: disabled by bios
> [   12.002395] Bluetooth: hci0: Waiting for firmware download to complete
> [   12.002965] Bluetooth: hci0: Firmware loaded in 1411663 usecs
> [   12.003004] Bluetooth: hci0: Waiting for device to boot
> [   12.013988] Bluetooth: hci0: Device booted in 10738 usecs
> [   12.014071] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
> [   12.018154] Bluetooth: hci0: Applying Intel DDC parameters completed
> [   12.085867] kvm: disabled by bios
> [   12.189958] kvm: disabled by bios
> [   12.364185] [drm] ib test on ring 6 succeeded
> [   12.876218] [drm] ib test on ring 7 succeeded
> [   12.888032] [drm] radeon atom DIG backlight initialized
> [   12.888037] [drm] Radeon Display Connectors
> [   12.888039] [drm] Connector 0:
> [   12.888041] [drm]   eDP-2
> [   12.888042] [drm]   HPD3
> [   12.888046] [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558 0x655c 0x655c
> [   12.888047] [drm]   Encoders:
> [   12.888049] [drm]     LCD1: INTERNAL_UNIPHY2
> [   12.888050] [drm] Connector 1:
> [   12.888052] [drm]   DP-4
> [   12.888053] [drm]   HPD4
> [   12.888056] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c 0x656c
> [   12.888057] [drm]   Encoders:
> [   12.888058] [drm]     DFP1: INTERNAL_UNIPHY2
> [   12.888059] [drm] Connector 2:
> [   12.888061] [drm]   DP-5
> [   12.888062] [drm]   HPD1
> [   12.888064] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c
> [   12.888065] [drm]   Encoders:
> [   12.888067] [drm]     DFP2: INTERNAL_UNIPHY1
> [   12.888068] [drm] Connector 3:
> [   12.888069] [drm]   DP-6
> [   12.888070] [drm]   HPD2
> [   12.888072] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c
> [   12.888073] [drm]   Encoders:
> [   12.888074] [drm]     DFP3: INTERNAL_UNIPHY1
> [   13.035994] iwlwifi 0000:02:00.0: Collecting data: trigger 15 fired.
> [   13.284756] iwlwifi 0000:02:00.0: Loaded firmware version: 36.9f0a2d68.0
> [   13.284760] iwlwifi 0000:02:00.0: 0x00000000 | ADVANCED_SYSASSERT          
> [   13.284762] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status0
> [   13.284763] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
> [   13.284764] iwlwifi 0000:02:00.0: 0x00000000 | branchlink2
> [   13.284766] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink1
> [   13.284767] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
> [   13.284768] iwlwifi 0000:02:00.0: 0x00000000 | data1
> [   13.284769] iwlwifi 0000:02:00.0: 0x00000000 | data2
> [   13.284770] iwlwifi 0000:02:00.0: 0x00000000 | data3
> [   13.284771] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
> [   13.284773] iwlwifi 0000:02:00.0: 0x00000000 | tsf low
> [   13.284774] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
> [   13.284775] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
> [   13.284776] iwlwifi 0000:02:00.0: 0x00000000 | time gp2
> [   13.284777] iwlwifi 0000:02:00.0: 0x00000000 | uCode revision type
> [   13.284778] iwlwifi 0000:02:00.0: 0x00000000 | uCode version major
> [   13.284780] iwlwifi 0000:02:00.0: 0x00000000 | uCode version minor
> [   13.284781] iwlwifi 0000:02:00.0: 0x00000000 | hw version
> [   13.284782] iwlwifi 0000:02:00.0: 0x00000000 | board version
> [   13.284783] iwlwifi 0000:02:00.0: 0x00000000 | hcmd
> [   13.284784] iwlwifi 0000:02:00.0: 0x00000000 | isr0
> [   13.284786] iwlwifi 0000:02:00.0: 0x00000000 | isr1
> [   13.284787] iwlwifi 0000:02:00.0: 0x00000000 | isr2
> [   13.284788] iwlwifi 0000:02:00.0: 0x00000000 | isr3
> [   13.284789] iwlwifi 0000:02:00.0: 0x00000000 | isr4
> [   13.284790] iwlwifi 0000:02:00.0: 0x00000000 | last cmd Id
> [   13.284791] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
> [   13.284792] iwlwifi 0000:02:00.0: 0x00000000 | l2p_control
> [   13.284794] iwlwifi 0000:02:00.0: 0x00000000 | l2p_duration
> [   13.284795] iwlwifi 0000:02:00.0: 0x00000000 | l2p_mhvalid
> [   13.284796] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
> [   13.284797] iwlwifi 0000:02:00.0: 0x00000000 | lmpm_pmg_sel
> [   13.284798] iwlwifi 0000:02:00.0: 0x00000000 | timestamp
> [   13.284800] iwlwifi 0000:02:00.0: 0x00000000 | flow_handler
> [   13.284976] iwlwifi 0000:02:00.0: 0x00000000 | ADVANCED_SYSASSERT
> [   13.284977] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink1
> [   13.284979] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink2
> [   13.284980] iwlwifi 0000:02:00.0: 0x00000000 | umac interruptlink1
> [   13.284981] iwlwifi 0000:02:00.0: 0x00000000 | umac interruptlink2
> [   13.284982] iwlwifi 0000:02:00.0: 0x00000000 | umac data1
> [   13.284983] iwlwifi 0000:02:00.0: 0x00000000 | umac data2
> [   13.284985] iwlwifi 0000:02:00.0: 0x00000000 | umac data3
> [   13.284986] iwlwifi 0000:02:00.0: 0x00000000 | umac major
> [   13.284987] iwlwifi 0000:02:00.0: 0x00000000 | umac minor
> [   13.284988] iwlwifi 0000:02:00.0: 0x00000000 | frame pointer
> [   13.284989] iwlwifi 0000:02:00.0: 0x00000000 | stack pointer
> [   13.284990] iwlwifi 0000:02:00.0: 0x00000000 | last host cmd
> [   13.284992] iwlwifi 0000:02:00.0: 0x00000000 | isr status reg
> [   13.285127] iwlwifi 0000:02:00.0: Fseq Registers:
> [   13.285132] iwlwifi 0000:02:00.0: 0x7BAED36C | FSEQ_ERROR_CODE
> [   13.285181] iwlwifi 0000:02:00.0: 0x67438631 | FSEQ_TOP_INIT_VERSION
> [   13.285230] iwlwifi 0000:02:00.0: 0x0A950400 | FSEQ_CNVIO_INIT_VERSION
> [   13.285279] iwlwifi 0000:02:00.0: 0x0000A050 | FSEQ_OTP_VERSION
> [   13.285328] iwlwifi 0000:02:00.0: 0xCEFEB196 | FSEQ_TOP_CONTENT_VERSION
> [   13.285377] iwlwifi 0000:02:00.0: 0xA0FD8C73 | FSEQ_ALIVE_TOKEN
> [   13.285427] iwlwifi 0000:02:00.0: 0xB44772E7 | FSEQ_CNVI_ID
> [   13.285476] iwlwifi 0000:02:00.0: 0xF2BEF376 | FSEQ_CNVR_ID
> [   13.285525] iwlwifi 0000:02:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
> [   13.285574] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
> [   13.285623] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> [   13.285672] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> [   13.285747] iwlwifi 0000:02:00.0: SecBoot CPU1 Status: 0x3090001, CPU2 Status: 0x0
> [   13.285749] iwlwifi 0000:02:00.0: Failed to start INIT ucode: -110
> [   13.285751] iwlwifi 0000:02:00.0: Failed to run INIT ucode: -110
> [   13.285752] iwlwifi 0000:02:00.0: Failed to start RT ucode: -110
> [   13.285761] iwlwifi 0000:02:00.0: Firmware not running - cannot dump error
> [   13.376536] [drm] Cannot find any crtc or sizes
> [   13.380047] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
> [   13.380743] [drm] Initialized i915 1.6.0 20190619 for 0000:00:02.0 on minor 1
> [   13.381628] [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
> [   13.381743] ACPI: Video Device [PEGP] (multi-head: yes  rom: no  post: no)
> [   13.381972] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:05/LNXVIDEO:00/input/input23
> [   13.385282] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [   13.385678] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input24
> [   13.385928] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> [   13.507852] fbcon: i915drmfb (fb0) is primary device
> [   13.511872] Console: switching to colour frame buffer device 240x67
> [   13.538500] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
> [   13.658820] NET: Registered protocol family 17
> [   13.740260] snd_hda_codec_conexant hdaudioC0D0: CX20724: BIOS auto-probing.
> [   13.740782] snd_hda_codec_conexant hdaudioC0D0: autoconfig for CX20724: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
> [   13.740784] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   13.740786] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1 (0x16/0x0/0x0/0x0/0x0)
> [   13.740787] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
> [   13.740787] snd_hda_codec_conexant hdaudioC0D0:    inputs:
> [   13.740789] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x1a
> [   13.740790] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x19
> [   13.745161] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input25
> [   13.745280] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input26
> [   13.801605] [drm] amdgpu kernel modesetting enabled.
> [   14.822245] [drm] Cannot find any crtc or sizes
> [   16.216649] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
> [   16.217200] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   16.217202] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
> [   16.217202] iwlwifi 0000:02:00.0: Loaded firmware version: 36.9f0a2d68.0
> [   16.217204] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
> [   16.217204] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
> [   16.217205] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
> [   16.217206] iwlwifi 0000:02:00.0: 0x00024180 | branchlink2
> [   16.217207] iwlwifi 0000:02:00.0: 0x000397EA | interruptlink1
> [   16.217208] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
> [   16.217209] iwlwifi 0000:02:00.0: 0x00310405 | data1
> [   16.217209] iwlwifi 0000:02:00.0: 0x00000032 | data2
> [   16.217210] iwlwifi 0000:02:00.0: 0x00000032 | data3
> [   16.217211] iwlwifi 0000:02:00.0: 0x00177F51 | beacon time
> [   16.217212] iwlwifi 0000:02:00.0: 0x002882F3 | tsf low
> [   16.217212] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
> [   16.217213] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
> [   16.217214] iwlwifi 0000:02:00.0: 0x002882F4 | time gp2
> [   16.217215] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
> [   16.217216] iwlwifi 0000:02:00.0: 0x00000024 | uCode version major
> [   16.217216] iwlwifi 0000:02:00.0: 0x9F0A2D68 | uCode version minor
> [   16.217217] iwlwifi 0000:02:00.0: 0x00000201 | hw version
> [   16.217218] iwlwifi 0000:02:00.0: 0x00489008 | board version
> [   16.217219] iwlwifi 0000:02:00.0: 0x00310405 | hcmd
> [   16.217220] iwlwifi 0000:02:00.0: 0x00022080 | isr0
> [   16.217220] iwlwifi 0000:02:00.0: 0x00000000 | isr1
> [   16.217221] iwlwifi 0000:02:00.0: 0x28201802 | isr2
> [   16.217222] iwlwifi 0000:02:00.0: 0x00400080 | isr3
> [   16.217223] iwlwifi 0000:02:00.0: 0x00000000 | isr4
> [   16.217223] iwlwifi 0000:02:00.0: 0x003001C8 | last cmd Id
> [   16.217224] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
> [   16.217225] iwlwifi 0000:02:00.0: 0x000097FD | l2p_control
> [   16.217226] iwlwifi 0000:02:00.0: 0x00000000 | l2p_duration
> [   16.217226] iwlwifi 0000:02:00.0: 0x00000000 | l2p_mhvalid
> [   16.217227] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
> [   16.217228] iwlwifi 0000:02:00.0: 0x0000008F | lmpm_pmg_sel
> [   16.217229] iwlwifi 0000:02:00.0: 0x04120134 | timestamp
> [   16.217230] iwlwifi 0000:02:00.0: 0x00003840 | flow_handler
> [   16.217406] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   16.217407] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 7
> [   16.217408] iwlwifi 0000:02:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
> [   16.217408] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink1
> [   16.217409] iwlwifi 0000:02:00.0: 0xC0086AA4 | umac branchlink2
> [   16.217410] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink1
> [   16.217411] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink2
> [   16.217412] iwlwifi 0000:02:00.0: 0x00000800 | umac data1
> [   16.217412] iwlwifi 0000:02:00.0: 0xC0083C90 | umac data2
> [   16.217413] iwlwifi 0000:02:00.0: 0xDEADBEEF | umac data3
> [   16.217414] iwlwifi 0000:02:00.0: 0x00000024 | umac major
> [   16.217415] iwlwifi 0000:02:00.0: 0x9F0A2D68 | umac minor
> [   16.217415] iwlwifi 0000:02:00.0: 0xC088628C | frame pointer
> [   16.217416] iwlwifi 0000:02:00.0: 0xC088628C | stack pointer
> [   16.217417] iwlwifi 0000:02:00.0: 0x00310405 | last host cmd
> [   16.217418] iwlwifi 0000:02:00.0: 0x00000000 | isr status reg
> [   16.217556] iwlwifi 0000:02:00.0: Fseq Registers:
> [   16.217560] iwlwifi 0000:02:00.0: 0x7BAED36C | FSEQ_ERROR_CODE
> [   16.217565] iwlwifi 0000:02:00.0: 0x67438631 | FSEQ_TOP_INIT_VERSION
> [   16.217569] iwlwifi 0000:02:00.0: 0x0A950400 | FSEQ_CNVIO_INIT_VERSION
> [   16.217574] iwlwifi 0000:02:00.0: 0x0000A050 | FSEQ_OTP_VERSION
> [   16.217578] iwlwifi 0000:02:00.0: 0xCEFEB196 | FSEQ_TOP_CONTENT_VERSION
> [   16.217583] iwlwifi 0000:02:00.0: 0xA0FD8C73 | FSEQ_ALIVE_TOKEN
> [   16.217587] iwlwifi 0000:02:00.0: 0xB44772E7 | FSEQ_CNVI_ID
> [   16.217591] iwlwifi 0000:02:00.0: 0xF2BEF376 | FSEQ_CNVR_ID
> [   16.217596] iwlwifi 0000:02:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
> [   16.217603] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
> [   16.217611] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> [   16.217618] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> [   16.217624] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
> [   16.217626] ieee80211 phy0: Hardware restart was requested
> [   16.217629] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
> [   16.217630] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0031 service 0x00000005
> [   16.217631] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x00000000002882EE
> [   16.217660] iwlwifi 0000:02:00.0: iwlwifi transaction failed, dumping registers
> [   16.217675] iwlwifi 0000:02:00.0: iwlwifi device config registers:
> [   16.218317] iwlwifi 0000:02:00.0: 00000000: 24f38086 00100406 0280002a 00000000 dc100004 00000000 00000000 00000000
> [   16.218319] iwlwifi 0000:02:00.0: 00000020: 00000000 00000000 00000000 00108086 00000000 000000c8 00000000 000001ff
> [   16.218320] iwlwifi 0000:02:00.0: 00000040: 00020010 10008ec0 00190c10 0045e811 10110142 00000000 00000000 00000000
> [   16.218321] iwlwifi 0000:02:00.0: 00000060: 00000000 00080812 00000405 00000000 00010001 00000000 00000000 00000000
> [   16.218322] iwlwifi 0000:02:00.0: 00000080: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   16.218324] iwlwifi 0000:02:00.0: 000000a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   16.218325] iwlwifi 0000:02:00.0: 000000c0: 00000000 00000000 c823d001 0d000000 00814005 fee08004 00000000 00004023
> [   16.218326] iwlwifi 0000:02:00.0: 000000e0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   16.218327] iwlwifi 0000:02:00.0: 00000100: 14010001 00000000 00000000 00462031 00000000 00002000 00000000 00000000
> [   16.218328] iwlwifi 0000:02:00.0: 00000120: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   16.218330] iwlwifi 0000:02:00.0: 00000140: 14c10003 ff368058 3413e8ff 15410018 08460846 0001001e 00481e1f 40a0000f
> [   16.218331] iwlwifi 0000:02:00.0: iwlwifi device memory mapped registers:
> [   16.218495] iwlwifi 0000:02:00.0: 00000000: 00489008 0000ff40 00000000 ba00008b 00000000 00000000 00000019 00000000
> [   16.218496] iwlwifi 0000:02:00.0: 00000020: 00000000 08040005 00000201 d55555d5 d55555d5 d55555d5 80008040 041f0042
> [   16.218547] iwlwifi 0000:02:00.0: iwlwifi device AER capability structure:
> [   16.218569] iwlwifi 0000:02:00.0: 00000000: 14010001 00000000 00000000 00462031 00000000 00002000 00000000 00000000
> [   16.218570] iwlwifi 0000:02:00.0: 00000020: 00000000 00000000 00000000
> [   16.218571] iwlwifi 0000:02:00.0: iwlwifi parent port (0000:00:1c.0) config registers:
> [   16.218639] iwlwifi 0000:00:1c.0: 00000000: a1108086 00100407 060400f1 00810000 00000000 00000000 00020200 200000f0
> [   16.218640] iwlwifi 0000:00:1c.0: 00000020: dc10dc10 0001fff1 00000000 00000000 00000000 00000040 00000000 000201ff
> [   16.218642] iwlwifi 0000:00:1c.0: 00000040: 01428010 00008001 0010000f 01724c11 70110042 0004b200 01400000 00000000
> [   16.218643] iwlwifi 0000:00:1c.0: 00000060: 00000000 00000837 00000400 00000002 00010001 00000000 00000000 00000000
> [   16.218644] iwlwifi 0000:00:1c.0: 00000080: 00019005 fee08004 00004021 00000000 0000a00d 80d5103c 00000000 00000000
> [   16.218645] iwlwifi 0000:00:1c.0: 000000a0: c8030001 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   16.218647] iwlwifi 0000:00:1c.0: 000000c0: 00000000 00000000 00000000 00000000 07001001 00001842 8b1e2008 00000000
> [   16.218648] iwlwifi 0000:00:1c.0: 000000e0: 0073f700 8c548c54 00128016 00000000 00000150 40000300 08310fb3 01000000
> [   16.218649] iwlwifi 0000:00:1c.0: 00000100: 14010001 00000000 00010000 00060011 00000000 00002000 00000000 00000000
> [   16.218650] iwlwifi 0000:00:1c.0: 00000120: 00000000 00000000 00000000 00000007 00000000 00000000 00000000 00000000
> [   16.218651] iwlwifi 0000:00:1c.0: 00000140: 2001000d 0000000f 00000000 00000000 00000000 00000000 00000000 00000000
> [   16.218652] iwlwifi 0000:00:1c.0: 00000160: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   16.218654] iwlwifi 0000:00:1c.0: 00000180: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   16.218655] iwlwifi 0000:00:1c.0: 000001a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   16.218656] iwlwifi 0000:00:1c.0: 000001c0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   16.218657] iwlwifi 0000:00:1c.0: 000001e0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   16.218658] iwlwifi 0000:00:1c.0: 00000200: 0001001e 0028281f 40a0280f
> [   16.218659] iwlwifi 0000:02:00.0: iwlwifi root port (0000:00:1c.0) AER cap structure:
> [   16.218666] iwlwifi 0000:00:1c.0: 00000000: 14010001 00000000 00010000 00060011 00000000 00002000 00000000 00000000
> [   16.218667] iwlwifi 0000:00:1c.0: 00000020: 00000000 00000000 00000000 00000007 00000000 00000000
> [   16.218669] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
> [   16.218670] CPU: 3 PID: 166 Comm: kworker/3:1 Tainted: G            E     5.3.0-rc5-default+ #296
> [   16.218671] Hardware name: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [   16.218678] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
> [   16.218679] Call Trace:
> [   16.218684]  dump_stack+0x5c/0x7b
> [   16.218690]  iwl_trans_pcie_send_hcmd+0x4cd/0x510 [iwlwifi]
> [   16.218693]  ? wait_woken+0x80/0x80
> [   16.218698]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
> [   16.218704]  iwl_mvm_send_cmd+0x2c/0xa0 [iwlmvm]
> [   16.218708]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
> [   16.218712]  ? iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   16.218716]  ? iwl_mvm_rx_chub_update_mcc+0xe3/0x190 [iwlmvm]
> [   16.218719]  iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   16.218722]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
> [   16.218725]  process_one_work+0x1f4/0x3e0
> [   16.218726]  worker_thread+0x2d/0x3e0
> [   16.218727]  ? process_one_work+0x3e0/0x3e0
> [   16.218728]  kthread+0x117/0x130
> [   16.218730]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   16.218731]  ret_from_fork+0x35/0x40
> [   16.218734] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
> [   16.218737] ------------[ cut here ]------------
> [   16.218755] WARNING: CPU: 3 PID: 166 at drivers/net/wireless/intel/iwlwifi/mvm/scan.c:1874 iwl_mvm_rx_umac_scan_complete_notif+0x220/0x230 [iwlmvm]
> [   16.218756] Modules linked in: amdgpu(E) snd_hda_codec_conexant(E) snd_hda_codec_generic(E) ledtrig_audio(E) af_packet(E) gpu_sched(E) mfd_core(E) intel_rapl_msr(E) intel_rapl_common(E) cdc_mbim(E) cdc_ncm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) uvcvideo(E) videobuf2_vmalloc(E) videobuf2_memops(E) qmi_wwan(E) videobuf2_v4l2(E) cdc_ether(E) cdc_wdm(E) videodev(E) usbnet(E) mii(E) bnep(E) videobuf2_common(E) btusb(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) iwlmvm(E) kvm(E) nls_iso8859_1(E) i915(E) mac80211(E) nls_cp437(E) irqbypass(E) snd_hda_codec_hdmi(E) xfs(E) crc32_pclmul(E) radeon(E) snd_hda_intel(E) snd_hda_codec(E) vfat(E) ghash_clmulni_intel(E) libarc4(E) fat(E) snd_hda_core(E) aesni_intel(E) iTCO_wdt(E) snd_hwdep(E) msr(E) mei_wdt(E) aes_x86_64(E) iTCO_vendor_support(E) mei_hdcp(E) ttm(E) snd_pcm(E) iwlwifi(E) crypto_simd(E) i2c_algo_bit(E) e1000e(E) hp_accel(E) cryptd(E) ptp(E) drm_kms_helper(E) lis3lv02d(E) snd_timer(E)
> [   16.218773]  hp_wmi(E) glue_helper(E) sparse_keymap(E) i2c_i801(E) joydev(E) pps_core(E) pcspkr(E) input_polldev(E) wmi_bmof(E) drm(E) cfg80211(E) battery(E) intel_pmc_core(E) snd(E) tpm_infineon(E) hp_wireless(E) ac(E) syscopyarea(E) acpi_pad(E) rfkill(E) sysfillrect(E) mei_me(E) soundcore(E) sysimgblt(E) thermal(E) fb_sys_fops(E) mei(E) button(E) intel_pch_thermal(E) btrfs(E) libcrc32c(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E) sd_mod(E) crc32c_intel(E) ahci(E) xhci_pci(E) libahci(E) serio_raw(E) xhci_hcd(E) libata(E) usbcore(E) wmi(E) video(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
> [   16.218787] CPU: 3 PID: 166 Comm: kworker/3:1 Tainted: G            E     5.3.0-rc5-default+ #296
> [   16.218788] Hardware name: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [   16.218791] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
> [   16.218796] RIP: 0010:iwl_mvm_rx_umac_scan_complete_notif+0x220/0x230 [iwlmvm]
> [   16.218797] Code: 00 00 00 00 00 00 8b 8d 68 1d 00 00 41 8b 84 24 ec 1d 00 00 44 8b 4c 24 04 e9 5e fe ff ff 48 c7 c7 00 79 d1 c1 e8 7e 87 40 c2 <0f> 0b e9 12 ff ff ff e8 94 0b 3a c2 0f 1f 40 00 0f 1f 44 00 00 53
> [   16.218798] RSP: 0018:ffffad7c802afe08 EFLAGS: 00010286
> [   16.218799] RAX: 0000000000000024 RBX: ffff98b34f985040 RCX: 0000000000000006
> [   16.218799] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff98b35f2d97a0
> [   16.218800] RBP: ffffad7c802afe50 R08: 0000000000000557 R09: 0000000000000004
> [   16.218800] R10: ffffad7c802afe48 R11: 0000000000000001 R12: ffff98b3334f9e28
> [   16.218801] R13: dead000000000122 R14: dead000000000100 R15: ffff98b35a6f1280
> [   16.218802] FS:  0000000000000000(0000) GS:ffff98b35f2c0000(0000) knlGS:0000000000000000
> [   16.218802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   16.218803] CR2: 00007fd8f9a69bc0 CR3: 000000001b20a006 CR4: 00000000003606e0
> [   16.218803] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   16.218804] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   16.218804] Call Trace:
> [   16.218808]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
> [   16.218810]  process_one_work+0x1f4/0x3e0
> [   16.218811]  worker_thread+0x2d/0x3e0
> [   16.218812]  ? process_one_work+0x3e0/0x3e0
> [   16.218813]  kthread+0x117/0x130
> [   16.218814]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   16.218815]  ret_from_fork+0x35/0x40
> [   16.218817] ---[ end trace 6725bc5c55335222 ]---
> [   19.681049] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
> [   19.681276] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   19.681280] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
> [   19.681284] iwlwifi 0000:02:00.0: Loaded firmware version: 36.9f0a2d68.0
> [   19.681289] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
> [   19.681292] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
> [   19.681296] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
> [   19.681299] iwlwifi 0000:02:00.0: 0x00024180 | branchlink2
> [   19.681303] iwlwifi 0000:02:00.0: 0x000397EA | interruptlink1
> [   19.681306] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
> [   19.681309] iwlwifi 0000:02:00.0: 0x00330405 | data1
> [   19.681312] iwlwifi 0000:02:00.0: 0x00000034 | data2
> [   19.681315] iwlwifi 0000:02:00.0: 0x00000034 | data3
> [   19.681318] iwlwifi 0000:02:00.0: 0x00196F09 | beacon time
> [   19.681322] iwlwifi 0000:02:00.0: 0x002694DA | tsf low
> [   19.681325] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
> [   19.681328] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
> [   19.681331] iwlwifi 0000:02:00.0: 0x002694DB | time gp2
> [   19.681335] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
> [   19.681338] iwlwifi 0000:02:00.0: 0x00000024 | uCode version major
> [   19.681341] iwlwifi 0000:02:00.0: 0x9F0A2D68 | uCode version minor
> [   19.681345] iwlwifi 0000:02:00.0: 0x00000201 | hw version
> [   19.681348] iwlwifi 0000:02:00.0: 0x00489008 | board version
> [   19.681351] iwlwifi 0000:02:00.0: 0x00330405 | hcmd
> [   19.681354] iwlwifi 0000:02:00.0: 0x00022080 | isr0
> [   19.681357] iwlwifi 0000:02:00.0: 0x00000000 | isr1
> [   19.681360] iwlwifi 0000:02:00.0: 0x28201802 | isr2
> [   19.681363] iwlwifi 0000:02:00.0: 0x00400080 | isr3
> [   19.681366] iwlwifi 0000:02:00.0: 0x00000000 | isr4
> [   19.681370] iwlwifi 0000:02:00.0: 0x003201C8 | last cmd Id
> [   19.681373] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
> [   19.681376] iwlwifi 0000:02:00.0: 0x000097BD | l2p_control
> [   19.681379] iwlwifi 0000:02:00.0: 0x00000000 | l2p_duration
> [   19.681382] iwlwifi 0000:02:00.0: 0x00000000 | l2p_mhvalid
> [   19.681386] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
> [   19.681389] iwlwifi 0000:02:00.0: 0x0000008F | lmpm_pmg_sel
> [   19.681392] iwlwifi 0000:02:00.0: 0x04120134 | timestamp
> [   19.681395] iwlwifi 0000:02:00.0: 0x00006070 | flow_handler
> [   19.681577] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   19.681581] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 7
> [   19.681584] iwlwifi 0000:02:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
> [   19.681587] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink1
> [   19.681591] iwlwifi 0000:02:00.0: 0xC0086AA4 | umac branchlink2
> [   19.681594] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink1
> [   19.681597] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink2
> [   19.681600] iwlwifi 0000:02:00.0: 0x00000800 | umac data1
> [   19.681604] iwlwifi 0000:02:00.0: 0xC0083C90 | umac data2
> [   19.681607] iwlwifi 0000:02:00.0: 0xDEADBEEF | umac data3
> [   19.681610] iwlwifi 0000:02:00.0: 0x00000024 | umac major
> [   19.681613] iwlwifi 0000:02:00.0: 0x9F0A2D68 | umac minor
> [   19.681616] iwlwifi 0000:02:00.0: 0xC088628C | frame pointer
> [   19.681619] iwlwifi 0000:02:00.0: 0xC088628C | stack pointer
> [   19.681623] iwlwifi 0000:02:00.0: 0x00330405 | last host cmd
> [   19.681626] iwlwifi 0000:02:00.0: 0x00000000 | isr status reg
> [   19.681764] iwlwifi 0000:02:00.0: Fseq Registers:
> [   19.681820] iwlwifi 0000:02:00.0: 0x7BAED36C | FSEQ_ERROR_CODE
> [   19.681875] iwlwifi 0000:02:00.0: 0x67438631 | FSEQ_TOP_INIT_VERSION
> [   19.681930] iwlwifi 0000:02:00.0: 0x0A950400 | FSEQ_CNVIO_INIT_VERSION
> [   19.681985] iwlwifi 0000:02:00.0: 0x0000A050 | FSEQ_OTP_VERSION
> [   19.682040] iwlwifi 0000:02:00.0: 0xCEFEB196 | FSEQ_TOP_CONTENT_VERSION
> [   19.682095] iwlwifi 0000:02:00.0: 0xA0FD8C73 | FSEQ_ALIVE_TOKEN
> [   19.682150] iwlwifi 0000:02:00.0: 0xB44772E7 | FSEQ_CNVI_ID
> [   19.682205] iwlwifi 0000:02:00.0: 0xF2BEF376 | FSEQ_CNVR_ID
> [   19.682260] iwlwifi 0000:02:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
> [   19.682319] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
> [   19.682377] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> [   19.682435] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> [   19.682500] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
> [   19.682506] ieee80211 phy0: Hardware restart was requested
> [   19.682521] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
> [   19.682525] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0033 service 0x00000005
> [   19.682529] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x00000000002694D7
> [   19.682581] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
> [   19.682587] CPU: 3 PID: 204 Comm: kworker/3:2 Tainted: G        W   E     5.3.0-rc5-default+ #296
> [   19.682589] Hardware name: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [   19.682615] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
> [   19.682617] Call Trace:
> [   19.682631]  dump_stack+0x5c/0x7b
> [   19.682654]  iwl_trans_pcie_send_hcmd+0x4cd/0x510 [iwlwifi]
> [   19.682663]  ? wait_woken+0x80/0x80
> [   19.682686]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
> [   19.682709]  iwl_mvm_send_cmd+0x2c/0xa0 [iwlmvm]
> [   19.682724]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
> [   19.682743]  ? iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   19.682757]  ? iwl_mvm_rx_chub_update_mcc+0xe3/0x190 [iwlmvm]
> [   19.682770]  iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   19.682785]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
> [   19.682792]  process_one_work+0x1f4/0x3e0
> [   19.682798]  worker_thread+0x2d/0x3e0
> [   19.682803]  ? process_one_work+0x3e0/0x3e0
> [   19.682807]  kthread+0x117/0x130
> [   19.682811]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   19.682817]  ret_from_fork+0x35/0x40
> [   19.682824] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
> [   19.682837] ------------[ cut here ]------------
> [   19.682897] WARNING: CPU: 3 PID: 204 at drivers/net/wireless/intel/iwlwifi/mvm/scan.c:1874 iwl_mvm_rx_umac_scan_complete_notif+0x220/0x230 [iwlmvm]
> [   19.682898] Modules linked in: amdgpu(E) snd_hda_codec_conexant(E) snd_hda_codec_generic(E) ledtrig_audio(E) af_packet(E) gpu_sched(E) mfd_core(E) intel_rapl_msr(E) intel_rapl_common(E) cdc_mbim(E) cdc_ncm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) uvcvideo(E) videobuf2_vmalloc(E) videobuf2_memops(E) qmi_wwan(E) videobuf2_v4l2(E) cdc_ether(E) cdc_wdm(E) videodev(E) usbnet(E) mii(E) bnep(E) videobuf2_common(E) btusb(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) iwlmvm(E) kvm(E) nls_iso8859_1(E) i915(E) mac80211(E) nls_cp437(E) irqbypass(E) snd_hda_codec_hdmi(E) xfs(E) crc32_pclmul(E) radeon(E) snd_hda_intel(E) snd_hda_codec(E) vfat(E) ghash_clmulni_intel(E) libarc4(E) fat(E) snd_hda_core(E) aesni_intel(E) iTCO_wdt(E) snd_hwdep(E) msr(E) mei_wdt(E) aes_x86_64(E) iTCO_vendor_support(E) mei_hdcp(E) ttm(E) snd_pcm(E) iwlwifi(E) crypto_simd(E) i2c_algo_bit(E) e1000e(E) hp_accel(E) cryptd(E) ptp(E) drm_kms_helper(E) lis3lv02d(E) snd_timer(E)
> [   19.682952]  hp_wmi(E) glue_helper(E) sparse_keymap(E) i2c_i801(E) joydev(E) pps_core(E) pcspkr(E) input_polldev(E) wmi_bmof(E) drm(E) cfg80211(E) battery(E) intel_pmc_core(E) snd(E) tpm_infineon(E) hp_wireless(E) ac(E) syscopyarea(E) acpi_pad(E) rfkill(E) sysfillrect(E) mei_me(E) soundcore(E) sysimgblt(E) thermal(E) fb_sys_fops(E) mei(E) button(E) intel_pch_thermal(E) btrfs(E) libcrc32c(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E) sd_mod(E) crc32c_intel(E) ahci(E) xhci_pci(E) libahci(E) serio_raw(E) xhci_hcd(E) libata(E) usbcore(E) wmi(E) video(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
> [   19.682995] CPU: 3 PID: 204 Comm: kworker/3:2 Tainted: G        W   E     5.3.0-rc5-default+ #296
> [   19.682997] Hardware name: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [   19.683013] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
> [   19.683033] RIP: 0010:iwl_mvm_rx_umac_scan_complete_notif+0x220/0x230 [iwlmvm]
> [   19.683037] Code: 00 00 00 00 00 00 8b 8d 68 1d 00 00 41 8b 84 24 ec 1d 00 00 44 8b 4c 24 04 e9 5e fe ff ff 48 c7 c7 00 79 d1 c1 e8 7e 87 40 c2 <0f> 0b e9 12 ff ff ff e8 94 0b 3a c2 0f 1f 40 00 0f 1f 44 00 00 53
> [   19.683040] RSP: 0018:ffffad7c8038be08 EFLAGS: 00010286
> [   19.683043] RAX: 0000000000000024 RBX: ffff98b34f944040 RCX: 0000000000000006
> [   19.683045] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff98b35f2d97a0
> [   19.683047] RBP: ffffad7c8038be50 R08: 00000000000005d2 R09: 0000000000000004
> [   19.683049] R10: ffffad7c8038be48 R11: 0000000000000001 R12: ffff98b3334f9e28
> [   19.683051] R13: dead000000000122 R14: dead000000000100 R15: ffff98b34f455080
> [   19.683054] FS:  0000000000000000(0000) GS:ffff98b35f2c0000(0000) knlGS:0000000000000000
> [   19.683056] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   19.683058] CR2: 00007fd8f91a7000 CR3: 000000001b20a003 CR4: 00000000003606e0
> [   19.683060] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   19.683062] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   19.683063] Call Trace:
> [   19.683081]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
> [   19.683088]  process_one_work+0x1f4/0x3e0
> [   19.683093]  worker_thread+0x2d/0x3e0
> [   19.683098]  ? process_one_work+0x3e0/0x3e0
> [   19.683101]  kthread+0x117/0x130
> [   19.683105]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   19.683110]  ret_from_fork+0x35/0x40
> [   19.683115] ---[ end trace 6725bc5c55335223 ]---
> [   33.868089] iwlwifi 0000:02:00.0: regular scan timed out
> [   33.869673] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x2000000.
> [   33.869917] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   33.869922] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
> [   33.869926] iwlwifi 0000:02:00.0: Loaded firmware version: 36.9f0a2d68.0
> [   33.869930] iwlwifi 0000:02:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN       
> [   33.869934] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
> [   33.869937] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
> [   33.869940] iwlwifi 0000:02:00.0: 0x00024180 | branchlink2
> [   33.869944] iwlwifi 0000:02:00.0: 0x000397EA | interruptlink1
> [   33.869947] iwlwifi 0000:02:00.0: 0x0000483A | interruptlink2
> [   33.869950] iwlwifi 0000:02:00.0: 0x00000000 | data1
> [   33.869953] iwlwifi 0000:02:00.0: 0x00000080 | data2
> [   33.869956] iwlwifi 0000:02:00.0: 0x07830000 | data3
> [   33.869960] iwlwifi 0000:02:00.0: 0x0037BCD6 | beacon time
> [   33.869963] iwlwifi 0000:02:00.0: 0x00CC1C10 | tsf low
> [   33.869966] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
> [   33.869969] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
> [   33.869973] iwlwifi 0000:02:00.0: 0x00CC1C11 | time gp2
> [   33.869976] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
> [   33.869979] iwlwifi 0000:02:00.0: 0x00000024 | uCode version major
> [   33.869983] iwlwifi 0000:02:00.0: 0x9F0A2D68 | uCode version minor
> [   33.869986] iwlwifi 0000:02:00.0: 0x00000201 | hw version
> [   33.869989] iwlwifi 0000:02:00.0: 0x00489008 | board version
> [   33.869992] iwlwifi 0000:02:00.0: 0x0030012C | hcmd
> [   33.869995] iwlwifi 0000:02:00.0: 0x00022000 | isr0
> [   33.869998] iwlwifi 0000:02:00.0: 0x00800000 | isr1
> [   33.870002] iwlwifi 0000:02:00.0: 0x08001802 | isr2
> [   33.870005] iwlwifi 0000:02:00.0: 0x40400180 | isr3
> [   33.870008] iwlwifi 0000:02:00.0: 0x00000000 | isr4
> [   33.870011] iwlwifi 0000:02:00.0: 0x0030012C | last cmd Id
> [   33.870014] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
> [   33.870018] iwlwifi 0000:02:00.0: 0x000097FD | l2p_control
> [   33.870021] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
> [   33.870024] iwlwifi 0000:02:00.0: 0x00000000 | l2p_mhvalid
> [   33.870027] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
> [   33.870030] iwlwifi 0000:02:00.0: 0x0000008F | lmpm_pmg_sel
> [   33.870034] iwlwifi 0000:02:00.0: 0x04120134 | timestamp
> [   33.870037] iwlwifi 0000:02:00.0: 0x00342838 | flow_handler
> [   33.870219] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   33.870222] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 7
> [   33.870226] iwlwifi 0000:02:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
> [   33.870229] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink1
> [   33.870232] iwlwifi 0000:02:00.0: 0xC0086AA4 | umac branchlink2
> [   33.870235] iwlwifi 0000:02:00.0: 0xC008D83C | umac interruptlink1
> [   33.870239] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink2
> [   33.870242] iwlwifi 0000:02:00.0: 0x00000800 | umac data1
> [   33.870245] iwlwifi 0000:02:00.0: 0xC0083C90 | umac data2
> [   33.870248] iwlwifi 0000:02:00.0: 0xDEADBEEF | umac data3
> [   33.870251] iwlwifi 0000:02:00.0: 0x00000024 | umac major
> [   33.870254] iwlwifi 0000:02:00.0: 0x9F0A2D68 | umac minor
> [   33.870257] iwlwifi 0000:02:00.0: 0xC088628C | frame pointer
> [   33.870261] iwlwifi 0000:02:00.0: 0xC088628C | stack pointer
> [   33.870264] iwlwifi 0000:02:00.0: 0x0030012C | last host cmd
> [   33.870267] iwlwifi 0000:02:00.0: 0x00000000 | isr status reg
> [   33.870406] iwlwifi 0000:02:00.0: Fseq Registers:
> [   33.870461] iwlwifi 0000:02:00.0: 0x7BAED36C | FSEQ_ERROR_CODE
> [   33.870516] iwlwifi 0000:02:00.0: 0x67438631 | FSEQ_TOP_INIT_VERSION
> [   33.870571] iwlwifi 0000:02:00.0: 0x0A950400 | FSEQ_CNVIO_INIT_VERSION
> [   33.870626] iwlwifi 0000:02:00.0: 0x0000A050 | FSEQ_OTP_VERSION
> [   33.870681] iwlwifi 0000:02:00.0: 0xCEFEB196 | FSEQ_TOP_CONTENT_VERSION
> [   33.870736] iwlwifi 0000:02:00.0: 0xA0FD8C73 | FSEQ_ALIVE_TOKEN
> [   33.870791] iwlwifi 0000:02:00.0: 0xB44772E7 | FSEQ_CNVI_ID
> [   33.870847] iwlwifi 0000:02:00.0: 0xF2BEF376 | FSEQ_CNVR_ID
> [   33.870902] iwlwifi 0000:02:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
> [   33.870957] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
> [   33.871015] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> [   33.871073] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> [   33.871129] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
> [   33.871138] ieee80211 phy0: Hardware restart was requested
> [   42.496384] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
> [   42.496599] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   42.496604] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
> [   42.496608] iwlwifi 0000:02:00.0: Loaded firmware version: 36.9f0a2d68.0
> [   42.496613] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
> [   42.496617] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
> [   42.496621] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
> [   42.496624] iwlwifi 0000:02:00.0: 0x00024180 | branchlink2
> [   42.496627] iwlwifi 0000:02:00.0: 0x000397EA | interruptlink1
> [   42.496630] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
> [   42.496634] iwlwifi 0000:02:00.0: 0x00330405 | data1
> [   42.496637] iwlwifi 0000:02:00.0: 0x00000034 | data2
> [   42.496640] iwlwifi 0000:02:00.0: 0x00000034 | data3
> [   42.496643] iwlwifi 0000:02:00.0: 0x0011E906 | beacon time
> [   42.496646] iwlwifi 0000:02:00.0: 0x0077E570 | tsf low
> [   42.496650] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
> [   42.496653] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
> [   42.496656] iwlwifi 0000:02:00.0: 0x0077E571 | time gp2
> [   42.496659] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
> [   42.496662] iwlwifi 0000:02:00.0: 0x00000024 | uCode version major
> [   42.496666] iwlwifi 0000:02:00.0: 0x9F0A2D68 | uCode version minor
> [   42.496669] iwlwifi 0000:02:00.0: 0x00000201 | hw version
> [   42.496672] iwlwifi 0000:02:00.0: 0x00489008 | board version
> [   42.496675] iwlwifi 0000:02:00.0: 0x00330405 | hcmd
> [   42.496679] iwlwifi 0000:02:00.0: 0x00022080 | isr0
> [   42.496682] iwlwifi 0000:02:00.0: 0x00000000 | isr1
> [   42.496685] iwlwifi 0000:02:00.0: 0x28201802 | isr2
> [   42.496688] iwlwifi 0000:02:00.0: 0x00400080 | isr3
> [   42.496691] iwlwifi 0000:02:00.0: 0x00000000 | isr4
> [   42.496694] iwlwifi 0000:02:00.0: 0x003201C8 | last cmd Id
> [   42.496697] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
> [   42.496701] iwlwifi 0000:02:00.0: 0x000097BD | l2p_control
> [   42.496704] iwlwifi 0000:02:00.0: 0x00000000 | l2p_duration
> [   42.496707] iwlwifi 0000:02:00.0: 0x00000000 | l2p_mhvalid
> [   42.496710] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
> [   42.496714] iwlwifi 0000:02:00.0: 0x0000008F | lmpm_pmg_sel
> [   42.496717] iwlwifi 0000:02:00.0: 0x04120134 | timestamp
> [   42.496720] iwlwifi 0000:02:00.0: 0x00005068 | flow_handler
> [   42.496901] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   42.496904] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 7
> [   42.496908] iwlwifi 0000:02:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
> [   42.496912] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink1
> [   42.496915] iwlwifi 0000:02:00.0: 0xC0086AA4 | umac branchlink2
> [   42.496918] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink1
> [   42.496921] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink2
> [   42.496924] iwlwifi 0000:02:00.0: 0x00000800 | umac data1
> [   42.496927] iwlwifi 0000:02:00.0: 0xC0083C90 | umac data2
> [   42.496931] iwlwifi 0000:02:00.0: 0xDEADBEEF | umac data3
> [   42.496934] iwlwifi 0000:02:00.0: 0x00000024 | umac major
> [   42.496937] iwlwifi 0000:02:00.0: 0x9F0A2D68 | umac minor
> [   42.496940] iwlwifi 0000:02:00.0: 0xC088628C | frame pointer
> [   42.496943] iwlwifi 0000:02:00.0: 0xC088628C | stack pointer
> [   42.496946] iwlwifi 0000:02:00.0: 0x00330405 | last host cmd
> [   42.496950] iwlwifi 0000:02:00.0: 0x00000000 | isr status reg
> [   42.497088] iwlwifi 0000:02:00.0: Fseq Registers:
> [   42.497144] iwlwifi 0000:02:00.0: 0x7BAED36C | FSEQ_ERROR_CODE
> [   42.497199] iwlwifi 0000:02:00.0: 0x67438631 | FSEQ_TOP_INIT_VERSION
> [   42.497254] iwlwifi 0000:02:00.0: 0x0A950400 | FSEQ_CNVIO_INIT_VERSION
> [   42.497309] iwlwifi 0000:02:00.0: 0x0000A050 | FSEQ_OTP_VERSION
> [   42.497364] iwlwifi 0000:02:00.0: 0xCEFEB196 | FSEQ_TOP_CONTENT_VERSION
> [   42.497419] iwlwifi 0000:02:00.0: 0xA0FD8C73 | FSEQ_ALIVE_TOKEN
> [   42.497474] iwlwifi 0000:02:00.0: 0xB44772E7 | FSEQ_CNVI_ID
> [   42.497529] iwlwifi 0000:02:00.0: 0xF2BEF376 | FSEQ_CNVR_ID
> [   42.497584] iwlwifi 0000:02:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
> [   42.497642] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
> [   42.497701] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> [   42.497759] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> [   42.497835] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
> [   42.497842] ieee80211 phy0: Hardware restart was requested
> [   42.497856] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
> [   42.497860] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0033 service 0x00000005
> [   42.497864] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x000000000077E56D
> [   42.497895] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
> [   42.497903] CPU: 7 PID: 168 Comm: kworker/7:1 Tainted: G        W   E     5.3.0-rc5-default+ #296
> [   42.497906] Hardware name: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [   42.497937] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
> [   42.497941] Call Trace:
> [   42.497957]  dump_stack+0x5c/0x7b
> [   42.497980]  iwl_trans_pcie_send_hcmd+0x4cd/0x510 [iwlwifi]
> [   42.497988]  ? wait_woken+0x80/0x80
> [   42.498011]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
> [   42.498033]  iwl_mvm_send_cmd+0x2c/0xa0 [iwlmvm]
> [   42.498046]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
> [   42.498064]  ? iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   42.498078]  ? iwl_mvm_rx_chub_update_mcc+0xe3/0x190 [iwlmvm]
> [   42.498090]  iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   42.498104]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
> [   42.498111]  process_one_work+0x1f4/0x3e0
> [   42.498117]  worker_thread+0x2d/0x3e0
> [   42.498122]  ? process_one_work+0x3e0/0x3e0
> [   42.498126]  kthread+0x117/0x130
> [   42.498130]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   42.498136]  ret_from_fork+0x35/0x40
> [   42.498143] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
> [   42.498157] ------------[ cut here ]------------
> [   42.498215] WARNING: CPU: 7 PID: 168 at drivers/net/wireless/intel/iwlwifi/mvm/scan.c:1874 iwl_mvm_rx_umac_scan_complete_notif+0x220/0x230 [iwlmvm]
> [   42.498216] Modules linked in: amdgpu(E) snd_hda_codec_conexant(E) snd_hda_codec_generic(E) ledtrig_audio(E) af_packet(E) gpu_sched(E) mfd_core(E) intel_rapl_msr(E) intel_rapl_common(E) cdc_mbim(E) cdc_ncm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) uvcvideo(E) videobuf2_vmalloc(E) videobuf2_memops(E) qmi_wwan(E) videobuf2_v4l2(E) cdc_ether(E) cdc_wdm(E) videodev(E) usbnet(E) mii(E) bnep(E) videobuf2_common(E) btusb(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) iwlmvm(E) kvm(E) nls_iso8859_1(E) i915(E) mac80211(E) nls_cp437(E) irqbypass(E) snd_hda_codec_hdmi(E) xfs(E) crc32_pclmul(E) radeon(E) snd_hda_intel(E) snd_hda_codec(E) vfat(E) ghash_clmulni_intel(E) libarc4(E) fat(E) snd_hda_core(E) aesni_intel(E) iTCO_wdt(E) snd_hwdep(E) msr(E) mei_wdt(E) aes_x86_64(E) iTCO_vendor_support(E) mei_hdcp(E) ttm(E) snd_pcm(E) iwlwifi(E) crypto_simd(E) i2c_algo_bit(E) e1000e(E) hp_accel(E) cryptd(E) ptp(E) drm_kms_helper(E) lis3lv02d(E) snd_timer(E)
> [   42.498269]  hp_wmi(E) glue_helper(E) sparse_keymap(E) i2c_i801(E) joydev(E) pps_core(E) pcspkr(E) input_polldev(E) wmi_bmof(E) drm(E) cfg80211(E) battery(E) intel_pmc_core(E) snd(E) tpm_infineon(E) hp_wireless(E) ac(E) syscopyarea(E) acpi_pad(E) rfkill(E) sysfillrect(E) mei_me(E) soundcore(E) sysimgblt(E) thermal(E) fb_sys_fops(E) mei(E) button(E) intel_pch_thermal(E) btrfs(E) libcrc32c(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E) sd_mod(E) crc32c_intel(E) ahci(E) xhci_pci(E) libahci(E) serio_raw(E) xhci_hcd(E) libata(E) usbcore(E) wmi(E) video(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
> [   42.498314] CPU: 7 PID: 168 Comm: kworker/7:1 Tainted: G        W   E     5.3.0-rc5-default+ #296
> [   42.498315] Hardware name: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [   42.498330] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
> [   42.498351] RIP: 0010:iwl_mvm_rx_umac_scan_complete_notif+0x220/0x230 [iwlmvm]
> [   42.498355] Code: 00 00 00 00 00 00 8b 8d 68 1d 00 00 41 8b 84 24 ec 1d 00 00 44 8b 4c 24 04 e9 5e fe ff ff 48 c7 c7 00 79 d1 c1 e8 7e 87 40 c2 <0f> 0b e9 12 ff ff ff e8 94 0b 3a c2 0f 1f 40 00 0f 1f 44 00 00 53
> [   42.498358] RSP: 0018:ffffad7c80ed3e08 EFLAGS: 00010286
> [   42.498361] RAX: 0000000000000024 RBX: ffff98b333410040 RCX: 0000000000000006
> [   42.498363] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff98b35f3d97a0
> [   42.498365] RBP: ffffad7c80ed3e50 R08: 0000000000000693 R09: 0000000000000004
> [   42.498367] R10: ffffad7c80ed3e48 R11: 0000000000000001 R12: ffff98b3334f9e28
> [   42.498368] R13: dead000000000122 R14: dead000000000100 R15: ffff98b35a4658c0
> [   42.498372] FS:  0000000000000000(0000) GS:ffff98b35f3c0000(0000) knlGS:0000000000000000
> [   42.498374] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   42.498376] CR2: 00007f418be55fc8 CR3: 000000001b20a002 CR4: 00000000003606e0
> [   42.498378] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   42.498380] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   42.498381] Call Trace:
> [   42.498397]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
> [   42.498404]  process_one_work+0x1f4/0x3e0
> [   42.498409]  worker_thread+0x2d/0x3e0
> [   42.498414]  ? process_one_work+0x3e0/0x3e0
> [   42.498417]  kthread+0x117/0x130
> [   42.498421]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   42.498426]  ret_from_fork+0x35/0x40
> [   42.498430] ---[ end trace 6725bc5c55335224 ]---
> [   44.778283] Bluetooth: RFCOMM TTY layer initialized
> [   44.778298] Bluetooth: RFCOMM socket layer initialized
> [   44.778307] Bluetooth: RFCOMM ver 1.11
> [   45.876257] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
> [   45.876485] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   45.876497] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
> [   45.876500] iwlwifi 0000:02:00.0: Loaded firmware version: 36.9f0a2d68.0
> [   45.876505] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
> [   45.876506] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
> [   45.876507] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
> [   45.876509] iwlwifi 0000:02:00.0: 0x00024180 | branchlink2
> [   45.876511] iwlwifi 0000:02:00.0: 0x000397EA | interruptlink1
> [   45.876512] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
> [   45.876514] iwlwifi 0000:02:00.0: 0x00380405 | data1
> [   45.876515] iwlwifi 0000:02:00.0: 0x00000039 | data2
> [   45.876516] iwlwifi 0000:02:00.0: 0x00000039 | data3
> [   45.876517] iwlwifi 0000:02:00.0: 0x0018CE44 | beacon time
> [   45.876519] iwlwifi 0000:02:00.0: 0x0027336E | tsf low
> [   45.876522] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
> [   45.876524] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
> [   45.876525] iwlwifi 0000:02:00.0: 0x00273370 | time gp2
> [   45.876526] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
> [   45.876527] iwlwifi 0000:02:00.0: 0x00000024 | uCode version major
> [   45.876528] iwlwifi 0000:02:00.0: 0x9F0A2D68 | uCode version minor
> [   45.876530] iwlwifi 0000:02:00.0: 0x00000201 | hw version
> [   45.876531] iwlwifi 0000:02:00.0: 0x00489008 | board version
> [   45.876533] iwlwifi 0000:02:00.0: 0x00380405 | hcmd
> [   45.876534] iwlwifi 0000:02:00.0: 0x00022080 | isr0
> [   45.876535] iwlwifi 0000:02:00.0: 0x00000000 | isr1
> [   45.876536] iwlwifi 0000:02:00.0: 0x28201802 | isr2
> [   45.876538] iwlwifi 0000:02:00.0: 0x00400080 | isr3
> [   45.876540] iwlwifi 0000:02:00.0: 0x00000000 | isr4
> [   45.876541] iwlwifi 0000:02:00.0: 0x003701C8 | last cmd Id
> [   45.876542] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
> [   45.876544] iwlwifi 0000:02:00.0: 0x00006D82 | l2p_control
> [   45.876545] iwlwifi 0000:02:00.0: 0x00000000 | l2p_duration
> [   45.876547] iwlwifi 0000:02:00.0: 0x00000000 | l2p_mhvalid
> [   45.876548] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
> [   45.876549] iwlwifi 0000:02:00.0: 0x0000008F | lmpm_pmg_sel
> [   45.876550] iwlwifi 0000:02:00.0: 0x04120134 | timestamp
> [   45.876552] iwlwifi 0000:02:00.0: 0x00005868 | flow_handler
> [   45.876732] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   45.876735] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 7
> [   45.876737] iwlwifi 0000:02:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
> [   45.876738] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink1
> [   45.876740] iwlwifi 0000:02:00.0: 0xC0086AA4 | umac branchlink2
> [   45.876741] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink1
> [   45.876743] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink2
> [   45.876745] iwlwifi 0000:02:00.0: 0x00000800 | umac data1
> [   45.876747] iwlwifi 0000:02:00.0: 0xC0083C90 | umac data2
> [   45.876748] iwlwifi 0000:02:00.0: 0xDEADBEEF | umac data3
> [   45.876750] iwlwifi 0000:02:00.0: 0x00000024 | umac major
> [   45.876751] iwlwifi 0000:02:00.0: 0x9F0A2D68 | umac minor
> [   45.876753] iwlwifi 0000:02:00.0: 0xC088628C | frame pointer
> [   45.876754] iwlwifi 0000:02:00.0: 0xC088628C | stack pointer
> [   45.876755] iwlwifi 0000:02:00.0: 0x00380405 | last host cmd
> [   45.876757] iwlwifi 0000:02:00.0: 0x00000000 | isr status reg
> [   45.876904] iwlwifi 0000:02:00.0: Fseq Registers:
> [   45.877055] iwlwifi 0000:02:00.0: 0x7BAED36C | FSEQ_ERROR_CODE
> [   45.877206] iwlwifi 0000:02:00.0: 0x67438631 | FSEQ_TOP_INIT_VERSION
> [   45.877351] iwlwifi 0000:02:00.0: 0x0A950400 | FSEQ_CNVIO_INIT_VERSION
> [   45.877497] iwlwifi 0000:02:00.0: 0x0000A050 | FSEQ_OTP_VERSION
> [   45.877647] iwlwifi 0000:02:00.0: 0xCEFEB196 | FSEQ_TOP_CONTENT_VERSION
> [   45.877787] iwlwifi 0000:02:00.0: 0xA0FD8C73 | FSEQ_ALIVE_TOKEN
> [   45.877842] iwlwifi 0000:02:00.0: 0xB44772E7 | FSEQ_CNVI_ID
> [   45.877896] iwlwifi 0000:02:00.0: 0xF2BEF376 | FSEQ_CNVR_ID
> [   45.877952] iwlwifi 0000:02:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
> [   45.878013] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
> [   45.878163] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> [   45.878308] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> [   45.878368] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
> [   45.878372] ieee80211 phy0: Hardware restart was requested
> [   45.878380] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
> [   45.878381] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0038 service 0x00000005
> [   45.878383] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x000000000027336B
> [   45.878397] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
> [   45.878400] CPU: 7 PID: 1431 Comm: kworker/7:3 Tainted: G        W   E     5.3.0-rc5-default+ #296
> [   45.878401] Hardware name: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [   45.878414] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
> [   45.878415] Call Trace:
> [   45.878423]  dump_stack+0x5c/0x7b
> [   45.878433]  iwl_trans_pcie_send_hcmd+0x4cd/0x510 [iwlwifi]
> [   45.878437]  ? wait_woken+0x80/0x80
> [   45.878446]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
> [   45.878455]  iwl_mvm_send_cmd+0x2c/0xa0 [iwlmvm]
> [   45.878461]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
> [   45.878468]  ? iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   45.878474]  ? iwl_mvm_rx_chub_update_mcc+0xe3/0x190 [iwlmvm]
> [   45.878480]  iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   45.878485]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
> [   45.878489]  process_one_work+0x1f4/0x3e0
> [   45.878491]  worker_thread+0x2d/0x3e0
> [   45.878493]  ? process_one_work+0x3e0/0x3e0
> [   45.878494]  kthread+0x117/0x130
> [   45.878496]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   45.878498]  ret_from_fork+0x35/0x40
> [   45.878503] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
> [   45.878510] ------------[ cut here ]------------
> [   45.878543] WARNING: CPU: 7 PID: 1431 at drivers/net/wireless/intel/iwlwifi/mvm/scan.c:1874 iwl_mvm_rx_umac_scan_complete_notif+0x220/0x230 [iwlmvm]
> [   45.878548] Modules linked in: rfcomm(E) amdgpu(E) snd_hda_codec_conexant(E) snd_hda_codec_generic(E) ledtrig_audio(E) af_packet(E) gpu_sched(E) mfd_core(E) intel_rapl_msr(E) intel_rapl_common(E) cdc_mbim(E) cdc_ncm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) uvcvideo(E) videobuf2_vmalloc(E) videobuf2_memops(E) qmi_wwan(E) videobuf2_v4l2(E) cdc_ether(E) cdc_wdm(E) videodev(E) usbnet(E) mii(E) bnep(E) videobuf2_common(E) btusb(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) iwlmvm(E) kvm(E) nls_iso8859_1(E) i915(E) mac80211(E) nls_cp437(E) irqbypass(E) snd_hda_codec_hdmi(E) xfs(E) crc32_pclmul(E) radeon(E) snd_hda_intel(E) snd_hda_codec(E) vfat(E) ghash_clmulni_intel(E) libarc4(E) fat(E) snd_hda_core(E) aesni_intel(E) iTCO_wdt(E) snd_hwdep(E) msr(E) mei_wdt(E) aes_x86_64(E) iTCO_vendor_support(E) mei_hdcp(E) ttm(E) snd_pcm(E) iwlwifi(E) crypto_simd(E) i2c_algo_bit(E) e1000e(E) hp_accel(E) cryptd(E) ptp(E) drm_kms_helper(E) lis3lv02d(E)
> [   45.878580]  snd_timer(E) hp_wmi(E) glue_helper(E) sparse_keymap(E) i2c_i801(E) joydev(E) pps_core(E) pcspkr(E) input_polldev(E) wmi_bmof(E) drm(E) cfg80211(E) battery(E) intel_pmc_core(E) snd(E) tpm_infineon(E) hp_wireless(E) ac(E) syscopyarea(E) acpi_pad(E) rfkill(E) sysfillrect(E) mei_me(E) soundcore(E) sysimgblt(E) thermal(E) fb_sys_fops(E) mei(E) button(E) intel_pch_thermal(E) btrfs(E) libcrc32c(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E) sd_mod(E) crc32c_intel(E) ahci(E) xhci_pci(E) libahci(E) serio_raw(E) xhci_hcd(E) libata(E) usbcore(E) wmi(E) video(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
> [   45.878604] CPU: 7 PID: 1431 Comm: kworker/7:3 Tainted: G        W   E     5.3.0-rc5-default+ #296
> [   45.878605] Hardware name: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [   45.878611] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
> [   45.878619] RIP: 0010:iwl_mvm_rx_umac_scan_complete_notif+0x220/0x230 [iwlmvm]
> [   45.878621] Code: 00 00 00 00 00 00 8b 8d 68 1d 00 00 41 8b 84 24 ec 1d 00 00 44 8b 4c 24 04 e9 5e fe ff ff 48 c7 c7 00 79 d1 c1 e8 7e 87 40 c2 <0f> 0b e9 12 ff ff ff e8 94 0b 3a c2 0f 1f 40 00 0f 1f 44 00 00 53
> [   45.878622] RSP: 0000:ffffad7c80463e08 EFLAGS: 00010286
> [   45.878623] RAX: 0000000000000024 RBX: ffff98b35a645040 RCX: 0000000000000006
> [   45.878624] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff98b35f3d97a0
> [   45.878625] RBP: ffffad7c80463e50 R08: 0000000000000711 R09: 0000000000000004
> [   45.878626] R10: ffffad7c80463e48 R11: 0000000000000001 R12: ffff98b3334f9e28
> [   45.878627] R13: dead000000000122 R14: dead000000000100 R15: ffff98b3335cc5c0
> [   45.878628] FS:  0000000000000000(0000) GS:ffff98b35f3c0000(0000) knlGS:0000000000000000
> [   45.878629] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   45.878629] CR2: 000055cad7d972b8 CR3: 000000087b4ea004 CR4: 00000000003606e0
> [   45.878630] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   45.878631] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   45.878632] Call Trace:
> [   45.878641]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
> [   45.878644]  process_one_work+0x1f4/0x3e0
> [   45.878645]  worker_thread+0x2d/0x3e0
> [   45.878647]  ? process_one_work+0x3e0/0x3e0
> [   45.878648]  kthread+0x117/0x130
> [   45.878650]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   45.878652]  ret_from_fork+0x35/0x40
> [   45.878653] ---[ end trace 6725bc5c55335225 ]---
> [   46.934485] fuse: init (API version 7.31)
> [   49.140946] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
> [   49.141108] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   49.141109] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
> [   49.141110] iwlwifi 0000:02:00.0: Loaded firmware version: 36.9f0a2d68.0
> [   49.141111] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
> [   49.141112] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
> [   49.141113] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
> [   49.141114] iwlwifi 0000:02:00.0: 0x00024180 | branchlink2
> [   49.141115] iwlwifi 0000:02:00.0: 0x000397EA | interruptlink1
> [   49.141116] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
> [   49.141117] iwlwifi 0000:02:00.0: 0x00330405 | data1
> [   49.141118] iwlwifi 0000:02:00.0: 0x00000034 | data2
> [   49.141118] iwlwifi 0000:02:00.0: 0x00000034 | data3
> [   49.141119] iwlwifi 0000:02:00.0: 0x00197E78 | beacon time
> [   49.141120] iwlwifi 0000:02:00.0: 0x0026833A | tsf low
> [   49.141121] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
> [   49.141122] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
> [   49.141123] iwlwifi 0000:02:00.0: 0x0026833B | time gp2
> [   49.141123] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
> [   49.141124] iwlwifi 0000:02:00.0: 0x00000024 | uCode version major
> [   49.141125] iwlwifi 0000:02:00.0: 0x9F0A2D68 | uCode version minor
> [   49.141126] iwlwifi 0000:02:00.0: 0x00000201 | hw version
> [   49.141127] iwlwifi 0000:02:00.0: 0x00489008 | board version
> [   49.141128] iwlwifi 0000:02:00.0: 0x00330405 | hcmd
> [   49.141128] iwlwifi 0000:02:00.0: 0x00022080 | isr0
> [   49.141129] iwlwifi 0000:02:00.0: 0x00000000 | isr1
> [   49.141130] iwlwifi 0000:02:00.0: 0x28201802 | isr2
> [   49.141132] iwlwifi 0000:02:00.0: 0x00400080 | isr3
> [   49.141133] iwlwifi 0000:02:00.0: 0x00000000 | isr4
> [   49.141134] iwlwifi 0000:02:00.0: 0x003201C8 | last cmd Id
> [   49.141135] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
> [   49.141136] iwlwifi 0000:02:00.0: 0x000081D1 | l2p_control
> [   49.141136] iwlwifi 0000:02:00.0: 0x00000000 | l2p_duration
> [   49.141137] iwlwifi 0000:02:00.0: 0x00000000 | l2p_mhvalid
> [   49.141138] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
> [   49.141139] iwlwifi 0000:02:00.0: 0x0000008F | lmpm_pmg_sel
> [   49.141140] iwlwifi 0000:02:00.0: 0x04120134 | timestamp
> [   49.141141] iwlwifi 0000:02:00.0: 0x00006070 | flow_handler
> [   49.141317] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   49.141318] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 7
> [   49.141319] iwlwifi 0000:02:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
> [   49.141320] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink1
> [   49.141321] iwlwifi 0000:02:00.0: 0xC0086AA4 | umac branchlink2
> [   49.141322] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink1
> [   49.141323] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink2
> [   49.141323] iwlwifi 0000:02:00.0: 0x00000800 | umac data1
> [   49.141324] iwlwifi 0000:02:00.0: 0xC0083C90 | umac data2
> [   49.141325] iwlwifi 0000:02:00.0: 0xDEADBEEF | umac data3
> [   49.141326] iwlwifi 0000:02:00.0: 0x00000024 | umac major
> [   49.141327] iwlwifi 0000:02:00.0: 0x9F0A2D68 | umac minor
> [   49.141327] iwlwifi 0000:02:00.0: 0xC088628C | frame pointer
> [   49.141328] iwlwifi 0000:02:00.0: 0xC088628C | stack pointer
> [   49.141329] iwlwifi 0000:02:00.0: 0x00330405 | last host cmd
> [   49.141330] iwlwifi 0000:02:00.0: 0x00000000 | isr status reg
> [   49.141467] iwlwifi 0000:02:00.0: Fseq Registers:
> [   49.141472] iwlwifi 0000:02:00.0: 0x7BAED36C | FSEQ_ERROR_CODE
> [   49.141476] iwlwifi 0000:02:00.0: 0x67438631 | FSEQ_TOP_INIT_VERSION
> [   49.141481] iwlwifi 0000:02:00.0: 0x0A950400 | FSEQ_CNVIO_INIT_VERSION
> [   49.141486] iwlwifi 0000:02:00.0: 0x0000A050 | FSEQ_OTP_VERSION
> [   49.141490] iwlwifi 0000:02:00.0: 0xCEFEB196 | FSEQ_TOP_CONTENT_VERSION
> [   49.141494] iwlwifi 0000:02:00.0: 0xA0FD8C73 | FSEQ_ALIVE_TOKEN
> [   49.141499] iwlwifi 0000:02:00.0: 0xB44772E7 | FSEQ_CNVI_ID
> [   49.141504] iwlwifi 0000:02:00.0: 0xF2BEF376 | FSEQ_CNVR_ID
> [   49.141508] iwlwifi 0000:02:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
> [   49.141516] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
> [   49.141523] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> [   49.141531] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> [   49.141538] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
> [   49.141542] ieee80211 phy0: Hardware restart was requested
> [   49.141547] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
> [   49.141549] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0033 service 0x00000005
> [   49.141550] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000268336
> [   49.141559] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
> [   49.141562] CPU: 7 PID: 168 Comm: kworker/7:1 Tainted: G        W   E     5.3.0-rc5-default+ #296
> [   49.141563] Hardware name: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [   49.141573] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
> [   49.141574] Call Trace:
> [   49.141580]  dump_stack+0x5c/0x7b
> [   49.141588]  iwl_trans_pcie_send_hcmd+0x4cd/0x510 [iwlwifi]
> [   49.141591]  ? wait_woken+0x80/0x80
> [   49.141599]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
> [   49.141607]  iwl_mvm_send_cmd+0x2c/0xa0 [iwlmvm]
> [   49.141612]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
> [   49.141618]  ? iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   49.141623]  ? iwl_mvm_rx_chub_update_mcc+0xe3/0x190 [iwlmvm]
> [   49.141628]  iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   49.141633]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
> [   49.141636]  process_one_work+0x1f4/0x3e0
> [   49.141638]  worker_thread+0x2d/0x3e0
> [   49.141639]  ? process_one_work+0x3e0/0x3e0
> [   49.141641]  kthread+0x117/0x130
> [   49.141642]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   49.141644]  ret_from_fork+0x35/0x40
> [   49.141647] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
> [   49.141654] ------------[ cut here ]------------
> [   49.141678] WARNING: CPU: 7 PID: 168 at drivers/net/wireless/intel/iwlwifi/mvm/scan.c:1874 iwl_mvm_rx_umac_scan_complete_notif+0x220/0x230 [iwlmvm]
> [   49.141679] Modules linked in: fuse(E) rfcomm(E) amdgpu(E) snd_hda_codec_conexant(E) snd_hda_codec_generic(E) ledtrig_audio(E) af_packet(E) gpu_sched(E) mfd_core(E) intel_rapl_msr(E) intel_rapl_common(E) cdc_mbim(E) cdc_ncm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) uvcvideo(E) videobuf2_vmalloc(E) videobuf2_memops(E) qmi_wwan(E) videobuf2_v4l2(E) cdc_ether(E) cdc_wdm(E) videodev(E) usbnet(E) mii(E) bnep(E) videobuf2_common(E) btusb(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) ecdh_generic(E) ecc(E) crc16(E) iwlmvm(E) kvm(E) nls_iso8859_1(E) i915(E) mac80211(E) nls_cp437(E) irqbypass(E) snd_hda_codec_hdmi(E) xfs(E) crc32_pclmul(E) radeon(E) snd_hda_intel(E) snd_hda_codec(E) vfat(E) ghash_clmulni_intel(E) libarc4(E) fat(E) snd_hda_core(E) aesni_intel(E) iTCO_wdt(E) snd_hwdep(E) msr(E) mei_wdt(E) aes_x86_64(E) iTCO_vendor_support(E) mei_hdcp(E) ttm(E) snd_pcm(E) iwlwifi(E) crypto_simd(E) i2c_algo_bit(E) e1000e(E) hp_accel(E) cryptd(E) ptp(E) drm_kms_helper(E) lis3lv02d(E)
> [   49.141705]  snd_timer(E) hp_wmi(E) glue_helper(E) sparse_keymap(E) i2c_i801(E) joydev(E) pps_core(E) pcspkr(E) input_polldev(E) wmi_bmof(E) drm(E) cfg80211(E) battery(E) intel_pmc_core(E) snd(E) tpm_infineon(E) hp_wireless(E) ac(E) syscopyarea(E) acpi_pad(E) rfkill(E) sysfillrect(E) mei_me(E) soundcore(E) sysimgblt(E) thermal(E) fb_sys_fops(E) mei(E) button(E) intel_pch_thermal(E) btrfs(E) libcrc32c(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E) sd_mod(E) crc32c_intel(E) ahci(E) xhci_pci(E) libahci(E) serio_raw(E) xhci_hcd(E) libata(E) usbcore(E) wmi(E) video(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
> [   49.141727] CPU: 7 PID: 168 Comm: kworker/7:1 Tainted: G        W   E     5.3.0-rc5-default+ #296
> [   49.141728] Hardware name: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [   49.141734] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
> [   49.141742] RIP: 0010:iwl_mvm_rx_umac_scan_complete_notif+0x220/0x230 [iwlmvm]
> [   49.141743] Code: 00 00 00 00 00 00 8b 8d 68 1d 00 00 41 8b 84 24 ec 1d 00 00 44 8b 4c 24 04 e9 5e fe ff ff 48 c7 c7 00 79 d1 c1 e8 7e 87 40 c2 <0f> 0b e9 12 ff ff ff e8 94 0b 3a c2 0f 1f 40 00 0f 1f 44 00 00 53
> [   49.141744] RSP: 0000:ffffad7c80ed3e08 EFLAGS: 00010286
> [   49.141745] RAX: 0000000000000024 RBX: ffff98b348cc2040 RCX: 0000000000000006
> [   49.141745] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff98b35f3d97a0
> [   49.141746] RBP: ffffad7c80ed3e50 R08: 000000000000078d R09: 0000000000000004
> [   49.141747] R10: ffffad7c80ed3e48 R11: 0000000000000001 R12: ffff98b3334f9e28
> [   49.141747] R13: dead000000000122 R14: dead000000000100 R15: ffff98b332431d00
> [   49.141748] FS:  0000000000000000(0000) GS:ffff98b35f3c0000(0000) knlGS:0000000000000000
> [   49.141749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   49.141749] CR2: 00007f7f86400003 CR3: 00000008742c4003 CR4: 00000000003606e0
> [   49.141750] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   49.141751] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   49.141751] Call Trace:
> [   49.141756]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
> [   49.141759]  process_one_work+0x1f4/0x3e0
> [   49.141760]  worker_thread+0x2d/0x3e0
> [   49.141761]  ? process_one_work+0x3e0/0x3e0
> [   49.141762]  kthread+0x117/0x130
> [   49.141764]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   49.141765]  ret_from_fork+0x35/0x40
> [   49.141767] ---[ end trace 6725bc5c55335226 ]---
> [   52.432378] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
> [   52.432763] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   52.432765] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
> [   52.432766] iwlwifi 0000:02:00.0: Loaded firmware version: 36.9f0a2d68.0
> [   52.432767] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
> [   52.432768] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
> [   52.432769] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
> [   52.432769] iwlwifi 0000:02:00.0: 0x00024180 | branchlink2
> [   52.432770] iwlwifi 0000:02:00.0: 0x000397EA | interruptlink1
> [   52.432771] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
> [   52.432772] iwlwifi 0000:02:00.0: 0x00330405 | data1
> [   52.432773] iwlwifi 0000:02:00.0: 0x00000034 | data2
> [   52.432773] iwlwifi 0000:02:00.0: 0x00000034 | data3
> [   52.432774] iwlwifi 0000:02:00.0: 0x00198F6B | beacon time
> [   52.432775] iwlwifi 0000:02:00.0: 0x002672C0 | tsf low
> [   52.432776] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
> [   52.432776] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
> [   52.432777] iwlwifi 0000:02:00.0: 0x002672C1 | time gp2
> [   52.432778] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
> [   52.432779] iwlwifi 0000:02:00.0: 0x00000024 | uCode version major
> [   52.432780] iwlwifi 0000:02:00.0: 0x9F0A2D68 | uCode version minor
> [   52.432781] iwlwifi 0000:02:00.0: 0x00000201 | hw version
> [   52.432781] iwlwifi 0000:02:00.0: 0x00489008 | board version
> [   52.432782] iwlwifi 0000:02:00.0: 0x00330405 | hcmd
> [   52.432783] iwlwifi 0000:02:00.0: 0x00022080 | isr0
> [   52.432784] iwlwifi 0000:02:00.0: 0x00000000 | isr1
> [   52.432784] iwlwifi 0000:02:00.0: 0x28201802 | isr2
> [   52.432785] iwlwifi 0000:02:00.0: 0x00400080 | isr3
> [   52.432786] iwlwifi 0000:02:00.0: 0x00000000 | isr4
> [   52.432787] iwlwifi 0000:02:00.0: 0x003201C8 | last cmd Id
> [   52.432787] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
> [   52.432788] iwlwifi 0000:02:00.0: 0x000097FC | l2p_control
> [   52.432789] iwlwifi 0000:02:00.0: 0x00000000 | l2p_duration
> [   52.432790] iwlwifi 0000:02:00.0: 0x00000000 | l2p_mhvalid
> [   52.432791] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
> [   52.432791] iwlwifi 0000:02:00.0: 0x0000008F | lmpm_pmg_sel
> [   52.432792] iwlwifi 0000:02:00.0: 0x04120134 | timestamp
> [   52.432793] iwlwifi 0000:02:00.0: 0x00005868 | flow_handler
> [   52.432969] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
> [   52.432970] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 7
> [   52.432971] iwlwifi 0000:02:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL
> [   52.432972] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink1
> [   52.432973] iwlwifi 0000:02:00.0: 0xC0086AA4 | umac branchlink2
> [   52.432973] iwlwifi 0000:02:00.0: 0xC008D83C | umac interruptlink1
> [   52.432974] iwlwifi 0000:02:00.0: 0xC0083C90 | umac interruptlink2
> [   52.432975] iwlwifi 0000:02:00.0: 0x00000800 | umac data1
> [   52.432976] iwlwifi 0000:02:00.0: 0xC0083C90 | umac data2
> [   52.432976] iwlwifi 0000:02:00.0: 0xDEADBEEF | umac data3
> [   52.432977] iwlwifi 0000:02:00.0: 0x00000024 | umac major
> [   52.432978] iwlwifi 0000:02:00.0: 0x9F0A2D68 | umac minor
> [   52.432979] iwlwifi 0000:02:00.0: 0xC088628C | frame pointer
> [   52.432979] iwlwifi 0000:02:00.0: 0xC088628C | stack pointer
> [   52.432980] iwlwifi 0000:02:00.0: 0x00330405 | last host cmd
> [   52.432981] iwlwifi 0000:02:00.0: 0x00000000 | isr status reg
> [   52.433119] iwlwifi 0000:02:00.0: Fseq Registers:
> [   52.433124] iwlwifi 0000:02:00.0: 0x7BAED36C | FSEQ_ERROR_CODE
> [   52.433128] iwlwifi 0000:02:00.0: 0x67438631 | FSEQ_TOP_INIT_VERSION
> [   52.433133] iwlwifi 0000:02:00.0: 0x0A950400 | FSEQ_CNVIO_INIT_VERSION
> [   52.433137] iwlwifi 0000:02:00.0: 0x0000A050 | FSEQ_OTP_VERSION
> [   52.433142] iwlwifi 0000:02:00.0: 0xCEFEB196 | FSEQ_TOP_CONTENT_VERSION
> [   52.433146] iwlwifi 0000:02:00.0: 0xA0FD8C73 | FSEQ_ALIVE_TOKEN
> [   52.433150] iwlwifi 0000:02:00.0: 0xB44772E7 | FSEQ_CNVI_ID
> [   52.433155] iwlwifi 0000:02:00.0: 0xF2BEF376 | FSEQ_CNVR_ID
> [   52.433159] iwlwifi 0000:02:00.0: 0x03000000 | CNVI_AUX_MISC_CHIP
> [   52.433167] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_AUX_MISC_CHIP
> [   52.433174] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> [   52.433182] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> [   52.433188] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
> [   52.433190] ieee80211 phy0: Hardware restart was requested
> [   52.433193] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
> [   52.433194] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0033 service 0x00000005
> [   52.433195] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x00000000002672BD
> [   52.433225] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
> [   52.433227] CPU: 7 PID: 526 Comm: kworker/7:2 Tainted: G        W   E     5.3.0-rc5-default+ #296
> [   52.433228] Hardware name: HP HP ZBook 15 G3/80D5, BIOS N81 Ver. 01.09 06/28/2016
> [   52.433238] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
> [   52.433239] Call Trace:
> [   52.433245]  dump_stack+0x5c/0x7b
> [   52.433270]  iwl_trans_pcie_send_hcmd+0x4cd/0x510 [iwlwifi]
> [   52.433273]  ? wait_woken+0x80/0x80
> [   52.433280]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
> [   52.433287]  iwl_mvm_send_cmd+0x2c/0xa0 [iwlmvm]
> [   52.433293]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
> [   52.433299]  ? iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   52.433303]  ? iwl_mvm_rx_chub_update_mcc+0xe3/0x190 [iwlmvm]
> [   52.433308]  iwl_mvm_rx_chub_update_mcc+0xfd/0x190 [iwlmvm]
> [   52.433312]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
> [   52.433315]  process_one_work+0x1f4/0x3e0
> [   52.433316]  worker_thread+0x2d/0x3e0
> [   52.433318]  ? process_one_work+0x3e0/0x3e0
> [   52.433319]  kthread+0x117/0x130
> [   52.433320]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   52.433322]  ret_from_fork+0x35/0x40
> [   52.433325] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
> [   
> -------------------------------------
> linuxwifi@eclists.intel.com
> https://eclists.intel.com/sympa/info/linuxwifi
> Unsubscribe by sending email to sympa@eclists.intel.com with subject "Unsubscribe linuxwifi"

