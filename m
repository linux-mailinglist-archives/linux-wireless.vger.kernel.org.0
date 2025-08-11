Return-Path: <linux-wireless+bounces-26255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7DEB208F4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B552A3590
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569425D558;
	Mon, 11 Aug 2025 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KAO/DYx4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990FA2D6608
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915930; cv=none; b=nqcO1x+shiycDUUyiuZIG2wgGsD6zcccYTOA9CayzZNs20LrAG7CIf1ASlLuPDlXUb6RIRJx0q6FzqcCX1pYJNMXLNlJP9CrOosTAVpb+JapiUi/pIT3vgMpWvRU9XfUenhl+B/2uf/FPCSlO2PivbMJQZ7hL3Sithm0ss06sQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915930; c=relaxed/simple;
	bh=ItMZGe400K4AmH1RhZjp5lRupNVxUoQHYQ2RyXmFJjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1YG8q+IT/3OqbrerkY+E2a6HDF1XT7BpZjEFDOr3E5haxw3J0Sh987jgl1qYnYogb4lymV2Jl5OC/mq6OMYeupRF95Y73keehDKuX5jUe5+nLv9ZRN4p6jA00Cn3jqUVgldtva/uS7AZOiVvi1p5ptigZlqQC2mlVMQbe5iIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KAO/DYx4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57BCckZuB073203, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754915926; bh=x5HpGRoY9TlfCbmVXP5jFy8576r9/T2NQmZjqqvX8EA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KAO/DYx49Tz0CpgVnUvavYh9+8a5M0MOzeoSzH32Zi1TmfbK4UwsNBI421RVMxUW4
	 RfsflPsZb/sXuWe67FP8PakFCVvBZxAoHf/9TaUlb6f9NBItO7efszNMuFo2Rc9C6j
	 1eNifiVLVxvdbXtotW1wmBY+XUVuG4Q3jolhyP0lkvh7RxkoFWnQIWvrsZ/CnZI+v1
	 dve8ngAWXCf6waBpAQvANbrtoI89nSbymocEH548CkjWL3ci5IsqyPdySP+CHi+jHV
	 al+VXDE1BH1msG52QSgaevp9MQ0mRpS/IoDgV64hjKKxeveQeSsQyq35qACQ1TswiH
	 +j6ZwksIy08XA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57BCckZuB073203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 20:38:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 20:38:45 +0800
Received: from [127.0.1.1] (10.22.225.179) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 Aug
 2025 20:38:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 2/8] wifi: rtw89: debug: add beacon_info debugfs
Date: Mon, 11 Aug 2025 20:37:38 +0800
Message-ID: <20250811123744.15361-3-pkshih@realtek.com>
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

Add debugfs beacon_info to display the information of beacon tracking.
The screenshot as below:

  [Beacon info]
  count: 15
  interval: 100
  dtim: 1
  raw rssi: 146
  hw rate: 0
  length: 407

  [Distribution]
  tbtt
  00 - 04: 26
  05 - 09: 5
  10 - 14: 1
  15 - 19: 0
  20 - 24: 0
  25 - 29: 0

  drift
  0: 9
  1: 7
  2: 3
  3: 3
  4: 4
  5: 1
  6: 1
  7: 2
  8: 1
  11: 1

  lower bound: 0
  upper bound: 10
  outlier count: 1

  [Tracking]
  tbtt offset: 20
  bcn timeout: 19

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index afdfb9647fc1..a37cdd73ddc3 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -86,6 +86,7 @@ struct rtw89_debugfs {
 	struct rtw89_debugfs_priv stations;
 	struct rtw89_debugfs_priv disable_dm;
 	struct rtw89_debugfs_priv mlo_mode;
+	struct rtw89_debugfs_priv beacon_info;
 };
 
 struct rtw89_debugfs_iter_data {
@@ -4298,6 +4299,64 @@ rtw89_debug_priv_mlo_mode_set(struct rtw89_dev *rtwdev,
 	return count;
 }
 
+static ssize_t
+rtw89_debug_priv_beacon_info_get(struct rtw89_dev *rtwdev,
+				 struct rtw89_debugfs_priv *debugfs_priv,
+				 char *buf, size_t bufsz)
+{
+	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.last_pkt_stat;
+	struct rtw89_beacon_track_info *bcn_track = &rtwdev->bcn_track;
+	struct rtw89_beacon_stat *bcn_stat = &rtwdev->phystat.bcn_stat;
+	struct rtw89_beacon_dist *bcn_dist = &bcn_stat->bcn_dist;
+	u16 upper, lower = bcn_stat->tbtt_tu_min;
+	char *p = buf, *end = buf + bufsz;
+	u16 *drift = bcn_stat->drift;
+	u8 bcn_num = bcn_stat->num;
+	u8 count;
+	u8 i;
+
+	p += scnprintf(p, end - p, "[Beacon info]\n");
+	p += scnprintf(p, end - p, "count: %u\n", pkt_stat->beacon_nr);
+	p += scnprintf(p, end - p, "interval: %u\n", bcn_track->beacon_int);
+	p += scnprintf(p, end - p, "dtim: %u\n", bcn_track->dtim);
+	p += scnprintf(p, end - p, "raw rssi: %lu\n",
+		       ewma_rssi_read(&rtwdev->phystat.bcn_rssi));
+	p += scnprintf(p, end - p, "hw rate: %u\n", pkt_stat->beacon_rate);
+	p += scnprintf(p, end - p, "length: %u\n", pkt_stat->beacon_len);
+
+	p += scnprintf(p, end - p, "\n[Distribution]\n");
+	p += scnprintf(p, end - p, "tbtt\n");
+	for (i = 0; i < RTW89_BCN_TRACK_MAX_BIN_NUM; i++) {
+		upper = lower + RTW89_BCN_TRACK_BIN_WIDTH - 1;
+		if (i == RTW89_BCN_TRACK_MAX_BIN_NUM - 1)
+			upper = max(upper, bcn_stat->tbtt_tu_max);
+
+		p += scnprintf(p, end - p, "%02u - %02u: %u\n",
+			       lower, upper, bcn_dist->bins[i]);
+
+		lower = upper + 1;
+	}
+
+	p += scnprintf(p, end - p, "\ndrift\n");
+
+	for (i = 0; i < bcn_num; i += count) {
+		count = 1;
+		while (i + count < bcn_num && drift[i] == drift[i + count])
+			count++;
+
+		p += scnprintf(p, end - p, "%u: %u\n", drift[i], count);
+	}
+	p += scnprintf(p, end - p, "\nlower bound: %u\n", bcn_dist->lower_bound);
+	p += scnprintf(p, end - p, "upper bound: %u\n", bcn_dist->upper_bound);
+	p += scnprintf(p, end - p, "outlier count: %u\n", bcn_dist->outlier_count);
+
+	p += scnprintf(p, end - p, "\n[Tracking]\n");
+	p += scnprintf(p, end - p, "tbtt offset: %u\n", bcn_track->tbtt_offset);
+	p += scnprintf(p, end - p, "bcn timeout: %u\n", bcn_track->bcn_timeout);
+
+	return p - buf;
+}
+
 #define rtw89_debug_priv_get(name, opts...)			\
 {								\
 	.cb_read = rtw89_debug_priv_ ##name## _get,		\
@@ -4356,6 +4415,7 @@ static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.stations = rtw89_debug_priv_get(stations, RLOCK),
 	.disable_dm = rtw89_debug_priv_set_and_get(disable_dm, RWLOCK),
 	.mlo_mode = rtw89_debug_priv_set_and_get(mlo_mode, RWLOCK),
+	.beacon_info = rtw89_debug_priv_get(beacon_info),
 };
 
 #define rtw89_debugfs_add(name, mode, fopname, parent)				\
@@ -4401,6 +4461,7 @@ void rtw89_debugfs_add_sec1(struct rtw89_dev *rtwdev, struct dentry *debugfs_top
 	rtw89_debugfs_add_r(stations);
 	rtw89_debugfs_add_rw(disable_dm);
 	rtw89_debugfs_add_rw(mlo_mode);
+	rtw89_debugfs_add_r(beacon_info);
 }
 
 void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
-- 
2.25.1


