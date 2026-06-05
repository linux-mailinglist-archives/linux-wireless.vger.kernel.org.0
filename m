Return-Path: <linux-wireless+bounces-37412-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TTULNwa0ImqDcQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37412-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 13:33:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07756647BFA
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 13:33:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=ejg5jsJs;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37412-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37412-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E727300612F
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572A4C8FFD;
	Fri,  5 Jun 2026 11:33:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD49370D7B
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 11:33:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659203; cv=none; b=ObtxtzoSVFxEIpGpXrzVqYAtI4sx/mbq5tYTK24hGpNLETAht3UHHjmeKbPrmx16xUFMUP6A6LRcsnOaSC7fYo21qaqfWtWekaIcdpbZaMbkDrvkQJvRE9NWlUh/pHj+PWQQyMajzt4xD9sgijpMYCwce9vQLx+9mc6BD6QOG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659203; c=relaxed/simple;
	bh=Ca6SeSrIkOK248ci5zAUD8/nfsVQ71O3nCGWK2lJM8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zj4WQbacW4W2AUjSBwiavjVM2UwgkqAh8jRyO3qTwZuZf06VXdMfHXIMH5az33NVE5dgT0buAY5rpsPKelJeBmz6zRHVoejmBkhEo9QZ+7prCELLoEG9x0mfCPFk8pbkJU81n4l1UrOvkiuHXUlpjbHyOXhnV1YD5fv7W2uDs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ejg5jsJs; arc=none smtp.client-ip=60.244.123.138
X-UUID: 55bbddc260d211f1b1788b6acf885367-20260605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PAxJwUqHC+sJ1RxYzu8X7M7iz9HDPm2JEn9tEGPQd7k=;
	b=ejg5jsJsY37qzIkU9c9I+IED+aRcmLps/OTlRxIC1a9lsrdlfAUDOPMhnF919z4ntnFkWYOWm1pTotV18FAkTgnJOsjO4lY3PMZjIToHwdGj6U9QmzHJ+G8ZMtvIrhohGXxClfrXJcp4fLgfACXooXhGo/Y2xe3GAuh8gLqcsMk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:b0567cb0-b9a6-4112-8722-8ecee793002e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:cf106820-87a8-421b-982c-f5939dba7cba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 55bbddc260d211f1b1788b6acf885367-20260605
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 978662730; Fri, 05 Jun 2026 19:33:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Jun 2026 19:33:10 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 5 Jun 2026 19:33:10 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: <linux-mediatek@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
	Shayne Chen <shayne.chen@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/4] wifi: mt76: mt7915: fix potential tx_retries underflow
Date: Fri, 5 Jun 2026 04:33:03 -0700
Message-ID: <20260605113306.3485554-1-ryder.lee@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37412-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:linux-mediatek@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:shayne.chen@mediatek.com,m:ryder.lee@mediatek.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:from_mime,mediatek.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07756647BFA

When FIELD_GET returns 0 for the retry count, subtracting 1 causes
an unsigned integer underflow, resulting in tx_retries becoming a
very large value (0xFFFFFFFF for u32).

Fix by checking if count is non-zero before subtracting 1.

Fixes: 943e4fb96e6f ("wifi: mt76: mt7915: report tx retries/failed counts for non-WED path")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cec2c4208..334c19ab2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -912,16 +912,16 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 		}
 
 		if (!mtk_wed_device_active(&mdev->mmio.wed) && wcid) {
-			u32 tx_retries = 0, tx_failed = 0;
+			u32 tx_retries = 0, tx_failed = 0, count;
 
 			if (v3 && (info & MT_TX_FREE_MPDU_HEADER_V3)) {
-				tx_retries =
-					FIELD_GET(MT_TX_FREE_COUNT_V3, info) - 1;
+				count = FIELD_GET(MT_TX_FREE_COUNT_V3, info);
+				tx_retries = count ? count - 1 : 0;
 				tx_failed = tx_retries +
 					!!FIELD_GET(MT_TX_FREE_STAT_V3, info);
 			} else if (!v3 && (info & MT_TX_FREE_MPDU_HEADER)) {
-				tx_retries =
-					FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
+				count = FIELD_GET(MT_TX_FREE_COUNT, info);
+				tx_retries = count ? count - 1 : 0;
 				tx_failed = tx_retries +
 					!!FIELD_GET(MT_TX_FREE_STAT, info);
 			}
-- 
2.45.2


