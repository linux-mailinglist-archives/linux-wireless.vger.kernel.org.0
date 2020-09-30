Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CB727E877
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 14:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgI3MYr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgI3MYq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:46 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ACBC061755
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=asISrvtVABPgxDvEAUpHdytbjHH3o69OnEszIeHDi4I=; b=IkALPjWZe8ZIZAa6ufZnqshevV
        ePiq03W0j5HzRNqFYsEPgkcAGPnJdiDt+D+gx+ULp/HzuEI/OAKXMENSuqaFMo0CQEMsrpJhxN7h2
        lc3O17Bg55RM2UVbyBEwWvkxxTkwBSIwNiWhYW0e6c9af3aGv4qa4fHopwTLQvrrZ04I=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNbA4-0005MT-MD
        for linux-wireless@vger.kernel.org; Wed, 30 Sep 2020 14:24:44 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 10/10] mt76: mt7915: query station rx rate from firmware
Date:   Wed, 30 Sep 2020 14:24:41 +0200
Message-Id: <20200930122441.64523-10-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930122441.64523-1-nbd@nbd.name>
References: <20200930122441.64523-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When per-packet rate reporting is enabled, the hardware can get stuck under
some conditions. It self-recovers quickly, but in practice this leads to
reduced performance.
In order to avoid running into this issue, disable per-packet rate reporting
by default and query the rx rate from firmware instead, unless monitor mode
is enabled.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  9 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 94 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 21 +++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +
 5 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 5884c0ce45e5..5f238bc63c2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -43,8 +43,8 @@ static void mt7915_mac_init(struct mt7915_dev *dev)
 
 	mt76_rmw_field(dev, MT_DMA_DCR0, MT_DMA_DCR0_MAX_RX_LEN, 1536);
 	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, 1536);
-	/* enable rx rate report */
-	mt76_set(dev, MT_DMA_DCR0, MT_DMA_DCR0_RXD_G5_EN);
+	/* disable rx rate report by default due to hw issues */
+	mt76_clear(dev, MT_DMA_DCR0, MT_DMA_DCR0_RXD_G5_EN);
 	/* disable hardware de-agg */
 	mt76_clear(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 5d4bffbe07f9..b53f04fc0534 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -362,11 +362,14 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 	mutex_lock(&dev->mt76.mutex);
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
-		if (!(hw->conf.flags & IEEE80211_CONF_MONITOR))
+		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
+
+		if (!enabled)
 			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
 		else
 			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
 
+		mt76_rmw_field(dev, MT_DMA_DCR0, MT_DMA_DCR0_RXD_G5_EN, enabled);
 		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
 	}
 
@@ -794,9 +797,13 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 				  struct ieee80211_sta *sta,
 				  struct station_info *sinfo)
 {
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct mt7915_sta_stats *stats = &msta->stats;
 
+	if (mt7915_mcu_get_rx_rate(phy, vif, sta, &sinfo->rxrate) == 0)
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+
 	if (!stats->tx_rate.legacy && !stats->tx_rate.flags)
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index a87b10e8fda7..dde053a76261 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3404,3 +3404,97 @@ int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_SPR, &req,
 				 sizeof(req), true);
 }
+
+int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, struct rate_info *rate)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt7915_dev *dev = phy->dev;
+	struct mt76_phy *mphy = phy->mt76;
+	struct {
+		u8 category;
+		u8 band;
+		__le16 wcid;
+	} __packed req = {
+		.category = MCU_PHY_STATE_CONTENTION_RX_RATE,
+		.band = mvif->band_idx,
+		.wcid = cpu_to_le16(msta->wcid.idx),
+	};
+	struct ieee80211_supported_band *sband;
+	struct mt7915_mcu_phy_rx_info *res;
+	struct sk_buff *skb;
+	u16 flags = 0;
+	int ret;
+	int i;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_PHY_STAT_INFO,
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt7915_mcu_phy_rx_info *)skb->data;
+
+	rate->mcs = res->rate;
+	rate->nss = res->nsts + 1;
+
+	switch (res->mode) {
+	case MT_PHY_TYPE_CCK:
+	case MT_PHY_TYPE_OFDM:
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		for (i = 0; i < sband->n_bitrates; i++) {
+			if (rate->mcs != (sband->bitrates[i].hw_value & 0xf))
+				continue;
+
+			rate->legacy = sband->bitrates[i].bitrate;
+			break;
+		}
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		rate->mcs += (rate->nss - 1) * 8;
+		flags |= RATE_INFO_FLAGS_MCS;
+
+		if (res->gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		flags |= RATE_INFO_FLAGS_VHT_MCS;
+
+		if (res->gi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		rate->he_gi = res->gi;
+
+		flags |= RATE_INFO_FLAGS_HE_MCS;
+		break;
+	default:
+		break;
+	}
+	rate->flags = flags;
+
+	switch (res->bw) {
+	case IEEE80211_STA_RX_BW_160:
+		rate->bw = RATE_INFO_BW_160;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		rate->bw = RATE_INFO_BW_80;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		rate->bw = RATE_INFO_BW_40;
+		break;
+	default:
+		rate->bw = RATE_INFO_BW_20;
+		break;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 49ff60509a72..5f23f27f9f6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -153,6 +153,18 @@ struct mt7915_mcu_ra_info {
 	u8 prob_down_pending;
 } __packed;
 
+
+struct mt7915_mcu_phy_rx_info {
+	u8 category;
+	u8 rate;
+	u8 mode;
+	u8 nsts;
+	u8 gi;
+	u8 coding;
+	u8 stbc;
+	u8 bw;
+};
+
 #define MT_RA_RATE_NSS			GENMASK(8, 6)
 #define MT_RA_RATE_MCS			GENMASK(3, 0)
 #define MT_RA_RATE_TX_MODE		GENMASK(12, 9)
@@ -217,6 +229,7 @@ enum {
 	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
 	MCU_EXT_CMD_SET_RDD_TH = 0x9d,
 	MCU_EXT_CMD_SET_SPR = 0xa8,
+	MCU_EXT_CMD_PHY_STAT_INFO = 0xad,
 };
 
 enum {
@@ -250,6 +263,14 @@ enum {
 	EE_FORMAT_MULTIPLE,
 };
 
+enum {
+	MCU_PHY_STATE_TX_RATE,
+	MCU_PHY_STATE_RX_RATE,
+	MCU_PHY_STATE_RSSI,
+	MCU_PHY_STATE_CONTENTION_RX_RATE,
+	MCU_PHY_STATE_OFDMLQ_CNINFO,
+};
+
 #define STA_TYPE_STA			BIT(0)
 #define STA_TYPE_AP			BIT(1)
 #define STA_TYPE_ADHOC			BIT(2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 292075d3f0da..0ea3965c28f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -321,6 +321,8 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 			    const struct mt7915_dfs_pattern *pattern);
 int mt7915_mcu_get_rate_info(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx);
 int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index);
+int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev, enum mt7915_rdd_cmd cmd,
 		       u8 index, u8 rx_sel, u8 val);
 int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 ctrl);
-- 
2.28.0

