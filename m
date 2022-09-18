Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329E75BBE66
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Sep 2022 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIROdY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 10:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIROdW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 10:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A771EC56
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663511599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PA5L3Ve4x1vIggfYVl79AfGzEXdCkxkRq/K9eN7R16c=;
        b=dOwbT3MoqruovUONZNBJKSL1EEDd/EkoTpYRC9SuvVaO6A8UVHjGBRR78mMxTpTVDmaJ8e
        dFdEhP2yeSzxyu42UBfzdWPI4WL99m6J5DPW82m3GuitCG/Yrj4auQjyzq+3kOcA74fUvo
        o5o/9Ref4B+wvVC2VcVS9f2J2E/g45o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-VWD7XUSTPMOdcAVgh7Wv3Q-1; Sun, 18 Sep 2022 10:33:18 -0400
X-MC-Unique: VWD7XUSTPMOdcAVgh7Wv3Q-1
Received: by mail-ed1-f72.google.com with SMTP id m13-20020a056402510d00b004519332f0b1so15005302edd.7
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 07:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PA5L3Ve4x1vIggfYVl79AfGzEXdCkxkRq/K9eN7R16c=;
        b=YFCht8UmU0KTFa9NWARqbu12LVBW5MdFpE01cQmYHd3FGZ9CrPCF3fzpMN3EbyqkhT
         j3V/FtrjxeALrf3zC34RlRw1pcVYfhPZjE+twaK8S+NL50LWZQ8rA+42n57j9i1FdRJh
         btOmon7OfkOaZ/p1+P3Gf1G7toZwKiS9/1eRAAiNa5gzV4x7xAT1lIXKE3U8FL66CCDE
         FmYR/DpRg4NipNHk2PUz4oFsndf8rSphEUFBWseGxnZxxNDvF8AHddthSjuYoWkNblyP
         OvW+AHEVmhxMWhly5jNK7tpyPPAYLHEC92iFIbND4naNKYK5duG6wqk4WhuNyKCwCBvJ
         dePg==
X-Gm-Message-State: ACrzQf0k8uiTJSYHNjxdzg3tZSmq5XW74D3PnTQ+sHJr4ok64W/Xu3SY
        Fh1nRiTaz6SCy2Y0/QMAKJFw4+s2Y/fAoZcvm6mg6WdsyP4Mbuo//auFZQukskm8Pd9yAg2KOnj
        dSWJnVlap7kcl3jZ9ZQO4Hgtrxz0=
X-Received: by 2002:a05:6402:51cb:b0:451:6ede:88e3 with SMTP id r11-20020a05640251cb00b004516ede88e3mr11309370edd.45.1663511596607;
        Sun, 18 Sep 2022 07:33:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7B8oA4i2u5Z2g9aj+/AlrxqnyJzB+Lwl13RO4zqbSwvWqEPWTzsZUIOJYOkD4hy9Ny/flUjA==
X-Received: by 2002:a05:6402:51cb:b0:451:6ede:88e3 with SMTP id r11-20020a05640251cb00b004516ede88e3mr11309352edd.45.1663511596320;
        Sun, 18 Sep 2022 07:33:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id v23-20020aa7cd57000000b0044e796598bdsm17995674edw.11.2022.09.18.07.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 07:33:15 -0700 (PDT)
Message-ID: <091ccc63-8f0b-322f-3cb6-d4dc4e587fc1@redhat.com>
Date:   Sun, 18 Sep 2022 16:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 0/1] rt2x00 WA for mac80211 core (BUG?) submitting skb-s
 with queue-ids >= hw.queues
Content-Language: en-US
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
References: <20220908173618.155291-1-hdegoede@redhat.com>
 <20220915190107.GB10590@wp.pl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220915190107.GB10590@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 9/15/22 21:01, Stanislaw Gruszka wrote:
> On Thu, Sep 08, 2022 at 07:36:17PM +0200, Hans de Goede wrote:
>> I'm seeing the mac80211 core submitting skb-s with queue-ids >= hw.queues
>> on a ralink rt2500 PCI card which causes rt2x00queue_get_tx_queue() to
>> return NULL and the following error to be logged: "ieee80211 phy0:
>> rt2x00mac_tx: Error - Attempt to send packet over invalid queue 2",
>> after which association with the AP fails.
>>
>> I have a hunch that although I've come up with a quick fix in the rt2x00 
>> driver, that this is really an issue with the mac80211 core and that
>> the core should never submit skb-s where skb_get_queue_mapping()
>> returns a value >= ieee80211_hw.queues ?
> 
> Yes, most likely this is mac80211 problem and other prehistoric cards
> will not work. 
> 
> Maybe this commit is related to the issue ?
> 
> commit 10cb8e617560fc050a759a897a2dde07a5fe04cb
> Author: Markus Theil <markus.theil@tu-ilmenau.de>
> Date:   Sat Feb 6 12:51:12 2021 +0100
> 
>     mac80211: enable QoS support for nl80211 ctrl port
> 
> If someone have time, could look at it, but not sure if we 
> have any working hardware except yours rt2500 that require this :-)

Thanks, that commit indeed is the culprit. I have prepared a fix for
this at the mac80211 core level. I just need to write a commit message
now and then I will submit it upstream.

Regards,

Hans


>> Because of this hunch I have added a WARN_ON(1) when the workaround
>> triggered to see what I would get. This results in the following
>> 2 backtraces just after associating with my ISP provisioned access-point:
>>
>> [   58.263794] ------------[ cut here ]------------
>> [   58.263831] WARNING: CPU: 0 PID: 662 at drivers/net/wireless/ralink/rt2x00/rt2x00.h:1316 rt2x00mac_tx+0x59/0x3a0 [rt2x00lib]
>> [   58.263856] Modules linked in: rt2500pci(E) rt2x00pci(E) rt2x00mmio(E) rt2x00lib(E) mac80211 libarc4 snd_atiixp_modem snd_atiixp snd_ac97_codec ac97_bus cfg80211 snd_seq snd_seq_device snd_pcm joydev edac_mce_amd snd_timer 8139too eeprom_93cx6 pcspkr snd 8139cp mii k8temp soundcore qrtr rfkill i2c_piix4 zram amdgpu iommu_v2 gpu_sched drm_buddy radeon video wmi sdhci_pci drm_ttm_helper cqhci ttm sdhci firewire_ohci drm_display_helper firewire_core mmc_core ata_generic pata_acpi serio_raw yenta_socket cec crc_itu_t pata_atiixp ip6_tables ip_tables i2c_dev fuse
>> [   58.264061] CPU: 0 PID: 662 Comm: wpa_supplicant Tainted: G            E      6.0.0-rc3+ #112
>> [   58.264069] Hardware name: MICRO-STAR INT'L CO.,LTD MS-1013, BIOS A1013AMS V4.30 01/09/2006
>> [   58.264074] RIP: 0010:rt2x00mac_tx+0x59/0x3a0 [rt2x00lib]
>> [   58.264088] Code: 8b 54 24 08 49 89 f5 8b 4a 18 f6 43 28 20 0f 85 cb 00 00 00 44 0f b7 f8 41 8d 77 fe 83 fe 01 77 56 83 f9 02 0f 87 10 01 00 00 <0f> 0b 83 f9 02 75 12 4d 8b b4 24 98 11 00 00 b8 60 01 00 00 4d 85
>> [   58.264094] RSP: 0018:ffffa30501c63780 EFLAGS: 00010246
>> [   58.264103] RAX: 0000000000000002 RBX: ffff93df43ab3e00 RCX: 0000000000000002
>> [   58.264108] RDX: ffffffffc123c4a0 RSI: 0000000000000000 RDI: ffff93df4b3c8e00
>> [   58.264113] RBP: ffff93df4b3c8e00 R08: 0000000000000001 R09: 0000000000000001
>> [   58.264118] R10: ffff93df49860000 R11: 000000000001103d R12: ffff93df4b3cb3c0
>> [   58.264123] R13: ffffa30501c637e8 R14: ffff93df4b3c9440 R15: 0000000000000002
>> [   58.264128] FS:  00007feddd63c7c0(0000) GS:ffff93dfb9c00000(0000) knlGS:0000000000000000
>> [   58.264134] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   58.264139] CR2: 0000557d841633c8 CR3: 000000000994a000 CR4: 00000000000006f0
>> [   58.264145] Call Trace:
>> [   58.264149]  <TASK>
>> [   58.264154]  ? _raw_spin_unlock_irqrestore+0x30/0x60
>> [   58.264176]  ieee80211_process_measurement_req+0x2ca/0x890 [mac80211]
>> [   58.264274]  ieee80211_next_txq+0x2162/0x2790 [mac80211]
>> [   58.264335]  ieee80211_tx_prepare_skb+0x250/0x290 [mac80211]
>> [   58.264426]  __ieee80211_subif_start_xmit+0x21f/0x410 [mac80211]
>> [   58.264499]  ieee80211_tx_control_port+0x2d5/0x5a0 [mac80211]
>> [   58.264572]  nl80211_tx_control_port+0x1cb/0x380 [cfg80211]
>> [   58.264864]  genl_family_rcv_msg_doit+0xd0/0x120
>> [   58.264901]  genl_rcv_msg+0xca/0x1c0
>> [   58.264912]  ? nl80211_prepare_wdev_dump+0x220/0x220 [cfg80211]
>> [   58.265045]  ? genl_get_cmd+0xe0/0xe0
>> [   58.265057]  netlink_rcv_skb+0x51/0x100
>> [   58.265085]  genl_rcv+0x24/0x40
>> [   58.265092]  netlink_unicast+0x168/0x250
>> [   58.265109]  netlink_sendmsg+0x242/0x4a0
>> [   58.265138]  sock_sendmsg+0x5f/0x70
>> [   58.265149]  ____sys_sendmsg+0x22e/0x270
>> [   58.265157]  ? import_iovec+0x17/0x20
>> [   58.265166]  ? copy_msghdr_from_user+0x5d/0x80
>> [   58.265191]  ___sys_sendmsg+0x86/0xd0
>> [   58.265219]  ? lock_is_held_type+0xe3/0x140
>> [   58.265234]  ? find_held_lock+0x2b/0x80
>> [   58.265253]  ? lock_is_held_type+0xe3/0x140
>> [   58.265272]  ? rcu_read_lock_sched_held+0x3f/0x80
>> [   58.265284]  ? kfree+0x365/0x5c0
>> [   58.265309]  __sys_sendmsg+0x47/0x80
>> [   58.265339]  ? syscall_enter_from_user_mode+0x22/0xc0
>> [   58.265352]  do_syscall_64+0x5b/0x80
>> [   58.265370]  ? asm_common_interrupt+0x22/0x40
>> [   58.265379]  ? lockdep_hardirqs_on+0x7d/0x100
>> [   58.265390]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [   58.265396] RIP: 0033:0x7feddd1318e4
>> [   58.265407] Code: 15 41 45 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 80 3d 1d cd 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
>> [   58.265413] RSP: 002b:00007ffdc089f4f8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
>> [   58.265423] RAX: ffffffffffffffda RBX: 000055c1579c4880 RCX: 00007feddd1318e4
>> [   58.265428] RDX: 0000000000000000 RSI: 00007ffdc089f530 RDI: 0000000000000006
>> [   58.265433] RBP: 000055c157a41910 R08: 0000000000000004 R09: 000000000000000d
>> [   58.265438] R10: 00007ffdc089f610 R11: 0000000000000202 R12: 000055c1579c4790
>> [   58.265442] R13: 00007ffdc089f530 R14: 0000000000000000 R15: 00007ffdc089f610
>> [   58.265485]  </TASK>
>> [   58.265489] irq event stamp: 51698
>> [   58.265493] hardirqs last  enabled at (51704): [<ffffffff9d184a6e>] __up_console_sem+0x5e/0x70
>> [   58.265502] hardirqs last disabled at (51709): [<ffffffff9d184a53>] __up_console_sem+0x43/0x70
>> [   58.265511] softirqs last  enabled at (50976): [<ffffffff9d0fbc9d>] __irq_exit_rcu+0xed/0x160
>> [   58.265520] softirqs last disabled at (50988): [<ffffffffc1414692>] ieee80211_tx_control_port+0x282/0x5a0 [mac80211]
>> [   58.265574] ---[ end trace 0000000000000000 ]---
>>
>> Backtrace 2:
>>
>> [   58.283734] ------------[ cut here ]------------
>> [   58.283747] WARNING: CPU: 0 PID: 662 at drivers/net/wireless/ralink/rt2x00/rt2x00.h:1316 rt2x00mac_tx+0x59/0x3a0 [rt2x00lib]
>> [   58.283774] Modules linked in: rt2500pci(E) rt2x00pci(E) rt2x00mmio(E) rt2x00lib(E) mac80211 libarc4 snd_atiixp_modem snd_atiixp snd_ac97_codec ac97_bus cfg80211 snd_seq snd_seq_device snd_pcm joydev edac_mce_amd snd_timer 8139too eeprom_93cx6 pcspkr snd 8139cp mii k8temp soundcore qrtr rfkill i2c_piix4 zram amdgpu iommu_v2 gpu_sched drm_buddy radeon video wmi sdhci_pci drm_ttm_helper cqhci ttm sdhci firewire_ohci drm_display_helper firewire_core mmc_core ata_generic pata_acpi serio_raw yenta_socket cec crc_itu_t pata_atiixp ip6_tables ip_tables i2c_dev fuse
>> [   58.283986] CPU: 0 PID: 662 Comm: wpa_supplicant Tainted: G        W   E      6.0.0-rc3+ #112
>> [   58.283994] Hardware name: MICRO-STAR INT'L CO.,LTD MS-1013, BIOS A1013AMS V4.30 01/09/2006
>> [   58.283999] RIP: 0010:rt2x00mac_tx+0x59/0x3a0 [rt2x00lib]
>> [   58.284015] Code: 8b 54 24 08 49 89 f5 8b 4a 18 f6 43 28 20 0f 85 cb 00 00 00 44 0f b7 f8 41 8d 77 fe 83 fe 01 77 56 83 f9 02 0f 87 10 01 00 00 <0f> 0b 83 f9 02 75 12 4d 8b b4 24 98 11 00 00 b8 60 01 00 00 4d 85
>> [   58.284021] RSP: 0018:ffffa30501c63770 EFLAGS: 00010246
>> [   58.284030] RAX: 0000000000000002 RBX: ffff93df43ab3400 RCX: 0000000000000002
>> [   58.284035] RDX: ffffffffc123c4a0 RSI: 0000000000000000 RDI: ffff93df4b3c8e00
>> [   58.284040] RBP: ffff93df4b3c8e00 R08: 0000000000000001 R09: 0000000000000001
>> [   58.284045] R10: ffff93df49860000 R11: 0000000001761407 R12: ffff93df4b3cb3c0
>> [   58.284050] R13: ffffa30501c637d8 R14: ffff93df4b3c9440 R15: 0000000000000002
>> [   58.284056] FS:  00007feddd63c7c0(0000) GS:ffff93dfb9c00000(0000) knlGS:0000000000000000
>> [   58.284062] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   58.284067] CR2: 000055c157a50668 CR3: 000000000994a000 CR4: 00000000000006f0
>> [   58.284072] Call Trace:
>> [   58.284080]  <TASK>
>> [   58.284084]  ? _raw_spin_unlock_irqrestore+0x30/0x60
>> [   58.284110]  ieee80211_process_measurement_req+0x2ca/0x890 [mac80211]
>> [   58.284216]  ieee80211_next_txq+0x2162/0x2790 [mac80211]
>> [   58.284278]  ieee80211_tx_prepare_skb+0x250/0x290 [mac80211]
>> [   58.284368]  __ieee80211_subif_start_xmit+0x21f/0x410 [mac80211]
>> [   58.284441]  ieee80211_tx_control_port+0x2d5/0x5a0 [mac80211]
>> [   58.284514]  nl80211_tx_control_port+0x1cb/0x380 [cfg80211]
>> [   58.284791]  genl_family_rcv_msg_doit+0xd0/0x120
>> [   58.284828]  genl_rcv_msg+0xca/0x1c0
>> [   58.284840]  ? nl80211_prepare_wdev_dump+0x220/0x220 [cfg80211]
>> [   58.284973]  ? genl_get_cmd+0xe0/0xe0
>> [   58.284985]  netlink_rcv_skb+0x51/0x100
>> [   58.285013]  genl_rcv+0x24/0x40
>> [   58.285022]  netlink_unicast+0x168/0x250
>> [   58.285038]  netlink_sendmsg+0x242/0x4a0
>> [   58.285067]  sock_sendmsg+0x5f/0x70
>> [   58.285078]  ____sys_sendmsg+0x22e/0x270
>> [   58.285087]  ? import_iovec+0x17/0x20
>> [   58.285095]  ? copy_msghdr_from_user+0x5d/0x80
>> [   58.285120]  ___sys_sendmsg+0x86/0xd0
>> [   58.285151]  ? lock_is_held_type+0xe3/0x140
>> [   58.285165]  ? find_held_lock+0x2b/0x80
>> [   58.285182]  ? lock_is_held_type+0xe3/0x140
>> [   58.285202]  ? rcu_read_lock_sched_held+0x3f/0x80
>> [   58.285215]  ? kfree+0x365/0x5c0
>> [   58.285238]  __sys_sendmsg+0x47/0x80
>> [   58.285269]  ? syscall_enter_from_user_mode+0x22/0xc0
>> [   58.285282]  do_syscall_64+0x5b/0x80
>> [   58.285289]  ? do_syscall_64+0x67/0x80
>> [   58.285297]  ? lockdep_hardirqs_on+0x7d/0x100
>> [   58.285308]  ? do_syscall_64+0x67/0x80
>> [   58.285318]  ? do_syscall_64+0x67/0x80
>> [   58.285326]  ? lockdep_hardirqs_on+0x7d/0x100
>> [   58.285337]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [   58.285344] RIP: 0033:0x7feddd1318e4
>> [   58.285354] Code: 15 41 45 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 80 3d 1d cd 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
>> [   58.285360] RSP: 002b:00007ffdc089f898 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
>> [   58.285369] RAX: ffffffffffffffda RBX: 000055c1579c4880 RCX: 00007feddd1318e4
>> [   58.285374] RDX: 0000000000000000 RSI: 00007ffdc089f8d0 RDI: 0000000000000006
>> [   58.285379] RBP: 000055c157a41910 R08: 0000000000000004 R09: 00007feddd1f73e0
>> [   58.285384] R10: 00007ffdc089f9b0 R11: 0000000000000202 R12: 000055c1579c4790
>> [   58.285389] R13: 00007ffdc089f8d0 R14: 0000000000000000 R15: 00007ffdc089f9b0
>> [   58.285431]  </TASK>
>> [   58.285435] irq event stamp: 52662
>> [   58.285439] hardirqs last  enabled at (52668): [<ffffffff9d184a6e>] __up_console_sem+0x5e/0x70
>> [   58.285449] hardirqs last disabled at (52673): [<ffffffff9d184a53>] __up_console_sem+0x43/0x70
>> [   58.285457] softirqs last  enabled at (51810): [<ffffffff9ddec003>] packet_poll+0xd3/0x140
>> [   58.285466] softirqs last disabled at (51934): [<ffffffffc1414692>] ieee80211_tx_control_port+0x282/0x5a0 [mac80211]
>> [   58.285520] ---[ end trace 0000000000000000 ]---
>>
>> If this is indeed considered an issue with the core I hope that these
>> traces might help pinpoint the issue.
>>
>> Regards,
>>
>> Hans
>>
>>
>> Hans de Goede (1):
>>   wifi: rt2x00: Fix "Error - Attempt to send packet over invalid queue 2"
>>
>>  drivers/net/wireless/ralink/rt2x00/rt2x00.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.37.2
>>
> 

