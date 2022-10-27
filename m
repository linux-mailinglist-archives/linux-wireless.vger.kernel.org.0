Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0C60EF7D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Oct 2022 07:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiJ0F2K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Oct 2022 01:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiJ0F1z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Oct 2022 01:27:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF68E15A8E7
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 22:27:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29R5RAbvC019480, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29R5RAbvC019480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Oct 2022 13:27:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 27 Oct 2022 13:27:44 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 27 Oct
 2022 13:27:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/7] wifi: rtw89: add function to adjust and restore PLE quota
Date:   Thu, 27 Oct 2022 13:27:03 +0800
Message-ID: <20221027052707.14605-4-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

PLE RX quota, which is the setting of RX buffer, is needed to be adjusted
dynamically for WoWLAN mode, and restored when back to normal mode.
The action is not needed for rtw8852c chip.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 32 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  4 +++
 4 files changed, 39 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 90bf7bdb60628..10ccb047d6a06 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2389,6 +2389,7 @@ enum rtw89_dma_ch {
 enum rtw89_qta_mode {
 	RTW89_QTA_SCC,
 	RTW89_QTA_DLFW,
+	RTW89_QTA_WOW,
 
 	/* keep last */
 	RTW89_QTA_INVALID,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index de9708eb97260..061244a28f4b4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1306,6 +1306,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt47 = {525, 0, 32, 20, 1034, 13, 1199, 0, 1053, 62, 160, 1037,},
 	/* PCIE 64 */
 	.ple_qt58 = {147, 0, 16, 20, 157, 13, 229, 0, 172, 14, 24, 0,},
+	/* 8852A PCIE WOW */
+	.ple_qt_52a_wow = {264, 0, 32, 20, 64, 13, 1005, 0, 64, 128, 120,},
 };
 EXPORT_SYMBOL(rtw89_mac_size);
 
@@ -1478,6 +1480,36 @@ static void ple_quota_cfg(struct rtw89_dev *rtwdev,
 		SET_QUOTA(tx_rpt, PLE, 11);
 }
 
+int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow)
+{
+	const struct rtw89_ple_quota *min_cfg, *max_cfg;
+	const struct rtw89_dle_mem *cfg;
+	u32 val;
+
+	if (rtwdev->chip->chip_id == RTL8852C)
+		return 0;
+
+	if (rtwdev->mac.qta_mode != RTW89_QTA_SCC) {
+		rtw89_err(rtwdev, "[ERR]support SCC mode only\n");
+		return -EINVAL;
+	}
+
+	if (wow)
+		cfg = get_dle_mem_cfg(rtwdev, RTW89_QTA_WOW);
+	else
+		cfg = get_dle_mem_cfg(rtwdev, RTW89_QTA_SCC);
+	if (!cfg) {
+		rtw89_err(rtwdev, "[ERR]get_dle_mem_cfg\n");
+		return -EINVAL;
+	}
+
+	min_cfg = cfg->ple_min_qt;
+	max_cfg = cfg->ple_max_qt;
+	SET_QUOTA(cma0_dma, PLE, 6);
+	SET_QUOTA(cma1_dma, PLE, 7);
+
+	return 0;
+}
 #undef SET_QUOTA
 
 static void dle_quota_cfg(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 6e03f5e4ae246..20211c4e62db5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -719,6 +719,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt46;
 	const struct rtw89_ple_quota ple_qt47;
 	const struct rtw89_ple_quota ple_qt58;
+	const struct rtw89_ple_quota ple_qt_52a_wow;
 };
 
 extern const struct rtw89_mac_size_set rtw89_mac_size;
@@ -1026,5 +1027,6 @@ void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 u16 rtw89_mac_dle_buf_req(struct rtw89_dev *rtwdev, u16 buf_len, bool wd);
 int rtw89_mac_set_cpuio(struct rtw89_dev *rtwdev,
 			struct rtw89_cpuio_ctrl *ctrl_para, bool wd);
+int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index b5aa8697a0982..375e84f5fe5c1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -48,6 +48,10 @@ static const struct rtw89_dle_mem rtw8852a_dle_mem_pcie[] = {
 			   &rtw89_mac_size.ple_size0, &rtw89_mac_size.wde_qt0,
 			   &rtw89_mac_size.wde_qt0, &rtw89_mac_size.ple_qt4,
 			   &rtw89_mac_size.ple_qt5},
+	[RTW89_QTA_WOW] = {RTW89_QTA_WOW, &rtw89_mac_size.wde_size0,
+			   &rtw89_mac_size.ple_size0, &rtw89_mac_size.wde_qt0,
+			   &rtw89_mac_size.wde_qt0, &rtw89_mac_size.ple_qt4,
+			   &rtw89_mac_size.ple_qt_52a_wow},
 	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size4,
 			    &rtw89_mac_size.ple_size4, &rtw89_mac_size.wde_qt4,
 			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
-- 
2.25.1

