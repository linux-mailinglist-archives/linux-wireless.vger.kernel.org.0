Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57A1597BD0
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 05:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242893AbiHRCz5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 22:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242889AbiHRCzz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 22:55:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 203C6A5C4E
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 19:55:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27I2tYCo9010861, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27I2tYCo9010861
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 18 Aug 2022 10:55:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 18 Aug 2022 10:55:47 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 18 Aug
 2022 10:55:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw89: pci: correct suspend/resume setting for variant chips
Date:   Thu, 18 Aug 2022 10:55:30 +0800
Message-ID: <20220818025530.9087-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818025530.9087-1-pkshih@realtek.com>
References: <20220818025530.9087-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 08/18/2022 02:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTggpFekyCAxMjo0MDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

We find that suspend/resume tests cause 8852CE lost, because some pci
registers are changed for 8852CE. So, correct them accordingly.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 31 ++++++++++++++++++------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 8ae06c3f27dbb..4254e110b370d 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3713,14 +3713,20 @@ static int __maybe_unused rtw89_pci_suspend(struct device *dev)
 {
 	struct ieee80211_hw *hw = dev_get_drvdata(dev);
 	struct rtw89_dev *rtwdev = hw->priv;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 
-	rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL,
-			  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
 	rtw89_write32_set(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
 	rtw89_write32_set(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
 	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
-	rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1,
-			  B_AX_PCIE_PERST_KEEP_REG | B_AX_PCIE_TRAIN_KEEP_REG);
+	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL,
+				  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
+		rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1,
+				  B_AX_PCIE_PERST_KEEP_REG | B_AX_PCIE_TRAIN_KEEP_REG);
+	} else {
+		rtw89_write32_clr(rtwdev, R_AX_PCIE_PS_CTRL_V1,
+				  B_AX_CMAC_EXIT_L1_EN | B_AX_DMAC0_EXIT_L1_EN);
+	}
 
 	return 0;
 }
@@ -3741,15 +3747,24 @@ static int __maybe_unused rtw89_pci_resume(struct device *dev)
 {
 	struct ieee80211_hw *hw = dev_get_drvdata(dev);
 	struct rtw89_dev *rtwdev = hw->priv;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 
-	rtw89_write32_set(rtwdev, R_AX_SYS_SDIO_CTRL,
-			  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
 	rtw89_write32_set(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
 	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
 	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
-	rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1,
-			  B_AX_PCIE_PERST_KEEP_REG | B_AX_PCIE_TRAIN_KEEP_REG);
+	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+		rtw89_write32_set(rtwdev, R_AX_SYS_SDIO_CTRL,
+				  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
+		rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1,
+				  B_AX_PCIE_PERST_KEEP_REG | B_AX_PCIE_TRAIN_KEEP_REG);
+	} else {
+		rtw89_write32_set(rtwdev, R_AX_PCIE_PS_CTRL_V1,
+				  B_AX_CMAC_EXIT_L1_EN | B_AX_DMAC0_EXIT_L1_EN);
+		rtw89_write32_clr(rtwdev, R_AX_PCIE_PS_CTRL_V1,
+				  B_AX_SEL_REQ_ENTR_L1);
+	}
 	rtw89_pci_l2_hci_ldo(rtwdev);
+	rtw89_pci_filter_out(rtwdev);
 	rtw89_pci_link_cfg(rtwdev);
 	rtw89_pci_l1ss_cfg(rtwdev);
 
-- 
2.25.1

