Return-Path: <linux-wireless+bounces-24495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A00B4AE8BAE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 19:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD48189080B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145981ADC69;
	Wed, 25 Jun 2025 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5CYvtwZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B533074AC
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873261; cv=none; b=lFV6ZCdnxYD0HEN6wV3o3gW5ACko/nZPZvCnVmyVSR0BMsRHd8fDKOi+UgNP9c9iGG2h8/A+D9WKW8sQc8vwqyu3OWfhuRXGcja1jkPZU2+SrJmG83C1wR7W58RGZgvmUZwhmZ4Z+gIqOduSJUHhYq1zC6W4PlQXbsDacTSt5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873261; c=relaxed/simple;
	bh=Al67X+wyrvlZmIUJb011DLtITPEcTdpDYcvQmDhjBS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pCq5zEDkc0Db3cODtdVi01Tp8c5ACfj1iuBqvzvIfXTDDKLoq91rLARUyx0qeWMf2etjmUAJyenQwh3n+ifZCOG9GOfUZ5Rjl3jiziuDFo6t81pvFQmmS0i7wOrI0UJM7TNdrS6rkOyZGzAOipVg9X4mBx1WgDxo+j3tQK5/ugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5CYvtwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DD2C4CEEA;
	Wed, 25 Jun 2025 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750873260;
	bh=Al67X+wyrvlZmIUJb011DLtITPEcTdpDYcvQmDhjBS0=;
	h=From:Date:Subject:To:Cc:From;
	b=E5CYvtwZla5r19x/yWIvWJ5UVoglbMyPejYpkx7KxR5sQnb+4O3y5M6snePa/3KzG
	 8Dk80+918QeRDyU0bqriBqjZ3ZCkwRT79cFJ3kXkhEiP0nhzDqXF5Gq4j6wYzRINYf
	 T9/tE4yln7zrDF63xxm+W2++MTGnfe7XKIfuGISSkD+onFa69lay32vj9oUUS5WCdt
	 5uLeEdw9/KppzTbn7DZMvgBgABaDKca1fIYayQieGSReq1NYrnRd9zdJN/nHXLZrU7
	 Dgq2YZIGpH0Y7MRC9JVsX3OzBJRfqLHHqMY0dN544pTFzZAvkLKqI/pyrSSjpORPzQ
	 ZOASr3tUVNhqA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 25 Jun 2025 19:40:30 +0200
Subject: [PATCH mt76] wifi: mt76: Get rid of dma_sync_single_for_device()
 for MMIO devices
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-mt76-sync-for-device-v1-1-e687e3278e1a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI00XGgC/x3MTQqAIBBA4avErBswI/u5SrQwHWsWWWhEEd49a
 fkW33shUmCKMBQvBLo48u5zVGUBZtV+IWSbG6SQjVCywe1sFcbHG3R7QJuJIax1NQtleqs6B5k
 egRzf/3acUvoAyL+ONGYAAAA=
X-Change-ID: 20250625-mt76-sync-for-device-3a1b06c9d68f
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Since the page_pool for MT76 MMIO devices are created with
PP_FLAG_DMA_SYNC_DEV flag, we do not need to sync_for_device each page
received from the pool since it is already done by the page_pool
codebase.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 11 +++--------
 drivers/net/wireless/mediatek/mt76/wed.c |  6 +-----
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 35b4ec91979e6a55b80feec0eca68afa28d2c5b9..87f531297f8513b0caee2d034184ddd8fa3b6a21 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -643,10 +643,8 @@ mt76_dma_rx_fill_buf(struct mt76_dev *dev, struct mt76_queue *q,
 
 	while (q->queued < q->ndesc - 1) {
 		struct mt76_queue_buf qbuf = {};
-		enum dma_data_direction dir;
-		dma_addr_t addr;
-		int offset;
 		void *buf = NULL;
+		int offset;
 
 		if (mt76_queue_is_wed_rro_ind(q))
 			goto done;
@@ -655,11 +653,8 @@ mt76_dma_rx_fill_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		if (!buf)
 			break;
 
-		addr = page_pool_get_dma_addr(virt_to_head_page(buf)) + offset;
-		dir = page_pool_get_dma_dir(q->page_pool);
-		dma_sync_single_for_device(dev->dma_dev, addr, len, dir);
-
-		qbuf.addr = addr + q->buf_offset;
+		qbuf.addr = page_pool_get_dma_addr(virt_to_head_page(buf)) +
+			    offset + q->buf_offset;
 done:
 		qbuf.len = len - q->buf_offset;
 		qbuf.skip_unmap = false;
diff --git a/drivers/net/wireless/mediatek/mt76/wed.c b/drivers/net/wireless/mediatek/mt76/wed.c
index f89e4537555c59ac05a64067a43d4a806917bb1d..63f69e152b1cbb5bc0170a44976be1c7c52f21dc 100644
--- a/drivers/net/wireless/mediatek/mt76/wed.c
+++ b/drivers/net/wireless/mediatek/mt76/wed.c
@@ -34,11 +34,10 @@ u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 	struct mt76_dev *dev = container_of(wed, struct mt76_dev, mmio.wed);
 	struct mtk_wed_bm_desc *desc = wed->rx_buf_ring.desc;
 	struct mt76_queue *q = &dev->q_rx[MT_RXQ_MAIN];
-	int i, len = SKB_WITH_OVERHEAD(q->buf_size);
 	struct mt76_txwi_cache *t = NULL;
+	int i;
 
 	for (i = 0; i < size; i++) {
-		enum dma_data_direction dir;
 		dma_addr_t addr;
 		u32 offset;
 		int token;
@@ -53,9 +52,6 @@ u32 mt76_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 			goto unmap;
 
 		addr = page_pool_get_dma_addr(virt_to_head_page(buf)) + offset;
-		dir = page_pool_get_dma_dir(q->page_pool);
-		dma_sync_single_for_device(dev->dma_dev, addr, len, dir);
-
 		desc->buf0 = cpu_to_le32(addr);
 		token = mt76_rx_token_consume(dev, buf, t, addr);
 		if (token < 0) {

---
base-commit: 4327120e4c508ad68fec3253b5781f0e52dc8dba
change-id: 20250625-mt76-sync-for-device-3a1b06c9d68f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


