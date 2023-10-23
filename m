Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F787D3B1C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 17:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjJWPmU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 11:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjJWPmN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 11:42:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09BD102
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 08:42:07 -0700 (PDT)
X-UUID: b47faf5071ba11eea33bb35ae8d461a2-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7QEua/dPamd3sR1FVDyP0QWhRHLn4KMfv/22iKbdorM=;
        b=jN7Yj64+v5z8PlRPaO0Q9lbdKPaCyfmE1o30t5NFjWC2j//tbU4vzf4NGvukw8eZbfW9Pf2rIssWoX9y5zmSgPcFMNwm2E1TK2heixpFXQspv1PbSNvUQFnOobmDlpNmlnZ/3TjtsxrQlf11+hrE7/dnc+vvKG9lsdxvJ9RTNEo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:f576fd0c-2197-4c43-a4c7-4c2bc03462e3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:03ac37d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b47faf5071ba11eea33bb35ae8d461a2-20231023
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 614383728; Mon, 23 Oct 2023 23:42:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 23:41:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 23:41:58 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 05/11] wifi: mt76: connac: add beacon duplicate TX mode support for mt7996
Date:   Mon, 23 Oct 2023 23:38:48 +0800
Message-ID: <20231023153854.10708-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231023153854.10708-1-shayne.chen@mediatek.com>
References: <20231023153854.10708-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.473800-8.000000
X-TMASE-MatchedRID: JwS4jUxTVmMbTIpM8PviapyBsp6+TmyGWjWsWQUWzVrEWeKnUo+CVv9T
        oIqmlx19NJnt9TW/xwZDxo0ZYj4mPdbms8wOrodv0Xw0ILvo/uXmTPEuA2FKKRL6MU7t349bgo4
        eB1LnWghGskkvZ95zFxIuFMMW4kD5YwDOL7t3RyHAjK1KJglnOri8G4TZfQeVv8D7QPW2jo9CZn
        37VQFgvVFRKKt82ciTys/FpHHmWmzQo7lIbG5ppNxajlW+zwxCKLXqnf812iOiXe5nNnUYtw1qT
        OnuhxNxnaaF/flUVDXW15rhxUaKFyZywmJvYiNpogGd8wIUGIJG/JUd7BvSQn3PDAw6e54HCKhu
        U3rY4TCsA7x2tQEwEzPa9WgTjca7PX+2+ZWGbdnd+fuf9kcapn0tCKdnhB589yM15V5aWpj6C0e
        Ps7A07RFNbIORqV3l
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.473800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D691063670E6D34DC7090E7355781DF71657B6AEE5FC6CE4E764F6FF218493C72000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

For connac3 chipsets, setting of spe_idx is moved from TX descriptor to
the fixed rate table. This patch implements the setting to support
duplicate TX mode for beacon.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  6 ++--
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 11 -------
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 18 ++++++------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 29 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 20 +++++++++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  8 +++--
 7 files changed, 68 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 1d8680b153a7..65844de6dccd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1242,6 +1242,7 @@ enum {
 	MCU_UNI_CMD_CHANNEL_SWITCH = 0x34,
 	MCU_UNI_CMD_THERMAL = 0x35,
 	MCU_UNI_CMD_VOW = 0x37,
+	MCU_UNI_CMD_FIXED_RATE_TABLE = 0x40,
 	MCU_UNI_CMD_RRO = 0x57,
 	MCU_UNI_CMD_OFFCH_SCAN_CTRL = 0x58,
 	MCU_UNI_CMD_PER_STA_INFO = 0x6d,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index e2d08bf96eb0..6a03cddaed04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -354,6 +354,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
 
 	phy->slottime = 9;
+	phy->beacon_rate = -1;
 
 	hw->sta_data_size = sizeof(struct mt7996_sta);
 	hw->vif_data_size = sizeof(struct mt7996_vif);
@@ -468,11 +469,12 @@ static void mt7996_mac_init_basic_rates(struct mt7996_dev *dev)
 
 	for (i = 0; i < ARRAY_SIZE(mt76_rates); i++) {
 		u16 rate = mt76_rates[i].hw_value;
-		u16 idx = MT7996_BASIC_RATES_TBL + i;
+		/* odd index for driver, even index for firmware */
+		u16 idx = MT7996_BASIC_RATES_TBL + 2 * i;
 
 		rate = FIELD_PREP(MT_TX_RATE_MODE, rate >> 8) |
 		       FIELD_PREP(MT_TX_RATE_IDX, rate & GENMASK(7, 0));
-		mt7996_mac_set_fixed_rate_table(dev, idx, rate);
+		mt7996_mcu_set_fixed_rate_table(&dev->phy, idx, rate, false);
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 10f079cf691d..18c7fef00fff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -248,17 +248,6 @@ void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
 		mt76_clear(dev, addr, BIT(5));
 }
 
-void mt7996_mac_set_fixed_rate_table(struct mt7996_dev *dev,
-				     u8 tbl_idx, u16 rate_idx)
-{
-	u32 ctrl = MT_WTBL_ITCR_WR | MT_WTBL_ITCR_EXEC | tbl_idx;
-
-	mt76_wr(dev, MT_WTBL_ITDR0, rate_idx);
-	/* use wtbl spe idx */
-	mt76_wr(dev, MT_WTBL_ITDR1, MT_WTBL_SPE_IDX_SEL);
-	mt76_wr(dev, MT_WTBL_ITCR, ctrl);
-}
-
 /* The HW does not translate the mac header to 802.3 for mesh point */
 static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 33a9d50d3366..9f12b47eb2bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -522,24 +522,25 @@ mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct mt76_phy *mphy = hw->priv;
 	u16 rate;
-	u8 i, idx, ht;
+	u8 i, idx;
 
 	rate = mt76_connac2_mac_tx_rate_val(mphy, vif, beacon, mcast);
-	ht = FIELD_GET(MT_TX_RATE_MODE, rate) > MT_PHY_TYPE_OFDM;
 
-	if (beacon && ht) {
-		struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	if (beacon) {
+		struct mt7996_phy *phy = mphy->priv;
+
+		/* odd index for driver, even index for firmware */
+		idx = MT7996_BEACON_RATES_TBL + 2 * phy->mt76->band_idx;
+		if (phy->beacon_rate != rate)
+			mt7996_mcu_set_fixed_rate_table(phy, idx, rate, beacon);
 
-		/* must odd index */
-		idx = MT7996_BEACON_RATES_TBL + 2 * (mvif->idx % 20);
-		mt7996_mac_set_fixed_rate_table(dev, idx, rate);
 		return idx;
 	}
 
 	idx = FIELD_GET(MT_TX_RATE_IDX, rate);
 	for (i = 0; i < ARRAY_SIZE(mt76_rates); i++)
 		if ((mt76_rates[i].hw_value & GENMASK(7, 0)) == idx)
-			return MT7996_BASIC_RATES_TBL + i;
+			return MT7996_BASIC_RATES_TBL + 2 * i;
 
 	return mvif->basic_rates_idx;
 }
@@ -965,7 +966,6 @@ mt7996_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	mt7996_set_stream_vht_txbf_caps(phy);
 	mt7996_set_stream_he_eht_caps(phy);
 
-	/* TODO: update bmc_wtbl spe_idx when antenna changes */
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 61c0d4ff9653..dad5be748d7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4179,6 +4179,35 @@ int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 }
 
+int mt7996_mcu_set_fixed_rate_table(struct mt7996_phy *phy, u8 table_idx,
+				    u16 rate_idx, bool beacon)
+{
+#define UNI_FIXED_RATE_TABLE_SET	0
+#define SPE_IXD_SELECT_TXD		0
+#define SPE_IXD_SELECT_BMC_WTBL		1
+	struct mt7996_dev *dev = phy->dev;
+	struct fixed_rate_table_ctrl req = {
+		.tag = cpu_to_le16(UNI_FIXED_RATE_TABLE_SET),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.table_idx = table_idx,
+		.rate_idx = cpu_to_le16(rate_idx),
+		.gi = 1,
+		.he_ltf = 1,
+	};
+	u8 band_idx = phy->mt76->band_idx;
+
+	if (beacon) {
+		req.spe_idx_sel = SPE_IXD_SELECT_TXD;
+		req.spe_idx = 24 + band_idx;
+		phy->beacon_rate = rate_idx;
+	} else {
+		req.spe_idx_sel = SPE_IXD_SELECT_BMC_WTBL;
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(FIXED_RATE_TABLE),
+				 &req, sizeof(req), false);
+}
+
 int mt7996_mcu_rf_regval(struct mt7996_dev *dev, u32 regidx, u32 *val, bool set)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 4a73850db9c0..a2700151ee1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -801,4 +801,24 @@ enum {
 #define MT7996_SEC_KEY_IDX		GENMASK(2, 1)
 #define MT7996_SEC_IV			BIT(3)
 
+struct fixed_rate_table_ctrl {
+	u8 _rsv[4];
+
+	__le16 tag;
+	__le16 len;
+
+	u8 table_idx;
+	u8 antenna_idx;
+	__le16 rate_idx;
+	u8 spe_idx_sel;
+	u8 spe_idx;
+	u8 gi;
+	u8 he_ltf;
+	bool ldpc;
+	bool txbf;
+	bool dynamic_bw;
+
+	u8 _rsv2;
+} __packed;
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 61e0f905d902..ed99432b2d03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -47,7 +47,7 @@
 #define MT7996_MAX_QUEUE		(__MT_RXQ_MAX +	__MT_MCUQ_MAX + 3)
 
 /* NOTE: used to map mt76_rates. idx may change if firmware expands table */
-#define MT7996_BASIC_RATES_TBL		11
+#define MT7996_BASIC_RATES_TBL		31
 #define MT7996_BEACON_RATES_TBL		25
 
 #define MT7996_THERMAL_THROTTLE_MAX	100
@@ -217,6 +217,8 @@ struct mt7996_phy {
 
 	u8 rdd_state;
 
+	u16 beacon_rate;
+
 	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
 
@@ -472,6 +474,8 @@ int mt7996_mcu_rdd_cmd(struct mt7996_dev *dev, int cmd, u8 index,
 		       u8 rx_sel, u8 val);
 int mt7996_mcu_rdd_background_enable(struct mt7996_phy *phy,
 				     struct cfg80211_chan_def *chandef);
+int mt7996_mcu_set_fixed_rate_table(struct mt7996_phy *phy, u8 table_idx,
+				    u16 rate_idx, bool beacon);
 int mt7996_mcu_rf_regval(struct mt7996_dev *dev, u32 regidx, u32 *val, bool set);
 int mt7996_mcu_set_hdr_trans(struct mt7996_dev *dev, bool hdr_trans);
 int mt7996_mcu_set_rro(struct mt7996_dev *dev, u16 tag, u16 val);
@@ -538,8 +542,6 @@ void mt7996_mac_cca_stats_reset(struct mt7996_phy *phy);
 void mt7996_mac_enable_nf(struct mt7996_dev *dev, u8 band);
 void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
 			      struct ieee80211_vif *vif, bool enable);
-void mt7996_mac_set_fixed_rate_table(struct mt7996_dev *dev,
-				     u8 tbl_idx, u16 rate_idx);
 void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, int pid,
-- 
2.39.2

