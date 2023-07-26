Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122967631A8
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 11:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjGZJUw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 05:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjGZJUe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 05:20:34 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F061738
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QmWW1z9leCPxHXI76pBWSGhj/lZzSfgISVk6ICzsuhI=; b=jm60dwM/C5XLileHzFEHVAvNFU
        5+9x4QaS0pg9RDsvWMvxfVI4/UDbJAhgouymOgmzEvMoHZMcED03TIXPwte3FhjZ/IiL1Y9X/+Ixa
        HgJ/LLXfqTNsrzcn7wySGfrAgTmT7Rtu5xJdszR4nHq9P7nBUM3mL4ybRC/M9smMUUKU=;
Received: from p4ff134dd.dip0.t-ipconnect.de ([79.241.52.221] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qOadt-001nWM-MR
        for linux-wireless@vger.kernel.org; Wed, 26 Jul 2023 11:17:13 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] wifi: mt76: mt7603: fix tx filter/flush function
Date:   Wed, 26 Jul 2023 11:17:04 +0200
Message-ID: <20230726091704.25795-3-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726091704.25795-1-nbd@nbd.name>
References: <20230726091704.25795-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Setting MT_TX_ABORT does not abort any transmission for a wtbl index on its
own. Instead, it modifies the behavior of a queue flush to make it selectively
flush packets for a particular wtbl index.
Adjust powersave filtering to make use of this in order to avoid running into
unnecessary timeouts while flushing

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 21 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  5 ++++-
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/regs.h  |  7 +++++++
 4 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index de11557eb04c..99ae080502d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -178,8 +178,9 @@ mt7603_wtbl_set_skip_tx(struct mt7603_dev *dev, int idx, bool enabled)
 	mt76_wr(dev, addr + 3 * 4, val);
 }
 
-void mt7603_filter_tx(struct mt7603_dev *dev, int idx, bool abort)
+void mt7603_filter_tx(struct mt7603_dev *dev, int mac_idx, int idx, bool abort)
 {
+	u32 flush_mask;
 	int i, port, queue;
 
 	if (abort) {
@@ -195,6 +196,18 @@ void mt7603_filter_tx(struct mt7603_dev *dev, int idx, bool abort)
 	mt76_wr(dev, MT_TX_ABORT, MT_TX_ABORT_EN |
 			FIELD_PREP(MT_TX_ABORT_WCID, idx));
 
+	flush_mask = MT_WF_ARB_TX_FLUSH_AC0 |
+		     MT_WF_ARB_TX_FLUSH_AC1 |
+		     MT_WF_ARB_TX_FLUSH_AC2 |
+		     MT_WF_ARB_TX_FLUSH_AC3;
+	flush_mask <<= mac_idx;
+
+	mt76_wr(dev, MT_WF_ARB_TX_FLUSH_0, flush_mask);
+	mt76_poll(dev, MT_WF_ARB_TX_FLUSH_0, flush_mask, 0, 20000);
+	mt76_wr(dev, MT_WF_ARB_TX_START_0, flush_mask);
+
+	mt76_wr(dev, MT_TX_ABORT, 0);
+
 	for (i = 0; i < 4; i++) {
 		mt76_wr(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY |
 			FIELD_PREP(MT_DMA_FQCR0_TARGET_WCID, idx) |
@@ -202,13 +215,11 @@ void mt7603_filter_tx(struct mt7603_dev *dev, int idx, bool abort)
 			FIELD_PREP(MT_DMA_FQCR0_DEST_PORT_ID, port) |
 			FIELD_PREP(MT_DMA_FQCR0_DEST_QUEUE_ID, queue));
 
-		mt76_poll(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY, 0, 15000);
+		mt76_poll(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY, 0, 5000);
 	}
 
 	WARN_ON_ONCE(mt76_rr(dev, MT_DMA_FQCR0) & MT_DMA_FQCR0_BUSY);
 
-	mt76_wr(dev, MT_TX_ABORT, 0);
-
 	mt7603_wtbl_set_skip_tx(dev, idx, false);
 }
 
@@ -245,7 +256,7 @@ void mt7603_wtbl_set_ps(struct mt7603_dev *dev, struct mt7603_sta *sta,
 	mt76_poll(dev, MT_PSE_RTA, MT_PSE_RTA_BUSY, 0, 5000);
 
 	if (enabled)
-		mt7603_filter_tx(dev, idx, false);
+		mt7603_filter_tx(dev, sta->vif->idx, idx, false);
 
 	addr = mt7603_wtbl1_addr(idx);
 	mt76_set(dev, MT_WTBL1_OR, MT_WTBL1_OR_PSM_WRITE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 1d4893410ca5..c213fd2a5216 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -69,6 +69,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.hw_key_idx = -1;
+	mvif->sta.vif = mvif;
 	mt76_packet_id_init(&mvif->sta.wcid);
 
 	eth_broadcast_addr(bc_addr);
@@ -357,6 +358,7 @@ mt7603_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->smps = ~0;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
+	msta->vif = mvif;
 	mt7603_wtbl_init(dev, idx, mvif->idx, sta->addr);
 	mt7603_wtbl_set_ps(dev, msta, false);
 
@@ -380,12 +382,13 @@ mt7603_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		  struct ieee80211_sta *sta)
 {
 	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
+	struct mt7603_vif *mvif = (struct mt7603_vif *)vif->drv_priv;
 	struct mt7603_sta *msta = (struct mt7603_sta *)sta->drv_priv;
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
 
 	spin_lock_bh(&dev->ps_lock);
 	__skb_queue_purge(&msta->psq);
-	mt7603_filter_tx(dev, wcid->idx, true);
+	mt7603_filter_tx(dev, mvif->idx, wcid->idx, true);
 	spin_unlock_bh(&dev->ps_lock);
 
 	spin_lock_bh(&mdev->sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 354b189862f7..9e58df7042ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -230,7 +230,7 @@ void mt7603_wtbl_set_ps(struct mt7603_dev *dev, struct mt7603_sta *sta,
 			bool enabled);
 void mt7603_wtbl_set_smps(struct mt7603_dev *dev, struct mt7603_sta *sta,
 			  bool enabled);
-void mt7603_filter_tx(struct mt7603_dev *dev, int idx, bool abort);
+void mt7603_filter_tx(struct mt7603_dev *dev, int mac_idx, int idx, bool abort);
 
 int mt7603_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
index 3b901090b29c..a39c9a0fcb1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
@@ -309,6 +309,13 @@ enum {
 #define MT_WF_ARB_TX_STOP_0		MT_WF_ARB(0x110)
 #define MT_WF_ARB_TX_STOP_1		MT_WF_ARB(0x114)
 
+#define MT_WF_ARB_TX_FLUSH_AC0		BIT(0)
+#define MT_WF_ARB_TX_FLUSH_AC1		BIT(5)
+#define MT_WF_ARB_TX_FLUSH_AC2		BIT(10)
+#define MT_WF_ARB_TX_FLUSH_AC3		BIT(16)
+#define MT_WF_ARB_TX_FLUSH_AC4		BIT(21)
+#define MT_WF_ARB_TX_FLUSH_AC5		BIT(26)
+
 #define MT_WF_ARB_BCN_START		MT_WF_ARB(0x118)
 #define MT_WF_ARB_BCN_START_BSSn(n)	BIT(0 + (n))
 #define MT_WF_ARB_BCN_START_T_PRE_TTTT	BIT(10)
-- 
2.41.0

