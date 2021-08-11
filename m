Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365543E9A8D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhHKVqL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:46:11 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:59024 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232340AbhHKVpq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:46 -0400
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 03E4A24AE53
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:45:15 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.174])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D5A702A0074
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9474F7C0066
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 264F913C2B7;
        Wed, 11 Aug 2021 14:44:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 264F913C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718292;
        bh=u4FuozJ3VYZ/a0gbpy61HDSMBNrkER+K0ed0WYjSpSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VphCmOzeCjpla+9Nex7MRjhvXwvj9VMRgYyYJF0tKYN5rv/35h5b2aikaE5YWorxa
         MkNxUAVJRUiLiXH3Aj7Ng3AYLrnil7vFL3nxvcFLtcgx+fSFMfngdSRegbY6lvkIer
         caNv7FZtRMBi6PHouV5V37I26ots47saeEzvTWY4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 12/15] mt76: mt7915: add more pse queue data to debugfs
Date:   Wed, 11 Aug 2021 14:44:36 -0700
Message-Id: <20210811214439.17458-13-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718293-kG6eqIdbfl9V
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This may provide some clues in case rx packet drops are suspected.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 111 ++++++++
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 246 +++++++++++++++++-
 2 files changed, 356 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 5c6a75f45f8f..9786fb9d7f73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -546,9 +546,120 @@ mt7915_pse_q_nonempty_stat_read_phy(struct mt7915_phy *phy,
 	struct mt7915_dev *dev = file->private;
 	u32 pse_stat;
 	int i;
+	u32 pg_flow_ctrl[22] = {0};
+	u32 fpg_cnt, ffa_cnt, fpg_head, fpg_tail;
+	u32 max_q, min_q, rsv_pg, used_pg;
+	u32 pse_buf_ctrl, pg_sz, pg_num;
+
 
 	pse_stat = mt76_rr(dev, WF_PSE_TOP_QUEUE_EMPTY_ADDR);
 
+	pse_buf_ctrl = mt76_rr(dev, WF_PSE_TOP_PBUF_CTRL_ADDR);
+	pg_flow_ctrl[0] = mt76_rr(dev, WF_PSE_TOP_FREEPG_CNT_ADDR);
+	pg_flow_ctrl[1] = mt76_rr(dev, WF_PSE_TOP_FREEPG_HEAD_TAIL_ADDR);
+	pg_flow_ctrl[2] = mt76_rr(dev, WF_PSE_TOP_PG_HIF0_GROUP_ADDR);
+	pg_flow_ctrl[3] = mt76_rr(dev, WF_PSE_TOP_HIF0_PG_INFO_ADDR);
+	pg_flow_ctrl[4] = mt76_rr(dev, WF_PSE_TOP_PG_HIF1_GROUP_ADDR);
+	pg_flow_ctrl[5] = mt76_rr(dev, WF_PSE_TOP_HIF1_PG_INFO_ADDR);
+	pg_flow_ctrl[6] = mt76_rr(dev, WF_PSE_TOP_PG_CPU_GROUP_ADDR);
+	pg_flow_ctrl[7] = mt76_rr(dev, WF_PSE_TOP_CPU_PG_INFO_ADDR);
+	pg_flow_ctrl[8] = mt76_rr(dev, WF_PSE_TOP_PG_LMAC0_GROUP_ADDR);
+	pg_flow_ctrl[9] = mt76_rr(dev, WF_PSE_TOP_LMAC0_PG_INFO_ADDR);
+	pg_flow_ctrl[10] = mt76_rr(dev, WF_PSE_TOP_PG_LMAC1_GROUP_ADDR);
+	pg_flow_ctrl[11] = mt76_rr(dev, WF_PSE_TOP_LMAC1_PG_INFO_ADDR);
+	pg_flow_ctrl[12] = mt76_rr(dev, WF_PSE_TOP_PG_LMAC2_GROUP_ADDR);
+	pg_flow_ctrl[13] = mt76_rr(dev, WF_PSE_TOP_LMAC2_PG_INFO_ADDR);
+	pg_flow_ctrl[14] = mt76_rr(dev, WF_PSE_TOP_PG_PLE_GROUP_ADDR);
+	pg_flow_ctrl[15] = mt76_rr(dev, WF_PSE_TOP_PLE_PG_INFO_ADDR);
+	pg_flow_ctrl[16] = mt76_rr(dev, WF_PSE_TOP_PG_LMAC3_GROUP_ADDR);
+	pg_flow_ctrl[17] = mt76_rr(dev, WF_PSE_TOP_LMAC3_PG_INFO_ADDR);
+	pg_flow_ctrl[18] = mt76_rr(dev, WF_PSE_TOP_PG_MDP_GROUP_ADDR);
+	pg_flow_ctrl[19] = mt76_rr(dev, WF_PSE_TOP_MDP_PG_INFO_ADDR);
+	pg_flow_ctrl[20] = mt76_rr(dev, WF_PSE_TOP_PG_PLE1_GROUP_ADDR);
+	pg_flow_ctrl[21] = mt76_rr(dev, WF_PSE_TOP_PLE1_PG_INFO_ADDR);
+
+	seq_puts(file, "PSE Configuration Info:\n");
+	seq_printf(file, "\tPacket Buffer Control: 0x%08x\n", pse_buf_ctrl);
+
+	pg_sz = (pse_buf_ctrl & WF_PSE_TOP_PBUF_CTRL_PAGE_SIZE_CFG_MASK)
+		>> WF_PSE_TOP_PBUF_CTRL_PAGE_SIZE_CFG_SHFT;
+	seq_printf(file, "\t\tPage Size:   %d(%d bytes per page)\n",
+		   pg_sz, (pg_sz == 1 ? 256 : 128));
+	seq_printf(file, "\t\tPage Offset: %d(in unit of 64KB)\n",
+		   (pse_buf_ctrl & WF_PSE_TOP_PBUF_CTRL_PBUF_OFFSET_MASK)
+		   >> WF_PSE_TOP_PBUF_CTRL_PBUF_OFFSET_SHFT);
+	pg_num = (pse_buf_ctrl & WF_PSE_TOP_PBUF_CTRL_TOTAL_PAGE_NUM_MASK)
+		>> WF_PSE_TOP_PBUF_CTRL_TOTAL_PAGE_NUM_SHFT;
+	seq_printf(file, "\t\tTotal page numbers: %d pages\n", pg_num);
+
+	/* Page Flow Control */
+	seq_puts(file, "PSE Page Flow Control:\n");
+	seq_printf(file, "\tFree page counter: 0x%08x\n", pg_flow_ctrl[0]);
+	fpg_cnt = (pg_flow_ctrl[0] & WF_PSE_TOP_FREEPG_CNT_FREEPG_CNT_MASK)
+		>> WF_PSE_TOP_FREEPG_CNT_FREEPG_CNT_SHFT;
+	seq_printf(file, "\t\tThe toal page number of free: 0x%03x\n", fpg_cnt);
+	ffa_cnt = (pg_flow_ctrl[0] & WF_PSE_TOP_FREEPG_CNT_FFA_CNT_MASK)
+		>> WF_PSE_TOP_FREEPG_CNT_FFA_CNT_SHFT;
+	seq_printf(file, "\t\tThe free page numbers of free for all: 0x%03x\n",
+		   ffa_cnt);
+	seq_printf(file, "\tFree page head and tail: 0x%08x\n", pg_flow_ctrl[1]);
+	fpg_head = (pg_flow_ctrl[1] & WF_PSE_TOP_FREEPG_HEAD_TAIL_FREEPG_HEAD_MASK)
+		>> WF_PSE_TOP_FREEPG_HEAD_TAIL_FREEPG_HEAD_SHFT;
+	fpg_tail = (pg_flow_ctrl[1] & WF_PSE_TOP_FREEPG_HEAD_TAIL_FREEPG_TAIL_MASK)
+		>> WF_PSE_TOP_FREEPG_HEAD_TAIL_FREEPG_TAIL_SHFT;
+	seq_printf(file, "\t\tThe tail/head page of free page list: 0x%03x/0x%03x\n",
+		   fpg_tail, fpg_head);
+
+#define MT7915_MMQ(idx, type, text)					\
+	do {                                                            \
+		int i2 = (idx);						\
+									\
+		min_q = (pg_flow_ctrl[i2] & type##_MIN_QUOTA_MASK)	\
+			>> type##_MIN_QUOTA_SHFT;                       \
+		max_q = (pg_flow_ctrl[i2] & type##_MAX_QUOTA_MASK)	\
+			>> type##_MAX_QUOTA_SHFT;                       \
+		seq_printf(file, "\t\t%s: %d/%d\n",			\
+			   text, max_q, min_q);				\
+	} while (false)
+
+#define MT7915_RSQ(idx, type, text)					\
+	do {                                                            \
+		int i3 = (idx);						\
+									\
+		rsv_pg = (pg_flow_ctrl[i3] & type##_RSV_CNT_MASK)	\
+			>> type##_RSV_CNT_SHFT;                         \
+		used_pg = (pg_flow_ctrl[i3] & type##_SRC_CNT_MASK)	\
+			>> type##_SRC_CNT_SHFT;                         \
+		seq_printf(file, "\t\t%s: %d/%d\n",			\
+			   text, used_pg, rsv_pg);			\
+	} while (false)
+
+#define MT7915_MMQ_RSQ(idx, type)					\
+	do {                                                            \
+		int i4 = (idx);						\
+									\
+		seq_printf(file, "\tReserved page counter of "          \
+			   #type " group: 0x%08x\n",			\
+			   pg_flow_ctrl[i4]);				\
+		seq_printf(file, "\t" #type " group page status: 0x%08x\n", \
+			   pg_flow_ctrl[i4 + 1]);			\
+		MT7915_MMQ(i4, WF_PSE_TOP_PG_##type##_GROUP_##type,	\
+			   "The max/min quota pages of " #type " group"); \
+		MT7915_RSQ(i4 + 1, WF_PSE_TOP_##type##_PG_INFO_##type, \
+			   "The used/reserved pages of " #type " group"); \
+	} while (false)
+
+	MT7915_MMQ_RSQ(2, HIF0);
+	MT7915_MMQ_RSQ(4, HIF1);
+	MT7915_MMQ_RSQ(6, CPU);
+	MT7915_MMQ_RSQ(8, LMAC0);
+	MT7915_MMQ_RSQ(10, LMAC1);
+	MT7915_MMQ_RSQ(12, LMAC2);
+	MT7915_MMQ_RSQ(16, LMAC3);
+	MT7915_MMQ_RSQ(14, PLE);
+	MT7915_MMQ_RSQ(20, PLE1);
+	MT7915_MMQ_RSQ(18, MDP);
+
 	/* Queue Empty Status */
 	seq_puts(file, "PSE Queue Empty Status:\n");
 	seq_printf(file, "\tQUEUE_EMPTY: 0x%08x\n", pse_stat);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 1e3ce90ff3dd..0bd911075aa9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -634,13 +634,257 @@ enum _ENUM_UMAC_PLE_CTRL_P3_QUEUE {
 
 #define WF_PSE_TOP_BASE                                        0x820C8000
 
+#define WF_PSE_TOP_GC_ADDR                                     (WF_PSE_TOP_BASE + 0x00) /* 8000 */
+#define WF_PSE_TOP_PBUF_CTRL_ADDR                              (WF_PSE_TOP_BASE + 0x14) /* 8014 */
+#define WF_PSE_TOP_INT_N9_EN_MASK_ADDR                         (WF_PSE_TOP_BASE + 0x20) /* 8020 */
+#define WF_PSE_TOP_INT_N9_STS_ADDR                             (WF_PSE_TOP_BASE + 0x24) /* 8024 */
+#define WF_PSE_TOP_INT_N9_ERR_STS_ADDR                         (WF_PSE_TOP_BASE + 0x28) /* 8028 */
+#define WF_PSE_TOP_INT_N9_ERR_MASK_ADDR                        (WF_PSE_TOP_BASE + 0x2C) /* 802C */
+#define WF_PSE_TOP_INT_N9_ERR1_STS_ADDR                        (WF_PSE_TOP_BASE + 0x30) /* 8030 */
+#define WF_PSE_TOP_INT_N9_ERR1_MASK_ADDR                       (WF_PSE_TOP_BASE + 0x34) /* 8034 */
+#define WF_PSE_TOP_C_GET_FID_0_ADDR                            (WF_PSE_TOP_BASE + 0x40) /* 8040 */
+#define WF_PSE_TOP_C_GET_FID_1_ADDR                            (WF_PSE_TOP_BASE + 0x44) /* 8044 */
+#define WF_PSE_TOP_C_EN_QUEUE_0_ADDR                           (WF_PSE_TOP_BASE + 0x60) /* 8060 */
+#define WF_PSE_TOP_C_EN_QUEUE_1_ADDR                           (WF_PSE_TOP_BASE + 0x64) /* 8064 */
+#define WF_PSE_TOP_C_EN_QUEUE_2_ADDR                           (WF_PSE_TOP_BASE + 0x68) /* 8068 */
+#define WF_PSE_TOP_C_DE_QUEUE_0_ADDR                           (WF_PSE_TOP_BASE + 0x80) /* 8080 */
+#define WF_PSE_TOP_C_DE_QUEUE_1_ADDR                           (WF_PSE_TOP_BASE + 0x84) /* 8084 */
+#define WF_PSE_TOP_C_DE_QUEUE_2_ADDR                           (WF_PSE_TOP_BASE + 0x88) /* 8088 */
+#define WF_PSE_TOP_C_DE_QUEUE_3_ADDR                           (WF_PSE_TOP_BASE + 0x8c) /* 808C */
+#define WF_PSE_TOP_C_DE_QUEUE_4_ADDR                           (WF_PSE_TOP_BASE + 0x90) /* 8090 */
+#define WF_PSE_TOP_ALLOCATE_0_ADDR                             (WF_PSE_TOP_BASE + 0xA0) /* 80A0 */
+#define WF_PSE_TOP_ALLOCATE_1_ADDR                             (WF_PSE_TOP_BASE + 0xA4) /* 80A4 */
 #define WF_PSE_TOP_QUEUE_EMPTY_ADDR                            (WF_PSE_TOP_BASE + 0xB0) /* 80B0 */
 #define WF_PSE_TOP_QUEUE_EMPTY_MASK_ADDR                       (WF_PSE_TOP_BASE + 0xB4) /* 80B4 */
-
+#define WF_PSE_TOP_FREEPG_START_END_ADDR                       (WF_PSE_TOP_BASE + 0xC0) /* 80C0 */
+#define WF_PSE_TOP_PSE_MODULE_CKG_DIS_ADDR                     (WF_PSE_TOP_BASE + 0xc4) /* 80C4 */
+#define WF_PSE_TOP_TO_N9_INT_ADDR                              (WF_PSE_TOP_BASE + 0xf0) /* 80F0 */
+#define WF_PSE_TOP_FREEPG_CNT_ADDR                             (WF_PSE_TOP_BASE + 0x100) /* 8100 */
+#define WF_PSE_TOP_FREEPG_HEAD_TAIL_ADDR                       (WF_PSE_TOP_BASE + 0x104) /* 8104 */
+#define WF_PSE_TOP_GROUP_REFILL_CTRL_ADDR                      (WF_PSE_TOP_BASE + 0x108) /* 8108 */
+#define WF_PSE_TOP_PG_HIF0_GROUP_ADDR                          (WF_PSE_TOP_BASE + 0x110) /* 8110 */
+#define WF_PSE_TOP_HIF0_PG_INFO_ADDR                           (WF_PSE_TOP_BASE + 0x114) /* 8114 */
+#define WF_PSE_TOP_PG_HIF1_GROUP_ADDR                          (WF_PSE_TOP_BASE + 0x118) /* 8118 */
+#define WF_PSE_TOP_HIF1_PG_INFO_ADDR                           (WF_PSE_TOP_BASE + 0x11C) /* 811C */
+#define WF_PSE_TOP_PG_CPU_GROUP_ADDR                           (WF_PSE_TOP_BASE + 0x150) /* 8150 */
+#define WF_PSE_TOP_CPU_PG_INFO_ADDR                            (WF_PSE_TOP_BASE + 0x154) /* 8154 */
+#define WF_PSE_TOP_PG_PLE_GROUP_ADDR                           (WF_PSE_TOP_BASE + 0x160) /* 8160 */
+#define WF_PSE_TOP_PLE_PG_INFO_ADDR                            (WF_PSE_TOP_BASE + 0x164) /* 8164 */
+#define WF_PSE_TOP_PG_PLE1_GROUP_ADDR                          (WF_PSE_TOP_BASE + 0x168) /* 8168 */
+#define WF_PSE_TOP_PLE1_PG_INFO_ADDR                           (WF_PSE_TOP_BASE + 0x16C) /* 816C */
+#define WF_PSE_TOP_PG_LMAC0_GROUP_ADDR                         (WF_PSE_TOP_BASE + 0x170) /* 8170 */
+#define WF_PSE_TOP_LMAC0_PG_INFO_ADDR                          (WF_PSE_TOP_BASE + 0x174) /* 8174 */
+#define WF_PSE_TOP_PG_LMAC1_GROUP_ADDR                         (WF_PSE_TOP_BASE + 0x178) /* 8178 */
+#define WF_PSE_TOP_LMAC1_PG_INFO_ADDR                          (WF_PSE_TOP_BASE + 0x17C) /* 817C */
+#define WF_PSE_TOP_PG_LMAC2_GROUP_ADDR                         (WF_PSE_TOP_BASE + 0x180) /* 8180 */
+#define WF_PSE_TOP_LMAC2_PG_INFO_ADDR                          (WF_PSE_TOP_BASE + 0x184) /* 8184 */
+#define WF_PSE_TOP_PG_LMAC3_GROUP_ADDR                         (WF_PSE_TOP_BASE + 0x188) /* 8188 */
+#define WF_PSE_TOP_LMAC3_PG_INFO_ADDR                          (WF_PSE_TOP_BASE + 0x18C) /* 818C */
+#define WF_PSE_TOP_PG_MDP_GROUP_ADDR                           (WF_PSE_TOP_BASE + 0x198) /* 8198 */
+#define WF_PSE_TOP_MDP_PG_INFO_ADDR                            (WF_PSE_TOP_BASE + 0x19C) /* 819C */
+#define WF_PSE_TOP_RL_BUF_CTRL_0_ADDR                          (WF_PSE_TOP_BASE + 0x1A0) /* 81A0 */
+#define WF_PSE_TOP_RL_BUF_CTRL_1_ADDR                          (WF_PSE_TOP_BASE + 0x1A4) /* 81A4 */
 #define WF_PSE_TOP_FL_QUE_CTRL_0_ADDR                          (WF_PSE_TOP_BASE + 0x1B0) /* 81B0 */
 #define WF_PSE_TOP_FL_QUE_CTRL_1_ADDR                          (WF_PSE_TOP_BASE + 0x1B4) /* 81B4 */
 #define WF_PSE_TOP_FL_QUE_CTRL_2_ADDR                          (WF_PSE_TOP_BASE + 0x1B8) /* 81B8 */
 #define WF_PSE_TOP_FL_QUE_CTRL_3_ADDR                          (WF_PSE_TOP_BASE + 0x1BC) /* 81BC */
+#define WF_PSE_TOP_PL_QUE_CTRL_0_ADDR                          (WF_PSE_TOP_BASE + 0x1C0) /* 81C0 */
+#define WF_PSE_TOP_PSE_LP_CTRL_ADDR                            (WF_PSE_TOP_BASE + 0x1D0) /* 81D0 */
+#define WF_PSE_TOP_PSE_WFDMA_BUF_CTRL_ADDR                     (WF_PSE_TOP_BASE + 0x1E0) /* 81E0 */
+#define WF_PSE_TOP_PSE_CT_PRI_CTRL_ADDR                        (WF_PSE_TOP_BASE + 0x1EC) /* 81EC */
+#define WF_PSE_TOP_PLE_ENQ_PKT_NUM_ADDR                        (WF_PSE_TOP_BASE + 0x1F0) /* 81F0 */
+#define WF_PSE_TOP_CPU_ENQ_PKT_NUM_ADDR                        (WF_PSE_TOP_BASE + 0x1F4) /* 81F4 */
+#define WF_PSE_TOP_LMAC_ENQ_PKT_NUM_ADDR                       (WF_PSE_TOP_BASE + 0x1F8) /* 81F8 */
+#define WF_PSE_TOP_HIF_ENQ_PKT_NUM_ADDR                        (WF_PSE_TOP_BASE + 0x1FC) /* 81FC */
+#define WF_PSE_TOP_MDP_ENQ_PKT_NUM_ADDR                        (WF_PSE_TOP_BASE + 0x200) /* 8200 */
+#define WF_PSE_TOP_TIMEOUT_CTRL_ADDR                           (WF_PSE_TOP_BASE + 0x244) /* 8244 */
+#define WF_PSE_TOP_FSM_IDLE_WD_CTRL_ADDR                       (WF_PSE_TOP_BASE + 0x24C) /* 824C */
+#define WF_PSE_TOP_FSM_IDLE_WD_EN_ADDR                         (WF_PSE_TOP_BASE + 0x250) /* 8250 */
+#define WF_PSE_TOP_PSE_INTER_ERR_FLAG_ADDR                     (WF_PSE_TOP_BASE + 0x280) /* 8280 */
+#define WF_PSE_TOP_PSE_SER_CTRL_ADDR                           (WF_PSE_TOP_BASE + 0x2a0) /* 82A0 */
+#define WF_PSE_TOP_PSE_MBIST_RP_FUSE_ADDR                      (WF_PSE_TOP_BASE + 0x2b0) /* 82B0 */
+#define WF_PSE_TOP_PSE_MBIST_BSEL_ADDR                         (WF_PSE_TOP_BASE + 0x2b4) /* 82B4 */
+#define WF_PSE_TOP_SRAM_MBIST_BACKGROUND_ADDR                  (WF_PSE_TOP_BASE + 0x2d0) /* 82D0 */
+#define WF_PSE_TOP_PSE_MISC_FUNC_CTRL_ADDR                     (WF_PSE_TOP_BASE + 0x2d4) /* 82D4 */
+#define WF_PSE_TOP_SRAM_MBIST_DONE_ADDR                        (WF_PSE_TOP_BASE + 0x2d8) /* 82D8 */
+#define WF_PSE_TOP_SRAM_MBIST_FAIL_ADDR                        (WF_PSE_TOP_BASE + 0x2dc) /* 82DC */
+#define WF_PSE_TOP_SRAM_MBIST_CTRL_ADDR                        (WF_PSE_TOP_BASE + 0x2e0) /* 82E0 */
+#define WF_PSE_TOP_SRAM_MBIST_DELSEL_ADDR                      (WF_PSE_TOP_BASE + 0x2e4) /* 82E4 */
+#define WF_PSE_TOP_SRAM_AWT_HDEN_CTRL_ADDR                     (WF_PSE_TOP_BASE + 0x2e8) /* 82E8 */
+#define WF_PSE_TOP_PSE_SEEK_CR_00_ADDR                         (WF_PSE_TOP_BASE + 0x3d0) /* 83D0 */
+#define WF_PSE_TOP_PSE_SEEK_CR_01_ADDR                         (WF_PSE_TOP_BASE + 0x3d4) /* 83D4 */
+#define WF_PSE_TOP_PSE_SEEK_CR_02_ADDR                         (WF_PSE_TOP_BASE + 0x3d8) /* 83D8 */
+#define WF_PSE_TOP_PSE_SEEK_CR_03_ADDR                         (WF_PSE_TOP_BASE + 0x3dc) /* 83DC */
+#define WF_PSE_TOP_PSE_SEEK_CR_04_ADDR                         (WF_PSE_TOP_BASE + 0x3e0) /* 83E0 */
+#define WF_PSE_TOP_PSE_SEEK_CR_05_ADDR                         (WF_PSE_TOP_BASE + 0x3e4) /* 83E4 */
+#define WF_PSE_TOP_PSE_SEEK_CR_06_ADDR                         (WF_PSE_TOP_BASE + 0x3e8) /* 83E8 */
+#define WF_PSE_TOP_PSE_SEEK_CR_07_ADDR                         (WF_PSE_TOP_BASE + 0x3ec) /* 83EC */
+#define WF_PSE_TOP_PSE_SEEK_CR_08_ADDR                         (WF_PSE_TOP_BASE + 0x3f0) /* 83F0 */
+#define WF_PSE_TOP_PSE_SEEK_CR_09_ADDR                         (WF_PSE_TOP_BASE + 0x3f4) /* 83F4 */
+
+#define WF_PSE_TOP_PBUF_CTRL_PAGE_SIZE_CFG_ADDR    WF_PSE_TOP_PBUF_CTRL_ADDR
+#define WF_PSE_TOP_PBUF_CTRL_PAGE_SIZE_CFG_MASK    0x80000000   /* PAGE_SIZE_CFG[31] */
+#define WF_PSE_TOP_PBUF_CTRL_PAGE_SIZE_CFG_SHFT    31
+#define WF_PSE_TOP_PBUF_CTRL_PBUF_OFFSET_ADDR      WF_PSE_TOP_PBUF_CTRL_ADDR
+#define WF_PSE_TOP_PBUF_CTRL_PBUF_OFFSET_MASK      0x03FE0000   /* PBUF_OFFSET[25..17] */
+#define WF_PSE_TOP_PBUF_CTRL_PBUF_OFFSET_SHFT      17
+#define WF_PSE_TOP_PBUF_CTRL_TOTAL_PAGE_NUM_ADDR   WF_PSE_TOP_PBUF_CTRL_ADDR
+#define WF_PSE_TOP_PBUF_CTRL_TOTAL_PAGE_NUM_MASK   0x00000FFF   /* TOTAL_PAGE_NUM[11..0] */
+#define WF_PSE_TOP_PBUF_CTRL_TOTAL_PAGE_NUM_SHFT   0
+
+#define WF_PSE_TOP_FREEPG_CNT_FFA_CNT_ADDR         WF_PSE_TOP_FREEPG_CNT_ADDR
+#define WF_PSE_TOP_FREEPG_CNT_FFA_CNT_MASK         0x0FFF0000   /* FFA_CNT[27..16] */
+#define WF_PSE_TOP_FREEPG_CNT_FFA_CNT_SHFT         16
+#define WF_PSE_TOP_FREEPG_CNT_FREEPG_CNT_ADDR      WF_PSE_TOP_FREEPG_CNT_ADDR
+#define WF_PSE_TOP_FREEPG_CNT_FREEPG_CNT_MASK      0x00000FFF   /* FREEPG_CNT[11..0] */
+#define WF_PSE_TOP_FREEPG_CNT_FREEPG_CNT_SHFT      0
+
+#define WF_PSE_TOP_FREEPG_HEAD_TAIL_FREEPG_TAIL_ADDR  WF_PSE_TOP_FREEPG_HEAD_TAIL_ADDR
+#define WF_PSE_TOP_FREEPG_HEAD_TAIL_FREEPG_TAIL_MASK  0x0FFF0000  /* FREEPG_TAIL[27..16] */
+#define WF_PSE_TOP_FREEPG_HEAD_TAIL_FREEPG_TAIL_SHFT  16
+#define WF_PSE_TOP_FREEPG_HEAD_TAIL_FREEPG_HEAD_ADDR  WF_PSE_TOP_FREEPG_HEAD_TAIL_ADDR
+#define WF_PSE_TOP_FREEPG_HEAD_TAIL_FREEPG_HEAD_MASK  0x00000FFF  /* FREEPG_HEAD[11..0] */
+#define WF_PSE_TOP_FREEPG_HEAD_TAIL_FREEPG_HEAD_SHFT  0
+
+#define WF_PSE_TOP_PG_HIF0_GROUP_HIF0_MAX_QUOTA_ADDR  WF_PSE_TOP_PG_HIF0_GROUP_ADDR
+#define WF_PSE_TOP_PG_HIF0_GROUP_HIF0_MAX_QUOTA_MASK  0x0FFF0000  /* HIF0_MAX_QUOTA[27..16] */
+#define WF_PSE_TOP_PG_HIF0_GROUP_HIF0_MAX_QUOTA_SHFT  16
+#define WF_PSE_TOP_PG_HIF0_GROUP_HIF0_MIN_QUOTA_ADDR  WF_PSE_TOP_PG_HIF0_GROUP_ADDR
+#define WF_PSE_TOP_PG_HIF0_GROUP_HIF0_MIN_QUOTA_MASK  0x00000FFF  /* HIF0_MIN_QUOTA[11..0] */
+#define WF_PSE_TOP_PG_HIF0_GROUP_HIF0_MIN_QUOTA_SHFT  0
+
+#define WF_PSE_TOP_HIF0_PG_INFO_HIF0_SRC_CNT_ADDR     WF_PSE_TOP_HIF0_PG_INFO_ADDR
+#define WF_PSE_TOP_HIF0_PG_INFO_HIF0_SRC_CNT_MASK     0x0FFF0000  /* HIF0_SRC_CNT[27..16] */
+#define WF_PSE_TOP_HIF0_PG_INFO_HIF0_SRC_CNT_SHFT     16
+#define WF_PSE_TOP_HIF0_PG_INFO_HIF0_RSV_CNT_ADDR     WF_PSE_TOP_HIF0_PG_INFO_ADDR
+#define WF_PSE_TOP_HIF0_PG_INFO_HIF0_RSV_CNT_MASK     0x00000FFF  /* HIF0_RSV_CNT[11..0] */
+#define WF_PSE_TOP_HIF0_PG_INFO_HIF0_RSV_CNT_SHFT     0
+
+#define WF_PSE_TOP_PG_HIF1_GROUP_HIF1_MAX_QUOTA_ADDR  WF_PSE_TOP_PG_HIF1_GROUP_ADDR
+#define WF_PSE_TOP_PG_HIF1_GROUP_HIF1_MAX_QUOTA_MASK  0x0FFF0000  /* HIF1_MAX_QUOTA[27..16] */
+#define WF_PSE_TOP_PG_HIF1_GROUP_HIF1_MAX_QUOTA_SHFT  16
+#define WF_PSE_TOP_PG_HIF1_GROUP_HIF1_MIN_QUOTA_ADDR  WF_PSE_TOP_PG_HIF1_GROUP_ADDR
+#define WF_PSE_TOP_PG_HIF1_GROUP_HIF1_MIN_QUOTA_MASK  0x00000FFF  /* HIF1_MIN_QUOTA[11..0] */
+#define WF_PSE_TOP_PG_HIF1_GROUP_HIF1_MIN_QUOTA_SHFT  0
+
+#define WF_PSE_TOP_HIF1_PG_INFO_HIF1_SRC_CNT_ADDR     WF_PSE_TOP_HIF1_PG_INFO_ADDR
+#define WF_PSE_TOP_HIF1_PG_INFO_HIF1_SRC_CNT_MASK     0x0FFF0000  /* HIF1_SRC_CNT[27..16] */
+#define WF_PSE_TOP_HIF1_PG_INFO_HIF1_SRC_CNT_SHFT     16
+#define WF_PSE_TOP_HIF1_PG_INFO_HIF1_RSV_CNT_ADDR     WF_PSE_TOP_HIF1_PG_INFO_ADDR
+#define WF_PSE_TOP_HIF1_PG_INFO_HIF1_RSV_CNT_MASK     0x00000FFF  /* HIF1_RSV_CNT[11..0] */
+#define WF_PSE_TOP_HIF1_PG_INFO_HIF1_RSV_CNT_SHFT     0
+
+#define WF_PSE_TOP_PG_CPU_GROUP_CPU_MAX_QUOTA_ADDR    WF_PSE_TOP_PG_CPU_GROUP_ADDR
+#define WF_PSE_TOP_PG_CPU_GROUP_CPU_MAX_QUOTA_MASK    0x0FFF0000  /* CPU_MAX_QUOTA[27..16] */
+#define WF_PSE_TOP_PG_CPU_GROUP_CPU_MAX_QUOTA_SHFT    16
+#define WF_PSE_TOP_PG_CPU_GROUP_CPU_MIN_QUOTA_ADDR    WF_PSE_TOP_PG_CPU_GROUP_ADDR
+#define WF_PSE_TOP_PG_CPU_GROUP_CPU_MIN_QUOTA_MASK    0x00000FFF  /* CPU_MIN_QUOTA[11..0] */
+#define WF_PSE_TOP_PG_CPU_GROUP_CPU_MIN_QUOTA_SHFT    0
+
+#define WF_PSE_TOP_CPU_PG_INFO_CPU_SRC_CNT_ADDR       WF_PSE_TOP_CPU_PG_INFO_ADDR
+#define WF_PSE_TOP_CPU_PG_INFO_CPU_SRC_CNT_MASK       0x0FFF0000  /* CPU_SRC_CNT[27..16] */
+#define WF_PSE_TOP_CPU_PG_INFO_CPU_SRC_CNT_SHFT       16
+#define WF_PSE_TOP_CPU_PG_INFO_CPU_RSV_CNT_ADDR       WF_PSE_TOP_CPU_PG_INFO_ADDR
+#define WF_PSE_TOP_CPU_PG_INFO_CPU_RSV_CNT_MASK       0x00000FFF  /* CPU_RSV_CNT[11..0] */
+#define WF_PSE_TOP_CPU_PG_INFO_CPU_RSV_CNT_SHFT       0
+
+#define WF_PSE_TOP_PG_PLE_GROUP_PLE_MAX_QUOTA_ADDR    WF_PSE_TOP_PG_PLE_GROUP_ADDR
+#define WF_PSE_TOP_PG_PLE_GROUP_PLE_MAX_QUOTA_MASK    0x0FFF0000  /* PLE_MAX_QUOTA[27..16] */
+#define WF_PSE_TOP_PG_PLE_GROUP_PLE_MAX_QUOTA_SHFT    16
+#define WF_PSE_TOP_PG_PLE_GROUP_PLE_MIN_QUOTA_ADDR    WF_PSE_TOP_PG_PLE_GROUP_ADDR
+#define WF_PSE_TOP_PG_PLE_GROUP_PLE_MIN_QUOTA_MASK    0x00000FFF  /* PLE_MIN_QUOTA[11..0] */
+#define WF_PSE_TOP_PG_PLE_GROUP_PLE_MIN_QUOTA_SHFT    0
+
+#define WF_PSE_TOP_PLE_PG_INFO_PLE_SRC_CNT_ADDR       WF_PSE_TOP_PLE_PG_INFO_ADDR
+#define WF_PSE_TOP_PLE_PG_INFO_PLE_SRC_CNT_MASK       0x0FFF0000  /* PLE_SRC_CNT[27..16] */
+#define WF_PSE_TOP_PLE_PG_INFO_PLE_SRC_CNT_SHFT       16
+#define WF_PSE_TOP_PLE_PG_INFO_PLE_RSV_CNT_ADDR       WF_PSE_TOP_PLE_PG_INFO_ADDR
+#define WF_PSE_TOP_PLE_PG_INFO_PLE_RSV_CNT_MASK       0x00000FFF  /* PLE_RSV_CNT[11..0] */
+#define WF_PSE_TOP_PLE_PG_INFO_PLE_RSV_CNT_SHFT       0
+
+#define WF_PSE_TOP_PG_PLE1_GROUP_PLE1_MAX_QUOTA_ADDR  WF_PSE_TOP_PG_PLE1_GROUP_ADDR
+#define WF_PSE_TOP_PG_PLE1_GROUP_PLE1_MAX_QUOTA_MASK  0x0FFF0000  /* PLE_MAX_QUOTA[27..16] */
+#define WF_PSE_TOP_PG_PLE1_GROUP_PLE1_MAX_QUOTA_SHFT  16
+#define WF_PSE_TOP_PG_PLE1_GROUP_PLE1_MIN_QUOTA_ADDR  WF_PSE_TOP_PG_PLE1_GROUP_ADDR
+#define WF_PSE_TOP_PG_PLE1_GROUP_PLE1_MIN_QUOTA_MASK  0x00000FFF  /* PLE_MIN_QUOTA[11..0] */
+#define WF_PSE_TOP_PG_PLE1_GROUP_PLE1_MIN_QUOTA_SHFT  0
+
+#define WF_PSE_TOP_PLE1_PG_INFO_PLE1_SRC_CNT_ADDR     WF_PSE_TOP_PLE1_PG_INFO_ADDR
+#define WF_PSE_TOP_PLE1_PG_INFO_PLE1_SRC_CNT_MASK     0x0FFF0000  /* PLE_SRC_CNT[27..16] */
+#define WF_PSE_TOP_PLE1_PG_INFO_PLE1_SRC_CNT_SHFT     16
+#define WF_PSE_TOP_PLE1_PG_INFO_PLE1_RSV_CNT_ADDR     WF_PSE_TOP_PLE1_PG_INFO_ADDR
+#define WF_PSE_TOP_PLE1_PG_INFO_PLE1_RSV_CNT_MASK     0x00000FFF  /* PLE_RSV_CNT[11..0] */
+#define WF_PSE_TOP_PLE1_PG_INFO_PLE1_RSV_CNT_SHFT     0
+
+#define WF_PSE_TOP_PG_LMAC0_GROUP_LMAC0_MAX_QUOTA_ADDR  WF_PSE_TOP_PG_LMAC0_GROUP_ADDR
+#define WF_PSE_TOP_PG_LMAC0_GROUP_LMAC0_MAX_QUOTA_MASK  0x0FFF0000  /* LMAC0_MAX_QUOTA[27..16] */
+#define WF_PSE_TOP_PG_LMAC0_GROUP_LMAC0_MAX_QUOTA_SHFT  16
+#define WF_PSE_TOP_PG_LMAC0_GROUP_LMAC0_MIN_QUOTA_ADDR  WF_PSE_TOP_PG_LMAC0_GROUP_ADDR
+#define WF_PSE_TOP_PG_LMAC0_GROUP_LMAC0_MIN_QUOTA_MASK  0x00000FFF  /* LMAC0_MIN_QUOTA[11..0] */
+#define WF_PSE_TOP_PG_LMAC0_GROUP_LMAC0_MIN_QUOTA_SHFT  0
+
+#define WF_PSE_TOP_LMAC0_PG_INFO_LMAC0_SRC_CNT_ADDR     WF_PSE_TOP_LMAC0_PG_INFO_ADDR
+#define WF_PSE_TOP_LMAC0_PG_INFO_LMAC0_SRC_CNT_MASK     0x0FFF0000  /* LMAC0_SRC_CNT[27..16] */
+#define WF_PSE_TOP_LMAC0_PG_INFO_LMAC0_SRC_CNT_SHFT     16
+#define WF_PSE_TOP_LMAC0_PG_INFO_LMAC0_RSV_CNT_ADDR     WF_PSE_TOP_LMAC0_PG_INFO_ADDR
+#define WF_PSE_TOP_LMAC0_PG_INFO_LMAC0_RSV_CNT_MASK     0x00000FFF  /* LMAC0_RSV_CNT[11..0] */
+#define WF_PSE_TOP_LMAC0_PG_INFO_LMAC0_RSV_CNT_SHFT     0
+
+#define WF_PSE_TOP_PG_LMAC1_GROUP_LMAC1_MAX_QUOTA_ADDR  WF_PSE_TOP_PG_LMAC1_GROUP_ADDR
+#define WF_PSE_TOP_PG_LMAC1_GROUP_LMAC1_MAX_QUOTA_MASK  0x0FFF0000  /* LMAC1_MAX_QUOTA[27..16] */
+#define WF_PSE_TOP_PG_LMAC1_GROUP_LMAC1_MAX_QUOTA_SHFT  16
+#define WF_PSE_TOP_PG_LMAC1_GROUP_LMAC1_MIN_QUOTA_ADDR  WF_PSE_TOP_PG_LMAC1_GROUP_ADDR
+#define WF_PSE_TOP_PG_LMAC1_GROUP_LMAC1_MIN_QUOTA_MASK  0x00000FFF  /* LMAC1_MIN_QUOTA[11..0] */
+#define WF_PSE_TOP_PG_LMAC1_GROUP_LMAC1_MIN_QUOTA_SHFT  0
+
+#define WF_PSE_TOP_LMAC1_PG_INFO_LMAC1_SRC_CNT_ADDR     WF_PSE_TOP_LMAC1_PG_INFO_ADDR
+#define WF_PSE_TOP_LMAC1_PG_INFO_LMAC1_SRC_CNT_MASK     0x0FFF0000  /* LMAC1_SRC_CNT[27..16] */
+#define WF_PSE_TOP_LMAC1_PG_INFO_LMAC1_SRC_CNT_SHFT     16
+#define WF_PSE_TOP_LMAC1_PG_INFO_LMAC1_RSV_CNT_ADDR     WF_PSE_TOP_LMAC1_PG_INFO_ADDR
+#define WF_PSE_TOP_LMAC1_PG_INFO_LMAC1_RSV_CNT_MASK     0x00000FFF  /* LMAC1_RSV_CNT[11..0] */
+#define WF_PSE_TOP_LMAC1_PG_INFO_LMAC1_RSV_CNT_SHFT     0
+
+#define WF_PSE_TOP_PG_LMAC2_GROUP_LMAC2_MAX_QUOTA_ADDR  WF_PSE_TOP_PG_LMAC2_GROUP_ADDR
+#define WF_PSE_TOP_PG_LMAC2_GROUP_LMAC2_MAX_QUOTA_MASK  0x0FFF0000  /* LMAC2_MAX_QUOTA[27..16] */
+#define WF_PSE_TOP_PG_LMAC2_GROUP_LMAC2_MAX_QUOTA_SHFT  16
+#define WF_PSE_TOP_PG_LMAC2_GROUP_LMAC2_MIN_QUOTA_ADDR  WF_PSE_TOP_PG_LMAC2_GROUP_ADDR
+#define WF_PSE_TOP_PG_LMAC2_GROUP_LMAC2_MIN_QUOTA_MASK  0x00000FFF  /* LMAC2_MIN_QUOTA[11..0] */
+#define WF_PSE_TOP_PG_LMAC2_GROUP_LMAC2_MIN_QUOTA_SHFT  0
+
+#define WF_PSE_TOP_LMAC2_PG_INFO_LMAC2_SRC_CNT_ADDR     WF_PSE_TOP_LMAC2_PG_INFO_ADDR
+#define WF_PSE_TOP_LMAC2_PG_INFO_LMAC2_SRC_CNT_MASK     0x0FFF0000  /* LMAC2_SRC_CNT[27..16] */
+#define WF_PSE_TOP_LMAC2_PG_INFO_LMAC2_SRC_CNT_SHFT     16
+#define WF_PSE_TOP_LMAC2_PG_INFO_LMAC2_RSV_CNT_ADDR     WF_PSE_TOP_LMAC2_PG_INFO_ADDR
+#define WF_PSE_TOP_LMAC2_PG_INFO_LMAC2_RSV_CNT_MASK     0x00000FFF  /* LMAC2_RSV_CNT[11..0] */
+#define WF_PSE_TOP_LMAC2_PG_INFO_LMAC2_RSV_CNT_SHFT     0
+
+#define WF_PSE_TOP_PG_LMAC3_GROUP_LMAC3_MAX_QUOTA_ADDR  WF_PSE_TOP_PG_LMAC3_GROUP_ADDR
+#define WF_PSE_TOP_PG_LMAC3_GROUP_LMAC3_MAX_QUOTA_MASK  0x0FFF0000  /* LMAC3_MAX_QUOTA[27..16] */
+#define WF_PSE_TOP_PG_LMAC3_GROUP_LMAC3_MAX_QUOTA_SHFT  16
+#define WF_PSE_TOP_PG_LMAC3_GROUP_LMAC3_MIN_QUOTA_ADDR  WF_PSE_TOP_PG_LMAC3_GROUP_ADDR
+#define WF_PSE_TOP_PG_LMAC3_GROUP_LMAC3_MIN_QUOTA_MASK  0x00000FFF  /* LMAC3_MIN_QUOTA[11..0] */
+#define WF_PSE_TOP_PG_LMAC3_GROUP_LMAC3_MIN_QUOTA_SHFT  0
+
+#define WF_PSE_TOP_LMAC3_PG_INFO_LMAC3_SRC_CNT_ADDR     WF_PSE_TOP_LMAC3_PG_INFO_ADDR
+#define WF_PSE_TOP_LMAC3_PG_INFO_LMAC3_SRC_CNT_MASK     0x0FFF0000  /* LMAC3_SRC_CNT[27..16] */
+#define WF_PSE_TOP_LMAC3_PG_INFO_LMAC3_SRC_CNT_SHFT     16
+#define WF_PSE_TOP_LMAC3_PG_INFO_LMAC3_RSV_CNT_ADDR     WF_PSE_TOP_LMAC3_PG_INFO_ADDR
+#define WF_PSE_TOP_LMAC3_PG_INFO_LMAC3_RSV_CNT_MASK     0x00000FFF  /* LMAC3_RSV_CNT[11..0] */
+#define WF_PSE_TOP_LMAC3_PG_INFO_LMAC3_RSV_CNT_SHFT     0
+
+#define WF_PSE_TOP_PG_MDP_GROUP_MDP_MAX_QUOTA_ADDR      WF_PSE_TOP_PG_MDP_GROUP_ADDR
+#define WF_PSE_TOP_PG_MDP_GROUP_MDP_MAX_QUOTA_MASK      0x0FFF0000  /* MDP_MAX_QUOTA[27..16] */
+#define WF_PSE_TOP_PG_MDP_GROUP_MDP_MAX_QUOTA_SHFT      16
+#define WF_PSE_TOP_PG_MDP_GROUP_MDP_MIN_QUOTA_ADDR      WF_PSE_TOP_PG_MDP_GROUP_ADDR
+#define WF_PSE_TOP_PG_MDP_GROUP_MDP_MIN_QUOTA_MASK      0x00000FFF  /* MDP_MIN_QUOTA[11..0] */
+#define WF_PSE_TOP_PG_MDP_GROUP_MDP_MIN_QUOTA_SHFT      0
+
+#define WF_PSE_TOP_MDP_PG_INFO_MDP_SRC_CNT_ADDR         WF_PSE_TOP_MDP_PG_INFO_ADDR
+#define WF_PSE_TOP_MDP_PG_INFO_MDP_SRC_CNT_MASK         0x0FFF0000  /* MDP_SRC_CNT[27..16] */
+#define WF_PSE_TOP_MDP_PG_INFO_MDP_SRC_CNT_SHFT         16
+#define WF_PSE_TOP_MDP_PG_INFO_MDP_RSV_CNT_ADDR         WF_PSE_TOP_MDP_PG_INFO_ADDR
+#define WF_PSE_TOP_MDP_PG_INFO_MDP_RSV_CNT_MASK         0x00000FFF  /* MDP_RSV_CNT[11..0] */
+#define WF_PSE_TOP_MDP_PG_INFO_MDP_RSV_CNT_SHFT         0
 
 #define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_6_EMPTY_MASK_ADDR      WF_PSE_TOP_QUEUE_EMPTY_MASK_ADDR
 #define WF_PSE_TOP_QUEUE_EMPTY_MASK_HIF_6_EMPTY_MASK_MASK      0x00004000 /* HIF_6_EMPTY_MASK[14] */
-- 
2.20.1

