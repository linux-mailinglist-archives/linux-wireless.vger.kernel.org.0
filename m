Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1338617A95
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Nov 2022 11:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKCKHY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Nov 2022 06:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCKHV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Nov 2022 06:07:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BB695A6
        for <linux-wireless@vger.kernel.org>; Thu,  3 Nov 2022 03:07:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l6so1193002pjj.0
        for <linux-wireless@vger.kernel.org>; Thu, 03 Nov 2022 03:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yonsei-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JL+3oJcUuUZnzs1/rZYnw9pUj52YpajoYK1pHnac2ew=;
        b=ajygb/Po3qc3ql7glKxd581SqC3buK4aIs4V4hmB2Ct7qosTygnRyQuClDejUJukPx
         fsk9grFI6BBSLqj6YKXGIH8VucrjejRpp0EH7tbSSYsBdHnr2fIBq54D8avnyTuT9XE1
         jScO6ejfUzNZSyU4iKqvaASSxJE2z86uxzxZdR2Zb4tjPr4Nbe8sYGLDvW2QNsLANp8/
         agnOJQ65dqTveWOzmCnyQKQo16JOd6Mr75UKmxTN30DOm+wPmjoMQPoVyLrEYmAVdGJb
         odU2o0T5qNAHcfT2C3BswTGPwS5c4vIOZrwUgmwZYJH0FHiCSIx6ZtUB8jENaY6RML4u
         31YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JL+3oJcUuUZnzs1/rZYnw9pUj52YpajoYK1pHnac2ew=;
        b=wFFRpvZoUIQ1/94VeFYA9m+ub4YVwC4GSveczw1itzNWYoqkYbTeDpPjFcIUrtmoXE
         rnnoID5jEGIWsEofZGDctOPVbEQdC38G3qATuxO61v6EtqAS4qBngR3372SIi8Khg7xR
         bLU+eCc5x7JJDfInl5YhH7fj2bKz3swxTs6atKFXyCc4MJeB67zPdKzwfZafkmy72pT2
         EPzq0a3CfoXlJcJFEDfn1aVaIVd3E3iYzl4X+dRY/eIOfCkJmmFQJ8f9UZaDduRPweDN
         EOCq9tUAi+uaC11HIIkM2iTMUXo09oJuy4RPwkKiD7GEP7N7f4IWzMELLcT529NVWXpX
         w4UQ==
X-Gm-Message-State: ACrzQf3Cd+SCsWivCF5A1FQmOw2y9KjD8OBO5Qax4GIJuBiJ7XZvryef
        cynz9Uu7C9JCtdN6PIu80pn3hg==
X-Google-Smtp-Source: AMsMyM45kxiyh0FoCLL0Mr4S1pbq1V9TFRFTu7TQ8EVf+5qY40HX1R1kyOIWkOv+7YyL7riVb9jZSQ==
X-Received: by 2002:a17:902:f552:b0:186:cdb2:b864 with SMTP id h18-20020a170902f55200b00186cdb2b864mr29110762plf.24.1667470035249;
        Thu, 03 Nov 2022 03:07:15 -0700 (PDT)
Received: from localhost.localdomain ([165.132.118.52])
        by smtp.gmail.com with ESMTPSA id nb7-20020a17090b35c700b0020af2411721sm630318pjb.34.2022.11.03.03.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:07:14 -0700 (PDT)
From:   Minsuk Kang <linuxlovemin@yonsei.ac.kr>
To:     nbd@nbd.name, lorenzo@kernel.org
Cc:     linux-wireless@vger.kernel.org, kvalo@kernel.org,
        dokyungs@yonsei.ac.kr, jisoo.jang@yonsei.ac.kr,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Subject: [RFC PATCH] wifi: mt76: Fix potential NULL pointer dereference in status work
Date:   Thu,  3 Nov 2022 19:05:56 +0900
Message-Id: <20221103100556.48288-1-linuxlovemin@yonsei.ac.kr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch fixes a NULL pointer dereference in mt76 that occurs when a
status work like mt76u_tx_status_data() queued from mt76u_status_worker()
is called in worker thread while the device initialization failed.
Pointers dereferenced in the work that should have been initialized
during the device registration in mt76_register_device(),
'dev->mphy.chandef.chan' in mt76x02_mac_fill_tx_status(), for example,
may be NULL if the initialization failed. The patch adds a check that
safely terminates the function if that is the case.

Found by a modified version of syzkaller.

KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 98 Comm: kworker/u2:2 Not tainted 5.14.0+ #78
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: mt76 mt76u_tx_status_data
RIP: 0010:mt76x02_mac_fill_tx_status.isra.0+0x82c/0x9e0
Code: c5 48 b8 00 00 00 00 00 fc ff df 80 3c 02 00 0f 85 94 01 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 34 24 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 89 01 00 00 41 8b 16 41 0f b7
RSP: 0018:ffffc900005af988 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc900005afae8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff832fc661 RDI: ffffc900005afc2a
RBP: ffffc900005afae0 R08: 0000000000000001 R09: fffff520000b5f3c
R10: 0000000000000003 R11: fffff520000b5f3b R12: ffff88810b6132d8
R13: 000000000000ffff R14: 0000000000000000 R15: ffffc900005afc28
FS:  0000000000000000(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa0eda6a000 CR3: 0000000118f17000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 ? do_raw_spin_lock+0x125/0x2e0
 ? mt76x02_mac_write_txwi+0xdc0/0xdc0
 ? rwlock_bug.part.0+0x90/0x90
 ? __dev_printk+0x1d6/0x1fe
 mt76x02_send_tx_status+0x1d2/0xeb0
 ? usleep_range+0xb3/0x170
 ? mt76x02_mac_load_tx_status+0x4b0/0x4b0
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? mt76u_rr+0x3c/0x50
 mt76x02_tx_status_data+0x8e/0xd0
 ? mt76x02_tx_set_txpwr_auto+0x330/0x330
 mt76u_tx_status_data+0xe1/0x240
 ? mt76u_read_copy_ext+0x180/0x180
 ? rcu_read_lock_sched_held+0x81/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? lockdep_hardirqs_on_prepare+0x273/0x3e0
 process_one_work+0x92b/0x1460
 ? pwq_dec_nr_in_flight+0x330/0x330
 ? rwlock_bug.part.0+0x90/0x90
 worker_thread+0x95/0xe00
 ? __kthread_parkme+0x115/0x1e0
 ? process_one_work+0x1460/0x1460
 kthread+0x3a1/0x480
 ? set_kthread_struct+0x120/0x120
 ret_from_fork+0x1f/0x30
Modules linked in:
---[ end trace 8df5d20fc5040f65 ]---
RIP: 0010:mt76x02_mac_fill_tx_status.isra.0+0x82c/0x9e0
Code: c5 48 b8 00 00 00 00 00 fc ff df 80 3c 02 00 0f 85 94 01 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 34 24 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 89 01 00 00 41 8b 16 41 0f b7
RSP: 0018:ffffc900005af988 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc900005afae8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff832fc661 RDI: ffffc900005afc2a
RBP: ffffc900005afae0 R08: 0000000000000001 R09: fffff520000b5f3c
R10: 0000000000000003 R11: fffff520000b5f3b R12: ffff88810b6132d8
R13: 000000000000ffff R14: 0000000000000000 R15: ffffc900005afc28
FS:  0000000000000000(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa0eda6a000 CR3: 0000000118f17000 CR4: 0000000000750ef0
PKRU: 55555554

Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
Signed-off-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
---

The crash we found occurs when the initialization failed in
mt76x0u_register_device() and mt76u_stop_tx() is called via
mt76u_queues_deinit() as an error handling. mt76u_stop_tx()
enables a kthread with mt76_worker_enable() and this
make 'dev->mphy.chandef.chan', which is NULL, be dereferenced
in mt76x02_mac_fill_tx_status(), called in the worker.

I think that calling mt76_worker_enable() in mt76u_stop_tx()
may be a fundamental problem in this crash. What I found
is that mt76u_stop_tx() is invoked twice by mt76x0u_stop()
and mt76x0u_cleanup() from mt76x0_disconnect() when
disconnecting the device. In this situation, enabling
kthreads in mt76u_stop_tx() after disabling them will prevents
them from being repeatedly parked, which will return -EBUSY.

If invoking mt76u_stop_tx() in both mt76x0u_stop() and
mt76x0u_cleanup() is unnecessary, and preventing kthreads
from being continuously parked is the only reason of
mt76_worker_enable() in mt76u_stop_tx(), I think we can
make a solution that fundamentally prevent the work from
being called when initialization is failed, instead of
checking the state after the work is called.
---
 drivers/net/wireless/mediatek/mt76/sdio.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/usb.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 0ec308f99af5..464d1c713554 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -499,7 +499,8 @@ static void mt76s_tx_status_data(struct work_struct *work)
 	dev = container_of(sdio, struct mt76_dev, sdio);
 
 	while (true) {
-		if (test_bit(MT76_REMOVED, &dev->phy.state))
+		if (test_bit(MT76_REMOVED, &dev->phy.state) ||
+		    !test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
 			break;
 
 		if (!dev->drv->tx_status_data(dev, &update))
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 4c4033bb1bb3..6cfdaa9d09d1 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -803,7 +803,8 @@ static void mt76u_tx_status_data(struct work_struct *work)
 	dev = container_of(usb, struct mt76_dev, usb);
 
 	while (true) {
-		if (test_bit(MT76_REMOVED, &dev->phy.state))
+		if (test_bit(MT76_REMOVED, &dev->phy.state) ||
+		    !test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
 			break;
 
 		if (!dev->drv->tx_status_data(dev, &update))
-- 
2.25.1

