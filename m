Return-Path: <linux-wireless+bounces-35312-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPLJBk8b7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35312-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ACC467936
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 540433004DCE
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8D8303A0D;
	Sat, 25 Apr 2026 19:51:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21C303C83
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146701; cv=none; b=OFmf1A325hj0DJreYqyIiPK/8aQDwjI+RJKdYgPn4qr7qwBp9TdRcsuGxmRcjG2OIUxeP16hWTo7XxqqS6q11Udx0l4Vd3Be/zDcMq1Au3KkfFyJiPzj4LC9RM8OIuD6n4x1OuaXN4t77puwcGhNsveBIYMeb6ZDa5EqPMcQpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146701; c=relaxed/simple;
	bh=q3qmQm1FWIjpuSn0h8rrbh+e1MKYrhPALFTyuOiu4p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwVnqnWd0Iw1u1bK09rf2hgAd91VeTJrzhP0QnbTy+o2v3vEzB1k4/vXS+ZRxT88DRLEofOBbLMizo9lpklQidLS5yFmgoozPCHCSUMGnKdL79NZ0wgoVaU3ZTvOlq3xwzNnh3+J1CWX2iTa5raGBY2ju3SHc0Y+caGqAl2zEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dcdca9dd6cso4892021a34.3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146699; x=1777751499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=44qxgi71MvbrDUxdKmi1Cwa1db52LH7bUeo0SZ0+/JA=;
        b=eJXQsaRh3io0UKJTbvfWYx2H07opiA3LrsA1xCcY1WIYKzMXVqcIThh06au01S11Q8
         uCfAZgC+/dwj0AavbrjBg1MH5sgQGtuRYmZxSR6rowmJ6YV94ChO7ut9nb3/1v0+XoCL
         syISp9c2KlFxkPHGuHqu78fWJaL0HOeK1Daek1fXwHe8GIvUh9CFwBq0Jf1RkXFs9BcR
         GCvwJN4VZJnWgQN243WceQ82bP7aBMbhUl9l1DQKq3Cz/DSdorNuFl7V5B4o4B6HXTt+
         A12Pq3x27F5kDI8mMN7JFgFRqL63Ffmm1qE+ZYIGSh2H2yzFNcPjQQ+gZV6WQMnngdcC
         Bd0Q==
X-Gm-Message-State: AOJu0YzlH8kCT6XUe6jNRomCFXaPSYtB1GXriZgH6u1B459ZY9scq7jP
	FACGAoXhEUagfh8NPmnAeJMMs6STEAfBFGDvsuzXvQdVzwVVSWKc9u+N
X-Gm-Gg: AeBDiesNZpCVKVsaslS8oWe5+3y3lGS8tNEfH8BmBXaJkrkFKEtgB9uxg0cDknI1VO0
	9nkgMmtRPT6vU9sVxNsHJmDwLSEl7InO90X+pxb31CCEWx3f9Uvq6oEkPB81hnsX9U/DYwvKXiy
	O35ckJfekSTl2oTcfDRqhr13JczXlZyh/O0sSvLBLCVrTo+CwS0zruUq/g/kfe2vD3W6wHl2ND9
	wyiNGFAUTmljtuLcqLBqitop/0uH/7adwYT2X4XrD/pK188JeFSeg8oAlOw298kG7DyqN9T7wfD
	7IeXEErURHN/5iz1t350yXTtZ7ytZZlg+BopIK0MJ88hfXExLTaO2D9UM26dPe3aHg5EzX3egx3
	Sjz/0Ll5rvJKVKE1D6ClNhxT7SasdIYZjNmcD0TncFiR3OSHCLbXLhX11dgNkoFwmk3IqGKHXUE
	BkM4OivRDZV1RQjCSiLBdLupu/TCsXUBzomWeAW73EtyvP8htZcQXwyTpOKmM1Y2/VYgIhk5Whf
	w==
X-Received: by 2002:a05:6830:314a:b0:7d9:b189:d938 with SMTP id 46e09a7af769-7dc950e3ad5mr24699490a34.10.1777146699338;
        Sat, 25 Apr 2026 12:51:39 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:38 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 15/21] wifi: mt76: mt7925: switch DMA init to common mt792x queue helpers
Date: Sat, 25 Apr 2026 14:50:05 -0500
Message-ID: <20260425195011.790265-16-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0ACC467936
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35312-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

Convert mt7925 DMA init to use the common mt792x queue allocation
helper and isolate the mt7925-specific prefetch/WFDMA setup.

This removes duplicated DMA setup code and prepares the path for
follow-up chip-specific DMA support with smaller deltas.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/pci.c   | 57 +++++++------------
 .../net/wireless/mediatek/mt76/mt792x_dma.c   | 46 +++++++++------
 2 files changed, 48 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 1f05c212be02..39c663687c3c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -210,48 +210,29 @@ static u32 mt7925_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 	return dev->bus_ops->rmw(mdev, addr, mask, val);
 }
 
+static const struct mt792x_dma_layout mt7925_dma_layout = {
+	.tx_data0 = mt792x_dma_ring(MT7925_TXQ_BAND0,
+				    MT7925_TX_RING_SIZE,
+				    MT_TX_RING_BASE),
+	.tx_mcu = mt792x_dma_ring(MT7925_TXQ_MCU_WM,
+				  MT7925_TX_MCU_RING_SIZE,
+				  MT_TX_RING_BASE),
+	.tx_fwdl = mt792x_dma_ring(MT7925_TXQ_FWDL,
+				   MT7925_TX_FWDL_RING_SIZE,
+				   MT_TX_RING_BASE),
+	.rx_mcu = mt792x_dma_ring(MT7925_RXQ_MCU_WM,
+				  MT7925_RX_MCU_RING_SIZE,
+				  MT_RX_EVENT_RING_BASE),
+	.rx_data = mt792x_dma_ring(MT7925_RXQ_BAND0,
+				   MT7925_RX_RING_SIZE,
+				   MT_RX_DATA_RING_BASE),
+};
+
 static int mt7925_dma_init(struct mt792x_dev *dev)
 {
 	int ret;
 
-	mt76_dma_attach(&dev->mt76);
-
-	ret = mt792x_dma_disable(dev, true);
-	if (ret)
-		return ret;
-
-	/* init tx queue */
-	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7925_TXQ_BAND0,
-					 MT7925_TX_RING_SIZE,
-					 MT_TX_RING_BASE, NULL, 0);
-	if (ret)
-		return ret;
-
-	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, 0x4);
-
-	/* command to WM */
-	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM, MT7925_TXQ_MCU_WM,
-				  MT7925_TX_MCU_RING_SIZE, MT_TX_RING_BASE);
-	if (ret)
-		return ret;
-
-	/* firmware download */
-	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL, MT7925_TXQ_FWDL,
-				  MT7925_TX_FWDL_RING_SIZE, MT_TX_RING_BASE);
-	if (ret)
-		return ret;
-
-	/* rx event */
-	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
-			       MT7925_RXQ_MCU_WM, MT7925_RX_MCU_RING_SIZE,
-			       MT_RX_BUF_SIZE, MT_RX_EVENT_RING_BASE);
-	if (ret)
-		return ret;
-
-	/* rx data */
-	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
-			       MT7925_RXQ_BAND0, MT7925_RX_RING_SIZE,
-			       MT_RX_BUF_SIZE, MT_RX_DATA_RING_BASE);
+	ret = mt792x_dma_alloc_queues(dev, &mt7925_dma_layout);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index c52d0c85913c..7b36f0761dd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -144,21 +144,35 @@ int mt792x_dma_alloc_queues(struct mt792x_dev *dev,
 EXPORT_SYMBOL_GPL(mt792x_dma_alloc_queues);
 
 #define PREFETCH(base, depth)	((base) << 16 | (depth))
+
+static void mt7925_dma_prefetch_setup(struct mt792x_dev *dev)
+{
+	/* rx ring */
+	mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0000, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING1_EXT_CTRL, PREFETCH(0x0040, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL, PREFETCH(0x0080, 0x4));
+	mt76_wr(dev, MT_WFDMA0_RX_RING3_EXT_CTRL, PREFETCH(0x00c0, 0x4));
+
+	/* tx ring */
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x0100, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING1_EXT_CTRL, PREFETCH(0x0200, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING2_EXT_CTRL, PREFETCH(0x0300, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING3_EXT_CTRL, PREFETCH(0x0400, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING15_EXT_CTRL, PREFETCH(0x0500, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x0540, 0x4));
+}
+
+static void mt7925_wfdma_setup(struct mt792x_dev *dev)
+{
+	mt76_rmw(dev, MT_UWFDMA0_GLO_CFG_EXT1, BIT(28), BIT(28));
+	mt76_set(dev, MT_WFDMA0_INT_RX_PRI, 0x0F00);
+	mt76_set(dev, MT_WFDMA0_INT_TX_PRI, 0x7F00);
+}
+
 static void mt792x_dma_prefetch(struct mt792x_dev *dev)
 {
 	if (is_mt7925(&dev->mt76)) {
-		/* rx ring */
-		mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0000, 0x4));
-		mt76_wr(dev, MT_WFDMA0_RX_RING1_EXT_CTRL, PREFETCH(0x0040, 0x4));
-		mt76_wr(dev, MT_WFDMA0_RX_RING2_EXT_CTRL, PREFETCH(0x0080, 0x4));
-		mt76_wr(dev, MT_WFDMA0_RX_RING3_EXT_CTRL, PREFETCH(0x00c0, 0x4));
-		/* tx ring */
-		mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x0100, 0x10));
-		mt76_wr(dev, MT_WFDMA0_TX_RING1_EXT_CTRL, PREFETCH(0x0200, 0x10));
-		mt76_wr(dev, MT_WFDMA0_TX_RING2_EXT_CTRL, PREFETCH(0x0300, 0x10));
-		mt76_wr(dev, MT_WFDMA0_TX_RING3_EXT_CTRL, PREFETCH(0x0400, 0x10));
-		mt76_wr(dev, MT_WFDMA0_TX_RING15_EXT_CTRL, PREFETCH(0x0500, 0x4));
-		mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x0540, 0x4));
+		mt7925_dma_prefetch_setup(dev);
 	} else if (is_mt7902(&dev->mt76)) {
 		/* rx ring */
 		mt76_wr(dev, MT_WFDMA0_RX_RING0_EXT_CTRL, PREFETCH(0x0000, 0x4));
@@ -222,11 +236,9 @@ int mt792x_dma_enable(struct mt792x_dev *dev)
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
-	if (is_mt7925(&dev->mt76)) {
-		mt76_rmw(dev, MT_UWFDMA0_GLO_CFG_EXT1, BIT(28), BIT(28));
-		mt76_set(dev, MT_WFDMA0_INT_RX_PRI, 0x0F00);
-		mt76_set(dev, MT_WFDMA0_INT_TX_PRI, 0x7F00);
-	}
+	if (is_mt7925(&dev->mt76))
+		mt7925_wfdma_setup(dev);
+
 	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 
 	/* enable interrupts for TX/RX rings */
-- 
2.43.0


