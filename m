Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1035B5B24C2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiIHRgd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiIHRgb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 13:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42633E9159
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662658588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4WCde75zNdXePC5HPni+kEqy9b/u9SL/6WjEwJTE1hk=;
        b=Sj4/Qgzys+hNhUfnXUc7P+3GkkVI+HSWzR5aKQoaIr5hmz7Wex8iJqlcrjs/UidOn1/O+V
        rIpo9y0tdf6gIDHgfs0PBXTAPkF2kTCkrpM3ohmT8wSCzOBP+PZ37I17pVkaTzFOaMBbLk
        7GR731sJsfWM5o6oh4nfkBo6JRjiJGE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-dE86XyyBM82eRCS-5N5Sqg-1; Thu, 08 Sep 2022 13:36:25 -0400
X-MC-Unique: dE86XyyBM82eRCS-5N5Sqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22062101E98C;
        Thu,  8 Sep 2022 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3477CC15BBA;
        Thu,  8 Sep 2022 17:36:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-wireless@vger.kernel.org
Subject: [PATCH 0/1] rt2x00 WA for mac80211 core (BUG?) submitting skb-s with queue-ids >= hw.queues
Date:   Thu,  8 Sep 2022 19:36:17 +0200
Message-Id: <20220908173618.155291-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi All,

I'm seeing the mac80211 core submitting skb-s with queue-ids >= hw.queues
on a ralink rt2500 PCI card which causes rt2x00queue_get_tx_queue() to
return NULL and the following error to be logged: "ieee80211 phy0:
rt2x00mac_tx: Error - Attempt to send packet over invalid queue 2",
after which association with the AP fails.

I have a hunch that although I've come up with a quick fix in the rt2x00 
driver, that this is really an issue with the mac80211 core and that
the core should never submit skb-s where skb_get_queue_mapping()
returns a value >= ieee80211_hw.queues ?

Because of this hunch I have added a WARN_ON(1) when the workaround
triggered to see what I would get. This results in the following
2 backtraces just after associating with my ISP provisioned access-point:

[   58.263794] ------------[ cut here ]------------
[   58.263831] WARNING: CPU: 0 PID: 662 at drivers/net/wireless/ralink/rt2x00/rt2x00.h:1316 rt2x00mac_tx+0x59/0x3a0 [rt2x00lib]
[   58.263856] Modules linked in: rt2500pci(E) rt2x00pci(E) rt2x00mmio(E) rt2x00lib(E) mac80211 libarc4 snd_atiixp_modem snd_atiixp snd_ac97_codec ac97_bus cfg80211 snd_seq snd_seq_device snd_pcm joydev edac_mce_amd snd_timer 8139too eeprom_93cx6 pcspkr snd 8139cp mii k8temp soundcore qrtr rfkill i2c_piix4 zram amdgpu iommu_v2 gpu_sched drm_buddy radeon video wmi sdhci_pci drm_ttm_helper cqhci ttm sdhci firewire_ohci drm_display_helper firewire_core mmc_core ata_generic pata_acpi serio_raw yenta_socket cec crc_itu_t pata_atiixp ip6_tables ip_tables i2c_dev fuse
[   58.264061] CPU: 0 PID: 662 Comm: wpa_supplicant Tainted: G            E      6.0.0-rc3+ #112
[   58.264069] Hardware name: MICRO-STAR INT'L CO.,LTD MS-1013, BIOS A1013AMS V4.30 01/09/2006
[   58.264074] RIP: 0010:rt2x00mac_tx+0x59/0x3a0 [rt2x00lib]
[   58.264088] Code: 8b 54 24 08 49 89 f5 8b 4a 18 f6 43 28 20 0f 85 cb 00 00 00 44 0f b7 f8 41 8d 77 fe 83 fe 01 77 56 83 f9 02 0f 87 10 01 00 00 <0f> 0b 83 f9 02 75 12 4d 8b b4 24 98 11 00 00 b8 60 01 00 00 4d 85
[   58.264094] RSP: 0018:ffffa30501c63780 EFLAGS: 00010246
[   58.264103] RAX: 0000000000000002 RBX: ffff93df43ab3e00 RCX: 0000000000000002
[   58.264108] RDX: ffffffffc123c4a0 RSI: 0000000000000000 RDI: ffff93df4b3c8e00
[   58.264113] RBP: ffff93df4b3c8e00 R08: 0000000000000001 R09: 0000000000000001
[   58.264118] R10: ffff93df49860000 R11: 000000000001103d R12: ffff93df4b3cb3c0
[   58.264123] R13: ffffa30501c637e8 R14: ffff93df4b3c9440 R15: 0000000000000002
[   58.264128] FS:  00007feddd63c7c0(0000) GS:ffff93dfb9c00000(0000) knlGS:0000000000000000
[   58.264134] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.264139] CR2: 0000557d841633c8 CR3: 000000000994a000 CR4: 00000000000006f0
[   58.264145] Call Trace:
[   58.264149]  <TASK>
[   58.264154]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[   58.264176]  ieee80211_process_measurement_req+0x2ca/0x890 [mac80211]
[   58.264274]  ieee80211_next_txq+0x2162/0x2790 [mac80211]
[   58.264335]  ieee80211_tx_prepare_skb+0x250/0x290 [mac80211]
[   58.264426]  __ieee80211_subif_start_xmit+0x21f/0x410 [mac80211]
[   58.264499]  ieee80211_tx_control_port+0x2d5/0x5a0 [mac80211]
[   58.264572]  nl80211_tx_control_port+0x1cb/0x380 [cfg80211]
[   58.264864]  genl_family_rcv_msg_doit+0xd0/0x120
[   58.264901]  genl_rcv_msg+0xca/0x1c0
[   58.264912]  ? nl80211_prepare_wdev_dump+0x220/0x220 [cfg80211]
[   58.265045]  ? genl_get_cmd+0xe0/0xe0
[   58.265057]  netlink_rcv_skb+0x51/0x100
[   58.265085]  genl_rcv+0x24/0x40
[   58.265092]  netlink_unicast+0x168/0x250
[   58.265109]  netlink_sendmsg+0x242/0x4a0
[   58.265138]  sock_sendmsg+0x5f/0x70
[   58.265149]  ____sys_sendmsg+0x22e/0x270
[   58.265157]  ? import_iovec+0x17/0x20
[   58.265166]  ? copy_msghdr_from_user+0x5d/0x80
[   58.265191]  ___sys_sendmsg+0x86/0xd0
[   58.265219]  ? lock_is_held_type+0xe3/0x140
[   58.265234]  ? find_held_lock+0x2b/0x80
[   58.265253]  ? lock_is_held_type+0xe3/0x140
[   58.265272]  ? rcu_read_lock_sched_held+0x3f/0x80
[   58.265284]  ? kfree+0x365/0x5c0
[   58.265309]  __sys_sendmsg+0x47/0x80
[   58.265339]  ? syscall_enter_from_user_mode+0x22/0xc0
[   58.265352]  do_syscall_64+0x5b/0x80
[   58.265370]  ? asm_common_interrupt+0x22/0x40
[   58.265379]  ? lockdep_hardirqs_on+0x7d/0x100
[   58.265390]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   58.265396] RIP: 0033:0x7feddd1318e4
[   58.265407] Code: 15 41 45 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 80 3d 1d cd 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
[   58.265413] RSP: 002b:00007ffdc089f4f8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[   58.265423] RAX: ffffffffffffffda RBX: 000055c1579c4880 RCX: 00007feddd1318e4
[   58.265428] RDX: 0000000000000000 RSI: 00007ffdc089f530 RDI: 0000000000000006
[   58.265433] RBP: 000055c157a41910 R08: 0000000000000004 R09: 000000000000000d
[   58.265438] R10: 00007ffdc089f610 R11: 0000000000000202 R12: 000055c1579c4790
[   58.265442] R13: 00007ffdc089f530 R14: 0000000000000000 R15: 00007ffdc089f610
[   58.265485]  </TASK>
[   58.265489] irq event stamp: 51698
[   58.265493] hardirqs last  enabled at (51704): [<ffffffff9d184a6e>] __up_console_sem+0x5e/0x70
[   58.265502] hardirqs last disabled at (51709): [<ffffffff9d184a53>] __up_console_sem+0x43/0x70
[   58.265511] softirqs last  enabled at (50976): [<ffffffff9d0fbc9d>] __irq_exit_rcu+0xed/0x160
[   58.265520] softirqs last disabled at (50988): [<ffffffffc1414692>] ieee80211_tx_control_port+0x282/0x5a0 [mac80211]
[   58.265574] ---[ end trace 0000000000000000 ]---

Backtrace 2:

[   58.283734] ------------[ cut here ]------------
[   58.283747] WARNING: CPU: 0 PID: 662 at drivers/net/wireless/ralink/rt2x00/rt2x00.h:1316 rt2x00mac_tx+0x59/0x3a0 [rt2x00lib]
[   58.283774] Modules linked in: rt2500pci(E) rt2x00pci(E) rt2x00mmio(E) rt2x00lib(E) mac80211 libarc4 snd_atiixp_modem snd_atiixp snd_ac97_codec ac97_bus cfg80211 snd_seq snd_seq_device snd_pcm joydev edac_mce_amd snd_timer 8139too eeprom_93cx6 pcspkr snd 8139cp mii k8temp soundcore qrtr rfkill i2c_piix4 zram amdgpu iommu_v2 gpu_sched drm_buddy radeon video wmi sdhci_pci drm_ttm_helper cqhci ttm sdhci firewire_ohci drm_display_helper firewire_core mmc_core ata_generic pata_acpi serio_raw yenta_socket cec crc_itu_t pata_atiixp ip6_tables ip_tables i2c_dev fuse
[   58.283986] CPU: 0 PID: 662 Comm: wpa_supplicant Tainted: G        W   E      6.0.0-rc3+ #112
[   58.283994] Hardware name: MICRO-STAR INT'L CO.,LTD MS-1013, BIOS A1013AMS V4.30 01/09/2006
[   58.283999] RIP: 0010:rt2x00mac_tx+0x59/0x3a0 [rt2x00lib]
[   58.284015] Code: 8b 54 24 08 49 89 f5 8b 4a 18 f6 43 28 20 0f 85 cb 00 00 00 44 0f b7 f8 41 8d 77 fe 83 fe 01 77 56 83 f9 02 0f 87 10 01 00 00 <0f> 0b 83 f9 02 75 12 4d 8b b4 24 98 11 00 00 b8 60 01 00 00 4d 85
[   58.284021] RSP: 0018:ffffa30501c63770 EFLAGS: 00010246
[   58.284030] RAX: 0000000000000002 RBX: ffff93df43ab3400 RCX: 0000000000000002
[   58.284035] RDX: ffffffffc123c4a0 RSI: 0000000000000000 RDI: ffff93df4b3c8e00
[   58.284040] RBP: ffff93df4b3c8e00 R08: 0000000000000001 R09: 0000000000000001
[   58.284045] R10: ffff93df49860000 R11: 0000000001761407 R12: ffff93df4b3cb3c0
[   58.284050] R13: ffffa30501c637d8 R14: ffff93df4b3c9440 R15: 0000000000000002
[   58.284056] FS:  00007feddd63c7c0(0000) GS:ffff93dfb9c00000(0000) knlGS:0000000000000000
[   58.284062] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.284067] CR2: 000055c157a50668 CR3: 000000000994a000 CR4: 00000000000006f0
[   58.284072] Call Trace:
[   58.284080]  <TASK>
[   58.284084]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[   58.284110]  ieee80211_process_measurement_req+0x2ca/0x890 [mac80211]
[   58.284216]  ieee80211_next_txq+0x2162/0x2790 [mac80211]
[   58.284278]  ieee80211_tx_prepare_skb+0x250/0x290 [mac80211]
[   58.284368]  __ieee80211_subif_start_xmit+0x21f/0x410 [mac80211]
[   58.284441]  ieee80211_tx_control_port+0x2d5/0x5a0 [mac80211]
[   58.284514]  nl80211_tx_control_port+0x1cb/0x380 [cfg80211]
[   58.284791]  genl_family_rcv_msg_doit+0xd0/0x120
[   58.284828]  genl_rcv_msg+0xca/0x1c0
[   58.284840]  ? nl80211_prepare_wdev_dump+0x220/0x220 [cfg80211]
[   58.284973]  ? genl_get_cmd+0xe0/0xe0
[   58.284985]  netlink_rcv_skb+0x51/0x100
[   58.285013]  genl_rcv+0x24/0x40
[   58.285022]  netlink_unicast+0x168/0x250
[   58.285038]  netlink_sendmsg+0x242/0x4a0
[   58.285067]  sock_sendmsg+0x5f/0x70
[   58.285078]  ____sys_sendmsg+0x22e/0x270
[   58.285087]  ? import_iovec+0x17/0x20
[   58.285095]  ? copy_msghdr_from_user+0x5d/0x80
[   58.285120]  ___sys_sendmsg+0x86/0xd0
[   58.285151]  ? lock_is_held_type+0xe3/0x140
[   58.285165]  ? find_held_lock+0x2b/0x80
[   58.285182]  ? lock_is_held_type+0xe3/0x140
[   58.285202]  ? rcu_read_lock_sched_held+0x3f/0x80
[   58.285215]  ? kfree+0x365/0x5c0
[   58.285238]  __sys_sendmsg+0x47/0x80
[   58.285269]  ? syscall_enter_from_user_mode+0x22/0xc0
[   58.285282]  do_syscall_64+0x5b/0x80
[   58.285289]  ? do_syscall_64+0x67/0x80
[   58.285297]  ? lockdep_hardirqs_on+0x7d/0x100
[   58.285308]  ? do_syscall_64+0x67/0x80
[   58.285318]  ? do_syscall_64+0x67/0x80
[   58.285326]  ? lockdep_hardirqs_on+0x7d/0x100
[   58.285337]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   58.285344] RIP: 0033:0x7feddd1318e4
[   58.285354] Code: 15 41 45 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 80 3d 1d cd 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
[   58.285360] RSP: 002b:00007ffdc089f898 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[   58.285369] RAX: ffffffffffffffda RBX: 000055c1579c4880 RCX: 00007feddd1318e4
[   58.285374] RDX: 0000000000000000 RSI: 00007ffdc089f8d0 RDI: 0000000000000006
[   58.285379] RBP: 000055c157a41910 R08: 0000000000000004 R09: 00007feddd1f73e0
[   58.285384] R10: 00007ffdc089f9b0 R11: 0000000000000202 R12: 000055c1579c4790
[   58.285389] R13: 00007ffdc089f8d0 R14: 0000000000000000 R15: 00007ffdc089f9b0
[   58.285431]  </TASK>
[   58.285435] irq event stamp: 52662
[   58.285439] hardirqs last  enabled at (52668): [<ffffffff9d184a6e>] __up_console_sem+0x5e/0x70
[   58.285449] hardirqs last disabled at (52673): [<ffffffff9d184a53>] __up_console_sem+0x43/0x70
[   58.285457] softirqs last  enabled at (51810): [<ffffffff9ddec003>] packet_poll+0xd3/0x140
[   58.285466] softirqs last disabled at (51934): [<ffffffffc1414692>] ieee80211_tx_control_port+0x282/0x5a0 [mac80211]
[   58.285520] ---[ end trace 0000000000000000 ]---

If this is indeed considered an issue with the core I hope that these
traces might help pinpoint the issue.

Regards,

Hans


Hans de Goede (1):
  wifi: rt2x00: Fix "Error - Attempt to send packet over invalid queue 2"

 drivers/net/wireless/ralink/rt2x00/rt2x00.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.37.2

