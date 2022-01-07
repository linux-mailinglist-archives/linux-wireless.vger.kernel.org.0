Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED18C48715C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345897AbiAGDnR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:17 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51085 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345896AbiAGDnR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:17 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073hCj85022961, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073hCj85022961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 11:43:12 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 09/19] rtw89: configure mac port HIQ registers
Date:   Fri, 7 Jan 2022 11:42:29 +0800
Message-ID: <20220107034239.22002-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107034239.22002-1-pkshih@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/07/2022 03:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNyCkV6TIIDAxOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HIQ is short for high queue that is used to send broadcast/multicast
packets right after TBTT in AP mode. Two registers, DTIM and window size,
are configured accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 34 +++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h | 14 +++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a0ff3d8a3f61b..58aa24e71637d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2864,6 +2864,36 @@ static void rtw89_mac_port_cfg_bcn_intv(struct rtw89_dev *rtwdev,
 				bcn_int);
 }
 
+static void rtw89_mac_port_cfg_hiq_win(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif *rtwvif)
+{
+	static const u32 hiq_win_addr[RTW89_PORT_NUM] = {
+		R_AX_P0MB_HGQ_WINDOW_CFG_0, R_AX_PORT_HGQ_WINDOW_CFG,
+		R_AX_PORT_HGQ_WINDOW_CFG + 1, R_AX_PORT_HGQ_WINDOW_CFG + 2,
+		R_AX_PORT_HGQ_WINDOW_CFG + 3,
+	};
+	u8 win = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE ? 16 : 0;
+	u8 port = rtwvif->port;
+	u32 reg;
+
+	reg = rtw89_mac_reg_by_idx(hiq_win_addr[port], rtwvif->mac_idx);
+	rtw89_write8(rtwdev, reg, win);
+}
+
+static void rtw89_mac_port_cfg_hiq_dtim(struct rtw89_dev *rtwdev,
+					struct rtw89_vif *rtwvif)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	const struct rtw89_port_reg *p = &rtw_port_base;
+	u32 addr;
+
+	addr = rtw89_mac_reg_by_idx(R_AX_MD_TSFT_STMP_CTL, rtwvif->mac_idx);
+	rtw89_write8_set(rtwdev, addr, B_AX_UPD_HGQMD | B_AX_UPD_TIMIE);
+
+	rtw89_write16_port_mask(rtwdev, rtwvif, p->dtim_ctrl, B_AX_DTIM_NUM_MASK,
+				vif->bss_conf.dtim_period);
+}
+
 static void rtw89_mac_port_cfg_bcn_setup_time(struct rtw89_dev *rtwdev,
 					      struct rtw89_vif *rtwvif)
 {
@@ -3034,13 +3064,15 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_mac_port_cfg_rx_sync(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_tx_sw(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bcn_intv(rtwdev, rtwvif);
+	rtw89_mac_port_cfg_hiq_win(rtwdev, rtwvif);
+	rtw89_mac_port_cfg_hiq_dtim(rtwdev, rtwvif);
+	rtw89_mac_port_cfg_hiq_drop(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bcn_setup_time(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bcn_hold_time(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bcn_mask_area(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_tbtt_early(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif);
-	rtw89_mac_port_cfg_hiq_drop(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif);
 	fsleep(BCN_ERLY_SET_DLY);
 	rtw89_mac_port_cfg_bcn_early(rtwdev, rtwvif);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index e0a416d37d0e8..5e5cb0fcfa859 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -913,7 +913,7 @@
 #define R_AX_DTIM_CTRL_P2 0xC4A6
 #define R_AX_DTIM_CTRL_P3 0xC4E6
 #define R_AX_DTIM_CTRL_P4 0xC526
-#define B_AX_DTIM_NUM_MASK GENMASK(15, 0)
+#define B_AX_DTIM_NUM_MASK GENMASK(15, 8)
 #define B_AX_DTIM_CURRCNT_MASK GENMASK(7, 0)
 
 #define R_AX_TBTT_SHIFT_P0 0xC428
@@ -964,6 +964,11 @@
 #define B_AX_P0MB2_EN BIT(2)
 #define B_AX_P0MB1_EN BIT(1)
 
+#define R_AX_P0MB_HGQ_WINDOW_CFG_0 0xC590
+#define R_AX_P0MB_HGQ_WINDOW_CFG_0_C1 0xE590
+#define R_AX_PORT_HGQ_WINDOW_CFG 0xC5A0
+#define R_AX_PORT_HGQ_WINDOW_CFG_C1 0xE5A0
+
 #define R_AX_AMPDU_AGG_LIMIT 0xC610
 #define B_AX_AMPDU_MAX_TIME_MASK GENMASK(31, 24)
 #define B_AX_RA_TRY_RATE_AGG_LMT_MASK GENMASK(23, 16)
@@ -1080,6 +1085,13 @@
 #define B_AX_TCR_ZLD_USTIME_AFTERPHYTXON GENMASK(11, 8)
 #define B_AX_TCR_TXTIMEOUT GENMASK(7, 0)
 
+#define R_AX_MD_TSFT_STMP_CTL 0xCA08
+#define R_AX_MD_TSFT_STMP_CTL_C1 0xEA08
+#define B_AX_TSFT_OFS_MASK GENMASK(31, 16)
+#define B_AX_STMP_THSD_MASK GENMASK(15, 8)
+#define B_AX_UPD_HGQMD BIT(1)
+#define B_AX_UPD_TIMIE BIT(0)
+
 #define R_AX_PPWRBIT_SETTING 0xCA0C
 #define R_AX_PPWRBIT_SETTING_C1 0xEA0C
 
-- 
2.25.1

