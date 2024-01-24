Return-Path: <linux-wireless+bounces-2432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A383A02F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 04:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4228295123
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3611381;
	Wed, 24 Jan 2024 03:38:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B70C150
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706067508; cv=none; b=HCQrZfXN2+oQqW1ZFsp4LECRVckaStkGM5oY9f50WDDdUgzXXy5zPP2cZdfSz7bbYzyYfbEdLuAKBPewckNf39coSpbgsA3KzbeLFRY1QU9jpLlCu/46+GK/Tz+d+LHpjrZ2FgkRAMhgHzGiXy/HeqS7lzIDBwmmbry5+E+EWYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706067508; c=relaxed/simple;
	bh=Hu9g7LFvFK17Pn1xaH1uXNjhZhlX51I/4akHjWvBDgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZXJ8K8VPZFLhMPTsTjRDbEOt9uyoB4rXDLGhrDX8pr5MqhplE2gqPazrbb5PkXkRGvTExAV6t+XDrjcPRIxo0UdASMlq7ZNqMAQT/Wo34E85GI3OvU5VfFJqmkKm6QslZCZyX8NGtAyceG5+aJ30RAsWyLHAc2hh7qovRe7+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40O3cLHd9724205, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40O3cLHd9724205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:38:21 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 24 Jan 2024 11:38:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 24 Jan
 2024 11:38:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: 8922a: add chip_ops to get thermal value
Date: Wed, 24 Jan 2024 11:38:02 +0800
Message-ID: <20240124033802.12508-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124033637.12330-1-pkshih@realtek.com>
References: <20240124033637.12330-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Get thermal value as a clue to do RF calibration if the delta is larger
than a threshold, but 8922A doesn't need this, so we only read out the
value when debugging to reduce IO.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 6b15fa431b22..53061801fa4c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7465,6 +7465,7 @@
 #define RR_LUTWD0_LB GENMASK(5, 0)
 #define RR_TM 0x42
 #define RR_TM_TRI BIT(19)
+#define RR_TM_VAL_V1 GENMASK(7, 0)
 #define RR_TM_VAL GENMASK(6, 1)
 #define RR_TM2 0x43
 #define RR_TM2_OFF GENMASK(19, 16)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 1c5ceb5564c3..6de3c0f8d83a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1528,6 +1528,27 @@ static void rtw8922a_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 				   &tx_en0, false);
 }
 
+static u8 rtw8922a_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	int th;
+
+	/* read thermal only if debugging */
+	if (!rtw89_debug_is_enabled(rtwdev, RTW89_DBG_CFO | RTW89_DBG_RFK_TRACK))
+		return 80;
+
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x0);
+	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
+
+	fsleep(200);
+
+	th = rtw89_read_rf(rtwdev, rf_path, RR_TM, RR_TM_VAL_V1);
+	th += (s8)info->thermal_trim[rf_path];
+
+	return clamp_t(int, th, 0, U8_MAX);
+}
+
 static void rtw8922a_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
 					 struct rtw89_rx_phy_ppdu *phy_ppdu,
 					 struct ieee80211_rx_status *status)
@@ -1603,6 +1624,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.set_txpwr		= rtw8922a_set_txpwr,
 	.set_txpwr_ctrl		= rtw8922a_set_txpwr_ctrl,
 	.init_txpwr_unit	= NULL,
+	.get_thermal		= rtw8922a_get_thermal,
 	.ctrl_btg_bt_rx		= rtw8922a_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8922a_query_ppdu,
 	.ctrl_nbtg_bt_tx	= rtw8922a_ctrl_nbtg_bt_tx,
-- 
2.25.1


