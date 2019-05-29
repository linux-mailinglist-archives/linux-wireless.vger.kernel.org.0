Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAC12D717
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 09:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfE2HzA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 03:55:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37214 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfE2HzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 03:55:00 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4T7su5L005595, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4T7su5L005595
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Wed, 29 May 2019 15:54:56 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Wed, 29 May 2019 15:54:56 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/11] rtw88: refine flow to get tx power index
Date:   Wed, 29 May 2019 15:54:46 +0800
Message-ID: <1559116487-5244-11-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Add a structure for power parameters including base,
offset, limit and a function to get tx power parameters.
Then, refine flow to get tx power index through the
function.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 55 +++++++++++++++++++-------------
 drivers/net/wireless/realtek/rtw88/phy.h | 11 +++++++
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index c4e43c3..0952fb2 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1598,40 +1598,51 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 	return (s8)rtwdev->chip->max_power_index;
 }
 
-static u8
-rtw_phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
-			   enum rtw_bandwidth bandwidth, u8 channel, u8 regd)
+void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8 rate, u8 bw,
+			     u8 ch, u8 regd, struct rtw_power_params *pwr_param)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_txpwr_idx *pwr_idx;
-	u8 tx_power;
-	u8 group;
-	u8 band;
-	s8 offset, limit;
+	u8 group, band;
+	u8 *base = &pwr_param->pwr_base;
+	s8 *offset = &pwr_param->pwr_offset;
+	s8 *limit = &pwr_param->pwr_limit;
 
-	pwr_idx = &rtwdev->efuse.txpwr_idx_table[rf_path];
-	group = rtw_get_channel_group(channel);
+	pwr_idx = &rtwdev->efuse.txpwr_idx_table[path];
+	group = rtw_get_channel_group(ch);
 
 	/* base power index for 2.4G/5G */
-	if (channel <= 14) {
+	if (ch <= 14) {
 		band = PHY_BAND_2G;
-		tx_power = rtw_phy_get_2g_tx_power_index(rtwdev,
-							 &pwr_idx->pwr_idx_2g,
-							 bandwidth, rate, group);
-		offset = hal->tx_pwr_by_rate_offset_2g[rf_path][rate];
+		*base = rtw_phy_get_2g_tx_power_index(rtwdev,
+						      &pwr_idx->pwr_idx_2g,
+						      bw, rate, group);
+		*offset = hal->tx_pwr_by_rate_offset_2g[path][rate];
 	} else {
 		band = PHY_BAND_5G;
-		tx_power = rtw_phy_get_5g_tx_power_index(rtwdev,
-							 &pwr_idx->pwr_idx_5g,
-							 bandwidth, rate, group);
-		offset = hal->tx_pwr_by_rate_offset_5g[rf_path][rate];
+		*base = rtw_phy_get_5g_tx_power_index(rtwdev,
+						      &pwr_idx->pwr_idx_5g,
+						      bw, rate, group);
+		*offset = hal->tx_pwr_by_rate_offset_5g[path][rate];
 	}
 
-	limit = rtw_phy_get_tx_power_limit(rtwdev, band, bandwidth, rf_path,
-					   rate, channel, regd);
+	*limit = rtw_phy_get_tx_power_limit(rtwdev, band, bw, path,
+					    rate, ch, regd);
+}
+
+u8
+rtw_phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
+			   enum rtw_bandwidth bandwidth, u8 channel, u8 regd)
+{
+	struct rtw_power_params pwr_param = {0};
+	u8 tx_power;
+	s8 offset;
+
+	rtw_get_tx_power_params(rtwdev, rf_path, rate, bandwidth,
+				channel, regd, &pwr_param);
 
-	if (offset > limit)
-		offset = limit;
+	tx_power = pwr_param.pwr_base;
+	offset = min_t(s8, pwr_param.pwr_offset, pwr_param.pwr_limit);
 
 	tx_power += offset;
 
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index 5bd4b9b..7c8eb73 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -105,6 +105,17 @@ static inline int rtw_check_supported_rfe(struct rtw_dev *rtwdev)
 
 void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi);
 
+struct rtw_power_params {
+	u8 pwr_base;
+	s8 pwr_offset;
+	s8 pwr_limit;
+};
+
+void
+rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path,
+			u8 rate, u8 bw, u8 ch, u8 regd,
+			struct rtw_power_params *pwr_param);
+
 #define	MASKBYTE0		0xff
 #define	MASKBYTE1		0xff00
 #define	MASKBYTE2		0xff0000
-- 
2.7.4

