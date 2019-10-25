Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FDFE4762
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 11:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfJYJeB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 05:34:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50490 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJYJd6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 05:33:58 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9P9XppV026487, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9P9XppV026487
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 25 Oct 2019 17:33:51 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 25 Oct 2019 17:33:50 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <g.schlmm@googlemail.com>
Subject: [PATCH 5/6] rtw88: fix potential read outside array boundary
Date:   Fri, 25 Oct 2019 17:33:44 +0800
Message-ID: <20191025093345.22643-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025093345.22643-1-yhchuang@realtek.com>
References: <20191025093345.22643-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

The level of cckpd is from 0 to 4, and it is the index of
array pd_lvl[] and cs_lvl[]. However, the length of both arrays
are 4, which is smaller than the possible maximum input index.
Enumerate cck level to make sure the max level will not be wrong
if new level is added in future.

Fixes: 479c4ee931a6 ("rtw88: add dynamic cck pd mechanism")
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c      | 17 ++++++++---------
 drivers/net/wireless/realtek/rtw88/phy.h      |  9 +++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  4 ++--
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 4a41134c420e..4adba44dbd74 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -109,7 +109,7 @@ static void rtw_phy_cck_pd_init(struct rtw_dev *rtwdev)
 
 	for (i = 0; i <= RTW_CHANNEL_WIDTH_40; i++) {
 		for (j = 0; j < RTW_RF_PATH_MAX; j++)
-			dm_info->cck_pd_lv[i][j] = 0;
+			dm_info->cck_pd_lv[i][j] = CCK_PD_LV0;
 	}
 
 	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
@@ -461,7 +461,6 @@ static void rtw_phy_dpk_track(struct rtw_dev *rtwdev)
 		chip->ops->dpk_track(rtwdev);
 }
 
-#define CCK_PD_LV_MAX		5
 #define CCK_PD_FA_LV1_MIN	1000
 #define CCK_PD_FA_LV0_MAX	500
 
@@ -471,10 +470,10 @@ static u8 rtw_phy_cck_pd_lv_unlink(struct rtw_dev *rtwdev)
 	u32 cck_fa_avg = dm_info->cck_fa_avg;
 
 	if (cck_fa_avg > CCK_PD_FA_LV1_MIN)
-		return 1;
+		return CCK_PD_LV1;
 
 	if (cck_fa_avg < CCK_PD_FA_LV0_MAX)
-		return 0;
+		return CCK_PD_LV0;
 
 	return CCK_PD_LV_MAX;
 }
@@ -494,15 +493,15 @@ static u8 rtw_phy_cck_pd_lv_link(struct rtw_dev *rtwdev)
 	u32 cck_fa_avg = dm_info->cck_fa_avg;
 
 	if (igi > CCK_PD_IGI_LV4_VAL && rssi > CCK_PD_RSSI_LV4_VAL)
-		return 4;
+		return CCK_PD_LV4;
 	if (igi > CCK_PD_IGI_LV3_VAL && rssi > CCK_PD_RSSI_LV3_VAL)
-		return 3;
+		return CCK_PD_LV3;
 	if (igi > CCK_PD_IGI_LV2_VAL || rssi > CCK_PD_RSSI_LV2_VAL)
-		return 2;
+		return CCK_PD_LV2;
 	if (cck_fa_avg > CCK_PD_FA_LV1_MIN)
-		return 1;
+		return CCK_PD_LV1;
 	if (cck_fa_avg < CCK_PD_FA_LV0_MAX)
-		return 0;
+		return CCK_PD_LV0;
 
 	return CCK_PD_LV_MAX;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index c389ef274ed8..af916d8784cd 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -146,6 +146,15 @@ rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path,
 			u8 rate, u8 bw, u8 ch, u8 regd,
 			struct rtw_power_params *pwr_param);
 
+enum rtw_phy_cck_pd_lv {
+	CCK_PD_LV0,
+	CCK_PD_LV1,
+	CCK_PD_LV2,
+	CCK_PD_LV3,
+	CCK_PD_LV4,
+	CCK_PD_LV_MAX,
+};
+
 #define	MASKBYTE0		0xff
 #define	MASKBYTE1		0xff00
 #define	MASKBYTE2		0xff0000
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index b77905196ffb..0c419332fd52 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3295,8 +3295,8 @@ rtw8822c_phy_cck_pd_set_reg(struct rtw_dev *rtwdev,
 static void rtw8822c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
-	s8 pd_lvl[4] = {2, 4, 6, 8};
-	s8 cs_lvl[4] = {2, 2, 2, 4};
+	s8 pd_lvl[CCK_PD_LV_MAX] = {0, 2, 4, 6, 8};
+	s8 cs_lvl[CCK_PD_LV_MAX] = {0, 2, 2, 2, 4};
 	u8 cur_lvl;
 	u8 nrx, bw;
 
-- 
2.17.1

