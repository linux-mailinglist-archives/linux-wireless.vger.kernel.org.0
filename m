Return-Path: <linux-wireless+bounces-724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6A5810705
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 01:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDD41C20E33
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 00:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8766112;
	Wed, 13 Dec 2023 00:52:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E072DB9
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 16:52:22 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BD0qGCO13838309, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BD0qGCO13838309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 08:52:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 13 Dec 2023 08:52:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 13 Dec
 2023 08:52:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 6/6] wifi: rtw89: phy: print out RFK log with formatted string
Date: Wed, 13 Dec 2023 08:50:54 +0800
Message-ID: <20231213005054.10568-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213005054.10568-1-pkshih@realtek.com>
References: <20231213005054.10568-1-pkshih@realtek.com>
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

With formatted string loaded from firmware file, we can use the formatted
string ID and get corresponding string, and then use regular rtw89_debug()
to show the message if debug mask of RFK is enabled.

If the string ID doesn't present, fallback to print plain hexadecimal.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  |  5 ++++
 drivers/net/wireless/realtek/rtw89/phy.c | 38 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index aa749732a9e2..bfe226fe3d07 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3733,6 +3733,11 @@ struct rtw89_c2h_rf_log_hdr {
 	u8 content[];
 } __packed;
 
+struct rtw89_c2h_rf_run_log {
+	__le32 fmt_idx;
+	__le32 arg[4];
+} __packed;
+
 struct rtw89_c2h_rf_dpk_rpt_log {
 	u8 ver;
 	u8 idx[2];
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 496160f72755..bafc7b1cc104 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2566,6 +2566,38 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 		    "unexpected RFK func %d report log with length %d\n", func, len);
 }
 
+static bool rtw89_phy_c2h_rfk_run_log(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_c2h_rfk_log_func func,
+				      void *content, u16 len)
+{
+	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
+	const struct rtw89_c2h_rf_run_log *log = content;
+	const struct rtw89_fw_element_hdr *elm;
+	u32 fmt_idx;
+	u16 offset;
+
+	if (sizeof(*log) != len)
+		return false;
+
+	if (!elm_info->rfk_log_fmt)
+		return false;
+
+	elm = elm_info->rfk_log_fmt->elm[func];
+	fmt_idx = le32_to_cpu(log->fmt_idx);
+	if (!elm || fmt_idx >= elm->u.rfk_log_fmt.nr)
+		return false;
+
+	offset = le16_to_cpu(elm->u.rfk_log_fmt.offset[fmt_idx]);
+	if (offset == 0)
+		return false;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, &elm->u.common.contents[offset],
+		    le32_to_cpu(log->arg[0]), le32_to_cpu(log->arg[1]),
+		    le32_to_cpu(log->arg[2]), le32_to_cpu(log->arg[3]));
+
+	return true;
+}
+
 static void rtw89_phy_c2h_rfk_log(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 				  u32 len, enum rtw89_phy_c2h_rfk_log_func func,
 				  const char *rfk_name)
@@ -2575,6 +2607,7 @@ static void rtw89_phy_c2h_rfk_log(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 	void *log_ptr = c2h_hdr;
 	u16 content_len;
 	u16 chunk_len;
+	bool handled;
 
 	if (!rtw89_debug_is_enabled(rtwdev, RTW89_DBG_RFK))
 		return;
@@ -2592,6 +2625,11 @@ static void rtw89_phy_c2h_rfk_log(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 
 		switch (log_hdr->type) {
 		case RTW89_RF_RUN_LOG:
+			handled = rtw89_phy_c2h_rfk_run_log(rtwdev, func,
+							    log_hdr->content, content_len);
+			if (handled)
+				break;
+
 			rtw89_debug(rtwdev, RTW89_DBG_RFK, "%s run: %*ph\n",
 				    rfk_name, content_len, log_hdr->content);
 			break;
-- 
2.25.1


