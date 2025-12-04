Return-Path: <linux-wireless+bounces-29491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D43CA2C27
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BC933008055
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49627EFEF;
	Thu,  4 Dec 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH0TMlm8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3512FF142
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835892; cv=none; b=Oru/9HY9DhWv5k+amX9VqWNJbfOk7H4sZD61BC9BD3InSo79Hx8KU5bjbpFC5RYeJ5vhvSqbN2O2PXv8jh8J3I7vkn4kJcL4BsVlxGpqI/viPXUPFhI7HyJxknJo6WuCjMdWsNGCjjnogGVDeQVsbEq9qnz0Q0Gie00zu1V+4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835892; c=relaxed/simple;
	bh=EEEUGLWIt7MCMt8Rynlc3HmYVn3aGUZLMUFrSR5Ui+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3a5RWSarSF91/wstyJ1I9EJkIrkuZOtJQVW/JkroK7cvZFfb10Pzsvexv/GKFqpnfFb8nUEzyFA1/Cqz+xF15FnFteZ4j8F98XgiCqCeH656ir8kKHv5aNj3g6bGzRlaF0Vu6Pnqf+QZfW8qsrh5QLCoGzKGj6K1YDByZ8Ondw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH0TMlm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B5AC16AAE;
	Thu,  4 Dec 2025 08:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764835891;
	bh=EEEUGLWIt7MCMt8Rynlc3HmYVn3aGUZLMUFrSR5Ui+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YH0TMlm8JDMZ7mlorJha+V4h+3DhfINJRq1C+XluvfFbRnBTCd5hjnCcnrLGWqGRw
	 O1NASCoJfVrCuhhxFAIvl993fNj4nacNp0Z7VF1BsUn1DmIbMDCXjFe7GeV5cXYv/5
	 zd6R57+MVu1ks974LbJPaFtWXF2LUIYqTYuenlYkdflx7dVEVYaXmWWCWmqdqrlatv
	 jlNAxZ7B2GB8sjUvW+7HQLj/2giSTQ7dHXcmrHWvQVRP3huwlwvBqBanzHJmGDNCBg
	 150JKnSmCdWxTkUaPHq1i8LBMe9qUT6Cmmooij2ELZj1tT7jzEMCUNx68r9Z5nt5gX
	 WSFUgvByt3tpQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 09:10:45 +0100
Subject: [PATCH mt76 03/11] wifi: mt76: always enable RRO queues for
 non-MT7992 chipset
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-npu-eagle-offload-v1-3-7819c52c0893@kernel.org>
References: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
In-Reply-To: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hui Ma <hui.ma@airoha.com>
X-Mailer: b4 0.14.2

MT7996 NPU binary requires to initialize NPU desc_base after configuring
ring_size. This is a preliminary patch to enable NPU offload for MT7996
(7990-Eagle) chipset.

Tested-by: Hui Ma <hui.ma@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f240016ed9f0ead27e98e350f4fdb818e1686781..fc2ac463e4e78872f9e4e7dacbdaa34bac383fb7 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -6,6 +6,7 @@
 #include <linux/dma-mapping.h>
 #include "mt76.h"
 #include "dma.h"
+#include "mt76_connac.h"
 
 static struct mt76_txwi_cache *
 mt76_alloc_txwi(struct mt76_dev *dev)
@@ -188,16 +189,18 @@ mt76_dma_queue_magic_cnt_init(struct mt76_dev *dev, struct mt76_queue *q)
 static void
 mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	Q_WRITE(q, desc_base, q->desc_dma);
-	if ((q->flags & MT_QFLAG_WED_RRO_EN) && !mt76_npu_device_active(dev))
+	if ((q->flags & MT_QFLAG_WED_RRO_EN) &&
+	    (!is_mt7992(dev) || !mt76_npu_device_active(dev)))
 		Q_WRITE(q, ring_size, MT_DMA_RRO_EN | q->ndesc);
 	else
 		Q_WRITE(q, ring_size, q->ndesc);
 
 	if (mt76_queue_is_npu_tx(q)) {
-		writel(q->desc_dma, &q->regs->desc_base);
 		writel(q->ndesc, &q->regs->ring_size);
+		writel(q->desc_dma, &q->regs->desc_base);
 	}
+
+	Q_WRITE(q, desc_base, q->desc_dma);
 	q->head = Q_READ(q, dma_idx);
 	q->tail = q->head;
 }

-- 
2.52.0


