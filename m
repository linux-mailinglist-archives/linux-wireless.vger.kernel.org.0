Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B343C62C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 11:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbhJ0JMR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 05:12:17 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53744 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241185AbhJ0JMN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 05:12:13 -0400
X-UUID: d938e75838c74096be44728eee9d4ee1-20211027
X-UUID: d938e75838c74096be44728eee9d4ee1-20211027
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 101286905; Wed, 27 Oct 2021 17:09:42 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 27 Oct 2021 17:09:41 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Oct
 2021 16:40:33 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 27 Oct 2021 16:40:33 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH 02/11] mt76: mt7915: refine register definition
Date:   Wed, 27 Oct 2021 16:40:10 +0800
Message-ID: <7d6e535525d41806310209bd5d529179fcca4be6.1635323366.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1635323366.git.Bo.Jiao@mediatek.com>
References: <cover.1635323366.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Add mt7915_reg_desc to differentiate chip generations.
This is an intermediate patch to introduce mt7916 support.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  20 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |   5 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  26 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 507 +++++++++++++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 607 ++++++++++++------
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  58 +-
 7 files changed, 907 insertions(+), 320 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index a15aa25..fa7553f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -302,14 +302,14 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 DEFINE_SHOW_ATTRIBUTE(mt7915_tx_stats);
 
 static void
-mt7915_hw_queue_read(struct seq_file *s, u32 base, u32 size,
+mt7915_hw_queue_read(struct seq_file *s, u32 size,
 		     const struct hw_queue_map *map)
 {
 	struct mt7915_phy *phy = s->private;
 	struct mt7915_dev *dev = phy->dev;
 	u32 i, val;
 
-	val = mt76_rr(dev, base + MT_FL_Q_EMPTY);
+	val = mt76_rr(dev, MT_FL_Q_EMPTY);
 	for (i = 0; i < size; i++) {
 		u32 ctrl, head, tail, queued;
 
@@ -317,13 +317,13 @@ mt7915_hw_queue_read(struct seq_file *s, u32 base, u32 size,
 			continue;
 
 		ctrl = BIT(31) | (map[i].pid << 10) | (map[i].qid << 24);
-		mt76_wr(dev, base + MT_FL_Q0_CTRL, ctrl);
+		mt76_wr(dev, MT_FL_Q0_CTRL, ctrl);
 
-		head = mt76_get_field(dev, base + MT_FL_Q2_CTRL,
+		head = mt76_get_field(dev, MT_FL_Q2_CTRL,
 				      GENMASK(11, 0));
-		tail = mt76_get_field(dev, base + MT_FL_Q2_CTRL,
+		tail = mt76_get_field(dev, MT_FL_Q2_CTRL,
 				      GENMASK(27, 16));
-		queued = mt76_get_field(dev, base + MT_FL_Q3_CTRL,
+		queued = mt76_get_field(dev, MT_FL_Q3_CTRL,
 					GENMASK(11, 0));
 
 		seq_printf(s, "\t%s: ", map[i].name);
@@ -351,8 +351,8 @@ mt7915_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 		if (val & BIT(offs))
 			continue;
 
-		mt76_wr(dev, MT_PLE_BASE + MT_FL_Q0_CTRL, ctrl | msta->wcid.idx);
-		qlen = mt76_get_field(dev, MT_PLE_BASE + MT_FL_Q3_CTRL,
+		mt76_wr(dev, MT_FL_Q0_CTRL, ctrl | msta->wcid.idx);
+		qlen = mt76_get_field(dev, MT_FL_Q3_CTRL,
 				      GENMASK(11, 0));
 		seq_printf(s, "\tSTA %pM wcid %d: AC%d%d queued:%d\n",
 			   sta->addr, msta->wcid.idx, msta->vif->wmm_idx,
@@ -414,7 +414,7 @@ mt7915_hw_queues_show(struct seq_file *file, void *data)
 		   val, head, tail);
 
 	seq_puts(file, "PLE non-empty queue info:\n");
-	mt7915_hw_queue_read(file, MT_PLE_BASE, ARRAY_SIZE(ple_queue_map),
+	mt7915_hw_queue_read(file, ARRAY_SIZE(ple_queue_map),
 			     &ple_queue_map[0]);
 
 	/* iterate per-sta ple queue */
@@ -422,7 +422,7 @@ mt7915_hw_queues_show(struct seq_file *file, void *data)
 					  mt7915_sta_hw_queue_read, file);
 	/* pse queue */
 	seq_puts(file, "PSE non-empty queue info:\n");
-	mt7915_hw_queue_read(file, MT_PSE_BASE, ARRAY_SIZE(pse_queue_map),
+	mt7915_hw_queue_read(file, ARRAY_SIZE(pse_queue_map),
 			     &pse_queue_map[0]);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 9182568..ad9678b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -7,6 +7,7 @@
 
 int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc)
 {
+	struct mt7915_dev *dev = phy->dev;
 	int i, err;
 
 	err = mt76_init_tx_queue(phy->mt76, 0, idx, n_desc, MT_TX_RING_BASE);
@@ -74,7 +75,7 @@ void mt7915_dma_prefetch(struct mt7915_dev *dev)
 {
 	__mt7915_dma_prefetch(dev, 0);
 	if (dev->hif2)
-		__mt7915_dma_prefetch(dev, MT_WFDMA1_PCIE1_BASE - MT_WFDMA1_BASE);
+		__mt7915_dma_prefetch(dev, MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0));
 }
 
 int mt7915_dma_init(struct mt7915_dev *dev)
@@ -85,7 +86,7 @@ int mt7915_dma_init(struct mt7915_dev *dev)
 	mt76_dma_attach(&dev->mt76);
 
 	if (dev->hif2)
-		hif1_ofs = MT_WFDMA1_PCIE1_BASE - MT_WFDMA1_BASE;
+		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 
 	/* configure global setting */
 	mt76_set(dev, MT_WFDMA1_GLO_CFG,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 5fcf35f..4216858 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1763,7 +1763,7 @@ static void
 mt7915_dma_reset(struct mt7915_dev *dev)
 {
 	struct mt76_phy *mphy_ext = dev->mt76.phy2;
-	u32 hif1_ofs = MT_WFDMA1_PCIE1_BASE - MT_WFDMA1_BASE;
+	u32 hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 	int i;
 
 	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
@@ -1925,8 +1925,8 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	bool ext_phy = phy != &dev->phy;
 	int i, aggr0, aggr1, cnt;
 
-	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
-					   MT_MIB_SDR3_FCS_ERR_MASK);
+	cnt = mt76_rr(dev, MT_MIB_SDR3(ext_phy));
+	mib->fcs_err_cnt += __FIELD_GET(MIB_SDR3_FCS_ERR, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR4(ext_phy));
 	mib->rx_fifo_full_cnt += FIELD_GET(MT_MIB_SDR4_RX_FIFO_FULL_MASK, cnt);
@@ -1953,10 +1953,10 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	mib->tx_stop_q_empty_cnt += FIELD_GET(MT_MIB_SDR13_TX_STOP_Q_EMPTY_CNT_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR14(ext_phy));
-	mib->tx_mpdu_attempts_cnt += FIELD_GET(MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK, cnt);
+	mib->tx_mpdu_attempts_cnt += __FIELD_GET(MIB_MPDU_ATTEMPTS_CNT, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR15(ext_phy));
-	mib->tx_mpdu_success_cnt += FIELD_GET(MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK, cnt);
+	mib->tx_mpdu_success_cnt += __FIELD_GET(MIB_MPDU_SUCCESS_CNT, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR22(ext_phy));
 	mib->rx_ampdu_cnt += cnt;
@@ -1965,7 +1965,7 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	mib->rx_ampdu_bytes_cnt += cnt;
 
 	cnt = mt76_rr(dev, MT_MIB_SDR24(ext_phy));
-	mib->rx_ampdu_valid_subframe_cnt += FIELD_GET(MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK, cnt);
+	mib->rx_ampdu_valid_subframe_cnt += __FIELD_GET(MIB_AMPDU_SF_CNT, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR25(ext_phy));
 	mib->rx_ampdu_valid_subframe_bytes_cnt += cnt;
@@ -1977,11 +1977,10 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	mib->tx_rwp_need_cnt += FIELD_GET(MT_MIB_SDR28_TX_RWP_NEED_CNT_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR29(ext_phy));
-	mib->rx_pfdrop_cnt += FIELD_GET(MT_MIB_SDR29_RX_PFDROP_CNT_MASK, cnt);
+	mib->rx_pfdrop_cnt += __FIELD_GET(MIB_PF_DROP_CNT, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR30(ext_phy));
-	mib->rx_vec_queue_overflow_drop_cnt +=
-		FIELD_GET(MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK, cnt);
+	cnt = mt76_rr(dev, MT_MIB_SDRVEC(ext_phy));
+	mib->rx_vec_queue_overflow_drop_cnt += __FIELD_GET(MIB_VEC_DROP_CNT, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR31(ext_phy));
 	mib->rx_ba_cnt += cnt;
@@ -1989,10 +1988,11 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	cnt = mt76_rr(dev, MT_MIB_SDR32(ext_phy));
 	mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR32_TX_PKT_EBF_CNT_MASK, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR33(ext_phy));
-	mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR33_TX_PKT_IBF_CNT_MASK, cnt);
+	if (is_mt7915(&dev->mt76))
+		cnt = mt76_rr(dev, MT_MIB_SDR33(ext_phy));
+	mib->tx_pkt_ibf_cnt += __FIELD_GET(MIB_BF_TX_CNT, cnt);
 
-	cnt = mt76_rr(dev, MT_MIB_SDR34(ext_phy));
+	cnt = mt76_rr(dev, MT_MIB_SDRMUBF(ext_phy));
 	mib->tx_bf_cnt += FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_DR8(ext_phy));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 2f8b72b..0d67321 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -10,100 +10,449 @@
 #include "mac.h"
 #include "../trace.h"
 
+static const u32 mt7915_base[] = {
+	[MT_REMAP_L1_CFG_BASE]	= 0xf1000,
+	[MT_REMAP_L1_BASE]	= 0xe0000,
+	[MT_REMAP_L2_CFG_BASE]	= 0xf1000,
+	[MT_REMAP_L2_BASE]	= 0x00000,
+	[MT_INFRA_MCU_END_BASE]	= 0x7c3fffff,
+	[MT_PCIE_MAC_BASE]	= 0x74030000,
+	[MT_PCIE1_MAC_BASE]	= 0x74020000,
+	[MT_WFDMA0_BASE]	= 0xd4000,
+	[MT_WFDMA1_BASE]	= 0xd5000,
+	[MT_WFDMA0_PCIE1_BASE]	= 0xd8000,
+	[MT_WFDMA1_PCIE1_BASE]	= 0xd9000,
+	[MT_WFDMA_EXT_CSR_BASE]	= 0xd7000,
+	[MT_SWDEF_BASE]		= 0x41f200,
+	[MT_MCU_WFDMA0_BASE]	= 0x2000,
+	[MT_MCU_WFDMA1_BASE]	= 0x3000,
+};
+
+static const u32 mt7916_base[] = {
+	[MT_REMAP_L1_CFG_BASE]	= 0xfe000,
+	[MT_REMAP_L1_BASE]	= 0xe0000,
+	[MT_REMAP_L2_CFG_BASE]	= 0x00000,
+	[MT_REMAP_L2_BASE]	= 0x40000,
+	[MT_INFRA_MCU_END_BASE]	= 0x7c085fff,
+	[MT_PCIE_MAC_BASE]	= 0x74030000,
+	[MT_PCIE1_MAC_BASE]	= 0x74090000,
+	[MT_WFDMA0_BASE]	= 0xd4000,
+	[MT_WFDMA1_BASE]	= 0xd5000,
+	[MT_WFDMA0_PCIE1_BASE]	= 0xd8000,
+	[MT_WFDMA1_PCIE1_BASE]	= 0xd9000,
+	[MT_WFDMA_EXT_CSR_BASE]	= 0xd7000,
+	[MT_SWDEF_BASE]		= 0x411400,
+	[MT_MCU_WFDMA0_BASE]	= 0x2000,
+	[MT_MCU_WFDMA1_BASE]	= 0x3000,
+};
+
+static const struct __reg mt7915_reg[] = {
+	[L1_REMAP_CFG_OFFSET]	= { MT_REMAP_L1_CFG_BASE, 0x1ac },
+	[L2_REMAP_CFG_OFFSET]	= { MT_REMAP_L2_CFG_BASE, 0x1b0 },
+	[INT_SOURCE_CSR]	= { MT_WFDMA_EXT_CSR_BASE, 0x10 },
+	[INT_MASK_CSR]		= { MT_WFDMA_EXT_CSR_BASE, 0x14 },
+	[INT1_SOURCE_CSR]	= { MT_WFDMA_EXT_CSR_BASE, 0x88 },
+	[INT1_MASK_CSR]		= { MT_WFDMA_EXT_CSR_BASE, 0x8c },
+	[INT_MCU_CMD_SOURCE]	= { MT_WFDMA1_BASE, 0x1f0 },
+	[INT_MCU_CMD_EVENT]	= { MT_MCU_WFDMA1_BASE, 0x108 },
+	[TX_RING_BASE]		= { MT_WFDMA1_BASE, 0x400 },
+	[RX_EVENT_RING_BASE]	= { MT_WFDMA1_BASE, 0x500 },
+	[RX_DATA_RING_BASE]	= { MT_WFDMA0_BASE, 0x500 },
+	[TMAC_CDTR]		= { INVALID_BASE, 0x090 },
+	[TMAC_ODTR]		= { INVALID_BASE, 0x094 },
+	[TMAC_ATCR]		= { INVALID_BASE, 0x098 },
+	[TMAC_TRCR0]		= { INVALID_BASE, 0x09c },
+	[TMAC_ICR0]		= { INVALID_BASE, 0x0a4 },
+	[TMAC_ICR1]		= { INVALID_BASE, 0x0b4 },
+	[TMAC_CTCR0]		= { INVALID_BASE, 0x0f4 },
+	[TMAC_TFCR0]		= { INVALID_BASE, 0x1e0 },
+	[MDP_BNRCFR0]		= { INVALID_BASE, 0x070 },
+	[MDP_BNRCFR1]		= { INVALID_BASE, 0x074 },
+	[ARB_DRNGR0]		= { INVALID_BASE, 0x194 },
+	[ARB_SCR]		= { INVALID_BASE, 0x080 },
+	[RMAC_MIB_AIRTIME14]	= { INVALID_BASE, 0x3b8 },
+	[AGG_AWSCR0]		= { INVALID_BASE, 0x05c },
+	[AGG_PCR0]		= { INVALID_BASE, 0x06c },
+	[AGG_ACR0]		= { INVALID_BASE, 0x084 },
+	[AGG_MRCR]		= { INVALID_BASE, 0x098 },
+	[AGG_ATCR1]		= { INVALID_BASE, 0x0f0 },
+	[AGG_ATCR3]		= { INVALID_BASE, 0x0f4 },
+	[LPON_UTTR0]		= { INVALID_BASE, 0x080 },
+	[LPON_UTTR1]		= { INVALID_BASE, 0x084 },
+	[MIB_SDR3]		= { INVALID_BASE, 0x014 },
+	[MIB_SDR4]		= { INVALID_BASE, 0x018 },
+	[MIB_SDR5]		= { INVALID_BASE, 0x01c },
+	[MIB_SDR7]		= { INVALID_BASE, 0x024 },
+	[MIB_SDR8]		= { INVALID_BASE, 0x028 },
+	[MIB_SDR9]		= { INVALID_BASE, 0x02c },
+	[MIB_SDR10]		= { INVALID_BASE, 0x030 },
+	[MIB_SDR11]		= { INVALID_BASE, 0x034 },
+	[MIB_SDR12]		= { INVALID_BASE, 0x038 },
+	[MIB_SDR13]		= { INVALID_BASE, 0x03c },
+	[MIB_SDR14]		= { INVALID_BASE, 0x040 },
+	[MIB_SDR15]		= { INVALID_BASE, 0x044 },
+	[MIB_SDR16]		= { INVALID_BASE, 0x048 },
+	[MIB_SDR17]		= { INVALID_BASE, 0x04c },
+	[MIB_SDR18]		= { INVALID_BASE, 0x050 },
+	[MIB_SDR19]		= { INVALID_BASE, 0x054 },
+	[MIB_SDR20]		= { INVALID_BASE, 0x058 },
+	[MIB_SDR21]		= { INVALID_BASE, 0x05c },
+	[MIB_SDR22]		= { INVALID_BASE, 0x060 },
+	[MIB_SDR23]		= { INVALID_BASE, 0x064 },
+	[MIB_SDR24]		= { INVALID_BASE, 0x068 },
+	[MIB_SDR25]		= { INVALID_BASE, 0x06c },
+	[MIB_SDR27]		= { INVALID_BASE, 0x074 },
+	[MIB_SDR28]		= { INVALID_BASE, 0x078 },
+	[MIB_SDR29]		= { INVALID_BASE, 0x07c },
+	[MIB_SDRVEC]		= { INVALID_BASE, 0x080 },
+	[MIB_SDR31]		= { INVALID_BASE, 0x084 },
+	[MIB_SDR32]		= { INVALID_BASE, 0x088 },
+	[MIB_SDRMUBF]		= { INVALID_BASE, 0x090 },
+	[MIB_DR8]		= { INVALID_BASE, 0x0c0 },
+	[MIB_DR9]		= { INVALID_BASE, 0x0c4 },
+	[MIB_DR11]		= { INVALID_BASE, 0x0cc },
+	[MIB_MB_SDR0]		= { INVALID_BASE, 0x100 },
+	[MIB_MB_SDR1]		= { INVALID_BASE, 0x104 },
+	[TX_AGG_CNT]		= { INVALID_BASE, 0x0a8 },
+	[TX_AGG_CNT2]		= { INVALID_BASE, 0x164 },
+	[MIB_ARNG]		= { INVALID_BASE, 0x4b8 },
+	[WTBLON_TOP_WDUCR]	= { INVALID_BASE, 0x0},
+	[WTBL_UPDATE]		= { INVALID_BASE, 0x030},
+	[PLE_FL_Q_EMPTY]	= { INVALID_BASE, 0x0b0},
+	[PLE_FL_Q_CTRL]		= { INVALID_BASE, 0x1b0},
+	[PLE_AC_QEMPTY]		= { INVALID_BASE, 0x500},
+	[PLE_FREEPG_CNT]	= { INVALID_BASE, 0x100},
+	[PLE_FREEPG_HEAD_TAIL]	= { INVALID_BASE, 0x104},
+	[PLE_PG_HIF_GROUP]	= { INVALID_BASE, 0x110},
+	[PLE_HIF_PG_INFO]	= { INVALID_BASE, 0x114},
+	[AC_OFFSET]		= { INVALID_BASE, 0x040},
+};
+
+static const struct __reg mt7916_reg[] = {
+	[L1_REMAP_CFG_OFFSET]	= { MT_REMAP_L1_CFG_BASE, 0x260 },
+	[L2_REMAP_CFG_OFFSET]	= { MT_REMAP_L2_CFG_BASE, 0x1b8 },
+	[INT_SOURCE_CSR]	= { MT_WFDMA0_BASE, 0x200 },
+	[INT_MASK_CSR]		= { MT_WFDMA0_BASE, 0x204 },
+	[INT1_SOURCE_CSR]	= { MT_WFDMA0_PCIE1_BASE, 0x200 },
+	[INT1_MASK_CSR]		= { MT_WFDMA0_PCIE1_BASE, 0x204 },
+	[INT_MCU_CMD_SOURCE]	= { MT_WFDMA0_BASE, 0x1f0 },
+	[INT_MCU_CMD_EVENT]	= { MT_MCU_WFDMA0_BASE, 0x108 },
+	[TX_RING_BASE]		= { MT_WFDMA0_BASE, 0x400 },
+	[RX_EVENT_RING_BASE]	= { MT_WFDMA0_BASE, 0x500 },
+	[RX_DATA_RING_BASE]	= { MT_WFDMA0_BASE, 0x540 },
+	[TMAC_CDTR]		= { INVALID_BASE, 0x0c8 },
+	[TMAC_ODTR]		= { INVALID_BASE, 0x0cc },
+	[TMAC_ATCR]		= { INVALID_BASE, 0x00c },
+	[TMAC_TRCR0]		= { INVALID_BASE, 0x010 },
+	[TMAC_ICR0]		= { INVALID_BASE, 0x014 },
+	[TMAC_ICR1]		= { INVALID_BASE, 0x018 },
+	[TMAC_CTCR0]		= { INVALID_BASE, 0x114 },
+	[TMAC_TFCR0]		= { INVALID_BASE, 0x0e4 },
+	[MDP_BNRCFR0]		= { INVALID_BASE, 0x090 },
+	[MDP_BNRCFR1]		= { INVALID_BASE, 0x094 },
+	[ARB_DRNGR0]		= { INVALID_BASE, 0x1e0 },
+	[ARB_SCR]		= { INVALID_BASE, 0x000 },
+	[RMAC_MIB_AIRTIME14]	= { INVALID_BASE, 0x0398 },
+	[AGG_AWSCR0]		= { INVALID_BASE, 0x030 },
+	[AGG_PCR0]		= { INVALID_BASE, 0x040 },
+	[AGG_ACR0]		= { INVALID_BASE, 0x054 },
+	[AGG_MRCR]		= { INVALID_BASE, 0x068 },
+	[AGG_ATCR1]		= { INVALID_BASE, 0x1a8 },
+	[AGG_ATCR3]		= { INVALID_BASE, 0x080 },
+	[LPON_UTTR0]		= { INVALID_BASE, 0x360 },
+	[LPON_UTTR1]		= { INVALID_BASE, 0x364 },
+	[MIB_SDR3]		= { INVALID_BASE, 0x698 },
+	[MIB_SDR4]		= { INVALID_BASE, 0x788 },
+	[MIB_SDR5]		= { INVALID_BASE, 0x780 },
+	[MIB_SDR7]		= { INVALID_BASE, 0x5a8 },
+	[MIB_SDR8]		= { INVALID_BASE, 0x78c },
+	[MIB_SDR9]		= { INVALID_BASE, 0x024 },
+	[MIB_SDR10]		= { INVALID_BASE, 0x76c },
+	[MIB_SDR11]		= { INVALID_BASE, 0x790 },
+	[MIB_SDR12]		= { INVALID_BASE, 0x558 },
+	[MIB_SDR13]		= { INVALID_BASE, 0x560 },
+	[MIB_SDR14]		= { INVALID_BASE, 0x564 },
+	[MIB_SDR15]		= { INVALID_BASE, 0x568 },
+	[MIB_SDR16]		= { INVALID_BASE, 0x7fc },
+	[MIB_SDR17]		= { INVALID_BASE, 0x800 },
+	[MIB_SDR18]		= { INVALID_BASE, 0x030 },
+	[MIB_SDR19]		= { INVALID_BASE, 0x5ac },
+	[MIB_SDR20]		= { INVALID_BASE, 0x5b0 },
+	[MIB_SDR21]		= { INVALID_BASE, 0x5b4 },
+	[MIB_SDR22]		= { INVALID_BASE, 0x770 },
+	[MIB_SDR23]		= { INVALID_BASE, 0x774 },
+	[MIB_SDR24]		= { INVALID_BASE, 0x778 },
+	[MIB_SDR25]		= { INVALID_BASE, 0x77c },
+	[MIB_SDR27]		= { INVALID_BASE, 0x080 },
+	[MIB_SDR28]		= { INVALID_BASE, 0x084 },
+	[MIB_SDR29]		= { INVALID_BASE, 0x650 },
+	[MIB_SDRVEC]		= { INVALID_BASE, 0x5a8 },
+	[MIB_SDR31]		= { INVALID_BASE, 0x55c },
+	[MIB_SDR32]		= { INVALID_BASE, 0x7a8 },
+	[MIB_SDRMUBF]		= { INVALID_BASE, 0x7ac },
+	[MIB_DR8]		= { INVALID_BASE, 0x56c },
+	[MIB_DR9]		= { INVALID_BASE, 0x570 },
+	[MIB_DR11]		= { INVALID_BASE, 0x574 },
+	[MIB_MB_SDR0]		= { INVALID_BASE, 0x688 },
+	[MIB_MB_SDR1]		= { INVALID_BASE, 0x690 },
+	[TX_AGG_CNT]		= { INVALID_BASE, 0x7dc },
+	[TX_AGG_CNT2]		= { INVALID_BASE, 0x7ec },
+	[MIB_ARNG]		= { INVALID_BASE, 0x0b0 },
+	[WTBLON_TOP_WDUCR]	= { INVALID_BASE, 0x200},
+	[WTBL_UPDATE]		= { INVALID_BASE, 0x230},
+	[PLE_FL_Q_EMPTY]	= { INVALID_BASE, 0x360},
+	[PLE_FL_Q_CTRL]		= { INVALID_BASE, 0x3e0},
+	[PLE_AC_QEMPTY]		= { INVALID_BASE, 0x600},
+	[PLE_FREEPG_CNT]	= { INVALID_BASE, 0x380},
+	[PLE_FREEPG_HEAD_TAIL]	= { INVALID_BASE, 0x384},
+	[PLE_PG_HIF_GROUP]	= { INVALID_BASE, 0x00c},
+	[PLE_HIF_PG_INFO]	= { INVALID_BASE, 0x388},
+	[AC_OFFSET]		= { INVALID_BASE, 0x080},
+};
+
+static const struct __mask mt7915_mask[] = {
+	[L2_REMAP_MASK]		= {19, 0},
+	[L2_REMAP_OFFSET]	= {11, 0},
+	[L2_REMAP_BASE]		= {31, 12},
+	[MIB_SDR3_FCS_ERR]	= {15, 0},
+	[MIB_MRDY_CNT]		= {25, 0},
+	[MIB_MPDU_ATTEMPTS_CNT]	= {23, 0},
+	[MIB_MPDU_SUCCESS_CNT]	= {23, 0},
+	[MIB_AMPDU_SF_CNT]	= {23, 0},
+	[MIB_PF_DROP_CNT]	= {7, 0},
+	[MIB_VEC_DROP_CNT]	= {15, 0},
+	[MIB_BF_TX_CNT]		= {15, 0},
+};
+
+static const struct __mask mt7916_mask[] = {
+	[L2_REMAP_MASK]		= {31, 16},
+	[L2_REMAP_OFFSET]	= {15, 0},
+	[L2_REMAP_BASE]		= {31, 16},
+	[MIB_SDR3_FCS_ERR]	= {31, 16},
+	[MIB_MRDY_CNT]		= {31, 0},
+	[MIB_MPDU_ATTEMPTS_CNT]	= {31, 0},
+	[MIB_MPDU_SUCCESS_CNT]	= {31, 0},
+	[MIB_AMPDU_SF_CNT]	= {31, 0},
+	[MIB_PF_DROP_CNT]	= {15, 0},
+	[MIB_VEC_DROP_CNT]	= {31, 16},
+	[MIB_BF_TX_CNT]		= {31, 16},
+};
+
+static const u32 mt7915_bit[] = {
+	[RX_DONE_DAND0]		= 16,
+	[RX_DONE_DAND1]		= 17,
+	[RX_DONE_MCU_WM]	= 0,
+	[RX_DONE_MCU_WA]	= 1,
+	[RX_DONE_WA_BAND0]	= 1,
+	[RX_DONE_WA_BAND1]	= 2,
+	[TX_DONE_FWDL]		= 26,
+	[TX_DONE_MCU_WM]	= 27,
+	[TX_DONE_MCU_WA]	= 15,
+	[TX_DONE_BAND0]		= 30,
+	[TX_DONE_BAND1]		= 31,
+	[RX_MCU_TO_HOST]	= 29,
+	[MIB_MB_SDR]		= 2,
+	[LPON_TCR]		= 0,
+};
+
+static const u32 mt7916_bit[] = {
+	[RX_DONE_DAND0]		= 22,
+	[RX_DONE_DAND1]		= 23,
+	[RX_DONE_MCU_WM]	= 0,
+	[RX_DONE_MCU_WA]	= 1,
+	[RX_DONE_WA_BAND0]	= 2,
+	[RX_DONE_WA_BAND1]	= 3,
+	[TX_DONE_FWDL]		= 26,
+	[TX_DONE_MCU_WM]	= 27,
+	[TX_DONE_MCU_WA]	= 25,
+	[TX_DONE_BAND0]		= 30,
+	[TX_DONE_BAND1]		= 31,
+	[RX_MCU_TO_HOST]	= 29,
+	[MIB_MB_SDR]		= 1,
+	[LPON_TCR]		= 2,
+};
+
+static const struct __map mt7915_reg_map[] = {
+	{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
+	{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure regs) */
+	{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
+	{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
+	{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
+	{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
+	{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
+	{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
+	{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
+	{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
+	{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
+	{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
+	{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
+	{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
+	{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
+	{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
+	{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
+	{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+	{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+	{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+	{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+	{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+	{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+	{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+	{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+	{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+	{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+	{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+	{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+	{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+	{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+	{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+	{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+	{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+	{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+	{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+	{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+	{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+	{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+	{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+	{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	{ 0x0, 0x0, 0x0 }, /* imply end of search */
+};
+
+static const struct __map mt7916_reg_map[] = {
+	{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA_0 (PCIE0 MCU DMA0) */
+	{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA_1 (PCIE0 MCU DMA1) */
+	{ 0x56000000, 0x04000, 0x1000 }, /* WFDMA_2 (Reserved) */
+	{ 0x57000000, 0x05000, 0x1000 }, /* WFDMA_3 (MCU wrap CR) */
+	{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA_4 (PCIE1 MCU DMA0) */
+	{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA_5 (PCIE1 MCU DMA1) */
+	{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
+	{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
+	{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
+	{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+	{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+	{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+	{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+	{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+	{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+	{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
+	{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+	{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
+	{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+	{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+	{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+	{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+	{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+	{ 0x820ca000, 0x26000, 0x2000 }, /* WF_LMAC_TOP BN0 (WF_MUCOP) */
+	{ 0x820d0000, 0x30000, 0x10000}, /* WF_LMAC_TOP (WF_WTBLON) */
+	{ 0x00400000, 0x80000, 0x10000}, /* WF_MCU_SYSRAM */
+	{ 0x00410000, 0x90000, 0x10000}, /* WF_MCU_SYSRAM (configure cr) */
+	{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+	{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+	{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+	{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+	{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+	{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+	{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+	{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+	{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+	{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+	{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+	{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	{ 0x820c4000, 0xa8000, 0x1000 }, /* WF_LMAC_TOP (WF_UWTBL ) */
+	{ 0x820b0000, 0xae000, 0x1000 }, /* [APB2] WFSYS_ON */
+	{ 0x80020000, 0xb0000, 0x10000}, /* WF_TOP_MISC_OFF */
+	{ 0x81020000, 0xc0000, 0x10000}, /* WF_TOP_MISC_ON */
+	{ 0x0, 0x0, 0x100000 }, /* fixed remap range */
+	{ 0x0, 0x0, 0x0 }, /* imply end of search */
+};
+
+static const struct mt7915_reg_desc reg_desc[] = {
+	{ 0x7915,
+	  mt7915_base,
+	  mt7915_reg,
+	  mt7915_mask,
+	  mt7915_bit,
+	  mt7915_reg_map,
+	  ARRAY_SIZE(mt7915_reg_map)
+	},
+	{ 0x7906,
+	  mt7916_base,
+	  mt7916_reg,
+	  mt7916_mask,
+	  mt7916_bit,
+	  mt7916_reg_map,
+	  ARRAY_SIZE(mt7916_reg_map)
+	},
+};
+
 static u32 mt7915_reg_map_l1(struct mt7915_dev *dev, u32 addr)
 {
 	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
 	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
 
-	mt76_rmw_field(dev, MT_HIF_REMAP_L1, MT_HIF_REMAP_L1_MASK, base);
+	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L1,
+			  MT_HIF_REMAP_L1_MASK,
+		FIELD_PREP(MT_HIF_REMAP_L1_MASK, base));
 	/* use read to push write */
-	mt76_rr(dev, MT_HIF_REMAP_L1);
+	dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L1);
 
 	return MT_HIF_REMAP_BASE_L1 + offset;
 }
 
 static u32 mt7915_reg_map_l2(struct mt7915_dev *dev, u32 addr)
 {
-	u32 offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET, addr);
-	u32 base = FIELD_GET(MT_HIF_REMAP_L2_BASE, addr);
+	u32 offset =  __FIELD_GET(L2_REMAP_OFFSET, addr);
+	u32 base = __FIELD_GET(L2_REMAP_BASE, addr);
+
+	dev->bus_ops->rmw(&dev->mt76, MT_HIF_REMAP_L2,
+			  MT_HIF_REMAP_L2_MASK,
+			  __FIELD_PREP(L2_REMAP_MASK, base));
 
-	mt76_rmw_field(dev, MT_HIF_REMAP_L2, MT_HIF_REMAP_L2_MASK, base);
 	/* use read to push write */
-	mt76_rr(dev, MT_HIF_REMAP_L2);
+	dev->bus_ops->rr(&dev->mt76, MT_HIF_REMAP_L2);
 
 	return MT_HIF_REMAP_BASE_L2 + offset;
 }
 
 static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
 {
-	static const struct {
-		u32 phys;
-		u32 mapped;
-		u32 size;
-	} fixed_map[] = {
-		{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
-		{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure regs) */
-		{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
-		{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
-		{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
-		{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
-		{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
-		{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
-		{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
-		{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
-		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
-		{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
-		{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
-		{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
-		{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
-		{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
-		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
-		{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
-		{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
-		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
-		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
-		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
-		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
-		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
-		{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
-		{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
-		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
-		{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
-		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
-		{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
-		{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
-		{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
-		{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
-		{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
-		{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
-		{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
-		{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
-		{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
-		{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
-		{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
-		{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
-	};
 	int i;
 
 	if (addr < 0x100000)
 		return addr;
 
-	for (i = 0; i < ARRAY_SIZE(fixed_map); i++) {
+	if (!dev->reg->map) {
+		dev_err(dev->mt76.dev, "err: reg_map is null\n");
+		return addr;
+	}
+
+	for (i = 0; i < dev->reg->map_size; i++) {
 		u32 ofs;
 
-		if (addr < fixed_map[i].phys)
+		if (addr < dev->reg->map[i].phys)
 			continue;
 
-		ofs = addr - fixed_map[i].phys;
-		if (ofs > fixed_map[i].size)
+		ofs = addr - dev->reg->map[i].phys;
+		if (ofs > dev->reg->map[i].size)
 			continue;
 
-		return fixed_map[i].mapped + ofs;
+		return dev->reg->map[i].maps + ofs;
 	}
 
-	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
-	    (addr >= 0x70000000 && addr < 0x78000000))
+	if ((addr >= MT_INFRA_BASE && addr < MT_WFSYS0_PHY_START) ||
+	    (addr >= MT_WFSYS0_PHY_START && addr < MT_WFSYS1_PHY_START) ||
+	    (addr >= MT_WFSYS1_PHY_START && addr <= MT_WFSYS1_PHY_END))
+		return mt7915_reg_map_l1(dev, addr);
+
+	if (dev_is_pci(dev->mt76.dev) &&
+	    ((addr >= MT_CBTOP1_PHY_START && addr <= MT_CBTOP1_PHY_END) ||
+	     (addr >= MT_CBTOP2_PHY_START && addr <= MT_CBTOP2_PHY_END))) {
+		/* CONN_INFRA: covert to phyiscal addr and use layer 1 remap */
+		if (addr >= MT_CONN_INFRA_MCU_START &&
+		    addr <= MT_CONN_INFRA_MCU_END)
+			addr = addr - MT_CONN_INFRA_MCU_START + MT_INFRA_BASE;
+
 		return mt7915_reg_map_l1(dev, addr);
+	}
 
 	return mt7915_reg_map_l2(dev, addr);
 }
@@ -138,10 +487,18 @@ static int mt7915_mmio_init(struct mt76_dev *mdev,
 {
 	struct mt76_bus_ops *bus_ops;
 	struct mt7915_dev *dev;
+	int i;
 
 	dev = container_of(mdev, struct mt7915_dev, mt76);
 	mt76_mmio_init(&dev->mt76, mem_base);
 
+	for (i = 0; i < ARRAY_SIZE(reg_desc); i++) {
+		if (device_id == reg_desc[i].id) {
+			dev->reg = &reg_desc[i];
+			break;
+		}
+	}
+
 	dev->bus_ops = dev->mt76.bus;
 	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
 			       GFP_KERNEL);
@@ -184,15 +541,29 @@ static void mt7915_rx_poll_complete(struct mt76_dev *mdev,
 				    enum mt76_rxq_id q)
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	static const u32 rx_irq_mask[] = {
-		[MT_RXQ_MAIN] = MT_INT_RX_DONE_DATA0,
-		[MT_RXQ_EXT] = MT_INT_RX_DONE_DATA1,
-		[MT_RXQ_MCU] = MT_INT_RX_DONE_WM,
-		[MT_RXQ_MCU_WA] = MT_INT_RX_DONE_WA,
-		[MT_RXQ_EXT_WA] = MT_INT_RX_DONE_WA_EXT,
-	};
+	u32 rx_irq_mask = 0;
+
+	switch (q) {
+	case MT_RXQ_MAIN:
+		rx_irq_mask = MT_INT_RX_DONE_DATA0;
+		break;
+	case MT_RXQ_EXT:
+		rx_irq_mask = MT_INT_RX_DONE_DATA1;
+		break;
+	case MT_RXQ_MCU:
+		rx_irq_mask = MT_INT_RX_DONE_WM;
+		break;
+	case MT_RXQ_MCU_WA:
+		rx_irq_mask = MT_INT_RX_DONE_WA;
+		break;
+	case MT_RXQ_EXT_WA:
+		rx_irq_mask = MT_INT_RX_DONE_WA_EXT;
+		break;
+	default:
+		break;
+	}
 
-	mt7915_irq_enable(dev, rx_irq_mask[q]);
+	mt7915_irq_enable(dev, rx_irq_mask);
 }
 
 /* TODO: support 2/4/6/8 MSI-X vectors */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 05a28c2..b69e00d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -53,7 +53,7 @@ struct mt7915_dfs_pulse;
 struct mt7915_dfs_pattern;
 
 enum mt7915_txq_id {
-	MT7915_TXQ_FWDL = 16,
+	MT7915_TXQ_FWDL = 0,
 	MT7915_TXQ_MCU_WM,
 	MT7915_TXQ_BAND0,
 	MT7915_TXQ_BAND1,
@@ -250,6 +250,7 @@ struct mt7915_dev {
 	};
 
 	struct mt7915_hif *hif2;
+	const struct mt7915_reg_desc *reg;
 
 	const struct mt76_bus_ops *bus_ops;
 	struct tasklet_struct irq_tasklet;
@@ -376,7 +377,6 @@ int mt7915_mmio_probe(struct device *pdev,
 		      void __iomem *mem_base,
 		      u32 device_id,
 		      int irq, struct mt7915_hif *hif2);
-u32 mt7915_reg_map(struct mt7915_dev *dev, u32 addr);
 u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif);
 int mt7915_register_device(struct mt7915_dev *dev);
 void mt7915_unregister_device(struct mt7915_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index ff71f56..3837b2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -4,41 +4,221 @@
 #ifndef __MT7915_REGS_H
 #define __MT7915_REGS_H
 
+#define INVALID_BASE		0x0
+#define INVALID_OFFSET		0x0
+
+struct __map {
+	u32 phys;
+	u32 maps;
+	u32 size;
+};
+
+struct __reg {
+	u32 base;
+	u32 offs;
+};
+
+struct __mask {
+	u32 end;
+	u32 start;
+};
+
+/* used to differentiate between generations */
+struct mt7915_reg_desc {
+	const u32 id;
+	const u32 *base_rev;
+	const struct __reg *reg_rev;
+	const struct __mask *mask_rev;
+	const u32 *bit_rev;
+	const struct __map *map;
+	const u32 map_size;
+};
+
+enum base_rev {
+	MT_REMAP_L1_CFG_BASE,
+	MT_REMAP_L1_BASE,
+	MT_REMAP_L2_CFG_BASE,
+	MT_REMAP_L2_BASE,
+	MT_INFRA_MCU_END_BASE,
+	MT_PCIE_MAC_BASE,
+	MT_PCIE1_MAC_BASE,
+	MT_WFDMA0_BASE,
+	MT_WFDMA1_BASE,
+	MT_WFDMA0_PCIE1_BASE,
+	MT_WFDMA1_PCIE1_BASE,
+	MT_WFDMA_EXT_CSR_BASE,
+	MT_SWDEF_BASE,
+	MT_MCU_WFDMA0_BASE,
+	MT_MCU_WFDMA1_BASE,
+	__MT_REG_BASE_MAX,
+};
+
+enum reg_rev {
+	L1_REMAP_CFG_OFFSET,
+	L2_REMAP_CFG_OFFSET,
+	INT_SOURCE_CSR,
+	INT_MASK_CSR,
+	INT1_SOURCE_CSR,
+	INT1_MASK_CSR,
+	INT_MCU_CMD_SOURCE,
+	INT_MCU_CMD_EVENT,
+	TX_RING_BASE,
+	RX_EVENT_RING_BASE,
+	RX_DATA_RING_BASE,
+	TMAC_CDTR,
+	TMAC_ODTR,
+	TMAC_ATCR,
+	TMAC_TRCR0,
+	TMAC_ICR0,
+	TMAC_ICR1,
+	TMAC_CTCR0,
+	TMAC_TFCR0,
+	MDP_BNRCFR0,
+	MDP_BNRCFR1,
+	ARB_DRNGR0,
+	ARB_SCR,
+	RMAC_MIB_AIRTIME14,
+	AGG_AWSCR0,
+	AGG_PCR0,
+	AGG_ACR0,
+	AGG_MRCR,
+	AGG_ATCR1,
+	AGG_ATCR3,
+	LPON_UTTR0,
+	LPON_UTTR1,
+	MIB_SDR3,
+	MIB_SDR4,
+	MIB_SDR5,
+	MIB_SDR7,
+	MIB_SDR8,
+	MIB_SDR9,
+	MIB_SDR10,
+	MIB_SDR11,
+	MIB_SDR12,
+	MIB_SDR13,
+	MIB_SDR14,
+	MIB_SDR15,
+	MIB_SDR16,
+	MIB_SDR17,
+	MIB_SDR18,
+	MIB_SDR19,
+	MIB_SDR20,
+	MIB_SDR21,
+	MIB_SDR22,
+	MIB_SDR23,
+	MIB_SDR24,
+	MIB_SDR25,
+	MIB_SDR27,
+	MIB_SDR28,
+	MIB_SDR29,
+	MIB_SDRVEC,
+	MIB_SDR31,
+	MIB_SDR32,
+	MIB_SDRMUBF,
+	MIB_DR8,
+	MIB_DR9,
+	MIB_DR11,
+	MIB_MB_SDR0,
+	MIB_MB_SDR1,
+	TX_AGG_CNT,
+	TX_AGG_CNT2,
+	MIB_ARNG,
+	WTBLON_TOP_WDUCR,
+	WTBL_UPDATE,
+	PLE_FL_Q_EMPTY,
+	PLE_FL_Q_CTRL,
+	PLE_AC_QEMPTY,
+	PLE_FREEPG_CNT,
+	PLE_FREEPG_HEAD_TAIL,
+	PLE_PG_HIF_GROUP,
+	PLE_HIF_PG_INFO,
+	AC_OFFSET,
+	__MT_REG_DIFF_MAX,
+};
+
+enum mask_rev {
+	L2_REMAP_MASK,
+	L2_REMAP_OFFSET,
+	L2_REMAP_BASE,
+	MIB_SDR3_FCS_ERR,
+	MIB_MRDY_CNT,
+	MIB_MPDU_ATTEMPTS_CNT,
+	MIB_MPDU_SUCCESS_CNT,
+	MIB_AMPDU_SF_CNT,
+	MIB_PF_DROP_CNT,
+	MIB_VEC_DROP_CNT,
+	MIB_BF_TX_CNT,
+	__MT_MASK_DIF_MAX,
+};
+
+enum bit_rev {
+	RX_DONE_DAND0,
+	RX_DONE_DAND1,
+	RX_DONE_MCU_WM,
+	RX_DONE_MCU_WA,
+	RX_DONE_WA_BAND0,
+	RX_DONE_WA_BAND1,
+	TX_DONE_FWDL,
+	TX_DONE_MCU_WM,
+	TX_DONE_MCU_WA,
+	TX_DONE_BAND0,
+	TX_DONE_BAND1,
+	RX_MCU_TO_HOST,
+	MIB_MB_SDR,
+	LPON_TCR,
+	__MT_BIT_DIF_MAX,
+};
+
+#define __REG_MAP(_dev, id, ofs)	((_dev)->reg->base_rev[(id)] + (ofs))
+#define __REG_BASE(_dev, id)		((_dev)->reg->reg_rev[(id)].base)
+#define __REG_OFFS(_dev, id)		((_dev)->reg->reg_rev[(id)].offs)
+
+#define __BIT(_dev, id)			BIT((_dev)->reg->bit_rev[(id)])
+#define __MASK(_dev, id)		GENMASK((_dev)->reg->mask_rev[(id)].end,	\
+						(_dev)->reg->mask_rev[(id)].start)
+#define __REG(_dev, id)			__REG_MAP((_dev), __REG_BASE((_dev), (id)),	\
+						__REG_OFFS((_dev), (id)))
+
+#define __FIELD_GET(id, _reg)		(((_reg) & __MASK(dev, (id))) >>		\
+					 dev->reg->mask_rev[(id)].start)
+#define __FIELD_PREP(id, _reg)		(((_reg) << dev->reg->mask_rev[(id)].start) &		\
+					 __MASK(dev, (id)))
+
 /* MCU WFDMA0 */
-#define MT_MCU_WFDMA0_BASE		0x2000
-#define MT_MCU_WFDMA0(ofs)		(MT_MCU_WFDMA0_BASE + (ofs))
+#define MT_MCU_WFDMA0(ofs)		__REG_MAP(dev, MT_MCU_WFDMA0_BASE, (ofs))
 #define MT_MCU_WFDMA0_DUMMY_CR		MT_MCU_WFDMA0(0x120)
 
 /* MCU WFDMA1 */
-#define MT_MCU_WFDMA1_BASE		0x3000
-#define MT_MCU_WFDMA1(ofs)		(MT_MCU_WFDMA1_BASE + (ofs))
-
-#define MT_MCU_INT_EVENT		MT_MCU_WFDMA1(0x108)
+#define MT_MCU_INT_EVENT		__REG(dev, INT_MCU_CMD_EVENT)
 #define MT_MCU_INT_EVENT_DMA_STOPPED	BIT(0)
 #define MT_MCU_INT_EVENT_DMA_INIT	BIT(1)
 #define MT_MCU_INT_EVENT_SER_TRIGGER	BIT(2)
 #define MT_MCU_INT_EVENT_RESET_DONE	BIT(3)
 
-#define MT_PLE_BASE			0x8000
+/* PLE */
+#define MT_PLE_BASE			0x820c0000
 #define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
 
-#define MT_FL_Q_EMPTY			0x0b0
-#define MT_FL_Q0_CTRL			0x1b0
-#define MT_FL_Q2_CTRL			0x1b8
-#define MT_FL_Q3_CTRL			0x1bc
-
-#define MT_PLE_FREEPG_CNT		MT_PLE(0x100)
-#define MT_PLE_FREEPG_HEAD_TAIL		MT_PLE(0x104)
-#define MT_PLE_PG_HIF_GROUP		MT_PLE(0x110)
-#define MT_PLE_HIF_PG_INFO		MT_PLE(0x114)
-#define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(0x500 + 0x40 * (ac) + \
-					       ((n) << 2))
+#define MT_FL_Q_EMPTY			MT_PLE(__REG_OFFS(dev, PLE_FL_Q_EMPTY))
+#define MT_FL_Q0_CTRL			MT_PLE(__REG_OFFS(dev, PLE_FL_Q_CTRL))
+#define MT_FL_Q2_CTRL			MT_PLE(__REG_OFFS(dev, PLE_FL_Q_CTRL) + 0x8)
+#define MT_FL_Q3_CTRL			MT_PLE(__REG_OFFS(dev, PLE_FL_Q_CTRL) + 0xc)
+
+#define MT_PLE_FREEPG_CNT		MT_PLE(__REG_OFFS(dev, PLE_FREEPG_CNT))
+#define MT_PLE_FREEPG_HEAD_TAIL		MT_PLE(__REG_OFFS(dev, PLE_FREEPG_HEAD_TAIL))
+#define MT_PLE_PG_HIF_GROUP		MT_PLE(__REG_OFFS(dev, PLE_PG_HIF_GROUP))
+#define MT_PLE_HIF_PG_INFO		MT_PLE(__REG_OFFS(dev, PLE_HIF_PG_INFO))
+
+#define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(__REG_OFFS(dev, PLE_AC_QEMPTY) +	\
+					       __REG_OFFS(dev, AC_OFFSET) *	\
+					       (ac) + ((n) << 2))
 #define MT_PLE_AMSDU_PACK_MSDU_CNT(n)	MT_PLE(0x10e0 + ((n) << 2))
 
-#define MT_PSE_BASE			0xc000
+#define MT_PSE_BASE			0x820c8000
 #define MT_PSE(ofs)			(MT_PSE_BASE + (ofs))
 
-#define MT_MDP_BASE			0xf000
+/* WF MDP TOP */
+#define MT_MDP_BASE			0x820cd000
 #define MT_MDP(ofs)			(MT_MDP_BASE + (ofs))
 
 #define MT_MDP_DCR0			MT_MDP(0x000)
@@ -47,63 +227,66 @@
 #define MT_MDP_DCR1			MT_MDP(0x004)
 #define MT_MDP_DCR1_MAX_RX_LEN		GENMASK(15, 3)
 
-#define MT_MDP_BNRCFR0(_band)		MT_MDP(0x070 + ((_band) << 8))
+#define MT_MDP_BNRCFR0(_band)		MT_MDP(__REG_OFFS(dev, MDP_BNRCFR0) + \
+					       ((_band) << 8))
 #define MT_MDP_RCFR0_MCU_RX_MGMT	GENMASK(5, 4)
 #define MT_MDP_RCFR0_MCU_RX_CTL_NON_BAR	GENMASK(7, 6)
 #define MT_MDP_RCFR0_MCU_RX_CTL_BAR	GENMASK(9, 8)
 
-#define MT_MDP_BNRCFR1(_band)		MT_MDP(0x074 + ((_band) << 8))
+#define MT_MDP_BNRCFR1(_band)		MT_MDP(__REG_OFFS(dev, MDP_BNRCFR1) + \
+					       ((_band) << 8))
 #define MT_MDP_RCFR1_MCU_RX_BYPASS	GENMASK(23, 22)
 #define MT_MDP_RCFR1_RX_DROPPED_UCAST	GENMASK(28, 27)
 #define MT_MDP_RCFR1_RX_DROPPED_MCAST	GENMASK(30, 29)
 #define MT_MDP_TO_HIF			0
 #define MT_MDP_TO_WM			1
 
-/* TMAC: band 0(0x21000), band 1(0xa1000) */
-#define MT_WF_TMAC_BASE(_band)		((_band) ? 0xa1000 : 0x21000)
+/* TMAC: band 0(0x820e4000), band 1(0x820f4000) */
+#define MT_WF_TMAC_BASE(_band)		((_band) ? 0x820f4000 : 0x820e4000)
 #define MT_WF_TMAC(_band, ofs)		(MT_WF_TMAC_BASE(_band) + (ofs))
 
 #define MT_TMAC_TCR0(_band)		MT_WF_TMAC(_band, 0)
 #define MT_TMAC_TCR0_TX_BLINK		GENMASK(7, 6)
 #define MT_TMAC_TCR0_TBTT_STOP_CTRL	BIT(25)
 
-#define MT_TMAC_CDTR(_band)		MT_WF_TMAC(_band, 0x090)
-#define MT_TMAC_ODTR(_band)		MT_WF_TMAC(_band, 0x094)
+#define MT_TMAC_CDTR(_band)		MT_WF_TMAC(_band, __REG_OFFS(dev, TMAC_CDTR))
+ #define MT_TMAC_ODTR(_band)		MT_WF_TMAC(_band, __REG_OFFS(dev, TMAC_ODTR))
 #define MT_TIMEOUT_VAL_PLCP		GENMASK(15, 0)
 #define MT_TIMEOUT_VAL_CCA		GENMASK(31, 16)
 
-#define MT_TMAC_ATCR(_band)		MT_WF_TMAC(_band, 0x098)
+#define MT_TMAC_ATCR(_band)		MT_WF_TMAC(_band, __REG_OFFS(dev, TMAC_ATCR))
 #define MT_TMAC_ATCR_TXV_TOUT		GENMASK(7, 0)
 
-#define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, 0x09c)
+#define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, __REG_OFFS(dev, TMAC_TRCR0))
 #define MT_TMAC_TRCR0_TR2T_CHK		GENMASK(8, 0)
 #define MT_TMAC_TRCR0_I2T_CHK		GENMASK(24, 16)
 
-#define MT_TMAC_ICR0(_band)		MT_WF_TMAC(_band, 0x0a4)
-#define MT_IFS_EIFS_OFDM			GENMASK(8, 0)
+#define MT_TMAC_ICR0(_band)		MT_WF_TMAC(_band, __REG_OFFS(dev, TMAC_ICR0))
+#define MT_IFS_EIFS_OFDM		GENMASK(8, 0)
 #define MT_IFS_RIFS			GENMASK(14, 10)
 #define MT_IFS_SIFS			GENMASK(22, 16)
 #define MT_IFS_SLOT			GENMASK(30, 24)
 
-#define MT_TMAC_ICR1(_band)		MT_WF_TMAC(_band, 0x0b4)
+#define MT_TMAC_ICR1(_band)		MT_WF_TMAC(_band, __REG_OFFS(dev, TMAC_ICR1))
 #define MT_IFS_EIFS_CCK			GENMASK(8, 0)
 
-#define MT_TMAC_CTCR0(_band)			MT_WF_TMAC(_band, 0x0f4)
+#define MT_TMAC_CTCR0(_band)		MT_WF_TMAC(_band, __REG_OFFS(dev, TMAC_CTCR0))
 #define MT_TMAC_CTCR0_INS_DDLMT_REFTIME		GENMASK(5, 0)
 #define MT_TMAC_CTCR0_INS_DDLMT_EN		BIT(17)
 #define MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN	BIT(18)
 
-#define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
+#define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, __REG_OFFS(dev, TMAC_TFCR0))
 
-#define MT_WF_DMA_BASE(_band)		((_band) ? 0xa1e00 : 0x21e00)
+/* WF DMA TOP: band 0(0x820e7000),band 1(0x820f7000) */
+#define MT_WF_DMA_BASE(_band)		((_band) ? 0x820f7000 : 0x820e7000)
 #define MT_WF_DMA(_band, ofs)		(MT_WF_DMA_BASE(_band) + (ofs))
 
 #define MT_DMA_DCR0(_band)		MT_WF_DMA(_band, 0x000)
 #define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 3)
 #define MT_DMA_DCR0_RXD_G5_EN		BIT(23)
 
-/* ETBF: band 0(0x24000), band 1(0xa4000) */
-#define MT_WF_ETBF_BASE(_band)		((_band) ? 0xa4000 : 0x24000)
+/* ETBF: band 0(0x820ea000), band 1(0x820fa000) */
+#define MT_WF_ETBF_BASE(_band)		((_band) ? 0x820fa000 : 0x820ea000)
 #define MT_WF_ETBF(_band, ofs)		(MT_WF_ETBF_BASE(_band) + (ofs))
 
 #define MT_ETBF_TX_NDP_BFRP(_band)	MT_WF_ETBF(_band, 0x040)
@@ -125,174 +308,184 @@
 #define MT_ETBF_RX_FB_VHT		GENMASK(15, 8)
 #define MT_ETBF_RX_FB_HT		GENMASK(7, 0)
 
-/* LPON: band 0(0x24200), band 1(0xa4200) */
-#define MT_WF_LPON_BASE(_band)		((_band) ? 0xa4200 : 0x24200)
+/* LPON: band 0(0x820eb000), band 1(0x820fb000) */
+#define MT_WF_LPON_BASE(_band)		((_band) ? 0x820fb000 : 0x820eb000)
 #define MT_WF_LPON(_band, ofs)		(MT_WF_LPON_BASE(_band) + (ofs))
 
-#define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, 0x080)
-#define MT_LPON_UTTR1(_band)		MT_WF_LPON(_band, 0x084)
+#define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, __REG_OFFS(dev, LPON_UTTR0))
+#define MT_LPON_UTTR1(_band)		MT_WF_LPON(_band, __REG_OFFS(dev, LPON_UTTR1))
 
-#define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 + (n) * 4)
+#define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 +	\
+						   (((n) * 4) << __BIT(dev, LPON_TCR)))
 #define MT_LPON_TCR_SW_MODE		GENMASK(1, 0)
 #define MT_LPON_TCR_SW_WRITE		BIT(0)
 #define MT_LPON_TCR_SW_ADJUST		BIT(1)
 #define MT_LPON_TCR_SW_READ		GENMASK(1, 0)
 
-/* MIB: band 0(0x24800), band 1(0xa4800) */
+/* MIB: band 0(0x820ed000), band 1(0x820fd000) */
 /* These counters are (mostly?) clear-on-read.  So, some should not
  * be read at all in case firmware is already reading them.  These
  * are commented with 'DNR' below.  The DNR stats will be read by querying
  * the firmware API for the appropriate message.  For counters the driver
  * does read, the driver should accumulate the counters.
  */
-#define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
+#define MT_WF_MIB_BASE(_band)		((_band) ? 0x820fd000 : 0x820ed000)
 #define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
 
 #define MT_MIB_SDR0(_band)		MT_WF_MIB(_band, 0x010)
 #define MT_MIB_SDR0_BERACON_TX_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x014)
-#define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR3))
+#define MT_MIB_SDR3_FCS_ERR_MASK	__MASK(dev, MIB_SDR3_FCS_ERR)
 
-#define MT_MIB_SDR4(_band)		MT_WF_MIB(_band, 0x018)
+#define MT_MIB_SDR4(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR4))
 #define MT_MIB_SDR4_RX_FIFO_FULL_MASK	GENMASK(15, 0)
 
 /* rx mpdu counter, full 32 bits */
-#define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, 0x01c)
+#define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR5))
 
 #define MT_MIB_SDR6(_band)		MT_WF_MIB(_band, 0x020)
 #define MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR7(_band)		MT_WF_MIB(_band, 0x024)
+#define MT_MIB_SDR7(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR7))
 #define MT_MIB_SDR7_RX_VECTOR_MISMATCH_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR8(_band)		MT_WF_MIB(_band, 0x028)
+#define MT_MIB_SDR8(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR8))
 #define MT_MIB_SDR8_RX_DELIMITER_FAIL_CNT_MASK	GENMASK(15, 0)
 
 /* aka CCA_NAV_TX_TIME */
-#define MT_MIB_SDR9_DNR(_band)		MT_WF_MIB(_band, 0x02c)
-#define MT_MIB_SDR9_CCA_BUSY_TIME_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR9_DNR(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR9))
+#define MT_MIB_SDR9_CCA_BUSY_TIME_MASK		GENMASK(23, 0)
 
-#define MT_MIB_SDR10_DNR(_band)		MT_WF_MIB(_band, 0x030)
-#define MT_MIB_SDR10_MRDY_COUNT_MASK	GENMASK(25, 0)
+#define MT_MIB_SDR10_DNR(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR10))
+#define MT_MIB_SDR10_MRDY_COUNT_MASK		__MASK(dev, MIB_MRDY_CNT)
 
-#define MT_MIB_SDR11(_band)		MT_WF_MIB(_band, 0x034)
+#define MT_MIB_SDR11(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR11))
 #define MT_MIB_SDR11_RX_LEN_MISMATCH_CNT_MASK	GENMASK(15, 0)
 
 /* tx ampdu cnt, full 32 bits */
-#define MT_MIB_SDR12(_band)		MT_WF_MIB(_band, 0x038)
+#define MT_MIB_SDR12(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR12))
 
-#define MT_MIB_SDR13(_band)		MT_WF_MIB(_band, 0x03c)
+#define MT_MIB_SDR13(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR13))
 #define MT_MIB_SDR13_TX_STOP_Q_EMPTY_CNT_MASK	GENMASK(15, 0)
 
 /* counts all mpdus in ampdu, regardless of success */
-#define MT_MIB_SDR14(_band)		MT_WF_MIB(_band, 0x040)
-#define MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR14(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR14))
+#define MT_MIB_SDR14_TX_MPDU_ATTEMPTS_CNT_MASK	__MASK(dev, MIB_MPDU_ATTEMPTS_CNT)
 
 /* counts all successfully tx'd mpdus in ampdu */
-#define MT_MIB_SDR15(_band)		MT_WF_MIB(_band, 0x044)
-#define MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR15(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR15))
+#define MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK	__MASK(dev, MIB_MPDU_SUCCESS_CNT)
 
 /* in units of 'us' */
-#define MT_MIB_SDR16_DNR(_band)		MT_WF_MIB(_band, 0x048)
+#define MT_MIB_SDR16_DNR(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR16))
 #define MT_MIB_SDR16_PRIMARY_CCA_BUSY_TIME_MASK	GENMASK(23, 0)
 
-#define MT_MIB_SDR17_DNR(_band)		MT_WF_MIB(_band, 0x04c)
+#define MT_MIB_SDR17_DNR(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR17))
 #define MT_MIB_SDR17_SECONDARY_CCA_BUSY_TIME_MASK	GENMASK(23, 0)
 
-#define MT_MIB_SDR18(_band)		MT_WF_MIB(_band, 0x050)
+#define MT_MIB_SDR18(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR18))
 #define MT_MIB_SDR18_PRIMARY_ENERGY_DETECT_TIME_MASK	GENMASK(23, 0)
 
 /* units are us */
-#define MT_MIB_SDR19_DNR(_band)		MT_WF_MIB(_band, 0x054)
+#define MT_MIB_SDR19_DNR(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR19))
 #define MT_MIB_SDR19_CCK_MDRDY_TIME_MASK	GENMASK(23, 0)
 
-#define MT_MIB_SDR20_DNR(_band)		MT_WF_MIB(_band, 0x058)
+#define MT_MIB_SDR20_DNR(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR20))
 #define MT_MIB_SDR20_OFDM_VHT_MDRDY_TIME_MASK	GENMASK(23, 0)
 
-#define MT_MIB_SDR21_DNR(_band)		MT_WF_MIB(_band, 0x05c)
+#define MT_MIB_SDR21_DNR(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR21))
 #define MT_MIB_SDR20_GREEN_MDRDY_TIME_MASK	GENMASK(23, 0)
 
 /* rx ampdu count, 32-bit */
-#define MT_MIB_SDR22(_band)		MT_WF_MIB(_band, 0x060)
+#define MT_MIB_SDR22(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR22))
 
 /* rx ampdu bytes count, 32-bit */
-#define MT_MIB_SDR23(_band)		MT_WF_MIB(_band, 0x064)
+#define MT_MIB_SDR23(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR23))
 
 /* rx ampdu valid subframe count */
-#define MT_MIB_SDR24(_band)		MT_WF_MIB(_band, 0x068)
-#define MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR24(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR24))
+#define MT_MIB_SDR24_RX_AMPDU_SF_CNT_MASK	__MASK(dev, MIB_AMPDU_SF_CNT)
 
 /* rx ampdu valid subframe bytes count, 32bits */
-#define MT_MIB_SDR25(_band)		MT_WF_MIB(_band, 0x06c)
+#define MT_MIB_SDR25(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR25))
 
 /* remaining windows protected stats */
-#define MT_MIB_SDR27(_band)		MT_WF_MIB(_band, 0x074)
+#define MT_MIB_SDR27(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR27))
 #define MT_MIB_SDR27_TX_RWP_FAIL_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR28(_band)		MT_WF_MIB(_band, 0x078)
+#define MT_MIB_SDR28(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR28))
 #define MT_MIB_SDR28_TX_RWP_NEED_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR29(_band)		MT_WF_MIB(_band, 0x07c)
-#define MT_MIB_SDR29_RX_PFDROP_CNT_MASK	GENMASK(7, 0)
+#define MT_MIB_SDR29(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR29))
+#define MT_MIB_SDR29_RX_PFDROP_CNT_MASK		__MASK(dev, MIB_PF_DROP_CNT)
 
-#define MT_MIB_SDR30(_band)		MT_WF_MIB(_band, 0x080)
-#define MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK	GENMASK(15, 0)
+#define MT_MIB_SDRVEC(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDRVEC))
+#define MT_MIB_SDR30_RX_VEC_QUEUE_OVERFLOW_DROP_CNT_MASK	__MASK(dev, MIB_VEC_DROP_CNT)
 
 /* rx blockack count, 32 bits */
-#define MT_MIB_SDR31(_band)		MT_WF_MIB(_band, 0x084)
+#define MT_MIB_SDR31(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR31))
 
-#define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, 0x088)
+#define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDR32))
 #define MT_MIB_SDR32_TX_PKT_EBF_CNT_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR33(_band)		MT_WF_MIB(_band, 0x08c)
-#define MT_MIB_SDR33_TX_PKT_IBF_CNT_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR33(_band)		MT_WF_MIB(_band, 0x088)
+#define MT_MIB_SDR32_TX_PKT_IBF_CNT_MASK	__MASK(dev, MIB_BF_TX_CNT)
 
-#define MT_MIB_SDR34(_band)		MT_WF_MIB(_band, 0x090)
+#define MT_MIB_SDRMUBF(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_SDRMUBF))
 #define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
 
 /* 36, 37 both DNR */
 
-#define MT_MIB_DR8(_band)		MT_WF_MIB(_band, 0x0c0)
-#define MT_MIB_DR9(_band)		MT_WF_MIB(_band, 0x0c4)
-#define MT_MIB_DR11(_band)		MT_WF_MIB(_band, 0x0cc)
+#define MT_MIB_DR8(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_DR8))
+#define MT_MIB_DR9(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_DR9))
+#define MT_MIB_DR11(_band)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_DR11))
 
-#define MT_MIB_MB_SDR0(_band, n)	MT_WF_MIB(_band, 0x100 + ((n) << 4))
+#define MT_MIB_MB_SDR0(_band, n)	MT_WF_MIB(_band, __REG_OFFS(dev, MIB_MB_SDR0) +	\
+						  ((n) << __BIT(dev, MIB_MB_SDR)))
 #define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
 #define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
 
-#define MT_MIB_MB_SDR1(_band, n)	MT_WF_MIB(_band, 0x104 + ((n) << 4))
+#define MT_MIB_MB_SDR1(_band, n)	MT_WF_MIB(_band, __REG_OFFS(dev, MIB_MB_SDR1) + \
+						  ((n) << __BIT(dev, MIB_MB_SDR)))
 #define MT_MIB_BA_MISS_COUNT_MASK	GENMASK(15, 0)
 #define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(31, 16)
 
-#define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, 0x0a8 + ((n) << 2))
-#define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, 0x164 + ((n) << 2))
-#define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x4b8 + ((n) << 2))
+#define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, __REG_OFFS(dev, TX_AGG_CNT) +	\
+						  ((n) << 2))
+#define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, __REG_OFFS(dev, TX_AGG_CNT2) +	\
+						  ((n) << 2))
+#define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, __REG_OFFS(dev, MIB_ARNG) +	\
+						  ((n) << 2))
 #define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0))
 
-#define MT_WTBLON_TOP_BASE		0x34000
+/* WTBLON TOP */
+#define MT_WTBLON_TOP_BASE		0x820d4000
 #define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
-#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x0)
+#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(__REG_OFFS(dev, WTBLON_TOP_WDUCR))
 #define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
 
-#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x030)
+#define MT_WTBL_UPDATE			MT_WTBLON_TOP(__REG_OFFS(dev, WTBL_UPDATE))
 #define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
 #define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
 #define MT_WTBL_UPDATE_BUSY		BIT(31)
 
-#define MT_WTBL_BASE			0x38000
+/* WTBL */
+#define MT_WTBL_BASE			0x820d8000
 #define MT_WTBL_LMAC_ID			GENMASK(14, 8)
 #define MT_WTBL_LMAC_DW			GENMASK(7, 2)
 #define MT_WTBL_LMAC_OFFS(_id, _dw)	(MT_WTBL_BASE | \
-					FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
-					FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
+					 FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
+					 FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
 
-/* AGG: band 0(0x20800), band 1(0xa0800) */
-#define MT_WF_AGG_BASE(_band)		((_band) ? 0xa0800 : 0x20800)
+/* AGG: band 0(0x820e2000), band 1(0x820f2000) */
+#define MT_WF_AGG_BASE(_band)		((_band) ? 0x820f2000 : 0x820e2000)
 #define MT_WF_AGG(_band, ofs)		(MT_WF_AGG_BASE(_band) + (ofs))
 
-#define MT_AGG_AWSCR0(_band, _n)	MT_WF_AGG(_band, 0x05c + (_n) * 4)
-#define MT_AGG_PCR0(_band, _n)		MT_WF_AGG(_band, 0x06c + (_n) * 4)
+#define MT_AGG_AWSCR0(_band, _n)	MT_WF_AGG(_band, (__REG_OFFS(dev, AGG_AWSCR0) +	\
+							  (_n) * 4))
+#define MT_AGG_PCR0(_band, _n)		MT_WF_AGG(_band, (__REG_OFFS(dev, AGG_PCR0) +	\
+							  (_n) * 4))
 #define MT_AGG_PCR0_MM_PROT		BIT(0)
 #define MT_AGG_PCR0_GF_PROT		BIT(1)
 #define MT_AGG_PCR0_BW20_PROT		BIT(2)
@@ -305,31 +498,32 @@
 #define MT_AGG_PCR1_RTS0_NUM_THRES	GENMASK(31, 23)
 #define MT_AGG_PCR1_RTS0_LEN_THRES	GENMASK(19, 0)
 
-#define MT_AGG_ACR0(_band)		MT_WF_AGG(_band, 0x084)
+#define MT_AGG_ACR0(_band)		MT_WF_AGG(_band, __REG_OFFS(dev, AGG_ACR0))
 #define MT_AGG_ACR_CFEND_RATE		GENMASK(13, 0)
 #define MT_AGG_ACR_BAR_RATE		GENMASK(29, 16)
 
-#define MT_AGG_MRCR(_band)		MT_WF_AGG(_band, 0x098)
-#define MT_AGG_MRCR_BAR_CNT_LIMIT	GENMASK(15, 12)
-#define MT_AGG_MRCR_LAST_RTS_CTS_RN	BIT(6)
-#define MT_AGG_MRCR_RTS_FAIL_LIMIT	GENMASK(11, 7)
+#define MT_AGG_MRCR(_band)		MT_WF_AGG(_band, __REG_OFFS(dev, AGG_MRCR))
+#define MT_AGG_MRCR_BAR_CNT_LIMIT		GENMASK(15, 12)
+#define MT_AGG_MRCR_LAST_RTS_CTS_RN		BIT(6)
+#define MT_AGG_MRCR_RTS_FAIL_LIMIT		GENMASK(11, 7)
 #define MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT	GENMASK(28, 24)
 
-#define MT_AGG_ATCR1(_band)		MT_WF_AGG(_band, 0x0f0)
-#define MT_AGG_ATCR3(_band)		MT_WF_AGG(_band, 0x0f4)
+#define MT_AGG_ATCR1(_band)		MT_WF_AGG(_band, __REG_OFFS(dev, AGG_ATCR1))
+#define MT_AGG_ATCR3(_band)		MT_WF_AGG(_band, __REG_OFFS(dev, AGG_ATCR3))
 
-/* ARB: band 0(0x20c00), band 1(0xa0c00) */
-#define MT_WF_ARB_BASE(_band)		((_band) ? 0xa0c00 : 0x20c00)
+/* ARB: band 0(0x820e3000), band 1(0x820f3000) */
+#define MT_WF_ARB_BASE(_band)		((_band) ? 0x820f3000 : 0x820e3000)
 #define MT_WF_ARB(_band, ofs)		(MT_WF_ARB_BASE(_band) + (ofs))
 
-#define MT_ARB_SCR(_band)		MT_WF_ARB(_band, 0x080)
+#define MT_ARB_SCR(_band)		MT_WF_ARB(_band, __REG_OFFS(dev, ARB_SCR))
 #define MT_ARB_SCR_TX_DISABLE		BIT(8)
 #define MT_ARB_SCR_RX_DISABLE		BIT(9)
 
-#define MT_ARB_DRNGR0(_band, _n)	MT_WF_ARB(_band, 0x194 + (_n) * 4)
+#define MT_ARB_DRNGR0(_band, _n)	MT_WF_ARB(_band, (__REG_OFFS(dev, ARB_DRNGR0) +	\
+							  (_n) * 4))
 
-/* RMAC: band 0(0x21400), band 1(0xa1400) */
-#define MT_WF_RMAC_BASE(_band)		((_band) ? 0xa1400 : 0x21400)
+/* RMAC: band 0(0x820e5000), band 1(0x820f5000) */
+#define MT_WF_RMAC_BASE(_band)		((_band) ? 0x820f5000 : 0x820e5000)
 #define MT_WF_RMAC(_band, ofs)		(MT_WF_RMAC_BASE(_band) + (ofs))
 
 #define MT_WF_RFCR(_band)		MT_WF_RMAC(_band, 0x000)
@@ -366,8 +560,7 @@
 #define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
 
 /* WFDMA0 */
-#define MT_WFDMA0_BASE			0xd4000
-#define MT_WFDMA0(ofs)			(MT_WFDMA0_BASE + (ofs))
+#define MT_WFDMA0(ofs)			__REG_MAP(dev, MT_WFDMA0_BASE, ofs)
 
 #define MT_WFDMA0_RST			MT_WFDMA0(0x100)
 #define MT_WFDMA0_RST_LOGIC_RST		BIT(4)
@@ -385,15 +578,12 @@
 #define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
 #define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
 
-#define MT_RX_DATA_RING_BASE		MT_WFDMA0(0x500)
-
 #define MT_WFDMA0_RX_RING0_EXT_CTRL	MT_WFDMA0(0x680)
 #define MT_WFDMA0_RX_RING1_EXT_CTRL	MT_WFDMA0(0x684)
 #define MT_WFDMA0_RX_RING2_EXT_CTRL	MT_WFDMA0(0x688)
 
 /* WFDMA1 */
-#define MT_WFDMA1_BASE			0xd5000
-#define MT_WFDMA1(ofs)			(MT_WFDMA1_BASE + (ofs))
+#define MT_WFDMA1(ofs)			__REG_MAP(dev, MT_WFDMA1_BASE, ofs)
 
 #define MT_WFDMA1_RST			MT_WFDMA1(0x100)
 #define MT_WFDMA1_RST_LOGIC_RST		BIT(4)
@@ -404,14 +594,6 @@
 #define MT_WFDMA1_BUSY_ENA_TX_FIFO1	BIT(1)
 #define MT_WFDMA1_BUSY_ENA_RX_FIFO	BIT(2)
 
-#define MT_MCU_CMD			MT_WFDMA1(0x1f0)
-#define MT_MCU_CMD_STOP_DMA_FW_RELOAD	BIT(1)
-#define MT_MCU_CMD_STOP_DMA		BIT(2)
-#define MT_MCU_CMD_RESET_DONE		BIT(3)
-#define MT_MCU_CMD_RECOVERY_DONE	BIT(4)
-#define MT_MCU_CMD_NORMAL_STATE		BIT(5)
-#define MT_MCU_CMD_ERROR_MASK		GENMASK(5, 1)
-
 #define MT_WFDMA1_GLO_CFG		MT_WFDMA1(0x208)
 #define MT_WFDMA1_GLO_CFG_TX_DMA_EN	BIT(0)
 #define MT_WFDMA1_GLO_CFG_RX_DMA_EN	BIT(2)
@@ -421,9 +603,6 @@
 #define MT_WFDMA1_RST_DTX_PTR		MT_WFDMA1(0x20c)
 #define MT_WFDMA1_PRI_DLY_INT_CFG0	MT_WFDMA1(0x2f0)
 
-#define MT_TX_RING_BASE			MT_WFDMA1(0x300)
-#define MT_RX_EVENT_RING_BASE		MT_WFDMA1(0x500)
-
 #define MT_WFDMA1_TX_RING0_EXT_CTRL	MT_WFDMA1(0x600)
 #define MT_WFDMA1_TX_RING1_EXT_CTRL	MT_WFDMA1(0x604)
 #define MT_WFDMA1_TX_RING2_EXT_CTRL	MT_WFDMA1(0x608)
@@ -448,31 +627,7 @@
 #define MT_WFDMA1_RX_RING3_EXT_CTRL	MT_WFDMA1(0x68c)
 
 /* WFDMA CSR */
-#define MT_WFDMA_EXT_CSR_BASE		0xd7000
-#define MT_WFDMA_EXT_CSR(ofs)		(MT_WFDMA_EXT_CSR_BASE + (ofs))
-
-#define MT_INT_SOURCE_CSR		MT_WFDMA_EXT_CSR(0x10)
-#define MT_INT_MASK_CSR			MT_WFDMA_EXT_CSR(0x14)
-#define MT_INT_RX_DONE_DATA0		BIT(16)
-#define MT_INT_RX_DONE_DATA1		BIT(17)
-#define MT_INT_RX_DONE_WM		BIT(0)
-#define MT_INT_RX_DONE_WA		BIT(1)
-#define MT_INT_RX_DONE_WA_EXT		BIT(2)
-#define MT_INT_RX_DONE_ALL		(GENMASK(2, 0) | GENMASK(17, 16))
-#define MT_INT_TX_DONE_MCU_WA		BIT(15)
-#define MT_INT_TX_DONE_FWDL		BIT(26)
-#define MT_INT_TX_DONE_MCU_WM		BIT(27)
-#define MT_INT_TX_DONE_BAND0		BIT(30)
-#define MT_INT_TX_DONE_BAND1		BIT(31)
-
-#define MT_INT_BAND1_MASK		(MT_INT_RX_DONE_WA_EXT |	\
-					 MT_INT_TX_DONE_BAND1)
-
-#define MT_INT_MCU_CMD			BIT(29)
-
-#define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WA |	\
-					 MT_INT_TX_DONE_MCU_WM |	\
-					 MT_INT_TX_DONE_FWDL)
+#define MT_WFDMA_EXT_CSR(ofs)		__REG_MAP(dev, MT_WFDMA_EXT_CSR_BASE, (ofs))
 
 #define MT_WFDMA_HOST_CONFIG		MT_WFDMA_EXT_CSR(0x30)
 #define MT_WFDMA_HOST_CONFIG_PDMA_BAND	BIT(0)
@@ -480,53 +635,113 @@
 #define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR(0x44)
 #define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY	BIT(0)
 
-#define MT_INT1_SOURCE_CSR		MT_WFDMA_EXT_CSR(0x88)
-#define MT_INT1_MASK_CSR		MT_WFDMA_EXT_CSR(0x8c)
-
-#define MT_PCIE_RECOG_ID		MT_WFDMA_EXT_CSR(0x90)
+#define MT_PCIE_RECOG_ID		0xd7090
 #define MT_PCIE_RECOG_ID_MASK		GENMASK(30, 0)
 #define MT_PCIE_RECOG_ID_SEM		BIT(31)
 
 /* WFDMA0 PCIE1 */
-#define MT_WFDMA0_PCIE1_BASE			0xd8000
-#define MT_WFDMA0_PCIE1(ofs)			(MT_WFDMA0_PCIE1_BASE + (ofs))
+#define MT_WFDMA0_PCIE1(ofs)		__REG_MAP(dev, MT_WFDMA0_PCIE1_BASE, (ofs))
 
-#define MT_WFDMA0_PCIE1_BUSY_ENA		MT_WFDMA0_PCIE1(0x13c)
+#define MT_WFDMA0_PCIE1_BUSY_ENA	MT_WFDMA0_PCIE1(0x13c)
 #define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO0	BIT(0)
 #define MT_WFDMA0_PCIE1_BUSY_ENA_TX_FIFO1	BIT(1)
 #define MT_WFDMA0_PCIE1_BUSY_ENA_RX_FIFO	BIT(2)
 
 /* WFDMA1 PCIE1 */
-#define MT_WFDMA1_PCIE1_BASE			0xd9000
-#define MT_WFDMA1_PCIE1(ofs)			(MT_WFDMA0_PCIE1_BASE + (ofs))
+#define MT_WFDMA1_PCIE1(ofs)		__REG_MAP(dev, MT_WFDMA1_PCIE1_BASE, (ofs))
 
-#define MT_WFDMA1_PCIE1_BUSY_ENA		MT_WFDMA1_PCIE1(0x13c)
+#define MT_WFDMA1_PCIE1_BUSY_ENA	MT_WFDMA1_PCIE1(0x13c)
 #define MT_WFDMA1_PCIE1_BUSY_ENA_TX_FIFO0	BIT(0)
 #define MT_WFDMA1_PCIE1_BUSY_ENA_TX_FIFO1	BIT(1)
 #define MT_WFDMA1_PCIE1_BUSY_ENA_RX_FIFO	BIT(2)
 
-#define MT_TOP_RGU_BASE				0xf0000
-#define MT_TOP_PWR_CTRL				(MT_TOP_RGU_BASE + (0x0))
-#define MT_TOP_PWR_KEY				(0x5746 << 16)
-#define MT_TOP_PWR_SW_RST			BIT(0)
-#define MT_TOP_PWR_SW_PWR_ON			GENMASK(3, 2)
-#define MT_TOP_PWR_HW_CTRL			BIT(4)
-#define MT_TOP_PWR_PWR_ON			BIT(7)
+/* WFDMA COMMON */
+#define MT_INT_SOURCE_CSR		__REG(dev, INT_SOURCE_CSR)
+#define MT_INT_MASK_CSR			__REG(dev, INT_MASK_CSR)
+
+#define MT_INT1_SOURCE_CSR		__REG(dev, INT1_SOURCE_CSR)
+#define MT_INT1_MASK_CSR		__REG(dev, INT1_MASK_CSR)
+
+#define MT_TX_RING_BASE			__REG(dev, TX_RING_BASE)
+#define MT_RX_EVENT_RING_BASE		__REG(dev, RX_EVENT_RING_BASE)
+#define MT_RX_DATA_RING_BASE		__REG(dev, RX_DATA_RING_BASE)
+
+#define MT_INT_RX_DONE_DATA0		__BIT(dev, RX_DONE_DAND0)
+#define MT_INT_RX_DONE_DATA1		__BIT(dev, RX_DONE_DAND1)
+#define MT_INT_RX_DONE_WM		__BIT(dev, RX_DONE_MCU_WM)
+#define MT_INT_RX_DONE_WA		__BIT(dev, RX_DONE_MCU_WA)
+#define MT_INT_RX_DONE_WA_MAIN		__BIT(dev, RX_DONE_WA_BAND0)
+#define MT_INT_RX_DONE_WA_EXT		__BIT(dev, RX_DONE_WA_BAND1)
+#define MT_INT_MCU_CMD			__BIT(dev, RX_MCU_TO_HOST)
+
+#define MT_INT_RX_DONE_MCU		(MT_INT_RX_DONE_WM |		\
+					 MT_INT_RX_DONE_WA)
+#define MT_INT_BAND0_RX_DONE		(MT_INT_RX_DONE_WA_MAIN |	\
+					 MT_INT_RX_DONE_DATA0)
+#define MT_INT_BAND1_RX_DONE		(MT_INT_RX_DONE_WA_MAIN |	\
+					 MT_INT_RX_DONE_WA_EXT |	\
+					 MT_INT_RX_DONE_DATA1)
+#define MT_INT_RX_DONE_ALL		(MT_INT_RX_DONE_MCU |		\
+					 MT_INT_BAND0_RX_DONE |		\
+					 MT_INT_BAND1_RX_DONE)
+
+#define MT_INT_TX_DONE_FWDL		__BIT(dev, TX_DONE_FWDL)
+#define MT_INT_TX_DONE_MCU_WM		__BIT(dev, TX_DONE_MCU_WM)
+#define MT_INT_TX_DONE_MCU_WA		__BIT(dev, TX_DONE_MCU_WA)
+#define MT_INT_TX_DONE_BAND0		__BIT(dev, TX_DONE_BAND0)
+#define MT_INT_TX_DONE_BAND1		__BIT(dev, TX_DONE_BAND1)
 
-#define MT_INFRA_CFG_BASE		0xf1000
-#define MT_INFRA(ofs)			(MT_INFRA_CFG_BASE + (ofs))
+#define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WA |	\
+					 MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_FWDL)
+#define MT_MCU_CMD			__REG(dev, INT_MCU_CMD_SOURCE)
+#define MT_MCU_CMD_STOP_DMA_FW_RELOAD	BIT(1)
+#define MT_MCU_CMD_STOP_DMA		BIT(2)
+#define MT_MCU_CMD_RESET_DONE		BIT(3)
+#define MT_MCU_CMD_RECOVERY_DONE	BIT(4)
+#define MT_MCU_CMD_NORMAL_STATE		BIT(5)
+#define MT_MCU_CMD_ERROR_MASK		GENMASK(5, 1)
 
-#define MT_HIF_REMAP_L1			MT_INFRA(0x1ac)
+/* TOP RGU */
+#define MT_TOP_RGU_BASE			0x18000000
+#define MT_TOP_PWR_CTRL			(MT_TOP_RGU_BASE + (0x0))
+#define MT_TOP_PWR_KEY			(0x5746 << 16)
+#define MT_TOP_PWR_SW_RST		BIT(0)
+#define MT_TOP_PWR_SW_PWR_ON		GENMASK(3, 2)
+#define MT_TOP_PWR_HW_CTRL		BIT(4)
+#define MT_TOP_PWR_PWR_ON		BIT(7)
+
+/* l1/l2 remap */
+#define MT_HIF_REMAP_L1			__REG(dev, L1_REMAP_CFG_OFFSET)
 #define MT_HIF_REMAP_L1_MASK		GENMASK(15, 0)
 #define MT_HIF_REMAP_L1_OFFSET		GENMASK(15, 0)
 #define MT_HIF_REMAP_L1_BASE		GENMASK(31, 16)
-#define MT_HIF_REMAP_BASE_L1		0xe0000
+#define MT_HIF_REMAP_BASE_L1		__REG_MAP(dev, MT_REMAP_L1_BASE, 0)
+
+#define MT_HIF_REMAP_L2			__REG(dev, L2_REMAP_CFG_OFFSET)
+#define MT_HIF_REMAP_L2_MASK		__MASK(dev, L2_REMAP_MASK)
+#define MT_HIF_REMAP_L2_OFFSET		__MASK(dev, L2_REMAP_OFFSET)
+#define MT_HIF_REMAP_L2_BASE		__MASK(dev, L2_REMAP_BASE)
+#define MT_HIF_REMAP_BASE_L2		__REG_MAP(dev, MT_REMAP_L2_BASE, 0)
+
+#define MT_INFRA_BASE			0x18000000
+#define MT_WFSYS0_PHY_START		0x18400000
+#define MT_WFSYS1_PHY_START		0x18800000
+#define MT_WFSYS1_PHY_END		0x18bfffff
+#define MT_CBTOP1_PHY_START		0x70000000
+#define MT_CBTOP1_PHY_END		0x7fffffff
+#define MT_CBTOP2_PHY_START		0xf0000000
+#define MT_CBTOP2_PHY_END		0xffffffff
+#define MT_CONN_INFRA_MCU_START		0x7c000000
+#define MT_CONN_INFRA_MCU_END		__REG_MAP(dev, MT_INFRA_MCU_END_BASE, 0)
+
+/* FW MODE SYNC */
+#define MT_SWDEF(ofs)			__REG_MAP(dev, MT_SWDEF_BASE, (ofs))
 
-#define MT_HIF_REMAP_L2			MT_INFRA(0x1b0)
-#define MT_HIF_REMAP_L2_MASK		GENMASK(19, 0)
-#define MT_HIF_REMAP_L2_OFFSET		GENMASK(11, 0)
-#define MT_HIF_REMAP_L2_BASE		GENMASK(31, 12)
-#define MT_HIF_REMAP_BASE_L2		0x00000
+#define MT_SWDEF_MODE			MT_SWDEF(0x3c)
+#define MT_SWDEF_NORMAL_MODE		0
+#define MT_SWDEF_ICAP_MODE		1
+#define MT_SWDEF_SPECTRUM_MODE		2
 
 #define MT_DIC_CMD_REG_BASE		0x41f000
 #define MT_DIC_CMD_REG(ofs)		(MT_DIC_CMD_REG_BASE + (ofs))
@@ -540,13 +755,7 @@
 #define MT_CPU_UTIL_PEAK_IDLE_CNT	MT_CPU_UTIL(0x0c)
 #define MT_CPU_UTIL_CTRL		MT_CPU_UTIL(0x1c)
 
-#define MT_SWDEF_BASE			0x41f200
-#define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
-#define MT_SWDEF_MODE			MT_SWDEF(0x3c)
-#define MT_SWDEF_NORMAL_MODE		0
-#define MT_SWDEF_ICAP_MODE		1
-#define MT_SWDEF_SPECTRUM_MODE		2
-
+/* LED */
 #define MT_LED_TOP_BASE			0x18013000
 #define MT_LED_PHYS(_n)			(MT_LED_TOP_BASE + (_n))
 
@@ -561,6 +770,11 @@
 
 #define MT_LED_EN(_n)			MT_LED_PHYS(0x40 + ((_n) * 4))
 
+#define MT_LED_GPIO_MUX2                0x70005058 /* GPIO 18 */
+#define MT_LED_GPIO_MUX3                0x7000505C /* GPIO 26 */
+#define MT_LED_GPIO_SEL_MASK            GENMASK(11, 8)
+
+/* MT TOP */
 #define MT_TOP_BASE			0x18060000
 #define MT_TOP(ofs)			(MT_TOP_BASE + (ofs))
 
@@ -572,22 +786,17 @@
 #define MT_TOP_MISC			MT_TOP(0xf0)
 #define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
 
-#define MT_LED_GPIO_MUX2                0x70005058 /* GPIO 18 */
-#define MT_LED_GPIO_MUX3                0x7000505C /* GPIO 26 */
-#define MT_LED_GPIO_SEL_MASK            GENMASK(11, 8)
-
 #define MT_HW_BOUND			0x70010020
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
 
-#define MT_PCIE1_MAC_BASE		0x74020000
-#define MT_PCIE1_MAC(ofs)		(MT_PCIE1_MAC_BASE + (ofs))
-#define MT_PCIE1_MAC_INT_ENABLE		MT_PCIE1_MAC(0x188)
-
-#define MT_PCIE_MAC_BASE		0x74030000
-#define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
+/* PCIE MAC */
+#define MT_PCIE_MAC(ofs)		__REG_MAP(dev, MT_PCIE_MAC_BASE, (ofs))
 #define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
 
+#define MT_PCIE1_MAC(ofs)		__REG_MAP(dev, MT_PCIE1_MAC_BASE, (ofs))
+#define MT_PCIE1_MAC_INT_ENABLE		MT_PCIE1_MAC(0x188)
+
 #define MT_WF_IRPI_BASE			0x83006000
 #define MT_WF_IRPI(ofs)			(MT_WF_IRPI_BASE + ((ofs) << 16))
 
@@ -601,7 +810,7 @@
 
 #define MT_WF_PHY_RXTD12(_phy)		MT_WF_PHY(0x8230 + ((_phy) << 16))
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
-#define MT_WF_PHY_RXTD12_IRPI_SW_CLR	BIT(29)
+#define MT_WF_PHY_RXTD12_IRPI_SW_CLR		BIT(29)
 
 #define MT_MCU_WM_CIRQ_BASE			0x89010000
 #define MT_MCU_WM_CIRQ(ofs)			(MT_MCU_WM_CIRQ_BASE + (ofs))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 89aae32..a70f7d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -23,30 +23,16 @@ struct reg_band {
 	u32 band[2];
 };
 
-#define REG_BAND(_reg) \
-	{ .band[0] = MT_##_reg(0), .band[1] = MT_##_reg(1) }
-#define REG_BAND_IDX(_reg, _idx) \
-	{ .band[0] = MT_##_reg(0, _idx), .band[1] = MT_##_reg(1, _idx) }
-
-static const struct reg_band reg_backup_list[] = {
-	REG_BAND_IDX(AGG_PCR0, 0),
-	REG_BAND_IDX(AGG_PCR0, 1),
-	REG_BAND_IDX(AGG_AWSCR0, 0),
-	REG_BAND_IDX(AGG_AWSCR0, 1),
-	REG_BAND_IDX(AGG_AWSCR0, 2),
-	REG_BAND_IDX(AGG_AWSCR0, 3),
-	REG_BAND(AGG_MRCR),
-	REG_BAND(TMAC_TFCR0),
-	REG_BAND(TMAC_TCR0),
-	REG_BAND(AGG_ATCR1),
-	REG_BAND(AGG_ATCR3),
-	REG_BAND(TMAC_TRCR0),
-	REG_BAND(TMAC_ICR0),
-	REG_BAND_IDX(ARB_DRNGR0, 0),
-	REG_BAND_IDX(ARB_DRNGR0, 1),
-	REG_BAND(WF_RFCR),
-	REG_BAND(WF_RFCR1),
-};
+#define REG_BAND(_list, _reg) \
+		{ _list.band[0] = MT_##_reg(0);	\
+		  _list.band[1] = MT_##_reg(1); }
+#define REG_BAND_IDX(_list, _reg, _idx) \
+		{ _list.band[0] = MT_##_reg(0, _idx);	\
+		  _list.band[1] = MT_##_reg(1, _idx); }
+
+#define TM_REG_MAX_ID	17
+static struct reg_band reg_backup_list[TM_REG_MAX_ID];
+
 
 static int
 mt7915_tm_set_tx_power(struct mt7915_phy *phy)
@@ -355,6 +341,24 @@ mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 	u32 *b = phy->test.reg_backup;
 	int i;
 
+	REG_BAND_IDX(reg_backup_list[0], AGG_PCR0, 0);
+	REG_BAND_IDX(reg_backup_list[1], AGG_PCR0, 1);
+	REG_BAND_IDX(reg_backup_list[2], AGG_AWSCR0, 0);
+	REG_BAND_IDX(reg_backup_list[3], AGG_AWSCR0, 1);
+	REG_BAND_IDX(reg_backup_list[4], AGG_AWSCR0, 2);
+	REG_BAND_IDX(reg_backup_list[5], AGG_AWSCR0, 3);
+	REG_BAND(reg_backup_list[6], AGG_MRCR);
+	REG_BAND(reg_backup_list[7], TMAC_TFCR0);
+	REG_BAND(reg_backup_list[8], TMAC_TCR0);
+	REG_BAND(reg_backup_list[9], AGG_ATCR1);
+	REG_BAND(reg_backup_list[10], AGG_ATCR3);
+	REG_BAND(reg_backup_list[11], TMAC_TRCR0);
+	REG_BAND(reg_backup_list[12], TMAC_ICR0);
+	REG_BAND_IDX(reg_backup_list[13], ARB_DRNGR0, 0);
+	REG_BAND_IDX(reg_backup_list[14], ARB_DRNGR0, 1);
+	REG_BAND(reg_backup_list[15], WF_RFCR);
+	REG_BAND(reg_backup_list[16], WF_RFCR1);
+
 	if (phy->mt76->test.state == MT76_TM_STATE_OFF) {
 		for (i = 0; i < n_regs; i++)
 			mt76_wr(dev, reg_backup_list[i].band[ext_phy], b[i]);
@@ -726,6 +730,7 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 	void *rx, *rssi;
 	u16 fcs_err;
 	int i;
+	u32 cnt;
 
 	rx = nla_nest_start(msg, MT76_TM_STATS_ATTR_LAST_RX);
 	if (!rx)
@@ -769,8 +774,9 @@ mt7915_tm_dump_stats(struct mt76_phy *mphy, struct sk_buff *msg)
 
 	nla_nest_end(msg, rx);
 
-	fcs_err = mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
-				 MT_MIB_SDR3_FCS_ERR_MASK);
+	cnt = mt76_rr(dev, MT_MIB_SDR3(ext_phy));
+	fcs_err = __FIELD_GET(MIB_SDR3_FCS_ERR, cnt);
+
 	q = ext_phy ? MT_RXQ_EXT : MT_RXQ_MAIN;
 	mphy->test.rx_stats.packets[q] += fcs_err;
 	mphy->test.rx_stats.fcs_error[q] += fcs_err;
-- 
2.18.0

