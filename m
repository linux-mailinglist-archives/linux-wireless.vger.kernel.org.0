Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C061C10E9
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 12:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgEAKgr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 06:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgEAKgq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 06:36:46 -0400
Received: from lore-desk.lan (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1507521973;
        Fri,  1 May 2020 10:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588329404;
        bh=MaKQ3XXwEhsK2wRzmwPj6owv7UxL36M2eAST5DwoCYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdVHZ0mkXsxbQOOm/A0MgtszjKQtAW7QRezKCtcWKDhEunfFcLHe8jRWNEkIgM4Jx
         jhCwzWAj7zHVyWUjnQIRIwUe/loctXA+/cAsFNDTaGIi2NmpBVFBjHWUdD2b8kywym
         uyPpN7VeFU1nSltlt4TlvyQ+F3lGolUMaG6RfFaY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org,
        soul.huang@mediatek.com
Subject: [PATCH 5/7] mt76: mt7615: introduce PM support
Date:   Fri,  1 May 2020 12:36:15 +0200
Message-Id: <fa7af0636560df42930a8faa536456802e311999.1588329170.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588329170.git.lorenzo@kernel.org>
References: <cover.1588329170.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce suspend/resume to mt7615e driver

Co-developed-by: Wan-Feng Jiang <Wan-Feng.Jiang@mediatek.com>
Signed-off-by: Wan-Feng Jiang <Wan-Feng.Jiang@mediatek.com>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  37 ++++++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |   4 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   5 +
 .../net/wireless/mediatek/mt76/mt7615/pci.c   | 107 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  28 ++++-
 7 files changed, 185 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 0b1fbddd1c3f..5a124610d4af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -130,6 +130,43 @@ static int mt7615_poll_tx(struct napi_struct *napi, int budget)
 	return 0;
 }
 
+int mt7615_wait_pdma_busy(struct mt7615_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+
+	if (!is_mt7663(mdev)) {
+		u32 mask = MT_PDMA_TX_BUSY | MT_PDMA_RX_BUSY;
+		u32 reg = mt7615_reg_map(dev, MT_PDMA_BUSY);
+
+		if (!mt76_poll_msec(dev, reg, mask, 0, 1000)) {
+			dev_err(mdev->dev, "PDMA engine busy\n");
+			return -EIO;
+		}
+
+		return 0;
+	}
+
+	if (!mt76_poll_msec(dev, MT_PDMA_BUSY_STATUS,
+			    MT_PDMA_TX_IDX_BUSY, 0, 1000)) {
+		dev_err(mdev->dev, "PDMA engine tx busy\n");
+		return -EIO;
+	}
+
+	if (!mt76_poll_msec(dev, MT_PSE_PG_INFO,
+			    MT_PSE_SRC_CNT, 0, 1000)) {
+		dev_err(mdev->dev, "PSE engine busy\n");
+		return -EIO;
+	}
+
+	if (!mt76_poll_msec(dev, MT_PDMA_BUSY_STATUS,
+			    MT_PDMA_BUSY_IDX, 0, 1000)) {
+		dev_err(mdev->dev, "PDMA engine busy\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static void mt7622_dma_sched_init(struct mt7615_dev *dev)
 {
 	u32 reg = mt7615_reg_map(dev, MT_DMASHDL_BASE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index e7a76032caff..b8f86d8fab93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1806,8 +1806,7 @@ mt7615_update_beacons(struct mt7615_dev *dev)
 		mt7615_update_vif_beacon, dev->mt76.phy2->hw);
 }
 
-static void
-mt7615_dma_reset(struct mt7615_dev *dev)
+void mt7615_dma_reset(struct mt7615_dev *dev)
 {
 	int i;
 
@@ -1826,6 +1825,7 @@ mt7615_dma_reset(struct mt7615_dev *dev)
 		 MT_WPDMA_GLO_CFG_RX_DMA_EN | MT_WPDMA_GLO_CFG_TX_DMA_EN |
 		 MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
 }
+EXPORT_SYMBOL_GPL(mt7615_dma_reset);
 
 void mt7615_mac_reset_work(struct work_struct *work)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 2d077c18a4b6..22e532aeb3cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1677,7 +1677,7 @@ static void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
 			   !en * MT_INFRACFG_MISC_AP2CONN_WAKE);
 }
 
-static int mt7615_driver_own(struct mt7615_dev *dev)
+int mt7615_driver_own(struct mt7615_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
 	u32 addr;
@@ -1697,8 +1697,9 @@ static int mt7615_driver_own(struct mt7615_dev *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7615_driver_own);
 
-static int mt7615_firmware_own(struct mt7615_dev *dev)
+int mt7615_firmware_own(struct mt7615_dev *dev)
 {
 	u32 addr;
 
@@ -1717,6 +1718,7 @@ static int mt7615_firmware_own(struct mt7615_dev *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7615_firmware_own);
 
 static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index c9f5b1ce70ae..e670393506f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -15,6 +15,8 @@ const u32 mt7615e_reg_map[] = {
 	[MT_ARB_BASE]		= 0x20c00,
 	[MT_HIF_BASE]		= 0x04000,
 	[MT_CSR_BASE]		= 0x07000,
+	[MT_PLE_BASE]		= 0x08000,
+	[MT_PSE_BASE]		= 0x0c000,
 	[MT_PHY_BASE]		= 0x10000,
 	[MT_CFG_BASE]		= 0x20200,
 	[MT_AGG_BASE]		= 0x20a00,
@@ -40,6 +42,8 @@ const u32 mt7663e_reg_map[] = {
 	[MT_ARB_BASE]		= 0x20c00,
 	[MT_HIF_BASE]		= 0x04000,
 	[MT_CSR_BASE]		= 0x07000,
+	[MT_PLE_BASE]		= 0x08000,
+	[MT_PSE_BASE]		= 0x0c000,
 	[MT_PHY_BASE]		= 0x10000,
 	[MT_CFG_BASE]		= 0x20000,
 	[MT_AGG_BASE]		= 0x22000,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 3e6bc3ce914a..be9188e40259 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -380,6 +380,7 @@ int mt7615_eeprom_init(struct mt7615_dev *dev, u32 addr);
 int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
 				  struct ieee80211_channel *chan,
 				  u8 chain_idx);
+int mt7615_wait_pdma_busy(struct mt7615_dev *dev);
 int mt7615_dma_init(struct mt7615_dev *dev);
 void mt7615_dma_cleanup(struct mt7615_dev *dev);
 int mt7615_mcu_init(struct mt7615_dev *dev);
@@ -436,6 +437,7 @@ static inline u16 mt7615_wtbl_size(struct mt7615_dev *dev)
 		return MT7615_WTBL_SIZE;
 }
 
+void mt7615_dma_reset(struct mt7615_dev *dev);
 void mt7615_scan_work(struct work_struct *work);
 void mt7615_ps_work(struct work_struct *work);
 void mt7615_init_txpower(struct mt7615_dev *dev,
@@ -526,6 +528,9 @@ int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy);
 void m7615_mcu_set_ps_iter(void *priv, u8 *mac, struct ieee80211_vif *vif);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
+int mt7615_firmware_own(struct mt7615_dev *dev);
+int mt7615_driver_own(struct mt7615_dev *dev);
+
 int mt7615_init_debugfs(struct mt7615_dev *dev);
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 0605c908059e..b84eb208c23e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -66,11 +66,118 @@ static void mt7615_pci_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
+static int __maybe_unused mt7615_pci_suspend(struct pci_dev *pdev,
+					     pm_message_t state)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	bool hif_suspend;
+	int i, err;
+
+	hif_suspend = !test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
+		      mt7615_firmware_offload(dev);
+	if (hif_suspend) {
+		err = mt7615_mcu_set_hif_suspend(dev, true);
+		if (err)
+			return err;
+	}
+
+	napi_disable(&mdev->tx_napi);
+	tasklet_kill(&mdev->tx_tasklet);
+
+	for (i = 0; i < ARRAY_SIZE(mdev->q_rx); i++)
+		napi_disable(&mdev->napi[i]);
+	tasklet_kill(&dev->irq_tasklet);
+
+	mt7615_dma_reset(dev);
+
+	err = mt7615_wait_pdma_busy(dev);
+	if (err)
+		goto restore;
+
+	if (is_mt7663(mdev)) {
+		mt76_set(dev, MT_PDMA_SLP_PROT, MT_PDMA_AXI_SLPPROT_ENABLE);
+		if (!mt76_poll_msec(dev, MT_PDMA_SLP_PROT,
+				    MT_PDMA_AXI_SLPPROT_RDY,
+				    MT_PDMA_AXI_SLPPROT_RDY, 1000)) {
+			dev_err(mdev->dev, "PDMA sleep protection failed\n");
+			err = -EIO;
+			goto restore;
+		}
+	}
+
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), true);
+	pci_save_state(pdev);
+	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	if (err)
+		goto restore;
+
+	err = mt7615_firmware_own(dev);
+	if (err)
+		goto restore;
+
+	return 0;
+
+restore:
+	for (i = 0; i < ARRAY_SIZE(mdev->q_rx); i++)
+		napi_enable(&mdev->napi[i]);
+	napi_enable(&mdev->tx_napi);
+	if (hif_suspend)
+		mt7615_mcu_set_hif_suspend(dev, false);
+
+	return err;
+}
+
+static int __maybe_unused mt7615_pci_resume(struct pci_dev *pdev)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	bool pdma_reset;
+	int i, err;
+
+	err = mt7615_driver_own(dev);
+	if (err < 0)
+		return err;
+
+	err = pci_set_power_state(pdev, PCI_D0);
+	if (err)
+		return err;
+
+	pci_restore_state(pdev);
+
+	if (is_mt7663(&dev->mt76)) {
+		mt76_clear(dev, MT_PDMA_SLP_PROT, MT_PDMA_AXI_SLPPROT_ENABLE);
+		mt76_wr(dev, MT_PCIE_IRQ_ENABLE, 1);
+	}
+
+	pdma_reset = !mt76_rr(dev, MT_WPDMA_TX_RING0_CTRL0) &&
+		     !mt76_rr(dev, MT_WPDMA_TX_RING0_CTRL1);
+	if (pdma_reset)
+		dev_err(mdev->dev, "PDMA engine must be reinitialized\n");
+
+	for (i = 0; i < ARRAY_SIZE(mdev->q_rx); i++) {
+		napi_enable(&mdev->napi[i]);
+		napi_schedule(&mdev->napi[i]);
+	}
+	napi_enable(&mdev->tx_napi);
+	napi_schedule(&mdev->tx_napi);
+
+	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
+	    mt7615_firmware_offload(dev))
+		err = mt7615_mcu_set_hif_suspend(dev, false);
+
+	return err;
+}
+
 struct pci_driver mt7615_pci_driver = {
 	.name		= KBUILD_MODNAME,
 	.id_table	= mt7615_pci_device_table,
 	.probe		= mt7615_pci_probe,
 	.remove		= mt7615_pci_remove,
+#ifdef CONFIG_PM
+	.suspend	= mt7615_pci_suspend,
+	.resume		= mt7615_pci_resume,
+#endif /* CONFIG_PM */
 };
 
 MODULE_DEVICE_TABLE(pci, mt7615_pci_device_table);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 68d30bcc087a..aee433a9eff6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -12,6 +12,8 @@ enum mt7615_reg_base {
 	MT_ARB_BASE,
 	MT_HIF_BASE,
 	MT_CSR_BASE,
+	MT_PLE_BASE,
+	MT_PSE_BASE,
 	MT_PHY_BASE,
 	MT_CFG_BASE,
 	MT_AGG_BASE,
@@ -63,6 +65,17 @@ enum mt7615_reg_base {
 #define MT_HIF_RST			MT_HIF(0x100)
 #define MT_HIF_LOGIC_RST_N		BIT(4)
 
+#define MT_PDMA_SLP_PROT		MT_HIF(0x154)
+#define MT_PDMA_AXI_SLPPROT_ENABLE	BIT(0)
+#define MT_PDMA_AXI_SLPPROT_RDY		BIT(16)
+
+#define MT_PDMA_BUSY_STATUS		MT_HIF(0x168)
+#define MT_PDMA_TX_IDX_BUSY		BIT(2)
+#define MT_PDMA_BUSY_IDX		BIT(31)
+
+#define MT_WPDMA_TX_RING0_CTRL0		MT_HIF(0x300)
+#define MT_WPDMA_TX_RING0_CTRL1		MT_HIF(0x304)
+
 #define MT7663_MCU_PCIE_REMAP_2_OFFSET	GENMASK(15, 0)
 #define MT7663_MCU_PCIE_REMAP_2_BASE	GENMASK(31, 16)
 
@@ -138,8 +151,7 @@ enum mt7615_reg_base {
 #define MT_CSR(ofs)			((dev)->reg_map[MT_CSR_BASE] + (ofs))
 #define MT_CONN_HIF_ON_LPCTL		MT_CSR(0x000)
 
-#define MT_PLE_BASE			0x8000
-#define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
+#define MT_PLE(ofs)			((dev)->reg_map[MT_PLE_BASE] + (ofs))
 
 #define MT_PLE_FL_Q0_CTRL		MT_PLE(0x1b0)
 #define MT_PLE_FL_Q1_CTRL		MT_PLE(0x1b4)
@@ -149,6 +161,14 @@ enum mt7615_reg_base {
 #define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(0x300 + 0x10 * (ac) + \
 					       ((n) << 2))
 
+#define MT_PSE(ofs)			((dev)->reg_map[MT_PSE_BASE] + (ofs))
+#define MT_PSE_QUEUE_EMPTY		MT_PSE(0x0b4)
+#define MT_HIF_0_EMPTY_MASK		BIT(16)
+#define MT_HIF_1_EMPTY_MASK		BIT(17)
+#define MT_HIF_ALL_EMPTY_MASK		GENMASK(17, 16)
+#define MT_PSE_PG_INFO			MT_PSE(0x194)
+#define MT_PSE_SRC_CNT			GENMASK(27, 16)
+
 #define MT_WF_PHY_BASE			((dev)->reg_map[MT_PHY_BASE])
 #define MT_WF_PHY(ofs)			(MT_WF_PHY_BASE + (ofs))
 
@@ -482,6 +502,10 @@ enum mt7615_reg_base {
 #define MT_LED_STATUS_ON		GENMASK(23, 16)
 #define MT_LED_STATUS_DURATION		GENMASK(15, 0)
 
+#define MT_PDMA_BUSY			0x82000504
+#define MT_PDMA_TX_BUSY			BIT(0)
+#define MT_PDMA_RX_BUSY			BIT(1)
+
 #define MT_EFUSE_BASE			((dev)->reg_map[MT_EFUSE_ADDR_BASE])
 #define MT_EFUSE_BASE_CTRL		0x000
 #define MT_EFUSE_BASE_CTRL_EMPTY	BIT(30)
-- 
2.25.4

