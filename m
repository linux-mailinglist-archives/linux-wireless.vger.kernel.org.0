Return-Path: <linux-wireless+bounces-27173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2C8B4A8BB
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD083ADBCB
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70B63112D6;
	Tue,  9 Sep 2025 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoJ9wCt9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2682313539
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411163; cv=none; b=uYVVn/hkuhPhdVZCj9n0iSwxrIBvVqRApD9Wv2IS5Xpy2qlnyp74/aFH3DnjQ8PJsizUOMiAUOhEnvroPcQ9AnRSjn9WezuGY7mgZgcHXcwFmAV6VgPPNPupQvIGOGj7jl6UKChwJU+LKywCaEHA+V7nBbEUCwDehflAY3GV/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411163; c=relaxed/simple;
	bh=VefrPpa7X9Fg9YWc2H408hwgRf9NxieAdeA1oV4lZc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AOhyZkRCQXuL0ULc2hDd27VpOoSK2x3SiWgjY6pH68GMrrnbBLTshRvuC24GEIQXoXNqPulSqiQZSJGi5bgigNHFYkb85M4bNkk7TCFJnxLNmV6mBscHZp5ZBZFwQE6YcXSf+YbM1Ft8o6Al43H4Yu6PY39EFNs8dxMJOjleh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoJ9wCt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9D3C4CEF4;
	Tue,  9 Sep 2025 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411163;
	bh=VefrPpa7X9Fg9YWc2H408hwgRf9NxieAdeA1oV4lZc8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CoJ9wCt9DHP4TF5e8QPyn2dadyxkj4duoXqw+xpixuq25URqG6fimfSH4UmIuSg/h
	 z8NmPnv7LKBHkgM5mI20UZ+yHYNyACgLt/g4JcPQ7G5OgBzElbTdHnsyr8ScmDQBnq
	 Ul0+dyJ4skc3gGfnT3Um6Hx1ZXyW5kcJpqj4rUHSAYNA/6NA+g8CiHe3TXN5IRRxX9
	 AVticwSfPGjtVHPsPq7iW41s+UY9x39OOo2mfyUHzjtwY/e0F3aO0tUiF+pHug+QyQ
	 UCAKQMqQhFMD644eul4Z1hfWDZsCiJb5YlLP6z2kO75cXezuy+2dWIjYv5g7l7RZfF
	 hQPsv5cLajgEA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 09 Sep 2025 11:45:23 +0200
Subject: [PATCH mt76 v5 15/16] wifi: mt76: Add mt76_dma_get_rxdmad_c_buf
 utility routione
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mt7996-rro-rework-v5-15-7d66f6eb7795@kernel.org>
References: <20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org>
In-Reply-To: <20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Bo Jiao <Bo.Jiao@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>
X-Mailer: b4 0.14.2

Introduce mt76_dma_get_rxdmad_c_buf routine to process packets received
by HW-RRO v3.1 module.
This is a preliminary patch to introduce SW path for HW-RRO v3.1 module
available on MT7992 chipset.

Co-developed-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 58 +++++++++++++++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/dma.h  | 15 ++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h |  8 +++++
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index fc30a8ea54ca6f736fd911de4ad471558e6c9577..7ad4a3a4cf095ba54afee6bda9fbf91286b8f280 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -427,15 +427,61 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 		wake_up(&dev->tx_wait);
 }
 
+static void *
+mt76_dma_get_rxdmad_c_buf(struct mt76_dev *dev, struct mt76_queue *q,
+			  int idx, int *len, bool *more)
+{
+	struct mt76_queue_entry *e = &q->entry[idx];
+	struct mt76_rro_rxdmad_c *dmad = e->buf;
+	u32 data1 = le32_to_cpu(dmad->data1);
+	u32 data2 = le32_to_cpu(dmad->data2);
+	struct mt76_txwi_cache *t;
+	u16 rx_token_id;
+	u8 ind_reason;
+	void *buf;
+
+	rx_token_id = FIELD_GET(RRO_RXDMAD_DATA2_RX_TOKEN_ID_MASK, data2);
+	t = mt76_rx_token_release(dev, rx_token_id);
+	if (!t)
+		return ERR_PTR(-EAGAIN);
+
+	q = &dev->q_rx[t->qid];
+	dma_sync_single_for_cpu(dev->dma_dev, t->dma_addr,
+				SKB_WITH_OVERHEAD(q->buf_size),
+				page_pool_get_dma_dir(q->page_pool));
+
+	if (len)
+		*len = FIELD_GET(RRO_RXDMAD_DATA1_SDL0_MASK, data1);
+	if (more)
+		*more = !FIELD_GET(RRO_RXDMAD_DATA1_LS_MASK, data1);
+
+	buf = t->ptr;
+	ind_reason = FIELD_GET(RRO_RXDMAD_DATA2_IND_REASON_MASK, data2);
+	if (ind_reason == MT_DMA_WED_IND_REASON_REPEAT ||
+	    ind_reason == MT_DMA_WED_IND_REASON_OLDPKT) {
+		mt76_put_page_pool_buf(buf, false);
+		buf = ERR_PTR(-EAGAIN);
+	}
+	t->ptr = NULL;
+	t->dma_addr = 0;
+
+	mt76_put_rxwi(dev, t);
+
+	return buf;
+}
+
 static void *
 mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
-		 int *len, u32 *info, bool *more, bool *drop)
+		 int *len, u32 *info, bool *more, bool *drop, bool flush)
 {
 	struct mt76_queue_entry *e = &q->entry[idx];
 	struct mt76_desc *desc = &q->desc[idx];
 	u32 ctrl, desc_info, buf1;
 	void *buf = e->buf;
 
+	if (mt76_queue_is_wed_rro_rxdmad_c(q) && !flush)
+		buf = mt76_dma_get_rxdmad_c_buf(dev, q, idx, len, more);
+
 	if (mt76_queue_is_wed_rro(q))
 		goto done;
 
@@ -516,7 +562,7 @@ mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
 	q->tail = (q->tail + 1) % q->ndesc;
 	q->queued--;
 
-	return mt76_dma_get_buf(dev, q, idx, len, info, more, drop);
+	return mt76_dma_get_buf(dev, q, idx, len, info, more, drop, flush);
 }
 
 static int
@@ -885,10 +931,16 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		if (!data)
 			break;
 
+		if (PTR_ERR(data) == -EAGAIN) {
+			done++;
+			continue;
+		}
+
 		if (mt76_queue_is_wed_rro_ind(q) && dev->drv->rx_rro_ind_process)
 			dev->drv->rx_rro_ind_process(dev, data);
 
-		if (mt76_queue_is_wed_rro(q)) {
+		if (mt76_queue_is_wed_rro(q) &&
+		    !mt76_queue_is_wed_rro_rxdmad_c(q)) {
 			done++;
 			continue;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index f53c2136858043d0f208d9d21304fae2058ac70f..17a80e1757fcc3a9358f1cc4f3cafe4b6d87ec65 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -58,6 +58,21 @@ struct mt76_wed_rro_desc {
 	__le32 buf1;
 } __packed __aligned(4);
 
+/* data1 */
+#define RRO_RXDMAD_DATA1_LS_MASK		BIT(30)
+#define RRO_RXDMAD_DATA1_SDL0_MASK		GENMASK(29, 16)
+/* data2 */
+#define RRO_RXDMAD_DATA2_RX_TOKEN_ID_MASK	GENMASK(31, 16)
+#define RRO_RXDMAD_DATA2_IND_REASON_MASK	GENMASK(15, 12)
+/* data3 */
+#define RRO_RXDMAD_DATA3_MAGIC_CNT_MASK		GENMASK(31, 28)
+struct mt76_rro_rxdmad_c {
+	__le32 data0;
+	__le32 data1;
+	__le32 data2;
+	__le32 data3;
+};
+
 enum mt76_qsel {
 	MT_QSEL_MGMT,
 	MT_QSEL_HCCA,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 39e4641ae2cc5287a2c8c838c729bc7e85b68b9a..4aabb8d1021a70f502a4afe25b14d2cc6d524aca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -45,6 +45,7 @@
 #define MT_WED_RRO_Q_DATA(_n)	__MT_WED_RRO_Q(MT76_WED_RRO_Q_DATA, _n)
 #define MT_WED_RRO_Q_MSDU_PG(_n)	__MT_WED_RRO_Q(MT76_WED_RRO_Q_MSDU_PG, _n)
 #define MT_WED_RRO_Q_IND	__MT_WED_RRO_Q(MT76_WED_RRO_Q_IND, 0)
+#define MT_WED_RRO_Q_RXDMAD_C	__MT_WED_RRO_Q(MT76_WED_RRO_Q_RXDMAD_C, 0)
 
 struct mt76_dev;
 struct mt76_phy;
@@ -71,6 +72,7 @@ enum mt76_wed_type {
 	MT76_WED_RRO_Q_DATA,
 	MT76_WED_RRO_Q_MSDU_PG,
 	MT76_WED_RRO_Q_IND,
+	MT76_WED_RRO_Q_RXDMAD_C,
 };
 
 struct mt76_bus_ops {
@@ -1793,6 +1795,12 @@ static inline bool mt76_queue_is_wed_rro_ind(struct mt76_queue *q)
 	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_RRO_Q_IND;
 }
 
+static inline bool mt76_queue_is_wed_rro_rxdmad_c(struct mt76_queue *q)
+{
+	return mt76_queue_is_wed_rro(q) &&
+	       FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) == MT76_WED_RRO_Q_RXDMAD_C;
+}
+
 static inline bool mt76_queue_is_wed_rro_data(struct mt76_queue *q)
 {
 	return mt76_queue_is_wed_rro(q) &&

-- 
2.51.0


