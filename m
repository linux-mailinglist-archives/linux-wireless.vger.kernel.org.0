Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5272AB30F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgKIJC2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:02:28 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60588 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgKIJC1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:02:27 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A992LvmC022868, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A992LvmC022868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 9 Nov 2020 17:02:21 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 9 Nov 2020 17:02:20 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] rtw88: 8723d: add cck pd seetings
Date:   Mon, 9 Nov 2020 17:01:22 +0800
Message-ID: <20201109090123.9254-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
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

CCK PD can reduce the number of false alarm of the CCK rates.
It dynamically adjusts the power threshold and CS ratio.
The values are compared to the values of the previous level, if
the level is changed, set new values of power threshold and CS
ratio.

Implement rtw_chip_ops::cck_pd_set() for 8723d.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index f438fd9407cd..1b8447b66cca 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -192,6 +192,7 @@ static void rtw8723d_phy_set_param(struct rtw_dev *rtwdev)
 	rtw_write32(rtwdev, REG_LTR_CTRL_BASIC + 4, WLAN_LTR_CTRL2);
 
 	rtw_phy_init(rtwdev);
+	rtwdev->dm_info.cck_pd_default = rtw_read8(rtwdev, REG_CSRATIO) & 0x1f;
 
 	rtw_write16_set(rtwdev, REG_TXDMA_OFFSET_CHK, BIT_DROP_DATA_EN);
 
@@ -1498,6 +1499,22 @@ static void rtw8723d_phy_calibration(struct rtw_dev *rtwdev)
 	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] finished\n");
 }
 
+static void rtw8723d_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 pd[CCK_PD_LV_MAX] = {3, 7, 13, 13, 13};
+
+	if (dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] == new_lvl)
+		return;
+
+	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
+
+	dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] = new_lvl;
+	rtw_write32_mask(rtwdev, REG_PWRTH, 0x3f0000, pd[new_lvl]);
+	rtw_write32_mask(rtwdev, REG_PWRTH2, 0x1f0000,
+			 dm_info->cck_pd_default + new_lvl * 2);
+}
+
 /* for coex */
 static void rtw8723d_coex_cfg_init(struct rtw_dev *rtwdev)
 {
@@ -1931,6 +1948,7 @@ static struct rtw_chip_ops rtw8723d_ops = {
 	.efuse_grant		= rtw8723d_efuse_grant,
 	.false_alarm_statistics	= rtw8723d_false_alarm_statistics,
 	.phy_calibration	= rtw8723d_phy_calibration,
+	.cck_pd_set		= rtw8723d_phy_cck_pd_set,
 	.pwr_track		= rtw8723d_pwr_track,
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index 7894d321cd7e..41d35174a542 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -163,6 +163,7 @@ static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
 #define REG_CCK0_SYS		0x0a00
 #define BIT_CCK_SIDE_BAND	BIT(4)
 #define REG_CCK_ANT_SEL_11N	0x0a04
+#define REG_PWRTH		0x0a08
 #define REG_CCK_FA_RST_11N	0x0a2c
 #define BIT_MASK_CCK_CNT_KEEP	BIT(12)
 #define BIT_MASK_CCK_CNT_EN	BIT(13)
@@ -175,6 +176,8 @@ static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
 #define REG_CCK_CCA_CNT_11N	0x0a60
 #define BIT_MASK_CCK_FA_MSB	GENMASK(7, 0)
 #define BIT_MASK_CCK_FA_LSB	GENMASK(15, 8)
+#define REG_PWRTH2		0x0aa8
+#define REG_CSRATIO		0x0aaa
 #define REG_OFDM_FA_HOLDC_11N	0x0c00
 #define BIT_MASK_OFDM_FA_KEEP	BIT(31)
 #define REG_BB_RX_PATH_11N	0x0c04
-- 
2.21.0

