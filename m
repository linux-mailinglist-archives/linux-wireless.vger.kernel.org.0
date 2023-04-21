Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C166EA1CE
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 04:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjDUCqi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 22:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjDUCqh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 22:46:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFCA6EA9
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 19:46:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33L2kOVZ1016490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33L2kOVZ1016490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 10:46:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 21 Apr 2023 10:46:03 +0800
Received: from localhost.localdomain (172.21.69.188) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 10:46:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <gary.chang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] wifi: rtw89: 8851b: add DLE mem and HFC quota
Date:   Fri, 21 Apr 2023 10:45:51 +0800
Message-ID: <20230421024551.29994-9-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

Configure DLE (data link engine) memory size for operating modes.
Similarly, HFC standing for HCI flow control is used to set quota
according to operating modes, which are SCC or download firmware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      |  2 +
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 50 +++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b8019cfc11b20..d93058bb56d12 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1475,6 +1475,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt_52a_wow = {264, 0, 32, 20, 64, 13, 1005, 0, 64, 128, 120,},
 	/* 8852B PCIE WOW */
 	.ple_qt_52b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
+	/* 8851B PCIE WOW */
+	.ple_qt_51b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
 };
 EXPORT_SYMBOL(rtw89_mac_size);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index a8d9847ef0b49..d3922d4fe288a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -817,6 +817,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt58;
 	const struct rtw89_ple_quota ple_qt_52a_wow;
 	const struct rtw89_ple_quota ple_qt_52b_wow;
+	const struct rtw89_ple_quota ple_qt_51b_wow;
 };
 
 extern const struct rtw89_mac_size_set rtw89_mac_size;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index ce5c7a8644c39..b68ebe950c4ef 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -18,6 +18,54 @@
 #define RTW8851B_MODULE_FIRMWARE \
 	RTW8851B_FW_BASENAME ".bin"
 
+static const struct rtw89_hfc_ch_cfg rtw8851b_hfc_chcfg_pcie[] = {
+	{5, 343, grp_0}, /* ACH 0 */
+	{5, 343, grp_0}, /* ACH 1 */
+	{5, 343, grp_0}, /* ACH 2 */
+	{5, 343, grp_0}, /* ACH 3 */
+	{0, 0, grp_0}, /* ACH 4 */
+	{0, 0, grp_0}, /* ACH 5 */
+	{0, 0, grp_0}, /* ACH 6 */
+	{0, 0, grp_0}, /* ACH 7 */
+	{4, 344, grp_0}, /* B0MGQ */
+	{4, 344, grp_0}, /* B0HIQ */
+	{0, 0, grp_0}, /* B1MGQ */
+	{0, 0, grp_0}, /* B1HIQ */
+	{40, 0, 0} /* FWCMDQ */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8851b_hfc_pubcfg_pcie = {
+	448, /* Group 0 */
+	0, /* Group 1 */
+	448, /* Public Max */
+	0 /* WP threshold */
+};
+
+static const struct rtw89_hfc_param_ini rtw8851b_hfc_param_ini_pcie[] = {
+	[RTW89_QTA_SCC] = {rtw8851b_hfc_chcfg_pcie, &rtw8851b_hfc_pubcfg_pcie,
+			   &rtw89_mac_size.hfc_preccfg_pcie, RTW89_HCIFC_POH},
+	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_preccfg_pcie,
+			    RTW89_HCIFC_POH},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
+static const struct rtw89_dle_mem rtw8851b_dle_mem_pcie[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size6,
+			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
+			   &rtw89_mac_size.wde_qt6, &rtw89_mac_size.ple_qt18,
+			   &rtw89_mac_size.ple_qt58},
+	[RTW89_QTA_WOW] = {RTW89_QTA_WOW, &rtw89_mac_size.wde_size6,
+			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
+			   &rtw89_mac_size.wde_qt6, &rtw89_mac_size.ple_qt18,
+			   &rtw89_mac_size.ple_qt_51b_wow},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
+			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,
+			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
+			    &rtw89_mac_size.ple_qt13},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
 static const struct rtw89_xtal_info rtw8851b_xtal_info = {
 	.xcap_reg		= R_AX_XTAL_ON_CTRL3,
 	.sc_xo_mask		= B_AX_XTAL_SC_XO_A_BLOCK_MASK,
@@ -52,6 +100,8 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.max_amsdu_limit	= 3500,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
+	.hfc_param_ini		= rtw8851b_hfc_param_ini_pcie,
+	.dle_mem		= rtw8851b_dle_mem_pcie,
 	.wde_qempty_acq_num     = 4,
 	.wde_qempty_mgq_sel     = 4,
 	.rf_base_addr		= {0xe000},
-- 
2.25.1

