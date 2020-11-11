Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813E82AE65C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 03:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbgKKCW1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 21:22:27 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39283 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbgKKCWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 21:22:20 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AB2MDlcC027731, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AB2MDlcC027731
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Nov 2020 10:22:13 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 11 Nov 2020 10:22:13 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 08/11] rtw88: coex: fix BT performance drop during initial/power-on step
Date:   Wed, 11 Nov 2020 10:21:05 +0800
Message-ID: <20201111022108.9834-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201111022108.9834-1-pkshih@realtek.com>
References: <20201111022108.9834-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

diff --git a/drivers/net/wireless/realtek/rtw88/coTÔÈ b/drivers/net/wireless/realtek/rtw88/coex.c8Ilex.cc7216245557..6ec3f45a64c1 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2369,19 +2369,19 @@ static void __rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
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
@@ -2389,6 +2389,7 @@ static void __rtw_coex_init_hw_config(struct rtw_dev *rtwdev, bool wifi_only)
 void rtw_coex_power_on_setting(struct rtw_dev *rtwdev)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
+	u8 table_case = 1;
 
 	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
 
@@ -2405,6 +2406,7 @@ void rtw_coex_power_on_setting(struct rtw_dev *rtwdev)
 	/* set antenna path to BT */
 	rtw_coex_set_ant_path(rtwdev, true, COEX_SET_ANT_POWERON);
 
+	rtw_coex_table(rtwdev, true, table_case);
 	/* red x issue */
 	rtw_write8(rtwdev, 0xff1a, 0x0);
 }
-- 
2.21.0

