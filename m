Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F0353F9C9
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbiFGJ3s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 05:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbiFGJ3f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 05:29:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28279B1BD
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 02:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB5B9B81E65
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 09:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FA2C34115;
        Tue,  7 Jun 2022 09:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654594139;
        bh=XcTN7Fzs3y6ZxZTVz65t8LdGDO9Ye+GKUsXZXOdIQ+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ReSiNkvIxGpQ8MBIxc7d7E/wMkqsUd3PzkLWxoByCdfRdonhHB22VW6OS7/DZAyrq
         thaWLrhOGm/wFTlPnDDnDqd33table/PwiFVy8i12JoZDgArW3hLEoNk0QD21yULcN
         SaJdv0SRqSEewtdX3cKBaiGgyg6psQdO7My669yMc+g3IaG3Apg2BSciCeabR22ro3
         rs31d7BHF0Yplj5svzJnxPsNAYTERlu61teeGedwM0r1abaRuWusMG2Feb4xxi/6z1
         EzDF0hKYhl+VjU8nwPO0ssGJujPKy5aehFzbKPDRWRaZpjThyAUMstnorrBGUGvUbl
         fffT1+ZxGKFXA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 2/5] mt76: mt7915: rely on mt76_dev in mt7915_mac_write_txwi signature
Date:   Tue,  7 Jun 2022 11:28:38 +0200
Message-Id: <c368e87bfde121dfeaf9676029e51356defc1228.1654593918.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654593918.git.lorenzo@kernel.org>
References: <cover.1654593918.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to share txwi configuration code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  4 ++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 00d670fa26c9..caed0dbee3cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1010,8 +1010,8 @@ mt7915_mac_write_txwi_tm(struct mt7915_phy *phy, __le32 *txwi,
 }
 
 static void
-mt7915_mac_write_txwi_8023(struct mt7915_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid)
+mt7915_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
+			   struct mt76_wcid *wcid)
 {
 
 	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
@@ -1050,9 +1050,8 @@ mt7915_mac_write_txwi_8023(struct mt7915_dev *dev, __le32 *txwi,
 }
 
 static void
-mt7915_mac_write_txwi_80211(struct mt7915_dev *dev, __le32 *txwi,
-			    struct sk_buff *skb, struct ieee80211_key_conf *key,
-			    bool *mcast)
+mt7915_mac_write_txwi_80211(__le32 *txwi, struct sk_buff *skb,
+			    struct ieee80211_key_conf *key, bool *mcast)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
@@ -1175,13 +1174,13 @@ mt7915_mac_tx_rate_val(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	       FIELD_PREP(MT_TX_RATE_MODE, mode);
 }
 
-void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
+void mt7915_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
 			   struct ieee80211_key_conf *key, u32 changed)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
-	struct mt76_phy *mphy = &dev->mphy;
+	struct mt76_phy *mphy = &dev->phy;
 	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0, band_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
@@ -1201,8 +1200,8 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 		band_idx = mvif->mt76.band_idx;
 	}
 
-	if (ext_phy && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
+	if (ext_phy && dev->phy2)
+		mphy = dev->phy2;
 
 	if (inband_disc) {
 		p_fmt = MT_TX_TYPE_FW;
@@ -1254,9 +1253,9 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	txwi[7] = wcid->amsdu ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
 
 	if (is_8023)
-		mt7915_mac_write_txwi_8023(dev, txwi, skb, wcid);
+		mt7915_mac_write_txwi_8023(txwi, skb, wcid);
 	else
-		mt7915_mac_write_txwi_80211(dev, txwi, skb, key, &mcast);
+		mt7915_mac_write_txwi_80211(txwi, skb, key, &mcast);
 
 	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
 		u16 rate = mt7915_mac_tx_rate_val(mphy, vif, beacon, mcast);
@@ -1315,7 +1314,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		return id;
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
-	mt7915_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, pid, key, 0);
+	mt7915_mac_write_txwi(mdev, txwi_ptr, tx_info->skb, wcid, pid, key, 0);
 
 	txp = (struct mt7915_txp *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 836cceac5174..a05a1376e357 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1853,7 +1853,7 @@ mt7915_mcu_beacon_cont(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	buf = (u8 *)tlv + sizeof(*cont);
-	mt7915_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, 0, NULL,
+	mt7915_mac_write_txwi(&dev->mt76, (__le32 *)buf, skb, wcid, 0, NULL,
 			      BSS_CHANGED_BEACON);
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
@@ -1992,7 +1992,7 @@ mt7915_mcu_beacon_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vi
 
 	buf = (u8 *)tlv + sizeof(*discov);
 
-	mt7915_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, 0, NULL,
+	mt7915_mac_write_txwi(&dev->mt76, (__le32 *)buf, skb, wcid, 0, NULL,
 			      changed);
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index bd985e6ce36a..e0049ab777b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -564,7 +564,7 @@ bool mt7915_mac_wtbl_update(struct mt7915_dev *dev, int idx, u32 mask);
 void mt7915_mac_reset_counters(struct mt7915_phy *phy);
 void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy);
 void mt7915_mac_enable_nf(struct mt7915_dev *dev, bool ext_phy);
-void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
+void mt7915_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
 			   struct ieee80211_key_conf *key, u32 changed);
 void mt7915_mac_set_timing(struct mt7915_phy *phy);
-- 
2.35.3

