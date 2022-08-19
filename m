Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AFF599583
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 08:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346548AbiHSGss (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Aug 2022 02:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHSGsq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Aug 2022 02:48:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E76AD4D829
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 23:48:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27J6mHsS5001751, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27J6mHsS5001751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 19 Aug 2022 14:48:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 19 Aug 2022 14:48:30 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 19 Aug
 2022 14:48:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/5] wifi: rtw89: pci: fix PCI PHY auto adaption by using software restore
Date:   Fri, 19 Aug 2022 14:48:09 +0800
Message-ID: <20220819064811.37700-4-pkshih@realtek.com>
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

From: Chia-Yuan Li <leo.li@realtek.com>

There is chance that PCI PHY auto adaption fail. When first time boot up,
software restore the right adaption value and close PHY auto adaption
mechanism.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 71 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h | 29 +++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h | 12 ++++
 3 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c68fec9eb5a64..c09d2ffc5005f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3219,6 +3219,76 @@ static void rtw89_pci_free_irq(struct rtw89_dev *rtwdev,
 	pci_free_irq_vectors(pdev);
 }
 
+static u16 gray_code_to_bin(u16 gray_code, u32 bit_num)
+{
+	u16 bin = 0, gray_bit;
+	u32 bit_idx;
+
+	for (bit_idx = 0; bit_idx < bit_num; bit_idx++) {
+		gray_bit = (gray_code >> bit_idx) & 0x1;
+		if (bit_num - bit_idx > 1)
+			gray_bit ^= (gray_code >> (bit_idx + 1)) & 0x1;
+		bin |= (gray_bit << bit_idx);
+	}
+
+	return bin;
+}
+
+static int rtw89_pci_filter_out(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
+	u16 val16, filter_out_val;
+	u32 val, phy_offset;
+	int ret;
+
+	if (rtwdev->chip->chip_id != RTL8852C)
+		return 0;
+
+	val = rtw89_read32_mask(rtwdev, R_AX_PCIE_MIX_CFG_V1, B_AX_ASPM_CTRL_MASK);
+	if (val == B_AX_ASPM_CTRL_L1)
+		return 0;
+
+	ret = pci_read_config_dword(pdev, RTW89_PCIE_L1_STS_V1, &val);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(RTW89_BCFG_LINK_SPEED_MASK, val);
+	if (val == RTW89_PCIE_GEN1_SPEED) {
+		phy_offset = R_RAC_DIRECT_OFFSET_G1;
+	} else if (val == RTW89_PCIE_GEN2_SPEED) {
+		phy_offset = R_RAC_DIRECT_OFFSET_G2;
+		val16 = rtw89_read16(rtwdev, phy_offset + RAC_ANA10 * RAC_MULT);
+		rtw89_write16_set(rtwdev, phy_offset + RAC_ANA10 * RAC_MULT,
+				  val16 | B_PCIE_BIT_PINOUT_DIS);
+		rtw89_write16_set(rtwdev, phy_offset + RAC_ANA19 * RAC_MULT,
+				  val16 & ~B_PCIE_BIT_RD_SEL);
+
+		val16 = rtw89_read16_mask(rtwdev,
+					  phy_offset + RAC_ANA1F * RAC_MULT,
+					  FILTER_OUT_EQ_MASK);
+		val16 = gray_code_to_bin(val16, hweight16(val16));
+		filter_out_val = rtw89_read16(rtwdev, phy_offset + RAC_ANA24 *
+					      RAC_MULT);
+		filter_out_val &= ~REG_FILTER_OUT_MASK;
+		filter_out_val |= FIELD_PREP(REG_FILTER_OUT_MASK, val16);
+
+		rtw89_write16(rtwdev, phy_offset + RAC_ANA24 * RAC_MULT,
+			      filter_out_val);
+		rtw89_write16_set(rtwdev, phy_offset + RAC_ANA0A * RAC_MULT,
+				  B_BAC_EQ_SEL);
+		rtw89_write16_set(rtwdev,
+				  R_RAC_DIRECT_OFFSET_G1 + RAC_ANA0C * RAC_MULT,
+				  B_PCIE_BIT_PSAVE);
+	} else {
+		return -EOPNOTSUPP;
+	}
+	rtw89_write16_set(rtwdev, phy_offset + RAC_ANA0C * RAC_MULT,
+			  B_PCIE_BIT_PSAVE);
+
+	return 0;
+}
+
 static void rtw89_pci_clkreq_set(struct rtw89_dev *rtwdev, bool enable)
 {
 	int ret;
@@ -3667,6 +3737,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_clear_resource;
 	}
 
+	rtw89_pci_filter_out(rtwdev);
 	rtw89_pci_link_cfg(rtwdev);
 	rtw89_pci_l1ss_cfg(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index a118647213e35..e80380271cd35 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -11,11 +11,18 @@
 #define MDIO_PG1_G1 1
 #define MDIO_PG0_G2 2
 #define MDIO_PG1_G2 3
+#define RAC_CTRL_PPR			0x00
+#define RAC_ANA0A			0x0A
+#define B_BAC_EQ_SEL			BIT(5)
+#define RAC_ANA0C			0x0C
+#define B_PCIE_BIT_PSAVE		BIT(15)
 #define RAC_ANA10			0x10
+#define B_PCIE_BIT_PINOUT_DIS		BIT(3)
 #define RAC_REG_REV2			0x1B
 #define BAC_CMU_EN_DLY_MASK		GENMASK(15, 12)
 #define PCIE_DPHY_DLY_25US		0x1
 #define RAC_ANA19			0x19
+#define B_PCIE_BIT_RD_SEL		BIT(2)
 #define RAC_ANA1F			0x1F
 #define RAC_ANA24			0x24
 #define B_AX_DEGLITCH			GENMASK(11, 8)
@@ -45,6 +52,16 @@
 #define B_AX_SEL_REQ_ENTR_L1		BIT(2)
 #define B_AX_SEL_REQ_EXIT_L1		BIT(0)
 
+#define R_AX_PCIE_MIX_CFG_V1		0x300C
+#define B_AX_ASPM_CTRL_L1		BIT(17)
+#define B_AX_ASPM_CTRL_L0		BIT(16)
+#define B_AX_ASPM_CTRL_MASK		GENMASK(17, 16)
+#define B_AX_XFER_PENDING_FW		BIT(11)
+#define B_AX_XFER_PENDING		BIT(10)
+#define B_AX_REQ_EXIT_L1		BIT(9)
+#define B_AX_REQ_ENTR_L1		BIT(8)
+#define B_AX_L1SUB_DISABLE		BIT(0)
+
 #define R_AX_PCIE_BG_CLR		0x303C
 #define B_AX_BG_CLR_ASYNC_M3		BIT(4)
 
@@ -88,7 +105,10 @@
 #define B_AX_PCIE_WDT_TIMER_S1_MASK GENMASK(31, 0)
 
 #define R_RAC_DIRECT_OFFSET_G1 0x3800
+#define FILTER_OUT_EQ_MASK GENMASK(14, 10)
 #define R_RAC_DIRECT_OFFSET_G2 0x3880
+#define REG_FILTER_OUT_MASK GENMASK(6, 2)
+#define RAC_MULT 2
 
 #define RTW89_PCI_WR_RETRY_CNT		20
 
@@ -505,6 +525,12 @@
 #define RTW89_PCI_MULTITAG		8
 
 /* PCIE CFG register */
+#define RTW89_PCIE_L1_STS_V1		0x80
+#define RTW89_BCFG_LINK_SPEED_MASK	GENMASK(19, 16)
+#define RTW89_PCIE_GEN1_SPEED		0x01
+#define RTW89_PCIE_GEN2_SPEED		0x02
+#define RTW89_PCIE_PHY_RATE		0x82
+#define RTW89_PCIE_PHY_RATE_MASK	GENMASK(1, 0)
 #define RTW89_PCIE_ASPM_CTRL		0x070F
 #define RTW89_L1DLY_MASK		GENMASK(5, 3)
 #define RTW89_L0DLY_MASK		GENMASK(2, 0)
@@ -516,8 +542,7 @@
 #define RTW89_PCIE_CLK_CTRL		0x0725
 #define RTW89_PCIE_RST_MSTATE		0x0B48
 #define RTW89_PCIE_BIT_CFG_RST_MSTATE	BIT(0)
-#define RTW89_PCIE_PHY_RATE		0x82
-#define RTW89_PCIE_PHY_RATE_MASK	GENMASK(1, 0)
+
 #define INTF_INTGRA_MINREF_V1	90
 #define INTF_INTGRA_HOSTREF_V1	100
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 497c1e9263fc0..f55ea3f834f89 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -143,6 +143,18 @@
 #define R_AX_PMC_DBG_CTRL2 0x00CC
 #define B_AX_SYSON_DIS_PMCR_AX_WRMSK BIT(2)
 
+#define R_AX_PCIE_MIO_INTF 0x00E4
+#define B_AX_PCIE_MIO_ADDR_PAGE_V1_MASK GENMASK(20, 16)
+#define B_AX_PCIE_MIO_BYIOREG BIT(13)
+#define B_AX_PCIE_MIO_RE BIT(12)
+#define B_AX_PCIE_MIO_WE_MASK GENMASK(11, 8)
+#define MIO_WRITE_BYTE_ALL 0xF
+#define B_AX_PCIE_MIO_ADDR_MASK GENMASK(7, 0)
+#define MIO_ADDR_PAGE_MASK GENMASK(12, 8)
+
+#define R_AX_PCIE_MIO_INTD 0x00E8
+#define B_AX_PCIE_MIO_DATA_MASK GENMASK(31, 0)
+
 #define R_AX_SYS_CFG1 0x00F0
 #define B_AX_CHIP_VER_MASK GENMASK(15, 12)
 
-- 
2.25.1

