Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F9E2AB2FE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgKIJAU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:00:20 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60059 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbgKIJAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:00:19 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A990CFf8021895, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A990CFf8021895
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 9 Nov 2020 17:00:12 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 9 Nov 2020 17:00:12 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 11/11] rtw88: coex: simplify the setting and condition about WLAN TX limitation
Date:   Mon, 9 Nov 2020 16:59:09 +0800
Message-ID: <20201109085909.9143-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201109085909.9143-1-pkshih@realtek.com>
References: <20201109085909.9143-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Life time related setting is related to WLAN active port number,
not its mode. The original setting may cause poor WLAN performance.

In most case, WLAN TX limitation is helpful for BT in coexistence
scenario, especially for A2DP quality.
So this is necessary to fix the setting and constraint it.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 24 +++++++----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index ad21fba48808..61e91565cd7d 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -38,7 +38,7 @@ static void rtw_coex_limited_tx(struct rtw_dev *rtwdev,
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
-	bool wifi_under_b_mode = false;
+	u8 num_of_active_port = 1;
 
 	if (!chip->scbd_support)
 		return;
@@ -70,17 +70,13 @@ static void rtw_coex_limited_tx(struct rtw_dev *rtwdev,
 		/* set queue life time to avoid can't reach tx retry limit
 		 * if tx is always broken by GNT_BT
 		 */
-		rtw_write8_set(rtwdev, REG_LIFETIME_EN, 0xf);
+		if (num_of_active_port <= 1)
+			rtw_write8_set(rtwdev, REG_LIFETIME_EN, 0xf);
 		rtw_write16(rtwdev, REG_RETRY_LIMIT, 0x0808);
 
 		/* auto rate fallback step within 8 retries */
-		if (wifi_under_b_mode) {
-			rtw_write32(rtwdev, REG_DARFRC, 0x1000000);
-			rtw_write32(rtwdev, REG_DARFRCH, 0x1010101);
-		} else {
-			rtw_write32(rtwdev, REG_DARFRC, 0x1000000);
-			rtw_write32(rtwdev, REG_DARFRCH, 0x4030201);
-		}
+		rtw_write32(rtwdev, REG_DARFRC, 0x1000000);
+		rtw_write32(rtwdev, REG_DARFRCH, 0x4030201);
 	} else {
 		rtw_write8_clr(rtwdev, REG_TX_HANG_CTRL, BIT_EN_GNT_BT_AWAKE);
 		rtw_write8_clr(rtwdev, REG_LIFETIME_EN, 0xf);
@@ -101,18 +97,12 @@ static void rtw_coex_limited_wl(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
-	struct rtw_coex_stat *coex_stat = &coex->stat;
 	bool tx_limit = false;
 	bool tx_agg_ctrl = false;
 
-	if (coex->under_5g ||
-	    coex_dm->bt_status == COEX_BTSTATUS_NCON_IDLE) {
-		/* no need to limit tx */
-	} else {
+	if (!coex->under_5g && coex_dm->bt_status != COEX_BTSTATUS_NCON_IDLE) {
 		tx_limit = true;
-		if (coex_stat->bt_hid_exist || coex_stat->bt_hfp_exist ||
-		    coex_stat->bt_hid_pair_num > 0)
-			tx_agg_ctrl = true;
+		tx_agg_ctrl = true;
 	}
 
 	rtw_coex_limited_tx(rtwdev, tx_limit, tx_agg_ctrl);
-- 
2.21.0

