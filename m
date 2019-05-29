Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FFB2D711
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 09:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfE2Hy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 03:54:59 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37207 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfE2Hy6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 03:54:58 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4T7ssrV005568, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4T7ssrV005568
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Wed, 29 May 2019 15:54:54 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Wed, 29 May 2019 15:54:54 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 06/11] rtw88: choose the lowest as world-wide power limit
Date:   Wed, 29 May 2019 15:54:42 +0800
Message-ID: <1559116487-5244-7-git-send-email-yhchuang@realtek.com>
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

When we are loading tx power limit from the power limit table, compare
the world-wide limit with the current limit and choose the lowest power
limit for the world-wide power settings.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index ac6912a..91f8b61 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1165,6 +1165,7 @@ static void rtw_phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
 				       u8 bw, u8 rs, u8 ch, s8 pwr_limit)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
+	s8 ww;
 	int ch_idx;
 
 	pwr_limit = clamp_t(s8, pwr_limit,
@@ -1179,10 +1180,17 @@ static void rtw_phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
 		return;
 	}
 
-	if (band == PHY_BAND_2G)
+	if (band == PHY_BAND_2G) {
 		hal->tx_pwr_limit_2g[regd][bw][rs][ch_idx] = pwr_limit;
-	else if (band == PHY_BAND_5G)
+		ww = hal->tx_pwr_limit_2g[RTW_REGD_WW][bw][rs][ch_idx];
+		ww = min_t(s8, ww, pwr_limit);
+		hal->tx_pwr_limit_2g[RTW_REGD_WW][bw][rs][ch_idx] = ww;
+	} else if (band == PHY_BAND_5G) {
 		hal->tx_pwr_limit_5g[regd][bw][rs][ch_idx] = pwr_limit;
+		ww = hal->tx_pwr_limit_5g[RTW_REGD_WW][bw][rs][ch_idx];
+		ww = min_t(s8, ww, pwr_limit);
+		hal->tx_pwr_limit_5g[RTW_REGD_WW][bw][rs][ch_idx] = ww;
+	}
 }
 
 void rtw_parse_tbl_txpwr_lmt(struct rtw_dev *rtwdev,
-- 
2.7.4

