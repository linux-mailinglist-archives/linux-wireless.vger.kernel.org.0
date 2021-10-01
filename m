Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D997D41E9AF
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 11:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353031AbhJAJjZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 05:39:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39286 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352790AbhJAJjX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 05:39:23 -0400
X-UUID: 411c58dee147464a915295989724b906-20211001
X-UUID: 411c58dee147464a915295989724b906-20211001
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1930765076; Fri, 01 Oct 2021 17:37:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 1 Oct 2021 17:37:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Oct 2021 17:37:37 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v3 2/2] mt76: mt7915: add debugfs knobs for MCU utilization
Date:   Fri, 1 Oct 2021 17:36:36 +0800
Message-ID: <20211001093636.10501-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211001093636.10501-1-shayne.chen@mediatek.com>
References: <20211001093636.10501-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add debugfs knobs to read MCU utilization, which helps user know
firmware status more easily to narrow down CPU bottleneck issues.

Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 49 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  5 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  2 +
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  3 ++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 17 +++++++
 6 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index b9689762f529..a71cc111420b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -100,6 +100,12 @@ mt7915_fw_debug_wm_set(void *data, u64 val)
 	for (debug = DEBUG_TXCMD; debug <= DEBUG_RPT_RX; debug++)
 		mt7915_mcu_fw_dbg_ctrl(dev, debug, !!dev->fw_debug_wm);
 
+	/* WM CPU info record control */
+	mt76_clear(dev, MT_CPU_UTIL_CTRL, BIT(0));
+	mt76_wr(dev, MT_DIC_CMD_REG_CMD, BIT(2) | BIT(13) | !dev->fw_debug_wm);
+	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_MASK_CLR_ADDR, BIT(5));
+	mt76_wr(dev, MT_MCU_WM_CIRQ_IRQ_SOFT_ADDR, BIT(5));
+
 	return 0;
 }
 
@@ -123,7 +129,11 @@ mt7915_fw_debug_wa_set(void *data, u64 val)
 
 	dev->fw_debug_wa = val ? MCU_FW_LOG_TO_HOST : 0;
 
-	return mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WA, dev->fw_debug_wa);
+	mt7915_mcu_fw_log_2_host(dev, MCU_FW_LOG_WA, dev->fw_debug_wa);
+	mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET), MCU_WA_PARAM_PDMA_RX,
+			  !!dev->fw_debug_wa, 0);
+
+	return 0;
 }
 
 static int
@@ -139,6 +149,39 @@ mt7915_fw_debug_wa_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug_wa, mt7915_fw_debug_wa_get,
 			 mt7915_fw_debug_wa_set, "%lld\n");
 
+static int
+mt7915_fw_util_wm_show(struct seq_file *file, void *data)
+{
+	struct mt7915_dev *dev = file->private;
+
+	if (dev->fw_debug_wm) {
+		seq_printf(file, "Busy: %u%%  Peak busy: %u%%\n",
+			   mt76_rr(dev, MT_CPU_UTIL_BUSY_PCT),
+			   mt76_rr(dev, MT_CPU_UTIL_PEAK_BUSY_PCT));
+		seq_printf(file, "Idle count: %u  Peak idle count: %u\n",
+			   mt76_rr(dev, MT_CPU_UTIL_IDLE_CNT),
+			   mt76_rr(dev, MT_CPU_UTIL_PEAK_IDLE_CNT));
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7915_fw_util_wm);
+
+static int
+mt7915_fw_util_wa_show(struct seq_file *file, void *data)
+{
+	struct mt7915_dev *dev = file->private;
+
+	if (dev->fw_debug_wa)
+		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(QUERY),
+				  MCU_WA_PARAM_CPU_UTIL, 0, 0);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7915_fw_util_wa);
+
 static void
 mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 			   struct seq_file *file)
@@ -480,6 +523,10 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 	debugfs_create_file("tx_stats", 0400, dir, dev, &mt7915_tx_stats_fops);
 	debugfs_create_file("fw_debug_wm", 0600, dir, dev, &fops_fw_debug_wm);
 	debugfs_create_file("fw_debug_wa", 0600, dir, dev, &fops_fw_debug_wa);
+	debugfs_create_file("fw_util_wm", 0400, dir, dev,
+			    &mt7915_fw_util_wm_fops);
+	debugfs_create_file("fw_util_wa", 0400, dir, dev,
+			    &mt7915_fw_util_wa_fops);
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 419b2acad41d..6bc940b271eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -416,8 +416,7 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[qid], skb, 0);
 }
 
-static int
-mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
+int mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
 {
 	struct {
 		__le32 args[3];
@@ -429,7 +428,7 @@ mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3)
 		},
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), false);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 4a601bdee156..ee732e206751 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -300,6 +300,8 @@ enum {
 };
 
 enum {
+	MCU_WA_PARAM_PDMA_RX = 0x04,
+	MCU_WA_PARAM_CPU_UTIL = 0x0b,
 	MCU_WA_PARAM_RED = 0x0e,
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 7bbb38e7116a..1f6ba306c850 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -34,6 +34,9 @@ static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
 		u32 mapped;
 		u32 size;
 	} fixed_map[] = {
+		{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
+		{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure regs) */
+		{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
 		{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
 		{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
 		{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 50c7c8c09d83..aceea6438184 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -356,6 +356,7 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev, enum mt7915_rdd_cmd cmd,
 		       u8 index, u8 rx_sel, u8 val);
+int mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3);
 int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 type, u8 ctrl);
 int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level);
 void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 3cf81bbcf1d8..e161c5dc1f8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -424,6 +424,18 @@
 #define MT_HIF_REMAP_L2_BASE		GENMASK(31, 12)
 #define MT_HIF_REMAP_BASE_L2		0x00000
 
+#define MT_DIC_CMD_REG_BASE		0x41f000
+#define MT_DIC_CMD_REG(ofs)		(MT_DIC_CMD_REG_BASE + (ofs))
+#define MT_DIC_CMD_REG_CMD		MT_DIC_CMD_REG(0x10)
+
+#define MT_CPU_UTIL_BASE		0x41f030
+#define MT_CPU_UTIL(ofs)		(MT_CPU_UTIL_BASE + (ofs))
+#define MT_CPU_UTIL_BUSY_PCT		MT_CPU_UTIL(0x00)
+#define MT_CPU_UTIL_PEAK_BUSY_PCT	MT_CPU_UTIL(0x04)
+#define MT_CPU_UTIL_IDLE_CNT		MT_CPU_UTIL(0x08)
+#define MT_CPU_UTIL_PEAK_IDLE_CNT	MT_CPU_UTIL(0x0c)
+#define MT_CPU_UTIL_CTRL		MT_CPU_UTIL(0x1c)
+
 #define MT_SWDEF_BASE			0x41f200
 #define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
 #define MT_SWDEF_MODE			MT_SWDEF(0x3c)
@@ -486,4 +498,9 @@
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR	BIT(29)
 
+#define MT_MCU_WM_CIRQ_BASE			0x89010000
+#define MT_MCU_WM_CIRQ(ofs)			(MT_MCU_WM_CIRQ_BASE + (ofs))
+#define MT_MCU_WM_CIRQ_IRQ_MASK_CLR_ADDR	MT_MCU_WM_CIRQ(0x80)
+#define MT_MCU_WM_CIRQ_IRQ_SOFT_ADDR		MT_MCU_WM_CIRQ(0xc0)
+
 #endif
-- 
2.25.1

