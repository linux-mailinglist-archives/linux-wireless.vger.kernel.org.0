Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4975FE72F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 04:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiJNC6A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 22:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJNC6A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 22:58:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B180415F918
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 19:57:58 -0700 (PDT)
X-UUID: 23621e676de04d7f84656a67b1c5382a-20221014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6vh4IJCOfQjz3JMDhYQ0n9jKVIGYVFgFR+YTYI8YBhA=;
        b=nUQsXWeNyishVvxiE8iPQTnx5iRSOS9wLyJuUkB8bqt8EB4QBVPEdJ9TnuTcSpKcJF380L2ZdaVClbj6FIth0Yp04r0BzD71oZZu7bc2F2mxgM5L5/joRab0O7OfrbJv/o82uoSt80ZaY59fcK+q1Xy1+3LvE5/QzZBZ0Pngbwk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:32f069fe-b944-48df-b429-6d9207a42ef3,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:be6f3eff-ee8c-4ff7-afe9-644435e96625,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 23621e676de04d7f84656a67b1c5382a-20221014
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1321940223; Fri, 14 Oct 2022 10:57:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 14 Oct 2022 10:57:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Oct 2022 10:57:53 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] wifi: mt76: mt7915: add ack signal support
Date:   Fri, 14 Oct 2022 10:57:48 +0800
Message-ID: <167355984a4e8ab4fe4330af7d10c02184b563ee.1665714480.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <98348bffc688f4c1416981f72528eebcc01faee3.1665714480.git.ryder.lee@mediatek.com>
References: <98348bffc688f4c1416981f72528eebcc01faee3.1665714480.git.ryder.lee@mediatek.com>
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

Tested-by: Shurong Wen <shurong.wen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  9 ++++-----
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  7 +++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 19 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  8 ++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  6 +++++-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  8 ++++++++
 7 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 4bdbfd0f6233..c59d12004459 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -951,14 +951,12 @@ void mt76_wcid_key_setup(struct mt76_dev *dev, struct mt76_wcid *wcid,
 }
 EXPORT_SYMBOL(mt76_wcid_key_setup);
 
-static int
-mt76_rx_signal(struct mt76_rx_status *status)
+int mt76_rx_signal(u8 chain_mask, s8 *chain_signal)
 {
-	s8 *chain_signal = status->chain_signal;
 	int signal = -128;
 	u8 chains;
 
-	for (chains = status->chains; chains; chains >>= 1, chain_signal++) {
+	for (chains = chain_mask; chains; chains >>= 1, chain_signal++) {
 		int cur, diff;
 
 		cur = *chain_signal;
@@ -980,6 +978,7 @@ mt76_rx_signal(struct mt76_rx_status *status)
 
 	return signal;
 }
+EXPORT_SYMBOL(mt76_rx_signal);
 
 static void
 mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
@@ -1009,7 +1008,7 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 	status->ampdu_reference = mstat.ampdu_ref;
 	status->device_timestamp = mstat.timestamp;
 	status->mactime = mstat.timestamp;
-	status->signal = mt76_rx_signal(&mstat);
+	status->signal = mt76_rx_signal(mstat.chains, mstat.chain_signal);
 	if (status->signal <= -128)
 		status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f9bdf16fc6c4..c91fb9bde632 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1149,6 +1149,7 @@ void mt76_update_survey(struct mt76_phy *phy);
 void mt76_update_survey_active_time(struct mt76_phy *phy, ktime_t time);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey);
+int mt76_rx_signal(u8 chain_mask, s8 *chain_signal);
 void mt76_set_stream_caps(struct mt76_phy *phy, bool vht);
 
 int mt76_rx_aggr_start(struct mt76_dev *dev, struct mt76_wcid *wcid, u8 tid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 7173ed964519..0e7d065afe29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -353,6 +353,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_DISCOVERY);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
 
 	if (!mdev->dev->of_node ||
 	    !of_property_read_bool(mdev->dev->of_node,
@@ -461,6 +462,12 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 	set = FIELD_PREP(MT_WF_RMAC_MIB_OBSS_BACKOFF, 0) |
 	      FIELD_PREP(MT_WF_RMAC_MIB_ED_OFFSET, 4);
 	mt76_rmw(dev, MT_WF_RMAC_MIB_AIRTIME0(band), mask, set);
+
+	/* filter out non-resp frames and get instanstaeous signal reporting */
+	mask = MT_WTBLOFF_TOP_RSCR_RCPI_MODE | MT_WTBLOFF_TOP_RSCR_RCPI_PARAM;
+	set = FIELD_PREP(MT_WTBLOFF_TOP_RSCR_RCPI_MODE, 0) |
+	      FIELD_PREP(MT_WTBLOFF_TOP_RSCR_RCPI_PARAM, 0x3);
+	mt76_rmw(dev, MT_WTBLOFF_TOP_RSCR(band), mask, set);
 }
 
 static void mt7915_mac_init(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 34a50d594372..1ce2b91353e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -9,7 +9,7 @@
 #include "mac.h"
 #include "mcu.h"
 
-#define to_rssi(field, rxv)	((FIELD_GET(field, rxv) - 220) / 2)
+#define to_rssi(field, rcpi)	((FIELD_GET(field, rcpi) - 220) / 2)
 
 static const struct mt7915_dfs_radar_spec etsi_radar_specs = {
 	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
@@ -119,6 +119,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		bool clear = false;
 		u32 addr, val;
 		u16 idx;
+		s8 rssi[4];
 		u8 bw;
 
 		spin_lock_bh(&dev->sta_poll_lock);
@@ -132,6 +133,8 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		spin_unlock_bh(&dev->sta_poll_lock);
 
 		idx = msta->wcid.idx;
+
+		/* refresh peer's airtime reporting */
 		addr = mt7915_mac_wtbl_lmac_addr(dev, idx, 20);
 
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
@@ -210,6 +213,20 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 			else
 				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
 		}
+
+		/* get signal strength of resp frames (CTS/BA/ACK) */
+		addr = mt7915_mac_wtbl_lmac_addr(dev, idx, 30);
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 6de49b93387e..ac320182c2ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -665,6 +665,8 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->jiffies = jiffies;
 
+	ewma_avg_signal_init(&msta->avg_ack_signal);
+
 	mt7915_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
@@ -1025,6 +1027,12 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->tx_retries = msta->wcid.stats.tx_retries;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 	}
+
+	sinfo->ack_signal = (s8)msta->ack_signal;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
+
+	sinfo->avg_ack_signal = -(s8)ewma_avg_signal_read(&msta->avg_ack_signal);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
 }
 
 static void mt7915_sta_rc_work(void *data, struct ieee80211_sta *sta)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 5e95f5c77933..b0b57ee1e00f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -114,6 +114,8 @@ struct mt7915_twt_flow {
 	u8 sched:1;
 };
 
+DECLARE_EWMA(avg_signal, 10, 8)
+
 struct mt7915_sta {
 	struct mt76_wcid wcid; /* must be first */
 
@@ -123,10 +125,12 @@ struct mt7915_sta {
 	struct list_head rc_list;
 	u32 airtime_ac[8];
 
+	int ack_signal;
+	struct ewma_avg_signal avg_ack_signal;
+
 	unsigned long changed;
 	unsigned long jiffies;
 	unsigned long ampdu_state;
-
 	struct mt76_connac_sta_key_conf bip;
 
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 7db809671230..9924271d8e36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -226,6 +226,14 @@ enum offs_rev {
 #define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 3)
 #define MT_DMA_DCR0_RXD_G5_EN		BIT(23)
 
+/* WTBLOFF TOP: band 0(0x820e9000),band 1(0x820f9000) */
+#define MT_WTBLOFF_TOP_BASE(_band)	((_band) ? 0x820f9000 : 0x820e9000)
+#define MT_WTBLOFF_TOP(_band, ofs)	(MT_WTBLOFF_TOP_BASE(_band) + (ofs))
+
+#define MT_WTBLOFF_TOP_RSCR(_band)	MT_WTBLOFF_TOP(_band, 0x008)
+#define MT_WTBLOFF_TOP_RSCR_RCPI_MODE	GENMASK(31, 30)
+#define MT_WTBLOFF_TOP_RSCR_RCPI_PARAM	GENMASK(25, 24)
+
 /* ETBF: band 0(0x820ea000), band 1(0x820fa000) */
 #define MT_WF_ETBF_BASE(_band)		((_band) ? 0x820fa000 : 0x820ea000)
 #define MT_WF_ETBF(_band, ofs)		(MT_WF_ETBF_BASE(_band) + (ofs))
-- 
2.36.1

