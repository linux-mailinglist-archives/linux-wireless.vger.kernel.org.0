Return-Path: <linux-wireless+bounces-37414-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6XnMJw60ImqEcQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37414-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 13:33:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8B647BFF
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 13:33:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=CPZmng+r;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37414-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37414-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E3EF3019003
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 11:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A454C8FFD;
	Fri,  5 Jun 2026 11:33:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56184C8FE6
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 11:33:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659206; cv=none; b=jGrt9Y70RGsyGFQCQHyqDE+6dqNcWnzVYtNtqgQ0giXe6bPRA08EBHL+5TnJ+WEGOKfBp+Op9M2h/rrDigjLKwfiJ9VlRgUopCqL7CpOb4b71qKU8hMm4gvMdfonMzO5fDGkxBFqYQn7AbDoDnsCMXfBbOuaMmhQTz1bezYlsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659206; c=relaxed/simple;
	bh=T81jHuJzoMNcrQ6BipL0yZszuLKNABdlbeDA06QOqPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTTCi4zz2Ru1o0p41ZIGC0HS9ev+1s6AaJuEWnla7Eo6bns6etzhTmqKx8+7WdTCfPQ5TEvb2UJgcltZ1ZKS4Eo+7qLB10MUnXQ+/NGHlOCyeGCFvSfyf9rb/CyfCfxH6BgWyWkAoUUeqHsYXYTIjkRCwHQzCZOGJtzPjv3FWzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CPZmng+r; arc=none smtp.client-ip=210.61.82.184
X-UUID: 591df4be60d211f18dc8c9802ae25ab1-20260605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AZuPNLh7boHniF51Mw9u8u+3YAMr1QxUy2t3oNZDymA=;
	b=CPZmng+rZ/e8yam7n5RDte/sM8qEjnopyggJE5fvW7KzZ1BPmzCY7vHQF7T1VSJKG9OZ29/gnb5kgnH4+SbkoHHqbfbVI06fqtPmGDfyqWuQkG3369bS/lGtkdnXPdF4fMu0++SZODoD3OkvDIjJITc+55fEn8skhY+lrEHLh6Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:6eb1fdfa-36f7-4d8e-ad99-bf2f82e7a366,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:02116820-87a8-421b-982c-f5939dba7cba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 591df4be60d211f18dc8c9802ae25ab1-20260605
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1780724630; Fri, 05 Jun 2026 19:33:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Jun 2026 19:33:16 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 5 Jun 2026 19:33:15 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: <linux-mediatek@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
	Shayne Chen <shayne.chen@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/4] wifi: mt76: mt7925: fix potential tx_retries underflow
Date: Fri, 5 Jun 2026 04:33:05 -0700
Message-ID: <20260605113306.3485554-3-ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260605113306.3485554-1-ryder.lee@mediatek.com>
References: <20260605113306.3485554-1-ryder.lee@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37414-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:linux-mediatek@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:shayne.chen@mediatek.com,m:ryder.lee@mediatek.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mediatek.com:mid,mediatek.com:dkim,mediatek.com:from_mime,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38D8B647BFF

When FIELD_GET returns 0 for the retry count, subtracting 1 causes
an unsigned integer underflow, resulting in tx_retries becoming a
very large value (0xFFFFFFFF for u32).

Fix by checking if count is non-zero before subtracting 1.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index c47bd812b..c56a9e530 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1141,8 +1141,9 @@ mt7925_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 
 		if (info & MT_TXFREE_INFO_HEADER) {
 			if (wcid) {
-				wcid->stats.tx_retries +=
-					FIELD_GET(MT_TXFREE_INFO_COUNT, info) - 1;
+				u32 count = FIELD_GET(MT_TXFREE_INFO_COUNT, info);
+
+				wcid->stats.tx_retries += count ? count - 1 : 0;
 				wcid->stats.tx_failed +=
 					!!FIELD_GET(MT_TXFREE_INFO_STAT, info);
 			}
-- 
2.45.2


