Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E93E9A87
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhHKVqC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:46:02 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:52232 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232233AbhHKVpY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:24 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.133])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6ABB41C0069
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3CF07B0007D
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id EBC4813C2B4;
        Wed, 11 Aug 2021 14:44:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EBC4813C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718292;
        bh=8P8wRSjVP+ECqn0enA5H9nL7znbe/vrrfUcpJGOc+bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=by9Gf+zh0IoEgT5zDbI/jdXFF8jEXlGPhQzKU5JbvxFN0IW+e4ppicSvOKTt9iI1M
         W11KON+PQ6kKcKZy1RINnv8qzOMcOWge8Lrp/1X2YSmh9MqkDCXYprpk3rO/dqqfi6
         BApQaeTV8eYeCDgPWDyJbUu00CIEiOqHVUm0lJyI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 11/15] mt76: mt7915:  debugfs display for pse non-empty queues
Date:   Wed, 11 Aug 2021 14:44:35 -0700
Message-Id: <20210811214439.17458-12-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718292-cwI4-HQ--Day
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This may give user some idea of how the buffer utilization is being used
in the firmware/hardware.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 141 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 201 ++++++++++++++++++
 2 files changed, 342 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 688641ea4bb5..5c6a75f45f8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -507,6 +507,146 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(mt7915_tx_stats);
 
+struct mt7915_empty_q_info {
+	const char *qname;
+	u32 port_id;
+	u32 q_id;
+};
+
+static struct mt7915_empty_q_info pse_queue_empty_info[] = {
+	{"CPU Q0",  ENUM_UMAC_CPU_PORT_1,     ENUM_UMAC_CTX_Q_0},
+	{"CPU Q1",  ENUM_UMAC_CPU_PORT_1,     ENUM_UMAC_CTX_Q_1},
+	{"CPU Q2",  ENUM_UMAC_CPU_PORT_1,     ENUM_UMAC_CTX_Q_2},
+	{"CPU Q3",  ENUM_UMAC_CPU_PORT_1,     ENUM_UMAC_CTX_Q_3},
+	{NULL, 0, 0}, {NULL, 0, 0}, {NULL, 0, 0}, {NULL, 0, 0}, /* 4~7 not defined */
+	{"HIF Q0", ENUM_UMAC_HIF_PORT_0,    0}, /* Q8 */
+	{"HIF Q1", ENUM_UMAC_HIF_PORT_0,    1},
+	{"HIF Q2", ENUM_UMAC_HIF_PORT_0,    2},
+	{"HIF Q3", ENUM_UMAC_HIF_PORT_0,    3},
+	{"HIF Q4", ENUM_UMAC_HIF_PORT_0,    4},
+	{"HIF Q5", ENUM_UMAC_HIF_PORT_0,    5},
+	{NULL, 0, 0}, {NULL, 0, 0},  /* 14~15 not defined */
+	{"LMAC Q",  ENUM_UMAC_LMAC_PORT_2,    0},
+	{"MDP TX Q", ENUM_UMAC_LMAC_PORT_2, 1},
+	{"MDP RX Q", ENUM_UMAC_LMAC_PORT_2, 2},
+	{"SEC TX Q", ENUM_UMAC_LMAC_PORT_2, 3},
+	{"SEC RX Q", ENUM_UMAC_LMAC_PORT_2, 4},
+	{"SFD_PARK Q", ENUM_UMAC_LMAC_PORT_2, 5},
+	{"MDP_TXIOC Q", ENUM_UMAC_LMAC_PORT_2, 6},
+	{"MDP_RXIOC Q", ENUM_UMAC_LMAC_PORT_2, 7},
+	{NULL, 0, 0}, {NULL, 0, 0}, {NULL, 0, 0}, {NULL, 0, 0},
+	{NULL, 0, 0}, {NULL, 0, 0}, {NULL, 0, 0}, /* 24~30 not defined */
+	{"RLS Q",  ENUM_PLE_CTRL_PSE_PORT_3, ENUM_UMAC_PLE_CTRL_P3_Q_0X1F}
+};
+
+static void
+mt7915_pse_q_nonempty_stat_read_phy(struct mt7915_phy *phy,
+				    struct seq_file *file)
+{
+	struct mt7915_dev *dev = file->private;
+	u32 pse_stat;
+	int i;
+
+	pse_stat = mt76_rr(dev, WF_PSE_TOP_QUEUE_EMPTY_ADDR);
+
+	/* Queue Empty Status */
+	seq_puts(file, "PSE Queue Empty Status:\n");
+	seq_printf(file, "\tQUEUE_EMPTY: 0x%08x\n", pse_stat);
+	seq_printf(file, "\t\tCPU Q0/1/2/3 empty=%d/%d/%d/%d\n",
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_CPU_Q0_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_CPU_Q0_EMPTY_SHFT),
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_CPU_Q1_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_CPU_Q1_EMPTY_SHFT),
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_CPU_Q2_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_CPU_Q2_EMPTY_SHFT),
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_CPU_Q3_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_CPU_Q3_EMPTY_SHFT));
+	seq_printf(file, "\t\tHIF Q0/1/2/3/4/5 empty=%d/%d/%d/%d/%d/%d\n",
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_HIF_0_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_HIF_0_EMPTY_SHFT),
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_HIF_1_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_HIF_1_EMPTY_SHFT),
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_HIF_2_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_HIF_2_EMPTY_SHFT),
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_HIF_3_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_HIF_3_EMPTY_SHFT),
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_HIF_4_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_HIF_4_EMPTY_SHFT),
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_HIF_5_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_HIF_5_EMPTY_SHFT));
+	seq_printf(file, "\t\tLMAC TX Q empty=%d\n",
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_LMAC_TX_QUEUE_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_LMAC_TX_QUEUE_EMPTY_SHFT));
+	seq_printf(file, "\t\tMDP TX Q/RX Q empty=%d/%d\n",
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_MDP_TX_QUEUE_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_MDP_TX_QUEUE_EMPTY_SHFT),
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_MDP_RX_QUEUE_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_MDP_RX_QUEUE_EMPTY_SHFT));
+	seq_printf(file, "\t\tSEC TX Q/RX Q empty=%d/%d\n",
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_SEC_TX_QUEUE_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_SEC_TX_QUEUE_EMPTY_SHFT),
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_SEC_RX_QUEUE_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_SEC_RX_QUEUE_EMPTY_SHFT));
+	seq_printf(file, "\t\tSFD PARK Q empty=%d\n",
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_SFD_PARK_QUEUE_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_SFD_PARK_QUEUE_EMPTY_SHFT));
+	seq_printf(file, "\t\tMDP TXIOC Q/RXIOC Q empty=%d/%d\n",
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_MDP_TXIOC_QUEUE_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_MDP_TXIOC_QUEUE_EMPTY_SHFT),
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_MDP_RXIOC_QUEUE_EMPTY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_MDP_RXIOC_QUEUE_EMPTY_SHFT));
+	seq_printf(file, "\t\tRLS Q empty=%d\n",
+		   ((pse_stat & WF_PSE_TOP_QUEUE_EMPTY_RLS_Q_EMTPY_MASK)
+		    >> WF_PSE_TOP_QUEUE_EMPTY_RLS_Q_EMTPY_SHFT));
+	seq_printf(file,  ("Non-Empty Q info:\n"));
+
+	for (i = 0; i < 31; i++) {
+		if (((pse_stat & (0x1 << i)) >> i) == 0) {
+			u32 hfid, tfid, pktcnt, fl_que_ctrl[3] = {0};
+
+			if (pse_queue_empty_info[i].qname) {
+				seq_printf(file,  "\t%s: ", pse_queue_empty_info[i].qname);
+				fl_que_ctrl[0] |= WF_PSE_TOP_FL_QUE_CTRL_0_EXECUTE_MASK;
+				fl_que_ctrl[0] |= (pse_queue_empty_info[i].port_id
+						   << WF_PSE_TOP_FL_QUE_CTRL_0_Q_BUF_PID_SHFT);
+				fl_que_ctrl[0] |= (pse_queue_empty_info[i].q_id
+						   << WF_PSE_TOP_FL_QUE_CTRL_0_Q_BUF_QID_SHFT);
+			} else {
+				continue;
+			}
+
+			/*  Executes frame link and queue structure buffer read command */
+			fl_que_ctrl[0] |= (0x1 << 31);
+			mt76_wr(dev, WF_PSE_TOP_FL_QUE_CTRL_0_ADDR, fl_que_ctrl[0]);
+
+			fl_que_ctrl[1] = mt76_rr(dev, WF_PSE_TOP_FL_QUE_CTRL_2_ADDR);
+			fl_que_ctrl[2] = mt76_rr(dev, WF_PSE_TOP_FL_QUE_CTRL_3_ADDR);
+			hfid = (fl_que_ctrl[1] & WF_PSE_TOP_FL_QUE_CTRL_2_QUEUE_HEAD_FID_MASK)
+				>> WF_PSE_TOP_FL_QUE_CTRL_2_QUEUE_HEAD_FID_SHFT;
+			tfid = (fl_que_ctrl[1] & WF_PSE_TOP_FL_QUE_CTRL_2_QUEUE_TAIL_FID_MASK)
+				>> WF_PSE_TOP_FL_QUE_CTRL_2_QUEUE_TAIL_FID_SHFT;
+			pktcnt = (fl_que_ctrl[2] & WF_PSE_TOP_FL_QUE_CTRL_3_QUEUE_PKT_NUM_MASK)
+				>> WF_PSE_TOP_FL_QUE_CTRL_3_QUEUE_PKT_NUM_SHFT;
+			seq_printf(file, "tail/head fid = 0x%03x/0x%03x, pkt cnt = 0x%03x\n",
+				   tfid, hfid, pktcnt);
+		}
+	}
+}
+
+static int
+mt7915_rx_pse_stats_show(struct seq_file *file, void *data)
+{
+	struct mt7915_dev *dev = file->private;
+
+	seq_puts(file, "RX PSE Stats\n");
+
+	mt7915_pse_q_nonempty_stat_read_phy(&dev->phy, file);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mt7915_rx_pse_stats);
+
 static int
 mt7915_queues_acq(struct seq_file *s, void *data)
 {
@@ -622,6 +762,7 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 	debugfs_create_devm_seqfile(dev->mt76.dev, "acq", dir,
 				    mt7915_queues_acq);
 	debugfs_create_file("tx_stats", 0400, dir, dev, &mt7915_tx_stats_fops);
+	debugfs_create_file("rx_pse_stats", 0400, dir, dev, &mt7915_rx_pse_stats_fops);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
 	debugfs_create_file("txs_for_no_skb", 0600, dir, dev, &fops_txs_for_no_skb);
 	debugfs_create_file("rx_group_5_enable", 0600, dir, dev, &fops_rx_group_5_enable);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index ac4d233b8cf2..1e3ce90ff3dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -566,4 +566,205 @@
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR	BIT(29)
 
+/* PSE queue related registers and enums */
+
+/* PLE info */
+enum ENUM_UMAC_PORT {
+	ENUM_UMAC_HIF_PORT_0         = 0,
+	ENUM_UMAC_CPU_PORT_1         = 1,
+	ENUM_UMAC_LMAC_PORT_2        = 2,
+	ENUM_PLE_CTRL_PSE_PORT_3     = 3,
+	ENUM_UMAC_PSE_PLE_PORT_TOTAL_NUM = 4
+};
+
+/* N9 MCU QUEUE LIST */
+enum ENUM_UMAC_CPU_P_QUEUE {
+	ENUM_UMAC_CTX_Q_0 = 0,
+	ENUM_UMAC_CTX_Q_1 = 1,
+	ENUM_UMAC_CTX_Q_2 = 2,
+	ENUM_UMAC_CTX_Q_3 = 3,
+	ENUM_UMAC_CRX     = 0,
+	ENUM_UMAC_CIF_QUEUE_TOTAL_NUM = 4
+};
+
+/* LMAC PLE TX QUEUE LIST */
+enum ENUM_UMAC_LMAC_PLE_TX_P_QUEUE {
+	ENUM_UMAC_LMAC_PLE_TX_Q_00           = 0x00,
+	ENUM_UMAC_LMAC_PLE_TX_Q_01           = 0x01,
+	ENUM_UMAC_LMAC_PLE_TX_Q_02           = 0x02,
+	ENUM_UMAC_LMAC_PLE_TX_Q_03           = 0x03,
+
+	ENUM_UMAC_LMAC_PLE_TX_Q_10           = 0x04,
+	ENUM_UMAC_LMAC_PLE_TX_Q_11           = 0x05,
+	ENUM_UMAC_LMAC_PLE_TX_Q_12           = 0x06,
+	ENUM_UMAC_LMAC_PLE_TX_Q_13           = 0x07,
+
+	ENUM_UMAC_LMAC_PLE_TX_Q_20           = 0x08,
+	ENUM_UMAC_LMAC_PLE_TX_Q_21           = 0x09,
+	ENUM_UMAC_LMAC_PLE_TX_Q_22           = 0x0a,
+	ENUM_UMAC_LMAC_PLE_TX_Q_23           = 0x0b,
+
+	ENUM_UMAC_LMAC_PLE_TX_Q_30           = 0x0c,
+	ENUM_UMAC_LMAC_PLE_TX_Q_31           = 0x0d,
+	ENUM_UMAC_LMAC_PLE_TX_Q_32           = 0x0e,
+	ENUM_UMAC_LMAC_PLE_TX_Q_33           = 0x0f,
+
+	ENUM_UMAC_LMAC_PLE_TX_Q_ALTX_0      = 0x10,
+	ENUM_UMAC_LMAC_PLE_TX_Q_BMC_0       = 0x11,
+	ENUM_UMAC_LMAC_PLE_TX_Q_BNC_0       = 0x12,
+	ENUM_UMAC_LMAC_PLE_TX_Q_PSMP_0      = 0x13,
+
+	ENUM_UMAC_LMAC_PLE_TX_Q_ALTX_1      = 0x14,
+	ENUM_UMAC_LMAC_PLE_TX_Q_BMC_1       = 0x15,
+	ENUM_UMAC_LMAC_PLE_TX_Q_BNC_1       = 0x16,
+	ENUM_UMAC_LMAC_PLE_TX_Q_PSMP_1      = 0x17,
+	ENUM_UMAC_LMAC_PLE_TX_Q_NAF         = 0x18,
+	ENUM_UMAC_LMAC_PLE_TX_Q_NBCN        = 0x19,
+	/* DE suggests not to use 0x1f, it's only for hw free queue */
+	ENUM_UMAC_LMAC_PLE_TX_Q_RELEASE     = 0x1f,
+	ENUM_UMAC_LMAC_QUEUE_TOTAL_NUM      = 24,
+};
+
+/* LMAC PLE For PSE Control P3 */
+enum _ENUM_UMAC_PLE_CTRL_P3_QUEUE {
+	ENUM_UMAC_PLE_CTRL_P3_Q_0X1E            = 0x1e,
+	ENUM_UMAC_PLE_CTRL_P3_Q_0X1F            = 0x1f,
+	ENUM_UMAC_PLE_CTRL_P3_TOTAL_NUM         = 2
+};
+
+#define WF_PSE_TOP_BASE                                        0x820C8000
+
+#define WF_PSE_TOP_QUEUE_EMPTY_ADDR                            (WF_PSE_TOP_BASE + 0xB0) /* 80B0 */
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_ADDR                       (WF_PSE_TOP_BASE + 0xB4) /* 80B4 */
+
+#define WF_PSE_TOP_FL_QUE_CTRL_0_ADDR                          (WF_PSE_TOP_BASE + 0x1B0) /* 81B0 */
+#define WF_PSE_TOP_FL_QUE_CTRL_1_ADDR                          (WF_PSE_TOP_BASE + 0x1B4) /* 81B4 */
+#define WF_PSE_TOP_FL_QUE_CTRL_2_ADDR                          (WF_PSE_TOP_BASE + 0x1B8) /* 81B8 */
+#define WF_PSE_TOP_FL_QUE_CTRL_3_ADDR                          (WF_PSE_TOP_BASE + 0x1BC) /* 81BC */
+
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_6_EMPTY_MASK_ADDR      WF_PSE_TOP_QUEUE_EMPTY_MASK_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_6_EMPTY_MASK_MASK      0x00004000 /* HIF_6_EMPTY_MASK[14] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_6_EMPTY_MASK_SHFT      14
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_5_EMPTY_MASK_ADDR      WF_PSE_TOP_QUEUE_EMPTY_MASK_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_5_EMPTY_MASK_MASK      0x00002000 /* HIF_5_EMPTY_MASK[13] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_5_EMPTY_MASK_SHFT      13
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_4_EMPTY_MASK_ADDR      WF_PSE_TOP_QUEUE_EMPTY_MASK_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_4_EMPTY_MASK_MASK      0x00001000 /* HIF_4_EMPTY_MASK[12] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_4_EMPTY_MASK_SHFT      12
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_3_EMPTY_MASK_ADDR      WF_PSE_TOP_QUEUE_EMPTY_MASK_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_3_EMPTY_MASK_MASK      0x00000800 /* HIF_3_EMPTY_MASK[11] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_3_EMPTY_MASK_SHFT      11
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_2_EMPTY_MASK_ADDR      WF_PSE_TOP_QUEUE_EMPTY_MASK_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_2_EMPTY_MASK_MASK      0x00000400 /* HIF_2_EMPTY_MASK[10] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_2_EMPTY_MASK_SHFT      10
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_1_EMPTY_MASK_ADDR      WF_PSE_TOP_QUEUE_EMPTY_MASK_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_1_EMPTY_MASK_MASK      0x00000200 /* HIF_1_EMPTY_MASK[9] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_1_EMPTY_MASK_SHFT      9
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_0_EMPTY_MASK_ADDR      WF_PSE_TOP_QUEUE_EMPTY_MASK_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_0_EMPTY_MASK_MASK      0x00000100 /* HIF_0_EMPTY_MASK[8] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_0_EMPTY_MASK_SHFT      8
+
+#define WF_PSE_TOP_QUEUE_EMPTY_RLS_Q_EMTPY_ADDR                WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_RLS_Q_EMTPY_MASK                0x80000000 /* RLS_Q_EMTPY[31] */
+#define WF_PSE_TOP_QUEUE_EMPTY_RLS_Q_EMTPY_SHFT                31
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_RXIOC1_QUEUE_EMPTY_ADDR     WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_RXIOC1_QUEUE_EMPTY_MASK     0x08000000 /* MDP_RXIOC1_QE[27] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_RXIOC1_QUEUE_EMPTY_SHFT     27
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TXIOC1_QUEUE_EMPTY_ADDR     WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TXIOC1_QUEUE_EMPTY_MASK     0x04000000 /* MDP_TXIOC1_QE[26] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TXIOC1_QUEUE_EMPTY_SHFT     26
+#define WF_PSE_TOP_QUEUE_EMPTY_SEC_TX1_QUEUE_EMPTY_ADDR        WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_SEC_TX1_QUEUE_EMPTY_MASK        0x02000000 /* SEC_TX1_QE[25] */
+#define WF_PSE_TOP_QUEUE_EMPTY_SEC_TX1_QUEUE_EMPTY_SHFT        25
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TX1_QUEUE_EMPTY_ADDR        WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TX1_QUEUE_EMPTY_MASK        0x01000000 /* MDP_TX1_QE[24] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TX1_QUEUE_EMPTY_SHFT        24
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_RXIOC_QUEUE_EMPTY_ADDR      WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_RXIOC_QUEUE_EMPTY_MASK      0x00800000 /* MDP_RXIOC_QE[23] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_RXIOC_QUEUE_EMPTY_SHFT      23
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TXIOC_QUEUE_EMPTY_ADDR      WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TXIOC_QUEUE_EMPTY_MASK      0x00400000 /* MDP_TXIOC_QE[22] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TXIOC_QUEUE_EMPTY_SHFT      22
+#define WF_PSE_TOP_QUEUE_EMPTY_SFD_PARK_QUEUE_EMPTY_ADDR       WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_SFD_PARK_QUEUE_EMPTY_MASK       0x00200000 /* SFD_PARK_QE[21] */
+#define WF_PSE_TOP_QUEUE_EMPTY_SFD_PARK_QUEUE_EMPTY_SHFT       21
+#define WF_PSE_TOP_QUEUE_EMPTY_SEC_RX_QUEUE_EMPTY_ADDR         WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_SEC_RX_QUEUE_EMPTY_MASK         0x00100000 /* SEC_RX_QE[20] */
+#define WF_PSE_TOP_QUEUE_EMPTY_SEC_RX_QUEUE_EMPTY_SHFT         20
+#define WF_PSE_TOP_QUEUE_EMPTY_SEC_TX_QUEUE_EMPTY_ADDR         WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_SEC_TX_QUEUE_EMPTY_MASK         0x00080000 /* SEC_TX_QE[19] */
+#define WF_PSE_TOP_QUEUE_EMPTY_SEC_TX_QUEUE_EMPTY_SHFT         19
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_RX_QUEUE_EMPTY_ADDR         WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_RX_QUEUE_EMPTY_MASK         0x00040000 /* MDP_RX_QE[18] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_RX_QUEUE_EMPTY_SHFT         18
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TX_QUEUE_EMPTY_ADDR         WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TX_QUEUE_EMPTY_MASK         0x00020000 /* MDP_TX_QE[17] */
+#define WF_PSE_TOP_QUEUE_EMPTY_MDP_TX_QUEUE_EMPTY_SHFT         17
+#define WF_PSE_TOP_QUEUE_EMPTY_LMAC_TX_QUEUE_EMPTY_ADDR        WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_LMAC_TX_QUEUE_EMPTY_MASK        0x00010000 /* LMAC_TX_QE[16] */
+#define WF_PSE_TOP_QUEUE_EMPTY_LMAC_TX_QUEUE_EMPTY_SHFT        16
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_6_EMPTY_ADDR                WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_6_EMPTY_MASK                0x00004000 /* HIF_6_EMPTY[14] */
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_6_EMPTY_SHFT                14
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_5_EMPTY_ADDR                WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_5_EMPTY_MASK                0x00002000 /* HIF_5_EMPTY[13] */
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_5_EMPTY_SHFT                13
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_4_EMPTY_ADDR                WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_4_EMPTY_MASK                0x00001000 /* HIF_4_EMPTY[12] */
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_4_EMPTY_SHFT                12
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_3_EMPTY_ADDR                WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_3_EMPTY_MASK                0x00000800 /* HIF_3_EMPTY[11] */
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_3_EMPTY_SHFT                11
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_2_EMPTY_ADDR                WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_2_EMPTY_MASK                0x00000400 /* HIF_2_EMPTY[10] */
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_2_EMPTY_SHFT                10
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_1_EMPTY_ADDR                WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_1_EMPTY_MASK                0x00000200 /* HIF_1_EMPTY[9] */
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_1_EMPTY_SHFT                9
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_0_EMPTY_ADDR                WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_0_EMPTY_MASK                0x00000100 /* HIF_0_EMPTY[8] */
+#define WF_PSE_TOP_QUEUE_EMPTY_HIF_0_EMPTY_SHFT                8
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q3_EMPTY_ADDR               WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q3_EMPTY_MASK               0x00000008 /* CPU_Q3_EMPTY[3] */
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q3_EMPTY_SHFT               3
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q2_EMPTY_ADDR               WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q2_EMPTY_MASK               0x00000004 /* CPU_Q2_EMPTY[2] */
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q2_EMPTY_SHFT               2
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q1_EMPTY_ADDR               WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q1_EMPTY_MASK               0x00000002 /* CPU_Q1_EMPTY[1] */
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q1_EMPTY_SHFT               1
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q0_EMPTY_ADDR               WF_PSE_TOP_QUEUE_EMPTY_ADDR
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q0_EMPTY_MASK               0x00000001 /* CPU_Q0_EMPTY[0] */
+#define WF_PSE_TOP_QUEUE_EMPTY_CPU_Q0_EMPTY_SHFT               0
+
+#define WF_PSE_TOP_FL_QUE_CTRL_0_EXECUTE_ADDR         WF_PSE_TOP_FL_QUE_CTRL_0_ADDR
+#define WF_PSE_TOP_FL_QUE_CTRL_0_EXECUTE_MASK         0x80000000 /* EXECUTE[31] */
+#define WF_PSE_TOP_FL_QUE_CTRL_0_EXECUTE_SHFT         31
+#define WF_PSE_TOP_FL_QUE_CTRL_0_Q_BUF_QID_ADDR       WF_PSE_TOP_FL_QUE_CTRL_0_ADDR
+#define WF_PSE_TOP_FL_QUE_CTRL_0_Q_BUF_QID_MASK       0x7F000000 /* Q_BUF_QID[30..24] */
+#define WF_PSE_TOP_FL_QUE_CTRL_0_Q_BUF_QID_SHFT       24
+#define WF_PSE_TOP_FL_QUE_CTRL_0_FL_BUFFER_ADDR_ADDR  WF_PSE_TOP_FL_QUE_CTRL_0_ADDR
+#define WF_PSE_TOP_FL_QUE_CTRL_0_FL_BUFFER_ADDR_MASK  0x00FFF000 /* FL_BUFFER_ADDR[23..12] */
+#define WF_PSE_TOP_FL_QUE_CTRL_0_FL_BUFFER_ADDR_SHFT  12
+#define WF_PSE_TOP_FL_QUE_CTRL_0_Q_BUF_PID_ADDR       WF_PSE_TOP_FL_QUE_CTRL_0_ADDR
+#define WF_PSE_TOP_FL_QUE_CTRL_0_Q_BUF_PID_MASK       0x00000C00 /* Q_BUF_PID[11..10] */
+#define WF_PSE_TOP_FL_QUE_CTRL_0_Q_BUF_PID_SHFT       10
+#define WF_PSE_TOP_FL_QUE_CTRL_0_Q_BUF_WLANID_ADDR    WF_PSE_TOP_FL_QUE_CTRL_0_ADDR
+#define WF_PSE_TOP_FL_QUE_CTRL_0_Q_BUF_WLANID_MASK    0x000003FF /* Q_BUF_WLANID[9..0] */
+#define WF_PSE_TOP_FL_QUE_CTRL_0_Q_BUF_WLANID_SHFT    0
+
+#define WF_PSE_TOP_FL_QUE_CTRL_2_QUEUE_TAIL_FID_ADDR  WF_PSE_TOP_FL_QUE_CTRL_2_ADDR
+#define WF_PSE_TOP_FL_QUE_CTRL_2_QUEUE_TAIL_FID_MASK  0x0FFF0000 /* QUEUE_TAIL_FID[27..16] */
+#define WF_PSE_TOP_FL_QUE_CTRL_2_QUEUE_TAIL_FID_SHFT  16
+#define WF_PSE_TOP_FL_QUE_CTRL_2_QUEUE_HEAD_FID_ADDR  WF_PSE_TOP_FL_QUE_CTRL_2_ADDR
+#define WF_PSE_TOP_FL_QUE_CTRL_2_QUEUE_HEAD_FID_MASK  0x00000FFF /* QUEUE_HEAD_FID[11..0] */
+#define WF_PSE_TOP_FL_QUE_CTRL_2_QUEUE_HEAD_FID_SHFT  0
+
+#define WF_PSE_TOP_FL_QUE_CTRL_3_QUEUE_PAGE_NUM_ADDR  WF_PSE_TOP_FL_QUE_CTRL_3_ADDR
+#define WF_PSE_TOP_FL_QUE_CTRL_3_QUEUE_PAGE_NUM_MASK  0x00FFF000 /* QUEUE_PAGE_NUM[23..12] */
+#define WF_PSE_TOP_FL_QUE_CTRL_3_QUEUE_PAGE_NUM_SHFT  12
+#define WF_PSE_TOP_FL_QUE_CTRL_3_QUEUE_PKT_NUM_ADDR   WF_PSE_TOP_FL_QUE_CTRL_3_ADDR
+#define WF_PSE_TOP_FL_QUE_CTRL_3_QUEUE_PKT_NUM_MASK   0x00000FFF /* QUEUE_PKT_NUM[11..0] */
+#define WF_PSE_TOP_FL_QUE_CTRL_3_QUEUE_PKT_NUM_SHFT   0
+
 #endif
-- 
2.20.1

