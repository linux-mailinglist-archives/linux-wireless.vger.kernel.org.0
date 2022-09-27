Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A955EBA9E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 08:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiI0G2K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 02:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiI0G2F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 02:28:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69AD7857F4
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 23:27:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28R6QeHS2008375, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28R6QeHS2008375
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 27 Sep 2022 14:26:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 27 Sep 2022 14:27:05 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 27 Sep
 2022 14:27:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/9] wifi: rtw89: pci: mask out unsupported TX channels
Date:   Tue, 27 Sep 2022 14:26:03 +0800
Message-ID: <20220927062611.30484-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927062611.30484-1-pkshih@realtek.com>
References: <20220927062611.30484-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/27/2022 06:02:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjcgpFekyCAwNDo1MzowMA==?=
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

8852BE doesn't support some TX channels, so mask them out, or it access
undefined registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 16 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h      |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    | 19 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 5 files changed, 38 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852be.c

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 3e8e477d32f79..002d3ce0e35b2 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1093,12 +1093,15 @@ static void __pci_flush_txch(struct rtw89_dev *rtwdev, u8 txch, bool drop)
 static void __rtw89_pci_ops_flush_txchs(struct rtw89_dev *rtwdev, u32 txchs,
 					bool drop)
 {
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	u8 i;
 
 	for (i = 0; i < RTW89_TXCH_NUM; i++) {
 		/* It may be unnecessary to flush FWCMD queue. */
 		if (i == RTW89_TXCH_CH12)
 			continue;
+		if (info->tx_dma_ch_mask & BIT(i))
+			continue;
 
 		if (txchs & BIT(i))
 			__pci_flush_txch(rtwdev, i, drop);
@@ -1377,6 +1380,7 @@ static const struct rtw89_pci_bd_ram bd_ram_table[RTW89_TXCH_NUM] = {
 static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	struct rtw89_pci_tx_ring *tx_ring;
 	struct rtw89_pci_rx_ring *rx_ring;
 	struct rtw89_pci_dma_ring *bd_ring;
@@ -1388,6 +1392,9 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 	int i;
 
 	for (i = 0; i < RTW89_TXCH_NUM; i++) {
+		if (info->tx_dma_ch_mask & BIT(i))
+			continue;
+
 		tx_ring = &rtwpci->tx_rings[i];
 		bd_ring = &tx_ring->bd_ring;
 		bd_ram = &bd_ram_table[i];
@@ -1431,12 +1438,15 @@ static void rtw89_pci_release_tx_ring(struct rtw89_dev *rtwdev,
 static void rtw89_pci_ops_reset(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	int txch;
 
 	rtw89_pci_reset_trx_rings(rtwdev);
 
 	spin_lock_bh(&rtwpci->trx_lock);
 	for (txch = 0; txch < RTW89_TXCH_NUM; txch++) {
+		if (info->tx_dma_ch_mask & BIT(txch))
+			continue;
 		if (txch == RTW89_TXCH_CH12) {
 			rtw89_pci_release_fwcmd(rtwdev, rtwpci,
 						skb_queue_len(&rtwpci->h2c_queue), true);
@@ -2722,10 +2732,13 @@ static void rtw89_pci_free_tx_rings(struct rtw89_dev *rtwdev,
 				    struct pci_dev *pdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	struct rtw89_pci_tx_ring *tx_ring;
 	int i;
 
 	for (i = 0; i < RTW89_TXCH_NUM; i++) {
+		if (info->tx_dma_ch_mask & BIT(i))
+			continue;
 		tx_ring = &rtwpci->tx_rings[i];
 		rtw89_pci_free_tx_wd_ring(rtwdev, pdev, tx_ring);
 		rtw89_pci_free_tx_ring(rtwdev, pdev, tx_ring);
@@ -2913,6 +2926,7 @@ static int rtw89_pci_alloc_tx_rings(struct rtw89_dev *rtwdev,
 				    struct pci_dev *pdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	struct rtw89_pci_tx_ring *tx_ring;
 	u32 desc_size;
 	u32 len;
@@ -2920,6 +2934,8 @@ static int rtw89_pci_alloc_tx_rings(struct rtw89_dev *rtwdev,
 	int ret;
 
 	for (i = 0; i < RTW89_TXCH_NUM; i++) {
+		if (info->tx_dma_ch_mask & BIT(i))
+			continue;
 		tx_ring = &rtwpci->tx_rings[i];
 		desc_size = sizeof(struct rtw89_pci_tx_bd_32);
 		len = RTW89_PCI_TXBD_NUM_MAX;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index af6f6d5c47706..391058de47ec5 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -760,6 +760,7 @@ struct rtw89_pci_info {
 
 	u32 rpwm_addr;
 	u32 cpwm_addr;
+	u32 tx_dma_ch_mask;
 	const struct rtw89_pci_bd_idx_addr *bd_idx_addr_low_power;
 	const struct rtw89_pci_ch_dma_addr_set *dma_addr_set;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index d600100db9eb4..48485bd9c149f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -41,6 +41,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 
 	.rpwm_addr		= R_AX_PCIE_HRPWM,
 	.cpwm_addr		= R_AX_CPWM,
+	.tx_dma_ch_mask		= 0,
 	.bd_idx_addr_low_power	= NULL,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
new file mode 100644
index 0000000000000..4590535841be3
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2020-2022  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+#include "reg.h"
+
+static const struct rtw89_pci_info rtw8852b_pci_info = {
+	.tx_dma_ch_mask		= BIT(RTW89_TXCH_ACH4) | BIT(RTW89_TXCH_ACH5) |
+				  BIT(RTW89_TXCH_ACH6) | BIT(RTW89_TXCH_ACH7) |
+				  BIT(RTW89_TXCH_CH10) | BIT(RTW89_TXCH_CH11),
+};
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852BE driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index be6b4e4d64914..c7370f5df8b54 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -50,6 +50,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 
 	.rpwm_addr		= R_AX_PCIE_HRPWM_V1,
 	.cpwm_addr		= R_AX_PCIE_CRPWM,
+	.tx_dma_ch_mask		= 0,
 	.bd_idx_addr_low_power	= &rtw8852c_bd_idx_addr_low_power,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_v1,
 
-- 
2.25.1

