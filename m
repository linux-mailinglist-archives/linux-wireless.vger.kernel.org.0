Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E292E188AB8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 17:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgCQQmU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 12:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgCQQmT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 12:42:19 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB0F20754;
        Tue, 17 Mar 2020 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584463338;
        bh=HO3zG6XaIXZeHAspbsrvN3fJKlyf1sWBMvHaRPJQT9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nmxcsTn2qDUaZPTW9uCd8JWhgyyh4/YqtpwBnM+EYOoFso2r0oK3kcmLPp/jK2HME
         Tw4F58c1Z4XleRYGjiMD7TBn2rIpVCUjEmvScvfJrVjDKJcher8QmZE+mqIdrNEO2+
         R/rj2CK5AQNV9mKsWhlzq50vAIM6ktb6lOiNHpfI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 14/25] mt76: mt7615: introduce mt7615_register_map
Date:   Tue, 17 Mar 2020 17:41:21 +0100
Message-Id: <aff134a807023fe6fafbc746a83f06773d8ac23e.1584463004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584463004.git.lorenzo@kernel.org>
References: <cover.1584463004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to reuse mt7615 code adding support for mt7663e driver,
introduce mt7615e_reg_map since mt7663e and mt7615 rely on a
different base registers definitions.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 14 ++--
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  | 27 ++++++-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 72 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7615/soc.c   |  2 +-
 6 files changed, 91 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 6c36585c3423..4d5171044b1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -703,9 +703,9 @@ void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 		mt7615_txp_skb_unmap_hw(dev, &txp->hw);
 }
 
-static u32 mt7615_mac_wtbl_addr(int wcid)
+static u32 mt7615_mac_wtbl_addr(struct mt7615_dev *dev, int wcid)
 {
-	return MT_WTBL_BASE + wcid * MT_WTBL_ENTRY_SIZE;
+	return MT_WTBL_BASE(dev) + wcid * MT_WTBL_ENTRY_SIZE;
 }
 
 bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask)
@@ -751,7 +751,7 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 		list_del_init(&msta->poll_list);
 		spin_unlock_bh(&dev->sta_poll_lock);
 
-		addr = mt7615_mac_wtbl_addr(msta->wcid.idx) + 19 * 4;
+		addr = mt7615_mac_wtbl_addr(dev, msta->wcid.idx) + 19 * 4;
 
 		for (i = 0; i < 4; i++, addr += 8) {
 			u32 tx_last = msta->airtime_ac[i];
@@ -801,7 +801,7 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 	struct mt76_phy *mphy = phy->mt76;
 	struct ieee80211_tx_rate *ref;
 	int wcid = sta->wcid.idx;
-	u32 addr = mt7615_mac_wtbl_addr(wcid);
+	u32 addr = mt7615_mac_wtbl_addr(dev, wcid);
 	bool stbc = false;
 	int n_rates = sta->n_rates;
 	u8 bw, bw_prev, bw_idx = 0;
@@ -966,7 +966,7 @@ mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			   enum mt7615_cipher_type cipher,
 			   enum set_key_cmd cmd)
 {
-	u32 addr = mt7615_mac_wtbl_addr(wcid->idx) + 30 * 4;
+	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx) + 30 * 4;
 	u8 data[32] = {};
 
 	if (key->keylen > sizeof(data))
@@ -1004,7 +1004,7 @@ mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			  enum mt7615_cipher_type cipher, int keyidx,
 			  enum set_key_cmd cmd)
 {
-	u32 addr = mt7615_mac_wtbl_addr(wcid->idx), w0, w1;
+	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx), w0, w1;
 
 	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
 		return -ETIMEDOUT;
@@ -1040,7 +1040,7 @@ mt7615_mac_wtbl_update_cipher(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			      enum mt7615_cipher_type cipher,
 			      enum set_key_cmd cmd)
 {
-	u32 addr = mt7615_mac_wtbl_addr(wcid->idx);
+	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx);
 
 	if (cmd == SET_KEY) {
 		if (cipher != MT_CIPHER_BIP_CMAC_128 || !wcid->cipher)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 0b445471b6e8..fb4a76270ad4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -2,9 +2,32 @@
 #include <linux/module.h>
 
 #include "mt7615.h"
+#include "regs.h"
 #include "mac.h"
 #include "../trace.h"
 
+const u32 mt7615e_reg_map[] = {
+	[MT_TOP_CFG_BASE]	= 0x01000,
+	[MT_HW_BASE]		= 0x01000,
+	[MT_PCIE_REMAP_2]	= 0x02504,
+	[MT_HIF_BASE]		= 0x04000,
+	[MT_CSR_BASE]		= 0x07000,
+	[MT_PHY_BASE]		= 0x10000,
+	[MT_CFG_BASE]		= 0x20200,
+	[MT_AGG_BASE]		= 0x20a00,
+	[MT_TMAC_BASE]		= 0x21000,
+	[MT_RMAC_BASE]		= 0x21200,
+	[MT_DMA_BASE]		= 0x21800,
+	[MT_WTBL_BASE_ON]	= 0x23000,
+	[MT_WTBL_BASE_OFF]	= 0x23400,
+	[MT_LPON_BASE]		= 0x24200,
+	[MT_MIB_BASE]		= 0x24800,
+	[MT_WTBL_BASE_ADDR]	= 0x30000,
+	[MT_PCIE_REMAP_BASE2]	= 0x80000,
+	[MT_TOP_MISC_BASE]	= 0xc0000,
+	[MT_EFUSE_ADDR_BASE]	= 0x81070000,
+};
+
 u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr)
 {
 	u32 base = addr & MT_MCU_PCIE_REMAP_2_BASE;
@@ -66,7 +89,8 @@ static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
-int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base, int irq)
+int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
+		      int irq, const u32 *map)
 {
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
@@ -95,6 +119,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base, int irq)
 	dev = container_of(mdev, struct mt7615_dev, mt76);
 	mt76_mmio_init(&dev->mt76, mem_base);
 
+	dev->reg_map = map;
 	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
 		    (mt76_rr(dev, MT_HW_REV) & 0xff);
 	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index e51b6ab6ebb8..c03ad0409f43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -185,6 +185,7 @@ struct mt7615_dev {
 
 	const struct mt7615_mcu_ops *mcu_ops;
 	struct regmap *infracfg;
+	const u32 *reg_map;
 
 	struct work_struct mcu_work;
 
@@ -285,6 +286,7 @@ mt7615_ext_phy(struct mt7615_dev *dev)
 }
 
 extern const struct ieee80211_ops mt7615_ops;
+extern const u32 mt7615e_reg_map[__MT_BASE_MAX];
 extern struct pci_driver mt7615_pci_driver;
 extern struct platform_driver mt7622_wmac_driver;
 
@@ -297,7 +299,8 @@ static inline int mt7622_wmac_init(struct mt7615_dev *dev)
 }
 #endif
 
-int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base, int irq);
+int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
+		      int irq, const u32 *map);
 u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
 
 void mt7615_init_device(struct mt7615_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 43e02128cc48..d20db968c7ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -35,7 +35,8 @@ static int mt7615_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	return mt7615_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0], pdev->irq);
+	return mt7615_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
+				 pdev->irq, mt7615e_reg_map);
 }
 
 static void mt7615_pci_remove(struct pci_dev *pdev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index fe68f6b2cbf8..b422a9c71089 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -4,15 +4,40 @@
 #ifndef __MT7615_REGS_H
 #define __MT7615_REGS_H
 
-#define MT_HW_REV			0x1000
-#define MT_HW_CHIPID			0x1008
-#define MT_TOP_STRAP_STA		0x1010
+enum mt7615_reg_base {
+	MT_TOP_CFG_BASE,
+	MT_HW_BASE,
+	MT_PCIE_REMAP_2,
+	MT_HIF_BASE,
+	MT_CSR_BASE,
+	MT_PHY_BASE,
+	MT_CFG_BASE,
+	MT_AGG_BASE,
+	MT_TMAC_BASE,
+	MT_RMAC_BASE,
+	MT_DMA_BASE,
+	MT_WTBL_BASE_ON,
+	MT_WTBL_BASE_OFF,
+	MT_LPON_BASE,
+	MT_MIB_BASE,
+	MT_WTBL_BASE_ADDR,
+	MT_PCIE_REMAP_BASE2,
+	MT_TOP_MISC_BASE,
+	MT_EFUSE_ADDR_BASE,
+	__MT_BASE_MAX,
+};
+
+#define MT_HW_INFO_BASE			((dev)->reg_map[MT_HW_BASE])
+#define MT_HW_INFO(ofs)			(MT_HW_INFO_BASE + (ofs))
+#define MT_HW_REV			MT_HW_INFO(0x000)
+#define MT_HW_CHIPID			MT_HW_INFO(0x008)
+#define MT_TOP_STRAP_STA		MT_HW_INFO(0x010)
 #define MT_TOP_3NSS			BIT(24)
 
 #define MT_TOP_OFF_RSV			0x1128
 #define MT_TOP_OFF_RSV_FW_STATE		GENMASK(18, 16)
 
-#define MT_TOP_MISC2			0x1134
+#define MT_TOP_MISC2			((dev)->reg_map[MT_TOP_CFG_BASE] + 0x134)
 #define MT_TOP_MISC2_FW_STATE		GENMASK(2, 0)
 
 #define MT_MCU_BASE			0x2000
@@ -23,13 +48,12 @@
 #define MT_MCU_PCIE_REMAP_1_BASE	GENMASK(31, 18)
 #define MT_PCIE_REMAP_BASE_1		0x40000
 
-#define MT_MCU_PCIE_REMAP_2		MT_MCU(0x504)
+#define MT_MCU_PCIE_REMAP_2		((dev)->reg_map[MT_PCIE_REMAP_2])
 #define MT_MCU_PCIE_REMAP_2_OFFSET	GENMASK(18, 0)
 #define MT_MCU_PCIE_REMAP_2_BASE	GENMASK(31, 19)
-#define MT_PCIE_REMAP_BASE_2		0x80000
+#define MT_PCIE_REMAP_BASE_2		((dev)->reg_map[MT_PCIE_REMAP_BASE2])
 
-#define MT_HIF_BASE			0x4000
-#define MT_HIF(ofs)			(MT_HIF_BASE + (ofs))
+#define MT_HIF(ofs)			((dev)->reg_map[MT_HIF_BASE] + (ofs))
 
 #define MT_CFG_LPCR_HOST		MT_HIF(0x1f0)
 #define MT_CFG_LPCR_HOST_FW_OWN		BIT(0)
@@ -95,6 +119,9 @@
 #define MT_WPDMA_ABT_CFG		MT_HIF(0x530)
 #define MT_WPDMA_ABT_CFG1		MT_HIF(0x534)
 
+#define MT_CSR(ofs)			((dev)->reg_map[MT_CSR_BASE] + (ofs))
+#define MT_CONN_HIF_ON_LPCTL		MT_CSR(0x000)
+
 #define MT_PLE_BASE			0x8000
 #define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
 
@@ -106,7 +133,7 @@
 #define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(0x300 + 0x10 * (ac) + \
 					       ((n) << 2))
 
-#define MT_WF_PHY_BASE			0x10000
+#define MT_WF_PHY_BASE			((dev)->reg_map[MT_PHY_BASE])
 #define MT_WF_PHY(ofs)			(MT_WF_PHY_BASE + (ofs))
 
 #define MT_WF_PHY_WF2_RFCTRL0(n)	MT_WF_PHY(0x1900 + (n) * 0x400)
@@ -139,7 +166,7 @@
 #define MT_WF_PHY_RXTD2_BASE		MT_WF_PHY(0x2a00)
 #define MT_WF_PHY_RXTD2(_n)		(MT_WF_PHY_RXTD2_BASE + ((_n) << 2))
 
-#define MT_WF_CFG_BASE			0x20200
+#define MT_WF_CFG_BASE			((dev)->reg_map[MT_CFG_BASE])
 #define MT_WF_CFG(ofs)			(MT_WF_CFG_BASE + (ofs))
 
 #define MT_CFG_CCR			MT_WF_CFG(0x000)
@@ -148,7 +175,7 @@
 #define MT_CFG_CCR_MAC_D1_2X_GC_EN	BIT(30)
 #define MT_CFG_CCR_MAC_D0_2X_GC_EN	BIT(31)
 
-#define MT_WF_AGG_BASE			0x20a00
+#define MT_WF_AGG_BASE			((dev)->reg_map[MT_AGG_BASE])
 #define MT_WF_AGG(ofs)			(MT_WF_AGG_BASE + (ofs))
 
 #define MT_AGG_ARCR			MT_WF_AGG(0x010)
@@ -188,7 +215,7 @@
 #define MT_ARB_SCR_TX1_DISABLE		BIT(10)
 #define MT_ARB_SCR_RX1_DISABLE		BIT(11)
 
-#define MT_WF_TMAC_BASE			0x21000
+#define MT_WF_TMAC_BASE			((dev)->reg_map[MT_TMAC_BASE])
 #define MT_WF_TMAC(ofs)			(MT_WF_TMAC_BASE + (ofs))
 
 #define MT_TMAC_CDTR			MT_WF_TMAC(0x090)
@@ -212,7 +239,7 @@
 #define MT_TMAC_CTCR0_INS_DDLMT_EN	BIT(17)
 #define MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN	BIT(18)
 
-#define MT_WF_RMAC_BASE			0x21200
+#define MT_WF_RMAC_BASE			((dev)->reg_map[MT_RMAC_BASE])
 #define MT_WF_RMAC(ofs)			(MT_WF_RMAC_BASE + (ofs))
 
 #define MT_WF_RFCR(_band)		MT_WF_RMAC((_band) ? 0x100 : 0x000)
@@ -257,7 +284,7 @@
 #define MT_WF_RMAC_MIB_TIME6		MT_WF_RMAC(0x03dc)
 #define MT_MIB_OBSSTIME_MASK		GENMASK(23, 0)
 
-#define MT_WF_DMA_BASE			0x21800
+#define MT_WF_DMA_BASE			((dev)->reg_map[MT_DMA_BASE])
 #define MT_WF_DMA(ofs)			(MT_WF_DMA_BASE + (ofs))
 
 #define MT_DMA_DCR0			MT_WF_DMA(0x000)
@@ -272,10 +299,10 @@
 #define MT_DMA_RCFR0_RX_DROPPED_UCAST	GENMASK(25, 24)
 #define MT_DMA_RCFR0_RX_DROPPED_MCAST	GENMASK(27, 26)
 
-#define MT_WTBL_BASE			0x30000
+#define MT_WTBL_BASE(dev)		((dev)->reg_map[MT_WTBL_BASE_ADDR])
 #define MT_WTBL_ENTRY_SIZE		256
 
-#define MT_WTBL_OFF_BASE		0x23400
+#define MT_WTBL_OFF_BASE		((dev)->reg_map[MT_WTBL_BASE_OFF])
 #define MT_WTBL_OFF(n)			(MT_WTBL_OFF_BASE + (n))
 
 #define MT_WTBL_W0_KEY_IDX		GENMASK(24, 23)
@@ -292,7 +319,11 @@
 #define MT_WTBL_UPDATE_TX_COUNT_CLEAR	BIT(14)
 #define MT_WTBL_UPDATE_BUSY		BIT(31)
 
-#define MT_WTBL_ON_BASE			0x23000
+#define MT_TOP_MISC(ofs)		((dev)->reg_map[MT_TOP_MISC_BASE] + (ofs))
+#define MT_CONN_ON_MISC			MT_TOP_MISC(0x1140)
+#define MT_TOP_MISC2_FW_N9_RDY		BIT(2)
+
+#define MT_WTBL_ON_BASE			((dev)->reg_map[MT_WTBL_BASE_ON])
 #define MT_WTBL_ON(_n)			(MT_WTBL_ON_BASE + (_n))
 
 #define MT_WTBL_RICR0			MT_WTBL_ON(0x010)
@@ -328,8 +359,7 @@
 
 #define MT_WTBL_W27_CC_BW_SEL		GENMASK(6, 5)
 
-#define MT_LPON_BASE			0x24200
-#define MT_LPON(_n)			(MT_LPON_BASE + (_n))
+#define MT_LPON(_n)			((dev)->reg_map[MT_LPON_BASE] + (_n))
 
 #define MT_LPON_T0CR			MT_LPON(0x010)
 #define MT_LPON_T0CR_MODE		GENMASK(1, 0)
@@ -337,7 +367,7 @@
 #define MT_LPON_UTTR0			MT_LPON(0x018)
 #define MT_LPON_UTTR1			MT_LPON(0x01c)
 
-#define MT_WF_MIB_BASE			0x24800
+#define MT_WF_MIB_BASE			(dev->reg_map[MT_MIB_BASE])
 #define MT_WF_MIB(ofs)			(MT_WF_MIB_BASE + (ofs))
 
 #define MT_MIB_M0_MISC_CR		MT_WF_MIB(0x00c)
@@ -406,7 +436,7 @@
 #define MT_LED_STATUS_ON		GENMASK(23, 16)
 #define MT_LED_STATUS_DURATION		GENMASK(15, 0)
 
-#define MT_EFUSE_BASE			0x81070000
+#define MT_EFUSE_BASE			((dev)->reg_map[MT_EFUSE_ADDR_BASE])
 #define MT_EFUSE_BASE_CTRL		0x000
 #define MT_EFUSE_BASE_CTRL_EMPTY	BIT(30)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/soc.c b/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
index 07ec9ec282f5..43aa49706c66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
@@ -47,7 +47,7 @@ static int mt7622_wmac_probe(struct platform_device *pdev)
 		return PTR_ERR(mem_base);
 	}
 
-	return mt7615_mmio_probe(&pdev->dev, mem_base, irq);
+	return mt7615_mmio_probe(&pdev->dev, mem_base, irq, mt7615e_reg_map);
 }
 
 static int mt7622_wmac_remove(struct platform_device *pdev)
-- 
2.25.1

