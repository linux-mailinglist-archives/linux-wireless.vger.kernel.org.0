Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551CB7A7494
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjITHpJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 03:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjITHoz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 03:44:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA7DD9
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 00:44:48 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38K7ifvoF803277, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38K7ifvoF803277
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 15:44:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 20 Sep 2023 15:44:41 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 20 Sep
 2023 15:44:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/7] wifi: rtw89: load TX power by rate when RFE parms setup
Date:   Wed, 20 Sep 2023 15:43:20 +0800
Message-ID: <20230920074322.42898-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920074322.42898-1-pkshih@realtek.com>
References: <20230920074322.42898-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Table of TX power by rate only needs to be loaded once. But, we originally
loaded it every time we start core. Now, we load it one time along as RFE
(RF Front End) parameters are determined.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 14 ++++++++++----
 drivers/net/wireless/realtek/rtw89/phy.c  |  3 ---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 362aa0922339..f9467adf0a14 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4008,21 +4008,27 @@ static void rtw89_core_setup_rfe_parms(struct rtw89_dev *rtwdev)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_rfe_parms_conf *conf = chip->rfe_parms_conf;
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	const struct rtw89_rfe_parms *sel;
 	u8 rfe_type = efuse->rfe_type;
 
-	if (!conf)
+	if (!conf) {
+		sel = chip->dflt_parms;
 		goto out;
+	}
 
 	while (conf->rfe_parms) {
 		if (rfe_type == conf->rfe_type) {
-			rtwdev->rfe_parms = conf->rfe_parms;
-			return;
+			sel = conf->rfe_parms;
+			goto out;
 		}
 		conf++;
 	}
 
+	sel = chip->dflt_parms;
+
 out:
-	rtwdev->rfe_parms = chip->dflt_parms;
+	rtwdev->rfe_parms = sel;
+	rtw89_load_txpwr_table(rtwdev, sel->byr_tbl);
 }
 
 static int rtw89_chip_efuse_info_setup(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f86de8c8ce18..f9f203295ee4 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4481,8 +4481,6 @@ static void rtw89_phy_env_monitor_init(struct rtw89_dev *rtwdev)
 
 void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
-
 	rtw89_phy_stat_init(rtwdev);
 
 	rtw89_chip_bb_sethw(rtwdev);
@@ -4498,7 +4496,6 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 
 	rtw89_phy_init_rf_nctl(rtwdev);
 	rtw89_chip_rfk_init(rtwdev);
-	rtw89_load_txpwr_table(rtwdev, rfe_parms->byr_tbl);
 	rtw89_chip_set_txpwr_ctrl(rtwdev);
 	rtw89_chip_power_trim(rtwdev);
 	rtw89_chip_cfg_txrx_path(rtwdev);
-- 
2.25.1

