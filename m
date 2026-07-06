Return-Path: <linux-wireless+bounces-38641-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CfHaFWMWS2onLwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38641-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:43:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D79E70C306
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 04:43:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=nwkHIaSg;
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38641-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38641-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC2F230094D1
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 02:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C23A9605;
	Mon,  6 Jul 2026 02:43:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40AA3A8747
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 02:43:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305794; cv=none; b=DFLXbCCz30o5/YucVy/LOwbxGUVb/ilqsw21ldPwka2PnBbZMx6kvWF8MhuQjJ5tBJ8ElXeQRv71rRT+h7zldWbpei7AeAGMGZYKu723YqLnwj8Ie9aKCy+bIMSh7mxSA6EbUG6g/6e0XDdd+Egcb16dDCJ8geDVffW/gF5xmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305794; c=relaxed/simple;
	bh=kecCJL0bb1yhxkT9PUjUa8rzZ73sMP4JKo+mERKvG34=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=syQbD/RfTxRfMTiVWTXzWTy22K6bEv8lTRXkWpjFYlPppdo9HKQrT7IiWK9Hb1/aDnvrXC2jik5j8TJ92yz2X7SerQWa1vLVVtBqhXg3VL6fCJ6qIQcy9Y/0ahnEAjIxNZjMMDeANXkOluaAF01vqpjbrKAkmOg0x1hDpN9w+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nwkHIaSg; arc=none smtp.client-ip=60.244.123.138
X-UUID: 687bad1478e411f1b1788b6acf885367-20260706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=aLPjFmMhfpxUPrhhsasDPypp8xXl3OnfF2sTXsA+gTA=;
	b=nwkHIaSgFOvcJbGiqnAfEs/n41bmH+C+NkvswzDRUq4Mcu272chYq6PFsauNslmfBVZbHBsYPeWKKLs4Y+lxQ6H3BfiQOOuc1kO9NuwLyRBgIi3dk3t6polS5wwF1ga2xGw0Yv1isNn30oB/+CIY9mpXxF7IFJedAOkTt12iXqQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:52c09912-683d-4123-8d7b-14ca06fea7e4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:d497b38,CLOUDID:59b00a82-6310-4e6b-a6b1-aca20d98ed8b,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 687bad1478e411f1b1788b6acf885367-20260706
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 56576014; Mon, 06 Jul 2026 10:43:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 6 Jul 2026 10:43:01 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 6 Jul 2026 10:43:01 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Leon.Yen@mediatek.com>, <litien.chang@mediatek.com>,
	<jeff.hsu@mediatek.com>, <jb.tsai@mediatek.com>, Jeff Hsu
	<Jeff.Hsu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: Add flag to control if need DMA re-init
Date: Mon, 6 Jul 2026 10:43:00 +0800
Message-ID: <20260706024300.47789-1-jb.tsai@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-38641-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:litien.chang@mediatek.com,m:jeff.hsu@mediatek.com,m:jb.tsai@mediatek.com,m:Jeff.Hsu@mediatek.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D79E70C306

From: Jeff Hsu <Jeff.Hsu@mediatek.com>

Add flag(skip_wpdma_reinit) to control if need do DMA re-init

Signed-off-by: Jeff Hsu <Jeff.Hsu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index a93cdc1f1c93..c5af9cd3edce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -398,6 +398,9 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (!mt7921_disable_aspm && mt76_pci_aspm_supported(pdev))
 		dev->aspm_supported = true;
 
+	/* MT7921 needs wpdma reinit */
+	dev->skip_wpdma_reinit = false;
+
 	ret = mt792xe_mcu_fw_pmctrl(dev);
 	if (ret)
 		goto err_free_dev;
-- 
2.45.2


