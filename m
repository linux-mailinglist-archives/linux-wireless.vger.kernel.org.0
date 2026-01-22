Return-Path: <linux-wireless+bounces-31077-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDpXGSMCcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31077-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:55:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F0C658FB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAF494AA373
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CBC421895;
	Thu, 22 Jan 2026 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYNJL3E3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF2355044
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078448; cv=none; b=gAb3eZyGAM8JFfUumo/W4kvUHa//61OEhLdGMFD8FDwYqQG1AP/nFASj3ayIcD6w0GTY77kyWaNLBSEP7xbCoUhgyYLCRRrdod/yXbWk/3X0xmxS7mbtjCB0/o8MtbkzEVF4/PQ+MPrlvYkmcJOq7zEIr0AVhY+PkageLCO7YwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078448; c=relaxed/simple;
	bh=GnGL7E+7P909aX4G+BaWU6tM9ToZknyZMbSj5MwV5v0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c009eCaB5XtKQv4U9GULEtTS7it+RhZ6JfqoVgzibklrtryf/qTazY3S8aQB3ouEyvW4J0h+sRDAYNZsh/Jbgqk91HRHUnZgO790Fa57u5+e1GdtFkrr4wXhXkMcr4EXyONzMUhVPnHdMOm+jFUMEiwOBI+JfJx1SfCWxkinApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYNJL3E3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D21C116C6;
	Thu, 22 Jan 2026 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078446;
	bh=GnGL7E+7P909aX4G+BaWU6tM9ToZknyZMbSj5MwV5v0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VYNJL3E3dv0C0qzK1C2rcZ8ZD804rHK9TPyhxPwoalYPrpbKcpYeT7x0IHQArespV
	 nZ3D/pveDlXmrrzfUAtvdlPp2OzIewnpSDrZ8mQuzilOJfOBP6b0lDz4P7I4mi6+er
	 wBaqDH1kdz4aEDzCYy4fSje/c6FZlIBttVY2T7QIaYhLRjphxzVhiNhNq0QTrtL3ZA
	 IuF8797FwKFkv9YOmxNaeMOxGUgkBanhxjxwjLrnygYrH6rEJmFiSSs/fuVlzWwZbj
	 2bgOjJe66DrrtSVTRab0oLZX/HEa+0kU9aqSaeJwuezkYxZXz1Puzdz9FR8zJfqkWi
	 f439elYzbKKfg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:40:00 +0100
Subject: [PATCH mt76 v2 16/17] wifi: mt76: mt7996: Store DMA mapped buffer
 addresses in mt7996_npu_hw_init()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-16-2374614c0de6@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31077-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: 15F0C658FB
X-Rspamd-Action: no action

In order to not always reallocate them during NPU reset, store the DMA
mapped buffer addresses allocated by mt7996_npu_hw_init routine in
mt7996 structure.

Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  4 ++
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c    | 58 +++++++++++++---------
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index a823292814ee589070fb5930a70a16d165855300..195e8ab7876caba602fb520dff8cfdd78bb495dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -31,6 +31,8 @@
 #define MT7996_RX_MCU_RING_SIZE_WA	1024
 #define MT7996_NPU_TX_RING_SIZE		1024
 #define MT7996_NPU_RX_RING_SIZE		1024
+#define MT7996_NPU_TXD_SIZE		3
+
 /* scatter-gather of mcu event is not supported in connac3 */
 #define MT7996_RX_MCU_BUF_SIZE		(2048 + \
 					 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
@@ -475,6 +477,8 @@ struct mt7996_dev {
 		struct list_head page_map[MT7996_RRO_MSDU_PG_HASH_SIZE];
 	} wed_rro;
 
+	dma_addr_t npu_txd_addr[2 * MT7996_NPU_TXD_SIZE];
+
 	bool ibf;
 	u8 fw_debug_wm;
 	u8 fw_debug_wa;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
index 7941996891c88333d121e4c739001ea19bff94c9..897918a31b162679c9e133c93894fa88b5a75f6a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
@@ -344,12 +344,14 @@ static int mt7996_npu_txd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
 		MT_BAND0,
 		is_mt7996(&dev->mt76) ? MT_BAND2 : MT_BAND1,
 	};
-	int i;
+	int i, index = 0;
+
+	BUILD_BUG_ON(ARRAY_SIZE(band_list) * 3 !=
+		     ARRAY_SIZE(dev->npu_txd_addr));
 
 	for (i = 0; i < ARRAY_SIZE(band_list); i++) {
 		int err, band = band_list[i], phy_id;
-		dma_addr_t dma_addr;
-		u32 val, size;
+		u32 val;
 
 		err = mt76_npu_get_msg(npu, band + 5,
 				       WLAN_FUNC_GET_WAIT_RXDESC_BASE,
@@ -364,43 +366,29 @@ static int mt7996_npu_txd_init(struct mt7996_dev *dev, struct airoha_npu *npu)
 					       : band;
 		writel(val, &dev->mt76.phys[phy_id]->q_tx[0]->regs->desc_base);
 
-		size = is_mt7996(&dev->mt76) ? band == MT_BAND2
-					     ? MT7996_NPU_TX_RING_SIZE
-					     : MT7996_NPU_RX_RING_SIZE / 2
-					     : MT7996_TX_RING_SIZE;
-		if (!dmam_alloc_coherent(dev->mt76.dma_dev, 256 * size,
-					 &dma_addr, GFP_KERNEL))
-			return -ENOMEM;
-
 		err = mt76_npu_send_msg(npu, band,
 					WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
-					dma_addr, GFP_KERNEL);
+					dev->npu_txd_addr[index++], GFP_KERNEL);
 		if (err) {
 			dev_warn(dev->mt76.dev,
 				 "failed setting NPU wlan queue buf addr\n");
 			return err;
 		}
 
-		if (!dmam_alloc_coherent(dev->mt76.dma_dev, 256 * size,
-					 &dma_addr, GFP_KERNEL))
-			return -ENOMEM;
-
 		err = mt76_npu_send_msg(npu, band + 5,
 					WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
-					dma_addr, GFP_KERNEL);
+					dev->npu_txd_addr[index++],
+					GFP_KERNEL);
 		if (err) {
 			dev_warn(dev->mt76.dev,
 				 "failed setting NPU wlan tx buf addr\n");
 			return err;
 		}
 
-		if (!dmam_alloc_coherent(dev->mt76.dma_dev, 256 * 1024,
-					 &dma_addr, GFP_KERNEL))
-			return -ENOMEM;
-
 		err = mt76_npu_send_msg(npu, band + 10,
 					WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
-					dma_addr, GFP_KERNEL);
+					dev->npu_txd_addr[index++],
+					GFP_KERNEL);
 		if (err) {
 			dev_warn(dev->mt76.dev,
 				 "failed setting NPU wlan tx buf base\n");
@@ -570,7 +558,31 @@ int __mt7996_npu_hw_init(struct mt7996_dev *dev)
 
 int mt7996_npu_hw_init(struct mt7996_dev *dev)
 {
-	int err;
+	int i, err;
+
+	BUILD_BUG_ON(ARRAY_SIZE(dev->npu_txd_addr) % 3);
+
+	for (i = 0; i < ARRAY_SIZE(dev->npu_txd_addr); i += 3) {
+		int band = i && is_mt7996(&dev->mt76) ? MT_BAND2 : MT_BAND0;
+		u32 size = is_mt7996(&dev->mt76) ? band == MT_BAND2
+						 ? MT7996_NPU_TX_RING_SIZE
+						 : MT7996_NPU_RX_RING_SIZE / 2
+						 : MT7996_TX_RING_SIZE;
+
+		if (!dmam_alloc_coherent(dev->mt76.dma_dev, 256 * size,
+					 &dev->npu_txd_addr[i], GFP_KERNEL))
+			return -ENOMEM;
+
+		if (!dmam_alloc_coherent(dev->mt76.dma_dev, 256 * size,
+					 &dev->npu_txd_addr[i + 1],
+					 GFP_KERNEL))
+			return -ENOMEM;
+
+		if (!dmam_alloc_coherent(dev->mt76.dma_dev, 256 * 1024,
+					 &dev->npu_txd_addr[i + 2],
+					 GFP_KERNEL))
+			return -ENOMEM;
+	}
 
 	mutex_lock(&dev->mt76.mutex);
 	err = __mt7996_npu_hw_init(dev);

-- 
2.52.0


