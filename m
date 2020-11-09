Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145672AB30E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgKIJC1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:02:27 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60587 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgKIJC0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:02:26 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A992LvoC022868, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A992LvoC022868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 9 Nov 2020 17:02:21 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 9 Nov 2020 17:02:21 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] rtw88: add CCK_PD debug log
Date:   Mon, 9 Nov 2020 17:01:23 +0800
Message-ID: <20201109090123.9254-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201109090123.9254-1-pkshih@realtek.com>
References: <20201109090123.9254-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

In order to help debugging in field, we add some log messages.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c      |  6 ++++++
 drivers/net/wireless/realtek/rtw88/reg.h      |  2 ++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  8 ++++++++
 5 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 5cd9cc42648e..d44960cd940c 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -541,6 +541,12 @@ static void rtw_phy_cck_pd(struct rtw_dev *rtwdev)
 	else
 		dm_info->cck_fa_avg = (dm_info->cck_fa_avg * 3 + cck_fa) >> 2;
 
+	rtw_dbg(rtwdev, RTW_DBG_PHY, "IGI=0x%x, rssi_min=%d, cck_fa=%d\n",
+		dm_info->igi_history[0], dm_info->min_rssi,
+		dm_info->fa_history[0]);
+	rtw_dbg(rtwdev, RTW_DBG_PHY, "cck_fa_avg=%d, cck_pd_default=%d\n",
+		dm_info->cck_fa_avg, dm_info->cck_pd_default);
+
 	level = rtw_phy_cck_pd_lv(rtwdev);
 
 	if (level >= CCK_PD_LV_MAX)
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 2a4275f3d851..cf9a3b674d30 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -489,6 +489,8 @@
 #define REG_2ND_CCA_CTRL	0x0976
 
 #define REG_CCK0_FAREPORT	0xa2c
+#define BIT_CCK0_2RX		BIT(18)
+#define BIT_CCK0_MRC		BIT(22)
 
 #define REG_DIS_DPD		0x0a70
 #define DIS_DPD_MASK		GENMASK(9, 0)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 1b8447b66cca..9268ea8b6dda 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1503,10 +1503,22 @@ static void rtw8723d_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u8 pd[CCK_PD_LV_MAX] = {3, 7, 13, 13, 13};
+	u8 cck_n_rx;
+
+	rtw_dbg(rtwdev, RTW_DBG_PHY, "lv: (%d) -> (%d)\n",
+		dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A], new_lvl);
 
 	if (dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] == new_lvl)
 		return;
 
+	cck_n_rx = (rtw_read8_mask(rtwdev, REG_CCK0_FAREPORT, BIT_CCK0_2RX) &&
+		    rtw_read8_mask(rtwdev, REG_CCK0_FAREPORT, BIT_CCK0_MRC)) ? 2 : 1;
+	rtw_dbg(rtwdev, RTW_DBG_PHY,
+		"is_linked=%d, lv=%d, n_rx=%d, cs_ratio=0x%x, pd_th=0x%x, cck_fa_avg=%d\n",
+		rtw_is_assoc(rtwdev), new_lvl, cck_n_rx,
+		dm_info->cck_pd_default + new_lvl * 2,
+		pd[new_lvl], dm_info->cck_fa_avg);
+
 	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
 
 	dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] = new_lvl;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index ef7da2a9a148..fbfd85439d1f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1020,6 +1020,7 @@ static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u8 pd[CCK_PD_LV_MAX] = {3, 7, 13, 13, 13};
+	u8 cck_n_rx;
 
 	if (dm_info->min_rssi > 60) {
 		new_lvl = 4;
@@ -1027,9 +1028,20 @@ static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 		goto set_cck_pd;
 	}
 
+	rtw_dbg(rtwdev, RTW_DBG_PHY, "lv: (%d) -> (%d)\n",
+		dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A], new_lvl);
+
 	if (dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] == new_lvl)
 		return;
 
+	cck_n_rx = (rtw_read8_mask(rtwdev, REG_CCK0_FAREPORT, BIT_CCK0_2RX) &&
+		    rtw_read8_mask(rtwdev, REG_CCK0_FAREPORT, BIT_CCK0_MRC)) ? 2 : 1;
+	rtw_dbg(rtwdev, RTW_DBG_PHY,
+		"is_linked=%d, lv=%d, n_rx=%d, cs_ratio=0x%x, pd_th=0x%x, cck_fa_avg=%d\n",
+		rtw_is_assoc(rtwdev), new_lvl, cck_n_rx,
+		dm_info->cck_pd_default + new_lvl * 2,
+		pd[new_lvl], dm_info->cck_fa_avg);
+
 	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
 
 set_cck_pd:
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index b91c0e81a2aa..7dd3ccb73793 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3454,6 +3454,10 @@ rtw8822c_phy_cck_pd_set_reg(struct rtw_dev *rtwdev,
 			 rtw8822c_cck_pd_reg[bw][nrx].reg_cs,
 			 rtw8822c_cck_pd_reg[bw][nrx].mask_cs,
 			 cs);
+
+	rtw_dbg(rtwdev, RTW_DBG_PHY,
+		"is_linked=%d, bw=%d, nrx=%d, cs_ratio=0x%x, pd_th=0x%x\n",
+		rtw_is_assoc(rtwdev), bw, nrx, cs, pd);
 }
 
 static void rtw8822c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
@@ -3467,6 +3471,10 @@ static void rtw8822c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 	nrx = (u8)rtw_read32_mask(rtwdev, 0x1a2c, 0x60000);
 	bw = (u8)rtw_read32_mask(rtwdev, 0x9b0, 0xc);
 
+	rtw_dbg(rtwdev, RTW_DBG_PHY, "lv: (%d) -> (%d) bw=%d nr=%d cck_fa_avg=%d\n",
+		dm_info->cck_pd_lv[bw][nrx], new_lvl, bw, nrx,
+		dm_info->cck_fa_avg);
+
 	if (dm_info->cck_pd_lv[bw][nrx] == new_lvl)
 		return;
 
-- 
2.21.0

