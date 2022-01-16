Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0589948FCCD
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiAPMn7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:43:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58678 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbiAPMn6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:43:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3215FB80BAA
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 12:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A092BC36AEC;
        Sun, 16 Jan 2022 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642337035;
        bh=H7SeXhSd5opCKPqGBqpGj/hWQqbbBnba2ZTldsXM2dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwLhStuzzv4nXirpEWKx/64reqDjtpeovr6kOtaQNdkR20HcVbfAZlWLWUsLurROK
         jVEpoDwqZvhdhOhWGVEyih7oPtbb7TuPCWbn/Iz7X70G5pgXAnNlDUxhhlABxmy4wK
         HL29ezj/AV+TxxLPEwNz7JTCYrGhvkZXpvwmU+sFz3iiwEmbrhDqN1Qe+uFcpC6mdT
         5PDr4tAVvZIod1zvQxfTDm83025XofO1zKeQbpogAv3Z/IQzvzsY3R/oMucIo8uXti
         20RJyhxxEtLfYMMd1VDV6UtmEmSQGazi+tFhS+TIAk9gYSL/nieyVbV8jpSolQxx6/
         wRAwsgEcA8hAg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 1/5] mt76: connac: move mt76_connac_lmac_mapping in mt76-connac module
Date:   Sun, 16 Jan 2022 13:43:14 +0100
Message-Id: <3417990e16b7281adef3bdfd5d17eb38bd4c6a1b.1642336806.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642336806.git.lorenzo@kernel.org>
References: <cover.1642336806.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76_connac_lmac_mapping is shared between mt7921 and mt7915

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/main.c     | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   | 6 ------
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   | 6 ------
 8 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index b353c26b7d27..e624843c2a25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -159,6 +159,12 @@ static inline u8 mt76_connac_chan_bw(struct cfg80211_chan_def *chandef)
 	return width_to_bw[chandef->width];
 }
 
+static inline u8 mt76_connac_lmac_mapping(u8 ac)
+{
+	/* LMAC uses the reverse order of mac80211 AC indexes */
+	return 3 - ac;
+}
+
 int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm);
 void mt76_connac_power_save_sched(struct mt76_phy *phy,
 				  struct mt76_connac_pm *pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 39163567d712..d11002342f01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -165,7 +165,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		sta = container_of((void *)msta, struct ieee80211_sta,
 				   drv_priv);
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			u8 q = mt7915_lmac_mapping(dev, i);
+			u8 q = mt76_connac_lmac_mapping(i);
 			u32 tx_cur = tx_time[q];
 			u32 rx_cur = rx_time[q];
 			u8 tid = ac_to_tid[i];
@@ -1205,7 +1205,7 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	} else {
 		p_fmt = MT_TX_TYPE_CT;
 		q_idx = wmm_idx * MT7915_MAX_WMM_SETS +
-			mt7915_lmac_mapping(dev, skb_get_queue_mapping(skb));
+			mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
 	}
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + MT_TXD_SIZE) |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3620aa873417..ae495dc5e28c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -506,11 +506,10 @@ static int
 mt7915_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
-	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 
 	/* no need to update right away, we'll get BSS_CHANGED_QOS */
-	queue = mt7915_lmac_mapping(dev, queue);
+	queue = mt76_connac_lmac_mapping(queue);
 	mvif->queue_params[queue] = *params;
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index f5c22b86e1a9..bc3a3dcdb3a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -378,12 +378,6 @@ mt7915_ext_phy(struct mt7915_dev *dev)
 	return phy->priv;
 }
 
-static inline u8 mt7915_lmac_mapping(struct mt7915_dev *dev, u8 ac)
-{
-	/* LMAC uses the reverse order of mac80211 AC indexes */
-	return 3 - ac;
-}
-
 extern const struct ieee80211_ops mt7915_ops;
 extern const struct mt76_testmode_ops mt7915_testmode_ops;
 extern struct pci_driver mt7915_pci_driver;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 8300f262a654..83da21d15ddd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -250,7 +250,7 @@ mt7915_tm_set_ipg_params(struct mt7915_phy *phy, u32 ipg, u8 mode)
 	mt7915_tm_set_slot_time(phy, slot_time, sifs);
 
 	return mt7915_tm_set_wmm_qid(dev,
-				     mt7915_lmac_mapping(dev, IEEE80211_AC_BE),
+				     mt76_connac_lmac_mapping(IEEE80211_AC_BE),
 				     aifsn, cw, cw, 0);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 83fd4fb6283c..dc7a2f5caf67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -116,7 +116,7 @@ void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 		sta = container_of((void *)msta, struct ieee80211_sta,
 				   drv_priv);
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			u8 q = mt7921_lmac_mapping(dev, i);
+			u8 q = mt76_connac_lmac_mapping(i);
 			u32 tx_cur = tx_time[q];
 			u32 rx_cur = rx_time[q];
 			u8 tid = ac_to_tid[i];
@@ -949,7 +949,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 	} else {
 		p_fmt = is_mmio ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
 		q_idx = wmm_idx * MT7921_MAX_WMM_SETS +
-			mt7921_lmac_mapping(dev, skb_get_queue_mapping(skb));
+			mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
 	}
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 92371f3c99a0..0a34c99ba238 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -537,11 +537,10 @@ static int
 mt7921_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
 	       const struct ieee80211_tx_queue_params *params)
 {
-	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
 
 	/* no need to update right away, we'll get BSS_CHANGED_QOS */
-	queue = mt7921_lmac_mapping(dev, queue);
+	queue = mt76_connac_lmac_mapping(queue);
 	mvif->queue_params[queue] = *params;
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 7e763b0d9d40..1ccb99584d13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -272,12 +272,6 @@ mt7921_hw_dev(struct ieee80211_hw *hw)
 #define mt7921_mutex_release(dev)	\
 	mt76_connac_mutex_release(&(dev)->mt76, &(dev)->pm)
 
-static inline u8 mt7921_lmac_mapping(struct mt7921_dev *dev, u8 ac)
-{
-	/* LMAC uses the reverse order of mac80211 AC indexes */
-	return 3 - ac;
-}
-
 extern const struct ieee80211_ops mt7921_ops;
 extern struct pci_driver mt7921_pci_driver;
 
-- 
2.34.1

