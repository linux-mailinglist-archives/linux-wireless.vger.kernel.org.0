Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63AC2AE65F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 03:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbgKKCW3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 21:22:29 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39289 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732066AbgKKCWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 21:22:20 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AB2MDdlC027738, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AB2MDdlC027738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Nov 2020 10:22:13 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 11 Nov 2020 10:22:13 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 09/11] rtw88: coex: remove write scan bit to scoreboard in scan and connect notify
Date:   Wed, 11 Nov 2020 10:21:06 +0800
Message-ID: <20201111022108.9834-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201111022108.9834-1-pkshih@realtek.com>
References: <20201111022108.9834-1-pkshih@realtek.com>
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

Remove some action which were writing scan bit to scoreboard,
since these behaviors are redundant.
It is already done in WLAN info notify.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 6ec3f45a64c1..aef77c377a5b 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2489,10 +2489,7 @@ void rtw_coex_scan_notify(struct rtw_dev *rtwdev, u8 type)
 		return;
 
 	coex->freeze = false;
-
-	if (type != COEX_SCAN_FINISH)
-		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_SCAN |
-				    COEX_SCBD_ONOFF, true);
+	rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_ONOFF, true);
 
 	if (type == COEX_SCAN_START_5G) {
 		rtw_dbg(rtwdev, RTW_DBG_COEX,
@@ -2549,8 +2546,7 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 	if (coex->manual_control || coex->stop_dm)
 		return;
 
-	rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_SCAN |
-			    COEX_SCBD_ONOFF, true);
+	rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE | COEX_SCBD_ONOFF, true);
 
 	if (type == COEX_ASSOCIATE_5G_START) {
 		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): 5G start\n",
-- 
2.21.0

