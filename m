Return-Path: <linux-wireless+bounces-37712-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qpnoKsW7K2qODgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37712-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:56:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AD767784B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:56:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=qhgPuCCW;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37712-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37712-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D2423166BDC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BAD31F985;
	Fri, 12 Jun 2026 07:53:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458132E72F
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:53:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250808; cv=none; b=sCzI9yjSkjfEgtr+W+87ZHOxLQXShrPU47JqPhZlu9PWIHGIhktyb4gQIOcnJjg/2xZE6POshd8H48VDLlqWSefl9hBZUsml69me6BkoRAyPAIkuVsdWWvr1sOEvF5ullLBRNehBaMfpiGNbnQfZp8g+Ss2DenMTHJWOJZ/85I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250808; c=relaxed/simple;
	bh=bWvQFmngq56rxSFsM9nC3iEC0G1hixJekVgeIT4h+q0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eR7fuszUrowje6J/w2aarLQe7GYuRg1HTHE8gz4k9GIHvP1ROMyeD+XyEguNgojl18DAmzJX1llnst90iSk9PIG6FBenO6eE6D0BDJFNB06eKt4eXkYJzU74MumteT575vn6VM7kJ8K63yJxqqXq2b5FgkQ5m+m9LtxbCPzVHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qhgPuCCW; arc=none smtp.client-ip=60.244.123.138
X-UUID: c6e08f96663311f1b1788b6acf885367-20260612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hN2x2tIIUNFomRLPegNdM0wJ2rC3cwatA/N82i76SGY=;
	b=qhgPuCCWLhh2jpJ/sn2k3x/SkQ3Q1+XOY27nwrYwNm2/RzY4u5bfqz2F0TQO421y+uAmISB5WcrGLtqtVBIGf3fcCbk6fgUF66GW0Vid/zQc3KBQUBVvQ+JypxsEx2u8ZfJvs0/bOFRqVKFxn1Y5m7Myrw0CVhmRaKtu1kupwPU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:d4dab2ef-94e8-4ca5-a575-0371d598515b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e276073,CLOUDID:2fd97654-902f-47df-afe3-f34f8d753c22,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c6e08f96663311f1b1788b6acf885367-20260612
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 635990943; Fri, 12 Jun 2026 15:53:19 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Jun 2026 15:53:18 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 12 Jun 2026 15:53:18 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <emery.hsin@mediatek.com>,
	<jb.tsai@mediatek.com>, FC Wei <fc.wei@mediatek.com>
Subject: [PATCH 14/20] wifi: mt76: mt7925: add MT7928 irq_map with chip-specific rx masks
Date: Fri, 12 Jun 2026 15:53:12 +0800
Message-ID: <20260612075313.2578154-4-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260612075313.2578154-1-jb.tsai@mediatek.com>
References: <20260612075313.2578154-1-jb.tsai@mediatek.com>
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
	TAGGED_FROM(0.00)[bounces-37712-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Deren.Wu@mediatek.com,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:litien.chang@mediatek.com,m:emery.hsin@mediatek.com,m:jb.tsai@mediatek.com,m:fc.wei@mediatek.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,mediatek.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45AD767784B

From: Emery Hsin <emery.hsin@mediatek.com>

MT7928 uses different RX interrupt bit assignments (RX_DONE_DATA on
ENA0, RX_DONE_WM on ENA3). Add MT7928-specific irq_map and select
it at probe time based on PCI device ID.

Signed-off-by: FC Wei <fc.wei@mediatek.com>
Signed-off-by: Emery Hsin <emery.hsin@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/pci.c   | 27 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7925/regs.h  |  6 +++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index e181cd0b6403..6a65c630f85a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -331,6 +331,20 @@ static const struct mt792x_irq_map mt7927_irq_map = {
 	},
 };
 
+static const struct mt792x_irq_map mt7928_irq_map = {
+	.host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
+	.tx = {
+		.all_complete_mask = MT_INT_TX_DONE_ALL,
+		.mcu_complete_mask = MT_INT_TX_DONE_MCU,
+	},
+	.rx = {
+		.all_complete_mask = MT7928_INT_RX_DONE_ALL,
+		.data_complete_mask = MT7928_INT_RX_DONE_DATA,
+		.wm_complete_mask = MT7928_INT_RX_DONE_WM,
+		.wm2_complete_mask = MT_INT_RX_DONE_WM2,
+	},
+};
+
 static int mt7925_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -360,11 +374,11 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 		.drv_own = mt792xe_mcu_drv_pmctrl,
 		.fw_own = mt792xe_mcu_fw_pmctrl,
 	};
-	struct ieee80211_ops *ops;
+	bool is_mt7927_hw, is_mt7928_hw;
 	struct mt76_bus_ops *bus_ops;
+	struct ieee80211_ops *ops;
 	struct mt792x_dev *dev;
 	struct mt76_dev *mdev;
-	bool is_mt7927_hw;
 	u8 features;
 	int ret;
 	u16 cmd;
@@ -394,6 +408,7 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 
 	is_mt7927_hw = (pdev->device == 0x6639 || pdev->device == 0x7927 ||
 			pdev->device == 0x0738);
+	is_mt7928_hw = (pdev->device == 0x7928 || pdev->device == 0x7935);
 
 	/* MT7927: ASPM L1 causes unreliable WFDMA register access */
 	if (mt7925_disable_aspm || is_mt7927_hw)
@@ -417,9 +432,15 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 	dev = container_of(mdev, struct mt792x_dev, mt76);
 	dev->fw_features = features;
 	dev->hif_ops = &mt7925_pcie_ops;
-	dev->irq_map = is_mt7927_hw ? &mt7927_irq_map : &mt7925_irq_map;
 	dev->pcie_reg = &mt7925_pcie_reg;
 
+	if (is_mt7928_hw)
+		dev->irq_map = &mt7928_irq_map;
+	else if (is_mt7927_hw)
+		dev->irq_map = &mt7927_irq_map;
+	else
+		dev->irq_map = &mt7925_irq_map;
+
 	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
 	tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index 0bcfd1cf0338..855a53c0748a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -58,6 +58,12 @@
 					 MT7927_INT_RX_DONE_WM | \
 					 MT7927_INT_RX_DONE_WM2)
 
+#define MT7928_INT_RX_DONE_DATA		HOST_RX_DONE_INT_ENA0
+#define MT7928_INT_RX_DONE_WM		HOST_RX_DONE_INT_ENA3
+#define MT7928_INT_RX_DONE_ALL		(MT7928_INT_RX_DONE_DATA | \
+					 MT7928_INT_RX_DONE_WM | \
+					 MT_INT_RX_DONE_WM2)
+
 #define MT_INT_TX_DONE_MCU_WM		(HOST_TX_DONE_INT_ENA15 | \
 					 HOST_TX_DONE_INT_ENA17)
 
-- 
2.45.2


