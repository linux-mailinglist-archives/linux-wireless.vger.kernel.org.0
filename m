Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C59459A2B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 03:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhKWCn3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 21:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWCn2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 21:43:28 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E41C061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 18:40:20 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id f186so18486164ybg.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 18:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=U2hxYmw2QTeSRz4diobYRKz4UmW0rZisjKf3yHpnKV4=;
        b=YwQvM8cXi0XeFsxTrN6EUJf8kjzYQWeMlkd4BLjnFz/hxzUOrPmlogTgsIt+oums13
         hXVrjxBlAnd25ktfV+hP34g1z9oNpy8+hIW57aTs5Hd0/bfaltJT+dRuZ1ZVEKu5kKkm
         0+2/ymcQupGpbDBQ8hHT3Cn6Xb1sCyCRefudAdeL/654sd/Ikk+yvMJBtvyENYuh+f/j
         YObWuWG3K0ROPlHOtY0+ERrjPbw6fpP+co++G9e3I3WKkF4FA382xCk74jT8rEm+fBGU
         7d8X20uim4qtkUfXErr5tg9iRJiYWwvOQ6rSuLa+nGSFmTl0Z6Mq0Jo3dxkeRni52wcU
         mVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=U2hxYmw2QTeSRz4diobYRKz4UmW0rZisjKf3yHpnKV4=;
        b=JJ4iEDjCPs9RhhHFPe9tKufckbMgY//3lUUMtOHtLnX3Z3KVQqevy0iHQT+GhMAQYl
         p+KHnFrOMeqhYJi6vDh/9wbV3gvzjSXZT55Y2pVHyteiLnUm5jRleu3zquSjrIZtvLAM
         1t+A65ydGFUGMW9DFUzuvW8MuO6OQyvE+ksP30BXncBBbvHRooLTBtYYEI1BPhpb1RNA
         gfIwDwZKkI1DN/oqtgvFwMVIbQndmoAT1QkHCRGFQJgjqMXafDKYq5hrMECaEaV8jW+0
         NJ95+wYh8c6aSYZud7inWjzMaqAfCEoEyIBOLTrCXBOAavi9wO8cne/BxgafLjoc683B
         yVoQ==
X-Gm-Message-State: AOAM532IZiC4v6ih6eZvRe/IWegXLlQzFKyIDZHv0eg5LrvJfjQltMGI
        k+ZC47W9OvB2KZ7NtVphgJ1OeFG6EEM1e9NUH/pXMWK5BzQMhLAe1Bk=
X-Google-Smtp-Source: ABdhPJyU1o8QQHqY3zvhJw1vhk51Bw5LCITj5IfF7Knths5ohAOY5GcWyVdE7rGicfl2TsmGBvPHefAFcliWdBacfTI=
X-Received: by 2002:a05:6902:1022:: with SMTP id x2mr2144534ybt.391.1637635219421;
 Mon, 22 Nov 2021 18:40:19 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtR28JZaqNC053jEpoZGN37kRK9ReYX0Kt8+ukRGnO5z_Q@mail.gmail.com>
 <CAJCQCtQBsa2KkeQ1vS+j_t4G6DV_uO5kHETerBrjh3SVHQUf8Q@mail.gmail.com>
In-Reply-To: <CAJCQCtQBsa2KkeQ1vS+j_t4G6DV_uO5kHETerBrjh3SVHQUf8Q@mail.gmail.com>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Mon, 22 Nov 2021 21:40:03 -0500
Message-ID: <CAJCQCtT7X7jcPMoQ68yvmqmFVUYfmmoqOCfB+ELdQ+pSpqCOFg@mail.gmail.com>
Subject: Re: 5.15.0-0.rc2: suspicious RCU usage
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is still a problem with 5.16.0-0.rc2.18.fc36.x86_64+debug

Downstream bug
https://bugzilla.redhat.com/show_bug.cgi?id=2009750
Full dmesg
https://bugzilla.redhat.com/attachment.cgi?id=1843093


[   10.086769] iwlwifi 0000:00:14.3: Detected Intel(R) Wireless-AC
9560 160MHz, REV=0x318
[   10.103027] zram0: detected capacity change from 0 to 16777216
[   10.106045] thermal thermal_zone6: failed to read out thermal zone (-61)
[   10.178076] iwlwifi 0000:00:14.3: base HW address: c8:e2:65:04:99:cb
[   10.205970] snd_hda_intel 0000:00:1f.3: DSP detected with PCI
class/subclass/prog-if info 0x040380
[   10.229278] snd_hda_intel 0000:00:1f.3: Digital mics found on
Skylake+ platform, using SOF driver

[   10.233993] =============================
[   10.233996] WARNING: suspicious RCU usage
[   10.233999] 5.16.0-0.rc2.18.fc36.x86_64+debug #1 Not tainted
[   10.234002] -----------------------------
[   10.234004] drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:264
suspicious rcu_dereference_protected() usage!
[   10.234008]
               other info that might help us debug this:

[   10.234010]
               rcu_scheduler_active = 2, debug_locks = 1
[   10.234013] 3 locks held by modprobe/671:
[   10.234017]  #0: ffffffffc0b2d0f0
(iwlwifi_opmode_table_mtx){+.+.}-{3:3}, at:
iwl_opmode_register+0x2c/0xe0 [iwlwifi]
[   10.234055]  #1: ffffffffa040dc10 (rtnl_mutex){+.+.}-{3:3}, at:
iwl_op_mode_mvm_start+0xa49/0xcf0 [iwlmvm]
[   10.234096]  #2: ffff9344c9f1b688 (&mvm->mutex){+.+.}-{3:3}, at:
iwl_op_mode_mvm_start+0xa55/0xcf0 [iwlmvm]
[   10.234127]
               stack backtrace:
[   10.234130] CPU: 3 PID: 671 Comm: modprobe Not tainted
5.16.0-0.rc2.18.fc36.x86_64+debug #1
[   10.234134] Hardware name: LENOVO 20QDS3E200/20QDS3E200, BIOS
N2HET64W (1.47 ) 07/19/2021
[   10.234137] Call Trace:
[   10.234140]  <TASK>
[   10.234144]  dump_stack_lvl+0x59/0x73
[   10.234153]  iwl_mvm_init_fw_regd+0x110/0x170 [iwlmvm]
[   10.234179]  iwl_mvm_init_mcc+0x42/0x1b0 [iwlmvm]
[   10.234202]  iwl_op_mode_mvm_start+0xc94/0xcf0 [iwlmvm]
[   10.234239]  _iwl_op_mode_start.isra.0+0x3f/0x80 [iwlwifi]
[   10.234265]  iwl_opmode_register+0x6f/0xe0 [iwlwifi]
[   10.234287]  ? 0xffffffffc07df000
[   10.234294]  iwl_mvm_init+0x36/0x1000 [iwlmvm]
[   10.234316]  do_one_initcall+0x64/0x350
[   10.234323]  ? rcu_read_lock_sched_held+0x3f/0x70
[   10.234329]  ? trace_kmalloc+0x38/0x100
[   10.234333]  ? kmem_cache_alloc_trace+0x1ee/0x3a0
[   10.234345]  do_init_module+0x5c/0x280
[   10.234352]  __do_sys_init_module+0x130/0x190
[   10.234382]  do_syscall_64+0x38/0x90
[   10.234389]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   10.234394] RIP: 0033:0x7f761e21799e
[   10.234399] Code: 48 8b 0d 8d 74 0e 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5a 74 0e 00 f7 d8 64 89
01 48
[   10.234402] RSP: 002b:00007fff30183428 EFLAGS: 00000246 ORIG_RAX:
00000000000000af
[   10.234408] RAX: ffffffffffffffda RBX: 000056233a3dbdb0 RCX: 00007f761e21799e
[   10.234411] RDX: 0000562338eeaa2a RSI: 00000000000fc6ee RDI: 000056233ae71200
[   10.234413] RBP: 000056233ae71200 R08: 000056233a3ded20 R09: 00000000000fc010
[   10.234416] R10: 0000000000000005 R11: 0000000000000246 R12: 0000562338eeaa2a
[   10.234419] R13: 000056233a3dbec0 R14: 000056233a3dbdb0 R15: 000056233a3dee30
[   10.234445]  </TASK>
[   10.238914] ------------[ cut here ]------------
[   10.239002] WARNING: CPU: 4 PID: 671 at net/wireless/reg.c:3107
reg_process_self_managed_hint+0x198/0x1e0 [cfg80211]
[   10.239060] Modules linked in: snd_hda_intel kvm(+)
snd_intel_dspcfg snd_intel_sdw_acpi irqbypass snd_hda_codec
snd_hda_core rapl iwlmvm(+) snd_hwdep intel_cstate intel_uncore
snd_seq snd_seq_device mac80211 snd_pcm think_lmi(+) btusb wmi_bmof
firmware_attributes_class intel_wmi_thunderbolt libarc4 uvcvideo btrtl
videobuf2_vmalloc btbcm videobuf2_memops snd_timer btintel
videobuf2_v4l2 i2c_i801 processor_thermal_device_pci_legacy
videobuf2_common i2c_smbus bluetooth processor_thermal_device iwlwifi
thunderbolt videodev processor_thermal_rfim mei_me
processor_thermal_mbox joydev mc mei idma64 ecdh_generic cfg80211
processor_thermal_rapl intel_rapl_common thinkpad_acpi
intel_soc_dts_iosf intel_pch_thermal ledtrig_audio platform_profile
rfkill snd int3403_thermal soundcore int340x_thermal_zone
int3400_thermal acpi_pad acpi_thermal_rel acpi_tad zram ip_tables
hid_multitouch i915 crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel e1000e nvme serio_raw nvme_core ucsi_acpi ttm
[   10.239244]  typec_ucsi typec i2c_hid_acpi i2c_hid wmi video
pinctrl_cannonlake ipmi_devintf ipmi_msghandler fuse
[   10.239270] CPU: 4 PID: 671 Comm: modprobe Not tainted
5.16.0-0.rc2.18.fc36.x86_64+debug #1
[   10.239275] Hardware name: LENOVO 20QDS3E200/20QDS3E200, BIOS
N2HET64W (1.47 ) 07/19/2021
[   10.239278] RIP: 0010:reg_process_self_managed_hint+0x198/0x1e0 [cfg80211]
[   10.239341] Code: de 09 03 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
5f 5d c3 49 8d 7c 24 70 be ff ff ff ff e8 80 33 5f de 85 c0 0f 85 b8
fe ff ff <0f> 0b e9 b1 fe ff ff 0f 0b 80 3d b7 be 0b 00 00 0f 85 94 fe
ff ff
[   10.239344] RSP: 0018:ffffab090191bc50 EFLAGS: 00010246
[   10.239350] RAX: 0000000000000000 RBX: ffff9344c9f1b5e8 RCX: 0000000000000001
[   10.239354] RDX: 0000000000000002 RSI: ffffffff9f809f4d RDI: ffffffff9f8a878e
[   10.239357] RBP: ffffab090191bcc8 R08: 000000026248c01c R09: 0000000000000000
[   10.239360] R10: 0000000000000001 R11: 0000000000000000 R12: ffff9344c9f18640
[   10.239363] R13: ffff9344c9f1b5e8 R14: ffffab090191bd30 R15: ffff9344c9f1b5e0
[   10.239366] FS:  00007f761e100740(0000) GS:ffff93482da00000(0000)
knlGS:0000000000000000
[   10.239370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.239373] CR2: 00007f9b3bc6eed0 CR3: 000000010b688004 CR4: 00000000003706e0
[   10.239376] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   10.239379] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   10.239382] Call Trace:
[   10.239386]  <TASK>
[   10.239389]  ? rcu_read_lock_sched_held+0x3f/0x70
[   10.239413]  regulatory_set_wiphy_regd_sync+0x31/0x90 [cfg80211]
[   10.239462]  iwl_mvm_init_mcc+0xa9/0x1b0 [iwlmvm]
[   10.239494]  iwl_op_mode_mvm_start+0xc94/0xcf0 [iwlmvm]
[   10.239534]  _iwl_op_mode_start.isra.0+0x3f/0x80 [iwlwifi]
[   10.239560]  iwl_opmode_register+0x6f/0xe0 [iwlwifi]
[   10.239582]  ? 0xffffffffc07df000
[   10.239619]  iwl_mvm_init+0x36/0x1000 [iwlmvm]
[   10.239643]  do_one_initcall+0x64/0x350
[   10.239649]  ? rcu_read_lock_sched_held+0x3f/0x70
[   10.239654]  ? trace_kmalloc+0x38/0x100
[   10.239659]  ? kmem_cache_alloc_trace+0x1ee/0x3a0
[   10.239671]  do_init_module+0x5c/0x280
[   10.239679]  __do_sys_init_module+0x130/0x190
[   10.239709]  do_syscall_64+0x38/0x90
[   10.239717]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   10.239721] RIP: 0033:0x7f761e21799e
[   10.239726] Code: 48 8b 0d 8d 74 0e 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5a 74 0e 00 f7 d8 64 89
01 48
[   10.239730] RSP: 002b:00007fff30183428 EFLAGS: 00000246 ORIG_RAX:
00000000000000af
[   10.239736] RAX: ffffffffffffffda RBX: 000056233a3dbdb0 RCX: 00007f761e21799e
[   10.239739] RDX: 0000562338eeaa2a RSI: 00000000000fc6ee RDI: 000056233ae71200
[   10.239742] RBP: 000056233ae71200 R08: 000056233a3ded20 R09: 00000000000fc010
[   10.239745] R10: 0000000000000005 R11: 0000000000000246 R12: 0000562338eeaa2a
[   10.239748] R13: 000056233a3dbec0 R14: 000056233a3dbdb0 R15: 000056233a3dee30
[   10.239774]  </TASK>
[   10.239777] irq event stamp: 157423
[   10.239780] hardirqs last  enabled at (157429):
[<ffffffff9e178e10>] __up_console_sem+0x60/0x70
[   10.239785] hardirqs last disabled at (157434):
[<ffffffff9e178df5>] __up_console_sem+0x45/0x70
[   10.239789] softirqs last  enabled at (156456):
[<ffffffff9e0f25b7>] __irq_exit_rcu+0x107/0x170
[   10.239794] softirqs last disabled at (156427):
[<ffffffff9e0f25b7>] __irq_exit_rcu+0x107/0x170
[   10.239798] ---[ end trace 3d5bcc984dacd264 ]---
[   10.252933] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
