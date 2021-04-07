Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192B63566D8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 10:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbhDGIaz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 04:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241210AbhDGIaw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 04:30:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6A3C06174A
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 01:30:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g18-20020a7bc4d20000b0290116042cfdd8so668267wmk.4
        for <linux-wireless@vger.kernel.org>; Wed, 07 Apr 2021 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YLnCZ0h0X0xLMJRg1GSzFOWAC2+92qDrfz2kro3fPjs=;
        b=Cy7a6zka83cYUyql2zIJhcfGPtkXOHOORXgTkSgCj/R+BN+7sVamjQPCsRXF+H22EQ
         1JyFxh6I0yJIzDTfMZvTwKBk/73AqPRI5W6dZBhaQJaeCiQEat/k2almOxxgkDqkfA2T
         lNUvdQyWBcEBv1EEoYPiA0pFTXAmi0fdcr/dZdg06ppEvNKYj5AtgZZrGORxOX3PJLCH
         vaCqibeDm8NhREf5CkajMt1zuVaRRb4ft0D1OObTTulCCjhkur+HDVKKUXtXSqp5spDi
         MF5WlQt8IsOBbR2hEIpyXTMOqP4+T8/WEh573SwT+ObZlLt48y2N+ORopzbzcpUtEBEb
         8Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YLnCZ0h0X0xLMJRg1GSzFOWAC2+92qDrfz2kro3fPjs=;
        b=oK4uZTW2BgfwApV6cIoY7WRWdnZ/16t6epj11OOaCzAisLOOKLwWGd4V/vdHarRDwX
         VZruVTgT1b7NoaO6NvrFpIFCm1oj0bdXGWYsN+Qwrz+VT45Q/ssWX4V/hVgpsYYdteQh
         7QozhjweWoF1lKksDKBNnpDWmqLWDCRs1DKmxDMLi38aOYaUb0P7SH92/Q/lTHf8hoUY
         kQK4RnOesX2hnp5GPbp/5z+ZwkZUKI7ZFhXXDFPpcKlhKq9aVouv/aI8fTuIS7Ba5WVH
         yjbIMzTkjmf2g05zjYq8qJIzDWPAZGLIjMx+C7vqJjeVgc5WTt54kQDbSxxxmsXxD0D+
         WxBw==
X-Gm-Message-State: AOAM531sD1sNitWpvGxtA6VpchvFhtHkfXvIJsq9npchTr75UBPzRdqq
        lJw9xcz9/T9GDN8KRHOEtn5i8R5XePk=
X-Google-Smtp-Source: ABdhPJyxd6H9CrPJS9+Cawx/P8m5DbySyL/9MBHoHc5BBaetDGL0B5fypI2mnfNk5/DCbORKmEjjqA==
X-Received: by 2002:a7b:cbc1:: with SMTP id n1mr1989947wmi.50.1617784241804;
        Wed, 07 Apr 2021 01:30:41 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:15f8:68c8:25bd:c1f8? (p200300ea8f38460015f868c825bdc1f8.dip0.t-ipconnect.de. [2003:ea:8f38:4600:15f8:68c8:25bd:c1f8])
        by smtp.googlemail.com with ESMTPSA id h25sm8383507wml.32.2021.04.07.01.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 01:30:41 -0700 (PDT)
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <b71f7f03-fa87-74ab-4f10-5cebe3e70b60@gmail.com>
 <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm>
 <95b6c4b34da1173faf226246ea25b47a8fd395b7.camel@sipsolutions.net>
 <5c35de6e8e73fedb58e81919f465fe4038dacbbb.camel@sipsolutions.net>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <fa68f26e-9d53-d057-d996-1c7676b85af5@gmail.com>
Date:   Wed, 7 Apr 2021 10:30:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <5c35de6e8e73fedb58e81919f465fe4038dacbbb.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 07.04.2021 09:56, Johannes Berg wrote:
> On Wed, 2021-04-07 at 09:55 +0200, Johannes Berg wrote:
>> On Wed, 2021-04-07 at 09:51 +0200, Jiri Kosina wrote:
>>> On Wed, 7 Apr 2021, Heiner Kallweit wrote:
>>>
>>>> Same fix as in 2800aadc18a6 ("iwlwifi: Fix softirq/hardirq disabling in
>>>> iwl_pcie_enqueue_hcmd()") is needed for iwl_pcie_gen2_enqueue_hcmd.
>>>> I get the same lockdep warning on AX210.
>>>
>>> Makes sense, it's being called from exactly the same contexts.
>>
>> I'm guessing nobody saw this before because the LEDs stuff is not
>> supported/used on newer devices :)
> 
> Eh, wait, Heiner said he sees the same warning? With LEDs? I was pretty
> sure that's not supported by the later firmware, but maybe some other
> path? Anyway this fix seems right.
> 
> johannes
> 

For your reference here the warning I got.

[   27.645349] ------------[ cut here ]------------
[   27.645453] WARNING: CPU: 1 PID: 2323 at kernel/softirq.c:364 __local_bh_enable_ip+0x85/0xc0
[   27.645516] Modules linked in: snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio cmac bnep iwlmvm led_class vfat fat mac80211 libarc4 iwlwifi x86_pkg_temp_thermal coretemp i915 btusb btintel bluetooth snd_hda_intel snd_intel_dspcfg aesni_intel r8169 cfg80211 realtek ecdh_generic snd_hda_codec mdio_devres crypto_simd i2c_i801 rfkill intel_gtt ecc mei_me cryptd i2c_smbus snd_hda_core libphy mei i2c_algo_bit snd_pcm drm_kms_helper syscopyarea sysfillrect sysimgblt snd_timer fb_sys_fops snd sch_fq_codel crypto_user drm efivarfs ext4 mbcache jbd2 ums_realtek crc32c_intel ahci libahci libata
[   27.645991] CPU: 1 PID: 2323 Comm: ip Not tainted 5.12.0-rc6-next-20210406+ #4
[   27.646040] Hardware name: NA ZBOX-CI327NANO-GS-01/ZBOX-CI327NANO-GS-01, BIOS 5.12 04/28/2020
[   27.646094] RIP: 0010:__local_bh_enable_ip+0x85/0xc0
[   27.646132] Code: 8b 05 af c6 ba 47 a9 00 ff ff 00 74 32 65 ff 0d a1 c6 ba 47 e8 7c b4 0e 00 fb 5b 41 5c 5d c3 65 8b 05 6b cc ba 47 85 c0 75 ae <0f> 0b eb aa e8 92 b3 0e 00 eb ab 4c 89 e7 e8 18 ff 05 00 eb b4 65
[   27.646275] RSP: 0018:ffffbb574062b1b8 EFLAGS: 00010046
[   27.646311] RAX: 0000000000000000 RBX: 0000000000000201 RCX: 0000000000000000
[   27.646355] RDX: 0000000000000003 RSI: 0000000000000201 RDI: ffffffffc051192b
[   27.646401] RBP: ffffbb574062b1c8 R08: 0000000000000000 R09: 0000000000000001
[   27.646444] R10: ffff9eec03243e00 R11: 0000000000000000 R12: ffffffffc051192b
[   27.646488] R13: ffff9eec07e72b40 R14: 0000000000000001 R15: 0000000000000000
[   27.646533] FS:  00007fce73f11740(0000) GS:ffff9eec7bc80000(0000) knlGS:0000000000000000
[   27.646584] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.646622] CR2: 00005581ebf10cc0 CR3: 0000000102924000 CR4: 00000000003506e0
[   27.646668] Call Trace:
[   27.646687]  _raw_spin_unlock_bh+0x2c/0x40
[   27.646718]  iwl_pcie_gen2_enqueue_hcmd+0x50b/0x890 [iwlwifi]
[   27.646781]  iwl_trans_txq_send_hcmd+0x68/0x3b0 [iwlwifi]
[   27.646836]  iwl_trans_send_cmd+0x7d/0x170 [iwlwifi]
[   27.646888]  iwl_mvm_send_cmd+0x29/0x80 [iwlmvm]
[   27.646942]  iwl_mvm_led_set+0xa5/0xd0 [iwlmvm]
[   27.646995]  iwl_led_brightness_set+0x1a/0x20 [iwlmvm]
[   27.647050]  led_set_brightness_nosleep+0x24/0x50
[   27.647085]  led_set_brightness+0x41/0x50
[   27.647115]  led_trigger_event+0x46/0x70
[   27.647143]  ieee80211_led_radio+0x24/0x30 [mac80211]
[   27.647288]  ieee80211_do_open+0x4c4/0x9a0 [mac80211]
[   27.647379]  ieee80211_open+0x69/0x90 [mac80211]
[   27.647487]  __dev_open+0xd6/0x190
[   27.647517]  __dev_change_flags+0x1b2/0x230
[   27.647548]  dev_change_flags+0x21/0x60
[   27.647577]  do_setlink+0x289/0x1190
[   27.647607]  ? __nla_validate_parse+0x60/0xbd0
[   27.647644]  __rtnl_newlink+0x61c/0xa10
[   27.647677]  ? mark_lock+0x25/0x1110
[   27.647709]  ? rcu_read_lock_sched_held+0x41/0x80
[   27.647744]  ? kmem_cache_alloc_trace+0x21e/0x250
[   27.647781]  rtnl_newlink+0x44/0x70
[   27.647808]  rtnetlink_rcv_msg+0x17f/0x4b0
[   27.647838]  ? netlink_deliver_tap+0x10e/0x3f0
[   27.647873]  ? find_held_lock+0x31/0x90
[   27.647902]  ? netlink_deliver_tap+0x10e/0x3f0
[   27.647934]  ? rtnetlink_put_metrics+0x1d0/0x1d0
[   27.647967]  netlink_rcv_skb+0x50/0xf0
[   27.648000]  rtnetlink_rcv+0x10/0x20
[   27.648027]  netlink_unicast+0x1a3/0x270
[   27.648056]  netlink_sendmsg+0x22c/0x430
[   27.648085]  ? netlink_unicast+0x270/0x270
[   27.648116]  ____sys_sendmsg+0x2a6/0x2e0
[   27.648147]  ? import_iovec+0x1b/0x20
[   27.648179]  ? sendmsg_copy_msghdr+0x79/0xa0
[   27.648211]  ___sys_sendmsg+0x82/0xc0
[   27.648240]  __sys_sendmsg+0x62/0xb0
[   27.648268]  ? syscall_enter_from_user_mode+0x21/0x60
[   27.648307]  __x64_sys_sendmsg+0x1a/0x20
[   27.648337]  do_syscall_64+0x38/0x50
[   27.648366]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   27.648403] RIP: 0033:0x7fce74030737
[   27.648433] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[   27.648547] RSP: 002b:00007ffdd61d1498 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   27.648600] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fce74030737
[   27.648645] RDX: 0000000000000000 RSI: 00007ffdd61d1500 RDI: 0000000000000003
[   27.648691] RBP: 00000000606d6d4f R08: 0000000000000001 R09: 00007fce740f1a60
[   27.648736] R10: 0000000000000230 R11: 0000000000000246 R12: 0000000000000001
[   27.648782] R13: 00007ffdd61d15d0 R14: 0000000000000000 R15: 00005581ebec6020
[   27.648830] irq event stamp: 94495
[   27.648855] hardirqs last  enabled at (94493): [<ffffffffb846a864>] __local_bh_enable_ip+0x74/0xc0
[   27.648917] hardirqs last disabled at (94494): [<ffffffffb8bf198f>] _raw_read_lock_irqsave+0x7f/0x90
[   27.648977] softirqs last  enabled at (94492): [<ffffffffc051192b>] iwl_pcie_gen2_enqueue_hcmd+0x50b/0x890 [iwlwifi]
[   27.649064] softirqs last disabled at (94495): [<ffffffffc0511516>] iwl_pcie_gen2_enqueue_hcmd+0xf6/0x890 [iwlwifi]
[   27.649151] ---[ end trace da6e11a6f99dba37 ]---
[   27.649242] ------------[ cut here ]------------
[   27.649326] raw_local_irq_restore() called with IRQs enabled
[   27.649367] WARNING: CPU: 1 PID: 2323 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x22/0x30
[   27.649433] Modules linked in: snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio cmac bnep iwlmvm led_class vfat fat mac80211 libarc4 iwlwifi x86_pkg_temp_thermal coretemp i915 btusb btintel bluetooth snd_hda_intel snd_intel_dspcfg aesni_intel r8169 cfg80211 realtek ecdh_generic snd_hda_codec mdio_devres crypto_simd i2c_i801 rfkill intel_gtt ecc mei_me cryptd i2c_smbus snd_hda_core libphy mei i2c_algo_bit snd_pcm drm_kms_helper syscopyarea sysfillrect sysimgblt snd_timer fb_sys_fops snd sch_fq_codel crypto_user drm efivarfs ext4 mbcache jbd2 ums_realtek crc32c_intel ahci libahci libata
[   27.649900] CPU: 1 PID: 2323 Comm: ip Tainted: G        W         5.12.0-rc6-next-20210406+ #4
[   27.649956] Hardware name: NA ZBOX-CI327NANO-GS-01/ZBOX-CI327NANO-GS-01, BIOS 5.12 04/28/2020
[   27.650010] RIP: 0010:warn_bogus_irq_restore+0x22/0x30
[   27.650047] Code: cc cc cc cc cc cc cc cc 55 48 89 e5 80 3d ca 51 9f 00 00 74 02 5d c3 48 c7 c7 18 07 21 b9 c6 05 b8 51 9f 00 01 e8 12 f8 fc ff <0f> 0b 5d c3 cc cc cc cc cc cc cc cc cc cc 55 48 89 e5 41 54 53 44
[   27.650177] RSP: 0018:ffffbb574062b3d0 EFLAGS: 00010286
[   27.650216] RAX: 0000000000000000 RBX: 0000000000000200 RCX: ffff9eec7bc976f8
[   27.650303] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9eec7bc976f0
[   27.650423] RBP: ffffbb574062b3d0 R08: 0000000000000001 R09: 0000000000000001
[   27.650542] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: ffff9eec08e9ac78
[   27.650661] R13: 00000000000000ff R14: 0000000000000286 R15: ffff9eec08e9ac78
[   27.650781] FS:  00007fce73f11740(0000) GS:ffff9eec7bc80000(0000) knlGS:0000000000000000
[   27.650919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.651070] CR2: 00005581ebf10cc0 CR3: 0000000102924000 CR4: 00000000003506e0
[   27.651243] Call Trace:
[   27.651298]  _raw_read_unlock_irqrestore+0x4f/0x60
[   27.651392]  led_trigger_event+0x64/0x70
[   27.651470]  ieee80211_led_radio+0x24/0x30 [mac80211]
[   27.651758]  ieee80211_do_open+0x4c4/0x9a0 [mac80211]
[   27.652006]  ieee80211_open+0x69/0x90 [mac80211]
[   27.652334]  __dev_open+0xd6/0x190
[   27.652407]  __dev_change_flags+0x1b2/0x230
[   27.652490]  dev_change_flags+0x21/0x60
[   27.652566]  do_setlink+0x289/0x1190
[   27.652641]  ? __nla_validate_parse+0x60/0xbd0
[   27.652729]  __rtnl_newlink+0x61c/0xa10
[   27.652809]  ? mark_lock+0x25/0x1110
[   27.652886]  ? rcu_read_lock_sched_held+0x41/0x80
[   27.652977]  ? kmem_cache_alloc_trace+0x21e/0x250
[   27.653068]  rtnl_newlink+0x44/0x70
[   27.653139]  rtnetlink_rcv_msg+0x17f/0x4b0
[   27.653257]  ? netlink_deliver_tap+0x10e/0x3f0
[   27.653343]  ? find_held_lock+0x31/0x90
[   27.653419]  ? netlink_deliver_tap+0x10e/0x3f0
[   27.653504]  ? rtnetlink_put_metrics+0x1d0/0x1d0
[   27.653591]  netlink_rcv_skb+0x50/0xf0
[   27.653667]  rtnetlink_rcv+0x10/0x20
[   27.653738]  netlink_unicast+0x1a3/0x270
[   27.653816]  netlink_sendmsg+0x22c/0x430
[   27.653893]  ? netlink_unicast+0x270/0x270
[   27.653973]  ____sys_sendmsg+0x2a6/0x2e0
[   27.654052]  ? import_iovec+0x1b/0x20
[   27.654127]  ? sendmsg_copy_msghdr+0x79/0xa0
[   27.654250]  ___sys_sendmsg+0x82/0xc0
[   27.654332]  __sys_sendmsg+0x62/0xb0
[   27.654407]  ? syscall_enter_from_user_mode+0x21/0x60
[   27.654502]  __x64_sys_sendmsg+0x1a/0x20
[   27.654581]  do_syscall_64+0x38/0x50
[   27.654654]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   27.654748] RIP: 0033:0x7fce74030737
[   27.654819] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[   27.655111] RSP: 002b:00007ffdd61d1498 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   27.655284] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fce74030737
[   27.655405] RDX: 0000000000000000 RSI: 00007ffdd61d1500 RDI: 0000000000000003
[   27.655523] RBP: 00000000606d6d4f R08: 0000000000000001 R09: 00007fce740f1a60
[   27.655641] R10: 0000000000000230 R11: 0000000000000246 R12: 0000000000000001
[   27.655759] R13: 00007ffdd61d15d0 R14: 0000000000000000 R15: 00005581ebec6020
[   27.655879] irq event stamp: 95385
[   27.655944] hardirqs last  enabled at (95393): [<ffffffffb84d2270>] console_unlock+0x4a0/0x5c0
[   27.656093] hardirqs last disabled at (95400): [<ffffffffb84d21e3>] console_unlock+0x413/0x5c0
[   27.656275] softirqs last  enabled at (95022): [<ffffffffb846a9ec>] irq_exit_rcu+0xac/0xe0
[   27.656420] softirqs last disabled at (95017): [<ffffffffb846a9ec>] irq_exit_rcu+0xac/0xe0
[   27.656561] ---[ end trace da6e11a6f99dba38 ]---
