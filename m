Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932B71ECCCA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 11:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFCJmf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 05:42:35 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42383 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgFCJmd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 05:42:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0539gNES1012446, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0539gNES1012446
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 3 Jun 2020 17:42:23 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 3 Jun 2020 17:42:23 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 3 Jun 2020 17:42:23 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v2 1/5] rtw88: 8821c: add cck pd settings
Date:   Wed, 3 Jun 2020 17:42:14 +0800
Message-ID: <20200603094218.19942-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603094218.19942-1-yhchuang@realtek.com>
References: <20200603094218.19942-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

CCK PD can reduce the number of false alarm of the CCK rates.
It dynamically adjusts the power threshold and CS ratio.
The values are compared to the values of the previous level, if
the level is changed, set new values of power threshold and CS
ratio.

Implement rtw_chip_ops::cck_pd_set() for 8821c.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 25 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 82b6accf4744..605a70e311fc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1483,6 +1483,7 @@ struct rtw_dm_info {
 	/* [bandwidth 0:20M/1:40M][number of path] */
 	u8 cck_pd_lv[2][RTW_RF_PATH_MAX];
 	u32 cck_fa_avg;
+	u8 cck_pd_default;
 
 	/* save the last rx phy status for debug */
 	s8 rx_snr[RTW_RF_PATH_MAX];
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 4bd4164d23ef..904eb494ccad 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -102,6 +102,7 @@ static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
 	rtwdev->chip->ch_param[2] = rtw_read32_mask(rtwdev, REG_TXFILTER, MASKDWORD);
 
 	rtw_phy_init(rtwdev);
+	rtwdev->dm_info.cck_pd_default = rtw_read8(rtwdev, REG_CSRATIO) & 0x1f;
 }
 
 static int rtw8821c_mac_init(struct rtw_dev *rtwdev)
@@ -596,6 +597,29 @@ static void rtw8821c_phy_calibration(struct rtw_dev *rtwdev)
 	rtw8821c_do_iqk(rtwdev);
 }
 
+static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 pd[CCK_PD_LV_MAX] = {3, 7, 13, 13, 13};
+
+	if (dm_info->min_rssi > 60) {
+		new_lvl = 4;
+		pd[4] = 0x1d;
+		goto set_cck_pd;
+	}
+
+	if (dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] == new_lvl)
+		return;
+
+	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
+
+set_cck_pd:
+	dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] = new_lvl;
+	rtw_write32_mask(rtwdev, REG_PWRTH, 0x3f0000, pd[new_lvl]);
+	rtw_write32_mask(rtwdev, REG_PWRTH2, 0x1f0000,
+			 dm_info->cck_pd_default + new_lvl * 2);
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8821c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -1035,6 +1059,7 @@ static struct rtw_chip_ops rtw8821c_ops = {
 	.cfg_ldo25		= rtw8821c_cfg_ldo25,
 	.false_alarm_statistics	= rtw8821c_false_alarm_statistics,
 	.phy_calibration	= rtw8821c_phy_calibration,
+	.cck_pd_set		= rtw8821c_phy_cck_pd_set,
 };
 
 struct rtw_chip_info rtw8821c_hw_spec = {
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index 3b7d12bf7728..bc66b91cd961 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -186,11 +186,14 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_FAS		0x9a4
 #define REG_RXSB	0xa00
 #define REG_ADCINI	0xa04
+#define REG_PWRTH	0xa08
 #define REG_TXSF2	0xa24
 #define REG_TXSF6	0xa28
 #define REG_FA_CCK	0xa5c
 #define REG_RXDESC	0xa2c
 #define REG_ENTXCCK	0xa80
+#define REG_PWRTH2	0xaa8
+#define REG_CSRATIO	0xaaa
 #define REG_TXFILTER	0xaac
 #define REG_CNTRST	0xb58
 #define REG_AGCTR_A	0xc08
-- 
2.17.1

