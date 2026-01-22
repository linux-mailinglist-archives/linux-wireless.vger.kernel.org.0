Return-Path: <linux-wireless+bounces-31064-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKjkA/UAcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31064-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:50:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 748BA6581D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF99F8A199F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE63F076C;
	Thu, 22 Jan 2026 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQxFWGLD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280293F23B4
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078414; cv=none; b=BrtM160PrxBx85dmQeo1VN0Cq6pKR39iPvqtJ02TwH/KrqdGNn6akCnagSqNS9uFg0pu2eViVqw0sBV5tl4Xp0CeiRjJ/mAJPU4BWf/00pRml2muMUfakx22o9Hn/8zzCfglO+8HK1SuOICZvwEccdbEiIu0nSiphMXJThd08MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078414; c=relaxed/simple;
	bh=jerZlZIqD/n4BQuav9w1m15qyc2xCEnPdzf61DRKMMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfbI8/yJvPv7aZ9t/d8sAP5h59M91x3rWwsrAI4dPsfeLA5lWcCcztxtU00qsvcuOOWolRZOa7snceQ0tmuIoSudPMN04subh9ovTRV2iTxy8OA+R1FE1pxscmZatB9qsDuZOnUwQRU6EMXGRKGT/MCEkQGzJgAKJCCA7/adjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQxFWGLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3876EC116C6;
	Thu, 22 Jan 2026 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078413;
	bh=jerZlZIqD/n4BQuav9w1m15qyc2xCEnPdzf61DRKMMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aQxFWGLDBNUB2mi34nH4e1GXbCq264QWgz8ZbEB88Hfo9fsUegPTxcQq/mS79xoDn
	 +yoKIm3IuWY6EzrTcVffYVR+iHDDpecohmQvBCdLRwGkhmEovW3IBpwj5YPch1r2zd
	 5V6xI19r2Piq2QIjjBH9Wfuz/iJtzJN+OxvzPN5kC6qfj9bI0JP7GGtfqTLmD2gSCb
	 BBIs0Kxo/ZRyq4xyQKCef3NnuiKQF9xcKfooUUWdpreRrdgpNEbi/xeMx7fuH+T3Qp
	 FsLA8rLMbbdaBcMsTHo2q2Nwy0plDbzy6e3Aj0kfcRKG2Fs9hZPzsLvWA3gy9srqT/
	 jVQazUW6PU2rg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:39:47 +0100
Subject: [PATCH mt76 v2 03/17] wifi: mt76: always enable RRO queues for
 non-MT7992 chipset
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-3-2374614c0de6@kernel.org>
References: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
In-Reply-To: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Kang Yang <kang.yang@airoha.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31064-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: 748BA6581D
X-Rspamd-Action: no action

MT7990 NPU binary requires to initialize NPU desc_base after configuring
ring_size. This is a preliminary patch to enable NPU offload for MT7996
(Eagle) chipset.

Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 893ac14285cab3c22f70945d490627a64b643efe..f5c6bb94ccbbda6afe03b24cf245b30c797e855d 100644
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


