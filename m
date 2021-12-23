Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A34447E2F0
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348133AbhLWMIX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348131AbhLWMIW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E70C061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 04:08:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBE3F61E67
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1884EC36AE5;
        Thu, 23 Dec 2021 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261301;
        bh=Sq2lHScTq3Lvz0EsdSIWqHwD4Y6At29L5wa85ozuCwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dslq9crTA6I4YaesXlNFnBYmseQUjlCXKmfOIWFiBctHfSz2fM2H2YOWZqG7oHdHg
         XJ9tQM2s+NYwHOVGm/8XxLo1n2xNlKnrlaGG6u+GGz/FLdldTjXDBe7Jf+zf6/sSwP
         ARIM+tpJFWqexqM9f4pnLz1oKfB7TFRwFzwB54SKb0qYL+oqqaOv/aFwtKAVCOe5xB
         gv7W61KueuS5j2Z/9ZlTrqgsqCzVsLy+A/bLMBTTEhNGRfP9BEx6HPsI8EK7FUDgj1
         d03Lrg3oem8FJ0IlqS2dhYUm/gCKvTSHiqlxtbD7r2HfBXe+mL55W09n2t901rHmR+
         eHM5JFfIYIpGA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 12/15] mt76: mt7915: rely on mt76_connac_mcu_wtbl_ht_tlv
Date:   Thu, 23 Dec 2021 13:07:40 +0100
Message-Id: <db1423c61fe9c7c38fec564f725a53cadcdbad11.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_wtbl_ht_tlv routine and
remove duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 12 +++--
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 46 +------------------
 4 files changed, 11 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 45c16f5f39a9..2bb8eb804883 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -918,7 +918,7 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 						 NULL, wtbl_hdr);
 		if (sta)
 			mt76_connac_mcu_wtbl_ht_tlv(&dev->mt76, wskb, sta,
-						    NULL, wtbl_hdr);
+						    NULL, wtbl_hdr, true);
 		mt76_connac_mcu_wtbl_hdr_trans_tlv(wskb, vif, &msta->wcid,
 						   NULL, wtbl_hdr);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 769b3da486cc..8d9d9d449175 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -877,7 +877,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_smps_tlv);
 
 void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_sta *sta, void *sta_wtbl,
-				 void *wtbl_tlv)
+				 void *wtbl_tlv, bool ldpc)
 {
 	struct wtbl_ht *ht = NULL;
 	struct tlv *tlv;
@@ -887,7 +887,8 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
 						     wtbl_tlv, sta_wtbl);
 		ht = (struct wtbl_ht *)tlv;
-		ht->ldpc = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
+		ht->ldpc = ldpc &&
+			   !!(sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
 		ht->af = sta->ht_cap.ampdu_factor;
 		ht->mm = sta->ht_cap.ampdu_density;
 		ht->ht = true;
@@ -901,7 +902,8 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 						     sizeof(*vht), wtbl_tlv,
 						     sta_wtbl);
 		vht = (struct wtbl_vht *)tlv;
-		vht->ldpc = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
+		vht->ldpc = ldpc &&
+			    !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
 		vht->vht = true;
 
 		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
@@ -912,7 +914,7 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 
 	mt76_connac_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
 
-	if (!is_mt7921(dev) && sta->ht_cap.ht_supported) {
+	if (!is_mt7921(dev) && !is_mt7915(dev) && sta->ht_cap.ht_supported) {
 		/* sgi */
 		u32 msk = MT_WTBL_W5_SHORT_GI_20 | MT_WTBL_W5_SHORT_GI_40 |
 			  MT_WTBL_W5_SHORT_GI_80 | MT_WTBL_W5_SHORT_GI_160;
@@ -980,7 +982,7 @@ int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
 						   sta_wtbl, wtbl_hdr);
 		if (info->sta)
 			mt76_connac_mcu_wtbl_ht_tlv(dev, skb, info->sta,
-						    sta_wtbl, wtbl_hdr);
+						    sta_wtbl, wtbl_hdr, true);
 	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 68754f4aa1bb..3b642be4d101 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1518,7 +1518,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     u8 rcpi, u8 state);
 void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_sta *sta, void *sta_wtbl,
-				 void *wtbl_tlv);
+				 void *wtbl_tlv, bool ldpc);
 void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_ampdu_params *params,
 				 bool enable, bool tx, void *sta_wtbl,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 9794a0383748..c307c79fd80c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1022,49 +1022,6 @@ mt7915_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	msta->wcid.amsdu = true;
 }
 
-static void
-mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, void *sta_wtbl,
-		       void *wtbl_tlv)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct wtbl_ht *ht = NULL;
-	struct tlv *tlv;
-
-	/* wtbl ht */
-	if (sta->ht_cap.ht_supported) {
-		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_HT, sizeof(*ht),
-						     wtbl_tlv, sta_wtbl);
-		ht = (struct wtbl_ht *)tlv;
-		ht->ldpc = mvif->cap.ldpc &&
-			   (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING);
-		ht->af = sta->ht_cap.ampdu_factor;
-		ht->mm = sta->ht_cap.ampdu_density;
-		ht->ht = true;
-	}
-
-	/* wtbl vht */
-	if (sta->vht_cap.vht_supported) {
-		struct wtbl_vht *vht;
-		u8 af;
-
-		tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_VHT,
-						     sizeof(*vht), wtbl_tlv,
-						     sta_wtbl);
-		vht = (struct wtbl_vht *)tlv;
-		vht->ldpc = mvif->cap.ldpc &&
-			    (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC);
-		vht->vht = true;
-
-		af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
-			       sta->vht_cap.cap);
-		if (ht)
-			ht->af = max_t(u8, ht->af, af);
-	}
-
-	mt76_connac_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
-}
-
 static void
 mt7915_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 			      struct ieee80211_sta *sta,
@@ -1117,7 +1074,8 @@ mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, tlv, wtbl_hdr);
 
 	if (sta)
-		mt7915_mcu_wtbl_ht_tlv(skb, vif, sta, tlv, wtbl_hdr);
+		mt76_connac_mcu_wtbl_ht_tlv(&dev->mt76, skb, sta, tlv,
+					    wtbl_hdr, mvif->cap.ldpc);
 
 	return 0;
 }
-- 
2.33.1

