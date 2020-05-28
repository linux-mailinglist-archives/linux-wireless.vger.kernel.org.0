Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B08C1E5AA3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgE1IWP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 04:22:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55029 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgE1IWO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 04:22:14 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04S8M9tiC004571, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04S8M9tiC004571
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 May 2020 16:22:09 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 28 May 2020 16:22:09 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 28 May 2020 16:22:09 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>
Subject: [PATCH 1/5] rtw88: 8821c: add cck pd settings
Date:   Thu, 28 May 2020 16:22:03 +0800
Message-ID: <20200528082207.26521-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200528082207.26521-1-yhchuang@realtek.com>
References: <20200528082207.26521-1-yhchuang@realtek.com>
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

CCK PD reduces the numbers of false alram in cck rate by dynamically
adjusting the value of power threshold and cs_ratio. We define current
circumstance in to levels, Compared to the previous level, if the
level is changed, we set the new values for power threshold and cs_ratio.
Implement this for 8821c.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 7b6488406836..d46fc9dd949c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1482,6 +1482,7 @@ struct rtw_dm_info {
 	/* [bandwidth 0:20M/1:40M][number of path] */
 	u8 cck_pd_lv[2][RTW_RF_PATH_MAX];
 	u32 cck_fa_avg;
+	u8 cck_pd_default;
 
 	/* save the last rx phy status for debug */
 	s8 rx_snr[RTW_RF_PATH_MAX];
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 749569eab912..16703086d64f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -99,6 +99,7 @@ static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
 	rtwdev->chip->ch_param[2] = rtw_read32_mask(rtwdev, 0xaac, MASKDWORD);
 
 	rtw_phy_init(rtwdev);
+	rtwdev->dm_info.cck_pd_default = rtw_read8(rtwdev, 0xaaa) & 0x1f;
 }
 
 static int rtw8821c_mac_init(struct rtw_dev *rtwdev)
@@ -588,6 +589,29 @@ static void rtw8821c_phy_calibration(struct rtw_dev *rtwdev)
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
+	rtw_write32_mask(rtwdev, 0xa08, 0x3f0000, pd[new_lvl]);
+	rtw_write32_mask(rtwdev, 0xaa8, 0x1f0000,
+			 dm_info->cck_pd_default + new_lvl * 2);
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8821c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -1027,6 +1051,7 @@ static struct rtw_chip_ops rtw8821c_ops = {
 	.cfg_ldo25		= rtw8821c_cfg_ldo25,
 	.false_alarm_statistics	= rtw8821c_false_alarm_statistics,
 	.phy_calibration	= rtw8821c_phy_calibration,
+	.cck_pd_set		= rtw8821c_phy_cck_pd_set,
 };
 
 struct rtw_chip_info rtw8821c_hw_spec = {
-- 
2.17.1

