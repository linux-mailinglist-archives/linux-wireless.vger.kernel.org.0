Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED8B298166
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Oct 2020 11:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415321AbgJYK7a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Oct 2020 06:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415239AbgJYK72 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Oct 2020 06:59:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02A8C0613CE
        for <linux-wireless@vger.kernel.org>; Sun, 25 Oct 2020 03:59:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c194so8613393wme.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Oct 2020 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=bQIwYOYHIUsEJv6l55Okr7fTjzjKzK8oKP+vpRq/mjs=;
        b=Gotu2vno3f1ijwdknMAmjPoawS3ZaMtd94VTIqkDYlu4APkejTu3pScU0gxffZzKR/
         NndrZQCcVjdpZKj4Aw+ayooWa29Ga5oebPtRZY1OMljEIvdoBMtNw8tYbTaeKPNS8qRr
         JRCfyOIVUxMI9DipzYwUfcrDgnCo7U9shFq5a9DT+IOG1tX9VwDSNrY5Dt++MuO3nnUK
         IBAMFWPSkY/sAyZ5lXlHkHqUIDdbtYUxxUOSVUoIsdeNCdGOn+wiyPi3w0nF4+ZPhAHG
         eHErRaZksA1+6RjSefKPGKH6Y7392uJhTADGd6uWozqQiagB99aPzSdThk6QGgLHmeD4
         9s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=bQIwYOYHIUsEJv6l55Okr7fTjzjKzK8oKP+vpRq/mjs=;
        b=L4xyG6mPUriPSdC4Ye/lP58YfB+LmEODMsvU889ovXoRGAqbntUcrVyf5auFt1mJvw
         HPUwvIxhVX0oz+mzvyazea2IkNoFf3C/14CwQYkbliUbUyRWhXcjt9OggHOwKv/MecAW
         S4OJs6FItOz09Oldctbg8TDSAOWU+Uz4IUOwlUb+GxL347R8vI2djLCO9HfhtbdprN9S
         SGv+hoN0yXj4YlnRLy5BLxiis9I6COyL7TS1L+7oVOwmLdtefczlnWFpA9J5mPqXQiQk
         D+TWVsJuwC8xsIkQzj7As3DYdf5v9g0nAVFokJh65i8I0MpWv3MJIIjGoUdVL7F72865
         R9CQ==
X-Gm-Message-State: AOAM530IDqlmmV5aJCvNeV1TysBGyj933JkIPdNmqPXwkHkk1fcTX4jh
        ZY56XBVBG7fg4G3Zc5TXUvxip1Ov//MjwQSl
X-Google-Smtp-Source: ABdhPJwlY27LGgPz8MJfIP+f8RFvoerk+2BbV4fMla3GvdCsEcTdh0n65RfMv+lTcks40iB1QfhVhQ==
X-Received: by 2002:a1c:2ed3:: with SMTP id u202mr11245127wmu.85.1603623547771;
        Sun, 25 Oct 2020 03:59:07 -0700 (PDT)
Received: from eeec (host-95-244-250-221.retail.telecomitalia.it. [95.244.250.221])
        by smtp.gmail.com with ESMTPSA id t6sm19249507wre.30.2020.10.25.03.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 03:59:06 -0700 (PDT)
Date:   Sun, 25 Oct 2020 11:58:54 +0100 (CET)
From:   Enrico Mioso <mrkiko.rs@gmail.com>
X-X-Sender: mrkiko@localhost.localdomain
To:     linux-wireless@vger.kernel.org
cc:     Avraham Stern <avraham.stern@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497
 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Message-ID: <alpine.LNX.2.23.451.2010251154240.3923@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!!
Sorry for the broad CC. I am reporting an issue with Intel Wi-Fi MVM driver; the card comes with a Dell Precision M6800, see dmesg.

Any help would be apreciated.

Enrico

microcode: microcode updated early to revision 0x28, date = 2019-11-12
Linux version 5.4.72kb+ (mrkiko@mStation) (gcc version 10.2.0 (GCC)) #1 SMP Fri Oct 23 20:59:55 CEST 2020
Command line: initrd=\intel-ucode.img root=/dev/sdb1 rw nospectre_v2 pti=off net.ifnames=0 l1tf=off kvm-intel.vmentry_l1d_flush=never nospec_store_bypass_disable mds=off mitigations=off srbds=off
KERNEL supported cpus:
   Intel GenuineIntel
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000004efff] usable
BIOS-e820: [mem 0x000000000004f000-0x000000000004ffff] reserved
BIOS-e820: [mem 0x0000000000050000-0x000000000009efff] usable
BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000bff6efff] usable
BIOS-e820: [mem 0x00000000bff6f000-0x00000000bff75fff] ACPI NVS
BIOS-e820: [mem 0x00000000bff76000-0x00000000c093ffff] usable
BIOS-e820: [mem 0x00000000c0940000-0x00000000c0e17fff] reserved
BIOS-e820: [mem 0x00000000c0e18000-0x00000000c7db1fff] usable
BIOS-e820: [mem 0x00000000c7db2000-0x00000000c7ffffff] reserved
BIOS-e820: [mem 0x00000000c8000000-0x00000000c8757fff] usable
BIOS-e820: [mem 0x00000000c8758000-0x00000000c87fffff] reserved
BIOS-e820: [mem 0x00000000c8800000-0x00000000c8f92fff] usable
BIOS-e820: [mem 0x00000000c8f93000-0x00000000c8ffffff] ACPI data
BIOS-e820: [mem 0x00000000c9000000-0x00000000ca6d3fff] usable
BIOS-e820: [mem 0x00000000ca6d4000-0x00000000ca7fffff] ACPI NVS
BIOS-e820: [mem 0x00000000ca800000-0x00000000cbcddfff] usable
BIOS-e820: [mem 0x00000000cbcde000-0x00000000cbffffff] reserved
BIOS-e820: [mem 0x00000000cd000000-0x00000000cf1fffff] reserved
BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000042edfffff] usable
NX (Execute Disable) protection: active
e820: update [mem 0xc58e8018-0xc5904657] usable ==> usable
e820: update [mem 0xc58e8018-0xc5904657] usable ==> usable
e820: update [mem 0xc58d7018-0xc58e7057] usable ==> usable
e820: update [mem 0xc58d7018-0xc58e7057] usable ==> usable
e820: update [mem 0xc58c7018-0xc58d6c57] usable ==> usable
e820: update [mem 0xc58c7018-0xc58d6c57] usable ==> usable
e820: update [mem 0xc58a9018-0xc58c6c57] usable ==> usable
e820: update [mem 0xc58a9018-0xc58c6c57] usable ==> usable
extended physical RAM map:
reserve setup_data: [mem 0x0000000000000000-0x000000000004efff] usable
reserve setup_data: [mem 0x000000000004f000-0x000000000004ffff] reserved
reserve setup_data: [mem 0x0000000000050000-0x000000000009efff] usable
reserve setup_data: [mem 0x000000000009f000-0x000000000009ffff] reserved
reserve setup_data: [mem 0x0000000000100000-0x00000000bff6efff] usable
reserve setup_data: [mem 0x00000000bff6f000-0x00000000bff75fff] ACPI NVS
reserve setup_data: [mem 0x00000000bff76000-0x00000000c093ffff] usable
reserve setup_data: [mem 0x00000000c0940000-0x00000000c0e17fff] reserved
reserve setup_data: [mem 0x00000000c0e18000-0x00000000c58a9017] usable
reserve setup_data: [mem 0x00000000c58a9018-0x00000000c58c6c57] usable
reserve setup_data: [mem 0x00000000c58c6c58-0x00000000c58c7017] usable
reserve setup_data: [mem 0x00000000c58c7018-0x00000000c58d6c57] usable
reserve setup_data: [mem 0x00000000c58d6c58-0x00000000c58d7017] usable
reserve setup_data: [mem 0x00000000c58d7018-0x00000000c58e7057] usable
reserve setup_data: [mem 0x00000000c58e7058-0x00000000c58e8017] usable
reserve setup_data: [mem 0x00000000c58e8018-0x00000000c5904657] usable
reserve setup_data: [mem 0x00000000c5904658-0x00000000c7db1fff] usable
reserve setup_data: [mem 0x00000000c7db2000-0x00000000c7ffffff] reserved
reserve setup_data: [mem 0x00000000c8000000-0x00000000c8757fff] usable
reserve setup_data: [mem 0x00000000c8758000-0x00000000c87fffff] reserved
reserve setup_data: [mem 0x00000000c8800000-0x00000000c8f92fff] usable
reserve setup_data: [mem 0x00000000c8f93000-0x00000000c8ffffff] ACPI data
reserve setup_data: [mem 0x00000000c9000000-0x00000000ca6d3fff] usable
reserve setup_data: [mem 0x00000000ca6d4000-0x00000000ca7fffff] ACPI NVS
reserve setup_data: [mem 0x00000000ca800000-0x00000000cbcddfff] usable
reserve setup_data: [mem 0x00000000cbcde000-0x00000000cbffffff] reserved
reserve setup_data: [mem 0x00000000cd000000-0x00000000cf1fffff] reserved
reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
reserve setup_data: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
reserve setup_data: [mem 0x0000000100000000-0x000000042edfffff] usable
efi: EFI v2.31 by American Megatrends
efi:  ACPI 2.0=0xc8fd3000  ACPI=0xc8fd3000  SMBIOS=0xf04c0  MPS=0xfd710 
SMBIOS 2.7 present.
DMI: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
tsc: Fast TSC calibration using PIT
tsc: Detected 2494.223 MHz processor
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x42ee00 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
   00000-9FFFF write-back
   A0000-BFFFF uncachable
   C0000-DBFFF write-protect
   DC000-DFFFF uncachable
   E0000-FFFFF write-protect
MTRR variable ranges enabled:
   0 base 0000000000 mask 7C00000000 write-back
   1 base 0400000000 mask 7FE0000000 write-back
   2 base 0420000000 mask 7FF0000000 write-back
   3 base 00E0000000 mask 7FE0000000 uncachable
   4 base 00D0000000 mask 7FF0000000 uncachable
   5 base 00CE000000 mask 7FFE000000 uncachable
   6 base 00CD000000 mask 7FFF000000 uncachable
   7 base 042F000000 mask 7FFF000000 uncachable
   8 base 042EE00000 mask 7FFFE00000 uncachable
   9 disabled
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT 
e820: update [mem 0xcd000000-0xffffffff] usable ==> reserved
last_pfn = 0xcbcde max_arch_pfn = 0x400000000
found SMP MP-table at [mem 0x000fda90-0x000fda9f]
Using GB pages for direct mapping
Secure boot disabled
RAMDISK: [mem 0x7fcfb000-0x7fffefff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000C8FD3000 000024 (v02 DELL  )
ACPI: XSDT 0x00000000C8FD3098 0000AC (v01 DELL   CBX3     01072009 AMI  00010013)
ACPI: FACP 0x00000000C8FE5038 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
ACPI: DSDT 0x00000000C8FD31D0 011E62 (v02 DELL   CBX3     00000014 INTL 20120711)
ACPI: FACS 0x00000000CA7FE080 000040
ACPI: APIC 0x00000000C8FE5148 000092 (v03 DELL   CBX3     01072009 AMI  00010013)
ACPI: FPDT 0x00000000C8FE51E0 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
ACPI: SLIC 0x00000000C8FE5228 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
ACPI: LPIT 0x00000000C8FE53A0 00005C (v01 DELL   CBX3     00000000 AMI. 00000005)
ACPI: SSDT 0x00000000C8FE5400 000228 (v01 INTEL  sensrhub 00000000 INTL 20120711)
ACPI: SSDT 0x00000000C8FE5628 000160 (v01 Intel  zpodd    00001000 INTL 20120711)
ACPI: SSDT 0x00000000C8FE5788 00051F (v01 PmRef  Cpu0Ist  00003000 INTL 20120711)
ACPI: SSDT 0x00000000C8FE5CA8 000AD8 (v01 PmRef  CpuPm    00003000 INTL 20120711)
ACPI: HPET 0x00000000C8FE6780 000038 (v01 DELL   CBX3     01072009 AMI. 00000005)
ACPI: SSDT 0x00000000C8FE67B8 000447 (v01 SataRe SataTabl 00001000 INTL 20120711)
ACPI: MCFG 0x00000000C8FE6C00 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
ACPI: ASF! 0x00000000C8FE6C40 0000A5 (v32 INTEL   HCG     00000001 TFSM 000F4240)
ACPI: MSDM 0x00000000C8FE6CE8 000055 (v03 DELL   CBX3     06222004 AMI  00010013)
ACPI: BGRT 0x00000000C8FE6D40 000038 (v00 \xf3\xee              01072009 AMI  00010013)
ACPI: SSDT 0x00000000C8FE6D78 0010BD (v01 SgRef  SgPeg    00001000 INTL 20120711)
ACPI: SSDT 0x00000000C8FE7E38 0010BA (v01 AmdRef AmdTabl  00001000 INTL 20120711)
ACPI: Local APIC address 0xfee00000
Zone ranges:
   DMA32    [mem 0x0000000000001000-0x00000000ffffffff]
   Normal   [mem 0x0000000100000000-0x000000042edfffff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x0000000000001000-0x000000000004efff]
   node   0: [mem 0x0000000000050000-0x000000000009efff]
   node   0: [mem 0x0000000000100000-0x00000000bff6efff]
   node   0: [mem 0x00000000bff76000-0x00000000c093ffff]
   node   0: [mem 0x00000000c0e18000-0x00000000c7db1fff]
   node   0: [mem 0x00000000c8000000-0x00000000c8757fff]
   node   0: [mem 0x00000000c8800000-0x00000000c8f92fff]
   node   0: [mem 0x00000000c9000000-0x00000000ca6d3fff]
   node   0: [mem 0x00000000ca800000-0x00000000cbcddfff]
   node   0: [mem 0x0000000100000000-0x000000042edfffff]
Zeroed struct page in unavailable ranges: 24307 pages
Initmem setup node 0 [mem 0x0000000000001000-0x000000042edfffff]
On node 0 totalpages: 4169997
   DMA32 zone: 13005 pages used for memmap
   DMA32 zone: 53 pages reserved
   DMA32 zone: 832269 pages, LIFO batch:63
   Normal zone: 52152 pages used for memmap
   Normal zone: 3337728 pages, LIFO batch:63
Reserving Intel graphics memory at [mem 0xcd200000-0xcf1fffff]
ACPI: PM-Timer IO Port: 0x1808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a701 base: 0xfed00000
TSC deadline timer available
smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[mem 0xcf200000-0xf7ffffff] available for PCI devices
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
percpu: Embedded 51 pages/cpu s168920 r8192 d31784 u262144
pcpu-alloc: s168920 r8192 d31784 u262144 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
Built 1 zonelists, mobility grouping on.  Total pages: 4104787
Kernel command line: initrd=\intel-ucode.img root=/dev/sdb1 rw nospectre_v2 pti=off net.ifnames=0 l1tf=off kvm-intel.vmentry_l1d_flush=never nospec_store_bypass_disable mds=off mitigations=off srbds=off
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
Memory: 16186080K/16679988K available (8195K kernel code, 869K rwdata, 2124K rodata, 1188K init, 1420K bss, 493908K reserved, 0K cma-reserved)
random: get_random_u64 called from cache_random_seq_create+0x65/0x120 with crng_init=0
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
ftrace: allocating 24730 entries in 97 pages
rcu: Hierarchical RCU implementation.
rcu: 	RCU event tracing is enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
random: crng done (trusting CPU's manufacturer)
Console: colour dummy device 80x25
printk: console [tty0] enabled
ACPI: Core revision 20190816
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
APIC: Switch to symmetric I/O mode setup
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x23f3e8602d1, max_idle_ns: 440795241926 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. 4988.44 BogoMIPS (lpj=2494223)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
mce: CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
Speculative Store Bypass: Vulnerable
SRBDS: Vulnerable
Freeing SMP alternatives memory: 24K
smpboot: CPU0: Intel(R) Core(TM) i7-4710MQ CPU @ 2.50GHz (family: 0x6, model: 0x3c, stepping: 0x3)
Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
... version:                3
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
smp: Brought up 1 node, 8 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 8 processors activated (39907.56 BogoMIPS)
devtmpfs: initialized
PM: Registering ACPI NVS region [mem 0xbff6f000-0xbff75fff] (28672 bytes)
PM: Registering ACPI NVS region [mem 0xca6d4000-0xca7fffff] (1228800 bytes)
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
NET: Registered protocol family 16
cpuidle: using governor menu
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
ACPI: bus type PCI registered
PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
pmd_set_huge: Cannot satisfy [mem 0xf8000000-0xf8200000] with a huge-page mapping due to MTRR override.
PCI: Using configuration type 1 for base access
core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
ACPI: 8 ACPI AML tables successfully acquired and loaded
ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFFA1859C565800 0003D3 (v01 PmRef  Cpu0Cst  00003001 INTL 20120711)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFFA1859C553800 0005AA (v01 PmRef  ApIst    00003000 INTL 20120711)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFFA1859C6C7C00 000119 (v01 PmRef  ApCst    00003000 INTL 20120711)
ACPI: EC: EC started
ACPI: EC: interrupt blocked
ACPI: \_SB_.PCI0.LPCB.ECDV: Used as first EC
ACPI: \_SB_.PCI0.LPCB.ECDV: GPE=0x10, EC_CMD/EC_SC=0x934, EC_DATA=0x930
ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC used to handle transactions
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: Enabled 6 GPEs in block 00 to 3F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A08:00: _OSC: platform does not support [PME]
acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
pci_bus 0000:00: root bus resource [mem 0xcf200000-0xfeafffff window]
pci_bus 0000:00: root bus resource [bus 00-3e]
pci 0000:00:00.0: [8086:0c04] type 00 class 0x060000
pci 0000:00:01.0: [8086:0c01] type 01 class 0x060400
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:02.0: [8086:0416] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xf5800000-0xf5bfffff 64bit]
pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bit pref]
pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
pci 0000:00:02.0: BAR 2: assigned to efifb
pci 0000:00:03.0: [8086:0c0c] type 00 class 0x040300
pci 0000:00:03.0: reg 0x10: [mem 0xf7d34000-0xf7d37fff 64bit]
pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
pci 0000:00:14.0: reg 0x10: [mem 0xf7d20000-0xf7d2ffff 64bit]
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
pci 0000:00:16.0: reg 0x10: [mem 0xf7d40000-0xf7d4000f 64bit]
pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
pci 0000:00:19.0: [8086:153a] type 00 class 0x020000
pci 0000:00:19.0: reg 0x10: [mem 0xf7d00000-0xf7d1ffff]
pci 0000:00:19.0: reg 0x14: [mem 0xf7d3d000-0xf7d3dfff]
pci 0000:00:19.0: reg 0x18: [io  0xf080-0xf09f]
pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
pci 0000:00:1a.0: reg 0x10: [mem 0xf7d3c000-0xf7d3c3ff]
pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: [8086:8c20] type 00 class 0x040300
pci 0000:00:1b.0: reg 0x10: [mem 0xf7d30000-0xf7d33fff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: [8086:8c14] type 01 class 0x060400
pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.3: [8086:8c16] type 01 class 0x060400
pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.4: [8086:8c18] type 01 class 0x060400
pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.6: [8086:8c1c] type 01 class 0x060400
pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.7: [8086:8c1e] type 01 class 0x060400
pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
pci 0000:00:1d.0: reg 0x10: [mem 0xf7d3b000-0xf7d3b3ff]
pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1f.0: [8086:8c4f] type 00 class 0x060100
pci 0000:00:1f.2: [8086:282a] type 00 class 0x010400
pci 0000:00:1f.2: reg 0x10: [io  0xf0d0-0xf0d7]
pci 0000:00:1f.2: reg 0x14: [io  0xf0c0-0xf0c3]
pci 0000:00:1f.2: reg 0x18: [io  0xf0b0-0xf0b7]
pci 0000:00:1f.2: reg 0x1c: [io  0xf0a0-0xf0a3]
pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
pci 0000:00:1f.2: reg 0x24: [mem 0xf7d3a000-0xf7d3a7ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
pci 0000:00:1f.3: reg 0x10: [mem 0xf7d39000-0xf7d390ff 64bit]
pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
pci 0000:01:00.0: [1002:6640] type 00 class 0x030000
pci 0000:01:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
pci 0000:01:00.0: reg 0x18: [mem 0xf0000000-0xf07fffff 64bit pref]
pci 0000:01:00.0: reg 0x20: [io  0xe000-0xe0ff]
pci 0000:01:00.0: reg 0x24: [mem 0xf7c00000-0xf7c3ffff]
pci 0000:01:00.0: reg 0x30: [mem 0xf7c40000-0xf7c5ffff pref]
pci 0000:01:00.0: supports D1 D2
pci 0000:01:00.0: PME# supported from D1 D2 D3hot
pci 0000:01:00.1: [1002:aac0] type 00 class 0x040300
pci 0000:01:00.1: reg 0x10: [mem 0xf7c60000-0xf7c63fff 64bit]
pci 0000:01:00.1: supports D1 D2
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:01.0:   bridge window [mem 0xf7c00000-0xf7cfffff]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xf07fffff 64bit pref]
pci 0000:00:1c.0: PCI bridge to [bus 02]
pci 0000:03:00.0: [8086:08b1] type 00 class 0x028000
pci 0000:03:00.0: reg 0x10: [mem 0xf7b00000-0xf7b01fff 64bit]
pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: PCI bridge to [bus 03]
pci 0000:00:1c.2:   bridge window [mem 0xf7b00000-0xf7bfffff]
pci 0000:00:1c.3: PCI bridge to [bus 04-07]
pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.3:   bridge window [mem 0xf7000000-0xf79fffff]
pci 0000:00:1c.3:   bridge window [mem 0xf1d00000-0xf26fffff 64bit pref]
pci 0000:00:1c.4: PCI bridge to [bus 08]
pci 0000:00:1c.4:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.4:   bridge window [mem 0xf6600000-0xf6ffffff]
pci 0000:00:1c.4:   bridge window [mem 0xf1300000-0xf1cfffff 64bit pref]
pci 0000:00:1c.6: PCI bridge to [bus 09-10]
pci 0000:00:1c.6:   bridge window [io  0xa000-0xbfff]
pci 0000:00:1c.6:   bridge window [mem 0xf5c00000-0xf65fffff]
pci 0000:00:1c.6:   bridge window [mem 0xf0900000-0xf12fffff 64bit pref]
pci 0000:11:00.0: [1217:8520] type 00 class 0x080501
pci 0000:11:00.0: reg 0x10: [mem 0xf7a01000-0xf7a01fff]
pci 0000:11:00.0: reg 0x14: [mem 0xf7a00000-0xf7a007ff]
pci 0000:11:00.0: PME# supported from D3hot D3cold
pci 0000:00:1c.7: PCI bridge to [bus 11]
pci 0000:00:1c.7:   bridge window [mem 0xf7a00000-0xf7afffff]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
ACPI: EC: interrupt unblocked
ACPI: EC: event unblocked
ACPI: \_SB_.PCI0.LPCB.ECDV: GPE=0x10, EC_CMD/EC_SC=0x934, EC_DATA=0x930
ACPI: \_SB_.PCI0.LPCB.ECDV: Boot DSDT EC used to handle transactions and events
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
pci 0000:00:02.0: vgaarb: no bridge control possible
pci 0000:01:00.0: vgaarb: bridge control possible
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
Registered efivars operations
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0004f000-0x0004ffff]
e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
e820: reserve RAM buffer [mem 0xbff6f000-0xbfffffff]
e820: reserve RAM buffer [mem 0xc0940000-0xc3ffffff]
e820: reserve RAM buffer [mem 0xc58a9018-0xc7ffffff]
e820: reserve RAM buffer [mem 0xc58c7018-0xc7ffffff]
e820: reserve RAM buffer [mem 0xc58d7018-0xc7ffffff]
e820: reserve RAM buffer [mem 0xc58e8018-0xc7ffffff]
e820: reserve RAM buffer [mem 0xc7db2000-0xc7ffffff]
e820: reserve RAM buffer [mem 0xc8758000-0xcbffffff]
e820: reserve RAM buffer [mem 0xc8f93000-0xcbffffff]
e820: reserve RAM buffer [mem 0xca6d4000-0xcbffffff]
e820: reserve RAM buffer [mem 0xcbcde000-0xcbffffff]
e820: reserve RAM buffer [mem 0x42ee00000-0x42fffffff]
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 14.318180 MHz counter
clocksource: Switched to clocksource tsc-early
pnp: PnP ACPI init
system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
system 00:01: [io  0x0680-0x069f] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0x1c00-0x1cfe] has been reserved
system 00:01: [io  0x1d00-0x1dfe] has been reserved
system 00:01: [io  0x1e00-0x1efe] has been reserved
system 00:01: [io  0x1f00-0x1ffe] has been reserved
system 00:01: [io  0x1800-0x18fe] has been reserved
system 00:01: [io  0x164e-0x164f] has been reserved
system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
system 00:03: [io  0x1854-0x1857] has been reserved
system 00:03: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
system 00:04: [io  0x04d0-0x04d1] has been reserved
system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:05: Plug and Play ACPI device, IDs PNP0303 (active)
pnp 00:06: Plug and Play ACPI device, IDs DLL05cd PNP0f13 (active)
pnp 00:07: Plug and Play ACPI device, IDs PNP0401 (disabled)
system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
system 00:08: [mem 0xfed10000-0xfed17fff] has been reserved
system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:08: [mem 0xf8000000-0xfbffffff] has been reserved
system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:08: [mem 0xfed90000-0xfed93fff] has been reserved
system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
system 00:08: [mem 0xff000000-0xffffffff] has been reserved
system 00:08: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:08: [mem 0xf7fdf000-0xf7fdffff] has been reserved
system 00:08: [mem 0xf7fe0000-0xf7feffff] has been reserved
system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp: PnP ACPI: found 9 devices
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:01.0:   bridge window [mem 0xf7c00000-0xf7cfffff]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xf07fffff 64bit pref]
pci 0000:00:1c.0: PCI bridge to [bus 02]
pci 0000:00:1c.2: PCI bridge to [bus 03]
pci 0000:00:1c.2:   bridge window [mem 0xf7b00000-0xf7bfffff]
pci 0000:00:1c.3: PCI bridge to [bus 04-07]
pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.3:   bridge window [mem 0xf7000000-0xf79fffff]
pci 0000:00:1c.3:   bridge window [mem 0xf1d00000-0xf26fffff 64bit pref]
pci 0000:00:1c.4: PCI bridge to [bus 08]
pci 0000:00:1c.4:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.4:   bridge window [mem 0xf6600000-0xf6ffffff]
pci 0000:00:1c.4:   bridge window [mem 0xf1300000-0xf1cfffff 64bit pref]
pci 0000:00:1c.6: PCI bridge to [bus 09-10]
pci 0000:00:1c.6:   bridge window [io  0xa000-0xbfff]
pci 0000:00:1c.6:   bridge window [mem 0xf5c00000-0xf65fffff]
pci 0000:00:1c.6:   bridge window [mem 0xf0900000-0xf12fffff 64bit pref]
pci 0000:00:1c.7: PCI bridge to [bus 11]
pci 0000:00:1c.7:   bridge window [mem 0xf7a00000-0xf7afffff]
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0x000dc000-0x000dffff window]
pci_bus 0000:00: resource 8 [mem 0xcf200000-0xfeafffff window]
pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
pci_bus 0000:01: resource 1 [mem 0xf7c00000-0xf7cfffff]
pci_bus 0000:01: resource 2 [mem 0xe0000000-0xf07fffff 64bit pref]
pci_bus 0000:03: resource 1 [mem 0xf7b00000-0xf7bfffff]
pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:04: resource 1 [mem 0xf7000000-0xf79fffff]
pci_bus 0000:04: resource 2 [mem 0xf1d00000-0xf26fffff 64bit pref]
pci_bus 0000:08: resource 0 [io  0xc000-0xcfff]
pci_bus 0000:08: resource 1 [mem 0xf6600000-0xf6ffffff]
pci_bus 0000:08: resource 2 [mem 0xf1300000-0xf1cfffff 64bit pref]
pci_bus 0000:09: resource 0 [io  0xa000-0xbfff]
pci_bus 0000:09: resource 1 [mem 0xf5c00000-0xf65fffff]
pci_bus 0000:09: resource 2 [mem 0xf0900000-0xf12fffff 64bit pref]
pci_bus 0000:11: resource 1 [mem 0xf7a00000-0xf7afffff]
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
TCP: Hash tables configured (established 131072 bind 65536)
UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
NET: Registered protocol family 1
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
PCI: CLS 64 bytes, default 64
Unpacking initramfs...
Freeing initrd memory: 3088K
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0xb8e3a000-0xbce3a000] (64MB)
Initialise system trusted keyrings
workingset: timestamp_bits=62 max_order=22 bucket_order=0
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
efifb: probing for efifb
efifb: framebuffer at 0xd0000000, using 8100k, total 8100k
efifb: mode is 1920x1080x32, linelength=7680, pages=1
efifb: scrolling: redraw
efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 240x67
fb0: EFI VGA frame buffer device
intel_idle: MWAIT substates: 0x42120
intel_idle: v0.4.1 model 0x3C
intel_idle: lapic_timer_reliable_states 0xffffffff
ACPI: AC Adapter [AC] (on-line)
input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
ACPI: Lid Switch [LID0]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
ACPI: Power Button [PBTN]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
ACPI: Sleep Button [SBTN]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
ACPI: Power Button [PWRF]
thermal LNXTHERM:00: registered as thermal_zone0
ACPI: Thermal Zone [THM] (25 C)
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x2f impl RAID mode
ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pio slum part ems sxs apst 
scsi host0: ahci
scsi host1: ahci
scsi host2: ahci
scsi host3: ahci
scsi host4: ahci
scsi host5: ahci
ata1: SATA max UDMA/133 abar m2048@0xf7d3a000 port 0xf7d3a100 irq 31
ata2: SATA max UDMA/133 abar m2048@0xf7d3a000 port 0xf7d3a180 irq 31
ata3: SATA max UDMA/133 abar m2048@0xf7d3a000 port 0xf7d3a200 irq 31
ata4: SATA max UDMA/133 abar m2048@0xf7d3a000 port 0xf7d3a280 irq 31
ata5: DUMMY
ata6: SATA max UDMA/133 abar m2048@0xf7d3a000 port 0xf7d3a380 irq 31
e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
battery: ACPI: Battery Slot [BAT0] (battery present)
battery: ACPI: Battery Slot [BAT1] (battery absent)
e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 20:47:47:eb:a4:44
e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: FFFFFF-0FF
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:00:1a.0: EHCI Host Controller
ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:1a.0: debug port 2
ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7d3c000
ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.04
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 5.4.72kb+ ehci_hcd
usb usb1: SerialNumber: 0000:00:1a.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ehci-pci 0000:00:1d.0: EHCI Host Controller
ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
ehci-pci 0000:00:1d.0: debug port 2
ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
ehci-pci 0000:00:1d.0: irq 21, io mem 0xf7d3b000
ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.04
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: EHCI Host Controller
usb usb2: Manufacturer: Linux 5.4.72kb+ ehci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.04
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: xHCI Host Controller
usb usb3: Manufacturer: Linux 5.4.72kb+ xhci-hcd
usb usb3: SerialNumber: 0000:00:14.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 15 ports detected
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.04
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: xHCI Host Controller
usb usb4: Manufacturer: Linux 5.4.72kb+ xhci-hcd
usb usb4: SerialNumber: 0000:00:14.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
rtc_cmos 00:02: RTC can wake from S4
rtc_cmos 00:02: registered as rtc0
rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
intel_pstate: Intel P-state driver initializing
Key type dns_resolver registered
microcode: sig=0x306c3, pf=0x10, revision=0x28
microcode: Microcode Update Driver: v2.2.
IPI shorthand broadcast: enabled
sched_clock: Marking stable (471394813, 329979)->(474689413, -2964621)
registered taskstats version 1
Loading compiled-in X.509 certificates
Key type ._fscrypt registered
Key type .fscrypt registered
rtc_cmos 00:02: setting system clock to 2020-10-24T07:44:46 UTC (1603525486)
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata1.00: ATA-10: ST1000LM048-2E7172, SDM1, max UDMA/133
ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST1000LM048-2E71 SDM1 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
sd 0:0:0:0: [sda] 4096-byte physical blocks
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
usb 1-1: new high-speed USB device number 2 using ehci-pci
usb 2-1: new high-speed USB device number 2 using ehci-pci
usb 3-3: new low-speed USB device number 2 using xhci_hcd
usb 1-1: New USB device found, idVendor=8087, idProduct=8008, bcdDevice= 0.04
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 6 ports detected
usb 2-1: New USB device found, idVendor=8087, idProduct=8000, bcdDevice= 0.04
usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 8 ports detected
usb 3-3: New USB device found, idVendor=046d, idProduct=c517, bcdDevice=38.10
usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-3: Product: USB Receiver
usb 3-3: Manufacturer: Logitech
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI: TSSTcorp DVD+/-RW SU-208GB, D100, max UDMA/100
ata2.00: configured for UDMA/100
scsi 1:0:0:0: CD-ROM            TSSTcorp DVD+-RW SU-208GB D100 PQ: 0 ANSI: 5
usb 3-10: new high-speed USB device number 3 using xhci_hcd
usb 1-1.5: new high-speed USB device number 3 using ehci-pci
usb 3-10: config 1 has an invalid interface number: 8 but max is 5
usb 3-10: config 1 has an invalid interface number: 10 but max is 5
usb 3-10: config 1 has an invalid interface number: 11 but max is 5
usb 3-10: config 1 has no interface number 1
usb 3-10: config 1 has no interface number 4
usb 3-10: config 1 has no interface number 5
usb 3-10: New USB device found, idVendor=1199, idProduct=68c0, bcdDevice= 0.06
usb 3-10: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-10: Product: MC7304
usb 3-10: Manufacturer: Sierra Wireless, Incorporated
usb 2-1.5: new full-speed USB device number 3 using ehci-pci
usb 2-1.5: New USB device found, idVendor=8087, idProduct=07dc, bcdDevice= 0.01
usb 2-1.5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
tsc: Refined TSC clocksource calibration: 2494.223 MHz
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23f3e8602d1, max_idle_ns: 440795241926 ns
clocksource: Switched to clocksource tsc
usb 1-1.5: New USB device found, idVendor=0c45, idProduct=64d0, bcdDevice=42.14
usb 1-1.5: New USB device strings: Mfr=2, Product=1, SerialNumber=0
usb 1-1.5: Product: Laptop_Integrated_Webcam_HD
usb 1-1.5: Manufacturer: CN0767N972487594B1ZKA01
usb 2-1.8: new full-speed USB device number 4 using ehci-pci
ata3: SATA link down (SStatus 0 SControl 300)
usb 2-1.8: New USB device found, idVendor=0a5c, idProduct=5800, bcdDevice= 1.01
usb 2-1.8: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-1.8: Product: 5880
usb 2-1.8: Manufacturer: Broadcom Corp
usb 2-1.8: SerialNumber: 0123456789ABCD
usb 2-1.8: config 0 descriptor??
ata4: SATA link down (SStatus 0 SControl 300)
ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata6.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
ata6.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
ata6.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
ata6.00: supports DRM functions and may not be fully accessible
ata6.00: ATA-11: Samsung SSD 860 PRO 256GB, RVM01B6Q, max UDMA/133
ata6.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
ata6.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
ata6.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE LOCK) filtered out
ata6.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGURATION OVERLAY) filtered out
ata6.00: supports DRM functions and may not be fully accessible
ata6.00: configured for UDMA/133
scsi 5:0:0:0: Direct-Access     ATA      Samsung SSD 860  1B6Q PQ: 0 ANSI: 5
ata6.00: Enabling discard_zeroes_data
sd 5:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB/238 GiB)
sd 5:0:0:0: [sdb] Write Protect is off
sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata6.00: Enabling discard_zeroes_data
  sdb: sdb1
ata6.00: Enabling discard_zeroes_data
sd 5:0:0:0: [sdb] Attached SCSI disk
EXT4-fs (sdb1): mounted filesystem without journal. Opts: (null)
VFS: Mounted root (ext4 filesystem) on device 8:17.
devtmpfs: mounted
Freeing unused kernel image memory: 1188K
Write protecting the kernel read-only data: 14336k
Freeing unused kernel image memory: 2020K
Freeing unused kernel image memory: 1972K
x86/mm: Checked W+X mappings: passed, no W+X pages found.
Run /sbin/init as init process
NET: Registered protocol family 10
Segment Routing with IPv6
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Attached scsi generic sg1 type 5
sd 5:0:0:0: Attached scsi generic sg2 type 0
EXT4-fs (sdb1): re-mounted. Opts: nojournal_checksum,noauto_da_alloc,nobarrier,user_xattr,acl
i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042: Warning: Keylock active
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
i801_smbus 0000:00:1f.3: SPD Write Disable is set
i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
ACPI Warning: SystemIO range 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000001800-0x000000000000183F (\_SB.PCI0.EHC2.E1PM) (20190816/utaddress-204)
ACPI Warning: SystemIO range 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000001800-0x000000000000183F (\_SB.PCI0.EHC1.E1PM) (20190816/utaddress-204)
ACPI Warning: SystemIO range 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000001800-0x000000000000187F (\PMIO) (20190816/utaddress-204)
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
i801_smbus 0000:00:1f.3: Accelerometer lis3lv02d is present on SMBus but its address is unknown, skipping registration
ACPI Warning: SystemIO range 0x0000000000001C40-0x0000000000001C4F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C5F (\_SB.PCI0.PEG0.PEGP.GPR) (20190816/utaddress-204)
ACPI Warning: SystemIO range 0x0000000000001C40-0x0000000000001C4F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20190816/utaddress-204)
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
EFI Variables Facility v0.08 2004-May-17
usbcore: registered new interface driver cdc_wdm
ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C5F (\_SB.PCI0.PEG0.PEGP.GPR) (20190816/utaddress-204)
ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20190816/utaddress-204)
ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20190816/utaddress-204)
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C5F (\_SB.PCI0.PEG0.PEGP.GPR) (20190816/utaddress-204)
dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.3)
ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20190816/utaddress-204)
ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20190816/utaddress-204)
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
lpc_ich: Resource conflict(s) found affecting gpio_ich
mc: Linux media interface: v0.10
qmi_wwan 3-10:1.8: cdc-wdm0: USB WDM device
qmi_wwan 3-10:1.8 wwan0: register 'qmi_wwan' at usb-0000:00:14.0-10, WWAN/QMI device, e6:7f:3a:46:b7:3c
qmi_wwan 3-10:1.10: cdc-wdm1: USB WDM device
qmi_wwan 3-10:1.10 wwan1: register 'qmi_wwan' at usb-0000:00:14.0-10, WWAN/QMI device, e6:7f:3a:46:b7:3c
usbcore: registered new interface driver qmi_wwan
RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
RAPL PMU: hw unit of domain package 2^-14 Joules
RAPL PMU: hw unit of domain dram 2^-14 Joules
RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
iTCO_wdt: Found a Lynx Point TCO device (Version=2, TCOBASE=0x1860)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
cryptd: max_cpu_qlen set to 1000
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
dell_laptop: Using dell-rbtn acpi driver for receiving events
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pci 0000:11:00.0: SDHCI controller found [1217:8520] (rev 1)
mmc0: SDHCI controller on PCI [0000:11:00.0] using ADMA
videodev: Linux video capture interface: v2.00
snd_hda_intel 0000:00:03.0: enabling device (0000 -> 0002)
snd_hda_intel 0000:01:00.1: Force to non-snoop mode
EXT4-fs (sda2): mounted filesystem without journal. Opts: nojournal_checksum,noauto_da_alloc,user_xattr,acl,nobarrier
snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3226: line_outs=1 (0x16/0x0/0x0/0x0/0x0) type:line
snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
snd_hda_codec_realtek hdaudioC1D0:    inputs:
snd_hda_codec_generic hdaudioC2D0: ignore pin 0x7, too many assigned pins
snd_hda_codec_generic hdaudioC2D0: ignore pin 0x9, too many assigned pins
snd_hda_codec_generic hdaudioC2D0: ignore pin 0xb, too many assigned pins
snd_hda_codec_generic hdaudioC2D0: ignore pin 0xd, too many assigned pins
snd_hda_codec_generic hdaudioC2D0: autoconfig for Generic: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
snd_hda_codec_generic hdaudioC2D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
snd_hda_codec_generic hdaudioC2D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x18
snd_hda_codec_generic hdaudioC2D0:    mono: mono_out=0x0
snd_hda_codec_realtek hdaudioC1D0:      Dock Mic=0x19
snd_hda_codec_generic hdaudioC2D0:    dig-out=0x3/0x5
snd_hda_codec_generic hdaudioC2D0:    inputs:
snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=0x1a
snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
input: HDA ATI HDMI HDMI as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input7
input: HDA ATI HDMI HDMI as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input8
uvcvideo: Found UVC 1.00 device Laptop_Integrated_Webcam_HD (0c45:64d0)
mmc0: new high speed SDXC card at address aaaa
uvcvideo 1-1.5:1.0: Entity type for entity Extension 4 was not initialized!
uvcvideo 1-1.5:1.0: Entity type for entity Extension 3 was not initialized!
uvcvideo 1-1.5:1.0: Entity type for entity Processing 2 was not initialized!
uvcvideo 1-1.5:1.0: Entity type for entity Camera 1 was not initialized!
Bluetooth: Core ver 2.22
input: Laptop_Integrated_Webcam_HD: In as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5:1.0/input/input10
NET: Registered protocol family 31
usbcore: registered new interface driver uvcvideo
Bluetooth: HCI device and connection manager initialized
USB Video Class driver (1.1.1)
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
mmcblk0: mmc0:aaaa SC128 119 GiB
  mmcblk0: p1
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card1/input9
cfg80211: Loading compiled-in X.509 certificates for regulatory database
input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input11
input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input12
input: HDA Intel PCH Dock Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card1/input13
input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input14
cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
usbcore: registered new interface driver btusb
Bluetooth: hci0: read Intel version: 3707100180012d0d00
Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
Bluetooth: hci0: unexpected event for opcode 0xfc2f
Bluetooth: hci0: Intel firmware patch completed and activated
intel_rapl_common: Found RAPL domain package
intel_rapl_common: Found RAPL domain core
intel_rapl_common: Found RAPL domain uncore
intel_rapl_common: Found RAPL domain dram
intel_rapl_common: RAPL package-0 domain package locked by BIOS
intel_rapl_common: RAPL package-0 domain dram locked by BIOS
Intel(R) Wireless WiFi driver for Linux
Copyright(c) 2003- 2015 Intel Corporation
iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
iwlwifi 0000:03:00.0: loaded firmware version 17.3216344376.0 op_mode iwlmvm
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
NET: Registered protocol family 38
[drm] radeon kernel modesetting enabled.
vga_switcheroo: detected switching method \_SB_.PCI0.GFX0.ATPX handle
ATPX version 1, functions 0x00000033
radeon 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 0: 0xe0000000 -> 0xefffffff
radeon 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 2: 0xf0000000 -> 0xf07fffff
radeon 0000:01:00.0: remove_conflicting_pci_framebuffers: bar 5: 0xf7c00000 -> 0xf7c3ffff
checking generic (d0000000 7e9000) vs hw (e0000000 10000000)
checking generic (d0000000 7e9000) vs hw (f0000000 800000)
checking generic (d0000000 7e9000) vs hw (f7c00000 40000)
radeon 0000:01:00.0: enabling device (0000 -> 0003)
[drm] initializing kernel modesetting (BONAIRE 0x1002:0x6640 0x1028:0x05CD 0x00).
[drm] doorbell mmio base: 0xF0000000
[drm] doorbell mmio size: 8388608
ATOM BIOS: Dell
[drm] GPU not posted. posting now...
radeon 0000:01:00.0: VRAM: 2048M 0x0000000000000000 - 0x000000007FFFFFFF (2048M used)
radeon 0000:01:00.0: GTT: 2048M 0x0000000080000000 - 0x00000000FFFFFFFF
[drm] Detected VRAM RAM=2048M, BAR=256M
[drm] RAM width 128bits DDR
[TTM] Zone  kernel: Available graphics memory: 8154902 KiB
[TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 2048M of VRAM memory ready
[drm] radeon: 2048M of GTT memory ready.
[drm] Loading bonaire Microcode
[drm] Internal thermal controller without fan control
input: AlpsPS/2 ALPS DualPoint Stick as /devices/platform/i8042/serio1/input/input15
[drm] radeon: dpm initialized
[drm] Found UVD firmware Version: 1.64 Family ID: 9
mousedev: PS/2 mouse device common for all mice
[drm] Found VCE firmware/feedback version 40.2.2 / 15!
[drm] GART: num cpu pages 524288, num gpu pages 524288
[drm] PCIE gen 3 link speeds already enabled
input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input6
[drm] PCIE GART of 2048M enabled (table at 0x000000000030E000).
radeon 0000:01:00.0: WB enabled
radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000080000c00 and cpu addr 0x000000004c993224
radeon 0000:01:00.0: fence driver on ring 1 use gpu addr 0x0000000080000c04 and cpu addr 0x0000000041d1edee
radeon 0000:01:00.0: fence driver on ring 2 use gpu addr 0x0000000080000c08 and cpu addr 0x00000000f791422b
radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000080000c0c and cpu addr 0x00000000ad8469b1
radeon 0000:01:00.0: fence driver on ring 4 use gpu addr 0x0000000080000c10 and cpu addr 0x00000000590265a3
radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x0000000000078d30 and cpu addr 0x00000000a613befe
radeon 0000:01:00.0: fence driver on ring 6 use gpu addr 0x0000000080000c18 and cpu addr 0x00000000bcc715b8
radeon 0000:01:00.0: fence driver on ring 7 use gpu addr 0x0000000080000c1c and cpu addr 0x0000000059763588
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
radeon 0000:01:00.0: radeon: using MSI.
[drm] radeon: irq initialized.
[drm] ring test on 0 succeeded in 3 usecs
[drm] ring test on 1 succeeded in 3 usecs
[drm] ring test on 2 succeeded in 3 usecs
[drm] ring test on 3 succeeded in 4 usecs
[drm] ring test on 4 succeeded in 4 usecs
[drm] ring test on 5 succeeded in 2 usecs
iwlwifi 0000:03:00.0: Detected Intel(R) Dual Band Wireless AC 7260, REV=0x144
[drm] UVD initialized successfully.
iwlwifi 0000:03:00.0: base HW address: ac:fd:ce:e6:69:05
[drm] ring test on 6 succeeded in 19 usecs
[drm] ring test on 7 succeeded in 3 usecs
[drm] VCE initialized successfully.
[drm] ib test on ring 0 succeeded in 0 usecs
[drm] ib test on ring 1 succeeded in 0 usecs
[drm] ib test on ring 2 succeeded in 0 usecs
[drm] ib test on ring 3 succeeded in 0 usecs
[drm] ib test on ring 4 succeeded in 0 usecs
checking generic (d0000000 7e9000) vs hw (d0000000 10000000)
fb0: switching to inteldrmfb from EFI VGA
Console: switching to colour dummy device 80x25
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
vga_switcheroo: enabled
i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
radeon 0000:01:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=none
ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[drm] ib test on ring 5 succeeded
[drm] ib test on ring 6 succeeded
[drm] ib test on ring 7 succeeded
[drm] Radeon Display Connectors
[drm] Connector 0:
[drm]   DP-2
[drm]   HPD1
[drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c
[drm]   Encoders:
[drm]     DFP1: INTERNAL_UNIPHY1
[drm] Connector 1:
[drm]   DP-3
[drm]   HPD2
[drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c
[drm]   Encoders:
[drm]     DFP2: INTERNAL_UNIPHY1
[drm] Connector 2:
[drm]   DP-4
[drm]   HPD3
[drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558 0x655c 0x655c
[drm]   Encoders:
[drm]     DFP3: INTERNAL_UNIPHY2
[drm] Connector 3:
[drm]   VGA-2
[drm]   DDC: 0x65c0 0x65c0 0x65c4 0x65c4 0x65c8 0x65c8 0x65cc 0x65cc
[drm]   Encoders:
[drm]     CRT1: INTERNAL_KLDSCP_DAC1
[drm] Cannot find any crtc or sizes
[drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[drm] Initialized i915 1.6.0 20190822 for 0000:00:02.0 on minor 1
[Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS
ACPI: Video Device [PEGP] (multi-head: yes  rom: no  post: no)
input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:50/LNXVIDEO:00/input/input16
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:01/input/input17
snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
fbcon: i915drmfb (fb0) is primary device
[drm] Cannot find any crtc or sizes
Console: switching to colour frame buffer device 240x67
i915 0000:00:02.0: fb0: i915drmfb frame buffer device
snd_hda_codec_generic hdaudioC0D0: autoconfig for Generic: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
snd_hda_codec_generic hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
snd_hda_codec_generic hdaudioC0D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
snd_hda_codec_generic hdaudioC0D0:    mono: mono_out=0x0
snd_hda_codec_generic hdaudioC0D0:    dig-out=0x3/0x0
snd_hda_codec_generic hdaudioC0D0:    inputs:
input: HDA Intel HDMI HDMI as /devices/pci0000:00/0000:00:03.0/sound/card0/input18
[drm] amdgpu kernel modesetting enabled.
vga_switcheroo: detected switching method \_SB_.PCI0.GFX0.ATPX handle
ATPX version 1, functions 0x00000033
e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
EXT4-fs (sdb1): re-mounted. Opts: nojournal_checksum,noauto_da_alloc,nobarrier,user_xattr,acl
io scheduler mq-deadline registered
usbcore: registered new interface driver qcserial
usbserial: USB Serial support registered for Qualcomm USB modem
qcserial 3-10:1.0: Qualcomm USB modem converter detected
usb 3-10: Qualcomm USB modem converter now attached to ttyUSB0
qcserial 3-10:1.2: Qualcomm USB modem converter detected
usb 3-10: Qualcomm USB modem converter now attached to ttyUSB1
qcserial 3-10:1.3: Qualcomm USB modem converter detected
usb 3-10: Qualcomm USB modem converter now attached to ttyUSB2
EXT4-fs (sda2): mounted filesystem without journal. Opts: nojournal_checksum,noauto_da_alloc,user_xattr,acl,nobarrier
EXT4-fs (mmcblk0p1): mounted filesystem without journal. Opts: nobarrier,noauto_da_alloc
EXT4-fs (sdb1): re-mounted. Opts: nojournal_checksum,noauto_da_alloc,nobarrier,user_xattr,acl
wireguard: WireGuard 1.0.20200908 loaded. See www.wireguard.com for information.
wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
bpfilter: Loaded bpfilter_umh pid 4812
snd_hda_intel 0000:00:1b.0: IRQ timing workaround is activated for card #1. Suggest a bigger bdl_pos_adj.
bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
apbridge: port 1(eth0) entered blocking state
apbridge: port 1(eth0) entered disabled state
device eth0 entered promiscuous mode
apbridge: port 1(eth0) entered blocking state
apbridge: port 1(eth0) entered forwarding state
IPv6: ADDRCONF(NETDEV_CHANGE): apbridge: link becomes ready
NET: Registered protocol family 17
apbridge: port 2(wlan0) entered blocking state
apbridge: port 2(wlan0) entered disabled state
device wlan0 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
apbridge: port 2(wlan0) entered blocking state
apbridge: port 2(wlan0) entered forwarding state
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Not tainted 5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa1859c68ef80 RBX: 0000000000000088 RCX: 0000000080200009
RDX: 000000008020000a RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa18569f11e08 R08: 0000000000000000 R09: ffffa184493d8830
R10: 00000003e46e9e58 R11: 0000000000000003 R12: ffffbacb404cbe18
R13: ffffa184493d8800 R14: ffffa185646e9e40 R15: ffffa1833951a000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5825cc6000 CR3: 0000000227008003 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cd0 ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa1859c57d901 RBX: 0000000000000088 RCX: 00000000000040d9
RDX: 00000000000040d8 RSI: ffffa1859c57de80 RDI: 000000000002c5f0
RBP: ffffa18569f11e08 R08: 00000000000000ff R09: ffffa184493d8830
R10: 00000003e46e9e58 R11: 0000000000000004 R12: ffffbacb404cbe18
R13: ffffa184493d8800 R14: ffffa185646e9e40 R15: ffffa1853cdde000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5825cc6000 CR3: 0000000227008003 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cd1 ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa1844793b580 RBX: 0000000000000088 RCX: 0000000080200016
RDX: 0000000080200017 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa18569f11e08 R08: 0000000000000000 R09: ffffa1859c3c6130
R10: 00000002e3e66658 R11: 0000000000000005 R12: ffffbacb404cbe18
R13: ffffa1859c3c6100 R14: ffffa18463e66640 R15: ffffa18597a13000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbea6670fd8 CR3: 0000000227008002 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cd2 ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa1859c57db01 RBX: 0000000000000088 RCX: 0000000000004349
RDX: 0000000000004348 RSI: ffffa1859c57d500 RDI: 000000000002c5f0
RBP: ffffa18569f11e08 R08: 00000000000000ff R09: ffffa1859c3c6130
R10: 00000002e3e66658 R11: 0000000000000006 R12: ffffbacb404cbe18
R13: ffffa1859c3c6100 R14: ffffa18463e66640 R15: ffffa1858ba90000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbea6670fd8 CR3: 0000000227008002 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cd3 ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0000:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa1823e489780 RBX: 0000000000000088 RCX: 0000000080200001
RDX: 0000000080200002 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa18569f11e08 R08: 0000000000000000 R09: ffffa181c1f0cc30
R10: 00000002dcde5c98 R11: 0000000000000007 R12: ffffbacb404cbe18
R13: ffffa181c1f0cc00 R14: ffffa1845cde5c80 R15: ffffa1846cc9f000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa7f0568bc0 CR3: 00000001b940c002 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cd4 ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0000:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa1859c57db01 RBX: 0000000000000088 RCX: 000000000000434b
RDX: 000000000000434a RSI: ffffa1859c57d500 RDI: 000000000002c5f0
RBP: ffffa18569f11e08 R08: 00000000000000ff R09: ffffa181c1f0cc30
R10: 00000002dcde5c98 R11: 0000000000000008 R12: ffffbacb404cbe18
R13: ffffa181c1f0cc00 R14: ffffa1845cde5c80 R15: ffffa18440d2b000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa7f0568bc0 CR3: 0000000227008004 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cd5 ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa18534113700 RBX: 0000000000000088 RCX: 0000000080200011
RDX: 0000000080200012 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa18569f11e08 R08: 0000000000000000 R09: ffffa1859759bd30
R10: 00000002e3ef7b18 R11: 0000000000000009 R12: ffffbacb404cbe18
R13: ffffa1859759bd00 R14: ffffa18463ef7b00 R15: ffffa18597951000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5825d6f000 CR3: 0000000227008006 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cd6 ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa1859c57db01 RBX: 0000000000000088 RCX: 000000000000434d
RDX: 000000000000434c RSI: ffffa1859c57d500 RDI: 000000000002c5f0
RBP: ffffa18569f11e08 R08: 00000000000000ff R09: ffffa1859759bd30
R10: 00000002e3ef7b18 R11: 000000000000000a R12: ffffbacb404cbe18
R13: ffffa1859759bd00 R14: ffffa18463ef7b00 R15: ffffa18447820000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5825d6f000 CR3: 0000000227008006 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cd7 ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa1844793bd00 RBX: 0000000000000088 RCX: 0000000080200015
RDX: 0000000080200016 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa18569f11e08 R08: 0000000000000000 R09: ffffa1859c3c7830
R10: 00000002e3e66498 R11: 000000000000000b R12: ffffbacb404cbe18
R13: ffffa1859c3c7800 R14: ffffa18463e66480 R15: ffffa1823dcfb000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5825cc9800 CR3: 0000000227008006 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cd8 ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0000:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa1859c57db01 RBX: 0000000000000088 RCX: 000000000000434f
RDX: 000000000000434e RSI: ffffa1859c57d500 RDI: 000000000002c5f0
RBP: ffffa18569f11e08 R08: 00000000000000fe R09: ffffa1859c3c7830
R10: 00000002e3e66498 R11: 000000000000000c R12: ffffbacb404cbe18
R13: ffffa1859c3c7800 R14: ffffa18463e66480 R15: ffffa1846462c000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055eadc483000 CR3: 00000004152d6002 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cd9 ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0000:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa1859c43a000 RBX: 0000000000000088 RCX: 0000000080200016
RDX: 0000000080200017 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa18569f11e08 R08: 0000000000000000 R09: ffffa1859bef1930
R10: 00000001087cfb18 R11: 000000000000000d R12: ffffbacb404cbe18
R13: ffffa1859bef1900 R14: ffffa182887cfb00 R15: ffffa18564728000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055eadc483000 CR3: 00000004152d6002 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cda ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa18534113e80 RBX: 0000000000000088 RCX: 000000008020001e
RDX: 000000008020001f RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa18569f11e08 R08: 0000000000000000 R09: ffffa1859759a730
R10: 00000002e3ef7418 R11: 000000000000009d R12: ffffbacb404cbe18
R13: ffffa1859759a700 R14: ffffa18463ef7400 R15: ffffa185977f3000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5825bc8800 CR3: 0000000227008004 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cdb ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa1859c68e380 RBX: 0000000000000088 RCX: 000000008020000b
RDX: 000000008020000c RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa18569f11e08 R08: 0000000000000000 R09: ffffa1846cc5ad30
R10: 00000003e46e8b18 R11: 0000000000000000 R12: ffffbacb404cbe18
R13: ffffa1846cc5ad00 R14: ffffa185646e8b00 R15: ffffa183e6543000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5825bc4800 CR3: 0000000227008005 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cdc ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa183e67d0380 RBX: 0000000000000088 RCX: 0000000080200018
RDX: 0000000080200019 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa18569f11e08 R08: 0000000000000000 R09: ffffa1844904e330
R10: 000000012352ddfe R11: 0000000000000001 R12: ffffbacb404cbe18
R13: ffffa1844904e300 R14: ffffa182a352dde4 R15: ffffa182a3402000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5825bc4800 CR3: 0000000227008005 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cdd ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa183e67d0200 RBX: 0000000000000088 RCX: 0000000080200017
RDX: 0000000080200018 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa18569f11e08 R08: 0000000000000000 R09: ffffa1844904f030
R10: 000000012352d6fe R11: 0000000000000002 R12: ffffbacb404cbe18
R13: ffffa1844904f000 R14: ffffa182a352d6e4 R15: ffffa18339450000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5825bc4800 CR3: 0000000227008005 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cde ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa185954ecd01 RBX: 0000000000000088 RCX: 0000000000005ac0
RDX: 0000000000005abf RSI: ffffa185954ec000 RDI: 000000000002c5f0
RBP: ffffa18569f11e08 R08: 00000000000000ff R09: ffffa1846cc5ad30
R10: 00000003e46e8b18 R11: 0000000000000001 R12: ffffbacb404cbe18
R13: ffffa1846cc5ad00 R14: ffffa185646e8b00 R15: ffffa183395a5000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5825bc4800 CR3: 0000000227008005 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994cdf ]---
------------[ cut here ]------------
WARNING: CPU: 7 PID: 2233 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:1497 iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Modules linked in: ccm af_packet bridge stp llc xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_mark iptable_mangle xt_comment xt_addrtype iptable_raw bpfilter wireguard ip6_udp_tunnel udp_tunnel qcserial usb_wwan usbserial mq_deadline amdgpu gpu_sched i915 iwlmvm joydev mousedev radeon mac80211 cmac algif_hash algif_skcipher af_alg bnep libarc4 iwlwifi intel_rapl_msr coretemp intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm btusb cfg80211 btrtl btbcm btintel mmc_block nls_iso8859_1 bluetooth nls_cp437 ttm uvcvideo intel_gtt vfat i2c_algo_bit fat snd_hda_codec_realtek drm_kms_helper snd_hda_codec_generic videobuf2_v4l2 videobuf2_vmalloc videobuf2_memops videobuf2_common irqbypass input_leds crct10dif_pclmul psmouse snd_hda_intel crc32_pclmul videodev crc32c_intel snd_intel_nhlt sdhci_pci snd_hda_codec ghash_clmulni_intel dell_smm_hwmon cqhci hwmon mei_hdcp snd_hda_core sdhci aesni_intel dell_laptop crypto_simd atkbd mmc_core iTCO_wdt
  snd_pcm libps2 cryptd glue_helper ledtrig_audio dell_smbios rapl mei_me snd_timer intel_cstate qmi_wwan syscopyarea dcdbas mei snd intel_uncore mc cdc_wdm sysfillrect efivars sysimgblt usbnet ecdh_generic lpc_ich video ecc i2c_i801 mfd_core soundcore mii led_class dell_rbtn fb_sys_fops iosf_mbi i8042 serio dell_smo8800 backlight rfkill evdev drm sg crypto_user i2c_core efivarfs ip_tables x_tables ipv6 autofs4
CPU: 7 PID: 2233 Comm: irq/38-iwlwifi Tainted: G        W         5.4.72kb+ #1
Hardware name: Dell Inc. Precision M6800/0CF0TC, BIOS A14 05/24/2015
RIP: 0010:iwl_mvm_rx_tx_cmd+0x40a/0x7c0 [iwlmvm]
Code: e8 cb 81 ff ff 4c 8b 0c 24 88 85 9e 1d 00 00 e9 0b fe ff ff 66 81 fb 85 00 41 0f 94 c4 eb a1 66 81 fb 8e 00 41 0f 94 c4 eb 96 <0f> 0b 41 81 4d 28 00 01 00 00 eb 87 c6 44 24 2d 00 8b 44 24 0c 31
RSP: 0018:ffffbacb404cbce0 EFLAGS: 00010246
RAX: ffffa185954ec001 RBX: 0000000000000088 RCX: 0000000000005ac1
RDX: 0000000000005ac0 RSI: ffffa185954ec900 RDI: 000000000002c5f0
RBP: ffffa18569f11e08 R08: 00000000000000fe R09: ffffa1844904e330
R10: 000000012352ddfe R11: 0000000000000003 R12: ffffbacb404cbe18
R13: ffffa1844904e300 R14: ffffa182a352dde4 R15: ffffa18596f9a000
FS:  0000000000000000(0000) GS:ffffa1859e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5825bc4800 CR3: 0000000227008005 CR4: 00000000001606e0
Call Trace:
  iwl_mvm_rx_common+0xc7/0x270 [iwlmvm]
  iwl_pcie_rx_handle+0x3b6/0xb00 [iwlwifi]
  iwl_pcie_irq_handler+0x526/0xa50 [iwlwifi]
  ? disable_irq_nosync+0x10/0x10
  irq_thread_fn+0x1a/0x60
  irq_thread+0xc9/0x160
  ? irq_thread_check_affinity+0x60/0x60
  ? irq_forced_thread_fn+0x80/0x80
  kthread+0x115/0x130
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x24/0x30
---[ end trace 1e85aa8a39994ce0 ]---
device wlan0 left promiscuous mode
apbridge: port 2(wlan0) entered disabled state


Enrico Mioso
Personal Phone Number: +39 3807096934
Tox ID is:
7C593F402A3C8632D87AB4B948D492294C39A6A614464ECF843CA3429FB023284180472C7475
