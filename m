Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDE75BA57C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 05:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIPDjY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Sep 2022 23:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiIPDi7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Sep 2022 23:38:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19C7A9D66C
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 20:38:56 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28G3cRx05003828, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28G3cRx05003828
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 16 Sep 2022 11:38:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 16 Sep 2022 11:38:49 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 16 Sep
 2022 11:38:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw89: initialize DMA of CMAC
Date:   Fri, 16 Sep 2022 11:38:05 +0800
Message-ID: <20220916033811.13862-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916033811.13862-1-pkshih@realtek.com>
References: <20220916033811.13862-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/16/2022 02:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTUgpFWkyCAxMDo1NzowMA==?=
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

8852C needs this to change CMAC dma to full mode to keep receiving
packets after RX full event being resolved.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 25 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h | 22 +++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index dd9dbe5ad6d30..7da0c1aa96cb9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2173,6 +2173,25 @@ static int ptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
+static int cmac_dma_init(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	u32 reg;
+	int ret;
+
+	if (chip_id != RTL8852A && chip_id != RTL8852B)
+		return 0;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	reg = rtw89_mac_reg_by_idx(R_AX_RXDMA_CTRL_0, mac_idx);
+	rtw89_write8_clr(rtwdev, reg, RX_FULL_MODE);
+
+	return 0;
+}
+
 static int cmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	int ret;
@@ -2248,6 +2267,12 @@ static int cmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		return ret;
 	}
 
+	ret = cmac_dma_init(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d DMA init %d\n", mac_idx, ret);
+		return ret;
+	}
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 19e5e09bf726b..ffebb24de7054 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2332,6 +2332,28 @@
 #define B_AX_DLE_IMR_SET (B_AX_RXSTS_FSM_HANG_ERROR_IMR | \
 			  B_AX_RXDATA_FSM_HANG_ERROR_IMR)
 
+#define R_AX_RXDMA_CTRL_0 0xC804
+#define R_AX_RXDMA_CTRL_0_C1 0xE804
+#define B_AX_RXDMA_DBGOUT_EN BIT(31)
+#define B_AX_RXDMA_DBG_SEL_MASK GENMASK(30, 29)
+#define B_AX_RXDMA_FIFO_DBG_SEL_MASK GENMASK(28, 25)
+#define B_AX_RXDMA_DEFAULT_PAGE_MASK GENMASK(22, 21)
+#define B_AX_RXDMA_BUFF_REQ_PRI_MASK GENMASK(20, 19)
+#define B_AX_RXDMA_TGT_QUEID_MASK GENMASK(18, 13)
+#define B_AX_RXDMA_TGT_PRID_MASK GENMASK(12, 10)
+#define B_AX_RXDMA_DIS_CSI_RELEASE BIT(9)
+#define B_AX_RXDMA_DIS_RXSTS_WAIT_PTR_CLR BIT(7)
+#define B_AX_RXDMA_DIS_CSI_WAIT_PTR_CLR BIT(6)
+#define B_AX_RXSTS_PTR_FULL_MODE BIT(5)
+#define B_AX_CSI_PTR_FULL_MODE BIT(4)
+#define B_AX_RU3_PTR_FULL_MODE BIT(3)
+#define B_AX_RU2_PTR_FULL_MODE BIT(2)
+#define B_AX_RU1_PTR_FULL_MODE BIT(1)
+#define B_AX_RU0_PTR_FULL_MODE BIT(0)
+#define RX_FULL_MODE (B_AX_RU0_PTR_FULL_MODE | B_AX_RU1_PTR_FULL_MODE | \
+		      B_AX_RU2_PTR_FULL_MODE | B_AX_RU3_PTR_FULL_MODE | \
+		      B_AX_CSI_PTR_FULL_MODE | B_AX_RXSTS_PTR_FULL_MODE)
+
 #define R_AX_RXDMA_PKT_INFO_0 0xC814
 #define R_AX_RXDMA_PKT_INFO_1 0xC818
 #define R_AX_RXDMA_PKT_INFO_2 0xC81C
-- 
2.25.1

