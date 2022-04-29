Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D62514323
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355058AbiD2HWJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 03:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355042AbiD2HWD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 03:22:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9951BE9FC
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 00:18:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23T7IcxV6001354, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23T7IcxV6001354
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Apr 2022 15:18:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 15:18:37 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 29 Apr
 2022 15:18:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 03/16] rtw89: 8852c: rfk: add LCK
Date:   Fri, 29 Apr 2022 15:17:56 +0800
Message-ID: <20220429071809.32104-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429071809.32104-1-pkshih@realtek.com>
References: <20220429071809.32104-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/29/2022 06:59:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjkgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

LCK is short fro LC Tank calibration. Do this calibration once driver
loads RF parameters table. Since the characteristic can be changed by
temperature, we do this calibration again if difference of thermal value
is over a threshold.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  5 ++
 drivers/net/wireless/realtek/rtw89/reg.h      |  2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  7 +++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 63 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |  2 +
 5 files changed, 79 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d544cf29e588a..41d23711dc354 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2642,6 +2642,10 @@ struct rtw89_mcc_info {
 	u8 table_idx;
 };
 
+struct rtw89_lck_info {
+	u8 thermal[RF_PATH_MAX];
+};
+
 struct rtw89_iqk_info {
 	bool lok_cor_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
 	bool lok_fin_fail[RTW89_IQK_CHS_NR][RTW89_IQK_PATH_NR];
@@ -3114,6 +3118,7 @@ struct rtw89_dev {
 	struct rtw89_iqk_info iqk;
 	struct rtw89_dpk_info dpk;
 	struct rtw89_mcc_info mcc;
+	struct rtw89_lck_info lck;
 	bool is_tssi_mode[RF_PATH_MAX];
 	bool is_bt_iqk_timeout;
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ce472d3b1a665..028c881308237 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3327,6 +3327,8 @@
 #define RR_MIXER_GN GENMASK(4, 3)
 #define RR_XTALX2 0xb8
 #define RR_MALSEL 0xbe
+#define RR_LCK_TRG 0xd3
+#define RR_LCK_TRGSEL BIT(8)
 #define RR_RCKD 0xde
 #define RR_RCKD_POW GENMASK(19, 13)
 #define RR_RCKD_BW BIT(2)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 502627d8141d4..14302ebed3d5e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1771,6 +1771,7 @@ static void rtw8852c_rfk_init(struct rtw89_dev *rtwdev)
 	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
 
 	memset(mcc_info, 0, sizeof(*mcc_info));
+	rtw8852c_lck_init(rtwdev);
 
 	rtw8852c_dack(rtwdev);
 }
@@ -1780,6 +1781,11 @@ static void rtw8852c_rfk_channel(struct rtw89_dev *rtwdev)
 	rtw89_fw_h2c_rf_ntfy_mcc(rtwdev);
 }
 
+static void rtw8852c_rfk_track(struct rtw89_dev *rtwdev)
+{
+	rtw8852c_lck_track(rtwdev);
+}
+
 static u32 rtw8852c_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
 				     enum rtw89_phy_idx phy_idx, s16 ref)
 {
@@ -2708,6 +2714,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.read_phycap		= rtw8852c_read_phycap,
 	.rfk_init		= rtw8852c_rfk_init,
 	.rfk_channel		= rtw8852c_rfk_channel,
+	.rfk_track		= rtw8852c_rfk_track,
 	.power_trim		= rtw8852c_power_trim,
 	.set_txpwr		= rtw8852c_set_txpwr,
 	.set_txpwr_ctrl		= rtw8852c_set_txpwr_ctrl,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 8369370fcc37e..7af21986e79bd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -628,6 +628,69 @@ static void _rxbb_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	}
 }
 
+static void _lck_keep_thermal(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_lck_info *lck = &rtwdev->lck;
+	int path;
+
+	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
+		lck->thermal[path] =
+			ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[LCK] path=%d thermal=0x%x", path, lck->thermal[path]);
+	}
+}
+
+static void _lck(struct rtw89_dev *rtwdev)
+{
+	u32 tmp18[2];
+	int path = rtwdev->dbcc_en ? 2 : 1;
+	int i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK, "[LCK] DO LCK\n");
+
+	tmp18[0] = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
+	tmp18[1] = rtw89_read_rf(rtwdev, RF_PATH_B, RR_CFGCH, RFREG_MASK);
+
+	for (i = 0; i < path; i++) {
+		rtw89_write_rf(rtwdev, i, RR_LCK_TRG, RR_LCK_TRGSEL, 0x1);
+		rtw89_write_rf(rtwdev, i, RR_CFGCH, RFREG_MASK, tmp18[i]);
+		rtw89_write_rf(rtwdev, i, RR_LCK_TRG, RR_LCK_TRGSEL, 0x0);
+	}
+
+	_lck_keep_thermal(rtwdev);
+}
+
+#define RTW8852C_LCK_TH 8
+
+void rtw8852c_lck_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_lck_info *lck = &rtwdev->lck;
+	u8 cur_thermal;
+	int delta;
+	int path;
+
+	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
+		cur_thermal =
+			ewma_thermal_read(&rtwdev->phystat.avg_thermal[path]);
+		delta = abs((int)cur_thermal - lck->thermal[path]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+			    "[LCK] path=%d current thermal=0x%x delta=0x%x\n",
+			    path, cur_thermal, delta);
+
+		if (delta >= RTW8852C_LCK_TH) {
+			_lck(rtwdev);
+			return;
+		}
+	}
+}
+
+void rtw8852c_lck_init(struct rtw89_dev *rtwdev)
+{
+	_lck_keep_thermal(rtwdev);
+}
+
 static
 void rtw8852c_ctrl_bw_ch(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			 u8 central_ch, enum rtw89_band band,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
index 7323183e74d41..4ce76ef4c5e60 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
@@ -11,5 +11,7 @@ void rtw8852c_dack(struct rtw89_dev *rtwdev);
 void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
 			     struct rtw89_channel_params *param,
 			     enum rtw89_phy_idx phy_idx);
+void rtw8852c_lck_init(struct rtw89_dev *rtwdev);
+void rtw8852c_lck_track(struct rtw89_dev *rtwdev);
 
 #endif
-- 
2.25.1

