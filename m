Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFFB6A334E
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Feb 2023 18:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBZRxJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Feb 2023 12:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZRxJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Feb 2023 12:53:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAD4901D
        for <linux-wireless@vger.kernel.org>; Sun, 26 Feb 2023 09:53:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 596EB60C16
        for <linux-wireless@vger.kernel.org>; Sun, 26 Feb 2023 17:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC04C433D2;
        Sun, 26 Feb 2023 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677433986;
        bh=pZF4+1MelKbYGh1VYRntDteYnJiML0WWelGupVvhoMc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OoVijxPfLeDqBfioyzqcLNA1ZW5s7nWkUCxGGbfsaaiPYqV2CqV8wYtuRkKaOvSnT
         pQMvGnFbwhf0OIt1iAL7Mbi+wPVut69HDm6RBC3p7T6f0fTaCsas7o0/zBrOF5J5oO
         aTzgLvRDWY8WzO3kk8OLJLbKiwS+T3ela/9+Xy4slrOJO60lXc4LhrmEspD5B+VOsc
         u5fzn6yO+2WhFz80Y4ypjKRSdwyfNO+0N7Dm8KnqSqP2kR8Bym4avmAtBhFCCAgBNr
         YsV2IUuLXa40fRAmqugknGoOvLfB47InEo2xeyFxHWFjAKmyOcpTCQ00roEScrb80J
         upEjilxrZ7D+A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: mt76: usb: fix use-after-free in
 mt76u_free_rx_queue
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <f2398f68011c976510c81e1964975b677e65860e.1677193208.git.lorenzo@kernel.org>
References: <f2398f68011c976510c81e1964975b677e65860e.1677193208.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, mikhail.v.gavrilov@gmail.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167743398189.7100.15237024063573420378.kvalo@kernel.org>
Date:   Sun, 26 Feb 2023 17:53:05 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix the following use-after-free issue in mt76u_free_rx_queue routine:
> 
> usb 3-3.3.4: reset high-speed USB device number 8 using xhci_hcd
> iwlwifi 0000:05:00.0: Detected RF HR B3, rfid=0x10a100
> iwlwifi 0000:05:00.0: base HW address: 50:eb:71:79:02:57
> iwlwifi 0000:05:00.0 wlp5s0: renamed from wlan0
> mt76x2u 3-3.3.4:1.0: ASIC revision: 76320044
> usb 3-3.3.1: 1:3 : unsupported format bits 0x100000000
> mt76x2u 3-3.3.4:1.0: could not get hardware semaphore for ROM PATCH
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 13 PID: 983 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
> Modules linked in: snd_seq_midi snd_seq_midi_event mt76x2u(+)
> mt76x2_common mt76x02_usb mt76_usb iwlmvm mt76x02_lib mt76
> snd_hda_codec_realtek intel_rapl_msr snd_hda_codec_generic
> snd_hda_codec_hdmi intel_rapl_common snd_hda_intel mac80211
> snd_intel_dspcfg snd_usb_audio(+) snd_intel_sdw_acpi btusb
> edac_mce_amd snd_hda_codec btrtl btbcm snd_usbmidi_lib snd_hda_core
> btintel snd_rawmidi btmtk snd_hwdep libarc4 mc iwlwifi kvm_amd snd_seq
> vfat bluetooth eeepc_wmi asus_ec_sensors snd_seq_device fat kvm
> cfg80211 asus_wmi snd_pcm irqbypass ledtrig_audio sparse_keymap rapl
> wmi_bmof platform_profile xpad snd_timer k10temp ff_memless i2c_piix4
> rfkill snd joydev soundcore acpi_cpufreq loop zram amdgpu
> crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
> polyval_generic drm_ttm_helper ttm video iommu_v2 ucsi_ccg drm_buddy
> gpu_sched typec_ucsi ghash_clmulni_intel drm_display_helper igb
> sha512_ssse3 typec ccp nvme cec sp5100_tco nvme_core dca nvme_common
> wmi ip6_tables ip_tables fuse
> BTRFS info (device nvme1n1): enabling ssd optimizations
> CPU: 13 PID: 983 Comm: (udev-worker) Tainted: G        W    L
> -------  ---  6.3.0-0.rc0.20230222git5b7c4cabbb65.3.fc39.x86_64+debug
> BTRFS info (device nvme1n1): auto enabling async discard
> Hardware name: System manufacturer System Product Name/ROG STRIX
> X570-I GAMING, BIOS 4601 02/02/2023
> RIP: 0010:refcount_warn_saturate+0xba/0x110
> Code: 01 01 e8 69 a6 83 ff 0f 0b e9 52 f4 85 00 80 3d 69 6f ec 01 00
> 75 85 48 c7 c7 d0 25 b3 a9 c6 05 59 6f ec 01 01 e8 46 a6 83 ff <0f> 0b
> e9 2f f4 85 00 80 3d 47 6f ec 01 00 0f 85 5e ff ff ff 48 c7
> RSP: 0018:ffffb4010456fb78 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000080000000 RCX: 0000000000000000
> RDX: 0000000000000002 RSI: ffffffffa9b17e3e RDI: 00000000ffffffff
> RBP: ffff8d15877336c0 R08: 0000000000000000 R09: ffffb4010456fa00
> R10: 0000000000000003 R11: ffff8d246e2fffe8 R12: 0000000000000080
> R13: ffff8d15b42fd000 R14: 0000000000000000 R15: ffff8d1587736a58
> FS:  00007fc05ae34940(0000) GS:ffff8d2425e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055d801f1d540 CR3: 000000011df60000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  mt76u_queues_deinit+0x2a0/0x370 [mt76_usb]
>  mt76x2u_probe+0xf3/0x130 [mt76x2u]
>  usb_probe_interface+0xe8/0x300
>  really_probe+0x1b6/0x410
>  __driver_probe_device+0x78/0x170
>  driver_probe_device+0x1f/0x90
>  __driver_attach+0xd2/0x1c0
>  ? __pfx___driver_attach+0x10/0x10
>  bus_for_each_dev+0x8a/0xd0
>  bus_add_driver+0x141/0x230
>  driver_register+0x77/0x120
>  usb_register_driver+0xaf/0x170
>  ? __pfx_init_module+0x10/0x10 [mt76x2u]
>  do_one_initcall+0x6e/0x350
>  do_init_module+0x4a/0x220
>  __do_sys_init_module+0x192/0x1c0
>  ? lock_is_held_type+0xce/0x120
>  do_syscall_64+0x5b/0x80
>  ? lock_is_held_type+0xce/0x120
>  ? asm_exc_page_fault+0x22/0x30
>  ? lockdep_hardirqs_on+0x7d/0x100
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fc05b1351be
> Code: 48 8b 0d 4d 0c 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d 1a 0c 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd947c0988 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> RAX: ffffffffffffffda RBX: 000055d801f2b090 RCX: 00007fc05b1351be
> RDX: 00007fc05b65c07d RSI: 00000000000234be RDI: 000055d802c6b170
> RBP: 00007ffd947c0a40 R08: 000055d8019b4690 R09: 0000000000022000
> R10: 000000055d8019b4 R11: 0000000000000246 R12: 00007fc05b65c07d
> R13: 0000000000020000 R14: 000055d801f39770 R15: 000055d801f47780
>  </TASK>
> irq event stamp: 186313
> hardirqs last  enabled at (186323): [<ffffffffa81c675e>]
> __up_console_sem+0x5e/0x70
> hardirqs last disabled at (186332): [<ffffffffa81c6743>]
> __up_console_sem+0x43/0x70
> softirqs last  enabled at (186022): [<ffffffffa811d2f7>]
> __irq_exit_rcu+0xd7/0x160
> softirqs last disabled at (186017): [<ffffffffa811d2f7>]
> __irq_exit_rcu+0xd7/0x160
> ---[ end trace 0000000000000000 ]---
> mt76x2u: probe of 3-3.3.4:1.0 failed with error -110
> usbcore: registered new interface driver mt76x2u
> kauditd_printk_skb: 32 callbacks suppressed
> 
> Fixes: 2f5c3c77fc9b ("wifi: mt76: switch to page_pool allocator")
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless.git, thanks.

cf45efcb250e wifi: mt76: usb: fix use-after-free in mt76u_free_rx_queue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/f2398f68011c976510c81e1964975b677e65860e.1677193208.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

