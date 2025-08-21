Return-Path: <linux-wireless+bounces-26524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A204B2FA41
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 15:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C224F621D40
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995432A3E4;
	Thu, 21 Aug 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IknQ8Rdp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518733437E
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782239; cv=none; b=LXIn3sPv3DQyk+WlshIrxbK9aSBfgfTE89APnUDbUOyFp4Ab7XyeUmzFIUebS9aw9IRmDwjcjWEZgK/gYT4MI7PuLuRT2XB3t7gpagoQjPOAyS4QdmZfmyxsQf58siDkeoZlFPBjZKeshtspH/NiMAn3bsfTTNsVJQlLUOAr+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782239; c=relaxed/simple;
	bh=ijuE0wfdKRgLW5FUQqYOzSlUI9xrn0XepELZw2luO1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEdGEN9fet4XzgFoXwiHBVBV7S2c7R/fZb7tc7CP959L/bJFZ5fEvecdDIYLcPWw81+1K2BZ9dF9SvTEl6B3tYhGUx72FDXFfA+Vm8r6bF8HHA7wnq9+dNQmJj58CE+46rflsKH0CBSwKVKtex8PiMjUHo42TZf6DlX8JXdoQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IknQ8Rdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EB7C4CEED;
	Thu, 21 Aug 2025 13:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782239;
	bh=ijuE0wfdKRgLW5FUQqYOzSlUI9xrn0XepELZw2luO1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IknQ8RdpQS6F1PqK3tIW34fLF1cJilJXlN410OzjNes3Rhfi/A8dXAl5L/MzleNk1
	 cVL6efbFrNPOJkjSlsnG9LRUBM/DKYZGZR/0pZ1no/TZ0uZ9wq7/b8uq+6mJmHIxOB
	 UoG+eu7FXRV8z5Sf/JYz3FANOVfrLet/EMsojE0iknWnTzbDsaCVYgZTDl+kCTSw55
	 bNPmPlXj2Zz3GSpDA7H24/GPzSubF0dyhsWYYzUDmC6NwTCxvzAfuneSkkucmUke/J
	 W0UTKHGYFMcNOzKoBON8oWCwA/66hlfFJskAEGg/u3eB+IAU9btdc40iLUeJQKFZf9
	 HZKXVvxO+pz9A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 21 Aug 2025 15:15:05 +0200
Subject: [PATCH mt76 13/14] wifi: mt76: Add mt76_dma_get_rxdmad_c_buf
 utility routione
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-mt7996-rro-rework-v1-13-6c8477ad969f@kernel.org>
References: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
In-Reply-To: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Rex Lu <rex.lu@mediatek.com>
X-Mailer: b4 0.14.2

Introduce mt76_dma_get_rxdmad_c_buf routine to process packets received
by HW-RRO v3.1 module.
This is a preliminary patch to introduce SW path for HW-RRO v3.1 module
available on MT7992 chipset.

Co-developed-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c  | 47 +++++++++++++++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/dma.h  | 33 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h |  8 ++++++
 3 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index fc30a8ea54ca6f736fd911de4ad471558e6c9577..01f71e4810748a6b724360416bfd685b37caa1e8 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -427,15 +427,55 @@ mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
 		wake_up(&dev->tx_wait);
 }
 
+static void *
+mt76_dma_get_rxdmad_c_buf(struct mt76_dev *dev, struct mt76_queue *q,
+			  int idx, int *len, bool *more)
+{
+	struct mt76_queue_entry *e = &q->entry[idx];
+	struct mt76_rro_rxdmad_c *dmad = e->buf;
+	struct mt76_txwi_cache *t;
+	void *buf;
+
+	t = mt76_rx_token_release(dev, dmad->rx_token_id);
+	if (!t)
+		return NULL;
+
+	q = &dev->q_rx[t->qid];
+	dma_sync_single_for_cpu(dev->dma_dev, t->dma_addr,
+				SKB_WITH_OVERHEAD(q->buf_size),
+				page_pool_get_dma_dir(q->page_pool));
+
+	if (len)
+		*len = dmad->sdl0;
+	if (more)
+		*more = !dmad->ls;
+
+	buf = t->ptr;
+	if (dmad->ind_reason == MT_DMA_WED_IND_REASON_REPEAT ||
+	    dmad->ind_reason == MT_DMA_WED_IND_REASON_OLDPKT) {
+		mt76_put_page_pool_buf(buf, false);
+		buf = NULL;
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
 
@@ -516,7 +556,7 @@ mt76_dma_dequeue(struct mt76_dev *dev, struct mt76_queue *q, bool flush,
 	q->tail = (q->tail + 1) % q->ndesc;
 	q->queued--;
 
-	return mt76_dma_get_buf(dev, q, idx, len, info, more, drop);
+	return mt76_dma_get_buf(dev, q, idx, len, info, more, drop, flush);
 }
 
 static int
@@ -888,7 +928,8 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76_queue *q, int budget)
 		if (mt76_queue_is_wed_rro_ind(q) && dev->drv->rx_rro_ind_process)
 			dev->drv->rx_rro_ind_process(dev, data);
 
-		if (mt76_queue_is_wed_rro(q)) {
+		if (mt76_queue_is_wed_rro(q) &&
+		    !mt76_queue_is_wed_rro_rxdmad_c(q)) {
 			done++;
 			continue;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index f53c2136858043d0f208d9d21304fae2058ac70f..f47039d9ba4fd03d7decc6dd7582bb0efccda496 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -58,6 +58,39 @@ struct mt76_wed_rro_desc {
 	__le32 buf1;
 } __packed __aligned(4);
 
+struct mt76_rro_rxdmad_c {
+	u32 sdp0_31_0;
+	u32 header_ofst	: 7;
+	u32 ver		: 1;
+	u32 to_host	: 1;
+	u32 ring_info	: 2;
+	u32 dst_sel	: 2;
+	u32 pn_chk_fail	: 1;
+	u32 rsv		: 2;
+	u32 sdl0	: 14;
+	u32 ls		: 1;
+	u32 rsv2	: 1;
+	u32 sdp0_35_32	: 4;
+	u32 rsv3	: 2;
+	u32 sca_gat	: 1;
+	u32 par_se	: 1;
+	u32 rss_hash	: 4;
+	u32 ind_reason	: 4;
+	u32 rx_token_id	: 16;
+	u32 cs_status	: 4;
+	u32 cs_type	: 4;
+	u32 c		: 1;
+	u32 f		: 1;
+	u32 un		: 1;
+	u32 is_fc_data	: 1;
+	u32 uc		: 1;
+	u32 mc		: 1;
+	u32 bc		: 1;
+	u32 rsv4	: 1;
+	u32 wcid	: 12;
+	u32 magic_cnt	: 4;
+};
+
 enum mt76_qsel {
 	MT_QSEL_MGMT,
 	MT_QSEL_HCCA,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c5b7a88c198f08a539f360fdaa0669ccc3130be6..c7c11e64332a05e6a7146cfd2ede65f32d2e9418 100644
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
2.50.1


