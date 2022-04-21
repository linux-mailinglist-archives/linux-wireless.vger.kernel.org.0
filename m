Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D887509F54
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383230AbiDUMNE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 08:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiDUMM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 08:12:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FF42ED7A
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 05:09:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23LC9Qu04028957, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23LC9Qu04028957
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 20:09:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 20:09:26 +0800
Received: from localhost (172.16.16.159) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 21 Apr
 2022 20:09:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 02/14] rtw89: pci: add variant RPWM/CPWM to enter low power mode
Date:   Thu, 21 Apr 2022 20:08:51 +0800
Message-ID: <20220421120903.73715-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421120903.73715-1-pkshih@realtek.com>
References: <20220421120903.73715-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.159]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/21/2022 11:49:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjEgpFekyCAxMDowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RPWM/CPWM are registers that can set and check low power mode. Since chips
use different address, add a field to access them in common flow.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c       |  6 +++---
 drivers/net/wireless/realtek/rtw89/pci.c       | 14 ++++++++------
 drivers/net/wireless/realtek/rtw89/pci.h       |  5 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c |  3 +++
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c |  2 ++
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 127d5d74c426b..05b94842fe662 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1027,7 +1027,7 @@ static int rtw89_mac_check_cpwm_state(struct rtw89_dev *rtwdev,
 		return 0;
 
 	rpwm_req_num = rtwdev->mac.rpwm_seq_num;
-	cpwm_rsp_seq = rtw89_read16_mask(rtwdev, R_AX_CPWM,
+	cpwm_rsp_seq = rtw89_read16_mask(rtwdev, rtwdev->hci.cpwm_addr,
 					 PS_CPWM_RSP_SEQ_NUM);
 
 	if (rpwm_req_num != cpwm_rsp_seq)
@@ -1036,11 +1036,11 @@ static int rtw89_mac_check_cpwm_state(struct rtw89_dev *rtwdev,
 	rtwdev->mac.cpwm_seq_num = (rtwdev->mac.cpwm_seq_num + 1) &
 				    CPWM_SEQ_NUM_MAX;
 
-	cpwm_seq = rtw89_read16_mask(rtwdev, R_AX_CPWM, PS_CPWM_SEQ_NUM);
+	cpwm_seq = rtw89_read16_mask(rtwdev, rtwdev->hci.cpwm_addr, PS_CPWM_SEQ_NUM);
 	if (cpwm_seq != rtwdev->mac.cpwm_seq_num)
 		return -EPERM;
 
-	cpwm_status = rtw89_read16_mask(rtwdev, R_AX_CPWM, PS_CPWM_STATE);
+	cpwm_status = rtw89_read16_mask(rtwdev, rtwdev->hci.cpwm_addr, PS_CPWM_STATE);
 	if (cpwm_status != req_pwr_state)
 		return -EPERM;
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 0d9cd8033c778..338a032490e16 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3486,6 +3486,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct ieee80211_hw *hw;
 	struct rtw89_dev *rtwdev;
 	const struct rtw89_driver_info *info;
+	const struct rtw89_pci_info *pci_info;
 	int driver_data_size;
 	int ret;
 
@@ -3496,20 +3497,21 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
+	info = (const struct rtw89_driver_info *)id->driver_data;
+	pci_info = info->bus.pci;
+
 	rtwdev = hw->priv;
 	rtwdev->hw = hw;
 	rtwdev->dev = &pdev->dev;
+	rtwdev->chip = info->chip;
+	rtwdev->pci_info = info->bus.pci;
 	rtwdev->hci.ops = &rtw89_pci_ops;
 	rtwdev->hci.type = RTW89_HCI_TYPE_PCIE;
-	rtwdev->hci.rpwm_addr = R_AX_PCIE_HRPWM;
-	rtwdev->hci.cpwm_addr = R_AX_CPWM;
+	rtwdev->hci.rpwm_addr = pci_info->rpwm_addr;
+	rtwdev->hci.cpwm_addr = pci_info->cpwm_addr;
 
 	SET_IEEE80211_DEV(rtwdev->hw, &pdev->dev);
 
-	info = (const struct rtw89_driver_info *)id->driver_data;
-	rtwdev->chip = info->chip;
-	rtwdev->pci_info = info->bus.pci;
-
 	ret = rtw89_core_init(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to initialise core\n");
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index aa804b577df27..c203c8cbf1632 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -481,6 +481,9 @@
 #define R_AX_PCIE_RX_PREF_ADV		0x13F4
 #define B_AX_RXDMA_PREF_ADV_EN		BIT(0)
 
+#define R_AX_PCIE_HRPWM_V1		0x30C0
+#define R_AX_PCIE_CRPWM			0x30C4
+
 #define RTW89_PCI_TXBD_NUM_MAX		256
 #define RTW89_PCI_RXBD_NUM_MAX		256
 #define RTW89_PCI_TXWD_NUM_MAX		512
@@ -698,6 +701,8 @@ struct rtw89_pci_info {
 	u32 dma_busy2_reg;
 	u32 dma_busy3_reg;
 
+	u32 rpwm_addr;
+	u32 cpwm_addr;
 	const struct rtw89_pci_ch_dma_addr_set *dma_addr_set;
 
 	int (*ltr_set)(struct rtw89_dev *rtwdev, bool en);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 73b5dd05235aa..c6937e5943ea7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 
 #include "pci.h"
+#include "reg.h"
 #include "rtw8852a.h"
 
 static const struct rtw89_pci_info rtw8852a_pci_info = {
@@ -38,6 +39,8 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.dma_busy2_reg		= R_AX_PCIE_DMA_BUSY2,
 	.dma_busy3_reg		= R_AX_PCIE_DMA_BUSY1,
 
+	.rpwm_addr		= R_AX_PCIE_HRPWM,
+	.cpwm_addr		= R_AX_CPWM,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
 
 	.ltr_set		= rtw89_pci_ltr_set,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 4021a56a82bc5..4d71cc87f7ba8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -39,6 +39,8 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.dma_busy2_reg		= R_AX_HAXI_DMA_BUSY2,
 	.dma_busy3_reg		= R_AX_HAXI_DMA_BUSY3,
 
+	.rpwm_addr		= R_AX_PCIE_HRPWM_V1,
+	.cpwm_addr		= R_AX_PCIE_CRPWM,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_v1,
 
 	.ltr_set		= rtw89_pci_ltr_set_v1,
-- 
2.25.1

