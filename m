Return-Path: <linux-wireless+bounces-27028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD7BB4430E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 18:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D1EA62CA0
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7F63009D2;
	Thu,  4 Sep 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvmRQ7Jr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638C2F549A
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003934; cv=none; b=Ax/HRmNcME9zOjz0spdISywd2pfxMOt/pBhmmnUulKARo6RSg2OiTxHsm+O2yEDTLCAEmaYc0AnzmaOqOHfSBNBOL35SCpsm9nKh4Ni0bQmqxD6uMiV2fZFv3Vaiy69ZFmrrKD4pV3Nw879GckAH1LapozptXwB3BSNVO2iFbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003934; c=relaxed/simple;
	bh=OTXljgrq/Lb9CesGfgc0KIChCxyS4DwcB138KDiuMyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQ3CbRHdJDPBc8n7/dczQqjYWKo8oiDypjl/V7H3k7uXLtd+zbRmXmbAgHKAOF9orLzeppp4AAbp2YKTzFvy6Az80aPqRPcOm9sjyIlZbXAVZXYBEPICspCIqHtiB1e2hmjmzDWv+IGgIa6x6Vg/3GP5tUzFpiaRyUghdTK35z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvmRQ7Jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D4FC4CEF0;
	Thu,  4 Sep 2025 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003934;
	bh=OTXljgrq/Lb9CesGfgc0KIChCxyS4DwcB138KDiuMyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pvmRQ7JrIhUi/rCW8YW4mrqHlupn1r+0vyOVdFRotVoZUU71cOIwxohyT5VXQmUeD
	 lpn4lNuSf/tAEQ+W9rVKYbMn1F2JROWH8bCpZzrS4372bkkXE42Lojbe9VZXzLkT/F
	 w2/F8gBV2EzTjUnNm5ubSf5tdqt+6anIT0j1IQLcY9KiqllNIXp7wojVR61QW74l12
	 B5frfkk0/pDv3iRS5PfRGDINJz7XBcuUChKkZhz0LyJyBH00GlqJfc/gSxdIoFQJ5D
	 grSfsanZA/ilSfgj9SK5pKZBMvr/z8GTtf/cXhUxNdVVrv7Ifo6hPYOYbpVaDvPm2u
	 sPAZ2oqmdO/Tw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Sep 2025 18:38:08 +0200
Subject: [PATCH mt76 v4 14/15] wifi: mt76: Add mt76_dma_get_rxdmad_c_buf
 utility routione
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-mt7996-rro-rework-v4-14-2cd91e7229d6@kernel.org>
References: <20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org>
In-Reply-To: <20250904-mt7996-rro-rework-v4-0-2cd91e7229d6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
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
index fc30a8ea54ca6f736fd911de4ad471558e6c9577..d305cdf254eb217c7bbb64eb44e6a3266eb00274 100644
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
+	rx_token_id = FIELD_GET(RRO_DATA2_RX_TOKEN_ID_MASK, data2);
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
+		*len = FIELD_GET(RRO_DATA1_SDL0_MASK, data1);
+	if (more)
+		*more = !FIELD_GET(RRO_DATA1_LS_MASK, data1);
+
+	buf = t->ptr;
+	ind_reason = FIELD_GET(RRO_DATA2_IND_REASON_MASK, data2);
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
index f53c2136858043d0f208d9d21304fae2058ac70f..08373f1496e5747a7dbb85beeb8911f4b0072c71 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -58,6 +58,21 @@ struct mt76_wed_rro_desc {
 	__le32 buf1;
 } __packed __aligned(4);
 
+/* data1 */
+#define RRO_DATA1_LS_MASK		BIT(30)
+#define RRO_DATA1_SDL0_MASK		GENMASK(29, 16)
+/* data2 */
+#define RRO_DATA2_RX_TOKEN_ID_MASK	GENMASK(31, 16)
+#define RRO_DATA2_IND_REASON_MASK	GENMASK(15, 12)
+/* data3 */
+#define RRO_DATA3_MAGIC_CNT_MASK	GENMASK(31, 28)
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
2.50.1


