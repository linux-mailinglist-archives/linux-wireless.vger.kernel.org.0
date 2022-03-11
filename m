Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D233C4D58A6
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 04:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbiCKDFD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 22:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345905AbiCKDFC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 22:05:02 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E901A637E
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 19:04:00 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22B33s0C2021493, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22B33s0C2021493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Mar 2022 11:03:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Mar 2022 11:03:54 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 11:03:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH 05/11] rtw89: add config_rf_reg_v1 to configure RF parameter tables
Date:   Fri, 11 Mar 2022 11:02:55 +0800
Message-ID: <20220311030301.33921-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311030301.33921-1-pkshih@realtek.com>
References: <20220311030301.33921-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/11/2022 02:42:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTEgpFekyCAwMTowNjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The format of RF parameter is changed; it doesn't encode delay parameters
into table, but the delay coding becomes regular pair of register address
and value.

To help firmware to recover RF register settings, we need to download
these parameters to firmware. For v1 format, only download partial
parameters (ignore them with addr < 0x100).

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  2 ++
 drivers/net/wireless/realtek/rtw89/phy.c  | 25 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/phy.h  |  4 ++++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index af73347c40b16..95f105232e807 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2229,6 +2229,8 @@ struct rtw89_phy_table {
 	const struct rtw89_reg2_def *regs;
 	u32 n_regs;
 	enum rtw89_rf_path rf_path;
+	void (*config)(struct rtw89_dev *rtwdev, const struct rtw89_reg2_def *reg,
+		       enum rtw89_rf_path rf_path, void *data);
 };
 
 struct rtw89_txpwr_table {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 43d73ec3f7594..ac211d8973118 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -862,6 +862,21 @@ static void rtw89_phy_config_rf_reg(struct rtw89_dev *rtwdev,
 	}
 }
 
+void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
+				const struct rtw89_reg2_def *reg,
+				enum rtw89_rf_path rf_path,
+				void *extra_data)
+{
+	rtw89_write_rf(rtwdev, rf_path, reg->addr, RFREG_MASK, reg->data);
+
+	if (reg->addr < 0x100)
+		return;
+
+	rtw89_phy_cofig_rf_reg_store(rtwdev, reg, rf_path,
+				     (struct rtw89_fw_h2c_rf_reg_info *)extra_data);
+}
+EXPORT_SYMBOL(rtw89_phy_config_rf_reg_v1);
+
 static int rtw89_phy_sel_headline(struct rtw89_dev *rtwdev,
 				  const struct rtw89_phy_table *table,
 				  u32 *headline_size, u32 *headline_idx,
@@ -1033,6 +1048,8 @@ static u32 rtw89_phy_nctl_poll(struct rtw89_dev *rtwdev)
 
 void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev)
 {
+	void (*config)(struct rtw89_dev *rtwdev, const struct rtw89_reg2_def *reg,
+		       enum rtw89_rf_path rf_path, void *data);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_phy_table *rf_table;
 	struct rtw89_fw_h2c_rf_reg_info *rf_reg_info;
@@ -1043,13 +1060,13 @@ void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev)
 		return;
 
 	for (path = RF_PATH_A; path < chip->rf_path_num; path++) {
-		rf_reg_info->rf_path = path;
 		rf_table = chip->rf_table[path];
-		rtw89_phy_init_reg(rtwdev, rf_table, rtw89_phy_config_rf_reg,
-				   (void *)rf_reg_info);
+		rf_reg_info->rf_path = rf_table->rf_path;
+		config = rf_table->config ? rf_table->config : rtw89_phy_config_rf_reg;
+		rtw89_phy_init_reg(rtwdev, rf_table, config, (void *)rf_reg_info);
 		if (rtw89_phy_config_rf_reg_fw(rtwdev, rf_reg_info))
 			rtw89_warn(rtwdev, "rf path %d reg h2c config failed\n",
-				   path);
+				   rf_reg_info->rf_path);
 	}
 	kfree(rf_reg_info);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index e600e01cbdd17..adcfcb4c24296 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -404,6 +404,10 @@ bool rtw89_phy_write_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			   u32 addr, u32 mask, u32 data);
 void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev);
 void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev);
+void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
+				const struct rtw89_reg2_def *reg,
+				enum rtw89_rf_path rf_path,
+				void *extra_data);
 void rtw89_phy_dm_init(struct rtw89_dev *rtwdev);
 void rtw89_phy_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			   u32 data, enum rtw89_phy_idx phy_idx);
-- 
2.25.1

