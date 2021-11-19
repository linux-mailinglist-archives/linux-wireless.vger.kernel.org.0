Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56044569C6
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 06:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhKSFl7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 00:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSFl6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 00:41:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6EFC061574
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 21:38:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id z1-20020a05600c220100b00337f97d2464so6999955wml.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 21:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:content-language:from
         :subject:content-transfer-encoding;
        bh=8f6mUCwf1mSciy1b1OhK8qun7YCQGg0jbFqo8NbleCY=;
        b=YQT+GGg3sxQAugPKCRtpKVshAxSVr375lfuoGSUr5+x/HRaFkqtjrvv6sufrU54HRs
         EMj0OmYcX7HI7Ble5w4bXEkxUN/HKv3TrulTLDaKoHcQkTMPFjo1AMe3BuDg0e5FW2rB
         5NC2C0odTbOgr56lxhJyD6DJ6SKtltr/whD4gtLU7+z91y7sFAPuvO1NB/cx9t8nL6fL
         EpWs2yiFihiYRgxMoEL4h9noSuSQSPnLnfDDtjuya+Bb8AyXupkRv23wVWVgSpcDUBT/
         au3HU4kkHWORpynDXnmFOU/9ZKkbVYNRbcKKBwa0z6ACDPf8ni30deP7XF6ZbsCb1DPx
         Pzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :content-language:from:subject:content-transfer-encoding;
        bh=8f6mUCwf1mSciy1b1OhK8qun7YCQGg0jbFqo8NbleCY=;
        b=LkFQxrAtJGBr0m0YA83Fl2nkkInl4mfviBpe5cS69Rmf44guw5+i1+IsQeuyBUGSNu
         CahJXCygt8vvMyLJqs0VZC5sgMayg50BTayKq0ta70W2zsTmrYyziODL7nFr0EUnHc6W
         8VE8h7x7VqA3znmSK/RThiRt0W38IXf+4c7eUhG7vqGaNtcFY45MiSNrEIoWQvv3IlJc
         ojA+KjNTsAkgNa7/1mAbN8sKwW+F4W7k/7IE4PU3af3Upg3yM2TNj494MoRvHDofeIAh
         8ehonkL+yH8KHCD4NzzvJtPYXYTYJ4kXEDITdkclZMSR7msACWRhzYZF5EcH3/INE0vp
         AdqQ==
X-Gm-Message-State: AOAM5311X1X8sl75t2zoIpji8rZE3neSU0mRbtNNuo6jAvhIL5b/fQlQ
        g0wOP2SfQhR1IKcX4sCW0V/7ItQtjr0WAQ==
X-Google-Smtp-Source: ABdhPJwjpTnsvXzd+ucr1hFt8NB/iLNiMm9gV2EfBXplnH1je/6PzCrDD2QrYwwrmtd0Qton1tQKHw==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr3505940wme.160.1637300335680;
        Thu, 18 Nov 2021 21:38:55 -0800 (PST)
Received: from ?IPV6:2a02:908:1980:7720::d962? ([2a02:908:1980:7720::d962])
        by smtp.gmail.com with ESMTPSA id e7sm2399033wrg.31.2021.11.18.21.38.55
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 21:38:55 -0800 (PST)
Message-ID: <d4b8f00f-19cd-b1f8-45f8-f26908b2c84b@gmail.com>
Date:   Fri, 19 Nov 2021 06:38:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
To:     linux-wireless@vger.kernel.org
Content-Language: en-US
From:   Julian Sikorski <belegdol@gmail.com>
Subject: mac80211.c:264 suspicious rcu_dereference_protected() usage!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I have noticed an RCU warning in my dmesg with 
5.16.0-0.rc1.20211118git8ab774587903.200.s0ix01.fc35.x86_64. Not sure 
whether this is a problem. My card is:
01:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)


[   16.404061] =============================

[   16.404063] WARNING: suspicious RCU usage

[   16.404066] 
5.16.0-0.rc1.20211118git8ab774587903.200.s0ix01.fc35.x86_64 #1 Not tainted

[   16.404070] -----------------------------

[   16.404072] drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:264 
suspicious rcu_dereference_protected() usage!

[   16.404076]

                other info that might help us debug this:



[   16.404079]

                rcu_scheduler_active = 2, debug_locks = 1

[   16.404082] 3 locks held by modprobe/705:

[   16.404086]  #0: ffffffffc11bc0f0 
(iwlwifi_opmode_table_mtx){+.+.}-{3:3}, at: 
iwl_opmode_register+0x2c/0xe0 [iwlwifi]

[   16.404124]  #1: ffffffffbc40dc10 (rtnl_mutex){+.+.}-{3:3}, at: 
iwl_op_mode_mvm_start+0xa49/0xcf0 [iwlmvm]

[   16.404169]  #2: ffff90bd496eb688 (&mvm->mutex){+.+.}-{3:3}, at: 
iwl_op_mode_mvm_start+0xa55/0xcf0 [iwlmvm]

[   16.404203]

                stack backtrace:

[   16.404207] CPU: 0 PID: 705 Comm: modprobe Not tainted 
5.16.0-0.rc1.20211118git8ab774587903.200.s0ix01.fc35.x86_64 #1

[   16.404212] Hardware name: ASUSTeK COMPUTER INC. ZenBook 
UX425IA_UM425IA/UX425IA, BIOS UX425IA.309 01/29/2021

[   16.404215] Call Trace:

[   16.404218]  <TASK>

[   16.404222]  dump_stack_lvl+0x59/0x73

[   16.404233]  iwl_mvm_init_fw_regd+0x110/0x170 [iwlmvm]

[   16.404262]  iwl_mvm_init_mcc+0x42/0x1b0 [iwlmvm]

[   16.404288]  iwl_op_mode_mvm_start+0xc94/0xcf0 [iwlmvm]

[   16.404329]  _iwl_op_mode_start.isra.0+0x42/0x80 [iwlwifi]

[   16.404357]  iwl_opmode_register+0x6f/0xe0 [iwlwifi]

[   16.404381]  ? 0xffffffffc14d9000

[   16.404389]  iwl_mvm_init+0x36/0x1000 [iwlmvm]

[   16.404414]  do_one_initcall+0x67/0x350

[   16.404422]  ? rcu_read_lock_sched_held+0x3f/0x70

[   16.404428]  ? trace_kmalloc+0x38/0x100

[   16.404433]  ? kmem_cache_alloc_trace+0x1ee/0x3a0

[   16.404446]  do_init_module+0x5c/0x280

[   16.404455]  __do_sys_init_module+0x130/0x190

[   16.404485]  do_syscall_64+0x3b/0x90

[   16.404494]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[   16.404500] RIP: 0033:0x7fa8ae78b99e

[   16.404505] Code: 48 8b 0d 8d 74 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5a 74 0e 00 f7 d8 64 89 01 48

[   16.404509] RSP: 002b:00007ffc0d0e8408 EFLAGS: 00000246 ORIG_RAX: 
00000000000000af

[   16.404515] RAX: ffffffffffffffda RBX: 000055ca40ef1d00 RCX: 
00007fa8ae78b99e

[   16.404519] RDX: 000055ca40c7ca2a RSI: 000000000152b1d4 RDI: 
00007fa8a8ddf010

[   16.404522] RBP: 00007fa8a8ddf010 R08: 000055ca40ef4db0 R09: 
000000000152b000

[   16.404525] R10: 0000000000000005 R11: 0000000000000246 R12: 
000055ca40c7ca2a

[   16.404528] R13: 000055ca40ef1e30 R14: 000055ca40ef1d00 R15: 
000055ca40ef4ec0

[   16.404555]  </TASK>

[   16.405529] ------------[ cut here ]------------

[   16.405535] WARNING: CPU: 0 PID: 705 at net/wireless/reg.c:3107 
reg_process_self_managed_hint+0x198/0x1e0 [cfg80211]

[   16.405591] Modules linked in: vfat fat iwlmvm(+) mac80211 
intel_rapl_msr intel_rapl_common edac_mce_amd snd_soc_dmic kvm_amd kvm 
snd_acp3x_rn snd_acp3x_pdm_dma snd_soc_core snd_hda_codec_realtek 
snd_hda_codec_generic libarc4 snd_hda_codec_hdmi snd_compress 
ledtrig_audio ac97_bus btusb snd_pcm_dmaengine snd_hda_intel iwlwifi 
btrtl snd_intel_dspcfg snd_intel_sdw_acpi btbcm snd_hda_codec btintel 
snd_hda_core uvcvideo irqbypass bluetooth videobuf2_vmalloc rapl 
videobuf2_memops snd_hwdep videobuf2_v4l2 videobuf2_common snd_seq 
asus_nb_wmi asus_wmi pcspkr videodev cfg80211 snd_seq_device 
sparse_keymap wmi_bmof platform_profile snd_pcm joydev snd_pci_acp5x mc 
snd_timer i2c_piix4 k10temp snd_rn_pci_acp3x ecdh_generic snd_pci_acp3x 
snd rfkill soundcore cm32181 industrialio acpi_cpufreq amd_pmc 
binfmt_misc zram ip_tables amdgpu rtsx_pci_sdmmc mmc_core nvme 
hid_multitouch nvme_core rtsx_pci ccp crct10dif_pclmul drm_ttm_helper 
ttm crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw iommu_v2

[   16.405793]  ucsi_acpi sp5100_tco typec_ucsi gpu_sched typec wmi 
video i2c_hid_acpi i2c_hid ipmi_devintf ipmi_msghandler fuse

[   16.405825] CPU: 0 PID: 705 Comm: modprobe Not tainted 
5.16.0-0.rc1.20211118git8ab774587903.200.s0ix01.fc35.x86_64 #1

[   16.405830] Hardware name: ASUSTeK COMPUTER INC. ZenBook 
UX425IA_UM425IA/UX425IA, BIOS UX425IA.309 01/29/2021

[   16.405834] RIP: 0010:reg_process_self_managed_hint+0x198/0x1e0 
[cfg80211]

[   16.405882] Code: ae 09 03 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 
5d c3 49 8d 7c 24 70 be ff ff ff ff e8 80 13 f8 f9 85 c0 0f 85 b8 fe ff 
ff <0f> 0b e9 b1 fe ff ff 0f 0b 80 3d b7 be 0b 00 00 0f 85 94 fe ff ff

[   16.405886] RSP: 0018:ffff9e430234fc50 EFLAGS: 00010246

[   16.405893] RAX: 0000000000000000 RBX: ffff90bd496eb5e8 RCX: 
0000000000000001

[   16.405896] RDX: 0000000000000002 RSI: ffffffffbb809cad RDI: 
ffffffffbb8a8416

[   16.405900] RBP: ffff9e430234fcc8 R08: 00000003d1d7d8f4 R09: 
0000000000000000

[   16.405903] R10: 0000000000000001 R11: 0000000000000000 R12: 
ffff90bd496e8640

[   16.405906] R13: ffff90bd496eb5e8 R14: ffff9e430234fd30 R15: 
ffff90bd496eb5e0

[   16.405910] FS:  00007fa8ae674740(0000) GS:ffff90c03ba00000(0000) 
knlGS:0000000000000000

[   16.405914] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[   16.405917] CR2: 00007f4ed482e140 CR3: 0000000106908000 CR4: 
0000000000350ef0

[   16.405921] Call Trace:

[   16.405925]  <TASK>

[   16.405928]  ? rcu_read_lock_sched_held+0x3f/0x70

[   16.405953]  regulatory_set_wiphy_regd_sync+0x31/0x90 [cfg80211]

[   16.406003]  iwl_mvm_init_mcc+0xa9/0x1b0 [iwlmvm]

[   16.406040]  iwl_op_mode_mvm_start+0xc94/0xcf0 [iwlmvm]

[   16.406084]  _iwl_op_mode_start.isra.0+0x42/0x80 [iwlwifi]

[   16.406113]  iwl_opmode_register+0x6f/0xe0 [iwlwifi]

[   16.406138]  ? 0xffffffffc14d9000

[   16.406145]  iwl_mvm_init+0x36/0x1000 [iwlmvm]

[   16.406172]  do_one_initcall+0x67/0x350

[   16.406180]  ? rcu_read_lock_sched_held+0x3f/0x70

[   16.406185]  ? trace_kmalloc+0x38/0x100

[   16.406190]  ? kmem_cache_alloc_trace+0x1ee/0x3a0

[   16.406203]  do_init_module+0x5c/0x280

[   16.406212]  __do_sys_init_module+0x130/0x190

[   16.406268]  do_syscall_64+0x3b/0x90

[   16.406277]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[   16.406283] RIP: 0033:0x7fa8ae78b99e

[   16.406288] Code: 48 8b 0d 8d 74 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5a 74 0e 00 f7 d8 64 89 01 48

[   16.406292] RSP: 002b:00007ffc0d0e8408 EFLAGS: 00000246 ORIG_RAX: 
00000000000000af

[   16.406298] RAX: ffffffffffffffda RBX: 000055ca40ef1d00 RCX: 
00007fa8ae78b99e

[   16.406302] RDX: 000055ca40c7ca2a RSI: 000000000152b1d4 RDI: 
00007fa8a8ddf010

[   16.406305] RBP: 00007fa8a8ddf010 R08: 000055ca40ef4db0 R09: 
000000000152b000

[   16.406308] R10: 0000000000000005 R11: 0000000000000246 R12: 
000055ca40c7ca2a

[   16.406312] R13: 000055ca40ef1e30 R14: 000055ca40ef1d00 R15: 
000055ca40ef4ec0

[   16.406338]  </TASK>

[   16.406341] irq event stamp: 722337

[   16.406344] hardirqs last  enabled at (722343): [<ffffffffba179020>] 
__up_console_sem+0x60/0x70

[   16.406350] hardirqs last disabled at (722348): [<ffffffffba179005>] 
__up_console_sem+0x45/0x70

[   16.406355] softirqs last  enabled at (721430): [<ffffffffba0f2827>] 
__irq_exit_rcu+0x107/0x170

[   16.406361] softirqs last disabled at (721421): [<ffffffffba0f2827>] 
__irq_exit_rcu+0x107/0x170

[   16.406366] ---[ end trace 8712d9fee8ea5eb3 ]---


Best regards,
Julian
