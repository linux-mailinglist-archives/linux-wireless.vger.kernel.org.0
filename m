Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB86D06E2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjC3NfL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 09:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjC3NfE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 09:35:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95355BB96
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 06:34:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32UDYLQt8015871, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32UDYLQt8015871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 30 Mar 2023 21:34:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 30 Mar 2023 21:34:39 +0800
Received: from localhost (172.16.16.62) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 30 Mar
 2023 21:34:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: pci: update PCI related settings to support 8851B
Date:   Thu, 30 Mar 2023 21:33:24 +0800
Message-ID: <20230330133324.19538-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330133324.19538-1-pkshih@realtek.com>
References: <20230330133324.19538-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.62]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Many settings of 8851B are like 8852A or 8852B. Change them to proper
settings as hardware design.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 33 +++++++++++++++---------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index ec8bb5f10482e..ca34f4cde9725 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1912,9 +1912,10 @@ __get_target(struct rtw89_dev *rtwdev, u16 *target, enum rtw89_pcie_phy phy_rate
 
 static int rtw89_pci_autok_x(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	int ret;
 
-	if (rtwdev->chip->chip_id != RTL8852B)
+	if (chip_id != RTL8852B && chip_id != RTL8851B)
 		return 0;
 
 	ret = rtw89_write16_mdio_mask(rtwdev, RAC_REG_FLD_0, BAC_AUTOK_N_MASK,
@@ -1924,13 +1925,14 @@ static int rtw89_pci_autok_x(struct rtw89_dev *rtwdev)
 
 static int rtw89_pci_auto_refclk_cal(struct rtw89_dev *rtwdev, bool autook_en)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	enum rtw89_pcie_phy phy_rate;
 	u16 val16, mgn_set, div_set, tar;
 	u8 val8, bdr_ori;
 	bool l1_flag = false;
 	int ret = 0;
 
-	if (rtwdev->chip->chip_id != RTL8852B)
+	if (chip_id != RTL8852B && chip_id != RTL8851B)
 		return 0;
 
 	ret = rtw89_pci_read_config_byte(rtwdev, RTW89_PCIE_PHY_RATE, &val8);
@@ -2107,7 +2109,9 @@ static void rtw89_pci_rxdma_prefth(struct rtw89_dev *rtwdev)
 
 static void rtw89_pci_l1off_pwroff(struct rtw89_dev *rtwdev)
 {
-	if (rtwdev->chip->chip_id != RTL8852A && rtwdev->chip->chip_id != RTL8852B)
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+
+	if (chip_id != RTL8852A && chip_id != RTL8852B && chip_id != RTL8851B)
 		return;
 
 	rtw89_write32_clr(rtwdev, R_AX_PCIE_PS_CTRL, B_AX_L1OFF_PWR_OFF_EN);
@@ -2135,7 +2139,9 @@ static u32 rtw89_pci_l2_rxen_lat(struct rtw89_dev *rtwdev)
 
 static void rtw89_pci_aphy_pwrcut(struct rtw89_dev *rtwdev)
 {
-	if (rtwdev->chip->chip_id != RTL8852A && rtwdev->chip->chip_id != RTL8852B)
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+
+	if (chip_id != RTL8852A && chip_id != RTL8852B && chip_id != RTL8851B)
 		return;
 
 	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_PSUS_OFF_CAPC_EN);
@@ -2143,8 +2149,9 @@ static void rtw89_pci_aphy_pwrcut(struct rtw89_dev *rtwdev)
 
 static void rtw89_pci_hci_ldo(struct rtw89_dev *rtwdev)
 {
-	if (rtwdev->chip->chip_id == RTL8852A ||
-	    rtwdev->chip->chip_id == RTL8852B) {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+
+	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
 		rtw89_write32_set(rtwdev, R_AX_SYS_SDIO_CTRL,
 				  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
 		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL,
@@ -2157,7 +2164,9 @@ static void rtw89_pci_hci_ldo(struct rtw89_dev *rtwdev)
 
 static int rtw89_pci_dphy_delay(struct rtw89_dev *rtwdev)
 {
-	if (rtwdev->chip->chip_id != RTL8852B)
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+
+	if (chip_id != RTL8852B && chip_id != RTL8851B)
 		return 0;
 
 	return rtw89_write16_mdio_mask(rtwdev, RAC_REG_REV2, BAC_CMU_EN_DLY_MASK,
@@ -3398,7 +3407,7 @@ static void rtw89_pci_clkreq_set(struct rtw89_dev *rtwdev, bool enable)
 	if (ret)
 		rtw89_err(rtwdev, "failed to set CLKREQ Delay\n");
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
 		if (enable)
 			ret = rtw89_pci_config_byte_set(rtwdev,
 							RTW89_PCIE_L1_CTRL,
@@ -3443,7 +3452,7 @@ static void rtw89_pci_aspm_set(struct rtw89_dev *rtwdev, bool enable)
 	if (ret)
 		rtw89_err(rtwdev, "failed to read ASPM Delay\n");
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
 		if (enable)
 			ret = rtw89_pci_config_byte_set(rtwdev,
 							RTW89_PCIE_L1_CTRL,
@@ -3523,7 +3532,7 @@ static void rtw89_pci_l1ss_set(struct rtw89_dev *rtwdev, bool enable)
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	int ret;
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
 		if (enable)
 			ret = rtw89_pci_config_byte_set(rtwdev,
 							RTW89_PCIE_TIMER_CTRL,
@@ -3722,7 +3731,7 @@ static int __maybe_unused rtw89_pci_suspend(struct device *dev)
 	rtw89_write32_set(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
 	rtw89_write32_set(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
 	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
-	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
 		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL,
 				  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
 		rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1,
@@ -3756,7 +3765,7 @@ static int __maybe_unused rtw89_pci_resume(struct device *dev)
 	rtw89_write32_set(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
 	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
 	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
-	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
 		rtw89_write32_set(rtwdev, R_AX_SYS_SDIO_CTRL,
 				  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
 		rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1,
-- 
2.25.1

