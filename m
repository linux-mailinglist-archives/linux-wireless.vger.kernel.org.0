Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC832AE655
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 03:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgKKCWU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 21:22:20 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39288 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732081AbgKKCWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 21:22:20 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AB2MEdlC027738, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AB2MEdlC027738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Nov 2020 10:22:14 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 11 Nov 2020 10:22:13 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/11] rtw88: coex: remove unnecessary WLAN slot extend
Date:   Wed, 11 Nov 2020 10:21:07 +0800
Message-ID: <20201111022108.9834-11-pkshih@realtek.com>
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

Remove extend 5 ms related operation at WLAN media status notify.
The mechanism should be enable only while DUT connect to a AP that it
doesn't follow our power save control or its rate is decreasing unusually
sensitive. So we extend a extra slot to save the transmission rate.

The original logic will always extend WLAN slot.
It will lead to BT slot always decrease 5 ms.

Remove write scoreboard action at WLAN media status notify.
It has already done in WLAN info notify.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index aef77c377a5b..95e5ff5abae5 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2593,8 +2593,6 @@ void rtw_coex_connect_notify(struct rtw_dev *rtwdev, u8 type)
 void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 type)
 {
 	struct rtw_coex *coex = &rtwdev->coex;
-	struct rtw_coex_stat *coex_stat = &coex->stat;
-	u8 para[6] = {0};
 
 	if (coex->manual_control || coex->stop_dm)
 		return;
@@ -2616,15 +2614,8 @@ void rtw_coex_media_status_notify(struct rtw_dev *rtwdev, u8 type)
 
 		/* Set CCK Rx high Pri */
 		rtw_coex_set_wl_pri_mask(rtwdev, COEX_WLPRI_RX_CCK, 1);
-
-		/* always enable 5ms extend if connect */
-		para[0] = COEX_H2C69_WL_LEAKAP;
-		para[1] = PARA1_H2C69_EN_5MS; /* enable 5ms extend */
-		rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1]);
-		coex_stat->wl_slot_extend = true;
 		rtw_coex_run_coex(rtwdev, COEX_RSN_2GMEDIA);
 	} else {
-		rtw_coex_write_scbd(rtwdev, COEX_SCBD_ACTIVE, false);
 		rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s(): disconnect!!\n",
 			__func__);
 		rtw_coex_set_wl_pri_mask(rtwdev, COEX_WLPRI_RX_CCK, 0);
-- 
2.21.0

