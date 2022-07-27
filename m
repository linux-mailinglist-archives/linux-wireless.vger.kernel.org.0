Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD82F583577
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 01:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiG0XBu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 19:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiG0XBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 19:01:44 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F9F21242
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 16:01:42 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.75])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 19FFF1C008A;
        Wed, 27 Jul 2022 23:01:41 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D913A80074;
        Wed, 27 Jul 2022 23:01:40 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 9BCA313C2B3;
        Wed, 27 Jul 2022 16:01:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9BCA313C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1658962900;
        bh=VvX5GinnEZCSHWrYjzLzhuGymQd4uMg7l/CeW6RIRa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxmvhPCqbQ6/UbuLUltAmvE4TiQmozqL1N6sN+8zlH1kpVib1xkSA+0LwCn4VC3fz
         TnV2KStVNklztW6PE2nF4Q54nSI87pmNaQvX3Sc9ut81JyPAwAXuZjARRM9z7HRpqK
         vIfN7B8DoMiG26Woyuc6HefiTyJ5hsYODp/CvcDM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 09/12] wifi: mt76: mt7915: ethtool group-5 rx stats information
Date:   Wed, 27 Jul 2022 16:01:19 -0700
Message-Id: <20220727230122.29842-9-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220727230122.29842-1-greearb@candelatech.com>
References: <20220727230122.29842-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1658962901-dcYSgj9Nnmcf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Add ethtool support for rx-nss, rx-bw, rx-mode stats.
These are only valid when the group-5 rx stats are
enabled.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 23 ++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h     | 10 +++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 29 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 21 ++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 21 ++++++++++++++
 5 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 242e055fa475..574e2c54637a 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1623,7 +1623,7 @@ EXPORT_SYMBOL_GPL(mt76_calculate_default_rate);
 void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 			 struct mt76_sta_stats *stats)
 {
-	int i, ei = wi->initial_stat_idx;
+	int i, q, ei = wi->initial_stat_idx;
 	u64 *data = wi->data;
 
 	wi->sta_count++;
@@ -1648,6 +1648,27 @@ void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 	for (i = 0; i < 12; i++)
 		data[ei++] += stats->tx_mcs[i];
 
+	/* rx stats */
+	for (q = 0; q < ARRAY_SIZE(stats->rx_nss); q++)
+		data[ei++] += stats->rx_nss[q];
+
+	data[ei++] += stats->rx_mode[MT_PHY_TYPE_CCK];
+	data[ei++] += stats->rx_mode[MT_PHY_TYPE_OFDM];
+	data[ei++] += stats->rx_mode[MT_PHY_TYPE_HT];
+	data[ei++] += stats->rx_mode[MT_PHY_TYPE_HT_GF];
+	data[ei++] += stats->rx_mode[MT_PHY_TYPE_VHT];
+	data[ei++] += stats->rx_mode[MT_PHY_TYPE_HE_SU];
+	data[ei++] += stats->rx_mode[MT_PHY_TYPE_HE_EXT_SU];
+	data[ei++] += stats->rx_mode[MT_PHY_TYPE_HE_TB];
+	data[ei++] += stats->rx_mode[MT_PHY_TYPE_HE_MU];
+
+	data[ei++] += stats->rx_bw_20;
+	data[ei++] += stats->rx_bw_40;
+	data[ei++] += stats->rx_bw_80;
+	data[ei++] += stats->rx_bw_160;
+	data[ei++] += stats->rx_bw_he_ru;
+	data[ei++] += stats->rx_ru_106;
+
 	wi->worker_stat_count = ei - wi->initial_stat_idx;
 }
 EXPORT_SYMBOL_GPL(mt76_ethtool_worker);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 682b554fbcb7..cbf1a30d3cc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -839,6 +839,16 @@ struct mt76_sta_stats {
 	u64 tx_bw[4];		/* 20, 40, 80, 160 */
 	u64 tx_nss[4];		/* 1, 2, 3, 4 */
 	u64 tx_mcs[16];		/* mcs idx */
+
+	/* This section requires group-5 in rxd to be enabled for 7915. */
+	u32 rx_nss[4]; /* rx-nss histogram */
+	u32 rx_mode[__MT_PHY_TYPE_HE_MAX]; /* rx mode histogram */
+	u32 rx_bw_20;
+	u32 rx_bw_40;
+	u32 rx_bw_80;
+	u32 rx_bw_160;
+	u32 rx_bw_he_ru;
+	u32 rx_ru_106;
 };
 
 struct mt76_ethtool_worker_info {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1d2909c0c04c..ca6748d67ce0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -487,7 +487,8 @@ static int
 mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			struct mt76_rx_status *status,
 			struct ieee80211_supported_band *sband,
-			__le32 *rxv, u8 *mode, u8 *nss)
+			__le32 *rxv, u8 *mode, u8 *nss,
+			struct mt76_sta_stats *stats)
 {
 	u32 v0, v2;
 	u8 stbc, gi, bw, dcm;
@@ -555,6 +556,8 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 
 	switch (bw) {
 	case IEEE80211_STA_RX_BW_20:
+		if (stats)
+			stats->rx_bw_20++;
 		break;
 	case IEEE80211_STA_RX_BW_40:
 		if (*mode & MT_PHY_TYPE_HE_EXT_SU &&
@@ -562,15 +565,26 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			status->bw = RATE_INFO_BW_HE_RU;
 			status->he_ru =
 				NL80211_RATE_INFO_HE_RU_ALLOC_106;
+			if (stats) {
+				stats->rx_bw_he_ru++;
+				stats->rx_ru_106++;
+			}
 		} else {
 			status->bw = RATE_INFO_BW_40;
+			if (stats)
+				stats->rx_bw_40++;
 		}
 		break;
 	case IEEE80211_STA_RX_BW_80:
 		status->bw = RATE_INFO_BW_80;
+		if (stats)
+			stats->rx_bw_80++;
+
 		break;
 	case IEEE80211_STA_RX_BW_160:
 		status->bw = RATE_INFO_BW_160;
+		if (stats)
+			stats->rx_bw_160++;
 		break;
 	default:
 		return -EINVAL;
@@ -591,6 +605,15 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 
 	status->nss = *nss;
 
+	if (stats) {
+		if (*nss > 3)
+			stats->rx_nss[3]++;
+		else
+			stats->rx_nss[*nss - 1]++;
+		if (*mode < __MT_PHY_TYPE_HE_MAX)
+			stats->rx_mode[*mode]++;
+	}
+
 	return 0;
 }
 
@@ -618,6 +641,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	u16 seq_ctrl = 0;
 	__le16 fc = 0;
 	int idx;
+	struct mt76_sta_stats *stats = NULL;
 
 	memset(status, 0, sizeof(*status));
 
@@ -652,6 +676,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		struct mt7915_sta *msta;
 
 		msta = container_of(status->wcid, struct mt7915_sta, wcid);
+		stats = &msta->stats;
 		spin_lock_bh(&dev->sta_poll_lock);
 		if (list_empty(&msta->poll_list))
 			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
@@ -797,7 +822,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 		if (!is_mt7915(&dev->mt76) || (rxd1 & MT_RXD1_NORMAL_GROUP_5)) {
 			ret = mt7915_mac_fill_rx_rate(dev, status, sband, rxv,
-						      &mode, &nss);
+						      &mode, &nss, stats);
 			if (ret < 0)
 				return ret;
 		} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 1e8f525fa669..db3c32eebb04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1187,6 +1187,27 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_mcs_9",
 	"v_tx_mcs_10",
 	"v_tx_mcs_11",
+
+	/* per-vif rx counters */
+	"v_rx_nss1",
+	"v_rx_nss2",
+	"v_rx_nss3",
+	"v_rx_nss4",
+	"v_rx_mode_cck",
+	"v_rx_mode_ofdm",
+	"v_rx_mode_ht",
+	"v_rx_mode_ht_gf",
+	"v_rx_mode_vht",
+	"v_rx_mode_he_su",
+	"v_rx_mode_he_ext_su",
+	"v_rx_mode_he_tb",
+	"v_rx_mode_he_mu",
+	"v_rx_bw_20",
+	"v_rx_bw_40",
+	"v_rx_bw_80",
+	"v_rx_bw_160",
+	"v_rx_bw_he_ru",
+	"v_rx_ru_106",
 };
 
 #define MT7915_SSTATS_LEN ARRAY_SIZE(mt7915_gstrings_stats)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index ac78fcf285bf..a23dd8f44e28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1016,6 +1016,27 @@ static const char mt7921_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_mcs_9",
 	"v_tx_mcs_10",
 	"v_tx_mcs_11",
+
+	/* per-vif rx counters */
+	"v_rx_nss1",
+	"v_rx_nss2",
+	"v_rx_nss3",
+	"v_rx_nss4",
+	"v_rx_mode_cck",
+	"v_rx_mode_ofdm",
+	"v_rx_mode_ht",
+	"v_rx_mode_ht_gf",
+	"v_rx_mode_vht",
+	"v_rx_mode_he_su",
+	"v_rx_mode_he_ext_su",
+	"v_rx_mode_he_tb",
+	"v_rx_mode_he_mu",
+	"v_rx_bw_20",
+	"v_rx_bw_40",
+	"v_rx_bw_80",
+	"v_rx_bw_160",
+	"v_rx_bw_he_ru",
+	"v_rx_ru_106",
 };
 
 static void
-- 
2.20.1

