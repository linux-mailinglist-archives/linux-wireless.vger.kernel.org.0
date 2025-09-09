Return-Path: <linux-wireless+bounces-27176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7EFB4AAE3
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 12:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDA0188AE27
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C02522B6;
	Tue,  9 Sep 2025 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWIANRDG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978123A58B
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414804; cv=none; b=u5JULlxCiH3f16kSDRQdT+ze5KPUji0BURbxGruDP4geJsTKHIdugHtY0dQ3Os4FiZfbT1znSlhl0nVlqC5HSIBzcNs36qIlHXk9N93ZCod16KUZFxnHZT6NEeXU80IaVSr6bPhaHa4yz0Y4OiuVmvoyNSuFE+Zw3HUQ1+jrfsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414804; c=relaxed/simple;
	bh=yWrhc412alWgxx6Om8MS4lFSCSiz7aS8X262Zvx9aeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqWqq8Z/kIs7xkZQfx4hblUk/UzurzLBCilzIjRtmYHNvm3dpG+ZNszN1p76soXX204++Y+7Y+cqqWdYq3eOHWHGUoO8qvxN0ic07LiZxwd1bfst0KLDMCsjIuyq8cLH3gt99FHBeGHgE7hpMi70zV+v9nzyggCUTCVCxEeaRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWIANRDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9147DC4CEF4;
	Tue,  9 Sep 2025 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757414803;
	bh=yWrhc412alWgxx6Om8MS4lFSCSiz7aS8X262Zvx9aeA=;
	h=From:To:Cc:Subject:Date:From;
	b=KWIANRDGKOXB9ngieV26KAdfpdlYXvgcH5bTFwhbA8LRTyWDg1H6tiy9K++ltVln4
	 vR1YgOMNbs8Kwvjmbjt9YeIKDZLYpmskusNzpmaTzTSLYbNCT3LytG/vOkzbEpUMbl
	 VQuSu4uLa9TsGX4Xw4U6iu2wxXWQ3xVykQPQqA7/winwFL+AATZNZ2qa9NPgc2UwIw
	 olaSvilNUYdxoZ5nkJmEaI4F+9oM6GauaPKeObdVjuksuqnrEQ8o9tqbUDj4KIoS2Y
	 wDqW0G7l5xFdHQMO4jt+A1Aa0uvCxV1jyT/peWGQbdg6d4bKhAgDfabsiN8UB5w68o
	 HaM5NOx5JZFMA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	lorenzo@kernel.org
Subject: [PATCH mt76] wifi: mt76: Convert mt76_wed_rro_ind to LE
Date: Tue,  9 Sep 2025 12:46:37 +0200
Message-ID: <301d5f2982ddb729c876fb65f9ac2443ce3f5ff1.1757414621.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not use bitmask in mt76_wed_rro_ind DMA descriptor in order to not
break endianness.
This patch is based on the following series:
https://lore.kernel.org/linux-wireless/20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org/T/#m8b488004d69036cd3672b9eeca8005a937ec0313

Fixes: 950d0abb5cd94 ("wifi: mt76: mt7996: add wed rx support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c      |  9 ++++++--
 drivers/net/wireless/mediatek/mt76/mt76.h     | 17 ++++++++-------
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 21 ++++++++++++-------
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 5dc093b21838..1fa7de1d2c45 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -194,6 +194,8 @@ mt76_dma_queue_magic_cnt_init(struct mt76_dev *dev, struct mt76_queue *q)
 	q->magic_cnt = 0;
 	if (mt76_queue_is_wed_rro_ind(q)) {
 		struct mt76_wed_rro_desc *rro_desc;
+		u32 data1 = FIELD_PREP(RRO_IND_DATA1_MAGIC_CNT_MASK,
+				       MT_DMA_WED_IND_CMD_CNT - 1);
 		int i;
 
 		rro_desc = (struct mt76_wed_rro_desc *)q->desc;
@@ -201,7 +203,7 @@ mt76_dma_queue_magic_cnt_init(struct mt76_dev *dev, struct mt76_queue *q)
 			struct mt76_wed_rro_ind *cmd;
 
 			cmd = (struct mt76_wed_rro_ind *)&rro_desc[i];
-			cmd->magic_cnt = MT_DMA_WED_IND_CMD_CNT - 1;
+			cmd->data1 = cpu_to_le32(data1);
 		}
 	} else if (mt76_queue_is_wed_rro_rxdmad_c(q)) {
 		struct mt76_rro_rxdmad_c *dmad = (void *)q->desc;
@@ -582,12 +584,15 @@ mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
 
 	if (mt76_queue_is_wed_rro_ind(q)) {
 		struct mt76_wed_rro_ind *cmd;
+		u8 magic_cnt;
 
 		if (flush)
 			goto done;
 
 		cmd = q->entry[idx].buf;
-		if (cmd->magic_cnt != q->magic_cnt)
+		magic_cnt = FIELD_GET(RRO_IND_DATA1_MAGIC_CNT_MASK,
+				      le32_to_cpu(cmd->data1));
+		if (magic_cnt != q->magic_cnt)
 			return NULL;
 
 		if (q->tail == q->ndesc - 1)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a78d663ee91d..eede0c0fe2b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -415,15 +415,16 @@ struct mt76_txq {
 	bool aggr;
 };
 
+/* data0 */
+#define RRO_IND_DATA0_IND_REASON_MASK	GENMASK(31, 28)
+#define RRO_IND_DATA0_START_SEQ_MASK	GENMASK(27, 16)
+#define RRO_IND_DATA0_SEQ_ID_MASK	GENMASK(11, 0)
+/* data1 */
+#define RRO_IND_DATA1_MAGIC_CNT_MASK	GENMASK(31, 29)
+#define RRO_IND_DATA1_IND_COUNT_MASK	GENMASK(12, 0)
 struct mt76_wed_rro_ind {
-	u32 se_id	: 12;
-	u32 rsv		: 4;
-	u32 start_sn	: 12;
-	u32 ind_reason	: 4;
-	u32 ind_cnt	: 13;
-	u32 win_sz	: 3;
-	u32 rsv2	: 13;
-	u32 magic_cnt	: 3;
+	__le32 data0;
+	__le32 data1;
 };
 
 struct mt76_txwi_cache {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ed10e45b21a4..5b43678e6556 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1822,11 +1822,17 @@ void mt7996_rro_rx_process(struct mt76_dev *mdev, void *data)
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt76_wed_rro_ind *cmd = (struct mt76_wed_rro_ind *)data;
+	u32 cmd_data0 = le32_to_cpu(cmd->data0);
+	u32 cmd_data1 = le32_to_cpu(cmd->data1);
+	u8 ind_reason = FIELD_GET(RRO_IND_DATA0_IND_REASON_MASK, cmd_data0);
+	u16 start_seq = FIELD_GET(RRO_IND_DATA0_START_SEQ_MASK, cmd_data0);
+	u16 seq_id = FIELD_GET(RRO_IND_DATA0_SEQ_ID_MASK, cmd_data0);
+	u16 ind_count = FIELD_GET(RRO_IND_DATA1_IND_COUNT_MASK, cmd_data1);
 	struct mt7996_msdu_page_info *pinfo = NULL;
 	struct mt7996_msdu_page *p = NULL;
 	int i, seq_num = 0;
 
-	for (i = 0; i < cmd->ind_cnt; i++) {
+	for (i = 0; i < ind_count; i++) {
 		struct mt7996_wed_rro_addr *e;
 		struct mt76_rx_status *status;
 		struct mt7996_rro_hif *rxd;
@@ -1841,8 +1847,8 @@ void mt7996_rro_rx_process(struct mt76_dev *mdev, void *data)
 		void *buf;
 		bool ls;
 
-		seq_num = FIELD_GET(MT996_RRO_SN_MASK, cmd->start_sn + i);
-		e = mt7996_rro_addr_elem_get(dev, cmd->se_id, seq_num);
+		seq_num = FIELD_GET(MT996_RRO_SN_MASK, start_seq + i);
+		e = mt7996_rro_addr_elem_get(dev, seq_id, seq_num);
 		data = le32_to_cpu(e->data);
 		signature = FIELD_GET(WED_RRO_ADDR_SIGNATURE_MASK, data);
 		if (signature != (seq_num / MT7996_RRO_WINDOW_MAX_LEN)) {
@@ -1930,7 +1936,7 @@ void mt7996_rro_rx_process(struct mt76_dev *mdev, void *data)
 			skb_mark_for_recycle(skb);
 			__skb_put(skb, len);
 
-			if (cmd->ind_reason == 1 || cmd->ind_reason == 2) {
+			if (ind_reason == 1 || ind_reason == 2) {
 				dev_kfree_skb(skb);
 				goto next_page;
 			}
@@ -1941,7 +1947,7 @@ void mt7996_rro_rx_process(struct mt76_dev *mdev, void *data)
 			}
 
 			status = (struct mt76_rx_status *)skb->cb;
-			if (cmd->se_id != MT7996_RRO_MAX_SESSION)
+			if (seq_id != MT7996_RRO_MAX_SESSION)
 				status->aggr = true;
 
 			mt7996_queue_rx_skb(mdev, qid, skb, &info);
@@ -1965,7 +1971,7 @@ void mt7996_rro_rx_process(struct mt76_dev *mdev, void *data)
 		if ((i + 1) % 4 == 0)
 			mt76_wr(dev, MT_RRO_ACK_SN_CTRL,
 				FIELD_PREP(MT_RRO_ACK_SN_CTRL_SESSION_MASK,
-					   cmd->se_id) |
+					   seq_id) |
 				FIELD_PREP(MT_RRO_ACK_SN_CTRL_SN_MASK,
 					   seq_num));
 		if (p) {
@@ -1977,8 +1983,7 @@ void mt7996_rro_rx_process(struct mt76_dev *mdev, void *data)
 	/* Update ack_seq_num for remaining addr_elem */
 	if (i % 4)
 		mt76_wr(dev, MT_RRO_ACK_SN_CTRL,
-			FIELD_PREP(MT_RRO_ACK_SN_CTRL_SESSION_MASK,
-				   cmd->se_id) |
+			FIELD_PREP(MT_RRO_ACK_SN_CTRL_SESSION_MASK, seq_id) |
 			FIELD_PREP(MT_RRO_ACK_SN_CTRL_SN_MASK, seq_num));
 }
 
-- 
2.51.0


