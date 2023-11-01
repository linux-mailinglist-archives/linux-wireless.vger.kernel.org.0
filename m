Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B71B7DDD1A
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 08:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjKAHWv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 03:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjKAHWu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 03:22:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7060FEA
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 00:22:45 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A17MXlD41220475, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A17MXlD41220475
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 15:22:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 1 Nov 2023 15:22:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 1 Nov 2023
 15:22:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] wifi: rtw89: pci: implement PCI mac_pre_init for WiFi 7 chips
Date:   Wed, 1 Nov 2023 15:21:47 +0800
Message-ID: <20231101072149.21997-4-pkshih@realtek.com>
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

Call this function when doing MAC initialization at probe stage. It does
partial initial registers only, because we only need basic ability to
download firmware. The function to clear index is the sub-function,
so set its pointer as well.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c    |   2 +-
 drivers/net/wireless/realtek/rtw89/pci.h    |  71 +++++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 324 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 228 ++++++++++++++
 4 files changed, 624 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 0384f46648e7..74828dd37715 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1537,7 +1537,7 @@ static void rtw89_pci_release_tx_ring(struct rtw89_dev *rtwdev,
 	rtw89_pci_release_pending_txwd_skb(rtwdev, tx_ring);
 }
 
-static void rtw89_pci_ops_reset(struct rtw89_dev *rtwdev)
+void rtw89_pci_ops_reset(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 32e56938a170..d9fe9a013a56 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -245,6 +245,51 @@
 #define B_AX_HS1ISR_IND_INT BIT(25)
 #define B_AX_PCIE_DBG_STE_INT BIT(13)
 
+#define R_BE_PCIE_FRZ_CLK 0x3004
+#define B_BE_PCIE_FRZ_MAC_HW_RST BIT(31)
+#define B_BE_PCIE_FRZ_CFG_SPC_RST BIT(30)
+#define B_BE_PCIE_FRZ_ELBI_RST BIT(29)
+#define B_BE_PCIE_MAC_IS_ACTIVE BIT(28)
+#define B_BE_PCIE_FRZ_RTK_HW_RST BIT(27)
+#define B_BE_PCIE_FRZ_REG_RST BIT(26)
+#define B_BE_PCIE_FRZ_ANA_RST BIT(25)
+#define B_BE_PCIE_FRZ_WLAN_RST BIT(24)
+#define B_BE_PCIE_FRZ_FLR_RST BIT(23)
+#define B_BE_PCIE_FRZ_RET_NON_STKY_RST BIT(22)
+#define B_BE_PCIE_FRZ_RET_STKY_RST BIT(21)
+#define B_BE_PCIE_FRZ_NON_STKY_RST BIT(20)
+#define B_BE_PCIE_FRZ_STKY_RST BIT(19)
+#define B_BE_PCIE_FRZ_RET_CORE_RST BIT(18)
+#define B_BE_PCIE_FRZ_PWR_RST BIT(17)
+#define B_BE_PCIE_FRZ_PERST_RST BIT(16)
+#define B_BE_PCIE_FRZ_PHY_ALOAD BIT(15)
+#define B_BE_PCIE_FRZ_PHY_HW_RST BIT(14)
+#define B_BE_PCIE_DBG_CLK BIT(4)
+#define B_BE_PCIE_EN_CLK BIT(3)
+#define B_BE_PCIE_DBI_ACLK_ACT BIT(2)
+#define B_BE_PCIE_S1_ACLK_ACT BIT(1)
+#define B_BE_PCIE_EN_AUX_CLK BIT(0)
+
+#define R_BE_PCIE_PS_CTRL 0x3008
+#define B_BE_RSM_L0S_EN BIT(8)
+#define B_BE_CMAC_EXIT_L1_EN BIT(7)
+#define B_BE_DMAC0_EXIT_L1_EN BIT(6)
+#define B_BE_FORCE_L0 BIT(5)
+#define B_BE_DBI_RO_WR_DISABLE BIT(4)
+#define B_BE_SEL_XFER_PENDING BIT(3)
+#define B_BE_SEL_REQ_ENTR_L1 BIT(2)
+#define B_BE_PCIE_EN_SWENT_L23 BIT(1)
+#define B_BE_SEL_REQ_EXIT_L1 BIT(0)
+
+#define R_BE_PCIE_LAT_CTRL 0x3044
+#define B_BE_ELBI_PHY_REMAP_MASK GENMASK(29, 24)
+#define B_BE_SYS_SUS_L12_EN BIT(17)
+#define B_BE_MDIO_S_EN BIT(16)
+#define B_BE_SYM_AUX_CLK_SEL BIT(15)
+#define B_BE_RTK_LDO_POWER_LATENCY_MASK GENMASK(11, 10)
+#define B_BE_RTK_LDO_BIAS_LATENCY_MASK GENMASK(9, 8)
+#define B_BE_CLK_REQ_LAT_MASK GENMASK(7, 4)
+
 /* TX/RX */
 #define R_AX_DRV_FW_HSK_0	0x01B0
 #define R_AX_DRV_FW_HSK_1	0x01B4
@@ -656,6 +701,31 @@
 #define R_BE_PCIE_HRPWM 0x30C0
 #define R_BE_PCIE_CRPWM 0x30C4
 
+#define R_BE_L1_2_CTRL_HCILDO 0x3110
+#define B_BE_PCIE_DIS_L1_2_CTRL_HCILDO BIT(0)
+
+#define R_BE_PL1_DBG_INFO 0x3120
+#define B_BE_END_PL1_CNT_MASK GENMASK(23, 16)
+#define B_BE_START_PL1_CNT_MASK GENMASK(7, 0)
+
+#define R_BE_SER_PL1_CTRL 0x34A8
+#define B_BE_PL1_SER_PL1_EN BIT(31)
+#define B_BE_PL1_IGNORE_HOT_RST BIT(30)
+#define B_BE_PL1_TIMER_UNIT_MASK GENMASK(19, 17)
+#define B_BE_PL1_TIMER_CLEAR BIT(0)
+
+#define R_BE_REG_PL1_MASK 0x34B0
+#define B_BE_SER_PCLKREQ_ACK_MASK BIT(5)
+#define B_BE_SER_PM_CLK_MASK BIT(4)
+#define B_BE_SER_LTSSM_IMR BIT(3)
+#define B_BE_SER_PM_MASTER_IMR BIT(2)
+#define B_BE_SER_L1SUB_IMR BIT(1)
+#define B_BE_SER_PMU_IMR BIT(0)
+
+#define R_BE_RX_APPEND_MODE 0x8920
+#define B_BE_APPEND_OFFSET_MASK GENMASK(23, 16)
+#define B_BE_APPEND_LEN_MASK GENMASK(15, 0)
+
 #define R_BE_TXBD_RWPTR_CLR1 0xB014
 #define B_BE_CLR_CH14_IDX BIT(14)
 #define B_BE_CLR_CH13_IDX BIT(13)
@@ -1244,6 +1314,7 @@ struct pci_device_id;
 
 int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 void rtw89_pci_remove(struct pci_dev *pdev);
+void rtw89_pci_ops_reset(struct rtw89_dev *rtwdev);
 int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en);
 int rtw89_pci_ltr_set_v1(struct rtw89_dev *rtwdev, bool en);
 u32 rtw89_pci_fill_txaddr_info(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 17dcf3211b77..0510fe9f7146 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -7,6 +7,330 @@
 #include "pci.h"
 #include "reg.h"
 
+enum pcie_rxbd_mode {
+	PCIE_RXBD_NORM = 0,
+	PCIE_RXBD_SEP,
+	PCIE_RXBD_EXT,
+};
+
+#define PL0_TMR_SCALE_ASIC 1
+#define PL0_TMR_ANA_172US 0x800
+#define PL0_TMR_MAC_1MS 0x27100
+#define PL0_TMR_AUX_1MS 0x1E848
+
+static void _patch_pcie_power_wake_be(struct rtw89_dev *rtwdev, bool power_up)
+{
+	if (power_up)
+		rtw89_write32_set(rtwdev, R_BE_HCI_OPT_CTRL, BIT_WAKE_CTRL_V1);
+	else
+		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, BIT_WAKE_CTRL_V1);
+}
+
+static void rtw89_pci_set_io_rcy_be(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	u32 scale = PL0_TMR_SCALE_ASIC;
+	u32 val32;
+
+	if (info->io_rcy_en == MAC_AX_PCIE_ENABLE) {
+		val32 = info->io_rcy_tmr == MAC_AX_IO_RCY_ANA_TMR_DEF ?
+			PL0_TMR_ANA_172US : info->io_rcy_tmr;
+		val32 /= scale;
+
+		rtw89_write32(rtwdev, R_BE_AON_WDT_TMR, val32);
+		rtw89_write32(rtwdev, R_BE_MDIO_WDT_TMR, val32);
+		rtw89_write32(rtwdev, R_BE_LA_MODE_WDT_TMR, val32);
+		rtw89_write32(rtwdev, R_BE_WDT_AR_TMR, val32);
+		rtw89_write32(rtwdev, R_BE_WDT_AW_TMR, val32);
+		rtw89_write32(rtwdev, R_BE_WDT_W_TMR, val32);
+		rtw89_write32(rtwdev, R_BE_WDT_B_TMR, val32);
+		rtw89_write32(rtwdev, R_BE_WDT_R_TMR, val32);
+
+		val32 = info->io_rcy_tmr == MAC_AX_IO_RCY_ANA_TMR_DEF ?
+			PL0_TMR_MAC_1MS : info->io_rcy_tmr;
+		val32 /= scale;
+		rtw89_write32(rtwdev, R_BE_WLAN_WDT_TMR, val32);
+		rtw89_write32(rtwdev, R_BE_AXIDMA_WDT_TMR, val32);
+
+		val32 = info->io_rcy_tmr == MAC_AX_IO_RCY_ANA_TMR_DEF ?
+			PL0_TMR_AUX_1MS : info->io_rcy_tmr;
+		val32 /= scale;
+		rtw89_write32(rtwdev, R_BE_LOCAL_WDT_TMR, val32);
+	} else {
+		rtw89_write32_clr(rtwdev, R_BE_WLAN_WDT, B_BE_WLAN_WDT_ENABLE);
+		rtw89_write32_clr(rtwdev, R_BE_AXIDMA_WDT, B_BE_AXIDMA_WDT_ENABLE);
+		rtw89_write32_clr(rtwdev, R_BE_AON_WDT, B_BE_AON_WDT_ENABLE);
+		rtw89_write32_clr(rtwdev, R_BE_LOCAL_WDT, B_BE_LOCAL_WDT_ENABLE);
+		rtw89_write32_clr(rtwdev, R_BE_MDIO_WDT, B_BE_MDIO_WDT_ENABLE);
+		rtw89_write32_clr(rtwdev, R_BE_LA_MODE_WDT, B_BE_LA_MODE_WDT_ENABLE);
+		rtw89_write32_clr(rtwdev, R_BE_WDT_AR, B_BE_WDT_AR_ENABLE);
+		rtw89_write32_clr(rtwdev, R_BE_WDT_AW, B_BE_WDT_AW_ENABLE);
+		rtw89_write32_clr(rtwdev, R_BE_WDT_W, B_BE_WDT_W_ENABLE);
+		rtw89_write32_clr(rtwdev, R_BE_WDT_B, B_BE_WDT_B_ENABLE);
+		rtw89_write32_clr(rtwdev, R_BE_WDT_R, B_BE_WDT_R_ENABLE);
+	}
+}
+
+static void rtw89_pci_ctrl_wpdma_pcie_be(struct rtw89_dev *rtwdev, bool en)
+{
+	if (en)
+		rtw89_write32_clr(rtwdev, R_BE_HAXI_DMA_STOP1, B_BE_STOP_WPDMA);
+	else
+		rtw89_write32_set(rtwdev, R_BE_HAXI_DMA_STOP1, B_BE_STOP_WPDMA);
+}
+
+static void rtw89_pci_ctrl_trxdma_pcie_be(struct rtw89_dev *rtwdev,
+					  enum mac_ax_pcie_func_ctrl tx_en,
+					  enum mac_ax_pcie_func_ctrl rx_en,
+					  enum mac_ax_pcie_func_ctrl io_en)
+{
+	u32 val;
+
+	val = rtw89_read32(rtwdev, R_BE_HAXI_INIT_CFG1);
+
+	if (tx_en == MAC_AX_PCIE_ENABLE)
+		val |= B_BE_TXDMA_EN;
+	else if (tx_en == MAC_AX_PCIE_DISABLE)
+		val &= ~B_BE_TXDMA_EN;
+
+	if (rx_en == MAC_AX_PCIE_ENABLE)
+		val |= B_BE_RXDMA_EN;
+	else if (rx_en == MAC_AX_PCIE_DISABLE)
+		val &= ~B_BE_RXDMA_EN;
+
+	if (io_en == MAC_AX_PCIE_ENABLE)
+		val &= ~B_BE_STOP_AXI_MST;
+	else if (io_en == MAC_AX_PCIE_DISABLE)
+		val |= B_BE_STOP_AXI_MST;
+
+	rtw89_write32(rtwdev, R_BE_HAXI_INIT_CFG1, val);
+}
+
+static void rtw89_pci_clr_idx_all_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct rtw89_pci_rx_ring *rx_ring;
+	u32 val;
+
+	val = B_BE_CLR_CH0_IDX | B_BE_CLR_CH1_IDX | B_BE_CLR_CH2_IDX |
+	      B_BE_CLR_CH3_IDX | B_BE_CLR_CH4_IDX | B_BE_CLR_CH5_IDX |
+	      B_BE_CLR_CH6_IDX | B_BE_CLR_CH7_IDX | B_BE_CLR_CH8_IDX |
+	      B_BE_CLR_CH9_IDX | B_BE_CLR_CH10_IDX | B_BE_CLR_CH11_IDX |
+	      B_BE_CLR_CH12_IDX | B_BE_CLR_CH13_IDX | B_BE_CLR_CH14_IDX;
+	rtw89_write32(rtwdev, R_BE_TXBD_RWPTR_CLR1, val);
+
+	rtw89_write32(rtwdev, R_BE_RXBD_RWPTR_CLR1_V1,
+		      B_BE_CLR_RXQ0_IDX | B_BE_CLR_RPQ0_IDX);
+
+	rx_ring = &rtwpci->rx_rings[RTW89_RXCH_RXQ];
+	rtw89_write16(rtwdev, R_BE_RXQ0_RXBD_IDX_V1, rx_ring->bd_ring.len - 1);
+
+	rx_ring = &rtwpci->rx_rings[RTW89_RXCH_RPQ];
+	rtw89_write16(rtwdev, R_BE_RPQ0_RXBD_IDX_V1, rx_ring->bd_ring.len - 1);
+}
+
+static int rtw89_pci_poll_txdma_ch_idle_be(struct rtw89_dev *rtwdev)
+{
+	u32 val;
+
+	return read_poll_timeout(rtw89_read32, val, (val & DMA_BUSY1_CHECK_BE) == 0,
+				 10, 1000, false, rtwdev, R_BE_HAXI_DMA_BUSY1);
+}
+
+static int rtw89_pci_poll_rxdma_ch_idle_be(struct rtw89_dev *rtwdev)
+{
+	u32 check;
+	u32 val;
+
+	check = B_BE_RXQ0_BUSY_V1 | B_BE_RPQ0_BUSY_V1;
+
+	return read_poll_timeout(rtw89_read32, val, (val & check) == 0,
+				 10, 1000, false, rtwdev, R_BE_HAXI_DMA_BUSY1);
+}
+
+static int rtw89_pci_poll_dma_all_idle_be(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = rtw89_pci_poll_txdma_ch_idle_be(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "txdma ch busy\n");
+		return ret;
+	}
+
+	ret = rtw89_pci_poll_rxdma_ch_idle_be(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "rxdma ch busy\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void rtw89_pci_mode_op_be(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	u32 val32_init1, val32_rxapp, val32_exp;
+
+	val32_init1 = rtw89_read32(rtwdev, R_BE_HAXI_INIT_CFG1);
+	val32_rxapp = rtw89_read32(rtwdev, R_BE_RX_APPEND_MODE);
+	val32_exp = rtw89_read32(rtwdev, R_BE_HAXI_EXP_CTRL_V1);
+
+	if (info->rxbd_mode == MAC_AX_RXBD_PKT) {
+		val32_init1 = u32_replace_bits(val32_init1, PCIE_RXBD_NORM,
+					       B_BE_RXQ_RXBD_MODE_MASK);
+	} else if (info->rxbd_mode == MAC_AX_RXBD_SEP) {
+		val32_init1 = u32_replace_bits(val32_init1, PCIE_RXBD_SEP,
+					       B_BE_RXQ_RXBD_MODE_MASK);
+		val32_rxapp = u32_replace_bits(val32_rxapp, 0,
+					       B_BE_APPEND_LEN_MASK);
+	}
+
+	val32_init1 = u32_replace_bits(val32_init1, info->tx_burst,
+				       B_BE_MAX_TXDMA_MASK);
+	val32_init1 = u32_replace_bits(val32_init1, info->rx_burst,
+				       B_BE_MAX_RXDMA_MASK);
+	val32_exp = u32_replace_bits(val32_exp, info->multi_tag_num,
+				     B_BE_MAX_TAG_NUM_MASK);
+	val32_init1 = u32_replace_bits(val32_init1, info->wd_dma_idle_intvl,
+				       B_BE_CFG_WD_PERIOD_IDLE_MASK);
+	val32_init1 = u32_replace_bits(val32_init1, info->wd_dma_act_intvl,
+				       B_BE_CFG_WD_PERIOD_ACTIVE_MASK);
+
+	rtw89_write32(rtwdev, R_BE_HAXI_INIT_CFG1, val32_init1);
+	rtw89_write32(rtwdev, R_BE_RX_APPEND_MODE, val32_rxapp);
+	rtw89_write32(rtwdev, R_BE_HAXI_EXP_CTRL_V1, val32_exp);
+}
+
+static int rtw89_pci_rst_bdram_be(struct rtw89_dev *rtwdev)
+{
+	u32 val;
+
+	rtw89_write32_set(rtwdev, R_BE_HAXI_INIT_CFG1, B_BE_SET_BDRAM_BOUND);
+
+	return read_poll_timeout(rtw89_read32, val, !(val & B_BE_SET_BDRAM_BOUND),
+				 50, 500000, false, rtwdev, R_BE_HAXI_INIT_CFG1);
+}
+
+static void rtw89_pci_debounce_be(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+
+	val32 = rtw89_read32(rtwdev, R_BE_SYS_PAGE_CLK_GATED);
+	val32 = u32_replace_bits(val32, 0, B_BE_PCIE_PRST_DEBUNC_PERIOD_MASK);
+	val32 |= B_BE_SYM_PRST_DEBUNC_SEL;
+	rtw89_write32(rtwdev, R_BE_SYS_PAGE_CLK_GATED, val32);
+}
+
+static void rtw89_pci_ldo_low_pwr_be(struct rtw89_dev *rtwdev)
+{
+	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_PSUS_OFF_CAPC_EN);
+	rtw89_write32_set(rtwdev, R_BE_SYS_PAGE_CLK_GATED,
+			  B_BE_SOP_OFFPOOBS_PC | B_BE_CPHY_AUXCLK_OP |
+			  B_BE_CPHY_POWER_READY_CHK);
+	rtw89_write32_clr(rtwdev, R_BE_SYS_SDIO_CTRL, B_BE_PCIE_FORCE_IBX_EN |
+						      B_BE_PCIE_DIS_L2_RTK_PERST |
+						      B_BE_PCIE_DIS_L2__CTRL_LDO_HCI);
+	rtw89_write32_clr(rtwdev, R_BE_L1_2_CTRL_HCILDO, B_BE_PCIE_DIS_L1_2_CTRL_HCILDO);
+}
+
+static void rtw89_pci_pcie_setting_be(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	rtw89_write32_set(rtwdev, R_BE_PCIE_FRZ_CLK, B_BE_PCIE_EN_AUX_CLK);
+	rtw89_write32_clr(rtwdev, R_BE_PCIE_PS_CTRL, B_BE_CMAC_EXIT_L1_EN);
+
+	if (chip->chip_id == RTL8922A && hal->cv == CHIP_CAV)
+		return;
+
+	rtw89_write32_set(rtwdev, R_BE_EFUSE_CTRL_2_V1, B_BE_R_SYM_AUTOLOAD_WITH_PMC_SEL);
+	rtw89_write32_set(rtwdev, R_BE_PCIE_LAT_CTRL, B_BE_SYM_AUX_CLK_SEL);
+}
+
+static void rtw89_pci_ser_setting_be(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+
+	rtw89_write32(rtwdev, R_BE_PL1_DBG_INFO, 0x0);
+	rtw89_write32_set(rtwdev, R_BE_FWS1IMR, B_BE_PCIE_SER_TIMEOUT_INDIC_EN);
+	rtw89_write32_set(rtwdev, R_BE_SER_PL1_CTRL, B_BE_PL1_SER_PL1_EN);
+
+	val32 = rtw89_read32(rtwdev, R_BE_REG_PL1_MASK);
+	val32 |= B_BE_SER_PMU_IMR | B_BE_SER_L1SUB_IMR | B_BE_SER_PM_MASTER_IMR |
+		 B_BE_SER_LTSSM_IMR | B_BE_SER_PM_CLK_MASK | B_BE_SER_PCLKREQ_ACK_MASK;
+	rtw89_write32(rtwdev, R_BE_REG_PL1_MASK, val32);
+}
+
+static void rtw89_pci_ctrl_txdma_ch_be(struct rtw89_dev *rtwdev, bool all_en,
+				       bool h2c_en)
+{
+	u32 mask_all;
+	u32 val;
+
+	mask_all = B_BE_STOP_CH0 | B_BE_STOP_CH1 | B_BE_STOP_CH2 |
+		   B_BE_STOP_CH3 | B_BE_STOP_CH4 | B_BE_STOP_CH5 |
+		   B_BE_STOP_CH6 | B_BE_STOP_CH7 | B_BE_STOP_CH8 |
+		   B_BE_STOP_CH9 | B_BE_STOP_CH10 | B_BE_STOP_CH11;
+
+	val = rtw89_read32(rtwdev, R_BE_HAXI_DMA_STOP1);
+	val |= B_BE_STOP_CH13 | B_BE_STOP_CH14;
+
+	if (all_en)
+		val &= ~mask_all;
+	else
+		val |= mask_all;
+
+	if (h2c_en)
+		val &= ~B_BE_STOP_CH12;
+	else
+		val |= B_BE_STOP_CH12;
+
+	rtw89_write32(rtwdev, R_BE_HAXI_DMA_STOP1, val);
+}
+
+static int rtw89_pci_ops_mac_pre_init_be(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtw89_pci_set_io_rcy_be(rtwdev);
+	_patch_pcie_power_wake_be(rtwdev, true);
+	rtw89_pci_ctrl_wpdma_pcie_be(rtwdev, false);
+	rtw89_pci_ctrl_trxdma_pcie_be(rtwdev, MAC_AX_PCIE_DISABLE,
+				      MAC_AX_PCIE_DISABLE, MAC_AX_PCIE_DISABLE);
+	rtw89_pci_clr_idx_all_be(rtwdev);
+
+	ret = rtw89_pci_poll_dma_all_idle_be(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR] poll pcie dma all idle\n");
+		return ret;
+	}
+
+	rtw89_pci_mode_op_be(rtwdev);
+	rtw89_pci_ops_reset(rtwdev);
+
+	ret = rtw89_pci_rst_bdram_be(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]pcie rst bdram\n");
+		return ret;
+	}
+
+	rtw89_pci_debounce_be(rtwdev);
+	rtw89_pci_ldo_low_pwr_be(rtwdev);
+	rtw89_pci_pcie_setting_be(rtwdev);
+	rtw89_pci_ser_setting_be(rtwdev);
+
+	rtw89_pci_ctrl_txdma_ch_be(rtwdev, false, true);
+	rtw89_pci_ctrl_trxdma_pcie_be(rtwdev, MAC_AX_PCIE_ENABLE,
+				      MAC_AX_PCIE_ENABLE, MAC_AX_PCIE_ENABLE);
+
+	return 0;
+}
+
 const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
+	.mac_pre_init = rtw89_pci_ops_mac_pre_init_be,
+
+	.clr_idx_all = rtw89_pci_clr_idx_all_be,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index b509e9582ccf..58b0e09b07aa 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -116,6 +116,7 @@
 #define B_AX_LTE_MUX_CTRL_PATH BIT(26)
 
 #define R_AX_HCI_OPT_CTRL 0x0074
+#define BIT_WAKE_CTRL_V1 BIT(23)
 #define BIT_WAKE_CTRL BIT(5)
 
 #define R_AX_HCI_BG_CTRL 0x0078
@@ -3629,6 +3630,33 @@
 #define B_AX_GNT_BT_TX_SW_VAL BIT(1)
 #define B_AX_GNT_BT_TX_SW_CTRL BIT(0)
 
+#define R_BE_SYS_PW_CTRL 0x0004
+#define B_BE_SOP_ASWRM BIT(31)
+#define B_BE_SOP_EASWR BIT(30)
+#define B_BE_SOP_PWMM_DSWR BIT(29)
+#define B_BE_SOP_EDSWR BIT(28)
+#define B_BE_SOP_ACKF BIT(27)
+#define B_BE_SOP_ERCK BIT(26)
+#define B_BE_SOP_ANA_CLK_DIVISION_2 BIT(25)
+#define B_BE_SOP_EXTL BIT(24)
+#define B_BE_SOP_OFF_CAPC_EN BIT(23)
+#define B_BE_XTAL_OFF_A_DIE BIT(22)
+#define B_BE_ROP_SWPR BIT(21)
+#define B_BE_DIS_HW_LPLDM BIT(20)
+#define B_BE_DIS_HW_LPURLDO BIT(19)
+#define B_BE_DIS_WLBT_PDNSUSEN_SOPC BIT(18)
+#define B_BE_RDY_SYSPWR BIT(17)
+#define B_BE_EN_WLON BIT(16)
+#define B_BE_APDM_HPDN BIT(15)
+#define B_BE_PSUS_OFF_CAPC_EN BIT(14)
+#define B_BE_AFSM_PCIE_SUS_EN BIT(12)
+#define B_BE_AFSM_WLSUS_EN BIT(11)
+#define B_BE_APFM_SWLPS BIT(10)
+#define B_BE_APFM_OFFMAC BIT(9)
+#define B_BE_APFN_ONMAC BIT(8)
+#define B_BE_CHIP_PDN_EN BIT(7)
+#define B_BE_RDY_MACDIS BIT(6)
+
 #define R_BE_SYS_CLK_CTRL 0x0008
 #define B_BE_CPU_CLK_EN BIT(14)
 #define B_BE_SYMR_BE_CLK_EN BIT(13)
@@ -3639,6 +3667,90 @@
 #define B_BE_ANA_CLK_DIVISION_2 BIT(1)
 #define B_BE_CNTD16V_EN BIT(0)
 
+#define R_BE_SYS_PAGE_CLK_GATED 0x000C
+#define B_BE_USB_APHY_PC_DLP_OP BIT(27)
+#define B_BE_PCIE_APHY_PC_DLP_OP BIT(26)
+#define B_BE_UPHY_POWER_READY_CHK BIT(25)
+#define B_BE_CPHY_POWER_READY_CHK BIT(24)
+#define B_BE_PCIE_PRST_DEBUNC_PERIOD_MASK GENMASK(23, 22)
+#define B_BE_SYM_PRST_DEBUNC_SEL BIT(21)
+#define B_BE_CPHY_AUXCLK_OP BIT(20)
+#define B_BE_SOP_OFFUA_PC BIT(19)
+#define B_BE_SOP_OFFPOOBS_PC BIT(18)
+#define B_BE_PCIE_LAN1_MASK BIT(17)
+#define B_BE_PCIE_LAN0_MASK BIT(16)
+#define B_BE_DIS_CLK_REGF_GATE BIT(15)
+#define B_BE_DIS_CLK_REGE_GATE BIT(14)
+#define B_BE_DIS_CLK_REGD_GATE BIT(13)
+#define B_BE_DIS_CLK_REGC_GATE BIT(12)
+#define B_BE_DIS_CLK_REGB_GATE BIT(11)
+#define B_BE_DIS_CLK_REGA_GATE BIT(10)
+#define B_BE_DIS_CLK_REG9_GATE BIT(9)
+#define B_BE_DIS_CLK_REG8_GATE BIT(8)
+#define B_BE_DIS_CLK_REG7_GATE BIT(7)
+#define B_BE_DIS_CLK_REG6_GATE BIT(6)
+#define B_BE_DIS_CLK_REG5_GATE BIT(5)
+#define B_BE_DIS_CLK_REG4_GATE BIT(4)
+#define B_BE_DIS_CLK_REG3_GATE BIT(3)
+#define B_BE_DIS_CLK_REG2_GATE BIT(2)
+#define B_BE_DIS_CLK_REG1_GATE BIT(1)
+#define B_BE_DIS_CLK_REG0_GATE BIT(0)
+
+#define R_BE_SYS_SDIO_CTRL 0x0070
+#define B_BE_MCM_FLASH_EN BIT(28)
+#define B_BE_PCIE_SEC_LOAD BIT(26)
+#define B_BE_PCIE_SER_RSTB BIT(25)
+#define B_BE_PCIE_SEC_LOAD_CLR BIT(24)
+#define B_BE_SDIO_CMD_SW_RST BIT(20)
+#define B_BE_SDIO_INT_POLARITY BIT(19)
+#define B_BE_SDIO_OFF_EN BIT(17)
+#define B_BE_SDIO_ON_EN BIT(16)
+#define B_BE_PCIE_DIS_L2__CTRL_LDO_HCI BIT(15)
+#define B_BE_PCIE_DIS_L2_RTK_PERST BIT(14)
+#define B_BE_PCIE_FORCE_PWR_NGAT BIT(13)
+#define B_BE_PCIE_FORCE_IBX_EN BIT(12)
+#define B_BE_PCIE_AUXCLK_GATE BIT(11)
+#define B_BE_PCIE_WAIT_TIMEOUT_EVENT BIT(10)
+#define B_BE_PCIE_WAIT_TIME BIT(9)
+#define B_BE_L1OFF_TO_L0_RESUME_EVT BIT(8)
+#define B_BE_USBA_FORCE_PWR_NGAT BIT(7)
+#define B_BE_USBD_FORCE_PWR_NGAT BIT(6)
+#define B_BE_BT_CTRL_USB_PWR BIT(5)
+#define B_BE_USB_D_STATE_HOLD BIT(4)
+#define B_BE_R_BE_FORCE_DP BIT(3)
+#define B_BE_R_BE_DP_MODE BIT(2)
+#define B_BE_RES_USB_MASS_STORAGE_DESC BIT(1)
+#define B_BE_USB_WAIT_TIME BIT(0)
+
+#define R_BE_HCI_OPT_CTRL 0x0074
+#define B_BE_HCI_WLAN_IO_ST BIT(31)
+#define B_BE_HCI_WLAN_IO_EN BIT(28)
+#define B_BE_HAXIDMA_IO_ST BIT(27)
+#define B_BE_HAXIDMA_BACKUP_RESTORE_ST BIT(26)
+#define B_BE_HAXIDMA_IO_EN BIT(24)
+#define B_BE_EN_PCIE_WAKE BIT(23)
+#define B_BE_SDIO_PAD_H3L1 BIT(22)
+#define B_BE_USBMAC_ANACLK_SW BIT(21)
+#define B_BE_PCIE_CPHY_CCK_XTAL_SEL BIT(20)
+#define B_BE_SDIO_DATA_PAD_SMT BIT(19)
+#define B_BE_SDIO_PAD_E5 BIT(18)
+#define B_BE_FORCE_PCIE_AUXCLK BIT(17)
+#define B_BE_HCI_LA_ADDR_MAP BIT(16)
+#define B_BE_HCI_LA_GLO_RST BIT(15)
+#define B_BE_USB3_SUS_DIS BIT(14)
+#define B_BE_NOPWR_CTRL_SEL BIT(13)
+#define B_BE_USB_HOST_PWR_OFF_EN BIT(12)
+#define B_BE_SYM_LPS_BLOCK_EN BIT(11)
+#define B_BE_USB_LPM_ACT_EN BIT(10)
+#define B_BE_USB_LPM_NY BIT(9)
+#define B_BE_USB2_SUS_DIS BIT(8)
+#define B_BE_SDIO_PAD_E_MASK GENMASK(7, 5)
+#define B_BE_USB_LPPLL_EN BIT(4)
+#define B_BE_USB1_1_USB2_0_DECISION BIT(3)
+#define B_BE_ROP_SW15 BIT(2)
+#define B_BE_PCI_CKRDY_OPT BIT(1)
+#define B_BE_PCI_VAUX_EN BIT(0)
+
 #define R_BE_PLATFORM_ENABLE 0x0088
 #define B_BE_HOLD_AFTER_RESET BIT(11)
 #define B_BE_SYM_WLPLT_MEM_MUX_EN BIT(10)
@@ -3652,6 +3764,22 @@
 #define B_BE_WCPU_EN BIT(1)
 #define B_BE_PLATFORM_EN BIT(0)
 
+#define R_BE_EFUSE_CTRL_2_V1 0x00A4
+#define B_BE_EF_ENT BIT(31)
+#define B_BE_EF_TCOLUMN_EN BIT(29)
+#define B_BE_BT_OTP_PWC_DIS BIT(28)
+#define B_BE_EF_RDT BIT(27)
+#define B_BE_R_SYM_AUTOLOAD_WITH_PMC_SEL BIT(24)
+#define B_BE_EF_PGTS_MASK GENMASK(23, 20)
+#define B_BE_EF_BURST BIT(19)
+#define B_BE_EF_TEST_SEL_MASK GENMASK(18, 16)
+#define B_BE_EF_TROW_EN BIT(15)
+#define B_BE_EF_ERR_FLAG BIT(14)
+#define B_BE_EF_FBURST_DIS BIT(13)
+#define B_BE_EF_HT_SEL BIT(12)
+#define B_BE_EF_DSB_EN BIT(11)
+#define B_BE_EF_DLY_SEL_MASK GENMASK(3, 0)
+
 #define R_BE_HALT_H2C_CTRL 0x0160
 #define B_BE_HALT_H2C_TRIGGER BIT(0)
 
@@ -3676,6 +3804,28 @@
 
 #define R_BE_SECURE_BOOT_MALLOC_INFO 0x0184
 
+#define R_BE_FWS1IMR 0x0198
+#define B_BE_FS_RPWM_INT_EN_V1 BIT(24)
+#define B_BE_PCIE_HOTRST_EN BIT(22)
+#define B_BE_PCIE_SER_TIMEOUT_INDIC_EN BIT(21)
+#define B_BE_PCIE_RXI300_SLVTOUT_INDIC_EN BIT(20)
+#define B_BE_AON_PCIE_FLR_INT_EN BIT(19)
+#define B_BE_PCIE_ERR_INDIC_INT_EN BIT(18)
+#define B_BE_SDIO_ERR_INDIC_INT_EN BIT(17)
+#define B_BE_USB_ERR_INDIC_INT_EN BIT(16)
+#define B_BE_FS_GPIO27_INT_EN BIT(11)
+#define B_BE_FS_GPIO26_INT_EN BIT(10)
+#define B_BE_FS_GPIO25_INT_EN BIT(9)
+#define B_BE_FS_GPIO24_INT_EN BIT(8)
+#define B_BE_FS_GPIO23_INT_EN BIT(7)
+#define B_BE_FS_GPIO22_INT_EN BIT(6)
+#define B_BE_FS_GPIO21_INT_EN BIT(5)
+#define B_BE_FS_GPIO20_INT_EN BIT(4)
+#define B_BE_FS_GPIO19_INT_EN BIT(3)
+#define B_BE_FS_GPIO18_INT_EN BIT(2)
+#define B_BE_FS_GPIO17_INT_EN BIT(1)
+#define B_BE_FS_GPIO16_INT_EN BIT(0)
+
 #define R_BE_WCPU_FW_CTRL 0x01E0
 #define B_BE_RUN_ENV_MASK GENMASK(31, 30)
 #define B_BE_WCPU_FWDL_STATUS_MASK GENMASK(29, 26)
@@ -3732,6 +3882,84 @@
 
 #define R_BE_FILTER_MODEL_ADDR 0x0C04
 
+#define R_BE_WLAN_WDT 0x3050
+#define B_BE_WLAN_WDT_TIMEOUT BIT(31)
+#define B_BE_WLAN_WDT_TIMER_CLEAR BIT(4)
+#define B_BE_WLAN_WDT_BYPASS BIT(1)
+#define B_BE_WLAN_WDT_ENABLE BIT(0)
+
+#define R_BE_AXIDMA_WDT 0x305C
+#define B_BE_AXIDMA_WDT_TIMEOUT BIT(31)
+#define B_BE_AXIDMA_WDT_TIMER_CLEAR BIT(4)
+#define B_BE_AXIDMA_WDT_BYPASS BIT(1)
+#define B_BE_AXIDMA_WDT_ENABLE BIT(0)
+
+#define R_BE_AON_WDT 0x3068
+#define B_BE_AON_WDT_TIMEOUT BIT(31)
+#define B_BE_AON_WDT_TIMER_CLEAR BIT(4)
+#define B_BE_AON_WDT_BYPASS BIT(1)
+#define B_BE_AON_WDT_ENABLE BIT(0)
+
+#define R_BE_AON_WDT_TMR 0x306C
+#define R_BE_MDIO_WDT_TMR 0x3090
+#define R_BE_LA_MODE_WDT_TMR 0x309C
+#define R_BE_WDT_AR_TMR 0x3144
+#define R_BE_WDT_AW_TMR 0x3150
+#define R_BE_WLAN_WDT_TMR 0x3054
+#define R_BE_WDT_W_TMR 0x315C
+#define R_BE_AXIDMA_WDT_TMR 0x3060
+#define R_BE_WDT_B_TMR 0x3164
+#define R_BE_WDT_R_TMR 0x316C
+#define R_BE_LOCAL_WDT_TMR 0x3084
+
+#define R_BE_LOCAL_WDT 0x3080
+#define B_BE_LOCAL_WDT_TIMEOUT BIT(31)
+#define B_BE_LOCAL_WDT_TIMER_CLEAR BIT(4)
+#define B_BE_LOCAL_WDT_BYPASS BIT(1)
+#define B_BE_LOCAL_WDT_ENABLE BIT(0)
+
+#define R_BE_MDIO_WDT 0x308C
+#define B_BE_MDIO_WDT_TIMEOUT BIT(31)
+#define B_BE_MDIO_WDT_TIMER_CLEAR BIT(4)
+#define B_BE_MDIO_WDT_BYPASS BIT(1)
+#define B_BE_MDIO_WDT_ENABLE BIT(0)
+
+#define R_BE_LA_MODE_WDT 0x3098
+#define B_BE_LA_MODE_WDT_TIMEOUT BIT(31)
+#define B_BE_LA_MODE_WDT_TIMER_CLEAR BIT(4)
+#define B_BE_LA_MODE_WDT_BYPASS BIT(1)
+#define B_BE_LA_MODE_WDT_ENABLE BIT(0)
+
+#define R_BE_WDT_AR 0x3140
+#define B_BE_WDT_AR_TIMEOUT BIT(31)
+#define B_BE_WDT_AR_TIMER_CLEAR BIT(4)
+#define B_BE_WDT_AR_BYPASS BIT(1)
+#define B_BE_WDT_AR_ENABLE BIT(0)
+
+#define R_BE_WDT_AW 0x314C
+#define B_BE_WDT_AW_TIMEOUT BIT(31)
+#define B_BE_WDT_AW_TIMER_CLEAR BIT(4)
+#define B_BE_WDT_AW_BYPASS BIT(1)
+#define B_BE_WDT_AW_ENABLE BIT(0)
+
+#define R_BE_WDT_W 0x3158
+#define B_BE_WDT_W_TIMEOUT BIT(31)
+#define B_BE_WDT_W_TIMER_CLEAR BIT(4)
+#define B_BE_WDT_W_BYPASS BIT(1)
+#define B_BE_WDT_W_ENABLE BIT(0)
+
+#define R_BE_WDT_B 0x3160
+#define B_BE_WDT_B_TIMEOUT BIT(31)
+#define B_BE_WDT_B_TIMER_CLEAR BIT(4)
+#define B_BE_WDT_B_BYPASS BIT(1)
+#define B_BE_WDT_B_ENABLE BIT(0)
+
+#define R_BE_WDT_R 0x3168
+#define B_BE_WDT_R_TIMEOUT BIT(31)
+#define B_BE_WDT_R_TIMER_CLEAR BIT(4)
+#define B_BE_WDT_R_BYPASS BIT(1)
+#define B_BE_WDT_R_ENABLE BIT(0)
+
 #define R_BE_PLE_DBG_FUN_INTF_CTL 0x9110
 #define B_BE_PLE_DFI_ACTIVE BIT(31)
 #define B_BE_PLE_DFI_TRGSEL_MASK GENMASK(19, 16)
-- 
2.25.1

