Return-Path: <linux-wireless+bounces-37706-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z3kzDki7K2orDgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37706-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:54:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2806777C0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:54:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=q57fILqV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37706-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37706-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89BB73186A42
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308EA3E2AB6;
	Fri, 12 Jun 2026 07:51:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710153E4507
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:51:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250713; cv=none; b=A9rZFN1YWf8+zrsaUHRKIVZFW2B1KEzRdHAahS8aKwPRXmuGQz9eFmBkUaah1+HlpSXlL10IQbEMMFOwDTFU1GRlBooQ8hBwGhRuMc+DLWVbcKZTzEURCqBSOTLL9jMWPJUMNWANbcXdl/Vd7GeckVYN6ZhvZte17oNTms32Iq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250713; c=relaxed/simple;
	bh=0UAAbu/alRSQqgcka/4iO2YkrwY5ReupqbrLkM+gOGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpLiNWUaowlnNYSwp5/wIjAEEPxgDejFntVyH8fRwH2IeHj0tTVFSWA/MxJlxKvHnMHEgUFKxakWiBPMzUQr5i+yQMRZAVh2bgWFxQY1sHgLFCXHx9jDjc2mIk+nT5Dro3ASvdElGxN8lphU9KEGDz5Y7Glod7L8PgeIX5N/bN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=q57fILqV; arc=none smtp.client-ip=210.61.82.184
X-UUID: 8b89d182663311f18dc8c9802ae25ab1-20260612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Tr/pocFYdumnRAiTS0oIGp7DfNRxlNOnmimYddYie18=;
	b=q57fILqVThWfjc1ePfeD6bMBwi2PYtmcHG8jvHgokaAjJvC/SCZEt18whB2d0KYtJhVlSoXkqvIb5RgaKd5vSM2JLs4HY1W/FYIDaRLV4Y5PmvWz92xFcG+p93+yzISxsxfZbfj2fTA5rNP9NtWW7hAop6wrmYh4ST+9R88QGmI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:a737b462-e28c-475b-bc46-5f5e8b1e7ed8,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e276073,CLOUDID:ddd47654-902f-47df-afe3-f34f8d753c22,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8b89d182663311f18dc8c9802ae25ab1-20260612
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 686046318; Fri, 12 Jun 2026 15:51:39 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Jun 2026 15:51:38 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 12 Jun 2026 15:51:38 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <emery.hsin@mediatek.com>,
	<jb.tsai@mediatek.com>, Xiong <xiong.huang@mediatek.com>
Subject: [PATCH 07/20] wifi: mt76: mt7925: add per-chip PCIe register definitions
Date: Fri, 12 Jun 2026 15:51:33 +0800
Message-ID: <20260612075136.2577553-2-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260612075136.2577553-1-jb.tsai@mediatek.com>
References: <20260612075136.2577553-1-jb.tsai@mediatek.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-37706-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Deren.Wu@mediatek.com,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:litien.chang@mediatek.com,m:emery.hsin@mediatek.com,m:jb.tsai@mediatek.com,m:xiong.huang@mediatek.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,mediatek.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD2806777C0

From: Emery Hsin <emery.hsin@mediatek.com>

Add MT7925_PCIE_MAC_{INT_ENABLE,PM} macros and mt7925_pcie_reg
struct. Update all PCIe register accesses in pci.c, pci_mac.c, and
pci_mcu.c to use dev->pcie_reg->{imask,pm}.

This is a preparation patch before enabling MT7928 PCIe support.

Signed-off-by: Xiong <xiong.huang@mediatek.com>
Signed-off-by: Emery Hsin <emery.hsin@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c   | 15 ++++++++++-----
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c   |  4 ++--
 .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h  |  5 +++++
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 8a4fb53c718f..61349c260b12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -298,6 +298,11 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
 	return mt792x_dma_enable(dev);
 }
 
+static const struct mt792x_pcie_reg mt7925_pcie_reg = {
+	.imask = MT7925_PCIE_MAC_INT_ENABLE,
+	.pm = MT7925_PCIE_MAC_PM,
+};
+
 static const struct mt792x_irq_map mt7925_irq_map = {
 	.host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
 	.tx = {
@@ -413,6 +418,8 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	dev->fw_features = features;
 	dev->hif_ops = &mt7925_pcie_ops;
 	dev->irq_map = is_mt7927_hw ? &mt7927_irq_map : &mt7925_irq_map;
+	dev->pcie_reg = &mt7925_pcie_reg;
+
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
 
@@ -462,8 +469,7 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 		goto err_free_dev;
 
 	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
-
-	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+	mt76_wr(dev, dev->pcie_reg->imask, 0xff);
 
 	ret = devm_request_irq(mdev->dev, pdev->irq, mt792x_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
@@ -564,8 +570,7 @@ static int mt7925_pci_suspend(struct device *device)
 
 	/* disable interrupt */
 	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
-
-	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+	mt76_wr(dev, dev->pcie_reg->imask, 0x0);
 
 	synchronize_irq(pdev->irq);
 	tasklet_kill(&mdev->irq_tasklet);
@@ -615,7 +620,7 @@ static int _mt7925_pci_resume(struct device *device, bool restore)
 	mt792x_wpdma_reinit_cond(dev);
 
 	/* enable interrupt */
-	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+	mt76_wr(dev, dev->pcie_reg->imask, 0xff);
 	mt76_connac_irq_enable(&dev->mt76,
 			       dev->irq_map->tx.all_complete_mask |
 			       dev->irq_map->rx.all_complete_mask |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
index d288739e1307..8477d21abc66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
@@ -78,7 +78,7 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
 	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
-	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+	mt76_wr(dev, dev->pcie_reg->imask, 0x0);
 
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
@@ -121,7 +121,7 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
 		dev->irq_map->tx.all_complete_mask |
 		dev->irq_map->rx.all_complete_mask |
 		MT_INT_MCU_CMD);
-	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+	mt76_wr(dev, dev->pcie_reg->imask, 0xff);
 
 	err = mt792xe_mcu_fw_pmctrl(dev);
 	if (err)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
index 6cceff88c656..72707eddc3db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
@@ -43,7 +43,7 @@ int mt7925e_mcu_init(struct mt792x_dev *dev)
 	if (err)
 		return err;
 
-	mt76_rmw_field(dev, MT_PCIE_MAC_PM, MT_PCIE_MAC_PM_L0S_DIS, 1);
+	mt76_rmw_field(dev, dev->pcie_reg->pm, MT_PCIE_MAC_PM_L0S_DIS, 1);
 
 	err = mt7925_run_firmware(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index bb5969689337..85adde2ad597 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -97,4 +97,9 @@
 #define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(11, 0)
 #define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(14)
 
+#define MT7925_PCIE_MAC_BASE		0x10000
+#define MT7925_PCIE_MAC(ofs)		(MT7925_PCIE_MAC_BASE + (ofs))
+#define MT7925_PCIE_MAC_INT_ENABLE	MT7925_PCIE_MAC(0x188)
+#define MT7925_PCIE_MAC_PM		MT7925_PCIE_MAC(0x194)
+
 #endif
-- 
2.45.2


