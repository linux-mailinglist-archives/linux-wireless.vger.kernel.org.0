Return-Path: <linux-wireless+bounces-26254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150BCB208FA
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028903B2599
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B376154423;
	Mon, 11 Aug 2025 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iQVJF/n6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C925D558
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915929; cv=none; b=mpK9rbGJwoTq7OmSYvABfLf3rzIZ/pmwhlUFS9D4kP8RRtBOUABlH3MIUoDp59L6/SoTjHIsI5IQtKvybwVaO14nwC51H9KkiDYPYjXpBTkvjjS0FEpROMVk0ZUVYZdaKDbSL+hSC32p0Gh0s847q/CL1ecc7Z8cTOUl0ByUvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915929; c=relaxed/simple;
	bh=liMLymJVLS2dHfO9Q/rjLvLam2yic5j5cF/RJEGZnqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8JS3FJE6YRhMZgO7iPl28Gg45OncfKlfvyTRo2Ajx+mD0bGqjcUySWFRwFCWD7Qnd9/4qoyz1eHJdQ7iS6W+5LzMy8QU5xQNSnfav3nrj0b25teAiZkIOWg02POfJxsK11tACpfdJhK1dDygczIhCovaypHFmI5sSajzNT2yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iQVJF/n6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57BCcfcY7073199, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754915922; bh=X98QZ4d9Fyrfgf32MMSfVrTKqxTZWx8Kkyy0zItauEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iQVJF/n6KyyoxBbDOgH2SOO9wQg3Cffji9K1v7IGO3Kq55zo9XPoW+w5qrxk7Kh/7
	 +f/KqO1qm6dSkIWxufTSJYAwtm0/oOphcrduCdIM4qxIysqsUo8ZoFZCJytih9xHZW
	 NpMcQVBSh1gFn3Pq7pGD52KWskC7Y1MiAS6cgtN8bDzkZKhAIs2BtFRNM/dVEwQmtw
	 bkqGfvzRgxVn0Fvt+MOGfPimb/Lqzqaznlm7/A2H/I8UfRUkaNVzr7D5YmDdPZoTHE
	 Ao90ilXced1JiawAuQj/HwVk9QfVd2f25hoF9c0E6uaKkEd6ZITBDxa4VRmFBlyUpb
	 NsoomKx/86yug==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57BCcfcY7073199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 20:38:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 20:38:41 +0800
Received: from [127.0.1.1] (10.22.225.179) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 Aug
 2025 20:38:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 1/8] wifi: rtw89: introduce beacon tracking to improve connection stability
Date: Mon, 11 Aug 2025 20:37:37 +0800
Message-ID: <20250811123744.15361-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811123744.15361-1-pkshih@realtek.com>
References: <20250811123744.15361-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Kuan-Chung Chen <damon.chen@realtek.com>

In ideal scenario, AP's beacon should transmit at the Target Beacon
Transmission Time (TBTT). However, in practice, beacon may be slightly
off-schedule. This beacon "drift" prevents the firmware from receiving
beacon at the expected TBTT, leading to connection disruptions.

To address this, we introduce beacon tracking mechanism to enhance overall
connection stability. This mechanism executes the following steps in each
cycle (2 seconds): 1) Based on the last 32 received beacons, compute the
minimum TBTT offset to use for the next cycle 2) Using the same 32 beacons,
calculate the drift of each. A histogram is plotted, and outliers are
identified using a boxplot. 3) According to the statistical results from
the second step, a maximum receive window size (beacon timeout) is selected
to cover approximately 80% of the beacons and applied to the next cycle.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 457 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  50 ++-
 drivers/net/wireless/realtek/rtw89/fw.c   |  90 +++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  27 ++
 drivers/net/wireless/realtek/rtw89/mac.c  |  22 --
 drivers/net/wireless/realtek/rtw89/phy.c  |   2 +-
 drivers/net/wireless/realtek/rtw89/ps.c   |   3 +
 7 files changed, 619 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 57590f5577a3..7d522031dfa1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 #include <linux/ip.h>
+#include <linux/sort.h>
 #include <linux/udp.h>
 
 #include "cam.h"
@@ -272,17 +273,18 @@ rtw89_get_6ghz_span(struct rtw89_dev *rtwdev, u32 center_freq)
 	return NULL;
 }
 
-bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate)
+bool rtw89_legacy_rate_to_bitrate(struct rtw89_dev *rtwdev, u8 legacy_rate, u16 *bitrate)
 {
-	struct ieee80211_rate rate;
+	const struct ieee80211_rate *rate;
 
-	if (unlikely(rpt_rate >= ARRAY_SIZE(rtw89_bitrates))) {
-		rtw89_debug(rtwdev, RTW89_DBG_UNEXP, "invalid rpt rate %d\n", rpt_rate);
+	if (unlikely(legacy_rate >= ARRAY_SIZE(rtw89_bitrates))) {
+		rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
+			    "invalid legacy rate %d\n", legacy_rate);
 		return false;
 	}
 
-	rate = rtw89_bitrates[rpt_rate];
-	*bitrate = rate.bitrate;
+	rate = &rtw89_bitrates[legacy_rate];
+	*bitrate = rate->bitrate;
 
 	return true;
 }
@@ -2221,6 +2223,435 @@ static void rtw89_vif_sync_bcn_tsf(struct rtw89_vif_link *rtwvif_link,
 	WRITE_ONCE(rtwvif_link->sync_bcn_tsf, le64_to_cpu(mgmt->u.beacon.timestamp));
 }
 
+static u32 rtw89_bcn_calc_min_tbtt(struct rtw89_dev *rtwdev, u32 tbtt1, u32 tbtt2)
+{
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	u32 close_bcn_intvl_th = bcn_track->close_bcn_intvl_th;
+	u32 tbtt_diff_th = bcn_track->tbtt_diff_th;
+
+	if (tbtt2 > tbtt1)
+		swap(tbtt1, tbtt2);
+
+	if (tbtt1 - tbtt2 > tbtt_diff_th)
+		return tbtt1;
+	else if (tbtt2 > close_bcn_intvl_th)
+		return tbtt2;
+	else if (tbtt1 > close_bcn_intvl_th)
+		return tbtt1;
+	else
+		return tbtt2;
+}
+
+static void rtw89_bcn_cfg_tbtt_offset(struct rtw89_dev *rtwdev,
+				      struct rtw89_vif_link *rtwvif_link)
+{
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	u32 offset = bcn_track->tbtt_offset;
+
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
+		const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+		const struct rtw89_port_reg *p = mac->port_base;
+		u32 bcnspc, val;
+
+		bcnspc = rtw89_read32_port_mask(rtwdev, rtwvif_link,
+						p->bcn_space, B_AX_BCN_SPACE_MASK);
+		val = bcnspc - (offset / 1024);
+		val = u32_encode_bits(val, B_AX_TBTT_SHIFT_OFST_MAG) |
+				      B_AX_TBTT_SHIFT_OFST_SIGN;
+
+		rtw89_write16_port_mask(rtwdev, rtwvif_link, p->tbtt_shift,
+					B_AX_TBTT_SHIFT_OFST_MASK, val);
+
+		return;
+	}
+
+	rtw89_fw_h2c_tbtt_tuning(rtwdev, rtwvif_link, offset);
+}
+
+static void rtw89_bcn_update_tbtt_offset(struct rtw89_dev *rtwdev,
+					 struct rtw89_vif_link *rtwvif_link)
+{
+	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	u32 *tbtt_us = bcn_stat->tbtt_us;
+	u32 offset = tbtt_us[0];
+	u8 i;
+
+	for (i = 1; i < RTW89_BCN_TRACK_STAT_NR; i++)
+		offset = rtw89_bcn_calc_min_tbtt(rtwdev, tbtt_us[i], offset);
+
+	if (bcn_track->tbtt_offset == offset)
+		return;
+
+	bcn_track->tbtt_offset = offset;
+	rtw89_bcn_cfg_tbtt_offset(rtwdev, rtwvif_link);
+}
+
+static int cmp_u16(const void *a, const void *b)
+{
+	return *(const u16 *)a - *(const u16 *)b;
+}
+
+static u16 _rtw89_bcn_calc_drift(u16 tbtt, u16 offset, u16 beacon_int)
+{
+	if (tbtt < offset)
+		return beacon_int - offset + tbtt;
+
+	return tbtt - offset;
+}
+
+static void rtw89_bcn_calc_drift(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	u16 offset_tu = bcn_track->tbtt_offset / 1024;
+	u16 *tbtt_tu = bcn_stat->tbtt_tu;
+	u16 *drift = bcn_stat->drift;
+	u8 i;
+
+	bcn_stat->tbtt_tu_min = U16_MAX;
+	bcn_stat->tbtt_tu_max = 0;
+	for (i = 0; i < RTW89_BCN_TRACK_STAT_NR; i++) {
+		drift[i] = _rtw89_bcn_calc_drift(tbtt_tu[i], offset_tu,
+						 bcn_track->beacon_int);
+
+		bcn_stat->tbtt_tu_min = min(bcn_stat->tbtt_tu_min, tbtt_tu[i]);
+		bcn_stat->tbtt_tu_max = max(bcn_stat->tbtt_tu_max, tbtt_tu[i]);
+	}
+
+	sort(drift, RTW89_BCN_TRACK_STAT_NR, sizeof(*drift), cmp_u16, NULL);
+}
+
+static void rtw89_bcn_calc_distribution(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
+	struct rtw89_beacon_dist *bcn_dist = &bcn_stat->bcn_dist;
+	u16 lower_bound, upper_bound, outlier_count = 0;
+	u16 *drift = bcn_stat->drift;
+	u16 *bins = bcn_dist->bins;
+	u16 q1, q3, iqr, tmp;
+	u8 i;
+
+	BUILD_BUG_ON(RTW89_BCN_TRACK_STAT_NR % 4 != 0);
+
+	memset(bcn_dist, 0, sizeof(*bcn_dist));
+
+	bcn_dist->min = drift[0];
+	bcn_dist->max = drift[RTW89_BCN_TRACK_STAT_NR - 1];
+
+	tmp = RTW89_BCN_TRACK_STAT_NR / 4;
+	q1 = ((drift[tmp] + drift[tmp - 1]) * RTW89_BCN_TRACK_SCALE_FACTOR) / 2;
+
+	tmp = (RTW89_BCN_TRACK_STAT_NR * 3) / 4;
+	q3 = ((drift[tmp] + drift[tmp - 1]) * RTW89_BCN_TRACK_SCALE_FACTOR) / 2;
+
+	iqr = q3 - q1;
+	tmp = (3 * iqr) / 2;
+
+	if (bcn_dist->min <= 5)
+		lower_bound = bcn_dist->min;
+	else if (q1 > tmp)
+		lower_bound = (q1 - tmp) / RTW89_BCN_TRACK_SCALE_FACTOR;
+	else
+		lower_bound = 0;
+
+	upper_bound = (q3 + tmp) / RTW89_BCN_TRACK_SCALE_FACTOR;
+
+	for (i = 0; i < RTW89_BCN_TRACK_STAT_NR; i++) {
+		u16 tbtt = bcn_stat->tbtt_tu[i];
+		u16 min = bcn_stat->tbtt_tu_min;
+		u8 bin_idx;
+
+		/* histogram */
+		bin_idx = min((tbtt - min) / RTW89_BCN_TRACK_BIN_WIDTH,
+			      RTW89_BCN_TRACK_MAX_BIN_NUM - 1);
+		bins[bin_idx]++;
+
+		/* boxplot outlier */
+		if (drift[i] < lower_bound || drift[i] > upper_bound)
+			outlier_count++;
+	}
+
+	bcn_dist->outlier_count = outlier_count;
+	bcn_dist->lower_bound = lower_bound;
+	bcn_dist->upper_bound = upper_bound;
+}
+
+static u8 rtw89_bcn_get_coverage(struct rtw89_dev *rtwdev, u16 threshold)
+{
+	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
+	int l = 0, r = RTW89_BCN_TRACK_STAT_NR - 1, m;
+	u16 *drift = bcn_stat->drift;
+	int index = -1;
+	u8 count = 0;
+
+	while (l <= r) {
+		m = l + (r - l) / 2;
+
+		if (drift[m] <= threshold) {
+			index = m;
+			l = m + 1;
+		} else {
+			r = m - 1;
+		}
+	}
+
+	count = (index == -1) ? 0 : (index + 1);
+
+	return (count * PERCENT) / RTW89_BCN_TRACK_STAT_NR;
+}
+
+static u16 rtw89_bcn_get_histogram_bound(struct rtw89_dev *rtwdev, u8 target)
+{
+	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
+	struct rtw89_beacon_dist *bcn_dist = &bcn_stat->bcn_dist;
+	u16 tbtt_tu_max = bcn_stat->tbtt_tu_max;
+	u16 upper, lower = bcn_stat->tbtt_tu_min;
+	u8 i, count = 0;
+
+	for (i = 0; i < RTW89_BCN_TRACK_MAX_BIN_NUM; i++) {
+		upper = lower + RTW89_BCN_TRACK_BIN_WIDTH - 1;
+		if (i == RTW89_BCN_TRACK_MAX_BIN_NUM - 1)
+			upper = max(upper, tbtt_tu_max);
+
+		count += bcn_dist->bins[i];
+		if (count > target)
+			break;
+
+		lower = upper + 1;
+	}
+
+	return upper;
+}
+
+static u16 rtw89_bcn_get_rx_time(struct rtw89_dev *rtwdev,
+				 const struct rtw89_chan *chan)
+{
+#define RTW89_SYMBOL_TIME_2GHZ 192
+#define RTW89_SYMBOL_TIME_5GHZ 20
+#define RTW89_SYMBOL_TIME_6GHZ 20
+	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
+	u16 bitrate, val;
+
+	if (!rtw89_legacy_rate_to_bitrate(rtwdev, pkt_stat->beacon_rate, &bitrate))
+		return 0;
+
+	val = (pkt_stat->beacon_len * 8 * RTW89_BCN_TRACK_SCALE_FACTOR) / bitrate;
+
+	switch (chan->band_type) {
+	default:
+	case RTW89_BAND_2G:
+		val += RTW89_SYMBOL_TIME_2GHZ;
+		break;
+	case RTW89_BAND_5G:
+		val += RTW89_SYMBOL_TIME_5GHZ;
+		break;
+	case RTW89_BAND_6G:
+		val += RTW89_SYMBOL_TIME_6GHZ;
+		break;
+	}
+
+	/* convert to millisecond */
+	return DIV_ROUND_UP(val, 1000);
+}
+
+static void rtw89_bcn_calc_timeout(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link)
+{
+#define RTW89_BCN_TRACK_EXTEND_TIMEOUT 5
+#define RTW89_BCN_TRACK_COVERAGE_TH 0 /* unit: TU */
+#define RTW89_BCN_TRACK_STRONG_RSSI 80
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
+	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.cur_pkt_stat;
+	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	struct rtw89_beacon_dist *bcn_dist = &bcn_stat->bcn_dist;
+	u16 outlier_high_bcn_th = bcn_track->outlier_high_bcn_th;
+	u16 outlier_low_bcn_th = bcn_track->outlier_low_bcn_th;
+	u8 rssi = ewma_rssi_read(&rtwdev->phystat.bcn_rssi);
+	u16 target_bcn_th = bcn_track->target_bcn_th;
+	u16 low_bcn_th = bcn_track->low_bcn_th;
+	u16 med_bcn_th = bcn_track->med_bcn_th;
+	u16 beacon_int = bcn_track->beacon_int;
+	u16 bcn_timeout;
+
+	if (pkt_stat->beacon_nr < low_bcn_th) {
+		bcn_timeout = (RTW89_BCN_TRACK_TARGET_BCN * beacon_int) / PERCENT;
+		goto out;
+	}
+
+	if (bcn_dist->outlier_count >= outlier_high_bcn_th) {
+		bcn_timeout = bcn_dist->max;
+		goto out;
+	}
+
+	if (pkt_stat->beacon_nr < med_bcn_th) {
+		if (bcn_dist->outlier_count > outlier_low_bcn_th)
+			bcn_timeout = (bcn_dist->max + bcn_dist->upper_bound) / 2;
+		else
+			bcn_timeout = bcn_dist->upper_bound +
+				      RTW89_BCN_TRACK_EXTEND_TIMEOUT;
+
+		goto out;
+	}
+
+	if (rssi >= RTW89_BCN_TRACK_STRONG_RSSI) {
+		if (rtw89_bcn_get_coverage(rtwdev, RTW89_BCN_TRACK_COVERAGE_TH) >= 90) {
+			/* ideal case */
+			bcn_timeout = 0;
+		} else {
+			u16 offset_tu = bcn_track->tbtt_offset / 1024;
+			u16 upper_bound;
+
+			upper_bound =
+				rtw89_bcn_get_histogram_bound(rtwdev, target_bcn_th);
+			bcn_timeout =
+				_rtw89_bcn_calc_drift(upper_bound, offset_tu, beacon_int);
+		}
+
+		goto out;
+	}
+
+	bcn_timeout = bcn_stat->drift[target_bcn_th];
+
+out:
+	bcn_track->bcn_timeout = bcn_timeout + rtw89_bcn_get_rx_time(rtwdev, chan);
+}
+
+static void rtw89_bcn_update_timeout(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif_link *rtwvif_link)
+{
+	rtw89_bcn_calc_drift(rtwdev);
+	rtw89_bcn_calc_distribution(rtwdev);
+	rtw89_bcn_calc_timeout(rtwdev, rtwvif_link);
+}
+
+static void rtw89_core_bcn_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	struct rtw89_vif_link *rtwvif_link;
+	struct rtw89_vif *rtwvif;
+	unsigned int link_id;
+
+	if (!RTW89_CHK_FW_FEATURE(BEACON_TRACKING, &rtwdev->fw))
+		return;
+
+	if (!rtwdev->lps_enabled)
+		return;
+
+	if (!bcn_track->is_data_ready)
+		return;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+			if (!(rtwvif_link->wifi_role == RTW89_WIFI_ROLE_STATION ||
+			      rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT))
+				continue;
+
+			rtw89_bcn_update_tbtt_offset(rtwdev, rtwvif_link);
+			rtw89_bcn_update_timeout(rtwdev, rtwvif_link);
+		}
+	}
+}
+
+static bool rtw89_core_bcn_track_can_lps(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+
+	if (!RTW89_CHK_FW_FEATURE(BEACON_TRACKING, &rtwdev->fw))
+		return true;
+
+	return bcn_track->is_data_ready;
+}
+
+static void rtw89_core_bcn_track_assoc(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif_link *rtwvif_link)
+{
+#define RTW89_BCN_TRACK_MED_BCN 70
+#define RTW89_BCN_TRACK_LOW_BCN 30
+#define RTW89_BCN_TRACK_OUTLIER_HIGH_BCN 30
+#define RTW89_BCN_TRACK_OUTLIER_LOW_BCN 20
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	u32 period = jiffies_to_msecs(RTW89_TRACK_WORK_PERIOD);
+	struct ieee80211_bss_conf *bss_conf;
+	u32 beacons_in_period;
+	u32 bcn_intvl_us;
+	u16 beacon_int;
+	u8 dtim;
+
+	rcu_read_lock();
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	beacon_int = bss_conf->beacon_int;
+	dtim = bss_conf->dtim_period;
+	rcu_read_unlock();
+
+	beacons_in_period = period / beacon_int / dtim;
+	bcn_intvl_us = ieee80211_tu_to_usec(beacon_int);
+
+	bcn_track->low_bcn_th =
+		(beacons_in_period * RTW89_BCN_TRACK_LOW_BCN) / PERCENT;
+	bcn_track->med_bcn_th =
+		(beacons_in_period * RTW89_BCN_TRACK_MED_BCN) / PERCENT;
+	bcn_track->outlier_low_bcn_th =
+		(RTW89_BCN_TRACK_STAT_NR * RTW89_BCN_TRACK_OUTLIER_LOW_BCN) / PERCENT;
+	bcn_track->outlier_high_bcn_th =
+		(RTW89_BCN_TRACK_STAT_NR * RTW89_BCN_TRACK_OUTLIER_HIGH_BCN) / PERCENT;
+	bcn_track->target_bcn_th =
+		(RTW89_BCN_TRACK_STAT_NR * RTW89_BCN_TRACK_TARGET_BCN) / PERCENT;
+
+	bcn_track->close_bcn_intvl_th = ieee80211_tu_to_usec(beacon_int - 3);
+	bcn_track->tbtt_diff_th = (bcn_intvl_us * 85) / PERCENT;
+	bcn_track->beacon_int = beacon_int;
+	bcn_track->dtim = dtim;
+}
+
+static void rtw89_core_bcn_track_reset(struct rtw89_dev *rtwdev)
+{
+	memset(&rtwdev->phystat.bcn_stat, 0, sizeof(rtwdev->phystat.bcn_stat));
+	memset(&rtwdev->bcn_track, 0, sizeof(rtwdev->bcn_track));
+}
+
+static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev,
+				  struct ieee80211_bss_conf *bss_conf,
+				  struct sk_buff *skb)
+{
+#define RTW89_APPEND_TSF_2GHZ 384
+#define RTW89_APPEND_TSF_5GHZ 52
+#define RTW89_APPEND_TSF_6GHZ 52
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	u32 bcn_intvl_us = ieee80211_tu_to_usec(bss_conf->beacon_int);
+	u64 tsf = le64_to_cpu(mgmt->u.beacon.timestamp);
+	u8 wp, num = bcn_stat->num;
+	u16 append;
+
+	if (!RTW89_CHK_FW_FEATURE(BEACON_TRACKING, &rtwdev->fw))
+		return;
+
+	switch (rx_status->band) {
+	default:
+	case NL80211_BAND_2GHZ:
+		append = RTW89_APPEND_TSF_2GHZ;
+		break;
+	case NL80211_BAND_5GHZ:
+		append = RTW89_APPEND_TSF_5GHZ;
+		break;
+	case NL80211_BAND_6GHZ:
+		append = RTW89_APPEND_TSF_6GHZ;
+		break;
+	}
+
+	wp = bcn_stat->wp;
+	div_u64_rem(tsf - append, bcn_intvl_us, &bcn_stat->tbtt_us[wp]);
+	bcn_stat->tbtt_tu[wp] = bcn_stat->tbtt_us[wp] / 1024;
+	bcn_stat->wp = (wp + 1) % RTW89_BCN_TRACK_STAT_NR;
+	bcn_stat->num = umin(num + 1, RTW89_BCN_TRACK_STAT_NR);
+	bcn_track->is_data_ready = bcn_stat->num == RTW89_BCN_TRACK_STAT_NR;
+}
+
 static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 				    struct ieee80211_vif *vif)
 {
@@ -2272,7 +2703,6 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 			rtw89_vif_sync_bcn_tsf(rtwvif_link, hdr, skb->len);
 			rtw89_fw_h2c_rssi_offload(rtwdev, phy_ppdu);
 		}
-		pkt_stat->beacon_nr++;
 
 		if (phy_ppdu) {
 			ewma_rssi_add(&rtwdev->phystat.bcn_rssi, phy_ppdu->rssi_avg);
@@ -2280,7 +2710,11 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 				rtwvif_link->bcn_bw_idx = phy_ppdu->bw_idx;
 		}
 
+		pkt_stat->beacon_nr++;
 		pkt_stat->beacon_rate = desc_info->data_rate;
+		pkt_stat->beacon_len = skb->len;
+
+		rtw89_vif_rx_bcn_stat(rtwdev, bss_conf, skb);
 	}
 
 	if (!ether_addr_equal(bss_conf->addr, hdr->addr1))
@@ -3697,6 +4131,9 @@ static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
 		      vif->type == NL80211_IFTYPE_P2P_CLIENT))
 			continue;
 
+		if (!rtw89_core_bcn_track_can_lps(rtwdev))
+			continue;
+
 		rtw89_enter_lps(rtwdev, rtwvif, true);
 	}
 }
@@ -3883,6 +4320,7 @@ static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 		rtw89_btc_ntfy_wl_sta(rtwdev);
 	}
 	rtw89_mac_bf_monitor_track(rtwdev);
+	rtw89_core_bcn_track(rtwdev);
 	rtw89_phy_stat_track(rtwdev);
 	rtw89_phy_env_monitor_track(rtwdev);
 	rtw89_phy_dig(rtwdev);
@@ -4129,8 +4567,10 @@ int rtw89_core_sta_link_disassoc(struct rtw89_dev *rtwdev,
 
 	rtw89_assoc_link_clr(rtwsta_link);
 
-	if (vif->type == NL80211_IFTYPE_STATION)
+	if (vif->type == NL80211_IFTYPE_STATION) {
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, rtwvif_link, false);
+		rtw89_core_bcn_track_reset(rtwdev);
+	}
 
 	if (rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT)
 		rtw89_p2p_noa_once_deinit(rtwvif_link);
@@ -4271,6 +4711,7 @@ int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 					 BTC_ROLE_MSTS_STA_CONN_END);
 		rtw89_core_get_no_ul_ofdma_htc(rtwdev, &rtwsta_link->htc_template, chan);
 		rtw89_phy_ul_tb_assoc(rtwdev, rtwvif_link);
+		rtw89_core_bcn_track_assoc(rtwdev, rtwvif_link);
 
 		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif_link, rtwsta_link->mac_id);
 		if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 43e10278e14d..ca48426c577f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4622,6 +4622,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_SCAN_OFFLOAD_EXTRA_OP,
 	RTW89_FW_FEATURE_RFK_NTFY_MCC_V0,
 	RTW89_FW_FEATURE_LPS_DACK_BY_C2H_REG,
+	RTW89_FW_FEATURE_BEACON_TRACKING,
 };
 
 struct rtw89_fw_suit {
@@ -5074,9 +5075,36 @@ struct rtw89_pkt_drop_params {
 struct rtw89_pkt_stat {
 	u16 beacon_nr;
 	u8 beacon_rate;
+	u32 beacon_len;
 	u32 rx_rate_cnt[RTW89_HW_RATE_NR];
 };
 
+#define RTW89_BCN_TRACK_STAT_NR 32
+#define RTW89_BCN_TRACK_SCALE_FACTOR 10
+#define RTW89_BCN_TRACK_MAX_BIN_NUM 6
+#define RTW89_BCN_TRACK_BIN_WIDTH 5
+#define RTW89_BCN_TRACK_TARGET_BCN 80
+
+struct rtw89_beacon_dist {
+	u16 min;
+	u16 max;
+	u16 outlier_count;
+	u16 lower_bound;
+	u16 upper_bound;
+	u16 bins[RTW89_BCN_TRACK_MAX_BIN_NUM];
+};
+
+struct rtw89_beacon_stat {
+	u8 num;
+	u8 wp;
+	u16 tbtt_tu_min;
+	u16 tbtt_tu_max;
+	u16 drift[RTW89_BCN_TRACK_STAT_NR];
+	u32 tbtt_us[RTW89_BCN_TRACK_STAT_NR];
+	u16 tbtt_tu[RTW89_BCN_TRACK_STAT_NR];
+	struct rtw89_beacon_dist bcn_dist;
+};
+
 DECLARE_EWMA(thermal, 4, 4);
 
 struct rtw89_phy_stat {
@@ -5085,6 +5113,7 @@ struct rtw89_phy_stat {
 	struct ewma_rssi bcn_rssi;
 	struct rtw89_pkt_stat cur_pkt_stat;
 	struct rtw89_pkt_stat last_pkt_stat;
+	struct rtw89_beacon_stat bcn_stat;
 };
 
 enum rtw89_rfk_report_state {
@@ -5882,6 +5911,24 @@ struct rtw89_mlo_info {
 	struct rtw89_wait_info wait;
 };
 
+struct rtw89_beacon_track_info {
+	bool is_data_ready;
+	u32 tbtt_offset; /* in unit of microsecond */
+	u16 bcn_timeout; /* in unit of millisecond */
+
+	/* The following are constant and set at association. */
+	u8 dtim;
+	u16 beacon_int;
+	u16 low_bcn_th;
+	u16 med_bcn_th;
+	u16 high_bcn_th;
+	u16 target_bcn_th;
+	u16 outlier_low_bcn_th;
+	u16 outlier_high_bcn_th;
+	u32 close_bcn_intvl_th;
+	u32 tbtt_diff_th;
+};
+
 struct rtw89_dev {
 	struct ieee80211_hw *hw;
 	struct device *dev;
@@ -5896,6 +5943,7 @@ struct rtw89_dev {
 	const struct rtw89_pci_info *pci_info;
 	const struct rtw89_rfe_parms *rfe_parms;
 	struct rtw89_hal hal;
+	struct rtw89_beacon_track_info bcn_track;
 	struct rtw89_mcc_info mcc;
 	struct rtw89_mlo_info mlo;
 	struct rtw89_mac_info mac;
@@ -7454,7 +7502,7 @@ void rtw89_vif_type_mapping(struct rtw89_vif_link *rtwvif_link, bool assoc);
 int rtw89_chip_info_setup(struct rtw89_dev *rtwdev);
 void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif_link *rtwvif_link);
-bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate);
+bool rtw89_legacy_rate_to_bitrate(struct rtw89_dev *rtwdev, u8 legacy_rate, u16 *bitrate);
 int rtw89_regd_setup(struct rtw89_dev *rtwdev);
 int rtw89_regd_init_hint(struct rtw89_dev *rtwdev);
 const char *rtw89_regd_get_string(enum rtw89_regulation_type regd);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 16e59a4a486e..cc1956245f9b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -835,6 +835,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 90, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 91, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 110, 0, BEACON_FILTER),
+	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 122, 0, BEACON_TRACKING),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, SCAN_OFFLOAD_EXTRA_OP),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, CRASH_TRIGGER_TYPE_1),
@@ -846,6 +847,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 56, 10, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 80, 0, WOW_REASON_V1),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 128, 0, BEACON_LOSS_COUNT_V1),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 129, 1, BEACON_TRACKING),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 35, 0, SCAN_OFFLOAD),
@@ -864,6 +866,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 71, 0, BEACON_LOSS_COUNT_V1),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 76, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 79, 0, CRASH_TRIGGER_TYPE_1),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 80, 0, BEACON_TRACKING),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -3990,6 +3993,93 @@ int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_update_beacon_be);
 
+int rtw89_fw_h2c_tbtt_tuning(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif_link *rtwvif_link, u32 offset)
+{
+	struct rtw89_h2c_tbtt_tuning *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c tbtt tuning\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_tbtt_tuning *)skb->data;
+
+	h2c->w0 = le32_encode_bits(rtwvif_link->phy_idx, RTW89_H2C_TBTT_TUNING_W0_BAND) |
+		  le32_encode_bits(rtwvif_link->port, RTW89_H2C_TBTT_TUNING_W0_PORT);
+	h2c->w1 = le32_encode_bits(offset, RTW89_H2C_TBTT_TUNING_W1_SHIFT);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_PS,
+			      H2C_FUNC_TBTT_TUNING, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+int rtw89_fw_h2c_pwr_lvl(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
+{
+#define RTW89_BCN_TO_VAL_MIN 4
+#define RTW89_BCN_TO_VAL_MAX 64
+#define RTW89_DTIM_TO_VAL_MIN 7
+#define RTW89_DTIM_TO_VAL_MAX 15
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	struct rtw89_h2c_pwr_lvl *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	u8 bcn_to_val;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c pwr lvl\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_pwr_lvl *)skb->data;
+
+	bcn_to_val = clamp_t(u8, bcn_track->bcn_timeout,
+			     RTW89_BCN_TO_VAL_MIN, RTW89_BCN_TO_VAL_MAX);
+
+	h2c->w0 = le32_encode_bits(rtwvif_link->mac_id, RTW89_H2C_PWR_LVL_W0_MACID) |
+		  le32_encode_bits(bcn_to_val, RTW89_H2C_PWR_LVL_W0_BCN_TO_VAL) |
+		  le32_encode_bits(0, RTW89_H2C_PWR_LVL_W0_PS_LVL) |
+		  le32_encode_bits(0, RTW89_H2C_PWR_LVL_W0_TRX_LVL) |
+		  le32_encode_bits(RTW89_DTIM_TO_VAL_MIN,
+				   RTW89_H2C_PWR_LVL_W0_DTIM_TO_VAL);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_PS,
+			      H2C_FUNC_PS_POWER_LEVEL, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link,
 			       struct rtw89_sta_link *rtwsta_link,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 3de29137b113..fad9d87d3e56 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1602,6 +1602,28 @@ struct rtw89_h2c_bcn_upd_be {
 #define RTW89_H2C_BCN_UPD_BE_W7_ECSA_OFST GENMASK(30, 16)
 #define RTW89_H2C_BCN_UPD_BE_W7_PROTECTION_KEY_ID BIT(31)
 
+struct rtw89_h2c_tbtt_tuning {
+	__le32 w0;
+	__le32 w1;
+} __packed;
+
+#define RTW89_H2C_TBTT_TUNING_W0_BAND GENMASK(3, 0)
+#define RTW89_H2C_TBTT_TUNING_W0_PORT GENMASK(7, 4)
+#define RTW89_H2C_TBTT_TUNING_W1_SHIFT GENMASK(31, 0)
+
+struct rtw89_h2c_pwr_lvl {
+	__le32 w0;
+	__le32 w1;
+} __packed;
+
+#define RTW89_H2C_PWR_LVL_W0_MACID GENMASK(7, 0)
+#define RTW89_H2C_PWR_LVL_W0_BCN_TO_VAL GENMASK(15, 8)
+#define RTW89_H2C_PWR_LVL_W0_PS_LVL GENMASK(19, 16)
+#define RTW89_H2C_PWR_LVL_W0_TRX_LVL GENMASK(23, 20)
+#define RTW89_H2C_PWR_LVL_W0_BCN_TO_LVL GENMASK(27, 24)
+#define RTW89_H2C_PWR_LVL_W0_DTIM_TO_VAL GENMASK(31, 28)
+#define RTW89_H2C_PWR_LVL_W1_MACID_EXT GENMASK(7, 0)
+
 struct rtw89_h2c_role_maintain {
 	__le32 w0;
 };
@@ -4201,6 +4223,8 @@ enum rtw89_ps_h2c_func {
 	H2C_FUNC_MAC_LPS_PARM		= 0x0,
 	H2C_FUNC_P2P_ACT		= 0x1,
 	H2C_FUNC_IPS_CFG		= 0x3,
+	H2C_FUNC_PS_POWER_LEVEL		= 0x7,
+	H2C_FUNC_TBTT_TUNING		= 0xA,
 
 	NUM_OF_RTW89_PS_H2C_FUNC,
 };
@@ -4750,6 +4774,9 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link);
 int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link);
+int rtw89_fw_h2c_tbtt_tuning(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif_link *rtwvif_link, u32 offset);
+int rtw89_fw_h2c_pwr_lvl(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif,
 		     struct rtw89_sta_link *rtwsta_link, const u8 *scan_mac_addr);
 int rtw89_fw_h2c_dctl_sec_cam_v1(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5a5da9d9c0c5..d7aa279b9f7c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4649,27 +4649,6 @@ static void rtw89_mac_port_cfg_bcn_early(struct rtw89_dev *rtwdev,
 				BCN_ERLY_DEF);
 }
 
-static void rtw89_mac_port_cfg_tbtt_shift(struct rtw89_dev *rtwdev,
-					  struct rtw89_vif_link *rtwvif_link)
-{
-	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	const struct rtw89_port_reg *p = mac->port_base;
-	u16 val;
-
-	if (rtwdev->chip->chip_id != RTL8852C)
-		return;
-
-	if (rtwvif_link->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT &&
-	    rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION)
-		return;
-
-	val = FIELD_PREP(B_AX_TBTT_SHIFT_OFST_MAG, 1) |
-			 B_AX_TBTT_SHIFT_OFST_SIGN;
-
-	rtw89_write16_port_mask(rtwdev, rtwvif_link, p->tbtt_shift,
-				B_AX_TBTT_SHIFT_OFST_MASK, val);
-}
-
 void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif_link *rtwvif_link,
 			     struct rtw89_vif_link *rtwvif_src,
@@ -4820,7 +4799,6 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvi
 	rtw89_mac_port_cfg_bcn_hold_time(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bcn_mask_area(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_tbtt_early(rtwdev, rtwvif_link);
-	rtw89_mac_port_cfg_tbtt_shift(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif_link);
 	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif_link, true);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d607577b353c..0c52ca9a64a4 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2943,7 +2943,7 @@ static void __rtw89_phy_c2h_ra_rpt_iter(struct rtw89_sta_link *rtwsta_link,
 	}
 
 	if (mode == RTW89_RA_RPT_MODE_LEGACY) {
-		valid = rtw89_ra_report_to_bitrate(rtwdev, rate, &legacy_bitrate);
+		valid = rtw89_legacy_rate_to_bitrate(rtwdev, rate, &legacy_bitrate);
 		if (!valid)
 			return;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 652f8fc81b79..cf58121eb541 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -119,6 +119,9 @@ static void __rtw89_enter_lps_link(struct rtw89_dev *rtwdev,
 
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_FW_CTRL);
 	rtw89_fw_h2c_lps_parm(rtwdev, &lps_param);
+
+	if (RTW89_CHK_FW_FEATURE(BEACON_TRACKING, &rtwdev->fw))
+		rtw89_fw_h2c_pwr_lvl(rtwdev, rtwvif_link);
 }
 
 static void __rtw89_leave_lps(struct rtw89_dev *rtwdev,
-- 
2.25.1


