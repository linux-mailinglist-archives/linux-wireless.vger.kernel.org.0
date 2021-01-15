Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C97A2F7533
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 10:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbhAOJZt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 04:25:49 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:53877 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAOJZt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 04:25:49 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10F9P2V40001170, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10F9P2V40001170
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Jan 2021 17:25:02 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 15 Jan
 2021 17:25:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH v4 1/8] rtw88: add dynamic rrsr configuration
Date:   Fri, 15 Jan 2021 17:23:58 +0800
Message-ID: <20210115092405.8081-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210115092405.8081-1-pkshih@realtek.com>
References: <20210115092405.8081-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Register rrsr determines the response rate we send.
In field tests, using rate higher than current tx rate could lead
to difficulty for the receiving end to receive management/control
frames. Calculate current modulation level by tx rate then cross out
rate higher than those.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     |  3 +
 drivers/net/wireless/realtek/rtw88/main.h     |  5 ++
 drivers/net/wireless/realtek/rtw88/phy.c      | 62 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/phy.h      |  3 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  2 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  2 -
 6 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e7c1ae454524..07ea9df48149 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -894,6 +894,7 @@ static u64 rtw_update_rate_mask(struct rtw_dev *rtwdev,
 
 void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 {
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	struct ieee80211_sta *sta = si->sta;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_hal *hal = &rtwdev->hal;
@@ -938,6 +939,7 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 		} else {
 			wireless_set = WIRELESS_OFDM;
 		}
+		dm_info->rrsr_val_init = RRSR_INIT_5G;
 	} else if (hal->current_band_type == RTW_BAND_2G) {
 		ra_mask |= sta->supp_rates[NL80211_BAND_2GHZ];
 		if (sta->vht_cap.vht_supported) {
@@ -955,6 +957,7 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 		} else {
 			wireless_set = WIRELESS_CCK | WIRELESS_OFDM;
 		}
+		dm_info->rrsr_val_init = RRSR_INIT_2G;
 	} else {
 		rtw_err(rtwdev, "Unknown band type\n");
 		wireless_set = 0;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9a318dfd04f9..4b5da1247d66 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1488,6 +1488,9 @@ struct rtw_iqk_info {
 	} result;
 };
 
+#define RRSR_INIT_2G 0x15f
+#define RRSR_INIT_5G 0x150
+
 struct rtw_dm_info {
 	u32 cck_fa_cnt;
 	u32 ofdm_fa_cnt;
@@ -1518,6 +1521,8 @@ struct rtw_dm_info {
 	u8 cck_gi_l_bnd;
 
 	u8 tx_rate;
+	u32 rrsr_val_init;
+	u32 rrsr_mask_min;
 	u8 thermal_avg[RTW_RF_PATH_MAX];
 	u8 thermal_meter_k;
 	s8 delta_power_index[RTW_RF_PATH_MAX];
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index d44960cd940c..e114ddecac09 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -465,6 +465,60 @@ static void rtw_phy_ra_info_update(struct rtw_dev *rtwdev)
 	rtw_iterate_stas_atomic(rtwdev, rtw_phy_ra_info_update_iter, rtwdev);
 }
 
+static u32 rtw_phy_get_rrsr_mask(struct rtw_dev *rtwdev, u8 rate_idx)
+{
+	u8 rate_order;
+
+	rate_order = rate_idx;
+
+	if (rate_idx >= DESC_RATEVHT4SS_MCS0)
+		rate_order -= DESC_RATEVHT4SS_MCS0;
+	else if (rate_idx >= DESC_RATEVHT3SS_MCS0)
+		rate_order -= DESC_RATEVHT3SS_MCS0;
+	else if (rate_idx >= DESC_RATEVHT2SS_MCS0)
+		rate_order -= DESC_RATEVHT2SS_MCS0;
+	else if (rate_idx >= DESC_RATEVHT1SS_MCS0)
+		rate_order -= DESC_RATEVHT1SS_MCS0;
+	else if (rate_idx >= DESC_RATEMCS24)
+		rate_order -= DESC_RATEMCS24;
+	else if (rate_idx >= DESC_RATEMCS16)
+		rate_order -= DESC_RATEMCS16;
+	else if (rate_idx >= DESC_RATEMCS8)
+		rate_order -= DESC_RATEMCS8;
+	else if (rate_idx >= DESC_RATEMCS0)
+		rate_order -= DESC_RATEMCS0;
+	else if (rate_idx >= DESC_RATE6M)
+		rate_order -= DESC_RATE6M;
+	else
+		rate_order -= DESC_RATE1M;
+
+	if (rate_idx >= DESC_RATEMCS0 || rate_order == 0)
+		rate_order++;
+
+	return GENMASK(rate_order + RRSR_RATE_ORDER_CCK_LEN - 1, 0);
+}
+
+static void rtw_phy_rrsr_mask_min_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw_dev *rtwdev = (struct rtw_dev *)data;
+	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u32 mask = 0;
+
+	mask = rtw_phy_get_rrsr_mask(rtwdev, si->ra_report.desc_rate);
+	if (mask < dm_info->rrsr_mask_min)
+		dm_info->rrsr_mask_min = mask;
+}
+
+static void rtw_phy_rrsr_update(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	dm_info->rrsr_mask_min = RRSR_RATE_ORDER_MAX;
+	rtw_iterate_stas_atomic(rtwdev, rtw_phy_rrsr_mask_min_iter, rtwdev);
+	rtw_write32(rtwdev, REG_RRSR, dm_info->rrsr_val_init & dm_info->rrsr_mask_min);
+}
+
 static void rtw_phy_dpk_track(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -561,13 +615,19 @@ static void rtw_phy_pwr_track(struct rtw_dev *rtwdev)
 	rtwdev->chip->ops->pwr_track(rtwdev);
 }
 
+static void rtw_phy_ra_track(struct rtw_dev *rtwdev)
+{
+	rtw_phy_ra_info_update(rtwdev);
+	rtw_phy_rrsr_update(rtwdev);
+}
+
 void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev)
 {
 	/* for further calculation */
 	rtw_phy_statistics(rtwdev);
 	rtw_phy_dig(rtwdev);
 	rtw_phy_cck_pd(rtwdev);
-	rtw_phy_ra_info_update(rtwdev);
+	rtw_phy_ra_track(rtwdev);
 	rtw_phy_dpk_track(rtwdev);
 	rtw_phy_pwr_track(rtwdev);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index b924ed07630a..a4fcfb878550 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -185,4 +185,7 @@ enum rtw_phy_cck_pd_lv {
 #define LSSI_READ_EDGE_MASK	0x80000000
 #define LSSI_READ_DATA_MASK	0xfffff
 
+#define RRSR_RATE_ORDER_MAX	0xfffff
+#define RRSR_RATE_ORDER_CCK_LEN	4
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index cf9a3b674d30..ea518aa78552 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -306,6 +306,8 @@
 #define REG_DARFRC		0x0430
 #define REG_DARFRCH		0x0434
 #define REG_RARFRCH		0x043C
+#define REG_RRSR		0x0440
+#define BITS_RRSR_RSC		GENMASK(22, 21)
 #define REG_ARFR0		0x0444
 #define REG_ARFRH0		0x0448
 #define REG_ARFR1_V1		0x044C
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index 32b4771e04d0..bb2495b8609e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -164,8 +164,6 @@ const struct rtw_table name ## _tbl = {			\
 
 #define REG_ANAPARLDO_POW_MAC	0x0029
 #define BIT_LDOE25_PON		BIT(0)
-#define REG_RRSR		0x0440
-#define BITS_RRSR_RSC		(BIT(21) | BIT(22))
 
 #define REG_TXDFIR0	0x808
 #define REG_DFIRBW	0x810
-- 
2.21.0

