Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854E32AFE87
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgKLFit (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:49 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38676 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgKLDPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 22:15:37 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC3FVTj8025866, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC3FVTj8025866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 11:15:31 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 11:15:31 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 07/11] rtw88: coex: Change antenna setting to enhance free-run performance
Date:   Thu, 12 Nov 2020 11:14:26 +0800
Message-ID: <20201112031430.4846-8-pkshih@realtek.com>
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

While the mechanism goes to 2G_free_run or WL5G_BT2G,
set BT to hardware PTA mode to get a more efficiently performance.

Add a flag to indicate antenna switch is supported or not so
that the IC serials which has different antenna structure can
set antenna correctly.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 57b7776cf263..d3432e6eb284 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1061,6 +1061,7 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
 	struct rtw_coex_stat *coex_stat = &coex->stat;
+	struct rtw_coex_rfe *coex_rfe = &coex->rfe;
 	struct rtw_coex_dm *coex_dm = &coex->dm;
 	u8 ctrl_type = COEX_SWITCH_CTRL_MAX;
 	u8 pos_type = COEX_SWITCH_TO_MAX;
@@ -1156,8 +1157,8 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		rtw_dbg(rtwdev, RTW_DBG_COEX,
 			"[BTCoex], %s() - PHASE_5G_RUNTIME\n", __func__);
 
-		/* set GNT_BT to PTA */
-		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_HIGH);
+		/* set GNT_BT to HW PTA */
+		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_HW_PTA);
 
 		/* set GNT_WL to SW high */
 		rtw_coex_set_gnt_wl(rtwdev, COEX_GNT_SET_SW_HIGH);
@@ -1172,8 +1173,8 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		rtw_dbg(rtwdev, RTW_DBG_COEX,
 			"[BTCoex], %s() - PHASE_2G_FREERUN\n", __func__);
 
-		/* set GNT_BT to SW high */
-		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_SW_HIGH);
+		/* set GNT_BT to HW PTA */
+		rtw_coex_set_gnt_bt(rtwdev, COEX_GNT_SET_HW_PTA);
 
 		/* Set GNT_WL to SW high */
 		rtw_coex_set_gnt_wl(rtwdev, COEX_GNT_SET_SW_HIGH);
@@ -1204,7 +1205,8 @@ static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
 		return;
 	}
 
-	if (ctrl_type < COEX_SWITCH_CTRL_MAX && pos_type < COEX_SWITCH_TO_MAX)
+	if (ctrl_type < COEX_SWITCH_CTRL_MAX && pos_type < COEX_SWITCH_TO_MAX &&
+	    coex_rfe->ant_switch_exist)
 		rtw_coex_set_ant_switch(rtwdev, ctrl_type, pos_type);
 }
 
-- 
2.21.0

