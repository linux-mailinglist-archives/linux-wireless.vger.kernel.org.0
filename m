Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10206613A0
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jan 2023 06:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjAHFGK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 00:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHFGH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 00:06:07 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C7F3056D
        for <linux-wireless@vger.kernel.org>; Sat,  7 Jan 2023 21:06:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d30so3175196lfv.8
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jan 2023 21:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=durity-me.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gRPHcaFKeV6wGy7fxNh/+7M0F4JkWRWMl+m84PUtw74=;
        b=OQtvICF41d2HjXC9MDETv/Lo6p5P7nTF0wN8CO07N+80GCYuMKBCOl3YkYVoUmj2LN
         H9t9Rt/NkjY4yIu9OUxRuyVY0Z4YswuCfuU4HNnd/xHJYmNIZhrmEnGVdkMNiH/hEwaQ
         SNRLleN62Xvmz/KHTwuQRHY51U8vplMcLBBbNSzV1Owy9H9qbKhnXaGqmEa79tTFFzUb
         vU+btdwafgxlmi3PSpesHCvwEjWATNupvOxUDz9LVYBCseImy1KutewoqwE2CpaUJjhZ
         xUC+BeeZ9Ib889VDY2KSrJ+fIhBP34+wc4LHFDLtZojcV+arH5R/XHsrT2nckRtRoQ/1
         3cFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRPHcaFKeV6wGy7fxNh/+7M0F4JkWRWMl+m84PUtw74=;
        b=UxPbboDTOnF4qeprTUgz/50OXNES4sRAosnbnpgWFV7xgjpF9GxzJuSP/8JknK1Jp7
         RNeRFTLbNeE9waaClsucXHlKEyDkIHJicuHQe7Dnwh0mh75gHtzAzCsIKJeu5In38zgz
         KgGo2okpXFl9NpkBj0W0yC1iLDXt50pEAFCWw/psEgQ9roq/SlKj+fUBx/GhcRbzfT6R
         fldeBFyk9x9l6ou+1RRudgZoOKhfyAL9bgzuN38dPyTwPdk/3zFB2lN8Ybd6SXwgbIKs
         L1SyXcg+hQ/h7iekjn3sZ3TDW8m9e4o59e3MYadjCuPuhfvLxAdzlywoqEi9liTdXhUb
         OjmA==
X-Gm-Message-State: AFqh2koO0x8lhgG/wtsBSmIrB1BlWDodY8shFG9IizaImavswaspBwL/
        /3MU6JQh8xnXb1RRYxRlDgsnnjQgjVFr6JUph6UrsOAYvKrHFTsIJ0U=
X-Google-Smtp-Source: AMrXdXsExPOqWl6nX0Zi5LuRRwSDUZeZFhwOyfbFJUfsSCcBligAn6pmuivYb2CSTwcxEZ/gYAunAlOYVpPggZEa5C0=
X-Received: by 2002:ac2:5f8e:0:b0:4ca:cca6:2093 with SMTP id
 r14-20020ac25f8e000000b004cacca62093mr4424727lfe.645.1673154360578; Sat, 07
 Jan 2023 21:06:00 -0800 (PST)
MIME-Version: 1.0
From:   Anthony Durity <anthony@durity.me>
Date:   Sun, 8 Jan 2023 05:05:49 +0000
Message-ID: <CAJc6SnfTSuzXTVhrKh7XY8TA2pScA3NEy7cn3y9vN_0uw2aLZA@mail.gmail.com>
Subject: iwlwifi kernel crash on PC Specialist LTD `NH5xAx`
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi there,

Don't know if this is the correct place to post this.

[    6.958634] ------------[ cut here ]------------
[    6.958635] WARNING: CPU: 12 PID: 961 at
drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:711
iwl_init_he_hw_capab+0x38e/0x3b0 [iwlwifi]
[    6.958651] Modules linked in: snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi iwlmvm(+) snd_hda_codec
snd_hda_core snd_hwdep intel_rapl_msr nvidia_drm(POE+)
intel_rapl_common nvidia_modeset(POE) binfmt_misc mac80211 snd_pcm
btusb uvcvideo btrtl snd_seq_midi btbcm snd_seq_midi_event joydev
btintel videobuf2_vmalloc btmtk edac_mce_amd videobuf2_memops libarc4
snd_rawmidi videobuf2_v4l2 nvidia(POE) nls_iso8859_1 bluetooth kvm_amd
snd_seq videobuf2_common iwlwifi snd_seq_device videodev snd_timer
drm_kms_helper ecdh_generic kvm mc ecc fb_sys_fops cfg80211 snd
syscopyarea sysfillrect ccp input_leds k10temp hid_multitouch
sysimgblt rapl soundcore efi_pstore wmi_bmof serio_raw mxm_wmi
clevo_wmi(OE) clevo_acpi(OE) tuxedo_io(OE) tuxedo_keyboard(OE) mac_hid
sparse_keymap sch_fq_codel overlay iptable_filter ip6table_filter
ip6_tables br_netfilter bridge stp llc arp_tables kyber_iosched
ipmi_devintf ipmi_msghandler msr
[    6.958686]  parport_pc ppdev lp parport drm ip_tables x_tables
autofs4 dm_crypt raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0
multipath linear system76_io(OE) system76_acpi(OE) r8169
rtsx_pci_sdmmc nvme hid_generic crct10dif_pclmul crc32_pclmul
polyval_clmulni polyval_generic ghash_clmulni_intel aesni_intel
crypto_simd cryptd psmouse i2c_piix4 ahci nvme_core xhci_pci rtsx_pci
realtek libahci xhci_pci_renesas nvme_common i2c_hid_acpi video
i2c_hid hid wmi gpio_amdpt
[    6.958710] CPU: 12 PID: 961 Comm: modprobe Tainted: P           OE
     6.0.12-76060006-generic #202212290932~1671652965~22.04~452ea9d
[    6.958712] Hardware name: PC Specialist LTD NH5xAx
         /NH5xAx, BIOS 1.07.07TPCS 06/03/2020
[    6.958714] RIP: 0010:iwl_init_he_hw_capab+0x38e/0x3b0 [iwlwifi]
[    6.958725] Code: fe ff ff 81 e9 10 01 00 00 83 f9 01 0f 86 60 fe
ff ff e9 65 fe ff ff 48 8d 86 a0 02 00 00 e9 14 fd ff ff 0f 0b e9 ca
fc ff ff <0f> 0b e9 e1 fe ff ff 0f 0b e9 08 ff ff ff e8 9f 02 c4 dc 66
66 2e
[    6.958726] RSP: 0018:ffffa22a0c10f928 EFLAGS: 00010246
[    6.958728] RAX: 0000000000000000 RBX: ffff92354bf34168 RCX: 0000000000000000
[    6.958729] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    6.958730] RBP: ffffa22a0c10f988 R08: 0000000000000000 R09: 0000000000000000
[    6.958731] R10: 0000000000000003 R11: 0000000000000003 R12: ffff92354c100028
[    6.958732] R13: ffff92354bf34000 R14: 0000000000000003 R15: 0000000000000003
[    6.958733] FS:  00007f394a61cc40(0000) GS:ffff923c3e900000(0000)
knlGS:0000000000000000
[    6.958734] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.958735] CR2: 00007f15cddcc5b0 CR3: 0000000119808000 CR4: 0000000000350ee0
[    6.958736] Call Trace:
[    6.958737]  <TASK>
[    6.958740]  iwl_init_sbands+0x265/0x2d0 [iwlwifi]
[    6.958751]  iwl_get_nvm+0x245/0x2e0 [iwlwifi]
[    6.958763]  iwl_run_unified_mvm_ucode+0x209/0x250 [iwlmvm]
[    6.958778]  ? iwl_run_unified_mvm_ucode+0x209/0x250 [iwlmvm]
[    6.958789]  ? iwl_read32+0x24/0x90 [iwlwifi]
[    6.958800]  ? 0xffffffffc12ac000
[    6.958803]  iwl_run_init_mvm_ucode+0x29/0x40 [iwlmvm]
[    6.958813]  iwl_mvm_start_get_nvm+0xad/0x280 [iwlmvm]
[    6.958826]  iwl_op_mode_mvm_start+0x7e4/0xa50 [iwlmvm]
[    6.958838]  _iwl_op_mode_start+0x78/0xe0 [iwlwifi]
[    6.958850]  iwl_opmode_register+0x6d/0xf0 [iwlwifi]
[    6.958861]  ? 0xffffffffc1343000
[    6.958862]  iwl_mvm_init+0x3a/0x1000 [iwlmvm]
[    6.958876]  ? 0xffffffffc1343000
[    6.958877]  do_one_initcall+0x49/0x220
[    6.958880]  ? kmem_cache_alloc_trace+0x160/0x330
[    6.958883]  do_init_module+0x52/0x220
[    6.958886]  load_module+0xac1/0xc80
[    6.958887]  ? security_kernel_post_read_file+0x5c/0x80
[    6.958891]  ? kernel_read_file+0x25c/0x2b0
[    6.958893]  __do_sys_finit_module+0xcc/0x150
[    6.958895]  ? __do_sys_finit_module+0xcc/0x150
[    6.958898]  __x64_sys_finit_module+0x18/0x30
[    6.958899]  do_syscall_64+0x5c/0x90
[    6.958902]  ? exit_to_user_mode_prepare+0xaf/0xd0
[    6.958904]  ? syscall_exit_to_user_mode+0x2a/0x50
[    6.958905]  ? do_syscall_64+0x69/0x90
[    6.958907]  ? syscall_exit_to_user_mode+0x2a/0x50
[    6.958908]  ? do_syscall_64+0x69/0x90
[    6.958910]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[    6.958912] RIP: 0033:0x7f3949d1ea3d
[    6.958913] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 a3 0f 00 f7 d8 64 89
01 48
[    6.958914] RSP: 002b:00007fff17b88848 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    6.958916] RAX: ffffffffffffffda RBX: 000055da5ec4f150 RCX: 00007f3949d1ea3d
[    6.958917] RDX: 0000000000000000 RSI: 000055da5cd4fcd2 RDI: 0000000000000002
[    6.958918] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000002
[    6.958918] R10: 0000000000000002 R11: 0000000000000246 R12: 000055da5cd4fcd2
[    6.958919] R13: 000055da5ec4e3a0 R14: 000055da5ec4e730 R15: 000055da5ec5c7b0
[    6.958921]  </TASK>
[    6.958922] ---[ end trace 0000000000000000 ]--

Hope this helps someone,
    Anthony
