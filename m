Return-Path: <linux-wireless+bounces-37701-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jsh/HH+6K2qQDQQAu9opvQ
	(envelope-from <linux-wireless+bounces-37701-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:51:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F567770C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:51:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=rpbP0VF3;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37701-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37701-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C7B730913E7
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 07:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F263E16B2;
	Fri, 12 Jun 2026 07:50:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1E23D6CDD
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:50:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250657; cv=none; b=n9T/HD/x/5VCydUa9GwwwDjphl1HBVIsKaXToaJbdeOFngSRUgyEogiaXxyp7alAywLraF9U5joxXvCNpVWHeY8CjBNTTWrFT4a8hTN/Amb4oonR+yacGxQRE3PIqRzUvR8YujCeTVDP7K/Nv3fNXwiGPu8GWjARMu5Tj36vhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250657; c=relaxed/simple;
	bh=wGBcKQreRrPxZU6WrB3ZDc6J+0fAdt8w03K/g+h4ABk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYsbIZuhqtZcau31izI+tlksbeMvRQ/09uUrDnEzNBjOPFfiyEgQlwHTFNbHcdvre0Kppr9OUTALmcQe1DS2WsyissQx4nee24UYR21dBmXbtvlTPxoRJouHAITuvR6QsqCMurWICl7C9P9rbqg9GMNVI9CA4zPN7Io+ZPheyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rpbP0VF3; arc=none smtp.client-ip=210.61.82.184
X-UUID: 6c8b9e1e663311f18dc8c9802ae25ab1-20260612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hQUMpd3xd8ZrJpr/6Z9xwel6PH81ekgZqisB+svUWR8=;
	b=rpbP0VF3v51SydVmg7a+vHDP8L7TcVnUL/xY0vHlS3ObKSPGwRCSsbHSkp0ORN65SwUsPeCl2RngYeACI5Jf596DEhWvpz4X9N94cX1P258DtQLjHfUBXefOPGd2zXdlIP2hUagPgX8xRDFzN4PllKa3LGy37jbRf6Sizrvh4J0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:90f76b13-becc-439f-9ad7-7ae526700ad9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:304b6397-22d1-4176-b420-d0d82ac3f01a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6c8b9e1e663311f18dc8c9802ae25ab1-20260612
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1856780293; Fri, 12 Jun 2026 15:50:47 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Jun 2026 15:50:46 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 12 Jun 2026 15:50:46 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <emery.hsin@mediatek.com>,
	<jb.tsai@mediatek.com>
Subject: [PATCH 04/20] wifi: mt76: mt7925: add MT7927 per-chip rx irq definitions
Date: Fri, 12 Jun 2026 15:50:41 +0800
Message-ID: <20260612075042.2577193-4-jb.tsai@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-37701-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,mediatek.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E71F567770C

From: Emery Hsin <emery.hsin@mediatek.com>

Add MT7927_INT_RX_DONE_{DATA,WM,WM2,ALL} macros and populate
all_complete_mask in mt7927_irq_map. MT7927 maps RX_DONE_DATA to
ENA4 and RX_DONE_WM to ENA6, differing from MT7925.

This is a preparation patch before enabling MT7928 PCIe support.

Signed-off-by: Emery Hsin <emery.hsin@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h | 7 +++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 95a0bd615167..8a4fb53c718f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -319,11 +319,13 @@ static const struct mt792x_irq_map mt7927_irq_map = {
 		.mcu_complete_mask = MT_INT_TX_DONE_MCU,
 	},
 	.rx = {
-		.data_complete_mask = MT7927_RX_DONE_INT_ENA4,
-		.wm_complete_mask = MT7927_RX_DONE_INT_ENA6,
-		.wm2_complete_mask = MT7927_RX_DONE_INT_ENA7,
+		.all_complete_mask = MT7927_INT_RX_DONE_ALL,
+		.data_complete_mask = MT7927_INT_RX_DONE_DATA,
+		.wm_complete_mask = MT7927_INT_RX_DONE_WM,
+		.wm2_complete_mask = MT7927_INT_RX_DONE_WM2,
 	},
 };
+
 static int mt7925_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index aed90cc82858..bb5969689337 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -51,6 +51,13 @@
 					 MT7925_INT_RX_DONE_WM | \
 					 MT_INT_RX_DONE_WM2)
 
+#define MT7927_INT_RX_DONE_DATA		MT7927_RX_DONE_INT_ENA4
+#define MT7927_INT_RX_DONE_WM		MT7927_RX_DONE_INT_ENA6
+#define MT7927_INT_RX_DONE_WM2		MT7927_RX_DONE_INT_ENA7
+#define MT7927_INT_RX_DONE_ALL		(MT7927_INT_RX_DONE_DATA | \
+					 MT7927_INT_RX_DONE_WM | \
+					 MT7927_INT_RX_DONE_WM2)
+
 #define MT_INT_TX_DONE_MCU_WM		(HOST_TX_DONE_INT_ENA15 | \
 					 HOST_TX_DONE_INT_ENA17)
 
-- 
2.45.2


