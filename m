Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A294F8B6A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 02:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiDHAQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 20:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiDHAQ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 20:16:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40F122FDA4
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 17:14:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2380EBt24019357, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2380EBt24019357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Apr 2022 08:14:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 08:14:11 +0800
Received: from localhost (172.16.21.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 08:14:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <johnson.lin@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH v2 02/13] rtw89: ser: configure D-MAC interrupt mask
Date:   Fri, 8 Apr 2022 08:13:42 +0800
Message-ID: <20220408001353.17188-3-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

These interrupts are used by firmware to recover hardware. Create
functions to set specific D-MAC masks to replace plain register settings.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  29 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 160 +++-
 drivers/net/wireless/realtek/rtw89/reg.h      | 863 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  29 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  29 +
 5 files changed, 1091 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ee2edd9e9173a..d06a9c7cf2972 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2293,6 +2293,34 @@ struct rtw89_page_regs {
 	u32 wp_page_info1;
 };
 
+struct rtw89_imr_info {
+	u32 wdrls_imr_set;
+	u32 wsec_imr_reg;
+	u32 wsec_imr_set;
+	u32 mpdu_tx_imr_set;
+	u32 mpdu_rx_imr_set;
+	u32 sta_sch_imr_set;
+	u32 txpktctl_imr_b0_reg;
+	u32 txpktctl_imr_b0_clr;
+	u32 txpktctl_imr_b0_set;
+	u32 txpktctl_imr_b1_reg;
+	u32 txpktctl_imr_b1_clr;
+	u32 txpktctl_imr_b1_set;
+	u32 wde_imr_clr;
+	u32 wde_imr_set;
+	u32 ple_imr_clr;
+	u32 ple_imr_set;
+	u32 host_disp_imr_clr;
+	u32 host_disp_imr_set;
+	u32 cpu_disp_imr_clr;
+	u32 cpu_disp_imr_set;
+	u32 other_disp_imr_clr;
+	u32 other_disp_imr_set;
+	u32 bbrpt_chinfo_err_imr_reg;
+	u32 bbrpt_err_imr_set;
+	u32 bbrpt_dfs_err_imr_reg;
+};
+
 struct rtw89_chip_info {
 	enum rtw89_core_chip_id chip_id;
 	const struct rtw89_chip_ops *ops;
@@ -2378,6 +2406,7 @@ struct rtw89_chip_info {
 	const struct rtw89_page_regs *page_regs;
 	const struct rtw89_reg_def *dcfo_comp;
 	u8 dcfo_comp_sft;
+	const struct rtw89_imr_info *imr_info;
 };
 
 union rtw89_bus_info {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 34e14a53a5851..eb75f6c703a42 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2607,6 +2607,136 @@ static int band1_enable(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw89_wdrls_imr_enable(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+
+	rtw89_write32_clr(rtwdev, R_AX_WDRLS_ERR_IMR, B_AX_WDRLS_IMR_EN_CLR);
+	rtw89_write32_set(rtwdev, R_AX_WDRLS_ERR_IMR, imr->wdrls_imr_set);
+}
+
+static void rtw89_wsec_imr_enable(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+
+	rtw89_write32_set(rtwdev, imr->wsec_imr_reg, imr->wsec_imr_set);
+}
+
+static void rtw89_mpdu_trx_imr_enable(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+
+	rtw89_write32_clr(rtwdev, R_AX_MPDU_TX_ERR_IMR,
+			  B_AX_TX_GET_ERRPKTID_INT_EN |
+			  B_AX_TX_NXT_ERRPKTID_INT_EN |
+			  B_AX_TX_MPDU_SIZE_ZERO_INT_EN |
+			  B_AX_TX_OFFSET_ERR_INT_EN |
+			  B_AX_TX_HDR3_SIZE_ERR_INT_EN);
+	if (chip_id == RTL8852C)
+		rtw89_write32_clr(rtwdev, R_AX_MPDU_TX_ERR_IMR,
+				  B_AX_TX_ETH_TYPE_ERR_EN |
+				  B_AX_TX_LLC_PRE_ERR_EN |
+				  B_AX_TX_NW_TYPE_ERR_EN |
+				  B_AX_TX_KSRCH_ERR_EN);
+	rtw89_write32_set(rtwdev, R_AX_MPDU_TX_ERR_IMR,
+			  imr->mpdu_tx_imr_set);
+
+	rtw89_write32_clr(rtwdev, R_AX_MPDU_RX_ERR_IMR,
+			  B_AX_GETPKTID_ERR_INT_EN |
+			  B_AX_MHDRLEN_ERR_INT_EN |
+			  B_AX_RPT_ERR_INT_EN);
+	rtw89_write32_set(rtwdev, R_AX_MPDU_RX_ERR_IMR,
+			  imr->mpdu_rx_imr_set);
+}
+
+static void rtw89_sta_sch_imr_enable(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+
+	rtw89_write32_clr(rtwdev, R_AX_STA_SCHEDULER_ERR_IMR,
+			  B_AX_SEARCH_HANG_TIMEOUT_INT_EN |
+			  B_AX_RPT_HANG_TIMEOUT_INT_EN |
+			  B_AX_PLE_B_PKTID_ERR_INT_EN);
+	rtw89_write32_set(rtwdev, R_AX_STA_SCHEDULER_ERR_IMR,
+			  imr->sta_sch_imr_set);
+}
+
+static void rtw89_txpktctl_imr_enable(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+
+	rtw89_write32_clr(rtwdev, imr->txpktctl_imr_b0_reg,
+			  imr->txpktctl_imr_b0_clr);
+	rtw89_write32_set(rtwdev, imr->txpktctl_imr_b0_reg,
+			  imr->txpktctl_imr_b0_set);
+	rtw89_write32_clr(rtwdev, imr->txpktctl_imr_b1_reg,
+			  imr->txpktctl_imr_b1_clr);
+	rtw89_write32_set(rtwdev, imr->txpktctl_imr_b1_reg,
+			  imr->txpktctl_imr_b1_set);
+}
+
+static void rtw89_wde_imr_enable(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+
+	rtw89_write32_clr(rtwdev, R_AX_WDE_ERR_IMR, imr->wde_imr_clr);
+	rtw89_write32_set(rtwdev, R_AX_WDE_ERR_IMR, imr->wde_imr_set);
+}
+
+static void rtw89_ple_imr_enable(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+
+	rtw89_write32_clr(rtwdev, R_AX_PLE_ERR_IMR, imr->ple_imr_clr);
+	rtw89_write32_set(rtwdev, R_AX_PLE_ERR_IMR, imr->ple_imr_set);
+}
+
+static void rtw89_pktin_imr_enable(struct rtw89_dev *rtwdev)
+{
+	rtw89_write32_set(rtwdev, R_AX_PKTIN_ERR_IMR,
+			  B_AX_PKTIN_GETPKTID_ERR_INT_EN);
+}
+
+static void rtw89_dispatcher_imr_enable(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+
+	rtw89_write32_clr(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR,
+			  imr->host_disp_imr_clr);
+	rtw89_write32_set(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR,
+			  imr->host_disp_imr_set);
+	rtw89_write32_clr(rtwdev, R_AX_CPU_DISPATCHER_ERR_IMR,
+			  imr->cpu_disp_imr_clr);
+	rtw89_write32_set(rtwdev, R_AX_CPU_DISPATCHER_ERR_IMR,
+			  imr->cpu_disp_imr_set);
+	rtw89_write32_clr(rtwdev, R_AX_OTHER_DISPATCHER_ERR_IMR,
+			  imr->other_disp_imr_clr);
+	rtw89_write32_set(rtwdev, R_AX_OTHER_DISPATCHER_ERR_IMR,
+			  imr->other_disp_imr_set);
+}
+
+static void rtw89_cpuio_imr_enable(struct rtw89_dev *rtwdev)
+{
+	rtw89_write32_clr(rtwdev, R_AX_CPUIO_ERR_IMR, B_AX_CPUIO_IMR_CLR);
+	rtw89_write32_set(rtwdev, R_AX_CPUIO_ERR_IMR, B_AX_CPUIO_IMR_SET);
+}
+
+static void rtw89_bbrpt_imr_enable(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
+
+	rtw89_write32_set(rtwdev, R_AX_BBRPT_COM_ERR_IMR,
+			  B_AX_BBRPT_COM_NULL_PLPKTID_ERR_INT_EN);
+	rtw89_write32_clr(rtwdev, imr->bbrpt_chinfo_err_imr_reg,
+			  B_AX_BBRPT_CHINFO_IMR_CLR);
+	rtw89_write32_set(rtwdev, imr->bbrpt_chinfo_err_imr_reg,
+			  imr->bbrpt_err_imr_set);
+	rtw89_write32_set(rtwdev, imr->bbrpt_dfs_err_imr_reg,
+			  B_AX_BBRPT_DFS_TO_ERR_INT_EN);
+	rtw89_write32_set(rtwdev, R_AX_LA_ERRFLAG, B_AX_LA_IMR_DATA_LOSS_ERR);
+}
+
 static int rtw89_mac_enable_imr(struct rtw89_dev *rtwdev, u8 mac_idx,
 				enum rtw89_mac_hwmod_sel sel)
 {
@@ -2621,25 +2751,17 @@ static int rtw89_mac_enable_imr(struct rtw89_dev *rtwdev, u8 mac_idx,
 	}
 
 	if (sel == RTW89_DMAC_SEL) {
-		rtw89_write32_clr(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR,
-				  B_AX_TXPKTCTL_USRCTL_RLSBMPLEN_ERR_INT_EN |
-				  B_AX_TXPKTCTL_USRCTL_RDNRLSCMD_ERR_INT_EN |
-				  B_AX_TXPKTCTL_CMDPSR_FRZTO_ERR_INT_EN);
-		rtw89_write32_clr(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR_B1,
-				  B_AX_TXPKTCTL_USRCTL_RLSBMPLEN_ERR_INT_EN |
-				  B_AX_TXPKTCTL_USRCTL_RDNRLSCMD_ERR_INT_EN);
-		rtw89_write32_clr(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR,
-				  B_AX_HDT_PKT_FAIL_DBG_INT_EN |
-				  B_AX_HDT_OFFSET_UNMATCH_INT_EN);
-		rtw89_write32_clr(rtwdev, R_AX_CPU_DISPATCHER_ERR_IMR,
-				  B_AX_CPU_SHIFT_EN_ERR_INT_EN);
-		rtw89_write32_clr(rtwdev, R_AX_PLE_ERR_IMR,
-				  B_AX_PLE_GETNPG_STRPG_ERR_INT_EN);
-		rtw89_write32_clr(rtwdev, R_AX_WDRLS_ERR_IMR,
-				  B_AX_WDRLS_PLEBREQ_TO_ERR_INT_EN);
-		rtw89_write32_set(rtwdev, R_AX_HD0IMR, B_AX_WDT_PTFM_INT_EN);
-		rtw89_write32_clr(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR,
-				  B_AX_TXPKTCTL_USRCTL_NOINIT_ERR_INT_EN);
+		rtw89_wdrls_imr_enable(rtwdev);
+		rtw89_wsec_imr_enable(rtwdev);
+		rtw89_mpdu_trx_imr_enable(rtwdev);
+		rtw89_sta_sch_imr_enable(rtwdev);
+		rtw89_txpktctl_imr_enable(rtwdev);
+		rtw89_wde_imr_enable(rtwdev);
+		rtw89_ple_imr_enable(rtwdev);
+		rtw89_pktin_imr_enable(rtwdev);
+		rtw89_dispatcher_imr_enable(rtwdev);
+		rtw89_cpuio_imr_enable(rtwdev);
+		rtw89_bbrpt_imr_enable(rtwdev);
 	} else if (sel == RTW89_CMAC_SEL) {
 		reg = rtw89_mac_reg_by_idx(R_AX_SCHEDULE_ERR_IMR, mac_idx);
 		rtw89_write32_clr(rtwdev, reg,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index a0c60528b5780..9e445bf9b9d49 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -527,13 +527,361 @@
 #define B_AX_HOST_ADDR_INFO_8B_SEL BIT(0)
 
 #define R_AX_HOST_DISPATCHER_ERR_IMR 0x8850
+#define B_AX_HDT_RX_WRITE_UNDERFLOW_INT_EN BIT(31)
+#define B_AX_HDT_RX_WRITE_OVERFLOW_INT_EN BIT(30)
+#define B_AX_HDT_CHKSUM_FSM_ERR_INT_EN BIT(29)
+#define B_AX_HDT_SHIFT_DMA_CFG_ERR_INT_EN BIT(28)
+#define B_AX_HDT_DMA_PROCESS_ERR_INT_EN BIT(27)
+#define B_AX_HDT_TOTAL_LEN_ERR_INT_EN BIT(26)
+#define B_AX_HDT_SHIFT_EN_ERR_INT_EN BIT(25)
+#define B_AX_HDT_RXAGG_CFG_ERR_INT_EN BIT(24)
+#define B_AX_HDT_OUTPUT_ERR_INT_EN BIT(21)
+#define B_AX_HDT_RES_ERR_INT_EN BIT(20)
+#define B_AX_HDT_BURST_NUM_ERR_INT_EN BIT(19)
+#define B_AX_HDT_NULLPKT_ERR_INT_EN BIT(18)
+#define B_AX_HDT_FLOW_CTRL_ERR_INT_EN BIT(17)
+#define B_AX_HDT_PLD_CMD_UNDERFLOW_INT_EN BIT(16)
+#define B_AX_HDT_PLD_CMD_OVERLOW_INT_EN BIT(15)
+#define B_AX_HDT_TX_WRITE_UNDERFLOW_INT_EN BIT(14)
+#define B_AX_HDT_TX_WRITE_OVERFLOW_INT_EN BIT(13)
+#define B_AX_HDT_TCP_CHK_ERR_INT_EN BIT(12)
+#define B_AX_HDT_TXPKTSIZE_ERR_INT_EN BIT(11)
+#define B_AX_HDT_PRE_COST_ERR_INT_EN BIT(10)
+#define B_AX_HDT_WD_CHK_ERR_INT_EN BIT(9)
+#define B_AX_HDT_CHANNEL_DMA_ERR_INT_EN BIT(8)
 #define B_AX_HDT_OFFSET_UNMATCH_INT_EN BIT(7)
+#define B_AX_HDT_PAYLOAD_UNDERFLOW_INT_EN BIT(6)
+#define B_AX_HDT_PAYLOAD_OVERFLOW_INT_EN BIT(5)
+#define B_AX_HDT_PERMU_UNDERFLOW_INT_EN BIT(4)
+#define B_AX_HDT_PERMU_OVERFLOW_INT_EN BIT(3)
 #define B_AX_HDT_PKT_FAIL_DBG_INT_EN BIT(2)
+#define B_AX_HDT_CHANNEL_ID_ERR_INT_EN BIT(1)
+#define B_AX_HDT_CHANNEL_DIFF_ERR_INT_EN BIT(0)
+#define B_AX_HOST_DISP_IMR_CLR (B_AX_HDT_CHANNEL_DIFF_ERR_INT_EN | \
+				B_AX_HDT_CHANNEL_ID_ERR_INT_EN | \
+				B_AX_HDT_PKT_FAIL_DBG_INT_EN | \
+				B_AX_HDT_PERMU_OVERFLOW_INT_EN | \
+				B_AX_HDT_PERMU_UNDERFLOW_INT_EN | \
+				B_AX_HDT_PAYLOAD_OVERFLOW_INT_EN | \
+				B_AX_HDT_PAYLOAD_UNDERFLOW_INT_EN | \
+				B_AX_HDT_OFFSET_UNMATCH_INT_EN | \
+				B_AX_HDT_CHANNEL_DMA_ERR_INT_EN | \
+				B_AX_HDT_WD_CHK_ERR_INT_EN | \
+				B_AX_HDT_PRE_COST_ERR_INT_EN | \
+				B_AX_HDT_TXPKTSIZE_ERR_INT_EN | \
+				B_AX_HDT_TCP_CHK_ERR_INT_EN | \
+				B_AX_HDT_TX_WRITE_OVERFLOW_INT_EN | \
+				B_AX_HDT_TX_WRITE_UNDERFLOW_INT_EN | \
+				B_AX_HDT_PLD_CMD_OVERLOW_INT_EN | \
+				B_AX_HDT_PLD_CMD_UNDERFLOW_INT_EN | \
+				B_AX_HDT_FLOW_CTRL_ERR_INT_EN | \
+				B_AX_HDT_NULLPKT_ERR_INT_EN | \
+				B_AX_HDT_BURST_NUM_ERR_INT_EN | \
+				B_AX_HDT_RXAGG_CFG_ERR_INT_EN | \
+				B_AX_HDT_SHIFT_EN_ERR_INT_EN | \
+				B_AX_HDT_TOTAL_LEN_ERR_INT_EN | \
+				B_AX_HDT_DMA_PROCESS_ERR_INT_EN | \
+				B_AX_HDT_SHIFT_DMA_CFG_ERR_INT_EN | \
+				B_AX_HDT_CHKSUM_FSM_ERR_INT_EN | \
+				B_AX_HDT_RX_WRITE_OVERFLOW_INT_EN | \
+				B_AX_HDT_RX_WRITE_UNDERFLOW_INT_EN)
+#define B_AX_HOST_DISP_IMR_SET (B_AX_HDT_CHANNEL_DIFF_ERR_INT_EN | \
+				B_AX_HDT_PAYLOAD_OVERFLOW_INT_EN | \
+				B_AX_HDT_PAYLOAD_UNDERFLOW_INT_EN | \
+				B_AX_HDT_CHANNEL_DMA_ERR_INT_EN | \
+				B_AX_HDT_TOTAL_LEN_ERR_INT_EN | \
+				B_AX_HDT_DMA_PROCESS_ERR_INT_EN)
+
+#define B_AX_HR_WRFF_UNDERFLOW_ERR_INT_EN BIT(31)
+#define B_AX_HR_WRFF_OVERFLOW_ERR_INT_EN BIT(30)
+#define B_AX_HR_CHKSUM_FSM_ERR_INT_EN BIT(29)
+#define B_AX_HR_SHIFT_DMA_CFG_ERR_INT_EN BIT(28)
+#define B_AX_HR_DMA_PROCESS_ERR_INT_EN BIT(27)
+#define B_AX_HR_TOTAL_LEN_UNDER_ERR_INT_EN BIT(26)
+#define B_AX_HR_SHIFT_EN_ERR_INT_EN BIT(25)
+#define B_AX_HR_AGG_CFG_ERR_INT_EN BIT(24)
+#define B_AX_HR_DMA_RD_CNT_DEQ_ERR_INT_EN BIT(23)
+#define B_AX_HR_PLD_LEN_ZERO_ERR_INT_EN BIT(22)
+#define B_AX_HT_ILL_CH_ERR_INT_EN BIT(20)
+#define B_AX_HT_ADDR_INFO_LEN_ERR_INT_EN BIT(18)
+#define B_AX_HT_WD_LEN_OVER_ERR_INT_EN BIT(17)
+#define B_AX_HT_PLD_CMD_UNDERFLOW_ERR_INT_EN BIT(16)
+#define B_AX_HT_PLD_CMD_OVERFLOW_ERR_INT_EN BIT(15)
+#define B_AX_HT_WRFF_UNDERFLOW_ERR_INT_EN BIT(14)
+#define B_AX_HT_WRFF_OVERFLOW_ERR_INT_EN BIT(13)
+#define B_AX_HT_CHKSUM_FSM_ERR_INT_EN BIT(12)
+#define B_AX_HT_TXPKTSIZE_ERR_INT_EN BIT(11)
+#define B_AX_HT_PRE_SUB_ERR_INT_EN BIT(10)
+#define B_AX_HT_WD_CHKSUM_ERR_INT_EN BIT(9)
+#define B_AX_HT_CHANNEL_DMA_ERR_INT_EN BIT(8)
+#define B_AX_HT_OFFSET_UNMATCH_ERR_INT_EN BIT(7)
+#define B_AX_HT_PAYLOAD_UNDER_ERR_INT_EN BIT(6)
+#define B_AX_HT_PAYLOAD_OVER_ERR_INT_EN BIT(5)
+#define B_AX_HT_PERMU_FF_UNDERFLOW_ERR_INT_EN BIT(4)
+#define B_AX_HT_PERMU_FF_OVERFLOW_ERR_INT_EN BIT(3)
+#define B_AX_HT_PKT_FAIL_ERR_INT_EN BIT(2)
+#define B_AX_HT_CH_ID_ERR_INT_EN BIT(1)
+#define B_AX_HT_EP_CH_DIFF_ERR_INT_EN BIT(0)
+#define B_AX_HOST_DISP_IMR_CLR_V1 (B_AX_HT_EP_CH_DIFF_ERR_INT_EN | \
+				   B_AX_HT_CH_ID_ERR_INT_EN | \
+				   B_AX_HT_PKT_FAIL_ERR_INT_EN | \
+				   B_AX_HT_PERMU_FF_OVERFLOW_ERR_INT_EN | \
+				   B_AX_HT_PERMU_FF_UNDERFLOW_ERR_INT_EN | \
+				   B_AX_HT_PAYLOAD_OVER_ERR_INT_EN | \
+				   B_AX_HT_PAYLOAD_UNDER_ERR_INT_EN | \
+				   B_AX_HT_OFFSET_UNMATCH_ERR_INT_EN | \
+				   B_AX_HT_CHANNEL_DMA_ERR_INT_EN | \
+				   B_AX_HT_WD_CHKSUM_ERR_INT_EN | \
+				   B_AX_HT_PRE_SUB_ERR_INT_EN | \
+				   B_AX_HT_TXPKTSIZE_ERR_INT_EN | \
+				   B_AX_HT_CHKSUM_FSM_ERR_INT_EN | \
+				   B_AX_HT_WRFF_OVERFLOW_ERR_INT_EN | \
+				   B_AX_HT_WRFF_UNDERFLOW_ERR_INT_EN | \
+				   B_AX_HT_PLD_CMD_OVERFLOW_ERR_INT_EN | \
+				   B_AX_HT_PLD_CMD_UNDERFLOW_ERR_INT_EN | \
+				   B_AX_HT_WD_LEN_OVER_ERR_INT_EN | \
+				   B_AX_HT_ADDR_INFO_LEN_ERR_INT_EN | \
+				   B_AX_HT_ILL_CH_ERR_INT_EN | \
+				   B_AX_HR_PLD_LEN_ZERO_ERR_INT_EN | \
+				   B_AX_HR_DMA_RD_CNT_DEQ_ERR_INT_EN | \
+				   B_AX_HR_AGG_CFG_ERR_INT_EN | \
+				   B_AX_HR_SHIFT_EN_ERR_INT_EN | \
+				   B_AX_HR_TOTAL_LEN_UNDER_ERR_INT_EN | \
+				   B_AX_HR_DMA_PROCESS_ERR_INT_EN | \
+				   B_AX_HR_SHIFT_DMA_CFG_ERR_INT_EN | \
+				   B_AX_HR_CHKSUM_FSM_ERR_INT_EN | \
+				   B_AX_HR_WRFF_OVERFLOW_ERR_INT_EN | \
+				   B_AX_HR_WRFF_UNDERFLOW_ERR_INT_EN)
+#define B_AX_HOST_DISP_IMR_SET_V1 (B_AX_HT_PAYLOAD_OVER_ERR_INT_EN | \
+				   B_AX_HT_PAYLOAD_UNDER_ERR_INT_EN | \
+				   B_AX_HT_ILL_CH_ERR_INT_EN | \
+				   B_AX_HR_TOTAL_LEN_UNDER_ERR_INT_EN | \
+				   B_AX_HR_DMA_PROCESS_ERR_INT_EN)
 
 #define R_AX_CPU_DISPATCHER_ERR_IMR 0x8854
+#define B_AX_CPU_RX_WRITE_UNDERFLOW_INT_EN BIT(31)
+#define B_AX_CPU_RX_WRITE_OVERFLOW_INT_EN BIT(30)
+#define B_AX_CPU_CHKSUM_FSM_ERR_INT_EN BIT(29)
+#define B_AX_CPU_SHIFT_DMA_CFG_ERR_INT_EN BIT(28)
+#define B_AX_CPU_DMA_PROCESS_ERR_INT_EN BIT(27)
+#define B_AX_CPU_TOTAL_LEN_ERR_INT_EN BIT(26)
 #define B_AX_CPU_SHIFT_EN_ERR_INT_EN BIT(25)
+#define B_AX_CPU_RXAGG_CFG_ERR_INT_EN BIT(24)
+#define B_AX_CPU_OUTPUT_ERR_INT_EN BIT(20)
+#define B_AX_CPU_RESP_ERR_INT_EN BIT(19)
+#define B_AX_CPU_BURST_NUM_ERR_INT_EN BIT(18)
+#define B_AX_CPU_NULLPKT_ERR_INT_EN BIT(17)
+#define B_AX_CPU_FLOW_CTRL_ERR_INT_EN BIT(16)
+#define B_AX_CPU_F2P_SEQ_ERR_INT_EN BIT(15)
+#define B_AX_CPU_F2P_QSEL_ERR_INT_EN BIT(14)
+#define B_AX_CPU_PLD_CMD_UNDERFLOW_INT_EN BIT(13)
+#define B_AX_CPU_PLD_CMD_OVERLOW_INT_EN BIT(12)
+#define B_AX_CPU_PRE_COST_ERR_INT_EN BIT(11)
+#define B_AX_CPU_WD_CHK_ERR_INT_EN BIT(10)
+#define B_AX_CPU_CHANNEL_DMA_ERR_INT_EN BIT(9)
+#define B_AX_CPU_OFFSET_UNMATCH_INT_EN BIT(8)
+#define B_AX_CPU_PAYLOAD_CHKSUM_ERR_INT_EN BIT(7)
+#define B_AX_CPU_PAYLOAD_UNDERFLOW_INT_EN BIT(6)
+#define B_AX_CPU_PAYLOAD_OVERFLOW_INT_EN BIT(5)
+#define B_AX_CPU_PERMU_UNDERFLOW_INT_EN BIT(4)
+#define B_AX_CPU_PERMU_OVERFLOW_INT_EN BIT(3)
+#define B_AX_CPU_CHANNEL_ID_ERR_INT_EN BIT(2)
+#define B_AX_CPU_PKT_FAIL_DBG_INT_EN BIT(1)
+#define B_AX_CPU_CHANNEL_DIFF_ERR_INT_EN BIT(0)
+#define B_AX_CPU_DISP_IMR_CLR (B_AX_CPU_CHANNEL_DIFF_ERR_INT_EN | \
+			       B_AX_CPU_PKT_FAIL_DBG_INT_EN | \
+			       B_AX_CPU_CHANNEL_ID_ERR_INT_EN | \
+			       B_AX_CPU_PERMU_OVERFLOW_INT_EN | \
+			       B_AX_CPU_PERMU_UNDERFLOW_INT_EN | \
+			       B_AX_CPU_PAYLOAD_OVERFLOW_INT_EN | \
+			       B_AX_CPU_PAYLOAD_UNDERFLOW_INT_EN | \
+			       B_AX_CPU_PAYLOAD_CHKSUM_ERR_INT_EN | \
+			       B_AX_CPU_OFFSET_UNMATCH_INT_EN | \
+			       B_AX_CPU_CHANNEL_DMA_ERR_INT_EN | \
+			       B_AX_CPU_WD_CHK_ERR_INT_EN | \
+			       B_AX_CPU_PRE_COST_ERR_INT_EN | \
+			       B_AX_CPU_PLD_CMD_OVERLOW_INT_EN | \
+			       B_AX_CPU_PLD_CMD_UNDERFLOW_INT_EN | \
+			       B_AX_CPU_F2P_QSEL_ERR_INT_EN | \
+			       B_AX_CPU_F2P_SEQ_ERR_INT_EN | \
+			       B_AX_CPU_FLOW_CTRL_ERR_INT_EN | \
+			       B_AX_CPU_NULLPKT_ERR_INT_EN | \
+			       B_AX_CPU_BURST_NUM_ERR_INT_EN | \
+			       B_AX_CPU_RXAGG_CFG_ERR_INT_EN | \
+			       B_AX_CPU_SHIFT_EN_ERR_INT_EN | \
+			       B_AX_CPU_TOTAL_LEN_ERR_INT_EN | \
+			       B_AX_CPU_DMA_PROCESS_ERR_INT_EN | \
+			       B_AX_CPU_SHIFT_DMA_CFG_ERR_INT_EN | \
+			       B_AX_CPU_CHKSUM_FSM_ERR_INT_EN | \
+			       B_AX_CPU_RX_WRITE_OVERFLOW_INT_EN | \
+			       B_AX_CPU_RX_WRITE_UNDERFLOW_INT_EN)
+#define B_AX_CPU_DISP_IMR_SET (B_AX_CPU_PKT_FAIL_DBG_INT_EN | \
+			       B_AX_CPU_PAYLOAD_OVERFLOW_INT_EN | \
+			       B_AX_CPU_PAYLOAD_UNDERFLOW_INT_EN | \
+			       B_AX_CPU_TOTAL_LEN_ERR_INT_EN)
+
+#define B_AX_CR_PLD_LEN_ERR_INT_EN BIT(30)
+#define B_AX_CR_WRFF_UNDERFLOW_ERR_INT_EN BIT(29)
+#define B_AX_CR_WRFF_OVERFLOW_ERR_INT_EN BIT(28)
+#define B_AX_CR_SHIFT_DMA_CFG_ERR_INT_EN BIT(27)
+#define B_AX_CR_DMA_PROCESS_ERR_INT_EN BIT(26)
+#define B_AX_CR_TOTAL_LEN_UNDER_ERR_INT_EN BIT(25)
+#define B_AX_CR_SHIFT_EN_ERR_INT_EN BIT(24)
+#define B_AX_REUSE_FIFO_B_UNDER_ERR_INT_EN BIT(22)
+#define B_AX_REUSE_FIFO_B_OVER_ERR_INT_EN BIT(21)
+#define B_AX_REUSE_FIFO_A_UNDER_ERR_INT_EN BIT(20)
+#define B_AX_REUSE_FIFO_A_OVER_ERR_INT_EN BIT(19)
+#define B_AX_CT_ADDR_INFO_LEN_MISS_ERR_INT_EN BIT(17)
+#define B_AX_CT_WD_LEN_OVER_ERR_INT_EN BIT(16)
+#define B_AX_CT_F2P_SEQ_ERR_INT_EN BIT(15)
+#define B_AX_CT_F2P_QSEL_ERR_INT_EN BIT(14)
+#define B_AX_CT_PLD_CMD_UNDERFLOW_ERR_INT_EN BIT(13)
+#define B_AX_CT_PLD_CMD_OVERFLOW_ERR_INT_EN BIT(12)
+#define B_AX_CT_PRE_SUB_ERR_INT_EN BIT(11)
+#define B_AX_CT_WD_CHKSUM_ERR_INT_EN BIT(10)
+#define B_AX_CT_CHANNEL_DMA_ERR_INT_EN BIT(9)
+#define B_AX_CT_OFFSET_UNMATCH_ERR_INT_EN BIT(8)
+#define B_AX_CT_PAYLOAD_CHKSUM_ERR_INT_EN BIT(7)
+#define B_AX_CT_PAYLOAD_UNDER_ERR_INT_EN BIT(6)
+#define B_AX_CT_PAYLOAD_OVER_ERR_INT_EN BIT(5)
+#define B_AX_CT_PERMU_FF_UNDERFLOW_ERR_INT_EN BIT(4)
+#define B_AX_CT_PERMU_FF_OVERFLOW_ERR_INT_EN BIT(3)
+#define B_AX_CT_CH_ID_ERR_INT_EN BIT(2)
+#define B_AX_CT_EP_CH_DIFF_ERR_INT_EN BIT(0)
+#define B_AX_CPU_DISP_IMR_CLR_V1 (B_AX_CT_EP_CH_DIFF_ERR_INT_EN | \
+				  B_AX_CT_CH_ID_ERR_INT_EN | \
+				  B_AX_CT_PERMU_FF_OVERFLOW_ERR_INT_EN | \
+				  B_AX_CT_PERMU_FF_UNDERFLOW_ERR_INT_EN | \
+				  B_AX_CT_PAYLOAD_OVER_ERR_INT_EN | \
+				  B_AX_CT_PAYLOAD_UNDER_ERR_INT_EN | \
+				  B_AX_CT_PAYLOAD_CHKSUM_ERR_INT_EN | \
+				  B_AX_CT_OFFSET_UNMATCH_ERR_INT_EN | \
+				  B_AX_CT_CHANNEL_DMA_ERR_INT_EN | \
+				  B_AX_CT_WD_CHKSUM_ERR_INT_EN | \
+				  B_AX_CT_PRE_SUB_ERR_INT_EN | \
+				  B_AX_CT_PLD_CMD_OVERFLOW_ERR_INT_EN | \
+				  B_AX_CT_PLD_CMD_UNDERFLOW_ERR_INT_EN | \
+				  B_AX_CT_F2P_QSEL_ERR_INT_EN | \
+				  B_AX_CT_F2P_SEQ_ERR_INT_EN | \
+				  B_AX_CT_WD_LEN_OVER_ERR_INT_EN | \
+				  B_AX_CT_ADDR_INFO_LEN_MISS_ERR_INT_EN | \
+				  B_AX_REUSE_FIFO_A_OVER_ERR_INT_EN | \
+				  B_AX_REUSE_FIFO_A_UNDER_ERR_INT_EN | \
+				  B_AX_REUSE_FIFO_B_OVER_ERR_INT_EN | \
+				  B_AX_REUSE_FIFO_B_UNDER_ERR_INT_EN | \
+				  B_AX_CR_SHIFT_EN_ERR_INT_EN | \
+				  B_AX_CR_TOTAL_LEN_UNDER_ERR_INT_EN | \
+				  B_AX_CR_DMA_PROCESS_ERR_INT_EN | \
+				  B_AX_CR_SHIFT_DMA_CFG_ERR_INT_EN | \
+				  B_AX_CR_WRFF_OVERFLOW_ERR_INT_EN | \
+				  B_AX_CR_WRFF_UNDERFLOW_ERR_INT_EN | \
+				  B_AX_CR_PLD_LEN_ERR_INT_EN)
+#define B_AX_CPU_DISP_IMR_SET_V1 (B_AX_CT_PAYLOAD_OVER_ERR_INT_EN | \
+				  B_AX_CT_PAYLOAD_UNDER_ERR_INT_EN | \
+				  B_AX_CR_TOTAL_LEN_UNDER_ERR_INT_EN | \
+				  B_AX_CR_DMA_PROCESS_ERR_INT_EN | \
+				  B_AX_CR_WRFF_OVERFLOW_ERR_INT_EN | \
+				  B_AX_CR_WRFF_UNDERFLOW_ERR_INT_EN)
 
 #define R_AX_OTHER_DISPATCHER_ERR_IMR 0x8858
+#define B_AX_OTHER_STF_WROQT_UNDERFLOW_INT_EN BIT(29)
+#define B_AX_OTHER_STF_WROQT_OVERFLOW_INT_EN BIT(28)
+#define B_AX_OTHER_STF_WRFF_UNDERFLOW_INT_EN BIT(27)
+#define B_AX_OTHER_STF_WRFF_OVERFLOW_INT_EN BIT(26)
+#define B_AX_OTHER_STF_CMD_UNDERFLOW_INT_EN BIT(25)
+#define B_AX_OTHER_STF_CMD_OVERFLOW_INT_EN BIT(24)
+#define B_AX_HOST_ADDR_INFO_LEN_ZERO_ERR_INT_EN BIT(17)
+#define B_AX_CPU_ADDR_INFO_LEN_ZERO_ERR_INT_EN BIT(16)
+#define B_AX_PLE_OUTPUT_ERR_INT_EN BIT(12)
+#define B_AX_PLE_RESP_ERR_INT_EN BIT(11)
+#define B_AX_PLE_BURST_NUM_ERR_INT_EN BIT(10)
+#define B_AX_PLE_NULL_PKT_ERR_INT_EN BIT(9)
+#define B_AX_PLE_FLOW_CTRL_ERR_INT_EN BIT(8)
+#define B_AX_WDE_OUTPUT_ERR_INT_EN BIT(4)
+#define B_AX_WDE_RESP_ERR_INT_EN BIT(3)
+#define B_AX_WDE_BURST_NUM_ERR_INT_EN BIT(2)
+#define B_AX_WDE_NULL_PKT_ERR_INT_EN BIT(1)
+#define B_AX_WDE_FLOW_CTRL_ERR_INT_EN BIT(0)
+#define B_AX_OTHER_DISP_IMR_CLR (B_AX_OTHER_STF_WROQT_UNDERFLOW_INT_EN | \
+				 B_AX_OTHER_STF_WROQT_OVERFLOW_INT_EN | \
+				 B_AX_OTHER_STF_WRFF_UNDERFLOW_INT_EN | \
+				 B_AX_OTHER_STF_WRFF_OVERFLOW_INT_EN | \
+				 B_AX_OTHER_STF_CMD_UNDERFLOW_INT_EN | \
+				 B_AX_OTHER_STF_CMD_OVERFLOW_INT_EN | \
+				 B_AX_HOST_ADDR_INFO_LEN_ZERO_ERR_INT_EN | \
+				 B_AX_CPU_ADDR_INFO_LEN_ZERO_ERR_INT_EN | \
+				 B_AX_PLE_OUTPUT_ERR_INT_EN | \
+				 B_AX_PLE_RESP_ERR_INT_EN | \
+				 B_AX_PLE_BURST_NUM_ERR_INT_EN | \
+				 B_AX_PLE_NULL_PKT_ERR_INT_EN | \
+				 B_AX_PLE_FLOW_CTRL_ERR_INT_EN | \
+				 B_AX_WDE_OUTPUT_ERR_INT_EN | \
+				 B_AX_WDE_RESP_ERR_INT_EN | \
+				 B_AX_WDE_BURST_NUM_ERR_INT_EN | \
+				 B_AX_WDE_NULL_PKT_ERR_INT_EN | \
+				 B_AX_WDE_FLOW_CTRL_ERR_INT_EN)
+
+#define B_AX_REUSE_SIZE_ERR_INT_EN BIT(31)
+#define B_AX_REUSE_EN_ERR_INT_EN BIT(30)
+#define B_AX_STF_OQT_UNDERFLOW_ERR_INT_EN BIT(29)
+#define B_AX_STF_OQT_OVERFLOW_ERR_INT_EN BIT(28)
+#define B_AX_STF_WRFF_UNDERFLOW_ERR_INT_EN BIT(27)
+#define B_AX_STF_WRFF_OVERFLOW_ERR_INT_EN BIT(26)
+#define B_AX_STF_CMD_UNDERFLOW_ERR_INT_EN BIT(25)
+#define B_AX_STF_CMD_OVERFLOW_ERR_INT_EN BIT(24)
+#define B_AX_REUSE_SIZE_ZERO_ERR_INT_EN BIT(23)
+#define B_AX_REUSE_PKT_CNT_ERR_INT_EN BIT(22)
+#define B_AX_CDT_PTR_TIMEOUT_ERR_INT_EN BIT(21)
+#define B_AX_CDT_HCI_TIMEOUT_ERR_INT_EN BIT(20)
+#define B_AX_HDT_PTR_TIMEOUT_ERR_INT_EN BIT(19)
+#define B_AX_HDT_HCI_TIMEOUT_ERR_INT_EN BIT(18)
+#define B_AX_CDT_ADDR_INFO_LEN_ERR_INT_EN BIT(17)
+#define B_AX_HDT_ADDR_INFO_LEN_ERR_INT_EN BIT(16)
+#define B_AX_CDR_DMA_TIMEOUT_ERR_INT_EN BIT(15)
+#define B_AX_CDR_RX_TIMEOUT_ERR_INT_EN BIT(14)
+#define B_AX_PLE_RESPOSE_ERR_INT_EN BIT(11)
+#define B_AX_HDR_DMA_TIMEOUT_ERR_INT_EN BIT(7)
+#define B_AX_HDR_RX_TIMEOUT_ERR_INT_EN BIT(6)
+#define B_AX_WDE_RESPONSE_ERR_INT_EN BIT(3)
+#define B_AX_OTHER_DISP_IMR_CLR_V1 (B_AX_CT_EP_CH_DIFF_ERR_INT_EN | \
+				    B_AX_WDE_FLOW_CTRL_ERR_INT_EN | \
+				    B_AX_WDE_NULL_PKT_ERR_INT_EN | \
+				    B_AX_WDE_BURST_NUM_ERR_INT_EN | \
+				    B_AX_WDE_RESPONSE_ERR_INT_EN | \
+				    B_AX_WDE_OUTPUT_ERR_INT_EN | \
+				    B_AX_HDR_RX_TIMEOUT_ERR_INT_EN | \
+				    B_AX_HDR_DMA_TIMEOUT_ERR_INT_EN | \
+				    B_AX_PLE_FLOW_CTRL_ERR_INT_EN | \
+				    B_AX_PLE_NULL_PKT_ERR_INT_EN | \
+				    B_AX_PLE_BURST_NUM_ERR_INT_EN | \
+				    B_AX_PLE_RESPOSE_ERR_INT_EN | \
+				    B_AX_PLE_OUTPUT_ERR_INT_EN | \
+				    B_AX_CDR_RX_TIMEOUT_ERR_INT_EN | \
+				    B_AX_CDR_DMA_TIMEOUT_ERR_INT_EN | \
+				    B_AX_HDT_ADDR_INFO_LEN_ERR_INT_EN | \
+				    B_AX_CDT_ADDR_INFO_LEN_ERR_INT_EN | \
+				    B_AX_HDT_HCI_TIMEOUT_ERR_INT_EN | \
+				    B_AX_HDT_PTR_TIMEOUT_ERR_INT_EN | \
+				    B_AX_CDT_HCI_TIMEOUT_ERR_INT_EN | \
+				    B_AX_CDT_PTR_TIMEOUT_ERR_INT_EN | \
+				    B_AX_REUSE_PKT_CNT_ERR_INT_EN | \
+				    B_AX_REUSE_SIZE_ZERO_ERR_INT_EN | \
+				    B_AX_STF_CMD_OVERFLOW_ERR_INT_EN | \
+				    B_AX_STF_CMD_UNDERFLOW_ERR_INT_EN | \
+				    B_AX_STF_WRFF_OVERFLOW_ERR_INT_EN | \
+				    B_AX_STF_WRFF_UNDERFLOW_ERR_INT_EN | \
+				    B_AX_STF_OQT_OVERFLOW_ERR_INT_EN | \
+				    B_AX_STF_OQT_UNDERFLOW_ERR_INT_EN | \
+				    B_AX_REUSE_EN_ERR_INT_EN | \
+				    B_AX_REUSE_SIZE_ERR_INT_EN)
+#define B_AX_OTHER_DISP_IMR_SET_V1 (B_AX_CDR_RX_TIMEOUT_ERR_INT_EN | \
+				    B_AX_CDR_DMA_TIMEOUT_ERR_INT_EN | \
+				    B_AX_HDT_HCI_TIMEOUT_ERR_INT_EN | \
+				    B_AX_HDT_PTR_TIMEOUT_ERR_INT_EN | \
+				    B_AX_CDT_HCI_TIMEOUT_ERR_INT_EN | \
+				    B_AX_CDT_PTR_TIMEOUT_ERR_INT_EN | \
+				    B_AX_STF_OQT_OVERFLOW_ERR_INT_EN | \
+				    B_AX_STF_OQT_UNDERFLOW_ERR_INT_EN)
 
 #define R_AX_HCI_FC_CTRL 0x8A00
 #define B_AX_HCI_FC_CH12_FULL_COND_MASK GENMASK(11, 10)
@@ -612,9 +960,168 @@
 #define B_AX_WDE_START_BOUND_MASK GENMASK(13, 8)
 #define B_AX_WDE_PAGE_SEL_MASK GENMASK(1, 0)
 #define B_AX_WDE_FREE_PAGE_NUM_MASK GENMASK(28, 16)
+
+#define R_AX_WDE_ERRFLAG_MSG 0x8C30
+#define B_AX_WDE_ERR_FLAG_MSG_MASK GENMASK(31, 0)
+
 #define R_AX_WDE_ERR_FLAG_CFG 0x8C34
+
 #define R_AX_WDE_ERR_IMR 0x8C38
+#define B_AX_WDE_DATCHN_RRDY_ERR_INT_EN BIT(27)
+#define B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN BIT(26)
+#define B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN BIT(25)
+#define B_AX_WDE_DATCHN_ARBT_ERR_INT_EN BIT(24)
+#define B_AX_WDE_QUEMGN_FRZTO_ERR_INT_EN BIT(19)
+#define B_AX_WDE_NXTPKTLL_AD_ERR_INT_EN BIT(18)
+#define B_AX_WDE_PREPKTLLT_AD_ERR_INT_EN BIT(17)
+#define B_AX_WDE_ENQ_PKTCNT_NVAL_ERR_INT_EN BIT(16)
+#define B_AX_WDE_ENQ_PKTCNT_OVRF_ERR_INT_EN BIT(15)
+#define B_AX_WDE_QUE_SRCQUEID_ERR_INT_EN BIT(14)
+#define B_AX_WDE_QUE_DSTQUEID_ERR_INT_EN BIT(13)
+#define B_AX_WDE_QUE_CMDTYPE_ERR_INT_EN BIT(12)
+#define B_AX_WDE_BUFMGN_FRZTO_ERR_INT_EN BIT(7)
+#define B_AX_WDE_GETNPG_PGOFST_ERR_INT_EN BIT(6)
+#define B_AX_WDE_GETNPG_STRPG_ERR_INT_EN BIT(5)
+#define B_AX_WDE_BUFREQ_SRCHTAILPG_ERR_INT_EN BIT(4)
+#define B_AX_WDE_BUFRTN_SIZE_ERR_INT_EN BIT(3)
+#define B_AX_WDE_BUFRTN_INVLD_PKTID_ERR_INT_EN BIT(2)
+#define B_AX_WDE_BUFREQ_UNAVAL_ERR_INT_EN BIT(1)
+#define B_AX_WDE_BUFREQ_QTAID_ERR_INT_EN BIT(0)
+#define B_AX_WDE_IMR_CLR (B_AX_WDE_BUFREQ_QTAID_ERR_INT_EN | \
+			  B_AX_WDE_BUFREQ_UNAVAL_ERR_INT_EN | \
+			  B_AX_WDE_BUFRTN_INVLD_PKTID_ERR_INT_EN | \
+			  B_AX_WDE_BUFRTN_SIZE_ERR_INT_EN | \
+			  B_AX_WDE_BUFREQ_SRCHTAILPG_ERR_INT_EN | \
+			  B_AX_WDE_GETNPG_STRPG_ERR_INT_EN | \
+			  B_AX_WDE_GETNPG_PGOFST_ERR_INT_EN | \
+			  B_AX_WDE_BUFMGN_FRZTO_ERR_INT_EN | \
+			  B_AX_WDE_QUE_CMDTYPE_ERR_INT_EN | \
+			  B_AX_WDE_QUE_DSTQUEID_ERR_INT_EN | \
+			  B_AX_WDE_QUE_SRCQUEID_ERR_INT_EN | \
+			  B_AX_WDE_ENQ_PKTCNT_OVRF_ERR_INT_EN | \
+			  B_AX_WDE_ENQ_PKTCNT_NVAL_ERR_INT_EN | \
+			  B_AX_WDE_PREPKTLLT_AD_ERR_INT_EN | \
+			  B_AX_WDE_NXTPKTLL_AD_ERR_INT_EN | \
+			  B_AX_WDE_QUEMGN_FRZTO_ERR_INT_EN | \
+			  B_AX_WDE_DATCHN_ARBT_ERR_INT_EN | \
+			  B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN | \
+			  B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN)
+#define B_AX_WDE_IMR_SET (B_AX_WDE_BUFREQ_QTAID_ERR_INT_EN | \
+			  B_AX_WDE_BUFREQ_SIZE0_INT_EN | \
+			  B_AX_WDE_BUFREQ_SIZELMT_INT_EN | \
+			  B_AX_WDE_BUFREQ_UNAVAL_ERR_INT_EN_V1 | \
+			  B_AX_WDE_BUFRTN_INVLD_PKTID_ERR_INT_EN_V1 | \
+			  B_AX_WDE_BUFRTN_SIZE_ERR_INT_EN_V1 | \
+			  B_AX_WDE_BUFREQ_SRCHTAILPG_ERR_INT_EN_V1 | \
+			  B_AX_WDE_GETNPG_STRPG_ERR_INT_EN_V1 | \
+			  B_AX_WDE_GETNPG_PGOFST_ERR_INT_EN_V1 | \
+			  B_AX_WDE_BUFMGN_FRZTO_ERR_INT_EN_V1 | \
+			  B_AX_WDE_QUE_CMDTYPE_ERR_INT_EN | \
+			  B_AX_WDE_QUE_DSTQUEID_ERR_INT_EN | \
+			  B_AX_WDE_QUE_SRCQUEID_ERR_INT_EN | \
+			  B_AX_WDE_ENQ_PKTCNT_OVRF_ERR_INT_EN | \
+			  B_AX_WDE_ENQ_PKTCNT_NVAL_ERR_INT_EN | \
+			  B_AX_WDE_PREPKTLLT_AD_ERR_INT_EN | \
+			  B_AX_WDE_NXTPKTLL_AD_ERR_INT_EN | \
+			  B_AX_WDE_QUEMGN_FRZTO_ERR_INT_EN | \
+			  B_AX_WDE_DATCHN_ARBT_ERR_INT_EN | \
+			  B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN | \
+			  B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN | \
+			  B_AX_WDE_DATCHN_RRDY_ERR_INT_EN | \
+			  B_AX_WDE_DATCHN_ADRERR_ERR_INT_EN | \
+			  B_AX_WDE_DATCHN_CAMREQ_ERR_INT_EN)
+
+#define B_AX_WDE_DATCHN_CAMREQ_ERR_INT_EN BIT(29)
+#define B_AX_WDE_DATCHN_ADRERR_ERR_INT_EN BIT(28)
+#define B_AX_WDE_DATCHN_RRDY_ERR_INT_EN BIT(27)
+#define B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN BIT(26)
+#define B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN BIT(25)
+#define B_AX_WDE_DATCHN_ARBT_ERR_INT_EN BIT(24)
+#define B_AX_WDE_QUEMGN_FRZTO_ERR_INT_EN BIT(19)
+#define B_AX_WDE_NXTPKTLL_AD_ERR_INT_EN BIT(18)
+#define B_AX_WDE_PREPKTLLT_AD_ERR_INT_EN BIT(17)
+#define B_AX_WDE_ENQ_PKTCNT_NVAL_ERR_INT_EN BIT(16)
+#define B_AX_WDE_ENQ_PKTCNT_OVRF_ERR_INT_EN BIT(15)
+#define B_AX_WDE_QUE_SRCQUEID_ERR_INT_EN BIT(14)
+#define B_AX_WDE_BUFMGN_FRZTO_ERR_INT_EN_V1 BIT(9)
+#define B_AX_WDE_GETNPG_PGOFST_ERR_INT_EN_V1 BIT(8)
+#define B_AX_WDE_GETNPG_STRPG_ERR_INT_EN_V1 BIT(7)
+#define B_AX_WDE_BUFREQ_SRCHTAILPG_ERR_INT_EN_V1 BIT(6)
+#define B_AX_WDE_BUFRTN_SIZE_ERR_INT_EN_V1 BIT(5)
+#define B_AX_WDE_BUFRTN_INVLD_PKTID_ERR_INT_EN_V1 BIT(4)
+#define B_AX_WDE_BUFREQ_UNAVAL_ERR_INT_EN_V1 BIT(3)
+#define B_AX_WDE_BUFREQ_SIZELMT_INT_EN BIT(2)
+#define B_AX_WDE_BUFREQ_SIZE0_INT_EN BIT(1)
+#define B_AX_WDE_IMR_CLR_V1 (B_AX_WDE_BUFREQ_QTAID_ERR_INT_EN | \
+			     B_AX_WDE_BUFREQ_SIZE0_INT_EN | \
+			     B_AX_WDE_BUFREQ_SIZELMT_INT_EN | \
+			     B_AX_WDE_BUFREQ_UNAVAL_ERR_INT_EN_V1 | \
+			     B_AX_WDE_BUFRTN_INVLD_PKTID_ERR_INT_EN_V1 | \
+			     B_AX_WDE_BUFRTN_SIZE_ERR_INT_EN_V1 | \
+			     B_AX_WDE_BUFREQ_SRCHTAILPG_ERR_INT_EN_V1 | \
+			     B_AX_WDE_GETNPG_STRPG_ERR_INT_EN_V1 | \
+			     B_AX_WDE_GETNPG_PGOFST_ERR_INT_EN_V1 | \
+			     B_AX_WDE_BUFMGN_FRZTO_ERR_INT_EN_V1 | \
+			     B_AX_WDE_QUE_CMDTYPE_ERR_INT_EN | \
+			     B_AX_WDE_QUE_DSTQUEID_ERR_INT_EN | \
+			     B_AX_WDE_QUE_SRCQUEID_ERR_INT_EN | \
+			     B_AX_WDE_ENQ_PKTCNT_OVRF_ERR_INT_EN | \
+			     B_AX_WDE_ENQ_PKTCNT_NVAL_ERR_INT_EN | \
+			     B_AX_WDE_PREPKTLLT_AD_ERR_INT_EN | \
+			     B_AX_WDE_NXTPKTLL_AD_ERR_INT_EN | \
+			     B_AX_WDE_QUEMGN_FRZTO_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_ARBT_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_RRDY_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_ADRERR_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_CAMREQ_ERR_INT_EN)
+#define B_AX_WDE_IMR_SET_V1 (B_AX_WDE_BUFREQ_QTAID_ERR_INT_EN | \
+			     B_AX_WDE_BUFREQ_SIZE0_INT_EN | \
+			     B_AX_WDE_BUFREQ_SIZELMT_INT_EN | \
+			     B_AX_WDE_BUFREQ_UNAVAL_ERR_INT_EN_V1 | \
+			     B_AX_WDE_BUFRTN_INVLD_PKTID_ERR_INT_EN_V1 | \
+			     B_AX_WDE_BUFRTN_SIZE_ERR_INT_EN_V1 | \
+			     B_AX_WDE_BUFREQ_SRCHTAILPG_ERR_INT_EN_V1 | \
+			     B_AX_WDE_GETNPG_STRPG_ERR_INT_EN_V1 | \
+			     B_AX_WDE_GETNPG_PGOFST_ERR_INT_EN_V1 | \
+			     B_AX_WDE_BUFMGN_FRZTO_ERR_INT_EN_V1 | \
+			     B_AX_WDE_QUE_CMDTYPE_ERR_INT_EN | \
+			     B_AX_WDE_QUE_DSTQUEID_ERR_INT_EN | \
+			     B_AX_WDE_QUE_SRCQUEID_ERR_INT_EN | \
+			     B_AX_WDE_ENQ_PKTCNT_OVRF_ERR_INT_EN | \
+			     B_AX_WDE_ENQ_PKTCNT_NVAL_ERR_INT_EN | \
+			     B_AX_WDE_PREPKTLLT_AD_ERR_INT_EN | \
+			     B_AX_WDE_NXTPKTLL_AD_ERR_INT_EN | \
+			     B_AX_WDE_QUEMGN_FRZTO_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_ARBT_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_NULLPG_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_FRZTO_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_RRDY_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_ADRERR_ERR_INT_EN | \
+			     B_AX_WDE_DATCHN_CAMREQ_ERR_INT_EN)
+
 #define R_AX_WDE_ERR_ISR 0x8C3C
+#define B_AX_WDE_DATCHN_RRDY_ERR BIT(27)
+#define B_AX_WDE_DATCHN_FRZTO_ERR BIT(26)
+#define B_AX_WDE_DATCHN_NULLPG_ERR BIT(25)
+#define B_AX_WDE_DATCHN_ARBT_ERR BIT(24)
+#define B_AX_WDE_QUEMGN_FRZTO_ERR BIT(19)
+#define B_AX_WDE_NXTPKTLL_AD_ERR BIT(18)
+#define B_AX_WDE_PREPKTLLT_AD_ERR BIT(17)
+#define B_AX_WDE_ENQ_PKTCNT_NVAL_ERR BIT(16)
+#define B_AX_WDE_ENQ_PKTCNT_OVRF_ERR BIT(15)
+#define B_AX_WDE_QUE_SRCQUEID_ERR BIT(14)
+#define B_AX_WDE_QUE_DSTQUEID_ERR BIT(13)
+#define B_AX_WDE_QUE_CMDTYPE_ERR BIT(12)
+#define B_AX_WDE_BUFMGN_FRZTO_ERR BIT(7)
+#define B_AX_WDE_GETNPG_PGOFST_ERR BIT(6)
+#define B_AX_WDE_GETNPG_STRPG_ERR BIT(5)
+#define B_AX_WDE_BUFREQ_SRCHTAILPG_ERR BIT(4)
+#define B_AX_WDE_BUFRTN_SIZE_ERR BIT(3)
+#define B_AX_WDE_BUFRTN_INVLD_PKTID_ERR BIT(2)
+#define B_AX_WDE_BUFREQ_UNAVAL_ERR BIT(1)
+#define B_AX_WDE_BUFREQ_QTAID_ERR BIT(0)
 
 #define B_AX_WDE_MAX_SIZE_MASK GENMASK(27, 16)
 #define B_AX_WDE_MIN_SIZE_MASK GENMASK(11, 0)
@@ -649,7 +1156,123 @@
 #define R_AX_PLE_ERR_FLAG_CFG 0x9034
 
 #define R_AX_PLE_ERR_IMR 0x9038
+#define B_AX_PLE_DATCHN_RRDY_ERR_INT_EN BIT(27)
+#define B_AX_PLE_DATCHN_FRZTO_ERR_INT_EN BIT(26)
+#define B_AX_PLE_DATCHN_NULLPG_ERR_INT_EN BIT(25)
+#define B_AX_PLE_DATCHN_ARBT_ERR_INT_EN BIT(24)
+#define B_AX_PLE_QUEMGN_FRZTO_ERR_INT_EN BIT(19)
+#define B_AX_PLE_NXTPKTLL_AD_ERR_INT_EN BIT(18)
+#define B_AX_PLE_PREPKTLLT_AD_ERR_INT_EN BIT(17)
+#define B_AX_PLE_ENQ_PKTCNT_NVAL_ERR_INT_EN BIT(16)
+#define B_AX_PLE_ENQ_PKTCNT_OVRF_ERR_INT_EN BIT(15)
+#define B_AX_PLE_QUE_SRCQUEID_ERR_INT_EN BIT(14)
+#define B_AX_PLE_QUE_DSTQUEID_ERR_INT_EN BIT(13)
+#define B_AX_PLE_QUE_CMDTYPE_ERR_INT_EN BIT(12)
+#define B_AX_PLE_BUFMGN_FRZTO_ERR_INT_EN BIT(7)
+#define B_AX_PLE_GETNPG_PGOFST_ERR_INT_EN BIT(6)
 #define B_AX_PLE_GETNPG_STRPG_ERR_INT_EN BIT(5)
+#define B_AX_PLE_BUFREQ_SRCHTAILPG_ERR_INT_EN BIT(4)
+#define B_AX_PLE_BUFRTN_SIZE_ERR_INT_EN BIT(3)
+#define B_AX_PLE_BUFRTN_INVLD_PKTID_ERR_INT_EN BIT(2)
+#define B_AX_PLE_BUFREQ_UNAVAL_ERR_INT_EN BIT(1)
+#define B_AX_PLE_BUFREQ_QTAID_ERR_INT_EN BIT(0)
+#define B_AX_PLE_IMR_CLR (B_AX_PLE_BUFREQ_QTAID_ERR_INT_EN | \
+			  B_AX_PLE_BUFREQ_UNAVAL_ERR_INT_EN | \
+			  B_AX_PLE_BUFRTN_INVLD_PKTID_ERR_INT_EN | \
+			  B_AX_PLE_BUFRTN_SIZE_ERR_INT_EN | \
+			  B_AX_PLE_BUFREQ_SRCHTAILPG_ERR_INT_EN | \
+			  B_AX_PLE_GETNPG_STRPG_ERR_INT_EN | \
+			  B_AX_PLE_GETNPG_PGOFST_ERR_INT_EN | \
+			  B_AX_PLE_BUFMGN_FRZTO_ERR_INT_EN | \
+			  B_AX_PLE_QUE_CMDTYPE_ERR_INT_EN | \
+			  B_AX_PLE_QUE_DSTQUEID_ERR_INT_EN | \
+			  B_AX_PLE_QUE_SRCQUEID_ERR_INT_EN | \
+			  B_AX_PLE_ENQ_PKTCNT_OVRF_ERR_INT_EN | \
+			  B_AX_PLE_ENQ_PKTCNT_NVAL_ERR_INT_EN | \
+			  B_AX_PLE_PREPKTLLT_AD_ERR_INT_EN | \
+			  B_AX_PLE_NXTPKTLL_AD_ERR_INT_EN | \
+			  B_AX_PLE_QUEMGN_FRZTO_ERR_INT_EN | \
+			  B_AX_PLE_DATCHN_ARBT_ERR_INT_EN | \
+			  B_AX_PLE_DATCHN_NULLPG_ERR_INT_EN | \
+			  B_AX_PLE_DATCHN_FRZTO_ERR_INT_EN)
+#define B_AX_PLE_IMR_SET (B_AX_PLE_BUFREQ_QTAID_ERR_INT_EN | \
+			  B_AX_PLE_BUFREQ_UNAVAL_ERR_INT_EN | \
+			  B_AX_PLE_BUFRTN_INVLD_PKTID_ERR_INT_EN | \
+			  B_AX_PLE_BUFRTN_SIZE_ERR_INT_EN | \
+			  B_AX_PLE_BUFREQ_SRCHTAILPG_ERR_INT_EN | \
+			  B_AX_PLE_GETNPG_PGOFST_ERR_INT_EN | \
+			  B_AX_PLE_BUFMGN_FRZTO_ERR_INT_EN | \
+			  B_AX_PLE_QUE_CMDTYPE_ERR_INT_EN | \
+			  B_AX_PLE_QUE_DSTQUEID_ERR_INT_EN | \
+			  B_AX_PLE_QUE_SRCQUEID_ERR_INT_EN | \
+			  B_AX_PLE_ENQ_PKTCNT_OVRF_ERR_INT_EN | \
+			  B_AX_PLE_ENQ_PKTCNT_NVAL_ERR_INT_EN | \
+			  B_AX_PLE_PREPKTLLT_AD_ERR_INT_EN | \
+			  B_AX_PLE_NXTPKTLL_AD_ERR_INT_EN | \
+			  B_AX_PLE_QUEMGN_FRZTO_ERR_INT_EN | \
+			  B_AX_PLE_DATCHN_ARBT_ERR_INT_EN | \
+			  B_AX_PLE_DATCHN_NULLPG_ERR_INT_EN | \
+			  B_AX_PLE_DATCHN_FRZTO_ERR_INT_EN)
+
+#define B_AX_PLE_DATCHN_CAMREQ_ERR_INT_EN BIT(29)
+#define B_AX_PLE_DATCHN_ADRERR_ERR_INT_EN BIT(28)
+#define B_AX_PLE_BUFMGN_FRZTO_ERR_INT_EN_V1 BIT(9)
+#define B_AX_PLE_GETNPG_PGOFST_ERR_INT_EN_V1 BIT(8)
+#define B_AX_PLE_GETNPG_STRPG_ERR_INT_EN_V1 BIT(7)
+#define B_AX_PLE_BUFREQ_SRCHTAILPG_ERR_INT_EN_V1 BIT(6)
+#define B_AX_PLE_BUFRTN_SIZE_ERR_INT_EN_V1 BIT(5)
+#define B_AX_PLE_BUFRTN_INVLD_PKTID_ERR_INT_EN_V1 BIT(4)
+#define B_AX_PLE_BUFREQ_UNAVAL_ERR_INT_EN_V1 BIT(3)
+#define B_AX_PLE_BUFREQ_SIZELMT_INT_EN BIT(2)
+#define B_AX_PLE_BUFREQ_SIZE0_INT_EN BIT(1)
+#define B_AX_PLE_IMR_CLR_V1 (B_AX_PLE_BUFREQ_QTAID_ERR_INT_EN | \
+			     B_AX_PLE_BUFREQ_SIZE0_INT_EN | \
+			     B_AX_PLE_BUFREQ_SIZELMT_INT_EN | \
+			     B_AX_PLE_BUFREQ_UNAVAL_ERR_INT_EN_V1 | \
+			     B_AX_PLE_BUFRTN_INVLD_PKTID_ERR_INT_EN_V1 | \
+			     B_AX_PLE_BUFRTN_SIZE_ERR_INT_EN_V1 | \
+			     B_AX_PLE_BUFREQ_SRCHTAILPG_ERR_INT_EN_V1 | \
+			     B_AX_PLE_GETNPG_STRPG_ERR_INT_EN_V1 | \
+			     B_AX_PLE_GETNPG_PGOFST_ERR_INT_EN_V1 | \
+			     B_AX_PLE_BUFMGN_FRZTO_ERR_INT_EN_V1 | \
+			     B_AX_PLE_QUE_CMDTYPE_ERR_INT_EN | \
+			     B_AX_PLE_QUE_DSTQUEID_ERR_INT_EN | \
+			     B_AX_PLE_QUE_SRCQUEID_ERR_INT_EN | \
+			     B_AX_PLE_ENQ_PKTCNT_OVRF_ERR_INT_EN | \
+			     B_AX_PLE_ENQ_PKTCNT_NVAL_ERR_INT_EN | \
+			     B_AX_PLE_PREPKTLLT_AD_ERR_INT_EN | \
+			     B_AX_PLE_NXTPKTLL_AD_ERR_INT_EN | \
+			     B_AX_PLE_QUEMGN_FRZTO_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_ARBT_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_NULLPG_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_FRZTO_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_RRDY_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_ADRERR_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_CAMREQ_ERR_INT_EN)
+#define B_AX_PLE_IMR_SET_V1 (B_AX_PLE_BUFREQ_QTAID_ERR_INT_EN | \
+			     B_AX_PLE_BUFREQ_SIZE0_INT_EN | \
+			     B_AX_PLE_BUFREQ_SIZELMT_INT_EN | \
+			     B_AX_PLE_BUFREQ_UNAVAL_ERR_INT_EN_V1 | \
+			     B_AX_PLE_BUFRTN_INVLD_PKTID_ERR_INT_EN_V1 | \
+			     B_AX_PLE_BUFRTN_SIZE_ERR_INT_EN_V1 | \
+			     B_AX_PLE_BUFREQ_SRCHTAILPG_ERR_INT_EN_V1 | \
+			     B_AX_PLE_GETNPG_STRPG_ERR_INT_EN_V1 | \
+			     B_AX_PLE_GETNPG_PGOFST_ERR_INT_EN_V1 | \
+			     B_AX_PLE_BUFMGN_FRZTO_ERR_INT_EN_V1 | \
+			     B_AX_PLE_QUE_CMDTYPE_ERR_INT_EN | \
+			     B_AX_PLE_QUE_DSTQUEID_ERR_INT_EN | \
+			     B_AX_PLE_QUE_SRCQUEID_ERR_INT_EN | \
+			     B_AX_PLE_ENQ_PKTCNT_OVRF_ERR_INT_EN | \
+			     B_AX_PLE_ENQ_PKTCNT_NVAL_ERR_INT_EN | \
+			     B_AX_PLE_PREPKTLLT_AD_ERR_INT_EN | \
+			     B_AX_PLE_NXTPKTLL_AD_ERR_INT_EN | \
+			     B_AX_PLE_QUEMGN_FRZTO_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_ARBT_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_NULLPG_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_FRZTO_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_RRDY_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_ADRERR_ERR_INT_EN | \
+			     B_AX_PLE_DATCHN_CAMREQ_ERR_INT_EN)
 
 #define R_AX_PLE_ERR_FLAG_ISR 0x903C
 #define B_AX_PLE_MAX_SIZE_MASK GENMASK(27, 16)
@@ -704,12 +1327,97 @@
 #define B_AX_WDRLS_CTL_FRZTO_ERR_INT_EN BIT(2)
 #define B_AX_WDRLS_CTL_PLPKTID_ISNULL_ERR_INT_EN BIT(1)
 #define B_AX_WDRLS_CTL_WDPKTID_ISNULL_ERR_INT_EN BIT(0)
+#define B_AX_WDRLS_IMR_EN_CLR (B_AX_WDRLS_CTL_WDPKTID_ISNULL_ERR_INT_EN | \
+			       B_AX_WDRLS_CTL_PLPKTID_ISNULL_ERR_INT_EN | \
+			       B_AX_WDRLS_CTL_FRZTO_ERR_INT_EN | \
+			       B_AX_WDRLS_PLEBREQ_TO_ERR_INT_EN | \
+			       B_AX_WDRLS_PLEBREQ_PKTID_ISNULL_ERR_INT_EN | \
+			       B_AX_WDRLS_RPT0_AGGNUM0_ERR_INT_EN | \
+			       B_AX_WDRLS_RPT0_FRZTO_ERR_INT_EN | \
+			       B_AX_WDRLS_RPT1_AGGNUM0_ERR_INT_EN | \
+			       B_AX_WDRLS_RPT1_FRZTO_ERR_INT_EN)
+#define B_AX_WDRLS_IMR_SET (B_AX_WDRLS_CTL_WDPKTID_ISNULL_ERR_INT_EN | \
+			    B_AX_WDRLS_CTL_PLPKTID_ISNULL_ERR_INT_EN | \
+			    B_AX_WDRLS_CTL_FRZTO_ERR_INT_EN | \
+			    B_AX_WDRLS_PLEBREQ_PKTID_ISNULL_ERR_INT_EN | \
+			    B_AX_WDRLS_RPT0_AGGNUM0_ERR_INT_EN | \
+			    B_AX_WDRLS_RPT0_FRZTO_ERR_INT_EN | \
+			    B_AX_WDRLS_RPT1_AGGNUM0_ERR_INT_EN | \
+			    B_AX_WDRLS_RPT1_FRZTO_ERR_INT_EN)
+#define B_AX_WDRLS_IMR_SET_V1 (B_AX_WDRLS_CTL_WDPKTID_ISNULL_ERR_INT_EN | \
+			      B_AX_WDRLS_CTL_PLPKTID_ISNULL_ERR_INT_EN | \
+			      B_AX_WDRLS_CTL_FRZTO_ERR_INT_EN | \
+			      B_AX_WDRLS_PLEBREQ_TO_ERR_INT_EN | \
+			      B_AX_WDRLS_PLEBREQ_PKTID_ISNULL_ERR_INT_EN | \
+			      B_AX_WDRLS_RPT0_AGGNUM0_ERR_INT_EN | \
+			      B_AX_WDRLS_RPT0_FRZTO_ERR_INT_EN | \
+			      B_AX_WDRLS_RPT1_AGGNUM0_ERR_INT_EN | \
+			      B_AX_WDRLS_RPT1_FRZTO_ERR_INT_EN)
+
 #define R_AX_WDRLS_ERR_ISR 0x9434
 
+#define R_AX_BBRPT_COM_ERR_IMR 0x9608
+#define B_AX_BBRPT_COM_HANG_EN BIT(1)
+#define B_AX_BBRPT_COM_NULL_PLPKTID_ERR_INT_EN BIT(0)
+
 #define R_AX_BBRPT_COM_ERR_IMR_ISR 0x960C
+#define B_AX_BBRPT_COM_NULL_PLPKTID_ERR BIT(16)
+#define B_AX_BBRPT_COM_NULL_PLPKTID_ERR_INT_EN BIT(0)
+
+#define R_AX_BBRPT_CHINFO_ERR_IMR 0x9628
+#define B_AX_BBPRT_CHIF_TO_ERR_INT_EN BIT(7)
+#define B_AX_BBPRT_CHIF_NULL_ERR_INT_EN BIT(6)
+#define B_AX_BBPRT_CHIF_LEFT2_ERR_INT_EN BIT(5)
+#define B_AX_BBPRT_CHIF_LEFT1_ERR_INT_EN BIT(4)
+#define B_AX_BBPRT_CHIF_HDRL_ERR_INT_EN BIT(3)
+#define B_AX_BBPRT_CHIF_BOVF_ERR_INT_EN BIT(2)
+#define B_AX_BBPRT_CHIF_OVF_ERR_INT_EN BIT(1)
+#define B_AX_BBPRT_CHIF_BB_TO_ERR_INT_EN BIT(0)
+#define R_AX_BBRPT_CHINFO_IMR_SET_V1 (B_AX_BBPRT_CHIF_BB_TO_ERR_INT_EN | \
+				      B_AX_BBPRT_CHIF_OVF_ERR_INT_EN | \
+				      B_AX_BBPRT_CHIF_BOVF_ERR_INT_EN | \
+				      B_AX_BBPRT_CHIF_HDRL_ERR_INT_EN | \
+				      B_AX_BBPRT_CHIF_LEFT1_ERR_INT_EN | \
+				      B_AX_BBPRT_CHIF_LEFT2_ERR_INT_EN | \
+				      B_AX_BBPRT_CHIF_NULL_ERR_INT_EN | \
+				      B_AX_BBPRT_CHIF_TO_ERR_INT_EN)
+
 #define R_AX_BBRPT_CHINFO_ERR_IMR_ISR 0x962C
+#define B_AX_BBPRT_CHIF_TO_ERR BIT(23)
+#define B_AX_BBPRT_CHIF_NULL_ERR BIT(22)
+#define B_AX_BBPRT_CHIF_LEFT2_ERR BIT(21)
+#define B_AX_BBPRT_CHIF_LEFT1_ERR BIT(20)
+#define B_AX_BBPRT_CHIF_HDRL_ERR BIT(19)
+#define B_AX_BBPRT_CHIF_BOVF_ERR BIT(18)
+#define B_AX_BBPRT_CHIF_OVF_ERR BIT(17)
+#define B_AX_BBPRT_CHIF_BB_TO_ERR BIT(16)
+#define B_AX_BBPRT_CHIF_TO_ERR_INT_EN BIT(7)
+#define B_AX_BBPRT_CHIF_NULL_ERR_INT_EN BIT(6)
+#define B_AX_BBPRT_CHIF_LEFT2_ERR_INT_EN BIT(5)
+#define B_AX_BBPRT_CHIF_LEFT1_ERR_INT_EN BIT(4)
+#define B_AX_BBPRT_CHIF_HDRL_ERR_INT_EN BIT(3)
+#define B_AX_BBPRT_CHIF_BOVF_ERR_INT_EN BIT(2)
+#define B_AX_BBPRT_CHIF_OVF_ERR_INT_EN BIT(1)
+#define B_AX_BBPRT_CHIF_BB_TO_ERR_INT_EN BIT(0)
+#define B_AX_BBRPT_CHINFO_IMR_CLR (B_AX_BBPRT_CHIF_BB_TO_ERR_INT_EN | \
+				   B_AX_BBPRT_CHIF_OVF_ERR_INT_EN | \
+				   B_AX_BBPRT_CHIF_BOVF_ERR_INT_EN | \
+				   B_AX_BBPRT_CHIF_HDRL_ERR_INT_EN | \
+				   B_AX_BBPRT_CHIF_LEFT1_ERR_INT_EN | \
+				   B_AX_BBPRT_CHIF_LEFT2_ERR_INT_EN | \
+				   B_AX_BBPRT_CHIF_NULL_ERR_INT_EN | \
+				   B_AX_BBPRT_CHIF_TO_ERR_INT_EN)
+
+#define R_AX_BBRPT_DFS_ERR_IMR 0x9638
+#define B_AX_BBRPT_DFS_TO_ERR_INT_EN BIT(0)
+
 #define R_AX_BBRPT_DFS_ERR_IMR_ISR 0x963C
+#define B_AX_BBRPT_DFS_TO_ERR BIT(16)
+#define B_AX_BBRPT_DFS_TO_ERR_INT_EN BIT(0)
+
 #define R_AX_LA_ERRFLAG 0x966C
+#define B_AX_LA_ISR_DATA_LOSS_ERR BIT(16)
+#define B_AX_LA_IMR_DATA_LOSS_ERR BIT(0)
 
 #define R_AX_WD_BUF_REQ 0x9800
 #define R_AX_PL_BUF_REQ 0x9820
@@ -745,18 +1453,51 @@
 #define R_AX_PL_CPUQ_OP_STATUS 0x983C
 #define B_AX_WD_CPUQ_OP_STAT_DONE BIT(31)
 #define B_AX_WD_CPUQ_OP_PKTID_MASK GENMASK(11, 0)
+
 #define R_AX_CPUIO_ERR_IMR 0x9840
+#define B_AX_PLEQUE_OP_ERR_INT_EN BIT(12)
+#define B_AX_PLEBUF_OP_ERR_INT_EN BIT(8)
+#define B_AX_WDEQUE_OP_ERR_INT_EN BIT(4)
+#define B_AX_WDEBUF_OP_ERR_INT_EN BIT(0)
+#define B_AX_CPUIO_IMR_CLR (B_AX_WDEBUF_OP_ERR_INT_EN | \
+			    B_AX_WDEQUE_OP_ERR_INT_EN | \
+			    B_AX_PLEBUF_OP_ERR_INT_EN | \
+			    B_AX_PLEQUE_OP_ERR_INT_EN)
+#define B_AX_CPUIO_IMR_SET (B_AX_WDEBUF_OP_ERR_INT_EN | \
+			    B_AX_WDEQUE_OP_ERR_INT_EN | \
+			    B_AX_PLEBUF_OP_ERR_INT_EN | \
+			    B_AX_PLEQUE_OP_ERR_INT_EN)
+
 #define R_AX_CPUIO_ERR_ISR 0x9844
 
 #define R_AX_SEC_ERR_IMR_ISR 0x991C
 
 #define R_AX_PKTIN_SETTING 0x9A00
 #define B_AX_WD_ADDR_INFO_LENGTH BIT(1)
+
 #define R_AX_PKTIN_ERR_IMR 0x9A20
+#define B_AX_PKTIN_GETPKTID_ERR_INT_EN BIT(0)
+
 #define R_AX_PKTIN_ERR_ISR 0x9A24
 
 #define R_AX_MPDU_TX_ERR_ISR 0x9BF0
 #define R_AX_MPDU_TX_ERR_IMR 0x9BF4
+#define B_AX_TX_KSRCH_ERR_EN BIT(9)
+#define B_AX_TX_NW_TYPE_ERR_EN BIT(8)
+#define B_AX_TX_LLC_PRE_ERR_EN BIT(7)
+#define B_AX_TX_ETH_TYPE_ERR_EN BIT(6)
+#define B_AX_TX_HDR3_SIZE_ERR_INT_EN BIT(5)
+#define B_AX_TX_OFFSET_ERR_INT_EN BIT(4)
+#define B_AX_TX_MPDU_SIZE_ZERO_INT_EN BIT(3)
+#define B_AX_TX_NXT_ERRPKTID_INT_EN BIT(2)
+#define B_AX_TX_GET_ERRPKTID_INT_EN BIT(1)
+#define B_AX_MPDU_TX_IMR_SET_V1 (B_AX_TX_GET_ERRPKTID_INT_EN | \
+				 B_AX_TX_NXT_ERRPKTID_INT_EN | \
+				 B_AX_TX_MPDU_SIZE_ZERO_INT_EN | \
+				 B_AX_TX_HDR3_SIZE_ERR_INT_EN | \
+				 B_AX_TX_ETH_TYPE_ERR_EN | \
+				 B_AX_TX_NW_TYPE_ERR_EN | \
+				 B_AX_TX_KSRCH_ERR_EN)
 
 #define R_AX_MPDU_PROC 0x9C00
 #define B_AX_A_ICV_ERR BIT(1)
@@ -778,6 +1519,10 @@
 
 #define R_AX_MPDU_RX_ERR_ISR 0x9CF0
 #define R_AX_MPDU_RX_ERR_IMR 0x9CF4
+#define B_AX_RPT_ERR_INT_EN BIT(3)
+#define B_AX_MHDRLEN_ERR_INT_EN BIT(1)
+#define B_AX_GETPKTID_ERR_INT_EN BIT(0)
+#define B_AX_MPDU_RX_IMR_SET_V1 B_AX_RPT_ERR_INT_EN
 
 #define R_AX_SEC_ENG_CTRL 0x9D00
 #define B_AX_TX_PARTIAL_MODE BIT(11)
@@ -798,15 +1543,23 @@
 #define R_AX_SEC_CAM_ACCESS 0x9D10
 #define R_AX_SEC_CAM_RDATA 0x9D14
 #define R_AX_SEC_CAM_WDATA 0x9D18
+
 #define R_AX_SEC_DEBUG 0x9D1C
+#define B_AX_IMR_ERROR BIT(3)
+
 #define R_AX_SEC_DEBUG1 0x9D1C
 #define B_AX_TX_TIMEOUT_SEL_MASK GENMASK(31, 30)
 #define AX_TX_TO_VAL  0x2
+
 #define R_AX_SEC_TX_DEBUG 0x9D20
 #define R_AX_SEC_RX_DEBUG 0x9D24
 #define R_AX_SEC_TRX_PKT_CNT 0x9D28
 #define R_AX_SEC_TRX_BLK_CNT 0x9D2C
 
+#define R_AX_SEC_ERROR_FLAG_IMR 0x9D2C
+#define B_AX_RX_HANG_IMR BIT(1)
+#define B_AX_TX_HANG_IMR BIT(0)
+
 #define R_AX_SS_CTRL 0x9E10
 #define B_AX_SS_INIT_DONE_1 BIT(31)
 #define B_AX_SS_WARM_INIT_FLG BIT(29)
@@ -838,9 +1591,47 @@
 #define B_AX_SS_MACID127_96_PAUSE_MASK GENMASK(31, 0)
 
 #define R_AX_STA_SCHEDULER_ERR_IMR 0x9EF0
+#define B_AX_PLE_B_PKTID_ERR_INT_EN BIT(2)
+#define B_AX_RPT_HANG_TIMEOUT_INT_EN BIT(1)
+#define B_AX_SEARCH_HANG_TIMEOUT_INT_EN BIT(0)
+#define B_AX_STA_SCHEDULER_IMR_SET (B_AX_SEARCH_HANG_TIMEOUT_INT_EN | \
+				    B_AX_RPT_HANG_TIMEOUT_INT_EN | \
+				    B_AX_PLE_B_PKTID_ERR_INT_EN)
+
 #define R_AX_STA_SCHEDULER_ERR_ISR 0x9EF4
 
 #define R_AX_TXPKTCTL_ERR_IMR_ISR 0x9F1C
+#define B_AX_TXPKTCTL_CMDPSR_FRZTO_ERR BIT(25)
+#define B_AX_TXPKTCTL_CMDPSR_CMDTYPE_ERR BIT(24)
+#define B_AX_TXPKTCTL_USRCTL_RLSBMPLEN_ERR BIT(19)
+#define B_AX_TXPKTCTL_USRCTL_RDNRLSCMD_ERR BIT(18)
+#define B_AX_TXPKTCTL_USRCTL_NOINIT_ERR BIT(17)
+#define B_AX_TXPKTCTL_USRCTL_REINIT_ERR BIT(16)
+#define B_AX_TXPKTCTL_CMDPSR_FRZTO_ERR_INT_EN BIT(9)
+#define B_AX_TXPKTCTL_CMDPSR_CMDTYPE_ERR_INT_EN BIT(8)
+#define B_AX_TXPKTCTL_USRCTL_RLSBMPLEN_ERR_INT_EN BIT(3)
+#define B_AX_TXPKTCTL_USRCTL_RDNRLSCMD_ERR_INT_EN BIT(2)
+#define B_AX_TXPKTCTL_USRCTL_NOINIT_ERR_INT_EN BIT(1)
+#define B_AX_TXPKTCTL_USRCTL_REINIT_ERR_INT_EN BIT(0)
+#define B_AX_TXPKTCTL_IMR_B0_CLR (B_AX_TXPKTCTL_USRCTL_REINIT_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_USRCTL_NOINIT_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_USRCTL_RDNRLSCMD_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_USRCTL_RLSBMPLEN_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_CMDPSR_CMDTYPE_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_CMDPSR_FRZTO_ERR_INT_EN)
+#define B_AX_TXPKTCTL_IMR_B1_CLR (B_AX_TXPKTCTL_USRCTL_REINIT_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_USRCTL_NOINIT_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_USRCTL_RDNRLSCMD_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_USRCTL_RLSBMPLEN_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_CMDPSR_CMDTYPE_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_CMDPSR_FRZTO_ERR_INT_EN)
+#define B_AX_TXPKTCTL_IMR_B0_SET (B_AX_TXPKTCTL_USRCTL_REINIT_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_CMDPSR_CMDTYPE_ERR_INT_EN)
+#define B_AX_TXPKTCTL_IMR_B1_SET (B_AX_TXPKTCTL_USRCTL_REINIT_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_USRCTL_NOINIT_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_CMDPSR_CMDTYPE_ERR_INT_EN | \
+				  B_AX_TXPKTCTL_CMDPSR_FRZTO_ERR_INT_EN)
+
 #define R_AX_TXPKTCTL_ERR_IMR_ISR_B1 0x9F2C
 #define B_AX_TXPKTCTL_CMDPSR_FRZTO_ERR_INT_EN BIT(9)
 #define B_AX_TXPKTCTL_USRCTL_RLSBMPLEN_ERR_INT_EN BIT(3)
@@ -867,6 +1658,42 @@
 #define PRELD_NEXT_WND 1
 #define B_AX_B0_PRELD_NXT_RSVMINSZ_MASK GENMASK(7, 0)
 
+#define R_AX_TXPKTCTL_B0_ERRFLAG_IMR 0x9F78
+#define B_AX_B0_IMR_ERR_PRELD_ENTNUMCFG BIT(21)
+#define B_AX_B0_IMR_ERR_PRELD_RLSPKTSZERR BIT(20)
+#define B_AX_B0_IMR_ERR_MPDUIF_DATAERR BIT(18)
+#define B_AX_B0_IMR_ERR_MPDUINFO_RECFG BIT(16)
+#define B_AX_B0_IMR_ERR_CMDPSR_TBLSZ BIT(11)
+#define B_AX_B0_IMR_ERR_CMDPSR_FRZTO BIT(10)
+#define B_AX_B0_IMR_ERR_CMDPSR_CMDTYPE BIT(9)
+#define B_AX_B0_IMR_ERR_CMDPSR_1STCMDERR BIT(8)
+#define B_AX_B0_IMR_ERR_USRCTL_RLSBMPLEN BIT(3)
+#define B_AX_B0_IMR_ERR_USRCTL_RDNRLSCMD BIT(2)
+#define B_AX_B0_IMR_ERR_USRCTL_NOINIT BIT(1)
+#define B_AX_B0_IMR_ERR_USRCTL_REINIT BIT(0)
+#define B_AX_TXPKTCTL_IMR_B0_CLR_V1 (B_AX_B0_IMR_ERR_USRCTL_REINIT | \
+				     B_AX_B0_IMR_ERR_USRCTL_NOINIT | \
+				     B_AX_B0_IMR_ERR_USRCTL_RDNRLSCMD | \
+				     B_AX_B0_IMR_ERR_USRCTL_RLSBMPLEN | \
+				     B_AX_B0_IMR_ERR_CMDPSR_1STCMDERR | \
+				     B_AX_B0_IMR_ERR_CMDPSR_CMDTYPE | \
+				     B_AX_B0_IMR_ERR_CMDPSR_FRZTO | \
+				     B_AX_B0_IMR_ERR_CMDPSR_TBLSZ | \
+				     B_AX_B0_IMR_ERR_MPDUINFO_RECFG | \
+				     B_AX_B0_IMR_ERR_MPDUIF_DATAERR | \
+				     B_AX_B0_IMR_ERR_PRELD_RLSPKTSZERR | \
+				     B_AX_B0_IMR_ERR_PRELD_ENTNUMCFG)
+#define B_AX_TXPKTCTL_IMR_B0_SET_V1 (B_AX_B0_IMR_ERR_USRCTL_REINIT | \
+				     B_AX_B0_IMR_ERR_USRCTL_NOINIT | \
+				     B_AX_B0_IMR_ERR_CMDPSR_1STCMDERR | \
+				     B_AX_B0_IMR_ERR_CMDPSR_CMDTYPE | \
+				     B_AX_B0_IMR_ERR_CMDPSR_FRZTO | \
+				     B_AX_B0_IMR_ERR_CMDPSR_TBLSZ | \
+				     B_AX_B0_IMR_ERR_MPDUINFO_RECFG | \
+				     B_AX_B0_IMR_ERR_MPDUIF_DATAERR | \
+				     B_AX_B0_IMR_ERR_PRELD_RLSPKTSZERR | \
+				     B_AX_B0_IMR_ERR_PRELD_ENTNUMCFG)
+
 #define R_AX_TXPKTCTL_B1_PRELD_CFG0 0x9F88
 #define B_AX_B1_PRELD_FEN BIT(31)
 #define B_AX_B1_PRELD_USEMAXSZ_MASK GENMASK(25, 16)
@@ -878,6 +1705,42 @@
 #define B_AX_B1_PRELD_NXT_TXENDWIN_MASK GENMASK(11, 8)
 #define B_AX_B1_PRELD_NXT_RSVMINSZ_MASK GENMASK(7, 0)
 
+#define R_AX_TXPKTCTL_B1_ERRFLAG_IMR 0x9FB8
+#define B_AX_B1_IMR_ERR_PRELD_ENTNUMCFG BIT(21)
+#define B_AX_B1_IMR_ERR_PRELD_RLSPKTSZERR BIT(20)
+#define B_AX_B1_IMR_ERR_MPDUIF_DATAERR BIT(18)
+#define B_AX_B1_IMR_ERR_MPDUINFO_RECFG BIT(16)
+#define B_AX_B1_IMR_ERR_CMDPSR_TBLSZ BIT(11)
+#define B_AX_B1_IMR_ERR_CMDPSR_FRZTO BIT(10)
+#define B_AX_B1_IMR_ERR_CMDPSR_CMDTYPE BIT(9)
+#define B_AX_B1_IMR_ERR_CMDPSR_1STCMDERR BIT(8)
+#define B_AX_B1_IMR_ERR_USRCTL_RLSBMPLEN BIT(3)
+#define B_AX_B1_IMR_ERR_USRCTL_RDNRLSCMD BIT(2)
+#define B_AX_B1_IMR_ERR_USRCTL_NOINIT BIT(1)
+#define B_AX_B1_IMR_ERR_USRCTL_REINIT BIT(0)
+#define B_AX_TXPKTCTL_IMR_B1_CLR_V1 (B_AX_B1_IMR_ERR_USRCTL_REINIT | \
+				     B_AX_B1_IMR_ERR_USRCTL_NOINIT | \
+				     B_AX_B1_IMR_ERR_USRCTL_RDNRLSCMD | \
+				     B_AX_B1_IMR_ERR_USRCTL_RLSBMPLEN | \
+				     B_AX_B1_IMR_ERR_CMDPSR_1STCMDERR | \
+				     B_AX_B1_IMR_ERR_CMDPSR_CMDTYPE | \
+				     B_AX_B1_IMR_ERR_CMDPSR_FRZTO | \
+				     B_AX_B1_IMR_ERR_CMDPSR_TBLSZ | \
+				     B_AX_B1_IMR_ERR_MPDUINFO_RECFG | \
+				     B_AX_B1_IMR_ERR_MPDUIF_DATAERR | \
+				     B_AX_B1_IMR_ERR_PRELD_RLSPKTSZERR | \
+				     B_AX_B1_IMR_ERR_PRELD_ENTNUMCFG)
+#define B_AX_TXPKTCTL_IMR_B1_SET_V1 (B_AX_B1_IMR_ERR_USRCTL_REINIT | \
+				     B_AX_B1_IMR_ERR_USRCTL_NOINIT | \
+				     B_AX_B1_IMR_ERR_CMDPSR_1STCMDERR | \
+				     B_AX_B1_IMR_ERR_CMDPSR_CMDTYPE | \
+				     B_AX_B1_IMR_ERR_CMDPSR_FRZTO | \
+				     B_AX_B1_IMR_ERR_CMDPSR_TBLSZ | \
+				     B_AX_B1_IMR_ERR_MPDUINFO_RECFG | \
+				     B_AX_B1_IMR_ERR_MPDUIF_DATAERR | \
+				     B_AX_B1_IMR_ERR_PRELD_RLSPKTSZERR | \
+				     B_AX_B1_IMR_ERR_PRELD_ENTNUMCFG)
+
 #define R_AX_AFE_CTRL1 0x0024
 
 #define B_AX_R_SYM_WLCMAC1_P4_PC_EN BIT(4)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 501631b1f0416..1af6057487401 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -408,6 +408,34 @@ static const struct rtw89_reg_def rtw8852a_dcfo_comp = {
 	R_DCFO_COMP_S0, B_DCFO_COMP_S0_MSK
 };
 
+static const struct rtw89_imr_info rtw8852a_imr_info = {
+	.wdrls_imr_set		= B_AX_WDRLS_IMR_SET,
+	.wsec_imr_reg		= R_AX_SEC_DEBUG,
+	.wsec_imr_set		= B_AX_IMR_ERROR,
+	.mpdu_tx_imr_set	= 0,
+	.mpdu_rx_imr_set	= 0,
+	.sta_sch_imr_set	= B_AX_STA_SCHEDULER_IMR_SET,
+	.txpktctl_imr_b0_reg	= R_AX_TXPKTCTL_ERR_IMR_ISR,
+	.txpktctl_imr_b0_clr	= B_AX_TXPKTCTL_IMR_B0_CLR,
+	.txpktctl_imr_b0_set	= B_AX_TXPKTCTL_IMR_B0_SET,
+	.txpktctl_imr_b1_reg	= R_AX_TXPKTCTL_ERR_IMR_ISR_B1,
+	.txpktctl_imr_b1_clr	= B_AX_TXPKTCTL_IMR_B1_CLR,
+	.txpktctl_imr_b1_set	= B_AX_TXPKTCTL_IMR_B1_SET,
+	.wde_imr_clr		= B_AX_WDE_IMR_CLR,
+	.wde_imr_set		= B_AX_WDE_IMR_SET,
+	.ple_imr_clr		= B_AX_PLE_IMR_CLR,
+	.ple_imr_set		= B_AX_PLE_IMR_SET,
+	.host_disp_imr_clr	= B_AX_HOST_DISP_IMR_CLR,
+	.host_disp_imr_set	= B_AX_HOST_DISP_IMR_SET,
+	.cpu_disp_imr_clr	= B_AX_CPU_DISP_IMR_CLR,
+	.cpu_disp_imr_set	= B_AX_CPU_DISP_IMR_SET,
+	.other_disp_imr_clr	= B_AX_OTHER_DISP_IMR_CLR,
+	.other_disp_imr_set	= 0,
+	.bbrpt_chinfo_err_imr_reg = R_AX_BBRPT_CHINFO_ERR_IMR_ISR,
+	.bbrpt_err_imr_set	= 0,
+	.bbrpt_dfs_err_imr_reg	= R_AX_BBRPT_DFS_ERR_IMR_ISR,
+};
+
 static void rtw8852ae_efuse_parsing(struct rtw89_efuse *efuse,
 				    struct rtw8852a_efuse *map)
 {
@@ -2112,6 +2140,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.page_regs		= &rtw8852a_page_regs,
 	.dcfo_comp		= &rtw8852a_dcfo_comp,
 	.dcfo_comp_sft		= 3,
+	.imr_info		= &rtw8852a_imr_info
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 5dbb711defc40..18c17b4bbc181 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -51,6 +51,34 @@ static const struct rtw89_reg_def rtw8852c_dcfo_comp = {
 	R_DCFO_COMP_S0_V1, B_DCFO_COMP_S0_V1_MSK
 };
 
+static const struct rtw89_imr_info rtw8852c_imr_info = {
+	.wdrls_imr_set		= B_AX_WDRLS_IMR_SET_V1,
+	.wsec_imr_reg		= R_AX_SEC_ERROR_FLAG_IMR,
+	.wsec_imr_set		= B_AX_TX_HANG_IMR | B_AX_RX_HANG_IMR,
+	.mpdu_tx_imr_set	= B_AX_MPDU_TX_IMR_SET_V1,
+	.mpdu_rx_imr_set	= B_AX_MPDU_RX_IMR_SET_V1,
+	.sta_sch_imr_set	= B_AX_STA_SCHEDULER_IMR_SET,
+	.txpktctl_imr_b0_reg	= R_AX_TXPKTCTL_B0_ERRFLAG_IMR,
+	.txpktctl_imr_b0_clr	= B_AX_TXPKTCTL_IMR_B0_CLR_V1,
+	.txpktctl_imr_b0_set	= B_AX_TXPKTCTL_IMR_B0_SET_V1,
+	.txpktctl_imr_b1_reg	= R_AX_TXPKTCTL_B1_ERRFLAG_IMR,
+	.txpktctl_imr_b1_clr	= B_AX_TXPKTCTL_IMR_B1_CLR_V1,
+	.txpktctl_imr_b1_set	= B_AX_TXPKTCTL_IMR_B1_SET_V1,
+	.wde_imr_clr		= B_AX_WDE_IMR_CLR_V1,
+	.wde_imr_set		= B_AX_WDE_IMR_SET_V1,
+	.ple_imr_clr		= B_AX_PLE_IMR_CLR_V1,
+	.ple_imr_set		= B_AX_PLE_IMR_SET_V1,
+	.host_disp_imr_clr	= B_AX_HOST_DISP_IMR_CLR_V1,
+	.host_disp_imr_set	= B_AX_HOST_DISP_IMR_SET_V1,
+	.cpu_disp_imr_clr	= B_AX_CPU_DISP_IMR_CLR_V1,
+	.cpu_disp_imr_set	= B_AX_CPU_DISP_IMR_SET_V1,
+	.other_disp_imr_clr	= B_AX_OTHER_DISP_IMR_CLR_V1,
+	.other_disp_imr_set	= B_AX_OTHER_DISP_IMR_SET_V1,
+	.bbrpt_chinfo_err_imr_reg = R_AX_BBRPT_CHINFO_ERR_IMR,
+	.bbrpt_err_imr_set	= R_AX_BBRPT_CHINFO_IMR_SET_V1,
+	.bbrpt_dfs_err_imr_reg	= R_AX_BBRPT_DFS_ERR_IMR,
+};
+
 static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -572,6 +600,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.page_regs		= &rtw8852c_page_regs,
 	.dcfo_comp		= &rtw8852c_dcfo_comp,
 	.dcfo_comp_sft		= 5,
+	.imr_info		= &rtw8852c_imr_info
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
-- 
2.25.1

