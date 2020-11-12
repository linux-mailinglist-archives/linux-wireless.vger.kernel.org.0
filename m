Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA3D2AFEC5
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgKLFiw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:52 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38679 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgKLDPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 22:15:37 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC3FVoqC025883, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC3FVoqC025883
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 11:15:31 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 11:15:31 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 08/11] rtw88: coex: fix BT performance drop during initial/power-on step
Date:   Thu, 12 Nov 2020 11:14:27 +0800
Message-ID: <20201112031430.4846-9-pkshih@realtek.com>
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

Force set the coexistence to BT high priority during
WLAN initial/power-on step. Since the duration the related setting
may be not ready yet.

The score board is not related to scan when initialing, remove the scan
parameter.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index d3432e6eb284..2911367019b0 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2368,19 +2368,19 @@ static void __rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
 			__func__);
 	} else if (wifi_only) {
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_WONLY);
-		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_SCAN,
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_ONOFF,
 				    true);
 		coex->stop_dm = true;
 	} else {
 		rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_INIT);
-		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_SCAN,
+		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_ONOFF,
 				    true);
 		coex->stop_dm = false;
 		coex->freeze = true;
 	}
 
 	/* PTA parameter */
-	rtw_coex_table(rtwdev, false, 0);
+	rtw_coex_table(rtwdev, true, 1);
 	rtw_coex_tdma(rtwdev, true, 0);
 	rtw_coex_query_bt_info(rtwdev);
 }
@@ -2388,6 +2388,7 @@ static void __rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
 void rtw_coex_power_on_setting(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
+	u8 table_case = 1;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 
@@ -2404,6 +2405,7 @@ void rtw_coex_power_on_setting(struct rtw_dev *rtwdev)
 	/* set antenna path to BT */
 	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_POWERON);
 
+	rtw_coex_table(rtwdev, true, table_case);
 	/* red x issue */
 	rtw_write8(rtwdev, 0xff1a, 0x0);
 }
-- 
2.21.0

