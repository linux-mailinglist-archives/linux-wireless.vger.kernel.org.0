Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1C86E4AAA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjDQOEj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjDQOEf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 10:04:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014CD5BA8
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 07:04:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1poPSb-000488-Je; Mon, 17 Apr 2023 16:04:01 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1poPSa-00BtJz-VL; Mon, 17 Apr 2023 16:04:00 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1poPSZ-009OrH-Mt; Mon, 17 Apr 2023 16:03:59 +0200
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
Subject: [PATCH v3 3/4] wifi: rtw88: set pkg_type correctly for specific rtw8821c variants
Date:   Mon, 17 Apr 2023 16:03:57 +0200
Message-Id: <20230417140358.2240429-4-s.hauer@pengutronix.de>
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

According to the vendor driver the pkg_type has to be set to '1'
for some rtw8821c variants. As the pkg_type has been hardcoded to
'0', add a field for it in struct rtw_hal and set this correctly
in the rtw8821c part.
With this parsing of a rtw_table is influenced and check_positive()
in phy.c returns true for some cases here. The same is done in the
vendor driver. However, this has no visible effect on the driver
here.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/realtek/rtw88/main.c     | 2 +-
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index b2e78737bd5d0..421e25353c62f 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1979,7 +1979,7 @@ static int rtw_chip_board_info_setup(struct rtw_dev *rtwdev)
 	if (!rfe_def)
 		return -ENODEV;
 
-	rtw_phy_setup_phy_cond(rtwdev, 0);
+	rtw_phy_setup_phy_cond(rtwdev, hal->pkg_type);
 
 	rtw_phy_init_tx_power(rtwdev);
 	if (rfe_def->agc_btg_tbl)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index d4a53d5567451..9946aca7a72ce 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1890,6 +1890,7 @@ struct rtw_hal {
 	u8 cut_version;
 	u8 mp_chip;
 	u8 oem_id;
+	u8 pkg_type;
 	struct rtw_phy_cond phy_cond;
 
 	u8 ps_mode;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 67efa58dd78ee..94c582a27b9ff 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -41,6 +41,7 @@ enum rtw8821ce_rf_set {
 
 static int rtw8821c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 {
+	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw8821c_efuse *map;
 	int i;
@@ -64,6 +65,8 @@ static int rtw8821c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	efuse->tx_bb_swing_setting_2g = map->tx_bb_swing_setting_2g;
 	efuse->tx_bb_swing_setting_5g = map->tx_bb_swing_setting_5g;
 
+	hal->pkg_type = map->rfe_option & BIT(5) ? 1 : 0;
+
 	for (i = 0; i < 4; i++)
 		efuse->txpwr_idx_table[i] = map->txpwr_idx_table[i];
 
-- 
2.39.2

