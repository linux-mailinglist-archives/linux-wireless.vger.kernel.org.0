Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0652E3508
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 09:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgL1I03 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 03:26:29 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:40539 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgL1I02 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 03:26:28 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0BS8Pf0S2029963, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0BS8Pf0S2029963
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Dec 2020 16:25:42 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 28 Dec
 2020 16:25:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <vincent_fann@realtek.com>
Subject: [PATCH] rtw88: 8821c: apply CCK PD level which calculates from dynamic mechanism
Date:   Mon, 28 Dec 2020 16:25:16 +0800
Message-ID: <20201228082516.16488-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: vincent_fann <vincent_fann@realtek.com>

Hal function must follow the value that calculates from dynamic mechanism.
Force to set new_lvl to 4 damages receiving ability. System will not able
to reconnect to the AP if wifi unexpected disconnecting at this moment.

Signed-off-by: vincent_fann <vincent_fann@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index fbfd85439d1f..74155c999ebb 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1022,12 +1022,6 @@ static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 	u8 pd[CCK_PD_LV_MAX] = {3, 7, 13, 13, 13};
 	u8 cck_n_rx;
 
-	if (dm_info->min_rssi > 60) {
-		new_lvl = 4;
-		pd[4] = 0x1d;
-		goto set_cck_pd;
-	}
-
 	rtw_dbg(rtwdev, RTW_DBG_PHY, "lv: (%d) -> (%d)\n",
 		dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A], new_lvl);
 
@@ -1044,7 +1038,6 @@ static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 
 	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
 
-set_cck_pd:
 	dm_info->cck_pd_lv[RTW_CHANNEL_WIDTH_20][RF_PATH_A] = new_lvl;
 	rtw_write32_mask(rtwdev, REG_PWRTH, 0x3f0000, pd[new_lvl]);
 	rtw_write32_mask(rtwdev, REG_PWRTH2, 0x1f0000,
-- 
2.21.0

