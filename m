Return-Path: <linux-wireless+bounces-35313-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPolM1sb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35313-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDDD46794B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F4208300E248
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB004303A0D;
	Sat, 25 Apr 2026 19:51:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9D303C83
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146709; cv=none; b=bM+g2JP226JaprkV8yg06uNUck8jtUlUDtog9O/ZQKrMfCotPBh3bNVDi319hcgfY/jEmki+9J3d+1U2bMPOdUeXwNSKxPWpcFcW5Hlva4rNMyVe+CSyTIWaXy1jc8CR/VuLhqVV6HajW+Ej2DXMm4M7MmTnbnNLJsWtlIFIBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146709; c=relaxed/simple;
	bh=MKRBKsrZY5CgS9oYa1NeMQ1VfjR6cclWa7EtviGbrag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psLq5AYJt6B2tRYEh5t7fKfUNEgdzzHB+Xb1OumH4t6h1pQLo9Aw6lhV+b5lWryboK9GE9sDw2Jaa1ejobaVhREEpqGprzvkSeZaHC+a3xPYu5xiQfXMlmy+DfKFHneGGhF3IjDGTT43jMWpXNsTVjpqPp/3r10p8fhhZixgSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dcdaf06498so3473109a34.2
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146707; x=1777751507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l7nWpwAKhQ8b/YmLD8HtlKqkkqVHFMcOQws53Dclzw8=;
        b=lt6X9xdQKFNMvMENyI9kHpk8BzH+CIOn5AMbQp12MzWejV/ot7KObglGJ70eLR/hWt
         scApCgzhTLB1vlp4ZxtsrfMr+5OVfVfo3NAnAMVkxSHC+A2oHIyAWK8FPY7JfCv7FDtY
         lnxQ8cyUWFm6qJooAhVkhpTkbvY5SD+vfgDE7/oeDt0ERXTuxzehnkMB6KL8yqfSLtDE
         C+OOCKOlE60zY/YUSE5pUnP/VICj51IfMmgMKhPGVe25Tv8fBus5k0PedV1biTlSLf/O
         zy047udVd2zR5MGGSqgXMXSCeD9te0J7GH8v5efVc46rJ7yH1u5bQg2MUX7ZQ9frc1cl
         HU5Q==
X-Gm-Message-State: AOJu0YzMUyJQpGTS+e7mpJ2E4NXdefOhUuRNvrSwwcTYx334S18oueuC
	H3CEPfMOvI9S3jbHYvH9yE6XbRcKg3HPAQ+6WKFWaelSyHRKqG7caS7O
X-Gm-Gg: AeBDieseWQv17H2bq47MjRE7oZw+KFt0RApfkWt346X7P+QDYlYACpWHrYk4BqIisdS
	oMkIopdUML/OrwGgaIoBscsIra6lh9M7KyXZjga8YG/6oQaaCjujF30UIyduWzZ987gXzkSTexP
	aPfrU61fdaPTUafwBCA24w4vrsxtmLzA6OFGZ46juhwrYjTR8zAgZhzrX2V4QswdgbseQrEgDr+
	hQmEfFJObz/maw8Ct6ZFq5pdiHUU6Dscz5wbEM6UJ4SvKD1aPks6AMtufWCrG6xneadJrcqKjWe
	MqU5O/E4BO3HjP+wH0mJWbSNrSEylkO+Kf9dZiGdrDLYuHAdtYef7t3Pd9VugBxfE26ZetVdtCd
	dJ1bcKL1h9xdsZlflHphIbqXV5odHfcMRnvBhx+mZ167T1Y6o0a0rYHAz0DLHhfCK7DgUyUywGH
	V2nnnPAxPrNIv8MpwrIyM6YmJi0eL92bNOUh/CTb7mf3uXpi8ex1WZOMlGefMVg5LqeVIOr99sB
	Q==
X-Received: by 2002:a05:6830:640a:b0:7dc:d587:af3 with SMTP id 46e09a7af769-7dcd58710abmr16318429a34.23.1777146707482;
        Sat, 25 Apr 2026 12:51:47 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:46 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Javier Tia <floss@jetm.me>
Subject: [PATCH v5 16/21] wifi: mt76: mt792x: add MT7927-specific PCIe DMA support
Date: Sat, 25 Apr 2026 14:50:06 -0500
Message-ID: <20260425195011.790265-17-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: 4FDDD46794B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35313-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

Add the MT7927-specific PCIe DMA queue layout and local DMA setup,
including the extra RX ring and WFDMA/prefetch programming.

MT7927 does not follow the mt7925 DMA configuration, so provide a
separate DMA init path while reusing the existing common queue setup.

This keeps the chip-specific changes local and prepares the driver
for later MT7927 enablement without affecting existing devices.

Co-developed-by: Javier Tia <floss@jetm.me>
Signed-off-by: Javier Tia <floss@jetm.me>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7925/mt7925.h    | 13 +++++
 .../net/wireless/mediatek/mt76/mt7925/pci.c   | 53 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt792x_dma.c   | 41 +++++++++++++-
 .../net/wireless/mediatek/mt76/mt792x_regs.h  |  9 ++++
 4 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 46b480f7d813..984be40ca76d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -126,6 +126,19 @@ enum mt7925_rxq_id {
 	MT7925_RXQ_MCU_WM2, /* for tx done */
 };
 
+enum mt7927_txq_id {
+	MT7927_TXQ_BAND0 = MT7925_TXQ_BAND0,
+	MT7927_TXQ_BAND1 = MT7925_TXQ_BAND1,
+	MT7927_TXQ_MCU_WM = MT7925_TXQ_MCU_WM,
+	MT7927_TXQ_FWDL = MT7925_TXQ_FWDL,
+};
+
+enum mt7927_rxq_id {
+	MT7927_RXQ_BAND0 = 4,
+	MT7927_RXQ_MCU_WM = 6,
+	MT7927_RXQ_DATA2 = 7,
+};
+
 enum {
 	MODE_OPEN = 0,
 	MODE_SHARED = 1,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 39c663687c3c..7455cf7eddc5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -228,6 +228,51 @@ static const struct mt792x_dma_layout mt7925_dma_layout = {
 				   MT_RX_DATA_RING_BASE),
 };
 
+static const struct mt792x_dma_layout mt7927_dma_layout = {
+	.tx_data0 = mt792x_dma_ring(MT7927_TXQ_BAND0,
+				    MT7925_TX_RING_SIZE,
+				    MT_TX_RING_BASE),
+	.tx_mcu = mt792x_dma_ring(MT7927_TXQ_MCU_WM,
+				  MT7925_TX_MCU_RING_SIZE,
+				  MT_TX_RING_BASE),
+	.tx_fwdl = mt792x_dma_ring(MT7927_TXQ_FWDL,
+				   MT7925_TX_FWDL_RING_SIZE,
+				   MT_TX_RING_BASE),
+	.rx_mcu = mt792x_dma_ring(MT7927_RXQ_MCU_WM,
+				  MT7925_RX_MCU_RING_SIZE,
+				  MT_RX_EVENT_RING_BASE),
+	.rx_data = mt792x_dma_ring(MT7927_RXQ_BAND0,
+				   MT7925_RX_RING_SIZE,
+				   MT_RX_DATA_RING_BASE),
+};
+
+static int mt7927_dma_init(struct mt792x_dev *dev)
+{
+	int ret;
+
+	ret = mt792x_dma_alloc_queues(dev, &mt7927_dma_layout);
+	if (ret)
+		return ret;
+
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
+			       MT7927_RXQ_DATA2,
+			       MT7925_RX_MCU_RING_SIZE,
+			       MT_RX_BUF_SIZE,
+			       MT_RX_DATA_RING_BASE);
+	if (ret)
+		return ret;
+
+	ret = mt76_init_queues(dev, mt792x_poll_rx);
+	if (ret < 0)
+		return ret;
+
+	netif_napi_add_tx(dev->mt76.tx_napi_dev, &dev->mt76.tx_napi,
+			  mt792x_poll_tx);
+	napi_enable(&dev->mt76.tx_napi);
+
+	return mt792x_dma_enable(dev);
+}
+
 static int mt7925_dma_init(struct mt792x_dev *dev)
 {
 	int ret;
@@ -406,7 +451,13 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_dev;
 
-	ret = mt7925_dma_init(dev);
+	if (is_mt7927(&dev->mt76))
+		ret = mt7927_dma_init(dev);
+	else if (is_mt7925(&dev->mt76))
+		ret = mt7925_dma_init(dev);
+	else
+		ret = -EINVAL;
+
 	if (ret)
 		goto err_free_irq;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 7b36f0761dd1..fc326447c792 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -169,9 +169,39 @@ static void mt7925_wfdma_setup(struct mt792x_dev *dev)
 	mt76_set(dev, MT_WFDMA0_INT_TX_PRI, 0x7F00);
 }
 
+static void mt7927_dma_prefetch_setup(struct mt792x_dev *dev)
+{
+	mt76_wr(dev, MT_WFDMA_PREFETCH_CTRL,
+		mt76_rr(dev, MT_WFDMA_PREFETCH_CTRL));
+	mt76_wr(dev, MT_WFDMA_PREFETCH_CFG0, 0x660077);
+	mt76_wr(dev, MT_WFDMA_PREFETCH_CFG1, 0x1100);
+	mt76_wr(dev, MT_WFDMA_PREFETCH_CFG2, 0x30004f);
+	mt76_wr(dev, MT_WFDMA_PREFETCH_CFG3, 0x542200);
+	mt76_wr(dev, MT_WFDMA0_RX_RING4_EXT_CTRL, PREFETCH(0x0000, 0x8));
+	mt76_wr(dev, MT_WFDMA0_RX_RING6_EXT_CTRL, PREFETCH(0x0080, 0x8));
+	mt76_wr(dev, MT_WFDMA0_RX_RING7_EXT_CTRL, PREFETCH(0x0100, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING16_EXT_CTRL, PREFETCH(0x0140, 0x4));
+	mt76_wr(dev, MT_WFDMA0_TX_RING15_EXT_CTRL, PREFETCH(0x0180, 0x10));
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, PREFETCH(0x0280, 0x4));
+}
+
+static void mt7927_wfdma_setup(struct mt792x_dev *dev)
+{
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_ADDR_EXT_EN |
+		 MT_WFDMA0_GLO_CFG_FW_DWLD_BYPASS_DMASHDL);
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_CSR_LBK_RX_Q_SEL_EN);
+	mt76_rmw(dev, MT_WFDMA0_GLO_CFG_EXT1, BIT(28), BIT(28));
+	mt76_set(dev, MT_WFDMA0_INT_RX_PRI, 0x0F00);
+	mt76_set(dev, MT_WFDMA0_INT_TX_PRI, 0x7F00);
+}
+
 static void mt792x_dma_prefetch(struct mt792x_dev *dev)
 {
-	if (is_mt7925(&dev->mt76)) {
+	if (is_mt7927(&dev->mt76)) {
+		mt7927_dma_prefetch_setup(dev);
+	} else if (is_mt7925(&dev->mt76)) {
 		mt7925_dma_prefetch_setup(dev);
 	} else if (is_mt7902(&dev->mt76)) {
 		/* rx ring */
@@ -236,7 +266,9 @@ int mt792x_dma_enable(struct mt792x_dev *dev)
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
-	if (is_mt7925(&dev->mt76))
+	if (is_mt7927(&dev->mt76))
+		mt7927_wfdma_setup(dev);
+	else if (is_mt7925(&dev->mt76))
 		mt7925_wfdma_setup(dev);
 
 	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
@@ -349,6 +381,11 @@ int mt792x_dma_disable(struct mt792x_dev *dev, bool force)
 				 MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1))
 		return -ETIMEDOUT;
 
+	if (is_mt7927(&dev->mt76)) {
+		mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
+		mt76_wr(dev, MT_WFDMA0_RST_DRX_PTR, ~0);
+	}
+
 	/* disable dmashdl */
 	mt76_clear(dev, MT_WFDMA0_GLO_CFG_EXT0,
 		   MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 17504ef8e80d..4cd5b33b640e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -301,7 +301,9 @@
 #define MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
 #define MT_WFDMA0_GLO_CFG_RX_WB_DDONE	BIT(13)
 #define MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN BIT(15)
+#define MT_WFDMA0_GLO_CFG_CSR_LBK_RX_Q_SEL_EN	BIT(20)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
+#define MT_WFDMA0_GLO_CFG_ADDR_EXT_EN		BIT(26)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO	BIT(27)
 #define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO	BIT(28)
 #define MT_WFDMA0_GLO_CFG_CLK_GAT_DIS	BIT(30)
@@ -368,6 +370,13 @@
 #define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR(0x44)
 #define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY	BIT(0)
 
+#define MT_WFDMA_PREFETCH_CTRL		MT_WFDMA_EXT_CSR(0x30)
+#define MT_WFDMA_PREFETCH_CFG0		MT_WFDMA_EXT_CSR(0xf0)
+#define MT_WFDMA_PREFETCH_CFG1		MT_WFDMA_EXT_CSR(0xf4)
+#define MT_WFDMA_PREFETCH_CFG2		MT_WFDMA_EXT_CSR(0xf8)
+#define MT_WFDMA_PREFETCH_CFG3		MT_WFDMA_EXT_CSR(0xfc)
+#define MT_WFDMA0_GLO_CFG_EXT1		MT_WFDMA0(0x2b4)
+
 #define MT_SWDEF_BASE			0x41f200
 #define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
 #define MT_SWDEF_MODE			MT_SWDEF(0x3c)
-- 
2.43.0


