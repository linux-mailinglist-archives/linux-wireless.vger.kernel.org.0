Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE7A63E86B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 04:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiLADpC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 22:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiLADo7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 22:44:59 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D049076A
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 19:44:54 -0800 (PST)
X-UUID: a6dd4de0b4264d8f8b6b24402894fd1e-20221201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Jsf9J5Ms6gO+LqzpHqgBnYispZSazsm+J96Ryvhnp08=;
        b=iVuwNNltF0oAVbTaKMURtam0Y3HRqZq46rixbK7NX7abWO9QG0UT76QkdeLWsiOGv1shuWCa2rCodQKiQyqAqifQxUdT/NAZq3nUyA8QDgd+/TtAio9OhRvipVYpuo252yz2atEErPAhGRelCcQ/34TM5TAQhvFRrcdX4o87T44=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:0d4cafb4-46dd-4627-a9b6-5fd5df7b82ce,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:0d4cafb4-46dd-4627-a9b6-5fd5df7b82ce,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:5f50d01e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:2212011144514SBOYJUW,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a6dd4de0b4264d8f8b6b24402894fd1e-20221201
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1908393935; Thu, 01 Dec 2022 11:44:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 1 Dec 2022 11:44:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 1 Dec 2022 11:44:48 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 4/5] wifi: mt76: mt7996: enable ack signal support
Date:   Thu, 1 Dec 2022 11:44:43 +0800
Message-ID: <c206ea56124fca3d8b21e7f75ff7fe55f0465367.1669861863.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <d1c11adff6b57c9104bb16df19f62700e2505473.1669861862.git.ryder.lee@mediatek.com>
References: <d1c11adff6b57c9104bb16df19f62700e2505473.1669861862.git.ryder.lee@mediatek.com>
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

This reports signal strength of ACK packets from the peer as measured
at each interface.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  7 +++++++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 19 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  8 ++++++++
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  | 17 +++++++++--------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  5 +++++
 .../net/wireless/mediatek/mt76/mt7996/regs.h  | 17 +++++++++++++----
 6 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index cd1657e3585d..46b290526092 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -180,6 +180,7 @@ mt7996_init_wiphy(struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_DISCOVERY);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
 
 	if (!mdev->dev->of_node ||
 	    !of_property_read_bool(mdev->dev->of_node,
@@ -240,6 +241,12 @@ mt7996_mac_init_band(struct mt7996_dev *dev, u8 band)
 	set = FIELD_PREP(MT_WF_RMAC_MIB_OBSS_BACKOFF, 0) |
 	      FIELD_PREP(MT_WF_RMAC_MIB_ED_OFFSET, 4);
 	mt76_rmw(dev, MT_WF_RMAC_MIB_AIRTIME0(band), mask, set);
+
+	/* filter out non-resp frames and get instanstaeous signal reporting */
+	mask = MT_WTBLOFF_RSCR_RCPI_MODE | MT_WTBLOFF_RSCR_RCPI_PARAM;
+	set = FIELD_PREP(MT_WTBLOFF_RSCR_RCPI_MODE, 0) |
+	      FIELD_PREP(MT_WTBLOFF_RSCR_RCPI_PARAM, 0x3);
+	mt76_rmw(dev, MT_WTBLOFF_RSCR(band), mask, set);
 }
 
 static void mt7996_mac_init(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 554f9bcb69e2..00a6f44f3dc2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -10,7 +10,7 @@
 #include "mac.h"
 #include "mcu.h"
 
-#define to_rssi(field, rxv)	((FIELD_GET(field, rxv) - 220) / 2)
+#define to_rssi(field, rcpi)	((FIELD_GET(field, rcpi) - 220) / 2)
 
 #define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
 #define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
@@ -124,6 +124,7 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		bool clear = false;
 		u32 addr, val;
 		u16 idx;
+		s8 rssi[4];
 		u8 bw;
 
 		spin_lock_bh(&dev->sta_poll_lock);
@@ -137,6 +138,8 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		spin_unlock_bh(&dev->sta_poll_lock);
 
 		idx = msta->wcid.idx;
+
+		/* refresh peer's airtime reporting */
 		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 20);
 
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
@@ -213,6 +216,20 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 			else
 				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
 		}
+
+		/* get signal strength of resp frames (CTS/BA/ACK) */
+		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 34);
+		val = mt76_rr(dev, addr);
+
+		rssi[0] = to_rssi(GENMASK(7, 0), val);
+		rssi[1] = to_rssi(GENMASK(15, 8), val);
+		rssi[2] = to_rssi(GENMASK(23, 16), val);
+		rssi[3] = to_rssi(GENMASK(31, 14), val);
+
+		msta->ack_signal =
+			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
+
+		ewma_avg_signal_add(&msta->avg_ack_signal, -msta->ack_signal);
 	}
 
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index d43530a9786b..f2129be25d99 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -595,6 +595,8 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->jiffies = jiffies;
 
+	ewma_avg_signal_init(&msta->avg_ack_signal);
+
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
@@ -917,6 +919,12 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 	}
 	sinfo->txrate.flags = txrate->flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+
+	sinfo->ack_signal = (s8)msta->ack_signal;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
+
+	sinfo->avg_ack_signal = -(s8)ewma_avg_signal_read(&msta->avg_ack_signal);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
 }
 
 static void mt7996_sta_rc_work(void *data, struct ieee80211_sta *sta)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 0d097cda4da7..521769eb6b0e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -12,14 +12,15 @@
 #include "../trace.h"
 
 static const struct __base mt7996_reg_base[] = {
-	[WF_AGG_BASE]	= { { 0x820e2000, 0x820f2000, 0x830e2000 } },
-	[WF_MIB_BASE]	= { { 0x820ed000, 0x820fd000, 0x830ed000 } },
-	[WF_TMAC_BASE]	= { { 0x820e4000, 0x820f4000, 0x830e4000 } },
-	[WF_RMAC_BASE]	= { { 0x820e5000, 0x820f5000, 0x830e5000 } },
-	[WF_ARB_BASE]	= { { 0x820e3000, 0x820f3000, 0x830e3000 } },
-	[WF_LPON_BASE]	= { { 0x820eb000, 0x820fb000, 0x830eb000 } },
-	[WF_ETBF_BASE]	= { { 0x820ea000, 0x820fa000, 0x830ea000 } },
-	[WF_DMA_BASE]	= { { 0x820e7000, 0x820f7000, 0x830e7000 } },
+	[WF_AGG_BASE]		= { { 0x820e2000, 0x820f2000, 0x830e2000 } },
+	[WF_ARB_BASE]		= { { 0x820e3000, 0x820f3000, 0x830e3000 } },
+	[WF_TMAC_BASE]		= { { 0x820e4000, 0x820f4000, 0x830e4000 } },
+	[WF_RMAC_BASE]		= { { 0x820e5000, 0x820f5000, 0x830e5000 } },
+	[WF_DMA_BASE]		= { { 0x820e7000, 0x820f7000, 0x830e7000 } },
+	[WF_WTBLOFF_BASE]	= { { 0x820e9000, 0x820f9000, 0x830e9000 } },
+	[WF_ETBF_BASE]		= { { 0x820ea000, 0x820fa000, 0x830ea000 } },
+	[WF_LPON_BASE]		= { { 0x820eb000, 0x820fb000, 0x830eb000 } },
+	[WF_MIB_BASE]		= { { 0x820ed000, 0x820fd000, 0x830ed000 } },
 };
 
 static const struct __map mt7996_reg_map[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 00c58878524e..17dcd05d3459 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -85,6 +85,8 @@ struct mt7996_twt_flow {
 	u8 sched:1;
 };
 
+DECLARE_EWMA(avg_signal, 10, 8)
+
 struct mt7996_sta {
 	struct mt76_wcid wcid; /* must be first */
 
@@ -94,6 +96,9 @@ struct mt7996_sta {
 	struct list_head rc_list;
 	u32 airtime_ac[8];
 
+	int ack_signal;
+	struct ewma_avg_signal avg_ack_signal;
+
 	unsigned long changed;
 	unsigned long jiffies;
 	unsigned long ampdu_state;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 1d53611da4d8..794f61b93a46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -25,13 +25,14 @@ struct mt7996_reg_desc {
 
 enum base_rev {
 	WF_AGG_BASE,
-	WF_MIB_BASE,
+	WF_ARB_BASE,
 	WF_TMAC_BASE,
 	WF_RMAC_BASE,
-	WF_ARB_BASE,
-	WF_LPON_BASE,
-	WF_ETBF_BASE,
 	WF_DMA_BASE,
+	WF_WTBLOFF_BASE,
+	WF_ETBF_BASE,
+	WF_LPON_BASE,
+	WF_MIB_BASE,
 	__MT_REG_BASE_MAX,
 };
 
@@ -97,6 +98,14 @@ enum base_rev {
 #define MT_DMA_TCRF1(_band)			MT_WF_DMA(_band, 0x054)
 #define MT_DMA_TCRF1_QIDX			GENMASK(15, 13)
 
+/* WTBLOFF TOP: band 0(0x820e9000), band 1(0x820f9000), band 2(0x830e9000) */
+#define MT_WTBLOFF_BASE(_band)			__BASE(WF_WTBLOFF_BASE, (_band))
+#define MT_WTBLOFF(_band, ofs)			(MT_WTBLOFF_BASE(_band) + (ofs))
+
+#define MT_WTBLOFF_RSCR(_band)			MT_WTBLOFF(_band, 0x008)
+#define MT_WTBLOFF_RSCR_RCPI_MODE		GENMASK(31, 30)
+#define MT_WTBLOFF_RSCR_RCPI_PARAM		GENMASK(25, 24)
+
 /* ETBF: band 0(0x820ea000), band 1(0x820fa000), band 2(0x830ea000) */
 #define MT_WF_ETBF_BASE(_band)			__BASE(WF_ETBF_BASE, (_band))
 #define MT_WF_ETBF(_band, ofs)			(MT_WF_ETBF_BASE(_band) + (ofs))
-- 
2.18.0

