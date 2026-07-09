Return-Path: <linux-wireless+bounces-38812-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RaqIIi5UT2pBegIAu9opvQ
	(envelope-from <linux-wireless+bounces-38812-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 09:56:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5BC72DFC4
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 09:56:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b="nOfQGh/Z";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38812-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38812-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F172300B1F8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F6A3DDAFA;
	Thu,  9 Jul 2026 07:56:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDC3E63A8
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 07:56:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583788; cv=none; b=sTfQKptv/6RAQR1G/IFXhJ4/5f08xoOy3OMUz1OMikaVsH6ERwAIY27EPkabaKJ28QsbfrSID6YNyRRIKOavHECdWQBICgMj2RztXS9MMa9Ix3MPgaUHTF+eK0r3Jc4SISVcOBCsy7/tkT9WOMwd060D0uVjzkJ+D53wF6ImLB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583788; c=relaxed/simple;
	bh=cBvowL2wrsDf2AxZrEeyKoVXCxRzCSbWwzAoUDAoZYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ez8tPEOwuHK0oAahI33TYyy6eqDvy2y+xw3z3hlor35xGQN4Wq6dvH02UuZMTczfGzhOKpE9Ew0SZ6nsHR02FuiKLrOCVt2V+cXOI4k//HnDBFWzyyaA+Ila1pKr1bBLddpzcjPiePouN+IsCH7vjXeiQQ7doUXmUNIIUGR+0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nOfQGh/Z; arc=none smtp.client-ip=210.61.82.184
X-UUID: a8d424347b6b11f18dc8c9802ae25ab1-20260709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5EnLepiGJu5ynM7pzYiD8KQTaUm1oFDIVTsdGhvGkps=;
	b=nOfQGh/Z9MeqQp6lZwP7m5byacn21h13okEVaETjRiOtaCcPxsDCoQgXjAE1b5ST0FQ6Dg6t1Sz0MoPe59GqSNyVmg9hYRQ8jYe/WWA6cXGxuO+S5K2TxHRY+N85+ywhmKr/ZzTQV/E7RxXiru06qQhTtypIDjZykI8q8ShJEt0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:0ff483bf-01cf-48d1-8f02-214b62f21ead,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:d497b38,CLOUDID:79dea303-430e-43d5-9a6c-19a994ddbd60,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a8d424347b6b11f18dc8c9802ae25ab1-20260709
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 948769838; Thu, 09 Jul 2026 15:56:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Jul 2026 15:56:13 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 9 Jul 2026 15:56:13 +0800
From: Eason Lai <eason.lai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Yf.Luo@mediatek.com>, <kun.wu@mediatek.com>, <deren.wu@mediatek.com>,
	<sean.wang@mediatek.com>, <quan.zhou@mediatek.com>, <ryder.lee@mediatek.com>,
	<leon.yen@mediatek.com>, <litien.chang@mediatek.com>, <jb.tsai@mediatek.com>,
	<eason.lai@mediatek.com>, Eason Lai <Eason.Lai@mediatek.com>
Subject: [PATCH 3/3] wifi: mt76: mt792x: Restrict TX page pool to MT8196 platform
Date: Thu, 9 Jul 2026 15:55:58 +0800
Message-ID: <20260709075558.1654164-4-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709075558.1654164-1-eason.lai@mediatek.com>
References: <20260709075558.1654164-1-eason.lai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-38812-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Yf.Luo@mediatek.com,m:kun.wu@mediatek.com,m:deren.wu@mediatek.com,m:sean.wang@mediatek.com,m:quan.zhou@mediatek.com,m:ryder.lee@mediatek.com,m:leon.yen@mediatek.com,m:litien.chang@mediatek.com,m:jb.tsai@mediatek.com,m:eason.lai@mediatek.com,m:Eason.Lai@mediatek.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:from_mime,mediatek.com:email,mediatek.com:mid,mediatek.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D5BC72DFC4

From: Eason Lai <Eason.Lai@mediatek.com>

The TX page pool optimization significantly improves performance on
MT8196 when IOMMU is enabled, but this benefit is platform-specific.
Restrict this feature to MT8196 where it has been tested and validated.

On MT8196 with IOMMU enabled, DMA mapping overhead increases
dramatically compared to IOMMU-disabled configurations:

dma_unmap_single() in mt76_connac_txp_skb_unmap_hw() (NAPI context):
  - IOMMU disabled: 181.25 ns (avg over 20,000 calls)
      - IOMMU enabled:  5216.19 ns (avg over 21,000 calls)

dma_map_single() in mt76_dma_tx_queue_skb() (workqueue context):
  - IOMMU disabled: 880.20 ns (avg over 20,000 calls)
      - IOMMU enabled:  2106.65 ns (avg over 20,000 calls)

The TX page pool mitigates this overhead by reusing DMA mappings,
but should only be enabled on platforms where it has been verified
to work correctly.

Signed-off-by: Eason Lai <Eason.Lai@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index b341f1cb3ce0..6d5725a5b10f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -307,6 +307,7 @@ int mt792x_dma_tx_page_pool_init(struct mt792x_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
 	int i, ret, pool_count = 0;
+	bool is_mt8196;
 
 	if (!iommu_get_domain_for_dev(mdev->dma_dev))
 		return 0;
@@ -314,6 +315,13 @@ int mt792x_dma_tx_page_pool_init(struct mt792x_dev *dev)
 	if (!mt76_is_mmio(mdev))
 		return 0;
 
+	is_mt8196 = of_machine_is_compatible("mediatek,mt8196");
+	if (!is_mt8196) {
+		dev_info(mdev->dev, "Not MT8196 platform, TX page pool optimization disabled\n");
+		return 0;
+	}
+
+	dev_info(mdev->dev, "MT8196 platform detected, enabling TX page pool optimization\n");
 	mdev->tx_prealloc_enabled = true;
 
 	for (i = 0; i < ARRAY_SIZE(mdev->phy.q_tx); i++) {
-- 
2.45.2


