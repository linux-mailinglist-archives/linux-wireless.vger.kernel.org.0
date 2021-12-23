Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9179047E2E9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348116AbhLWMIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbhLWMIL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A86C061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 04:08:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F7CAB81F6D
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C997EC36AEA;
        Thu, 23 Dec 2021 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261288;
        bh=D2hi6vZ0dF/AB15kIWyGKMpd7u9PQ0CUP44HtuBSM6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjWgdUxIKhGAoVEX207ux8ls3CXpzWLF0WVVfWlt575Ukmpw6WE0jzNmifZLtdt/h
         wi44PK9Dh4hgif4CAGJa4UWS15QpoMuASUbvBD6J4kUS07RVV5ntpSTGLSRPTjipUw
         8hqnvNLTuf5MRtj4jhCWr7N/VcgvMGmieES5gSx/Xvqwqk5vLnVzD8imuXBZC9AJyi
         e7t2rkGkyKjNmT2LVsTijz8HgFbk9X9++d2xGcCQO+kDjlAIjpl25Gz5Qrmx6nJOCw
         +LnY/75MP1wSbTDupgLp21BOOWZDDn5gqb2oJNs/iG8NEOHWUDOk+pDY4DC6Yfd4Dd
         npQM/KdmeWnYg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 04/15] mt76: connac: move mt76_connac_mcu_bss_basic_tlv in connac module
Date:   Thu, 23 Dec 2021 13:07:32 +0100
Message-Id: <f6ca98ba8a7c20cc60e4481a38c2722d9d43fe50.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7615_mcu_bss_basic_tlv/mt7915_mcu_bss_basic_tlv in connac
module since it is shared between mt7615 and mt7915 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 55 +--------------
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 65 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  5 ++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 68 +------------------
 4 files changed, 74 insertions(+), 119 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 40b8cdc29ed3..3bec99f08009 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -784,58 +784,6 @@ mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
 				 &req, sizeof(req), true);
 }
 
-static int
-mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta, struct mt7615_phy *phy,
-			 bool enable)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	u32 type = vif->p2p ? NETWORK_P2P : NETWORK_INFRA;
-	struct bss_info_basic *bss;
-	u8 wlan_idx = mvif->sta.wcid.idx;
-	struct tlv *tlv;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
-	case NL80211_IFTYPE_MONITOR:
-		break;
-	case NL80211_IFTYPE_STATION:
-		/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
-		if (enable && sta) {
-			struct mt7615_sta *msta;
-
-			msta = (struct mt7615_sta *)sta->drv_priv;
-			wlan_idx = msta->wcid.idx;
-		}
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		type = NETWORK_IBSS;
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	bss = (struct bss_info_basic *)tlv;
-	bss->network_type = cpu_to_le32(type);
-	bss->bmc_wcid_lo = wlan_idx;
-	bss->wmm_idx = mvif->mt76.wmm_idx;
-	bss->active = enable;
-
-	if (vif->type != NL80211_IFTYPE_MONITOR) {
-		memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
-		bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
-		bss->dtim_period = vif->bss_conf.dtim_period;
-	} else {
-		memcpy(bss->bssid, phy->mt76->macaddr, ETH_ALEN);
-	}
-
-	return 0;
-}
-
 static int
 mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta, bool enable)
@@ -854,7 +802,8 @@ mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	if (enable)
 		mt76_connac_mcu_bss_omac_tlv(skb, vif);
 
-	mt7615_mcu_bss_basic_tlv(skb, vif, sta, phy, enable);
+	mt76_connac_mcu_bss_basic_tlv(skb, vif, sta, phy->mt76,
+				      mvif->sta.wcid.idx, enable);
 
 	if (enable && mvif->mt76.omac_idx >= EXT_BSSID_START &&
 	    mvif->mt76.omac_idx < REPEATER_BSSID_START)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 93c5e4d0ea8c..7788f0073c1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2632,5 +2632,70 @@ void mt76_connac_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt76_vif *mvif)
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_ext_tlv);
 
+int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta,
+				  struct mt76_phy *phy, u8 wlan_idx,
+				  bool enable)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	u32 type = vif->p2p ? NETWORK_P2P : NETWORK_INFRA;
+	struct bss_info_basic *bss;
+	struct tlv *tlv;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_MONITOR:
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (enable) {
+			rcu_read_lock();
+			if (!sta)
+				sta = ieee80211_find_sta(vif,
+							 vif->bss_conf.bssid);
+			/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
+			if (sta) {
+				struct mt76_wcid *wcid;
+
+				wcid = (struct mt76_wcid *)sta->drv_priv;
+				wlan_idx = wcid->idx;
+			}
+			rcu_read_unlock();
+		}
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		type = NETWORK_IBSS;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
+
+	bss = (struct bss_info_basic *)tlv;
+	bss->network_type = cpu_to_le32(type);
+	bss->bmc_wcid_lo = to_wcid_lo(wlan_idx);
+	bss->bmc_wcid_hi = to_wcid_hi(wlan_idx);
+	bss->wmm_idx = mvif->wmm_idx;
+	bss->active = enable;
+
+	if (vif->type != NL80211_IFTYPE_MONITOR) {
+		struct cfg80211_chan_def *chandef = &phy->chandef;
+
+		memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
+		bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
+		bss->dtim_period = vif->bss_conf.dtim_period;
+		bss->phy_mode = mt76_connac_get_phy_mode(phy, vif,
+							 chandef->chan->band, NULL);
+	} else {
+		memcpy(bss->bssid, phy->macaddr, ETH_ALEN);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_basic_tlv);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 84ab91decdb7..ccae578922f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1596,4 +1596,9 @@ int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 void mt76_connac_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt76_vif *mvif);
 void mt76_connac_mcu_bss_omac_tlv(struct sk_buff *skb,
 				  struct ieee80211_vif *vif);
+int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta,
+				  struct mt76_phy *phy, u8 wlan_idx,
+				  bool enable);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 32a461182cdf..4fb7bc81d7c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -487,71 +487,6 @@ mt7915_mcu_add_nested_subtlv(struct sk_buff *skb, int sub_tag, int sub_len,
 }
 
 /** bss info **/
-static int
-mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			 struct mt7915_phy *phy, bool enable)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct bss_info_basic *bss;
-	u16 wlan_idx = mvif->sta.wcid.idx;
-	u32 type = NETWORK_INFRA;
-	struct tlv *tlv;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_BASIC, sizeof(*bss));
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
-	case NL80211_IFTYPE_MONITOR:
-		break;
-	case NL80211_IFTYPE_STATION:
-		/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
-		if (enable) {
-			struct ieee80211_sta *sta;
-			struct mt7915_sta *msta;
-
-			rcu_read_lock();
-			sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
-			if (!sta) {
-				rcu_read_unlock();
-				return -EINVAL;
-			}
-
-			msta = (struct mt7915_sta *)sta->drv_priv;
-			wlan_idx = msta->wcid.idx;
-			rcu_read_unlock();
-		}
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		type = NETWORK_IBSS;
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	bss = (struct bss_info_basic *)tlv;
-	bss->network_type = cpu_to_le32(type);
-	bss->bmc_wcid_lo = to_wcid_lo(wlan_idx);
-	bss->bmc_wcid_hi = to_wcid_hi(wlan_idx);
-	bss->wmm_idx = mvif->mt76.wmm_idx;
-	bss->active = enable;
-
-	if (vif->type != NL80211_IFTYPE_MONITOR) {
-		struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
-
-		memcpy(bss->bssid, vif->bss_conf.bssid, ETH_ALEN);
-		bss->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
-		bss->dtim_period = vif->bss_conf.dtim_period;
-		bss->phy_mode = mt76_connac_get_phy_mode(phy->mt76, vif,
-							 chandef->chan->band, NULL);
-	} else {
-		memcpy(bss->bssid, phy->mt76->macaddr, ETH_ALEN);
-	}
-
-	return 0;
-}
-
 struct mt7915_he_obss_narrow_bw_ru_data {
 	bool tolerated;
 };
@@ -782,7 +717,8 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 	if (enable)
 		mt76_connac_mcu_bss_omac_tlv(skb, vif);
 
-	mt7915_mcu_bss_basic_tlv(skb, vif, phy, enable);
+	mt76_connac_mcu_bss_basic_tlv(skb, vif, NULL, phy->mt76,
+				      mvif->sta.wcid.idx, enable);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		goto out;
-- 
2.33.1

