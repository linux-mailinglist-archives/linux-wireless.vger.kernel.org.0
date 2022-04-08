Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665714F8BB4
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 02:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiDHAQg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 20:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiDHAQ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 20:16:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38774247827
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 17:14:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2380ECiG4019362, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2380ECiG4019362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Apr 2022 08:14:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Apr 2022 08:14:12 +0800
Received: from localhost (172.16.21.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 08:14:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <johnson.lin@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH v2 03/13] rtw89: ser: configure C-MAC interrupt mask
Date:   Fri, 8 Apr 2022 08:13:43 +0800
Message-ID: <20220408001353.17188-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408001353.17188-1-pkshih@realtek.com>
References: <20220408001353.17188-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.190]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/07/2022 23:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyCkVaTIIDEwOjAwOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chia-Yuan Li <leo.li@realtek.com>

Similarly, create functions to set specific C-MAC masks for firmware
recovery.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  17 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 108 +++++--
 drivers/net/wireless/realtek/rtw89/reg.h      | 300 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  17 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  17 +
 5 files changed, 423 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d06a9c7cf2972..5f0f675fe2a11 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2319,6 +2319,23 @@ struct rtw89_imr_info {
 	u32 bbrpt_chinfo_err_imr_reg;
 	u32 bbrpt_err_imr_set;
 	u32 bbrpt_dfs_err_imr_reg;
+	u32 ptcl_imr_clr;
+	u32 ptcl_imr_set;
+	u32 cdma_imr_0_reg;
+	u32 cdma_imr_0_clr;
+	u32 cdma_imr_0_set;
+	u32 cdma_imr_1_reg;
+	u32 cdma_imr_1_clr;
+	u32 cdma_imr_1_set;
+	u32 phy_intf_imr_reg;
+	u32 phy_intf_imr_clr;
+	u32 phy_intf_imr_set;
+	u32 rmac_imr_reg;
+	u32 rmac_imr_clr;
+	u32 rmac_imr_set;
+	u32 tmac_imr_reg;
+	u32 tmac_imr_clr;
+	u32 tmac_imr_set;
 };
 
 struct rtw89_chip_info {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index eb75f6c703a42..2c2f4aaf99fc3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2737,10 +2737,76 @@ static void rtw89_bbrpt_imr_enable(struct rtw89_dev *rtwdev)
 	rtw89_write32_set(rtwdev, R_AX_LA_ERRFLAG, B_AX_LA_IMR_DATA_LOSS_ERR);
 }
 
+static void rtw89_scheduler_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 reg;
+
+	reg = rtw89_mac_reg_by_idx(R_AX_SCHEDULE_ERR_IMR, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, B_AX_SORT_NON_IDLE_ERR_INT_EN |
+				       B_AX_FSM_TIMEOUT_ERR_INT_EN);
+	rtw89_write32_set(rtwdev, reg, B_AX_FSM_TIMEOUT_ERR_INT_EN);
+}
+
+static void rtw89_ptcl_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+	u32 reg;
+
+	reg = rtw89_mac_reg_by_idx(R_AX_PTCL_IMR0, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, imr->ptcl_imr_clr);
+	rtw89_write32_set(rtwdev, reg, imr->ptcl_imr_set);
+}
+
+static void rtw89_cdma_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	u32 reg;
+
+	reg = rtw89_mac_reg_by_idx(imr->cdma_imr_0_reg, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, imr->cdma_imr_0_clr);
+	rtw89_write32_set(rtwdev, reg, imr->cdma_imr_0_set);
+
+	if (chip_id == RTL8852C) {
+		reg = rtw89_mac_reg_by_idx(imr->cdma_imr_1_reg, mac_idx);
+		rtw89_write32_clr(rtwdev, reg, imr->cdma_imr_1_clr);
+		rtw89_write32_set(rtwdev, reg, imr->cdma_imr_1_set);
+	}
+}
+
+static void rtw89_phy_intf_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+	u32 reg;
+
+	reg = rtw89_mac_reg_by_idx(imr->phy_intf_imr_reg, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, imr->phy_intf_imr_clr);
+	rtw89_write32_set(rtwdev, reg, imr->phy_intf_imr_set);
+}
+
+static void rtw89_rmac_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+	u32 reg;
+
+	reg = rtw89_mac_reg_by_idx(imr->rmac_imr_reg, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, imr->rmac_imr_clr);
+	rtw89_write32_set(rtwdev, reg, imr->rmac_imr_set);
+}
+
+static void rtw89_tmac_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+	u32 reg;
+
+	reg = rtw89_mac_reg_by_idx(imr->tmac_imr_reg, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, imr->tmac_imr_clr);
+	rtw89_write32_set(rtwdev, reg, imr->tmac_imr_set);
+}
+
 static int rtw89_mac_enable_imr(struct rtw89_dev *rtwdev, u8 mac_idx,
 				enum rtw89_mac_hwmod_sel sel)
 {
-	u32 reg, val;
 	int ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, sel);
@@ -2763,40 +2829,12 @@ static int rtw89_mac_enable_imr(struct rtw89_dev *rtwdev, u8 mac_idx,
 		rtw89_cpuio_imr_enable(rtwdev);
 		rtw89_bbrpt_imr_enable(rtwdev);
 	} else if (sel == RTW89_CMAC_SEL) {
-		reg = rtw89_mac_reg_by_idx(R_AX_SCHEDULE_ERR_IMR, mac_idx);
-		rtw89_write32_clr(rtwdev, reg,
-				  B_AX_SORT_NON_IDLE_ERR_INT_EN);
-
-		reg = rtw89_mac_reg_by_idx(R_AX_DLE_CTRL, mac_idx);
-		rtw89_write32_clr(rtwdev, reg,
-				  B_AX_NO_RESERVE_PAGE_ERR_IMR |
-				  B_AX_RXDATA_FSM_HANG_ERROR_IMR);
-
-		reg = rtw89_mac_reg_by_idx(R_AX_PTCL_IMR0, mac_idx);
-		val = B_AX_F2PCMD_USER_ALLC_ERR_INT_EN |
-		      B_AX_TX_RECORD_PKTID_ERR_INT_EN |
-		      B_AX_FSM_TIMEOUT_ERR_INT_EN;
-		rtw89_write32(rtwdev, reg, val);
-
-		reg = rtw89_mac_reg_by_idx(R_AX_PHYINFO_ERR_IMR, mac_idx);
-		rtw89_write32_set(rtwdev, reg,
-				  B_AX_PHY_TXON_TIMEOUT_INT_EN |
-				  B_AX_CCK_CCA_TIMEOUT_INT_EN |
-				  B_AX_OFDM_CCA_TIMEOUT_INT_EN |
-				  B_AX_DATA_ON_TIMEOUT_INT_EN |
-				  B_AX_STS_ON_TIMEOUT_INT_EN |
-				  B_AX_CSI_ON_TIMEOUT_INT_EN);
-
-		reg = rtw89_mac_reg_by_idx(R_AX_RMAC_ERR_ISR, mac_idx);
-		val = rtw89_read32(rtwdev, reg);
-		val |= (B_AX_RMAC_RX_CSI_TIMEOUT_INT_EN |
-			B_AX_RMAC_RX_TIMEOUT_INT_EN |
-			B_AX_RMAC_CSI_TIMEOUT_INT_EN);
-		val &= ~(B_AX_RMAC_CCA_TO_IDLE_TIMEOUT_INT_EN |
-			 B_AX_RMAC_DATA_ON_TO_IDLE_TIMEOUT_INT_EN |
-			 B_AX_RMAC_CCA_TIMEOUT_INT_EN |
-			 B_AX_RMAC_DATA_ON_TIMEOUT_INT_EN);
-		rtw89_write32(rtwdev, reg, val);
+		rtw89_scheduler_imr_enable(rtwdev, mac_idx);
+		rtw89_ptcl_imr_enable(rtwdev, mac_idx);
+		rtw89_cdma_imr_enable(rtwdev, mac_idx);
+		rtw89_phy_intf_imr_enable(rtwdev, mac_idx);
+		rtw89_rmac_imr_enable(rtwdev, mac_idx);
+		rtw89_tmac_imr_enable(rtwdev, mac_idx);
 	} else {
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9e445bf9b9d49..3d66d3579af4e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1932,7 +1932,6 @@
 #define R_AX_SCHEDULE_ERR_IMR 0xC3E8
 #define R_AX_SCHEDULE_ERR_IMR_C1 0xE3E8
 #define B_AX_SORT_NON_IDLE_ERR_INT_EN BIT(1)
-#define B_AX_FSM_TIMEOUT_ERR_INT_EN BIT(0)
 
 #define R_AX_SCHEDULE_ERR_ISR 0xC3EC
 #define R_AX_SCHEDULE_ERR_ISR_C1 0xE3EC
@@ -2206,8 +2205,48 @@
 
 #define R_AX_PTCL_IMR0 0xC6C0
 #define R_AX_PTCL_IMR0_C1 0xE6C0
+#define B_AX_F2PCMD_PKTID_ERR_INT_EN BIT(31)
+#define B_AX_F2PCMD_RD_PKTID_ERR_INT_EN BIT(30)
+#define B_AX_F2PCMD_ASSIGN_PKTID_ERR_INT_EN BIT(29)
 #define B_AX_F2PCMD_USER_ALLC_ERR_INT_EN BIT(28)
+#define B_AX_RX_SPF_U0_PKTID_ERR_INT_EN BIT(27)
+#define B_AX_TX_SPF_U1_PKTID_ERR_INT_EN BIT(26)
+#define B_AX_TX_SPF_U2_PKTID_ERR_INT_EN BIT(25)
+#define B_AX_TX_SPF_U3_PKTID_ERR_INT_EN BIT(24)
 #define B_AX_TX_RECORD_PKTID_ERR_INT_EN BIT(23)
+#define B_AX_F2PCMD_EMPTY_ERR_INT_EN BIT(15)
+#define B_AX_TWTSP_QSEL_ERR_INT_EN BIT(14)
+#define B_AX_BCNQ_ORDER_ERR_INT_EN BIT(12)
+#define B_AX_Q_PKTID_ERR_INT_EN BIT(11)
+#define B_AX_D_PKTID_ERR_INT_EN BIT(10)
+#define B_AX_TXPRT_FULL_DROP_ERR_INT_EN BIT(9)
+#define B_AX_F2PCMDRPT_FULL_DROP_ERR_INT_EN BIT(8)
+#define B_AX_FSM1_TIMEOUT_ERR_INT_EN BIT(1)
+#define B_AX_FSM_TIMEOUT_ERR_INT_EN BIT(0)
+#define B_AX_PTCL_IMR_CLR (B_AX_FSM_TIMEOUT_ERR_INT_EN | \
+			   B_AX_F2PCMDRPT_FULL_DROP_ERR_INT_EN | \
+			   B_AX_TXPRT_FULL_DROP_ERR_INT_EN | \
+			   B_AX_D_PKTID_ERR_INT_EN | \
+			   B_AX_Q_PKTID_ERR_INT_EN | \
+			   B_AX_BCNQ_ORDER_ERR_INT_EN | \
+			   B_AX_TWTSP_QSEL_ERR_INT_EN | \
+			   B_AX_F2PCMD_EMPTY_ERR_INT_EN | \
+			   B_AX_TX_RECORD_PKTID_ERR_INT_EN | \
+			   B_AX_TX_SPF_U3_PKTID_ERR_INT_EN | \
+			   B_AX_TX_SPF_U2_PKTID_ERR_INT_EN | \
+			   B_AX_TX_SPF_U1_PKTID_ERR_INT_EN | \
+			   B_AX_RX_SPF_U0_PKTID_ERR_INT_EN | \
+			   B_AX_F2PCMD_USER_ALLC_ERR_INT_EN | \
+			   B_AX_F2PCMD_ASSIGN_PKTID_ERR_INT_EN | \
+			   B_AX_F2PCMD_RD_PKTID_ERR_INT_EN | \
+			   B_AX_F2PCMD_PKTID_ERR_INT_EN)
+#define B_AX_PTCL_IMR_SET (B_AX_FSM_TIMEOUT_ERR_INT_EN | \
+			   B_AX_TX_RECORD_PKTID_ERR_INT_EN | \
+			   B_AX_F2PCMD_USER_ALLC_ERR_INT_EN)
+#define B_AX_PTCL_IMR_CLR_V1 (B_AX_FSM1_TIMEOUT_ERR_INT_EN | \
+			      B_AX_FSM_TIMEOUT_ERR_INT_EN)
+#define B_AX_PTCL_IMR_SET_V1 (B_AX_FSM1_TIMEOUT_ERR_INT_EN | \
+			      B_AX_FSM_TIMEOUT_ERR_INT_EN)
 
 #define R_AX_PTCL_ISR0 0xC6C4
 #define R_AX_PTCL_ISR0_C1 0xE6C4
@@ -2234,10 +2273,142 @@
 #define R_AX_DLE_CTRL_C1 0xE800
 #define B_AX_NO_RESERVE_PAGE_ERR_IMR BIT(23)
 #define B_AX_RXDATA_FSM_HANG_ERROR_IMR BIT(15)
+#define B_AX_RXSTS_FSM_HANG_ERROR_IMR BIT(14)
+#define B_AX_DLE_IMR_CLR (B_AX_RXSTS_FSM_HANG_ERROR_IMR | \
+			  B_AX_RXDATA_FSM_HANG_ERROR_IMR | \
+			  B_AX_NO_RESERVE_PAGE_ERR_IMR)
+#define B_AX_DLE_IMR_SET (B_AX_RXSTS_FSM_HANG_ERROR_IMR | \
+			  B_AX_RXDATA_FSM_HANG_ERROR_IMR)
+
 #define R_AX_RXDMA_PKT_INFO_0 0xC814
 #define R_AX_RXDMA_PKT_INFO_1 0xC818
 #define R_AX_RXDMA_PKT_INFO_2 0xC81C
 
+#define R_AX_RX_ERR_FLAG_IMR 0xC804
+#define R_AX_RX_ERR_FLAG_IMR_C1 0xE804
+#define B_AX_RX_GET_NULL_PKT_ERR_MSK BIT(30)
+#define B_AX_RX_RU0_FSM_HANG_MSK_ERR_MSK BIT(29)
+#define B_AX_RX_RU1_FSM_HANG_MSK_ERR_MSK BIT(28)
+#define B_AX_RX_RU2_FSM_HANG_MSK_ERR_MSK BIT(27)
+#define B_AX_RX_RU3_FSM_HANG_MSK_ERR_MSK BIT(26)
+#define B_AX_RX_RU4_FSM_HANG_MSK_ERR_MSK BIT(25)
+#define B_AX_RX_RU5_FSM_HANG_MSK_ERR_MSK BIT(24)
+#define B_AX_RX_RU6_FSM_HANG_MSK_ERR_MSK BIT(23)
+#define B_AX_RX_RU7_FSM_HANG_MSK_ERR_MSK BIT(22)
+#define B_AX_RX_RXSTS_FSM_HANG_MSK_ERR_MSK BIT(21)
+#define B_AX_RX_CSI_FSM_HANG_MSK_ERR_MSK BIT(20)
+#define B_AX_RX_TXRPT_FSM_HANG_MSK_ERR_MSK BIT(19)
+#define B_AX_RX_F2PCMD_FSM_HANG_MSK_ERR_MSK BIT(18)
+#define B_AX_RX_RU0_ZERO_LEN_ERR_MSK BIT(17)
+#define B_AX_RX_RU1_ZERO_LEN_ERR_MSK BIT(16)
+#define B_AX_RX_RU2_ZERO_LEN_ERR_MSK BIT(15)
+#define B_AX_RX_RU3_ZERO_LEN_ERR_MSK BIT(14)
+#define B_AX_RX_RU4_ZERO_LEN_ERR_MSK BIT(13)
+#define B_AX_RX_RU5_ZERO_LEN_ERR_MSK BIT(12)
+#define B_AX_RX_RU6_ZERO_LEN_ERR_MSK BIT(11)
+#define B_AX_RX_RU7_ZERO_LEN_ERR_MSK BIT(10)
+#define B_AX_RX_RXSTS_ZERO_LEN_ERR_MSK BIT(9)
+#define B_AX_RX_CSI_ZERO_LEN_ERR_MSK BIT(8)
+#define B_AX_PLE_DATA_OPT_FSM_HANG_MSK BIT(7)
+#define B_AX_PLE_RXDATA_REQ_BUF_FSM_HANG_MSK BIT(6)
+#define B_AX_PLE_TXRPT_REQ_BUF_FSM_HANG_MSK BIT(5)
+#define B_AX_PLE_WD_OPT_FSM_HANG_MSK BIT(4)
+#define B_AX_PLE_ENQ_FSM_HANG_MSK BIT(3)
+#define B_AX_RXDATA_ENQUE_ORDER_ERR_MSK BIT(2)
+#define B_AX_RXSTS_ENQUE_ORDER_ERR_MSK BIT(1)
+#define B_AX_RX_CSI_PKT_NUM_ERR_MSK BIT(0)
+#define B_AX_RX_ERR_IMR_CLR_V1 (B_AX_RXSTS_ENQUE_ORDER_ERR_MSK | \
+				B_AX_RXDATA_ENQUE_ORDER_ERR_MSK | \
+				B_AX_RX_CSI_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RXSTS_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU7_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU6_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU5_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU4_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU3_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU2_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU1_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU0_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_F2PCMD_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_TXRPT_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_CSI_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RXSTS_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU7_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU6_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU5_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU4_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU3_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU2_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU1_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU0_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_GET_NULL_PKT_ERR_MSK)
+#define B_AX_RX_ERR_IMR_SET_V1 (B_AX_RXSTS_ENQUE_ORDER_ERR_MSK | \
+				B_AX_RXDATA_ENQUE_ORDER_ERR_MSK | \
+				B_AX_RX_CSI_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RXSTS_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU7_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU6_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU5_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU4_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU3_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU2_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU1_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_RU0_ZERO_LEN_ERR_MSK | \
+				B_AX_RX_F2PCMD_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_TXRPT_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_CSI_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RXSTS_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU7_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU6_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU5_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU4_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU3_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU2_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU1_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_RU0_FSM_HANG_MSK_ERR_MSK | \
+				B_AX_RX_GET_NULL_PKT_ERR_MSK)
+
+#define R_AX_TX_ERR_FLAG_IMR 0xC870
+#define R_AX_TX_ERR_FLAG_IMR_C1 0xE870
+#define B_AX_TX_RU0_FSM_HANG_ERR_MSK BIT(31)
+#define B_AX_TX_RU1_FSM_HANG_ERR_MSK BIT(30)
+#define B_AX_TX_RU2_FSM_HANG_ERR_MSK BIT(29)
+#define B_AX_TX_RU3_FSM_HANG_ERR_MSK BIT(28)
+#define B_AX_TX_RU4_FSM_HANG_ERR_MSK BIT(27)
+#define B_AX_TX_RU5_FSM_HANG_ERR_MSK BIT(26)
+#define B_AX_TX_RU6_FSM_HANG_ERR_MSK BIT(25)
+#define B_AX_TX_RU7_FSM_HANG_ERR_MSK BIT(24)
+#define B_AX_TX_RU8_FSM_HANG_ERR_MSK BIT(23)
+#define B_AX_TX_RU9_FSM_HANG_ERR_MSK BIT(22)
+#define B_AX_TX_RU10_FSM_HANG_ERR_MSK BIT(21)
+#define B_AX_TX_RU11_FSM_HANG_ERR_MSK BIT(20)
+#define B_AX_TX_RU12_FSM_HANG_ERR_MSK BIT(19)
+#define B_AX_TX_RU13_FSM_HANG_ERR_MSK BIT(18)
+#define B_AX_TX_RU14_FSM_HANG_ERR_MSK BIT(17)
+#define B_AX_TX_RU15_FSM_HANG_ERR_MSK BIT(16)
+#define B_AX_TX_CSI_FSM_HANG_ERR_MSK BIT(15)
+#define B_AX_TX_WD_PLD_ID_FSM_HANG_ERR_MSK BIT(14)
+#define B_AX_TX_ERR_IMR_CLR_V1 (B_AX_TX_WD_PLD_ID_FSM_HANG_ERR_MSK | \
+				B_AX_TX_CSI_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU7_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU6_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU5_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU4_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU3_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU2_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU1_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU0_FSM_HANG_ERR_MSK)
+#define B_AX_TX_ERR_IMR_SET_V1 (B_AX_TX_WD_PLD_ID_FSM_HANG_ERR_MSK | \
+				B_AX_TX_CSI_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU7_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU6_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU5_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU4_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU3_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU2_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU1_FSM_HANG_ERR_MSK | \
+				B_AX_TX_RU0_FSM_HANG_ERR_MSK)
+
 #define R_AX_TCR0 0xCA00
 #define R_AX_TCR0_C1 0xEA00
 #define B_AX_TCR_ZLD_NUM_MASK GENMASK(31, 24)
@@ -2370,6 +2541,38 @@
 #define B_AX_RXTRIG_EN BIT(16)
 #define B_AX_RXTRIG_USERINFO_2_MASK GENMASK(15, 0)
 
+#define R_AX_TRXPTCL_ERROR_INDICA_MASK 0xCCBC
+#define R_AX_TRXPTCL_ERROR_INDICA_MASK_C1 0xECBC
+#define B_AX_WMAC_MODE BIT(22)
+#define B_AX_WMAC_TIMETOUT_THR_MASK GENMASK(21, 16)
+#define B_AX_RMAC_FTM BIT(8)
+#define B_AX_RMAC_CSI BIT(7)
+#define B_AX_TMAC_MIMO_CTRL BIT(6)
+#define B_AX_TMAC_RXTB BIT(5)
+#define B_AX_TMAC_HWSIGB_GEN BIT(4)
+#define B_AX_TMAC_TXPLCP BIT(3)
+#define B_AX_TMAC_RESP BIT(2)
+#define B_AX_TMAC_TXCTL BIT(1)
+#define B_AX_TMAC_MACTX BIT(0)
+#define B_AX_TMAC_IMR_CLR_V1 (B_AX_TMAC_MACTX | \
+			      B_AX_TMAC_TXCTL | \
+			      B_AX_TMAC_RESP | \
+			      B_AX_TMAC_TXPLCP | \
+			      B_AX_TMAC_HWSIGB_GEN | \
+			      B_AX_TMAC_RXTB | \
+			      B_AX_TMAC_MIMO_CTRL | \
+			      B_AX_RMAC_CSI | \
+			      B_AX_RMAC_FTM)
+#define B_AX_TMAC_IMR_SET_V1 (B_AX_TMAC_MACTX | \
+			      B_AX_TMAC_TXCTL | \
+			      B_AX_TMAC_RESP | \
+			      B_AX_TMAC_TXPLCP | \
+			      B_AX_TMAC_HWSIGB_GEN | \
+			      B_AX_TMAC_RXTB | \
+			      B_AX_TMAC_MIMO_CTRL | \
+			      B_AX_RMAC_CSI | \
+			      B_AX_RMAC_FTM)
+
 #define R_AX_WMAC_TX_TF_INFO_0 0xCCD0
 #define R_AX_WMAC_TX_TF_INFO_0_C1 0xECD0
 #define B_AX_WMAC_TX_TF_INFO_SEL_MASK GENMASK(2, 0)
@@ -2384,11 +2587,55 @@
 
 #define R_AX_TMAC_ERR_IMR_ISR 0xCCEC
 #define R_AX_TMAC_ERR_IMR_ISR_C1 0xECEC
+#define B_AX_TMAC_TXPLCP_ERR_CLR BIT(19)
+#define B_AX_TMAC_RESP_ERR_CLR BIT(18)
+#define B_AX_TMAC_TXCTL_ERR_CLR BIT(17)
+#define B_AX_TMAC_MACTX_ERR_CLR BIT(16)
+#define B_AX_TMAC_TXPLCP_ERR BIT(14)
+#define B_AX_TMAC_RESP_ERR BIT(13)
+#define B_AX_TMAC_TXCTL_ERR BIT(12)
+#define B_AX_TMAC_MACTX_ERR BIT(11)
+#define B_AX_TMAC_TXPLCP_INT_EN BIT(10)
+#define B_AX_TMAC_RESP_INT_EN BIT(9)
+#define B_AX_TMAC_TXCTL_INT_EN BIT(8)
+#define B_AX_TMAC_MACTX_INT_EN BIT(7)
+#define B_AX_WMAC_INT_MODE BIT(6)
+#define B_AX_TMAC_TIMETOUT_THR_MASK GENMASK(5, 0)
+#define B_AX_TMAC_IMR_CLR (B_AX_TMAC_MACTX_INT_EN | \
+			   B_AX_TMAC_TXCTL_INT_EN | \
+			   B_AX_TMAC_RESP_INT_EN | \
+			   B_AX_TMAC_TXPLCP_INT_EN)
+#define B_AX_TMAC_IMR_SET (B_AX_TMAC_MACTX_INT_EN | \
+			   B_AX_TMAC_TXCTL_INT_EN | \
+			   B_AX_TMAC_RESP_INT_EN | \
+			   B_AX_TMAC_TXPLCP_INT_EN)
 
 #define R_AX_DBGSEL_TRXPTCL 0xCCF4
 #define R_AX_DBGSEL_TRXPTCL_C1 0xECF4
 #define B_AX_DBGSEL_TRXPTCL_MASK GENMASK(7, 0)
 
+#define R_AX_PHYINFO_ERR_IMR_V1 0xCCF8
+#define R_AX_PHYINFO_ERR_IMR_V1_C1 0xECF8
+#define B_AX_PHYINTF_TIMEOUT_THR_MSAK_V1 GENMASK(21, 16)
+#define B_AX_CSI_ON_TIMEOUT_EN BIT(5)
+#define B_AX_STS_ON_TIMEOUT_EN BIT(4)
+#define B_AX_DATA_ON_TIMEOUT_EN BIT(3)
+#define B_AX_OFDM_CCA_TIMEOUT_EN BIT(2)
+#define B_AX_CCK_CCA_TIMEOUT_EN BIT(1)
+#define B_AX_PHY_TXON_TIMEOUT_EN BIT(0)
+#define B_AX_PHYINFO_IMR_CLR_V1 (B_AX_PHY_TXON_TIMEOUT_EN | \
+				 B_AX_CCK_CCA_TIMEOUT_EN | \
+				 B_AX_OFDM_CCA_TIMEOUT_EN | \
+				 B_AX_DATA_ON_TIMEOUT_EN | \
+				 B_AX_STS_ON_TIMEOUT_EN | \
+				 B_AX_CSI_ON_TIMEOUT_EN)
+#define B_AX_PHYINFO_IMR_SET_V1 (B_AX_PHY_TXON_TIMEOUT_EN | \
+				 B_AX_CCK_CCA_TIMEOUT_EN | \
+				 B_AX_OFDM_CCA_TIMEOUT_EN | \
+				 B_AX_DATA_ON_TIMEOUT_EN | \
+				 B_AX_STS_ON_TIMEOUT_EN | \
+				 B_AX_CSI_ON_TIMEOUT_EN)
+
 #define R_AX_PHYINFO_ERR_IMR 0xCCFC
 #define R_AX_PHYINFO_ERR_IMR_C1 0xECFC
 #define B_AX_CSI_ON_TIMEOUT BIT(29)
@@ -2404,6 +2651,12 @@
 #define B_AX_CCK_CCA_TIMEOUT_INT_EN BIT(17)
 #define B_AX_PHY_TXON_TIMEOUT_INT_EN BIT(16)
 #define B_AX_PHYINTF_TIMEOUT_THR_MSAK GENMASK(5, 0)
+#define B_AX_PHYINFO_IMR_EN_ALL (B_AX_PHY_TXON_TIMEOUT_INT_EN | \
+				 B_AX_CCK_CCA_TIMEOUT_INT_EN | \
+				 B_AX_OFDM_CCA_TIMEOUT_INT_EN | \
+				 B_AX_DATA_ON_TIMEOUT_INT_EN | \
+				 B_AX_STS_ON_TIMEOUT_INT_EN | \
+				 B_AX_CSI_ON_TIMEOUT_INT_EN)
 
 #define R_AX_PHYINFO_ERR_ISR 0xCCFC
 #define R_AX_PHYINFO_ERR_ISR_C1 0xECFC
@@ -2579,6 +2832,51 @@
 #define B_AX_BMAC_DMA_TIMEOUT_FLAG BIT(2)
 #define B_AX_BMAC_DATA_ON_TO_IDLE_TIMEOUT_FLAG BIT(1)
 #define B_AX_BMAC_CCA_TO_IDLE_TIMEOUT_FLAG BIT(0)
+#define B_AX_RMAC_IMR_CLR (B_AX_RMAC_CCA_TO_IDLE_TIMEOUT_INT_EN | \
+			   B_AX_RMAC_DATA_ON_TO_IDLE_TIMEOUT_INT_EN | \
+			   B_AX_RMAC_DMA_TIMEOUT_INT_EN | \
+			   B_AX_RMAC_CCA_TIMEOUT_INT_EN | \
+			   B_AX_RMAC_DATA_ON_TIMEOUT_INT_EN | \
+			   B_AX_RMAC_CSI_TIMEOUT_INT_EN | \
+			   B_AX_RMAC_RX_TIMEOUT_INT_EN | \
+			   B_AX_RMAC_RX_CSI_TIMEOUT_INT_EN)
+#define B_AX_RMAC_IMR_SET (B_AX_RMAC_DMA_TIMEOUT_INT_EN | \
+			   B_AX_RMAC_CSI_TIMEOUT_INT_EN | \
+			   B_AX_RMAC_RX_TIMEOUT_INT_EN | \
+			   B_AX_RMAC_RX_CSI_TIMEOUT_INT_EN)
+
+#define R_AX_RX_ERR_IMR 0xCEF8
+#define R_AX_RX_ERR_IMR_C1 0xEEF8
+#define B_AX_RX_ERR_TRIG_ACT_TO_MSK BIT(9)
+#define B_AX_RX_ERR_STS_ACT_TO_MSK BIT(8)
+#define B_AX_RX_ERR_CSI_ACT_TO_MSK BIT(7)
+#define B_AX_RX_ERR_ACT_TO_MSK BIT(6)
+#define B_AX_CSI_DATAON_ASSERT_TO_MSK BIT(5)
+#define B_AX_DATAON_ASSERT_TO_MSK BIT(4)
+#define B_AX_CCA_ASSERT_TO_MSK BIT(3)
+#define B_AX_RX_ERR_DMA_TO_MSK BIT(2)
+#define B_AX_RX_ERR_DATA_TO_MSK BIT(1)
+#define B_AX_RX_ERR_CCA_TO_MSK BIT(0)
+#define B_AX_RMAC_IMR_CLR_V1 (B_AX_RX_ERR_CCA_TO_MSK | \
+			      B_AX_RX_ERR_DATA_TO_MSK | \
+			      B_AX_RX_ERR_DMA_TO_MSK | \
+			      B_AX_CCA_ASSERT_TO_MSK | \
+			      B_AX_DATAON_ASSERT_TO_MSK | \
+			      B_AX_CSI_DATAON_ASSERT_TO_MSK | \
+			      B_AX_RX_ERR_ACT_TO_MSK | \
+			      B_AX_RX_ERR_CSI_ACT_TO_MSK | \
+			      B_AX_RX_ERR_STS_ACT_TO_MSK | \
+			      B_AX_RX_ERR_TRIG_ACT_TO_MSK)
+#define B_AX_RMAC_IMR_SET_V1 (B_AX_RX_ERR_CCA_TO_MSK | \
+			      B_AX_RX_ERR_DATA_TO_MSK | \
+			      B_AX_RX_ERR_DMA_TO_MSK | \
+			      B_AX_CCA_ASSERT_TO_MSK | \
+			      B_AX_DATAON_ASSERT_TO_MSK | \
+			      B_AX_CSI_DATAON_ASSERT_TO_MSK | \
+			      B_AX_RX_ERR_ACT_TO_MSK | \
+			      B_AX_RX_ERR_CSI_ACT_TO_MSK | \
+			      B_AX_RX_ERR_STS_ACT_TO_MSK | \
+			      B_AX_RX_ERR_TRIG_ACT_TO_MSK)
 
 #define R_AX_RMAC_PLCP_MON 0xCEF8
 #define R_AX_RMAC_PLCP_MON_C1 0xEEF8
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 1af6057487401..9871ed78e44ca 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -434,6 +434,23 @@ static const struct rtw89_imr_info rtw8852a_imr_info = {
 	.bbrpt_chinfo_err_imr_reg = R_AX_BBRPT_CHINFO_ERR_IMR_ISR,
 	.bbrpt_err_imr_set	= 0,
 	.bbrpt_dfs_err_imr_reg	= R_AX_BBRPT_DFS_ERR_IMR_ISR,
+	.ptcl_imr_clr		= B_AX_PTCL_IMR_CLR,
+	.ptcl_imr_set		= B_AX_PTCL_IMR_SET,
+	.cdma_imr_0_reg		= R_AX_DLE_CTRL,
+	.cdma_imr_0_clr		= B_AX_DLE_IMR_CLR,
+	.cdma_imr_0_set		= B_AX_DLE_IMR_SET,
+	.cdma_imr_1_reg		= 0,
+	.cdma_imr_1_clr		= 0,
+	.cdma_imr_1_set		= 0,
+	.phy_intf_imr_reg	= R_AX_PHYINFO_ERR_IMR,
+	.phy_intf_imr_clr	= 0,
+	.phy_intf_imr_set	= 0,
+	.rmac_imr_reg		= R_AX_RMAC_ERR_ISR,
+	.rmac_imr_clr		= B_AX_RMAC_IMR_CLR,
+	.rmac_imr_set		= B_AX_RMAC_IMR_SET,
+	.tmac_imr_reg		= R_AX_TMAC_ERR_IMR_ISR,
+	.tmac_imr_clr		= B_AX_TMAC_IMR_CLR,
+	.tmac_imr_set		= B_AX_TMAC_IMR_SET,
 };
 
 static void rtw8852ae_efuse_parsing(struct rtw89_efuse *efuse,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 18c17b4bbc181..9689fc5a63723 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -77,6 +77,23 @@ static const struct rtw89_imr_info rtw8852c_imr_info = {
 	.bbrpt_chinfo_err_imr_reg = R_AX_BBRPT_CHINFO_ERR_IMR,
 	.bbrpt_err_imr_set	= R_AX_BBRPT_CHINFO_IMR_SET_V1,
 	.bbrpt_dfs_err_imr_reg	= R_AX_BBRPT_DFS_ERR_IMR,
+	.ptcl_imr_clr		= B_AX_PTCL_IMR_CLR_V1,
+	.ptcl_imr_set		= B_AX_PTCL_IMR_SET_V1,
+	.cdma_imr_0_reg		= R_AX_RX_ERR_FLAG_IMR,
+	.cdma_imr_0_clr		= B_AX_RX_ERR_IMR_CLR_V1,
+	.cdma_imr_0_set		= B_AX_RX_ERR_IMR_SET_V1,
+	.cdma_imr_1_reg		= R_AX_TX_ERR_FLAG_IMR,
+	.cdma_imr_1_clr		= B_AX_TX_ERR_IMR_CLR_V1,
+	.cdma_imr_1_set		= B_AX_TX_ERR_IMR_SET_V1,
+	.phy_intf_imr_reg	= R_AX_PHYINFO_ERR_IMR_V1,
+	.phy_intf_imr_clr	= B_AX_PHYINFO_IMR_CLR_V1,
+	.phy_intf_imr_set	= B_AX_PHYINFO_IMR_SET_V1,
+	.rmac_imr_reg		= R_AX_RX_ERR_IMR,
+	.rmac_imr_clr		= B_AX_RMAC_IMR_CLR_V1,
+	.rmac_imr_set		= B_AX_RMAC_IMR_SET_V1,
+	.tmac_imr_reg		= R_AX_TRXPTCL_ERROR_INDICA_MASK,
+	.tmac_imr_clr		= B_AX_TMAC_IMR_CLR_V1,
+	.tmac_imr_set		= B_AX_TMAC_IMR_SET_V1,
 };
 
 static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
-- 
2.25.1

