Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8F26E15CA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 22:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjDMUXy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 16:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDMUXu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 16:23:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E780D900F
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 13:23:44 -0700 (PDT)
X-UUID: 129fb00eda3911edb6b9f13eb10bd0fe-20230414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SDVtzz9IyAbFQmtl/vtDofuY7XjGc3wxzEFog7brU3o=;
        b=s/atSR9WpU5wGBurolZiiKtgeBjgO+H9WVW9BONG9zmsgOGWnk+NnmFteqqjHPdqCCp3b7ZRviisps0diWmDJhAVt+0KJMf0it66yPGfrpbdyjUBw3WKtTqUbemBYZHFsl4L9K8CZfI1qaZl/Dexk7D4vBD8f8UWMQCvJgsPzqc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:64850fc1-aac6-4412-bf24-218976e577d2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:f08dfb83-cd9c-45f5-8134-710979e3df0e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 129fb00eda3911edb6b9f13eb10bd0fe-20230414
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 340114732; Fri, 14 Apr 2023 04:23:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 14 Apr 2023 04:23:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 14 Apr 2023 04:23:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/5] wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support
Date:   Fri, 14 Apr 2023 04:23:31 +0800
Message-ID: <6d8377411404f3be85c1e61a2c1c7a4e5199652b.1681416097.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <f5d216bcd79cc444b7f7039dd3898e08aff70286.1681416097.git.ryder.lee@mediatek.com>
References: <f5d216bcd79cc444b7f7039dd3898e08aff70286.1681416097.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The connac3 removes fixed rate fields to reduce txd size and introduces
global rate tables (64 entries) for rate setting. Driver needs to fill
the corresponding idx in MT_TXD6_TX_RATE while tx, and push mt76_rate
into predifined table at bootup stage so that  mvif->basic_rates_idx
can immediately switch out once setting changes.

spe_idx is also needed for fixed rate frames, and will be updated by
future patches.

Note that all table entries are shared across driver and firmware
(i.e.TxBF), hence adding MT7996_BASIC_RATES_TBL to reflect mapping
status.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 16 ++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 29 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7996/mac.h   |  7 ++---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 29 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 20 ++++++-------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  7 +++++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  7 +++++
 7 files changed, 85 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 503a7ff24f95..fc78849d14b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -250,6 +250,20 @@ mt7996_mac_init_band(struct mt7996_dev *dev, u8 band)
 	mt76_rmw(dev, MT_WTBLOFF_RSCR(band), mask, set);
 }
 
+static void mt7996_mac_init_basic_rates(struct mt7996_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mt76_rates); i++) {
+		u16 rate = mt76_rates[i].hw_value;
+		u16 idx = MT7996_BASIC_RATES_TBL + i;
+
+		rate = FIELD_PREP(MT_TX_RATE_MODE, rate >> 8) |
+		       FIELD_PREP(MT_TX_RATE_IDX, rate & GENMASK(7, 0));
+		mt7996_mac_set_fixed_rate_table(dev, idx, rate);
+	}
+}
+
 void mt7996_mac_init(struct mt7996_dev *dev)
 {
 #define HIF_TXD_V2_1	4
@@ -282,6 +296,8 @@ void mt7996_mac_init(struct mt7996_dev *dev)
 
 	for (i = MT_BAND0; i <= MT_BAND2; i++)
 		mt7996_mac_init_band(dev, i);
+
+	mt7996_mac_init_basic_rates(dev);
 }
 
 int mt7996_txbf_init(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 52244b95831c..048a4ebe2069 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -256,6 +256,17 @@ void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
 		mt76_clear(dev, addr, BIT(5));
 }
 
+void mt7996_mac_set_fixed_rate_table(struct mt7996_dev *dev,
+				     u8 tbl_idx, u16 rate_idx)
+{
+	u32 ctrl = MT_WTBL_ITCR_WR | MT_WTBL_ITCR_EXEC | tbl_idx;
+
+	mt76_wr(dev, MT_WTBL_ITDR0, rate_idx);
+	/* use wtbl spe idx */
+	mt76_wr(dev, MT_WTBL_ITDR1, MT_WTBL_SPE_IDX_SEL);
+	mt76_wr(dev, MT_WTBL_ITCR, ctrl);
+}
+
 static void
 mt7996_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
 				 struct ieee80211_radiotap_he *he,
@@ -987,6 +998,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt76_phy *mphy = &dev->mphy;
 	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
 	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
@@ -999,8 +1011,6 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 					 BSS_CHANGED_FILS_DISCOVERY));
 
 	if (vif) {
-		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-
 		omac_idx = mvif->mt76.omac_idx;
 		wmm_idx = mvif->mt76.wmm_idx;
 		band_idx = mvif->mt76.band_idx;
@@ -1065,18 +1075,9 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		mt7996_mac_write_txwi_80211(dev, txwi, skb, key);
 
 	if (txwi[1] & cpu_to_le32(MT_TXD1_FIXED_RATE)) {
-		/* Fixed rata is available just for 802.11 txd */
-		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-		bool multicast = is_multicast_ether_addr(hdr->addr1);
-		u16 rate = mt76_connac2_mac_tx_rate_val(mphy, vif, beacon,
-							multicast);
-
-		/* fix to bw 20 */
-		val = MT_TXD6_FIXED_BW |
-		      FIELD_PREP(MT_TXD6_BW, 0) |
-		      FIELD_PREP(MT_TXD6_TX_RATE, rate);
-
-		txwi[6] |= cpu_to_le32(val);
+		u8 idx = mvif->basic_rates_idx;
+
+		txwi[6] |= FIELD_PREP(MT_TXD6_TX_RATE, idx);
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
index 2cc218f735d8..56b11743d7ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -236,14 +236,11 @@ enum tx_mgnt_type {
 
 #define MT_TXD6_TX_SRC			GENMASK(31, 30)
 #define MT_TXD6_VTA			BIT(28)
-#define MT_TXD6_FIXED_BW		BIT(25)
-#define MT_TXD6_BW			GENMASK(24, 22)
+#define MT_TXD6_BW			GENMASK(25, 22)
 #define MT_TXD6_TX_RATE			GENMASK(21, 16)
 #define MT_TXD6_TIMESTAMP_OFS_EN	BIT(15)
 #define MT_TXD6_TIMESTAMP_OFS_IDX	GENMASK(14, 10)
 #define MT_TXD6_MSDU_CNT		GENMASK(9, 4)
-#define MT_TXD6_SPE_ID_IDX		BIT(10)
-#define MT_TXD6_ANT_ID			GENMASK(7, 4)
 #define MT_TXD6_DIS_MAT			BIT(3)
 #define MT_TXD6_DAS			BIT(2)
 #define MT_TXD6_AMSDU_CAP		BIT(1)
@@ -257,7 +254,7 @@ enum tx_mgnt_type {
 #define MT_TXD7_UDP_TCP_SUM		BIT(15)
 #define MT_TXD7_TX_TIME			GENMASK(9, 0)
 
-#define MT_TX_RATE_STBC			BIT(13)
+#define MT_TX_RATE_STBC			BIT(14)
 #define MT_TX_RATE_NSS			GENMASK(13, 10)
 #define MT_TX_RATE_MODE			GENMASK(9, 6)
 #define MT_TX_RATE_SU_EXT_TONE		BIT(5)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 67d02d30456e..e707d0a1aff5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -5,6 +5,7 @@
 
 #include "mt7996.h"
 #include "mcu.h"
+#include "mac.h"
 
 static bool mt7996_dev_running(struct mt7996_dev *dev)
 {
@@ -227,6 +228,11 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 		vif->offload_flags = 0;
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
+	if (phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
+		mvif->basic_rates_idx = MT7996_BASIC_RATES_TBL + 4;
+	else
+		mvif->basic_rates_idx = MT7996_BASIC_RATES_TBL;
+
 	mt7996_init_bitrate_mask(vif);
 	memset(&mvif->cap, -1, sizeof(mvif->cap));
 
@@ -505,11 +511,30 @@ mt7996_update_bss_color(struct ieee80211_hw *hw,
 	}
 }
 
+static u8
+mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt76_phy *mphy = hw->priv;
+	u16 rate;
+	u8 i, idx;
+
+	rate = mt76_connac2_mac_tx_rate_val(mphy, vif, false, false);
+
+	idx = FIELD_GET(MT_TX_RATE_IDX, rate);
+	for (i = 0; i < ARRAY_SIZE(mt76_rates); i++)
+		if ((mt76_rates[i].hw_value & GENMASK(7, 0)) == idx)
+			return MT7996_BASIC_RATES_TBL + i;
+
+	return mvif->basic_rates_idx;
+}
+
 static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    struct ieee80211_bss_conf *info,
 				    u64 changed)
 {
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 
@@ -541,6 +566,9 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (changed & BSS_CHANGED_BASIC_RATES)
+		mvif->basic_rates_idx = mt7996_get_rates_table(hw, vif);
+
 	if (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon) {
 		mt7996_mcu_add_bss_info(phy, vif, true);
 		mt7996_mcu_add_sta(dev, vif, NULL, true);
@@ -900,6 +928,7 @@ mt7996_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	mt7996_set_stream_vht_txbf_caps(phy);
 	mt7996_set_stream_he_eht_caps(phy);
 
+	/* TODO: update bmc_wtbl spe_idx when antenna changes */
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 1d44347a5fa7..95d443f427ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -596,25 +596,23 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 }
 
 static void
-mt7996_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt7996_phy *phy)
+mt7996_mcu_bss_bmc_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+		       struct mt7996_phy *phy)
 {
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct bss_rate_tlv *bmc;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct tlv *tlv;
+	u8 idx = mvif->basic_rates_idx;
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_RATE, sizeof(*bmc));
 
 	bmc = (struct bss_rate_tlv *)tlv;
-	if (band == NL80211_BAND_2GHZ) {
-		bmc->short_preamble = true;
-	} else {
-		bmc->bc_trans = cpu_to_le16(0x8080);
-		bmc->mc_trans = cpu_to_le16(0x8080);
-		bmc->bc_fixed_rate = 1;
-		bmc->mc_fixed_rate = 1;
-		bmc->short_preamble = 1;
-	}
+
+	bmc->short_preamble = (band == NL80211_BAND_2GHZ);
+	bmc->bc_fixed_rate = idx;
+	bmc->mc_fixed_rate = idx;
 }
 
 static void
@@ -822,7 +820,7 @@ int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
 
 	if (enable) {
 		mt7996_mcu_bss_rfch_tlv(skb, vif, phy);
-		mt7996_mcu_bss_bmc_tlv(skb, phy);
+		mt7996_mcu_bss_bmc_tlv(skb, vif, phy);
 		mt7996_mcu_bss_ra_tlv(skb, vif, phy);
 		mt7996_mcu_bss_txcmd_tlv(skb, true);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 412cee079f8a..4fe17b125b00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -43,6 +43,9 @@
 #define MT7996_MAX_STA_TWT_AGRT		8
 #define MT7996_MAX_QUEUE		(__MT_RXQ_MAX +	__MT_MCUQ_MAX + 3)
 
+/* NOTE: used to map mt76_rates. idx may change if firmware expands table */
+#define MT7996_BASIC_RATES_TBL		11
+
 struct mt7996_vif;
 struct mt7996_sta;
 struct mt7996_dfs_pulse;
@@ -136,6 +139,8 @@ struct mt7996_vif {
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 	struct cfg80211_bitrate_mask bitrate_mask;
+
+	u8 basic_rates_idx;
 };
 
 /* per-phy stats.  */
@@ -523,6 +528,8 @@ void mt7996_mac_cca_stats_reset(struct mt7996_phy *phy);
 void mt7996_mac_enable_nf(struct mt7996_dev *dev, u8 band);
 void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
 			      struct ieee80211_vif *vif, bool enable);
+void mt7996_mac_set_fixed_rate_table(struct mt7996_dev *dev,
+				     u8 tbl_idx, u16 rate_idx);
 void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
 			   struct ieee80211_key_conf *key, u32 changed);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 75f856205559..d1d3d154195d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -228,6 +228,13 @@ enum base_rev {
 #define MT_WTBL_UPDATE_ADM_COUNT_CLEAR		BIT(14)
 #define MT_WTBL_UPDATE_BUSY			BIT(31)
 
+#define MT_WTBL_ITCR				MT_WTBLON_TOP(0x3b0)
+#define MT_WTBL_ITCR_WR				BIT(16)
+#define MT_WTBL_ITCR_EXEC			BIT(31)
+#define MT_WTBL_ITDR0				MT_WTBLON_TOP(0x3b8)
+#define MT_WTBL_ITDR1				MT_WTBLON_TOP(0x3bc)
+#define MT_WTBL_SPE_IDX_SEL			BIT(6)
+
 /* WTBL */
 #define MT_WTBL_BASE				0x820d8000
 #define MT_WTBL_LMAC_ID				GENMASK(14, 8)
-- 
2.18.0

