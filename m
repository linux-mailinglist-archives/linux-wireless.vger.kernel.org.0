Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F817409E6
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjF1Hwv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50272 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230430AbjF1Hwd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:33 -0400
X-UUID: 6a80d54e158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5sk3Ppg5vy8X5XSeahN07sdXT1yQ8/YqJALymlnnx50=;
        b=GGJnM/3t+FvPxAoP7tHs1jZ44T8QENPPIZQLo3K6f449yFtKmEhmquVOBM7kruNSJEbe0SuIdStxj2XvZggHMsW3AcQpllUjpSdDB1cBK809/oZvR9uRSKiT46/nPq5zM1yrNbcr0DnP9PRboIpd9SVtGzncx5eDI81TmnKk3Ww=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:4c031a0a-9db9-488a-916f-6a59cb4b619b,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:01c9525,CLOUDID:067c9b0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6a80d54e158211eeb20a276fd37b9834-20230628
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 964190036; Wed, 28 Jun 2023 15:07:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:15 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 13/16] wifi: mt76: mt7921: move dma shared code in mt792x-lib module
Date:   Wed, 28 Jun 2023 15:05:59 +0800
Message-ID: <316d8568faecc1df4f71d4302e8b4145bd548af4.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Reduce duplicated code moving dma shared code in mt792x-lib module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 102 +-----------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   7 --
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |   2 -
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  10 ++
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  98 ++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt792x_regs.h  |   3 +
 8 files changed, 119 insertions(+), 111 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 3c628962641b..9dcda35cdf73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -25,24 +25,6 @@ static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 	return 0;
 }
 
-static int mt7921_poll_rx(struct napi_struct *napi, int budget)
-{
-	struct mt792x_dev *dev;
-	int done;
-
-	dev = container_of(napi->dev, struct mt792x_dev, mt76.napi_dev);
-
-	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
-		napi_complete(napi);
-		queue_work(dev->mt76.wq, &dev->pm.wake_work);
-		return 0;
-	}
-	done = mt76_dma_rx_poll(napi, budget);
-	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
-
-	return done;
-}
-
 static void mt7921_dma_prefetch(struct mt792x_dev *dev)
 {
 #define PREFETCH(base, depth)	((base) << 16 | (depth))
@@ -64,40 +46,6 @@ static void mt7921_dma_prefetch(struct mt792x_dev *dev)
 	mt76_wr(dev, MT_WFDMA0_TX_RING17_EXT_CTRL, PREFETCH(0x380, 0x4));
 }
 
-static int mt7921_dma_disable(struct mt792x_dev *dev, bool force)
-{
-	/* disable WFDMA0 */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
-		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
-		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
-	if (!mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
-				 MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
-				 MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1))
-		return -ETIMEDOUT;
-
-	/* disable dmashdl */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG_EXT0,
-		   MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
-	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
-
-	if (force) {
-		/* reset */
-		mt76_clear(dev, MT_WFDMA0_RST,
-			   MT_WFDMA0_RST_DMASHDL_ALL_RST |
-			   MT_WFDMA0_RST_LOGIC_RST);
-
-		mt76_set(dev, MT_WFDMA0_RST,
-			 MT_WFDMA0_RST_DMASHDL_ALL_RST |
-			 MT_WFDMA0_RST_LOGIC_RST);
-	}
-
-	return 0;
-}
-
 static int mt7921_dma_enable(struct mt792x_dev *dev)
 {
 	/* configure perfetch settings */
@@ -135,7 +83,7 @@ static int mt7921_dma_reset(struct mt792x_dev *dev, bool force)
 {
 	int i, err;
 
-	err = mt7921_dma_disable(dev, force);
+	err = mt792x_dma_disable(dev, force);
 	if (err)
 		return err;
 
@@ -154,19 +102,6 @@ static int mt7921_dma_reset(struct mt792x_dev *dev, bool force)
 	return mt7921_dma_enable(dev);
 }
 
-int mt7921_wfsys_reset(struct mt792x_dev *dev)
-{
-	mt76_clear(dev, MT_WFSYS_SW_RST_B, WFSYS_SW_RST_B);
-	msleep(50);
-	mt76_set(dev, MT_WFSYS_SW_RST_B, WFSYS_SW_RST_B);
-
-	if (!__mt76_poll_msec(&dev->mt76, MT_WFSYS_SW_RST_B,
-			      WFSYS_SW_INIT_DONE, WFSYS_SW_INIT_DONE, 500))
-		return -ETIMEDOUT;
-
-	return 0;
-}
-
 int mt7921_wpdma_reset(struct mt792x_dev *dev, bool force)
 {
 	int i, err;
@@ -182,7 +117,7 @@ int mt7921_wpdma_reset(struct mt792x_dev *dev, bool force)
 		mt76_queue_rx_cleanup(dev, &dev->mt76.q_rx[i]);
 
 	if (force) {
-		err = mt7921_wfsys_reset(dev);
+		err = mt792x_wfsys_reset(dev, MT_WFSYS_SW_RST_B);
 		if (err)
 			return err;
 	}
@@ -202,7 +137,7 @@ int mt7921_wpdma_reinit_cond(struct mt792x_dev *dev)
 	int err;
 
 	/* check if the wpdma must be reinitialized */
-	if (mt7921_dma_need_reinit(dev)) {
+	if (mt792x_dma_need_reinit(dev)) {
 		/* disable interrutpts */
 		mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
@@ -227,7 +162,7 @@ int mt7921_dma_init(struct mt792x_dev *dev)
 
 	mt76_dma_attach(&dev->mt76);
 
-	ret = mt7921_dma_disable(dev, true);
+	ret = mt792x_dma_disable(dev, true);
 	if (ret)
 		return ret;
 
@@ -275,7 +210,7 @@ int mt7921_dma_init(struct mt792x_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt76_init_queues(dev, mt7921_poll_rx);
+	ret = mt76_init_queues(dev, mt792x_poll_rx);
 	if (ret < 0)
 		return ret;
 
@@ -285,30 +220,3 @@ int mt7921_dma_init(struct mt792x_dev *dev)
 
 	return mt7921_dma_enable(dev);
 }
-
-void mt7921_dma_cleanup(struct mt792x_dev *dev)
-{
-	/* disable */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
-		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
-		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
-	mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
-			    MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
-			    MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1);
-
-	/* reset */
-	mt76_clear(dev, MT_WFDMA0_RST,
-		   MT_WFDMA0_RST_DMASHDL_ALL_RST |
-		   MT_WFDMA0_RST_LOGIC_RST);
-
-	mt76_set(dev, MT_WFDMA0_RST,
-		 MT_WFDMA0_RST_DMASHDL_ALL_RST |
-		 MT_WFDMA0_RST_LOGIC_RST);
-
-	mt76_dma_cleanup(&dev->mt76);
-}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 31fa51b8695e..b8699c942b34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -208,7 +208,6 @@ void mt7921_unregister_device(struct mt792x_dev *dev);
 int mt7921_dma_init(struct mt792x_dev *dev);
 int mt7921_wpdma_reset(struct mt792x_dev *dev, bool force);
 int mt7921_wpdma_reinit_cond(struct mt792x_dev *dev);
-void mt7921_dma_cleanup(struct mt792x_dev *dev);
 int mt7921_run_firmware(struct mt792x_dev *dev);
 int mt7921_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			  bool enable);
@@ -262,11 +261,6 @@ mt7921_l1_rmw(struct mt792x_dev *dev, u32 addr, u32 mask, u32 val)
 #define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
 #define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
 
-static inline bool mt7921_dma_need_reinit(struct mt792x_dev *dev)
-{
-	return !mt76_get_field(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
-}
-
 static inline void
 mt7921_skb_add_usb_sdio_hdr(struct mt792x_dev *dev, struct sk_buff *skb,
 			    int type)
@@ -319,7 +313,6 @@ int mt7921_mcu_fw_pmctrl(struct mt792x_dev *dev);
 void mt7921_pm_wake_work(struct work_struct *work);
 void mt7921_pm_power_save_work(struct work_struct *work);
 void mt7921_coredump_work(struct work_struct *work);
-int mt7921_wfsys_reset(struct mt792x_dev *dev);
 int mt7921_get_txpwr_info(struct mt792x_dev *dev, struct mt7921_txpwr *txpwr);
 int mt7921_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			void *data, int len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 67eaa6232a02..4d929cf8d854 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -117,8 +117,8 @@ static void mt7921e_unregister_device(struct mt792x_dev *dev)
 
 	mt76_connac2_tx_token_put(&dev->mt76);
 	__mt7921_mcu_drv_pmctrl(dev);
-	mt7921_dma_cleanup(dev);
-	mt7921_wfsys_reset(dev);
+	mt792x_dma_cleanup(dev);
+	mt792x_wfsys_reset(dev, MT_WFSYS_SW_RST_B);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 
 	tasklet_disable(&dev->mt76.irq_tasklet);
@@ -337,7 +337,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
-	ret = mt7921_wfsys_reset(dev);
+	ret = mt792x_wfsys_reset(dev, MT_WFSYS_SW_RST_B);
 	if (ret)
 		goto err_free_dev;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index c5ca1b931584..083d655f82e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -87,8 +87,6 @@
 #define MT_HIF_REMAP_BASE_L1		0x40000
 
 #define MT_WFSYS_SW_RST_B		0x18000140
-#define WFSYS_SW_RST_B			BIT(0)
-#define WFSYS_SW_INIT_DONE		BIT(4)
 
 #define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x200)
 #define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 3bf902cacd28..c7368cf676a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -349,7 +349,7 @@ static int mt7921u_resume(struct usb_interface *intf)
 		msleep(20);
 	}
 
-	if (reinit || mt7921_dma_need_reinit(dev)) {
+	if (reinit || mt792x_dma_need_reinit(dev)) {
 		err = mt7921u_dma_init(dev, true);
 		if (err)
 			goto failed;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index f0f9fb3fd970..fa199cc05c60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -8,6 +8,7 @@
 #include <linux/ktime.h>
 
 #include "mt76_connac_mcu.h"
+#include "mt792x_regs.h"
 
 #define MT792x_MAX_INTERFACES	4
 #define MT792x_WTBL_SIZE	20
@@ -169,6 +170,11 @@ mt792x_get_status_freq_info(struct mt76_rx_status *status, u8 chfreq)
 	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
 }
 
+static inline bool mt792x_dma_need_reinit(struct mt792x_dev *dev)
+{
+	return !mt76_get_field(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
+}
+
 #define mt792x_mutex_acquire(dev)	\
 	mt76_connac_mutex_acquire(&(dev)->mt76, &(dev)->pm)
 #define mt792x_mutex_release(dev)	\
@@ -219,5 +225,9 @@ void mt792x_sta_statistics(struct ieee80211_hw *hw,
 			   struct ieee80211_sta *sta,
 			   struct station_info *sinfo);
 void mt792x_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class);
+void mt792x_dma_cleanup(struct mt792x_dev *dev);
+int mt792x_dma_disable(struct mt792x_dev *dev, bool force);
+int mt792x_poll_rx(struct napi_struct *napi, int budget);
+int mt792x_wfsys_reset(struct mt792x_dev *dev, u32 addr);
 
 #endif /* __MT7925_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index fa648b133397..b176ce53996e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -4,7 +4,7 @@
 #include <linux/module.h>
 
 #include "mt792x.h"
-#include "mt792x_regs.h"
+#include "dma.h"
 
 void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 	       struct sk_buff *skb)
@@ -465,5 +465,101 @@ void mt792x_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
 }
 EXPORT_SYMBOL_GPL(mt792x_set_coverage_class);
 
+int mt792x_dma_disable(struct mt792x_dev *dev, bool force)
+{
+	/* disable WFDMA0 */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	if (!mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
+				 MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+				 MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1))
+		return -ETIMEDOUT;
+
+	/* disable dmashdl */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG_EXT0,
+		   MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
+	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
+
+	if (force) {
+		/* reset */
+		mt76_clear(dev, MT_WFDMA0_RST,
+			   MT_WFDMA0_RST_DMASHDL_ALL_RST |
+			   MT_WFDMA0_RST_LOGIC_RST);
+
+		mt76_set(dev, MT_WFDMA0_RST,
+			 MT_WFDMA0_RST_DMASHDL_ALL_RST |
+			 MT_WFDMA0_RST_LOGIC_RST);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_dma_disable);
+
+void mt792x_dma_cleanup(struct mt792x_dev *dev)
+{
+	/* disable */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
+			    MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+			    MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1);
+
+	/* reset */
+	mt76_clear(dev, MT_WFDMA0_RST,
+		   MT_WFDMA0_RST_DMASHDL_ALL_RST |
+		   MT_WFDMA0_RST_LOGIC_RST);
+
+	mt76_set(dev, MT_WFDMA0_RST,
+		 MT_WFDMA0_RST_DMASHDL_ALL_RST |
+		 MT_WFDMA0_RST_LOGIC_RST);
+
+	mt76_dma_cleanup(&dev->mt76);
+}
+EXPORT_SYMBOL_GPL(mt792x_dma_cleanup);
+
+int mt792x_poll_rx(struct napi_struct *napi, int budget)
+{
+	struct mt792x_dev *dev;
+	int done;
+
+	dev = container_of(napi->dev, struct mt792x_dev, mt76.napi_dev);
+
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		napi_complete(napi);
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+		return 0;
+	}
+	done = mt76_dma_rx_poll(napi, budget);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
+
+	return done;
+}
+EXPORT_SYMBOL_GPL(mt792x_poll_rx);
+
+int mt792x_wfsys_reset(struct mt792x_dev *dev, u32 addr)
+{
+	mt76_clear(dev, addr, WFSYS_SW_RST_B);
+	msleep(50);
+	mt76_set(dev, addr, WFSYS_SW_RST_B);
+
+	if (!__mt76_poll_msec(&dev->mt76, addr, WFSYS_SW_INIT_DONE,
+			      WFSYS_SW_INIT_DONE, 500))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_wfsys_reset);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 5f2407fbf95f..9c6308ef4cb3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -454,4 +454,7 @@
 #define MT_WF_SW_SER_TRIGGER_SUSPEND	BIT(6)
 #define MT_WF_SW_SER_DONE_SUSPEND	BIT(7)
 
+#define WFSYS_SW_RST_B			BIT(0)
+#define WFSYS_SW_INIT_DONE		BIT(4)
+
 #endif /* __MT792X_REGS_H */
-- 
2.18.0

