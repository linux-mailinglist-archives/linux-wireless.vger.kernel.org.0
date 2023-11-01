Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE47DDD19
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 08:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjKAHWu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 03:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjKAHWt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 03:22:49 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5D103
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 00:22:46 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A17MclD61220475, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A17MclD61220475
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 15:22:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 1 Nov 2023 15:22:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 1 Nov 2023
 15:22:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw89: pci: implement PCI mac_post_init for WiFi 7 chips
Date:   Wed, 1 Nov 2023 15:21:49 +0800
Message-ID: <20231101072149.21997-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101072149.21997-1-pkshih@realtek.com>
References: <20231101072149.21997-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: license violation
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For normal use, we do additional settings than mac_pre_init, such as
more TX/RX DMA channels, interrupt mitigation and etc.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h    | 44 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 36 +++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 9b39ca4bbb66..37398e416e58 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -708,6 +708,45 @@
 #define B_BE_END_PL1_CNT_MASK GENMASK(23, 16)
 #define B_BE_START_PL1_CNT_MASK GENMASK(7, 0)
 
+#define R_BE_PCIE_MIT0_TMR 0x3330
+#define B_BE_PCIE_MIT0_RX_TMR_MASK GENMASK(5, 4)
+#define BE_MIT0_TMR_UNIT_1MS 0
+#define BE_MIT0_TMR_UNIT_2MS 1
+#define BE_MIT0_TMR_UNIT_4MS 2
+#define BE_MIT0_TMR_UNIT_8MS 3
+#define B_BE_PCIE_MIT0_TX_TMR_MASK GENMASK(1, 0)
+
+#define R_BE_PCIE_MIT0_CNT 0x3334
+#define B_BE_PCIE_RX_MIT0_CNT_MASK GENMASK(31, 24)
+#define B_BE_PCIE_TX_MIT0_CNT_MASK GENMASK(23, 16)
+#define B_BE_PCIE_RX_MIT0_TMR_CNT_MASK GENMASK(15, 8)
+#define B_BE_PCIE_TX_MIT0_TMR_CNT_MASK GENMASK(7, 0)
+
+#define R_BE_PCIE_MIT_CH_EN 0x3338
+#define B_BE_PCIE_MIT_RX1P1_EN BIT(23)
+#define B_BE_PCIE_MIT_RX0P1_EN BIT(22)
+#define B_BE_PCIE_MIT_ROQ1_EN BIT(21)
+#define B_BE_PCIE_MIT_RPQ1_EN BIT(20)
+#define B_BE_PCIE_MIT_RX1P2_EN BIT(19)
+#define B_BE_PCIE_MIT_ROQ0_EN BIT(18)
+#define B_BE_PCIE_MIT_RPQ0_EN BIT(17)
+#define B_BE_PCIE_MIT_RX0P2_EN BIT(16)
+#define B_BE_PCIE_MIT_TXCH14_EN BIT(14)
+#define B_BE_PCIE_MIT_TXCH13_EN BIT(13)
+#define B_BE_PCIE_MIT_TXCH12_EN BIT(12)
+#define B_BE_PCIE_MIT_TXCH11_EN BIT(11)
+#define B_BE_PCIE_MIT_TXCH10_EN BIT(10)
+#define B_BE_PCIE_MIT_TXCH9_EN BIT(9)
+#define B_BE_PCIE_MIT_TXCH8_EN BIT(8)
+#define B_BE_PCIE_MIT_TXCH7_EN BIT(7)
+#define B_BE_PCIE_MIT_TXCH6_EN BIT(6)
+#define B_BE_PCIE_MIT_TXCH5_EN BIT(5)
+#define B_BE_PCIE_MIT_TXCH4_EN BIT(4)
+#define B_BE_PCIE_MIT_TXCH3_EN BIT(3)
+#define B_BE_PCIE_MIT_TXCH2_EN BIT(2)
+#define B_BE_PCIE_MIT_TXCH1_EN BIT(1)
+#define B_BE_PCIE_MIT_TXCH0_EN BIT(0)
+
 #define R_BE_SER_PL1_CTRL 0x34A8
 #define B_BE_PL1_SER_PL1_EN BIT(31)
 #define B_BE_PL1_IGNORE_HOT_RST BIT(30)
@@ -800,12 +839,15 @@
 #define RTW89_PCI_MULTITAG		8
 
 /* PCIE CFG register */
+#define RTW89_PCIE_CAPABILITY_SPEED	0x7C
+#define RTW89_PCIE_SUPPORT_GEN_MASK	GENMASK(3, 0)
 #define RTW89_PCIE_L1_STS_V1		0x80
 #define RTW89_BCFG_LINK_SPEED_MASK	GENMASK(19, 16)
 #define RTW89_PCIE_GEN1_SPEED		0x01
 #define RTW89_PCIE_GEN2_SPEED		0x02
 #define RTW89_PCIE_PHY_RATE		0x82
 #define RTW89_PCIE_PHY_RATE_MASK	GENMASK(1, 0)
+#define RTW89_PCIE_LINK_CHANGE_SPEED	0xA0
 #define RTW89_PCIE_L1SS_STS_V1		0x0168
 #define RTW89_PCIE_BIT_ASPM_L11		BIT(3)
 #define RTW89_PCIE_BIT_ASPM_L12		BIT(2)
@@ -820,6 +862,8 @@
 #define RTW89_PCIE_BIT_CLK		BIT(4)
 #define RTW89_PCIE_BIT_L1		BIT(3)
 #define RTW89_PCIE_CLK_CTRL		0x0725
+#define RTW89_PCIE_FTS			0x080C
+#define RTW89_PCIE_POLLING_BIT		BIT(17)
 #define RTW89_PCIE_RST_MSTATE		0x0B48
 #define RTW89_PCIE_BIT_CFG_RST_MSTATE	BIT(0)
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 33c841613c3d..f3aab34a3a24 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -385,8 +385,44 @@ int rtw89_pci_ltr_set_v2(struct rtw89_dev *rtwdev, bool en)
 }
 EXPORT_SYMBOL(rtw89_pci_ltr_set_v2);
 
+static void rtw89_pci_configure_mit_be(struct rtw89_dev *rtwdev)
+{
+	u32 cnt;
+	u32 val;
+
+	rtw89_write32_mask(rtwdev, R_BE_PCIE_MIT0_TMR,
+			   B_BE_PCIE_MIT0_RX_TMR_MASK, BE_MIT0_TMR_UNIT_1MS);
+
+	val = rtw89_read32(rtwdev, R_BE_PCIE_MIT0_CNT);
+	cnt = min_t(u32, U8_MAX, RTW89_PCI_RXBD_NUM_MAX / 2);
+	val = u32_replace_bits(val, cnt, B_BE_PCIE_RX_MIT0_CNT_MASK);
+	val = u32_replace_bits(val, 2, B_BE_PCIE_RX_MIT0_TMR_CNT_MASK);
+	rtw89_write32(rtwdev, R_BE_PCIE_MIT0_CNT, val);
+}
+
+static int rtw89_pci_ops_mac_post_init_be(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	int ret;
+
+	ret = info->ltr_set(rtwdev, true);
+	if (ret) {
+		rtw89_err(rtwdev, "pci ltr set fail\n");
+		return ret;
+	}
+
+	rtw89_pci_ctrl_trxdma_pcie_be(rtwdev, MAC_AX_PCIE_IGNORE,
+				      MAC_AX_PCIE_IGNORE, MAC_AX_PCIE_ENABLE);
+	rtw89_pci_ctrl_wpdma_pcie_be(rtwdev, true);
+	rtw89_pci_ctrl_txdma_ch_be(rtwdev, true, true);
+	rtw89_pci_configure_mit_be(rtwdev);
+
+	return 0;
+}
+
 const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_be,
+	.mac_post_init = rtw89_pci_ops_mac_post_init_be,
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_be,
 };
-- 
2.25.1

