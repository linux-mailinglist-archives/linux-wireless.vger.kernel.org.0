Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF61599582
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 08:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346589AbiHSGsz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Aug 2022 02:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbiHSGsr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Aug 2022 02:48:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B68865071C
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 23:48:43 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27J6mIHW1001755, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27J6mIHW1001755
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 19 Aug 2022 14:48:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 14:48:31 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 19 Aug
 2022 14:48:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/5] wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and L1ss for 8852c
Date:   Fri, 19 Aug 2022 14:48:10 +0800
Message-ID: <20220819064811.37700-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819064811.37700-1-pkshih@realtek.com>
References: <20220819064811.37700-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 08/19/2022 06:25:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTkgpFekyCAwMTo1MzowMA==?=
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

8852CE controls CLKREQ, ASPM L1, L1ss via wifi registers
instead, so change them accordingly.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 91 +++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/pci.h | 12 ++++
 2 files changed, 79 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c09d2ffc5005f..67baf495a6986 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3291,6 +3291,7 @@ static int rtw89_pci_filter_out(struct rtw89_dev *rtwdev)
 
 static void rtw89_pci_clkreq_set(struct rtw89_dev *rtwdev, bool enable)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	int ret;
 
 	if (rtw89_pci_disable_clkreq)
@@ -3301,19 +3302,33 @@ static void rtw89_pci_clkreq_set(struct rtw89_dev *rtwdev, bool enable)
 	if (ret)
 		rtw89_err(rtwdev, "failed to set CLKREQ Delay\n");
 
-	if (enable)
-		ret = rtw89_pci_config_byte_set(rtwdev, RTW89_PCIE_L1_CTRL,
-						RTW89_PCIE_BIT_CLK);
-	else
-		ret = rtw89_pci_config_byte_clr(rtwdev, RTW89_PCIE_L1_CTRL,
-						RTW89_PCIE_BIT_CLK);
-	if (ret)
-		rtw89_err(rtwdev, "failed to %s CLKREQ_L1, ret=%d",
-			  enable ? "set" : "unset", ret);
+	if (chip_id == RTL8852A) {
+		if (enable)
+			ret = rtw89_pci_config_byte_set(rtwdev,
+							RTW89_PCIE_L1_CTRL,
+							RTW89_PCIE_BIT_CLK);
+		else
+			ret = rtw89_pci_config_byte_clr(rtwdev,
+							RTW89_PCIE_L1_CTRL,
+							RTW89_PCIE_BIT_CLK);
+		if (ret)
+			rtw89_err(rtwdev, "failed to %s CLKREQ_L1, ret=%d",
+				  enable ? "set" : "unset", ret);
+	} else if (chip_id == RTL8852C) {
+		rtw89_write32_set(rtwdev, R_AX_PCIE_LAT_CTRL,
+				  B_AX_CLK_REQ_SEL_OPT | B_AX_CLK_REQ_SEL);
+		if (enable)
+			rtw89_write32_set(rtwdev, R_AX_L1_CLK_CTRL,
+					  B_AX_CLK_REQ_N);
+		else
+			rtw89_write32_clr(rtwdev, R_AX_L1_CLK_CTRL,
+					  B_AX_CLK_REQ_N);
+	}
 }
 
 static void rtw89_pci_aspm_set(struct rtw89_dev *rtwdev, bool enable)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u8 value = 0;
 	int ret;
 
@@ -3332,12 +3347,23 @@ static void rtw89_pci_aspm_set(struct rtw89_dev *rtwdev, bool enable)
 	if (ret)
 		rtw89_err(rtwdev, "failed to read ASPM Delay\n");
 
-	if (enable)
-		ret = rtw89_pci_config_byte_set(rtwdev, RTW89_PCIE_L1_CTRL,
-						RTW89_PCIE_BIT_L1);
-	else
-		ret = rtw89_pci_config_byte_clr(rtwdev, RTW89_PCIE_L1_CTRL,
-						RTW89_PCIE_BIT_L1);
+	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+		if (enable)
+			ret = rtw89_pci_config_byte_set(rtwdev,
+							RTW89_PCIE_L1_CTRL,
+							RTW89_PCIE_BIT_L1);
+		else
+			ret = rtw89_pci_config_byte_clr(rtwdev,
+							RTW89_PCIE_L1_CTRL,
+							RTW89_PCIE_BIT_L1);
+	} else if (chip_id == RTL8852C) {
+		if (enable)
+			rtw89_write32_set(rtwdev, R_AX_PCIE_MIX_CFG_V1,
+					  B_AX_ASPM_CTRL_L1);
+		else
+			rtw89_write32_clr(rtwdev, R_AX_PCIE_MIX_CFG_V1,
+					  B_AX_ASPM_CTRL_L1);
+	}
 	if (ret)
 		rtw89_err(rtwdev, "failed to %s ASPM L1, ret=%d",
 			  enable ? "set" : "unset", ret);
@@ -3398,17 +3424,34 @@ static void rtw89_pci_link_cfg(struct rtw89_dev *rtwdev)
 
 static void rtw89_pci_l1ss_set(struct rtw89_dev *rtwdev, bool enable)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	int ret;
 
-	if (enable)
-		ret = rtw89_pci_config_byte_set(rtwdev, RTW89_PCIE_TIMER_CTRL,
-						RTW89_PCIE_BIT_L1SUB);
-	else
-		ret = rtw89_pci_config_byte_clr(rtwdev, RTW89_PCIE_TIMER_CTRL,
-						RTW89_PCIE_BIT_L1SUB);
-	if (ret)
-		rtw89_err(rtwdev, "failed to %s L1SS, ret=%d",
-			  enable ? "set" : "unset", ret);
+	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+		if (enable)
+			ret = rtw89_pci_config_byte_set(rtwdev,
+							RTW89_PCIE_TIMER_CTRL,
+							RTW89_PCIE_BIT_L1SUB);
+		else
+			ret = rtw89_pci_config_byte_clr(rtwdev,
+							RTW89_PCIE_TIMER_CTRL,
+							RTW89_PCIE_BIT_L1SUB);
+		if (ret)
+			rtw89_err(rtwdev, "failed to %s L1SS, ret=%d",
+				  enable ? "set" : "unset", ret);
+	} else if (chip_id == RTL8852C) {
+		ret = rtw89_pci_config_byte_clr(rtwdev, RTW89_PCIE_L1SS_STS_V1,
+						RTW89_PCIE_BIT_ASPM_L11 |
+						RTW89_PCIE_BIT_PCI_L11);
+		if (ret)
+			rtw89_warn(rtwdev, "failed to unset ASPM L1.1, ret=%d", ret);
+		if (enable)
+			rtw89_write32_clr(rtwdev, R_AX_PCIE_MIX_CFG_V1,
+					  B_AX_L1SUB_DISABLE);
+		else
+			rtw89_write32_set(rtwdev, R_AX_PCIE_MIX_CFG_V1,
+					  B_AX_L1SUB_DISABLE);
+	}
 }
 
 static void rtw89_pci_l1ss_cfg(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index e80380271cd35..63dc6d4db6022 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -62,9 +62,16 @@
 #define B_AX_REQ_ENTR_L1		BIT(8)
 #define B_AX_L1SUB_DISABLE		BIT(0)
 
+#define R_AX_L1_CLK_CTRL		0x3010
+#define B_AX_CLK_REQ_N			BIT(1)
+
 #define R_AX_PCIE_BG_CLR		0x303C
 #define B_AX_BG_CLR_ASYNC_M3		BIT(4)
 
+#define R_AX_PCIE_LAT_CTRL		0x3044
+#define B_AX_CLK_REQ_SEL_OPT		BIT(1)
+#define B_AX_CLK_REQ_SEL		BIT(0)
+
 #define R_AX_PCIE_IO_RCY_M1 0x3100
 #define B_AX_PCIE_IO_RCY_P_M1 BIT(5)
 #define B_AX_PCIE_IO_RCY_WDT_P_M1 BIT(4)
@@ -531,6 +538,11 @@
 #define RTW89_PCIE_GEN2_SPEED		0x02
 #define RTW89_PCIE_PHY_RATE		0x82
 #define RTW89_PCIE_PHY_RATE_MASK	GENMASK(1, 0)
+#define RTW89_PCIE_L1SS_STS_V1		0x0168
+#define RTW89_PCIE_BIT_ASPM_L11		BIT(3)
+#define RTW89_PCIE_BIT_ASPM_L12		BIT(2)
+#define RTW89_PCIE_BIT_PCI_L11		BIT(1)
+#define RTW89_PCIE_BIT_PCI_L12		BIT(0)
 #define RTW89_PCIE_ASPM_CTRL		0x070F
 #define RTW89_L1DLY_MASK		GENMASK(5, 3)
 #define RTW89_L0DLY_MASK		GENMASK(2, 0)
-- 
2.25.1

