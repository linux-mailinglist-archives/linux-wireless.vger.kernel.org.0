Return-Path: <linux-wireless+bounces-891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25F4816664
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 07:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7012825A3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CBFE550;
	Mon, 18 Dec 2023 06:15:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51EDF4A
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BI6FHvJ43224890, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BI6FHvJ43224890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 14:15:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 18 Dec 2023 14:15:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Dec
 2023 14:15:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/11] wifi: rtw89: coex: Translate antenna configuration from ID to string
Date: Mon, 18 Dec 2023 14:13:40 +0800
Message-ID: <20231218061341.51255-11-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

More readable on the coexistence log.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 24 +++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 8273408ffd42..0b430eace1aa 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -6864,6 +6864,7 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 #define CASE_BTC_SLOT_STR(e) case CXST_ ## e: return #e
 #define CASE_BTC_EVT_STR(e) case CXEVNT_## e: return #e
 #define CASE_BTC_INIT(e) case BTC_MODE_## e: return #e
+#define CASE_BTC_ANTPATH_STR(e) case BTC_ANT_##e: return #e
 
 static const char *steps_to_str(u16 step)
 {
@@ -7050,6 +7051,25 @@ static const char *id_to_mode(u8 id)
 	}
 }
 
+static const char *id_to_ant(u32 id)
+{
+	switch (id) {
+	CASE_BTC_ANTPATH_STR(WPOWERON);
+	CASE_BTC_ANTPATH_STR(WINIT);
+	CASE_BTC_ANTPATH_STR(WONLY);
+	CASE_BTC_ANTPATH_STR(WOFF);
+	CASE_BTC_ANTPATH_STR(W2G);
+	CASE_BTC_ANTPATH_STR(W5G);
+	CASE_BTC_ANTPATH_STR(W25G);
+	CASE_BTC_ANTPATH_STR(FREERUN);
+	CASE_BTC_ANTPATH_STR(WRFK);
+	CASE_BTC_ANTPATH_STR(BRFK);
+	CASE_BTC_ANTPATH_STR(MAX);
+	default:
+		return "unknown";
+	}
+}
+
 static
 void seq_print_segment(struct seq_file *m, const char *prefix, u16 *data,
 		       u8 len, u8 seg_len, u8 start_idx, u8 ring_len)
@@ -7104,12 +7124,12 @@ static void _show_dm_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   (btc->ctrl.manual ? "(Manual)" : "(Auto)"));
 
 	seq_printf(m,
-		   " %-15s : type:%s, reason:%s(), action:%s(), ant_path:%ld, init_mode:%s, run_cnt:%d\n",
+		   " %-15s : type:%s, reason:%s(), action:%s(), ant_path:%s, init_mode:%s, run_cnt:%d\n",
 		   "[status]",
 		   module->ant.type == BTC_ANT_SHARED ? "shared" : "dedicated",
 		   steps_to_str(dm->run_reason),
 		   steps_to_str(dm->run_action | BTC_ACT_EXT_BIT),
-		   FIELD_GET(GENMASK(7, 0), dm->set_ant_path),
+		   id_to_ant(FIELD_GET(GENMASK(7, 0), dm->set_ant_path)),
 		   id_to_mode(wl->coex_mode),
 		   dm->cnt_dm[BTC_DCNT_RUN]);
 
-- 
2.25.1


