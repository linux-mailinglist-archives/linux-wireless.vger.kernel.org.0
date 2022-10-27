Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79E260EF7B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Oct 2022 07:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiJ0F16 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Oct 2022 01:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ0F1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Oct 2022 01:27:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C281C15A8E3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 22:27:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29R5R8prC019401, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29R5R8prC019401
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Oct 2022 13:27:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 27 Oct 2022 13:27:42 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 27 Oct
 2022 13:27:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/7] wifi: rtw89: collect and send RF parameters to firmware for WoWLAN
Date:   Thu, 27 Oct 2022 13:27:01 +0800
Message-ID: <20221027052707.14605-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027052707.14605-1-pkshih@realtek.com>
References: <20221027052707.14605-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/27/2022 05:04:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzI2IKRVpMggMTE6MzI6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

For WoWLAN mode, we only collect and send RF parameters to Firmware
without writing RF registers. So we add one function to practice it.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c  | 31 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h  |  2 +-
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a0fa9639b5097..4b6c90d5f1b6c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2960,7 +2960,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 		return ret;
 
 	rtw89_phy_init_bb_reg(rtwdev);
-	rtw89_phy_init_rf_reg(rtwdev);
+	rtw89_phy_init_rf_reg(rtwdev, false);
 
 	rtw89_btc_ntfy_init(rtwdev, BTC_MODE_NORMAL);
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 35a0d190434a3..dd46856989830 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -801,6 +801,11 @@ bool rtw89_phy_write_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 }
 EXPORT_SYMBOL(rtw89_phy_write_rf_v1);
 
+static bool rtw89_chip_rf_v1(struct rtw89_dev *rtwdev)
+{
+	return rtwdev->chip->ops->write_rf == rtw89_phy_write_rf_v1;
+}
+
 static void rtw89_phy_bb_reset(struct rtw89_dev *rtwdev,
 			       enum rtw89_phy_idx phy_idx)
 {
@@ -1123,6 +1128,24 @@ static int rtw89_phy_config_rf_reg_fw(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+static void rtw89_phy_config_rf_reg_noio(struct rtw89_dev *rtwdev,
+					 const struct rtw89_reg2_def *reg,
+					 enum rtw89_rf_path rf_path,
+					 void *extra_data)
+{
+	u32 addr = reg->addr;
+
+	if (addr == 0xfe || addr == 0xfd || addr == 0xfc || addr == 0xfb ||
+	    addr == 0xfa || addr == 0xf9)
+		return;
+
+	if (rtw89_chip_rf_v1(rtwdev) && addr < 0x100)
+		return;
+
+	rtw89_phy_cofig_rf_reg_store(rtwdev, reg, rf_path,
+				     (struct rtw89_fw_h2c_rf_reg_info *)extra_data);
+}
+
 static void rtw89_phy_config_rf_reg(struct rtw89_dev *rtwdev,
 				    const struct rtw89_reg2_def *reg,
 				    enum rtw89_rf_path rf_path,
@@ -1335,7 +1358,7 @@ static u32 rtw89_phy_nctl_poll(struct rtw89_dev *rtwdev)
 	return rtw89_phy_read32(rtwdev, 0x8080);
 }
 
-void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev)
+void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio)
 {
 	void (*config)(struct rtw89_dev *rtwdev, const struct rtw89_reg2_def *reg,
 		       enum rtw89_rf_path rf_path, void *data);
@@ -1351,7 +1374,11 @@ void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev)
 	for (path = RF_PATH_A; path < chip->rf_path_num; path++) {
 		rf_table = chip->rf_table[path];
 		rf_reg_info->rf_path = rf_table->rf_path;
-		config = rf_table->config ? rf_table->config : rtw89_phy_config_rf_reg;
+		if (noio)
+			config = rtw89_phy_config_rf_reg_noio;
+		else
+			config = rf_table->config ? rf_table->config :
+				 rtw89_phy_config_rf_reg;
 		rtw89_phy_init_reg(rtwdev, rf_table, config, (void *)rf_reg_info);
 		if (rtw89_phy_config_rf_reg_fw(rtwdev, rf_reg_info))
 			rtw89_warn(rtwdev, "rf path %d reg h2c config failed\n",
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 995c13f6f906c..dac69a02e8687 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -500,7 +500,7 @@ bool rtw89_phy_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 bool rtw89_phy_write_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			   u32 addr, u32 mask, u32 data);
 void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev);
-void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev);
+void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev, bool noio);
 void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
 				const struct rtw89_reg2_def *reg,
 				enum rtw89_rf_path rf_path,
-- 
2.25.1

