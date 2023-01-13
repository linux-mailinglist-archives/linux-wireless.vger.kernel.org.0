Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD0366925E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 10:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbjAMJKb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 04:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbjAMJKA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 04:10:00 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BB5D43A21
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 01:07:13 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30D95sDK2029942, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30D95sDK2029942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 13 Jan 2023 17:05:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 13 Jan 2023 17:06:53 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 13 Jan
 2023 17:06:52 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <echuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: fix assignation of TX BD RAM table
Date:   Fri, 13 Jan 2023 17:06:31 +0800
Message-ID: <20230113090632.60957-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113090632.60957-1-pkshih@realtek.com>
References: <20230113090632.60957-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/13/2023 08:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTMgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

TX BD's RAM table describes how HW allocates usable buffer section
for each TX channel at fetch time. The total RAM size for TX BD is
chip-dependent. For 8852BE, it has only half size (32) for TX channels
of single band. Original table arrange total size (64) for dual band.
It will overflow on 8852BE circuit and cause section conflicts between
different TX channels.

So, we do the changes below.
* add another table for single band chip and export both kind of tables
* point to the expected one in rtw89_pci_info by chip

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c       | 15 ++++++++++++++-
 drivers/net/wireless/realtek/rtw89/pci.h       | 15 +++++++++------
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c |  1 +
 5 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 1c4500ba777c6..0ea734c81b4f0 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1384,7 +1384,7 @@ static int rtw89_pci_ops_tx_write(struct rtw89_dev *rtwdev, struct rtw89_core_tx
 	return 0;
 }
 
-static const struct rtw89_pci_bd_ram bd_ram_table[RTW89_TXCH_NUM] = {
+const struct rtw89_pci_bd_ram rtw89_bd_ram_table_dual[RTW89_TXCH_NUM] = {
 	[RTW89_TXCH_ACH0] = {.start_idx = 0,  .max_num = 5, .min_num = 2},
 	[RTW89_TXCH_ACH1] = {.start_idx = 5,  .max_num = 5, .min_num = 2},
 	[RTW89_TXCH_ACH2] = {.start_idx = 10, .max_num = 5, .min_num = 2},
@@ -1399,11 +1399,24 @@ static const struct rtw89_pci_bd_ram bd_ram_table[RTW89_TXCH_NUM] = {
 	[RTW89_TXCH_CH11] = {.start_idx = 55, .max_num = 5, .min_num = 1},
 	[RTW89_TXCH_CH12] = {.start_idx = 60, .max_num = 4, .min_num = 1},
 };
+EXPORT_SYMBOL(rtw89_bd_ram_table_dual);
+
+const struct rtw89_pci_bd_ram rtw89_bd_ram_table_single[RTW89_TXCH_NUM] = {
+	[RTW89_TXCH_ACH0] = {.start_idx = 0,  .max_num = 5, .min_num = 2},
+	[RTW89_TXCH_ACH1] = {.start_idx = 5,  .max_num = 5, .min_num = 2},
+	[RTW89_TXCH_ACH2] = {.start_idx = 10, .max_num = 5, .min_num = 2},
+	[RTW89_TXCH_ACH3] = {.start_idx = 15, .max_num = 5, .min_num = 2},
+	[RTW89_TXCH_CH8]  = {.start_idx = 20, .max_num = 4, .min_num = 1},
+	[RTW89_TXCH_CH9]  = {.start_idx = 24, .max_num = 4, .min_num = 1},
+	[RTW89_TXCH_CH12] = {.start_idx = 28, .max_num = 4, .min_num = 1},
+};
+EXPORT_SYMBOL(rtw89_bd_ram_table_single);
 
 static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_bd_ram *bd_ram_table = *info->bd_ram_table;
 	struct rtw89_pci_tx_ring *tx_ring;
 	struct rtw89_pci_rx_ring *rx_ring;
 	struct rtw89_pci_dma_ring *bd_ring;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 7d033501d4d95..1e19740db8c54 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -750,6 +750,12 @@ struct rtw89_pci_ch_dma_addr_set {
 	struct rtw89_pci_ch_dma_addr rx[RTW89_RXCH_NUM];
 };
 
+struct rtw89_pci_bd_ram {
+	u8 start_idx;
+	u8 max_num;
+	u8 min_num;
+};
+
 struct rtw89_pci_info {
 	enum mac_ax_bd_trunc_mode txbd_trunc_mode;
 	enum mac_ax_bd_trunc_mode rxbd_trunc_mode;
@@ -785,6 +791,7 @@ struct rtw89_pci_info {
 	u32 tx_dma_ch_mask;
 	const struct rtw89_pci_bd_idx_addr *bd_idx_addr_low_power;
 	const struct rtw89_pci_ch_dma_addr_set *dma_addr_set;
+	const struct rtw89_pci_bd_ram (*bd_ram_table)[RTW89_TXCH_NUM];
 
 	int (*ltr_set)(struct rtw89_dev *rtwdev, bool en);
 	u32 (*fill_txaddr_info)(struct rtw89_dev *rtwdev,
@@ -798,12 +805,6 @@ struct rtw89_pci_info {
 				struct rtw89_pci_isrs *isrs);
 };
 
-struct rtw89_pci_bd_ram {
-	u8 start_idx;
-	u8 max_num;
-	u8 min_num;
-};
-
 struct rtw89_pci_tx_data {
 	dma_addr_t dma;
 };
@@ -1057,6 +1058,8 @@ static inline bool rtw89_pci_ltr_is_err_reg_val(u32 val)
 extern const struct dev_pm_ops rtw89_pm_ops;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_v1;
+extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_dual[RTW89_TXCH_NUM];
+extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_single[RTW89_TXCH_NUM];
 
 struct pci_device_id;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 0cd8c0c44d19d..d835a44a1d0d0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -44,6 +44,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.tx_dma_ch_mask		= 0,
 	.bd_idx_addr_low_power	= NULL,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
+	.bd_ram_table		= &rtw89_bd_ram_table_dual,
 
 	.ltr_set		= rtw89_pci_ltr_set,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index 0ef2ca8efeb0e..ecf39d2d9f81f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -46,6 +46,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 				  BIT(RTW89_TXCH_CH10) | BIT(RTW89_TXCH_CH11),
 	.bd_idx_addr_low_power	= NULL,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
+	.bd_ram_table		= &rtw89_bd_ram_table_single,
 
 	.ltr_set		= rtw89_pci_ltr_set,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 35901f64d17de..80490a5437df6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -53,6 +53,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.tx_dma_ch_mask		= 0,
 	.bd_idx_addr_low_power	= &rtw8852c_bd_idx_addr_low_power,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_v1,
+	.bd_ram_table		= &rtw89_bd_ram_table_dual,
 
 	.ltr_set		= rtw89_pci_ltr_set_v1,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info_v1,
-- 
2.25.1

