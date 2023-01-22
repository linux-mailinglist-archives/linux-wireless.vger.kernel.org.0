Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256E86772F3
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jan 2023 23:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjAVWMu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Jan 2023 17:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVWMt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Jan 2023 17:12:49 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CB113D40
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 14:12:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B752161418B3;
        Sun, 22 Jan 2023 23:12:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id u1G21sPuVYh8; Sun, 22 Jan 2023 23:12:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 853A06453EB9;
        Sun, 22 Jan 2023 23:12:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DvtImEXzATMB; Sun, 22 Jan 2023 23:12:40 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5FF1C605DED8;
        Sun, 22 Jan 2023 23:12:40 +0100 (CET)
Date:   Sun, 22 Jan 2023 23:12:40 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Message-ID: <1263051271.53086.1674425560245.JavaMail.zimbra@nod.at>
Subject: Resume from hibernation fails due to ath11k_pci
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: tJtnXIlwp0PjqoIG/LDLuWfyhRsGJw==
Thread-Topic: Resume from hibernation fails due to ath11k_pci
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

On my shiny new Lenovo T14s resume from hibernation always fails, and crashes the kernel.
Looks like ath11k_pci is unable to resume the device.
This happens also with Linus' tree as of today.

Device in question:
01:00.0 Network controller: Qualcomm QCNFA765 Wireless Network Adapter (rev 01)
        Subsystem: Lenovo Device 9309
        Flags: bus master, fast devsel, latency 0, IRQ 75
        Memory at 98000000 (64-bit, non-prefetchable) [size=2M]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=32/32 Maskable+ 64bit-
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] #19
        Capabilities: [158] Transaction Processing Hints
        Capabilities: [1e4] Latency Tolerance Reporting
        Capabilities: [1ec] L1 PM Substates
        Kernel driver in use: ath11k_pci
        Kernel modules: ath11k_pci


Full log from EFI pstore:
Panic#1 Part1
<4>[  105.480943][    C2] RSP: 0018:ffffb971801c7e90 EFLAGS: 00000246
<4>[  105.480947][    C2] RAX: ffff9154deeb3cc0 RBX: ffff914dc893f000 RCX: 000000000000292b
<4>[  105.480949][    C2] RDX: 0000000000000002 RSI: 000000188f213a55 RDI: 0000000000000000
<4>[  105.480951][    C2] RBP: 0000000000000003 R08: 000000188f216380 R09: 000000000000000f
<4>[  105.480952][    C2] R10: 0000000000000001 R11: 000000000015479f R12: ffffffffb2433be0
<4>[  105.480953][    C2] R13: 000000188f216380 R14: 0000000000000003 R15: 0000000000000000
<4>[  105.480959][    C2]  cpuidle_enter+0x29/0x40
<4>[  105.480963][    C2]  do_idle+0x1f3/0x2a0
<4>[  105.480969][    C2]  cpu_startup_entry+0x19/0x20
<4>[  105.480972][    C2]  start_secondary+0x114/0x140
<4>[  105.480977][    C2]  secondary_startup_64_no_verify+0xe5/0xeb
<4>[  105.480983][    C2]  </TASK>
<0>[  105.481062][    C2] Kernel Offset: 0x2fa00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
Panic#1 Part2
<4>[  105.480874][    C2]  ? dpm_show_time.cold+0x5f/0x5f
<4>[  105.480878][    C2]  dpm_watchdog_handler+0x54/0x54
<4>[  105.480881][    C2]  ? dpm_show_time.cold+0x5f/0x5f
<4>[  105.480884][    C2]  call_timer_fn+0x27/0x130
<4>[  105.480890][    C2]  __run_timers.part.0+0x1d2/0x270
<4>[  105.480895][    C2]  ? tick_sched_timer+0x65/0x80
<4>[  105.480901][    C2]  ? __hrtimer_run_queues+0x121/0x2b0
<4>[  105.480903][    C2]  ? ktime_get+0x38/0xa0
<4>[  105.480906][    C2]  run_timer_softirq+0x26/0x50
<4>[  105.480911][    C2]  __do_softirq+0xc6/0x29c
<4>[  105.480915][    C2]  __irq_exit_rcu+0xa4/0xd0
<4>[  105.480921][    C2]  sysvec_apic_timer_interrupt+0x72/0x90
<4>[  105.480925][    C2]  </IRQ>
<4>[  105.480926][    C2]  <TASK>
<4>[  105.480927][    C2]  asm_sysvec_apic_timer_interrupt+0x16/0x20
<4>[  105.480933][    C2] RIP: 0010:cpuidle_enter_state+0xde/0x410
<4>[  105.480941][    C2] Code: 00 00 31 ff e8 f3 76 85 ff 45 84 ff 74 16 9c 58 0f 1f 40 00 f6 c4 02 0f 85 11 03 00 00 31 ff e8 a8 68 8c ff fb 0f 1f 44 00 00 <45> 85 f6 0f 88 6e 01 00 00 49 63 d6 4c 2b 2c 24 48 8d 04 52 48 8d
Panic#1 Part3
<0>[  105.480762][    C2]  device_resume+0x105/0x280
<0>[  105.480768][    C2]  ? dpm_show_time.cold+0x5f/0x5f
<0>[  105.480777][    C2]  async_resume+0x19/0x30
<0>[  105.480782][    C2]  async_run_entry_fn+0x2e/0x110
<0>[  105.480792][    C2]  process_one_work+0x21a/0x3e0
<0>[  105.480802][    C2]  worker_thread+0x4d/0x3c0
<0>[  105.480808][    C2]  ? process_one_work+0x3e0/0x3e0
<0>[  105.480815][    C2]  kthread+0xd9/0x100
<0>[  105.480822][    C2]  ? kthread_complete_and_exit+0x20/0x20
<0>[  105.480828][    C2]  ret_from_fork+0x22/0x30
<0>[  105.480840][    C2]  </TASK>
<0>[  105.480845][    C2] Kernel panic - not syncing: ath11k_pci 0000:01:00.0: unrecoverable failure
<4>[  105.480848][    C2] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.1.7-lp153.3.g2ebd33f-default #1 openSUSE Tumbleweed (unreleased) 165cc3f42ba30422f558a28d075e2ef07ff85066
<4>[  105.480854][    C2] Hardware name: LENOVO 21CQCTO1WW/21CQCTO1WW, BIOS R22ET55W (1.25 ) 09/14/2022
<4>[  105.480856][    C2] Call Trace:
<4>[  105.480858][    C2]  <IRQ>
<4>[  105.480860][    C2]  dump_stack_lvl+0x45/0x5e
<4>[  105.480866][    C2]  panic+0x10c/0x2a0
Panic#1 Part4
<6>[   45.225721][  T115] amdgpu 0000:33:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hub 1
<0>[  105.480570][    C2] ath11k_pci 0000:01:00.0: PM: **** DPM device timeout ****
<0>[  105.480587][    C2] Call Trace:
<0>[  105.480594][    C2]  <TASK>
<0>[  105.480603][    C2]  __schedule+0x301/0x1310
<0>[  105.480620][    C2]  ? __mod_timer+0x20d/0x3b0
<0>[  105.480632][    C2]  schedule+0x5a/0xd0
<0>[  105.480640][    C2]  schedule_timeout+0x88/0x160
<0>[  105.480647][    C2]  ? timer_migration_handler+0x90/0x90
<0>[  105.480660][    C2]  __mhi_pm_resume+0x284/0x410 [mhi 75aba2ea7e1783672c961bedf4c141b8800b9c9e]
<0>[  105.480681][    C2]  ? destroy_sched_domains_rcu+0x30/0x30
<0>[  105.480689][    C2]  ? pci_pm_poweroff_noirq+0x120/0x120
<0>[  105.480702][    C2]  ath11k_mhi_resume+0x17/0x50 [ath11k_pci 05e8ca762c997bd5feabff7694276ca7ec83d39c]
<0>[  105.480717][    C2]  ath11k_core_resume+0x57/0x120 [ath11k 504a26768b25fac38e0ba4c531385e4abd4b6da1]
<0>[  105.480742][    C2]  ath11k_pci_pm_resume+0x2e/0x60 [ath11k_pci 05e8ca762c997bd5feabff7694276ca7ec83d39c]
<0>[  105.480753][    C2]  dpm_run_callback+0x4a/0x150
Panic#1 Part5
<6>[   45.225715][  T115] amdgpu 0000:33:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
<6>[   45.225716][  T115] amdgpu 0000:33:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
<6>[   45.225716][  T115] amdgpu 0000:33:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
<6>[   45.225716][  T115] amdgpu 0000:33:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
<6>[   45.225717][  T115] amdgpu 0000:33:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
<6>[   45.225717][  T115] amdgpu 0000:33:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
<6>[   45.225718][  T115] amdgpu 0000:33:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
<6>[   45.225718][  T115] amdgpu 0000:33:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
<6>[   45.225719][  T115] amdgpu 0000:33:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on hub 1
<6>[   45.225720][  T115] amdgpu 0000:33:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on hub 1
<6>[   45.225720][  T115] amdgpu 0000:33:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on hub 1
Panic#1 Part6
<6>[   44.411653][  T115] amdgpu 0000:33:00.0: amdgpu: RAS: optional ras ta ucode is not available
<6>[   44.423430][  T115] amdgpu 0000:33:00.0: amdgpu: RAP: optional rap ta ucode is not available
<6>[   44.423432][  T115] amdgpu 0000:33:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
<6>[   44.423436][  T115] amdgpu 0000:33:00.0: amdgpu: SMU is resuming...
<6>[   44.423936][  T115] amdgpu 0000:33:00.0: amdgpu: SMU is resumed successfully!
<6>[   44.425922][  T115] [drm] DMUB hardware initialized: version=0x0400001A
<6>[   45.222119][  T115] [drm] kiq ring mec 2 pipe 1 q 0
<6>[   45.224719][  T115] [drm] VCN decode and encode initialized successfully(under DPG Mode).
<6>[   45.225703][  T115] [drm] JPEG decode initialized successfully.
<6>[   45.225712][  T115] amdgpu 0000:33:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
<6>[   45.225714][  T115] amdgpu 0000:33:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
<6>[   45.225715][  T115] amdgpu 0000:33:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
Panic#1 Part7
<5>[   44.064409][    T9] usb usb4: root hub lost power or was reset
<5>[   44.064478][  T117] usb usb5: root hub lost power or was reset
<5>[   44.064482][  T117] usb usb6: root hub lost power or was reset
<5>[   44.064505][  T118] usb usb7: root hub lost power or was reset
<5>[   44.064508][  T118] usb usb8: root hub lost power or was reset
<6>[   44.064583][  T115] [drm] PCIE GART of 1024M enabled (table at 0x000000F43FC00000).
<6>[   44.064619][  T115] [drm] PSP is resuming...
<6>[   44.065875][  T117] xhci_hcd 0000:34:00.0: USB3 root hub has no ports
<5>[   44.066840][ T3691] usb usb9: root hub lost power or was reset
<5>[   44.066841][ T3691] usb usb10: root hub lost power or was reset
<6>[   44.077661][ T3705] nvme nvme0: Shutdown timeout set to 10 seconds
<6>[   44.080894][ T3705] nvme nvme0: 16/0/0 default/read/poll queues
<6>[   44.087035][  T115] [drm] reserve 0xa00000 from 0xf43e000000 for PSP TMR
<6>[   44.348509][ T3665] usb 5-1: reset high-speed USB device number 2 using xhci_hcd
<6>[   44.360533][ T3664] usb 1-3: reset high-speed USB device number 2 using xhci_hcd
Panic#1 Part8
<6>[   43.979268][    T0] microcode: CPU13: patch_level=0x0a404102
<6>[   43.980582][   T92] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
<6>[   43.981171][ T3127] CPU13 is up
<6>[   43.981189][ T3127] smpboot: Booting Node 0 Processor 14 APIC 0xe
<6>[   43.980429][    T0] microcode: CPU14: patch_level=0x0a404102
<6>[   43.981580][   T98] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
<6>[   43.982480][ T3127] CPU14 is up
<6>[   43.982496][ T3127] smpboot: Booting Node 0 Processor 15 APIC 0xf
<6>[   43.981404][    T0] microcode: CPU15: patch_level=0x0a404102
<6>[   43.982874][  T104] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
<6>[   43.983555][ T3127] CPU15 is up
<6>[   43.984896][ T3127] ACPI: PM: Waking up from system sleep state S4
<6>[   44.004214][ T3127] ACPI: EC: interrupt unblocked
<4>[   44.064069][  T111] mhi mhi0: Resuming from non M3 state (RESET)
<6>[   44.064109][ T3127] ACPI: EC: event unblocked
<5>[   44.064358][  T112] usb usb1: root hub lost power or was reset
<5>[   44.064361][  T112] usb usb2: root hub lost power or was reset
<5>[   44.064406][    T9] usb usb3: root hub lost power or was reset
Panic#1 Part9
<6>[   43.976241][ T3127] CPU8 is up
<6>[   43.976253][ T3127] smpboot: Booting Node 0 Processor 9 APIC 0x9
<6>[   43.975484][    T0] microcode: CPU9: patch_level=0x0a404102
<6>[   43.976611][   T68] ACPI: \_SB_.PLTF.C009: Found 3 idle states
<6>[   43.977198][ T3127] CPU9 is up
<6>[   43.977210][ T3127] smpboot: Booting Node 0 Processor 10 APIC 0xa
<6>[   43.976458][    T0] microcode: CPU10: patch_level=0x0a404102
<6>[   43.977590][   T74] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
<6>[   43.978272][ T3127] CPU10 is up
<6>[   43.978284][ T3127] smpboot: Booting Node 0 Processor 11 APIC 0xb
<6>[   43.977426][    T0] microcode: CPU11: patch_level=0x0a404102
<6>[   43.978549][   T80] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
<6>[   43.979047][ T3127] CPU11 is up
<6>[   43.979060][ T3127] smpboot: Booting Node 0 Processor 12 APIC 0xc
<6>[   43.978431][    T0] microcode: CPU12: patch_level=0x0a404102
<6>[   43.979434][   T86] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
<6>[   43.980210][ T3127] CPU12 is up
<6>[   43.980230][ T3127] smpboot: Booting Node 0 Processor 13 APIC 0xd
Panic#1 Part10
<6>[   43.972280][    T0] microcode: CPU4: patch_level=0x0a404102
<6>[   43.972527][   T38] ACPI: \_SB_.PLTF.C004: Found 3 idle states
<6>[   43.972954][ T3127] CPU4 is up
<6>[   43.972969][ T3127] smpboot: Booting Node 0 Processor 5 APIC 0x5
<6>[   43.972391][    T0] microcode: CPU5: patch_level=0x0a404102
<6>[   43.973320][   T44] ACPI: \_SB_.PLTF.C005: Found 3 idle states
<6>[   43.973701][ T3127] CPU5 is up
<6>[   43.973715][ T3127] smpboot: Booting Node 0 Processor 6 APIC 0x6
<6>[   43.973242][    T0] microcode: CPU6: patch_level=0x0a404102
<6>[   43.974075][   T50] ACPI: \_SB_.PLTF.C006: Found 3 idle states
<6>[   43.974582][ T3127] CPU6 is up
<6>[   43.974597][ T3127] smpboot: Booting Node 0 Processor 7 APIC 0x7
<6>[   43.973916][    T0] microcode: CPU7: patch_level=0x0a404102
<6>[   43.974871][   T56] ACPI: \_SB_.PLTF.C007: Found 3 idle states
<6>[   43.975261][ T3127] CPU7 is up
<6>[   43.975275][ T3127] smpboot: Booting Node 0 Processor 8 APIC 0x8
<6>[   43.974757][    T0] microcode: CPU8: patch_level=0x0a404102
<6>[   43.975641][   T62] ACPI: \_SB_.PLTF.C008: Found 3 idle states
Panic#1 Part11
<6>[   43.972280][ T3127] AMD-Vi: Virtual APIC enabled
<6>[   43.972280][ T3127] LVT offset 0 assigned for vector 0x400
<6>[   43.972280][ T3127] Enabling non-boot CPUs ...
<6>[   43.972280][ T3127] x86: Booting SMP configuration:
<6>[   43.972280][ T3127] smpboot: Booting Node 0 Processor 1 APIC 0x1
<6>[   43.939798][    T0] microcode: CPU1: patch_level=0x0a404102
<6>[   43.972280][   T20] ACPI: \_SB_.PLTF.C001: Found 3 idle states
<6>[   43.972280][ T3127] Spectre V2 : Update user space SMT mitigation: STIBP always-on
<6>[   43.972280][ T3127] CPU1 is up
<6>[   43.972280][ T3127] smpboot: Booting Node 0 Processor 2 APIC 0x2
<6>[   43.972280][    T0] microcode: CPU2: patch_level=0x0a404102
<6>[   43.972280][   T26] ACPI: \_SB_.PLTF.C002: Found 3 idle states
<6>[   43.972280][ T3127] CPU2 is up
<6>[   43.972280][ T3127] smpboot: Booting Node 0 Processor 3 APIC 0x3
<6>[   43.972280][    T0] microcode: CPU3: patch_level=0x0a404102
<6>[   43.972280][   T32] ACPI: \_SB_.PLTF.C003: Found 3 idle states
<6>[   43.972280][ T3127] CPU3 is up
<6>[   43.972280][ T3127] smpboot: Booting Node 0 Processor 4 APIC 0x4
Panic#1 Part12
<6>[   43.948841][ T3127] smpboot: CPU 5 is now offline
<6>[   43.951017][ T3127] smpboot: CPU 6 is now offline
<6>[   43.953153][ T3127] smpboot: CPU 7 is now offline
<6>[   43.955102][ T3127] smpboot: CPU 8 is now offline
<6>[   43.956928][ T3127] smpboot: CPU 9 is now offline
<6>[   43.958665][ T3127] smpboot: CPU 10 is now offline
<6>[   43.960465][ T3127] smpboot: CPU 11 is now offline
<6>[   43.962495][ T3127] smpboot: CPU 12 is now offline
<6>[   43.964348][ T3127] smpboot: CPU 13 is now offline
<6>[   43.966260][ T3127] smpboot: CPU 14 is now offline
<6>[   43.966577][ T3127] Spectre V2 : Update user space SMT mitigation: STIBP off
<6>[   43.967985][ T3127] smpboot: CPU 15 is now offline
<6>[   43.969504][ T3127] PM: hibernation: Creating image:
<6>[   43.972280][ T3127] PM: hibernation: Need to copy 731648 pages
<7>[   43.972280][ T3127] PM: hibernation: Normal pages needed: 731648 + 1024, available pages: 7332255
<6>[   43.972280][ T3127] ACPI: PM: Restoring platform NVS memory
<6>[   43.972280][ T3127] ACPI: EC: EC started
<6>[   43.972280][ T3127] AMD-Vi: Virtual APIC enabled
Panic#1 Part13
<6>[   42.880448][ T3127] PM: hibernation: Allocated 671793 pages for snapshot
<6>[   42.880452][ T3127] PM: hibernation: Allocated 2687172 kbytes in 0.22 seconds (12214.41 MB/s)
<6>[   42.880454][ T3127] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
<6>[   42.881978][ T3127] printk: Suspending console(s) (use no_console_suspend to debug)
<6>[   43.777041][  T117] amdgpu 0000:33:00.0: amdgpu: free PSP TMR buffer
<6>[   43.808095][  T117] amdgpu 0000:33:00.0: amdgpu: MODE2 reset
<6>[   43.818353][ T3127] ACPI: EC: interrupt blocked
<6>[   43.819200][ T3127] ACPI: PM: Preparing to enter system sleep state S4
<6>[   43.928507][ T3127] ACPI: EC: event blocked
<6>[   43.928511][ T3127] ACPI: EC: EC stopped
<6>[   43.928512][ T3127] ACPI: PM: Saving platform NVS memory
<6>[   43.938079][ T3127] Disabling non-boot CPUs ...
<6>[   43.940193][ T3127] smpboot: CPU 1 is now offline
<6>[   43.942551][ T3127] smpboot: CPU 2 is now offline
<6>[   43.944829][ T3127] smpboot: CPU 3 is now offline
<6>[   43.946868][ T3127] smpboot: CPU 4 is now offline
Panic#1 Part14
<7>[   42.650552][ T3127] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
<7>[   42.650553][ T3127] PM: hibernation: Marking nosave pages: [mem 0x09c00000-0x09da0fff]
<7>[   42.650555][ T3127] PM: hibernation: Marking nosave pages: [mem 0x09f00000-0x09f27fff]
<7>[   42.650556][ T3127] PM: hibernation: Marking nosave pages: [mem 0x3ed04000-0x3ed04fff]
<7>[   42.650556][ T3127] PM: hibernation: Marking nosave pages: [mem 0x3ed0e000-0x3ed0efff]
<7>[   42.650557][ T3127] PM: hibernation: Marking nosave pages: [mem 0x6a9d4000-0x6aa64fff]
<7>[   42.650558][ T3127] PM: hibernation: Marking nosave pages: [mem 0x6b9e6000-0x6b9e6fff]
<7>[   42.650558][ T3127] PM: hibernation: Marking nosave pages: [mem 0x6ba11000-0x6ba11fff]
<7>[   42.650558][ T3127] PM: hibernation: Marking nosave pages: [mem 0x7057e000-0x777fdfff]
<7>[   42.650664][ T3127] PM: hibernation: Marking nosave pages: [mem 0x79ffd000-0xffffffff]
<7>[   42.651637][ T3127] PM: hibernation: Basic memory bitmaps created
<6>[   42.651991][ T3127] PM: hibernation: Preallocating image memory
Panic#1 Part15
<6>[   10.297326][ T2087] NET: Registered PF_PACKET protocol family
<6>[   23.470694][ T2067] wlan0: authenticate with 0a:18:d6:e2:ed:f1
<6>[   23.511526][ T2067] wlan0: send auth to 0a:18:d6:e2:ed:f1 (try 1/3)
<6>[   23.515056][  T123] wlan0: authenticated
<6>[   23.516281][  T123] wlan0: associate with 0a:18:d6:e2:ed:f1 (try 1/3)
<6>[   23.530613][  T123] wlan0: RX AssocResp from 0a:18:d6:e2:ed:f1 (capab=0x1511 status=0 aid=4)
<6>[   23.616330][  T123] wlan0: associated
<6>[   23.792833][ T2067] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
<6>[   40.301799][ T2067] wlan0: deauthenticating from 0a:18:d6:e2:ed:f1 by local choice (Reason: 3=DEAUTH_LEAVING)
<6>[   42.513551][ T3127] PM: hibernation: hibernation entry
<6>[   42.648547][ T3127] Filesystems sync: 0.027 seconds
<6>[   42.648861][ T3127] Freezing user space processes ... (elapsed 0.001 seconds) done.
<6>[   42.650402][ T3127] OOM killer disabled.
<7>[   42.650550][ T3127] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
Panic#1 Part16
<6>[    8.729751][ T1649] bpfilter: Loaded bpfilter_umh pid 1650
<13>[    8.729870][ T1650] Started bpfilter
<6>[    8.932345][  T190] mhi mhi0: Wait for device to enter SBL or Mission mode
<6>[    9.038184][ T1018] mc: Linux media interface: v0.10
<6>[    9.046841][ T1018] videodev: Linux video capture interface: v2.00
<6>[    9.201670][ T1900] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
<6>[    9.349664][ T1018] usb 5-1: Found UVC 1.10 device Integrated Camera (04f2:b761)
<6>[    9.356486][ T1018] input: Integrated Camera: Integrated C as /devices/pci0000:00/0000:00:08.3/0000:34:00.0/usb5/5-1/5-1:1.0/input/input22
<6>[    9.356554][ T1018] usbcore: registered new interface driver uvcvideo
<6>[    9.634337][  T111] ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
<6>[    9.634346][  T111] ath11k_pci 0000:01:00.0: fw_version 0x110f0c35 fw_build_timestamp 2022-03-30 09:05 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.7
Panic#1 Part17
<6>[    8.277743][ T1283] NET: Registered PF_QIPCRTR protocol family
<6>[    8.302298][  T979] BTRFS info: devid 1 device path /dev/mapper/system-root changed to /dev/dm-2 scanned by systemd-udevd (979)
<6>[    8.302787][  T979] BTRFS info: devid 1 device path /dev/dm-2 changed to /dev/mapper/system-root scanned by systemd-udevd (979)
<6>[    8.340862][   T84] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:08.1/0000:33:00.6/sound/card1/input19
<6>[    8.340910][   T84] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:33:00.6/sound/card1/input20
<6>[    8.340957][   T84] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:08.1/0000:33:00.6/sound/card1/input21
<6>[    8.435325][ T1000] mhi mhi0: Requested to power ON
<6>[    8.435339][ T1000] mhi mhi0: Power on setup success
<6>[    8.440353][ T1011] acp_yc_mach acp_yc_mach.0: Enabling ACP DMIC support via DMI
<6>[    8.440392][  T113] acp_yc_mach acp_yc_mach.0: Enabling ACP DMIC support via DMI
<6>[    8.632654][   T19] intel_rapl_common: Found RAPL domain package
<6>[    8.632658][   T19] intel_rapl_common: Found RAPL domain core
Panic#1 Part18
<6>[    8.247910][ T1269] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
<6>[    8.247912][ T1269] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
<6>[    8.247913][ T1269] snd_hda_codec_realtek hdaudioC1D0:    inputs:
<6>[    8.247914][ T1269] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x19
<6>[    8.251037][  T984] SVM: TSC scaling supported
<6>[    8.251039][  T984] kvm: Nested Virtualization enabled
<6>[    8.251041][  T984] SVM: kvm: Nested Paging enabled
<6>[    8.251051][  T984] SVM: Virtual VMLOAD VMSAVE supported
<6>[    8.251052][  T984] SVM: Virtual GIF supported
<6>[    8.251052][  T984] SVM: LBR virtualization supported
<6>[    8.265303][ T1017] MCE: In-kernel MCE decoding enabled.
<6>[    8.269965][ T1000] ath11k_pci 0000:01:00.0: BAR 0: assigned [mem 0x98000000-0x981fffff 64bit]
<6>[    8.269982][ T1000] ath11k_pci 0000:01:00.0: enabling device (0000 -> 0002)
<6>[    8.270356][ T1000] ath11k_pci 0000:01:00.0: MSI vectors: 32
<6>[    8.270362][ T1000] ath11k_pci 0000:01:00.0: wcn6855 hw2.1

Is this a known issue or is there some workaround I could try?

Thanks,
//richard
