Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBF95005E4
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 08:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbiDNGXo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 02:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiDNGXf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 02:23:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6AA49F25
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 23:21:11 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23E6L6Zi8001371, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23E6L6Zi8001371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Apr 2022 14:21:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 14:21:05 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 14 Apr
 2022 14:21:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 08/12] rtw89: 8852c: add HFC parameters
Date:   Thu, 14 Apr 2022 14:20:22 +0800
Message-ID: <20220414062027.62638-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414062027.62638-1-pkshih@realtek.com>
References: <20220414062027.62638-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/14/2022 06:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMTQgpFekyCAwMzo1OTowMA==?=
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

HFC is short for HCI flow control, and these parameters is used to
configure PCI quota for TX/RX.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index bb935632ce40d..8be3cb22eb110 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -11,6 +11,37 @@
 #include "rtw8852c.h"
 #include "rtw8852c_table.h"
 
+static const struct rtw89_hfc_ch_cfg rtw8852c_hfc_chcfg_pcie[] = {
+	{13, 1614, grp_0}, /* ACH 0 */
+	{13, 1614, grp_0}, /* ACH 1 */
+	{13, 1614, grp_0}, /* ACH 2 */
+	{13, 1614, grp_0}, /* ACH 3 */
+	{13, 1614, grp_1}, /* ACH 4 */
+	{13, 1614, grp_1}, /* ACH 5 */
+	{13, 1614, grp_1}, /* ACH 6 */
+	{13, 1614, grp_1}, /* ACH 7 */
+	{13, 1614, grp_0}, /* B0MGQ */
+	{13, 1614, grp_0}, /* B0HIQ */
+	{13, 1614, grp_1}, /* B1MGQ */
+	{13, 1614, grp_1}, /* B1HIQ */
+	{40, 0, 0} /* FWCMDQ */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8852c_hfc_pubcfg_pcie = {
+	1614, /* Group 0 */
+	1614, /* Group 1 */
+	3228, /* Public Max */
+	0 /* WP threshold */
+};
+
+static const struct rtw89_hfc_param_ini rtw8852c_hfc_param_ini_pcie[] = {
+	[RTW89_QTA_SCC] = {rtw8852c_hfc_chcfg_pcie, &rtw8852c_hfc_pubcfg_pcie,
+			   &rtw89_mac_size.hfc_preccfg_pcie, RTW89_HCIFC_POH},
+	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_preccfg_pcie,
+			    RTW89_HCIFC_POH},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
 static const struct rtw89_dle_mem rtw8852c_dle_mem_pcie[] = {
 	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size19,
 			   &rtw89_mac_size.ple_size19, &rtw89_mac_size.wde_qt18,
@@ -1116,6 +1147,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.chip_id		= RTL8852C,
 	.ops			= &rtw8852c_chip_ops,
 	.fw_name		= "rtw89/rtw8852c_fw.bin",
+	.hfc_param_ini		= rtw8852c_hfc_param_ini_pcie,
 	.dle_mem		= rtw8852c_dle_mem_pcie,
 	.rf_base_addr		= {0xe000, 0xf000},
 	.pwr_on_seq		= NULL,
-- 
2.25.1

