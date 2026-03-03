Return-Path: <linux-wireless+bounces-32378-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCKSN/11pmnDQAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32378-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 06:47:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF2C1E9504
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 06:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E62073037469
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 05:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F6FE56A;
	Tue,  3 Mar 2026 05:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gr9xYPxM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C629A2
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 05:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772516858; cv=none; b=ImPV/oZIHGsFBnYFZTfNxNZvoJB8lzUCARR6SNiD8EyduOJiRbgeDFmZyhftC1A/+Xm2HAHj7Y9P8ipYJCHw+NoI5dSOsUdkEQoEdMeu0rAraoGsmqAlvhs+YcH9wKR+wpxHa889vBQk/Z/RzJLNq7dPVuKUxVd1OOSE0eL22Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772516858; c=relaxed/simple;
	bh=cGjsPqEbKK9eyv4MjchSCyjZy2b3cRLg5Mx9eRe3jJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HUqpOKxMhrYYy4Q2nXcegUkn02iOH24IrJJckuIxsndkbI5WKQCnGfOpdXO6iAM23DWUqdiOCgBkK1oSJJXAAYFEExAjUIqe+Gusyz4BCw8DNEW9UBBrXI8uAfxKCvsbG77w7eoiOYjGHRRiPOexMSZLUhqe1bk30b7seImY5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gr9xYPxM; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 76d7e14816c411f1bcd7499a721e883d-20260303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=U0pjx6MBRdmbHia5VISr9zyiGLKGVqVY7cF6epmrGjQ=;
	b=gr9xYPxMyE8xnKVBBXdOgxItswWjL/ISheIHW9LYLIuNR4hy6Z3utLA9baBrmQZEpUdK3dmq4ed9TY1X1b8CqwRG8lPnnTxUuaaRsRrRZ0S/OwiPl4TYOrRmiostB26CYe3BcU3GKQVYpzx52GtM+VY4jGuuGcPooUbVThzlr4U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:9a9dbb3b-899f-4f87-b867-8cd8b09edf63,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:7cd831f1-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 76d7e14816c411f1bcd7499a721e883d-20260303
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <meichia.chiu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1349511451; Tue, 03 Mar 2026 13:47:28 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Mar 2026 13:47:27 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 3 Mar 2026 13:47:27 +0800
From: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Shayne Chen <shayne.chen@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <Money.Wang@mediatek.com>,
	<linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Subject: [PATCH] wifi: mac80211: fix missing ieee80211_eml_params member initialization
Date: Tue, 3 Mar 2026 13:47:25 +0800
Message-ID: <20260303054725.471548-1-MeiChia.Chiu@mediatek.com>
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
X-Rspamd-Queue-Id: 7DF2C1E9504
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32378-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[MeiChia.Chiu@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[mediatek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid]
X-Rspamd-Action: no action

The missing initialization causes driver to misinterpret the EML control bitmap,
resulting in incorrect link bitmap handling.

Fixes: 0d95280a2d54e ("wifi: mac80211: Add eMLSR/eMLMR action frame parsing support")
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
---
 net/mac80211/eht.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 75096b2195d2..078e1e23d8d1 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -154,6 +154,7 @@ void ieee80211_rx_eml_op_mode_notif(struct ieee80211_sub_if_data *sdata,
 	u8 *ptr = mgmt->u.action.u.eml_omn.variable;
 	struct ieee80211_eml_params eml_params = {
 		.link_id = status->link_id,
+		.control = control,
 	};
 	struct sta_info *sta;
 	int opt_len = 0;
-- 
2.45.2


