Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F541EEBA
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 15:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353853AbhJANm3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 09:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhJANm0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 09:42:26 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5F4C06177C
        for <linux-wireless@vger.kernel.org>; Fri,  1 Oct 2021 06:40:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v195so20125183ybb.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Oct 2021 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=uLUSTyWMGfGiUFaw3TGJR+Jd9IdZWkg7pIjncnmRp48=;
        b=sKVx5gsN9Joxrle9h9r/xszPqZvOkS4adBFooUEtdc3NawsUCCBsmvJKrLmLfQq6e7
         nDfoE+YsbXJUnRQwHDbnY7qWDqK4Wcf82jlVj76kt8krQbCnpQ1QxMcF4dHaiFe4foCK
         WgTGCnWAbI7rljUfU07F7WX02quLMEHWSFDS1ophuzQczx7QAw2X7Nj/jfrnZ4cHA/ps
         RUO74poqyRhPiHhbPfLhfxBMhQD/SqFvnPcDGFuj6lT3E9S+z01FQclwjkgjlgtjrfq6
         ijg+En0bEAVp1BzurjhcGkdJTchJDh4OnftT121PnHWaM7qKPRVIuv6K3DYegmxBEne2
         XZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uLUSTyWMGfGiUFaw3TGJR+Jd9IdZWkg7pIjncnmRp48=;
        b=NFLxCGpYKTaCDIGflOfz/lx5wsw7tEC3KXNqtBRJBshX9oPjPTTCORuHDoNr2vO58Y
         xilddY69TzyR1mdVJOK4clJ0KAPgtf0MT3qMWb6JKi4f3aKTkXi1sr5z797L9KxaDxit
         HJuhc/MXmwD4UXgxTjN/VCg0E3X8uT5g2AcIu3TJ/xikQX4RSmk78eex7UDVLzfnsHTa
         DsJ3D7/jTXFhqHBPh6dOY2N4vFdh9snNoyiMa/r9dCuYfGeAxykTFIKUh4zf4z1B3KeS
         ZJ7GiVfiaA8Z0AVqkWJNwAKO/KW5Sk4eiA3wk1zd67HMmAk4vLN0ARGovN2P4MsvktMh
         LRRg==
X-Gm-Message-State: AOAM533avUhQJfjbfFHxV4JBMssZ7goWlznJtpeK7f/YFG/+/kjZVYq3
        A+HtghnIBBTO+9OcpmOpc9y0P1jTJk/tdSq1B++HZEKt2mfHbYfd
X-Google-Smtp-Source: ABdhPJya2BKNHJ1y1W5MarxIK/CFO68NMjpP1oWi4IvPmsxtRYYRmO6CtlZi9sPFPLcn/NJj5csZkWkFpnePU7+O7Vs=
X-Received: by 2002:a25:5b83:: with SMTP id p125mr3776634ybb.277.1633095640970;
 Fri, 01 Oct 2021 06:40:40 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <chris@colorremedies.com>
Date:   Fri, 1 Oct 2021 09:40:25 -0400
Message-ID: <CAJCQCtR28JZaqNC053jEpoZGN37kRK9ReYX0Kt8+ukRGnO5z_Q@mail.gmail.com>
Subject: 5.15.0-0.rc2: suspicious RCU usage
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

First seen with these kernels:
5.15.0-0.rc2.18.fc36.x86_64+debug
5.15.0-0.rc3.25.fc36.x86_64+debug

Did not see it with 5.14 series, but also didn't test any 5.15 kernel
prior to rc2.

There's actually two issues, not sure if they are related:

1.

[    9.054169] =============================
[    9.054170] WARNING: suspicious RCU usage
[    9.054172] 5.15.0-0.rc3.25.fc36.x86_64+debug #1 Not tainted
[    9.054173] -----------------------------
[    9.054175] drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:263
suspicious rcu_dereference_protected() usage!
[    9.054178]
               other info that might help us debug this:

[    9.054180]
               rcu_scheduler_active = 2, debug_locks = 1
[    9.054182] 3 locks held by modprobe/670:
[    9.054185]  #0: ffffffffc0d160f0
(iwlwifi_opmode_table_mtx){+.+.}-{3:3}, at:
iwl_opmode_register+0x2c/0xe0 [iwlwifi]
[    9.054209]  #1: ffffffffa21ee910 (rtnl_mutex){+.+.}-{3:3}, at:
iwl_op_mode_mvm_start+0xa41/0xce0 [iwlmvm]
[    9.054239]  #2: ffff9f6586cc3608 (&mvm->mutex){+.+.}-{3:3}, at:
iwl_op_mode_mvm_start+0xa4d/0xce0 [iwlmvm]
[    9.054260]
               stack backtrace:
[    9.054261] CPU: 7 PID: 670 Comm: modprobe Not tainted
5.15.0-0.rc3.25.fc36.x86_64+debug #1
[    9.054264] Hardware name: LENOVO 20QDS3E200/20QDS3E200, BIOS
N2HET63W (1.46 ) 06/01/2021
[    9.054265] Call Trace:
[    9.054268]  dump_stack_lvl+0x57/0x72
[    9.054273]  iwl_mvm_init_fw_regd+0x110/0x170 [iwlmvm]
[    9.054292]  iwl_mvm_init_mcc+0x42/0x1b0 [iwlmvm]
[    9.054308]  iwl_op_mode_mvm_start+0xc8e/0xce0 [iwlmvm]
[    9.054332]  _iwl_op_mode_start.isra.0+0x3f/0x80 [iwlwifi]
[    9.054349]  iwl_opmode_register+0x6f/0xe0 [iwlwifi]
[    9.054363]  ? 0xffffffffc0be0000
[    9.054367]  iwl_mvm_init+0x36/0x1000 [iwlmvm]
[    9.054383]  do_one_initcall+0x64/0x320
[    9.054389]  ? rcu_read_lock_sched_held+0x3f/0x80
[    9.054393]  ? trace_kmalloc+0x38/0xe0
[    9.054396]  ? kmem_cache_alloc_trace+0x17c/0x280
[    9.054405]  do_init_module+0x5c/0x270
[    9.054409]  __do_sys_init_module+0x130/0x190
[    9.054427]  do_syscall_64+0x38/0x90
[    9.054433]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    9.054437] RIP: 0033:0x7ff05073b97e
[    9.054441] Code: 48 8b 0d ad 74 0e 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7a 74 0e 00 f7 d8 64 89
01 48
[    9.054444] RSP: 002b:00007ffce3da9378 EFLAGS: 00000246 ORIG_RAX:
00000000000000af
[    9.054448] RAX: ffffffffffffffda RBX: 00005645f1041db0 RCX: 00007ff05073b97e
[    9.054450] RDX: 00005645ef77ba2a RSI: 00000000000fb6e6 RDI: 00005645f1ad0180
[    9.054452] RBP: 00005645f1ad0180 R08: 00005645f1044cc0 R09: 00000000000fa010
[    9.054454] R10: 0000000000000005 R11: 0000000000000246 R12: 00005645ef77ba2a
[    9.054456] R13: 00005645f1041ec0 R14: 00005645f1041db0 R15: 00005645f1044dd0
[    9.061824] ------------[ cut here ]------------
[    9.061829] WARNING: CPU: 5 PID: 670 at net/wireless/reg.c:3107
reg_process_self_managed_hint+0x198/0x1e0 [cfg80211]
[    9.061883] Modules linked in: snd_soc_core(+) kvm_intel(+)
pcc_cpufreq(-) iTCO_wdt(+) snd_compress intel_pmc_bxt ac97_bus
snd_pcm_dmaengine iTCO_vendor_support mei_hdcp mei_wdt snd_hda_intel
kvm intel_rapl_msr snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
irqbypass iwlmvm(+) snd_hda_core rapl snd_hwdep intel_cstate snd_seq
mac80211 snd_seq_device intel_uncore snd_pcm uvcvideo think_lmi(+)
libarc4 firmware_attributes_class intel_wmi_thunderbolt wmi_bmof
videobuf2_vmalloc btusb i2c_i801 videobuf2_memops snd_timer
videobuf2_v4l2 videobuf2_common i2c_smbus thunderbolt btrtl btbcm
iwlwifi videodev btintel mei_me processor_thermal_device_pci_legacy
processor_thermal_device bluetooth joydev mc processor_thermal_rfim
mei cfg80211 thinkpad_acpi ucsi_acpi processor_thermal_mbox idma64
ledtrig_audio ecdh_generic typec_ucsi processor_thermal_rapl
platform_profile intel_rapl_common typec intel_pch_thermal
intel_soc_dts_iosf rfkill snd int3403_thermal soundcore
int340x_thermal_zone acpi_pad
[    9.062083]  acpi_tad int3400_thermal acpi_thermal_rel zram
ip_tables i915 hid_multitouch crct10dif_pclmul i2c_algo_bit
crc32_pclmul crc32c_intel ttm drm_kms_helper ghash_clmulni_intel cec
serio_raw e1000e drm nvme nvme_core i2c_hid_acpi i2c_hid wmi video
pinctrl_cannonlake fuse
[    9.062158] CPU: 5 PID: 670 Comm: modprobe Not tainted
5.15.0-0.rc3.25.fc36.x86_64+debug #1
[    9.062164] Hardware name: LENOVO 20QDS3E200/20QDS3E200, BIOS
N2HET63W (1.46 ) 06/01/2021
[    9.062168] RIP: 0010:reg_process_self_managed_hint+0x198/0x1e0 [cfg80211]
[    9.062211] Code: 0e 01 03 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
5f 5d c3 49 8d 7c 24 70 be ff ff ff ff e8 50 f1 35 e0 85 c0 0f 85 b8
fe ff ff <0f> 0b e9 b1 fe ff ff 0f 0b 80 3d 47 bf 0b 00 00 0f 85 94 fe
ff ff
[    9.062214] RSP: 0018:ffffc353c141bc50 EFLAGS: 00010246
[    9.062219] RAX: 0000000000000000 RBX: ffff9f6586cc3568 RCX: 0000000000000001
[    9.062223] RDX: 0000000000000002 RSI: ffff9f6586cc0650 RDI: ffff9f658701c410
[    9.062225] RBP: ffffc353c141bcc8 R08: 0000000000000000 R09: 0000000000000001
[    9.062228] R10: ffffffffa372c720 R11: 0000000000000000 R12: ffff9f6586cc05e0
[    9.062231] R13: ffff9f6586cc3568 R14: ffffc353c141bd30 R15: ffff9f6586cc3560
[    9.062236] FS:  00007ff050624740(0000) GS:ffff9f68ee400000(0000)
knlGS:0000000000000000
[    9.062239] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.062242] CR2: 00005572b3a19440 CR3: 00000001029ca006 CR4: 00000000003706e0
[    9.062246] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    9.062249] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    9.062252] Call Trace:
[    9.062258]  ? kfree+0x319/0x4c0
[    9.062282]  regulatory_set_wiphy_regd_sync+0x31/0x90 [cfg80211]
[    9.062321]  iwl_mvm_init_mcc+0xa9/0x1b0 [iwlmvm]
[    9.062352]  iwl_op_mode_mvm_start+0xc8e/0xce0 [iwlmvm]
[    9.062384]  _iwl_op_mode_start.isra.0+0x3f/0x80 [iwlwifi]
[    9.062404]  iwl_opmode_register+0x6f/0xe0 [iwlwifi]
[    9.062416]  ? 0xffffffffc0be0000
[    9.062423]  iwl_mvm_init+0x36/0x1000 [iwlmvm]
[    9.062438]  do_one_initcall+0x64/0x320
[    9.062445]  ? rcu_read_lock_sched_held+0x3f/0x80
[    9.062450]  ? trace_kmalloc+0x38/0xe0
[    9.062455]  ? kmem_cache_alloc_trace+0x17c/0x280
[    9.062464]  do_init_module+0x5c/0x270
[    9.062471]  __do_sys_init_module+0x130/0x190
[    9.062496]  do_syscall_64+0x38/0x90
[    9.062504]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    9.062509] RIP: 0033:0x7ff05073b97e
[    9.062514] Code: 48 8b 0d ad 74 0e 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7a 74 0e 00 f7 d8 64 89
01 48
[    9.062517] RSP: 002b:00007ffce3da9378 EFLAGS: 00000246 ORIG_RAX:
00000000000000af
[    9.062523] RAX: ffffffffffffffda RBX: 00005645f1041db0 RCX: 00007ff05073b97e
[    9.062526] RDX: 00005645ef77ba2a RSI: 00000000000fb6e6 RDI: 00005645f1ad0180
[    9.062529] RBP: 00005645f1ad0180 R08: 00005645f1044cc0 R09: 00000000000fa010
[    9.062554] R10: 0000000000000005 R11: 0000000000000246 R12: 00005645ef77ba2a
[    9.062557] R13: 00005645f1041ec0 R14: 00005645f1041db0 R15: 00005645f1044dd0
[    9.062580] irq event stamp: 149273
[    9.062583] hardirqs last  enabled at (149281):
[<ffffffffa0e00e42>] asm_sysvec_call_function+0x12/0x20
[    9.062588] hardirqs last disabled at (149288):
[<ffffffffa01727a5>] __up_console_sem+0x45/0x70
[    9.062594] softirqs last  enabled at (149246):
[<ffffffffa00ec798>] __irq_exit_rcu+0xd8/0x110
[    9.062599] softirqs last disabled at (149237):
[<ffffffffa00ec798>] __irq_exit_rcu+0xd8/0x110
[    9.062603] ---[ end trace fec5843beb08d839 ]---


2. these appear in red text

[   23.150258] iwlwifi 0000:00:14.3: Unhandled alg: 0xc0400707
[   23.150380] iwlwifi 0000:00:14.3: Unhandled alg: 0xc0400707


Downstream bug report has the full dmesg attached
https://bugzilla.redhat.com/show_bug.cgi?id=2009750



-- 
Chris Murphy
