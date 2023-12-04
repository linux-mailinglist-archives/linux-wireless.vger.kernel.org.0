Return-Path: <linux-wireless+bounces-355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BDB802CBF
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B791F2110B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F92FBE4;
	Mon,  4 Dec 2023 08:09:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C26DF
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 00:09:16 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B4896Ku81945270, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B4896Ku81945270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 16:09:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 4 Dec 2023 16:09:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 4 Dec 2023
 16:09:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <leo.li@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: 8922a: dump MAC registers when SER occurs
Date: Mon, 4 Dec 2023 16:07:50 +0800
Message-ID: <20231204080751.15354-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204080751.15354-1-pkshih@realtek.com>
References: <20231204080751.15354-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Chia-Yuan Li <leo.li@realtek.com>

To diagnose the reason why firmware or hardware get abnormal, add to dump
MAC registers related to counters and interrupt masks. With these values,
people can classify problems and check if registers values are unexpected,
and then correct them. However, it could possible false alarm because
firmware triggers this SER event by wrong conditions that we should
correct it at firmware or register settings.

In field, SER might happen under special conditions, and very hard to
happen again, so dump lots of registers to provide rich information to
catch the problem.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 283 +++++++---
 drivers/net/wireless/realtek/rtw89/mac.h    |  10 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 251 +++++++++
 drivers/net/wireless/realtek/rtw89/pci.c    |  22 +-
 drivers/net/wireless/realtek/rtw89/pci.h    |   4 +
 drivers/net/wireless/realtek/rtw89/reg.h    | 572 ++++++++++++++++++++
 6 files changed, 1061 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d4812b25c86c..44decdf801a3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -113,8 +113,7 @@ int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val)
 	return ret;
 }
 
-static
-int dle_dfi_ctrl(struct rtw89_dev *rtwdev, struct rtw89_mac_dle_dfi_ctrl *ctrl)
+int rtw89_mac_dle_dfi_cfg(struct rtw89_dev *rtwdev, struct rtw89_mac_dle_dfi_ctrl *ctrl)
 {
 	u32 ctrl_reg, data_reg, ctrl_data;
 	u32 val;
@@ -154,8 +153,8 @@ int dle_dfi_ctrl(struct rtw89_dev *rtwdev, struct rtw89_mac_dle_dfi_ctrl *ctrl)
 	return 0;
 }
 
-static int dle_dfi_quota(struct rtw89_dev *rtwdev,
-			 struct rtw89_mac_dle_dfi_quota *quota)
+int rtw89_mac_dle_dfi_quota_cfg(struct rtw89_dev *rtwdev,
+				struct rtw89_mac_dle_dfi_quota *quota)
 {
 	struct rtw89_mac_dle_dfi_ctrl ctrl;
 	int ret;
@@ -163,9 +162,9 @@ static int dle_dfi_quota(struct rtw89_dev *rtwdev,
 	ctrl.type = quota->dle_type;
 	ctrl.target = DLE_DFI_TYPE_QUOTA;
 	ctrl.addr = quota->qtaid;
-	ret = dle_dfi_ctrl(rtwdev, &ctrl);
+	ret = rtw89_mac_dle_dfi_cfg(rtwdev, &ctrl);
 	if (ret) {
-		rtw89_warn(rtwdev, "[ERR]dle_dfi_ctrl %d\n", ret);
+		rtw89_warn(rtwdev, "[ERR] dle dfi quota %d\n", ret);
 		return ret;
 	}
 
@@ -183,9 +182,9 @@ int rtw89_mac_dle_dfi_qempty_cfg(struct rtw89_dev *rtwdev,
 	ctrl.type = qempty->dle_type;
 	ctrl.target = DLE_DFI_TYPE_QEMPTY;
 	ctrl.addr = qempty->grpsel;
-	ret = dle_dfi_ctrl(rtwdev, &ctrl);
+	ret = rtw89_mac_dle_dfi_cfg(rtwdev, &ctrl);
 	if (ret) {
-		rtw89_warn(rtwdev, "[ERR]dle_dfi_ctrl %d\n", ret);
+		rtw89_warn(rtwdev, "[ERR] dle dfi qempty %d\n", ret);
 		return ret;
 	}
 
@@ -193,7 +192,7 @@ int rtw89_mac_dle_dfi_qempty_cfg(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-static void dump_err_status_dispatcher(struct rtw89_dev *rtwdev)
+static void dump_err_status_dispatcher_ax(struct rtw89_dev *rtwdev)
 {
 	rtw89_info(rtwdev, "R_AX_HOST_DISPATCHER_ALWAYS_IMR=0x%08x ",
 		   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR));
@@ -209,7 +208,7 @@ static void dump_err_status_dispatcher(struct rtw89_dev *rtwdev)
 		   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_ISR));
 }
 
-static void rtw89_mac_dump_qta_lost(struct rtw89_dev *rtwdev)
+static void rtw89_mac_dump_qta_lost_ax(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mac_dle_dfi_qempty qempty;
 	struct rtw89_mac_dle_dfi_quota quota;
@@ -232,19 +231,19 @@ static void rtw89_mac_dump_qta_lost(struct rtw89_dev *rtwdev)
 		ctrl.type = DLE_CTRL_TYPE_PLE;
 		ctrl.target = DLE_DFI_TYPE_QLNKTBL;
 		ctrl.addr = (QLNKTBL_ADDR_INFO_SEL_0 ? QLNKTBL_ADDR_INFO_SEL : 0) |
-			    FIELD_PREP(QLNKTBL_ADDR_TBL_IDX_MASK, i);
-		ret = dle_dfi_ctrl(rtwdev, &ctrl);
+			    u32_encode_bits(i, QLNKTBL_ADDR_TBL_IDX_MASK);
+		ret = rtw89_mac_dle_dfi_cfg(rtwdev, &ctrl);
 		if (ret)
 			rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
 		else
-			rtw89_info(rtwdev, "qidx%d pktcnt = %ld\n", i,
-				   FIELD_GET(QLNKTBL_DATA_SEL1_PKT_CNT_MASK,
-					     ctrl.out_data));
+			rtw89_info(rtwdev, "qidx%d pktcnt = %d\n", i,
+				   u32_get_bits(ctrl.out_data,
+						QLNKTBL_DATA_SEL1_PKT_CNT_MASK));
 	}
 
 	quota.dle_type = DLE_CTRL_TYPE_PLE;
 	quota.qtaid = 6;
-	ret = dle_dfi_quota(rtwdev, &quota);
+	ret = rtw89_mac_dle_dfi_quota_cfg(rtwdev, &quota);
 	if (ret)
 		rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
 	else
@@ -252,33 +251,74 @@ static void rtw89_mac_dump_qta_lost(struct rtw89_dev *rtwdev)
 			   quota.rsv_pgnum, quota.use_pgnum);
 
 	val = rtw89_read32(rtwdev, R_AX_PLE_QTA6_CFG);
-	rtw89_info(rtwdev, "[PLE][CMAC0_RX]min_pgnum=0x%lx\n",
-		   FIELD_GET(B_AX_PLE_Q6_MIN_SIZE_MASK, val));
-	rtw89_info(rtwdev, "[PLE][CMAC0_RX]max_pgnum=0x%lx\n",
-		   FIELD_GET(B_AX_PLE_Q6_MAX_SIZE_MASK, val));
+	rtw89_info(rtwdev, "[PLE][CMAC0_RX]min_pgnum=0x%x\n",
+		   u32_get_bits(val, B_AX_PLE_Q6_MIN_SIZE_MASK));
+	rtw89_info(rtwdev, "[PLE][CMAC0_RX]max_pgnum=0x%x\n",
+		   u32_get_bits(val, B_AX_PLE_Q6_MAX_SIZE_MASK));
+	val = rtw89_read32(rtwdev, R_AX_RX_FLTR_OPT);
+	rtw89_info(rtwdev, "[PLE][CMAC0_RX]B_AX_RX_MPDU_MAX_LEN=0x%x\n",
+		   u32_get_bits(val, B_AX_RX_MPDU_MAX_LEN_MASK));
+	rtw89_info(rtwdev, "R_AX_RSP_CHK_SIG=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_RSP_CHK_SIG));
+	rtw89_info(rtwdev, "R_AX_TRXPTCL_RESP_0=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_TRXPTCL_RESP_0));
+	rtw89_info(rtwdev, "R_AX_CCA_CONTROL=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_CCA_CONTROL));
+
+	if (!rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_1, RTW89_CMAC_SEL)) {
+		quota.dle_type = DLE_CTRL_TYPE_PLE;
+		quota.qtaid = 7;
+		ret = rtw89_mac_dle_dfi_quota_cfg(rtwdev, &quota);
+		if (ret)
+			rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
+		else
+			rtw89_info(rtwdev, "quota7 rsv/use: 0x%x/0x%x\n",
+				   quota.rsv_pgnum, quota.use_pgnum);
+
+		val = rtw89_read32(rtwdev, R_AX_PLE_QTA7_CFG);
+		rtw89_info(rtwdev, "[PLE][CMAC1_RX]min_pgnum=0x%x\n",
+			   u32_get_bits(val, B_AX_PLE_Q7_MIN_SIZE_MASK));
+		rtw89_info(rtwdev, "[PLE][CMAC1_RX]max_pgnum=0x%x\n",
+			   u32_get_bits(val, B_AX_PLE_Q7_MAX_SIZE_MASK));
+		val = rtw89_read32(rtwdev, R_AX_RX_FLTR_OPT_C1);
+		rtw89_info(rtwdev, "[PLE][CMAC1_RX]B_AX_RX_MPDU_MAX_LEN=0x%x\n",
+			   u32_get_bits(val, B_AX_RX_MPDU_MAX_LEN_MASK));
+		rtw89_info(rtwdev, "R_AX_RSP_CHK_SIG_C1=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_RSP_CHK_SIG_C1));
+		rtw89_info(rtwdev, "R_AX_TRXPTCL_RESP_0_C1=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_TRXPTCL_RESP_0_C1));
+		rtw89_info(rtwdev, "R_AX_CCA_CONTROL_C1=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_CCA_CONTROL_C1));
+	}
+
+	rtw89_info(rtwdev, "R_AX_DLE_EMPTY0=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_DLE_EMPTY0));
+	rtw89_info(rtwdev, "R_AX_DLE_EMPTY1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_DLE_EMPTY1));
 
-	dump_err_status_dispatcher(rtwdev);
+	dump_err_status_dispatcher_ax(rtwdev);
 }
 
-static void rtw89_mac_dump_l0_to_l1(struct rtw89_dev *rtwdev,
-				    enum mac_ax_err_info err)
+void rtw89_mac_dump_l0_to_l1(struct rtw89_dev *rtwdev,
+			     enum mac_ax_err_info err)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 dbg, event;
 
 	dbg = rtw89_read32(rtwdev, R_AX_SER_DBG_INFO);
-	event = FIELD_GET(B_AX_L0_TO_L1_EVENT_MASK, dbg);
+	event = u32_get_bits(dbg, B_AX_L0_TO_L1_EVENT_MASK);
 
 	switch (event) {
 	case MAC_AX_L0_TO_L1_RX_QTA_LOST:
 		rtw89_info(rtwdev, "quota lost!\n");
-		rtw89_mac_dump_qta_lost(rtwdev);
+		mac->dump_qta_lost(rtwdev);
 		break;
 	default:
 		break;
 	}
 }
 
-static void rtw89_mac_dump_dmac_err_status(struct rtw89_dev *rtwdev)
+void rtw89_mac_dump_dmac_err_status(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 dmac_err;
@@ -358,6 +398,21 @@ static void rtw89_mac_dump_dmac_err_status(struct rtw89_dev *rtwdev)
 				rtw89_info(rtwdev, "sel=%x,R_AX_SEC_DEBUG2=0x%08x\n",
 					   i, rtw89_read32(rtwdev, R_AX_SEC_DEBUG2));
 			}
+		} else if (chip->chip_id == RTL8922A) {
+			rtw89_info(rtwdev, "R_BE_SEC_ERROR_FLAG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_SEC_ERROR_FLAG));
+			rtw89_info(rtwdev, "R_BE_SEC_ERROR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_SEC_ERROR_IMR));
+			rtw89_info(rtwdev, "R_BE_SEC_ENG_CTRL=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_SEC_ENG_CTRL));
+			rtw89_info(rtwdev, "R_BE_SEC_MPDU_PROC=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_SEC_MPDU_PROC));
+			rtw89_info(rtwdev, "R_BE_SEC_CAM_ACCESS=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_SEC_CAM_ACCESS));
+			rtw89_info(rtwdev, "R_BE_SEC_CAM_RDATA=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_SEC_CAM_RDATA));
+			rtw89_info(rtwdev, "R_BE_SEC_DEBUG2=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_SEC_DEBUG2));
 		} else {
 			rtw89_info(rtwdev, "R_AX_SEC_ERR_IMR_ISR=0x%08x\n",
 				   rtw89_read32(rtwdev, R_AX_SEC_DEBUG));
@@ -394,10 +449,17 @@ static void rtw89_mac_dump_dmac_err_status(struct rtw89_dev *rtwdev)
 	}
 
 	if (dmac_err & B_AX_STA_SCHEDULER_ERR_FLAG) {
-		rtw89_info(rtwdev, "R_AX_STA_SCHEDULER_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_STA_SCHEDULER_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_ISR));
+		if (chip->chip_id == RTL8922A) {
+			rtw89_info(rtwdev, "R_BE_INTERRUPT_MASK_REG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_INTERRUPT_MASK_REG));
+			rtw89_info(rtwdev, "R_BE_INTERRUPT_STS_REG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_INTERRUPT_STS_REG));
+		} else {
+			rtw89_info(rtwdev, "R_AX_STA_SCHEDULER_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_IMR));
+			rtw89_info(rtwdev, "R_AX_STA_SCHEDULER_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_ISR));
+		}
 	}
 
 	if (dmac_err & B_AX_WDE_DLE_ERR_FLAG) {
@@ -412,7 +474,7 @@ static void rtw89_mac_dump_dmac_err_status(struct rtw89_dev *rtwdev)
 	}
 
 	if (dmac_err & B_AX_TXPKTCTRL_ERR_FLAG) {
-		if (chip->chip_id == RTL8852C) {
+		if (chip->chip_id == RTL8852C || chip->chip_id == RTL8922A) {
 			rtw89_info(rtwdev, "R_AX_TXPKTCTL_B0_ERRFLAG_IMR=0x%08x\n",
 				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B0_ERRFLAG_IMR));
 			rtw89_info(rtwdev, "R_AX_TXPKTCTL_B0_ERRFLAG_ISR=0x%08x\n",
@@ -444,30 +506,41 @@ static void rtw89_mac_dump_dmac_err_status(struct rtw89_dev *rtwdev)
 			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_1));
 		rtw89_info(rtwdev, "R_AX_WD_CPUQ_OP_2=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_2));
-		rtw89_info(rtwdev, "R_AX_WD_CPUQ_OP_STATUS=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_STATUS));
 		rtw89_info(rtwdev, "R_AX_PL_CPUQ_OP_0=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_0));
 		rtw89_info(rtwdev, "R_AX_PL_CPUQ_OP_1=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_1));
 		rtw89_info(rtwdev, "R_AX_PL_CPUQ_OP_2=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_2));
-		rtw89_info(rtwdev, "R_AX_PL_CPUQ_OP_STATUS=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_STATUS));
-		if (chip->chip_id == RTL8852C) {
-			rtw89_info(rtwdev, "R_AX_RX_CTRL0=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RX_CTRL0));
-			rtw89_info(rtwdev, "R_AX_RX_CTRL1=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RX_CTRL1));
-			rtw89_info(rtwdev, "R_AX_RX_CTRL2=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RX_CTRL2));
+		if (chip->chip_id == RTL8922A) {
+			rtw89_info(rtwdev, "R_BE_WD_CPUQ_OP_3=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_WD_CPUQ_OP_3));
+			rtw89_info(rtwdev, "R_BE_WD_CPUQ_OP_STATUS=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_WD_CPUQ_OP_STATUS));
+			rtw89_info(rtwdev, "R_BE_PLE_CPUQ_OP_3=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_PL_CPUQ_OP_3));
+			rtw89_info(rtwdev, "R_BE_PL_CPUQ_OP_STATUS=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_PL_CPUQ_OP_STATUS));
 		} else {
-			rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_0=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_0));
-			rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_1=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_1));
-			rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_2=0x%08x\n",
-				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_2));
+			rtw89_info(rtwdev, "R_AX_WD_CPUQ_OP_STATUS=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_STATUS));
+			rtw89_info(rtwdev, "R_AX_PL_CPUQ_OP_STATUS=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_STATUS));
+			if (chip->chip_id == RTL8852C) {
+				rtw89_info(rtwdev, "R_AX_RX_CTRL0=0x%08x\n",
+					   rtw89_read32(rtwdev, R_AX_RX_CTRL0));
+				rtw89_info(rtwdev, "R_AX_RX_CTRL1=0x%08x\n",
+					   rtw89_read32(rtwdev, R_AX_RX_CTRL1));
+				rtw89_info(rtwdev, "R_AX_RX_CTRL2=0x%08x\n",
+					   rtw89_read32(rtwdev, R_AX_RX_CTRL2));
+			} else {
+				rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_0=0x%08x\n",
+					   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_0));
+				rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_1=0x%08x\n",
+					   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_1));
+				rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_2=0x%08x\n",
+					   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_2));
+			}
 		}
 	}
 
@@ -479,22 +552,37 @@ static void rtw89_mac_dump_dmac_err_status(struct rtw89_dev *rtwdev)
 	}
 
 	if (dmac_err & B_AX_DISPATCH_ERR_FLAG) {
-		rtw89_info(rtwdev, "R_AX_HOST_DISPATCHER_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_HOST_DISPATCHER_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_ISR));
-		rtw89_info(rtwdev, "R_AX_CPU_DISPATCHER_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_CPU_DISPATCHER_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_ISR));
-		rtw89_info(rtwdev, "R_AX_OTHER_DISPATCHER_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_OTHER_DISPATCHER_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_ISR));
+		if (chip->chip_id == RTL8922A) {
+			rtw89_info(rtwdev, "R_BE_DISP_HOST_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_DISP_HOST_IMR));
+			rtw89_info(rtwdev, "R_BE_DISP_ERROR_ISR1=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_DISP_ERROR_ISR1));
+			rtw89_info(rtwdev, "R_BE_DISP_CPU_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_DISP_CPU_IMR));
+			rtw89_info(rtwdev, "R_BE_DISP_ERROR_ISR2=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_DISP_ERROR_ISR2));
+			rtw89_info(rtwdev, "R_BE_DISP_OTHER_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_DISP_OTHER_IMR));
+			rtw89_info(rtwdev, "R_BE_DISP_ERROR_ISR0=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_DISP_ERROR_ISR0));
+		} else {
+			rtw89_info(rtwdev, "R_AX_HOST_DISPATCHER_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR));
+			rtw89_info(rtwdev, "R_AX_HOST_DISPATCHER_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_ISR));
+			rtw89_info(rtwdev, "R_AX_CPU_DISPATCHER_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_IMR));
+			rtw89_info(rtwdev, "R_AX_CPU_DISPATCHER_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_ISR));
+			rtw89_info(rtwdev, "R_AX_OTHER_DISPATCHER_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_IMR));
+			rtw89_info(rtwdev, "R_AX_OTHER_DISPATCHER_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_ISR));
+		}
 	}
 
 	if (dmac_err & B_AX_BBRPT_ERR_FLAG) {
-		if (chip->chip_id == RTL8852C) {
+		if (chip->chip_id == RTL8852C || chip->chip_id == RTL8922A) {
 			rtw89_info(rtwdev, "R_AX_BBRPT_COM_ERR_IMR=0x%08x\n",
 				   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR));
 			rtw89_info(rtwdev, "R_AX_BBRPT_COM_ERR_ISR=0x%08x\n",
@@ -519,18 +607,54 @@ static void rtw89_mac_dump_dmac_err_status(struct rtw89_dev *rtwdev)
 			rtw89_info(rtwdev, "R_AX_BBRPT_DFS_ERR_ISR=0x%08x\n",
 				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_ISR));
 		}
+		if (chip->chip_id == RTL8922A) {
+			rtw89_info(rtwdev, "R_BE_LA_ERRFLAG_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_LA_ERRFLAG_IMR));
+			rtw89_info(rtwdev, "R_BE_LA_ERRFLAG_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_LA_ERRFLAG_ISR));
+		}
+	}
+
+	if (dmac_err & B_AX_HAXIDMA_ERR_FLAG) {
+		if (chip->chip_id == RTL8922A) {
+			rtw89_info(rtwdev, "R_BE_HAXI_IDCT_MSK=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_HAXI_IDCT_MSK));
+			rtw89_info(rtwdev, "R_BE_HAXI_IDCT=0x%08x\n",
+				   rtw89_read32(rtwdev, R_BE_HAXI_IDCT));
+		} else if (chip->chip_id == RTL8852C) {
+			rtw89_info(rtwdev, "R_AX_HAXIDMA_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_HAXI_IDCT_MSK));
+			rtw89_info(rtwdev, "R_AX_HAXIDMA_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_HAXI_IDCT));
+		}
+	}
+
+	if (dmac_err & B_BE_P_AXIDMA_ERR_INT) {
+		rtw89_info(rtwdev, "R_BE_PL_AXIDMA_IDCT_MSK=0x%08x\n",
+			   rtw89_mac_mem_read(rtwdev, R_BE_PL_AXIDMA_IDCT_MSK,
+					      RTW89_MAC_MEM_AXIDMA));
+		rtw89_info(rtwdev, "R_BE_PL_AXIDMA_IDCT=0x%08x\n",
+			   rtw89_mac_mem_read(rtwdev, R_BE_PL_AXIDMA_IDCT,
+					      RTW89_MAC_MEM_AXIDMA));
+	}
+
+	if (dmac_err & B_BE_MLO_ERR_INT) {
+		rtw89_info(rtwdev, "R_BE_MLO_ERR_IDCT_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_BE_MLO_ERR_IDCT_IMR));
+		rtw89_info(rtwdev, "R_BE_PKTIN_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_BE_MLO_ERR_IDCT_ISR));
 	}
 
-	if (dmac_err & B_AX_HAXIDMA_ERR_FLAG && chip->chip_id == RTL8852C) {
-		rtw89_info(rtwdev, "R_AX_HAXIDMA_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_HAXI_IDCT_MSK));
-		rtw89_info(rtwdev, "R_AX_HAXIDMA_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_HAXI_IDCT));
+	if (dmac_err & B_BE_PLRLS_ERR_INT) {
+		rtw89_info(rtwdev, "R_BE_PLRLS_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_BE_PLRLS_ERR_IMR));
+		rtw89_info(rtwdev, "R_BE_PLRLS_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_BE_PLRLS_ERR_ISR));
 	}
 }
 
-static void rtw89_mac_dump_cmac_err_status(struct rtw89_dev *rtwdev,
-					   u8 band)
+static void rtw89_mac_dump_cmac_err_status_ax(struct rtw89_dev *rtwdev,
+					      u8 band)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 offset = 0;
@@ -620,8 +744,8 @@ static void rtw89_mac_dump_cmac_err_status(struct rtw89_dev *rtwdev,
 		   rtw89_read32(rtwdev, R_AX_CMAC_ERR_IMR + offset));
 }
 
-static void rtw89_mac_dump_err_status(struct rtw89_dev *rtwdev,
-				      enum mac_ax_err_info err)
+static void rtw89_mac_dump_err_status_ax(struct rtw89_dev *rtwdev,
+					 enum mac_ax_err_info err)
 {
 	if (err != MAC_AX_ERR_L1_ERR_DMAC &&
 	    err != MAC_AX_ERR_L0_PROMOTE_TO_L1 &&
@@ -633,11 +757,16 @@ static void rtw89_mac_dump_err_status(struct rtw89_dev *rtwdev,
 	rtw89_info(rtwdev, "--->\nerr=0x%x\n", err);
 	rtw89_info(rtwdev, "R_AX_SER_DBG_INFO =0x%08x\n",
 		   rtw89_read32(rtwdev, R_AX_SER_DBG_INFO));
+	rtw89_info(rtwdev, "R_AX_SER_DBG_INFO =0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_SER_DBG_INFO));
+	rtw89_info(rtwdev, "DBG Counter 1 (R_AX_DRV_FW_HSK_4)=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_DRV_FW_HSK_4));
+	rtw89_info(rtwdev, "DBG Counter 2 (R_AX_DRV_FW_HSK_5)=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_DRV_FW_HSK_5));
 
 	rtw89_mac_dump_dmac_err_status(rtwdev);
-	rtw89_mac_dump_cmac_err_status(rtwdev, RTW89_MAC_0);
-	if (rtwdev->dbcc_en)
-		rtw89_mac_dump_cmac_err_status(rtwdev, RTW89_MAC_1);
+	rtw89_mac_dump_cmac_err_status_ax(rtwdev, RTW89_MAC_0);
+	rtw89_mac_dump_cmac_err_status_ax(rtwdev, RTW89_MAC_1);
 
 	rtwdev->hci.ops->dump_err_status(rtwdev);
 
@@ -682,6 +811,7 @@ static bool rtw89_mac_suppress_log(struct rtw89_dev *rtwdev, u32 err)
 
 u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 err, err_scnr;
 	int ret;
 
@@ -707,7 +837,7 @@ u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 		return err;
 
 	rtw89_fw_st_dbg_dump(rtwdev);
-	rtw89_mac_dump_err_status(rtwdev, err);
+	mac->dump_err_status(rtwdev, err);
 
 	return err;
 }
@@ -1645,7 +1775,7 @@ static bool mac_is_txq_empty_ax(struct rtw89_dev *rtwdev)
 		}
 		qtmp = qempty.qempty;
 		for (j = 0 ; j < QEMP_ACQ_GRP_MACID_NUM; j++) {
-			val32 = FIELD_GET(QEMP_ACQ_GRP_QSEL_MASK, qtmp);
+			val32 = u32_get_bits(qtmp, QEMP_ACQ_GRP_QSEL_MASK);
 			if (val32 != QEMP_ACQ_GRP_QSEL_MASK)
 				return false;
 			qtmp >>= QEMP_ACQ_GRP_QSEL_SH;
@@ -5997,6 +6127,9 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 
 	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_ax,
 
+	.dump_qta_lost = rtw89_mac_dump_qta_lost_ax,
+	.dump_err_status = rtw89_mac_dump_err_status_ax,
+
 	.is_txq_empty = mac_is_txq_empty_ax,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index b63c506e8de1..18b285d9d96f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -935,6 +935,10 @@ struct rtw89_mac_gen_def {
 			     enum rtw89_phy_idx phy_idx,
 			     u32 reg_base, u32 *cr);
 
+	void (*dump_qta_lost)(struct rtw89_dev *rtwdev);
+	void (*dump_err_status)(struct rtw89_dev *rtwdev,
+				enum mac_ax_err_info err);
+
 	bool (*is_txq_empty)(struct rtw89_dev *rtwdev);
 };
 
@@ -1041,8 +1045,14 @@ int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 band,
 			   enum rtw89_mac_hwmod_sel sel);
 int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val);
 int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val);
+int rtw89_mac_dle_dfi_cfg(struct rtw89_dev *rtwdev, struct rtw89_mac_dle_dfi_ctrl *ctrl);
+int rtw89_mac_dle_dfi_quota_cfg(struct rtw89_dev *rtwdev,
+				struct rtw89_mac_dle_dfi_quota *quota);
+void rtw89_mac_dump_dmac_err_status(struct rtw89_dev *rtwdev);
 int rtw89_mac_dle_dfi_qempty_cfg(struct rtw89_dev *rtwdev,
 				 struct rtw89_mac_dle_dfi_qempty *qempty);
+void rtw89_mac_dump_l0_to_l1(struct rtw89_dev *rtwdev,
+			     enum mac_ax_err_info err);
 int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index ec394f02a8ca..c3c920ccb2f9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -780,6 +780,254 @@ static void rtw89_mac_bf_assoc_be(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void dump_err_status_dispatcher_be(struct rtw89_dev *rtwdev)
+{
+	rtw89_info(rtwdev, "R_BE_DISP_HOST_IMR=0x%08x ",
+		   rtw89_read32(rtwdev, R_BE_DISP_HOST_IMR));
+	rtw89_info(rtwdev, "R_BE_DISP_ERROR_ISR1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_DISP_ERROR_ISR1));
+	rtw89_info(rtwdev, "R_BE_DISP_CPU_IMR=0x%08x ",
+		   rtw89_read32(rtwdev, R_BE_DISP_CPU_IMR));
+	rtw89_info(rtwdev, "R_BE_DISP_ERROR_ISR2=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_DISP_ERROR_ISR2));
+	rtw89_info(rtwdev, "R_BE_DISP_OTHER_IMR=0x%08x ",
+		   rtw89_read32(rtwdev, R_BE_DISP_OTHER_IMR));
+	rtw89_info(rtwdev, "R_BE_DISP_ERROR_ISR0=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_DISP_ERROR_ISR0));
+}
+
+static void rtw89_mac_dump_qta_lost_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mac_dle_dfi_qempty qempty;
+	struct rtw89_mac_dle_dfi_quota quota;
+	struct rtw89_mac_dle_dfi_ctrl ctrl;
+	u32 val, not_empty, i;
+	int ret;
+
+	qempty.dle_type = DLE_CTRL_TYPE_PLE;
+	qempty.grpsel = 0;
+	qempty.qempty = ~(u32)0;
+	ret = rtw89_mac_dle_dfi_qempty_cfg(rtwdev, &qempty);
+	if (ret)
+		rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
+	else
+		rtw89_info(rtwdev, "DLE group0 empty: 0x%x\n", qempty.qempty);
+
+	for (not_empty = ~qempty.qempty, i = 0; not_empty != 0; not_empty >>= 1, i++) {
+		if (!(not_empty & BIT(0)))
+			continue;
+		ctrl.type = DLE_CTRL_TYPE_PLE;
+		ctrl.target = DLE_DFI_TYPE_QLNKTBL;
+		ctrl.addr = (QLNKTBL_ADDR_INFO_SEL_0 ? QLNKTBL_ADDR_INFO_SEL : 0) |
+			    u32_encode_bits(i, QLNKTBL_ADDR_TBL_IDX_MASK);
+		ret = rtw89_mac_dle_dfi_cfg(rtwdev, &ctrl);
+		if (ret)
+			rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
+		else
+			rtw89_info(rtwdev, "qidx%d pktcnt = %d\n", i,
+				   u32_get_bits(ctrl.out_data,
+						QLNKTBL_DATA_SEL1_PKT_CNT_MASK));
+	}
+
+	quota.dle_type = DLE_CTRL_TYPE_PLE;
+	quota.qtaid = 6;
+	ret = rtw89_mac_dle_dfi_quota_cfg(rtwdev, &quota);
+	if (ret)
+		rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
+	else
+		rtw89_info(rtwdev, "quota6 rsv/use: 0x%x/0x%x\n",
+			   quota.rsv_pgnum, quota.use_pgnum);
+
+	val = rtw89_read32(rtwdev, R_BE_PLE_QTA6_CFG);
+	rtw89_info(rtwdev, "[PLE][CMAC0_RX]min_pgnum=0x%x\n",
+		   u32_get_bits(val, B_BE_PLE_Q6_MIN_SIZE_MASK));
+	rtw89_info(rtwdev, "[PLE][CMAC0_RX]max_pgnum=0x%x\n",
+		   u32_get_bits(val, B_BE_PLE_Q6_MAX_SIZE_MASK));
+	val = rtw89_read32(rtwdev, R_BE_RX_FLTR_OPT);
+	rtw89_info(rtwdev, "[PLE][CMAC0_RX]B_BE_RX_MPDU_MAX_LEN=0x%x\n",
+		   u32_get_bits(val, B_BE_RX_MPDU_MAX_LEN_MASK));
+	rtw89_info(rtwdev, "R_BE_RSP_CHK_SIG=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_RSP_CHK_SIG));
+	rtw89_info(rtwdev, "R_BE_TRXPTCL_RESP_0=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_TRXPTCL_RESP_0));
+
+	if (!rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_1, RTW89_CMAC_SEL)) {
+		quota.dle_type = DLE_CTRL_TYPE_PLE;
+		quota.qtaid = 7;
+		ret = rtw89_mac_dle_dfi_quota_cfg(rtwdev, &quota);
+		if (ret)
+			rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
+		else
+			rtw89_info(rtwdev, "quota7 rsv/use: 0x%x/0x%x\n",
+				   quota.rsv_pgnum, quota.use_pgnum);
+
+		val = rtw89_read32(rtwdev, R_BE_PLE_QTA7_CFG);
+		rtw89_info(rtwdev, "[PLE][CMAC1_RX]min_pgnum=0x%x\n",
+			   u32_get_bits(val, B_BE_PLE_Q7_MIN_SIZE_MASK));
+		rtw89_info(rtwdev, "[PLE][CMAC1_RX]max_pgnum=0x%x\n",
+			   u32_get_bits(val, B_BE_PLE_Q7_MAX_SIZE_MASK));
+		val = rtw89_read32(rtwdev, R_BE_RX_FLTR_OPT_C1);
+		rtw89_info(rtwdev, "[PLE][CMAC1_RX]B_BE_RX_MPDU_MAX_LEN=0x%x\n",
+			   u32_get_bits(val, B_BE_RX_MPDU_MAX_LEN_MASK));
+		rtw89_info(rtwdev, "R_BE_RSP_CHK_SIG_C1=0x%08x\n",
+			   rtw89_read32(rtwdev, R_BE_RSP_CHK_SIG_C1));
+		rtw89_info(rtwdev, "R_BE_TRXPTCL_RESP_0_C1=0x%08x\n",
+			   rtw89_read32(rtwdev, R_BE_TRXPTCL_RESP_0_C1));
+	}
+
+	rtw89_info(rtwdev, "R_BE_DLE_EMPTY0=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_DLE_EMPTY0));
+	rtw89_info(rtwdev, "R_BE_DLE_EMPTY1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_DLE_EMPTY1));
+
+	dump_err_status_dispatcher_be(rtwdev);
+}
+
+static void rtw89_mac_dump_cmac_err_status_be(struct rtw89_dev *rtwdev,
+					      u8 band)
+{
+	u32 offset = 0;
+	u32 cmac_err;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, band, RTW89_CMAC_SEL);
+	if (ret) {
+		rtw89_info(rtwdev, "[CMAC] : CMAC%d not enabled\n", band);
+		return;
+	}
+
+	if (band)
+		offset = RTW89_MAC_BE_BAND_REG_OFFSET;
+
+	cmac_err = rtw89_read32(rtwdev, R_BE_CMAC_ERR_ISR + offset);
+	rtw89_info(rtwdev, "R_BE_CMAC_ERR_ISR [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_BE_CMAC_ERR_ISR + offset));
+	rtw89_info(rtwdev, "R_BE_CMAC_FUNC_EN [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_BE_CMAC_FUNC_EN + offset));
+	rtw89_info(rtwdev, "R_BE_CK_EN [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_BE_CK_EN + offset));
+
+	if (cmac_err & B_BE_SCHEDULE_TOP_ERR_IND) {
+		rtw89_info(rtwdev, "R_BE_SCHEDULE_ERR_IMR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_SCHEDULE_ERR_IMR + offset));
+		rtw89_info(rtwdev, "R_BE_SCHEDULE_ERR_ISR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_SCHEDULE_ERR_ISR + offset));
+	}
+
+	if (cmac_err & B_BE_PTCL_TOP_ERR_IND) {
+		rtw89_info(rtwdev, "R_BE_PTCL_IMR0 [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_PTCL_IMR0 + offset));
+		rtw89_info(rtwdev, "R_BE_PTCL_ISR0 [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_PTCL_ISR0 + offset));
+		rtw89_info(rtwdev, "R_BE_PTCL_IMR1 [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_PTCL_IMR1 + offset));
+		rtw89_info(rtwdev, "R_BE_PTCL_ISR1 [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_PTCL_ISR1 + offset));
+	}
+
+	if (cmac_err & B_BE_DMA_TOP_ERR_IND) {
+		rtw89_info(rtwdev, "R_BE_RX_ERROR_FLAG_IMR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_RX_ERROR_FLAG_IMR + offset));
+		rtw89_info(rtwdev, "R_BE_RX_ERROR_FLAG [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_RX_ERROR_FLAG + offset));
+		rtw89_info(rtwdev, "R_BE_TX_ERROR_FLAG_IMR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_TX_ERROR_FLAG_IMR + offset));
+		rtw89_info(rtwdev, "R_BE_TX_ERROR_FLAG [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_TX_ERROR_FLAG + offset));
+		rtw89_info(rtwdev, "R_BE_RX_ERROR_FLAG_IMR_1 [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_RX_ERROR_FLAG_IMR_1 + offset));
+		rtw89_info(rtwdev, "R_BE_RX_ERROR_FLAG_1 [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_RX_ERROR_FLAG_1 + offset));
+	}
+
+	if (cmac_err & B_BE_PHYINTF_ERR_IND) {
+		rtw89_info(rtwdev, "R_BE_PHYINFO_ERR_IMR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_PHYINFO_ERR_IMR_V1 + offset));
+		rtw89_info(rtwdev, "R_BE_PHYINFO_ERR_ISR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_PHYINFO_ERR_ISR + offset));
+	}
+
+	if (cmac_err & B_AX_TXPWR_CTRL_ERR_IND) {
+		rtw89_info(rtwdev, "R_BE_TXPWR_ERR_FLAG [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_TXPWR_ERR_FLAG + offset));
+		rtw89_info(rtwdev, "R_BE_TXPWR_ERR_IMR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_TXPWR_ERR_IMR + offset));
+	}
+
+	if (cmac_err & (B_BE_WMAC_RX_ERR_IND | B_BE_WMAC_TX_ERR_IND |
+			B_BE_WMAC_RX_IDLETO_IDCT | B_BE_PTCL_TX_IDLETO_IDCT)) {
+		rtw89_info(rtwdev, "R_BE_DBGSEL_TRXPTCL [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_DBGSEL_TRXPTCL + offset));
+		rtw89_info(rtwdev, "R_BE_TRXPTCL_ERROR_INDICA_MASK [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_TRXPTCL_ERROR_INDICA_MASK + offset));
+		rtw89_info(rtwdev, "R_BE_TRXPTCL_ERROR_INDICA [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_TRXPTCL_ERROR_INDICA + offset));
+		rtw89_info(rtwdev, "R_BE_RX_ERR_IMR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_RX_ERR_IMR + offset));
+		rtw89_info(rtwdev, "R_BE_RX_ERR_ISR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_BE_RX_ERR_ISR + offset));
+	}
+
+	rtw89_info(rtwdev, "R_BE_CMAC_ERR_IMR [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_BE_CMAC_ERR_IMR + offset));
+}
+
+static void rtw89_mac_dump_err_status_be(struct rtw89_dev *rtwdev,
+					 enum mac_ax_err_info err)
+{
+	if (err != MAC_AX_ERR_L1_ERR_DMAC &&
+	    err != MAC_AX_ERR_L0_PROMOTE_TO_L1 &&
+	    err != MAC_AX_ERR_L0_ERR_CMAC0 &&
+	    err != MAC_AX_ERR_L0_ERR_CMAC1 &&
+	    err != MAC_AX_ERR_RXI300)
+		return;
+
+	rtw89_info(rtwdev, "--->\nerr=0x%x\n", err);
+	rtw89_info(rtwdev, "R_BE_SER_DBG_INFO=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_DBG_INFO));
+	rtw89_info(rtwdev, "R_BE_SER_L0_DBG_CNT=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L0_DBG_CNT));
+	rtw89_info(rtwdev, "R_BE_SER_L0_DBG_CNT1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L0_DBG_CNT1));
+	rtw89_info(rtwdev, "R_BE_SER_L0_DBG_CNT2=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L0_DBG_CNT2));
+	rtw89_info(rtwdev, "R_BE_SER_L0_DBG_CNT3=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L0_DBG_CNT3));
+	if (!rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_1, RTW89_CMAC_SEL)) {
+		rtw89_info(rtwdev, "R_BE_SER_L0_DBG_CNT_C1=0x%08x\n",
+			   rtw89_read32(rtwdev, R_BE_SER_L0_DBG_CNT_C1));
+		rtw89_info(rtwdev, "R_BE_SER_L0_DBG_CNT1_C1=0x%08x\n",
+			   rtw89_read32(rtwdev, R_BE_SER_L0_DBG_CNT1_C1));
+	}
+	rtw89_info(rtwdev, "R_BE_SER_L1_DBG_CNT_0=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L1_DBG_CNT_0));
+	rtw89_info(rtwdev, "R_BE_SER_L1_DBG_CNT_1=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L1_DBG_CNT_1));
+	rtw89_info(rtwdev, "R_BE_SER_L1_DBG_CNT_2=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L1_DBG_CNT_2));
+	rtw89_info(rtwdev, "R_BE_SER_L1_DBG_CNT_3=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L1_DBG_CNT_3));
+	rtw89_info(rtwdev, "R_BE_SER_L1_DBG_CNT_4=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L1_DBG_CNT_4));
+	rtw89_info(rtwdev, "R_BE_SER_L1_DBG_CNT_5=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L1_DBG_CNT_5));
+	rtw89_info(rtwdev, "R_BE_SER_L1_DBG_CNT_6=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L1_DBG_CNT_6));
+	rtw89_info(rtwdev, "R_BE_SER_L1_DBG_CNT_7=0x%08x\n",
+		   rtw89_read32(rtwdev, R_BE_SER_L1_DBG_CNT_7));
+
+	rtw89_mac_dump_dmac_err_status(rtwdev);
+	rtw89_mac_dump_cmac_err_status_be(rtwdev, RTW89_MAC_0);
+	rtw89_mac_dump_cmac_err_status_be(rtwdev, RTW89_MAC_1);
+
+	rtwdev->hci.ops->dump_err_status(rtwdev);
+
+	if (err == MAC_AX_ERR_L0_PROMOTE_TO_L1)
+		rtw89_mac_dump_l0_to_l1(rtwdev, err);
+
+	rtw89_info(rtwdev, "<---\n");
+}
+
 static bool mac_is_txq_empty_be(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mac_dle_dfi_qempty qempty;
@@ -871,6 +1119,9 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 
 	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_be,
 
+	.dump_qta_lost = rtw89_mac_dump_qta_lost_be,
+	.dump_err_status = rtw89_mac_dump_err_status_be,
+
 	.is_txq_empty = mac_is_txq_empty_be,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 0ca07ae63594..769f1ce62ebc 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3826,12 +3826,22 @@ static int rtw89_pci_ops_mac_lv1_recovery(struct rtw89_dev *rtwdev,
 
 static void rtw89_pci_ops_dump_err_status(struct rtw89_dev *rtwdev)
 {
-	rtw89_info(rtwdev, "R_AX_RPQ_RXBD_IDX =0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_RPQ_RXBD_IDX));
-	rtw89_info(rtwdev, "R_AX_DBG_ERR_FLAG=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_DBG_ERR_FLAG));
-	rtw89_info(rtwdev, "R_AX_LBC_WATCHDOG=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_LBC_WATCHDOG));
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+		return;
+
+	if (rtwdev->chip->chip_id == RTL8852C) {
+		rtw89_info(rtwdev, "R_AX_DBG_ERR_FLAG=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_DBG_ERR_FLAG_V1));
+		rtw89_info(rtwdev, "R_AX_LBC_WATCHDOG=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_LBC_WATCHDOG_V1));
+	} else {
+		rtw89_info(rtwdev, "R_AX_RPQ_RXBD_IDX =0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_RPQ_RXBD_IDX));
+		rtw89_info(rtwdev, "R_AX_DBG_ERR_FLAG=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_DBG_ERR_FLAG));
+		rtw89_info(rtwdev, "R_AX_LBC_WATCHDOG=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_LBC_WATCHDOG));
+	}
 }
 
 static int rtw89_pci_napi_poll(struct napi_struct *napi, int budget)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index e2d8eef52b20..ca5de77fee90 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -812,6 +812,8 @@
 #define B_AX_RXCOUNTER_MATCH_MASK	GENMASK(15, 8)
 #define B_AX_RXTIMER_MATCH_MASK		GENMASK(7, 0)
 
+#define R_AX_DBG_ERR_FLAG_V1 0x1104
+
 #define R_AX_INT_MIT_RX_V1 0x1184
 #define B_AX_RXMIT_RXP2_SEL_V1 BIT(19)
 #define B_AX_RXMIT_RXP1_SEL_V1 BIT(18)
@@ -857,6 +859,8 @@
 #define R_AX_PCIE_HRPWM_V1		0x30C0
 #define R_AX_PCIE_CRPWM			0x30C4
 
+#define R_AX_LBC_WATCHDOG_V1 0x30D8
+
 #define R_BE_PCIE_HRPWM 0x30C0
 #define R_BE_PCIE_CRPWM 0x30C4
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 76f9195f40e7..2f2ac0748ce0 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1457,6 +1457,8 @@
 #define B_AX_PLE_Q6_MAX_SIZE_MASK GENMASK(27, 16)
 #define B_AX_PLE_Q6_MIN_SIZE_MASK GENMASK(11, 0)
 #define R_AX_PLE_QTA7_CFG 0x905C
+#define B_AX_PLE_Q7_MAX_SIZE_MASK GENMASK(27, 16)
+#define B_AX_PLE_Q7_MIN_SIZE_MASK GENMASK(11, 0)
 #define R_AX_PLE_QTA8_CFG 0x9060
 #define R_AX_PLE_QTA9_CFG 0x9064
 #define R_AX_PLE_QTA10_CFG 0x9068
@@ -4122,6 +4124,15 @@
 				     B_BE_PL_AXIDMA_TXBD_LEN0_MASK | \
 				     B_BE_PL_AXIDMA_FC_ERR_MASK)
 
+#define R_BE_PL_AXIDMA_IDCT 0x0914
+#define B_BE_PL_AXIDMA_RRESP_ERR BIT(6)
+#define B_BE_PL_AXIDMA_BRESP_ERR BIT(5)
+#define B_BE_PL_AXIDMA_FC_ERR BIT(4)
+#define B_BE_PL_AXIDMA_TXBD_LEN0 BIT(3)
+#define B_BE_PL_AXIDMA_TXBD_4KBOUD_LENERR BIT(2)
+#define B_BE_PL_AXIDMA_TXBD_RX_STUCK BIT(1)
+#define B_BE_PL_AXIDMA_TXBD_TX_STUCK BIT(0)
+
 #define R_BE_FILTER_MODEL_ADDR 0x0C04
 
 #define R_BE_WLAN_WDT 0x3050
@@ -4305,6 +4316,12 @@
 #define B_BE_DMAC_CTRL_INFO_SER_IO BIT(11)
 #define B_BE_DMAC_CTRL_INFO_OFFSET_MASK GENMASK(10, 0)
 
+#define R_BE_SER_DBG_INFO 0x8424
+#define B_BE_SER_L0_PROMOTE_L1_EVENT_MASK GENMASK(31, 28)
+#define B_BE_SER_L1_COUNTER_MASK GENMASK(27, 24)
+#define B_BE_RMAC_PPDU_HANG_CNT_MASK GENMASK(23, 16)
+#define B_BE_SER_L0_COUNTER_MASK GENMASK(8, 0)
+
 #define R_BE_DLE_EMPTY0 0x8430
 #define B_BE_PLE_EMPTY_QTA_DMAC_H2D BIT(27)
 #define B_BE_PLE_EMPTY_QTA_DMAC_CPUIO BIT(26)
@@ -4335,6 +4352,193 @@
 #define B_BE_WDE_EMPTY_QUE_CMAC0_MBH BIT(1)
 #define B_BE_WDE_EMPTY_QUE_CMAC0_ALL_AC BIT(0)
 
+#define R_BE_DLE_EMPTY1 0x8434
+#define B_BE_PLE_EMPTY_QTA_CMAC_DMA_TXRPT BIT(21)
+#define B_BE_PLE_EMPTY_QTA_DMAC_WDRLS BIT(20)
+#define B_BE_PLE_EMPTY_QTA_CMAC1_DMA_BBRPT BIT(19)
+#define B_BE_PLE_EMPTY_QTA_CMAC1_DMA_RX BIT(18)
+#define B_BE_PLE_EMPTY_QTA_CMAC0_DMA_RX BIT(17)
+#define B_BE_PLE_EMPTY_QTA_DMAC_C2H BIT(16)
+#define B_BE_PLE_EMPTY_QUE_DMAC_PLRLS BIT(5)
+#define B_BE_PLE_EMPTY_QUE_DMAC_CPUIO BIT(4)
+#define B_BE_PLE_EMPTY_QUE_DMAC_SEC_RX BIT(3)
+#define B_BE_PLE_EMPTY_QUE_DMAC_MPDU_RX BIT(2)
+#define B_BE_PLE_EMPTY_QUE_DMAC_HDP BIT(1)
+#define B_BE_WDE_EMPTY_QUE_DMAC_WDRLS BIT(0)
+
+#define R_BE_SER_L1_DBG_CNT_0 0x8440
+#define B_BE_SER_L1_WDRLS_CNT_MASK GENMASK(31, 24)
+#define B_BE_SER_L1_SEC_CNT_MASK GENMASK(23, 16)
+#define B_BE_SER_L1_MPDU_CNT_MASK GENMASK(15, 8)
+#define B_BE_SER_L1_STA_SCH_CNT_MASK GENMASK(7, 0)
+
+#define R_BE_SER_L1_DBG_CNT_1 0x8444
+#define B_BE_SER_L1_WDE_CNT_MASK GENMASK(31, 24)
+#define B_BE_SER_L1_TXPKTCTRL_CNT_MASK GENMASK(23, 16)
+#define B_BE_SER_L1_PLE_CNT_MASK GENMASK(15, 8)
+#define B_BE_SER_L1_PKTIN_CNT_MASK GENMASK(7, 0)
+
+#define R_BE_SER_L1_DBG_CNT_2 0x8448
+#define B_BE_SER_L1_DISP_CNT_MASK GENMASK(31, 24)
+#define B_BE_SER_L1_APB_BRIDGE_CNT_MASK GENMASK(23, 16)
+#define B_BE_SER_L1_DLE_W_CPUIO_CNT_MASK GENMASK(15, 8)
+#define B_BE_SER_L1_BBRPT_CNT_MASK GENMASK(7, 0)
+
+#define R_BE_SER_L1_DBG_CNT_3 0x844C
+#define B_BE_SER_L1_HCI_BUF_CNT_MASK GENMASK(31, 24)
+#define B_BE_SER_L1_P_AXIDMA_CNT_MASK GENMASK(23, 16)
+#define B_BE_SER_L1_H_AXIDMA_CNT_MASK GENMASK(15, 8)
+#define B_BE_SER_L1_MLO_ERR_CNT_MASK GENMASK(7, 0)
+
+#define R_BE_SER_L1_DBG_CNT_4 0x8450
+#define B_BE_SER_L1_PLDRLS_ERR_CNT_MASK GENMASK(31, 24)
+#define B_BE_SER_L1_DLE_D_CPUIO_CNT_MASK GENMASK(23, 16)
+
+#define R_BE_SER_L1_DBG_CNT_5 0x8454
+#define B_BE_SER_L1_DBG_0_MASK GENMASK(31, 0)
+
+#define R_BE_SER_L1_DBG_CNT_6 0x8458
+#define B_BE_SER_L1_DBG_1_MASK GENMASK(31, 0)
+
+#define R_BE_SER_L1_DBG_CNT_7 0x845C
+#define B_BE_SER_L1_DBG_2_MASK GENMASK(31, 0)
+
+#define R_BE_DMAC_ERR_IMR 0x8520
+#define B_BE_DMAC_NOTX_ERR_INT_EN BIT(21)
+#define B_BE_DMAC_NORX_ERR_INT_EN BIT(20)
+#define B_BE_DLE_DATACPUIO_ERR_INT_EN BIT(19)
+#define B_BE_PLRSL_ERR_INT_EN BIT(18)
+#define B_BE_MLO_ERR_INT_EN BIT(17)
+#define B_BE_DMAC_FW_ERR_INT_EN BIT(16)
+#define B_BE_H_AXIDMA_ERR_INT_EN BIT(14)
+#define B_BE_P_AXIDMA_ERR_INT_EN BIT(13)
+#define B_BE_HCI_BUF_ERR_INT_EN BIT(12)
+#define B_BE_BBRPT_ERR_INT_EN BIT(11)
+#define B_BE_DLE_CPUIO_ERR_INT_EN BIT(10)
+#define B_BE_APB_BRIDGE_ERR_INT_EN BIT(9)
+#define B_BE_DISPATCH_ERR_INT_EN BIT(8)
+#define B_BE_PKTIN_ERR_INT_EN BIT(7)
+#define B_BE_PLE_DLE_ERR_INT_EN BIT(6)
+#define B_BE_TXPKTCTRL_ERR_INT_EN BIT(5)
+#define B_BE_WDE_DLE_ERR_INT_EN BIT(4)
+#define B_BE_STA_SCHEDULER_ERR_INT_EN BIT(3)
+#define B_BE_MPDU_ERR_INT_EN BIT(2)
+#define B_BE_WSEC_ERR_INT_EN BIT(1)
+#define B_BE_WDRLS_ERR_INT_EN BIT(0)
+
+#define R_BE_DMAC_ERR_ISR 0x8524
+#define B_BE_DLE_DATACPUIO_ERR_INT BIT(19)
+#define B_BE_PLRLS_ERR_INT BIT(18)
+#define B_BE_MLO_ERR_INT BIT(17)
+#define B_BE_DMAC_FW_ERR_IDCT BIT(16)
+#define B_BE_H_AXIDMA_ERR_INT BIT(14)
+#define B_BE_P_AXIDMA_ERR_INT BIT(13)
+#define B_BE_HCI_BUF_ERR_FLAG BIT(12)
+#define B_BE_BBRPT_ERR_FLAG BIT(11)
+#define B_BE_DLE_CPUIO_ERR_FLAG BIT(10)
+#define B_BE_APB_BRIDGE_ERR_FLAG BIT(9)
+#define B_BE_DISPATCH_ERR_FLAG BIT(8)
+#define B_BE_PKTIN_ERR_FLAG BIT(7)
+#define B_BE_PLE_DLE_ERR_FLAG BIT(6)
+#define B_BE_TXPKTCTRL_ERR_FLAG BIT(5)
+#define B_BE_WDE_DLE_ERR_FLAG BIT(4)
+#define B_BE_STA_SCHEDULER_ERR_FLAG BIT(3)
+#define B_BE_MPDU_ERR_FLAG BIT(2)
+#define B_BE_WSEC_ERR_FLAG BIT(1)
+#define B_BE_WDRLS_ERR_FLAG BIT(0)
+
+#define R_BE_DISP_ERROR_ISR0 0x8804
+#define B_BE_REUSE_SIZE_ERR BIT(31)
+#define B_BE_REUSE_EN_ERR BIT(30)
+#define B_BE_STF_OQT_UNDERFLOW_ERR BIT(29)
+#define B_BE_STF_OQT_OVERFLOW_ERR BIT(28)
+#define B_BE_STF_WRFF_UNDERFLOW_ERR BIT(27)
+#define B_BE_STF_WRFF_OVERFLOW_ERR BIT(26)
+#define B_BE_STF_CMD_UNDERFLOW_ERR BIT(25)
+#define B_BE_STF_CMD_OVERFLOW_ERR BIT(24)
+#define B_BE_REUSE_SIZE_ZERO_ERR BIT(23)
+#define B_BE_REUSE_PKT_CNT_ERR BIT(22)
+#define B_BE_CDT_PTR_TIMEOUT_ERR BIT(21)
+#define B_BE_CDT_HCI_TIMEOUT_ERR BIT(20)
+#define B_BE_HDT_PTR_TIMEOUT_ERR BIT(19)
+#define B_BE_HDT_HCI_TIMEOUT_ERR BIT(18)
+#define B_BE_CDT_ADDR_INFO_LEN_ERR BIT(17)
+#define B_BE_HDT_ADDR_INFO_LEN_ERR BIT(16)
+#define B_BE_CDR_DMA_TIMEOUT_ERR BIT(15)
+#define B_BE_CDR_RX_TIMEOUT_ERR BIT(14)
+#define B_BE_PLE_OUTPUT_ERR BIT(12)
+#define B_BE_PLE_RESPOSE_ERR BIT(11)
+#define B_BE_PLE_BURST_NUM_ERR BIT(10)
+#define B_BE_PLE_NULL_PKT_ERR BIT(9)
+#define B_BE_PLE_FLOW_CTRL_ERR BIT(8)
+#define B_BE_HDR_DMA_TIMEOUT_ERR BIT(7)
+#define B_BE_HDR_RX_TIMEOUT_ERR BIT(6)
+#define B_BE_WDE_OUTPUT_ERR BIT(4)
+#define B_BE_WDE_RESPONSE_ERR BIT(3)
+#define B_BE_WDE_BURST_NUM_ERR BIT(2)
+#define B_BE_WDE_NULL_PKT_ERR BIT(1)
+#define B_BE_WDE_FLOW_CTRL_ERR BIT(0)
+
+#define R_BE_DISP_ERROR_ISR1 0x8808
+#define B_BE_HR_WRFF_UNDERFLOW_ERR BIT(31)
+#define B_BE_HR_WRFF_OVERFLOW_ERR BIT(30)
+#define B_BE_HR_CHKSUM_FSM_ERR BIT(29)
+#define B_BE_HR_SHIFT_DMA_CFG_ERR BIT(28)
+#define B_BE_HR_DMA_PROCESS_ERR BIT(27)
+#define B_BE_HR_TOTAL_LEN_UNDER_ERR BIT(26)
+#define B_BE_HR_SHIFT_EN_ERR BIT(25)
+#define B_BE_HR_AGG_CFG_ERR BIT(24)
+#define B_BE_HR_PLD_LEN_ZERO_ERR BIT(22)
+#define B_BE_HT_ILL_CH_ERR BIT(20)
+#define B_BE_HT_ADDR_INFO_LEN_ERR BIT(18)
+#define B_BE_HT_WD_LEN_OVER_ERR BIT(17)
+#define B_BE_HT_PLD_CMD_UNDERFLOW_ERR BIT(16)
+#define B_BE_HT_PLD_CMD_OVERFLOW_ERR BIT(15)
+#define B_BE_HT_WRFF_UNDERFLOW_ERR BIT(14)
+#define B_BE_HT_WRFF_OVERFLOW_ERR BIT(13)
+#define B_BE_HT_CHKSUM_FSM_ERR BIT(12)
+#define B_BE_HT_NON_IDLE_PKT_STR_ERR BIT(11)
+#define B_BE_HT_PRE_SUB_BE_ERR BIT(10)
+#define B_BE_HT_WD_CHKSUM_ERR BIT(9)
+#define B_BE_HT_CHANNEL_DMA_ERR BIT(8)
+#define B_BE_HT_OFFSET_UNMATCH_ERR BIT(7)
+#define B_BE_HT_PAYLOAD_UNDER_ERR BIT(6)
+#define B_BE_HT_PAYLOAD_OVER_ERR BIT(5)
+#define B_BE_HT_PERMU_FF_UNDERFLOW_ERR BIT(4)
+#define B_BE_HT_PERMU_FF_OVERFLOW_ERR BIT(3)
+#define B_BE_HT_PKT_FAIL_ERR BIT(2)
+#define B_BE_HT_CH_ID_ERR BIT(1)
+#define B_BE_HT_EP_CH_DIFF_ERR BIT(0)
+
+#define R_BE_DISP_ERROR_ISR2 0x880C
+#define B_BE_CR_PLD_LEN_ERR BIT(30)
+#define B_BE_CR_WRFF_UNDERFLOW_ERR BIT(29)
+#define B_BE_CR_WRFF_OVERFLOW_ERR BIT(28)
+#define B_BE_CR_SHIFT_DMA_CFG_ERR BIT(27)
+#define B_BE_CR_DMA_PROCESS_ERR BIT(26)
+#define B_BE_CR_SHIFT_EN_ERR BIT(24)
+#define B_BE_REUSE_FIFO_B_UNDER_ERR BIT(22)
+#define B_BE_REUSE_FIFO_B_OVER_ERR BIT(21)
+#define B_BE_REUSE_FIFO_A_UNDER_ERR BIT(20)
+#define B_BE_REUSE_FIFO_A_OVER_ERR BIT(19)
+#define B_BE_CT_ADDR_INFO_LEN_MISS_ERR BIT(17)
+#define B_BE_CT_WD_LEN_OVER_ERR BIT(16)
+#define B_BE_CT_F2P_SEQ_ERR BIT(15)
+#define B_BE_CT_F2P_QSEL_ERR BIT(14)
+#define B_BE_CT_PLD_CMD_UNDERFLOW_ERR BIT(13)
+#define B_BE_CT_PLD_CMD_OVERFLOW_ERR BIT(12)
+#define B_BE_CT_PRE_SUB_ERR BIT(11)
+#define B_BE_CT_WD_CHKSUM_ERR BIT(10)
+#define B_BE_CT_CHANNEL_DMA_ERR BIT(9)
+#define B_BE_CT_OFFSET_UNMATCH_ERR BIT(8)
+#define B_BE_F2P_TOTAL_NUM_ERR BIT(7)
+#define B_BE_CT_PAYLOAD_UNDER_ERR BIT(6)
+#define B_BE_CT_PAYLOAD_OVER_ERR BIT(5)
+#define B_BE_CT_PERMU_FF_UNDERFLOW_ERR BIT(4)
+#define B_BE_CT_PERMU_FF_OVERFLOW_ERR BIT(3)
+#define B_BE_CT_CH_ID_ERR BIT(2)
+#define B_BE_CT_EP_CH_DIFF_ERR BIT(0)
+
 #define R_BE_DISP_OTHER_IMR 0x8870
 #define B_BE_REUSE_SIZE_ERR_INT_EN BIT(31)
 #define B_BE_REUSE_EN_ERR_INT_EN BIT(30)
@@ -4904,6 +5108,9 @@
 #define B_BE_LA_ERRFLAG_IMR_CLR B_BE_LA_IMR_DATA_LOSS
 #define B_BE_LA_ERRFLAG_IMR_SET B_BE_LA_IMR_DATA_LOSS
 
+#define R_BE_LA_ERRFLAG_ISR 0x966C
+#define B_BE_LA_ISR_DATA_LOSS BIT(0)
+
 #define R_BE_CH_INFO_DBGFLAG_IMR 0x9688
 #define B_BE_BCHN_EVT01_ISR_EN BIT(29)
 #define B_BE_BCHN_REQTO_ISR_EN BIT(28)
@@ -5025,6 +5232,55 @@
 #define B_BE_MPDU_RX_ERR_IMR_CLR B_BE_TIMEOUT_ERR_IMR
 #define B_BE_MPDU_RX_ERR_IMR_SET 0
 
+#define R_BE_SEC_ENG_CTRL 0x9D00
+#define B_BE_SEC_ENG_EN BIT(31)
+#define B_BE_CCMP_SPP_MIC BIT(30)
+#define B_BE_CCMP_SPP_CTR BIT(29)
+#define B_BE_SEC_CAM_ACC BIT(28)
+#define B_BE_WMAC_SEC_PN_SEL_MASK GENMASK(27, 26)
+#define B_BE_WMAC_SEC_MASKIV BIT(25)
+#define B_BE_WAPI_SPEC BIT(24)
+#define B_BE_REVERT_TA_RA_MLD_EN BIT(23)
+#define B_BE_SEC_DBG_SEL_MASK GENMASK(19, 16)
+#define B_BE_CAM_FORCE_CLK BIT(15)
+#define B_BE_SEC_FORCE_CLK BIT(14)
+#define B_BE_SEC_RX_SHORT_ADD_ICVERR BIT(13)
+#define B_BE_SRAM_IO_PROT BIT(12)
+#define B_BE_SEC_PRE_ENQUE_TX BIT(11)
+#define B_BE_CLK_EN_CGCMP BIT(10)
+#define B_BE_CLK_EN_WAPI BIT(9)
+#define B_BE_CLK_EN_WEP_TKIP BIT(8)
+#define B_BE_BMC_MGNT_DEC BIT(5)
+#define B_BE_UC_MGNT_DEC BIT(4)
+#define B_BE_MC_DEC BIT(3)
+#define B_BE_BC_DEC BIT(2)
+#define B_BE_SEC_RX_DEC BIT(1)
+#define B_BE_SEC_TX_ENC BIT(0)
+
+#define R_BE_SEC_MPDU_PROC 0x9D04
+#define B_BE_DBG_ENGINE_SEL BIT(8)
+#define B_BE_STOP_RX_PKT_HANDLE BIT(7)
+#define B_BE_STOP_TX_PKT_HANDLE BIT(6)
+#define B_BE_QUEUE_FOWARD_SEL BIT(5)
+#define B_BE_RESP1_PROTECT BIT(4)
+#define B_BE_RESP0_PROTECT BIT(3)
+#define B_BE_TX_ACTIVE_PROTECT BIT(2)
+#define B_BE_APPEND_ICV BIT(1)
+#define B_BE_APPEND_MIC BIT(0)
+
+#define R_BE_SEC_CAM_ACCESS 0x9D10
+#define B_BE_SEC_TIME_OUT_MASK GENMASK(31, 16)
+#define B_BE_SEC_CAM_POLL BIT(15)
+#define B_BE_SEC_CAM_RW BIT(14)
+#define B_BE_SEC_CAM_ACC_FAIL BIT(13)
+#define B_BE_SEC_CAM_OFFSET_MASK GENMASK(10, 0)
+
+#define R_BE_SEC_CAM_RDATA 0x9D14
+#define B_BE_SEC_CAM_RDATA_MASK GENMASK(31, 0)
+
+#define R_BE_SEC_DEBUG2 0x9D28
+#define B_BE_DBG_READ_MASK GENMASK(31, 0)
+
 #define R_BE_SEC_ERROR_IMR 0x9D2C
 #define B_BE_QUEUE_OPERATION_HANG_IMR BIT(4)
 #define B_BE_SEC1_RX_HANG_IMR BIT(3)
@@ -5042,6 +5298,14 @@
 				B_BE_SEC1_RX_HANG_IMR | \
 				B_BE_QUEUE_OPERATION_HANG_IMR)
 
+#define R_BE_SEC_ERROR_FLAG 0x9D30
+#define B_BE_TXD_DIFF_KEYCAM_TYPE_ERROR BIT(5)
+#define B_BE_QUEUE_OPERATION_HANG_ERROR BIT(4)
+#define B_BE_SEC1_RX_HANG_ERROR BIT(3)
+#define B_BE_SEC1_TX_HANG_ERROR BIT(2)
+#define B_BE_RX_HANG_ERROR BIT(1)
+#define B_BE_TX_HANG_ERROR BIT(0)
+
 #define R_BE_TXPKTCTL_B0_ERRFLAG_IMR 0x9F78
 #define B_BE_B0_IMR_DBG_USRCTL_RLSBMPLEN BIT(25)
 #define B_BE_B0_IMR_DBG_USRCTL_RDNRLSCMD BIT(24)
@@ -5114,11 +5378,23 @@
 				   B_BE_MLO_ERR_IDCT_IMR_1 | \
 				   B_BE_MLO_ERR_IDCT_IMR_0)
 
+#define R_BE_MLO_ERR_IDCT_ISR 0xA12C
+#define B_BE_MLO_ISR_IDCT_0 BIT(31)
+#define B_BE_MLO_ISR_IDCT_1 BIT(30)
+#define B_BE_MLO_ISR_IDCT_2 BIT(29)
+#define B_BE_MLO_ISR_IDCT_3 BIT(28)
+
 #define R_BE_PLRLS_ERR_IMR 0xA218
 #define B_BE_PLRLS_CTL_FRZTO_IMR BIT(0)
 #define B_BE_PLRLS_ERR_IMR_CLR B_BE_PLRLS_CTL_FRZTO_IMR
 #define B_BE_PLRLS_ERR_IMR_SET B_BE_PLRLS_CTL_FRZTO_IMR
 
+#define R_BE_PLRLS_ERR_ISR 0xA21C
+#define B_BE_PLRLS_CTL_EVT03_ISR BIT(3)
+#define B_BE_PLRLS_CTL_EVT02_ISR BIT(2)
+#define B_BE_PLRLS_CTL_EVT01_ISR BIT(1)
+#define B_BE_PLRLS_CTL_FRZTO_ISR BIT(0)
+
 #define R_BE_INTERRUPT_MASK_REG 0xA3F0
 #define B_BE_PLE_B_PKTID_ERR_IMR BIT(2)
 #define B_BE_RPT_TIMEOUT_IMR BIT(1)
@@ -5130,6 +5406,11 @@
 				     B_BE_RPT_TIMEOUT_IMR | \
 				     B_BE_PLE_B_PKTID_ERR_IMR)
 
+#define R_BE_INTERRUPT_STS_REG 0xA3F4
+#define B_BE_PLE_B_PKTID_ERR_ISR BIT(2)
+#define B_BE_RPT_TIMEOUT_ISR BIT(1)
+#define B_BE_SEARCH_TIMEOUT_ISR BIT(0)
+
 #define R_BE_HAXI_INIT_CFG1 0xB000
 #define B_BE_CFG_WD_PERIOD_IDLE_MASK GENMASK(31, 28)
 #define B_BE_CFG_WD_PERIOD_ACTIVE_MASK GENMASK(27, 24)
@@ -5194,6 +5475,16 @@
 				B_BE_HAXI_BRESP_ERR_IDCT_MSK | \
 				B_BE_HAXI_RRESP_ERR_IDCT_MSK)
 
+#define R_BE_HAXI_IDCT 0xB0BC
+#define B_BE_HAXI_RRESP_ERR_IDCT BIT(7)
+#define B_BE_HAXI_BRESP_ERR_IDCT BIT(6)
+#define B_BE_RXDMA_ERR_FLAG_IDCT BIT(5)
+#define B_BE_SET_FC_ERROR_FLAG_IDCT BIT(4)
+#define B_BE__TXBD_LEN0_ERR_IDCT BIT(3)
+#define B_BE__TXBD_4KBOUND_ERR_IDCT BIT(2)
+#define B_BE_RXMDA_STUCK_IDCT BIT(1)
+#define B_BE_TXMDA_STUCK_IDCT BIT(0)
+
 #define R_BE_HCI_FC_CTRL 0xB700
 #define B_BE_WD_PAGE_MODE_MASK GENMASK(17, 16)
 #define B_BE_HCI_FC_CH14_FULL_COND_MASK GENMASK(15, 14)
@@ -5270,6 +5561,104 @@
 			       B_BE_CMAC_CRPRT | B_BE_TXTIME_EN | B_BE_RESP_PKTCTL_EN | \
 			       B_BE_SIGB_EN)
 
+#define R_BE_CK_EN 0x10004
+#define R_BE_CK_EN_C1 0x14004
+#define B_BE_CMAC_CKEN BIT(30)
+#define B_BE_BCN_P1_P4_CKEN BIT(15)
+#define B_BE_BCN_P0MB1_15_CKEN BIT(14)
+#define B_BE_TXTIME_CKEN BIT(8)
+#define B_BE_RESP_PKTCTL_CKEN BIT(7)
+#define B_BE_SIGB_CKEN BIT(6)
+#define B_BE_PHYINTF_CKEN BIT(5)
+#define B_BE_CMAC_DMA_CKEN BIT(4)
+#define B_BE_PTCLTOP_CKEN BIT(3)
+#define B_BE_SCHEDULER_CKEN BIT(2)
+#define B_BE_TMAC_CKEN BIT(1)
+#define B_BE_RMAC_CKEN BIT(0)
+#define B_BE_CK_EN_SET (B_BE_CMAC_CKEN | B_BE_PHYINTF_CKEN | B_BE_CMAC_DMA_CKEN | \
+			B_BE_PTCLTOP_CKEN | B_BE_SCHEDULER_CKEN | B_BE_TMAC_CKEN | \
+			B_BE_RMAC_CKEN | B_BE_TXTIME_CKEN | B_BE_RESP_PKTCTL_CKEN | \
+			B_BE_SIGB_CKEN)
+
+#define R_BE_CMAC_ERR_IMR 0x10160
+#define R_BE_CMAC_ERR_IMR_C1 0x14160
+#define B_BE_CMAC_FW_ERR_IDCT_EN BIT(16)
+#define B_BE_PTCL_TX_IDLETO_IDCT_EN BIT(9)
+#define B_BE_WMAC_RX_IDLETO_IDCT_EN BIT(8)
+#define B_BE_WMAC_TX_ERR_IND_EN BIT(7)
+#define B_BE_WMAC_RX_ERR_IND_EN BIT(6)
+#define B_BE_TXPWR_CTRL_ERR_IND_EN BIT(5)
+#define B_BE_PHYINTF_ERR_IND_EN BIT(4)
+#define B_BE_DMA_TOP_ERR_IND_EN BIT(3)
+#define B_BE_RESP_PKTCTL_ERR_IND_EN BIT(2)
+#define B_BE_PTCL_TOP_ERR_IND_EN BIT(1)
+#define B_BE_SCHEDULE_TOP_ERR_IND_EN BIT(0)
+
+#define R_BE_CMAC_ERR_ISR 0x10164
+#define R_BE_CMAC_ERR_ISR_C1 0x14164
+#define B_BE_CMAC_FW_ERR_IDCT BIT(16)
+#define B_BE_PTCL_TX_IDLETO_IDCT BIT(9)
+#define B_BE_WMAC_RX_IDLETO_IDCT BIT(8)
+#define B_BE_WMAC_TX_ERR_IND BIT(7)
+#define B_BE_WMAC_RX_ERR_IND BIT(6)
+#define B_BE_TXPWR_CTRL_ERR_IND BIT(5)
+#define B_BE_PHYINTF_ERR_IND BIT(4)
+#define B_BE_DMA_TOP_ERR_IND BIT(3)
+#define B_BE_RESP_PKTCTL_ERR_IDCT BIT(2)
+#define B_BE_PTCL_TOP_ERR_IND BIT(1)
+#define B_BE_SCHEDULE_TOP_ERR_IND BIT(0)
+
+#define R_BE_SER_L0_DBG_CNT 0x10170
+#define R_BE_SER_L0_DBG_CNT_C1 0x14170
+#define B_BE_SER_L0_PHYINTF_CNT_MASK GENMASK(31, 24)
+#define B_BE_SER_L0_DMA_CNT_MASK GENMASK(23, 16)
+#define B_BE_SER_L0_PTCL_CNT_MASK GENMASK(15, 8)
+#define B_BE_SER_L0_SCH_CNT_MASK GENMASK(7, 0)
+
+#define R_BE_SER_L0_DBG_CNT1 0x10174
+#define R_BE_SER_L0_DBG_CNT1_C1 0x14174
+#define B_BE_SER_L0_TMAC_COUNTER_MASK GENMASK(23, 16)
+#define B_BE_SER_L0_RMAC_COUNTER_MASK GENMASK(15, 8)
+#define B_BE_SER_L0_TXPWR_COUNTER_MASK GENMASK(7, 0)
+
+#define R_BE_SER_L0_DBG_CNT2 0x10178
+#define R_BE_SER_L0_DBG_CNT2_C1 0x14178
+
+#define R_BE_SER_L0_DBG_CNT3 0x1017C
+#define R_BE_SER_L0_DBG_CNT3_C1 0x1417C
+#define B_BE_SER_L0_SUBMODULE_BIT31_CNT BIT(31)
+#define B_BE_SER_L0_SUBMODULE_BIT30_CNT BIT(30)
+#define B_BE_SER_L0_SUBMODULE_BIT29_CNT BIT(29)
+#define B_BE_SER_L0_SUBMODULE_BIT28_CNT BIT(28)
+#define B_BE_SER_L0_SUBMODULE_BIT27_CNT BIT(27)
+#define B_BE_SER_L0_SUBMODULE_BIT26_CNT BIT(26)
+#define B_BE_SER_L0_SUBMODULE_BIT25_CNT BIT(25)
+#define B_BE_SER_L0_SUBMODULE_BIT24_CNT BIT(24)
+#define B_BE_SER_L0_SUBMODULE_BIT23_CNT BIT(23)
+#define B_BE_SER_L0_SUBMODULE_BIT22_CNT BIT(22)
+#define B_BE_SER_L0_SUBMODULE_BIT21_CNT BIT(21)
+#define B_BE_SER_L0_SUBMODULE_BIT20_CNT BIT(20)
+#define B_BE_SER_L0_SUBMODULE_BIT19_CNT BIT(19)
+#define B_BE_SER_L0_SUBMODULE_BIT18_CNT BIT(18)
+#define B_BE_SER_L0_SUBMODULE_BIT17_CNT BIT(17)
+#define B_BE_SER_L0_SUBMODULE_BIT16_CNT BIT(16)
+#define B_BE_SER_L0_SUBMODULE_BIT15_CNT BIT(15)
+#define B_BE_SER_L0_SUBMODULE_BIT14_CNT BIT(14)
+#define B_BE_SER_L0_SUBMODULE_BIT13_CNT BIT(13)
+#define B_BE_SER_L0_SUBMODULE_BIT12_CNT BIT(12)
+#define B_BE_SER_L0_SUBMODULE_BIT11_CNT BIT(11)
+#define B_BE_SER_L0_SUBMODULE_BIT10_CNT BIT(10)
+#define B_BE_SER_L0_SUBMODULE_BIT9_CNT BIT(9)
+#define B_BE_SER_L0_SUBMODULE_BIT8_CNT BIT(8)
+#define B_BE_SER_L0_SUBMODULE_BIT7_CNT BIT(7)
+#define B_BE_SER_L0_SUBMODULE_BIT6_CNT BIT(6)
+#define B_BE_SER_L0_SUBMODULE_BIT5_CNT BIT(5)
+#define B_BE_SER_L0_SUBMODULE_BIT4_CNT BIT(4)
+#define B_BE_SER_L0_SUBMODULE_BIT3_CNT BIT(3)
+#define B_BE_SER_L0_SUBMODULE_BIT2_CNT BIT(2)
+#define B_BE_SER_L0_SUBMODULE_BIT1_CNT BIT(1)
+#define B_BE_SER_L0_SUBMODULE_BIT0_CNT BIT(0)
+
 #define R_BE_PORT_0_TSF_SYNC 0x102A0
 #define R_BE_PORT_0_TSF_SYNC_C1 0x142A0
 #define B_BE_P0_SYNC_NOW_P BIT(30)
@@ -5296,6 +5685,11 @@
 #define B_BE_SCHEDULE_ERR_IMR_CLR B_BE_FSM_TIMEOUT_ERR_INT_EN
 #define B_BE_SCHEDULE_ERR_IMR_SET B_BE_FSM_TIMEOUT_ERR_INT_EN
 
+#define R_BE_SCHEDULE_ERR_ISR 0x103EC
+#define R_BE_SCHEDULE_ERR_ISR_C1 0x143EC
+#define B_BE_SORT_NON_IDLE_ERR_INT BIT(1)
+#define B_BE_FSM_TIMEOUT_ERR_INT BIT(0)
+
 #define R_BE_PORT_CFG_P0 0x10400
 #define R_BE_PORT_CFG_P0_C1 0x14400
 #define B_BE_BCN_ERLY_SORT_EN_P0 BIT(18)
@@ -5453,6 +5847,12 @@
 			    B_BE_FSM1_TIMEOUT_ERR_INT_EN | \
 			    B_BE_PTCL_ERROR_FLAG_IMR)
 
+#define R_BE_PTCL_ISR0 0x108C4
+#define R_BE_PTCL_ISR0_C1 0x148C4
+#define B_BE_PTCL_ERROR_FLAG_ISR BIT(31)
+#define B_BE_FSM1_TIMEOUT_ERR BIT(1)
+#define B_BE_FSM_TIMEOUT_ERR BIT(0)
+
 #define R_BE_PTCL_IMR1 0x108C8
 #define R_BE_PTCL_IMR1_C1 0x148C8
 #define B_BE_F2PCMD_PKTID_IMR BIT(30)
@@ -5489,6 +5889,60 @@
 			    B_BE_F2PCMD_PKTID_IMR)
 #define B_BE_PTCL_IMR1_SET B_BE_F2PCMD_USER_ALLC_IMR
 
+#define R_BE_PTCL_ISR1 0x108CC
+#define R_BE_PTCL_ISR1_C1 0x148CC
+#define B_BE_F2PCMD_PKTID_ERR BIT(30)
+#define B_BE_F2PCMD_RD_PKTID_ERR BIT(29)
+#define B_BE_F2PCMD_ASSIGN_PKTID_ERR BIT(28)
+#define B_BE_F2PCMD_USER_ALLC_ERR BIT(27)
+#define B_BE_RX_SPF_U0_PKTID_ERR BIT(26)
+#define B_BE_TX_SPF_U1_PKTID_ERR BIT(25)
+#define B_BE_TX_SPF_U2_PKTID_ERR BIT(24)
+#define B_BE_TX_SPF_U3_PKTID_ERR BIT(23)
+#define B_BE_TX_RECORD_PKTID_ERR BIT(22)
+#define B_BE_TWTSP_QSEL_ERR BIT(14)
+#define B_BE_F2P_RLS_CTN_SEL_ERR BIT(13)
+#define B_BE_BCNQ_ORDER_ERR BIT(12)
+#define B_BE_Q_PKTID_ERR BIT(11)
+#define B_BE_D_PKTID_ERR BIT(10)
+#define B_BE_TXPRT_FULL_DROP_ERR BIT(9)
+#define B_BE_F2PCMDRPT_FULL_DROP_ERR BIT(8)
+
+#define R_BE_RX_ERROR_FLAG 0x10C00
+#define R_BE_RX_ERROR_FLAG_C1 0x14C00
+#define B_BE_RX_CSI_NOT_RELEASE_ERROR BIT(31)
+#define B_BE_RX_GET_NULL_PKT_ERROR BIT(30)
+#define B_BE_RX_RU0_FSM_HANG_ERROR BIT(29)
+#define B_BE_RX_RU1_FSM_HANG_ERROR BIT(28)
+#define B_BE_RX_RU2_FSM_HANG_ERROR BIT(27)
+#define B_BE_RX_RU3_FSM_HANG_ERROR BIT(26)
+#define B_BE_RX_RU4_FSM_HANG_ERROR BIT(25)
+#define B_BE_RX_RU5_FSM_HANG_ERROR BIT(24)
+#define B_BE_RX_RU6_FSM_HANG_ERROR BIT(23)
+#define B_BE_RX_RU7_FSM_HANG_ERROR BIT(22)
+#define B_BE_RX_RXSTS_FSM_HANG_ERROR BIT(21)
+#define B_BE_RX_CSI_FSM_HANG_ERROR BIT(20)
+#define B_BE_RX_TXRPT_FSM_HANG_ERROR BIT(19)
+#define B_BE_RX_F2PCMD_FSM_HANG_ERROR BIT(18)
+#define B_BE_RX_RU0_ZERO_LENGTH_ERROR BIT(17)
+#define B_BE_RX_RU1_ZERO_LENGTH_ERROR BIT(16)
+#define B_BE_RX_RU2_ZERO_LENGTH_ERROR BIT(15)
+#define B_BE_RX_RU3_ZERO_LENGTH_ERROR BIT(14)
+#define B_BE_RX_RU4_ZERO_LENGTH_ERROR BIT(13)
+#define B_BE_RX_RU5_ZERO_LENGTH_ERROR BIT(12)
+#define B_BE_RX_RU6_ZERO_LENGTH_ERROR BIT(11)
+#define B_BE_RX_RU7_ZERO_LENGTH_ERROR BIT(10)
+#define B_BE_RX_RXSTS_ZERO_LENGTH_ERROR BIT(9)
+#define B_BE_RX_CSI_ZERO_LENGTH_ERROR BIT(8)
+#define B_BE_PLE_DATA_OPT_FSM_HANG BIT(7)
+#define B_BE_PLE_RXDATA_REQUEST_BUFFER_FSM_HANG BIT(6)
+#define B_BE_PLE_TXRPT_REQUEST_BUFFER_FSM_HANG BIT(5)
+#define B_BE_PLE_WD_OPT_FSM_HANG BIT(4)
+#define B_BE_PLE_ENQ_FSM_HANG BIT(3)
+#define B_BE_RXDATA_ENQUE_ORDER_ERROR BIT(2)
+#define B_BE_RXSTS_ENQUE_ORDER_ERROR BIT(1)
+#define B_BE_RX_CSI_PKT_NUM_ERROR BIT(0)
+
 #define R_BE_RX_ERROR_FLAG_IMR 0x10C04
 #define R_BE_RX_ERROR_FLAG_IMR_C1 0x14C04
 #define B_BE_RX_CSI_NOT_RELEASE_ERROR_IMR BIT(31)
@@ -5568,6 +6022,27 @@
 				    B_BE_RX_RU0_FSM_HANG_ERROR_IMR | \
 				    B_BE_RX_GET_NULL_PKT_ERROR_IMR)
 
+#define R_BE_TX_ERROR_FLAG 0x10C6C
+#define R_BE_TX_ERROR_FLAG_C1 0x14C6C
+#define B_BE_TX_RU0_FSM_HANG_ERROR BIT(31)
+#define B_BE_TX_RU1_FSM_HANG_ERROR BIT(30)
+#define B_BE_TX_RU2_FSM_HANG_ERROR BIT(29)
+#define B_BE_TX_RU3_FSM_HANG_ERROR BIT(28)
+#define B_BE_TX_RU4_FSM_HANG_ERROR BIT(27)
+#define B_BE_TX_RU5_FSM_HANG_ERROR BIT(26)
+#define B_BE_TX_RU6_FSM_HANG_ERROR BIT(25)
+#define B_BE_TX_RU7_FSM_HANG_ERROR BIT(24)
+#define B_BE_TX_RU8_FSM_HANG_ERROR BIT(23)
+#define B_BE_TX_RU9_FSM_HANG_ERROR BIT(22)
+#define B_BE_TX_RU10_FSM_HANG_ERROR BIT(21)
+#define B_BE_TX_RU11_FSM_HANG_ERROR BIT(20)
+#define B_BE_TX_RU12_FSM_HANG_ERROR BIT(19)
+#define B_BE_TX_RU13_FSM_HANG_ERROR BIT(18)
+#define B_BE_TX_RU14_FSM_HANG_ERROR BIT(17)
+#define B_BE_TX_RU15_FSM_HANG_ERROR BIT(16)
+#define B_BE_TX_CSI_FSM_HANG_ERROR BIT(15)
+#define B_BE_TX_WD_PLD_ID_FSM_HANG_ERROR BIT(14)
+
 #define R_BE_TX_ERROR_FLAG_IMR 0x10C70
 #define R_BE_TX_ERROR_FLAG_IMR_C1 0x14C70
 #define B_BE_TX_RU0_FSM_HANG_ERROR_IMR BIT(31)
@@ -5625,6 +6100,25 @@
 				    B_BE_TX_RU1_FSM_HANG_ERROR_IMR | \
 				    B_BE_TX_RU0_FSM_HANG_ERROR_IMR)
 
+#define R_BE_RX_ERROR_FLAG_1 0x10C84
+#define R_BE_RX_ERROR_FLAG_1_C1 0x14C84
+#define B_BE_RX_RU8_FSM_HANG_ERROR BIT(29)
+#define B_BE_RX_RU9_FSM_HANG_ERROR BIT(28)
+#define B_BE_RX_RU10_FSM_HANG_ERROR BIT(27)
+#define B_BE_RX_RU11_FSM_HANG_ERROR BIT(26)
+#define B_BE_RX_RU12_FSM_HANG_ERROR BIT(25)
+#define B_BE_RX_RU13_FSM_HANG_ERROR BIT(24)
+#define B_BE_RX_RU14_FSM_HANG_ERROR BIT(23)
+#define B_BE_RX_RU15_FSM_HANG_ERROR BIT(22)
+#define B_BE_RX_RU8_ZERO_LENGTH_ERROR BIT(17)
+#define B_BE_RX_RU9_ZERO_LENGTH_ERROR BIT(16)
+#define B_BE_RX_RU10_ZERO_LENGTH_ERROR BIT(15)
+#define B_BE_RX_RU11_ZERO_LENGTH_ERROR BIT(14)
+#define B_BE_RX_RU12_ZERO_LENGTH_ERROR BIT(13)
+#define B_BE_RX_RU13_ZERO_LENGTH_ERROR BIT(12)
+#define B_BE_RX_RU14_ZERO_LENGTH_ERROR BIT(11)
+#define B_BE_RX_RU15_ZERO_LENGTH_ERROR BIT(10)
+
 #define R_BE_RX_ERROR_FLAG_IMR_1 0x10C88
 #define R_BE_RX_ERROR_FLAG_IMR_1_C1 0x14C88
 #define B_BE_RX_RU8_FSM_HANG_ERROR_IMR BIT(29)
@@ -5683,6 +6177,38 @@
 #define B_BE_UPD_HGQMD BIT(1)
 #define B_BE_UPD_TIMIE BIT(0)
 
+#define R_BE_RSP_CHK_SIG 0x11000
+#define R_BE_RSP_CHK_SIG_C1 0x15000
+#define B_BE_RSP_STATIC_RTS_CHK_SERV_BW_EN BIT(30)
+#define B_BE_RSP_TBPPDU_CHK_PWR BIT(29)
+#define B_BE_RESP_PAIR_MACID_LEN_EN BIT(25)
+#define B_BE_RESP_TX_ABORT_TEST_EN BIT(24)
+#define B_BE_RESP_ER_SU_RU106_EN BIT(23)
+#define B_BE_RESP_ER_SU_EN BIT(22)
+#define B_BE_TXDATA_END_PS_OPT BIT(18)
+#define B_BE_CHECK_SOUNDING_SEQ BIT(17)
+#define B_BE_RXBA_IGNOREA2 BIT(16)
+#define B_BE_ACKTO_CCK_MASK GENMASK(15, 8)
+#define B_BE_ACKTO_MASK GENMASK(8, 0)
+
+#define R_BE_TRXPTCL_RESP_0 0x11004
+#define R_BE_TRXPTCL_RESP_0_C1 0x15004
+#define B_BE_WMAC_RESP_STBC_EN BIT(31)
+#define B_BE_WMAC_RXFTM_TXACK_SB BIT(30)
+#define B_BE_WMAC_RXFTM_TXACKBWEQ BIT(29)
+#define B_BE_RESP_TB_CHK_TXTIME BIT(24)
+#define B_BE_RSP_CHK_CCA BIT(23)
+#define B_BE_WMAC_LDPC_EN BIT(22)
+#define B_BE_WMAC_SGIEN BIT(21)
+#define B_BE_WMAC_SPLCPEN BIT(20)
+#define B_BE_RESP_EHT_MCS15_REF BIT(19)
+#define B_BE_RESP_EHT_MCS14_REF BIT(18)
+#define B_BE_WMAC_BESP_EARLY_TXBA BIT(17)
+#define B_BE_WMAC_MBA_DUR_FORCE BIT(16)
+#define B_BE_WMAC_SPEC_SIFS_OFDM_MASK GENMASK(15, 8)
+#define WMAC_SPEC_SIFS_OFDM_1115E 0x11
+#define B_BE_WMAC_SPEC_SIFS_CCK_MASK GENMASK(7, 0)
+
 #define R_BE_TRXPTCL_ERROR_INDICA_MASK 0x110BC
 #define R_BE_TRXPTCL_ERROR_INDICA_MASK_C1 0x150BC
 #define B_BE_WMAC_FTM_TIMEOUT_MODE BIT(30)
@@ -5720,6 +6246,25 @@
 					    B_BE_RMAC_FTM | \
 					    B_BE_RMAC_BFMER)
 
+#define R_BE_TRXPTCL_ERROR_INDICA 0x110C0
+#define R_BE_TRXPTCL_ERROR_INDICA_C1 0x150C0
+#define B_BE_BFMER_ERR_FLAG BIT(9)
+#define B_BE_FTM_ERROR_FLAG_CLR BIT(8)
+#define B_BE_CSI_ERROR_FLAG_CLR BIT(7)
+#define B_BE_MIMOCTRL_ERROR_FLAG_CLR BIT(6)
+#define B_BE_RXTB_ERROR_FLAG_CLR BIT(5)
+#define B_BE_HWSIGB_GEN_ERROR_FLAG_CLR BIT(4)
+#define B_BE_TXPLCP_ERROR_FLAG_CLR BIT(3)
+#define B_BE_RESP_ERROR_FLAG_CLR BIT(2)
+#define B_BE_TXCTL_ERROR_FLAG_CLR BIT(1)
+#define B_BE_MACTX_ERROR_FLAG_CLR BIT(0)
+
+#define R_BE_DBGSEL_TRXPTCL 0x110F4
+#define R_BE_DBGSEL_TRXPTCL_C1 0x150F4
+#define B_BE_WMAC_CHNSTS_STATE_MASK GENMASK(19, 16)
+#define B_BE_DBGSEL_TRIGCMD_SEL_MASK GENMASK(11, 8)
+#define B_BE_DBGSEL_TRXPTCL_MASK GENMASK(7, 0)
+
 #define R_BE_PHYINFO_ERR_IMR_V1 0x110F8
 #define R_BE_PHYINFO_ERR_IMR_V1_C1 0x150F8
 #define B_BE_PHYINTF_RXTB_WIDTH_MASK GENMASK(31, 30)
@@ -5741,6 +6286,15 @@
 				      B_BE_CSI_ON_TIMEOUT_EN)
 #define B_BE_PHYINFO_ERR_IMR_V1_SET 0
 
+#define R_BE_PHYINFO_ERR_ISR 0x110FC
+#define R_BE_PHYINFO_ERR_ISR_C1 0x150FC
+#define B_BE_CSI_ON_TIMEOUT_ERR BIT(5)
+#define B_BE_STS_ON_TIMEOUT_ERR BIT(4)
+#define B_BE_DATA_ON_TIMEOUT_ERR BIT(3)
+#define B_BE_OFDM_CCA_TIMEOUT_ERR BIT(2)
+#define B_BE_CCK_CCA_TIMEOUT_ERR BIT(1)
+#define B_BE_PHY_TXON_TIMEOUT_ERR BIT(0)
+
 #define R_BE_BFMEE_RESP_OPTION 0x11180
 #define R_BE_BFMEE_RESP_OPTION_C1 0x15180
 #define B_BE_BFMEE_CSI_SEC_TYPE_SH 20
@@ -5821,6 +6375,19 @@
 #define B_BE_CSIPRT_HESU_AID_EN BIT(25)
 #define B_BE_CSIPRT_VHTSU_AID_EN BIT(24)
 
+#define R_BE_RX_ERR_ISR 0x114F4
+#define R_BE_RX_ERR_ISR_C1 0x154F4
+#define B_BE_RX_ERR_TRIG_ACT_TO BIT(9)
+#define B_BE_RX_ERR_STS_ACT_TO BIT(8)
+#define B_BE_RX_ERR_CSI_ACT_TO BIT(7)
+#define B_BE_RX_ERR_ACT_TO BIT(6)
+#define B_BE_CSI_DATAON_ASSERT_TO BIT(5)
+#define B_BE_DATAON_ASSERT_TO BIT(4)
+#define B_BE_CCA_ASSERT_TO BIT(3)
+#define B_BE_RX_ERR_DMA_TO BIT(2)
+#define B_BE_RX_ERR_DATA_TO BIT(1)
+#define B_BE_RX_ERR_CCA_TO BIT(0)
+
 #define R_BE_RX_ERR_IMR 0x114F8
 #define R_BE_RX_ERR_IMR_C1 0x154F8
 #define B_BE_RX_ERR_TRIG_ACT_TO_MSK BIT(9)
@@ -5909,6 +6476,11 @@
 #define B_BE_C0_TXPWR_IMR_CLR B_BE_FSM_TIMEOUT_ERR_INT_EN
 #define B_BE_C0_TXPWR_IMR_SET B_BE_FSM_TIMEOUT_ERR_INT_EN
 
+#define R_BE_TXPWR_ERR_FLAG 0x128E4
+#define R_BE_TXPWR_ERR_IMR 0x128E0
+#define R_BE_TXPWR_ERR_FLAG_C1 0x158E4
+#define R_BE_TXPWR_ERR_IMR_C1 0x158E0
+
 #define CMAC1_START_ADDR_BE 0x14000
 #define CMAC1_END_ADDR_BE 0x17FFF
 
-- 
2.25.1


