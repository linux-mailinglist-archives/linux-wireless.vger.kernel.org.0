Return-Path: <linux-wireless+bounces-31992-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAkxBtBZlmm9eAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31992-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 01:31:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B524F15B28C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 01:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3800F304A6DA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 00:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43013221FCD;
	Thu, 19 Feb 2026 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MAetSQS9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783521448D5;
	Thu, 19 Feb 2026 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771461053; cv=none; b=SOKOK8XsX7S+tnww42moCeacmVY9vbWuoIJCrvC0Qe47i/SjGXYbYapG2zUjDKy6niBmVy6DbtnNO4rYXpBAVygMZe/ecbWwbvteeiJygZjEGtYn3WQWPEvAbWBxm9SS3/cTh+oMVPLcugOlmMIJ2QjkQrhFeaVKx9TvNHCar+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771461053; c=relaxed/simple;
	bh=K63sE+heA6dIPkSHQF8iWzG6C+zCfl+e50if7LFWoLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwTmGB/PFR38s2Oa2T+rrLe9bEdB15/uAQWWLvUlF4lkfzPjaXZDGxSxwqSUCqa0LlEUjqYjggM9a4VwHw00/Op2iuF7Oxupjor8ItsV5exnmBmjiQZvR0YVIMsB1KA2uHFf2yzHwDdNIeu/dMr2agQVRod2mO85xTKvMH7rQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MAetSQS9; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 374391ba0d2a11f1b7fc4fdb8733b2bc-20260219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rAzH74nBcBGKigZp9kU3P2C14pIvF/kRN1BygaisLuw=;
	b=MAetSQS9W9gb/rtoBbqZ8DSRywBg7MFtUYllKDfiJ7l56ojanu3q54RRliHf0uEDCrbXMVQsFYn3maG7fXyDeIy0mRk3LaMRp4Ow6ZjU43MLpyDId34HWOpp8ucoMM+OfDVCxuNskPypxIAMjoFbXaishGAdWHAVDthwUVWgaTA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:5cc62dc7-8699-4d20-a823-bf0309910dd2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:a5c1645b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 374391ba0d2a11f1b7fc4fdb8733b2bc-20260219
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 128733101; Thu, 19 Feb 2026 08:30:39 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Feb 2026 08:30:37 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 19 Feb 2026 08:30:36 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>
CC: <devicetree@vger.kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-wireless@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Allen
 Ye <allen.ye@mediatek.com>
Subject: [PATCH v8 3/3] dt-bindings: net: wireless: mt76: clarify backoff limit usage
Date: Wed, 18 Feb 2026 16:30:29 -0800
Message-ID: <87acf1a8ab5642298c67915b3afc41e624b312a7.1771205424.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1771205424.git.ryder.lee@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1771205424.git.ryder.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31992-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:email]
X-Rspamd-Queue-Id: B524F15B28C
X-Rspamd-Action: no action

Clarify the usage of path backoff limit properties in mt76 binding.
Add explicit documentation for old generation (mt7915, mt7916, mt7981,
mt7986) and new generation (mt7990, mt7992, mt7996) devices, including
the difference in beamforming and non-beamforming entries.

Rephrase the paths-ru/paths-ru-bf description to make them more precise.

Co-developed-by: Allen Ye <allen.ye@mediatek.com>
Signed-off-by: Allen Ye <allen.ye@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v4:
- revise commit message
- use PCI id as the compatible string to replace "connac2/3"

v5: fix missing starting space in comment(comments)
v6: separate commits with their own separate rationale
v7: add missing dts mailing list and maintainers
---
 .../bindings/net/wireless/mediatek,mt76.yaml     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index 72cc30251..20b868f7d 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -257,6 +257,14 @@ properties:
                       followed by 10 power limit values. The order of the
                       channel resource unit settings is RU26, RU52, RU106,
                       RU242/SU20, RU484/SU40, RU996/SU80 and RU2x996/SU160.
+                      - For mt7981/mt7986/mt7915/mt7916
+                        - Beamforming entries for BW20~BW160 and OFDM do not
+                          include 1T1ss.
+                        - When 1T1ss is not used, it should be filled with 0.
+                      - For mt7996/mt7992/mt7990
+                        - Beamforming entries for BW20~BW160 and RU include
+                          1T1ss, but OFDM does not include 1T1ss.
+                        - 1T1ss is taken into account, so no need to fill with 0.
                     minItems: 1
                     maxItems: 7
                     items:
@@ -275,6 +283,14 @@ properties:
                       followed by 10 power limit values. The order of the
                       channel resource unit settings is RU26, RU52, RU106,
                       RU242/SU20, RU484/SU40, RU996/SU80 and RU2x996/SU160.
+                      - For mt7981/mt7986/mt7915/mt7916
+                        - Beamforming entries for BW20~BW160 and OFDM do not
+                          include 1T1ss.
+                        - When 1T1ss is not used, it should be filled with 0.
+                      - For mt7996/mt7992/mt7990
+                        - Beamforming entries for BW20~BW160 and RU include
+                          1T1ss, but OFDM does not include 1T1ss.
+                        - 1T1ss is taken into account, so no need to fill with 0.
                     minItems: 1
                     maxItems: 7
                     items:
-- 
2.45.2


