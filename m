Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0847930E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbhLQRtC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 12:49:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38418 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbhLQRtC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 12:49:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73F3E62368
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 17:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6292C36AE9;
        Fri, 17 Dec 2021 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639763340;
        bh=1mMxRf5gVgrgGIyw27R7OAgB6P6SvGMFkmuuAnJN7h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxargvdxKV0/plIJvNI7F5WinPI3esyTe6Qp2lpBKDa6tlfGoHJj8pEIOS4x5tqKa
         ciCxdbaCGlw1NdOcv3EsSTgm0wAwVqduJTn4XP2FwRYsDXokhshT1nhn66ysYrhYc5
         tbya3pes2cyM4oUICOfc5NPWK0BSDPgY+mWa2SG1W4C88zNfiq6uyv9Md+gmuSuBjS
         eZ4W5WJIdzTrqq89Gn+s8xEFctbwZ6m/eh+5j1l2AzBjw+8NrbNzwptXYa3mteWTdH
         3j8atutEuBVw8QR4MRpDtDaio9gsiEUYuMnCcrXSnD5l/g1CAVq3d28/7uRN+Lqeog
         OH7qyZHD6iw9w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 1/7] mt76: mt7915: rely on mt76_connac_mcu_alloc_sta_req
Date:   Fri, 17 Dec 2021 18:48:45 +0100
Message-Id: <25810c3e3258c43119bf6db434d02eb3d40745a5.1639763123.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639763123.git.lorenzo@kernel.org>
References: <cover.1639763123.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_alloc_sta_req routine and remove
duplicated code.
Add MT76_CONNAC_LIB module dependency in mt7915 module

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  5 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 10 +--
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 23 ++++++-
 .../net/wireless/mediatek/mt76/mt7915/Kconfig |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 66 +++++++------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 --
 6 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index e7f01c2978a2..45ee7b06fba3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -100,6 +100,11 @@ static inline bool is_mt7663(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7663;
 }
 
+static inline bool is_mt7915(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7915;
+}
+
 int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm);
 void mt76_connac_power_save_sched(struct mt76_phy *phy,
 				  struct mt76_connac_pm *pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index f79e3d5084f3..fc5c870da420 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -266,19 +266,19 @@ mt76_connac_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_nested_tlv);
 
 struct sk_buff *
-mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
-			      struct mt76_wcid *wcid)
+__mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
+				struct mt76_wcid *wcid, int len)
 {
 	struct sta_req_hdr hdr = {
 		.bss_idx = mvif->idx,
-		.muar_idx = wcid ? mvif->omac_idx : 0,
 		.is_tlv_append = 1,
 	};
 	struct sk_buff *skb;
 
+	hdr.muar_idx = mt76_connac_mcu_get_muar_idx(dev, wcid, mvif);
 	mt76_connac_mcu_get_wlan_idx(dev, wcid, &hdr.wlan_idx_lo,
 				     &hdr.wlan_idx_hi);
-	skb = mt76_mcu_msg_alloc(dev, NULL, MT76_CONNAC_STA_UPDATE_MAX_SIZE);
+	skb = mt76_mcu_msg_alloc(dev, NULL, len);
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
@@ -286,7 +286,7 @@ mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
 
 	return skb;
 }
-EXPORT_SYMBOL_GPL(mt76_connac_mcu_alloc_sta_req);
+EXPORT_SYMBOL_GPL(__mt76_connac_mcu_alloc_sta_req);
 
 struct wtbl_req_hdr *
 mt76_connac_mcu_alloc_wtbl_req(struct mt76_dev *dev, struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 5baf8370b7bd..4c0220df18b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -570,6 +570,7 @@ struct wtbl_raw {
 					 sizeof(struct sta_rec_muru) +	\
 					 sizeof(struct sta_rec_bfee) +	\
 					 sizeof(struct sta_rec_ra) +	\
+					 sizeof(struct sta_rec_sec) +	\
 					 sizeof(struct sta_rec_ra_fixed) + \
 					 sizeof(struct sta_rec_he_6g_capa) + \
 					 sizeof(struct tlv) +		\
@@ -1436,7 +1437,7 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
 {
 	*wlan_idx_hi = 0;
 
-	if (is_mt7921(dev)) {
+	if (is_mt7921(dev) || is_mt7915(dev)) {
 		*wlan_idx_lo = wcid ? to_wcid_lo(wcid->idx) : 0;
 		*wlan_idx_hi = wcid ? to_wcid_hi(wcid->idx) : 0;
 	} else {
@@ -1444,9 +1445,27 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	}
 }
 
+static inline int
+mt76_connac_mcu_get_muar_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			     struct mt76_vif *mvif)
+{
+	if (is_mt7915(dev))
+		return wcid && wcid->sta ? mvif->omac_idx : 0xe;
+
+	return wcid ? mvif->omac_idx : 0;
+}
+
 struct sk_buff *
+__mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
+				struct mt76_wcid *wcid, int len);
+static inline struct sk_buff *
 mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
-			      struct mt76_wcid *wcid);
+			      struct mt76_wcid *wcid)
+{
+	return __mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid,
+					       MT76_CONNAC_STA_UPDATE_MAX_SIZE);
+}
+
 struct wtbl_req_hdr *
 mt76_connac_mcu_alloc_wtbl_req(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			       int cmd, void *sta_wtbl, struct sk_buff **skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
index d98225da694c..b8b98cbc2054 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: ISC
 config MT7915E
 	tristate "MediaTek MT7915E (PCIe) support"
-	select MT76_CORE
+	select MT76_CONNAC_LIB
 	depends on MAC80211
 	depends on PCI
 	help
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0911b6f973b5..6ad6eaef3c87 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -82,9 +82,6 @@ struct mt7915_fw_region {
 #define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
 #define PATCH_SEC_TYPE_INFO		0x2
 
-#define to_wcid_lo(id)			FIELD_GET(GENMASK(7, 0), (u16)id)
-#define to_wcid_hi(id)			FIELD_GET(GENMASK(9, 8), (u16)id)
-
 #define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
 #define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
 
@@ -577,28 +574,6 @@ void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb)
 		mt76_mcu_rx_event(&dev->mt76, skb);
 }
 
-static struct sk_buff *
-mt7915_mcu_alloc_sta_req(struct mt7915_dev *dev, struct mt7915_vif *mvif,
-			 struct mt7915_sta *msta, int len)
-{
-	struct sta_req_hdr hdr = {
-		.bss_idx = mvif->mt76.idx,
-		.wlan_idx_lo = msta ? to_wcid_lo(msta->wcid.idx) : 0,
-		.wlan_idx_hi = msta ? to_wcid_hi(msta->wcid.idx) : 0,
-		.muar_idx = msta && msta->wcid.sta ? mvif->mt76.omac_idx : 0xe,
-		.is_tlv_append = 1,
-	};
-	struct sk_buff *skb;
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
-	if (!skb)
-		return ERR_PTR(-ENOMEM);
-
-	skb_put_data(skb, &hdr, sizeof(hdr));
-
-	return skb;
-}
-
 static struct wtbl_req_hdr *
 mt7915_mcu_alloc_wtbl_req(struct mt7915_dev *dev, struct mt7915_sta *msta,
 			  int cmd, void *sta_wtbl, struct sk_buff **skb)
@@ -1010,6 +985,7 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, int enable)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_dev *dev = phy->dev;
 	struct sk_buff *skb;
 
 	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START) {
@@ -1017,8 +993,8 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 		mt7915_mcu_muar_config(phy, vif, true, enable);
 	}
 
-	skb = mt7915_mcu_alloc_sta_req(phy->dev, mvif, NULL,
-				       MT7915_BSS_UPDATE_MAX_SIZE);
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76, NULL,
+					      MT7915_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1045,7 +1021,7 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 			mt7915_mcu_bss_ext_tlv(skb, mvif);
 	}
 out:
-	return mt76_mcu_skb_send_msg(&phy->dev->mt76, skb,
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
 }
 
@@ -1124,10 +1100,10 @@ int mt7915_mcu_add_key(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct sk_buff *skb;
-	int len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_sec);
 	int ret;
 
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1204,8 +1180,8 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 	if (enable && tx && !params->amsdu)
 		msta->wcid.amsdu = false;
 
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT76_CONNAC_STA_UPDATE_MAX_SIZE);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1223,8 +1199,8 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 	if (ret)
 		return ret;
 
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT76_CONNAC_STA_UPDATE_MAX_SIZE);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2050,9 +2026,9 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 	struct sta_rec_ra_fixed *ra;
 	struct sk_buff *skb;
 	struct tlv *tlv;
-	int len = sizeof(struct sta_req_hdr) + sizeof(*ra);
 
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2091,8 +2067,8 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT76_CONNAC_STA_UPDATE_MAX_SIZE);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2304,8 +2280,8 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT76_CONNAC_STA_UPDATE_MAX_SIZE);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2371,8 +2347,8 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
 
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT76_CONNAC_STA_UPDATE_MAX_SIZE);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					    &msta->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2602,7 +2578,8 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 	struct bss_info_bcn *bcn;
 	int len = MT7915_BEACON_UPDATE_SIZE + MAX_BEACON_SIZE;
 
-	rskb = mt7915_mcu_alloc_sta_req(dev, mvif, NULL, len);
+	rskb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					       NULL, len);
 	if (IS_ERR(rskb))
 		return PTR_ERR(rskb);
 
@@ -4210,7 +4187,8 @@ int mt7915_mcu_update_bss_color(struct mt7915_dev *dev, struct ieee80211_vif *vi
 	struct sk_buff *skb;
 	struct tlv *tlv;
 
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, NULL, len);
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					      NULL, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 42d887383e8d..79a1c1ddf157 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -444,11 +444,6 @@ int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level);
 void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb);
 void mt7915_mcu_exit(struct mt7915_dev *dev);
 
-static inline bool is_mt7915(struct mt76_dev *dev)
-{
-	return mt76_chip(dev) == 0x7915;
-}
-
 void mt7915_dual_hif_set_irq_mask(struct mt7915_dev *dev, bool write_reg,
 				  u32 clear, u32 set);
 
-- 
2.33.1

