Return-Path: <linux-wireless+bounces-26512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9CFB2FA34
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 15:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC04608207
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E9D334382;
	Thu, 21 Aug 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klXwLcoc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51E33437E
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782189; cv=none; b=XP/m+3bIJCTmuiRqd3d2PL0Z7cqgkjSmJaCUWa+vT6GA1oMUOt3NYNG6d/vnG2zYIOGGm2TZmGqaoOmDZTLSQKKA+csbwzed8Gmm7+msVMlC2MEtJajJBoWcRxqBdlJk0u84H+XZw9tWg8e2RZ2DFcbYmtlsdu0MGYAibwVOOOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782189; c=relaxed/simple;
	bh=E5jMdc8rmImRDhZaIyIfKaxVtOY7fQaCZZ5xTpZRPfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jMrUn2+rvokoBGdQ6V6yAfyn5ICaXce4MeYii05DCuvgz8qcCdjzdNE7yeUD5FXXYcnNew/tdQRzCcWElBTp2YyYiEIu13TrrLKJOA9Ls6jqI2cIFZkWv4Gncr3COt2bxwfqcvuSCtISJCU3Np7ISttF3T4CZL1korYQWBjIo8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klXwLcoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42179C4CEED;
	Thu, 21 Aug 2025 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782188;
	bh=E5jMdc8rmImRDhZaIyIfKaxVtOY7fQaCZZ5xTpZRPfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=klXwLcoczpITv64Kp5Z+LJUMogwcW9g8S9cb/0h88+tWl5AzU8teirOhnathGNFh0
	 E7zERgQrtzeCOss+mW3HCQrmoxr+VMMwpPrUHGDlhTiKVwAIphesWIQZomiD1WW3kl
	 McSVA5QhkEtFQ8wgxd7XQ0A782RarNeUW/Y10KB7CgCSMES27gXMqNaqd/pSAAYuhm
	 66xwbQs/JPvNiCCt2GXugc4fz/Ro7OyuYD14z/IGwJh7CFrNIqb/1Z+O7Iov27OuT1
	 BXpTUq//+nLrk9V4mHs/QV9stuRqxvf5KmgFmkbV2ZWINtgFVUNnQ2iYsxmQlDzkM/
	 3mR8ZSxOCkm9w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 21 Aug 2025 15:14:53 +0200
Subject: [PATCH mt76 01/14] wifi: mt76: Add reset_idx to reset_q
 mt76_queue_ops signature.
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-mt7996-rro-rework-v1-1-6c8477ad969f@kernel.org>
References: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
In-Reply-To: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Rex Lu <rex.lu@mediatek.com>, Benjamin Lin <benjamin-jw.lin@mediatek.com>
X-Mailer: b4 0.14.2

Remove __mt76_dma_queue_reset routine and use mt76_dma_queue_reset
directly instead in mt76_queue_ops struct.
This is a preliminary patch to enable WED support for MT7992 Kite
chipset supported by MT7996 driver.

Co-developed-by: Rex Lu <rex.lu@mediatek.com>
Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c        | 11 +++--------
 drivers/net/wireless/mediatek/mt76/dma.h        |  7 +++----
 drivers/net/wireless/mediatek/mt76/mt76.h       |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c |  4 ++--
 drivers/net/wireless/mediatek/mt76/wed.c        |  8 ++++----
 7 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 87f531297f8513b0caee2d034184ddd8fa3b6a21..25c26ff8c8e24352f2bb31c6e185e628a56f609b 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -197,8 +197,8 @@ mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 	q->tail = q->head;
 }
 
-void __mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
-			    bool reset_idx)
+void mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
+			  bool reset_idx)
 {
 	if (!q || !q->ndesc)
 		return;
@@ -218,11 +218,6 @@ void __mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
 	mt76_dma_sync_idx(dev, q);
 }
 
-void mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q)
-{
-	__mt76_dma_queue_reset(dev, q, true);
-}
-
 static int
 mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		    struct mt76_queue_buf *buf, void *data)
@@ -740,7 +735,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 			return 0;
 	}
 
-	mt76_dma_queue_reset(dev, q);
+	mt76_dma_queue_reset(dev, q, true);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/dma.h b/drivers/net/wireless/mediatek/mt76/dma.h
index e3ddc7a837579c0835a704ab8944099d276c6222..320d2cbbbd4559db146139a50e579b9b57282557 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.h
+++ b/drivers/net/wireless/mediatek/mt76/dma.h
@@ -81,14 +81,13 @@ void mt76_dma_attach(struct mt76_dev *dev);
 void mt76_dma_cleanup(struct mt76_dev *dev);
 int mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q,
 		     bool allow_direct);
-void __mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
-			    bool reset_idx);
-void mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q);
+void mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
+			  bool reset_idx);
 
 static inline void
 mt76_dma_reset_tx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
-	dev->queue_ops->reset_q(dev, q);
+	dev->queue_ops->reset_q(dev, q, true);
 	if (mtk_wed_device_active(&dev->mmio.wed))
 		mt76_wed_dma_setup(dev, q, true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8dd5c29fb75b5c0c879350f3af15b71f12630a96..623a33803dac08a578df2730ef8731fbafc6f84f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -290,7 +290,8 @@ struct mt76_queue_ops {
 
 	void (*kick)(struct mt76_dev *dev, struct mt76_queue *q);
 
-	void (*reset_q)(struct mt76_dev *dev, struct mt76_queue *q);
+	void (*reset_q)(struct mt76_dev *dev, struct mt76_queue *q,
+			bool reset_idx);
 };
 
 enum mt76_phy_type {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 0c62272fe7d03552c8c260b3971a62fb143895c1..009ef713f437983a0676ed5d4d951a9efcb305e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -624,13 +624,13 @@ int mt7915_dma_reset(struct mt7915_dev *dev, bool force)
 	}
 
 	for (i = 0; i < __MT_MCUQ_MAX; i++)
-		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
+		mt76_queue_reset(dev, dev->mt76.q_mcu[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		if (mt76_queue_is_wed_tx_free(&dev->mt76.q_rx[i]))
 			continue;
 
-		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
+		mt76_queue_reset(dev, &dev->mt76.q_rx[i], true);
 	}
 
 	mt76_tx_status_check(&dev->mt76, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 6f9db782338e6e405de49dd07fefae1a1de09f93..69217ce911307b3408a56d0a210b39ac3bc75e8c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -181,13 +181,13 @@ mt792x_dma_reset(struct mt792x_dev *dev, bool force)
 
 	/* reset hw queues */
 	for (i = 0; i < __MT_TXQ_MAX; i++)
-		mt76_queue_reset(dev, dev->mphy.q_tx[i]);
+		mt76_queue_reset(dev, dev->mphy.q_tx[i], true);
 
 	for (i = 0; i < __MT_MCUQ_MAX; i++)
-		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
+		mt76_queue_reset(dev, dev->mt76.q_mcu[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i)
-		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
+		mt76_queue_reset(dev, &dev->mt76.q_rx[i], true);
 
 	mt76_tx_status_check(&dev->mt76, true);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index c8bef0b2a14445224689efb4c0fee6c80387a7fa..c77e619070d34ddbf281a5d90c6c96cbd1bb2283 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -775,7 +775,7 @@ void mt7996_dma_reset(struct mt7996_dev *dev, bool force)
 	}
 
 	for (i = 0; i < __MT_MCUQ_MAX; i++)
-		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
+		mt76_queue_reset(dev, dev->mt76.q_mcu[i], true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
 		if (mtk_wed_device_active(&dev->mt76.mmio.wed))
@@ -783,7 +783,7 @@ void mt7996_dma_reset(struct mt7996_dev *dev, bool force)
 			    mt76_queue_is_wed_tx_free(&dev->mt76.q_rx[i]))
 				continue;
 
-		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
+		mt76_queue_reset(dev, &dev->mt76.q_rx[i], true);
 	}
 
 	mt76_tx_status_check(&dev->mt76, true);
diff --git a/drivers/net/wireless/mediatek/mt76/wed.c b/drivers/net/wireless/mediatek/mt76/wed.c
index 63f69e152b1cbb5bc0170a44976be1c7c52f21dc..907a8e43e72ad1f2a68d097c4a06df4506c4b039 100644
--- a/drivers/net/wireless/mediatek/mt76/wed.c
+++ b/drivers/net/wireless/mediatek/mt76/wed.c
@@ -118,7 +118,7 @@ int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
 	case MT76_WED_Q_TXFREE:
 		/* WED txfree queue needs ring to be initialized before setup */
 		q->flags = 0;
-		mt76_dma_queue_reset(dev, q);
+		mt76_dma_queue_reset(dev, q, true);
 		mt76_dma_rx_fill(dev, q, false);
 
 		ret = mtk_wed_device_txfree_ring_setup(q->wed, q->regs);
@@ -133,21 +133,21 @@ int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q, bool reset)
 		break;
 	case MT76_WED_RRO_Q_DATA:
 		q->flags &= ~MT_QFLAG_WED;
-		__mt76_dma_queue_reset(dev, q, false);
+		mt76_dma_queue_reset(dev, q, false);
 		mtk_wed_device_rro_rx_ring_setup(q->wed, ring, q->regs);
 		q->head = q->ndesc - 1;
 		q->queued = q->head;
 		break;
 	case MT76_WED_RRO_Q_MSDU_PG:
 		q->flags &= ~MT_QFLAG_WED;
-		__mt76_dma_queue_reset(dev, q, false);
+		mt76_dma_queue_reset(dev, q, false);
 		mtk_wed_device_msdu_pg_rx_ring_setup(q->wed, ring, q->regs);
 		q->head = q->ndesc - 1;
 		q->queued = q->head;
 		break;
 	case MT76_WED_RRO_Q_IND:
 		q->flags &= ~MT_QFLAG_WED;
-		mt76_dma_queue_reset(dev, q);
+		mt76_dma_queue_reset(dev, q, true);
 		mt76_dma_rx_fill(dev, q, false);
 		mtk_wed_device_ind_rx_ring_setup(q->wed, q->regs);
 		break;

-- 
2.50.1


