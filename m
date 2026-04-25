Return-Path: <linux-wireless+bounces-35311-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBhnI1Mb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35311-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A019467944
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D15C5300FB46
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7A303A0D;
	Sat, 25 Apr 2026 19:51:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FD7303C83
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146698; cv=none; b=Jbmv0CO7B6lhyfHXlaH67xE5qU9hA6zQvME1chuiFUPXi9w/xMaDeNCkBs+eEi81BjjlLn8fg8xnmtoJ9AkH/vd9AQxHSyTLKnb2+8igXOZZdkdVNM0jeyKa9DODyN3gQZ19COu4K83zSqxWngawHu8uMqjCE/Lh/ui+SK4EKhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146698; c=relaxed/simple;
	bh=aHepc+8Ye2g8reHGmbqp29eeWsxZ2lAvHxkld5u6WiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzmINzg42R616ld612sJDOhCqn5NpptDiqQJ48pNihTVP2j6SRsY8jHPKFTOsB+C4/qKPv7LeeA2i4OCVsrJfqkDqWPqzj81nbXFLayvJ4d0+8LnRLeWOCyACkvsiz+zvmk1m4klItjAzlyhRZLZ+mwAFDNTzuQEsaeyB8xkAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7de4ed0593fso1467057a34.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146696; x=1777751496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MKK1TQu05IOvJzqk2ZSwsaHyP8UgKdpSWF9oEwSI2Ks=;
        b=TlIpPFspM6tO1AOsvpx0zIi5HTZvBtrGLpxwSl/zinBdVr8TRFmryMfQNG3fE/+wCz
         yVu7v4Bi5ymlJg4XgzLJewKzww0UQTR8jMvMJ6llK0yOwlruyom5AM2IGMgT44rAkliB
         bb+jr3N8oDO8nOz9W9lYNJPMSvjqbecxHZug2pZ7gCfFc3LsX3EwguGx8YXhWoY9yeRh
         XIHiU6/B51KaXlzwElJTo5rvkwTM6yi3otpHqvJkUEWkR61XIB/dVqodOTJ7DScIGX3h
         NhMlUaNHldJYeboHSBG+0N0UWtPWeJ9+10riboMdI/8v/MSn7ou3qU6SvCY6Ka9cl7NJ
         8Zvw==
X-Gm-Message-State: AOJu0Yzl1yPhStFBOErDXIfNhe7iZO1GaZOmVbflQNl3dR7hDuY0NzEu
	ntIHfNFrcZ4LOd6hcZR/z+ba6TRNdXY0kZimqHUfNqDs1OXDSD/L491O
X-Gm-Gg: AeBDieuKob1hPCar6hkiyoeCm3OtQ2LqXoKKnr7JmDm3zjitCjnUFYrcOaDMFrUuo/M
	He94NwB43h9SXTIb906r6nCOianAuCZ1BOryTWXEQ9w5lWouyzmTCe2lcx2gClzUlfwX+qXxdoi
	LJiLSA7UmGVqd0WmBVVDR1l+708lHtG2iWh4HjU2lgzQwaBGIdhK0sRECP1qwXQ49JxBG6PYJSL
	lvr7ROv/HROc8wSHGtaEVWJLKV1Py3WIPhMmZ3GNLkbT7l48IL0IaavvU6HrlpLMrWv61aVzm+I
	oUl6HWWt7luGpoLFpP0HDtJnyyx/uQdn/sY7CBSENg1EeDLBqaT+1LNRLoDOT8s369+70pJXI3t
	rcrLkRPXYvJQbJZJnHwNF1nzYVEftB/LGffSmlxfAdvggeUPXPlzYUygT7SfOaJfjPY2MvJf24c
	zPOub/aaD4CSV0NVJV3vOGTMM1Fpy3L0aktPD3c3ZX6nha7ALsEqrv2r0OvrcKuARPswXviCNTZ
	w==
X-Received: by 2002:a05:6830:3883:b0:7dc:db04:d30b with SMTP id 46e09a7af769-7dcdb04db39mr12370327a34.9.1777146695928;
        Sat, 25 Apr 2026 12:51:35 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:35 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 14/21] wifi: mt76: mt792x: factor out common DMA queue allocation
Date: Sat, 25 Apr 2026 14:50:04 -0500
Message-ID: <20260425195011.790265-15-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: 3A019467944
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35311-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

The mt792x PCIe DMA setup uses the same standard queue allocation
sequence for data, MCU, firmware download and RX rings.

Factor this part out into a small common helper so later chip support
can reuse the existing flow without duplicating the queue setup logic.

This keeps the common DMA skeleton in one place and makes follow-up
chip-specific DMA changes smaller and easier to review.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x.h   | 19 +++++++
 .../net/wireless/mediatek/mt76/mt792x_dma.c   | 56 +++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 09840483fe2a..59562567cc13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -206,6 +206,23 @@ struct mt792x_irq_map {
 	} rx;
 };
 
+struct mt792x_dma_ring {
+	u8 qid;
+	u16 n_desc;
+	u32 ring_base;
+};
+
+struct mt792x_dma_layout {
+	struct mt792x_dma_ring tx_data0;
+	struct mt792x_dma_ring tx_mcu;
+	struct mt792x_dma_ring tx_fwdl;
+	struct mt792x_dma_ring rx_data;
+	struct mt792x_dma_ring rx_mcu;
+};
+
+#define mt792x_dma_ring(_qid, _n_desc, _ring_base) \
+	{ .qid = (_qid), .n_desc = (_n_desc), .ring_base = (_ring_base) }
+
 #define mt792x_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
 #define mt792x_dev_reset(dev)		((dev)->hif_ops->reset(dev))
 #define mt792x_mcu_init(dev)		((dev)->hif_ops->mcu_init(dev))
@@ -421,6 +438,8 @@ void mt792x_sta_statistics(struct ieee80211_hw *hw,
 void mt792x_set_coverage_class(struct ieee80211_hw *hw, int radio_idx,
 			       s16 coverage_class);
 void mt792x_dma_cleanup(struct mt792x_dev *dev);
+int mt792x_dma_alloc_queues(struct mt792x_dev *dev,
+			    const struct mt792x_dma_layout *layout);
 int mt792x_dma_enable(struct mt792x_dev *dev);
 int mt792x_wpdma_reset(struct mt792x_dev *dev, bool force);
 int mt792x_wpdma_reinit_cond(struct mt792x_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 2835bf273154..c52d0c85913c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -87,6 +87,62 @@ void mt792x_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 }
 EXPORT_SYMBOL_GPL(mt792x_rx_poll_complete);
 
+int mt792x_dma_alloc_queues(struct mt792x_dev *dev,
+			    const struct mt792x_dma_layout *layout)
+{
+	int ret;
+
+	mt76_dma_attach(&dev->mt76);
+
+	ret = mt792x_dma_disable(dev, true);
+	if (ret)
+		return ret;
+
+	/* init tx queue */
+	ret = mt76_connac_init_tx_queues(dev->phy.mt76, layout->tx_data0.qid,
+					 layout->tx_data0.n_desc,
+					 layout->tx_data0.ring_base,
+					 NULL, 0);
+	if (ret)
+		return ret;
+
+	mt76_wr(dev, MT_WFDMA0_TX_RING0_EXT_CTRL, 0x4);
+
+	/* command to WM */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_WM,
+				  layout->tx_mcu.qid,
+				  layout->tx_mcu.n_desc,
+				  layout->tx_mcu.ring_base);
+	if (ret)
+		return ret;
+
+	/* firmware download */
+	ret = mt76_init_mcu_queue(&dev->mt76, MT_MCUQ_FWDL,
+				  layout->tx_fwdl.qid,
+				  layout->tx_fwdl.n_desc,
+				  layout->tx_fwdl.ring_base);
+	if (ret)
+		return ret;
+
+	/* rx event */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
+			       layout->rx_mcu.qid,
+			       layout->rx_mcu.n_desc,
+			       MT_RX_BUF_SIZE,
+			       layout->rx_mcu.ring_base);
+	if (ret)
+		return ret;
+
+	/* rx data */
+	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN],
+			       layout->rx_data.qid,
+			       layout->rx_data.n_desc,
+			       MT_RX_BUF_SIZE,
+			       layout->rx_data.ring_base);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt792x_dma_alloc_queues);
+
 #define PREFETCH(base, depth)	((base) << 16 | (depth))
 static void mt792x_dma_prefetch(struct mt792x_dev *dev)
 {
-- 
2.43.0


