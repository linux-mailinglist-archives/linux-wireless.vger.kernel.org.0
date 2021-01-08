Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEEC2EED33
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jan 2021 06:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbhAHFkB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jan 2021 00:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbhAHFkB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jan 2021 00:40:01 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A93C0612F4
        for <linux-wireless@vger.kernel.org>; Thu,  7 Jan 2021 21:39:20 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id m23so8710029ioy.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 Jan 2021 21:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dCuYySSKI2tZ2N/u+SA2sHejnIEVRuGbitOpkY2TC5s=;
        b=S4mzZ1OtsTaGZ0tdEstm+ugXU//D8Z0rIZL+hcbOjrJ8R5OHS9+6lE2yftCJVB5QDP
         /74GOIRfwiXK8hrlmdQO8PnLNt/eZe6B3uO0eBoMYRsa0PRV2PeBtSmJrQuLHFVc8lgW
         aqtOkiwuVvJUbjRny1byfR92UlGBHF2YwektNYluEVNDeQUGCh1ZRd+12j7aQF3SvyBn
         8/vBMXfGfPeYdjtFQNKTegB4rE+ruvLeN4/oiZen5I/V1PL5uzFD+zqHriGbNsU+j1cU
         ySXy/yuw2wlGfwRBjWdCdg6TMl+BxHT/oaWhiOHP2bAPejVMQzMTpbP1IIigwyFJr75t
         ypKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dCuYySSKI2tZ2N/u+SA2sHejnIEVRuGbitOpkY2TC5s=;
        b=gKvlyNYB7BqdNokTKzwnShgpAnP/39dtE20m5FjPEuo5q3u6EIXRY6yu+3OZSvyM5g
         anHJ4advbcVxCMVfqgXQiZgLNciMRufNmDf0zP47GKfGI81po3AFJB+DJdi+Fd90E81X
         xm3r5gWT4foq/Bu15gtwredpGKlraLS4eivwnUzBD49bqJj56Hd3FidivLTMV/GpoZPL
         Pw5ceoInOR4O2ofl0mjNHQLYJBdUsaaEI+ePn4yg05G0n2IPzZ8b2FbadsNAuUriQvtm
         PvyMRlRQjKaji2csEgZUiDhxy8Wa76gxBStAa123nQCNwrflGVhZtmHgHMcfDp7kzANO
         +ckQ==
X-Gm-Message-State: AOAM533bieQZkmrNn37o7GRCIZI5AhmsFChAni9+vVXYmQMySYMWC8KL
        e3y/vI5TyaRMdUPvUHV8rNce87JX3SufqPJoCkcLxHIeU8XmfQ==
X-Google-Smtp-Source: ABdhPJzYSkSaHrBFEKmWqOAvfyohOUMOyRtMrFVpeYifVgqcDv46IYfzMWrCwa02xGyygs9PQy+5g0tc4sDuiKhYq+E=
X-Received: by 2002:a6b:f90f:: with SMTP id j15mr4197369iog.89.1610084357597;
 Thu, 07 Jan 2021 21:39:17 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5rip57Kk5Y2O?= <huadiw@gmail.com>
Date:   Fri, 8 Jan 2021 13:39:06 +0800
Message-ID: <CAOMh3odt=hRexbeUT=xmhZcgZk4czbxSFDv5s=tFS+VUVaMBDQ@mail.gmail.com>
Subject: ntl8821ce driver is not working on my thinkpad E580
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi
I git the lastest repo on github lwfinger/rtw88.git  and install it.
After install, I reboot the system,ntl8821ce didn't work.

Here is my message.Thanks for your help
os:
Debian 10 testing x86_64
Linux debian 5.9.0-5-amd64 #1 SMP Debian 5.9.15-1 (2020-12-17) x86_64 GNU/Linux


lspci -v
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core
Processor Host Bridge/DRAM Registers (rev 08)
Subsystem: Lenovo Xeon E3-1200 v6/7th Gen Core Processor Host
Bridge/DRAM Registers
Flags: bus master, fast devsel, latency 0, IOMMU group 0
Capabilities: <access denied>
Kernel driver in use: skl_uncore

00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 620
(rev 07) (prog-if 00 [VGA controller])
Subsystem: Lenovo UHD Graphics 620
Flags: bus master, fast devsel, latency 0, IRQ 140, IOMMU group 1
Memory at f1000000 (64-bit, non-prefetchable) [size=16M]
Memory at d0000000 (64-bit, prefetchable) [size=256M]
I/O ports at e000 [size=64]
Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
Capabilities: <access denied>
Kernel driver in use: i915
Kernel modules: i915

00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 /
E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
Subsystem: Lenovo Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen
Core Processor Gaussian Mixture Model
Flags: fast devsel, IRQ 255, IOMMU group 2
Memory at f252a000 (64-bit, non-prefetchable) [disabled] [size=4K]
Capabilities: <access denied>

00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0
xHCI Controller (rev 21) (prog-if 30 [XHCI])
Subsystem: Lenovo Sunrise Point-LP USB 3.0 xHCI Controller
Flags: bus master, medium devsel, latency 0, IRQ 130, IOMMU group 3
Memory at f2500000 (64-bit, non-prefetchable) [size=64K]
Capabilities: <access denied>
Kernel driver in use: xhci_hcd
Kernel modules: xhci_pci

00:14.2 Signal processing controller: Intel Corporation Sunrise
Point-LP Thermal subsystem (rev 21)
Subsystem: Lenovo Sunrise Point-LP Thermal subsystem
Flags: fast devsel, IRQ 18, IOMMU group 3
Memory at f252b000 (64-bit, non-prefetchable) [size=4K]
Capabilities: <access denied>
Kernel driver in use: intel_pch_thermal
Kernel modules: intel_pch_thermal

00:16.0 Communication controller: Intel Corporation Sunrise Point-LP
CSME HECI #1 (rev 21)
Subsystem: Lenovo Sunrise Point-LP CSME HECI
Flags: bus master, fast devsel, latency 0, IRQ 142, IOMMU group 4
Memory at f252c000 (64-bit, non-prefetchable) [size=4K]
Capabilities: <access denied>
Kernel driver in use: mei_me
Kernel modules: mei_me

00:17.0 SATA controller: Intel Corporation Sunrise Point-LP SATA
Controller [AHCI mode] (rev 21) (prog-if 01 [AHCI 1.0])
Subsystem: Lenovo Sunrise Point-LP SATA Controller [AHCI mode]
Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 131, IOMMU group 5
Memory at f2528000 (32-bit, non-prefetchable) [size=8K]
Memory at f252f000 (32-bit, non-prefetchable) [size=256]
I/O ports at e080 [size=8]
I/O ports at e088 [size=4]
I/O ports at e060 [size=32]
Memory at f252d000 (32-bit, non-prefetchable) [size=2K]
Capabilities: <access denied>
Kernel driver in use: ahci
Kernel modules: ahci

00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express
Root Port #1 (rev f1) (prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 0, IRQ 122, IOMMU group 6
Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
I/O behind bridge: 0000d000-0000dfff [size=4K]
Memory behind bridge: f2400000-f24fffff [size=1M]
Prefetchable memory behind bridge: 00000000e0000000-00000000f01fffff [size=258M]
Capabilities: <access denied>
Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express
Root Port #5 (rev f1) (prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 0, IRQ 123, IOMMU group 7
Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
I/O behind bridge: 0000c000-0000cfff [size=4K]
Memory behind bridge: f2300000-f23fffff [size=1M]
Prefetchable memory behind bridge: [disabled]
Capabilities: <access denied>
Kernel driver in use: pcieport

00:1d.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express
Root Port #9 (rev f1) (prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 0, IRQ 124, IOMMU group 8
Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
I/O behind bridge: [disabled]
Memory behind bridge: f2200000-f22fffff [size=1M]
Prefetchable memory behind bridge: [disabled]
Capabilities: <access denied>
Kernel driver in use: pcieport

00:1d.2 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express
Root Port #11 (rev f1) (prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 0, IRQ 125, IOMMU group 9
Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
I/O behind bridge: 0000b000-0000bfff [size=4K]
Memory behind bridge: f2100000-f21fffff [size=1M]
Prefetchable memory behind bridge: [disabled]
Capabilities: <access denied>
Kernel driver in use: pcieport

00:1d.3 PCI bridge: Intel Corporation Device 9d1b (rev f1) (prog-if 00
[Normal decode])
Flags: bus master, fast devsel, latency 0, IRQ 126, IOMMU group 10
Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
I/O behind bridge: [disabled]
Memory behind bridge: f2000000-f20fffff [size=1M]
Prefetchable memory behind bridge: [disabled]
Capabilities: <access denied>
Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Sunrise Point LPC
Controller/eSPI Controller (rev 21)
Subsystem: Lenovo Sunrise Point LPC Controller/eSPI Controller
Flags: bus master, medium devsel, latency 0, IOMMU group 11

00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
Subsystem: Lenovo Sunrise Point-LP PMC
Flags: fast devsel, IOMMU group 11
Memory at f2524000 (32-bit, non-prefetchable) [disabled] [size=16K]

00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
Subsystem: Lenovo Sunrise Point-LP HD Audio
Flags: bus master, fast devsel, latency 64, IRQ 145, IOMMU group 11
Memory at f2520000 (64-bit, non-prefetchable) [size=16K]
Memory at f2510000 (64-bit, non-prefetchable) [size=64K]
Capabilities: <access denied>
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel, snd_soc_skl

00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
Subsystem: Lenovo Sunrise Point-LP SMBus
Flags: medium devsel, IRQ 16, IOMMU group 11
Memory at f252e000 (64-bit, non-prefetchable) [size=256]
I/O ports at efa0 [size=32]
Kernel driver in use: i801_smbus
Kernel modules: i2c_i801

02:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
Lexa PRO [Radeon 540/540X/550/550X / RX 540X/550/550X] (rev c0)
Subsystem: Lenovo Lexa PRO [Radeon 540/540X/550/550X / RX 540X/550/550X]
Flags: bus master, fast devsel, latency 0, IRQ 141, IOMMU group 12
Memory at e0000000 (64-bit, prefetchable) [size=256M]
Memory at f0000000 (64-bit, prefetchable) [size=2M]
I/O ports at d000 [size=256]
Memory at f2400000 (32-bit, non-prefetchable) [size=256K]
Expansion ROM at f2440000 [disabled] [size=128K]
Capabilities: <access denied>
Kernel driver in use: amdgpu
Kernel modules: amdgpu

03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 10)
Subsystem: Lenovo RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 13
I/O ports at c000 [size=256]
Memory at f2304000 (64-bit, non-prefetchable) [size=4K]
Memory at f2300000 (64-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: r8169
Kernel modules: r8169

04:00.0 Non-Volatile memory controller: Union Memory (Shenzhen) Device
5008 (rev 01) (prog-if 02 [NVM Express])
Subsystem: Union Memory (Shenzhen) Device 5008
Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0, IOMMU group 14
Memory at f2200000 (64-bit, non-prefetchable) [size=16K]
Capabilities: <access denied>
Kernel driver in use: nvme
Kernel modules: nvme

05:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE
802.11ac PCIe Wireless Network Adapter
Subsystem: Lenovo RTL8821CE 802.11ac PCIe Wireless Network Adapter
Flags: bus master, fast devsel, latency 0, IRQ 151, IOMMU group 15
I/O ports at b000 [size=256]
Memory at f2100000 (64-bit, non-prefetchable) [size=64K]
Capabilities: <access denied>
Kernel driver in use: rtw_8821ce
Kernel modules: rtw_8821ce, 8821ce

06:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader
Controller (rev 01) (prog-if 01)
Subsystem: Lenovo SD/MMC Card Reader Controller
Flags: bus master, fast devsel, latency 0, IRQ 127, IOMMU group 16
Memory at f2001000 (32-bit, non-prefetchable) [size=4K]
Memory at f2000000 (32-bit, non-prefetchable) [size=2K]
Capabilities: <access denied>
Kernel driver in use: sdhci-pci
Kernel modules: sdhci_pci


lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 04f2:b604 Chicony Electronics Co., Ltd
Integrated Camera (1280x720@30)
Bus 001 Device 005: ID 0bda:c024 Realtek Semiconductor Corp. Bluetooth Radio
Bus 001 Device 002: ID 17ef:6050 Lenovo Lenovo Precision USB Mouse
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub


dmesg
[    0.000000] microcode: microcode updated early to revision 0xe0,
date = 2020-06-17
[    0.000000] Linux version 5.9.0-5-amd64
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-1) 10.2.1
20201207, GNU ld (GNU Binutils for Debian) 2.35.1) #1 SMP Debian
5.9.15-1 (2020-12-17)
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.9.0-5-amd64
root=UUID=fb0b7366-7ee2-4efd-ae92-0f1fe0a91e51 ro quiet splash
l1tf=full
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is
960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000008bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008c000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000a077bfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000a077c000-0x00000000a077cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000a077d000-0x00000000a077dfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000a077e000-0x00000000aa0e8fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000aa0e9000-0x00000000aa19dfff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000aa19e000-0x00000000ab723fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ab724000-0x00000000ab799fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ab79a000-0x00000000ab7fefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000ab7ff000-0x00000000ab7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ab800000-0x00000000af7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe010000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000024f7fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Lenovo
[    0.000000] efi: SMBIOS=0xaa835000 SMBIOS 3.0=0xaa832000
ACPI=0xab7fe000 ACPI 2.0=0xab7fe014 ESRT=0xaa27a000 MEMATTR=0xa49bd018
[    0.000000] secureboot: Secure boot could not be determined (mode 0)
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: LENOVO 20KSA024CD/20KSA024CD, BIOS R0PET67W (1.44
) 06/19/2020
[    0.000000] tsc: Detected 1800.000 MHz processor
[    0.001089] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001092] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001102] last_pfn = 0x24f800 max_arch_pfn = 0x400000000
[    0.001108] MTRR default type: write-back
[    0.001109] MTRR fixed ranges enabled:
[    0.001111]   00000-9FFFF write-back
[    0.001112]   A0000-BFFFF uncachable
[    0.001114]   C0000-FFFFF write-protect
[    0.001115] MTRR variable ranges enabled:
[    0.001117]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.001118]   1 base 00B0000000 mask 7FF0000000 uncachable
[    0.001120]   2 base 00AE000000 mask 7FFE000000 uncachable
[    0.001121]   3 base 00AD000000 mask 7FFF000000 uncachable
[    0.001122]   4 disabled
[    0.001122]   5 disabled
[    0.001123]   6 disabled
[    0.001124]   7 disabled
[    0.001125]   8 disabled
[    0.001125]   9 disabled
[    0.001880] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.002147] last_pfn = 0xab800 max_arch_pfn = 0x400000000
[    0.017429] esrt: Reserving ESRT space from 0x00000000aa27a000 to
0x00000000aa27a088.
[    0.017444] Using GB pages for direct mapping
[    0.017973] RAMDISK: [mem 0x2fffb000-0x33ff4fff]
[    0.017982] ACPI: Early table checksum verification disabled
[    0.017985] ACPI: RSDP 0x00000000AB7FE014 000024 (v02 LENOVO)
[    0.017990] ACPI: XSDT 0x00000000AB7C1188 0000EC (v01 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.017998] ACPI: FACP 0x00000000AB7F7000 0000F4 (v05 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018006] ACPI: DSDT 0x00000000AB7D1000 0219A6 (v02 LENOVO SKL
  00000000 INTL 20160527)
[    0.018010] ACPI: FACS 0x00000000AB746000 000040
[    0.018014] ACPI: UEFI 0x00000000AB75C000 000042 (v01 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018018] ACPI: SSDT 0x00000000AB7F9000 003244 (v02 LENOVO SaSsdt
  00003000 INTL 20160527)
[    0.018022] ACPI: SSDT 0x00000000AB7F8000 0005C6 (v02 LENOVO
PerfTune 00001000 INTL 20160527)
[    0.018026] ACPI: HPET 0x00000000AB7F6000 000038 (v01 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018030] ACPI: APIC 0x00000000AB7F5000 00012C (v03 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018034] ACPI: MCFG 0x00000000AB7F4000 00003C (v01 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018038] ACPI: ECDT 0x00000000AB7F3000 000053 (v01 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018042] ACPI: SSDT 0x00000000AB7CF000 0016AC (v02 LENOVO
ProjSsdt 00000010 INTL 20160527)
[    0.018046] ACPI: BOOT 0x00000000AB7CE000 000028 (v01 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018050] ACPI: BATB 0x00000000AB7CD000 00004A (v02 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018054] ACPI: SLIC 0x00000000AB7CC000 000176 (v01 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018058] ACPI: SSDT 0x00000000AB7CA000 0017AE (v02 LENOVO
CpuSsdt  00003000 INTL 20160527)
[    0.018062] ACPI: SSDT 0x00000000AB7C9000 00056D (v02 LENOVO CtdpB
  00001000 INTL 20160527)
[    0.018066] ACPI: SSDT 0x00000000AB7C8000 000648 (v02 LENOVO
UsbCTabl 00001000 INTL 20160527)
[    0.018070] ACPI: DBGP 0x00000000AB7C7000 000034 (v01 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018073] ACPI: DBG2 0x00000000AB7C6000 000054 (v00 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018077] ACPI: MSDM 0x00000000AB7C5000 000055 (v03 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018081] ACPI: SSDT 0x00000000AB7C4000 0005C4 (v01 LENOVO
AmdTabl  00001000 INTL 20160527)
[    0.018085] ACPI: SSDT 0x00000000AB7C3000 0005AD (v02 LENOVO SgPch
  00001000 INTL 20160527)
[    0.018089] ACPI: SSDT 0x00000000AB7C2000 000351 (v02 LENOVO SgUlx
  00001000 INTL 20160527)
[    0.018093] ACPI: DMAR 0x00000000AB7FD000 0000A8 (v01 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018097] ACPI: ASF! 0x00000000AB7C0000 0000A0 (v32 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018101] ACPI: FPDT 0x00000000AB7BF000 000044 (v01 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018104] ACPI: UEFI 0x00000000AB732000 00013E (v01 LENOVO TP-R0P
  00000670 PTEC 00000002)
[    0.018116] ACPI: Local APIC address 0xfee00000
[    0.018216] No NUMA configuration found
[    0.018218] Faking a node at [mem 0x0000000000000000-0x000000024f7fffff]
[    0.018224] NODE_DATA(0) allocated [mem 0x24f7fb000-0x24f7fffff]
[    0.018270] Zone ranges:
[    0.018271]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.018273]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.018274]   Normal   [mem 0x0000000100000000-0x000000024f7fffff]
[    0.018276]   Device   empty
[    0.018277] Movable zone start for each node
[    0.018278] Early memory node ranges
[    0.018280]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.018281]   node   0: [mem 0x0000000000059000-0x000000000008bfff]
[    0.018282]   node   0: [mem 0x0000000000100000-0x00000000a077bfff]
[    0.018283]   node   0: [mem 0x00000000a077e000-0x00000000aa0e8fff]
[    0.018284]   node   0: [mem 0x00000000ab7ff000-0x00000000ab7fffff]
[    0.018285]   node   0: [mem 0x0000000100000000-0x000000024f7fffff]
[    0.018662] Zeroed struct page in unavailable ranges: 26510 pages
[    0.018664] Initmem setup node 0 [mem 0x0000000000001000-0x000000024f7fffff]
[    0.018667] On node 0 totalpages: 2070642
[    0.018668]   DMA zone: 64 pages used for memmap
[    0.018669]   DMA zone: 72 pages reserved
[    0.018671]   DMA zone: 3978 pages, LIFO batch:0
[    0.018728]   DMA32 zone: 10820 pages used for memmap
[    0.018729]   DMA32 zone: 692456 pages, LIFO batch:63
[    0.028443]   Normal zone: 21472 pages used for memmap
[    0.028444]   Normal zone: 1374208 pages, LIFO batch:63
[    0.028928] Reserving Intel graphics memory at [mem 0xad800000-0xaf7fffff]
[    0.029504] ACPI: PM-Timer IO Port: 0x1808
[    0.029506] ACPI: Local APIC address 0xfee00000
[    0.029515] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.029516] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.029517] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.029518] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.029519] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.029520] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.029520] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.029521] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.029522] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.029523] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.029523] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.029524] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.029525] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.029526] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.029527] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.029528] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.029556] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.029559] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.029561] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.029563] ACPI: IRQ0 used by override.
[    0.029564] ACPI: IRQ9 used by override.
[    0.029567] Using ACPI (MADT) for SMP configuration information
[    0.029569] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.029573] TSC deadline timer available
[    0.029574] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.029598] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.029600] PM: hibernation: Registered nosave memory: [mem
0x00058000-0x00058fff]
[    0.029602] PM: hibernation: Registered nosave memory: [mem
0x0008c000-0x000fffff]
[    0.029604] PM: hibernation: Registered nosave memory: [mem
0xa077c000-0xa077cfff]
[    0.029605] PM: hibernation: Registered nosave memory: [mem
0xa077d000-0xa077dfff]
[    0.029607] PM: hibernation: Registered nosave memory: [mem
0xaa0e9000-0xaa19dfff]
[    0.029608] PM: hibernation: Registered nosave memory: [mem
0xaa19e000-0xab723fff]
[    0.029609] PM: hibernation: Registered nosave memory: [mem
0xab724000-0xab799fff]
[    0.029610] PM: hibernation: Registered nosave memory: [mem
0xab79a000-0xab7fefff]
[    0.029612] PM: hibernation: Registered nosave memory: [mem
0xab800000-0xaf7fffff]
[    0.029612] PM: hibernation: Registered nosave memory: [mem
0xaf800000-0xf7ffffff]
[    0.029613] PM: hibernation: Registered nosave memory: [mem
0xf8000000-0xfbffffff]
[    0.029614] PM: hibernation: Registered nosave memory: [mem
0xfc000000-0xfe00ffff]
[    0.029615] PM: hibernation: Registered nosave memory: [mem
0xfe010000-0xfe010fff]
[    0.029616] PM: hibernation: Registered nosave memory: [mem
0xfe011000-0xffffffff]
[    0.029618] [mem 0xaf800000-0xf7ffffff] available for PCI devices
[    0.029620] Booting paravirtualized kernel on bare hardware
[    0.029623] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.037180] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512
nr_cpu_ids:8 nr_node_ids:1
[    0.037494] percpu: Embedded 55 pages/cpu s185048 r8192 d32040 u262144
[    0.037504] pcpu-alloc: s185048 r8192 d32040 u262144 alloc=1*2097152
[    0.037505] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.037538] Built 1 zonelists, mobility grouping on.  Total pages: 2038214
[    0.037539] Policy zone: Normal
[    0.037541] Kernel command line: BOOT_IMAGE=/vmlinuz-5.9.0-5-amd64
root=UUID=fb0b7366-7ee2-4efd-ae92-0f1fe0a91e51 ro quiet splash
l1tf=full
[    0.038435] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes, linear)
[    0.038836] Inode-cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.038956] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.060072] Memory: 2704784K/8282568K available (12291K kernel
code, 1298K rwdata, 3808K rodata, 1636K init, 1768K bss, 384032K
reserved, 0K cma-reserved)
[    0.060083] random: get_random_u64 called from
__kmem_cache_create+0x2e/0x540 with crng_init=0
[    0.060316] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.060338] Kernel/User page tables isolation: enabled
[    0.060366] ftrace: allocating 34827 entries in 137 pages
[    0.081839] ftrace: allocated 137 pages with 3 groups
[    0.082016] rcu: Hierarchical RCU implementation.
[    0.082018] rcu: RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
[    0.082019] Rude variant of Tasks RCU enabled.
[    0.082020] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.082021] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.087721] NR_IRQS: 33024, nr_irqs: 2048, preallocated irqs: 16
[    0.088426] random: crng done (trusting CPU's manufacturer)
[    0.088465] Console: colour dummy device 80x25
[    0.088471] printk: console [tty0] enabled
[    0.088504] ACPI: Core revision 20200717
[    0.088974] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 79635855245 ns
[    0.089048] APIC: Switch to symmetric I/O mode setup
[    0.089051] DMAR: Host address width 39
[    0.089052] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.089061] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap
1c0000c40660462 ecap 19e2ff0505e
[    0.089063] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.089068] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap
d2008c40660462 ecap f050da
[    0.089070] DMAR: RMRR base: 0x000000aac7f000 end: 0x000000aac9efff
[    0.089071] DMAR: RMRR base: 0x000000ad000000 end: 0x000000af7fffff
[    0.089074] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.089075] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.089076] DMAR-IR: Queued invalidation will be enabled to support
x2apic and Intr-remapping.
[    0.090756] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.090758] x2apic enabled
[    0.090772] Switched APIC routing to cluster x2apic.
[    0.094762] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.113016] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x19f2297dd97, max_idle_ns: 440795236593 ns
[    0.113022] Calibrating delay loop (skipped), value calculated
using timer frequency.. 3600.00 BogoMIPS (lpj=7200000)
[    0.113026] pid_max: default: 32768 minimum: 301
[    0.119595] LSM: Security Framework initializing
[    0.119605] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.119650] AppArmor: AppArmor initialized
[    0.119653] TOMOYO Linux initialized
[    0.119701] Mount-cache hash table entries: 16384 (order: 5, 131072
bytes, linear)
[    0.119720] Mountpoint-cache hash table entries: 16384 (order: 5,
131072 bytes, linear)
[    0.120196] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.120238] process: using mwait in idle threads
[    0.120242] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.120243] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.120247] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.120249] Spectre V2 : Mitigation: Full generic retpoline
[    0.120250] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    0.120251] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.120253] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.120254] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.120255] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl and seccomp
[    0.120256] SMT: disabled
[    0.120264] SRBDS: Mitigation: Microcode
[    0.120265] MDS: Mitigation: Clear CPU buffers
[    0.120578] Freeing SMP alternatives memory: 32K
[    0.125169] smpboot: CPU0: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
(family: 0x6, model: 0x8e, stepping: 0xa)
[    0.125457] Performance Events: PEBS fmt3+, Skylake events, 32-deep
LBR, full-width counters, Intel PMU driver.
[    0.125521] ... version:                4
[    0.125522] ... bit width:              48
[    0.125523] ... generic registers:      4
[    0.125524] ... value mask:             0000ffffffffffff
[    0.125525] ... max period:             00007fffffffffff
[    0.125526] ... fixed-purpose events:   3
[    0.125527] ... event mask:             000000070000000f
[    0.125614] rcu: Hierarchical SRCU implementation.
[    0.126834] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.126998] smp: Bringing up secondary CPUs ...
[    0.127160] x86: Booting SMP configuration:
[    0.127162] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.153669] smp: Brought up 1 node, 4 CPUs
[    0.153671] smpboot: Max logical packages: 2
[    0.153675] smpboot: Total of 4 processors activated (14400.00 BogoMIPS)
[    0.165647] node 0 deferred pages initialised in 12ms
[    0.169167] devtmpfs: initialized
[    0.169167] x86/mm: Memory block size: 128MB
[    0.170553] PM: Registering ACPI NVS region [mem
0xa077c000-0xa077cfff] (4096 bytes)
[    0.170553] PM: Registering ACPI NVS region [mem
0xab724000-0xab799fff] (483328 bytes)
[    0.170553] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.170553] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.170553] pinctrl core: initialized pinctrl subsystem
[    0.170553] NET: Registered protocol family 16
[    0.170553] audit: initializing netlink subsys (disabled)
[    0.170553] audit: type=2000 audit(1610082011.080:1):
state=initialized audit_enabled=0 res=1
[    0.170553] thermal_sys: Registered thermal governor 'fair_share'
[    0.170553] thermal_sys: Registered thermal governor 'bang_bang'
[    0.170553] thermal_sys: Registered thermal governor 'step_wise'
[    0.170553] thermal_sys: Registered thermal governor 'user_space'
[    0.170553] cpuidle: using governor ladder
[    0.170553] cpuidle: using governor menu
[    0.170553] Simple Boot Flag at 0x47 set to 0x1
[    0.170553] ACPI: bus type PCI registered
[    0.170553] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.170553] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.170553] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.170553] PCI: Using configuration type 1 for base access
[    0.173028] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.175142] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.175142] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.413680] ACPI: Added _OSI(Module Device)
[    0.413680] ACPI: Added _OSI(Processor Device)
[    0.413680] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.413680] ACPI: Added _OSI(Processor Aggregator Device)
[    0.413680] ACPI: Added _OSI(Linux-Dell-Video)
[    0.413680] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.413680] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.492497] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    0.494270] ACPI: EC: EC started
[    0.494271] ACPI: EC: interrupt blocked
[    0.496944] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.496945] ACPI: EC: Boot ECDT EC used to handle transactions
[    0.499292] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.522087] ACPI: Dynamic OEM Table Load:
[    0.522111] ACPI: SSDT 0xFFFF9EE3F6CBC800 00060D (v02 PmRef
Cpu0Ist  00003000 INTL 20160527)
[    0.524290] ACPI: \_PR_.PR00: _OSC native thermal LVT Acked
[    0.526091] ACPI: Dynamic OEM Table Load:
[    0.526102] ACPI: SSDT 0xFFFF9EE44747B400 0003FF (v02 PmRef
Cpu0Cst  00003001 INTL 20160527)
[    0.528854] ACPI: Dynamic OEM Table Load:
[    0.528868] ACPI: SSDT 0xFFFF9EE307762000 000D14 (v02 PmRef  ApIst
  00003000 INTL 20160527)
[    0.532131] ACPI: Dynamic OEM Table Load:
[    0.532140] ACPI: SSDT 0xFFFF9EE44747A400 00030A (v02 PmRef  ApCst
  00003000 INTL 20160527)
[    0.538616] ACPI: Interpreter enabled
[    0.538705] ACPI: (supports S0 S3 S4 S5)
[    0.538707] ACPI: Using IOAPIC for interrupt routing
[    0.538774] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.539895] ACPI: Enabled 8 GPEs in block 00 to 7F
[    0.547385] ACPI: Power Resource [PUBS] (on)
[    0.577049] ACPI: Power Resource [PC01] (on)
[    0.633040] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.633050] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    0.637416] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug
SHPCHotplug PME AER PCIeCapability LTR]
[    0.640911] PCI host bridge to bus 0000:00
[    0.640916] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.640918] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.640920] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.640921] pci_bus 0000:00: root bus resource [mem
0xaf800000-0xf7ffffff window]
[    0.640923] pci_bus 0000:00: root bus resource [mem
0xfd000000-0xfe7fffff window]
[    0.640925] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.640946] pci 0000:00:00.0: [8086:5914] type 00 class 0x060000
[    0.642341] pci 0000:00:02.0: [8086:5917] type 00 class 0x030000
[    0.642356] pci 0000:00:02.0: reg 0x10: [mem 0xf1000000-0xf1ffffff 64bit]
[    0.642365] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff
64bit pref]
[    0.642371] pci 0000:00:02.0: reg 0x20: [io  0xe000-0xe03f]
[    0.642399] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.643834] pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
[    0.643849] pci 0000:00:08.0: reg 0x10: [mem 0xf252a000-0xf252afff 64bit]
[    0.645288] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    0.645310] pci 0000:00:14.0: reg 0x10: [mem 0xf2500000-0xf250ffff 64bit]
[    0.645399] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.646945] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    0.646968] pci 0000:00:14.2: reg 0x10: [mem 0xf252b000-0xf252bfff 64bit]
[    0.648425] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    0.648451] pci 0000:00:16.0: reg 0x10: [mem 0xf252c000-0xf252cfff 64bit]
[    0.648542] pci 0000:00:16.0: PME# supported from D3hot
[    0.650032] pci 0000:00:17.0: [8086:9d03] type 00 class 0x010601
[    0.650050] pci 0000:00:17.0: reg 0x10: [mem 0xf2528000-0xf2529fff]
[    0.650059] pci 0000:00:17.0: reg 0x14: [mem 0xf252f000-0xf252f0ff]
[    0.650068] pci 0000:00:17.0: reg 0x18: [io  0xe080-0xe087]
[    0.650078] pci 0000:00:17.0: reg 0x1c: [io  0xe088-0xe08b]
[    0.650088] pci 0000:00:17.0: reg 0x20: [io  0xe060-0xe07f]
[    0.650098] pci 0000:00:17.0: reg 0x24: [mem 0xf252d000-0xf252d7ff]
[    0.650153] pci 0000:00:17.0: PME# supported from D3hot
[    0.651622] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400
[    0.651723] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.651746] pci 0000:00:1c.0: Intel SPT PCH root port ACS workaround enabled
[    0.653253] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    0.653356] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.653378] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[    0.654886] pci 0000:00:1d.0: [8086:9d18] type 01 class 0x060400
[    0.654992] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.655016] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[    0.656513] pci 0000:00:1d.2: [8086:9d1a] type 01 class 0x060400
[    0.656617] pci 0000:00:1d.2: PME# supported from D0 D3hot D3cold
[    0.656639] pci 0000:00:1d.2: Intel SPT PCH root port ACS workaround enabled
[    0.658129] pci 0000:00:1d.3: [8086:9d1b] type 01 class 0x060400
[    0.658235] pci 0000:00:1d.3: PME# supported from D0 D3hot D3cold
[    0.658260] pci 0000:00:1d.3: Intel SPT PCH root port ACS workaround enabled
[    0.659756] pci 0000:00:1f.0: [8086:9d4e] type 00 class 0x060100
[    0.661337] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    0.661354] pci 0000:00:1f.2: reg 0x10: [mem 0xf2524000-0xf2527fff]
[    0.662856] pci 0000:00:1f.3: [8086:9d71] type 00 class 0x040300
[    0.662885] pci 0000:00:1f.3: reg 0x10: [mem 0xf2520000-0xf2523fff 64bit]
[    0.662926] pci 0000:00:1f.3: reg 0x20: [mem 0xf2510000-0xf251ffff 64bit]
[    0.662993] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.664477] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    0.664528] pci 0000:00:1f.4: reg 0x10: [mem 0xf252e000-0xf252e0ff 64bit]
[    0.664578] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.666181] pci 0000:02:00.0: [1002:699f] type 00 class 0x038000
[    0.666213] pci 0000:02:00.0: reg 0x10: [mem 0xe0000000-0xefffffff
64bit pref]
[    0.666233] pci 0000:02:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff
64bit pref]
[    0.666246] pci 0000:02:00.0: reg 0x20: [io  0xd000-0xd0ff]
[    0.666259] pci 0000:02:00.0: reg 0x24: [mem 0xf2400000-0xf243ffff]
[    0.666273] pci 0000:02:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    0.666284] pci 0000:02:00.0: enabling Extended Tags
[    0.666389] pci 0000:02:00.0: supports D1 D2
[    0.666462] pci 0000:02:00.0: 31.504 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x4 link at 0000:00:1c.0 (capable of 63.008
Gb/s with 8.0 GT/s PCIe x8 link)
[    0.666565] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.666568] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.666572] pci 0000:00:1c.0:   bridge window [mem 0xf2400000-0xf24fffff]
[    0.666578] pci 0000:00:1c.0:   bridge window [mem
0xe0000000-0xf01fffff 64bit pref]
[    0.666689] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.666735] pci 0000:03:00.0: reg 0x10: [io  0xc000-0xc0ff]
[    0.666803] pci 0000:03:00.0: reg 0x18: [mem 0xf2304000-0xf2304fff 64bit]
[    0.666841] pci 0000:03:00.0: reg 0x20: [mem 0xf2300000-0xf2303fff 64bit]
[    0.667041] pci 0000:03:00.0: supports D1 D2
[    0.667043] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.667344] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.667347] pci 0000:00:1c.4:   bridge window [io  0xc000-0xcfff]
[    0.667351] pci 0000:00:1c.4:   bridge window [mem 0xf2300000-0xf23fffff]
[    0.667885] pci 0000:04:00.0: [1cc4:5008] type 00 class 0x010802
[    0.668092] pci 0000:04:00.0: reg 0x10: [mem 0xf2200000-0xf2203fff 64bit]
[    0.670159] pci 0000:00:1d.0: PCI bridge to [bus 04]
[    0.670165] pci 0000:00:1d.0:   bridge window [mem 0xf2200000-0xf22fffff]
[    0.670286] pci 0000:05:00.0: [10ec:c821] type 00 class 0x028000
[    0.670327] pci 0000:05:00.0: reg 0x10: [io  0xb000-0xb0ff]
[    0.670397] pci 0000:05:00.0: reg 0x18: [mem 0xf2100000-0xf210ffff 64bit]
[    0.670648] pci 0000:05:00.0: supports D1 D2
[    0.670649] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.670962] pci 0000:00:1d.2: PCI bridge to [bus 05]
[    0.670966] pci 0000:00:1d.2:   bridge window [io  0xb000-0xbfff]
[    0.670969] pci 0000:00:1d.2:   bridge window [mem 0xf2100000-0xf21fffff]
[    0.671130] pci 0000:06:00.0: [1217:8621] type 00 class 0x080501
[    0.671158] pci 0000:06:00.0: reg 0x10: [mem 0xf2001000-0xf2001fff]
[    0.671172] pci 0000:06:00.0: reg 0x14: [mem 0xf2000000-0xf20007ff]
[    0.671358] pci 0000:06:00.0: PME# supported from D3hot D3cold
[    0.681177] pci 0000:00:1d.3: PCI bridge to [bus 06]
[    0.681182] pci 0000:00:1d.3:   bridge window [mem 0xf2000000-0xf20fffff]
[    0.686677] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.686751] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.686820] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.686888] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.686956] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.687023] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.687091] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.687158] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.687937] ACPI: EC: interrupt unblocked
[    0.687937] ACPI: EC: event unblocked
[    0.687949] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.687950] ACPI: EC: GPE=0x20
[    0.687952] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    0.687954] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle
transactions and events
[    0.688066] iommu: Default domain type: Translated
[    0.688084] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.688084] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    0.688084] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.688084] vgaarb: loaded
[    0.688084] EDAC MC: Ver: 3.0.0
[    0.688084] Registered efivars operations
[    0.689041] NetLabel: Initializing
[    0.689042] NetLabel:  domain hash size = 128
[    0.689042] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.689061] NetLabel:  unlabeled traffic allowed by default
[    0.689062] PCI: Using ACPI for IRQ routing
[    0.695501] PCI: pci_cache_line_size set to 64 bytes
[    0.696345] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.696347] e820: reserve RAM buffer [mem 0x0008c000-0x0008ffff]
[    0.696348] e820: reserve RAM buffer [mem 0xa077c000-0xa3ffffff]
[    0.696350] e820: reserve RAM buffer [mem 0xaa0e9000-0xabffffff]
[    0.696351] e820: reserve RAM buffer [mem 0xab800000-0xabffffff]
[    0.696352] e820: reserve RAM buffer [mem 0x24f800000-0x24fffffff]
[    0.697676] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.697681] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.699731] clocksource: Switched to clocksource tsc-early
[    0.712548] VFS: Disk quotas dquot_6.6.0
[    0.712574] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.712747] AppArmor: AppArmor Filesystem Enabled
[    0.712771] pnp: PnP ACPI init
[    0.713097] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.713100] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.713102] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.713104] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.713106] system 00:00: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.713108] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.713110] system 00:00: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.713118] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.713704] system 00:01: [io  0xff00-0xfffe] has been reserved
[    0.713709] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.714883] system 00:02: [io  0x0680-0x069f] has been reserved
[    0.714885] system 00:02: [io  0xffff] has been reserved
[    0.714887] system 00:02: [io  0xffff] has been reserved
[    0.714888] system 00:02: [io  0xffff] has been reserved
[    0.714890] system 00:02: [io  0x1800-0x18fe] has been reserved
[    0.714892] system 00:02: [io  0x164e-0x164f] has been reserved
[    0.714897] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.715074] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.715138] system 00:04: [io  0x1854-0x1857] has been reserved
[    0.715143] system 00:04: Plug and Play ACPI device, IDs INT3f0d
PNP0c02 (active)
[    0.715170] pnp 00:05: Plug and Play ACPI device, IDs LEN0071
PNP0303 (active)
[    0.715360] system 00:06: [io  0x1800-0x189f] could not be reserved
[    0.715362] system 00:06: [io  0x0800-0x087f] has been reserved
[    0.715364] system 00:06: [io  0x0880-0x08ff] has been reserved
[    0.715366] system 00:06: [io  0x0900-0x097f] has been reserved
[    0.715368] system 00:06: [io  0x0980-0x09ff] has been reserved
[    0.715370] system 00:06: [io  0x0a00-0x0a7f] has been reserved
[    0.715372] system 00:06: [io  0x0a80-0x0aff] has been reserved
[    0.715374] system 00:06: [io  0x0b00-0x0b7f] has been reserved
[    0.715375] system 00:06: [io  0x0b80-0x0bff] has been reserved
[    0.715377] system 00:06: [io  0x15e0-0x15ef] has been reserved
[    0.715379] system 00:06: [io  0x1600-0x167f] could not be reserved
[    0.715381] system 00:06: [io  0x1640-0x165f] could not be reserved
[    0.715384] system 00:06: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.715386] system 00:06: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.715388] system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.715389] system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.715391] system 00:06: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.715393] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.715395] system 00:06: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.715398] system 00:06: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.715403] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.715430] pnp 00:07: Plug and Play ACPI device, IDs LEN2055
PNP0f13 (active)
[    0.717679] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.717681] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.717683] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.717688] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.718656] system 00:09: [mem 0xfed10000-0xfed17fff] could not be reserved
[    0.718658] system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.718660] system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.718662] system 00:09: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.718664] system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.718666] system 00:09: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.718668] system 00:09: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.718670] system 00:09: [mem 0xff000000-0xffffffff] has been reserved
[    0.718672] system 00:09: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.718674] system 00:09: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.718679] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.719143] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.719146] system 00:0a: [mem 0x000c0000-0x000c3fff] could not be reserved
[    0.719147] system 00:0a: [mem 0x000c8000-0x000cbfff] could not be reserved
[    0.719149] system 00:0a: [mem 0x000d0000-0x000d3fff] could not be reserved
[    0.719151] system 00:0a: [mem 0x000d8000-0x000dbfff] could not be reserved
[    0.719153] system 00:0a: [mem 0x000e0000-0x000e3fff] could not be reserved
[    0.719154] system 00:0a: [mem 0x000e8000-0x000ebfff] could not be reserved
[    0.719156] system 00:0a: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.719158] system 00:0a: [mem 0x00100000-0xaf7fffff] could not be reserved
[    0.719160] system 00:0a: [mem 0xfec00000-0xfed3ffff] could not be reserved
[    0.719163] system 00:0a: [mem 0xfed4c000-0xffffffff] could not be reserved
[    0.719167] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.719322] pnp: PnP ACPI: found 11 devices
[    0.725752] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.725842] NET: Registered protocol family 2
[    0.726049] tcp_listen_portaddr_hash hash table entries: 4096
(order: 4, 65536 bytes, linear)
[    0.726118] TCP established hash table entries: 65536 (order: 7,
524288 bytes, linear)
[    0.726339] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes, linear)
[    0.726465] TCP: Hash tables configured (established 65536 bind 65536)
[    0.726521] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.726561] UDP-Lite hash table entries: 4096 (order: 5, 131072
bytes, linear)
[    0.726643] NET: Registered protocol family 1
[    0.726650] NET: Registered protocol family 44
[    0.726656] pci 0000:02:00.0: can't claim BAR 6 [mem
0xfffe0000-0xffffffff pref]: no compatible bridge window
[    0.726671] pci 0000:02:00.0: BAR 6: assigned [mem
0xf2440000-0xf245ffff pref]
[    0.726674] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.726678] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.726683] pci 0000:00:1c.0:   bridge window [mem 0xf2400000-0xf24fffff]
[    0.726687] pci 0000:00:1c.0:   bridge window [mem
0xe0000000-0xf01fffff 64bit pref]
[    0.726693] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.726695] pci 0000:00:1c.4:   bridge window [io  0xc000-0xcfff]
[    0.726700] pci 0000:00:1c.4:   bridge window [mem 0xf2300000-0xf23fffff]
[    0.726708] pci 0000:00:1d.0: PCI bridge to [bus 04]
[    0.726713] pci 0000:00:1d.0:   bridge window [mem 0xf2200000-0xf22fffff]
[    0.726721] pci 0000:00:1d.2: PCI bridge to [bus 05]
[    0.726723] pci 0000:00:1d.2:   bridge window [io  0xb000-0xbfff]
[    0.726728] pci 0000:00:1d.2:   bridge window [mem 0xf2100000-0xf21fffff]
[    0.726736] pci 0000:00:1d.3: PCI bridge to [bus 06]
[    0.726741] pci 0000:00:1d.3:   bridge window [mem 0xf2000000-0xf20fffff]
[    0.726750] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.726752] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.726754] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.726755] pci_bus 0000:00: resource 7 [mem 0xaf800000-0xf7ffffff window]
[    0.726757] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
[    0.726759] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.726760] pci_bus 0000:02: resource 1 [mem 0xf2400000-0xf24fffff]
[    0.726762] pci_bus 0000:02: resource 2 [mem 0xe0000000-0xf01fffff
64bit pref]
[    0.726764] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.726765] pci_bus 0000:03: resource 1 [mem 0xf2300000-0xf23fffff]
[    0.726767] pci_bus 0000:04: resource 1 [mem 0xf2200000-0xf22fffff]
[    0.726768] pci_bus 0000:05: resource 0 [io  0xb000-0xbfff]
[    0.726770] pci_bus 0000:05: resource 1 [mem 0xf2100000-0xf21fffff]
[    0.726771] pci_bus 0000:06: resource 1 [mem 0xf2000000-0xf20fffff]
[    0.726967] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.727864] PCI: CLS 0 bytes, default 64
[    0.727933] Trying to unpack rootfs image as initramfs...
[    2.550135] Freeing initrd memory: 65512K
[    2.550202] DMAR: No ATSR found
[    2.550276] DMAR: dmar0: Using Queued invalidation
[    2.550281] DMAR: dmar1: Using Queued invalidation
[    2.550641] pci 0000:00:00.0: Adding to iommu group 0
[    2.550662] pci 0000:00:02.0: Adding to iommu group 1
[    2.550676] pci 0000:00:08.0: Adding to iommu group 2
[    2.550702] pci 0000:00:14.0: Adding to iommu group 3
[    2.550714] pci 0000:00:14.2: Adding to iommu group 3
[    2.550733] pci 0000:00:16.0: Adding to iommu group 4
[    2.550747] pci 0000:00:17.0: Adding to iommu group 5
[    2.550767] pci 0000:00:1c.0: Adding to iommu group 6
[    2.550782] pci 0000:00:1c.4: Adding to iommu group 7
[    2.550797] pci 0000:00:1d.0: Adding to iommu group 8
[    2.550814] pci 0000:00:1d.2: Adding to iommu group 9
[    2.550830] pci 0000:00:1d.3: Adding to iommu group 10
[    2.550867] pci 0000:00:1f.0: Adding to iommu group 11
[    2.550881] pci 0000:00:1f.2: Adding to iommu group 11
[    2.550896] pci 0000:00:1f.3: Adding to iommu group 11
[    2.550911] pci 0000:00:1f.4: Adding to iommu group 11
[    2.550927] pci 0000:02:00.0: Adding to iommu group 12
[    2.550942] pci 0000:03:00.0: Adding to iommu group 13
[    2.550957] pci 0000:04:00.0: Adding to iommu group 14
[    2.550973] pci 0000:05:00.0: Adding to iommu group 15
[    2.550995] pci 0000:06:00.0: Adding to iommu group 16
[    2.555625] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    2.555627] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.555629] software IO TLB: mapped [mem 0x978ea000-0x9b8ea000] (64MB)
[    2.556323] Initialise system trusted keyrings
[    2.556348] Key type blacklist registered
[    2.556411] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    2.558284] zbud: loaded
[    2.558513] integrity: Platform Keyring initialized
[    2.558515] Key type asymmetric registered
[    2.558517] Asymmetric key parser 'x509' registered
[    2.558526] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 251)
[    2.558592] io scheduler mq-deadline registered
[    2.559098] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
[    2.559182] pcieport 0000:00:1c.0: AER: enabled with IRQ 122
[    2.559501] pcieport 0000:00:1c.4: PME: Signaling with IRQ 123
[    2.559570] pcieport 0000:00:1c.4: AER: enabled with IRQ 123
[    2.559882] pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
[    2.559947] pcieport 0000:00:1d.0: AER: enabled with IRQ 124
[    2.560262] pcieport 0000:00:1d.2: PME: Signaling with IRQ 125
[    2.560327] pcieport 0000:00:1d.2: AER: enabled with IRQ 125
[    2.560636] pcieport 0000:00:1d.3: PME: Signaling with IRQ 126
[    2.560699] pcieport 0000:00:1d.3: AER: enabled with IRQ 126
[    2.560826] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.560848] efifb: probing for efifb
[    2.560867] efifb: framebuffer at 0xd0000000, using 4160k, total 4160k
[    2.560868] efifb: mode is 1366x768x32, linelength=5504, pages=1
[    2.560869] efifb: scrolling: redraw
[    2.560871] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    2.560986] Console: switching to colour frame buffer device 170x48
[    2.565665] fb0: EFI VGA frame buffer device
[    2.565676] intel_idle: MWAIT substates: 0x11142120
[    2.565677] intel_idle: v0.5.1 model 0x8E
[    2.566088] intel_idle: Local APIC timer is reliable in all C-states
[    2.577961] thermal LNXTHERM:00: registered as thermal_zone0
[    2.577963] ACPI: Thermal Zone [THM0] (35 C)
[    2.578336] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.579712] Linux agpgart interface v0.103
[    2.579771] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    2.579772] AMD-Vi: AMD IOMMUv2 functionality not available on this system
[    2.580312] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU]
at 0x60,0x64 irq 1,12
[    2.592580] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.592585] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.592849] mousedev: PS/2 mouse device common for all mice
[    2.593184] rtc_cmos 00:03: RTC can wake from S4
[    2.593778] rtc_cmos 00:03: registered as rtc0
[    2.593940] rtc_cmos 00:03: setting system clock to
2021-01-08T05:00:13 UTC (1610082013)
[    2.593961] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes
nvram, hpet irqs
[    2.593974] intel_pstate: Intel P-state driver initializing
[    2.594372] intel_pstate: HWP enabled
[    2.594646] ledtrig-cpu: registered to indicate activity on CPUs
[    2.594901] NET: Registered protocol family 10
[    2.601002] Segment Routing with IPv6
[    2.601015] mip6: Mobile IPv6
[    2.601016] NET: Registered protocol family 17
[    2.601199] mpls_gso: MPLS GSO support
[    2.601577] microcode: sig=0x806ea, pf=0x80, revision=0xe0
[    2.601632] microcode: Microcode Update Driver: v2.2.
[    2.601634] IPI shorthand broadcast: enabled
[    2.601640] sched_clock: Marking stable (2600558474,
941286)->(2617850420, -16350660)
[    2.601879] registered taskstats version 1
[    2.601881] Loading compiled-in X.509 certificates
[    2.602379] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
[    2.626648] Loaded X.509 cert 'Debian Secure Boot CA:
6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[    2.626664] Loaded X.509 cert 'Debian Secure Boot Signer 2020: 00b55eb3b9'
[    2.626677] zswap: loaded using pool lzo/zbud
[    2.626998] Key type ._fscrypt registered
[    2.626999] Key type .fscrypt registered
[    2.626999] Key type fscrypt-provisioning registered
[    2.627050] AppArmor: AppArmor sha1 policy hashing enabled
[    2.628135] integrity: Loading X.509 certificate: UEFI:db
[    2.628153] integrity: Loaded X.509 cert 'Lenovo Ltd.: ThinkPad
Product CA 2012: 838b1f54c1550463f45f98700640f11069265949'
[    2.628153] integrity: Loading X.509 certificate: UEFI:db
[    2.628166] integrity: Loaded X.509 cert 'Lenovo(Beijing) Ltd.:
ICD-CDC -DB: cf21a31053abf166e8568a3291e019506efea4a8'
[    2.628166] integrity: Loading X.509 certificate: UEFI:db
[    2.628178] integrity: Loaded X.509 cert 'Lenovo UEFI CA 2014:
4b91a68732eaefdd2c8ffffc6b027ec3449e9c8f'
[    2.628179] integrity: Loading X.509 certificate: UEFI:db
[    2.628200] integrity: Loaded X.509 cert 'Microsoft Corporation
UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    2.628200] integrity: Loading X.509 certificate: UEFI:db
[    2.628214] integrity: Loaded X.509 cert 'Microsoft Windows
Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    2.630889] Freeing unused kernel image (initmem) memory: 1636K
[    2.653442] Write protecting the kernel read-only data: 18432k
[    2.653993] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    2.654189] Freeing unused kernel image (rodata/data gap) memory: 288K
[    2.710206] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.710207] x86/mm: Checking user space page tables
[    2.752244] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.752248] Run /init as init process
[    2.752248]   with arguments:
[    2.752249]     /init
[    2.752249]     splash
[    2.752250]   with environment:
[    2.752250]     HOME=/
[    2.752250]     TERM=linux
[    2.752250]     BOOT_IMAGE=/vmlinuz-5.9.0-5-amd64
[    2.800916] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    2.811339] acpi PNP0C14:02: duplicate WMI GUID
05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on
PNP0C14:01)
[    2.811407] acpi PNP0C14:03: duplicate WMI GUID
05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on
PNP0C14:01)
[    2.813044] ACPI: Sleep Button [SLPB]
[    2.813077] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input3
[    2.813098] ACPI: Lid Switch [LID]
[    2.813122] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[    2.813143] ACPI: Power Button [PWRF]
[    2.830231] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    2.830376] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    2.830412] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    2.831412] i2c i2c-0: 2/2 memory slots populated (from DMI)
[    2.831720] i2c i2c-0: Successfully instantiated SPD at 0x50
[    2.832113] SCSI subsystem initialized
[    2.835842] sdhci: Secure Digital Host Controller Interface driver
[    2.835843] sdhci: Copyright(c) Pierre Ossman
[    2.839467] sdhci-pci 0000:06:00.0: SDHCI controller found
[1217:8621] (rev 1)
[    2.839545] sdhci-pci 0000:06:00.0: enabling device (0000 -> 0002)
[    2.844857] mmc0: SDHCI controller on PCI [0000:06:00.0] using ADMA
[    2.848108] ACPI: bus type USB registered
[    2.848123] usbcore: registered new interface driver usbfs
[    2.848127] usbcore: registered new interface driver hub
[    2.848150] usbcore: registered new device driver usb
[    2.849896] nvme nvme0: pci function 0000:04:00.0
[    2.853744] libphy: r8169: probed
[    2.853883] r8169 0000:03:00.0 eth0: RTL8168gu/8111gu,
98:fa:9b:55:72:ab, XID 509, IRQ 128
[    2.853884] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194
bytes, tx checksumming: ko]
[    2.857785] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.857790] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 1
[    2.858966] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci
version 0x100 quirks 0x0000000081109810
[    2.859086] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    2.861437] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.09
[    2.861438] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.861439] usb usb1: Product: xHCI Host Controller
[    2.861440] usb usb1: Manufacturer: Linux 5.9.0-5-amd64 xhci-hcd
[    2.861440] usb usb1: SerialNumber: 0000:00:14.0
[    2.861530] hub 1-0:1.0: USB hub found
[    2.861547] hub 1-0:1.0: 12 ports detected
[    2.862439] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.862441] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    2.862443] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.862467] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.09
[    2.862468] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.862469] usb usb2: Product: xHCI Host Controller
[    2.862469] usb usb2: Manufacturer: Linux 5.9.0-5-amd64 xhci-hcd
[    2.862470] usb usb2: SerialNumber: 0000:00:14.0
[    2.862510] libata version 3.00 loaded.
[    2.865293] ahci 0000:00:17.0: version 3.0
[    2.865468] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6
Gbps 0x1 impl SATA mode
[    2.865469] ahci 0000:00:17.0: flags: 64bit ncq led clo only pio
slum part deso sadm sds apst
[    2.865666] hub 2-0:1.0: USB hub found
[    2.865676] hub 2-0:1.0: 6 ports detected
[    2.866004] usb: port power management may be unreliable
[    2.866296] scsi host0: ahci
[    2.866482] scsi host1: ahci
[    2.866516] ata1: SATA max UDMA/133 abar m2048@0xf252d000 port
0xf252d100 irq 131
[    2.866517] ata2: DUMMY
[    2.871235] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    2.882492] nvme nvme0: 8/0/0 default/read/poll queues
[    2.890483]  nvme0n1: p1 p2 p3 p4 p5 p6 p7
[    2.946830] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    2.946832] checking generic (d0000000 410000) vs hw (f1000000 1000000)
[    2.946833] checking generic (d0000000 410000) vs hw (d0000000 10000000)
[    2.946833] fb0: switching to inteldrmfb from EFI VGA
[    2.946928] Console: switching to colour dummy device 80x25
[    2.946947] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.949339] i915 0000:00:02.0: vgaarb: changed VGA decodes:
olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.949383] i915 0000:00:02.0: firmware: direct-loading firmware
i915/kbl_dmc_ver1_04.bin
[    2.949788] i915 0000:00:02.0: [drm] Finished loading DMC firmware
i915/kbl_dmc_ver1_04.bin (v1.4)
[    2.963359] battery: ACPI: Battery Slot [BAT0] (battery present)
[    3.039735] [drm] amdgpu kernel modesetting enabled.
[    3.039752] vga_switcheroo: detected switching method
\_SB_.PCI0.GFX0.ATPX handle
[    3.039778] ATPX version 1, functions 0x00000033
[    3.039817] ATPX Hybrid Graphics
[    3.039854] CRAT table not found
[    3.039855] Virtual CRAT table created for CPU
[    3.039863] amdgpu: Topology: Add CPU node
[    3.040025] [drm] initializing kernel modesetting (POLARIS12
0x1002:0x699F 0x17AA:0x5069 0xC0).
[    3.040027] amdgpu 0000:02:00.0: amdgpu: Trusted Memory Zone (TMZ)
feature not supported
[    3.040035] [drm] register mmio base: 0xF2400000
[    3.040035] [drm] register mmio size: 262144
[    3.040037] [drm] PCIE atomic ops is not supported
[    3.040042] [drm] add ip block number 0 <vi_common>
[    3.040043] [drm] add ip block number 1 <gmc_v8_0>
[    3.040044] [drm] add ip block number 2 <tonga_ih>
[    3.040044] [drm] add ip block number 3 <gfx_v8_0>
[    3.040045] [drm] add ip block number 4 <sdma_v3_0>
[    3.040046] [drm] add ip block number 5 <powerplay>
[    3.040046] [drm] add ip block number 6 <dm>
[    3.040046] [drm] add ip block number 7 <uvd_v6_0>
[    3.040047] [drm] add ip block number 8 <vce_v3_0>
[    3.040049] kfd kfd: skipped device 1002:699f, PCI rejects atomics
[    3.066715] ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field
[TBF3] at bit offset/length 262144/32768 exceeds size of target Buffer
(262144 bits) (20200717/dsopcode-198)
[    3.066721] ACPI Error: Aborting method \_SB.PCI0.GFX0.GETB due to
previous error (AE_AML_BUFFER_LIMIT) (20200717/psparse-529)
[    3.066726] ACPI Error: Aborting method \_SB.PCI0.GFX0.ATRM due to
previous error (AE_AML_BUFFER_LIMIT) (20200717/psparse-529)
[    3.066730] failed to evaluate ATRM got AE_AML_BUFFER_LIMIT
[    3.066731] amdgpu: ATOM BIOS: BR61655.001
[    3.066746] [drm] UVD is enabled in VM mode
[    3.066746] [drm] UVD ENC is enabled in VM mode
[    3.066749] [drm] VCE enabled in VM mode
[    3.066760] [drm] GPU posting now...
[    3.083629] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
fragment size is 9-bit
[    3.083663] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_mc.bin
[    3.083673] amdgpu 0000:02:00.0: amdgpu: VRAM: 2048M
0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
[    3.083674] amdgpu 0000:02:00.0: amdgpu: GART: 256M
0x000000FF00000000 - 0x000000FF0FFFFFFF
[    3.083685] [drm] Detected VRAM RAM=2048M, BAR=256M
[    3.083685] [drm] RAM width 64bits GDDR5
[    3.083827] [TTM] Zone  kernel: Available graphics memory: 4024358 KiB
[    3.083827] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[    3.083828] [TTM] Initializing pool allocator
[    3.083831] [TTM] Initializing DMA pool allocator
[    3.083852] [drm] amdgpu: 2048M of VRAM memory ready
[    3.083854] [drm] amdgpu: 3072M of GTT memory ready.
[    3.083861] [drm] GART: num cpu pages 65536, num gpu pages 65536
[    3.084583] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[    3.084664] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_pfp_2.bin
[    3.084675] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_me_2.bin
[    3.084684] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_ce_2.bin
[    3.084685] [drm] Chained IB support enabled!
[    3.084694] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_rlc.bin
[    3.084745] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_mec_2.bin
[    3.084796] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_mec2_2.bin
[    3.086368] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_sdma.bin
[    3.086378] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_sdma1.bin
[    3.086498] amdgpu: hwmgr_sw_init smu backed is polaris10_smu
[    3.086576] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_uvd.bin
[    3.086578] [drm] Found UVD firmware Version: 1.130 Family ID: 16
[    3.088579] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_vce.bin
[    3.088581] [drm] Found VCE firmware Version: 53.26 Binary ID: 3
[    3.089539] amdgpu 0000:02:00.0: firmware: direct-loading firmware
amdgpu/polaris12_smc.bin
[    3.168453] [drm] DM_PPLIB: values for Engine clock
[    3.168454] [drm] DM_PPLIB: 214000
[    3.168455] [drm] DM_PPLIB: 547000
[    3.168455] [drm] DM_PPLIB: 786000
[    3.168455] [drm] DM_PPLIB: 902000
[    3.168456] [drm] DM_PPLIB: Validation clocks:
[    3.168456] [drm] DM_PPLIB:    engine_max_clock: 90200
[    3.168456] [drm] DM_PPLIB:    memory_max_clock: 150000
[    3.168457] [drm] DM_PPLIB:    level           : 8
[    3.168457] [drm] DM_PPLIB: values for Memory clock
[    3.168458] [drm] DM_PPLIB: 300000
[    3.168458] [drm] DM_PPLIB: 625000
[    3.168458] [drm] DM_PPLIB: 1500000
[    3.168459] [drm] DM_PPLIB: Validation clocks:
[    3.168459] [drm] DM_PPLIB:    engine_max_clock: 90200
[    3.168459] [drm] DM_PPLIB:    memory_max_clock: 150000
[    3.168459] [drm] DM_PPLIB:    level           : 8
[    3.168473] [drm] Display Core initialized with v3.2.95!
[    3.197028] usb 1-3: new low-speed USB device number 2 using xhci_hcd
[    3.215923] [drm] UVD and UVD ENC initialized successfully.
[    3.249076] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    3.325869] [drm] VCE initialized successfully.
[    3.325872] amdgpu 0000:02:00.0: amdgpu: SE 2, SH per SE 1, CU per
SH 5, active_cu_number 10
[    3.328798] [drm] Initialized amdgpu 3.39.0 20150101 for
0000:02:00.0 on minor 1
[    3.350938] usb 1-3: New USB device found, idVendor=17ef,
idProduct=6050, bcdDevice= 0.09
[    3.350942] usb 1-3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    3.350944] usb 1-3: Product: Lenovo Precision USB Mouse
[    3.364513] hid: raw HID events driver (C) Jiri Kosina
[    3.373279] usbcore: registered new interface driver usbhid
[    3.373280] usbhid: USB HID core driver
[    3.376349] input: Lenovo Precision USB Mouse as
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:17EF:6050.0001/input/input6
[    3.376616] hid-generic 0003:17EF:6050.0001: input,hidraw0: USB HID
v1.11 Mouse [Lenovo Precision USB Mouse] on usb-0000:00:14.0-3/input0
[    3.477066] usb 1-5: new full-speed USB device number 3 using xhci_hcd
[    3.577102] tsc: Refined TSC clocksource calibration: 1799.999 MHz
[    3.577115] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x19f228ab7a2, max_idle_ns: 440795289252 ns
[    3.577197] clocksource: Switched to clocksource tsc
[    3.626550] usb 1-5: New USB device found, idVendor=0bda,
idProduct=c024, bcdDevice= 1.10
[    3.626554] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.626557] usb 1-5: Product: Bluetooth Radio
[    3.626559] usb 1-5: Manufacturer: Realtek
[    3.626561] usb 1-5: SerialNumber: 00e04c000001
[    3.757116] usb 1-6: new high-speed USB device number 4 using xhci_hcd
[    3.778138] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    3.778143] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
LOCK) filtered out
[    3.778146] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES)
filtered out
[    3.814985] ata1.00: ATA-10: ST500LM034-2GH17A, LXM3, max UDMA/100
[    3.814990] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    3.846736] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    3.846742] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE
LOCK) filtered out
[    3.846746] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES)
filtered out
[    3.883724] ata1.00: configured for UDMA/100
[    3.893272] scsi 0:0:0:0: Direct-Access     ATA
ST500LM034-2GH17 LXM3 PQ: 0 ANSI: 5
[    3.905746] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks:
(500 GB/466 GiB)
[    3.905750] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    3.905766] sd 0:0:0:0: [sda] Write Protect is off
[    3.905770] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.905797] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    3.938702] usb 1-6: New USB device found, idVendor=04f2,
idProduct=b604, bcdDevice= 0.27
[    3.938707] usb 1-6: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    3.938710] usb 1-6: Product: Integrated Camera
[    3.938712] usb 1-6: Manufacturer: Chicony Electronics Co.,Ltd.
[    3.938715] usb 1-6: SerialNumber: 0001
[    3.956469] psmouse serio1: synaptics: queried max coordinates: x
[..5676], y [..4690]
[    4.004558] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1162..]
[    4.004569] psmouse serio1: synaptics: Trying to set up SMBus access
[    4.103179]  sda: sda1 sda2 sda3
[    4.104637] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.161583] [drm] Initialized i915 1.6.0 20200715 for 0000:00:02.0 on minor 0
[    4.168223] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    4.169107] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
[    4.169382] vga_switcheroo: enabled
[    4.369360] fbcon: i915drmfb (fb0) is primary device
[    4.370801] Console: switching to colour frame buffer device 170x48
[    4.390906] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    5.951258] PM: Image not found (code -22)
[    6.041649] SGI XFS with ACLs, security attributes, realtime,
quota, no debug enabled
[    6.042965] XFS (nvme0n1p7): Mounting V5 Filesystem
[    6.055002] XFS (nvme0n1p7): Ending clean mount
[    6.097171] Not activating Mandatory Access Control as
/sbin/tomoyo-init does not exist.
[    6.194833] systemd[1]: Inserted module 'autofs4'
[    6.305163] systemd[1]: systemd 247.2-4 running in system mode.
(+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID
+ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
[    6.325545] systemd[1]: Detected architecture x86-64.
[    6.326191] systemd[1]: Set hostname to <debian>.
[    6.367152] systemd-sysv-generator[275]: SysV service
'/etc/init.d/hddtemp' lacks a native systemd unit file. Automatically
generating a unit file for compatibility. Please update package to
include a native systemd unit file, in order to make it more safe and
robust.
[    6.367441] systemd-sysv-generator[275]: SysV service
'/etc/init.d/exim4' lacks a native systemd unit file. Automatically
generating a unit file for compatibility. Please update package to
include a native systemd unit file, in order to make it more safe and
robust.
[    6.368562] systemd-sysv-generator[275]: SysV service
'/etc/init.d/uml-utilities' lacks a native systemd unit file.
Automatically generating a unit file for compatibility. Please update
package to include a native systemd unit file, in order to make it
more safe and robust.
[    6.374965] systemd-sysv-generator[275]: SysV service
'/etc/init.d/gdomap' lacks a native systemd unit file. Automatically
generating a unit file for compatibility. Please update package to
include a native systemd unit file, in order to make it more safe and
robust.
[    6.470942] systemd[1]:
/lib/systemd/system/plymouth-start.service:16: Unit configured to use
KillMode=none. This is unsafe, as it disables systemd's process
lifecycle management for the service. Please update your service to
use a safer KillMode=, such as 'mixed' or 'control-group'. Support for
KillMode=none is deprecated and will eventually be removed.
[    6.488003] systemd[1]: /etc/systemd/system/v2ray6.service:7:
Special user nobody configured, this is not safe!
[    6.488523] systemd[1]: /etc/systemd/system/v2ray.service:7:
Special user nobody configured, this is not safe!
[    6.490781] systemd[1]:
/lib/systemd/system/smartmontools.service:10: Standard output type
syslog is obsolete, automatically updating to journal. Please update
your unit file, and consider removing the setting altogether.
[    6.500018] systemd[1]: Queued start job for default target
Graphical Interface.
[    6.518652] systemd[1]: Created slice Virtual Machine and Container Slice.
[    6.519371] systemd[1]: Created slice system-getty.slice.
[    6.519773] systemd[1]: Created slice system-modprobe.slice.
[    6.520155] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    6.520495] systemd[1]: Created slice User and Session Slice.
[    6.520645] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[    6.520890] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[    6.520989] systemd[1]: Reached target User and Group Name Lookups.
[    6.521011] systemd[1]: Reached target Remote File Systems.
[    6.521061] systemd[1]: Reached target Slices.
[    6.521105] systemd[1]: Reached target Libvirt guests shutdown.
[    6.521208] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    6.521689] systemd[1]: Listening on Syslog Socket.
[    6.522147] systemd[1]: Listening on fsck to fsckd communication Socket.
[    6.522245] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    6.522486] systemd[1]: Listening on Journal Audit Socket.
[    6.522633] systemd[1]: Listening on Journal Socket (/dev/log).
[    6.522793] systemd[1]: Listening on Journal Socket.
[    6.523434] systemd[1]: Listening on udev Control Socket.
[    6.523598] systemd[1]: Listening on udev Kernel Socket.
[    6.524782] systemd[1]: Mounting Huge Pages File System...
[    6.526094] systemd[1]: Mounting POSIX Message Queue File System...
[    6.527471] systemd[1]: Mounting Kernel Debug File System...
[    6.528897] systemd[1]: Mounting Kernel Trace File System...
[    6.529230] systemd[1]: Finished Availability of block devices.
[    6.533018] systemd[1]: Starting Set the console keyboard layout...
[    6.534429] systemd[1]: Starting Create list of static device nodes
for the current kernel...
[    6.535766] systemd[1]: Starting Load Kernel Module configfs...
[    6.537019] systemd[1]: Starting Load Kernel Module drm...
[    6.539283] systemd[1]: Starting Load Kernel Module fuse...
[    6.539570] systemd[1]: Condition check resulted in Set Up
Additional Binary Formats being skipped.
[    6.542180] systemd[1]: Starting Journal Service...
[    6.543749] systemd[1]: Starting Load Kernel Modules...
[    6.545142] systemd[1]: Starting Remount Root and Kernel File Systems...
[    6.546770] systemd[1]: Starting Coldplug All udev Devices...
[    6.550089] systemd[1]: Mounted Huge Pages File System.
[    6.550243] systemd[1]: Mounted POSIX Message Queue File System.
[    6.550364] systemd[1]: Mounted Kernel Debug File System.
[    6.550480] systemd[1]: Mounted Kernel Trace File System.
[    6.550868] systemd[1]: Finished Create list of static device nodes
for the current kernel.
[    6.551194] systemd[1]: modprobe@configfs.service: Succeeded.
[    6.551417] systemd[1]: Finished Load Kernel Module configfs.
[    6.551697] systemd[1]: modprobe@drm.service: Succeeded.
[    6.551927] systemd[1]: Finished Load Kernel Module drm.
[    6.553415] systemd[1]: Mounting Kernel Configuration File System...
[    6.556300] systemd[1]: Mounted Kernel Configuration File System.
[    6.560777] systemd[1]: Finished Load Kernel Modules.
[    6.561309] fuse: init (API version 7.31)
[    6.561671] systemd[1]: Starting Apply Kernel Variables...
[    6.561879] systemd[1]: modprobe@fuse.service: Succeeded.
[    6.562066] systemd[1]: Finished Load Kernel Module fuse.
[    6.562960] systemd[1]: Mounting FUSE Control File System...
[    6.565382] systemd[1]: Mounted FUSE Control File System.
[    6.565757] xfs filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
[    6.567010] systemd[1]: Finished Remount Root and Kernel File Systems.
[    6.567974] systemd[1]: Condition check resulted in Rebuild
Hardware Database being skipped.
[    6.568006] systemd[1]: Condition check resulted in Platform
Persistent Storage Archival being skipped.
[    6.568667] systemd[1]: Starting Load/Save Random Seed...
[    6.569321] systemd[1]: Starting Create System Users...
[    6.576399] systemd[1]: Finished Apply Kernel Variables.
[    6.577607] systemd[1]: Finished Load/Save Random Seed.
[    6.577964] systemd[1]: Condition check resulted in First Boot
Complete being skipped.
[    6.580136] systemd[1]: Finished Create System Users.
[    6.581108] systemd[1]: Starting Create Static Device Nodes in /dev...
[    6.593861] systemd[1]: Finished Create Static Device Nodes in /dev.
[    6.595336] systemd[1]: Starting Rule-based Manager for Device
Events and Files...
[    6.615263] systemd[1]: Finished Set the console keyboard layout.
[    6.615379] systemd[1]: Reached target Local File Systems (Pre).
[    6.615407] systemd[1]: Condition check resulted in Virtual Machine
and Container Storage (Compatibility) being skipped.
[    6.615423] systemd[1]: Reached target Containers.
[    6.623659] systemd[1]: Started Journal Service.
[    6.786558] ACPI: AC Adapter [AC] (off-line)
[    6.853445] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.853463] Non-volatile memory driver v1.3
[    6.865707] XFS (nvme0n1p6): Mounting V5 Filesystem
[    6.895180] XFS (nvme0n1p6): Ending clean mount
[    6.896065] xfs filesystem being mounted at /boot supports
timestamps until 2038 (0x7fffffff)
[    6.905680] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    6.907086] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    6.907087] thinkpad_acpi: http://ibm-acpi.sf.net/
[    6.907087] thinkpad_acpi: ThinkPad BIOS R0PET67W (1.44 ), EC R0PHT67W
[    6.907088] thinkpad_acpi: Lenovo ThinkPad E580, model 20KSA024CD
[    6.907342] thinkpad_acpi: radio switch found; radios are enabled
[    6.907352] thinkpad_acpi: This ThinkPad has standard ACPI
backlight brightness control, supported by the ACPI video driver
[    6.907352] thinkpad_acpi: Disabling thinkpad-acpi brightness
events by default...
[    6.908662] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio
is blocked
[    6.913731] usb 1-5: USB disconnect, device number 3
[    6.916617] rmi4_smbus 0-002c: registering SMbus-connected sensor
[    6.964508] iTCO_vendor_support: vendor-support=0
[    6.966778] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    6.966934] cfg80211: Loaded X.509 cert 'benh@debian.org:
577e021cb980e0e820821ba7b54b4961b8b4fadf'
[    6.967083] cfg80211: Loaded X.509 cert 'romain.perier@gmail.com:
3abbc6ec146e09d1b6016ab9d6cf71dd233f0328'
[    6.967248] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[    6.967248] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.968943] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    6.969002] iTCO_wdt: Found a Intel PCH TCO device (Version=4,
TCOBASE=0x0400)
[    6.969116] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    6.969349] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
Synaptics, product: TM3383-032, fw id: 2664282
[    6.972335] platform regulatory.0: firmware: direct-loading
firmware regulatory.db
[    6.972718] platform regulatory.0: firmware: direct-loading
firmware regulatory.db.p7s
[    7.010073] EFI Variables Facility v0.08 2004-May-17
[    7.040821] input: Synaptics TM3383-032 as /devices/rmi4-00/input/input9
[    7.052090] serio: RMI4 PS/2 pass-through port at rmi4-00.fn03
[    7.083370] input: PC Speaker as /devices/platform/pcspkr/input/input11
[    7.087211] pstore: Using crash dump compression: deflate
[    7.087227] pstore: Registered efi as persistent store backend
[    7.088891] snd_hda_codec_conexant hdaudioC0D0: CX20753/4: BIOS auto-probing.
[    7.094478] snd_hda_codec_conexant hdaudioC0D0: autoconfig for
CX20753/4: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    7.094479] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[    7.094480] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1
(0x16/0x0/0x0/0x0/0x0)
[    7.094481] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
[    7.094481] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[    7.094482] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x1a
[    7.094483] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x19
[    7.129798] rtw_core: loading out-of-tree module taints kernel.
[    7.129883] rtw_core: module verification failed: signature and/or
required key missing - tainting kernel
[    7.134875] resource sanity check: requesting [mem
0xfed10000-0xfed15fff], which spans more than pnp 00:06 [mem
0xfed10000-0xfed13fff]
[    7.134881] caller snb_uncore_imc_init_box+0x78/0xc0 [intel_uncore]
mapping multiple BARs
[    7.135948] input: HDA Intel PCH Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    7.135989] input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    7.136195] input: HDA Intel PCH HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    7.136232] input: HDA Intel PCH HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    7.136267] input: HDA Intel PCH HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[    7.136303] input: HDA Intel PCH HDMI/DP,pcm=9 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[    7.136497] input: HDA Intel PCH HDMI/DP,pcm=10 as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[    7.142327] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters,
655360 ms ovfl timer
[    7.142328] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    7.142328] RAPL PMU: hw unit of domain package 2^-14 Joules
[    7.142328] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    7.142329] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    7.142329] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    7.143409] rtw_8821ce 0000:05:00.0: enabling device (0000 -> 0003)
[    7.149315] cryptd: max_cpu_qlen set to 1000
[    7.150273] rtw_8821ce 0000:05:00.0: firmware: direct-loading
firmware rtw88/rtw8821c_fw.bin
[    7.150276] rtw_8821ce 0000:05:00.0: Firmware version 24.5.0, H2C version 12
[    7.174889] thinkpad_acpi: battery 1 registered (start 95, stop 100)
[    7.174894] battery: new extension: ThinkPad Battery Extension
[    7.175276] input: ThinkPad Extra Buttons as
/devices/platform/thinkpad_acpi/input/input8
[    7.181295] psmouse serio2: trackpoint: Elan TrackPoint firmware:
0x11, buttons: 3/3
[    7.241322] input: TPPS/2 Elan TrackPoint as
/devices/rmi4-00/rmi4-00.fn03/serio2/input/input10
[    7.424322] intel_pmc_core intel_pmc_core.0:  initialized
[    7.453041] usb 1-5: new full-speed USB device number 5 using xhci_hcd
[    7.525931] rtw_8821ce 0000:05:00.0 wlp5s0: renamed from wlan0
[    7.566239] intel_rapl_common: Found RAPL domain package
[    7.566244] intel_rapl_common: Found RAPL domain core
[    7.566247] intel_rapl_common: Found RAPL domain uncore
[    7.566250] intel_rapl_common: Found RAPL domain dram
[    7.601973] usb 1-5: New USB device found, idVendor=0bda,
idProduct=c024, bcdDevice= 1.10
[    7.601979] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.601983] usb 1-5: Product: Bluetooth Radio
[    7.601986] usb 1-5: Manufacturer: Realtek
[    7.601988] usb 1-5: SerialNumber: 00e04c000001
[    7.980740] XFS (sda3): Mounting V5 Filesystem
[    7.997190] Adding 15625212k swap on /dev/sda2.  Priority:-2
extents:1 across:15625212k FS
[    8.125256] XFS (sda3): Ending clean mount
[    8.165546] xfs filesystem being mounted at /home supports
timestamps until 2038 (0x7fffffff)
[    8.258493] mc: Linux media interface: v0.10
[    8.283443] audit: type=1400 audit(1610082019.183:2):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="libvirtd" pid=794 comm="apparmor_parser"
[    8.283449] audit: type=1400 audit(1610082019.183:3):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="libvirtd//qemu_bridge_helper" pid=794 comm="apparmor_parser"
[    8.283870] audit: type=1400 audit(1610082019.183:4):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="virt-aa-helper" pid=793 comm="apparmor_parser"
[    8.284046] audit: type=1400 audit(1610082019.183:5):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/bin/man" pid=792 comm="apparmor_parser"
[    8.284051] audit: type=1400 audit(1610082019.183:6):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="man_filter" pid=792 comm="apparmor_parser"
[    8.284056] audit: type=1400 audit(1610082019.183:7):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="man_groff" pid=792 comm="apparmor_parser"
[    8.289194] audit: type=1400 audit(1610082019.187:8):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="lsb_release" pid=795 comm="apparmor_parser"
[    8.292036] videodev: Linux video capture interface: v2.00
[    8.294898] audit: type=1400 audit(1610082019.195:9):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/sbin/haveged" pid=800 comm="apparmor_parser"
[    8.306135] audit: type=1400 audit(1610082019.207:10):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="nvidia_modprobe" pid=799 comm="apparmor_parser"
[    8.306138] audit: type=1400 audit(1610082019.207:11):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="nvidia_modprobe//kmod" pid=799 comm="apparmor_parser"
[    8.411220] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[    8.434519] uvcvideo: Found UVC 1.00 device Integrated Camera (04f2:b604)
[    8.438311] input: Integrated Camera: Integrated C as
/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.0/input/input19
[    8.438362] usbcore: registered new interface driver uvcvideo
[    8.438363] USB Video Class driver (1.1.1)
[    8.486660] Bluetooth: Core ver 2.22
[    8.486704] NET: Registered protocol family 31
[    8.486705] Bluetooth: HCI device and connection manager initialized
[    8.486707] Bluetooth: HCI socket layer initialized
[    8.486709] Bluetooth: L2CAP socket layer initialized
[    8.486711] Bluetooth: SCO socket layer initialized
[    8.516153] usbcore: registered new interface driver btusb
[    8.517798] Bluetooth: hci0: RTL: examining hci_ver=08 hci_rev=000c
lmp_ver=08 lmp_subver=8821
[    8.518798] Bluetooth: hci0: RTL: rom_version status=0 version=1
[    8.518800] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[    8.526683] bluetooth hci0: firmware: direct-loading firmware
rtl_bt/rtl8821c_fw.bin
[    8.526732] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[    8.527929] bluetooth hci0: firmware: direct-loading firmware
rtl_bt/rtl8821c_config.bin
[    8.527934] Bluetooth: hci0: RTL: extension section signature mismatch
[    8.611456] r8169 0000:03:00.0: firmware: direct-loading firmware
rtl_nic/rtl8168g-3.fw
[    8.637056] Generic FE-GE Realtek PHY r8169-300:00: attached PHY
driver [Generic FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-300:00,
irq=IGNORE)
[    8.821230] r8169 0000:03:00.0 enp3s0: Link is Down
[    9.345883] rtw_8821ce 0000:05:00.0: start vif ea:dc:80:01:f1:93 on port 0
[    9.346442] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[    9.346491] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[    9.346494] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[    9.346495] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[    9.346497] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[    9.346508] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[    9.346529] pcieport 0000:00:1d.2: AER: device recovery failed
[    9.937811] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[    9.937843] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[    9.937845] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[    9.937847] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[    9.937848] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[    9.937876] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[    9.937899] pcieport 0000:00:1d.2: AER: device recovery failed
[    9.938222] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[    9.938235] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[    9.938237] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[    9.938239] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[    9.938240] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[    9.938245] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[    9.938255] pcieport 0000:00:1d.2: AER: device recovery failed
[    9.938691] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[    9.938724] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[    9.938726] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[    9.938728] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[    9.938729] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[    9.938736] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[    9.938747] pcieport 0000:00:1d.2: AER: device recovery failed
[   10.997505] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   10.997529] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   10.997537] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   10.997542] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   10.997548] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   10.997560] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   10.997630] pcieport 0000:00:1d.2: AER: device recovery failed
[   13.733173] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   13.733261] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   13.733264] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   13.733265] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   13.733266] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   13.733272] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   13.733293] pcieport 0000:00:1d.2: AER: device recovery failed
[   13.733294] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   13.733307] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   13.733308] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   13.733309] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   13.733310] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   13.733314] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   13.733319] pcieport 0000:00:1d.2: AER: device recovery failed
[   15.649808] rfkill: input handler disabled
[   18.509820] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   18.509908] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   18.509911] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   18.509912] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   18.509913] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   18.509952] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   18.509977] pcieport 0000:00:1d.2: AER: device recovery failed
[   18.510330] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   18.510402] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   18.510404] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   18.510405] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   18.510406] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   18.510452] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   18.510460] pcieport 0000:00:1d.2: AER: device recovery failed
[   18.510748] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   18.510845] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   18.510846] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   18.510847] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   18.510848] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   18.510877] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   18.510883] pcieport 0000:00:1d.2: AER: device recovery failed
[   19.549731] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   19.549755] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   19.549763] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   19.549769] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   19.549774] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   19.549785] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   19.549870] pcieport 0000:00:1d.2: AER: device recovery failed
[   22.237780] pcieport 0000:00:1d.2: AER: Uncorrected (Non-Fatal)
error received: 0000:00:1d.2
[   22.237795] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   22.237804] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   22.237810] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   22.237815] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   22.237827] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   22.237903] pcieport 0000:00:1d.2: AER: device recovery failed
[   22.237908] pcieport 0000:00:1d.2: AER: Uncorrected (Non-Fatal)
error received: 0000:00:1d.2
[   22.237921] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   22.237926] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   22.237931] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   22.237935] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   22.237945] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   22.237971] pcieport 0000:00:1d.2: AER: device recovery failed
[   22.238098] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   22.238117] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   22.238122] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   22.238126] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   22.238131] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   22.238140] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   22.238166] pcieport 0000:00:1d.2: AER: device recovery failed
[   25.510361] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   25.510434] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   25.510443] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   25.510449] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   25.510455] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   25.510486] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   25.510576] pcieport 0000:00:1d.2: AER: device recovery failed
[   25.510803] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   25.510860] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   25.510862] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   25.510864] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   25.510865] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   25.510889] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   25.510901] pcieport 0000:00:1d.2: AER: device recovery failed
[   25.511023] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   25.511075] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   25.511083] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   25.511089] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   25.511091] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   25.511118] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   25.511132] pcieport 0000:00:1d.2: AER: device recovery failed
[   26.557743] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   26.557766] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   26.557775] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   26.557780] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   26.557785] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   26.557795] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   26.557875] pcieport 0000:00:1d.2: AER: device recovery failed
[   29.245768] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   29.245829] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   29.245838] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   29.245843] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   29.245848] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   29.245889] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   29.245967] pcieport 0000:00:1d.2: AER: device recovery failed
[   29.245972] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   29.246005] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   29.246010] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   29.246014] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   29.246018] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   29.246109] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   29.246137] pcieport 0000:00:1d.2: AER: device recovery failed
[   35.510274] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   35.510344] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   35.510352] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   35.510358] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   35.510363] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   35.510398] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   35.510472] pcieport 0000:00:1d.2: AER: device recovery failed
[   35.510707] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   35.510770] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   35.510773] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   35.510774] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   35.510776] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   35.510801] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   35.510813] pcieport 0000:00:1d.2: AER: device recovery failed
[   35.510880] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   35.510926] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   35.510928] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   35.510929] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   35.510931] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   35.510949] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   35.510957] pcieport 0000:00:1d.2: AER: device recovery failed
[   36.549696] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   36.549722] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   36.549732] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   36.549737] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   36.549743] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   36.549755] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   36.549849] pcieport 0000:00:1d.2: AER: device recovery failed
[   39.237801] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   39.237877] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   39.237887] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   39.237893] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   39.237899] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   39.237939] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   39.238021] pcieport 0000:00:1d.2: AER: device recovery failed
[   39.238026] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   39.238065] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   39.238072] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   39.238077] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   39.238084] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   39.238172] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   39.238203] pcieport 0000:00:1d.2: AER: device recovery failed
[   49.510202] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   49.510259] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   49.510270] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   49.510276] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   49.510281] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   49.510317] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   49.510403] pcieport 0000:00:1d.2: AER: device recovery failed
[   49.510558] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   49.510589] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   49.510596] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   49.510602] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   49.510608] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   49.510635] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   49.510669] pcieport 0000:00:1d.2: AER: device recovery failed
[   49.510876] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   49.510922] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   49.510924] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   49.510925] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   49.510927] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   49.510939] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   49.510948] pcieport 0000:00:1d.2: AER: device recovery failed
[   50.549714] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   50.549742] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   50.549753] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   50.549760] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   50.549767] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   50.549780] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   50.549881] pcieport 0000:00:1d.2: AER: device recovery failed
[   53.237763] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   53.237815] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   53.237826] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   53.237847] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   53.237854] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   53.237869] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   53.237957] pcieport 0000:00:1d.2: AER: device recovery failed
[   53.237964] pcieport 0000:00:1d.2: AER: Multiple Uncorrected
(Non-Fatal) error received: 0000:00:1d.2
[   53.238002] pcieport 0000:00:1d.2: PCIe Bus Error:
severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer
ID)
[   53.238010] pcieport 0000:00:1d.2:   device [8086:9d1a] error
status/mask=00008000/00010000
[   53.238016] pcieport 0000:00:1d.2:    [15] CmpltAbrt              (First)
[   53.238022] pcieport 0000:00:1d.2: AER:   TLP Header: 00000000
00000000 00000000 00000000
[   53.238035] rtw_8821ce 0000:05:00.0: AER: can't recover (no
error_detected callback)
[   53.238062] pcieport 0000:00:1d.2: AER: device recovery failed
