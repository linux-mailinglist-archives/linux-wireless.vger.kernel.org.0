Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9432D4D925C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 02:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344330AbiCOB52 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 21:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344329AbiCOB50 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 21:57:26 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7473A726
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 18:56:12 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22F1u2Xa9010074, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22F1u2Xa9010074
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Mar 2022 09:56:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 15 Mar 2022 09:56:02 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 15 Mar
 2022 09:56:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw89: reduce export symbol number of mac size and quota
Date:   Tue, 15 Mar 2022 09:55:22 +0800
Message-ID: <20220315015522.11366-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 03/15/2022 01:40:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTQgpFWkyCAxMTo0MzowMA==?=
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

An export symbol costs about 40 bytes (in x86 with gcc), so use a structure
containing these small arrays to reduce code size.

   text	   data	    bss	    dec	    hex	filename
  34932	   1410	      0	  36342	   8df6	mac.o (before)
  34276	   1258	      0	  35534	   8ace	mac.o (after)

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 158 +++++-------------
 drivers/net/wireless/realtek/rtw89/mac.h      |  44 ++---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  18 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  14 +-
 4 files changed, 83 insertions(+), 151 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8fbdfd983cc53..64f6edab26f73 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -482,11 +482,6 @@ int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err)
 }
 EXPORT_SYMBOL(rtw89_mac_set_err_status);
 
-const struct rtw89_hfc_prec_cfg rtw89_hfc_preccfg_pcie = {
-	2, 40, 0, 0, 1, 0, 0, 0
-};
-EXPORT_SYMBOL(rtw89_hfc_preccfg_pcie);
-
 static int hfc_reset_param(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
@@ -1171,119 +1166,48 @@ static int rtw89_mac_sys_init(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
-/* PCIE 64 */
-const struct rtw89_dle_size rtw89_wde_size0 = {
-	RTW89_WDE_PG_64, 4095, 1,
-};
-EXPORT_SYMBOL(rtw89_wde_size0);
-
-/* DLFW */
-const struct rtw89_dle_size rtw89_wde_size4 = {
-	RTW89_WDE_PG_64, 0, 4096,
-};
-EXPORT_SYMBOL(rtw89_wde_size4);
-
-/* 8852C DLFW */
-const struct rtw89_dle_size rtw89_wde_size18 = {
-	RTW89_WDE_PG_64, 0, 2048,
-};
-EXPORT_SYMBOL(rtw89_wde_size18);
-
-/* 8852C PCIE SCC */
-const struct rtw89_dle_size rtw89_wde_size19 = {
-	RTW89_WDE_PG_64, 3328, 0,
-};
-EXPORT_SYMBOL(rtw89_wde_size19);
-
-/* PCIE */
-const struct rtw89_dle_size rtw89_ple_size0 = {
-	RTW89_PLE_PG_128, 1520, 16,
-};
-EXPORT_SYMBOL(rtw89_ple_size0);
-
-/* DLFW */
-const struct rtw89_dle_size rtw89_ple_size4 = {
-	RTW89_PLE_PG_128, 64, 1472,
-};
-EXPORT_SYMBOL(rtw89_ple_size4);
-
-/* 8852C DLFW */
-const struct rtw89_dle_size rtw89_ple_size18 = {
-	RTW89_PLE_PG_128, 2544, 16,
-};
-EXPORT_SYMBOL(rtw89_ple_size18);
-
-/* 8852C PCIE SCC */
-const struct rtw89_dle_size rtw89_ple_size19 = {
-	RTW89_PLE_PG_128, 1904, 16,
-};
-EXPORT_SYMBOL(rtw89_ple_size19);
-
-/* PCIE 64 */
-const struct rtw89_wde_quota rtw89_wde_qt0 = {
-	3792, 196, 0, 107,
-};
-EXPORT_SYMBOL(rtw89_wde_qt0);
-
-/* DLFW */
-const struct rtw89_wde_quota rtw89_wde_qt4 = {
-	0, 0, 0, 0,
-};
-EXPORT_SYMBOL(rtw89_wde_qt4);
-
-/* 8852C DLFW */
-const struct rtw89_wde_quota rtw89_wde_qt17 = {
-	0, 0, 0,  0,
-};
-EXPORT_SYMBOL(rtw89_wde_qt17);
-
-/* 8852C PCIE SCC */
-const struct rtw89_wde_quota rtw89_wde_qt18 = {
-	3228, 60, 0, 40,
-};
-EXPORT_SYMBOL(rtw89_wde_qt18);
-
-/* PCIE SCC */
-const struct rtw89_ple_quota rtw89_ple_qt4 = {
-	264, 0, 16, 20, 26, 13, 356, 0, 32, 40, 8,
-};
-EXPORT_SYMBOL(rtw89_ple_qt4);
-
-/* PCIE SCC */
-const struct rtw89_ple_quota rtw89_ple_qt5 = {
-	264, 0, 32, 20, 64, 13, 1101, 0, 64, 128, 120,
-};
-EXPORT_SYMBOL(rtw89_ple_qt5);
-
-/* DLFW */
-const struct rtw89_ple_quota rtw89_ple_qt13 = {
-	0, 0, 16, 48, 0, 0, 0, 0, 0, 0, 0
-};
-EXPORT_SYMBOL(rtw89_ple_qt13);
-
-/* DLFW 52C */
-const struct rtw89_ple_quota rtw89_ple_qt44 = {
-	0, 0, 16, 256, 0, 0, 0, 0, 0, 0, 0, 0,
-};
-EXPORT_SYMBOL(rtw89_ple_qt44);
-
-/* DLFW 52C */
-const struct rtw89_ple_quota rtw89_ple_qt45 = {
-	0, 0, 32, 256, 0, 0, 0, 0, 0, 0, 0, 0,
-};
-EXPORT_SYMBOL(rtw89_ple_qt45);
-
-/* 8852C PCIE SCC */
-const struct rtw89_ple_quota rtw89_ple_qt46 = {
-	525, 0, 16, 20, 13, 13, 178, 0, 32, 62, 8, 16,
-};
-EXPORT_SYMBOL(rtw89_ple_qt46);
-
-/* 8852C PCIE SCC */
-const struct rtw89_ple_quota rtw89_ple_qt47 = {
-	525, 0, 32, 20, 1034, 13, 1199, 0, 1053, 62, 160, 1037,
+const struct rtw89_mac_size_set rtw89_mac_size = {
+	.hfc_preccfg_pcie = {2, 40, 0, 0, 1, 0, 0, 0},
+	/* PCIE 64 */
+	.wde_size0 = {RTW89_WDE_PG_64, 4095, 1,},
+	/* DLFW */
+	.wde_size4 = {RTW89_WDE_PG_64, 0, 4096,},
+	/* 8852C DLFW */
+	.wde_size18 = {RTW89_WDE_PG_64, 0, 2048,},
+	/* 8852C PCIE SCC */
+	.wde_size19 = {RTW89_WDE_PG_64, 3328, 0,},
+	/* PCIE */
+	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
+	/* DLFW */
+	.ple_size4 = {RTW89_PLE_PG_128, 64, 1472,},
+	/* 8852C DLFW */
+	.ple_size18 = {RTW89_PLE_PG_128, 2544, 16,},
+	/* 8852C PCIE SCC */
+	.ple_size19 = {RTW89_PLE_PG_128, 1904, 16,},
+	/* PCIE 64 */
+	.wde_qt0 = {3792, 196, 0, 107,},
+	/* DLFW */
+	.wde_qt4 = {0, 0, 0, 0,},
+	/* 8852C DLFW */
+	.wde_qt17 = {0, 0, 0,  0,},
+	/* 8852C PCIE SCC */
+	.wde_qt18 = {3228, 60, 0, 40,},
+	/* PCIE SCC */
+	.ple_qt4 = {264, 0, 16, 20, 26, 13, 356, 0, 32, 40, 8,},
+	/* PCIE SCC */
+	.ple_qt5 = {264, 0, 32, 20, 64, 13, 1101, 0, 64, 128, 120,},
+	/* DLFW */
+	.ple_qt13 = {0, 0, 16, 48, 0, 0, 0, 0, 0, 0, 0,},
+	/* DLFW 52C */
+	.ple_qt44 = {0, 0, 16, 256, 0, 0, 0, 0, 0, 0, 0, 0,},
+	/* DLFW 52C */
+	.ple_qt45 = {0, 0, 32, 256, 0, 0, 0, 0, 0, 0, 0, 0,},
+	/* 8852C PCIE SCC */
+	.ple_qt46 = {525, 0, 16, 20, 13, 13, 178, 0, 32, 62, 8, 16,},
+	/* 8852C PCIE SCC */
+	.ple_qt47 = {525, 0, 32, 20, 1034, 13, 1199, 0, 1053, 62, 160, 1037,},
 };
-EXPORT_SYMBOL(rtw89_ple_qt47);
+EXPORT_SYMBOL(rtw89_mac_size);
 
 static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
 						   enum rtw89_qta_mode mode)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 2f707c817fa79..2ac104e475445 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -672,26 +672,30 @@ enum mac_ax_err_info {
 	MAC_AX_SET_ERR_MAX,
 };
 
-extern const struct rtw89_hfc_prec_cfg rtw89_hfc_preccfg_pcie;
-extern const struct rtw89_dle_size rtw89_wde_size0;
-extern const struct rtw89_dle_size rtw89_wde_size4;
-extern const struct rtw89_dle_size rtw89_wde_size18;
-extern const struct rtw89_dle_size rtw89_wde_size19;
-extern const struct rtw89_dle_size rtw89_ple_size0;
-extern const struct rtw89_dle_size rtw89_ple_size4;
-extern const struct rtw89_dle_size rtw89_ple_size18;
-extern const struct rtw89_dle_size rtw89_ple_size19;
-extern const struct rtw89_wde_quota rtw89_wde_qt0;
-extern const struct rtw89_wde_quota rtw89_wde_qt4;
-extern const struct rtw89_wde_quota rtw89_wde_qt17;
-extern const struct rtw89_wde_quota rtw89_wde_qt18;
-extern const struct rtw89_ple_quota rtw89_ple_qt4;
-extern const struct rtw89_ple_quota rtw89_ple_qt5;
-extern const struct rtw89_ple_quota rtw89_ple_qt13;
-extern const struct rtw89_ple_quota rtw89_ple_qt44;
-extern const struct rtw89_ple_quota rtw89_ple_qt45;
-extern const struct rtw89_ple_quota rtw89_ple_qt46;
-extern const struct rtw89_ple_quota rtw89_ple_qt47;
+struct rtw89_mac_size_set {
+	const struct rtw89_hfc_prec_cfg hfc_preccfg_pcie;
+	const struct rtw89_dle_size wde_size0;
+	const struct rtw89_dle_size wde_size4;
+	const struct rtw89_dle_size wde_size18;
+	const struct rtw89_dle_size wde_size19;
+	const struct rtw89_dle_size ple_size0;
+	const struct rtw89_dle_size ple_size4;
+	const struct rtw89_dle_size ple_size18;
+	const struct rtw89_dle_size ple_size19;
+	const struct rtw89_wde_quota wde_qt0;
+	const struct rtw89_wde_quota wde_qt4;
+	const struct rtw89_wde_quota wde_qt17;
+	const struct rtw89_wde_quota wde_qt18;
+	const struct rtw89_ple_quota ple_qt4;
+	const struct rtw89_ple_quota ple_qt5;
+	const struct rtw89_ple_quota ple_qt13;
+	const struct rtw89_ple_quota ple_qt44;
+	const struct rtw89_ple_quota ple_qt45;
+	const struct rtw89_ple_quota ple_qt46;
+	const struct rtw89_ple_quota ple_qt47;
+};
+
+extern const struct rtw89_mac_size_set rtw89_mac_size;
 
 static inline u32 rtw89_mac_reg_by_idx(u32 reg_base, u8 band)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index c429eeae1b567..f256edbe4afad 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -37,19 +37,21 @@ static const struct rtw89_hfc_pub_cfg rtw8852a_hfc_pubcfg_pcie = {
 
 static const struct rtw89_hfc_param_ini rtw8852a_hfc_param_ini_pcie[] = {
 	[RTW89_QTA_SCC] = {rtw8852a_hfc_chcfg_pcie, &rtw8852a_hfc_pubcfg_pcie,
-			   &rtw89_hfc_preccfg_pcie, RTW89_HCIFC_POH},
-	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_hfc_preccfg_pcie,
+			   &rtw89_mac_size.hfc_preccfg_pcie, RTW89_HCIFC_POH},
+	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_preccfg_pcie,
 			    RTW89_HCIFC_POH},
 	[RTW89_QTA_INVALID] = {NULL},
 };
 
 static const struct rtw89_dle_mem rtw8852a_dle_mem_pcie[] = {
-	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_wde_size0, &rtw89_ple_size0,
-			   &rtw89_wde_qt0, &rtw89_wde_qt0, &rtw89_ple_qt4,
-			   &rtw89_ple_qt5},
-	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_wde_size4, &rtw89_ple_size4,
-			    &rtw89_wde_qt4, &rtw89_wde_qt4, &rtw89_ple_qt13,
-			    &rtw89_ple_qt13},
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size0,
+			   &rtw89_mac_size.ple_size0, &rtw89_mac_size.wde_qt0,
+			   &rtw89_mac_size.wde_qt0, &rtw89_mac_size.ple_qt4,
+			   &rtw89_mac_size.ple_qt5},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size4,
+			    &rtw89_mac_size.ple_size4, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
+			    &rtw89_mac_size.ple_qt13},
 	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
 			       NULL},
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 35a9f40af3c99..ecf8b45240fe0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -9,12 +9,14 @@
 #include "rtw8852c.h"
 
 static const struct rtw89_dle_mem rtw8852c_dle_mem_pcie[] = {
-	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_wde_size19, &rtw89_ple_size19,
-			   &rtw89_wde_qt18, &rtw89_wde_qt18, &rtw89_ple_qt46,
-			   &rtw89_ple_qt47},
-	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_wde_size18,
-			    &rtw89_ple_size18, &rtw89_wde_qt17, &rtw89_wde_qt17,
-			    &rtw89_ple_qt44, &rtw89_ple_qt45},
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size19,
+			   &rtw89_mac_size.ple_size19, &rtw89_mac_size.wde_qt18,
+			   &rtw89_mac_size.wde_qt18, &rtw89_mac_size.ple_qt46,
+			   &rtw89_mac_size.ple_qt47},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size18,
+			    &rtw89_mac_size.ple_size18, &rtw89_mac_size.wde_qt17,
+			    &rtw89_mac_size.wde_qt17, &rtw89_mac_size.ple_qt44,
+			    &rtw89_mac_size.ple_qt45},
 	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
 			       NULL},
 };
-- 
2.25.1

