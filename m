Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94419731989
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 15:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbjFONFf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbjFONFc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 09:05:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40501213F
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 06:05:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35FD55mX4032327, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35FD55mX4032327
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 15 Jun 2023 21:05:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 15 Jun 2023 21:05:24 +0800
Received: from [127.0.1.1] (172.16.16.227) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 15 Jun
 2023 21:05:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] wifi: rtw89: 8851b: rfk: add LCK track
Date:   Thu, 15 Jun 2023 21:04:40 +0800
Message-ID: <20230615130442.18116-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615130442.18116-1-pkshih@realtek.com>
References: <20230615130442.18116-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.227]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

LCK is short for LC Tank calibration. To keep RF performance, do this
calibration if difference of thermal value is over a threshold.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  2 +
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 65 ++++++++++++++++++-
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.h |  2 +
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index b6ffa923133d4..c515bc2a10afd 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3834,6 +3834,7 @@
 #define RR_LCKST_BIN BIT(0)
 #define RR_LCK_TRG 0xd3
 #define RR_LCK_TRGSEL BIT(8)
+#define RR_LCK_ST BIT(4)
 #define RR_MMD 0xd5
 #define RR_MMD_RST_EN BIT(8)
 #define RR_MMD_RST_SYN BIT(6)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index c4254e051be05..3a912896031c0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1546,6 +1546,7 @@ static void rtw8851b_rfk_init(struct rtw89_dev *rtwdev)
 {
 	rtwdev->is_tssi_mode[RF_PATH_A] = false;
 	rtwdev->is_tssi_mode[RF_PATH_B] = false;
+	rtw8851b_lck_init(rtwdev);
 
 	rtw8851b_dpk_init(rtwdev);
 	rtw8851b_aack(rtwdev);
@@ -1578,6 +1579,7 @@ static void rtw8851b_rfk_scan(struct rtw89_dev *rtwdev, bool start)
 static void rtw8851b_rfk_track(struct rtw89_dev *rtwdev)
 {
 	rtw8851b_dpk_track(rtwdev);
+	rtw8851b_lck_track(rtwdev);
 }
 
 static u32 rtw8851b_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 48f1bcc46edad..25dda3ee27a6a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -118,6 +118,8 @@ static const u32 dpk_kip_reg[DPK_KIP_REG_NUM_8851B] = {
 	0x813c, 0x8124, 0xc0ec, 0xc0e8, 0xc0c4, 0xc0d4, 0xc0d8};
 static const u32 dpk_rf_reg[DPK_RF_REG_NUM_8851B] = {0xde, 0x8f, 0x5, 0x10005};
 
+static void _set_ch(struct rtw89_dev *rtwdev, u32 val);
+
 static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	return RF_A;
@@ -3133,7 +3135,7 @@ void rtw8851b_dpk_init(struct rtw89_dev *rtwdev)
 
 void rtw8851b_aack(struct rtw89_dev *rtwdev)
 {
-	u32 tmp05, ib[4];
+	u32 tmp05, tmpd3, ib[4];
 	u32 tmp;
 	int ret;
 	int rek;
@@ -3142,8 +3144,10 @@ void rtw8851b_aack(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]DO AACK\n");
 
 	tmp05 = rtw89_read_rf(rtwdev, RF_PATH_A, RR_RSV1, RFREG_MASK);
+	tmpd3 = rtw89_read_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RFREG_MASK);
 	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_MASK, 0x3);
 	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RFREG_MASK, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_ST, 0x0);
 
 	for (rek = 0; rek < 4; rek++) {
 		rtw89_write_rf(rtwdev, RF_PATH_A, RR_AACK, RFREG_MASK, 0x8201e);
@@ -3171,6 +3175,65 @@ void rtw8851b_aack(struct rtw89_dev *rtwdev)
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]AACK rek = %d\n", rek);
 
 	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RFREG_MASK, tmp05);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RFREG_MASK, tmpd3);
+}
+
+static void _lck_keep_thermal(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_lck_info *lck = &rtwdev->lck;
+
+	lck->thermal[RF_PATH_A] =
+		ewma_thermal_read(&rtwdev->phystat.avg_thermal[RF_PATH_A]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+		    "[LCK] path=%d thermal=0x%x", RF_PATH_A, lck->thermal[RF_PATH_A]);
+}
+
+static void rtw8851b_lck(struct rtw89_dev *rtwdev)
+{
+	u32 tmp05, tmp18, tmpd3;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]DO LCK\n");
+
+	tmp05 = rtw89_read_rf(rtwdev, RF_PATH_A, RR_RSV1, RFREG_MASK);
+	tmp18 = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
+	tmpd3 = rtw89_read_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RFREG_MASK);
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_MASK, 0x3);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RFREG_MASK, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x1);
+
+	_set_ch(rtwdev, tmp18);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RFREG_MASK, tmpd3);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RFREG_MASK, tmp05);
+
+	_lck_keep_thermal(rtwdev);
+}
+
+#define RTW8851B_LCK_TH 8
+
+void rtw8851b_lck_track(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_lck_info *lck = &rtwdev->lck;
+	u8 cur_thermal;
+	int delta;
+
+	cur_thermal =
+		ewma_thermal_read(&rtwdev->phystat.avg_thermal[RF_PATH_A]);
+	delta = abs((int)cur_thermal - lck->thermal[RF_PATH_A]);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
+		    "[LCK] path=%d current thermal=0x%x delta=0x%x\n",
+		    RF_PATH_A, cur_thermal, delta);
+
+	if (delta >= RTW8851B_LCK_TH) {
+		rtw8851b_aack(rtwdev);
+		rtw8851b_lck(rtwdev);
+	}
+}
+
+void rtw8851b_lck_init(struct rtw89_dev *rtwdev)
+{
+	_lck_keep_thermal(rtwdev);
 }
 
 void rtw8851b_rck(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
index bf0c79d58a71d..b66a23d6d3673 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
@@ -8,6 +8,8 @@
 #include "core.h"
 
 void rtw8851b_aack(struct rtw89_dev *rtwdev);
+void rtw8851b_lck_init(struct rtw89_dev *rtwdev);
+void rtw8851b_lck_track(struct rtw89_dev *rtwdev);
 void rtw8851b_rck(struct rtw89_dev *rtwdev);
 void rtw8851b_dack(struct rtw89_dev *rtwdev);
 void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
-- 
2.25.1

