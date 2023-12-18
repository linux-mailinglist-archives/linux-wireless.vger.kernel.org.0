Return-Path: <linux-wireless+bounces-882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B4A81665B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 07:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BD5B2100F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 06:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9377475;
	Mon, 18 Dec 2023 06:15:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0C7461
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BI6F5II03224821, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BI6F5II03224821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:15:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 18 Dec 2023 14:15:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Dec
 2023 14:15:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 02/11] wifi: rtw89: coex: Record down Wi-Fi initial mode information
Date: Mon, 18 Dec 2023 14:13:32 +0800
Message-ID: <20231218061341.51255-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218061341.51255-1-pkshih@realtek.com>
References: <20231218061341.51255-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Ching-Te Ku <ku920601@realtek.com>

This information will use as judgment about how to set RF/HW parameters.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 17 ++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 1ff04ff79cd1..cc204783ea8d 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5308,6 +5308,7 @@ void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): mode=%d\n", __func__, mode);
 
+	wl->coex_mode = mode;
 	dm->cnt_notify[BTC_NCNT_INIT_COEX]++;
 	dm->wl_only = mode == BTC_MODE_WL ? 1 : 0;
 	dm->bt_only = mode == BTC_MODE_BT ? 1 : 0;
@@ -6553,6 +6554,7 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	case BTC_CXP_ ## e | BTC_POLICY_EXT_BIT: return #e
 #define CASE_BTC_SLOT_STR(e) case CXST_ ## e: return #e
 #define CASE_BTC_EVT_STR(e) case CXEVNT_## e: return #e
+#define CASE_BTC_INIT(e) case BTC_MODE_## e: return #e
 
 static const char *steps_to_str(u16 step)
 {
@@ -6727,6 +6729,18 @@ static const char *id_to_evt(u32 id)
 	}
 }
 
+static const char *id_to_mode(u8 id)
+{
+	switch (id) {
+	CASE_BTC_INIT(NORMAL);
+	CASE_BTC_INIT(WL);
+	CASE_BTC_INIT(BT);
+	CASE_BTC_INIT(WLOFF);
+	default:
+		return "unknown";
+	}
+}
+
 static
 void seq_print_segment(struct seq_file *m, const char *prefix, u16 *data,
 		       u8 len, u8 seg_len, u8 start_idx, u8 ring_len)
@@ -6781,12 +6795,13 @@ static void _show_dm_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   (btc->ctrl.manual ? "(Manual)" : "(Auto)"));
 
 	seq_printf(m,
-		   " %-15s : type:%s, reason:%s(), action:%s(), ant_path:%ld, run_cnt:%d\n",
+		   " %-15s : type:%s, reason:%s(), action:%s(), ant_path:%ld, init_mode:%s, run_cnt:%d\n",
 		   "[status]",
 		   module->ant.type == BTC_ANT_SHARED ? "shared" : "dedicated",
 		   steps_to_str(dm->run_reason),
 		   steps_to_str(dm->run_action | BTC_ACT_EXT_BIT),
 		   FIELD_GET(GENMASK(7, 0), dm->set_ant_path),
+		   id_to_mode(wl->coex_mode),
 		   dm->cnt_dm[BTC_DCNT_RUN]);
 
 	_show_dm_step(rtwdev, m);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6e050c0845a6..e72cf1866d1e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1706,6 +1706,7 @@ struct rtw89_btc_wl_info {
 	u8 port_id[RTW89_WIFI_ROLE_MLME_MAX];
 	u8 rssi_level;
 	u8 cn_report;
+	u8 coex_mode;
 
 	bool scbd_change;
 	u32 scbd;
-- 
2.25.1


