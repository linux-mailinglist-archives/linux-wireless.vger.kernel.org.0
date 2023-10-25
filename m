Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB07D73D8
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343573AbjJYTEJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjJYTEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:04:06 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA1115
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:04:03 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 764D330005D
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 19:04:01 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 27D2D13C2B4;
        Wed, 25 Oct 2023 12:04:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 27D2D13C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698260641;
        bh=OsbSj15/+5e6H62I01u2HR2chPv55pJlsDbEbV0Pg+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ksCt96THGbj2EQj12uZfHNKPWdRMh/Z4AuVVqtewIM09s1Oz8gxh+4UqEexaNDaai
         nFwuUnBFRiqjWOpztXAh0XIuB3/snOK7If68/s0ZrIsubQSJBTfuGL/W0G/2FfH3FH
         p4c67wKpxJOzb4u/4wym6OtWBRsK2Bn37ocJiaT0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 09/12] wifi: mt76: mt7915: ethtool group-5 rx stats information
Date:   Wed, 25 Oct 2023 12:03:51 -0700
Message-Id: <20231025190351.2141832-9-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231025190351.2141832-1-greearb@candelatech.com>
References: <20231025190351.2141832-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698260642-BJqun6Dk4pTl
X-MDID-O: us5;at1;1698260642;BJqun6Dk4pTl;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/wireless/mediatek/mt76/mac80211.c | 23 +++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  9 +++++++
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  3 ++-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 24 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  4 +++-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 21 ++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  4 +++-
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 21 ++++++++++++++++
 8 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 11651e5c9488..069e3f9f268d 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1771,7 +1771,7 @@ EXPORT_SYMBOL_GPL(mt76_calculate_default_rate);
 void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 			 struct mt76_sta_stats *stats, bool eht)
 {
-	int i, ei = wi->initial_stat_idx;
+	int i, q, ei = wi->initial_stat_idx;
 	u64 *data = wi->data;
 
 	wi->sta_count++;
@@ -1804,6 +1804,27 @@ void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 	for (i = 0; i < 4; i++)
 		data[ei++] += stats->tx_nss[i];
 
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
index 7b141fbf3497..35a333ae3d84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -288,6 +288,15 @@ struct mt76_sta_stats {
 	u32 rx_packets;
 	u32 rx_errors;
 	u32 rx_drops;
+	/* This section requires group-5 in rxd to be enabled for 7915. */
+	unsigned long rx_nss[4]; /* rx-nss histogram */
+	unsigned long rx_mode[__MT_PHY_TYPE_MAX]; /* rx mode histogram */
+	unsigned long rx_bw_20;
+	unsigned long rx_bw_40;
+	unsigned long rx_bw_80;
+	unsigned long rx_bw_160;
+	unsigned long rx_bw_he_ru;
+	unsigned long rx_ru_106;
 };
 
 enum mt76_wcid_flags {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 774911c52686..8d501db26c5a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -424,7 +424,8 @@ int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80211_vif *vif,
 int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 				  struct mt76_rx_status *status,
 				  struct ieee80211_supported_band *sband,
-				  __le32 *rxv, u8 *mode, u8 *nss);
+				  __le32 *rxv, u8 *mode, u8 *nss,
+				  struct mt76_sta_stats *stats);
 void mt76_connac2_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
 void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 			    struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index ccd82943cdd1..d349329a8168 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1014,7 +1014,8 @@ EXPORT_SYMBOL_GPL(mt76_connac2_reverse_frag0_hdr_trans);
 int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 				  struct mt76_rx_status *status,
 				  struct ieee80211_supported_band *sband,
-				  __le32 *rxv, u8 *mode, u8 *nss)
+				  __le32 *rxv, u8 *mode, u8 *nss,
+				  struct mt76_sta_stats *stats)
 {
 	u32 v0, v2;
 	u8 stbc, gi, bw, dcm;
@@ -1090,6 +1091,8 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 
 	switch (bw) {
 	case IEEE80211_STA_RX_BW_20:
+		if (stats)
+			stats->rx_bw_20++;
 		break;
 	case IEEE80211_STA_RX_BW_40:
 		if (*mode & MT_PHY_TYPE_HE_EXT_SU &&
@@ -1097,15 +1100,25 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
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
 		break;
 	case IEEE80211_STA_RX_BW_160:
 		status->bw = RATE_INFO_BW_160;
+		if (stats)
+			stats->rx_bw_160++;
 		break;
 	default:
 		return -EINVAL;
@@ -1126,6 +1139,15 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 
 	status->nss = *nss;
 
+	if (stats) {
+		if (*nss > 3)
+			stats->rx_nss[3]++;
+		else
+			stats->rx_nss[*nss - 1]++;
+		if (*mode < __MT_PHY_TYPE_MAX)
+			stats->rx_mode[*mode]++;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_fill_rx_rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index be983a1bfe20..40f3320edc02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -307,6 +307,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 	u16 seq_ctrl = 0;
 	__le16 fc = 0;
 	int idx;
+	struct mt76_sta_stats *stats = NULL;
 
 	memset(status, 0, sizeof(*status));
 
@@ -339,6 +340,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 
 	if (status->wcid) {
 		msta = container_of(status->wcid, struct mt7915_sta, wcid);
+		stats = &status->wcid->stats;
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		if (list_empty(&msta->wcid.poll_list))
 			list_add_tail(&msta->wcid.poll_list,
@@ -484,7 +486,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 		if (!is_mt7915(&dev->mt76) || (rxd1 & MT_RXD1_NORMAL_GROUP_5)) {
 			ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status,
 							    sband, rxv, &mode,
-							    &nss);
+							    &nss, stats);
 			if (ret < 0)
 				return ret;
 		} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index bef8a3c17731..05b633932e16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1391,6 +1391,27 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_nss_2",
 	"v_tx_nss_3",
 	"v_tx_nss_4",
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 52bbd7b98710..9f2c8a3a4202 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -189,6 +189,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	__le16 fc = 0;
 	u8 mode = 0;
 	int i, idx;
+	struct mt76_sta_stats *stats = NULL;
 
 	memset(status, 0, sizeof(*status));
 
@@ -216,6 +217,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 
 	if (status->wcid) {
 		msta = container_of(status->wcid, struct mt792x_sta, wcid);
+		stats = &status->wcid->stats;
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		if (list_empty(&msta->wcid.poll_list))
 			list_add_tail(&msta->wcid.poll_list,
@@ -347,7 +349,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 			status->enc_flags |= RX_ENC_FLAG_LDPC;
 
 		ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status, sband,
-						    rxv, &mode, &nss);
+						    rxv, &mode, &nss, stats);
 		if (ret < 0)
 			return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index f92a43d5f5b0..2607abc0d028 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -376,6 +376,27 @@ static const char mt792x_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_nss_2",
 	"v_tx_nss_3",
 	"v_tx_nss_4",
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
 
 void mt792x_get_et_strings(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-- 
2.40.0

