Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3893473A67C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 18:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjFVQvv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 12:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjFVQvu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 12:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DA610A
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 09:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40B9B618B0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 16:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A91C433C0;
        Thu, 22 Jun 2023 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687452707;
        bh=T26e6lSB+OptMiaD8GLwaViqQvTvvYtRwWJFlQilJRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plA9hSDA8ctImRD30y5pSQ8kv+wQjAU2Iqvwfi2b2a1Ztk0gY89/hCuZkJMZ9oliJ
         8myJFPF0b55gRGJ6cagkInQP0mfzSAK17pGWA17icrx3y5/abIoNfgzM/WASGSKm+7
         DK+tLI32KSXubZes5GXLekAzTHLwkFvR0Xw5Dm6XY74u6JwR8wOYBmENIJYc4hOq5N
         X/NbcLDEmdM4FbxOalnxMAEh4Nklvi8+MTY2SYJMtWgkjSOcT6ZFAG0efFrjoe2bhH
         UlIIo3Hbh87nLQrjS5xcevoZoPEki/Ek865u5ScyfYFxIqCOh6RpRgkY3Ai1UFmfNt
         lEwruEb80o0/A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, deren.wu@mediatek.com,
        shayne.chen@mediatek.com
Subject: [PATCH v4 11/15] wifi: mt76: move ampdu_state in mt76_wcid
Date:   Thu, 22 Jun 2023 18:50:28 +0200
Message-ID: <012c12b57afb6eb61a314b59cd17bd198f0f1209.1687452202.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687452202.git.lorenzo@kernel.org>
References: <cover.1687452202.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 97e72cf3bc8e..8ec77682d8e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -316,6 +316,7 @@ struct mt76_wcid {
 	int inactive_count;
 
 	struct rate_info rate;
+	unsigned long ampdu_state;
 
 	u16 idx;
 	u8 hw_key_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 99383e4e113a..b58e8275feef 100644
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
index 35fb92c4f19d..db3fc74f0f49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -827,16 +827,16 @@ mt7915_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
index a76dcceb0ec1..066934249a09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -144,7 +144,6 @@ struct mt7915_sta {
 
 	unsigned long changed;
 	unsigned long jiffies;
-	unsigned long ampdu_state;
 	struct mt76_connac_sta_key_conf bip;
 
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index c00342e87405..3e589748e1a3 100644
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
index 49053d05c164..87067ac367eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -954,16 +954,16 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
index fe4de77a0c07..2694ecb1fdcb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -156,7 +156,6 @@ struct mt7921_sta {
 	struct ewma_avg_signal avg_ack_signal;
 
 	unsigned long last_txs;
-	unsigned long ampdu_state;
 
 	struct mt76_connac_sta_key_conf bip;
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2adc2599d64d..dfe70e0ff329 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1204,7 +1204,7 @@ mt7996_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		return;
 
 	msta = (struct mt7996_sta *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &msta->ampdu_state))
+	if (!test_and_set_bit(tid, &msta->wcid.ampdu_state))
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 69b47136b8d7..54858cfc9342 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -774,16 +774,16 @@ mt7996_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
index e67d57a84426..79cb71c16264 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -111,7 +111,6 @@ struct mt7996_sta {
 
 	unsigned long changed;
 	unsigned long jiffies;
-	unsigned long ampdu_state;
 
 	struct mt76_connac_sta_key_conf bip;
 
-- 
2.41.0

