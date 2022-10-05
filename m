Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1376A5F50DD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 10:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJEIdK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 04:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJEIdE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 04:33:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECCA773902
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 01:32:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2958W88H0010386, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2958W88H0010386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Oct 2022 16:32:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 5 Oct 2022 16:32:36 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 5 Oct 2022
 16:32:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <echuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: 8852b: add HFC quota arrays
Date:   Wed, 5 Oct 2022 16:32:10 +0800
Message-ID: <20221005083212.45683-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005083212.45683-1-pkshih@realtek.com>
References: <20221005083212.45683-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/05/2022 03:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzUgpFekyCAwMjo1OTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

HFC is short for HCI flow control. These arrays are used to set quota
according to operating modes, which are SCC or download firmware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index e9bcea35a72a2..8424038d5338b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -11,6 +11,37 @@
 #include "rtw8852b_table.h"
 #include "txrx.h"
 
+static const struct rtw89_hfc_ch_cfg rtw8852b_hfc_chcfg_pcie[] = {
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
+static const struct rtw89_hfc_pub_cfg rtw8852b_hfc_pubcfg_pcie = {
+	448, /* Group 0 */
+	0, /* Group 1 */
+	448, /* Public Max */
+	0 /* WP threshold */
+};
+
+static const struct rtw89_hfc_param_ini rtw8852b_hfc_param_ini_pcie[] = {
+	[RTW89_QTA_SCC] = {rtw8852b_hfc_chcfg_pcie, &rtw8852b_hfc_pubcfg_pcie,
+			   &rtw89_mac_size.hfc_preccfg_pcie, RTW89_HCIFC_POH},
+	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_preccfg_pcie,
+			    RTW89_HCIFC_POH},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
 static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size6,
 			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
@@ -561,6 +592,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.ops			= &rtw8852b_chip_ops,
 	.fifo_size		= 196608,
 	.dle_scc_rsvd_size	= 98304,
+	.hfc_param_ini		= rtw8852b_hfc_param_ini_pcie,
 	.dle_mem		= rtw8852b_dle_mem_pcie,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
-- 
2.25.1

