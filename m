Return-Path: <linux-wireless+bounces-31074-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNz9LlcBcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31074-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:52:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D1E65891
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D76C5C828B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C923F074A;
	Thu, 22 Jan 2026 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABbg1rd3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCAE2571B0
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078439; cv=none; b=B605WpboDpuEO5L3LW0w2FhfaF+uX/cn5hzDOEumFsLArlFEQ+osPY6C5dMRkG7Bc4YiF3iGz6gAuRCTode3dTYjqSi7B5sAdo7w80doUjp3r+MtYcPbNwkKRGucDdtsBo8cxSCe990NJcVlMwnNYBv05fwP4mzBEcqBuq1xdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078439; c=relaxed/simple;
	bh=tFzAvVC+OlZ0dgOfKIpcbq6JqJ96VvuvXp19jvWZlXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=byOSasYsbfP37zGUnvbXvSKWpywnnnTbQZ/GtoRY1rA0h/vn8Lcl+73LSQNWf3SuCWdTGiYY4lfTsHRAL38vyPBtHfRsC1hixHQtiZ/ROLqnUZqRR/cFizrWHlFA26ub5ebVphUP1HKhWa8pZowqbhYYnNTt5AQoH/Sk/S4hDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABbg1rd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788D3C116C6;
	Thu, 22 Jan 2026 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078438;
	bh=tFzAvVC+OlZ0dgOfKIpcbq6JqJ96VvuvXp19jvWZlXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ABbg1rd38mhgBWXgcoqJIhmetmigaZ7y28dL6MvXNd89lo+z9gEGhLBg2qYgeCfFn
	 gRmnrdKr9byglTSUfaGT+4OdPyvfiMS1MwgUnnIcQ7Y/HPlSsb/EU0bnyikyGb7MHK
	 oay4tTy0ZMcj3186wkG2iRTyQDJdpyh0rkQC8PXcDmxF4MNeRsATerqUiBid5uwhSF
	 D9QNVbm/W8PHfXoWsfTe66la+aVrx+7JK+lZ5yeg4a6wYQplYts0beNI4y0VJcbUDD
	 HCaMSDWLo4jj/MA0aQ8g+puKtHeMg5Noe0v3rKMQSF23sBCruJyi+wM2oz/m3Es3E7
	 gahmO2s85fFFw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:39:57 +0100
Subject: [PATCH mt76 v2 13/17] wifi: mt76: mt7996: Move RRO dma start in a
 dedicated routine
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-13-2374614c0de6@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31074-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 75D1E65891
X-Rspamd-Action: no action

This is a preliminary patch to properly enable NPU offloading for MT7996
chipset since NPU initialization must be completed before kicking rx
queues.

Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    | 69 ++++++++++++----------
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |  2 +
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  1 +
 3 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 07212d93bc62df69720963f5ba04090bc82003fc..1a4f5f5b2a8435933070bb7d8feab26a0c174922 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -521,7 +521,7 @@ static void mt7996_dma_enable(struct mt7996_dev *dev, bool reset)
 int mt7996_dma_rro_init(struct mt7996_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
-	u32 irq_mask, size;
+	u32 size;
 	int ret;
 
 	if (dev->mt76.hwrro_mode == MT76_HWRRO_V3_1) {
@@ -548,7 +548,8 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 			mt76_queue_reset(dev, &mdev->q_rx[MT_RXQ_RRO_RXDMAD_C],
 					 true);
 		}
-		goto start_hw_rro;
+
+		return 0;
 	}
 
 	/* ind cmd */
@@ -615,43 +616,49 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 			return ret;
 	}
 
-start_hw_rro:
-	if (mtk_wed_device_active(&mdev->mmio.wed)) {
-		irq_mask = mdev->mmio.irqmask |
+	return 0;
+}
+
+void mt7996_dma_rro_start(struct mt7996_dev *dev)
+{
+	u32 irq_mask;
+
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
+		irq_mask = dev->mt76.mmio.irqmask |
 			   MT_INT_TX_DONE_BAND2;
 
 		mt76_wr(dev, MT_INT_MASK_CSR, irq_mask);
-		mtk_wed_device_start_hw_rro(&mdev->mmio.wed, irq_mask, false);
+		mtk_wed_device_start_hw_rro(&dev->mt76.mmio.wed, irq_mask,
+					    false);
 		mt7996_irq_enable(dev, irq_mask);
-	} else {
-		if (is_mt7996(&dev->mt76)) {
-			mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND1,
-					   mt76_dma_rx_poll);
-			mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND2,
-					   mt76_dma_rx_poll);
-			mt76_queue_rx_init(dev, MT_RXQ_RRO_BAND2,
-					   mt76_dma_rx_poll);
-		} else {
-			mt76_queue_rx_init(dev, MT_RXQ_RRO_BAND1,
-					   mt76_dma_rx_poll);
-		}
+		return;
+	}
 
-		mt76_queue_rx_init(dev, MT_RXQ_RRO_BAND0, mt76_dma_rx_poll);
-		if (dev->mt76.hwrro_mode == MT76_HWRRO_V3_1) {
-			mt76_queue_rx_init(dev, MT_RXQ_RRO_RXDMAD_C,
-					   mt76_dma_rx_poll);
-		} else {
-			mt76_queue_rx_init(dev, MT_RXQ_RRO_IND,
-					   mt76_dma_rx_poll);
-			mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND0,
-					   mt76_dma_rx_poll);
-		}
+	if (is_mt7996(&dev->mt76)) {
+		mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND1,
+				   mt76_dma_rx_poll);
+		mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND2,
+				   mt76_dma_rx_poll);
+		mt76_queue_rx_init(dev, MT_RXQ_RRO_BAND2,
+				   mt76_dma_rx_poll);
+	} else {
+		mt76_queue_rx_init(dev, MT_RXQ_RRO_BAND1,
+				   mt76_dma_rx_poll);
+	}
 
-		if (!mt76_npu_device_active(&dev->mt76))
-			mt7996_irq_enable(dev, MT_INT_RRO_RX_DONE);
+	mt76_queue_rx_init(dev, MT_RXQ_RRO_BAND0, mt76_dma_rx_poll);
+	if (dev->mt76.hwrro_mode == MT76_HWRRO_V3_1) {
+		mt76_queue_rx_init(dev, MT_RXQ_RRO_RXDMAD_C,
+				   mt76_dma_rx_poll);
+	} else {
+		mt76_queue_rx_init(dev, MT_RXQ_RRO_IND,
+				   mt76_dma_rx_poll);
+		mt76_queue_rx_init(dev, MT_RXQ_MSDU_PAGE_BAND0,
+				   mt76_dma_rx_poll);
 	}
 
-	return 0;
+	if (!mt76_npu_device_active(&dev->mt76))
+		mt7996_irq_enable(dev, MT_INT_RRO_RX_DONE);
 }
 
 int mt7996_dma_init(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 526a2cb298fd7f9dc8d0fcdd8de0e4071c07338f..de4ae79073fbfe364994d5284ee19ee652bda6c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1721,6 +1721,8 @@ int mt7996_register_device(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
+	mt7996_dma_rro_start(dev);
+
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
 				   ARRAY_SIZE(mt76_rates));
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 3928e059fd2a41aa7d4aa41b0d303b0763384523..a823292814ee589070fb5930a70a16d165855300 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -879,6 +879,7 @@ int mt7996_mtk_init_debugfs(struct mt7996_phy *phy, struct dentry *dir);
 #endif
 
 int mt7996_dma_rro_init(struct mt7996_dev *dev);
+void mt7996_dma_rro_start(struct mt7996_dev *dev);
 
 #ifdef CONFIG_MT7996_NPU
 int __mt7996_npu_hw_init(struct mt7996_dev *dev);

-- 
2.52.0


