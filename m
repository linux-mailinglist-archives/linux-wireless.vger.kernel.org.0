Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1F04CCE10
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 07:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiCDGsg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 01:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiCDGsV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 01:48:21 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0E218FAC2
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 22:47:23 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2246lI6O1011685, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2246lI6O1011685
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 4 Mar 2022 14:47:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 14:47:17 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 4 Mar
 2022 14:47:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/13] rtw89: 8852c: add chip::dle_mem
Date:   Fri, 4 Mar 2022 14:46:16 +0800
Message-ID: <20220304064619.23662-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304064619.23662-1-pkshih@realtek.com>
References: <20220304064619.23662-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/04/2022 06:29:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNCCkV6TIIDA0OjM0OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

These tables are used to configure hardware buffer size according to
operating mode.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 62 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      | 10 +++
 drivers/net/wireless/realtek/rtw89/reg.h      |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 12 ++++
 5 files changed, 86 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2dc19b530db62..207ac7e605691 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2168,6 +2168,7 @@ struct rtw89_ple_quota {
 	u16 bb_rpt;
 	u16 wd_rel;
 	u16 cpu_io;
+	u16 tx_rpt;
 };
 
 struct rtw89_dle_mem {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index df657df6b1493..0081cfbfea042 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1183,6 +1183,18 @@ const struct rtw89_dle_size rtw89_wde_size4 = {
 };
 EXPORT_SYMBOL(rtw89_wde_size4);
 
+/* 8852C DLFW */
+const struct rtw89_dle_size rtw89_wde_size18 = {
+	RTW89_WDE_PG_64, 0, 2048,
+};
+EXPORT_SYMBOL(rtw89_wde_size18);
+
+/* 8852C PCIE SCC */
+const struct rtw89_dle_size rtw89_wde_size19 = {
+	RTW89_WDE_PG_64, 3328, 0,
+};
+EXPORT_SYMBOL(rtw89_wde_size19);
+
 /* PCIE */
 const struct rtw89_dle_size rtw89_ple_size0 = {
 	RTW89_PLE_PG_128, 1520, 16,
@@ -1195,6 +1207,18 @@ const struct rtw89_dle_size rtw89_ple_size4 = {
 };
 EXPORT_SYMBOL(rtw89_ple_size4);
 
+/* 8852C DLFW */
+const struct rtw89_dle_size rtw89_ple_size18 = {
+	RTW89_PLE_PG_128, 2544, 16,
+};
+EXPORT_SYMBOL(rtw89_ple_size18);
+
+/* 8852C PCIE SCC */
+const struct rtw89_dle_size rtw89_ple_size19 = {
+	RTW89_PLE_PG_128, 1904, 16,
+};
+EXPORT_SYMBOL(rtw89_ple_size19);
+
 /* PCIE 64 */
 const struct rtw89_wde_quota rtw89_wde_qt0 = {
 	3792, 196, 0, 107,
@@ -1207,6 +1231,18 @@ const struct rtw89_wde_quota rtw89_wde_qt4 = {
 };
 EXPORT_SYMBOL(rtw89_wde_qt4);
 
+/* 8852C DLFW */
+const struct rtw89_wde_quota rtw89_wde_qt17 = {
+	0, 0, 0,  0,
+};
+EXPORT_SYMBOL(rtw89_wde_qt17);
+
+/* 8852C PCIE SCC */
+const struct rtw89_wde_quota rtw89_wde_qt18 = {
+	3228, 60, 0, 40,
+};
+EXPORT_SYMBOL(rtw89_wde_qt18);
+
 /* PCIE SCC */
 const struct rtw89_ple_quota rtw89_ple_qt4 = {
 	264, 0, 16, 20, 26, 13, 356, 0, 32, 40, 8,
@@ -1225,6 +1261,30 @@ const struct rtw89_ple_quota rtw89_ple_qt13 = {
 };
 EXPORT_SYMBOL(rtw89_ple_qt13);
 
+/* DLFW 52C */
+const struct rtw89_ple_quota rtw89_ple_qt44 = {
+	0, 0, 16, 256, 0, 0, 0, 0, 0, 0, 0, 0,
+};
+EXPORT_SYMBOL(rtw89_ple_qt44);
+
+/* DLFW 52C */
+const struct rtw89_ple_quota rtw89_ple_qt45 = {
+	0, 0, 32, 256, 0, 0, 0, 0, 0, 0, 0, 0,
+};
+EXPORT_SYMBOL(rtw89_ple_qt45);
+
+/* 8852C PCIE SCC */
+const struct rtw89_ple_quota rtw89_ple_qt46 = {
+	525, 0, 16, 20, 13, 13, 178, 0, 32, 62, 8, 16,
+};
+EXPORT_SYMBOL(rtw89_ple_qt46);
+
+/* 8852C PCIE SCC */
+const struct rtw89_ple_quota rtw89_ple_qt47 = {
+	525, 0, 32, 20, 1034, 13, 1199, 0, 1053, 62, 160, 1037,
+};
+EXPORT_SYMBOL(rtw89_ple_qt47);
+
 static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
 						   enum rtw89_qta_mode mode)
 {
@@ -1379,6 +1439,8 @@ static void ple_quota_cfg(struct rtw89_dev *rtwdev,
 	SET_QUOTA(bb_rpt, PLE, 8);
 	SET_QUOTA(wd_rel, PLE, 9);
 	SET_QUOTA(cpu_io, PLE, 10);
+	if (rtwdev->chip->chip_id == RTL8852C)
+		SET_QUOTA(tx_rpt, PLE, 11);
 }
 
 #undef SET_QUOTA
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 93595d3e07b99..1b0ae2db05fd2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -675,13 +675,23 @@ enum mac_ax_err_info {
 extern const struct rtw89_hfc_prec_cfg rtw89_hfc_preccfg_pcie;
 extern const struct rtw89_dle_size rtw89_wde_size0;
 extern const struct rtw89_dle_size rtw89_wde_size4;
+extern const struct rtw89_dle_size rtw89_wde_size18;
+extern const struct rtw89_dle_size rtw89_wde_size19;
 extern const struct rtw89_dle_size rtw89_ple_size0;
 extern const struct rtw89_dle_size rtw89_ple_size4;
+extern const struct rtw89_dle_size rtw89_ple_size18;
+extern const struct rtw89_dle_size rtw89_ple_size19;
 extern const struct rtw89_wde_quota rtw89_wde_qt0;
 extern const struct rtw89_wde_quota rtw89_wde_qt4;
+extern const struct rtw89_wde_quota rtw89_wde_qt17;
+extern const struct rtw89_wde_quota rtw89_wde_qt18;
 extern const struct rtw89_ple_quota rtw89_ple_qt4;
 extern const struct rtw89_ple_quota rtw89_ple_qt5;
 extern const struct rtw89_ple_quota rtw89_ple_qt13;
+extern const struct rtw89_ple_quota rtw89_ple_qt44;
+extern const struct rtw89_ple_quota rtw89_ple_qt45;
+extern const struct rtw89_ple_quota rtw89_ple_qt46;
+extern const struct rtw89_ple_quota rtw89_ple_qt47;
 
 static inline u32 rtw89_mac_reg_by_idx(u32 reg_base, u8 band)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 30e05abc7b55f..222aaddbff624 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -554,6 +554,7 @@
 #define R_AX_PLE_QTA8_CFG 0x9060
 #define R_AX_PLE_QTA9_CFG 0x9064
 #define R_AX_PLE_QTA10_CFG 0x9068
+#define R_AX_PLE_QTA11_CFG 0x906C
 
 #define R_AX_PLE_INI_STATUS 0x9100
 #define B_AX_PLE_Q_MGN_INI_RDY BIT(1)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 0b2f4595d1323..fead81d67ff85 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -7,6 +7,17 @@
 #include "reg.h"
 #include "rtw8852c.h"
 
+static const struct rtw89_dle_mem rtw8852c_dle_mem_pcie[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_wde_size19, &rtw89_ple_size19,
+			   &rtw89_wde_qt18, &rtw89_wde_qt18, &rtw89_ple_qt46,
+			   &rtw89_ple_qt47},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_wde_size18,
+			    &rtw89_ple_size18, &rtw89_wde_qt17, &rtw89_wde_qt17,
+			    &rtw89_ple_qt44, &rtw89_ple_qt45},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
 static const u32 rtw8852c_h2c_regs[RTW89_H2CREG_MAX] = {
 	R_AX_H2CREG_DATA0_V1, R_AX_H2CREG_DATA1_V1, R_AX_H2CREG_DATA2_V1,
 	R_AX_H2CREG_DATA3_V1
@@ -210,6 +221,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.chip_id		= RTL8852C,
 	.ops			= &rtw8852c_chip_ops,
 	.fw_name		= "rtw89/rtw8852c_fw.bin",
+	.dle_mem		= rtw8852c_dle_mem_pcie,
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN_V1,
-- 
2.25.1

