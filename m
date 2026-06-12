Return-Path: <linux-wireless+bounces-37703-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2wKzLZ+7K2pwDgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37703-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:56:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1202567781E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:56:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=Cr1aFjYy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37703-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37703-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 978B730DBF13
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 07:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335C3E44E8;
	Fri, 12 Jun 2026 07:50:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8253E2759
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:50:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250659; cv=none; b=SQ/izUKjqe1+TfwKtQ8fhTJ3zuNdh3hqR4gmxBPJBjuuAsN6aw3gG4sHVmI9/BwgMyfk9MWlObX4uzm5NpfhNd/OZ1O0wSSqAptnm+PGKMns8YUfCWOeJ1pdl+xBF7PPtVNbAOZfiR7cFIjF/vwfHsseuv+FR7mwtAN+1jy2Hf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250659; c=relaxed/simple;
	bh=aRPdE77a8gBaoLbR59KNPLbBsEoUcPjvRzSXcdEVwf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gln9uAm4VHoPcK1sR2t8bmTBFlSI1o2pOp3iAtUHjhUKOg14Cru7m1UK9miDpmuSFG0GVRMYB8EziWgpyh6sphItl4j5ju5qUnum8X0/FhJ9wA5oCTjESm6yBsNNYJQb6h+dgwDl7y1FLloXwtFDPK5hT1qipxblEoSr6HYYwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Cr1aFjYy; arc=none smtp.client-ip=210.61.82.184
X-UUID: 6be8acae663311f18dc8c9802ae25ab1-20260612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6wdbQcfqWlsPatgZkybOjuUihJQbe7/Y6dC2S+ODwe4=;
	b=Cr1aFjYyjXPepFekFP+SOnoETrUHaFgvvRxGcQp+5U/8VSBWdNF2B2+m+st1YmjB8+mAZEcvgP/LugnvpGVyUs+sUG3X/ceIlRGMgJ2vRJMOcI1rqLJVG5wi8TWluqOUDBNvjam6izLkd/qhD8irPsoaOGHrT+pcROxvCldFJEw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:3734e699-edde-4218-bb10-9f03f1517158,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e276073,CLOUDID:9a72b230-7784-4a77-a538-47ed6151d81b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6be8acae663311f18dc8c9802ae25ab1-20260612
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2094632168; Fri, 12 Jun 2026 15:50:46 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Jun 2026 15:50:45 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 12 Jun 2026 15:50:45 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <emery.hsin@mediatek.com>,
	<jb.tsai@mediatek.com>
Subject: [PATCH 03/20] wifi: mt76: mt7925: replace shared rx irq masks with per-chip definitions
Date: Fri, 12 Jun 2026 15:50:40 +0800
Message-ID: <20260612075042.2577193-3-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260612075042.2577193-1-jb.tsai@mediatek.com>
References: <20260612075042.2577193-1-jb.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-37703-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Deren.Wu@mediatek.com,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:litien.chang@mediatek.com,m:emery.hsin@mediatek.com,m:jb.tsai@mediatek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,mediatek.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1202567781E

From: Emery Hsin <emery.hsin@mediatek.com>

Replace shared MT_INT_RX_DONE_* macros with chip-specific
MT7925_INT_RX_DONE_{DATA,WM,WM2,ALL} and populate all_complete_mask
in mt7925_irq_map. Update resume and mac_reset paths accordingly.

This is a preparation patch before enabling MT7928 PCIe support.

Signed-off-by: Emery Hsin <emery.hsin@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/pci.c   | 33 ++++++++++---------
 .../wireless/mediatek/mt76/mt7925/pci_mac.c   |  4 +--
 .../net/wireless/mediatek/mt76/mt7925/regs.h  |  9 ++---
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index ea64303283ed..95a0bd615167 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -298,6 +298,20 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
 	return mt792x_dma_enable(dev);
 }
 
+static const struct mt792x_irq_map mt7925_irq_map = {
+	.host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
+	.tx = {
+		.all_complete_mask = MT_INT_TX_DONE_ALL,
+		.mcu_complete_mask = MT_INT_TX_DONE_MCU,
+	},
+	.rx = {
+		.all_complete_mask = MT7925_INT_RX_DONE_ALL,
+		.data_complete_mask = MT7925_INT_RX_DONE_DATA,
+		.wm_complete_mask = MT7925_INT_RX_DONE_WM,
+		.wm2_complete_mask = MT_INT_RX_DONE_WM2,
+	},
+};
+
 static const struct mt792x_irq_map mt7927_irq_map = {
 	.host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
 	.tx = {
@@ -339,17 +353,6 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 		.drv_own = mt792xe_mcu_drv_pmctrl,
 		.fw_own = mt792xe_mcu_fw_pmctrl,
 	};
-	static const struct mt792x_irq_map irq_map = {
-		.host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
-		.tx = {
-			.all_complete_mask = MT_INT_TX_DONE_ALL,
-			.mcu_complete_mask = MT_INT_TX_DONE_MCU,
-		},
-		.rx = {
-			.data_complete_mask = HOST_RX_DONE_INT_ENA2,
-			.wm_complete_mask = HOST_RX_DONE_INT_ENA0,
-		},
-	};
 	struct ieee80211_ops *ops;
 	struct mt76_bus_ops *bus_ops;
 	struct mt792x_dev *dev;
@@ -407,7 +410,7 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &mt7925_pcie_ops;
-	dev->irq_map = is_mt7927_hw ? &mt7927_irq_map : &irq_map;
+	dev->irq_map = is_mt7927_hw ? &mt7927_irq_map : &mt7925_irq_map;
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
 
@@ -456,7 +459,7 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_dev;
 
-	mt76_wr(dev, irq_map.host_irq_enable, 0);
+	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
 
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
@@ -613,9 +616,7 @@ static int _mt7925_pci_resume(struct device *device, bool restore)
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 	mt76_connac_irq_enable(&dev->mt76,
 			       dev->irq_map->tx.all_complete_mask |
-			       dev->irq_map->rx.data_complete_mask |
-			       dev->irq_map->rx.wm_complete_mask |
-			       dev->irq_map->rx.wm2_complete_mask |
+			       dev->irq_map->rx.all_complete_mask |
 			       MT_INT_MCU_CMD);
 	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
index 97683949a305..d288739e1307 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
@@ -119,9 +119,7 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
 
 	mt76_wr(dev, dev->irq_map->host_irq_enable,
 		dev->irq_map->tx.all_complete_mask |
-		dev->irq_map->rx.data_complete_mask |
-		dev->irq_map->rx.wm_complete_mask |
-		dev->irq_map->rx.wm2_complete_mask |
+		dev->irq_map->rx.all_complete_mask |
 		MT_INT_MCU_CMD);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index 24985bba1b90..aed90cc82858 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -43,11 +43,12 @@
 #define HOST_TX_DONE_INT_ENA17		BIT(27)
 
 /* WFDMA interrupt */
-#define MT_INT_RX_DONE_DATA		HOST_RX_DONE_INT_ENA2
-#define MT_INT_RX_DONE_WM		HOST_RX_DONE_INT_ENA0
 #define MT_INT_RX_DONE_WM2		HOST_RX_DONE_INT_ENA1
-#define MT_INT_RX_DONE_ALL		(MT_INT_RX_DONE_DATA | \
-					 MT_INT_RX_DONE_WM | \
+
+#define MT7925_INT_RX_DONE_DATA		HOST_RX_DONE_INT_ENA2
+#define MT7925_INT_RX_DONE_WM		HOST_RX_DONE_INT_ENA0
+#define MT7925_INT_RX_DONE_ALL		(MT7925_INT_RX_DONE_DATA | \
+					 MT7925_INT_RX_DONE_WM | \
 					 MT_INT_RX_DONE_WM2)
 
 #define MT_INT_TX_DONE_MCU_WM		(HOST_TX_DONE_INT_ENA15 | \
-- 
2.45.2


