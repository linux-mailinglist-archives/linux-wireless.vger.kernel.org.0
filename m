Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF4252E60C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 09:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbiETHSh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 03:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbiETHSc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 03:18:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269573ED17
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 00:18:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24K7HtAV2023730, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24K7HtAV2023730
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 May 2022 15:17:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 20 May 2022 15:17:55 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 20 May
 2022 15:17:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 4/6] rtw89: 8852c: rfk: re-calibrate RX DCK once thermal changes a lot
Date:   Fri, 20 May 2022 15:17:29 +0800
Message-ID: <20220520071731.38563-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520071731.38563-1-pkshih@realtek.com>
References: <20220520071731.38563-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.21]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/20/2022 06:55:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMjAgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RX DCK is receiver DC calibration. To keep good RF performance, do this
calibration again if the delta of thermal value from the last calibration
is more than 8.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  5 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 27 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |  1 +
 4 files changed, 34 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e8a77225a90ff..35619435ea0a2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2646,6 +2646,10 @@ struct rtw89_lck_info {
 	u8 thermal[RF_PATH_MAX];
 };
 
+struct rtw89_rx_dck_info {
+	u8 thermal[RF_PATH_MAX];
+};
+
 struct rtw89_iqk_info {
 	bool lok_cor_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
 	bool lok_fin_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
@@ -3125,6 +3129,7 @@ struct rtw89_dev {
 	struct rtw89_dpk_info dpk;
 	struct rtw89_mcc_info mcc;
 	struct rtw89_lck_info lck;
+	struct rtw89_rx_dck_info rx_dck;
 	bool is_tssi_mode[RF_PATH_MAX];
 	bool is_bt_iqk_timeout;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 64840c8d9efe8..b697aef2faf2d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1861,6 +1861,7 @@ static void rtw8852c_rfk_track(struct rtw89_dev *rtwdev)
 {
 	rtw8852c_dpk_track(rtwdev);
 	rtw8852c_lck_track(rtwdev);
+	rtw8852c_rx_dck_track(rtwdev);
 }
 
 static u32 rtw8852c_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index dfb9caba9bc41..4186d825d19b7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -3864,6 +3864,7 @@ void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_afe)
 {
+	struct rtw89_rx_dck_info *rx_dck = &rtwdev->rx_dck;
 	u8 path, kpath;
 	u32 rf_reg5;
 
@@ -3883,6 +3884,7 @@ void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_a
 		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
 		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RR_MOD_V_RX);
 		_set_rx_dck(rtwdev, phy, path, is_afe);
+		rx_dck->thermal[path] = ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
 		rtw89_write_rf(rtwdev, path, RR_RSV1, RFREG_MASK, rf_reg5);
 
 		if (rtwdev->is_tssi_mode[path])
@@ -3891,6 +3893,31 @@ void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_a
 	}
 }
 
+#define RTW8852C_RX_DCK_TH 8
+
+void rtw8852c_rx_dck_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_rx_dck_info *rx_dck = &rtwdev->rx_dck;
+	u8 cur_thermal;
+	int delta;
+	int path;
+
+	for (path = 0; path < RF_PATH_NUM_8852C; path++) {
+		cur_thermal =
+			ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
+		delta = abs((int)cur_thermal - rx_dck->thermal[path]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[RX_DCK] path=%d current thermal=0x%x delta=0x%x\n",
+			    path, cur_thermal, delta);
+
+		if (delta >= RTW8852C_RX_DCK_TH) {
+			rtw8852c_rx_dck(rtwdev, RTW89_PHY_0, false);
+			return;
+		}
+	}
+}
+
 void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	u32 tx_en;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
index c32756f0c01a9..5118a49da8d3e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
@@ -12,6 +12,7 @@ void rtw8852c_rck(struct rtw89_dev *rtwdev);
 void rtw8852c_dack(struct rtw89_dev *rtwdev);
 void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool is_afe);
+void rtw8852c_rx_dck_track(struct rtw89_dev *rtwdev);
 void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852c_dpk_track(struct rtw89_dev *rtwdev);
 void rtw8852c_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
-- 
2.25.1

