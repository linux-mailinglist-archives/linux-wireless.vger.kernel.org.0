Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9736C7A749B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjITHpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 03:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjITHo7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 03:44:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5026BE4
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 00:44:52 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38K7idvP7803255, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38K7idvP7803255
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 15:44:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 20 Sep 2023 15:44:39 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 20 Sep
 2023 15:44:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] wifi: rtw89: indicate TX power by rate table inside RFE parameter
Date:   Wed, 20 Sep 2023 15:43:18 +0800
Message-ID: <20230920074322.42898-4-pkshih@realtek.com>
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

For next-generation chips, TX power by rate table comes from RFE (RF
front end) parameter. It can be different according to RFE type. So,
we indicate TX power by rate table inside RFE parameter ahead. For
current chips, even with different RFE types, a chip is configured
with a single TX power by rate table. So, this commit doesn't really
affect these currently supported chips.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h           | 2 +-
 drivers/net/wireless/realtek/rtw89/phy.c            | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c       | 1 -
 drivers/net/wireless/realtek/rtw89/rtw8851b_table.c | 3 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b_table.h | 1 -
 drivers/net/wireless/realtek/rtw89/rtw8852a.c       | 1 -
 drivers/net/wireless/realtek/rtw89/rtw8852a_table.c | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a_table.h | 1 -
 drivers/net/wireless/realtek/rtw89/rtw8852b.c       | 1 -
 drivers/net/wireless/realtek/rtw89/rtw8852b_table.c | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b_table.h | 1 -
 drivers/net/wireless/realtek/rtw89/rtw8852c.c       | 1 -
 drivers/net/wireless/realtek/rtw89/rtw8852c_table.c | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c_table.h | 1 -
 14 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 61d46d130143..62b0cdecb0f7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3355,6 +3355,7 @@ struct rtw89_txpwr_rule_6ghz {
 };
 
 struct rtw89_rfe_parms {
+	const struct rtw89_txpwr_table *byr_tbl;
 	struct rtw89_txpwr_rule_2ghz rule_2ghz;
 	struct rtw89_txpwr_rule_5ghz rule_5ghz;
 	struct rtw89_txpwr_rule_6ghz rule_6ghz;
@@ -3553,7 +3554,6 @@ struct rtw89_chip_info {
 	const struct rtw89_phy_table *rf_table[RF_PATH_MAX];
 	const struct rtw89_phy_table *nctl_table;
 	const struct rtw89_rfk_tbl *nctl_post_table;
-	const struct rtw89_txpwr_table *byr_table;
 	const struct rtw89_phy_dig_gain_table *dig_table;
 	const struct rtw89_dig_regs *dig_regs;
 	const struct rtw89_phy_tssi_dbw_table *tssi_dbw_table;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 7139146cb3fa..d9f56c510eed 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4474,7 +4474,7 @@ static void rtw89_phy_env_monitor_init(struct rtw89_dev *rtwdev)
 
 void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
 
 	rtw89_phy_stat_init(rtwdev);
 
@@ -4491,7 +4491,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 
 	rtw89_phy_init_rf_nctl(rtwdev);
 	rtw89_chip_rfk_init(rtwdev);
-	rtw89_load_txpwr_table(rtwdev, chip->byr_table);
+	rtw89_load_txpwr_table(rtwdev, rfe_parms->byr_tbl);
 	rtw89_chip_set_txpwr_ctrl(rtwdev);
 	rtw89_chip_power_trim(rtwdev);
 	rtw89_chip_cfg_txrx_path(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index a6170c8f8813..826228117160 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2367,7 +2367,6 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.rf_table		= {&rtw89_8851b_phy_radioa_table,},
 	.nctl_table		= &rtw89_8851b_phy_nctl_table,
 	.nctl_post_table	= &rtw8851b_nctl_post_defs_tbl,
-	.byr_table		= &rtw89_8851b_byr_table,
 	.dflt_parms		= &rtw89_8851b_dflt_parms,
 	.rfe_parms_conf		= rtw89_8851b_rfe_parms_conf,
 	.txpwr_factor_rf	= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
index 58d413f61e98..bd9655385318 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
@@ -14795,6 +14795,7 @@ const struct rtw89_phy_table rtw89_8851b_phy_nctl_table = {
 	.rf_path	= 0, /* don't care */
 };
 
+static
 const struct rtw89_txpwr_table rtw89_8851b_byr_table = {
 	.data = rtw89_8851b_txpwr_byrate,
 	.size = ARRAY_SIZE(rtw89_8851b_txpwr_byrate),
@@ -14811,6 +14812,7 @@ const struct rtw89_txpwr_track_cfg rtw89_8851b_trk_cfg = {
 };
 
 const struct rtw89_rfe_parms rtw89_8851b_dflt_parms = {
+	.byr_tbl = &rtw89_8851b_byr_table,
 	.rule_2ghz = {
 		.lmt = &rtw89_8851b_txpwr_lmt_2g,
 		.lmt_ru = &rtw89_8851b_txpwr_lmt_ru_2g,
@@ -14823,6 +14825,7 @@ const struct rtw89_rfe_parms rtw89_8851b_dflt_parms = {
 };
 
 static const struct rtw89_rfe_parms rtw89_8851b_rfe_parms_type2 = {
+	.byr_tbl = &rtw89_8851b_byr_table,
 	.rule_2ghz = {
 		.lmt = &rtw89_8851b_txpwr_lmt_2g_type2,
 		.lmt_ru = &rtw89_8851b_txpwr_lmt_ru_2g_type2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
index 7967a98d830e..d8cf545d40a0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
@@ -11,7 +11,6 @@ extern const struct rtw89_phy_table rtw89_8851b_phy_bb_table;
 extern const struct rtw89_phy_table rtw89_8851b_phy_bb_gain_table;
 extern const struct rtw89_phy_table rtw89_8851b_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8851b_phy_nctl_table;
-extern const struct rtw89_txpwr_table rtw89_8851b_byr_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8851b_trk_cfg;
 extern const struct rtw89_rfe_parms rtw89_8851b_dflt_parms;
 extern const struct rtw89_rfe_parms_conf rtw89_8851b_rfe_parms_conf[];
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index db2eb93ef87f..c783e17c7ae8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2103,7 +2103,6 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 				   &rtw89_8852a_phy_radiob_table,},
 	.nctl_table		= &rtw89_8852a_phy_nctl_table,
 	.nctl_post_table	= NULL,
-	.byr_table		= &rtw89_8852a_byr_table,
 	.dflt_parms		= &rtw89_8852a_dflt_parms,
 	.rfe_parms_conf		= NULL,
 	.txpwr_factor_rf	= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
index be54194558ff..495890c180ef 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
@@ -51020,6 +51020,7 @@ const struct rtw89_phy_table rtw89_8852a_phy_nctl_table = {
 	.rf_path	= 0, /* don't care */
 };
 
+static
 const struct rtw89_txpwr_table rtw89_8852a_byr_table = {
 	.data = rtw89_8852a_txpwr_byrate,
 	.size = ARRAY_SIZE(rtw89_8852a_txpwr_byrate),
@@ -51049,6 +51050,7 @@ const struct rtw89_phy_dig_gain_table rtw89_8852a_phy_dig_table = {
 };
 
 const struct rtw89_rfe_parms rtw89_8852a_dflt_parms = {
+	.byr_tbl = &rtw89_8852a_byr_table,
 	.rule_2ghz = {
 		.lmt = &rtw89_8852a_txpwr_lmt_2g,
 		.lmt_ru = &rtw89_8852a_txpwr_lmt_ru_2g,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
index 41c379b1044d..7463ae6ee3f9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
@@ -11,7 +11,6 @@ extern const struct rtw89_phy_table rtw89_8852a_phy_bb_table;
 extern const struct rtw89_phy_table rtw89_8852a_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8852a_phy_radiob_table;
 extern const struct rtw89_phy_table rtw89_8852a_phy_nctl_table;
-extern const struct rtw89_txpwr_table rtw89_8852a_byr_table;
 extern const struct rtw89_phy_dig_gain_table rtw89_8852a_phy_dig_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852a_trk_cfg;
 extern const struct rtw89_rfe_parms rtw89_8852a_dflt_parms;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 90764d8c539e..eec421e88697 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2537,7 +2537,6 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 				   &rtw89_8852b_phy_radiob_table,},
 	.nctl_table		= &rtw89_8852b_phy_nctl_table,
 	.nctl_post_table	= NULL,
-	.byr_table		= &rtw89_8852b_byr_table,
 	.dflt_parms		= &rtw89_8852b_dflt_parms,
 	.rfe_parms_conf		= NULL,
 	.txpwr_factor_rf	= 2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
index 0939e37a9c52..e319e216f5c4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
@@ -22860,6 +22860,7 @@ const struct rtw89_phy_table rtw89_8852b_phy_nctl_table = {
 	.rf_path	= 0, /* don't care */
 };
 
+static
 const struct rtw89_txpwr_table rtw89_8852b_byr_table = {
 	.data = rtw89_8852b_txpwr_byrate,
 	.size = ARRAY_SIZE(rtw89_8852b_txpwr_byrate),
@@ -22882,6 +22883,7 @@ const struct rtw89_txpwr_track_cfg rtw89_8852b_trk_cfg = {
 };
 
 const struct rtw89_rfe_parms rtw89_8852b_dflt_parms = {
+	.byr_tbl = &rtw89_8852b_byr_table,
 	.rule_2ghz = {
 		.lmt = &rtw89_8852b_txpwr_lmt_2g,
 		.lmt_ru = &rtw89_8852b_txpwr_lmt_ru_2g,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
index 816b15285c66..da6c90e2ba93 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
@@ -12,7 +12,6 @@ extern const struct rtw89_phy_table rtw89_8852b_phy_bb_gain_table;
 extern const struct rtw89_phy_table rtw89_8852b_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8852b_phy_radiob_table;
 extern const struct rtw89_phy_table rtw89_8852b_phy_nctl_table;
-extern const struct rtw89_txpwr_table rtw89_8852b_byr_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852b_trk_cfg;
 extern const struct rtw89_rfe_parms rtw89_8852b_dflt_parms;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 4d88118f4f6e..aaed74135af2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2845,7 +2845,6 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 				   &rtw89_8852c_phy_radioa_table,},
 	.nctl_table		= &rtw89_8852c_phy_nctl_table,
 	.nctl_post_table	= NULL,
-	.byr_table		= &rtw89_8852c_byr_table,
 	.dflt_parms		= &rtw89_8852c_dflt_parms,
 	.rfe_parms_conf		= NULL,
 	.chanctx_listener	= &rtw8852c_chanctx_listener,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
index 3b393d17a08c..c42aa8778c4d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
@@ -56426,6 +56426,7 @@ const struct rtw89_phy_table rtw89_8852c_phy_nctl_table = {
 	.rf_path	= 0, /* don't care */
 };
 
+static
 const struct rtw89_txpwr_table rtw89_8852c_byr_table = {
 	.data = rtw89_8852c_txpwr_byrate,
 	.size = ARRAY_SIZE(rtw89_8852c_txpwr_byrate),
@@ -56462,6 +56463,7 @@ const struct rtw89_phy_tssi_dbw_table rtw89_8852c_tssi_dbw_table = {
 };
 
 const struct rtw89_rfe_parms rtw89_8852c_dflt_parms = {
+	.byr_tbl = &rtw89_8852c_byr_table,
 	.rule_2ghz = {
 		.lmt = &rtw89_8852c_txpwr_lmt_2g,
 		.lmt_ru = &rtw89_8852c_txpwr_lmt_ru_2g,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
index 4cff36dbf087..7c9f3ecdc4e7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
@@ -12,7 +12,6 @@ extern const struct rtw89_phy_table rtw89_8852c_phy_bb_gain_table;
 extern const struct rtw89_phy_table rtw89_8852c_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8852c_phy_radiob_table;
 extern const struct rtw89_phy_table rtw89_8852c_phy_nctl_table;
-extern const struct rtw89_txpwr_table rtw89_8852c_byr_table;
 extern const struct rtw89_phy_tssi_dbw_table rtw89_8852c_tssi_dbw_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852c_trk_cfg;
 extern const struct rtw89_rfe_parms rtw89_8852c_dflt_parms;
-- 
2.25.1

