Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479BA729281
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbjFIIQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbjFIIQ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 04:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7558C3A8E
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 01:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9823865475
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 08:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC79DC433EF;
        Fri,  9 Jun 2023 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298596;
        bh=UGsJMQ5u3PurbmBI6EApXcXFyvKX+fM4SrF10b9e7ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bX0ggogooBPxWxAd/LF00e/GRG4vPNCoppRt3qkAbrJT4DuCR4rl+aVmPKGMEAM5u
         g/xx3J+66IkYy439uH5QE8ynIoCmTE1/6a1Lc83myTdW6K83WHXgO5k20csvLHGIpu
         t5RXswovpIvp4GNWawLwBJDV0ge5OWrUvrI4LgkIarRHuTHijjTZk8466IzQBSOEbU
         WhEO67VfcOn0uE9fmpGtgEdxTEr+a70sB2KOcXS6N5KLYWNS3Xqxq39QCHgCPAYutd
         Ph6rE0aJ2GpMmkde8wJRSAdpfmV20M5yKr5oW7sFKDcMfosFYBpXbSzTFjfIDuRxTG
         wLIOMI5voIaCA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2 11/15] wifi: mt76: move ampdu_state in mt76_wcid
Date:   Fri,  9 Jun 2023 10:15:40 +0200
Message-Id: <7845ea90fa92dcc0c0cf776d28431b8de93db134.1686298162.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686298162.git.lorenzo@kernel.org>
References: <cover.1686298162.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ampdu_state field is used by most of the drivers, so move it in
mt76_wcid structure.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h          | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 1 -
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 1 -
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 1 -
 10 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 997bd722b045..878cebb8a4e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -316,6 +316,7 @@ struct mt76_wcid {
 	int inactive_count;
 
 	struct rate_info rate;
+	unsigned long ampdu_state;
 
 	u16 idx;
 	u8 hw_key_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b499ab7d95f8..5c2c054b31fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -863,7 +863,7 @@ mt7915_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		return;
 
 	msta = (struct mt7915_sta *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &msta->ampdu_state))
+	if (!test_and_set_bit(tid, &msta->wcid.ampdu_state))
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index cf1ed8632925..f2b4a99bd142 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -802,16 +802,16 @@ mt7915_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->ampdu_state);
+		clear_bit(tid, &msta->wcid.ampdu_state);
 		ret = mt7915_mcu_add_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		set_bit(tid, &msta->ampdu_state);
+		set_bit(tid, &msta->wcid.ampdu_state);
 		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->ampdu_state);
+		clear_bit(tid, &msta->wcid.ampdu_state);
 		ret = mt7915_mcu_add_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 0ebd44fa5f5f..ca01199afd11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -137,7 +137,6 @@ struct mt7915_sta {
 
 	unsigned long changed;
 	unsigned long jiffies;
-	unsigned long ampdu_state;
 	struct mt76_connac_sta_key_conf bip;
 
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 561590713e0b..f0e67e62abc2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -531,7 +531,7 @@ static void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		return;
 
 	msta = (struct mt7921_sta *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &msta->ampdu_state))
+	if (!test_and_set_bit(tid, &msta->wcid.ampdu_state))
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 2512c1c1fb89..ecfa3ef70902 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -955,16 +955,16 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->ampdu_state);
+		clear_bit(tid, &msta->wcid.ampdu_state);
 		mt7921_mcu_uni_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		set_bit(tid, &msta->ampdu_state);
+		set_bit(tid, &msta->wcid.ampdu_state);
 		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->ampdu_state);
+		clear_bit(tid, &msta->wcid.ampdu_state);
 		mt7921_mcu_uni_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index bd2c4190b77e..d4dfbbdb5f27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -156,7 +156,6 @@ struct mt7921_sta {
 	struct ewma_avg_signal avg_ack_signal;
 
 	unsigned long last_txs;
-	unsigned long ampdu_state;
 
 	struct mt76_connac_sta_key_conf bip;
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 5e1f26d3c5ad..753e9c7b1199 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1199,7 +1199,7 @@ mt7996_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		return;
 
 	msta = (struct mt7996_sta *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &msta->ampdu_state))
+	if (!test_and_set_bit(tid, &msta->wcid.ampdu_state))
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 1a5d646631a6..2d20de7c8916 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -752,16 +752,16 @@ mt7996_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->ampdu_state);
+		clear_bit(tid, &msta->wcid.ampdu_state);
 		ret = mt7996_mcu_add_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		set_bit(tid, &msta->ampdu_state);
+		set_bit(tid, &msta->wcid.ampdu_state);
 		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->ampdu_state);
+		clear_bit(tid, &msta->wcid.ampdu_state);
 		ret = mt7996_mcu_add_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index e1ab38bf9118..829973abc28d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -103,7 +103,6 @@ struct mt7996_sta {
 
 	unsigned long changed;
 	unsigned long jiffies;
-	unsigned long ampdu_state;
 
 	struct mt76_connac_sta_key_conf bip;
 
-- 
2.40.1

