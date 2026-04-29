Return-Path: <linux-wireless+bounces-35621-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFfWIDYH8mkimwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35621-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:27:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BAC494C9F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A30E430117DB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C093FE350;
	Wed, 29 Apr 2026 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WM8872k2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DD2C21F7
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469204; cv=none; b=UWqjsdhZ7nRyDy2C6rF5tSxpwI0+Smv65Ysi2tSqJrYjzGvnt8LqUpNn3UVpLdMyTKXEDQcQqLD7Q8tJqQlSSycMi5GAkoxdn66u0RQB7gZK3adJ89a1uXt2fUa5MlBIYJ3l7kh7STiRvZXq8jszQbUhGBvTKOrSn3oeu91fvXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469204; c=relaxed/simple;
	bh=I3IXOAqVR5WSuyoqhVlbtAzT4nHF9BiK0DPVfzXJhCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvhtyV0apdYeKp3OIlY2TMT0Y5eeu25nTMBwzSy8Z14NE5GJzh7i/l5Rpy+Vl3K3dyRN9OYUui6rDbw0ohdm7ZDqO4uOjQXqd4ed5ka14C86KV1uq+2lEo/YeVkTBEX8RPEn3Y73mF0B5lLNj1JX2ijACQtNGoDQXJ9uHCoj41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WM8872k2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63TDQaqtE1223026, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777469199; bh=NzL+K5tpagGgLWmLUg85AXHVoRlxsUaXE9qdNz60hlQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WM8872k2rPngaZdxJE5vQqDZueZoWWCD/l21bfzycgvbazdzXZIbwJEpuDwFP9PL+
	 vpYBpQwzPOcJ+ny0bYJHuMn1C9IwvJNEsdnwgoc0h95IS2Oog+Ret1s7SvfVQsGmMz
	 rwEdKquSyHi+E5LaaoOcdE4uP9AG53VTerlk1kcFbKjuokV1sGE0+H41OdIAhMUSAR
	 KZcECyyfkZ21pGz84IcMUGvol0+i8nmUEW+ha4N5tu5q6rAw4YKDHEWq1f57Cq5DOs
	 wkdYGUDm7TiL+XkaWneZFLOvy9bEXlVhmm8/eVCyT/wDD1ewTYwUHV6YYQ/X63d/dQ
	 BMX6bwHsRXiHw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63TDQaqtE1223026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:26:39 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:36 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:36 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 21:26:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 2/7] wifi: rtw89: phy: support per PHY RX statistics
Date: Wed, 29 Apr 2026 21:26:20 +0800
Message-ID: <20260429132625.1659182-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260429132625.1659182-1-pkshih@realtek.com>
References: <20260429132625.1659182-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 40BAC494C9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35621-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Kuan-Chung Chen <damon.chen@realtek.com>

Previously, RX statistics such as beacon RSSI and packet
counters were shared across all PHYs. To support MLO,
extend the statistics to be maintained per PHY.

Update the debugfs output for phy_info and beacon_info
to include a "[PHY X]" label for better clarity.

The output of phy_info:

  TP TX: 0 [0] Mbps (lv: 0), RX: 0 [0] Mbps (lv: 0)
  Avg packet length: TX=0, RX=120
  TF: 0

  [PHY 0]
  Beacon: 19 (-45 dBm)
  RX count:
     Legacy: [0, 0, 0, 0]
      ...
    EHT 2SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

The output of beacon_info:

  [PHY 0]
  Beacon: 20
  raw rssi: 131
  hw rate: 4
  length: 437

  [Beacon info]
  interval: 100
  dtim: 1

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 26 ++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  6 +-
 drivers/net/wireless/realtek/rtw89/debug.c    | 88 ++++++++++++-------
 drivers/net/wireless/realtek/rtw89/fw.c       |  6 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 17 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  5 +-
 6 files changed, 97 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 03d80d012022..81f3ae21dc18 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2736,12 +2736,14 @@ static u16 rtw89_bcn_get_histogram_bound(struct rtw89_dev *rtwdev, u8 target)
 }
 
 static u16 rtw89_bcn_get_rx_time(struct rtw89_dev *rtwdev,
-				 const struct rtw89_chan *chan)
+				 struct rtw89_vif_link *rtwvif_link)
 {
 #define RTW89_SYMBOL_TIME_2GHZ 192
 #define RTW89_SYMBOL_TIME_5GHZ 20
 #define RTW89_SYMBOL_TIME_6GHZ 20
-	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+	struct rtw89_bb_ctx *bb = rtw89_get_bb_ctx(rtwdev, rtwvif_link->phy_idx);
+	struct rtw89_pkt_stat *pkt_stat = &bb->cur_pkt_stat;
 	u16 bitrate, val;
 
 	if (!rtw89_legacy_rate_to_bitrate(rtwdev, pkt_stat->beacon_rate, &bitrate))
@@ -2772,15 +2774,15 @@ static void rtw89_bcn_calc_timeout(struct rtw89_dev *rtwdev,
 #define RTW89_BCN_TRACK_EXTEND_TIMEOUT 5
 #define RTW89_BCN_TRACK_COVERAGE_TH 0 /* unit: TU */
 #define RTW89_BCN_TRACK_STRONG_RSSI 80
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
-	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
+	struct rtw89_bb_ctx *bb = rtw89_get_bb_ctx(rtwdev, rtwvif_link->phy_idx);
 	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
 	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	struct rtw89_pkt_stat *pkt_stat = &bb->cur_pkt_stat;
 	struct rtw89_beacon_dist *bcn_dist = &bcn_stat->bcn_dist;
 	u16 outlier_high_bcn_th = bcn_track->outlier_high_bcn_th;
 	u16 outlier_low_bcn_th = bcn_track->outlier_low_bcn_th;
-	u8 rssi = ewma_rssi_read(&rtwdev->phystat.bcn_rssi);
 	u16 target_bcn_th = bcn_track->target_bcn_th;
+	u8 rssi = ewma_rssi_read(&bb->bcn_rssi);
 	u16 low_bcn_th = bcn_track->low_bcn_th;
 	u16 med_bcn_th = bcn_track->med_bcn_th;
 	u16 beacon_int = bcn_track->beacon_int;
@@ -2826,7 +2828,7 @@ static void rtw89_bcn_calc_timeout(struct rtw89_dev *rtwdev,
 	bcn_timeout = bcn_stat->drift[target_bcn_th];
 
 out:
-	bcn_track->bcn_timeout = bcn_timeout + rtw89_bcn_get_rx_time(rtwdev, chan);
+	bcn_track->bcn_timeout = bcn_timeout + rtw89_bcn_get_rx_time(rtwdev, rtwvif_link);
 }
 
 static void rtw89_bcn_update_timeout(struct rtw89_dev *rtwdev,
@@ -2987,7 +2989,6 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	struct rtw89_vif_rx_stats_iter_data *iter_data = data;
 	struct rtw89_dev *rtwdev = iter_data->rtwdev;
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
-	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
 	struct rtw89_rx_desc_info *desc_info = iter_data->desc_info;
 	struct sk_buff *skb = iter_data->skb;
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
@@ -2997,6 +2998,8 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	struct ieee80211_bss_conf *bss_conf;
 	struct rtw89_vif_link *rtwvif_link;
 	const u8 *bssid = iter_data->bssid;
+	struct rtw89_pkt_stat *pkt_stat;
+	struct rtw89_bb_ctx *bb;
 	const u8 *target_bssid;
 
 	if (rtwdev->scanning &&
@@ -3030,6 +3033,9 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 		rx_status->link_id = rtwvif_link->link_id;
 	}
 
+	bb = rtw89_get_bb_ctx(rtwdev, rtwvif_link->phy_idx);
+	pkt_stat = &bb->cur_pkt_stat;
+
 	if (ieee80211_is_beacon(hdr->frame_control)) {
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags)) {
@@ -3038,7 +3044,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 		}
 
 		if (phy_ppdu) {
-			ewma_rssi_add(&rtwdev->phystat.bcn_rssi, phy_ppdu->rssi_avg);
+			ewma_rssi_add(&bb->bcn_rssi, phy_ppdu->rssi_avg);
 			if (!test_bit(RTW89_FLAG_LOW_POWER_MODE, rtwdev->flags))
 				rtwvif_link->bcn_bw_idx = phy_ppdu->bw_idx;
 		}
@@ -4750,6 +4756,7 @@ static void rtw89_core_mlsr_link_decision(struct rtw89_dev *rtwdev,
 	struct rtw89_vif_link *rtwvif_link;
 	const struct rtw89_chan *chan;
 	unsigned long usable_links;
+	struct rtw89_bb_ctx *bb;
 	unsigned int link_id;
 	u8 rssi;
 
@@ -4759,7 +4766,8 @@ static void rtw89_core_mlsr_link_decision(struct rtw89_dev *rtwdev,
 	if (unlikely(!rtwvif_link))
 		goto select;
 
-	rssi = ewma_rssi_read(&rtwdev->phystat.bcn_rssi);
+	bb = rtw89_get_bb_ctx(rtwdev, rtwvif_link->phy_idx);
+	rssi = ewma_rssi_read(&bb->bcn_rssi);
 	if (unlikely(!rssi))
 		return;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b290da650c70..f15a0c43ef6d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5345,9 +5345,6 @@ DECLARE_EWMA(thermal, 4, 4);
 struct rtw89_phy_stat {
 	struct ewma_thermal avg_thermal[RF_PATH_MAX];
 	u8 last_thermal_max;
-	struct ewma_rssi bcn_rssi;
-	struct rtw89_pkt_stat cur_pkt_stat;
-	struct rtw89_pkt_stat last_pkt_stat;
 	struct rtw89_beacon_stat bcn_stat;
 };
 
@@ -6318,6 +6315,9 @@ struct rtw89_dev {
 		struct rtw89_dig_info dig;
 		struct rtw89_phy_ch_info ch_info;
 		struct rtw89_edcca_bak edcca_bak;
+		struct ewma_rssi bcn_rssi;
+		struct rtw89_pkt_stat cur_pkt_stat;
+		struct rtw89_pkt_stat last_pkt_stat;
 	} bbs[RTW89_PHY_NUM];
 
 	struct wiphy_delayed_work track_work;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 2cb6e441b2f8..2d953bec149b 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4051,38 +4051,20 @@ static const struct rtw89_rx_rate_cnt_info {
 	{FIRST_RATE_GEV1(EHT_NSS2_MCS0), 14, 0, "EHT 2SS:"},
 };
 
-static ssize_t rtw89_debug_priv_phy_info_get(struct rtw89_dev *rtwdev,
-					     struct rtw89_debugfs_priv *debugfs_priv,
-					     char *buf, size_t bufsz)
+static int rtw89_get_rx_pkt_stat(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
+				 char *buf, size_t bufsz)
 {
-	struct rtw89_traffic_stats *stats = &rtwdev->stats;
-	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.last_pkt_stat;
+	struct rtw89_pkt_stat *pkt_stat = &bb->last_pkt_stat;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_debugfs_iter_data iter_data;
 	const struct rtw89_rx_rate_cnt_info *info;
-	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 rssi = ewma_rssi_read(&bb->bcn_rssi);
 	char *p = buf, *end = buf + bufsz;
 	enum rtw89_hw_rate first_rate;
-	u8 rssi;
 	int i;
 
-	rssi = ewma_rssi_read(&rtwdev->phystat.bcn_rssi);
-
-	p += scnprintf(p, end - p, "TP TX: %u [%u] Mbps (lv: %d",
-		       stats->tx_throughput, stats->tx_throughput_raw,
-		       stats->tx_tfc_lv);
-	if (hal->thermal_prot_lv)
-		p += scnprintf(p, end - p, ", duty: %d%%",
-			       100 - hal->thermal_prot_lv * RTW89_THERMAL_PROT_STEP);
-	p += scnprintf(p, end - p, "), RX: %u [%u] Mbps (lv: %d)\n",
-		       stats->rx_throughput, stats->rx_throughput_raw,
-		       stats->rx_tfc_lv);
-	p += scnprintf(p, end - p, "Beacon: %u (%d dBm), TF: %u\n",
+	p += scnprintf(p, end - p, "Beacon: %u (%d dBm)\n",
 		       pkt_stat->beacon_nr,
-		       RTW89_RSSI_RAW_TO_DBM(rssi), stats->rx_tf_periodic);
-	p += scnprintf(p, end - p, "Avg packet length: TX=%u, RX=%u\n",
-		       stats->tx_avg_len,
-		       stats->rx_avg_len);
+		       RTW89_RSSI_RAW_TO_DBM(rssi));
 
 	p += scnprintf(p, end - p, "RX count:\n");
 
@@ -4103,6 +4085,39 @@ static ssize_t rtw89_debug_priv_phy_info_get(struct rtw89_dev *rtwdev,
 		p += scnprintf(p, end - p, "]\n");
 	}
 
+	return p - buf;
+}
+
+static ssize_t rtw89_debug_priv_phy_info_get(struct rtw89_dev *rtwdev,
+					     struct rtw89_debugfs_priv *debugfs_priv,
+					     char *buf, size_t bufsz)
+{
+	struct rtw89_traffic_stats *stats = &rtwdev->stats;
+	struct rtw89_debugfs_iter_data iter_data;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	char *p = buf, *end = buf + bufsz;
+	struct rtw89_bb_ctx *bb;
+
+	p += scnprintf(p, end - p, "TP TX: %u [%u] Mbps (lv: %d",
+		       stats->tx_throughput, stats->tx_throughput_raw,
+		       stats->tx_tfc_lv);
+	if (hal->thermal_prot_lv)
+		p += scnprintf(p, end - p, ", duty: %d%%",
+			       100 - hal->thermal_prot_lv * RTW89_THERMAL_PROT_STEP);
+	p += scnprintf(p, end - p, "), RX: %u [%u] Mbps (lv: %d)\n",
+		       stats->rx_throughput, stats->rx_throughput_raw,
+		       stats->rx_tfc_lv);
+	p += scnprintf(p, end - p, "Avg packet length: TX=%u, RX=%u\n",
+		       stats->tx_avg_len,
+		       stats->rx_avg_len);
+	p += scnprintf(p, end - p, "TF: %u\n", stats->rx_tf_periodic);
+
+	rtw89_for_each_active_bb(rtwdev, bb) {
+		p += scnprintf(p, end - p, "\n[PHY %u]\n", bb->phy_idx);
+		p += rtw89_get_rx_pkt_stat(rtwdev, bb, p, end - p);
+	}
+	p += scnprintf(p, end - p, "\n");
+
 	rtw89_debugfs_iter_data_setup(&iter_data, p, end - p);
 	ieee80211_iterate_stations_atomic(rtwdev->hw, rtw89_sta_info_get_iter, &iter_data);
 	p += iter_data.written_sz;
@@ -4858,12 +4873,26 @@ rtw89_debug_priv_diag_mac_get(struct rtw89_dev *rtwdev,
 	return rtw89_mac_diag_iter_all(rtwdev, buf, bufsz);
 }
 
+static int rtw89_get_beacon_info(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
+				 char *buf, size_t bufsz)
+{
+	struct rtw89_pkt_stat *pkt_stat = &bb->last_pkt_stat;
+	char *p = buf, *end = buf + bufsz;
+
+	p += scnprintf(p, end - p, "[PHY %u]\n", bb->phy_idx);
+	p += scnprintf(p, end - p, "Beacon: %u\n", pkt_stat->beacon_nr);
+	p += scnprintf(p, end - p, "raw rssi: %lu\n", ewma_rssi_read(&bb->bcn_rssi));
+	p += scnprintf(p, end - p, "hw rate: %u\n", pkt_stat->beacon_rate);
+	p += scnprintf(p, end - p, "length: %u\n\n", pkt_stat->beacon_len);
+
+	return p - buf;
+}
+
 static ssize_t
 rtw89_debug_priv_beacon_info_get(struct rtw89_dev *rtwdev,
 				 struct rtw89_debugfs_priv *debugfs_priv,
 				 char *buf, size_t bufsz)
 {
-	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.last_pkt_stat;
 	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
 	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
 	struct rtw89_beacon_dist *bcn_dist = &bcn_stat->bcn_dist;
@@ -4871,17 +4900,16 @@ rtw89_debug_priv_beacon_info_get(struct rtw89_dev *rtwdev,
 	char *p = buf, *end = buf + bufsz;
 	u16 *drift = bcn_stat->drift;
 	u8 bcn_num = bcn_stat->num;
+	struct rtw89_bb_ctx *bb;
 	u8 count;
 	u8 i;
 
+	rtw89_for_each_active_bb(rtwdev, bb)
+		p += rtw89_get_beacon_info(rtwdev, bb, p, end - p);
+
 	p += scnprintf(p, end - p, "[Beacon info]\n");
-	p += scnprintf(p, end - p, "count: %u\n", pkt_stat->beacon_nr);
 	p += scnprintf(p, end - p, "interval: %u\n", bcn_track->beacon_int);
 	p += scnprintf(p, end - p, "dtim: %u\n", bcn_track->dtim);
-	p += scnprintf(p, end - p, "raw rssi: %lu\n",
-		       ewma_rssi_read(&rtwdev->phystat.bcn_rssi));
-	p += scnprintf(p, end - p, "hw rate: %u\n", pkt_stat->beacon_rate);
-	p += scnprintf(p, end - p, "length: %u\n", pkt_stat->beacon_len);
 
 	p += scnprintf(p, end - p, "\n[Distribution]\n");
 	p += scnprintf(p, end - p, "tbtt\n");
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b5d2540cf212..2a3662ed733f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3223,14 +3223,15 @@ int rtw89_fw_h2c_lps_ml_cmn_info(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif)
 {
 	const struct rtw89_phy_bb_gain_info_be *gain = &rtwdev->bb_gain.be;
-	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
 	static const u8 bcn_bw_ofst[] = {0, 0, 0, 3, 6, 9, 0, 12};
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw89_h2c_lps_ml_cmn_info *h2c;
 	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_pkt_stat *pkt_stat;
 	const struct rtw89_chan *chan;
 	u8 bw_idx = RTW89_BB_BW_20_40;
+	struct rtw89_bb_ctx *bb;
 	u32 len = sizeof(*h2c);
 	unsigned int link_id;
 	struct sk_buff *skb;
@@ -3261,11 +3262,14 @@ int rtw89_fw_h2c_lps_ml_cmn_info(struct rtw89_dev *rtwdev,
 		path = rtwvif_link->phy_idx == RTW89_PHY_1 ? RF_PATH_B : RF_PATH_A;
 		chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 		gain_band = rtw89_subband_to_gain_band_be(chan->subband_type);
+		bb = rtw89_get_bb_ctx(rtwdev, rtwvif_link->phy_idx);
 
 		h2c->central_ch[rtwvif_link->phy_idx] = chan->channel;
 		h2c->pri_ch[rtwvif_link->phy_idx] = chan->primary_channel;
 		h2c->band[rtwvif_link->phy_idx] = chan->band_type;
 		h2c->bw[rtwvif_link->phy_idx] = chan->band_width;
+
+		pkt_stat = &bb->cur_pkt_stat;
 		if (pkt_stat->beacon_rate < RTW89_HW_RATE_OFDM6)
 			h2c->bcn_rate_type[rtwvif_link->phy_idx] = 0x1;
 		else
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 95b5ace2a27e..29770cc5ea60 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5814,6 +5814,7 @@ static void rtw89_phy_stat_rssi_update(struct rtw89_dev *rtwdev)
 static void rtw89_phy_stat_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_phy_stat *phystat = &rtwdev->phystat;
+	struct rtw89_bb_ctx *bb;
 	int i;
 
 	for (i = 0; i < rtwdev->chip->rf_path_num; i++)
@@ -5821,24 +5822,28 @@ static void rtw89_phy_stat_init(struct rtw89_dev *rtwdev)
 
 	rtw89_phy_stat_thermal_update(rtwdev);
 
-	memset(&phystat->cur_pkt_stat, 0, sizeof(phystat->cur_pkt_stat));
-	memset(&phystat->last_pkt_stat, 0, sizeof(phystat->last_pkt_stat));
+	rtw89_for_each_capab_bb(rtwdev, bb) {
+		memset(&bb->cur_pkt_stat, 0, sizeof(bb->cur_pkt_stat));
+		memset(&bb->last_pkt_stat, 0, sizeof(bb->last_pkt_stat));
 
-	ewma_rssi_init(&phystat->bcn_rssi);
+		ewma_rssi_init(&bb->bcn_rssi);
+	}
 
 	rtwdev->hal.thermal_prot_lv = 0;
 }
 
 void rtw89_phy_stat_track(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_phy_stat *phystat = &rtwdev->phystat;
+	struct rtw89_bb_ctx *bb;
 
 	rtw89_phy_stat_thermal_update(rtwdev);
 	rtw89_phy_thermal_protect(rtwdev);
 	rtw89_phy_stat_rssi_update(rtwdev);
 
-	phystat->last_pkt_stat = phystat->cur_pkt_stat;
-	memset(&phystat->cur_pkt_stat, 0, sizeof(phystat->cur_pkt_stat));
+	rtw89_for_each_active_bb(rtwdev, bb) {
+		bb->last_pkt_stat = bb->cur_pkt_stat;
+		memset(&bb->cur_pkt_stat, 0, sizeof(bb->cur_pkt_stat));
+	}
 }
 
 static u16 rtw89_phy_ccx_us_to_idx(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 9cd4c88ee57e..b81eeb59be60 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2158,13 +2158,14 @@ static void rtw8852a_query_ppdu(struct rtw89_dev *rtwdev,
 				struct rtw89_rx_phy_ppdu *phy_ppdu,
 				struct ieee80211_rx_status *status)
 {
-	u8 path;
+	struct rtw89_bb_ctx *bb = rtw89_get_bb_ctx(rtwdev, phy_ppdu->phy_idx);
 	u8 *rx_power = phy_ppdu->rssi;
+	u8 path;
 	u8 raw;
 
 	if (!status->signal) {
 		if (phy_ppdu->to_self)
-			raw = ewma_rssi_read(&rtwdev->phystat.bcn_rssi);
+			raw = ewma_rssi_read(&bb->bcn_rssi);
 		else
 			raw = max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]);
 
-- 
2.25.1


