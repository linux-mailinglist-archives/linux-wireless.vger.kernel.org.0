Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E4027A202
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 19:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgI0RS4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 13:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgI0RSz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 13:18:55 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78DCC0613D5
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/t3TpxYLC7Pm9tnq7dBQUzT/dzUHxWcVC6sdDxBMHmI=; b=FcEfRY4g40/YjC8ybImEqjIGoZ
        8C6nzV4zpbsCE5VxF/3tsI26Ih3b/NoR1ICzVL++/LFEr/BlnHy0Z5A3BG+ZS4zfxM7zNNa7kgXAZ
        eboq63/JTNu1cwb9xEj40ObMtrKtsrIyW7sFks8DMrmZvXsHXh9XdA+m/WNVd+ZuGtGA=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kMaK6-0002oU-Cr
        for linux-wireless@vger.kernel.org; Sun, 27 Sep 2020 19:18:54 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/8] mt76: mt7915: support 32 station interfaces
Date:   Sun, 27 Sep 2020 19:18:50 +0200
Message-Id: <20200927171852.48669-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200927171852.48669-1-nbd@nbd.name>
References: <20200927171852.48669-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When looking for a MAC address slot, start by using main BSSID slots 1-3,
afterwards use 16 repeater mode BSSID slots, then start using the slots
usually used for AP mode.
This search order should prevent unnecessary conflicts with AP mode interfaces
on the same PHY

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 10 ++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 56 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 53 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 27 +++------
 5 files changed, 105 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ee3cf612ae12..5884c0ce45e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -195,12 +195,14 @@ static const struct ieee80211_iface_limit if_limits[] = {
 		.max = 1,
 		.types = BIT(NL80211_IFTYPE_ADHOC)
 	}, {
-		.max = MT7915_MAX_INTERFACES,
+		.max = 16,
 		.types = BIT(NL80211_IFTYPE_AP) |
 #ifdef CONFIG_MAC80211_MESH
-			 BIT(NL80211_IFTYPE_MESH_POINT) |
+			 BIT(NL80211_IFTYPE_MESH_POINT)
 #endif
-			 BIT(NL80211_IFTYPE_STATION)
+	}, {
+		.max = MT7915_MAX_INTERFACES,
+		.types = BIT(NL80211_IFTYPE_STATION)
 	}
 };
 
@@ -208,7 +210,7 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	{
 		.limits = if_limits,
 		.n_limits = ARRAY_SIZE(if_limits),
-		.max_interfaces = 4,
+		.max_interfaces = MT7915_MAX_INTERFACES,
 		.num_different_channels = 1,
 		.beacon_int_infra_match = true,
 		.radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 58c2cd80140c..5d4bffbe07f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -84,28 +84,51 @@ static void mt7915_stop(struct ieee80211_hw *hw)
 	mutex_unlock(&dev->mt76.mutex);
 }
 
-static int get_omac_idx(enum nl80211_iftype type, u32 mask)
+static inline int get_free_idx(u32 mask, u8 start, u8 end)
+{
+	return ffs(~mask & GENMASK(end, start));
+}
+
+static int get_omac_idx(enum nl80211_iftype type, u64 mask)
 {
 	int i;
 
 	switch (type) {
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_STATION:
+		/* prefer hw bssid slot 1-3 */
+		i = get_free_idx(mask, HW_BSSID_1, HW_BSSID_3);
+		if (i)
+			return i - 1;
+
+		if (type != NL80211_IFTYPE_STATION)
+			break;
+
+		/* next, try to find a free repeater entry for the sta */
+		i = get_free_idx(mask >> REPEATER_BSSID_START, 0,
+				 REPEATER_BSSID_MAX - REPEATER_BSSID_START);
+		if (i)
+			return i + 32 - 1;
+
+		i = get_free_idx(mask, EXT_BSSID_1, EXT_BSSID_MAX);
+		if (i)
+			return i - 1;
+
+		if (~mask & BIT(HW_BSSID_0))
+			return HW_BSSID_0;
+
+		break;
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP:
 		/* ap uses hw bssid 0 and ext bssid */
 		if (~mask & BIT(HW_BSSID_0))
 			return HW_BSSID_0;
 
-		for (i = EXT_BSSID_1; i < EXT_BSSID_END; i++)
-			if (~mask & BIT(i))
-				return i;
-		break;
-	case NL80211_IFTYPE_MESH_POINT:
-	case NL80211_IFTYPE_ADHOC:
-	case NL80211_IFTYPE_STATION:
-		/* station uses hw bssid other than 0 */
-		for (i = HW_BSSID_1; i < HW_BSSID_MAX; i++)
-			if (~mask & BIT(i))
-				return i;
+		i = get_free_idx(mask, EXT_BSSID_1, EXT_BSSID_MAX);
+		if (i)
+			return i - 1;
+
 		break;
 	default:
 		WARN_ON(1);
@@ -148,12 +171,12 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	else
 		mvif->wmm_idx = mvif->idx % MT7915_MAX_WMM_SETS;
 
-	ret = mt7915_mcu_add_dev_info(dev, vif, true);
+	ret = mt7915_mcu_add_dev_info(phy, vif, true);
 	if (ret)
 		goto out;
 
 	phy->mt76->vif_mask |= BIT(mvif->idx);
-	phy->omac_mask |= BIT(mvif->omac_idx);
+	phy->omac_mask |= BIT_ULL(mvif->omac_idx);
 
 	idx = MT7915_WTBL_RESERVED - mvif->idx;
 
@@ -173,6 +196,9 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 		mtxq->wcid = &mvif->sta.wcid;
 	}
 
+	if (vif->type != NL80211_IFTYPE_AP &&
+	    (!mvif->omac_idx || mvif->omac_idx > 3))
+		vif->offload_flags = 0;
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
 out:
@@ -192,7 +218,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 
 	/* TODO: disable beacon for the bss */
 
-	mt7915_mcu_add_dev_info(dev, vif, false);
+	mt7915_mcu_add_dev_info(phy, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ffb774fc699f..ca198c4f5510 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1022,12 +1022,53 @@ mt7915_mcu_bss_sync_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 	sync->enable = true;
 }
 
+static int
+mt7915_mcu_muar_config(struct mt7915_phy *phy, struct ieee80211_vif *vif,
+		       bool bssid, bool enable)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	u32 idx = mvif->omac_idx - REPEATER_BSSID_START;
+	u32 mask = phy->omac_mask >> 32 & ~BIT(idx);
+	const u8 *addr = vif->addr;
+	struct {
+		u8 mode;
+		u8 force_clear;
+		u8 clear_bitmap[8];
+		u8 entry_count;
+		u8 write;
+		u8 band;
+
+		u8 index;
+		u8 bssid;
+		u8 addr[ETH_ALEN];
+	} __packed req = {
+		.mode = !!mask || enable,
+		.entry_count = 1,
+		.write = 1,
+
+		.index = idx * 2 + bssid,
+	};
+
+	if (bssid)
+		addr = vif->bss_conf.bssid;
+
+	if (enable)
+		ether_addr_copy(req.addr, addr);
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MUAR_UPDATE,
+				   &req, sizeof(req), true);
+}
+
 int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, int enable)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct sk_buff *skb;
 
+	if (mvif->omac_idx >= REPEATER_BSSID_START)
+		mt7915_mcu_muar_config(phy, vif, true, enable);
+
 	skb = mt7915_mcu_alloc_sta_req(phy->dev, mvif, NULL,
 				       MT7915_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
@@ -1048,10 +1089,10 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 		if (vif->bss_conf.he_support)
 			mt7915_mcu_bss_he_tlv(skb, vif, phy);
 
-		if (mvif->omac_idx > HW_BSSID_MAX)
-			mt7915_mcu_bss_ext_tlv(skb, mvif);
-		else
+		if (mvif->omac_idx < EXT_BSSID_START)
 			mt7915_mcu_bss_sync_tlv(skb, vif);
+		else if (mvif->omac_idx < REPEATER_BSSID_START)
+			mt7915_mcu_bss_ext_tlv(skb, mvif);
 	}
 
 	return __mt76_mcu_skb_send_msg(&phy->dev->mt76, skb,
@@ -2381,9 +2422,10 @@ int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
 				       MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
-int mt7915_mcu_add_dev_info(struct mt7915_dev *dev,
+int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, bool enable)
 {
+	struct mt7915_dev *dev = phy->dev;
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct {
 		struct req_hdr {
@@ -2415,6 +2457,9 @@ int mt7915_mcu_add_dev_info(struct mt7915_dev *dev,
 		},
 	};
 
+	if (mvif->omac_idx >= REPEATER_BSSID_START)
+		return mt7915_mcu_muar_config(phy, vif, false, enable);
+
 	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DEV_INFO_UPDATE,
 				   &data, sizeof(data), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 109647eea01d..49ff60509a72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -207,6 +207,7 @@ enum {
 	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
 	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
 	MCU_EXT_CMD_RX_HDR_TRANS = 0x47,
+	MCU_EXT_CMD_MUAR_UPDATE = 0x48,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
 	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
 	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 0ed439ecf787..292075d3f0da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -9,7 +9,7 @@
 #include "../mt76.h"
 #include "regs.h"
 
-#define MT7915_MAX_INTERFACES		4
+#define MT7915_MAX_INTERFACES		32
 #define MT7915_MAX_WMM_SETS		4
 #define MT7915_WTBL_SIZE		288
 #define MT7915_WTBL_RESERVED		(MT7915_WTBL_SIZE - 1)
@@ -113,7 +113,7 @@ struct mt7915_phy {
 	struct ieee80211_sband_iftype_data iftype[2][NUM_NL80211_IFTYPES];
 
 	u32 rxfilter;
-	u32 omac_mask;
+	u64 omac_mask;
 
 	u16 noise;
 	u16 chainmask;
@@ -171,24 +171,13 @@ enum {
 	HW_BSSID_1,
 	HW_BSSID_2,
 	HW_BSSID_3,
-	HW_BSSID_MAX,
+	HW_BSSID_MAX = HW_BSSID_3,
 	EXT_BSSID_START = 0x10,
 	EXT_BSSID_1,
-	EXT_BSSID_2,
-	EXT_BSSID_3,
-	EXT_BSSID_4,
-	EXT_BSSID_5,
-	EXT_BSSID_6,
-	EXT_BSSID_7,
-	EXT_BSSID_8,
-	EXT_BSSID_9,
-	EXT_BSSID_10,
-	EXT_BSSID_11,
-	EXT_BSSID_12,
-	EXT_BSSID_13,
-	EXT_BSSID_14,
-	EXT_BSSID_15,
-	EXT_BSSID_END
+	EXT_BSSID_15 = 0x1f,
+	EXT_BSSID_MAX = EXT_BSSID_15,
+	REPEATER_BSSID_START = 0x20,
+	REPEATER_BSSID_MAX = 0x3f,
 };
 
 enum {
@@ -281,7 +270,7 @@ int mt7915_dma_init(struct mt7915_dev *dev);
 void mt7915_dma_prefetch(struct mt7915_dev *dev);
 void mt7915_dma_cleanup(struct mt7915_dev *dev);
 int mt7915_mcu_init(struct mt7915_dev *dev);
-int mt7915_mcu_add_dev_info(struct mt7915_dev *dev,
+int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, bool enable);
 int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, int enable);
-- 
2.28.0

