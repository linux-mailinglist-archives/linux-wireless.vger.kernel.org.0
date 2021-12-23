Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708BD47E2E4
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348107AbhLWMIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348095AbhLWMIH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7DBC061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 04:08:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A94BEB81FDC
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F383C36AE5;
        Thu, 23 Dec 2021 12:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261284;
        bh=bEOTiqN4KjxEOMqsl/q1EsYSECdGCwABeDQUTYTEtUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2MokG8APBMKHOEq8heX1Vz5LtJScVY3HSDgBc44c2XDMg/tVDL4dsckur1NC6AGb
         WjlbpFQC9anewVq/saIYhVfkutJbDb8d0lMKMUvNOyDD0Hvbz+lgeFVzky3ElBqsLn
         sMx1ITJFJJDXLwWOrsGnf4BASbIpEeh1NwJm95OlV5b2UO7AMhaLCs3UNe3HivJNN2
         UKKO4jMXywumKa7/6wP5BzyykAiUsnLasZvDXoc5nM50sQUnGysxOboxYqHRilh8L+
         6pe6NZTeoXuc174y3IoFBUbm/7DxBezItDPHK+74R79tB39Aym3ztovAiPvlQrNbrq
         YKmjInTW310Bg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 02/15] mt76: connac: move mt76_connac_mcu_bss_omac_tlv in connac module
Date:   Thu, 23 Dec 2021 13:07:30 +0100
Message-Id: <6f0558cf1bede074b6f0448bf29b64d3dd03fa00.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7915_mcu_bss_omac_tlv/mt7615_mcu_bss_omac_tlv in connac module
since it is shared between mt7615 and mt7915 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 43 +------------------
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 42 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 ++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 39 +----------------
 4 files changed, 47 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 759dcf0e6783..7c48bce8becc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -836,47 +836,6 @@ mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	return 0;
 }
 
-static void
-mt7615_mcu_bss_omac_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
-{
-	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-	u8 omac_idx = mvif->mt76.omac_idx;
-	struct bss_info_omac *omac;
-	struct tlv *tlv;
-	u32 type = 0;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MONITOR:
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
-		if (vif->p2p)
-			type = CONNECTION_P2P_GO;
-		else
-			type = CONNECTION_INFRA_AP;
-		break;
-	case NL80211_IFTYPE_STATION:
-		if (vif->p2p)
-			type = CONNECTION_P2P_GC;
-		else
-			type = CONNECTION_INFRA_STA;
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		type = CONNECTION_IBSS_ADHOC;
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	omac = (struct bss_info_omac *)tlv;
-	omac->conn_type = cpu_to_le32(type);
-	omac->omac_idx = mvif->mt76.omac_idx;
-	omac->band_idx = mvif->mt76.band_idx;
-	omac->hw_bss_idx = omac_idx > EXT_BSSID_START ? HW_BSSID_0 : omac_idx;
-}
-
 /* SIFS 20us + 512 byte beacon tranmitted by 1Mbps (3906us) */
 #define BCN_TX_ESTIMATE_TIME (4096 + 20)
 static void
@@ -913,7 +872,7 @@ mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	if (enable)
-		mt7615_mcu_bss_omac_tlv(skb, vif);
+		mt76_connac_mcu_bss_omac_tlv(skb, vif);
 
 	mt7615_mcu_bss_basic_tlv(skb, vif, sta, phy, enable);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 7a7009b0d8e2..44be4e65391b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -316,6 +316,48 @@ mt76_connac_mcu_alloc_wtbl_req(struct mt76_dev *dev, struct mt76_wcid *wcid,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_alloc_wtbl_req);
 
+void mt76_connac_mcu_bss_omac_tlv(struct sk_buff *skb,
+				  struct ieee80211_vif *vif)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	u8 omac_idx = mvif->omac_idx;
+	struct bss_info_omac *omac;
+	struct tlv *tlv;
+	u32 type = 0;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_AP:
+		if (vif->p2p)
+			type = CONNECTION_P2P_GO;
+		else
+			type = CONNECTION_INFRA_AP;
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (vif->p2p)
+			type = CONNECTION_P2P_GC;
+		else
+			type = CONNECTION_INFRA_STA;
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		type = CONNECTION_IBSS_ADHOC;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
+
+	omac = (struct bss_info_omac *)tlv;
+	omac->conn_type = cpu_to_le32(type);
+	omac->omac_idx = mvif->omac_idx;
+	omac->band_idx = mvif->band_idx;
+	omac->hw_bss_idx = omac_idx > EXT_BSSID_START ? HW_BSSID_0 : omac_idx;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_omac_tlv);
+
 void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index fc9a08436d43..ec37225db5fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1592,4 +1592,7 @@ int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			    struct mt76_connac_sta_key_conf *sta_key_conf,
 			    struct ieee80211_key_conf *key, int mcu_cmd,
 			    struct mt76_wcid *wcid, enum set_key_cmd cmd);
+
+void mt76_connac_mcu_bss_omac_tlv(struct sk_buff *skb,
+				  struct ieee80211_vif *vif);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ec7ca7e90c48..20dc4de75ee2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -552,43 +552,6 @@ mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	return 0;
 }
 
-static void
-mt7915_mcu_bss_omac_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct bss_info_omac *omac;
-	struct tlv *tlv;
-	u32 type = 0;
-	u8 idx;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_OMAC, sizeof(*omac));
-
-	switch (vif->type) {
-	case NL80211_IFTYPE_MONITOR:
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_AP:
-		type = CONNECTION_INFRA_AP;
-		break;
-	case NL80211_IFTYPE_STATION:
-		type = CONNECTION_INFRA_STA;
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		type = CONNECTION_IBSS_ADHOC;
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	}
-
-	omac = (struct bss_info_omac *)tlv;
-	idx = mvif->mt76.omac_idx > EXT_BSSID_START ? HW_BSSID_0
-						    : mvif->mt76.omac_idx;
-	omac->conn_type = cpu_to_le32(type);
-	omac->omac_idx = mvif->mt76.omac_idx;
-	omac->band_idx = mvif->mt76.band_idx;
-	omac->hw_bss_idx = idx;
-}
-
 struct mt7915_he_obss_narrow_bw_ru_data {
 	bool tolerated;
 };
@@ -837,7 +800,7 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 
 	/* bss_omac must be first */
 	if (enable)
-		mt7915_mcu_bss_omac_tlv(skb, vif);
+		mt76_connac_mcu_bss_omac_tlv(skb, vif);
 
 	mt7915_mcu_bss_basic_tlv(skb, vif, phy, enable);
 
-- 
2.33.1

