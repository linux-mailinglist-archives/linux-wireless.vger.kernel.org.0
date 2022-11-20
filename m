Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC91631612
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 20:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKTTvt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 14:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiKTTvp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 14:51:45 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3602ED6B
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 11:51:41 -0800 (PST)
X-UUID: 6b0656e0ddc541219d80e1c16b4dde8e-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cCsvhMlRCo5Zn+apXuigqanoLR/g4df91IjKUp2nQOc=;
        b=GHsq7Nr5Ibo8+J8/v2gl2l33w5r5hYbMwOYd59X1INxHWQ9B3/74HpVraYLjNjfHRwnQqD3DJmWtqT3e+w2ufqoUP4tbG0cbkzNciF8AMBW8/uDeQg85HoWr1J9RsDqdQhUt9hnn5vrlM34RnOHDJvfZVvVWqQp8tKBNvo0mOLs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:bcbe1d4c-d2e4-4478-a9e9-cdd4820147fd,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.12,REQID:bcbe1d4c-d2e4-4478-a9e9-cdd4820147fd,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:62cd327,CLOUDID:a8ceb4db-6ad4-42ff-91f3-18e0272db660,B
        ulkID:221121035133906CTHHS,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6b0656e0ddc541219d80e1c16b4dde8e-20221121
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 919635166; Mon, 21 Nov 2022 03:51:33 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 21 Nov 2022 03:51:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 03:51:31 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/3] wifi: mt76: mt7915: enable .sta_set_txpwr support
Date:   Mon, 21 Nov 2022 03:51:29 +0800
Message-ID: <c843e72587751adf0438f6e85de9e9c5b8323bf4.1668973479.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <c73db8d9bb03efe8cb403434aeedad25d958e258.1668973479.git.ryder.lee@mediatek.com>
References: <c73db8d9bb03efe8cb403434aeedad25d958e258.1668973479.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This adds support for adjusting the Txpower level while pushing
traffic to an associated station. The allowed range is from 0 to
the maximum power of channel.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  3 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 33 +++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 92 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  8 ++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +
 5 files changed, 134 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index b48c2ba9273d..79bd7bf93f33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -355,6 +355,9 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_DISCOVERY);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
 
+	if (!is_mt7915(&dev->mt76))
+		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
+
 	if (!mdev->dev->of_node ||
 	    !of_property_read_bool(mdev->dev->of_node,
 				   "mediatek,disable-radar-background"))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index a29cbdb47801..9792831090c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1126,6 +1126,38 @@ static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
 	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
+static int mt7915_sta_set_txpwr(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta)
+{
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	s16 txpower = sta->deflink.txpwr.power;
+	int ret;
+
+	if (sta->deflink.txpwr.type == NL80211_TX_POWER_AUTOMATIC)
+		txpower = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	/* NOTE: temporarily use 0 as minimum limit, which is a
+	 * global setting and will be applied to all stations.
+	 */
+	ret = mt7915_mcu_set_txpower_frame_min(phy, 0);
+	if (ret)
+		return ret;
+
+	/* This only applies to data frames while pushing traffic,
+	 * whereas the management frames or other packets that are
+	 * using fixed rate can be configured via TxD.
+	 */
+	ret = mt7915_mcu_set_txpower_frame(phy, vif, sta, txpower);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
 static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"tx_ampdu_cnt",
 	"tx_stop_q_empty_cnt",
@@ -1491,6 +1523,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.set_bitrate_mask = mt7915_set_bitrate_mask,
 	.set_coverage_class = mt7915_set_coverage_class,
 	.sta_statistics = mt7915_sta_statistics,
+	.sta_set_txpwr = mt7915_sta_set_txpwr,
 	.sta_set_4addr = mt7915_sta_set_4addr,
 	.sta_set_decap_offload = mt7915_sta_set_decap_offload,
 	.add_twt_setup = mt7915_mac_add_twt_setup,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 3a0d97dad96f..d911512f31a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3083,6 +3083,86 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 				 &req, sizeof(req), false);
 }
 
+int mt7915_mcu_set_txpower_frame_min(struct mt7915_phy *phy, s8 txpower)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct {
+		u8 format_id;
+		u8 rsv;
+		u8 band_idx;
+		s8 txpower_min;
+	} __packed req = {
+		.format_id = TX_POWER_LIMIT_FRAME_MIN,
+		.band_idx = phy != &dev->phy,
+		.txpower_min = txpower * 2, /* 0.5db */
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76,
+				 MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), &req,
+				 sizeof(req), true);
+}
+
+int mt7915_mcu_set_txpower_frame(struct mt7915_phy *phy,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta, s8 txpower)
+{
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt7915_dev *dev = phy->dev;
+	struct {
+		u8 format_id;
+		u8 rsv[3];
+		u8 band_idx;
+		s8 txpower_max;
+		__le16 wcid;
+		s8 txpower_offs[48];
+	} __packed req = {
+		.format_id = TX_POWER_LIMIT_FRAME,
+		.band_idx = phy != &dev->phy,
+		.txpower_max = DIV_ROUND_UP(phy->mt76->txpower_cur, 2),
+		.wcid = cpu_to_le16(msta->wcid.idx),
+	};
+	int ret;
+	s8 txpower_sku[MT7915_SKU_RATE_NUM];
+
+	ret = mt7915_mcu_get_txpower_sku(phy, txpower_sku, sizeof(txpower_sku));
+	if (ret)
+		return ret;
+
+	if (txpower > req.txpower_max || txpower < 0)
+		return -EINVAL;
+
+	if (txpower) {
+		u32 offs, len, i;
+
+		if (sta->deflink.ht_cap.ht_supported) {
+			const u8 *sku_len = mt7915_sku_group_len;
+
+			offs = sku_len[SKU_CCK] + sku_len[SKU_OFDM];
+			len = sku_len[SKU_HT_BW20] + sku_len[SKU_HT_BW40];
+
+			if (sta->deflink.vht_cap.vht_supported) {
+				offs += len;
+				len = sku_len[SKU_VHT_BW20] * 4;
+
+				if (sta->deflink.he_cap.has_he) {
+					offs += len + sku_len[SKU_HE_RU26] * 3;
+					len = sku_len[SKU_HE_RU242] * 4;
+				}
+			}
+		} else {
+			return -EINVAL;
+		}
+
+		for (i = 0; i < len; i++, offs++)
+			req.txpower_offs[i] =
+				txpower - DIV_ROUND_UP(txpower_sku[offs], 2);
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76,
+				 MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), &req,
+				 sizeof(req), true);
+}
+
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
@@ -3094,7 +3174,7 @@ int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 		u8 dbdc_idx;
 		s8 val[MT7915_SKU_RATE_NUM];
 	} __packed req = {
-		.format_id = 4,
+		.format_id = TX_POWER_LIMIT_TABLE,
 		.dbdc_idx = phy != &dev->phy,
 	};
 	struct mt76_power_limits limits_array;
@@ -3144,11 +3224,11 @@ int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len)
 		u8 band;
 		u8 _rsv;
 	} __packed req = {
-		.format_id = 7,
+		.format_id = TX_POWER_LIMIT_INFO,
 		.category = RATE_POWER_INFO,
 		.band = phy != &dev->phy,
 	};
-	s8 res[MT7915_SKU_RATE_NUM][2];
+	s8 txpower_sku[MT7915_SKU_RATE_NUM][2];
 	struct sk_buff *skb;
 	int ret, i;
 
@@ -3158,9 +3238,9 @@ int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len)
 	if (ret)
 		return ret;
 
-	memcpy(res, skb->data + 4, sizeof(res));
+	memcpy(txpower_sku, skb->data + 4, sizeof(txpower_sku));
 	for (i = 0; i < len; i++)
-		txpower[i] = res[i][req.band];
+		txpower[i] = txpower_sku[i][req.band_idx];
 
 	dev_kfree_skb(skb);
 
@@ -3198,7 +3278,7 @@ int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable)
 		u8 dbdc_idx;
 		u8 rsv;
 	} __packed req = {
-		.format_id = 0,
+		.format_id = TX_POWER_LIMIT_ENABLE,
 		.dbdc_idx = phy != &dev->phy,
 		.sku_enable = enable,
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 2fc09fd53777..46c517e50ae4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -419,6 +419,14 @@ enum {
 #define RATE_CFG_PHY_TYPE		GENMASK(27, 24)
 #define RATE_CFG_HE_LTF			GENMASK(31, 28)
 
+enum {
+	TX_POWER_LIMIT_ENABLE,
+	TX_POWER_LIMIT_TABLE = 0x4,
+	TX_POWER_LIMIT_INFO = 0x7,
+	TX_POWER_LIMIT_FRAME = 0x11,
+	TX_POWER_LIMIT_FRAME_MIN = 0x12,
+};
+
 enum {
 	SPR_ENABLE = 0x1,
 	SPR_ENABLE_SD = 0x3,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 0bad78cf32c7..015c7190d79f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -526,6 +526,10 @@ int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band);
 int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable);
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy);
 int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len);
+int mt7915_mcu_set_txpower_frame_min(struct mt7915_phy *phy, s8 txpower);
+int mt7915_mcu_set_txpower_frame(struct mt7915_phy *phy,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta, s8 txpower);
 int mt7915_mcu_set_txbf(struct mt7915_dev *dev, u8 action);
 int mt7915_mcu_set_fcc5_lpn(struct mt7915_dev *dev, int val);
 int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
-- 
2.36.1

