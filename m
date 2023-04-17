Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C233D6E4AA8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDQOEi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDQOEf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 10:04:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1F86BE
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 07:04:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1poPSb-000484-IY; Mon, 17 Apr 2023 16:04:01 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1poPSa-00BtJy-UT; Mon, 17 Apr 2023 16:04:00 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1poPSZ-009OrL-Nf; Mon, 17 Apr 2023 16:03:59 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Hans Ulli Kroll <linux@ulli-kroll.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Pkshih <pkshih@realtek.com>, Tim K <tpkuester@gmail.com>,
        "Alex G ." <mr.nuke.me@gmail.com>,
        Nick Morrow <morrownr@gmail.com>,
        Viktor Petrenko <g0000ga@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        ValdikSS <iam@valdikss.org.ru>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 4/4] wifi: rtw88: call rtw8821c_switch_rf_set() according to chip variant
Date:   Mon, 17 Apr 2023 16:03:58 +0200
Message-Id: <20230417140358.2240429-5-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417140358.2240429-1-s.hauer@pengutronix.de>
References: <20230417140358.2240429-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We have to call rtw8821c_switch_rf_set() with SWITCH_TO_WLG or
SWITCH_TO_BTG according to the chip variant as denoted in rfe_option.
The information which argument to use for which variant has been
taken from the vendor driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9946aca7a72ce..462f69547be03 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1892,6 +1892,7 @@ struct rtw_hal {
 	u8 oem_id;
 	u8 pkg_type;
 	struct rtw_phy_cond phy_cond;
+	bool rfe_btg;
 
 	u8 ps_mode;
 	u8 current_channel;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 94c582a27b9ff..a50753ae235b5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -67,6 +67,17 @@ static int rtw8821c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 
 	hal->pkg_type = map->rfe_option & BIT(5) ? 1 : 0;
 
+	switch (efuse->rfe_option) {
+	case 0x2:
+	case 0x4:
+	case 0x7:
+	case 0xa:
+	case 0xc:
+	case 0xf:
+		hal->rfe_btg = true;
+		break;
+	}
+
 	for (i = 0; i < 4; i++)
 		efuse->txpwr_idx_table[i] = map->txpwr_idx_table[i];
 
@@ -289,6 +300,7 @@ static void rtw8821c_switch_rf_set(struct rtw_dev *rtwdev, u8 rf_set)
 
 static void rtw8821c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
 {
+	struct rtw_hal *hal = &rtwdev->hal;
 	u32 rf_reg18;
 
 	rf_reg18 = rtw_read_rf(rtwdev, RF_PATH_A, 0x18, RFREG_MASK);
@@ -320,11 +332,10 @@ static void rtw8821c_set_channel_rf(struct rtw_dev *rtwdev, u8 channel, u8 bw)
 	}
 
 	if (channel <= 14) {
-		if (rtwdev->efuse.rfe_option == 0)
-			rtw8821c_switch_rf_set(rtwdev, SWITCH_TO_WLG);
-		else if (rtwdev->efuse.rfe_option == 2 ||
-			 rtwdev->efuse.rfe_option == 4)
+		if (hal->rfe_btg)
 			rtw8821c_switch_rf_set(rtwdev, SWITCH_TO_BTG);
+		else
+			rtw8821c_switch_rf_set(rtwdev, SWITCH_TO_WLG);
 		rtw_write_rf(rtwdev, RF_PATH_A, RF_LUTDBG, BIT(6), 0x1);
 		rtw_write_rf(rtwdev, RF_PATH_A, 0x64, 0xf, 0xf);
 	} else {
-- 
2.39.2

