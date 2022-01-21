Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EE8495B50
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jan 2022 08:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379195AbiAUH4w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jan 2022 02:56:52 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49858 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379201AbiAUH4Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jan 2022 02:56:24 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20L7uCewD032211, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20L7uCewD032211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 15:56:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 21 Jan 2022 15:56:12 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 21 Jan
 2022 15:56:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <johnson.lin@realtek.com>
Subject: [PATCH] rtw89: refine DIG feature to support 160M and CCK PD
Date:   Fri, 21 Jan 2022 15:55:54 +0800
Message-ID: <20220121075555.12457-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 01/21/2022 07:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMjEgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johnson Lin <johnson.lin@realtek.com>

DIG, which is short for dynamic initial gain, is used to adjust gain to get
good RX performance. CCK PD feature, a mechanism that adjusts 802.11b CCK
packet detection(PD) power threshold based on environment noisy level in
order to avoid false alarm. Also, refine related variable naming.

Signed-off-by: Johnson Lin <johnson.lin@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  9 ++++++
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c  | 34 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.h  |  3 ++
 drivers/net/wireless/realtek/rtw89/reg.h  |  4 +++
 5 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a0737eea9f81d..6f7776c3c230a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2347,6 +2347,13 @@ static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
 	rtwdev->hal.cv = cv;
 }
 
+static void rtw89_core_setup_phycap(struct rtw89_dev *rtwdev)
+{
+	rtwdev->hal.support_cckpd =
+		!(rtwdev->chip->chip_id == RTL8852A && rtwdev->hal.cv <= CHIP_CBV) &&
+		!(rtwdev->chip->chip_id == RTL8852B && rtwdev->hal.cv <= CHIP_CAV);
+}
+
 static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 {
 	int ret;
@@ -2367,6 +2374,8 @@ static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	rtw89_core_setup_phycap(rtwdev);
+
 	rtw89_mac_pwr_off(rtwdev);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7c84556ec4ada..ced97f2fa8527 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2358,6 +2358,7 @@ struct rtw89_hal {
 	u32 antenna_rx;
 	u8 tx_nss;
 	u8 rx_nss;
+	bool support_cckpd;
 };
 
 #define RTW89_MAX_MAC_ID_NUM 128
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 147009888de04..e084eb978dbfc 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2845,7 +2845,9 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 	enum rtw89_bandwidth cbw = rtwdev->hal.current_band_width;
 	struct rtw89_dig_info *dig = &rtwdev->dig;
 	u8 final_rssi = 0, under_region = dig->pd_low_th_ofst;
-	u32 val = 0;
+	u8 ofdm_cca_th;
+	s8 cck_cca_th;
+	u32 pd_val = 0;
 
 	under_region += PD_TH_SB_FLTR_CMP_VAL;
 
@@ -2856,6 +2858,9 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 	case RTW89_CHANNEL_WIDTH_80:
 		under_region += PD_TH_BW80_CMP_VAL;
 		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		under_region += PD_TH_BW160_CMP_VAL;
+		break;
 	case RTW89_CHANNEL_WIDTH_20:
 		fallthrough;
 	default:
@@ -2866,23 +2871,38 @@ static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 	dig->dyn_pd_th_max = dig->igi_rssi;
 
 	final_rssi = min_t(u8, rssi, dig->igi_rssi);
-	final_rssi = clamp_t(u8, final_rssi, PD_TH_MIN_RSSI + under_region,
-			     PD_TH_MAX_RSSI + under_region);
+	ofdm_cca_th = clamp_t(u8, final_rssi, PD_TH_MIN_RSSI + under_region,
+			      PD_TH_MAX_RSSI + under_region);
 
 	if (enable) {
-		val = (final_rssi - under_region - PD_TH_MIN_RSSI) >> 1;
+		pd_val = (ofdm_cca_th - under_region - PD_TH_MIN_RSSI) >> 1;
 		rtw89_debug(rtwdev, RTW89_DBG_DIG,
-			    "dyn_max=%d, final_rssi=%d, total=%d, PD_low=%d\n",
-			    dig->igi_rssi, final_rssi, under_region, val);
+			    "igi=%d, ofdm_ccaTH=%d, backoff=%d, PD_low=%d\n",
+			    final_rssi, ofdm_cca_th, under_region, pd_val);
 	} else {
 		rtw89_debug(rtwdev, RTW89_DBG_DIG,
 			    "Dynamic PD th disabled, Set PD_low_bd=0\n");
 	}
 
 	rtw89_phy_write32_mask(rtwdev, R_SEG0R_PD, B_SEG0R_PD_LOWER_BOUND_MSK,
-			       val);
+			       pd_val);
 	rtw89_phy_write32_mask(rtwdev, R_SEG0R_PD,
 			       B_SEG0R_PD_SPATIAL_REUSE_EN_MSK, enable);
+
+	if (!rtwdev->hal.support_cckpd)
+		return;
+
+	cck_cca_th = max_t(s8, final_rssi - under_region, CCKPD_TH_MIN_RSSI);
+	pd_val = (u32)(cck_cca_th - IGI_RSSI_MAX);
+
+	rtw89_debug(rtwdev, RTW89_DBG_DIG,
+		    "igi=%d, cck_ccaTH=%d, backoff=%d, cck_PD_low=((%d))dB\n",
+		    final_rssi, cck_cca_th, under_region, pd_val);
+
+	rtw89_phy_write32_mask(rtwdev, R_BMODE_PDTH_EN_V1,
+			       B_BMODE_PDTH_LIMIT_EN_MSK_V1, enable);
+	rtw89_phy_write32_mask(rtwdev, R_BMODE_PDTH_V1,
+			       B_BMODE_PDTH_LOWER_BOUND_MSK_V1, pd_val);
 }
 
 void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index b1f059b725a10..ab703b4000235 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -87,8 +87,11 @@
 #define RXB_IDX_MAX 31
 #define RXB_IDX_MIN 0
 
+#define IGI_RSSI_MAX 110
 #define PD_TH_MAX_RSSI 70
 #define PD_TH_MIN_RSSI 8
+#define CCKPD_TH_MIN_RSSI (-18)
+#define PD_TH_BW160_CMP_VAL 9
 #define PD_TH_BW80_CMP_VAL 6
 #define PD_TH_BW40_CMP_VAL 3
 #define PD_TH_BW20_CMP_VAL 0
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index e0a416d37d0e8..96ba3c3a1e05e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1959,6 +1959,10 @@
 #define R_CHBW_MOD 0x4978
 #define B_CHBW_MOD_PRICH GENMASK(11, 8)
 #define B_CHBW_MOD_SBW GENMASK(13, 12)
+#define R_BMODE_PDTH_V1 0x4B64
+#define B_BMODE_PDTH_LOWER_BOUND_MSK_V1 GENMASK(31, 24)
+#define R_BMODE_PDTH_EN_V1 0x4B74
+#define B_BMODE_PDTH_LIMIT_EN_MSK_V1 BIT(30)
 #define R_CFO_COMP_SEG1_L 0x5384
 #define R_CFO_COMP_SEG1_H 0x5388
 #define R_CFO_COMP_SEG1_CTRL 0x538C
-- 
2.25.1

