Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6021B61571B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 02:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKBBn6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 21:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKBBnz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 21:43:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70EEBDED7
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 18:43:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A21h05s9012786, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A21h05s9012786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 2 Nov 2022 09:43:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Wed, 2 Nov 2022 09:43:36 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 2 Nov 2022
 09:43:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: update D-MAC and C-MAC dump to diagnose SER
Date:   Wed, 2 Nov 2022 09:43:00 +0800
Message-ID: <20221102014300.14091-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102014300.14091-1-pkshih@realtek.com>
References: <20221102014300.14091-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/02/2022 01:23:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzEgpFWkyCAxMDozMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chia-Yuan Li <leo.li@realtek.com>

To detect TX or RX stuck, we implement SER (system error recovery) in
firmware to recover abnormal states of hardware, and report events to
driver. This kind of events could happen rarely per day.

SER might be true-positive or false-negative cases, and it could be failed
to recover true-positive case. We dump related registers to kernel message
at that moment and collect them from users, because they occur rarely,
randomly and hard to make sure we reproduce the same symptom. To address
problems accurately, add more registers by this patch.

It also might be false-positive cases that looks like TX or RX get stuck,
we need to dump registers from debugfs manually, so also add similar
things to debugfs as well.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 426 ++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/mac.c   | 374 +++++++++++++-----
 drivers/net/wireless/realtek/rtw89/mac.h   |   1 +
 drivers/net/wireless/realtek/rtw89/pci.h   |  12 +
 drivers/net/wireless/realtek/rtw89/reg.h   | 229 ++++++++++-
 5 files changed, 845 insertions(+), 197 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index afd10e91d3ea5..8297e35bfa52b 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -8,6 +8,7 @@
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
+#include "pci.h"
 #include "ps.h"
 #include "reg.h"
 #include "sar.h"
@@ -988,7 +989,9 @@ static int rtw89_debug_mac_dump_dle_dbg(struct rtw89_dev *rtwdev,
 static int rtw89_debug_mac_dump_dmac_dbg(struct rtw89_dev *rtwdev,
 					 struct seq_file *m)
 {
-	int ret;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 dmac_err;
+	int i, ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, 0, RTW89_DMAC_SEL);
 	if (ret) {
@@ -996,98 +999,347 @@ static int rtw89_debug_mac_dump_dmac_dbg(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	seq_printf(m, "R_AX_DMAC_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_DMAC_ERR_ISR));
-	seq_printf(m, "[0]R_AX_WDRLS_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_WDRLS_ERR_ISR));
-	seq_printf(m, "[1]R_AX_SEC_ERR_IMR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_SEC_ERR_IMR_ISR));
-	seq_printf(m, "[2.1]R_AX_MPDU_TX_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_ISR));
-	seq_printf(m, "[2.2]R_AX_MPDU_RX_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_ISR));
-	seq_printf(m, "[3]R_AX_STA_SCHEDULER_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_ISR));
-	seq_printf(m, "[4]R_AX_WDE_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
-	seq_printf(m, "[5.1]R_AX_TXPKTCTL_ERR_IMR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR));
-	seq_printf(m, "[5.2]R_AX_TXPKTCTL_ERR_IMR_ISR_B1=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR_B1));
-	seq_printf(m, "[6]R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
-	seq_printf(m, "[7]R_AX_PKTIN_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_ISR));
-	seq_printf(m, "[8.1]R_AX_OTHER_DISPATCHER_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_ISR));
-	seq_printf(m, "[8.2]R_AX_HOST_DISPATCHER_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_ISR));
-	seq_printf(m, "[8.3]R_AX_CPU_DISPATCHER_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_ISR));
-	seq_printf(m, "[10]R_AX_CPUIO_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_CPUIO_ERR_ISR));
-	seq_printf(m, "[11.1]R_AX_BBRPT_COM_ERR_IMR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR_ISR));
-	seq_printf(m, "[11.2]R_AX_BBRPT_CHINFO_ERR_IMR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_IMR_ISR));
-	seq_printf(m, "[11.3]R_AX_BBRPT_DFS_ERR_IMR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_IMR_ISR));
-	seq_printf(m, "[11.4]R_AX_LA_ERRFLAG=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_LA_ERRFLAG));
+	dmac_err = rtw89_read32(rtwdev, R_AX_DMAC_ERR_ISR);
+	seq_printf(m, "R_AX_DMAC_ERR_ISR=0x%08x\n", dmac_err);
+	seq_printf(m, "R_AX_DMAC_ERR_IMR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_DMAC_ERR_IMR));
+
+	if (dmac_err) {
+		seq_printf(m, "R_AX_WDE_ERR_FLAG_CFG=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WDE_ERR_FLAG_CFG_NUM1));
+		seq_printf(m, "R_AX_PLE_ERR_FLAG_CFG=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_CFG_NUM1));
+		if (chip->chip_id == RTL8852C) {
+			seq_printf(m, "R_AX_PLE_ERRFLAG_MSG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_PLE_ERRFLAG_MSG));
+			seq_printf(m, "R_AX_WDE_ERRFLAG_MSG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_WDE_ERRFLAG_MSG));
+			seq_printf(m, "R_AX_PLE_DBGERR_LOCKEN=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_PLE_DBGERR_LOCKEN));
+			seq_printf(m, "R_AX_PLE_DBGERR_STS=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_PLE_DBGERR_STS));
+		}
+	}
+
+	if (dmac_err & B_AX_WDRLS_ERR_FLAG) {
+		seq_printf(m, "R_AX_WDRLS_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WDRLS_ERR_IMR));
+		seq_printf(m, "R_AX_WDRLS_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WDRLS_ERR_ISR));
+		if (chip->chip_id == RTL8852C)
+			seq_printf(m, "R_AX_RPQ_RXBD_IDX=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RPQ_RXBD_IDX_V1));
+		else
+			seq_printf(m, "R_AX_RPQ_RXBD_IDX=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RPQ_RXBD_IDX));
+	}
+
+	if (dmac_err & B_AX_WSEC_ERR_FLAG) {
+		if (chip->chip_id == RTL8852C) {
+			seq_printf(m, "R_AX_SEC_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_ERROR_FLAG_IMR));
+			seq_printf(m, "R_AX_SEC_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_ERROR_FLAG));
+			seq_printf(m, "R_AX_SEC_ENG_CTRL=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL));
+			seq_printf(m, "R_AX_SEC_MPDU_PROC=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_MPDU_PROC));
+			seq_printf(m, "R_AX_SEC_CAM_ACCESS=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_CAM_ACCESS));
+			seq_printf(m, "R_AX_SEC_CAM_RDATA=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_CAM_RDATA));
+			seq_printf(m, "R_AX_SEC_DEBUG1=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_DEBUG1));
+			seq_printf(m, "R_AX_SEC_TX_DEBUG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_TX_DEBUG));
+			seq_printf(m, "R_AX_SEC_RX_DEBUG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_RX_DEBUG));
+
+			rtw89_write32_mask(rtwdev, R_AX_DBG_CTRL,
+					   B_AX_DBG_SEL0, 0x8B);
+			rtw89_write32_mask(rtwdev, R_AX_DBG_CTRL,
+					   B_AX_DBG_SEL1, 0x8B);
+			rtw89_write32_mask(rtwdev, R_AX_SYS_STATUS1,
+					   B_AX_SEL_0XC0_MASK, 1);
+			for (i = 0; i < 0x10; i++) {
+				rtw89_write32_mask(rtwdev, R_AX_SEC_ENG_CTRL,
+						   B_AX_SEC_DBG_PORT_FIELD_MASK, i);
+				seq_printf(m, "sel=%x,R_AX_SEC_DEBUG2=0x%08x\n",
+					   i, rtw89_read32(rtwdev, R_AX_SEC_DEBUG2));
+			}
+		} else {
+			seq_printf(m, "R_AX_SEC_ERR_IMR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_DEBUG));
+			seq_printf(m, "R_AX_SEC_ENG_CTRL=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL));
+			seq_printf(m, "R_AX_SEC_MPDU_PROC=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_MPDU_PROC));
+			seq_printf(m, "R_AX_SEC_CAM_ACCESS=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_CAM_ACCESS));
+			seq_printf(m, "R_AX_SEC_CAM_RDATA=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_CAM_RDATA));
+			seq_printf(m, "R_AX_SEC_CAM_WDATA=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_CAM_WDATA));
+			seq_printf(m, "R_AX_SEC_TX_DEBUG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_TX_DEBUG));
+			seq_printf(m, "R_AX_SEC_RX_DEBUG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_RX_DEBUG));
+			seq_printf(m, "R_AX_SEC_TRX_PKT_CNT=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_TRX_PKT_CNT));
+			seq_printf(m, "R_AX_SEC_TRX_BLK_CNT=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_TRX_BLK_CNT));
+		}
+	}
+
+	if (dmac_err & B_AX_MPDU_ERR_FLAG) {
+		seq_printf(m, "R_AX_MPDU_TX_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_IMR));
+		seq_printf(m, "R_AX_MPDU_TX_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_ISR));
+		seq_printf(m, "R_AX_MPDU_RX_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_IMR));
+		seq_printf(m, "R_AX_MPDU_RX_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_ISR));
+	}
+
+	if (dmac_err & B_AX_STA_SCHEDULER_ERR_FLAG) {
+		seq_printf(m, "R_AX_STA_SCHEDULER_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_IMR));
+		seq_printf(m, "R_AX_STA_SCHEDULER_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_ISR));
+	}
+
+	if (dmac_err & B_AX_WDE_DLE_ERR_FLAG) {
+		seq_printf(m, "R_AX_WDE_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WDE_ERR_IMR));
+		seq_printf(m, "R_AX_WDE_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
+		seq_printf(m, "R_AX_PLE_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PLE_ERR_IMR));
+		seq_printf(m, "R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
+	}
+
+	if (dmac_err & B_AX_TXPKTCTRL_ERR_FLAG) {
+		if (chip->chip_id == RTL8852C) {
+			seq_printf(m, "R_AX_TXPKTCTL_B0_ERRFLAG_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B0_ERRFLAG_IMR));
+			seq_printf(m, "R_AX_TXPKTCTL_B0_ERRFLAG_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B0_ERRFLAG_ISR));
+			seq_printf(m, "R_AX_TXPKTCTL_B1_ERRFLAG_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B1_ERRFLAG_IMR));
+			seq_printf(m, "R_AX_TXPKTCTL_B1_ERRFLAG_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B1_ERRFLAG_ISR));
+		} else {
+			seq_printf(m, "R_AX_TXPKTCTL_ERR_IMR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR));
+			seq_printf(m, "R_AX_TXPKTCTL_ERR_IMR_ISR_B1=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR_B1));
+		}
+	}
+
+	if (dmac_err & B_AX_PLE_DLE_ERR_FLAG) {
+		seq_printf(m, "R_AX_WDE_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WDE_ERR_IMR));
+		seq_printf(m, "R_AX_WDE_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
+		seq_printf(m, "R_AX_PLE_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PLE_ERR_IMR));
+		seq_printf(m, "R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
+		seq_printf(m, "R_AX_WD_CPUQ_OP_0=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_0));
+		seq_printf(m, "R_AX_WD_CPUQ_OP_1=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_1));
+		seq_printf(m, "R_AX_WD_CPUQ_OP_2=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_2));
+		seq_printf(m, "R_AX_WD_CPUQ_OP_STATUS=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WD_CPUQ_OP_STATUS));
+		seq_printf(m, "R_AX_PL_CPUQ_OP_0=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_0));
+		seq_printf(m, "R_AX_PL_CPUQ_OP_1=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_1));
+		seq_printf(m, "R_AX_PL_CPUQ_OP_2=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_2));
+		seq_printf(m, "R_AX_PL_CPUQ_OP_STATUS=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_STATUS));
+		if (chip->chip_id == RTL8852C) {
+			seq_printf(m, "R_AX_RX_CTRL0=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RX_CTRL0));
+			seq_printf(m, "R_AX_RX_CTRL1=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RX_CTRL1));
+			seq_printf(m, "R_AX_RX_CTRL2=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RX_CTRL2));
+		} else {
+			seq_printf(m, "R_AX_RXDMA_PKT_INFO_0=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_0));
+			seq_printf(m, "R_AX_RXDMA_PKT_INFO_1=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_1));
+			seq_printf(m, "R_AX_RXDMA_PKT_INFO_2=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_2));
+		}
+	}
+
+	if (dmac_err & B_AX_PKTIN_ERR_FLAG) {
+		seq_printf(m, "R_AX_PKTIN_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_IMR));
+		seq_printf(m, "R_AX_PKTIN_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_ISR));
+	}
+
+	if (dmac_err & B_AX_DISPATCH_ERR_FLAG) {
+		seq_printf(m, "R_AX_HOST_DISPATCHER_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR));
+		seq_printf(m, "R_AX_HOST_DISPATCHER_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_ISR));
+		seq_printf(m, "R_AX_CPU_DISPATCHER_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_IMR));
+		seq_printf(m, "R_AX_CPU_DISPATCHER_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_ISR));
+		seq_printf(m, "R_AX_OTHER_DISPATCHER_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_IMR));
+		seq_printf(m, "R_AX_OTHER_DISPATCHER_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_ISR));
+	}
+
+	if (dmac_err & B_AX_BBRPT_ERR_FLAG) {
+		if (chip->chip_id == RTL8852C) {
+			seq_printf(m, "R_AX_BBRPT_COM_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR));
+			seq_printf(m, "R_AX_BBRPT_COM_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_ISR));
+			seq_printf(m, "R_AX_BBRPT_CHINFO_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_ISR));
+			seq_printf(m, "R_AX_BBRPT_CHINFO_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_IMR));
+			seq_printf(m, "R_AX_BBRPT_DFS_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_IMR));
+			seq_printf(m, "R_AX_BBRPT_DFS_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_ISR));
+		} else {
+			seq_printf(m, "R_AX_BBRPT_COM_ERR_IMR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR_ISR));
+			seq_printf(m, "R_AX_BBRPT_CHINFO_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_ISR));
+			seq_printf(m, "R_AX_BBRPT_CHINFO_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_IMR));
+			seq_printf(m, "R_AX_BBRPT_DFS_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_IMR));
+			seq_printf(m, "R_AX_BBRPT_DFS_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_ISR));
+		}
+	}
+
+	if (dmac_err & B_AX_HAXIDMA_ERR_FLAG && chip->chip_id == RTL8852C) {
+		seq_printf(m, "R_AX_HAXIDMA_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_HAXI_IDCT_MSK));
+		seq_printf(m, "R_AX_HAXIDMA_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_HAXI_IDCT));
+	}
 
 	return 0;
 }
 
-static int rtw89_debug_mac_dump_cmac_dbg(struct rtw89_dev *rtwdev,
-					 struct seq_file *m)
+static int rtw89_debug_mac_dump_cmac_err(struct rtw89_dev *rtwdev,
+					 struct seq_file *m,
+					 enum rtw89_mac_idx band)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 offset = 0;
+	u32 cmac_err;
 	int ret;
 
-	ret = rtw89_mac_check_mac_en(rtwdev, 0, RTW89_CMAC_SEL);
+	ret = rtw89_mac_check_mac_en(rtwdev, band, RTW89_CMAC_SEL);
 	if (ret) {
-		seq_puts(m, "[CMAC] : CMAC 0 not enabled\n");
+		if (band)
+			seq_puts(m, "[CMAC] : CMAC1 not enabled\n");
+		else
+			seq_puts(m, "[CMAC] : CMAC0 not enabled\n");
 		return ret;
 	}
 
-	seq_printf(m, "R_AX_CMAC_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR));
-	seq_printf(m, "[0]R_AX_SCHEDULE_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_ISR));
-	seq_printf(m, "[1]R_AX_PTCL_ISR0=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_PTCL_ISR0));
-	seq_printf(m, "[3]R_AX_DLE_CTRL=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_DLE_CTRL));
-	seq_printf(m, "[4]R_AX_PHYINFO_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_ISR));
-	seq_printf(m, "[5]R_AX_TXPWR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_TXPWR_ISR));
-	seq_printf(m, "[6]R_AX_RMAC_ERR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_RMAC_ERR_ISR));
-	seq_printf(m, "[7]R_AX_TMAC_ERR_IMR_ISR=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_TMAC_ERR_IMR_ISR));
-
-	ret = rtw89_mac_check_mac_en(rtwdev, 1, RTW89_CMAC_SEL);
-	if (ret) {
-		seq_puts(m, "[CMAC] : CMAC 1 not enabled\n");
-		return ret;
+	if (band)
+		offset = RTW89_MAC_AX_BAND_REG_OFFSET;
+
+	cmac_err = rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR + offset);
+	seq_printf(m, "R_AX_CMAC_ERR_ISR [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR + offset));
+	seq_printf(m, "R_AX_CMAC_FUNC_EN [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_AX_CMAC_FUNC_EN + offset));
+	seq_printf(m, "R_AX_CK_EN [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_AX_CK_EN + offset));
+
+	if (cmac_err & B_AX_SCHEDULE_TOP_ERR_IND) {
+		seq_printf(m, "R_AX_SCHEDULE_ERR_IMR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_IMR + offset));
+		seq_printf(m, "R_AX_SCHEDULE_ERR_ISR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_ISR + offset));
 	}
 
-	seq_printf(m, "R_AX_CMAC_ERR_ISR_C1=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR_C1));
-	seq_printf(m, "[0]R_AX_SCHEDULE_ERR_ISR_C1=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_ISR_C1));
-	seq_printf(m, "[1]R_AX_PTCL_ISR0_C1=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_PTCL_ISR0_C1));
-	seq_printf(m, "[3]R_AX_DLE_CTRL_C1=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_DLE_CTRL_C1));
-	seq_printf(m, "[4]R_AX_PHYINFO_ERR_ISR_C1=0x%02x\n",
-		   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_ISR_C1));
-	seq_printf(m, "[5]R_AX_TXPWR_ISR_C1=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_TXPWR_ISR_C1));
-	seq_printf(m, "[6]R_AX_RMAC_ERR_ISR_C1=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_RMAC_ERR_ISR_C1));
-	seq_printf(m, "[7]R_AX_TMAC_ERR_IMR_ISR_C1=0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_TMAC_ERR_IMR_ISR_C1));
+	if (cmac_err & B_AX_PTCL_TOP_ERR_IND) {
+		seq_printf(m, "R_AX_PTCL_IMR0 [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_PTCL_IMR0 + offset));
+		seq_printf(m, "R_AX_PTCL_ISR0 [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_PTCL_ISR0 + offset));
+	}
+
+	if (cmac_err & B_AX_DMA_TOP_ERR_IND) {
+		if (chip->chip_id == RTL8852C) {
+			seq_printf(m, "R_AX_RX_ERR_FLAG [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_RX_ERR_FLAG + offset));
+			seq_printf(m, "R_AX_RX_ERR_FLAG_IMR [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_RX_ERR_FLAG_IMR + offset));
+		} else {
+			seq_printf(m, "R_AX_DLE_CTRL [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_DLE_CTRL + offset));
+		}
+	}
+
+	if (cmac_err & B_AX_DMA_TOP_ERR_IND || cmac_err & B_AX_WMAC_RX_ERR_IND) {
+		if (chip->chip_id == RTL8852C) {
+			seq_printf(m, "R_AX_PHYINFO_ERR_ISR [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_ISR + offset));
+			seq_printf(m, "R_AX_PHYINFO_ERR_IMR [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_IMR + offset));
+		} else {
+			seq_printf(m, "R_AX_PHYINFO_ERR_IMR [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_IMR + offset));
+		}
+	}
+
+	if (cmac_err & B_AX_TXPWR_CTRL_ERR_IND) {
+		seq_printf(m, "R_AX_TXPWR_IMR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_TXPWR_IMR + offset));
+		seq_printf(m, "R_AX_TXPWR_ISR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_TXPWR_ISR + offset));
+	}
+
+	if (cmac_err & B_AX_WMAC_TX_ERR_IND) {
+		if (chip->chip_id == RTL8852C) {
+			seq_printf(m, "R_AX_TRXPTCL_ERROR_INDICA [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_TRXPTCL_ERROR_INDICA + offset));
+			seq_printf(m, "R_AX_TRXPTCL_ERROR_INDICA_MASK [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_TRXPTCL_ERROR_INDICA_MASK + offset));
+		} else {
+			seq_printf(m, "R_AX_TMAC_ERR_IMR_ISR [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_TMAC_ERR_IMR_ISR + offset));
+		}
+		seq_printf(m, "R_AX_DBGSEL_TRXPTCL [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL + offset));
+	}
+
+	seq_printf(m, "R_AX_CMAC_ERR_IMR [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_AX_CMAC_ERR_IMR + offset));
+
+	return 0;
+}
+
+static int rtw89_debug_mac_dump_cmac_dbg(struct rtw89_dev *rtwdev,
+					 struct seq_file *m)
+{
+	rtw89_debug_mac_dump_cmac_err(rtwdev, m, RTW89_MAC_0);
+	if (rtwdev->dbcc_en)
+		rtw89_debug_mac_dump_cmac_err(rtwdev, m, RTW89_MAC_1);
 
 	return 0;
 }
@@ -1821,7 +2073,7 @@ static const struct rtw89_mac_dbg_port_info dbg_port_pktinfo = {
 static const struct rtw89_mac_dbg_port_info dbg_port_pcie_txdma = {
 	.sel_addr = R_AX_PCIE_DBG_CTRL,
 	.sel_byte = 2,
-	.sel_msk = B_AX_DBG_SEL_MASK,
+	.sel_msk = B_AX_PCIE_DBG_SEL_MASK,
 	.srt = 0x00,
 	.end = 0x03,
 	.rd_addr = R_AX_DBG_PORT_SEL,
@@ -1832,7 +2084,7 @@ static const struct rtw89_mac_dbg_port_info dbg_port_pcie_txdma = {
 static const struct rtw89_mac_dbg_port_info dbg_port_pcie_rxdma = {
 	.sel_addr = R_AX_PCIE_DBG_CTRL,
 	.sel_byte = 2,
-	.sel_msk = B_AX_DBG_SEL_MASK,
+	.sel_msk = B_AX_PCIE_DBG_SEL_MASK,
 	.srt = 0x00,
 	.end = 0x04,
 	.rd_addr = R_AX_DBG_PORT_SEL,
@@ -1843,7 +2095,7 @@ static const struct rtw89_mac_dbg_port_info dbg_port_pcie_rxdma = {
 static const struct rtw89_mac_dbg_port_info dbg_port_pcie_cvt = {
 	.sel_addr = R_AX_PCIE_DBG_CTRL,
 	.sel_byte = 2,
-	.sel_msk = B_AX_DBG_SEL_MASK,
+	.sel_msk = B_AX_PCIE_DBG_SEL_MASK,
 	.srt = 0x00,
 	.end = 0x01,
 	.rd_addr = R_AX_DBG_PORT_SEL,
@@ -1854,7 +2106,7 @@ static const struct rtw89_mac_dbg_port_info dbg_port_pcie_cvt = {
 static const struct rtw89_mac_dbg_port_info dbg_port_pcie_cxpl = {
 	.sel_addr = R_AX_PCIE_DBG_CTRL,
 	.sel_byte = 2,
-	.sel_msk = B_AX_DBG_SEL_MASK,
+	.sel_msk = B_AX_PCIE_DBG_SEL_MASK,
 	.srt = 0x00,
 	.end = 0x05,
 	.rd_addr = R_AX_DBG_PORT_SEL,
@@ -1865,7 +2117,7 @@ static const struct rtw89_mac_dbg_port_info dbg_port_pcie_cxpl = {
 static const struct rtw89_mac_dbg_port_info dbg_port_pcie_io = {
 	.sel_addr = R_AX_PCIE_DBG_CTRL,
 	.sel_byte = 2,
-	.sel_msk = B_AX_DBG_SEL_MASK,
+	.sel_msk = B_AX_PCIE_DBG_SEL_MASK,
 	.srt = 0x00,
 	.end = 0x05,
 	.rd_addr = R_AX_DBG_PORT_SEL,
@@ -1876,7 +2128,7 @@ static const struct rtw89_mac_dbg_port_info dbg_port_pcie_io = {
 static const struct rtw89_mac_dbg_port_info dbg_port_pcie_misc = {
 	.sel_addr = R_AX_PCIE_DBG_CTRL,
 	.sel_byte = 2,
-	.sel_msk = B_AX_DBG_SEL_MASK,
+	.sel_msk = B_AX_PCIE_DBG_SEL_MASK,
 	.srt = 0x00,
 	.end = 0x06,
 	.rd_addr = R_AX_DBG_PORT_SEL,
@@ -2457,7 +2709,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		info = &dbg_port_pcie_misc2;
 		val16 = rtw89_read16(rtwdev, R_AX_PCIE_DBG_CTRL);
 		val16 = u16_replace_bits(val16, PCIE_MISC2_DBG_SEL,
-					 B_AX_DBG_SEL_MASK);
+					 B_AX_PCIE_DBG_SEL_MASK);
 		rtw89_write16(rtwdev, R_AX_PCIE_DBG_CTRL, val16);
 		seq_puts(m, "Enable pcie misc2 dump.\n");
 		break;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index bb49033b587d2..ac8e66be327f4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -7,6 +7,7 @@
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
+#include "pci.h"
 #include "ps.h"
 #include "reg.h"
 #include "util.h"
@@ -274,106 +275,163 @@ static void rtw89_mac_dump_l0_to_l1(struct rtw89_dev *rtwdev,
 	}
 }
 
-static void rtw89_mac_dump_err_status(struct rtw89_dev *rtwdev,
-				      enum mac_ax_err_info err)
+static void rtw89_mac_dump_dmac_err_status(struct rtw89_dev *rtwdev)
 {
-	u32 dmac_err, cmac_err;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 dmac_err;
+	int i, ret;
 
-	if (err != MAC_AX_ERR_L1_ERR_DMAC &&
-	    err != MAC_AX_ERR_L0_PROMOTE_TO_L1 &&
-	    err != MAC_AX_ERR_L0_ERR_CMAC0 &&
-	    err != MAC_AX_ERR_L0_ERR_CMAC1)
+	ret = rtw89_mac_check_mac_en(rtwdev, 0, RTW89_DMAC_SEL);
+	if (ret) {
+		rtw89_warn(rtwdev, "[DMAC] : DMAC not enabled\n");
 		return;
+	}
 
-	rtw89_info(rtwdev, "--->\nerr=0x%x\n", err);
-	rtw89_info(rtwdev, "R_AX_SER_DBG_INFO =0x%08x\n",
-		   rtw89_read32(rtwdev, R_AX_SER_DBG_INFO));
-
-	cmac_err = rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR);
-	rtw89_info(rtwdev, "R_AX_CMAC_ERR_ISR =0x%08x\n", cmac_err);
 	dmac_err = rtw89_read32(rtwdev, R_AX_DMAC_ERR_ISR);
-	rtw89_info(rtwdev, "R_AX_DMAC_ERR_ISR =0x%08x\n", dmac_err);
+	rtw89_info(rtwdev, "R_AX_DMAC_ERR_ISR=0x%08x\n", dmac_err);
+	rtw89_info(rtwdev, "R_AX_DMAC_ERR_IMR=0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_DMAC_ERR_IMR));
 
 	if (dmac_err) {
-		rtw89_info(rtwdev, "R_AX_WDE_ERR_FLAG_CFG =0x%08x ",
-			   rtw89_read32(rtwdev, R_AX_WDE_ERR_FLAG_CFG));
-		rtw89_info(rtwdev, "R_AX_PLE_ERR_FLAG_CFG =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_CFG));
+		rtw89_info(rtwdev, "R_AX_WDE_ERR_FLAG_CFG=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_WDE_ERR_FLAG_CFG_NUM1));
+		rtw89_info(rtwdev, "R_AX_PLE_ERR_FLAG_CFG=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_CFG_NUM1));
+		if (chip->chip_id == RTL8852C) {
+			rtw89_info(rtwdev, "R_AX_PLE_ERRFLAG_MSG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_PLE_ERRFLAG_MSG));
+			rtw89_info(rtwdev, "R_AX_WDE_ERRFLAG_MSG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_WDE_ERRFLAG_MSG));
+			rtw89_info(rtwdev, "R_AX_PLE_DBGERR_LOCKEN=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_PLE_DBGERR_LOCKEN));
+			rtw89_info(rtwdev, "R_AX_PLE_DBGERR_STS=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_PLE_DBGERR_STS));
+		}
 	}
 
 	if (dmac_err & B_AX_WDRLS_ERR_FLAG) {
-		rtw89_info(rtwdev, "R_AX_WDRLS_ERR_IMR =0x%08x ",
+		rtw89_info(rtwdev, "R_AX_WDRLS_ERR_IMR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_WDRLS_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_WDRLS_ERR_ISR =0x%08x\n",
+		rtw89_info(rtwdev, "R_AX_WDRLS_ERR_ISR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_WDRLS_ERR_ISR));
+		if (chip->chip_id == RTL8852C)
+			rtw89_info(rtwdev, "R_AX_RPQ_RXBD_IDX=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RPQ_RXBD_IDX_V1));
+		else
+			rtw89_info(rtwdev, "R_AX_RPQ_RXBD_IDX=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RPQ_RXBD_IDX));
 	}
 
 	if (dmac_err & B_AX_WSEC_ERR_FLAG) {
-		rtw89_info(rtwdev, "R_AX_SEC_ERR_IMR_ISR =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_SEC_DEBUG));
-		rtw89_info(rtwdev, "SEC_local_Register 0x9D00 =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL));
-		rtw89_info(rtwdev, "SEC_local_Register 0x9D04 =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_SEC_MPDU_PROC));
-		rtw89_info(rtwdev, "SEC_local_Register 0x9D10 =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_SEC_CAM_ACCESS));
-		rtw89_info(rtwdev, "SEC_local_Register 0x9D14 =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_SEC_CAM_RDATA));
-		rtw89_info(rtwdev, "SEC_local_Register 0x9D18 =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_SEC_CAM_WDATA));
-		rtw89_info(rtwdev, "SEC_local_Register 0x9D20 =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_SEC_TX_DEBUG));
-		rtw89_info(rtwdev, "SEC_local_Register 0x9D24 =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_SEC_RX_DEBUG));
-		rtw89_info(rtwdev, "SEC_local_Register 0x9D28 =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_SEC_TRX_PKT_CNT));
-		rtw89_info(rtwdev, "SEC_local_Register 0x9D2C =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_SEC_TRX_BLK_CNT));
+		if (chip->chip_id == RTL8852C) {
+			rtw89_info(rtwdev, "R_AX_SEC_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_ERROR_FLAG_IMR));
+			rtw89_info(rtwdev, "R_AX_SEC_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_ERROR_FLAG));
+			rtw89_info(rtwdev, "R_AX_SEC_ENG_CTRL=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL));
+			rtw89_info(rtwdev, "R_AX_SEC_MPDU_PROC=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_MPDU_PROC));
+			rtw89_info(rtwdev, "R_AX_SEC_CAM_ACCESS=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_CAM_ACCESS));
+			rtw89_info(rtwdev, "R_AX_SEC_CAM_RDATA=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_CAM_RDATA));
+			rtw89_info(rtwdev, "R_AX_SEC_DEBUG1=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_DEBUG1));
+			rtw89_info(rtwdev, "R_AX_SEC_TX_DEBUG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_TX_DEBUG));
+			rtw89_info(rtwdev, "R_AX_SEC_RX_DEBUG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_RX_DEBUG));
+
+			rtw89_write32_mask(rtwdev, R_AX_DBG_CTRL,
+					   B_AX_DBG_SEL0, 0x8B);
+			rtw89_write32_mask(rtwdev, R_AX_DBG_CTRL,
+					   B_AX_DBG_SEL1, 0x8B);
+			rtw89_write32_mask(rtwdev, R_AX_SYS_STATUS1,
+					   B_AX_SEL_0XC0_MASK, 1);
+			for (i = 0; i < 0x10; i++) {
+				rtw89_write32_mask(rtwdev, R_AX_SEC_ENG_CTRL,
+						   B_AX_SEC_DBG_PORT_FIELD_MASK, i);
+				rtw89_info(rtwdev, "sel=%x,R_AX_SEC_DEBUG2=0x%08x\n",
+					   i, rtw89_read32(rtwdev, R_AX_SEC_DEBUG2));
+			}
+		} else {
+			rtw89_info(rtwdev, "R_AX_SEC_ERR_IMR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_DEBUG));
+			rtw89_info(rtwdev, "R_AX_SEC_ENG_CTRL=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_ENG_CTRL));
+			rtw89_info(rtwdev, "R_AX_SEC_MPDU_PROC=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_MPDU_PROC));
+			rtw89_info(rtwdev, "R_AX_SEC_CAM_ACCESS=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_CAM_ACCESS));
+			rtw89_info(rtwdev, "R_AX_SEC_CAM_RDATA=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_CAM_RDATA));
+			rtw89_info(rtwdev, "R_AX_SEC_CAM_WDATA=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_CAM_WDATA));
+			rtw89_info(rtwdev, "R_AX_SEC_TX_DEBUG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_TX_DEBUG));
+			rtw89_info(rtwdev, "R_AX_SEC_RX_DEBUG=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_RX_DEBUG));
+			rtw89_info(rtwdev, "R_AX_SEC_TRX_PKT_CNT=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_TRX_PKT_CNT));
+			rtw89_info(rtwdev, "R_AX_SEC_TRX_BLK_CNT=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_SEC_TRX_BLK_CNT));
+		}
 	}
 
 	if (dmac_err & B_AX_MPDU_ERR_FLAG) {
-		rtw89_info(rtwdev, "R_AX_MPDU_TX_ERR_IMR =0x%08x ",
+		rtw89_info(rtwdev, "R_AX_MPDU_TX_ERR_IMR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_MPDU_TX_ERR_ISR =0x%08x\n",
+		rtw89_info(rtwdev, "R_AX_MPDU_TX_ERR_ISR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_MPDU_TX_ERR_ISR));
-		rtw89_info(rtwdev, "R_AX_MPDU_RX_ERR_IMR =0x%08x ",
+		rtw89_info(rtwdev, "R_AX_MPDU_RX_ERR_IMR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_MPDU_RX_ERR_ISR =0x%08x\n",
+		rtw89_info(rtwdev, "R_AX_MPDU_RX_ERR_ISR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_MPDU_RX_ERR_ISR));
 	}
 
 	if (dmac_err & B_AX_STA_SCHEDULER_ERR_FLAG) {
-		rtw89_info(rtwdev, "R_AX_STA_SCHEDULER_ERR_IMR =0x%08x ",
+		rtw89_info(rtwdev, "R_AX_STA_SCHEDULER_ERR_IMR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_STA_SCHEDULER_ERR_ISR= 0x%08x\n",
+		rtw89_info(rtwdev, "R_AX_STA_SCHEDULER_ERR_ISR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_STA_SCHEDULER_ERR_ISR));
 	}
 
 	if (dmac_err & B_AX_WDE_DLE_ERR_FLAG) {
-		rtw89_info(rtwdev, "R_AX_WDE_ERR_IMR=0x%08x ",
+		rtw89_info(rtwdev, "R_AX_WDE_ERR_IMR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_WDE_ERR_IMR));
 		rtw89_info(rtwdev, "R_AX_WDE_ERR_ISR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
-		rtw89_info(rtwdev, "R_AX_PLE_ERR_IMR=0x%08x ",
+		rtw89_info(rtwdev, "R_AX_PLE_ERR_IMR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_PLE_ERR_IMR));
 		rtw89_info(rtwdev, "R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
-		dump_err_status_dispatcher(rtwdev);
 	}
 
 	if (dmac_err & B_AX_TXPKTCTRL_ERR_FLAG) {
-		rtw89_info(rtwdev, "R_AX_TXPKTCTL_ERR_IMR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR));
-		rtw89_info(rtwdev, "R_AX_TXPKTCTL_ERR_IMR_ISR_B1=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR_B1));
+		if (chip->chip_id == RTL8852C) {
+			rtw89_info(rtwdev, "R_AX_TXPKTCTL_B0_ERRFLAG_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B0_ERRFLAG_IMR));
+			rtw89_info(rtwdev, "R_AX_TXPKTCTL_B0_ERRFLAG_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B0_ERRFLAG_ISR));
+			rtw89_info(rtwdev, "R_AX_TXPKTCTL_B1_ERRFLAG_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B1_ERRFLAG_IMR));
+			rtw89_info(rtwdev, "R_AX_TXPKTCTL_B1_ERRFLAG_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_B1_ERRFLAG_ISR));
+		} else {
+			rtw89_info(rtwdev, "R_AX_TXPKTCTL_ERR_IMR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR));
+			rtw89_info(rtwdev, "R_AX_TXPKTCTL_ERR_IMR_ISR_B1=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_TXPKTCTL_ERR_IMR_ISR_B1));
+		}
 	}
 
 	if (dmac_err & B_AX_PLE_DLE_ERR_FLAG) {
-		rtw89_info(rtwdev, "R_AX_WDE_ERR_IMR=0x%08x ",
+		rtw89_info(rtwdev, "R_AX_WDE_ERR_IMR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_WDE_ERR_IMR));
 		rtw89_info(rtwdev, "R_AX_WDE_ERR_ISR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_WDE_ERR_ISR));
-		rtw89_info(rtwdev, "R_AX_PLE_ERR_IMR=0x%08x ",
+		rtw89_info(rtwdev, "R_AX_PLE_ERR_IMR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_PLE_ERR_IMR));
 		rtw89_info(rtwdev, "R_AX_PLE_ERR_FLAG_ISR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_PLE_ERR_FLAG_ISR));
@@ -393,86 +451,190 @@ static void rtw89_mac_dump_err_status(struct rtw89_dev *rtwdev,
 			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_2));
 		rtw89_info(rtwdev, "R_AX_PL_CPUQ_OP_STATUS=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_PL_CPUQ_OP_STATUS));
-		rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_0=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_0));
-		rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_1=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_1));
-		rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_2=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_2));
-		dump_err_status_dispatcher(rtwdev);
+		if (chip->chip_id == RTL8852C) {
+			rtw89_info(rtwdev, "R_AX_RX_CTRL0=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RX_CTRL0));
+			rtw89_info(rtwdev, "R_AX_RX_CTRL1=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RX_CTRL1));
+			rtw89_info(rtwdev, "R_AX_RX_CTRL2=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RX_CTRL2));
+		} else {
+			rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_0=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_0));
+			rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_1=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_1));
+			rtw89_info(rtwdev, "R_AX_RXDMA_PKT_INFO_2=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_RXDMA_PKT_INFO_2));
+		}
 	}
 
 	if (dmac_err & B_AX_PKTIN_ERR_FLAG) {
-		rtw89_info(rtwdev, "R_AX_PKTIN_ERR_IMR =0x%08x ",
-			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_PKTIN_ERR_ISR =0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_ISR));
-		rtw89_info(rtwdev, "R_AX_PKTIN_ERR_IMR =0x%08x ",
+		rtw89_info(rtwdev, "R_AX_PKTIN_ERR_IMR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_PKTIN_ERR_ISR =0x%08x\n",
+		rtw89_info(rtwdev, "R_AX_PKTIN_ERR_ISR=0x%08x\n",
 			   rtw89_read32(rtwdev, R_AX_PKTIN_ERR_ISR));
 	}
 
-	if (dmac_err & B_AX_DISPATCH_ERR_FLAG)
-		dump_err_status_dispatcher(rtwdev);
+	if (dmac_err & B_AX_DISPATCH_ERR_FLAG) {
+		rtw89_info(rtwdev, "R_AX_HOST_DISPATCHER_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_IMR));
+		rtw89_info(rtwdev, "R_AX_HOST_DISPATCHER_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_HOST_DISPATCHER_ERR_ISR));
+		rtw89_info(rtwdev, "R_AX_CPU_DISPATCHER_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_IMR));
+		rtw89_info(rtwdev, "R_AX_CPU_DISPATCHER_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_CPU_DISPATCHER_ERR_ISR));
+		rtw89_info(rtwdev, "R_AX_OTHER_DISPATCHER_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_IMR));
+		rtw89_info(rtwdev, "R_AX_OTHER_DISPATCHER_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_OTHER_DISPATCHER_ERR_ISR));
+	}
+
+	if (dmac_err & B_AX_BBRPT_ERR_FLAG) {
+		if (chip->chip_id == RTL8852C) {
+			rtw89_info(rtwdev, "R_AX_BBRPT_COM_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR));
+			rtw89_info(rtwdev, "R_AX_BBRPT_COM_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_ISR));
+			rtw89_info(rtwdev, "R_AX_BBRPT_CHINFO_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_ISR));
+			rtw89_info(rtwdev, "R_AX_BBRPT_CHINFO_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_IMR));
+			rtw89_info(rtwdev, "R_AX_BBRPT_DFS_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_IMR));
+			rtw89_info(rtwdev, "R_AX_BBRPT_DFS_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_ISR));
+		} else {
+			rtw89_info(rtwdev, "R_AX_BBRPT_COM_ERR_IMR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR_ISR));
+			rtw89_info(rtwdev, "R_AX_BBRPT_CHINFO_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_ISR));
+			rtw89_info(rtwdev, "R_AX_BBRPT_CHINFO_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_CHINFO_ERR_IMR));
+			rtw89_info(rtwdev, "R_AX_BBRPT_DFS_ERR_IMR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_IMR));
+			rtw89_info(rtwdev, "R_AX_BBRPT_DFS_ERR_ISR=0x%08x\n",
+				   rtw89_read32(rtwdev, R_AX_BBRPT_DFS_ERR_ISR));
+		}
+	}
 
-	if (dmac_err & B_AX_DLE_CPUIO_ERR_FLAG) {
-		rtw89_info(rtwdev, "R_AX_CPUIO_ERR_IMR=0x%08x ",
-			   rtw89_read32(rtwdev, R_AX_CPUIO_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_CPUIO_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_CPUIO_ERR_ISR));
+	if (dmac_err & B_AX_HAXIDMA_ERR_FLAG && chip->chip_id == RTL8852C) {
+		rtw89_info(rtwdev, "R_AX_HAXIDMA_ERR_IMR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_HAXI_IDCT_MSK));
+		rtw89_info(rtwdev, "R_AX_HAXIDMA_ERR_ISR=0x%08x\n",
+			   rtw89_read32(rtwdev, R_AX_HAXI_IDCT));
 	}
+}
 
-	if (dmac_err & BIT(11)) {
-		rtw89_info(rtwdev, "R_AX_BBRPT_COM_ERR_IMR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_BBRPT_COM_ERR_IMR_ISR));
+static void rtw89_mac_dump_cmac_err_status(struct rtw89_dev *rtwdev,
+					   u8 band)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 offset = 0;
+	u32 cmac_err;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, band, RTW89_CMAC_SEL);
+	if (ret) {
+		if (band)
+			rtw89_warn(rtwdev, "[CMAC] : CMAC1 not enabled\n");
+		else
+			rtw89_warn(rtwdev, "[CMAC] : CMAC0 not enabled\n");
+		return;
 	}
 
+	if (band)
+		offset = RTW89_MAC_AX_BAND_REG_OFFSET;
+
+	cmac_err = rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR + offset);
+	rtw89_info(rtwdev, "R_AX_CMAC_ERR_ISR [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_AX_CMAC_ERR_ISR + offset));
+	rtw89_info(rtwdev, "R_AX_CMAC_FUNC_EN [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_AX_CMAC_FUNC_EN + offset));
+	rtw89_info(rtwdev, "R_AX_CK_EN [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_AX_CK_EN + offset));
+
 	if (cmac_err & B_AX_SCHEDULE_TOP_ERR_IND) {
-		rtw89_info(rtwdev, "R_AX_SCHEDULE_ERR_IMR=0x%08x ",
-			   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_IMR));
-		rtw89_info(rtwdev, "R_AX_SCHEDULE_ERR_ISR=0x%04x\n",
-			   rtw89_read16(rtwdev, R_AX_SCHEDULE_ERR_ISR));
+		rtw89_info(rtwdev, "R_AX_SCHEDULE_ERR_IMR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_IMR + offset));
+		rtw89_info(rtwdev, "R_AX_SCHEDULE_ERR_ISR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_SCHEDULE_ERR_ISR + offset));
 	}
 
 	if (cmac_err & B_AX_PTCL_TOP_ERR_IND) {
-		rtw89_info(rtwdev, "R_AX_PTCL_IMR0=0x%08x ",
-			   rtw89_read32(rtwdev, R_AX_PTCL_IMR0));
-		rtw89_info(rtwdev, "R_AX_PTCL_ISR0=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PTCL_ISR0));
+		rtw89_info(rtwdev, "R_AX_PTCL_IMR0 [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_PTCL_IMR0 + offset));
+		rtw89_info(rtwdev, "R_AX_PTCL_ISR0 [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_PTCL_ISR0 + offset));
 	}
 
 	if (cmac_err & B_AX_DMA_TOP_ERR_IND) {
-		rtw89_info(rtwdev, "R_AX_DLE_CTRL=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_DLE_CTRL));
+		if (chip->chip_id == RTL8852C) {
+			rtw89_info(rtwdev, "R_AX_RX_ERR_FLAG [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_RX_ERR_FLAG + offset));
+			rtw89_info(rtwdev, "R_AX_RX_ERR_FLAG_IMR [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_RX_ERR_FLAG_IMR + offset));
+		} else {
+			rtw89_info(rtwdev, "R_AX_DLE_CTRL [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_DLE_CTRL + offset));
+		}
 	}
 
-	if (cmac_err & B_AX_PHYINTF_ERR_IND) {
-		rtw89_info(rtwdev, "R_AX_PHYINFO_ERR_IMR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_IMR));
+	if (cmac_err & B_AX_DMA_TOP_ERR_IND || cmac_err & B_AX_WMAC_RX_ERR_IND) {
+		if (chip->chip_id == RTL8852C) {
+			rtw89_info(rtwdev, "R_AX_PHYINFO_ERR_ISR [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_ISR + offset));
+			rtw89_info(rtwdev, "R_AX_PHYINFO_ERR_IMR [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_IMR + offset));
+		} else {
+			rtw89_info(rtwdev, "R_AX_PHYINFO_ERR_IMR [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_IMR + offset));
+		}
 	}
 
 	if (cmac_err & B_AX_TXPWR_CTRL_ERR_IND) {
-		rtw89_info(rtwdev, "R_AX_TXPWR_IMR=0x%08x ",
-			   rtw89_read32(rtwdev, R_AX_TXPWR_IMR));
-		rtw89_info(rtwdev, "R_AX_TXPWR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_TXPWR_ISR));
-	}
-
-	if (cmac_err & B_AX_WMAC_RX_ERR_IND) {
-		rtw89_info(rtwdev, "R_AX_DBGSEL_TRXPTCL=0x%08x ",
-			   rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL));
-		rtw89_info(rtwdev, "R_AX_PHYINFO_ERR_ISR=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_PHYINFO_ERR_ISR));
+		rtw89_info(rtwdev, "R_AX_TXPWR_IMR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_TXPWR_IMR + offset));
+		rtw89_info(rtwdev, "R_AX_TXPWR_ISR [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_TXPWR_ISR + offset));
 	}
 
 	if (cmac_err & B_AX_WMAC_TX_ERR_IND) {
-		rtw89_info(rtwdev, "R_AX_TMAC_ERR_IMR_ISR=0x%08x ",
-			   rtw89_read32(rtwdev, R_AX_TMAC_ERR_IMR_ISR));
-		rtw89_info(rtwdev, "R_AX_DBGSEL_TRXPTCL=0x%08x\n",
-			   rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL));
+		if (chip->chip_id == RTL8852C) {
+			rtw89_info(rtwdev, "R_AX_TRXPTCL_ERROR_INDICA [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_TRXPTCL_ERROR_INDICA + offset));
+			rtw89_info(rtwdev, "R_AX_TRXPTCL_ERROR_INDICA_MASK [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_TRXPTCL_ERROR_INDICA_MASK + offset));
+		} else {
+			rtw89_info(rtwdev, "R_AX_TMAC_ERR_IMR_ISR [%d]=0x%08x\n", band,
+				   rtw89_read32(rtwdev, R_AX_TMAC_ERR_IMR_ISR + offset));
+		}
+		rtw89_info(rtwdev, "R_AX_DBGSEL_TRXPTCL [%d]=0x%08x\n", band,
+			   rtw89_read32(rtwdev, R_AX_DBGSEL_TRXPTCL + offset));
 	}
 
+	rtw89_info(rtwdev, "R_AX_CMAC_ERR_IMR [%d]=0x%08x\n", band,
+		   rtw89_read32(rtwdev, R_AX_CMAC_ERR_IMR + offset));
+}
+
+static void rtw89_mac_dump_err_status(struct rtw89_dev *rtwdev,
+				      enum mac_ax_err_info err)
+{
+	if (err != MAC_AX_ERR_L1_ERR_DMAC &&
+	    err != MAC_AX_ERR_L0_PROMOTE_TO_L1 &&
+	    err != MAC_AX_ERR_L0_ERR_CMAC0 &&
+	    err != MAC_AX_ERR_L0_ERR_CMAC1)
+		return;
+
+	rtw89_info(rtwdev, "--->\nerr=0x%x\n", err);
+	rtw89_info(rtwdev, "R_AX_SER_DBG_INFO =0x%08x\n",
+		   rtw89_read32(rtwdev, R_AX_SER_DBG_INFO));
+
+	rtw89_mac_dump_dmac_err_status(rtwdev);
+	rtw89_mac_dump_cmac_err_status(rtwdev, RTW89_MAC_0);
+	if (rtwdev->dbcc_en)
+		rtw89_mac_dump_cmac_err_status(rtwdev, RTW89_MAC_1);
+
 	rtwdev->hci.ops->dump_err_status(rtwdev);
 
 	if (err == MAC_AX_ERR_L0_PROMOTE_TO_L1)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 46d9cad2b5ec8..045e8ec61a41e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -440,6 +440,7 @@ enum rtw89_mac_bf_rrsc_rate {
 #define ACCESS_CMAC(_addr) \
 	({typeof(_addr) __addr = (_addr); \
 	  __addr >= R_AX_CMAC_REG_START && __addr <= R_AX_CMAC_REG_END; })
+#define RTW89_MAC_AX_BAND_REG_OFFSET 0x2000
 
 #define PTCL_IDLE_POLL_CNT	10000
 #define SW_CVR_DUR_US	8
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 179740607778a..7d033501d4d95 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -202,6 +202,18 @@
 #define B_AX_RXP1DMA_INT		BIT(1)
 #define B_AX_RXDMA_INT			BIT(0)
 
+#define R_AX_HAXI_IDCT_MSK 0x10B8
+#define B_AX_TXBD_LEN0_ERR_IDCT_MSK BIT(3)
+#define B_AX_TXBD_4KBOUND_ERR_IDCT_MSK BIT(2)
+#define B_AX_RXMDA_STUCK_IDCT_MSK BIT(1)
+#define B_AX_TXMDA_STUCK_IDCT_MSK BIT(0)
+
+#define R_AX_HAXI_IDCT 0x10BC
+#define B_AX_TXBD_LEN0_ERR_IDCT BIT(3)
+#define B_AX_TXBD_4KBOUND_ERR_IDCT BIT(2)
+#define B_AX_RXMDA_STUCK_IDCT BIT(1)
+#define B_AX_TXMDA_STUCK_IDCT BIT(0)
+
 #define R_AX_HAXI_HIMR10 0x11E0
 #define B_AX_TXDMA_CH11_INT_EN_V1 BIT(1)
 #define B_AX_TXDMA_CH10_INT_EN_V1 BIT(0)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 8a1cb8f4aa16c..dbe06542f443f 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -326,8 +326,7 @@
 
 #define R_AX_PCIE_DBG_CTRL 0x11C0
 #define B_AX_DBG_DUMMY_MASK GENMASK(23, 16)
-#define B_AX_DBG_SEL_MASK GENMASK(15, 13)
-#define B_AX_PCIE_DBG_SEL BIT(12)
+#define B_AX_PCIE_DBG_SEL_MASK GENMASK(15, 13)
 #define B_AX_MRD_TIMEOUT_EN BIT(10)
 #define B_AX_ASFF_FULL_NO_STK BIT(1)
 #define B_AX_EN_STUCK_DBG BIT(0)
@@ -574,6 +573,10 @@
 #define DMAC_ERR_IMR_DIS 0
 
 #define R_AX_DMAC_ERR_ISR 0x8524
+#define B_AX_HAXIDMA_ERR_FLAG BIT(14)
+#define B_AX_PAXIDMA_ERR_FLAG BIT(13)
+#define B_AX_HCI_BUF_ERR_FLAG BIT(12)
+#define B_AX_BBRPT_ERR_FLAG BIT(11)
 #define B_AX_DLE_CPUIO_ERR_FLAG BIT(10)
 #define B_AX_APB_BRIDGE_ERR_FLAG BIT(9)
 #define B_AX_DISPATCH_ERR_FLAG BIT(8)
@@ -1041,7 +1044,13 @@
 #define R_AX_WDE_ERRFLAG_MSG 0x8C30
 #define B_AX_WDE_ERR_FLAG_MSG_MASK GENMASK(31, 0)
 
-#define R_AX_WDE_ERR_FLAG_CFG 0x8C34
+#define R_AX_WDE_ERR_FLAG_CFG_NUM1 0x8C34
+#define B_AX_WDE_ERR_FLAG_NUM1_VLD BIT(31)
+#define B_AX_WDE_ERR_FLAG_NUM1_MSTIDX_MASK GENMASK(27, 24)
+#define B_AX_WDE_ERR_FLAG_NUM1_ISRIDX_MASK GENMASK(20, 16)
+#define B_AX_WDE_DATCHN_FRZTMR_MODE BIT(2)
+#define B_AX_WDE_QUEMGN_FRZTMR_MODE BIT(1)
+#define B_AX_WDE_BUFMGN_FRZTMR_MODE BIT(0)
 
 #define R_AX_WDE_ERR_IMR 0x8C38
 #define B_AX_WDE_DATCHN_RRDY_ERR_INT_EN BIT(27)
@@ -1225,7 +1234,59 @@
 #define B_AX_PLE_START_BOUND_MASK GENMASK(13, 8)
 #define B_AX_PLE_PAGE_SEL_MASK GENMASK(1, 0)
 #define B_AX_PLE_FREE_PAGE_NUM_MASK GENMASK(28, 16)
-#define R_AX_PLE_ERR_FLAG_CFG 0x9034
+
+#define R_AX_PLE_DBGERR_LOCKEN 0x9020
+#define B_AX_PLE_LOCKEN_DLEPIF07 BIT(7)
+#define B_AX_PLE_LOCKEN_DLEPIF06 BIT(6)
+#define B_AX_PLE_LOCKEN_DLEPIF05 BIT(5)
+#define B_AX_PLE_LOCKEN_DLEPIF04 BIT(4)
+#define B_AX_PLE_LOCKEN_DLEPIF03 BIT(3)
+#define B_AX_PLE_LOCKEN_DLEPIF02 BIT(2)
+#define B_AX_PLE_LOCKEN_DLEPIF01 BIT(1)
+#define B_AX_PLE_LOCKEN_DLEPIF00 BIT(0)
+
+#define R_AX_PLE_DBGERR_STS 0x9024
+#define B_AX_PLE_LOCKON_DLEPIF07 BIT(7)
+#define B_AX_PLE_LOCKON_DLEPIF06 BIT(6)
+#define B_AX_PLE_LOCKON_DLEPIF05 BIT(5)
+#define B_AX_PLE_LOCKON_DLEPIF04 BIT(4)
+#define B_AX_PLE_LOCKON_DLEPIF03 BIT(3)
+#define B_AX_PLE_LOCKON_DLEPIF02 BIT(2)
+#define B_AX_PLE_LOCKON_DLEPIF01 BIT(1)
+#define B_AX_PLE_LOCKON_DLEPIF00 BIT(0)
+
+#define R_AX_PLE_ERR_FLAG_CFG_NUM1 0x9034
+#define B_AX_PLE_ERR_FLAG_NUM1_VLD BIT(31)
+#define B_AX_PLE_ERR_FLAG_NUM1_MSTIDX_MASK GENMASK(27, 24)
+#define B_AX_PLE_ERR_FLAG_NUM1_ISRIDX_MASK GENMASK(20, 16)
+#define B_AX_PLE_DATCHN_FRZTMR_MODE BIT(2)
+#define B_AX_PLE_QUEMGN_FRZTMR_MODE BIT(1)
+#define B_AX_PLE_BUFMGN_FRZTMR_MODE BIT(0)
+
+#define R_AX_PLE_ERRFLAG_MSG 0x9030
+#define B_AX_PLE_ERR_FLAG_MSG_MASK GENMASK(31, 0)
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
+#define B_AX_PLE_DATCHN_CAMREQ_ERR BIT(29)
+#define B_AX_PLE_DATCHN_ADRERR_ERR BIT(28)
+#define B_AX_PLE_BUFMGN_FRZTO_ERR_V1 BIT(9)
+#define B_AX_PLE_GETNPG_PGOFST_ERR_V1 BIT(8)
+#define B_AX_PLE_GETNPG_STRPG_ERR_V1 BIT(7)
+#define B_AX_PLE_BUFREQ_SRCHTAILPG_ERR_V1 BIT(6)
+#define B_AX_PLE_BUFRTN_SIZE_ERR_V1 BIT(5)
+#define B_AX_PLE_BUFRTN_INVLD_PKTID_ERR_V1 BIT(4)
+#define B_AX_PLE_BUFREQ_UNAVAL_ERR_V1 BIT(3)
+#define B_AX_PLE_BUFREQ_SIZELMT_ERR BIT(2)
+#define B_AX_PLE_BUFREQ_SIZE0_ERR BIT(1)
 
 #define R_AX_PLE_ERR_IMR 0x9038
 #define B_AX_PLE_DATCHN_RRDY_ERR_INT_EN BIT(27)
@@ -1436,6 +1497,19 @@
 #define B_AX_BBRPT_COM_NULL_PLPKTID_ERR BIT(16)
 #define B_AX_BBRPT_COM_NULL_PLPKTID_ERR_INT_EN BIT(0)
 
+#define R_AX_BBRPT_COM_ERR_ISR 0x960C
+#define B_AX_BBRPT_COM_NULL_PLPKTID_ERR_INT_V1 BIT(0)
+
+#define R_AX_BBRPT_CHINFO_ERR_ISR 0x962C
+#define B_AX_BBPRT_CHIF_TO_ERR_V1 BIT(7)
+#define B_AX_BBPRT_CHIF_NULL_ERR_V1 BIT(6)
+#define B_AX_BBPRT_CHIF_LEFT2_ERR_V1 BIT(5)
+#define B_AX_BBPRT_CHIF_LEFT1_ERR_V1 BIT(4)
+#define B_AX_BBPRT_CHIF_HDRL_ERR_V1 BIT(3)
+#define B_AX_BBPRT_CHIF_BOVF_ERR_V1 BIT(2)
+#define B_AX_BBPRT_CHIF_OVF_ERR_V1 BIT(1)
+#define B_AX_BBPRT_CHIF_BB_TO_ERR_V1 BIT(0)
+
 #define R_AX_BBRPT_CHINFO_ERR_IMR 0x9628
 #define B_AX_BBPRT_CHIF_TO_ERR_INT_EN BIT(7)
 #define B_AX_BBPRT_CHIF_NULL_ERR_INT_EN BIT(6)
@@ -1487,6 +1561,9 @@
 #define B_AX_BBRPT_DFS_TO_ERR BIT(16)
 #define B_AX_BBRPT_DFS_TO_ERR_INT_EN BIT(0)
 
+#define R_AX_BBRPT_DFS_ERR_ISR 0x963C
+#define B_AX_BBRPT_DFS_TO_ERR_V1 BIT(0)
+
 #define R_AX_LA_ERRFLAG 0x966C
 #define B_AX_LA_ISR_DATA_LOSS_ERR BIT(16)
 #define B_AX_LA_IMR_DATA_LOSS_ERR BIT(0)
@@ -1602,6 +1679,7 @@
 #define B_AX_MPDU_RX_IMR_SET_V1 B_AX_RPT_ERR_INT_EN
 
 #define R_AX_SEC_ENG_CTRL 0x9D00
+#define B_AX_SEC_DBG_PORT_FIELD_MASK GENMASK(19, 16)
 #define B_AX_TX_PARTIAL_MODE BIT(11)
 #define B_AX_CLK_EN_CGCMP BIT(10)
 #define B_AX_CLK_EN_WAPI BIT(9)
@@ -1631,12 +1709,21 @@
 #define R_AX_SEC_TX_DEBUG 0x9D20
 #define R_AX_SEC_RX_DEBUG 0x9D24
 #define R_AX_SEC_TRX_PKT_CNT 0x9D28
+
+#define R_AX_SEC_DEBUG2 0x9D28
+#define B_AX_DBG_READ_SH 2
+#define B_AX_DBG_READ_MSK 0x3fffffff
+
 #define R_AX_SEC_TRX_BLK_CNT 0x9D2C
 
 #define R_AX_SEC_ERROR_FLAG_IMR 0x9D2C
 #define B_AX_RX_HANG_IMR BIT(1)
 #define B_AX_TX_HANG_IMR BIT(0)
 
+#define R_AX_SEC_ERROR_FLAG 0x9D30
+#define B_AX_RX_HANG_ERROR_V1 BIT(1)
+#define B_AX_TX_HANG_ERROR_V1 BIT(0)
+
 #define R_AX_SS_CTRL 0x9E10
 #define B_AX_SS_INIT_DONE_1 BIT(31)
 #define B_AX_SS_WARM_INIT_FLG BIT(29)
@@ -1771,6 +1858,28 @@
 				     B_AX_B0_IMR_ERR_PRELD_RLSPKTSZERR | \
 				     B_AX_B0_IMR_ERR_PRELD_ENTNUMCFG)
 
+#define R_AX_TXPKTCTL_B0_ERRFLAG_ISR 0x9F7C
+#define B_AX_B0_ISR_ERR_PRELD_EVT3 BIT(23)
+#define B_AX_B0_ISR_ERR_PRELD_EVT2 BIT(22)
+#define B_AX_B0_ISR_ERR_PRELD_ENTNUMCFG BIT(21)
+#define B_AX_B0_ISR_ERR_PRELD_RLSPKTSZERR BIT(20)
+#define B_AX_B0_ISR_ERR_MPDUIF_ERR1 BIT(19)
+#define B_AX_B0_ISR_ERR_MPDUIF_DATAERR BIT(18)
+#define B_AX_B0_ISR_ERR_MPDUINFO_ERR1 BIT(17)
+#define B_AX_B0_ISR_ERR_MPDUINFO_RECFG BIT(16)
+#define B_AX_B0_ISR_ERR_CMDPSR_TBLSZ BIT(11)
+#define B_AX_B0_ISR_ERR_CMDPSR_FRZTO BIT(10)
+#define B_AX_B0_ISR_ERR_CMDPSR_CMDTYPE BIT(9)
+#define B_AX_B0_ISR_ERR_CMDPSR_1STCMDERR BIT(8)
+#define B_AX_B0_ISR_ERR_USRCTL_EVT7 BIT(7)
+#define B_AX_B0_ISR_ERR_USRCTL_EVT6 BIT(6)
+#define B_AX_B0_ISR_ERR_USRCTL_EVT5 BIT(5)
+#define B_AX_B0_ISR_ERR_USRCTL_EVT4 BIT(4)
+#define B_AX_B0_ISR_ERR_USRCTL_RLSBMPLEN BIT(3)
+#define B_AX_B0_ISR_ERR_USRCTL_RDNRLSCMD BIT(2)
+#define B_AX_B0_ISR_ERR_USRCTL_NOINIT BIT(1)
+#define B_AX_B0_ISR_ERR_USRCTL_REINIT BIT(0)
+
 #define R_AX_TXPKTCTL_B1_PRELD_CFG0 0x9F88
 #define B_AX_B1_PRELD_FEN BIT(31)
 #define B_AX_B1_PRELD_USEMAXSZ_MASK GENMASK(25, 16)
@@ -1818,6 +1927,28 @@
 				     B_AX_B1_IMR_ERR_PRELD_RLSPKTSZERR | \
 				     B_AX_B1_IMR_ERR_PRELD_ENTNUMCFG)
 
+#define R_AX_TXPKTCTL_B1_ERRFLAG_ISR 0x9FBC
+#define B_AX_B1_ISR_ERR_PRELD_EVT3 BIT(23)
+#define B_AX_B1_ISR_ERR_PRELD_EVT2 BIT(22)
+#define B_AX_B1_ISR_ERR_PRELD_ENTNUMCFG BIT(21)
+#define B_AX_B1_ISR_ERR_PRELD_RLSPKTSZERR BIT(20)
+#define B_AX_B1_ISR_ERR_MPDUIF_ERR1 BIT(19)
+#define B_AX_B1_ISR_ERR_MPDUIF_DATAERR BIT(18)
+#define B_AX_B1_ISR_ERR_MPDUINFO_ERR1 BIT(17)
+#define B_AX_B1_ISR_ERR_MPDUINFO_RECFG BIT(16)
+#define B_AX_B1_ISR_ERR_CMDPSR_TBLSZ BIT(11)
+#define B_AX_B1_ISR_ERR_CMDPSR_FRZTO BIT(10)
+#define B_AX_B1_ISR_ERR_CMDPSR_CMDTYPE BIT(9)
+#define B_AX_B1_ISR_ERR_CMDPSR_1STCMDERR BIT(8)
+#define B_AX_B1_ISR_ERR_USRCTL_EVT7 BIT(7)
+#define B_AX_B1_ISR_ERR_USRCTL_EVT6 BIT(6)
+#define B_AX_B1_ISR_ERR_USRCTL_EVT5 BIT(5)
+#define B_AX_B1_ISR_ERR_USRCTL_EVT4 BIT(4)
+#define B_AX_B1_ISR_ERR_USRCTL_RLSBMPLEN BIT(3)
+#define B_AX_B1_ISR_ERR_USRCTL_RDNRLSCMD BIT(2)
+#define B_AX_B1_ISR_ERR_USRCTL_NOINIT BIT(1)
+#define B_AX_B1_ISR_ERR_USRCTL_REINIT BIT(0)
+
 #define R_AX_AFE_CTRL1 0x0024
 
 #define B_AX_R_SYM_WLCMAC1_P4_PC_EN BIT(4)
@@ -2386,6 +2517,41 @@
 #define B_AX_DLE_IMR_SET (B_AX_RXSTS_FSM_HANG_ERROR_IMR | \
 			  B_AX_RXDATA_FSM_HANG_ERROR_IMR)
 
+#define R_AX_RX_ERR_FLAG 0xC800
+#define R_AX_RX_ERR_FLAG_C1 0xE800
+#define B_AX_RX_GET_NO_PAGE_ERR BIT(31)
+#define B_AX_RX_GET_NULL_PKT_ERR BIT(30)
+#define B_AX_RX_RU0_FSM_HANG_ERR BIT(29)
+#define B_AX_RX_RU1_FSM_HANG_ERR BIT(28)
+#define B_AX_RX_RU2_FSM_HANG_ERR BIT(27)
+#define B_AX_RX_RU3_FSM_HANG_ERR BIT(26)
+#define B_AX_RX_RU4_FSM_HANG_ERR BIT(25)
+#define B_AX_RX_RU5_FSM_HANG_ERR BIT(24)
+#define B_AX_RX_RU6_FSM_HANG_ERR BIT(23)
+#define B_AX_RX_RU7_FSM_HANG_ERR BIT(22)
+#define B_AX_RX_RXSTS_FSM_HANG_ERR BIT(21)
+#define B_AX_RX_CSI_FSM_HANG_ERR BIT(20)
+#define B_AX_RX_TXRPT_FSM_HANG_ERR BIT(19)
+#define B_AX_RX_F2PCMD_FSM_HANG_ERR BIT(18)
+#define B_AX_RX_RU0_ZERO_LEN_ERR BIT(17)
+#define B_AX_RX_RU1_ZERO_LEN_ERR BIT(16)
+#define B_AX_RX_RU2_ZERO_LEN_ERR BIT(15)
+#define B_AX_RX_RU3_ZERO_LEN_ERR BIT(14)
+#define B_AX_RX_RU4_ZERO_LEN_ERR BIT(13)
+#define B_AX_RX_RU5_ZERO_LEN_ERR BIT(12)
+#define B_AX_RX_RU6_ZERO_LEN_ERR BIT(11)
+#define B_AX_RX_RU7_ZERO_LEN_ERR BIT(10)
+#define B_AX_RX_RXSTS_ZERO_LEN_ERR BIT(9)
+#define B_AX_RX_CSI_ZERO_LEN_ERR BIT(8)
+#define B_AX_PLE_DATA_OPT_FSM_HANG BIT(7)
+#define B_AX_PLE_RXDATA_REQ_BUF_FSM_HANG BIT(6)
+#define B_AX_PLE_TXRPT_REQ_BUF_FSM_HANG BIT(5)
+#define B_AX_PLE_WD_OPT_FSM_HANG BIT(4)
+#define B_AX_PLE_ENQ_FSM_HANG BIT(3)
+#define B_AX_RXDATA_ENQUE_ORDER_ERR BIT(2)
+#define B_AX_RXSTS_ENQUE_ORDER_ERR BIT(1)
+#define B_AX_RX_CSI_PKT_NUM_ERR BIT(0)
+
 #define R_AX_RXDMA_CTRL_0 0xC804
 #define R_AX_RXDMA_CTRL_0_C1 0xE804
 #define B_AX_RXDMA_DBGOUT_EN BIT(31)
@@ -2408,6 +2574,49 @@
 		      B_AX_RU2_PTR_FULL_MODE | B_AX_RU3_PTR_FULL_MODE | \
 		      B_AX_CSI_PTR_FULL_MODE | B_AX_RXSTS_PTR_FULL_MODE)
 
+#define R_AX_RX_CTRL0 0xC808
+#define R_AX_RX_CTRL0_C1 0xE808
+#define B_AX_DLE_CLOCK_FORCE_V1 BIT(31)
+#define B_AX_TXDMA_CLOCK_FORCE_V1 BIT(30)
+#define B_AX_RXDMA_CLOCK_FORCE_V1 BIT(29)
+#define B_AX_RXDMA_DEFAULT_PAGE_V1_MASK GENMASK(28, 24)
+#define B_AX_RXDMA_CSI_TGT_QUEID_MASK GENMASK(23, 18)
+#define B_AX_RXDMA_CSI_TGT_PRID_MASK GENMASK(17, 15)
+#define B_AX_RXDMA_DIS_CSI_RELEASE_V1 BIT(14)
+#define B_AX_CSI_PTR_FULL_MODE_V1 BIT(13)
+#define B_AX_RXDATA_PTR_FULL_MODE BIT(12)
+#define B_AX_RXSTS_PTR_FULL_MODE_V1 BIT(11)
+#define B_AX_TXRPT_FULL_RSV_DEPTH_V1_MASK GENMASK(10, 8)
+#define B_AX_RXDATA_FULL_RSV_DEPTH_MASK GENMASK(7, 5)
+#define B_AX_RXSTS_FULL_RSV_DEPTH_V1_MASK GENMASK(4, 2)
+#define B_AX_ORDER_FIFO_MASK GENMASK(1, 0)
+
+#define R_AX_RX_CTRL1 0xC80C
+#define R_AX_RX_CTRL1_C1 0xE80C
+#define B_AX_RXDMA_TXRPT_QUEUE_ID_SW_EN BIT(31)
+#define B_AX_RXDMA_TXRPT_QUEUE_ID_SW_V1_MASK GENMASK(30, 25)
+#define B_AX_RXDMA_F2PCMD_QUEUE_ID_SW_EN BIT(24)
+#define B_AX_RXDMA_F2PCMD_QUEUE_ID_SW_V1_MASK GENMASK(23, 18)
+#define B_AX_RXDMA_TXRPT_QUEUE_ID_TGT_SW_EN BIT(17)
+#define B_AX_RXDMA_TXRPT_QUEUE_ID_TGT_SW_1_MASK GENMASK(16, 11)
+#define B_AX_RXDMA_F2PCMD_QUEUE_ID_TGT_SW_EN BIT(10)
+#define B_AX_RXDMA_F2PCMD_QUEUE_ID_TGT_SW_1_MASK GENMASK(9, 4)
+#define B_AX_ORDER_FIFO_OUT BIT(3)
+#define B_AX_ORDER_FIFO_EMPTY BIT(2)
+#define B_AX_DBG_SEL_MASK GENMASK(1, 0)
+
+#define R_AX_RX_CTRL2 0xC810
+#define R_AX_RX_CTRL2_C1 0xE810
+#define B_AX_DLE_WDE_STATE_V1_MASK GENMASK(31, 30)
+#define B_AX_DLE_PLE_STATE_V1_MASK GENMASK(29, 28)
+#define B_AX_DLE_REQ_BUF_STATE_MASK GENMASK(27, 26)
+#define B_AX_DLE_ENQ_STATE_V1 BIT(25)
+#define B_AX_RX_DBG_SEL_MASK GENMASK(24, 19)
+#define B_AX_MACRX_CS_MASK GENMASK(18, 14)
+#define B_AX_RXSTS_CS_MASK GENMASK(13, 9)
+#define B_AX_ERR_INDICATOR BIT(5)
+#define B_AX_TXRPT_CS_MASK GENMASK(4, 0)
+
 #define R_AX_RXDMA_PKT_INFO_0 0xC814
 #define R_AX_RXDMA_PKT_INFO_1 0xC818
 #define R_AX_RXDMA_PKT_INFO_2 0xC81C
@@ -2715,6 +2924,18 @@
 			      B_AX_TMAC_MIMO_CTRL | \
 			      B_AX_RMAC_FTM)
 
+#define R_AX_TRXPTCL_ERROR_INDICA 0xCCC0
+#define R_AX_TRXPTCL_ERROR_INDICA_C1 0xECC0
+#define B_AX_FTM_ERROR_FLAG_CLR BIT(8)
+#define B_AX_CSI_ERROR_FLAG_CLR BIT(7)
+#define B_AX_MIMOCTRL_ERROR_FLAG_CLR BIT(6)
+#define B_AX_RXTB_ERROR_FLAG_CLR BIT(5)
+#define B_AX_HWSIGB_GEN_ERROR_FLAG_CLR BIT(4)
+#define B_AX_TXPLCP_ERROR_FLAG_CLR BIT(3)
+#define B_AX_RESP_ERROR_FLAG_CLR BIT(2)
+#define B_AX_TXCTL_ERROR_FLAG_CLR BIT(1)
+#define B_AX_MACTX_ERROR_FLAG_CLR BIT(0)
+
 #define R_AX_WMAC_TX_TF_INFO_0 0xCCD0
 #define R_AX_WMAC_TX_TF_INFO_0_C1 0xECD0
 #define B_AX_WMAC_TX_TF_INFO_SEL_MASK GENMASK(2, 0)
-- 
2.25.1

