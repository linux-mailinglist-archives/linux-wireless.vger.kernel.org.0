Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35FC2D70C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 09:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfE2Hyz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 03:54:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37191 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfE2Hyz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 03:54:55 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4T7sqZB005546, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4T7sqZB005546
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Wed, 29 May 2019 15:54:52 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Wed, 29 May 2019 15:54:51 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 02/11] rtw88: do not use (void *) as argument
Date:   Wed, 29 May 2019 15:54:38 +0800
Message-ID: <1559116487-5244-3-git-send-email-yhchuang@realtek.com>
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

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

The type change from (void *) to (struct rtw_dev *) is redundant.
Just pass the right type and compiler can check that for us.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index ed104ea..d4bcc89 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1079,11 +1079,10 @@ static void phy_get_rate_values_of_txpwr_by_rate(struct rtw_dev *rtwdev,
 	}
 }
 
-static void phy_store_tx_power_by_rate(void *adapter,
+static void phy_store_tx_power_by_rate(struct rtw_dev *rtwdev,
 				       u32 band, u32 rfpath, u32 txnum,
 				       u32 regaddr, u32 bitmask, u32 data)
 {
-	struct rtw_dev *rtwdev = adapter;
 	struct rtw_hal *hal = &rtwdev->hal;
 	u8 rate_num = 0;
 	u8 rate;
@@ -1510,10 +1509,9 @@ static s8 phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 }
 
 static
-u8 phy_get_tx_power_index(void *adapter, u8 rf_path, u8 rate,
+u8 phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
 			  enum rtw_bandwidth bandwidth, u8 channel, u8 regd)
 {
-	struct rtw_dev *rtwdev = adapter;
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_txpwr_idx *pwr_idx;
 	u8 tx_power;
@@ -1553,9 +1551,9 @@ u8 phy_get_tx_power_index(void *adapter, u8 rf_path, u8 rate,
 	return tx_power;
 }
 
-static void phy_set_tx_power_index_by_rs(void *adapter, u8 ch, u8 path, u8 rs)
+static void phy_set_tx_power_index_by_rs(struct rtw_dev *rtwdev,
+					 u8 ch, u8 path, u8 rs)
 {
-	struct rtw_dev *rtwdev = adapter;
 	struct rtw_hal *hal = &rtwdev->hal;
 	u8 regd = rtwdev->regd.txpwr_regd;
 	u8 *rates;
@@ -1573,7 +1571,7 @@ static void phy_set_tx_power_index_by_rs(void *adapter, u8 ch, u8 path, u8 rs)
 	bw = hal->current_band_width;
 	for (i = 0; i < size; i++) {
 		rate = rates[i];
-		pwr_idx = phy_get_tx_power_index(adapter, path, rate, bw, ch,
+		pwr_idx = phy_get_tx_power_index(rtwdev, path, rate, bw, ch,
 						 regd);
 		hal->tx_pwr_tbl[path][rate] = pwr_idx;
 	}
-- 
2.7.4

