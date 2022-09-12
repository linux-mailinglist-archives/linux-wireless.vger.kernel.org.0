Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246AF5B5544
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 09:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiILHVO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiILHUo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 03:20:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54C7F2E68A
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 00:17:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28C7HLAF0019163, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28C7HLAF0019163
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 12 Sep 2022 15:17:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 15:17:42 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 12 Sep
 2022 15:17:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: correct enable functions of HCI/PCI DMA
Date:   Mon, 12 Sep 2022 15:17:05 +0800
Message-ID: <20220912071706.13619-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912071706.13619-1-pkshih@realtek.com>
References: <20220912071706.13619-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/12/2022 06:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTIgpFekyCAwMjozNzowMA==?=
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

From: Chin-Yen Lee <timlee@realtek.com>

Some PCI and MAC registers are changed for different
chips and correct them accordingly. And HCI MAD functions
belongs to MAC core, so move it to mac.h/.c.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c |  10 +--
 drivers/net/wireless/realtek/rtw89/mac.h |  40 +++++++++
 drivers/net/wireless/realtek/rtw89/pci.c | 103 +++++++++--------------
 drivers/net/wireless/realtek/rtw89/pci.h |   5 --
 4 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f5bae0b282082..526078513eea8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3129,14 +3129,6 @@ static int rtw89_mac_dmac_pre_init(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
-static void rtw89_mac_hci_func_en(struct rtw89_dev *rtwdev)
-{
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-
-	rtw89_write32_set(rtwdev, chip->hci_func_en_addr,
-			  B_AX_HCI_TXDMA_EN | B_AX_HCI_RXDMA_EN);
-}
-
 int rtw89_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	rtw89_write8_set(rtwdev, R_AX_SYS_FUNC_EN,
@@ -3173,7 +3165,7 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev)
 			return ret;
 	}
 
-	rtw89_mac_hci_func_en(rtwdev);
+	rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
 
 	ret = rtw89_mac_dmac_pre_init(rtwdev);
 	if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 986e359a82237..cacf867a4f031 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -6,6 +6,7 @@
 #define __RTW89_MAC_H__
 
 #include "core.h"
+#include "reg.h"
 
 #define MAC_MEM_DUMP_PAGE_SIZE 0x40000
 #define ADDR_CAM_ENT_SIZE  0x40
@@ -912,6 +913,45 @@ static inline int rtw89_mac_txpwr_write32_mask(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static inline void rtw89_mac_ctrl_hci_dma_tx(struct rtw89_dev *rtwdev,
+					     bool enable)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (enable)
+		rtw89_write32_set(rtwdev, chip->hci_func_en_addr,
+				  B_AX_HCI_TXDMA_EN);
+	else
+		rtw89_write32_clr(rtwdev, chip->hci_func_en_addr,
+				  B_AX_HCI_TXDMA_EN);
+}
+
+static inline void rtw89_mac_ctrl_hci_dma_rx(struct rtw89_dev *rtwdev,
+					     bool enable)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (enable)
+		rtw89_write32_set(rtwdev, chip->hci_func_en_addr,
+				  B_AX_HCI_RXDMA_EN);
+	else
+		rtw89_write32_clr(rtwdev, chip->hci_func_en_addr,
+				  B_AX_HCI_RXDMA_EN);
+}
+
+static inline void rtw89_mac_ctrl_hci_dma_trx(struct rtw89_dev *rtwdev,
+					      bool enable)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (enable)
+		rtw89_write32_set(rtwdev, chip->hci_func_en_addr,
+				  B_AX_HCI_TXDMA_EN | B_AX_HCI_RXDMA_EN);
+	else
+		rtw89_write32_clr(rtwdev, chip->hci_func_en_addr,
+				  B_AX_HCI_TXDMA_EN | B_AX_HCI_RXDMA_EN);
+}
+
 int rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			  bool resume, u32 tx_time);
 int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 2c59ae06e4db9..7f348bcf640c8 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1607,35 +1607,41 @@ static void rtw89_pci_ops_write32(struct rtw89_dev *rtwdev, u32 addr, u32 data)
 	writel(data, rtwpci->mmap + addr);
 }
 
-static void rtw89_pci_ctrl_dma_all(struct rtw89_dev *rtwdev, bool enable)
+static void rtw89_pci_ctrl_dma_trx(struct rtw89_dev *rtwdev, bool enable)
 {
-	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
-	u32 txhci_en = info->txhci_en_bit;
-	u32 rxhci_en = info->rxhci_en_bit;
 
-	if (enable) {
-		if (chip_id != RTL8852C)
-			rtw89_write32_clr(rtwdev, info->dma_stop1_reg,
-					  B_AX_STOP_PCIEIO);
-		rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1,
-				  txhci_en | rxhci_en);
-		if (chip_id == RTL8852C)
-			rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1,
-					  B_AX_STOP_AXI_MST);
+	if (enable)
+		rtw89_write32_set(rtwdev, info->init_cfg_reg,
+				  info->rxhci_en_bit | info->txhci_en_bit);
+	else
+		rtw89_write32_clr(rtwdev, info->init_cfg_reg,
+				  info->rxhci_en_bit | info->txhci_en_bit);
+}
+
+static void rtw89_pci_ctrl_dma_io(struct rtw89_dev *rtwdev, bool enable)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	u32 reg, mask;
+
+	if (chip_id == RTL8852C) {
+		reg = R_AX_HAXI_INIT_CFG1;
+		mask = B_AX_STOP_AXI_MST;
 	} else {
-		if (chip_id != RTL8852C)
-			rtw89_write32_set(rtwdev, info->dma_stop1_reg,
-					  B_AX_STOP_PCIEIO);
-		else
-			rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1,
-					  B_AX_STOP_AXI_MST);
-		rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1,
-				  txhci_en | rxhci_en);
-		if (chip_id == RTL8852C)
-			rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1,
-					  B_AX_STOP_AXI_MST);
+		reg = R_AX_PCIE_DMA_STOP1;
+		mask = B_AX_STOP_PCIEIO;
 	}
+
+	if (enable)
+		rtw89_write32_clr(rtwdev, reg, mask);
+	else
+		rtw89_write32_set(rtwdev, reg, mask);
+}
+
+static void rtw89_pci_ctrl_dma_all(struct rtw89_dev *rtwdev, bool enable)
+{
+	rtw89_pci_ctrl_dma_io(rtwdev, enable);
+	rtw89_pci_ctrl_dma_trx(rtwdev, enable);
 }
 
 static int rtw89_pci_check_mdio(struct rtw89_dev *rtwdev, u8 addr, u8 speed, u16 rw_bit)
@@ -3478,26 +3484,6 @@ static void rtw89_pci_l1ss_cfg(struct rtw89_dev *rtwdev)
 		rtw89_pci_l1ss_set(rtwdev, true);
 }
 
-static void rtw89_pci_ctrl_dma_all_pcie(struct rtw89_dev *rtwdev, u8 en)
-{
-	const struct rtw89_pci_info *info = rtwdev->pci_info;
-	u32 val32;
-
-	if (en == MAC_AX_FUNC_EN) {
-		val32 = B_AX_STOP_PCIEIO;
-		rtw89_write32_clr(rtwdev, info->dma_stop1_reg, val32);
-
-		val32 = B_AX_TXHCI_EN | B_AX_RXHCI_EN;
-		rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1, val32);
-	} else {
-		val32 = B_AX_STOP_PCIEIO;
-		rtw89_write32_set(rtwdev, info->dma_stop1_reg, val32);
-
-		val32 = B_AX_TXHCI_EN | B_AX_RXHCI_EN;
-		rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1, val32);
-	}
-}
-
 static int rtw89_pci_poll_io_idle(struct rtw89_dev *rtwdev)
 {
 	int ret = 0;
@@ -3517,13 +3503,13 @@ static int rtw89_pci_poll_io_idle(struct rtw89_dev *rtwdev)
 
 static int rtw89_pci_lv1rst_stop_dma(struct rtw89_dev *rtwdev)
 {
-	u32 val, dma_rst = 0;
+	u32 val;
 	int ret;
 
 	if (rtwdev->chip->chip_id == RTL8852C)
 		return 0;
 
-	rtw89_pci_ctrl_dma_all_pcie(rtwdev, MAC_AX_FUNC_DIS);
+	rtw89_pci_ctrl_dma_all(rtwdev, false);
 	ret = rtw89_pci_poll_io_idle(rtwdev);
 	if (ret) {
 		val = rtw89_read32(rtwdev, R_AX_DBG_ERR_FLAG);
@@ -3531,12 +3517,10 @@ static int rtw89_pci_lv1rst_stop_dma(struct rtw89_dev *rtwdev)
 			    "[PCIe] poll_io_idle fail, before 0x%08x: 0x%08x\n",
 			    R_AX_DBG_ERR_FLAG, val);
 		if (val & B_AX_TX_STUCK || val & B_AX_PCIE_TXBD_LEN0)
-			dma_rst |= B_AX_HCI_TXDMA_EN;
+			rtw89_mac_ctrl_hci_dma_tx(rtwdev, false);
 		if (val & B_AX_RX_STUCK)
-			dma_rst |= B_AX_HCI_RXDMA_EN;
-		val = rtw89_read32(rtwdev, R_AX_HCI_FUNC_EN);
-		rtw89_write32(rtwdev, R_AX_HCI_FUNC_EN, val & ~dma_rst);
-		rtw89_write32(rtwdev, R_AX_HCI_FUNC_EN, val | dma_rst);
+			rtw89_mac_ctrl_hci_dma_rx(rtwdev, false);
+		rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
 		ret = rtw89_pci_poll_io_idle(rtwdev);
 		val = rtw89_read32(rtwdev, R_AX_DBG_ERR_FLAG);
 		rtw89_debug(rtwdev, RTW89_DBG_HCI,
@@ -3547,18 +3531,7 @@ static int rtw89_pci_lv1rst_stop_dma(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
-static void rtw89_pci_ctrl_hci_dma_en(struct rtw89_dev *rtwdev, u8 en)
-{
-	u32 val32;
 
-	if (en == MAC_AX_FUNC_EN) {
-		val32 = B_AX_HCI_TXDMA_EN | B_AX_HCI_RXDMA_EN;
-		rtw89_write32_set(rtwdev, R_AX_HCI_FUNC_EN, val32);
-	} else {
-		val32 = B_AX_HCI_TXDMA_EN | B_AX_HCI_RXDMA_EN;
-		rtw89_write32_clr(rtwdev, R_AX_HCI_FUNC_EN, val32);
-	}
-}
 
 static int rtw89_pci_rst_bdram(struct rtw89_dev *rtwdev)
 {
@@ -3581,15 +3554,15 @@ static int rtw89_pci_lv1rst_start_dma(struct rtw89_dev *rtwdev)
 	if (rtwdev->chip->chip_id == RTL8852C)
 		return 0;
 
-	rtw89_pci_ctrl_hci_dma_en(rtwdev, MAC_AX_FUNC_DIS);
-	rtw89_pci_ctrl_hci_dma_en(rtwdev, MAC_AX_FUNC_EN);
+	rtw89_mac_ctrl_hci_dma_trx(rtwdev, false);
+	rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
 	rtw89_pci_clr_idx_all(rtwdev);
 
 	ret = rtw89_pci_rst_bdram(rtwdev);
 	if (ret)
 		return ret;
 
-	rtw89_pci_ctrl_dma_all_pcie(rtwdev, MAC_AX_FUNC_EN);
+	rtw89_pci_ctrl_dma_all(rtwdev, true);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 63dc6d4db6022..1365bbb547989 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -564,11 +564,6 @@ enum rtw89_pcie_phy {
 	PCIE_PHY_GEN1_UNDEFINE = 0x7F,
 };
 
-enum mac_ax_func_sw {
-	MAC_AX_FUNC_DIS,
-	MAC_AX_FUNC_EN,
-};
-
 enum rtw89_pcie_l0sdly {
 	PCIE_L0SDLY_1US = 0,
 	PCIE_L0SDLY_2US = 1,
-- 
2.25.1

