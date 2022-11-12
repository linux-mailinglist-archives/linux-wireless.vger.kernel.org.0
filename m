Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E22626A53
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Nov 2022 16:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiKLPlg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 10:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiKLPle (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 10:41:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196991AF1D
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 07:41:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 877B060C4F
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 15:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93706C433D6;
        Sat, 12 Nov 2022 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267690;
        bh=faHgbAGPbVGUSdN3h2oRKRoQsP/P4hbhgNDzU/Tpk7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVlA1RR1map1xbnxuN/rsSSuYL0OmZvi1TZrHPHx3w2DmDnWtxNYSPpB+CDe566K+
         aEf23EcRHb+08yKLTuccySly8Hk5IH2+gCIWCMGg6qROUxEsNbAOHGMNkX9mUcZ+uT
         2fik4IbtOIkAeaVP67/NVVKabqwAntcOd/ulSkg5mQJqhS5mkp/y9QQLzLZAJ4p9RY
         c72MOjOx2tb8shBA3XGz2MINH47ApeuQlNKA1FEuEda/kfB/o+h0WWW3Q6nP7Fgkzg
         L5uoLsrvGt9Qpgr8zGaF6uUEywpDGShe4Bdy7CIRMOUQ8sqibLcwAkCMAqX4A2KLEb
         NEWHCC5fa7CZA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        ryder.Lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 7/8] wifi: mt76: mt7915: enable WED RX support
Date:   Sat, 12 Nov 2022 16:40:40 +0100
Message-Id: <c6a2a58cdd42b47b4c22137a40e357dd74ba8014.1668267241.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668267241.git.lorenzo@kernel.org>
References: <cover.1668267241.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable RX Wireless Ethernet Dispatch available on MT7986 Soc in oreder
to offlad traffic received by WLAN NIC and forwarded to LAN/WAN one.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |   5 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  20 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   4 +
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 293 ++++++++++++------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   2 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |   7 +
 6 files changed, 238 insertions(+), 93 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 3cd37a013dcc..fc608b369b3c 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1297,7 +1297,10 @@ void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
 
 	while ((skb = __skb_dequeue(&dev->rx_skb[q])) != NULL) {
 		mt76_check_sta(dev, skb);
-		mt76_rx_aggr_reorder(skb, &frames);
+		if (mtk_wed_device_active(&dev->mmio.wed))
+			__skb_queue_tail(&frames, skb);
+		else
+			mt76_rx_aggr_reorder(skb, &frames);
 	}
 
 	mt76_rx_complete(dev, &frames, napi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 38360f940747..e102a717fc01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -365,7 +365,8 @@ static int mt7915_dma_enable(struct mt7915_dev *dev)
 		wed_irq_mask |= MT_INT_TX_DONE_BAND0 | MT_INT_TX_DONE_BAND1;
 		if (!is_mt7986(&dev->mt76))
 			mt76_wr(dev, MT_INT_WED_MASK_CSR, wed_irq_mask);
-		mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
+		else
+			mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
 		mtk_wed_device_start(&dev->mt76.mmio.wed, wed_irq_mask);
 	}
 
@@ -401,6 +402,9 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 				FIELD_PREP(MT_WFDMA_WED_RING_CONTROL_TX1, 19) |
 				FIELD_PREP(MT_WFDMA_WED_RING_CONTROL_RX1,
 					   wed_control_rx1));
+			if (is_mt7915(mdev))
+				mt76_rmw(dev, MT_WFDMA0_EXT0_CFG, MT_WFDMA0_EXT0_RXWB_KEEP,
+					 MT_WFDMA0_EXT0_RXWB_KEEP);
 		}
 	} else {
 		mt76_clear(dev, MT_WFDMA_HOST_CONFIG, MT_WFDMA_HOST_CONFIG_WED);
@@ -473,6 +477,13 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 
 	/* rx data queue for band0 */
 	if (!dev->phy.band_idx) {
+		if (mtk_wed_device_active(&mdev->mmio.wed) &&
+		    mtk_wed_get_rx_capa(&mdev->mmio.wed)) {
+			dev->mt76.q_rx[MT_RXQ_MAIN].flags =
+				MT_WED_Q_RX(MT7915_RXQ_BAND0);
+			dev->mt76.rx_token_size += MT7915_RX_RING_SIZE;
+		}
+
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
 				       MT_RXQ_ID(MT_RXQ_MAIN),
 				       MT7915_RX_RING_SIZE,
@@ -503,6 +514,13 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2)
 	}
 
 	if (dev->dbdc_support || dev->phy.band_idx) {
+		if (mtk_wed_device_active(&mdev->mmio.wed) &&
+		    mtk_wed_get_rx_capa(&mdev->mmio.wed)) {
+			dev->mt76.q_rx[MT_RXQ_BAND1].flags =
+				MT_WED_Q_RX(MT7915_RXQ_BAND1);
+			dev->mt76.rx_token_size += MT7915_RX_RING_SIZE;
+		}
+
 		/* rx data queue for band1 */
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND1],
 				       MT_RXQ_ID(MT_RXQ_BAND1),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 17e13fd0ede9..f63ed0378802 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1677,6 +1677,10 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		return ret;
 	}
 out:
+	ret = mt76_connac_mcu_sta_wed_update(&dev->mt76, skb);
+	if (ret)
+		return ret;
+
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 3c840853a2c9..04f38755056f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -9,107 +9,111 @@
 #include "mt7915.h"
 #include "mac.h"
 #include "../trace.h"
+#include "../dma.h"
 
 static bool wed_enable;
 module_param(wed_enable, bool, 0644);
 
 static const u32 mt7915_reg[] = {
-	[INT_SOURCE_CSR]	= 0xd7010,
-	[INT_MASK_CSR]		= 0xd7014,
-	[INT1_SOURCE_CSR]	= 0xd7088,
-	[INT1_MASK_CSR]		= 0xd708c,
-	[INT_MCU_CMD_SOURCE]	= 0xd51f0,
-	[INT_MCU_CMD_EVENT]	= 0x3108,
-	[WFDMA0_ADDR]		= 0xd4000,
-	[WFDMA0_PCIE1_ADDR]	= 0xd8000,
-	[WFDMA_EXT_CSR_ADDR]	= 0xd7000,
-	[CBTOP1_PHY_END]	= 0x77ffffff,
-	[INFRA_MCU_ADDR_END]	= 0x7c3fffff,
-	[FW_ASSERT_STAT_ADDR]	= 0x219848,
-	[FW_EXCEPT_TYPE_ADDR]	= 0x21987c,
-	[FW_EXCEPT_COUNT_ADDR]	= 0x219848,
-	[FW_CIRQ_COUNT_ADDR]	= 0x216f94,
-	[FW_CIRQ_IDX_ADDR]	= 0x216ef8,
-	[FW_CIRQ_LISR_ADDR]	= 0x2170ac,
-	[FW_TASK_ID_ADDR]	= 0x216f90,
-	[FW_TASK_IDX_ADDR]	= 0x216f9c,
-	[FW_TASK_QID1_ADDR]	= 0x219680,
-	[FW_TASK_QID2_ADDR]	= 0x219760,
-	[FW_TASK_START_ADDR]	= 0x219558,
-	[FW_TASK_END_ADDR]	= 0x219554,
-	[FW_TASK_SIZE_ADDR]	= 0x219560,
-	[FW_LAST_MSG_ID_ADDR]	= 0x216f70,
-	[FW_EINT_INFO_ADDR]	= 0x219818,
-	[FW_SCHED_INFO_ADDR]	= 0x219828,
-	[SWDEF_BASE_ADDR]	= 0x41f200,
-	[TXQ_WED_RING_BASE]	= 0xd7300,
-	[RXQ_WED_RING_BASE]	= 0xd7410,
+	[INT_SOURCE_CSR]		= 0xd7010,
+	[INT_MASK_CSR]			= 0xd7014,
+	[INT1_SOURCE_CSR]		= 0xd7088,
+	[INT1_MASK_CSR]			= 0xd708c,
+	[INT_MCU_CMD_SOURCE]		= 0xd51f0,
+	[INT_MCU_CMD_EVENT]		= 0x3108,
+	[WFDMA0_ADDR]			= 0xd4000,
+	[WFDMA0_PCIE1_ADDR]		= 0xd8000,
+	[WFDMA_EXT_CSR_ADDR]		= 0xd7000,
+	[CBTOP1_PHY_END]		= 0x77ffffff,
+	[INFRA_MCU_ADDR_END]		= 0x7c3fffff,
+	[FW_ASSERT_STAT_ADDR]		= 0x219848,
+	[FW_EXCEPT_TYPE_ADDR]		= 0x21987c,
+	[FW_EXCEPT_COUNT_ADDR]		= 0x219848,
+	[FW_CIRQ_COUNT_ADDR]		= 0x216f94,
+	[FW_CIRQ_IDX_ADDR]		= 0x216ef8,
+	[FW_CIRQ_LISR_ADDR]		= 0x2170ac,
+	[FW_TASK_ID_ADDR]		= 0x216f90,
+	[FW_TASK_IDX_ADDR]		= 0x216f9c,
+	[FW_TASK_QID1_ADDR]		= 0x219680,
+	[FW_TASK_QID2_ADDR]		= 0x219760,
+	[FW_TASK_START_ADDR]		= 0x219558,
+	[FW_TASK_END_ADDR]		= 0x219554,
+	[FW_TASK_SIZE_ADDR]		= 0x219560,
+	[FW_LAST_MSG_ID_ADDR]		= 0x216f70,
+	[FW_EINT_INFO_ADDR]		= 0x219818,
+	[FW_SCHED_INFO_ADDR]		= 0x219828,
+	[SWDEF_BASE_ADDR]		= 0x41f200,
+	[TXQ_WED_RING_BASE]		= 0xd7300,
+	[RXQ_WED_RING_BASE]		= 0xd7410,
+	[RXQ_WED_DATA_RING_BASE]	= 0xd4500,
 };
 
 static const u32 mt7916_reg[] = {
-	[INT_SOURCE_CSR]	= 0xd4200,
-	[INT_MASK_CSR]		= 0xd4204,
-	[INT1_SOURCE_CSR]	= 0xd8200,
-	[INT1_MASK_CSR]		= 0xd8204,
-	[INT_MCU_CMD_SOURCE]	= 0xd41f0,
-	[INT_MCU_CMD_EVENT]	= 0x2108,
-	[WFDMA0_ADDR]		= 0xd4000,
-	[WFDMA0_PCIE1_ADDR]	= 0xd8000,
-	[WFDMA_EXT_CSR_ADDR]	= 0xd7000,
-	[CBTOP1_PHY_END]	= 0x7fffffff,
-	[INFRA_MCU_ADDR_END]	= 0x7c085fff,
-	[FW_ASSERT_STAT_ADDR]	= 0x02204c14,
-	[FW_EXCEPT_TYPE_ADDR]	= 0x022051a4,
-	[FW_EXCEPT_COUNT_ADDR]	= 0x022050bc,
-	[FW_CIRQ_COUNT_ADDR]	= 0x022001ac,
-	[FW_CIRQ_IDX_ADDR]	= 0x02204f84,
-	[FW_CIRQ_LISR_ADDR]	= 0x022050d0,
-	[FW_TASK_ID_ADDR]	= 0x0220406c,
-	[FW_TASK_IDX_ADDR]	= 0x0220500c,
-	[FW_TASK_QID1_ADDR]	= 0x022028c8,
-	[FW_TASK_QID2_ADDR]	= 0x02202a38,
-	[FW_TASK_START_ADDR]	= 0x0220286c,
-	[FW_TASK_END_ADDR]	= 0x02202870,
-	[FW_TASK_SIZE_ADDR]	= 0x02202878,
-	[FW_LAST_MSG_ID_ADDR]	= 0x02204fe8,
-	[FW_EINT_INFO_ADDR]	= 0x0220525c,
-	[FW_SCHED_INFO_ADDR]	= 0x0220516c,
-	[SWDEF_BASE_ADDR]	= 0x411400,
-	[TXQ_WED_RING_BASE]	= 0xd7300,
-	[RXQ_WED_RING_BASE]	= 0xd7410,
+	[INT_SOURCE_CSR]		= 0xd4200,
+	[INT_MASK_CSR]			= 0xd4204,
+	[INT1_SOURCE_CSR]		= 0xd8200,
+	[INT1_MASK_CSR]			= 0xd8204,
+	[INT_MCU_CMD_SOURCE]		= 0xd41f0,
+	[INT_MCU_CMD_EVENT]		= 0x2108,
+	[WFDMA0_ADDR]			= 0xd4000,
+	[WFDMA0_PCIE1_ADDR]		= 0xd8000,
+	[WFDMA_EXT_CSR_ADDR]		= 0xd7000,
+	[CBTOP1_PHY_END]		= 0x7fffffff,
+	[INFRA_MCU_ADDR_END]		= 0x7c085fff,
+	[FW_ASSERT_STAT_ADDR]		= 0x02204c14,
+	[FW_EXCEPT_TYPE_ADDR]		= 0x022051a4,
+	[FW_EXCEPT_COUNT_ADDR]		= 0x022050bc,
+	[FW_CIRQ_COUNT_ADDR]		= 0x022001ac,
+	[FW_CIRQ_IDX_ADDR]		= 0x02204f84,
+	[FW_CIRQ_LISR_ADDR]		= 0x022050d0,
+	[FW_TASK_ID_ADDR]		= 0x0220406c,
+	[FW_TASK_IDX_ADDR]		= 0x0220500c,
+	[FW_TASK_QID1_ADDR]		= 0x022028c8,
+	[FW_TASK_QID2_ADDR]		= 0x02202a38,
+	[FW_TASK_START_ADDR]		= 0x0220286c,
+	[FW_TASK_END_ADDR]		= 0x02202870,
+	[FW_TASK_SIZE_ADDR]		= 0x02202878,
+	[FW_LAST_MSG_ID_ADDR]		= 0x02204fe8,
+	[FW_EINT_INFO_ADDR]		= 0x0220525c,
+	[FW_SCHED_INFO_ADDR]		= 0x0220516c,
+	[SWDEF_BASE_ADDR]		= 0x411400,
+	[TXQ_WED_RING_BASE]		= 0xd7300,
+	[RXQ_WED_RING_BASE]		= 0xd7410,
+	[RXQ_WED_DATA_RING_BASE]	= 0xd4540,
 };
 
 static const u32 mt7986_reg[] = {
-	[INT_SOURCE_CSR]	= 0x24200,
-	[INT_MASK_CSR]		= 0x24204,
-	[INT1_SOURCE_CSR]	= 0x28200,
-	[INT1_MASK_CSR]		= 0x28204,
-	[INT_MCU_CMD_SOURCE]	= 0x241f0,
-	[INT_MCU_CMD_EVENT]	= 0x54000108,
-	[WFDMA0_ADDR]		= 0x24000,
-	[WFDMA0_PCIE1_ADDR]	= 0x28000,
-	[WFDMA_EXT_CSR_ADDR]	= 0x27000,
-	[CBTOP1_PHY_END]	= 0x7fffffff,
-	[INFRA_MCU_ADDR_END]	= 0x7c085fff,
-	[FW_ASSERT_STAT_ADDR]	= 0x02204b54,
-	[FW_EXCEPT_TYPE_ADDR]	= 0x022050dc,
-	[FW_EXCEPT_COUNT_ADDR]	= 0x02204ffc,
-	[FW_CIRQ_COUNT_ADDR]	= 0x022001ac,
-	[FW_CIRQ_IDX_ADDR]	= 0x02204ec4,
-	[FW_CIRQ_LISR_ADDR]	= 0x02205010,
-	[FW_TASK_ID_ADDR]	= 0x02204fac,
-	[FW_TASK_IDX_ADDR]	= 0x02204f4c,
-	[FW_TASK_QID1_ADDR]	= 0x02202814,
-	[FW_TASK_QID2_ADDR]	= 0x02202984,
-	[FW_TASK_START_ADDR]	= 0x022027b8,
-	[FW_TASK_END_ADDR]	= 0x022027bc,
-	[FW_TASK_SIZE_ADDR]	= 0x022027c4,
-	[FW_LAST_MSG_ID_ADDR]	= 0x02204f28,
-	[FW_EINT_INFO_ADDR]	= 0x02205194,
-	[FW_SCHED_INFO_ADDR]	= 0x022051a4,
-	[SWDEF_BASE_ADDR]	= 0x411400,
-	[TXQ_WED_RING_BASE]	= 0x24420,
-	[RXQ_WED_RING_BASE]	= 0x24520,
+	[INT_SOURCE_CSR]		= 0x24200,
+	[INT_MASK_CSR]			= 0x24204,
+	[INT1_SOURCE_CSR]		= 0x28200,
+	[INT1_MASK_CSR]			= 0x28204,
+	[INT_MCU_CMD_SOURCE]		= 0x241f0,
+	[INT_MCU_CMD_EVENT]		= 0x54000108,
+	[WFDMA0_ADDR]			= 0x24000,
+	[WFDMA0_PCIE1_ADDR]		= 0x28000,
+	[WFDMA_EXT_CSR_ADDR]		= 0x27000,
+	[CBTOP1_PHY_END]		= 0x7fffffff,
+	[INFRA_MCU_ADDR_END]		= 0x7c085fff,
+	[FW_ASSERT_STAT_ADDR]		= 0x02204b54,
+	[FW_EXCEPT_TYPE_ADDR]		= 0x022050dc,
+	[FW_EXCEPT_COUNT_ADDR]		= 0x02204ffc,
+	[FW_CIRQ_COUNT_ADDR]		= 0x022001ac,
+	[FW_CIRQ_IDX_ADDR]		= 0x02204ec4,
+	[FW_CIRQ_LISR_ADDR]		= 0x02205010,
+	[FW_TASK_ID_ADDR]		= 0x02204fac,
+	[FW_TASK_IDX_ADDR]		= 0x02204f4c,
+	[FW_TASK_QID1_ADDR]		= 0x02202814,
+	[FW_TASK_QID2_ADDR]		= 0x02202984,
+	[FW_TASK_START_ADDR]		= 0x022027b8,
+	[FW_TASK_END_ADDR]		= 0x022027bc,
+	[FW_TASK_SIZE_ADDR]		= 0x022027c4,
+	[FW_LAST_MSG_ID_ADDR]		= 0x02204f28,
+	[FW_EINT_INFO_ADDR]		= 0x02205194,
+	[FW_SCHED_INFO_ADDR]		= 0x022051a4,
+	[SWDEF_BASE_ADDR]		= 0x411400,
+	[TXQ_WED_RING_BASE]		= 0x24420,
+	[RXQ_WED_RING_BASE]		= 0x24520,
+	[RXQ_WED_DATA_RING_BASE]	= 0x24540,
 };
 
 static const u32 mt7915_offs[] = {
@@ -585,6 +589,80 @@ static void mt7915_mmio_wed_offload_disable(struct mtk_wed_device *wed)
 		mt76_clear(dev, MT_AGG_ACR4(phy->band_idx),
 			   MT_AGG_ACR_PPDU_TXS2H);
 }
+
+static void mt7915_wed_release_rx_buf(struct mtk_wed_device *wed)
+{
+	struct mt7915_dev *dev;
+	struct page *page;
+	int i;
+
+	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
+	for (i = 0; i < dev->mt76.rx_token_size; i++) {
+		struct mt76_txwi_cache *t;
+
+		t = mt76_rx_token_release(&dev->mt76, i);
+		if (!t || !t->ptr)
+			continue;
+
+		dma_unmap_single(dev->mt76.dma_dev, t->dma_addr,
+				 wed->wlan.rx_size, DMA_FROM_DEVICE);
+		skb_free_frag(t->ptr);
+		t->ptr = NULL;
+
+		mt76_put_rxwi(&dev->mt76, t);
+	}
+
+	if (!wed->rx_buf_ring.rx_page.va)
+		return;
+
+	page = virt_to_page(wed->rx_buf_ring.rx_page.va);
+	__page_frag_cache_drain(page, wed->rx_buf_ring.rx_page.pagecnt_bias);
+	memset(&wed->rx_buf_ring.rx_page, 0, sizeof(wed->rx_buf_ring.rx_page));
+}
+
+static u32 mt7915_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
+{
+	struct mtk_rxbm_desc *desc = wed->rx_buf_ring.desc;
+	struct mt7915_dev *dev;
+	u32 length;
+	int i;
+
+	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
+	length = SKB_DATA_ALIGN(NET_SKB_PAD + wed->wlan.rx_size +
+				sizeof(struct skb_shared_info));
+
+	for (i = 0; i < size; i++) {
+		struct mt76_txwi_cache *t = mt76_get_rxwi(&dev->mt76);
+		dma_addr_t phy_addr;
+		int token;
+		void *ptr;
+
+		ptr = page_frag_alloc(&wed->rx_buf_ring.rx_page, length,
+				      GFP_KERNEL);
+		if (!ptr)
+			goto unmap;
+
+		phy_addr = dma_map_single(dev->mt76.dma_dev, ptr,
+					  wed->wlan.rx_size,
+					  DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dev->mt76.dev, phy_addr))) {
+			skb_free_frag(ptr);
+			goto unmap;
+		}
+
+		desc->buf0 = cpu_to_le32(phy_addr);
+		token = mt76_rx_token_consume(&dev->mt76, ptr, t, phy_addr);
+		desc->token |= cpu_to_le32(FIELD_PREP(MT_DMA_CTL_TOKEN,
+						      token));
+		desc++;
+	}
+
+	return 0;
+
+unmap:
+	mt7915_wed_release_rx_buf(wed);
+	return -ENOMEM;
+}
 #endif
 
 int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
@@ -602,6 +680,10 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 
 		wed->wlan.pci_dev = pci_dev;
 		wed->wlan.bus_type = MTK_WED_BUS_PCIE;
+		wed->wlan.base = devm_ioremap(dev->mt76.dev,
+					      pci_resource_start(pci_dev, 0),
+					      pci_resource_len(pci_dev, 0));
+		wed->wlan.phy_base = pci_resource_start(pci_dev, 0);
 		wed->wlan.wpdma_int = pci_resource_start(pci_dev, 0) +
 				      MT_INT_WED_SOURCE_CSR;
 		wed->wlan.wpdma_mask = pci_resource_start(pci_dev, 0) +
@@ -612,6 +694,10 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 				     MT_TXQ_WED_RING_BASE;
 		wed->wlan.wpdma_txfree = pci_resource_start(pci_dev, 0) +
 					 MT_RXQ_WED_RING_BASE;
+		wed->wlan.wpdma_rx_glo = pci_resource_start(pci_dev, 0) +
+					 MT_WPDMA_GLO_CFG;
+		wed->wlan.wpdma_rx = pci_resource_start(pci_dev, 0) +
+				     MT_RXQ_WED_DATA_RING_BASE;
 	} else {
 		struct platform_device *plat_dev = pdev_ptr;
 		struct resource *res;
@@ -622,19 +708,44 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 
 		wed->wlan.platform_dev = plat_dev;
 		wed->wlan.bus_type = MTK_WED_BUS_AXI;
+		wed->wlan.base = devm_ioremap(dev->mt76.dev, res->start,
+					      resource_size(res));
+		wed->wlan.phy_base = res->start;
 		wed->wlan.wpdma_int = res->start + MT_INT_SOURCE_CSR;
 		wed->wlan.wpdma_mask = res->start + MT_INT_MASK_CSR;
 		wed->wlan.wpdma_tx = res->start + MT_TXQ_WED_RING_BASE;
 		wed->wlan.wpdma_txfree = res->start + MT_RXQ_WED_RING_BASE;
+		wed->wlan.wpdma_rx_glo = res->start + MT_WPDMA_GLO_CFG;
+		wed->wlan.wpdma_rx = res->start + MT_RXQ_WED_DATA_RING_BASE;
 	}
 	wed->wlan.nbuf = 4096;
 	wed->wlan.tx_tbit[0] = is_mt7915(&dev->mt76) ? 4 : 30;
 	wed->wlan.tx_tbit[1] = is_mt7915(&dev->mt76) ? 5 : 31;
-	wed->wlan.txfree_tbit = is_mt7915(&dev->mt76) ? 1 : 2;
+	wed->wlan.txfree_tbit = is_mt7986(&dev->mt76) ? 2 : 1;
 	wed->wlan.token_start = MT7915_TOKEN_SIZE - wed->wlan.nbuf;
+	wed->wlan.wcid_512 = !is_mt7915(&dev->mt76);
+
+	wed->wlan.rx_nbuf = 65536;
+	wed->wlan.rx_npkt = MT7915_WED_RX_TOKEN_SIZE;
+	wed->wlan.rx_size = SKB_WITH_OVERHEAD(MT_RX_BUF_SIZE);
+	if (is_mt7915(&dev->mt76)) {
+		wed->wlan.rx_tbit[0] = 16;
+		wed->wlan.rx_tbit[1] = 17;
+	} else if (is_mt7986(&dev->mt76)) {
+		wed->wlan.rx_tbit[0] = 22;
+		wed->wlan.rx_tbit[1] = 23;
+	} else {
+		wed->wlan.rx_tbit[0] = 18;
+		wed->wlan.rx_tbit[1] = 19;
+	}
+
 	wed->wlan.init_buf = mt7915_wed_init_buf;
 	wed->wlan.offload_enable = mt7915_mmio_wed_offload_enable;
 	wed->wlan.offload_disable = mt7915_mmio_wed_offload_disable;
+	wed->wlan.init_rx_buf = mt7915_wed_init_rx_buf;
+	wed->wlan.release_rx_buf = mt7915_wed_release_rx_buf;
+
+	dev->mt76.rx_token_size = wed->wlan.rx_npkt;
 
 	if (mtk_wed_device_attach(wed))
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 460be184e617..574f712b5fe1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -68,6 +68,8 @@
 #define MT7915_MIN_TWT_DUR 64
 #define MT7915_MAX_QUEUE		(MT_RXQ_BAND2 + __MT_MCUQ_MAX + 2)
 
+#define MT7915_WED_RX_TOKEN_SIZE	12288
+
 struct mt7915_vif;
 struct mt7915_sta;
 struct mt7915_dfs_pulse;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 0c61f1256f3b..42a19e7b95d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -43,6 +43,7 @@ enum reg_rev {
 	SWDEF_BASE_ADDR,
 	TXQ_WED_RING_BASE,
 	RXQ_WED_RING_BASE,
+	RXQ_WED_DATA_RING_BASE,
 	__MT_REG_MAX,
 };
 
@@ -588,9 +589,14 @@ enum offs_rev {
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
 
 #define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
+
+#define MT_WFDMA0_EXT0_CFG		MT_WFDMA0(0x2b0)
+#define MT_WFDMA0_EXT0_RXWB_KEEP	BIT(10)
+
 #define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
 #define MT_WFDMA0_PRI_DLY_INT_CFG1	MT_WFDMA0(0x2f4)
 #define MT_WFDMA0_PRI_DLY_INT_CFG2	MT_WFDMA0(0x2f8)
+#define MT_WPDMA_GLO_CFG		MT_WFDMA0(0x208)
 
 /* WFDMA1 */
 #define MT_WFDMA1_BASE			0xd5000
@@ -686,6 +692,7 @@ enum offs_rev {
 
 #define MT_TXQ_WED_RING_BASE		__REG(TXQ_WED_RING_BASE)
 #define MT_RXQ_WED_RING_BASE		__REG(RXQ_WED_RING_BASE)
+#define MT_RXQ_WED_DATA_RING_BASE	__REG(RXQ_WED_DATA_RING_BASE)
 
 #define MT_INT_SOURCE_CSR		__REG(INT_SOURCE_CSR)
 #define MT_INT_MASK_CSR			__REG(INT_MASK_CSR)
-- 
2.38.1

