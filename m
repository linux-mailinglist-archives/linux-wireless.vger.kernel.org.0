Return-Path: <linux-wireless+bounces-31752-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHQ7MYYgjWmJzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31752-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 01:36:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7004128A90
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 01:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8924D302DEC9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 00:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4B19DF62;
	Thu, 12 Feb 2026 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="snOMhfBT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE298635D;
	Thu, 12 Feb 2026 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770856579; cv=none; b=H4ReuXfjOlU99O1xSrtdXDItjsMAfFrcEcac7hRobI3/h3JgJd7wy0syyIWx8p83228E2Iy92knLv0HDi5dKh+zM+uB+gZmXhQNqeCo4PhB54GDrru4l4zCe0A2IcHfWxMbAxeClbiV9oxWs9Jxvq6RbGOHcZPc0Qcp/9Ysxg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770856579; c=relaxed/simple;
	bh=0f9mtHbO4Yya5wajS7zjy+Kx+fw3IPbjRQ9gz1dfc1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0b/KKAhIRlqsNbtV/rs9h6hiwB38K+k7N4u+YOX2TRd3zQWqJrffSjwy3kGI3cJA8kqDKgnuCBlNk6zQ9YQ6HmxsYdLhGDLzV4GsPgQt2qVy3/wHATuW4T2jPGYA7SI5RdjaGtPfZ5eadVBUzvd8/xIdsi/GuFhLIQgjDqnX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=snOMhfBT; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d517d48a07aa11f1b7fc4fdb8733b2bc-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=I2c8plAdsXPKdtqXqFU1sBc11ndG+WPMfeCU0BQGML4=;
	b=snOMhfBTHxiNTlt/Jn7n9brs0Rpb0XDxLYFBppzIBkMnA7AzIahpsDuz1qfeB0yMPZxb1S0DTYNE0SGVw15EjH8K5HoQiX3nQLzQocAiNm6Zorq4dwY4/HpaRtKhpzcuBNcK0thhjlqOfocIEkIAvtaMFA+T17KS7GGSe8/QIIk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:18007bb4-f63d-4744-89de-c4a612e8b58b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:5110335b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d517d48a07aa11f1b7fc4fdb8733b2bc-20260212
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 797882504; Thu, 12 Feb 2026 08:36:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 08:36:11 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 08:36:10 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-wireless@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Allen
 Ye <allen.ye@mediatek.com>
Subject: [PATCH v5 2/2] dt-bindings: net: wireless: mt76: clarify backoff limit usage
Date: Wed, 11 Feb 2026 16:36:06 -0800
Message-ID: <e39bff1d56a3f8b5146b881eef3442a4af97078b.1770856296.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770856296.git.ryder.lee@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770856296.git.ryder.lee@mediatek.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31752-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[mediatek.com:+]
X-Rspamd-Queue-Id: E7004128A90
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
---
 .../bindings/net/wireless/mediatek,mt76.yaml  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index ae6b97cdc..20b868f7d 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -27,6 +27,11 @@ properties:
       - mediatek,mt7622-wmac
       - mediatek,mt7981-wmac
       - mediatek,mt7986-wmac
+      - pci14c3,7915  # mt7915
+      - pci14c3,7906  # mt7916
+      - pci14c3,7990  # mt7996
+      - pci14c3,7992  # mt7992
+      - pci14c3,7993  # mt7990
 
   reg:
     minItems: 1
@@ -252,6 +257,14 @@ properties:
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
@@ -270,6 +283,14 @@ properties:
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


