Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078F771481D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 May 2023 12:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjE2KmY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 May 2023 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjE2KmX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 May 2023 06:42:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B98E5
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 03:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40AA862350
        for <linux-wireless@vger.kernel.org>; Mon, 29 May 2023 10:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5631FC4339B;
        Mon, 29 May 2023 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356936;
        bh=lGrPCM0BBP4UFK5efTw9561LeLpZpeWkaHWI2ZiZak8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHUo2bG3V4vWw1bWI8/iZ5zFCg429Z7w7vGghxalGLaHDtCtDdT6VyOpHTyXliDWj
         4qCZrM+JcJzaNbsmr9KOANT546Pdbg9QLip/HECtz1zCJMpMszpHdS006+s0Ac7ZRA
         DrgIEv6pY8EtJw3P2KFeYKrGsWfGUpPW29juELfieteA3O27TszwIclSYJqgy2UvIk
         aqH+V8Z48VQrGgwL1/t2hOfultVA6Po+X3xn8O9QMlXDSxrwmTdTitKQmodw0GGbLI
         4i3RbP2kRLaS8xUvKqJbAdWe/kWzqOeeMddD6afQyHRbCcpkA47cEysYJo0XWtdsDN
         6ljvmBpBvbO7w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 12/13] wifi: mt76: move ampdu_state in mt76_wcid
Date:   Mon, 29 May 2023 12:41:03 +0200
Message-Id: <df3bc0c0513488776634212cc4feb2b6a9794b4a.1685356673.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685356673.git.lorenzo@kernel.org>
References: <cover.1685356673.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index c8d7564ff17e..233e7be90992 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -157,7 +157,6 @@ struct mt7921_sta {
 	struct ewma_avg_signal avg_ack_signal;
 
 	unsigned long last_txs;
-	unsigned long ampdu_state;
 
 	struct mt76_connac_sta_key_conf bip;
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index f69ade14e7ab..90fd0e91a975 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1194,7 +1194,7 @@ mt7996_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		return;
 
 	msta = (struct mt7996_sta *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &msta->ampdu_state))
+	if (!test_and_set_bit(tid, &msta->wcid.ampdu_state))
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 1ab8dba4db9a..84e8d2914ab9 100644
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
index cf27f892eaf5..48936a3381aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -103,7 +103,6 @@ struct mt7996_sta {
 
 	unsigned long changed;
 	unsigned long jiffies;
-	unsigned long ampdu_state;
 
 	struct mt76_sta_stats stats;
 
-- 
2.40.1

