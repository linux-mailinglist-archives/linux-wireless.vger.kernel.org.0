Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E90650248
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Dec 2022 17:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiLRQpJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Dec 2022 11:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiLRQoi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Dec 2022 11:44:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C898F26CA;
        Sun, 18 Dec 2022 08:15:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F14AB80BE7;
        Sun, 18 Dec 2022 16:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AF5C433D2;
        Sun, 18 Dec 2022 16:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671380147;
        bh=tH6ZpV0L4UGuIzGbBfIQemffggo8wHMlaWF05gu9Ygk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uasa8E0E+vrLqPUP4ooCXvOouETLtH5ju02CuXX//qnL4NRiFV2s3XrrQeKRvDnkZ
         Hh3PaKFpAoJe2rs8HUlZd+AI/xWRvVhkBuWoia6trPdtP0RKkkN1K0mg5xYNpw54WH
         UD9sLS2NcObs5UU1INlCUTljvxISQx+yWI/f3snnQcH1rbvP6rk76jdJdu7HqXilWh
         flFXObuMmuYGwlQLdpMb/odP6BrmBR8Hf/ZpwMZ9W60tyATLnN1cLf6Ee88cYXsbwm
         F6PM8dofNw52A9eC6uK3ty8f2R36AJCEYTfOU6XYdOUypNKOHSKIaoLhVt0fnr7Bkk
         v3vFDxIKTLB2w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Dokyung Song <dokyungs@yonsei.ac.kr>,
        Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>, ryder.lee@mediatek.com,
        kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 42/46] wifi: mt76: do not run mt76u_status_worker if the device is not running
Date:   Sun, 18 Dec 2022 11:12:40 -0500
Message-Id: <20221218161244.930785-42-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221218161244.930785-1-sashal@kernel.org>
References: <20221218161244.930785-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit bd5dac7ced5a7c9faa4dc468ac9560c3256df845 ]

Fix the following NULL pointer dereference avoiding to run
mt76u_status_worker thread if the device is not running yet.

KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 98 Comm: kworker/u2:2 Not tainted 5.14.0+ #78 Hardware
name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: mt76 mt76u_tx_status_data
RIP: 0010:mt76x02_mac_fill_tx_status.isra.0+0x82c/0x9e0
Code: c5 48 b8 00 00 00 00 00 fc ff df 80 3c 02 00 0f 85 94 01 00 00
48 b8 00 00 00 00 00 fc ff df 4d 8b 34 24 4c 89 f2 48 c1 ea 03 <0f>
b6
04 02 84 c0 74 08 3c 03 0f 8e 89 01 00 00 41 8b 16 41 0f b7
RSP: 0018:ffffc900005af988 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc900005afae8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff832fc661 RDI: ffffc900005afc2a
RBP: ffffc900005afae0 R08: 0000000000000001 R09: fffff520000b5f3c
R10: 0000000000000003 R11: fffff520000b5f3b R12: ffff88810b6132d8
R13: 000000000000ffff R14: 0000000000000000 R15: ffffc900005afc28
FS:  0000000000000000(0000) GS:ffff88811aa00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa0eda6a000 CR3: 0000000118f17000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 mt76x02_send_tx_status+0x1d2/0xeb0
 mt76x02_tx_status_data+0x8e/0xd0
 mt76u_tx_status_data+0xe1/0x240
 process_one_work+0x92b/0x1460
 worker_thread+0x95/0xe00
 kthread+0x3a1/0x480
 ret_from_fork+0x1f/0x30
Modules linked in:
--[ end trace 8df5d20fc5040f65 ]--
RIP: 0010:mt76x02_mac_fill_tx_status.isra.0+0x82c/0x9e0
Code: c5 48 b8 00 00 00 00 00 fc ff df 80 3c 02 00 0f 85 94 01 00 00
48 b8 00 00 00 00 00 fc ff df 4d 8b 34 24 4c 89 f2 48 c1 ea 03 <0f>
b6
04 02 84 c0 74 08 3c 03 0f 8e 89 01 00 00 41 8b 16 41 0f b7
RSP: 0018:ffffc900005af988 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc900005afae8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff832fc661 RDI: ffffc900005afc2a
RBP: ffffc900005afae0 R08: 0000000000000001 R09: fffff520000b5f3c
R10: 0000000000000003 R11: fffff520000b5f3b R12: ffff88810b6132d8
R13: 000000000000ffff R14: 0000000000000000 R15: ffffc900005afc28
FS:  0000000000000000(0000) GS:ffff88811aa00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa0eda6a000 CR3: 0000000118f17000 CR4: 0000000000750ef0
PKRU: 55555554

Moreover move stat_work schedule out of the for loop.

Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 1e9f60bb811a..b47343e321b8 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -814,6 +814,9 @@ static void mt76u_status_worker(struct mt76_worker *w)
 	struct mt76_queue *q;
 	int i;
 
+	if (!test_bit(MT76_STATE_RUNNING, &dev->phy.state))
+		return;
+
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		q = dev->phy.q_tx[i];
 		if (!q)
@@ -833,11 +836,11 @@ static void mt76u_status_worker(struct mt76_worker *w)
 			wake_up(&dev->tx_wait);
 
 		mt76_worker_schedule(&dev->tx_worker);
-
-		if (dev->drv->tx_status_data &&
-		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
-			queue_work(dev->wq, &dev->usb.stat_work);
 	}
+
+	if (dev->drv->tx_status_data &&
+	    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
+		queue_work(dev->wq, &dev->usb.stat_work);
 }
 
 static void mt76u_tx_status_data(struct work_struct *work)
-- 
2.35.1

