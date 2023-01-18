Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D667867236B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjARQdv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjARQdF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:33:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298855BF
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 08:31:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40AF0B81DA8
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 16:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2FAC433F0;
        Wed, 18 Jan 2023 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674059468;
        bh=e1D/oL0BMEdF3m1VU9uBlqW3UfBr0HH+8OZD37wLSZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcvEO5edvLDfsZYQp2RtBFCSpV/fZlM9G6k5QmsHcEK/2odm0JjTblEMgoK/XMDhx
         cfk7F+t8qcZ8zJdl69O6DJ0KwNDBr1Ogkt2mUwqNH473urtTkX0LerU3a5bu0q5bNw
         qzAVVWU5zxksDqsubaXPFhrckJW665WA1E2b9UjpnwGKScMqiUVgyVIwdATej9IehJ
         xGTmZDTu7jD3G5rGliDepLlF3AS84NcQvjP8AOD0njKEen/ziRwACSgjIKGxXgekhz
         TGW/XDdAybuhPnrA3tHZXlRI8wvpCmldhxZ4DurgMfDVQgLmLXxLJdZW/EY6b5sNbB
         8uAa0cRDtNFNA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 3/4] wifi: mt76: mt7996: rely on mt76_connac_tx_complete_skb
Date:   Wed, 18 Jan 2023 17:30:40 +0100
Message-Id: <7e7d992e788e835a131e2b97d117cdedc786c51a.1674059222.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674059222.git.lorenzo@kernel.org>
References: <cover.1674059222.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop mt7996_tx_complete_skb routine since it is equivalent to
mt76_connac_tx_complete_skb().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 21 -------------------
 .../net/wireless/mediatek/mt76/mt7996/mac.h   | 13 ------------
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  2 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 -
 4 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 7fefb3f71940..56400331e74e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1533,27 +1533,6 @@ void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	}
 }
 
-void mt7996_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
-{
-	if (!e->txwi) {
-		dev_kfree_skb_any(e->skb);
-		return;
-	}
-
-	/* error path */
-	if (e->skb == DMA_DUMMY_DATA) {
-		struct mt76_connac_txp_common *txp;
-		struct mt76_txwi_cache *t;
-
-		txp = mt7996_txwi_to_txp(mdev, e->txwi);
-		t = mt76_token_put(mdev, le16_to_cpu(txp->fw.token));
-		e->skb = t ? t->skb : NULL;
-	}
-
-	if (e->skb)
-		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
-}
-
 void mt7996_mac_cca_stats_reset(struct mt7996_phy *phy)
 {
 	struct mt7996_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
index 10e08d66d474..27184cbac619 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -371,17 +371,4 @@ struct mt7996_dfs_radar_spec {
 	struct mt7996_dfs_pattern radar_pattern[16];
 };
 
-static inline struct mt76_connac_txp_common *
-mt7996_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
-{
-	u8 *txwi;
-
-	if (!t)
-		return NULL;
-
-	txwi = mt76_get_txwi_ptr(dev, t);
-
-	return (struct mt76_connac_txp_common *)(txwi + MT_TXD_SIZE);
-}
-
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 011a55622770..f7492a40ee7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -325,7 +325,7 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 				SURVEY_INFO_TIME_BSS_RX,
 		.token_size = MT7996_TOKEN_SIZE,
 		.tx_prepare_skb = mt7996_tx_prepare_skb,
-		.tx_complete_skb = mt7996_tx_complete_skb,
+		.tx_complete_skb = mt76_connac_tx_complete_skb,
 		.rx_skb = mt7996_queue_rx_skb,
 		.rx_check = mt7996_rx_check,
 		.rx_poll_complete = mt7996_rx_poll_complete,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 725344791b4c..9c6823284834 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -493,7 +493,6 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
-void mt7996_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 void mt7996_tx_token_put(struct mt7996_dev *dev);
 void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
-- 
2.39.0

