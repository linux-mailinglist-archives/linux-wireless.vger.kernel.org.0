Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C3033EBF8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Mar 2021 09:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCQI5v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Mar 2021 04:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhCQI5l (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Mar 2021 04:57:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1133464EE2;
        Wed, 17 Mar 2021 08:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615971461;
        bh=ZrBRcjp7OHgzFN1taAOk7PwXPIQl1nWc9kUbV1doVrQ=;
        h=From:To:Cc:Subject:Date:From;
        b=bQuK0ZZuMlDf3NknmjN9HHKzk/JtO+nn7mX96Sps3zMI1bHQuqDt88+sR1jbClWCx
         aff9GpIIxtfHpV0vrfNGCmL47QCLqxJsalt7akPn9ttF+Wb14xIpENAmS6XHw5C1Dk
         Kp/NjWwHkBsDY6zx4OuNC23jSF6LlAWwaB3/AzJ7yiVwzWxajVdOZX7BWvtJrXFlMB
         0gga8/OzUFmoAxPryIYlN/qLNzyx014zUGeDaj6RU8mM1RfwU8BU9BhMJAAMu0UyoI
         kgnH3bPTP31alqQQFG5eN94UaWpJlqqHDmg5/3K1v97JrsNDU4nmZC8FsDi0IlQd1M
         z95Ykmq9J93xw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: move de-amsdu buffer per-phy
Date:   Wed, 17 Mar 2021 09:57:35 +0100
Message-Id: <3cebac3977b265fb6207baeaadd577a286548cb3.1615971393.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7615d users report the following crash running both phy concurrently:

[  147.273909] CPU 1 Unable to handle kernel paging request at virtual address 00000000, epc == 8e4f288c, ra == 8e58a968
[  147.284570] Oops[#1]:
[  147.286854] CPU: 1 PID: 3724 Comm: kworker/u9:3 Not tainted 5.4.105 #0
[  147.293403] Workqueue: napi_workq napi_workfn
[  147.297742] $ 0   : 00000000 00000001 8e595ec0 00000000
[  147.302950] $ 4   : 8e595ec0 00000000 8e5ca600 00000000
[  147.308161] $ 8   : 00000000 000004c1 80808080 fefefeff
[  147.313370] $12   : 00000000 00000000 80704f1c 00000040
[  147.323781] $20   : 00000050 00000044 00000011 01ce9502
[  147.334195] $28   : 8e004000 8e005d18 8ddf2020 8e58a968
[  147.342266] Lo    : 00000000
[  147.350397] ra    : 8e58a968 mt7615_queue_rx_skb+0x94c/0xd0c [mt7615_common]
[  147.361580] Cause : 4080000c (ExcCode 03)
[  147.368434] PrId  : 0001992f (MIPS 1004Kc)
[  147.456965] Process kworker/u9:3 (pid: 3724, threadinfo=9ece68d6, task=b16d155f, tls=00000000)
[  147.473857]         0001ce95 00004188 00000000 00000080 00004c10 00000002 8074a2b8 80043dcc
[  147.490505]         00000000 8e4f0110 8069ddf4 806ab148 8dfc0000 00001000 00000000 00000050
[  147.507150]         ...
[  147.512033] [<8e4f288c>] mt76_rx+0x124/0x320 [mt76]
[  147.526633]
[  147.528512] ---[ end trace 3d137e75bb109149 ]---

The issue has been introduce enabling hw rx de-amsdu since the hw can
interleave amsdu frames from both phy. Fix the issue moving the de-amsdu
buffer per-phy.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 29 ++++++++++---------
 drivers/net/wireless/mediatek/mt76/mt76.h     | 11 +++----
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index a41e8cc3a8b1..7684a8cf00fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -508,40 +508,41 @@ void mt76_free_device(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_free_device);
 
-static void mt76_rx_release_burst(struct mt76_dev *dev, enum mt76_rxq_id q,
+static void mt76_rx_release_burst(struct mt76_phy *phy, enum mt76_rxq_id q,
 				  struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	struct sk_buff *nskb = dev->rx_amsdu[q].head;
+	struct sk_buff *nskb = phy->rx_amsdu[q].head;
+	struct mt76_dev *dev = phy->dev;
 
 	/* first amsdu subframe */
-	if (status->first_amsdu) {
-		dev->rx_amsdu[q].tail = &skb_shinfo(skb)->frag_list;
-		dev->rx_amsdu[q].seqno = status->seqno;
-		dev->rx_amsdu[q].head = skb;
+	if (status->amsdu && !phy->rx_amsdu[q].head) {
+		phy->rx_amsdu[q].tail = &skb_shinfo(skb)->frag_list;
+		phy->rx_amsdu[q].seqno = status->seqno;
+		phy->rx_amsdu[q].head = skb;
 		goto enqueue;
 	}
 
 	/* ampdu or out-of-order amsdu subframes */
-	if (!status->amsdu || status->seqno != dev->rx_amsdu[q].seqno) {
+	if (!status->amsdu || status->seqno != phy->rx_amsdu[q].seqno) {
 		/* release pending frames */
-		if (dev->rx_amsdu[q].head)
+		if (phy->rx_amsdu[q].head)
 			__skb_queue_tail(&dev->rx_skb[q],
-					 dev->rx_amsdu[q].head);
+					 phy->rx_amsdu[q].head);
 		nskb = skb;
 		goto reset_burst;
 	}
 
 	/* trailing amsdu subframes */
-	*dev->rx_amsdu[q].tail = skb;
+	*phy->rx_amsdu[q].tail = skb;
 	if (!status->last_amsdu) {
-		dev->rx_amsdu[q].tail = &skb->next;
+		phy->rx_amsdu[q].tail = &skb->next;
 		return;
 	}
 
 reset_burst:
-	dev->rx_amsdu[q].head = NULL;
-	dev->rx_amsdu[q].tail = NULL;
+	phy->rx_amsdu[q].head = NULL;
+	phy->rx_amsdu[q].tail = NULL;
 enqueue:
 	if (nskb)
 		__skb_queue_tail(&dev->rx_skb[q], nskb);
@@ -565,7 +566,7 @@ void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb)
 	}
 #endif
 
-	mt76_rx_release_burst(dev, q, skb);
+	mt76_rx_release_burst(phy, q, skb);
 }
 EXPORT_SYMBOL_GPL(mt76_rx);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index cba41a71f4a0..2cfe5584f33f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -609,6 +609,12 @@ struct mt76_phy {
 
 	struct delayed_work mac_work;
 	u8 mac_work_count;
+
+	struct {
+		struct sk_buff *head;
+		struct sk_buff **tail;
+		u16 seqno;
+	} rx_amsdu[__MT_RXQ_MAX];
 };
 
 struct mt76_dev {
@@ -641,11 +647,6 @@ struct mt76_dev {
 	spinlock_t rx_lock;
 	struct napi_struct napi[__MT_RXQ_MAX];
 	struct sk_buff_head rx_skb[__MT_RXQ_MAX];
-	struct {
-		struct sk_buff *head;
-		struct sk_buff **tail;
-		u16 seqno;
-	} rx_amsdu[__MT_RXQ_MAX];
 
 	struct list_head txwi_cache;
 	struct mt76_queue *q_mcu[__MT_MCUQ_MAX];
-- 
2.30.2

