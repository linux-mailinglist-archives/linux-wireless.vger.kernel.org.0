Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C642860FC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Oct 2020 16:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgJGOPB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Oct 2020 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgJGOPB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Oct 2020 10:15:01 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C5C061755
        for <linux-wireless@vger.kernel.org>; Wed,  7 Oct 2020 07:15:00 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id e20so1885734otj.11
        for <linux-wireless@vger.kernel.org>; Wed, 07 Oct 2020 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUSh2FqGeDFiYu6DXCCRlfNemvOIJvM8flYqm0p4+TE=;
        b=HvsgGQ1Zvl3WSEH1QLMrW4pq3LsznsqASH6uhRprwa2XsH3OKWy5PxESsENyhF4Jfd
         rSVV7z6PmxGK8zfibWO68x33g2wKt9KWILxAtu+Z7PTIp6HA7GShcPSME34pmVvyHAZN
         yUoRbrRtdF5epTLkvxoAUltNj4J1Tgas3u1duzIaB1eHyHYMGO9LU4WzPJY9GA9Di0wu
         v5EJBLlzpzvf/Kn0dJmONS6o2/HbI1kagPU83WBf8vPVSN7Vtliw1LNQ24KS+v+bIFIp
         RB/nb5TCpQavbkLZep8WRyY05DsTtn05UUAJsMjogBeWg9r/3QWX0RNsZ03V8Ued2nhr
         ng2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUSh2FqGeDFiYu6DXCCRlfNemvOIJvM8flYqm0p4+TE=;
        b=CLxooVWgzZtVMYzdvvk/tp7zoX66r373EjqJAckIBLQTarWYOGk6qOkTacANnxQcMl
         07Qe0u+V9ALI3od/cA+KFBkWvAV2wDx0T1eCY/aZxVmNQIxDkXOF9mymCzBwvtCpdtIv
         gQ/dQkC8onWE74m01jiel/pF1hsmtgrHhr2QlaDUEHStq6vnDH19FE8aiR0DBUKbgkfp
         Q/hTkId6Wj92Y4lnuc7jnxgyDeHquhGkYkK4QKNpAJsdnRzjrRNjuKrCUZIXs3WrYN89
         sso7kCPCRXSoMoWmT7jDp5/Jfyf4WZhPilNsh6zxzr9G8fIRwvpbwX4dRKjG+/klu8zX
         t4hw==
X-Gm-Message-State: AOAM530RM9J+BVpIDQDuoalOmZkOzfPyrJrYxGXIU8inZUQeKT8/1zTl
        hbT0/fDwz9hGCZ08odAWZ2HGCeYPYmP6myKK7WY=
X-Google-Smtp-Source: ABdhPJx6WaMKm2MDR2JsfVT+BrZzNE5+TO8DbXo0ub1RiqsFMANRmanUUOzuUsnZBhP4gvvXhOZpx5XRehNN7nfNufM=
X-Received: by 2002:a9d:491:: with SMTP id 17mr2050421otm.338.1602080099456;
 Wed, 07 Oct 2020 07:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANBg+yz2az1o9u7RDD6jwXCs=08u7izbmUOnkKJc2tnOQQCdog@mail.gmail.com>
 <97d78a81-b4fb-be83-5cb9-fa69575758c9@lwfinger.net> <CANBg+yy17Oj+WwvFRnC6PXJ4WWgwVm+O546F1Ju5xYHzu3kdnw@mail.gmail.com>
 <7b435755-a5e9-4cdb-05e0-c1aeea35bbf1@lwfinger.net> <CANBg+yyL5vSRxbL3WSzawS-CjOwE1jFJc0D+kBXFQJJsOMQJ5g@mail.gmail.com>
 <0ff3eede-a283-1f26-6ef5-be78842eb3a7@lwfinger.net>
In-Reply-To: <0ff3eede-a283-1f26-6ef5-be78842eb3a7@lwfinger.net>
From:   Cristian Llanos <cristian.llanos@gmail.com>
Date:   Wed, 7 Oct 2020 11:14:21 -0300
Message-ID: <CANBg+yxnetxyaRyeh0g0PRbk09DK_JmhrdX5F8LfH+Y9tHPaWg@mail.gmail.com>
Subject: Re: Error in driver for RTL8821CE
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yes it does. The last lines are strange, missing a country code?

===
[    0.000000] microcode: microcode updated early to revision 0x368,
date = 2019-04-23
[    0.000000] Linux version 5.4.0-48-generic (buildd@lcy01-amd64-023)
(gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)) #52~18.04.1-Ubuntu
SMP Thu Sep 10 12:50:22 UTC 2020 (Ubuntu 5.4.0-48.52~18.04.1-generic
5.4.60)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.4.0-48-generic
root=UUID=bda2f6db-fceb-496e-a089-e310c0f91638 ro quiet splash
vt.handoff=1
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000003efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000003f000-0x000000000003ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000040000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000007a7e7fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a7e8000-0x000000007a869fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a86a000-0x000000007a87bfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007a87c000-0x000000007b5acfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007b5ad000-0x000000007ba3cfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007ba3d000-0x000000007bc08fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bc09000-0x000000007bfc4fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007bfc5000-0x000000007bffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff980000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000017fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x746dd018-0x746ed057] usable ==> usable
[    0.000000] e820: update [mem 0x746dd018-0x746ed057] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem
0x0000000000000000-0x000000000003efff] usable
[    0.000000] reserve setup_data: [mem
0x000000000003f000-0x000000000003ffff] ACPI NVS
[    0.000000] reserve setup_data: [mem
0x0000000000040000-0x000000000009dfff] usable
[    0.000000] reserve setup_data: [mem
0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] reserve setup_data: [mem
0x0000000000100000-0x000000001fffffff] usable
[    0.000000] reserve setup_data: [mem
0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] reserve setup_data: [mem
0x0000000020200000-0x00000000746dd017] usable
[    0.000000] reserve setup_data: [mem
0x00000000746dd018-0x00000000746ed057] usable
[    0.000000] reserve setup_data: [mem
0x00000000746ed058-0x000000007a7e7fff] usable
[    0.000000] reserve setup_data: [mem
0x000000007a7e8000-0x000000007a869fff] reserved
[    0.000000] reserve setup_data: [mem
0x000000007a86a000-0x000000007a87bfff] ACPI data
[    0.000000] reserve setup_data: [mem
0x000000007a87c000-0x000000007b5acfff] ACPI NVS
[    0.000000] reserve setup_data: [mem
0x000000007b5ad000-0x000000007ba3cfff] reserved
[    0.000000] reserve setup_data: [mem
0x000000007ba3d000-0x000000007bc08fff] usable
[    0.000000] reserve setup_data: [mem
0x000000007bc09000-0x000000007bfc4fff] reserved
[    0.000000] reserve setup_data: [mem
0x000000007bfc5000-0x000000007bffffff] usable
[    0.000000] reserve setup_data: [mem
0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fed01000-0x00000000fed01fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fed08000-0x00000000fed08fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000ff980000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem
0x0000000100000000-0x000000017fffffff] usable
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi:  ESRT=0x7b9de218  ACPI=0x7a86d000  ACPI
2.0=0x7a86d000  SMBIOS=0x7b827d18  TPMEventLog=0x746ee018
[    0.000000] [Firmware Bug]: TPM Final Events table missing or invalid
[    0.000000] secureboot: Secure boot enabled
[    0.000000] Kernel is locked down from EFI Secure Boot mode; see
man kernel_lockdown.7
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. Inspiron 15-3552/0C004Y, BIOS 4.0.7 04/26/2016
[    0.000000] tsc: Detected 1600.000 MHz processor
[    0.000211] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000215] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000234] last_pfn = 0x180000 max_arch_pfn = 0x400000000
[    0.000241] MTRR default type: uncachable
[    0.000243] MTRR fixed ranges enabled:
[    0.000246]   00000-9FFFF write-back
[    0.000249]   A0000-FFFFF uncachable
[    0.000251] MTRR variable ranges enabled:
[    0.000254]   0 base 000000000 mask F80000000 write-back
[    0.000257]   1 base 07C800000 mask FFF800000 uncachable
[    0.000260]   2 base 07D000000 mask FFF000000 uncachable
[    0.000263]   3 base 07E000000 mask FFE000000 uncachable
[    0.000265]   4 base 100000000 mask F80000000 write-back
[    0.000267]   5 disabled
[    0.000269]   6 disabled
[    0.000270]   7 disabled
[    0.000381] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000511] total RAM covered: 4040M
[    0.001831] Found optimal setting for mtrr clean up
[    0.001834]  gran_size: 64K     chunk_size: 64M     num_reg: 5
lose cover RAM: 0G
[    0.001925] e820: update [mem 0x7c800000-0xffffffff] usable ==> reserved
[    0.001934] last_pfn = 0x7c000 max_arch_pfn = 0x400000000
[    0.020240] esrt: Reserving ESRT space from 0x000000007b9de218 to
0x000000007b9de250.
[    0.020265] check: Scanning 1 areas for low memory corruption
[    0.022454] secureboot: Secure boot enabled
[    0.022457] RAMDISK: [mem 0x3c77f000-0x3ee6efff]
[    0.022477] ACPI: Early table checksum verification disabled
[    0.022485] ACPI: RSDP 0x000000007A86D000 000024 (v02 DELL  )
[    0.022494] ACPI: XSDT 0x000000007A86D0A8 0000CC (v01 DELL   WN09
  01072009 AMI  00010013)
[    0.022511] ACPI: FACP 0x000000007A877620 00010C (v05 DELL   WN09
  01072009 AMI  00010013)
[    0.022523] ACPI BIOS Warning (bug): 32/64X length mismatch in
FADT/Gpe0Block: 128/32 (20190816/tbfadt-569)
[    0.022534] ACPI: DSDT 0x000000007A86D200 00A41B (v02 DELL   WN09
  01072009 INTL 20120913)
[    0.022543] ACPI: FACS 0x000000007B5AAE80 000040
[    0.022550] ACPI: APIC 0x000000007A877730 000084 (v03 DELL   WN09
  01072009 AMI  00010013)
[    0.022557] ACPI: FPDT 0x000000007A8777B8 000044 (v01 DELL   WN09
  01072009 AMI  00010013)
[    0.022565] ACPI: FIDT 0x000000007A877800 00009C (v01 DELL   WN09
  01072009 AMI  00010013)
[    0.022573] ACPI: MCFG 0x000000007A8778A0 00003C (v01 DELL   WN09
  01072009 MSFT 00000097)
[    0.022581] ACPI: BOOT 0x000000007A8778E0 000028 (v01 DELL   WN09
  01072009 AMI  00010013)
[    0.022588] ACPI: SLIC 0x000000007A877908 000176 (v01 ALWARE
ALIENWRE 01072009 AMI  00010013)
[    0.022596] ACPI: SLIC 0x000000007A877A80 000176 (v01 DELL   WN09
  01072009 AMI  00010013)
[    0.022604] ACPI: HPET 0x000000007A877BF8 000038 (v01 DELL   WN09
  01072009 AMI. 00000006)
[    0.022612] ACPI: SSDT 0x000000007A877C30 000763 (v01 PmRef  CpuPm
  00003000 INTL 20061109)
[    0.022620] ACPI: SSDT 0x000000007A878398 000290 (v01 PmRef
Cpu0Tst  00003000 INTL 20061109)
[    0.022628] ACPI: SSDT 0x000000007A878628 00017A (v01 PmRef  ApTst
  00003000 INTL 20061109)
[    0.022636] ACPI: UEFI 0x000000007A8787A8 000042 (v01 DELL   WN09
  00000000      00000000)
[    0.022646] ACPI: SSDT 0x000000007A8787F0 000427 (v01 Intel_
Tpm2Tabl 00001000 INTL 20061109)
[    0.022655] ACPI: TPM2 0x000000007A878C18 000034 (v03
  00000000      00000000)
[    0.022662] ACPI: MSDM 0x000000007A878C50 000055 (v03 DELL   WN09
  01072009 AMI  00010013)
[    0.022670] ACPI: LPIT 0x000000007A878CA8 000104 (v01 DELL   WN09
  00000005 MSFT 0100000D)
[    0.022678] ACPI: BGRT 0x000000007A878DB0 000038 (v01 DELL   WN09
  01072009 AMI  00010013)
[    0.022686] ACPI: CSRT 0x000000007A878DE8 00014C (v00 INTEL
LANFORDC 00000005 MSFT 0100000D)
[    0.022693] ACPI: SSDT 0x000000007A878F38 000545 (v01 CpuDpf
CpuDptf  00001000 INTL 20061109)
[    0.022702] ACPI: SSDT 0x000000007A879480 001ED7 (v01 DptfTb
DptfTab  00001000 INTL 20061109)
[    0.022726] ACPI: Local APIC address 0xfee00000
[    0.022998] No NUMA configuration found
[    0.023001] Faking a node at [mem 0x0000000000000000-0x000000017fffffff]
[    0.023025] NODE_DATA(0) allocated [mem 0x17ffd3000-0x17fffdfff]
[    0.023868] Zone ranges:
[    0.023871]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.023875]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.023879]   Normal   [mem 0x0000000100000000-0x000000017fffffff]
[    0.023882]   Device   empty
[    0.023886] Movable zone start for each node
[    0.023896] Early memory node ranges
[    0.023898]   node   0: [mem 0x0000000000001000-0x000000000003efff]
[    0.023901]   node   0: [mem 0x0000000000040000-0x000000000009dfff]
[    0.023903]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.023905]   node   0: [mem 0x0000000020200000-0x000000007a7e7fff]
[    0.023908]   node   0: [mem 0x000000007ba3d000-0x000000007bc08fff]
[    0.023910]   node   0: [mem 0x000000007bfc5000-0x000000007bffffff]
[    0.023912]   node   0: [mem 0x0000000100000000-0x000000017fffffff]
[    0.024398] Zeroed struct page in unavailable ranges: 22645 pages
[    0.024402] Initmem setup node 0 [mem 0x0000000000001000-0x000000017fffffff]
[    0.024407] On node 0 totalpages: 1025931
[    0.024411]   DMA zone: 64 pages used for memmap
[    0.024412]   DMA zone: 21 pages reserved
[    0.024416]   DMA zone: 3996 pages, LIFO batch:0
[    0.024573]   DMA32 zone: 7776 pages used for memmap
[    0.024575]   DMA32 zone: 497647 pages, LIFO batch:63
[    0.050210]   Normal zone: 8192 pages used for memmap
[    0.050212]   Normal zone: 524288 pages, LIFO batch:63
[    0.069159] Reserving Intel graphics memory at [mem 0x7ce00000-0x7edfffff]
[    0.069298] ACPI: PM-Timer IO Port: 0x408
[    0.069302] ACPI: Local APIC address 0xfee00000
[    0.069321] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.069323] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.069325] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.069327] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.069352] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-114
[    0.069359] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.069363] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.069367] ACPI: IRQ0 used by override.
[    0.069369] ACPI: IRQ9 used by override.
[    0.069375] Using ACPI (MADT) for SMP configuration information
[    0.069379] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.069403] e820: update [mem 0x78ef4000-0x78f21fff] usable ==> reserved
[    0.069428] TSC deadline timer available
[    0.069431] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.069503] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.069508] PM: Registered nosave memory: [mem 0x0003f000-0x0003ffff]
[    0.069512] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.069514] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.069518] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.069523] PM: Registered nosave memory: [mem 0x746dd000-0x746ddfff]
[    0.069528] PM: Registered nosave memory: [mem 0x746ed000-0x746edfff]
[    0.069532] PM: Registered nosave memory: [mem 0x78ef4000-0x78f21fff]
[    0.069537] PM: Registered nosave memory: [mem 0x7a7e8000-0x7a869fff]
[    0.069539] PM: Registered nosave memory: [mem 0x7a86a000-0x7a87bfff]
[    0.069540] PM: Registered nosave memory: [mem 0x7a87c000-0x7b5acfff]
[    0.069542] PM: Registered nosave memory: [mem 0x7b5ad000-0x7ba3cfff]
[    0.069547] PM: Registered nosave memory: [mem 0x7bc09000-0x7bfc4fff]
[    0.069552] PM: Registered nosave memory: [mem 0x7c000000-0x7cdfffff]
[    0.069553] PM: Registered nosave memory: [mem 0x7ce00000-0x7edfffff]
[    0.069555] PM: Registered nosave memory: [mem 0x7ee00000-0xe00f7fff]
[    0.069557] PM: Registered nosave memory: [mem 0xe00f8000-0xe00f8fff]
[    0.069558] PM: Registered nosave memory: [mem 0xe00f9000-0xfed00fff]
[    0.069560] PM: Registered nosave memory: [mem 0xfed01000-0xfed01fff]
[    0.069562] PM: Registered nosave memory: [mem 0xfed02000-0xfed07fff]
[    0.069563] PM: Registered nosave memory: [mem 0xfed08000-0xfed08fff]
[    0.069565] PM: Registered nosave memory: [mem 0xfed09000-0xff97ffff]
[    0.069567] PM: Registered nosave memory: [mem 0xff980000-0xffffffff]
[    0.069571] [mem 0x7ee00000-0xe00f7fff] available for PCI devices
[    0.069575] Booting paravirtualized kernel on bare hardware
[    0.069582] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.069604] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4
nr_cpu_ids:4 nr_node_ids:1
[    0.070614] percpu: Embedded 54 pages/cpu s184320 r8192 d28672 u524288
[    0.070636] pcpu-alloc: s184320 r8192 d28672 u524288 alloc=1*2097152
[    0.070639] pcpu-alloc: [0] 0 1 2 3
[    0.070739] Built 1 zonelists, mobility grouping on.  Total pages: 1009878
[    0.070741] Policy zone: Normal
[    0.070746] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-5.4.0-48-generic
root=UUID=bda2f6db-fceb-496e-a089-e310c0f91638 ro quiet splash
vt.handoff=1
[    0.072283] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.072976] Inode-cache hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.073067] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.095205] Calgary: detecting Calgary via BIOS EBDA area
[    0.095208] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.127921] Memory: 3796588K/4103724K available (14339K kernel
code, 2379K rwdata, 4928K rodata, 2704K init, 5020K bss, 307136K
reserved, 0K cma-reserved)
[    0.127937] random: get_random_u64 called from
__kmem_cache_create+0x41/0x550 with crng_init=0
[    0.128406] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.128448] Kernel/User page tables isolation: enabled
[    0.128487] ftrace: allocating 44229 entries in 173 pages
[    0.163969] rcu: Hierarchical RCU implementation.
[    0.163973] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[    0.163975]     Tasks RCU enabled.
[    0.163978] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.163979] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.173975] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
[    0.174536] random: crng done (trusting CPU's manufacturer)
[    0.174589] vt handoff: transparent VT on vt#1
[    0.174609] Console: colour dummy device 80x25
[    0.174618] printk: console [tty0] enabled
[    0.174679] ACPI: Core revision 20190816
[    0.175002] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484882848 ns
[    0.175032] APIC: Switch to symmetric I/O mode setup
[    0.176806] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.195037] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x171024fa93b, max_idle_ns: 440795253189 ns
[    0.195046] Calibrating delay loop (skipped), value calculated
using timer frequency.. 3200.00 BogoMIPS (lpj=6400000)
[    0.195052] pid_max: default: 32768 minimum: 301
[    0.204765] LSM: Security Framework initializing
[    0.204805] Yama: becoming mindful.
[    0.204891] AppArmor: AppArmor initialized
[    0.205009] Mount-cache hash table entries: 8192 (order: 4, 65536
bytes, linear)
[    0.205035] Mountpoint-cache hash table entries: 8192 (order: 4,
65536 bytes, linear)
[    0.205083] *** VALIDATE tmpfs ***
[    0.205509] *** VALIDATE proc ***
[    0.205684] *** VALIDATE cgroup1 ***
[    0.205688] *** VALIDATE cgroup2 ***
[    0.205817] process: using mwait in idle threads
[    0.205825] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.205829] Last level dTLB entries: 4KB 256, 2MB 16, 4MB 16, 1GB 0
[    0.205837] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.205840] Spectre V2 : Mitigation: Full generic retpoline
[    0.205842] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    0.205843] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.205847] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.205852] MDS: Mitigation: Clear CPU buffers
[    0.206202] Freeing SMP alternatives memory: 40K
[    0.209702] smpboot: CPU0: Intel(R) Pentium(R) CPU  N3700  @
1.60GHz (family: 0x6, model: 0x4c, stepping: 0x3)
[    0.210218] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont
events, 8-deep LBR, full-width counters, Intel PMU driver.
[    0.210232] ... version:                3
[    0.210234] ... bit width:              40
[    0.210235] ... generic registers:      2
[    0.210237] ... value mask:             000000ffffffffff
[    0.210239] ... max period:             0000007fffffffff
[    0.210240] ... fixed-purpose events:   3
[    0.210242] ... event mask:             0000000700000003
[    0.210359] rcu: Hierarchical SRCU implementation.
[    0.211040] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.211040] smp: Bringing up secondary CPUs ...
[    0.211040] x86: Booting SMP configuration:
[    0.211040] .... node  #0, CPUs:      #1 #2 #3
[    0.215623] smp: Brought up 1 node, 4 CPUs
[    0.215623] smpboot: Max logical packages: 1
[    0.215623] smpboot: Total of 4 processors activated (12800.00 BogoMIPS)
[    0.216324] devtmpfs: initialized
[    0.216324] x86/mm: Memory block size: 128MB
[    0.219235] PM: Registering ACPI NVS region [mem
0x0003f000-0x0003ffff] (4096 bytes)
[    0.219235] PM: Registering ACPI NVS region [mem
0x7a87c000-0x7b5acfff] (13832192 bytes)
[    0.219888] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.219888] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.219888] pinctrl core: initialized pinctrl subsystem
[    0.219888] PM: RTC time: 13:59:19, date: 2020-10-07
[    0.220040] NET: Registered protocol family 16
[    0.220313] audit: initializing netlink subsys (disabled)
[    0.220369] audit: type=2000 audit(1602079159.044:1):
state=initialized audit_enabled=0 res=1
[    0.220369] EISA bus registered
[    0.220369] cpuidle: using governor ladder
[    0.220369] cpuidle: using governor menu
[    0.220369] Simple Boot Flag at 0x47 set to 0x1
[    0.220369] ACPI: bus type PCI registered
[    0.220369] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.220369] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.220369] PCI: not using MMCONFIG
[    0.220369] PCI: Using configuration type 1 for base access
[    0.223238] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.227854] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.231355] ACPI: Added _OSI(Module Device)
[    0.231355] ACPI: Added _OSI(Processor Device)
[    0.231355] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.231355] ACPI: Added _OSI(Processor Aggregator Device)
[    0.231355] ACPI: Added _OSI(Linux-Dell-Video)
[    0.231355] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.231355] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.265092] ACPI: 7 ACPI AML tables successfully acquired and loaded
[    0.270876] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.285598] ACPI: Dynamic OEM Table Load:
[    0.285619] ACPI: SSDT 0xFFFF8E093B3CF000 0005D1 (v01 PmRef
Cpu0Ist  00003000 INTL 20061109)
[    0.289030] ACPI: Dynamic OEM Table Load:
[    0.289044] ACPI: SSDT 0xFFFF8E093AB35800 0003A5 (v01 PmRef
Cpu0Cst  00003001 INTL 20061109)
[    0.292431] ACPI: Dynamic OEM Table Load:
[    0.292445] ACPI: SSDT 0xFFFF8E093AB27000 00015F (v01 PmRef  ApIst
  00003000 INTL 20061109)
[    0.294638] ACPI: Dynamic OEM Table Load:
[    0.294650] ACPI: SSDT 0xFFFF8E093B3D8480 00008D (v01 PmRef  ApCst
  00003000 INTL 20061109)
[    0.301083] ACPI: Interpreter enabled
[    0.301156] ACPI: (supports S0 S3 S4 S5)
[    0.301159] ACPI: Using IOAPIC for interrupt routing
[    0.301305] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.305795] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved
in ACPI motherboard resources
[    0.305847] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.307227] ACPI: Enabled 8 GPEs in block 00 to 3F
[    0.313516] ACPI: Power Resource [USBC] (on)
[    0.344234] ACPI: Power Resource [FN00] (off)
[    0.346790] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.346808] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    0.348053] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug
SHPCHotplug PME AER PCIeCapability LTR]
[    0.349690] PCI host bridge to bus 0000:00
[    0.349697] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.349701] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
[    0.349706] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
[    0.349709] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.349712] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.349716] pci_bus 0000:00: root bus resource [mem
0x000c0000-0x000dffff window]
[    0.349719] pci_bus 0000:00: root bus resource [mem
0x000e0000-0x000fffff window]
[    0.349722] pci_bus 0000:00: root bus resource [mem
0x80000000-0xdfffffff window]
[    0.349726] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.349754] pci 0000:00:00.0: [8086:2280] type 00 class 0x060000
[    0.350225] pci 0000:00:02.0: [8086:22b1] type 00 class 0x030000
[    0.350255] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x90ffffff 64bit]
[    0.350269] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff
64bit pref]
[    0.350280] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.350316] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.350711] pci 0000:00:0b.0: [8086:22dc] type 00 class 0x118000
[    0.350736] pci 0000:00:0b.0: reg 0x10: [mem 0x9131f000-0x9131ffff 64bit]
[    0.351235] pci 0000:00:13.0: [8086:22a3] type 00 class 0x010601
[    0.351306] pci 0000:00:13.0: reg 0x20: [io  0xf060-0xf07f]
[    0.351319] pci 0000:00:13.0: reg 0x24: [mem 0x9131c000-0x9131c7ff]
[    0.351394] pci 0000:00:13.0: PME# supported from D3hot
[    0.351756] pci 0000:00:14.0: [8086:22b5] type 00 class 0x0c0330
[    0.351792] pci 0000:00:14.0: reg 0x10: [mem 0x91300000-0x9130ffff 64bit]
[    0.351899] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.352328] pci 0000:00:1a.0: [8086:2298] type 00 class 0x108000
[    0.352358] pci 0000:00:1a.0: reg 0x10: [mem 0x91100000-0x911fffff]
[    0.352371] pci 0000:00:1a.0: reg 0x14: [mem 0x91000000-0x910fffff]
[    0.352474] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.352832] pci 0000:00:1b.0: [8086:2284] type 00 class 0x040300
[    0.352872] pci 0000:00:1b.0: reg 0x10: [mem 0x91310000-0x91313fff 64bit]
[    0.352987] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.353342] pci 0000:00:1c.0: [8086:22c8] type 01 class 0x060400
[    0.353494] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.353929] pci 0000:00:1f.0: [8086:229c] type 00 class 0x060100
[    0.354422] pci 0000:00:1f.3: [8086:2292] type 00 class 0x0c0500
[    0.354495] pci 0000:00:1f.3: reg 0x10: [mem 0x91318000-0x9131801f]
[    0.354612] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    0.355277] pci 0000:01:00.0: [168c:0036] type 00 class 0x028000
[    0.355321] pci 0000:01:00.0: reg 0x10: [mem 0x91200000-0x9127ffff 64bit]
[    0.355376] pci 0000:01:00.0: reg 0x30: [mem 0x91280000-0x9128ffff pref]
[    0.355497] pci 0000:01:00.0: supports D1 D2
[    0.355501] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.355777] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.355789] pci 0000:00:1c.0:   bridge window [mem 0x91200000-0x912fffff]
[    0.464132] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.464434] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.464734] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.465029] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.465327] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.465624] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.465926] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.466228] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.472883] iommu: Default domain type: Translated
[    0.475289] SCSI subsystem initialized
[    0.475327] libata version 3.00 loaded.
[    0.475327] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.475327] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    0.475327] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.475327] vgaarb: loaded
[    0.475327] ACPI: bus type USB registered
[    0.475327] usbcore: registered new interface driver usbfs
[    0.475327] usbcore: registered new interface driver hub
[    0.475327] usbcore: registered new device driver usb
[    0.498206] pps_core: LinuxPPS API ver. 1 registered
[    0.498209] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.498218] PTP clock support registered
[    0.498276] EDAC MC: Ver: 3.0.0
[    0.499085] Registered efivars operations
[    0.499223] PCI: Using ACPI for IRQ routing
[    0.510433] PCI: pci_cache_line_size set to 64 bytes
[    0.510505] e820: reserve RAM buffer [mem 0x0003f000-0x0003ffff]
[    0.510509] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.510512] e820: reserve RAM buffer [mem 0x746dd018-0x77ffffff]
[    0.510514] e820: reserve RAM buffer [mem 0x78ef4000-0x7bffffff]
[    0.510516] e820: reserve RAM buffer [mem 0x7a7e8000-0x7bffffff]
[    0.510519] e820: reserve RAM buffer [mem 0x7bc09000-0x7bffffff]
[    0.510821] NetLabel: Initializing
[    0.510824] NetLabel:  domain hash size = 128
[    0.510825] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.510865] NetLabel:  unlabeled traffic allowed by default
[    0.512638] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.512648] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.514727] clocksource: Switched to clocksource tsc-early
[    0.555638] *** VALIDATE bpf ***
[    0.555829] VFS: Disk quotas dquot_6.6.0
[    0.555883] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.555955] *** VALIDATE ramfs ***
[    0.555972] *** VALIDATE hugetlbfs ***
[    0.556225] AppArmor: AppArmor Filesystem Enabled
[    0.556314] pnp: PnP ACPI init
[    0.556480] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.557097] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.557102] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.557106] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.557122] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.557254] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.557416] pnp 00:03: Plug and Play ACPI device, IDs SYN060c
PNP0f13 (active)
[    0.557565] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.557579] system 00:04: [mem 0xfe900000-0xfe902fff] has been reserved
[    0.557591] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.560640] system 00:05: [mem 0x9131d000-0x9131dfff] has been reserved
[    0.560646] system 00:05: [mem 0x9131b000-0x9131bfff] has been reserved
[    0.560650] system 00:05: [mem 0x91319000-0x91319fff] has been reserved
[    0.560663] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.560805] system 00:06: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.560809] system 00:06: [mem 0xfea00000-0xfeafffff] has been reserved
[    0.560815] system 00:06: [mem 0xfed01000-0xfed01fff] has been reserved
[    0.560819] system 00:06: [mem 0xfed03000-0xfed03fff] has been reserved
[    0.560822] system 00:06: [mem 0xfed06000-0xfed06fff] has been reserved
[    0.560827] system 00:06: [mem 0xfed08000-0xfed09fff] could not be reserved
[    0.560831] system 00:06: [mem 0xfed80000-0xfedbffff] could not be reserved
[    0.560834] system 00:06: [mem 0xfed1c000-0xfed1cfff] has been reserved
[    0.560838] system 00:06: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.560852] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.571568] pnp: PnP ACPI: found 7 devices
[    0.577431] thermal_sys: Registered thermal governor 'fair_share'
[    0.577434] thermal_sys: Registered thermal governor 'bang_bang'
[    0.577436] thermal_sys: Registered thermal governor 'step_wise'
[    0.577438] thermal_sys: Registered thermal governor 'user_space'
[    0.577440] thermal_sys: Registered thermal governor 'power_allocator'
[    0.582036] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.582158] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.582172] pci 0000:00:1c.0:   bridge window [mem 0x91200000-0x912fffff]
[    0.582185] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    0.582190] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    0.582193] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    0.582197] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.582200] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.582203] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.582207] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff window]
[    0.582210] pci_bus 0000:00: resource 11 [mem 0x80000000-0xdfffffff window]
[    0.582215] pci_bus 0000:01: resource 1 [mem 0x91200000-0x912fffff]
[    0.582566] NET: Registered protocol family 2
[    0.583079] tcp_listen_portaddr_hash hash table entries: 2048
(order: 3, 32768 bytes, linear)
[    0.583183] TCP established hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    0.583455] TCP bind hash table entries: 32768 (order: 7, 524288
bytes, linear)
[    0.583645] TCP: Hash tables configured (established 32768 bind 32768)
[    0.583784] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.583847] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.584007] NET: Registered protocol family 1
[    0.584021] NET: Registered protocol family 44
[    0.584055] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.584712] PCI: CLS 0 bytes, default 64
[    0.584848] Trying to unpack rootfs image as initramfs...
[    1.839369] Freeing initrd memory: 39872K
[    1.839429] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.839433] software IO TLB: mapped [mem 0x706dc000-0x746dc000] (64MB)
[    1.839556] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x171024fa93b, max_idle_ns: 440795253189 ns
[    1.839605] clocksource: Switched to clocksource tsc
[    1.839707] check: Scanning for low memory corruption every 60 seconds
[    1.840904] Initialise system trusted keyrings
[    1.840930] Key type blacklist registered
[    1.841026] workingset: timestamp_bits=36 max_order=20 bucket_order=0
[    1.845301] zbud: loaded
[    1.846430] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.846972] fuse: init (API version 7.31)
[    1.847027] *** VALIDATE fuse ***
[    1.847031] *** VALIDATE fuse ***
[    1.847360] Platform Keyring initialized
[    1.854468] Key type asymmetric registered
[    1.854471] Asymmetric key parser 'x509' registered
[    1.854493] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 244)
[    1.854627] io scheduler mq-deadline registered
[    1.855541] pcieport 0000:00:1c.0: PME: Signaling with IRQ 115
[    1.855716] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.855891] efifb: probing for efifb
[    1.855935] efifb: showing boot graphics
[    1.858327] efifb: framebuffer at 0x80000000, using 4128k, total 4128k
[    1.858330] efifb: mode is 1366x768x32, linelength=5504, pages=1
[    1.858331] efifb: scrolling: redraw
[    1.858334] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.858509] fbcon: Deferring console take-over
[    1.858512] fb0: EFI VGA frame buffer device
[    1.858534] intel_idle: MWAIT substates: 0x33000020
[    1.858536] intel_idle: v0.4.1 model 0x4C
[    1.859023] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.859470] ACPI: AC Adapter [AC] (off-line)
[    1.859646] input: Lid Switch as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    1.859746] ACPI: Lid Switch [LID0]
[    1.859835] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    1.859887] ACPI: Power Button [PWRB]
[    1.859983] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    1.860033] ACPI: Sleep Button [SLPB]
[    1.860130] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    1.860215] ACPI: Power Button [PWRF]
[    1.897797] thermal LNXTHERM:00: registered as thermal_zone0
[    1.897801] ACPI: Thermal Zone [THM] (65 C)
[    1.899527] thermal LNXTHERM:01: registered as thermal_zone1
[    1.899530] ACPI: Thermal Zone [TZ01] (65 C)
[    1.900191] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.920841] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =
115200) is a 16550A
[    1.929881] Linux agpgart interface v0.103
[    1.941705] battery: ACPI: Battery Slot [BAT0] (battery present)
[    1.994405] loop: module loaded
[    1.995155] libphy: Fixed MDIO Bus: probed
[    1.995158] tun: Universal TUN/TAP device driver, 1.6
[    1.995322] PPP generic driver version 2.4.2
[    1.995600] VFIO - User Level meta-driver version: 0.3
[    1.996036] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.996051] ehci-pci: EHCI PCI platform driver
[    1.996085] ehci-platform: EHCI generic platform driver
[    1.996116] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.996125] ohci-pci: OHCI PCI platform driver
[    1.996146] ohci-platform: OHCI generic platform driver
[    1.996165] uhci_hcd: USB Universal Host Controller Interface driver
[    1.996651] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.996668] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 1
[    1.997819] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci
version 0x100 quirks 0x0000000081509810
[    1.997948] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.998372] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.04
[    1.998378] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.998381] usb usb1: Product: xHCI Host Controller
[    1.998385] usb usb1: Manufacturer: Linux 5.4.0-48-generic xhci-hcd
[    1.998388] usb usb1: SerialNumber: 0000:00:14.0
[    1.998823] hub 1-0:1.0: USB hub found
[    1.998858] hub 1-0:1.0: 7 ports detected
[    2.003823] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.003833] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    2.003841] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.003973] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.04
[    2.003978] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.003981] usb usb2: Product: xHCI Host Controller
[    2.003985] usb usb2: Manufacturer: Linux 5.4.0-48-generic xhci-hcd
[    2.003988] usb usb2: SerialNumber: 0000:00:14.0
[    2.004426] hub 2-0:1.0: USB hub found
[    2.004458] hub 2-0:1.0: 6 ports detected
[    2.009167] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
at 0x60,0x64 irq 1,12
[    2.013110] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.013124] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.013854] mousedev: PS/2 mouse device common for all mice
[    2.014968] rtc_cmos 00:00: RTC can wake from S4
[    2.015602] rtc_cmos 00:00: registered as rtc0
[    2.015687] rtc_cmos 00:00: alarms up to one day, y3k, 242 bytes
nvram, hpet irqs
[    2.015709] i2c /dev entries driver
[    2.016120] device-mapper: uevent: version 1.0.3
[    2.016638] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16)
initialised: dm-devel@redhat.com
[    2.016705] platform eisa.0: Probing EISA bus 0
[    2.016710] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    2.016713] platform eisa.0: Cannot allocate resource for EISA slot 1
[    2.016716] platform eisa.0: Cannot allocate resource for EISA slot 2
[    2.016719] platform eisa.0: Cannot allocate resource for EISA slot 3
[    2.016722] platform eisa.0: Cannot allocate resource for EISA slot 4
[    2.016725] platform eisa.0: Cannot allocate resource for EISA slot 5
[    2.016728] platform eisa.0: Cannot allocate resource for EISA slot 6
[    2.016731] platform eisa.0: Cannot allocate resource for EISA slot 7
[    2.016734] platform eisa.0: Cannot allocate resource for EISA slot 8
[    2.016738] platform eisa.0: EISA: Detected 0 cards
[    2.016747] intel_pstate: Intel P-state driver initializing
[    2.017773] ledtrig-cpu: registered to indicate activity on CPUs
[    2.017816] EFI Variables Facility v0.08 2004-May-17
[    2.030165] drop_monitor: Initializing network drop monitor service
[    2.030510] NET: Registered protocol family 10
[    2.038315] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input4
[    2.046024] Segment Routing with IPv6
[    2.046091] NET: Registered protocol family 17
[    2.046553] Key type dns_resolver registered
[    2.048468] RAS: Correctable Errors collector initialized.
[    2.048572] microcode: sig=0x406c3, pf=0x1, revision=0x368
[    2.049575] microcode: Microcode Update Driver: v2.2.
[    2.049592] IPI shorthand broadcast: enabled
[    2.049620] sched_clock: Marking stable (2048890362,
657575)->(2079145287, -29597350)
[    2.050067] registered taskstats version 1
[    2.050089] Loading compiled-in X.509 certificates
[    2.052215] Loaded X.509 cert 'Build time autogenerated kernel key:
59a6f4fdc5599d4ba313e816491c745e50e7fa8e'
[    2.052291] zswap: loaded using pool lzo/zbud
[    2.053099] Key type ._fscrypt registered
[    2.053101] Key type .fscrypt registered
[    2.069587] Key type big_key registered
[    2.069604] Key type trusted registered
[    2.077007] Key type encrypted registered
[    2.077022] AppArmor: AppArmor sha1 policy hashing enabled
[    2.078005] integrity: Loading X.509 certificate: UEFI:db
[    2.078105] integrity: Loaded X.509 cert 'Microsoft Windows
Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    2.078107] integrity: Loading X.509 certificate: UEFI:db
[    2.078155] integrity: Loaded X.509 cert 'Microsoft Corporation
UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    2.079286] ima: Allocated hash algorithm: sha1
[    2.165945] ima: No architecture policies found
[    2.166002] evm: Initialising EVM extended attributes:
[    2.166005] evm: security.selinux
[    2.166007] evm: security.SMACK64
[    2.166008] evm: security.SMACK64EXEC
[    2.166009] evm: security.SMACK64TRANSMUTE
[    2.166010] evm: security.SMACK64MMAP
[    2.166011] evm: security.apparmor
[    2.166012] evm: security.ima
[    2.166015] evm: security.capability
[    2.166017] evm: HMAC attrs: 0x1
[    2.167258] PM:   Magic number: 8:371:988
[    2.167268] machinecheck machinecheck1: hash matches
[    2.167802] rtc_cmos 00:00: setting system clock to
2020-10-07T13:59:21 UTC (1602079161)
[    2.168206] Lockdown: swapper/0: hibernation is restricted; see man
kernel_lockdown.7
[    2.179885] Freeing unused decrypted memory: 2040K
[    2.181594] Freeing unused kernel image memory: 2704K
[    2.181930] Write protecting the kernel read-only data: 22528k
[    2.184005] Freeing unused kernel image memory: 2008K
[    2.185282] Freeing unused kernel image memory: 1216K
[    2.210218] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.210637] x86/mm: Checking user space page tables
[    2.234959] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.234965] Run /init as init process
[    2.339096] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    2.488416] usb 1-2: New USB device found, idVendor=05e3,
idProduct=0608, bcdDevice=88.31
[    2.488420] usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.488422] usb 1-2: Product: USB2.0 Hub
[    2.489265] hub 1-2:1.0: USB hub found
[    2.489571] hub 1-2:1.0: 4 ports detected
[    2.490505] usb: port power management may be unreliable
[    2.496125] sdhci: Secure Digital Host Controller Interface driver
[    2.496129] sdhci: Copyright(c) Pierre Ossman
[    2.497113] hidraw: raw HID events driver (C) Jiri Kosina
[    2.520239] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    2.552542] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query
control method not found
[    2.555797] ahci 0000:00:13.0: version 3.0
[    2.566299] ahci 0000:00:13.0: AHCI 0001.0301 32 slots 2 ports 6
Gbps 0x3 impl SATA mode
[    2.566304] ahci 0000:00:13.0: flags: 64bit ncq ilck pm led clo
only pio slum part deso sadm sds apst
[    2.567102] scsi host0: ahci
[    2.569597] scsi host1: ahci
[    2.569759] ata1: SATA max UDMA/133 abar m2048@0x9131c000 port
0x9131c100 irq 117
[    2.569763] ata2: SATA max UDMA/133 abar m2048@0x9131c000 port
0x9131c180 irq 117
[    2.619084] usb 1-5: new high-speed USB device number 3 using xhci_hcd
[    2.619571] i2c_hid i2c-DLL06AC:00: i2c-DLL06AC:00 supply vdd not
found, using dummy regulator
[    2.619603] i2c_hid i2c-DLL06AC:00: i2c-DLL06AC:00 supply vddl not
found, using dummy regulator
[    2.661644] input: DLL06AC:00 06CB:78F1 Mouse as
/devices/pci0000:00/808622C1:00/i2c-0/i2c-DLL06AC:00/0018:06CB:78F1.0001/input/input8
[    2.662617] hid-generic 0018:06CB:78F1.0001: input,hidraw0: I2C HID
v1.00 Mouse [DLL06AC:00 06CB:78F1] on i2c-DLL06AC:00
[    2.666814] mc: Linux media interface: v0.10
[    2.676237] videodev: Linux video capture interface: v2.00
[    2.790159] usb 1-5: New USB device found, idVendor=0bda,
idProduct=5683, bcdDevice=42.73
[    2.790164] usb 1-5: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    2.790167] usb 1-5: Product: Integrated_Webcam_HD
[    2.790170] usb 1-5: Manufacturer: CNFEH45M135030005502
[    2.790175] usb 1-5: SerialNumber: 200901010001
[    2.821288] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
Synaptics, product: TM3096-001, fw id: 2019836
[    2.855306] usb 1-2.1: new full-speed USB device number 4 using xhci_hcd
[    2.883104] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.884448] ata1.00: ATA-10: WDC WD5000LPCX-75VHAT0, 01.01A01, max UDMA/133
[    2.884453] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    2.885726] ata1.00: configured for UDMA/133
[    2.886231] scsi 0:0:0:0: Direct-Access     ATA      WDC
WD5000LPCX-7 1A01 PQ: 0 ANSI: 5
[    2.886728] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.886861] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks:
(500 GB/466 GiB)
[    2.886864] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    2.886898] sd 0:0:0:0: [sda] Write Protect is off
[    2.886901] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.886965] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    2.889801] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.893554] ata2.00: ATAPI: PLDS DVD+/-RW DU-8A5LH, DD11, max UDMA/133
[    2.904466] ata2.00: configured for UDMA/133
[    2.919706] input: Synaptics TM3096-001 as
/devices/pci0000:00/808622C1:00/i2c-0/i2c-DLL06AC:00/0018:06CB:78F1.0001/input/input10
[    2.920910] hid-rmi 0018:06CB:78F1.0001: input,hidraw0: I2C HID
v1.00 Mouse [DLL06AC:00 06CB:78F1] on i2c-DLL06AC:00
[    2.927589] scsi 1:0:0:0: CD-ROM            PLDS     DVD+-RW
DU-8A5LH DD11 PQ: 0 ANSI: 5
[    2.956990] usb 1-2.1: New USB device found, idVendor=0cf3,
idProduct=e005, bcdDevice= 0.01
[    2.956996] usb 1-2.1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    2.999092]  sda: sda1 sda2
[    3.001092] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer
dvd-ram cd/rw xa/form2 cdda tray
[    3.001097] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.001357] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.024280] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    3.024470] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    3.051492] usb 1-2.2: new high-speed USB device number 5 using xhci_hcd
[    3.153094] usb 1-2.2: New USB device found, idVendor=0bda,
idProduct=0129, bcdDevice=39.60
[    3.153100] usb 1-2.2: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    3.153104] usb 1-2.2: Product: USB2.0-CRW
[    3.153107] usb 1-2.2: Manufacturer: Generic
[    3.153109] usb 1-2.2: SerialNumber: 20100201396000000
[    3.170960] usbcore: registered new interface driver rtsx_usb
[    3.448525] fbcon: Taking over console
[    3.448764] Console: switching to colour frame buffer device 170x48
[    3.537925] EXT4-fs (sda2): mounted filesystem with ordered data
mode. Opts: (null)
[    5.901674] systemd[1]: systemd 237 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2
+IDN -PCRE2 default-hierarchy=hybrid)
[    5.920203] systemd[1]: Detected architecture x86-64.
[    5.971923] systemd[1]: Set hostname to <dell-cristian>.
[    6.030645] Lockdown: systemd: /dev/mem,kmem,port is restricted;
see man kernel_lockdown.7
[    7.050270] psmouse serio1: Failed to deactivate mouse on isa0060/serio1: -5
[    7.171703] psmouse serio1: Failed to enable mouse on isa0060/serio1
[    8.204729] input: PS/2 Generic Mouse as
/devices/platform/i8042/serio1/input/input7
[    8.267433] psmouse serio1: Failed to enable mouse on isa0060/serio1
[   10.201711] systemd[1]: Created slice User and Session Slice.
[   10.202376] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[   10.202427] systemd[1]: Reached target Remote File Systems.
[   10.202461] systemd[1]: Reached target User and Group Name Lookups.
[   10.202933] systemd[1]: Created slice System Slice.
[   10.203346] systemd[1]: Listening on Journal Audit Socket.
[   10.203633] systemd[1]: Listening on Journal Socket.
[   10.507882] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   10.948591] systemd-journald[275]: Received request to flush
runtime journal from PID 1
[   11.065920] lp: driver loaded but no devices found
[   11.073891] ppdev: user-space parallel port driver
[   11.143249] Adding 2097148k swap on /swapfile.  Priority:-2
extents:6 across:2260988k FS
[   18.646965] ACPI Warning: \_SB.DPTF._ART: Return Package has no
elements (empty) (20190816/nsprepkg-96)
[   18.659492] input: DELL Wireless hotkeys as /devices/virtual/input/input11
[   18.668458] proc_thermal 0000:00:0b.0: enabling device (0000 -> 0002)
[   18.680343] proc_thermal 0000:00:0b.0: Creating sysfs group for
PROC_THERMAL_PCI
[   19.333922] dcdbas dcdbas: Dell Systems Management Base Driver
(version 5.6.0-3.3)
[   19.373755] checking generic (80000000 408000) vs hw (80000000 10000000)
[   19.373758] fb0: switching to inteldrmfb from EFI VGA
[   19.373959] Console: switching to colour dummy device 80x25
[   19.374027] i915 0000:00:02.0: vgaarb: deactivate vga console
[   19.374166] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   19.374167] [drm] Driver supports precise vblank timestamp query.
[   19.376128] i915 0000:00:02.0: vgaarb: changed VGA decodes:
olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   19.383606] input: Dell WMI hotkeys as
/devices/platform/PNP0C14:00/wmi_bus/wmi_bus-PNP0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input12
[   19.390029] i915 0000:00:02.0:
[drm:intel_dp_aux_init_backlight_funcs [i915]] Panel advertises DPCD
backlight support, but VBT disagrees. If your backlight controls don't
work try booting with i915.enable_dpcd_backlight=1. If your machine
needs this, please file a _new_ bug report on bugs.freedesktop.org
against DRI -> DRM/Intel
[   19.403880] [drm] Initialized i915 1.6.0 20190822 for 0000:00:02.0 on minor 0
[   19.406380] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   19.407014] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input13
[   19.613896] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[   19.619727] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   19.683339] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[   19.683563] fbcon: i915drmfb (fb0) is primary device
[   19.683733] Console: switching to colour frame buffer device 170x48
[   19.683772] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
[   20.870341] cryptd: max_cpu_qlen set to 1000
[   20.973691] SSE version of gcm_enc/dec engaged.
[   21.243877] snd_hda_codec_generic hdaudioC0D0: autoconfig for
Generic: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[   21.243881] snd_hda_codec_generic hdaudioC0D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   21.243884] snd_hda_codec_generic hdaudioC0D0:    hp_outs=1
(0x21/0x0/0x0/0x0/0x0)
[   21.243886] snd_hda_codec_generic hdaudioC0D0:    mono: mono_out=0x0
[   21.243887] snd_hda_codec_generic hdaudioC0D0:    inputs:
[   21.243890] snd_hda_codec_generic hdaudioC0D0:      Mic=0x12
[   21.267719] snd_hda_codec_generic hdaudioC0D2: autoconfig for
Generic: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
[   21.267724] snd_hda_codec_generic hdaudioC0D2:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   21.267726] snd_hda_codec_generic hdaudioC0D2:    hp_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   21.267728] snd_hda_codec_generic hdaudioC0D2:    mono: mono_out=0x0
[   21.267730] snd_hda_codec_generic hdaudioC0D2:    dig-out=0x5/0x0
[   21.267731] snd_hda_codec_generic hdaudioC0D2:    inputs:
[   21.273861] input: HDA Intel PCH Front Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   21.274144] input: HDA Intel PCH HDMI as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   21.278002] Bluetooth: Core ver 2.22
[   21.278044] NET: Registered protocol family 31
[   21.278046] Bluetooth: HCI device and connection manager initialized
[   21.278053] Bluetooth: HCI socket layer initialized
[   21.278061] Bluetooth: L2CAP socket layer initialized
[   21.278069] Bluetooth: SCO socket layer initialized
[   21.501857] usbcore: registered new interface driver btusb
[   21.839511] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
[   21.839792] ath: phy0: WB335 2-ANT card detected
[   21.839794] ath: phy0: Set BT/WLAN RX diversity capability
[   21.848409] ath: phy0: Enable LNA combining
[   21.848455] uvcvideo: Found UVC 1.00 device Integrated_Webcam_HD (0bda:5683)
[   21.849596] ath: phy0: ASPM enabled: 0x42
[   21.849600] ath: EEPROM regdomain: 0x6c
[   21.849601] ath: EEPROM indicates we should expect a direct regpair map
[   21.849603] ath: Country alpha2 being used: 00
[   21.849604] ath: Regpair used: 0x6c
[   21.851595] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   21.852587] ieee80211 phy0: Atheros AR9565 Rev:1
mem=0xffffa45901100000, irq=16
[   21.855355] uvcvideo 1-5:1.0: Entity type for entity Extension 4
was not initialized!
[   21.855360] uvcvideo 1-5:1.0: Entity type for entity Extension 7
was not initialized!
[   21.855362] uvcvideo 1-5:1.0: Entity type for entity Processing 2
was not initialized!
[   21.855364] uvcvideo 1-5:1.0: Entity type for entity Camera 1 was
not initialized!
[   21.855492] input: Integrated_Webcam_HD: Integrate as
/devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input16
[   21.855638] usbcore: registered new interface driver uvcvideo
[   21.855640] USB Video Class driver (1.1.1)
[   22.049541] usbcore: registered new interface driver ath3k
[   22.179810] usb 1-2.1: USB disconnect, device number 4
[   22.403091] usb 1-2.1: new full-speed USB device number 6 using xhci_hcd
[   22.504282] usb 1-2.1: New USB device found, idVendor=0cf3,
idProduct=e005, bcdDevice= 0.02
[   22.504286] usb 1-2.1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[   26.193412] intel_rapl_common: Found RAPL domain package
[   26.193416] intel_rapl_common: Found RAPL domain core
[   26.562616] ath9k 0000:01:00.0 wlp1s0: renamed from wlan0
[   37.842997] audit: type=1400 audit(1602079197.168:2):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/bin/man" pid=845 comm="apparmor_parser"
[   37.843006] audit: type=1400 audit(1602079197.168:3):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="man_filter" pid=845 comm="apparmor_parser"
[   37.843010] audit: type=1400 audit(1602079197.168:4):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="man_groff" pid=845 comm="apparmor_parser"
[   37.845576] audit: type=1400 audit(1602079197.172:5):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/sbin/dhclient" pid=842 comm="apparmor_parser"
[   37.845585] audit: type=1400 audit(1602079197.172:6):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=842
comm="apparmor_parser"
[   37.845590] audit: type=1400 audit(1602079197.172:7):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=842
comm="apparmor_parser"
[   37.845593] audit: type=1400 audit(1602079197.172:8):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="/usr/lib/connman/scripts/dhclient-script" pid=842
comm="apparmor_parser"
[   37.847921] audit: type=1400 audit(1602079197.176:9):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="libreoffice-oopslash" pid=846 comm="apparmor_parser"
[   37.850383] audit: type=1400 audit(1602079197.176:10):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="libreoffice-senddoc" pid=847 comm="apparmor_parser"
[   37.851133] audit: type=1400 audit(1602079197.180:11):
apparmor="STATUS" operation="profile_load" profile="unconfined"
name="libreoffice-xpdfimport" pid=849 comm="apparmor_parser"
[   38.480466] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   38.480469] Bluetooth: BNEP filters: protocol multicast
[   38.480478] Bluetooth: BNEP socket layer initialized
[   40.520940] Lockdown: udisksd: /dev/mem,kmem,port is restricted;
see man kernel_lockdown.7
[   44.347644] wlp1s0: authenticate with 40:0d:10:2c:41:19
[   44.360246] wlp1s0: send auth to 40:0d:10:2c:41:19 (try 1/3)
[   44.363272] wlp1s0: authenticated
[   44.367221] wlp1s0: associate with 40:0d:10:2c:41:19 (try 1/3)
[   44.374733] wlp1s0: RX AssocResp from 40:0d:10:2c:41:19
(capab=0x431 status=0 aid=2)
[   44.374922] wlp1s0: associated
[   44.375189] ath: EEPROM regdomain: 0x8098
[   44.375194] ath: EEPROM indicates we should expect a country code
[   44.375196] ath: doing EEPROM country->regdmn map search
[   44.375199] ath: country maps to regdmn code: 0x5b
[   44.375201] ath: Country alpha2 being used: CL
[   44.375203] ath: Regpair used: 0x5b
[   44.375207] ath: regdomain 0x8098 dynamically updated by country element
[   44.445281] IPv6: ADDRCONF(NETDEV_CHANGE): wlp1s0: link becomes ready
[   58.972104] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   76.710332] Bluetooth: RFCOMM TTY layer initialized
[   76.710343] Bluetooth: RFCOMM socket layer initialized
[   76.710361] Bluetooth: RFCOMM ver 1.11
[   79.136140] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   80.746587] rfkill: input handler disabled
===

On Tue, Oct 6, 2020 at 11:51 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 10/6/20 7:31 PM, Cristian Llanos wrote:
> > Actually, the first command outputs nothing..
> >
> That means that it has not created a wireless interface.
>
> Does the output of the dmesg command show any information?
>
> Larry
>


-- 
Cristian Llanos Montenegro
+56 9 9618 8576
