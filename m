Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B412C38CE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 06:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgKYFk3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 00:40:29 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45831 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgKYFkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 00:40:24 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AP5eINQ1026142, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AP5eINQ1026142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 Nov 2020 13:40:18 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 25 Nov 2020 13:40:17 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <yhchuang@realtek.com>, <ku920601@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 06/10] rtw88: coex: change the coexistence mechanism for WLAN connected
Date:   Wed, 25 Nov 2020 13:38:57 +0800
Message-ID: <20201125053901.29678-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201125053901.29678-1-pkshih@realtek.com>
References: <20201125053901.29678-1-pkshih@realtek.com>
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

Add a flag to make decision whether the mechanism
should go into free-run mode or not.
For now, it is always false, the flag assignment will
be implemented later.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 8ea5e115a81e..fc96641dd133 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2179,6 +2179,7 @@ static void rtw_coex_action_wl_connected(struct rtw_dev *rtwdev)
 	struct rtw_coex_stat *coex_stat = &coex->stat;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	bool freerun_check = false;
 	u8 algorithm;
 
 	/* Non-Shared-Ant */
@@ -2198,10 +2199,15 @@ static void rtw_coex_action_wl_connected(struct rtw_dev *rtwdev)
 		rtw_coex_action_bt_hfp(rtwdev);
 		break;
 	case COEX_ALGO_HID:
-		rtw_coex_action_bt_hid(rtwdev);
+		if (freerun_check)
+			rtw_coex_action_freerun(rtwdev);
+		else
+			rtw_coex_action_bt_hid(rtwdev);
 		break;
 	case COEX_ALGO_A2DP:
-		if (coex_stat->bt_a2dp_sink)
+		if (freerun_check)
+			rtw_coex_action_freerun(rtwdev);
+		else if (coex_stat->bt_a2dp_sink)
 			rtw_coex_action_bt_a2dpsink(rtwdev);
 		else
 			rtw_coex_action_bt_a2dp(rtwdev);
@@ -2210,7 +2216,10 @@ static void rtw_coex_action_wl_connected(struct rtw_dev *rtwdev)
 		rtw_coex_action_bt_pan(rtwdev);
 		break;
 	case COEX_ALGO_A2DP_HID:
-		rtw_coex_action_bt_a2dp_hid(rtwdev);
+		if (freerun_check)
+			rtw_coex_action_freerun(rtwdev);
+		else
+			rtw_coex_action_bt_a2dp_hid(rtwdev);
 		break;
 	case COEX_ALGO_A2DP_PAN:
 		rtw_coex_action_bt_a2dp_pan(rtwdev);
-- 
2.21.0

