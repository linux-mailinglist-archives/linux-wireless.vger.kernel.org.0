Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657127DDD18
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 08:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjKAHWq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 03:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjKAHWp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 03:22:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E7E4
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 00:22:42 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A17MVlD41220475, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A17MVlD41220475
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 15:22:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 1 Nov 2023 15:22:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 1 Nov 2023
 15:22:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw89: pci: add PCI generation information to pci_info for each chip
Date:   Wed, 1 Nov 2023 15:21:45 +0800
Message-ID: <20231101072149.21997-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101072149.21997-1-pkshih@realtek.com>
References: <20231101072149.21997-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: license violation
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to reuse PCI initial and configuration flows, add struct
rtw89_pci_gen_def to abstract the differences between WiFi 6/7 generations.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c       |  4 ++++
 drivers/net/wireless/realtek/rtw89/pci.h       |  6 ++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c    | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851be.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c |  1 +
 8 files changed, 27 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/pci_be.c

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index b2de5280d934..411e9c270638 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3853,6 +3853,10 @@ static int __maybe_unused rtw89_pci_resume(struct device *dev)
 SIMPLE_DEV_PM_OPS(rtw89_pm_ops, rtw89_pci_suspend, rtw89_pci_resume);
 EXPORT_SYMBOL(rtw89_pm_ops);
 
+const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
+};
+EXPORT_SYMBOL(rtw89_pci_gen_ax);
+
 static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.tx_write	= rtw89_pci_ops_tx_write,
 	.tx_kick_off	= rtw89_pci_ops_tx_kick_off,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index fe1019ae5e5b..f4662c7057ee 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -922,7 +922,11 @@ struct rtw89_pci_bd_ram {
 	u8 min_num;
 };
 
+struct rtw89_pci_gen_def {
+};
+
 struct rtw89_pci_info {
+	const struct rtw89_pci_gen_def *gen_def;
 	enum mac_ax_bd_trunc_mode txbd_trunc_mode;
 	enum mac_ax_bd_trunc_mode rxbd_trunc_mode;
 	enum mac_ax_rxbd_mode rxbd_mode;
@@ -1229,6 +1233,8 @@ extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_v1;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_be;
 extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_dual[RTW89_TXCH_NUM];
 extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_single[RTW89_TXCH_NUM];
+extern const struct rtw89_pci_gen_def rtw89_pci_gen_ax;
+extern const struct rtw89_pci_gen_def rtw89_pci_gen_be;
 
 struct pci_device_id;
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
new file mode 100644
index 000000000000..17dcf3211b77
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2023  Realtek Corporation
+ */
+
+#include <linux/pci.h>
+
+#include "pci.h"
+#include "reg.h"
+
+const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
+};
+EXPORT_SYMBOL(rtw89_pci_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index 3b299778119a..6858fd760013 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -10,6 +10,7 @@
 #include "rtw8851b.h"
 
 static const struct rtw89_pci_info rtw8851b_pci_info = {
+	.gen_def		= &rtw89_pci_gen_ax,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_mode		= MAC_AX_RXBD_PKT,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index a40e87405dc8..f539f4602c02 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -10,6 +10,7 @@
 #include "rtw8852a.h"
 
 static const struct rtw89_pci_info rtw8852a_pci_info = {
+	.gen_def		= &rtw89_pci_gen_ax,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_mode		= MAC_AX_RXBD_PKT,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 9500ff9bb4aa..b9bbb6e9b4ff 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -10,6 +10,7 @@
 #include "rtw8852b.h"
 
 static const struct rtw89_pci_info rtw8852b_pci_info = {
+	.gen_def		= &rtw89_pci_gen_ax,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_mode		= MAC_AX_RXBD_PKT,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 5c84589fd50e..f6bf35342719 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -19,6 +19,7 @@ static const struct rtw89_pci_bd_idx_addr rtw8852c_bd_idx_addr_low_power = {
 };
 
 static const struct rtw89_pci_info rtw8852c_pci_info = {
+	.gen_def		= &rtw89_pci_gen_ax,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_mode		= MAC_AX_RXBD_PKT,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index e55f25bafc6e..8ea5261b9ee4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -9,6 +9,7 @@
 #include "reg.h"
 
 static const struct rtw89_pci_info rtw8922a_pci_info = {
+	.gen_def		= &rtw89_pci_gen_be,
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_mode		= MAC_AX_RXBD_PKT,
-- 
2.25.1

