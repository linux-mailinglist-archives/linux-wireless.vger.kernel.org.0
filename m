Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B62633659
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 08:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiKVHxd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 02:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiKVHx1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 02:53:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7037B10DC
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 23:53:23 -0800 (PST)
X-UUID: 5caed2e719ed4af58bf62e2813a6dda1-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CaYTU3vUJMztyklQyX6cRVojSxbk3E03NjOjGTJOACw=;
        b=Y1Zs3VfLkDavuDTgiLBRUJJh0QCkpmP09HvsZbSFHBq6B9duR1YBIyLcqrIzkw2v4lPTUNfX6VyAr5hvHknSDl9vdyFe8S713fGGaPy60Kwx9WzUQ3uixSW29KsFxbEHKEzR2n8Y0xKO7p/qiLl2VJTf9vyLh/DzCwRIGNjwYko=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:9e8fc3b1-6e0f-432a-b8ea-41e96cd0b97e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:6af6e3db-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5caed2e719ed4af58bf62e2813a6dda1-20221122
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2836820; Tue, 22 Nov 2022 15:53:16 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 15:53:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 15:53:14 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 3/3] wifi: mt76: mt7915: fix band_idx usage
Date:   Tue, 22 Nov 2022 15:53:12 +0800
Message-ID: <86ff61f5c8d4417bb82b76f3a0fed53e9326163c.1669097067.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <b8a621999a1b5171e031c2a207965976fbc793f0.1669097067.git.ryder.lee@mediatek.com>
References: <b8a621999a1b5171e031c2a207965976fbc793f0.1669097067.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The commit 006b9d4ad5bf introduced phy->band_idx to accommodate the
band definition change for mt7986 so that the band_idx of main_phy
can be 0 or 1. Accordingly, the source of band_idx 1 has switched to
"phy != &dev->phy" or "dev->phy.band_idx = 1".

We still use ext_phy to represent band 1 somewhere in driver, so fix it.
Also, band_idx sounds more reasonable than dbdc_idx, so change it.

Fixes: 006b9d4ad5bf ("mt76: mt7915: introduce band_idx in mt7915_phy")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 10 ++---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 13 +++---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 36 ++++++++---------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 40 +++++++++----------
 .../wireless/mediatek/mt76/mt7915/testmode.c  | 18 ++++-----
 5 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index c322fcc19d67..fef0ec83185b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -51,7 +51,7 @@ mt7915_sys_recovery_set(struct file *file, const char __user *user_buf,
 {
 	struct mt7915_phy *phy = file->private_data;
 	struct mt7915_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
+	bool band = phy->band_idx;
 	char buf[16];
 	int ret = 0;
 	u16 val;
@@ -83,7 +83,7 @@ mt7915_sys_recovery_set(struct file *file, const char __user *user_buf,
 	 * 8: trigger firmware crash.
 	 */
 	case SER_QUERY:
-		ret = mt7915_mcu_set_ser(dev, 0, 0, ext_phy);
+		ret = mt7915_mcu_set_ser(dev, 0, 0, band);
 		break;
 	case SER_SET_RECOVER_L1:
 	case SER_SET_RECOVER_L2:
@@ -91,17 +91,17 @@ mt7915_sys_recovery_set(struct file *file, const char __user *user_buf,
 	case SER_SET_RECOVER_L3_TX_ABORT:
 	case SER_SET_RECOVER_L3_TX_DISABLE:
 	case SER_SET_RECOVER_L3_BF:
-		ret = mt7915_mcu_set_ser(dev, SER_ENABLE, BIT(val), ext_phy);
+		ret = mt7915_mcu_set_ser(dev, SER_ENABLE, BIT(val), band);
 		if (ret)
 			return ret;
 
-		ret = mt7915_mcu_set_ser(dev, SER_RECOVER, val, ext_phy);
+		ret = mt7915_mcu_set_ser(dev, SER_RECOVER, val, band);
 		break;
 
 	/* enable full chip reset */
 	case SER_SET_RECOVER_FULL:
 		mt76_set(dev, MT_WFDMA0_MCU_HOST_INT_ENA, MT_MCU_CMD_WDT_MASK);
-		ret = mt7915_mcu_set_ser(dev, 1, 3, ext_phy);
+		ret = mt7915_mcu_set_ser(dev, 1, 3, band);
 		if (ret)
 			return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 117ddb00348c..6cd8930a10f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1228,18 +1228,18 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
 }
 
-void mt7915_mac_enable_nf(struct mt7915_dev *dev, bool ext_phy)
+void mt7915_mac_enable_nf(struct mt7915_dev *dev, bool band)
 {
 	u32 reg;
 
-	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_RXTD12(ext_phy) :
-		MT_WF_PHY_RXTD12_MT7916(ext_phy);
+	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_RXTD12(band) :
+				      MT_WF_PHY_RXTD12_MT7916(band);
 	mt76_set(dev, reg,
 		 MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY |
 		 MT_WF_PHY_RXTD12_IRPI_SW_CLR);
 
-	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_RX_CTRL1(ext_phy) :
-		MT_WF_PHY_RX_CTRL1_MT7916(ext_phy);
+	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_RX_CTRL1(band) :
+				      MT_WF_PHY_RX_CTRL1_MT7916(band);
 	mt76_set(dev, reg, FIELD_PREP(MT_WF_PHY_RX_CTRL1_IPI_EN, 0x5));
 }
 
@@ -1948,7 +1948,6 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 static void mt7915_mac_severe_check(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
-	bool ext_phy = phy != &dev->phy;
 	u32 trb;
 
 	if (!phy->omac_mask)
@@ -1966,7 +1965,7 @@ static void mt7915_mac_severe_check(struct mt7915_phy *phy)
 	     FIELD_GET(MT_TRB_RXPSR0_RX_WTBL_PTR, phy->trb_ts)) &&
 	    trb == phy->trb_ts)
 		mt7915_mcu_set_ser(dev, SER_RECOVER, SER_SET_RECOVER_L3_RX_ABORT,
-				   ext_phy);
+				   phy->band_idx);
 
 	phy->trb_ts = trb;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index cf48fcc8f170..ca917291e3dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -30,31 +30,31 @@ int mt7915_run(struct ieee80211_hw *hw)
 	running = mt7915_dev_running(dev);
 
 	if (!running) {
-		ret = mt76_connac_mcu_set_pm(&dev->mt76, 0, 0);
+		ret = mt76_connac_mcu_set_pm(&dev->mt76, dev->phy.band_idx, 0);
 		if (ret)
 			goto out;
 
-		ret = mt7915_mcu_set_mac(dev, 0, true, true);
+		ret = mt7915_mcu_set_mac(dev, dev->phy.band_idx, true, true);
 		if (ret)
 			goto out;
 
-		mt7915_mac_enable_nf(dev, 0);
+		mt7915_mac_enable_nf(dev, dev->phy.band_idx);
 	}
 
-	if (phy != &dev->phy || phy->band_idx) {
-		ret = mt76_connac_mcu_set_pm(&dev->mt76, 1, 0);
+	if (phy != &dev->phy) {
+		ret = mt76_connac_mcu_set_pm(&dev->mt76, phy->band_idx, 0);
 		if (ret)
 			goto out;
 
-		ret = mt7915_mcu_set_mac(dev, 1, true, true);
+		ret = mt7915_mcu_set_mac(dev, phy->band_idx, true, true);
 		if (ret)
 			goto out;
 
-		mt7915_mac_enable_nf(dev, 1);
+		mt7915_mac_enable_nf(dev, phy->band_idx);
 	}
 
 	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b,
-					     phy != &dev->phy);
+					     phy->band_idx);
 	if (ret)
 		goto out;
 
@@ -107,13 +107,13 @@ static void mt7915_stop(struct ieee80211_hw *hw)
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
 	if (phy != &dev->phy) {
-		mt76_connac_mcu_set_pm(&dev->mt76, 1, 1);
-		mt7915_mcu_set_mac(dev, 1, false, false);
+		mt76_connac_mcu_set_pm(&dev->mt76, phy->band_idx, 1);
+		mt7915_mcu_set_mac(dev, phy->band_idx, false, false);
 	}
 
 	if (!mt7915_dev_running(dev)) {
-		mt76_connac_mcu_set_pm(&dev->mt76, 0, 1);
-		mt7915_mcu_set_mac(dev, 0, false, false);
+		mt76_connac_mcu_set_pm(&dev->mt76, dev->phy.band_idx, 1);
+		mt7915_mcu_set_mac(dev, dev->phy.band_idx, false, false);
 	}
 
 	mutex_unlock(&dev->mt76.mutex);
@@ -440,7 +440,6 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-	bool band = phy != &dev->phy;
 	int ret;
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
@@ -468,6 +467,7 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+		bool band = phy->band_idx;
 
 		if (!enabled)
 			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
@@ -506,7 +506,7 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-	bool band = phy != &dev->phy;
+	bool band = phy->band_idx;
 	u32 ctl_flags = MT_WF_RFCR1_DROP_ACK |
 			MT_WF_RFCR1_DROP_BF_POLL |
 			MT_WF_RFCR1_DROP_BA |
@@ -743,7 +743,7 @@ static int mt7915_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 	int ret;
 
 	mutex_lock(&dev->mt76.mutex);
-	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, phy != &dev->phy);
+	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, phy->band_idx);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
@@ -846,7 +846,7 @@ u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-	bool band = phy != &dev->phy;
+	bool band = phy->band_idx;
 	union {
 		u64 t64;
 		u32 t32[2];
@@ -891,7 +891,7 @@ mt7915_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-	bool band = phy != &dev->phy;
+	bool band = phy->band_idx;
 	union {
 		u64 t64;
 		u32 t32[2];
@@ -922,7 +922,7 @@ mt7915_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
-	bool band = phy != &dev->phy;
+	bool band = phy->band_idx;
 	union {
 		u64 t64;
 		u32 t32[2];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b04cfe4c4e6d..f329705c4fa1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -599,7 +599,7 @@ mt7915_mcu_muar_config(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		.mode = !!mask || enable,
 		.entry_count = 1,
 		.write = 1,
-		.band = phy != &dev->phy,
+		.band = phy->band_idx,
 		.index = idx * 2 + bssid,
 	};
 
@@ -1693,7 +1693,7 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 	struct {
 		struct req_hdr {
 			u8 omac_idx;
-			u8 dbdc_idx;
+			u8 band_idx;
 			__le16 tlv_num;
 			u8 is_tlv_append;
 			u8 rsv[3];
@@ -1702,13 +1702,13 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 			__le16 tag;
 			__le16 len;
 			u8 active;
-			u8 dbdc_idx;
+			u8 band_idx;
 			u8 omac_addr[ETH_ALEN];
 		} __packed tlv;
 	} data = {
 		.hdr = {
 			.omac_idx = mvif->mt76.omac_idx,
-			.dbdc_idx = mvif->mt76.band_idx,
+			.band_idx = mvif->mt76.band_idx,
 			.tlv_num = cpu_to_le16(1),
 			.is_tlv_append = 1,
 		},
@@ -1716,7 +1716,7 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
 			.len = cpu_to_le16(sizeof(struct req_tlv)),
 			.active = enable,
-			.dbdc_idx = mvif->mt76.band_idx,
+			.band_idx = mvif->mt76.band_idx,
 		},
 	};
 
@@ -2563,7 +2563,7 @@ mt7915_mcu_background_chain_ctrl(struct mt7915_phy *phy,
 		req.monitor_central_chan =
 			ieee80211_frequency_to_channel(chandef->center_freq1);
 		req.monitor_bw = mt76_connac_chan_bw(chandef);
-		req.band_idx = phy != &dev->phy;
+		req.band_idx = phy->band_idx;
 		req.scan_mode = 1;
 		break;
 	}
@@ -2571,7 +2571,7 @@ mt7915_mcu_background_chain_ctrl(struct mt7915_phy *phy,
 		req.monitor_chan = chandef->chan->hw_value;
 		req.monitor_central_chan =
 			ieee80211_frequency_to_channel(chandef->center_freq1);
-		req.band_idx = phy != &dev->phy;
+		req.band_idx = phy->band_idx;
 		req.scan_mode = 2;
 		break;
 	case CH_SWITCH_BACKGROUND_SCAN_STOP:
@@ -2975,7 +2975,7 @@ int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch)
 	}
 
 	for (i = 0; i < 5; i++) {
-		req[i].band = cpu_to_le32(phy != &dev->phy);
+		req[i].band = cpu_to_le32(phy->band_idx);
 		req[i].offs = cpu_to_le32(offs[i + start]);
 
 		if (!is_mt7915(&dev->mt76) && i == 3)
@@ -3020,11 +3020,11 @@ int mt7915_mcu_get_temperature(struct mt7915_phy *phy)
 	struct {
 		u8 ctrl_id;
 		u8 action;
-		u8 dbdc_idx;
+		u8 band_idx;
 		u8 rsv[5];
 	} req = {
 		.ctrl_id = THERMAL_SENSOR_TEMP_QUERY,
-		.dbdc_idx = phy != &dev->phy,
+		.band_idx = phy->band_idx,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_CTRL), &req,
@@ -3173,11 +3173,11 @@ int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 	struct mt7915_sku_val {
 		u8 format_id;
 		u8 limit_type;
-		u8 dbdc_idx;
+		u8 band_idx;
 		s8 val[MT7915_SKU_RATE_NUM];
 	} __packed req = {
 		.format_id = TX_POWER_LIMIT_TABLE,
-		.dbdc_idx = phy != &dev->phy,
+		.band_idx = phy->band_idx,
 	};
 	struct mt76_power_limits limits_array;
 	s8 *la = (s8 *)&limits_array;
@@ -3223,12 +3223,12 @@ int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len)
 	struct {
 		u8 format_id;
 		u8 category;
-		u8 band;
+		u8 band_idx;
 		u8 _rsv;
 	} __packed req = {
 		.format_id = TX_POWER_LIMIT_INFO,
 		.category = RATE_POWER_INFO,
-		.band = phy != &dev->phy,
+		.band_idx = phy->band_idx,
 	};
 	s8 txpower_sku[MT7915_SKU_RATE_NUM][2];
 	struct sk_buff *skb;
@@ -3277,11 +3277,11 @@ int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable)
 	struct mt7915_sku {
 		u8 format_id;
 		u8 sku_enable;
-		u8 dbdc_idx;
+		u8 band_idx;
 		u8 rsv;
 	} __packed req = {
 		.format_id = TX_POWER_LIMIT_ENABLE,
-		.dbdc_idx = phy != &dev->phy,
+		.band_idx = phy->band_idx,
 		.sku_enable = enable,
 	};
 
@@ -3363,7 +3363,7 @@ mt7915_mcu_enable_obss_spr(struct mt7915_phy *phy, u8 action, u8 val)
 	struct mt7915_mcu_sr_ctrl req = {
 		.action = action,
 		.argnum = 1,
-		.band_idx = phy != &dev->phy,
+		.band_idx = phy->band_idx,
 		.val = cpu_to_le32(val),
 	};
 
@@ -3394,7 +3394,7 @@ mt7915_mcu_set_obss_spr_pd(struct mt7915_phy *phy,
 		.ctrl = {
 			.action = SPR_SET_PARAM,
 			.argnum = 9,
-			.band_idx = phy != &dev->phy,
+			.band_idx = phy->band_idx,
 		},
 	};
 	int ret;
@@ -3443,7 +3443,7 @@ mt7915_mcu_set_obss_spr_siga(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		.ctrl = {
 			.action = SPR_SET_SIGA,
 			.argnum = 1,
-			.band_idx = phy != &dev->phy,
+			.band_idx = phy->band_idx,
 		},
 		.siga = {
 			.omac = omac > HW_BSSID_MAX ? omac - 12 : omac,
@@ -3482,7 +3482,7 @@ mt7915_mcu_set_obss_spr_bitmap(struct mt7915_phy *phy,
 		.ctrl = {
 			.action = SPR_SET_SRG_BITMAP,
 			.argnum = 4,
-			.band_idx = phy != &dev->phy,
+			.band_idx = phy->band_idx,
 		},
 	};
 	u32 bitmap;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index a979460fad2d..7ace05e0b63b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -44,14 +44,14 @@ mt7915_tm_set_tx_power(struct mt7915_phy *phy)
 	int ret;
 	struct {
 		u8 format_id;
-		u8 dbdc_idx;
+		u8 band_idx;
 		s8 tx_power;
 		u8 ant_idx;	/* Only 0 is valid */
 		u8 center_chan;
 		u8 rsv[3];
 	} __packed req = {
 		.format_id = 0xf,
-		.dbdc_idx = phy != &dev->phy,
+		.band_idx = phy->band_idx,
 		.center_chan = ieee80211_frequency_to_channel(freq),
 	};
 	u8 *tx_power = NULL;
@@ -77,7 +77,7 @@ mt7915_tm_set_freq_offset(struct mt7915_phy *phy, bool en, u32 val)
 	struct mt7915_tm_cmd req = {
 		.testmode_en = en,
 		.param_idx = MCU_ATE_SET_FREQ_OFFSET,
-		.param.freq.band = phy != &dev->phy,
+		.param.freq.band = phy->band_idx,
 		.param.freq.freq_offset = cpu_to_le32(val),
 	};
 
@@ -111,7 +111,7 @@ mt7915_tm_set_trx(struct mt7915_phy *phy, int type, bool en)
 		.param_idx = MCU_ATE_SET_TRX,
 		.param.trx.type = type,
 		.param.trx.enable = en,
-		.param.trx.band = phy != &dev->phy,
+		.param.trx.band = phy->band_idx,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL), &req,
@@ -126,7 +126,7 @@ mt7915_tm_clean_hwq(struct mt7915_phy *phy, u8 wcid)
 		.testmode_en = 1,
 		.param_idx = MCU_ATE_CLEAN_TXQUEUE,
 		.param.clean.wcid = wcid,
-		.param.clean.band = phy != &dev->phy,
+		.param.clean.band = phy->band_idx,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL), &req,
@@ -144,7 +144,7 @@ mt7915_tm_set_slot_time(struct mt7915_phy *phy, u8 slot_time, u8 sifs)
 		.param.slot.sifs = sifs,
 		.param.slot.rifs = 2,
 		.param.slot.eifs = cpu_to_le16(60),
-		.param.slot.band = phy != &dev->phy,
+		.param.slot.band = phy->band_idx,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL), &req,
@@ -488,7 +488,7 @@ mt7915_tm_set_rx_frames(struct mt7915_phy *phy, bool en)
 		mt7915_tm_update_channel(phy);
 
 		/* read-clear */
-		mt76_rr(dev, MT_MIB_SDR3(phy != &dev->phy));
+		mt76_rr(dev, MT_MIB_SDR3(phy->band_idx));
 		mt7915_tm_set_trx(phy, TM_MAC_RX_RXV, en);
 	}
 }
@@ -526,7 +526,7 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 	tx_cont->control_ch = chandef->chan->hw_value;
 	tx_cont->center_ch = freq1;
 	tx_cont->tx_ant = td->tx_antenna_mask;
-	tx_cont->band = phy != &dev->phy;
+	tx_cont->band = phy->band_idx;
 
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_40:
@@ -558,7 +558,7 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 	}
 
 	if (!en) {
-		req.op.rf.param.func_data = cpu_to_le32(phy != &dev->phy);
+		req.op.rf.param.func_data = cpu_to_le32(phy->band_idx);
 		goto out;
 	}
 
-- 
2.36.1

