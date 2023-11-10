Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB447E767E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 02:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjKJBY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 20:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345537AbjKJBY1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 20:24:27 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A967244B9
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 17:24:24 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AA1OHJG01890537, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AA1OHJG01890537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 09:24:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 10 Nov 2023 09:24:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 10 Nov
 2023 09:24:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/7] wifi: rtw89: pci: correct interrupt mitigation register for 8852CE
Date:   Fri, 10 Nov 2023 09:23:18 +0800
Message-ID: <20231110012319.12727-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231110012319.12727-1-pkshih@realtek.com>
References: <20231110012319.12727-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
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
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To reduce interrupt count, configure mitigation register with thresholds
of time and packet count. We missed that 8852CE uses different register
address, so correct it. Then, interrupt counts down to 30,763 from 229,825
during stress test in 20 seconds.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c       | 3 ++-
 drivers/net/wireless/realtek/rtw89/pci.h       | 8 ++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851be.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c | 1 +
 6 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 9c6d55af8c8e..09de12a9e3c2 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3620,6 +3620,7 @@ static void rtw89_pci_aspm_set(struct rtw89_dev *rtwdev, bool enable)
 
 static void rtw89_pci_recalc_int_mit(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	struct rtw89_traffic_stats *stats = &rtwdev->stats;
 	enum rtw89_tfc_lv tx_tfc_lv = stats->tx_tfc_lv;
 	enum rtw89_tfc_lv rx_tfc_lv = stats->rx_tfc_lv;
@@ -3632,7 +3633,7 @@ static void rtw89_pci_recalc_int_mit(struct rtw89_dev *rtwdev)
 		      FIELD_PREP(B_AX_RXTIMER_UNIT_MASK, AX_RXTIMER_UNIT_64US) |
 		      FIELD_PREP(B_AX_RXTIMER_MATCH_MASK, 2048 / 64);
 
-	rtw89_write32(rtwdev, R_AX_INT_MIT_RX, val);
+	rtw89_write32(rtwdev, info->mit_addr, val);
 }
 
 static void rtw89_pci_link_cfg(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index d2a0a9aa4da3..e2d8eef52b20 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -812,6 +812,13 @@
 #define B_AX_RXCOUNTER_MATCH_MASK	GENMASK(15, 8)
 #define B_AX_RXTIMER_MATCH_MASK		GENMASK(7, 0)
 
+#define R_AX_INT_MIT_RX_V1 0x1184
+#define B_AX_RXMIT_RXP2_SEL_V1 BIT(19)
+#define B_AX_RXMIT_RXP1_SEL_V1 BIT(18)
+#define B_AX_MIT_RXTIMER_UNIT_MASK GENMASK(17, 16)
+#define B_AX_MIT_RXCOUNTER_MATCH_MASK GENMASK(15, 8)
+#define B_AX_MIT_RXTIMER_MATCH_MASK GENMASK(7, 0)
+
 #define R_AX_DBG_ERR_FLAG		0x11C4
 #define B_AX_PCIE_RPQ_FULL		BIT(29)
 #define B_AX_PCIE_RXQ_FULL		BIT(28)
@@ -1241,6 +1248,7 @@ struct rtw89_pci_info {
 
 	u32 rpwm_addr;
 	u32 cpwm_addr;
+	u32 mit_addr;
 	u32 tx_dma_ch_mask;
 	const struct rtw89_pci_bd_idx_addr *bd_idx_addr_low_power;
 	const struct rtw89_pci_ch_dma_addr_set *dma_addr_set;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index 6858fd760013..ade69bd30fc8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -43,6 +43,7 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 
 	.rpwm_addr		= R_AX_PCIE_HRPWM,
 	.cpwm_addr		= R_AX_CPWM,
+	.mit_addr		= R_AX_INT_MIT_RX,
 	.tx_dma_ch_mask		= BIT(RTW89_TXCH_ACH4) | BIT(RTW89_TXCH_ACH5) |
 				  BIT(RTW89_TXCH_ACH6) | BIT(RTW89_TXCH_ACH7) |
 				  BIT(RTW89_TXCH_CH10) | BIT(RTW89_TXCH_CH11),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index f539f4602c02..f1e890bde049 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -44,6 +44,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 
 	.rpwm_addr		= R_AX_PCIE_HRPWM,
 	.cpwm_addr		= R_AX_CPWM,
+	.mit_addr		= R_AX_INT_MIT_RX,
 	.tx_dma_ch_mask		= 0,
 	.bd_idx_addr_low_power	= NULL,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index b9bbb6e9b4ff..920b20bbcfb7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -44,6 +44,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 
 	.rpwm_addr		= R_AX_PCIE_HRPWM,
 	.cpwm_addr		= R_AX_CPWM,
+	.mit_addr		= R_AX_INT_MIT_RX,
 	.tx_dma_ch_mask		= BIT(RTW89_TXCH_ACH4) | BIT(RTW89_TXCH_ACH5) |
 				  BIT(RTW89_TXCH_ACH6) | BIT(RTW89_TXCH_ACH7) |
 				  BIT(RTW89_TXCH_CH10) | BIT(RTW89_TXCH_CH11),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index f6bf35342719..4592de3dbd94 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -53,6 +53,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 
 	.rpwm_addr		= R_AX_PCIE_HRPWM_V1,
 	.cpwm_addr		= R_AX_PCIE_CRPWM,
+	.mit_addr		= R_AX_INT_MIT_RX_V1,
 	.tx_dma_ch_mask		= 0,
 	.bd_idx_addr_low_power	= &rtw8852c_bd_idx_addr_low_power,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_v1,
-- 
2.25.1

