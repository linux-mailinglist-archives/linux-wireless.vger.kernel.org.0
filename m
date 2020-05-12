Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366781CFED4
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 22:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgELUDA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 16:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgELUDA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 16:03:00 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E11B20731;
        Tue, 12 May 2020 20:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589313779;
        bh=mC7Xaku0pm7W+u76ys7w20QHI6CsjIiDdI70DELyQb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbP6L9lbCJrf3icl1v7/oRJBDRnFRrxksE6YY8VV2hhvdOWx8JJ/g9B44MYI3k5ol
         E0vz0HfT9hSs3FNnPItj8re9Dyn7MVQ8H+uD38pgzhp2uTvwLUQnc9YlAe40AzAjR3
         GIMD3hmcCOMBR+BLaL+UBYjXa1GaKKCDL1xY/Psk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 1/4] mt76: mt7615: do not report scan_complete twice to mac80211
Date:   Tue, 12 May 2020 22:02:47 +0200
Message-Id: <05f13c32309716bbb532a926118b705915a198a2.1589313659.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589313659.git.lorenzo@kernel.org>
References: <cover.1589313659.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following kernel warning that occurs if scan work is scheduled
and the hw scan has been cancelled by mac80211

WARNING: CPU: 1 PID: 502 at net/mac80211/scan.c:391 __ieee80211_scan_completed+0x299/0x690
Modules linked in:
CPU: 1 PID: 502 Comm: kworker/u4:4 Not tainted 5.7.0-rc1+ #2882
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Workqueue: phy0 ieee80211_scan_work
RIP: 0010:__ieee80211_scan_completed+0x299/0x690
RSP: 0018:ffffc9000036fda8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 8c6318c6318c6320
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffff88803bb129b8
RBP: ffff88803bb10d80 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88803bb12ae8
FS:  0000000000000000(0000) GS:ffff88803ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f13ee5c1470 CR3: 000000003c790000 CR4: 00000000000006a0
Call Trace:
 ieee80211_scan_work+0x170/0x850
 ? sched_clock_cpu+0x11/0xb0
 process_one_work+0x24f/0x580
 ? worker_thread+0xcc/0x3e0
 worker_thread+0x4f/0x3e0
 ? process_one_work+0x580/0x580
 kthread+0x11b/0x140
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x3a/0x50
irq event stamp: 9255532
hardirqs last  enabled at (9255531): [<ffffffff81a504e4>] _raw_spin_unlock_irq+0x24/0x30
hardirqs last disabled at (9255532): [<ffffffff81001b3f>] trace_hardirqs_off_thunk+0x1a/0x1c
softirqs last  enabled at (9255526): [<ffffffff8107c9ef>] process_one_work+0x24f/0x580
softirqs last disabled at (9255524): [<ffffffff815f2f41>] mt7615_scan_work+0x91/0xc0

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 12 +++++++-----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 402ff38f7dcf..c8705f91bafc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -810,15 +810,15 @@ void mt7615_scan_work(struct work_struct *work)
 			break;
 
 		rxd = (struct mt7615_mcu_rxd *)skb->data;
-		if (rxd->eid == MCU_EVENT_SCAN_DONE) {
+		if (rxd->eid == MCU_EVENT_SCHED_SCAN_DONE) {
+			ieee80211_sched_scan_results(phy->mt76->hw);
+		} else if (test_and_clear_bit(MT76_HW_SCANNING,
+					      &phy->mt76->state)) {
 			struct cfg80211_scan_info info = {
 				.aborted = false,
 			};
 
-			clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
 			ieee80211_scan_completed(phy->mt76->hw, &info);
-		} else {
-			ieee80211_sched_scan_results(phy->mt76->hw);
 		}
 		dev_kfree_skb(skb);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index ef50b9a885f4..9cb8a9bb912b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2861,9 +2861,6 @@ int mt7615_mcu_cancel_hw_scan(struct mt7615_phy *phy,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_dev *dev = phy->dev;
-	struct cfg80211_scan_info info = {
-		.aborted = true,
-	};
 	struct {
 		u8 seq_num;
 		u8 is_ext_channel;
@@ -2872,8 +2869,13 @@ int mt7615_mcu_cancel_hw_scan(struct mt7615_phy *phy,
 		.seq_num = mvif->scan_seq_num,
 	};
 
-	ieee80211_scan_completed(phy->mt76->hw, &info);
-	clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
+	if (test_and_clear_bit(MT76_HW_SCANNING, &phy->mt76->state)) {
+		struct cfg80211_scan_info info = {
+			.aborted = true,
+		};
+
+		ieee80211_scan_completed(phy->mt76->hw, &info);
+	}
 
 	return __mt76_mcu_send_msg(&dev->mt76,  MCU_CMD_CANCEL_HW_SCAN, &req,
 				   sizeof(req), false);
-- 
2.26.2

