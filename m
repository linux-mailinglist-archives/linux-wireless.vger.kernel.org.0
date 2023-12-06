Return-Path: <linux-wireless+bounces-491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8E880701D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 13:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30973B20C48
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF336B17;
	Wed,  6 Dec 2023 12:46:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2607D51
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 04:46:16 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B6Ck8UK13602913, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B6Ck8UK13602913
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 20:46:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 6 Dec 2023 20:46:09 +0800
Received: from [127.0.1.1] (172.16.20.124) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 6 Dec 2023
 20:46:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: add C2H event handlers of RFK log and report
Date: Wed, 6 Dec 2023 20:44:46 +0800
Message-ID: <20231206124448.10537-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206124448.10537-1-pkshih@realtek.com>
References: <20231206124448.10537-1-pkshih@realtek.com>
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

Trigger a RFK (RF calibration) in firmware by a H2C command, and in
progress it reports log and a result finally by C2H events. Firstly, add
prototype of the C2H event handlers to have a simple picture of framework.

The callers who trigger H2C will wait until a C2H event is received,
so we must process these C2H events in receiving process. Thus, mark this
kind of C2H events as atomic. Also, timestamp is also useful for
debugging, mark C2H events carrying RFK log as atomic as well.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  |  2 +
 drivers/net/wireless/realtek/rtw89/phy.c | 87 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h |  7 ++
 3 files changed, 96 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 497c6dd5edf0..0ccc25683434 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3557,6 +3557,8 @@ static bool rtw89_fw_c2h_chk_atomic(struct rtw89_dev *rtwdev,
 		return false;
 	case RTW89_C2H_CAT_MAC:
 		return rtw89_mac_c2h_chk_atomic(rtwdev, class, func);
+	case RTW89_C2H_CAT_OUTSRC:
+		return rtw89_phy_c2h_chk_atomic(rtwdev, class, func);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index bfb1d8cfc531..8a4a72b00340 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2445,6 +2445,85 @@ void (* const rtw89_phy_c2h_ra_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_FUNC_TXSTS] = NULL,
 };
 
+static void
+rtw89_phy_c2h_rfk_log_iqk(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
+static void
+rtw89_phy_c2h_rfk_log_dpk(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
+static void
+rtw89_phy_c2h_rfk_log_dack(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
+static void
+rtw89_phy_c2h_rfk_log_rxdck(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
+static void
+rtw89_phy_c2h_rfk_log_tssi(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
+static void
+rtw89_phy_c2h_rfk_log_txgapk(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
+static
+void (* const rtw89_phy_c2h_rfk_log_handler[])(struct rtw89_dev *rtwdev,
+					       struct sk_buff *c2h, u32 len) = {
+	[RTW89_PHY_C2H_RFK_LOG_FUNC_IQK] = rtw89_phy_c2h_rfk_log_iqk,
+	[RTW89_PHY_C2H_RFK_LOG_FUNC_DPK] = rtw89_phy_c2h_rfk_log_dpk,
+	[RTW89_PHY_C2H_RFK_LOG_FUNC_DACK] = rtw89_phy_c2h_rfk_log_dack,
+	[RTW89_PHY_C2H_RFK_LOG_FUNC_RXDCK] = rtw89_phy_c2h_rfk_log_rxdck,
+	[RTW89_PHY_C2H_RFK_LOG_FUNC_TSSI] = rtw89_phy_c2h_rfk_log_tssi,
+	[RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK] = rtw89_phy_c2h_rfk_log_txgapk,
+};
+
+static void
+rtw89_phy_c2h_rfk_report_state(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
+static
+void (* const rtw89_phy_c2h_rfk_report_handler[])(struct rtw89_dev *rtwdev,
+						  struct sk_buff *c2h, u32 len) = {
+	[RTW89_PHY_C2H_RFK_REPORT_FUNC_STATE] = rtw89_phy_c2h_rfk_report_state,
+};
+
+bool rtw89_phy_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func)
+{
+	switch (class) {
+	case RTW89_PHY_C2H_RFK_LOG:
+		switch (func) {
+		case RTW89_PHY_C2H_RFK_LOG_FUNC_IQK:
+		case RTW89_PHY_C2H_RFK_LOG_FUNC_DPK:
+		case RTW89_PHY_C2H_RFK_LOG_FUNC_DACK:
+		case RTW89_PHY_C2H_RFK_LOG_FUNC_RXDCK:
+		case RTW89_PHY_C2H_RFK_LOG_FUNC_TSSI:
+		case RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK:
+			return true;
+		default:
+			return false;
+		}
+	case RTW89_PHY_C2H_RFK_REPORT:
+		switch (func) {
+		case RTW89_PHY_C2H_RFK_REPORT_FUNC_STATE:
+			return true;
+		default:
+			return false;
+		}
+	default:
+		return false;
+	}
+}
+
 void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func)
 {
@@ -2456,6 +2535,14 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (func < RTW89_PHY_C2H_FUNC_RA_MAX)
 			handler = rtw89_phy_c2h_ra_handler[func];
 		break;
+	case RTW89_PHY_C2H_RFK_LOG:
+		if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_log_handler))
+			handler = rtw89_phy_c2h_rfk_log_handler[func];
+		break;
+	case RTW89_PHY_C2H_RFK_REPORT:
+		if (func < ARRAY_SIZE(rtw89_phy_c2h_rfk_report_handler))
+			handler = rtw89_phy_c2h_rfk_report_handler[func];
+		break;
 	case RTW89_PHY_C2H_CLASS_DM:
 		if (func == RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY)
 			return;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index b60bc563d86f..3e379077c6ca 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -147,6 +147,10 @@ enum rtw89_phy_c2h_rfk_log_func {
 	RTW89_PHY_C2H_RFK_LOG_FUNC_NUM,
 };
 
+enum rtw89_phy_c2h_rfk_report_func {
+	RTW89_PHY_C2H_RFK_REPORT_FUNC_STATE = 0,
+};
+
 enum rtw89_phy_c2h_dm_func {
 	RTW89_PHY_C2H_DM_FUNC_FW_TEST,
 	RTW89_PHY_C2H_DM_FUNC_FW_TRIG_TX_RPT,
@@ -160,6 +164,8 @@ enum rtw89_phy_c2h_class {
 	RTW89_PHY_C2H_CLASS_RUA,
 	RTW89_PHY_C2H_CLASS_RA,
 	RTW89_PHY_C2H_CLASS_DM,
+	RTW89_PHY_C2H_RFK_LOG = 0x8,
+	RTW89_PHY_C2H_RFK_REPORT = 0x9,
 	RTW89_PHY_C2H_CLASS_BTC_MIN = 0x10,
 	RTW89_PHY_C2H_CLASS_BTC_MAX = 0x17,
 	RTW89_PHY_C2H_CLASS_MAX,
@@ -800,6 +806,7 @@ void rtw89_phy_ra_updata_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta
 void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
 				const struct cfg80211_bitrate_mask *mask);
+bool rtw89_phy_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func);
 void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func);
 void rtw89_phy_cfo_track(struct rtw89_dev *rtwdev);
-- 
2.25.1


