Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448F14560BE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 17:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhKRQo0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 11:44:26 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:39510 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233589AbhKRQoZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 11:44:25 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.171])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AF2141A0073
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:23 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 74AB29C0072
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:23 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5307D13C2B5;
        Thu, 18 Nov 2021 08:41:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5307D13C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637253666;
        bh=IVf/p4/gvplod5Xz+t/ICmrpWd9Gyz98p+yRQe4Ym/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXmqpvSv81puv3a64HGAAMMchNXVRrmePxn7rkaGxeXrFGQJl8rQyzG9xBZ8K1txl
         mZUCoal+TiohYZdCi1kZrdsK/ccS3X2ToKbf/Qs/bQHL/frqf9jdqQ9feXPjZVaEWb
         /zoWMccY0aX7Pu7R47ccud5wYxdq7pzKH4F3RLUw=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 05/11] mt76: mt7915: ethtool group-5 rx stats information
Date:   Thu, 18 Nov 2021 08:40:50 -0800
Message-Id: <20211118164056.2965-5-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118164056.2965-1-greearb@candelatech.com>
References: <20211118164056.2965-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1637253684-ixvPu790-xHC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Add ethtool support for rx-nss, rx-bw, rx-mode stats.
These are only valid when the group-5 rx stats are
enabled.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 23 ++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h     | 10 ++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 21 +++++++++++++++++
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index a385c1850c61..577d83f8ae71 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1512,7 +1512,7 @@ EXPORT_SYMBOL_GPL(mt76_calculate_default_rate);
 void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 			 struct mt76_sta_stats *stats)
 {
-	int i, ei = wi->initial_stat_idx;
+	int i, q, ei = wi->initial_stat_idx;
 	u64 *data = wi->data;
 
 	wi->sta_count++;
@@ -1537,6 +1537,27 @@ void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
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
index 7bcdfef3c983..9e43ea0077d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -798,6 +798,16 @@ struct mt76_sta_stats {
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
index ddc85464b1e9..2915e7237d96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -424,6 +424,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	u8 qos_ctl = 0;
 	__le16 fc = 0;
 	int i, idx;
+	struct mt76_sta_stats *stats = NULL;
 
 	memset(status, 0, sizeof(*status));
 
@@ -451,6 +452,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		struct mt7915_sta *msta;
 
 		msta = container_of(status->wcid, struct mt7915_sta, wcid);
+		stats = &msta->stats;
 		spin_lock_bh(&dev->sta_poll_lock);
 		if (list_empty(&msta->poll_list))
 			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
@@ -654,8 +656,19 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 				WARN_ON_ONCE(nss > 4);
 			}
 
+			if (stats) {
+				if (nss > 3)
+					stats->rx_nss[3]++;
+				else
+					stats->rx_nss[nss - 1]++;
+
+				stats->rx_mode[mode]++;
+			}
+
 			switch (FIELD_GET(MT_CRXV_FRAME_MODE, v2)) {
 			case IEEE80211_STA_RX_BW_20:
+				if (stats)
+					stats->rx_bw_20++;
 				break;
 			case IEEE80211_STA_RX_BW_40:
 				if (mode & MT_PHY_TYPE_HE_EXT_SU &&
@@ -663,14 +676,24 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 					status->bw = RATE_INFO_BW_HE_RU;
 					status->he_ru =
 						NL80211_RATE_INFO_HE_RU_ALLOC_106;
+					if (stats) {
+						stats->rx_bw_he_ru++;
+						stats->rx_ru_106++;
+					}
 				} else {
 					status->bw = RATE_INFO_BW_40;
+					if (stats)
+						stats->rx_bw_40++;
 				}
 				break;
 			case IEEE80211_STA_RX_BW_80:
 				status->bw = RATE_INFO_BW_80;
+				if (stats)
+					stats->rx_bw_80++;
 				break;
 			case IEEE80211_STA_RX_BW_160:
+				if (stats)
+					stats->rx_bw_160++;
 				status->bw = RATE_INFO_BW_160;
 				break;
 			default:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index e973b2527b34..bfc81e008f86 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1170,6 +1170,27 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
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
-- 
2.20.1

