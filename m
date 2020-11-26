Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0168C2C4D53
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 03:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbgKZCMz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 21:12:55 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60679 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732926AbgKZCM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 21:12:28 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AQ2CKQc8030316, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AQ2CKQc8030316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Nov 2020 10:12:20 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 26 Nov 2020 10:12:20 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <tony0620emma@gmail.com>, <ku920601@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 03/10] rtw88: coex: update the mechanism for A2DP + PAN
Date:   Thu, 26 Nov 2020 10:10:52 +0800
Message-ID: <20201126021059.11981-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201126021059.11981-1-pkshih@realtek.com>
References: <20201126021059.11981-1-pkshih@realtek.com>
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

Update A2DP+PAN+WL mechanism for CPT(Coexistence Performance Test) to
enhance WL/BT performance at the environment that some specific AP are
existing.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 37 +++++++++++++++++------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 33fef8530db7..c0dbc8a2f913 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1910,6 +1910,7 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 table_case, tdma_case;
+	bool wl_cpt_test = false, bt_cpt_test = false;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 
@@ -1917,16 +1918,29 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
 	if (efuse->share_ant) {
 		/* Shared-Ant */
-		if (coex_stat->wl_gl_busy &&
-		    coex_stat->wl_noisy_level == 0)
-			table_case = 14;
-		else
-			table_case = 10;
+		if (wl_cpt_test) {
+			if (coex_stat->wl_gl_busy) {
+				table_case = 20;
+				tdma_case = 17;
+			} else {
+				table_case = 10;
+				tdma_case = 15;
+			}
+		} else if (bt_cpt_test) {
+			table_case = 26;
+			tdma_case = 26;
+		} else {
+			if (coex_stat->wl_gl_busy &&
+			    coex_stat->wl_noisy_level == 0)
+				table_case = 14;
+			else
+				table_case = 10;
 
-		if (coex_stat->wl_gl_busy)
-			tdma_case = 15;
-		else
-			tdma_case = 20;
+			if (coex_stat->wl_gl_busy)
+				tdma_case = 15;
+			else
+				tdma_case = 20;
+		}
 	} else {
 		/* Non-Shared-Ant */
 		table_case = 112;
@@ -1937,6 +1951,11 @@ static void rtw_coex_action_bt_a2dp_pan(struct rtw_dev *rtwdev)
 			tdma_case = 120;
 	}
 
+	if (wl_cpt_test)
+		rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[1]);
+	else
+		rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
 	rtw_coex_table(rtwdev, false, table_case);
 	rtw_coex_tdma(rtwdev, false, tdma_case);
 }
-- 
2.21.0

