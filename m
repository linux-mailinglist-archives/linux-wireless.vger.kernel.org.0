Return-Path: <linux-wireless+bounces-24706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9291EAEEFDD
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 09:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7B2179845
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 07:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D4E51022;
	Tue,  1 Jul 2025 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dsVWSOH0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD31C5D6A
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355531; cv=none; b=rAPtButAi/l6E8PvrcDFIY9+q0FDhOik+Jare+g3mgBpZj935K90MnqWGo2YAX9w6PMY2kQLS+1ZL/UbVsLkcH65Sl7u5w2WoN7JGQpPy1dF8l2iR6+5uF/j9WeaT0F4ozFxsbPaHDUNDygy4FDIyoQqzrluncRtrB/OM9W5phc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355531; c=relaxed/simple;
	bh=qTx6lpK9Gk7hiK/Wsn9a8Mk3Mx8ou/JNxUzsXosHMxU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQIQSeTYj5945WpZWF5sv9p5X+uVHx2HnBGanAQU48dUKFOrceKAUnULXy+vdgfJTJB3FVpouy17natpYXjHaUWQHL3COTCV5Cp9KsL5BGf/e3LCr1oHMFAd5ibmsDsvd5kvcIVEs7KpfZveVlSw5R9Bae+V2/eZ0vWtUoDtQTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dsVWSOH0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5617ciCeB2673984, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751355524; bh=urSQzAsR0FsaWyGRBxtXOml86C66AeYGZb/dAhEfPZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=dsVWSOH0rIC3BftVgpoT+H0PrHLllCcJdDOzEtLOt0xWLzYvHhBPc5V8ITvyiJw6I
	 56s28qfLGKv9ThtbioA0R4NpaOOJggrkOiDfeVvNSo+LIg+r4WvumPWt7/S9eJh1Xj
	 PQnxhv03rl9kZEx4BIaa/e2zTbx5OnuyibcTN4l/JmBuvYKJNB1W7oZ3F8FVPnfXfB
	 gf3jdi9n6WjuV71aji5mMprclFFmtiQmq3V++nIQ3S5SKVSmNL3hCo/l9m6UZQnBdc
	 cf/8eSqbZJ4Ew/kyUfSoU9vOk7ZmIRhotFCIX/trY0vv36BDDBwd9O2ITspkMBovc7
	 H5Wsm7rQ3TuoQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5617ciCeB2673984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 1 Jul 2025 15:38:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Jul 2025 15:39:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 1 Jul
 2025 15:39:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH v2 rtw-next] wifi: rtw89: enter power save mode aggressively
Date: Tue, 1 Jul 2025 15:38:39 +0800
Message-ID: <20250701073839.31905-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chin-Yen Lee <timlee@realtek.com>

Currently the driver allows the WiFi chip enter power save mode
by checking the transmitting and receiving traffic is very low
per two seconds. But it's hard for some applications to enter
power save mode, like video streaming, which sends burst traffic
regularly for other side to buffer and only send little traffic
at most time. So adjust the criteria to enter power save while
lower than 10Mbps and check it per 100ms. Thus WiFi chip could
reduce power consumption under these applications.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - consider checking interval (100ms) to determine traffic level.
    Otherwise, use unexpected level.
---
 drivers/net/wireless/realtek/rtw89/core.c     | 110 +++++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h     |  20 +++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   3 +
 drivers/net/wireless/realtek/rtw89/ser.c      |   3 +
 drivers/net/wireless/realtek/rtw89/wow.c      |   2 +-
 drivers/net/wireless/realtek/rtw89/wow.h      |  14 ++-
 6 files changed, 123 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1f5639a5d166..ae4e8233be69 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -319,15 +319,25 @@ static const struct ieee80211_supported_band rtw89_sband_6ghz = {
 	.n_bitrates	= ARRAY_SIZE(rtw89_bitrates) - 4,
 };
 
+static void __rtw89_traffic_stats_accu(struct rtw89_traffic_stats *stats,
+				       struct sk_buff *skb, bool tx)
+{
+	if (tx) {
+		stats->tx_cnt++;
+		stats->tx_unicast += skb->len;
+	} else {
+		stats->rx_cnt++;
+		stats->rx_unicast += skb->len;
+	}
+}
+
 static void rtw89_traffic_stats_accu(struct rtw89_dev *rtwdev,
-				     struct rtw89_traffic_stats *stats,
-				     struct sk_buff *skb, bool tx)
+				     struct rtw89_vif *rtwvif,
+				     struct sk_buff *skb,
+				     bool accu_dev, bool tx)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
-	if (tx && ieee80211_is_assoc_req(hdr->frame_control))
-		rtw89_wow_parse_akm(rtwdev, skb);
-
 	if (!ieee80211_is_data(hdr->frame_control))
 		return;
 
@@ -335,12 +345,12 @@ static void rtw89_traffic_stats_accu(struct rtw89_dev *rtwdev,
 	    is_multicast_ether_addr(hdr->addr1))
 		return;
 
-	if (tx) {
-		stats->tx_cnt++;
-		stats->tx_unicast += skb->len;
-	} else {
-		stats->rx_cnt++;
-		stats->rx_unicast += skb->len;
+	if (accu_dev)
+		__rtw89_traffic_stats_accu(&rtwdev->stats, skb, tx);
+
+	if (rtwvif) {
+		__rtw89_traffic_stats_accu(&rtwvif->stats, skb, tx);
+		__rtw89_traffic_stats_accu(&rtwvif->stats_ps, skb, tx);
 	}
 }
 
@@ -1150,8 +1160,8 @@ static int rtw89_core_tx_write_link(struct rtw89_dev *rtwdev,
 	tx_req.rtwsta_link = rtwsta_link;
 	tx_req.desc_info.sw_mld = sw_mld;
 
-	rtw89_traffic_stats_accu(rtwdev, &rtwdev->stats, skb, true);
-	rtw89_traffic_stats_accu(rtwdev, &rtwvif->stats, skb, true);
+	rtw89_traffic_stats_accu(rtwdev, rtwvif, skb, true, true);
+	rtw89_wow_parse_akm(rtwdev, skb);
 	rtw89_core_tx_update_desc_info(rtwdev, &tx_req);
 	rtw89_core_tx_wake(rtwdev, &tx_req);
 
@@ -2267,7 +2277,7 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	if (desc_info->data_rate < RTW89_HW_RATE_NR)
 		pkt_stat->rx_rate_cnt[desc_info->data_rate]++;
 
-	rtw89_traffic_stats_accu(rtwdev, &rtwvif->stats, skb, false);
+	rtw89_traffic_stats_accu(rtwdev, rtwvif, skb, false, false);
 
 out:
 	rcu_read_unlock();
@@ -2280,7 +2290,7 @@ static void rtw89_core_rx_stats(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_vif_rx_stats_iter_data iter_data;
 
-	rtw89_traffic_stats_accu(rtwdev, &rtwdev->stats, skb, false);
+	rtw89_traffic_stats_accu(rtwdev, NULL, skb, true, false);
 
 	iter_data.rtwdev = rtwdev;
 	iter_data.phy_ppdu = phy_ppdu;
@@ -3567,9 +3577,22 @@ void rtw89_roc_work(struct wiphy *wiphy, struct wiphy_work *work)
 }
 
 static enum rtw89_tfc_lv rtw89_get_traffic_level(struct rtw89_dev *rtwdev,
-						 u32 throughput, u64 cnt)
+						 u32 throughput, u64 cnt,
+						 enum rtw89_tfc_interval interval)
 {
-	if (cnt < 100)
+	u64 cnt_level;
+
+	switch (interval) {
+	default:
+	case RTW89_TFC_INTERVAL_100MS:
+		cnt_level = 5;
+		break;
+	case RTW89_TFC_INTERVAL_2SEC:
+		cnt_level = 100;
+		break;
+	}
+
+	if (cnt < cnt_level)
 		return RTW89_TFC_IDLE;
 	if (throughput > 50)
 		return RTW89_TFC_HIGH;
@@ -3581,13 +3604,14 @@ static enum rtw89_tfc_lv rtw89_get_traffic_level(struct rtw89_dev *rtwdev,
 }
 
 static bool rtw89_traffic_stats_calc(struct rtw89_dev *rtwdev,
-				     struct rtw89_traffic_stats *stats)
+				     struct rtw89_traffic_stats *stats,
+				     enum rtw89_tfc_interval interval)
 {
 	enum rtw89_tfc_lv tx_tfc_lv = stats->tx_tfc_lv;
 	enum rtw89_tfc_lv rx_tfc_lv = stats->rx_tfc_lv;
 
-	stats->tx_throughput_raw = (u32)(stats->tx_unicast >> RTW89_TP_SHIFT);
-	stats->rx_throughput_raw = (u32)(stats->rx_unicast >> RTW89_TP_SHIFT);
+	stats->tx_throughput_raw = rtw89_bytes_to_mbps(stats->tx_unicast, interval);
+	stats->rx_throughput_raw = rtw89_bytes_to_mbps(stats->rx_unicast, interval);
 
 	ewma_tp_add(&stats->tx_ewma_tp, stats->tx_throughput_raw);
 	ewma_tp_add(&stats->rx_ewma_tp, stats->rx_throughput_raw);
@@ -3595,9 +3619,9 @@ static bool rtw89_traffic_stats_calc(struct rtw89_dev *rtwdev,
 	stats->tx_throughput = ewma_tp_read(&stats->tx_ewma_tp);
 	stats->rx_throughput = ewma_tp_read(&stats->rx_ewma_tp);
 	stats->tx_tfc_lv = rtw89_get_traffic_level(rtwdev, stats->tx_throughput,
-						   stats->tx_cnt);
+						   stats->tx_cnt, interval);
 	stats->rx_tfc_lv = rtw89_get_traffic_level(rtwdev, stats->rx_throughput,
-						   stats->rx_cnt);
+						   stats->rx_cnt, interval);
 	stats->tx_avg_len = stats->tx_cnt ?
 			    DIV_ROUND_DOWN_ULL(stats->tx_unicast, stats->tx_cnt) : 0;
 	stats->rx_avg_len = stats->rx_cnt ?
@@ -3623,10 +3647,12 @@ static bool rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
 	unsigned int link_id;
 	bool tfc_changed;
 
-	tfc_changed = rtw89_traffic_stats_calc(rtwdev, &rtwdev->stats);
+	tfc_changed = rtw89_traffic_stats_calc(rtwdev, &rtwdev->stats,
+					       RTW89_TFC_INTERVAL_2SEC);
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		rtw89_traffic_stats_calc(rtwdev, &rtwvif->stats);
+		rtw89_traffic_stats_calc(rtwdev, &rtwvif->stats,
+					 RTW89_TFC_INTERVAL_2SEC);
 
 		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
 			rtw89_fw_h2c_tp_offload(rtwdev, rtwvif_link);
@@ -3646,8 +3672,8 @@ static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
 		if (rtwvif->offchan)
 			continue;
 
-		if (rtwvif->stats.tx_tfc_lv != RTW89_TFC_IDLE ||
-		    rtwvif->stats.rx_tfc_lv != RTW89_TFC_IDLE)
+		if (rtwvif->stats_ps.tx_tfc_lv >= RTW89_TFC_MID ||
+		    rtwvif->stats_ps.rx_tfc_lv >= RTW89_TFC_MID)
 			continue;
 
 		vif = rtwvif_to_vif(rtwvif);
@@ -3786,6 +3812,34 @@ static void rtw89_core_mlo_track(struct rtw89_dev *rtwdev)
 	}
 }
 
+static void rtw89_track_ps_work(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
+						track_ps_work.work);
+	struct rtw89_vif *rtwvif;
+
+	lockdep_assert_wiphy(wiphy);
+
+	if (test_bit(RTW89_FLAG_FORBIDDEN_TRACK_WORK, rtwdev->flags))
+		return;
+
+	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
+		return;
+
+	wiphy_delayed_work_queue(wiphy, &rtwdev->track_ps_work,
+				 RTW89_TRACK_PS_WORK_PERIOD);
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_traffic_stats_calc(rtwdev, &rtwvif->stats_ps,
+					 RTW89_TFC_INTERVAL_100MS);
+
+	if (rtwdev->scanning)
+		return;
+
+	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
+		rtw89_enter_lps_track(rtwdev);
+}
+
 static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
@@ -4872,6 +4926,8 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 
 	wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->track_work,
 				 RTW89_TRACK_WORK_PERIOD);
+	wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->track_ps_work,
+				 RTW89_TRACK_PS_WORK_PERIOD);
 
 	set_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
 
@@ -4906,6 +4962,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	wiphy_work_cancel(wiphy, &btc->icmp_notify_work);
 	cancel_delayed_work_sync(&rtwdev->txq_reinvoke_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->track_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->track_ps_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->chanctx_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_act1_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_bt_devinfo_work);
@@ -5133,6 +5190,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
 	wiphy_delayed_work_init(&rtwdev->track_work, rtw89_track_work);
+	wiphy_delayed_work_init(&rtwdev->track_ps_work, rtw89_track_ps_work);
 	wiphy_delayed_work_init(&rtwdev->chanctx_work, rtw89_chanctx_work);
 	wiphy_delayed_work_init(&rtwdev->coex_act1_work, rtw89_coex_act1_work);
 	wiphy_delayed_work_init(&rtwdev->coex_bt_devinfo_work, rtw89_coex_bt_devinfo_work);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cdacf100a59a..7237b712ef34 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -40,6 +40,7 @@ extern const struct ieee80211_ops rtw89_ops;
 #define BYPASS_CR_DATA 0xbabecafe
 
 #define RTW89_TRACK_WORK_PERIOD	round_jiffies_relative(HZ * 2)
+#define RTW89_TRACK_PS_WORK_PERIOD msecs_to_jiffies(100)
 #define RTW89_FORBID_BA_TIMER round_jiffies_relative(HZ * 4)
 #define CFO_TRACK_MAX_USER 64
 #define MAX_RSSI 110
@@ -1381,6 +1382,11 @@ struct rtw89_btc_wl_smap {
 	u32 emlsr: 1;
 };
 
+enum rtw89_tfc_interval {
+	RTW89_TFC_INTERVAL_100MS,
+	RTW89_TFC_INTERVAL_2SEC,
+};
+
 enum rtw89_tfc_lv {
 	RTW89_TFC_IDLE,
 	RTW89_TFC_ULTRA_LOW,
@@ -1389,7 +1395,6 @@ enum rtw89_tfc_lv {
 	RTW89_TFC_HIGH,
 };
 
-#define RTW89_TP_SHIFT 18 /* bytes/2s --> Mbps */
 DECLARE_EWMA(tp, 10, 2);
 
 struct rtw89_traffic_stats {
@@ -5929,6 +5934,7 @@ struct rtw89_dev {
 	} bbs[RTW89_PHY_NUM];
 
 	struct wiphy_delayed_work track_work;
+	struct wiphy_delayed_work track_ps_work;
 	struct wiphy_delayed_work chanctx_work;
 	struct wiphy_delayed_work coex_act1_work;
 	struct wiphy_delayed_work coex_bt_devinfo_work;
@@ -5979,6 +5985,7 @@ struct rtw89_vif {
 	__be32 ip_addr;
 
 	struct rtw89_traffic_stats stats;
+	struct rtw89_traffic_stats stats_ps;
 	u32 tdls_peer;
 
 	struct ieee80211_scan_ies *scan_ies;
@@ -7291,6 +7298,17 @@ static inline bool rtw89_is_rtl885xb(struct rtw89_dev *rtwdev)
 	return false;
 }
 
+static inline u32 rtw89_bytes_to_mbps(u64 bytes, enum rtw89_tfc_interval interval)
+{
+	switch (interval) {
+	default:
+	case RTW89_TFC_INTERVAL_2SEC:
+		return bytes >> 18; /* bytes/2s --> Mbps */;
+	case RTW89_TFC_INTERVAL_100MS:
+		return (bytes * 10) >> 17; /* bytes/100ms --> Mbps */
+	}
+}
+
 int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel);
 int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a3ae1e654a98..c982ad633b4a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1772,6 +1772,7 @@ static int rtw89_ops_suspend(struct ieee80211_hw *hw,
 
 	set_bit(RTW89_FLAG_FORBIDDEN_TRACK_WORK, rtwdev->flags);
 	wiphy_delayed_work_cancel(hw->wiphy, &rtwdev->track_work);
+	wiphy_delayed_work_cancel(hw->wiphy, &rtwdev->track_ps_work);
 
 	ret = rtw89_wow_suspend(rtwdev, wowlan);
 	if (ret) {
@@ -1797,6 +1798,8 @@ static int rtw89_ops_resume(struct ieee80211_hw *hw)
 	clear_bit(RTW89_FLAG_FORBIDDEN_TRACK_WORK, rtwdev->flags);
 	wiphy_delayed_work_queue(hw->wiphy, &rtwdev->track_work,
 				 RTW89_TRACK_WORK_PERIOD);
+	wiphy_delayed_work_queue(hw->wiphy, &rtwdev->track_ps_work,
+				 RTW89_TRACK_PS_WORK_PERIOD);
 
 	return ret ? 1 : 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index d504518b8a57..bb39fdbcba0d 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -492,6 +492,7 @@ static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 	case SER_EV_STATE_IN:
 		wiphy_lock(wiphy);
 		wiphy_delayed_work_cancel(wiphy, &rtwdev->track_work);
+		wiphy_delayed_work_cancel(wiphy, &rtwdev->track_ps_work);
 		wiphy_unlock(wiphy);
 		drv_stop_tx(ser);
 
@@ -525,6 +526,8 @@ static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 		drv_resume_tx(ser);
 		wiphy_delayed_work_queue(wiphy, &rtwdev->track_work,
 					 RTW89_TRACK_WORK_PERIOD);
+		wiphy_delayed_work_queue(wiphy, &rtwdev->track_ps_work,
+					 RTW89_TRACK_PS_WORK_PERIOD);
 		break;
 
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 34a0ab49bd7a..c935d6683d83 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -12,7 +12,7 @@
 #include "util.h"
 #include "wow.h"
 
-void rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb)
+void __rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
diff --git a/drivers/net/wireless/realtek/rtw89/wow.h b/drivers/net/wireless/realtek/rtw89/wow.h
index f91991e8f2e3..6606528d31c7 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.h
+++ b/drivers/net/wireless/realtek/rtw89/wow.h
@@ -116,9 +116,21 @@ static inline bool rtw_wow_has_mgd_features(struct rtw89_dev *rtwdev)
 	return !bitmap_empty(rtw_wow->flags, RTW89_WOW_FLAG_NUM);
 }
 
+void __rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb);
+
+static inline
+void rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+	if (likely(!ieee80211_is_assoc_req(hdr->frame_control)))
+		return;
+
+	__rtw89_wow_parse_akm(rtwdev, skb);
+}
+
 int rtw89_wow_suspend(struct rtw89_dev *rtwdev, struct cfg80211_wowlan *wowlan);
 int rtw89_wow_resume(struct rtw89_dev *rtwdev);
-void rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb);
 #else
 static inline
 void rtw89_wow_parse_akm(struct rtw89_dev *rtwdev, struct sk_buff *skb)
-- 
2.25.1


