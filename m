Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58812AFED1
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgKLFi6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:58 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38675 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgKLDPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 22:15:37 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC3FVTh8025866, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC3FVTh8025866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 11:15:31 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 11:15:30 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 05/11] rtw88: coex: add the mechanism for RF4CE
Date:   Thu, 12 Nov 2020 11:14:24 +0800
Message-ID: <20201112031430.4846-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201112031430.4846-1-pkshih@realtek.com>
References: <20201112031430.4846-1-pkshih@realtek.com>
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

Add the related coexistence mechanism about RF4CE and WLAN connected
flag to decide control packet is whether higher or normal priority.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 33 ++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index d098a0c2c099..9ab31fbcb593 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1389,6 +1389,31 @@ static void rtw_coex_action_freerun(struct rtw_dev *rtwdev)
 	rtw_coex_tdma(rtwdev, false, 100);
 }
 
+static void rtw_coex_action_rf4ce(struct rtw_dev *rtwdev)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 table_case, tdma_case;
+
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
+
+	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
+	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
+
+	if (efuse->share_ant) {
+		/* Shared-Ant */
+		table_case = 9;
+		tdma_case = 16;
+	} else {
+		/* Non-Shared-Ant */
+		table_case = 100;
+		tdma_case = 100;
+	}
+
+	rtw_coex_table(rtwdev, false, table_case);
+	rtw_coex_tdma(rtwdev, false, tdma_case);
+}
+
 static void rtw_coex_action_bt_whql_test(struct rtw_dev *rtwdev)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
@@ -2179,6 +2204,7 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
+	bool rf4ce_en = false;
 
 	lockdep_assert_held(&rtwdev->mutex);
 
@@ -2234,7 +2260,12 @@ static void rtw_coex_run_coex(struct rtw_dev *rtwdev, u8 reason)
 	coex_stat->wl_coex_mode = COEX_WLINK_2G1PORT;
 	rtw_coex_write_scbd(rtwdev, COEX_SCBD_FIX2M, false);
 	if (coex_stat->bt_disabled) {
-		rtw_coex_action_wl_only(rtwdev);
+		if (coex_stat->wl_connected && rf4ce_en)
+			rtw_coex_action_rf4ce(rtwdev);
+		else if (!coex_stat->wl_connected)
+			rtw_coex_action_wl_not_connected(rtwdev);
+		else
+			rtw_coex_action_wl_only(rtwdev);
 		goto exit;
 	}
 
-- 
2.21.0

