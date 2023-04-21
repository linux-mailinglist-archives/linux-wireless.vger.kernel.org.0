Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4287D6EA1C7
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 04:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjDUCqN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 22:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjDUCqL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 22:46:11 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0779C49C2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 19:46:09 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33L2k2oC5015999, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33L2k2oC5015999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 10:46:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 21 Apr 2023 10:46:02 +0800
Received: from localhost.localdomain (172.21.69.188) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 10:46:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <gary.chang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/8] wifi: rtw89: 8851b: add NCTL post table
Date:   Fri, 21 Apr 2023 10:45:46 +0800
Message-ID: <20230421024551.29994-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421024551.29994-1-pkshih@realtek.com>
References: <20230421024551.29994-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

NCTL (nano-controller) is used to assist RF calibration that sends
commands to NCTL so it can reduce IO from driver. 8851B needs additional
settings, so add a table to do things.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 1 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 6 +++++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 6 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6df386a38fb41..890ecb533372c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3162,6 +3162,7 @@ struct rtw89_chip_info {
 	const struct rtw89_phy_table *bb_gain_table;
 	const struct rtw89_phy_table *rf_table[RF_PATH_MAX];
 	const struct rtw89_phy_table *nctl_table;
+	const struct rtw89_rfk_tbl *nctl_post_table;
 	const struct rtw89_txpwr_table *byr_table;
 	const struct rtw89_phy_dig_gain_table *dig_table;
 	const struct rtw89_dig_regs *dig_regs;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c7e9061234169..96fa9f159d0ce 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1400,7 +1400,8 @@ static void rtw89_phy_init_rf_nctl(struct rtw89_dev *rtwdev)
 	rtw89_phy_write32_set(rtwdev, R_IOQ_IQK_DPK, 0x3);
 	rtw89_phy_write32_set(rtwdev, R_GNT_BT_WGT_EN, 0x1);
 	rtw89_phy_write32_set(rtwdev, R_P0_PATH_RST, 0x8000000);
-	rtw89_phy_write32_set(rtwdev, R_P1_PATH_RST, 0x8000000);
+	if (chip->chip_id != RTL8851B)
+		rtw89_phy_write32_set(rtwdev, R_P1_PATH_RST, 0x8000000);
 	if (chip->chip_id == RTL8852B)
 		rtw89_phy_write32_set(rtwdev, R_IOQ_IQK_DPK, 0x2);
 
@@ -1414,6 +1415,9 @@ static void rtw89_phy_init_rf_nctl(struct rtw89_dev *rtwdev)
 
 	nctl_table = chip->nctl_table;
 	rtw89_phy_init_reg(rtwdev, nctl_table, rtw89_phy_config_bb_reg, NULL);
+
+	if (chip->nctl_post_table)
+		rtw89_rfk_parser(rtwdev, chip->nctl_post_table);
 }
 
 static u32 rtw89_phy0_phy1_offset(struct rtw89_dev *rtwdev, u32 addr)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index a0aaac74b0ec8..a67a43303592c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -8,6 +8,7 @@
 #include "phy.h"
 #include "reg.h"
 #include "rtw8851b.h"
+#include "rtw8851b_rfk_table.h"
 #include "rtw8851b_table.h"
 #include "txrx.h"
 #include "util.h"
@@ -44,6 +45,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.bb_gain_table		= &rtw89_8851b_phy_bb_gain_table,
 	.rf_table		= {&rtw89_8851b_phy_radioa_table,},
 	.nctl_table		= &rtw89_8851b_phy_nctl_table,
+	.nctl_post_table	= &rtw8851b_nctl_post_defs_tbl,
 	.byr_table		= &rtw89_8851b_byr_table,
 	.dflt_parms		= &rtw89_8851b_dflt_parms,
 	.rfe_parms_conf		= rtw89_8851b_rfe_parms_conf,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index d7930efd89b72..1e1e6d0af5517 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2085,6 +2085,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.rf_table		= {&rtw89_8852a_phy_radioa_table,
 				   &rtw89_8852a_phy_radiob_table,},
 	.nctl_table		= &rtw89_8852a_phy_nctl_table,
+	.nctl_post_table	= NULL,
 	.byr_table		= &rtw89_8852a_byr_table,
 	.dflt_parms		= &rtw89_8852a_dflt_parms,
 	.rfe_parms_conf		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index eaa2ea0586bc6..f12d250f03127 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2522,6 +2522,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.rf_table		= {&rtw89_8852b_phy_radioa_table,
 				   &rtw89_8852b_phy_radiob_table,},
 	.nctl_table		= &rtw89_8852b_phy_nctl_table,
+	.nctl_post_table	= NULL,
 	.byr_table		= &rtw89_8852b_byr_table,
 	.dflt_parms		= &rtw89_8852b_dflt_parms,
 	.rfe_parms_conf		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ceb819a62efc9..347a19b8eaa05 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2821,6 +2821,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.rf_table		= {&rtw89_8852c_phy_radiob_table,
 				   &rtw89_8852c_phy_radioa_table,},
 	.nctl_table		= &rtw89_8852c_phy_nctl_table,
+	.nctl_post_table	= NULL,
 	.byr_table		= &rtw89_8852c_byr_table,
 	.dflt_parms		= &rtw89_8852c_dflt_parms,
 	.rfe_parms_conf		= NULL,
-- 
2.25.1

