Return-Path: <linux-wireless+bounces-37704-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YP11Mii7K2oSDgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37704-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:54:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B76777A0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:54:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=izTLA0Hb;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37704-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37704-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C99E5309CC0B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E7F3E16A4;
	Fri, 12 Jun 2026 07:51:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005343E4507
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:51:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250706; cv=none; b=ZrMonExp+QxLL8tLB5PwSqXZI1D1uq62BfNm2uX+XYaofkEtvcSNcTuqaMsWAQ4mxTbaRrIk0OD7gcnVSFqnZ17/DVAyD9kqQUh/W2/AYxjBJYppt2aH9MPiZof569D2NbshQF8MqJuu3aexfG7G5h0cxJt5LnNhI0SoMfP6Nvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250706; c=relaxed/simple;
	bh=jMPM0RHuEl7frB0GpwJxVYOsmAAeQBgqghgnaabFcII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L59bA1EROc0scBAot670lVqd++GtTh929MjBGyixXIwVr1PZN6OjtmwWHl+1CXlwdkCODGaUlx7IwIgNee9JrVMNvBX0a0QWK32Xaos1YN3pAaKgCSGROIXJ4CsS0/6MW3AzmfLhHkRdKmKbVC1g97/GvRyjdiufoc9OKiwDToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=izTLA0Hb; arc=none smtp.client-ip=60.244.123.138
X-UUID: 8b2ac8ea663311f1b1788b6acf885367-20260612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=sWph3N1IPVPF1IPl5m4HgnnTTXcv789OBP34n5CObbU=;
	b=izTLA0HbMzFC9egcnKUKyuR7KlZo5mA+apl18yxW7tKaJeggzIARRvbY1wurVCnyxx2YJLAwMnMI0KN5VPBLKNZjdcNdf4qylObJzuLyqotvgcGhLtLMVFshzlRlut1YwZrKWgFiqKxsyA3BOTtuKwySuEaWyNXRDupVv0MpbuA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:050f4a67-e840-4df3-b434-252ec013a56a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e276073,CLOUDID:c5d47654-902f-47df-afe3-f34f8d753c22,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8b2ac8ea663311f1b1788b6acf885367-20260612
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 598667909; Fri, 12 Jun 2026 15:51:38 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Jun 2026 15:51:37 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 12 Jun 2026 15:51:37 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <emery.hsin@mediatek.com>,
	<jb.tsai@mediatek.com>, Xiong <xiong.huang@mediatek.com>
Subject: [PATCH 06/20] wifi: mt76: connac2: add per-chip PCIe register definitions
Date: Fri, 12 Jun 2026 15:51:32 +0800
Message-ID: <20260612075136.2577553-1-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-37704-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Deren.Wu@mediatek.com,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:litien.chang@mediatek.com,m:emery.hsin@mediatek.com,m:jb.tsai@mediatek.com,m:xiong.huang@mediatek.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 437B76777A0

From: Emery Hsin <emery.hsin@mediatek.com>

Add MT_PCIE_MAC_{INT_ENABLE,PM} definitions to mt7921/regs.h and
wire up mt7921_pcie_reg in mt7921_pci_probe() to provide connac2
series chips with their own PCIe register definitions.

This is a preparation patch before enabling MT7928 PCIe support.

Signed-off-by: Xiong <xiong.huang@mediatek.com>
Signed-off-by: Emery Hsin <emery.hsin@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 067f6b4142b6..a93cdc1f1c93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -285,6 +285,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.drv_own = mt792xe_mcu_drv_pmctrl,
 		.fw_own = mt792xe_mcu_fw_pmctrl,
 	};
+	static const struct mt792x_pcie_reg mt7921_pcie_reg = {
+		.imask = MT_PCIE_MAC_INT_ENABLE,
+		.pm = MT_PCIE_MAC_PM,
+	};
 	static const struct mt792x_irq_map irq_map = {
 		.host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
 		.tx = {
@@ -354,6 +358,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 
 	dev->fw_features = features;
 	dev->hif_ops = &mt7921_pcie_ops;
+	dev->pcie_reg = &mt7921_pcie_reg;
 	dev->irq_map = &irq_map;
 	mt76_mmio_init(&dev->mt76, regs);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 4d9eaf1e0692..75b4e81c7224 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -78,4 +78,9 @@
 #define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
 #define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
 
+#define MT_PCIE_MAC_BASE		0x10000
+#define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
+#define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
+#define MT_PCIE_MAC_PM			MT_PCIE_MAC(0x194)
+
 #endif
-- 
2.45.2


