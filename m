Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E18E4E6E05
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358401AbiCYGDt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358396AbiCYGDr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:03:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB7EC6828
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:13 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P624QE0011046, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P624QE0011046
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 14:02:03 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 04/16] rtw89: pci: add LTR setting for v1 chip
Date:   Fri, 25 Mar 2022 14:00:43 +0800
Message-ID: <20220325060055.58482-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325060055.58482-1-pkshih@realtek.com>
References: <20220325060055.58482-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/25/2022 05:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUgpFekyCAwNDo0ODowMA==?=
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

Add LTR handle to PCI deinit as well.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 58 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/pci.h      |  3 +
 drivers/net/wireless/realtek/rtw89/reg.h      | 22 +++++++
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 5 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 43bb4490380d8..2fd746d6987c1 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2182,10 +2182,13 @@ static int rtw89_pci_mode_op(struct rtw89_dev *rtwdev)
 
 static int rtw89_pci_ops_deinit(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+
 	if (rtwdev->chip->chip_id == RTL8852A) {
 		/* ltr sw trigger */
 		rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0, B_AX_APP_LTR_IDLE);
 	}
+	info->ltr_set(rtwdev, false);
 	rtw89_pci_ctrl_dma_all(rtwdev, false);
 	rtw89_pci_clr_idx_all(rtwdev);
 
@@ -2260,10 +2263,13 @@ static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev)
+int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en)
 {
 	u32 val;
 
+	if (!en)
+		return 0;
+
 	val = rtw89_read32(rtwdev, R_AX_LTR_CTRL_0);
 	if (rtw89_pci_ltr_is_err_reg_val(val))
 		return -EINVAL;
@@ -2290,13 +2296,61 @@ static int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev)
 
 	return 0;
 }
+EXPORT_SYMBOL(rtw89_pci_ltr_set);
+
+int rtw89_pci_ltr_set_v1(struct rtw89_dev *rtwdev, bool en)
+{
+	u32 dec_ctrl;
+	u32 val32;
+
+	val32 = rtw89_read32(rtwdev, R_AX_LTR_CTRL_0);
+	if (rtw89_pci_ltr_is_err_reg_val(val32))
+		return -EINVAL;
+	val32 = rtw89_read32(rtwdev, R_AX_LTR_CTRL_1);
+	if (rtw89_pci_ltr_is_err_reg_val(val32))
+		return -EINVAL;
+	dec_ctrl = rtw89_read32(rtwdev, R_AX_LTR_DEC_CTRL);
+	if (rtw89_pci_ltr_is_err_reg_val(dec_ctrl))
+		return -EINVAL;
+	val32 = rtw89_read32(rtwdev, R_AX_LTR_LATENCY_IDX3);
+	if (rtw89_pci_ltr_is_err_reg_val(val32))
+		return -EINVAL;
+	val32 = rtw89_read32(rtwdev, R_AX_LTR_LATENCY_IDX0);
+	if (rtw89_pci_ltr_is_err_reg_val(val32))
+		return -EINVAL;
+
+	if (!en) {
+		dec_ctrl &= ~(LTR_EN_BITS | B_AX_LTR_IDX_DRV_MASK | B_AX_LTR_HW_DEC_EN);
+		dec_ctrl |= FIELD_PREP(B_AX_LTR_IDX_DRV_MASK, PCIE_LTR_IDX_IDLE) |
+			    B_AX_LTR_REQ_DRV;
+	} else {
+		dec_ctrl |= B_AX_LTR_HW_DEC_EN;
+	}
+
+	dec_ctrl &= ~B_AX_LTR_SPACE_IDX_V1_MASK;
+	dec_ctrl |= FIELD_PREP(B_AX_LTR_SPACE_IDX_V1_MASK, PCI_LTR_SPC_500US);
+
+	if (en)
+		rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0,
+				  B_AX_LTR_WD_NOEMP_CHK_V1 | B_AX_LTR_HW_EN);
+	rtw89_write32_mask(rtwdev, R_AX_LTR_CTRL_0, B_AX_LTR_IDLE_TIMER_IDX_MASK,
+			   PCI_LTR_IDLE_TIMER_3_2MS);
+	rtw89_write32_mask(rtwdev, R_AX_LTR_CTRL_1, B_AX_LTR_RX0_TH_MASK, 0x28);
+	rtw89_write32_mask(rtwdev, R_AX_LTR_CTRL_1, B_AX_LTR_RX1_TH_MASK, 0x28);
+	rtw89_write32(rtwdev, R_AX_LTR_DEC_CTRL, dec_ctrl);
+	rtw89_write32(rtwdev, R_AX_LTR_LATENCY_IDX3, 0x90039003);
+	rtw89_write32(rtwdev, R_AX_LTR_LATENCY_IDX0, 0x880b880b);
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_pci_ltr_set_v1);
 
 static int rtw89_pci_ops_mac_post_init(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	int ret;
 
-	ret = rtw89_pci_ltr_set(rtwdev);
+	ret = info->ltr_set(rtwdev, true);
 	if (ret) {
 		rtw89_err(rtwdev, "pci ltr set fail\n");
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 2e8695208fccb..99f0cd2f47da2 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -647,6 +647,7 @@ struct rtw89_pci_info {
 
 	const struct rtw89_pci_ch_dma_addr_set *dma_addr_set;
 
+	int (*ltr_set)(struct rtw89_dev *rtwdev, bool en);
 	u32 (*fill_txaddr_info)(struct rtw89_dev *rtwdev,
 				void *txaddr_info_addr, u32 total_len,
 				dma_addr_t dma, u8 *add_info_nr);
@@ -912,6 +913,8 @@ struct pci_device_id;
 
 int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 void rtw89_pci_remove(struct pci_dev *pdev);
+int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en);
+int rtw89_pci_ltr_set_v1(struct rtw89_dev *rtwdev, bool en);
 u32 rtw89_pci_fill_txaddr_info(struct rtw89_dev *rtwdev,
 			       void *txaddr_info_addr, u32 total_len,
 			       dma_addr_t dma, u8 *add_info_nr);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 6cda6dcb5d867..21a451264e504 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -299,6 +299,27 @@
 #define B_AX_RPQ_BUSY BIT(1)
 #define B_AX_RXQ_BUSY BIT(0)
 
+#define R_AX_LTR_DEC_CTRL 0x1600
+#define B_AX_LTR_IDX_DRV_VLD BIT(16)
+#define B_AX_LTR_CURR_IDX_DRV_MASK GENMASK(15, 14)
+#define B_AX_LTR_IDX_FW_VLD BIT(13)
+#define B_AX_LTR_CURR_IDX_FW_MASK GENMASK(12, 11)
+#define B_AX_LTR_IDX_HW_VLD BIT(10)
+#define B_AX_LTR_CURR_IDX_HW_MASK GENMASK(9, 8)
+#define B_AX_LTR_REQ_DRV BIT(7)
+#define B_AX_LTR_IDX_DRV_MASK GENMASK(6, 5)
+#define PCIE_LTR_IDX_IDLE 3
+#define B_AX_LTR_DRV_DEC_EN BIT(4)
+#define B_AX_LTR_FW_DEC_EN BIT(3)
+#define B_AX_LTR_HW_DEC_EN BIT(2)
+#define B_AX_LTR_SPACE_IDX_V1_MASK GENMASK(1, 0)
+#define LTR_EN_BITS (B_AX_LTR_HW_DEC_EN | B_AX_LTR_FW_DEC_EN | B_AX_LTR_DRV_DEC_EN)
+
+#define R_AX_LTR_LATENCY_IDX0 0x1604
+#define R_AX_LTR_LATENCY_IDX1 0x1608
+#define R_AX_LTR_LATENCY_IDX2 0x160C
+#define R_AX_LTR_LATENCY_IDX3 0x1610
+
 #define R_AX_HCI_FC_CTRL_V1 0x1700
 #define R_AX_CH_PAGE_CTRL_V1 0x1704
 
@@ -440,6 +461,7 @@
 #define B_AX_APP_LTR_ACT BIT(5)
 #define B_AX_APP_LTR_IDLE BIT(4)
 #define B_AX_LTR_EN BIT(1)
+#define B_AX_LTR_WD_NOEMP_CHK_V1 BIT(1)
 #define B_AX_LTR_HW_EN BIT(0)
 
 #define R_AX_LTR_CTRL_1 0x8414
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 6055e8b9887f5..61a1693535d8a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -40,6 +40,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
 
+	.ltr_set		= rtw89_pci_ltr_set,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index dca023e791016..aeafac553f404 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -41,6 +41,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_v1,
 
+	.ltr_set		= rtw89_pci_ltr_set_v1,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info_v1,
 };
 
-- 
2.25.1

