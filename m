Return-Path: <linux-wireless+bounces-31990-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FUjDM79Zlmm+eAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31990-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 01:30:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD815B266
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 01:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AB41300BDA8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3241917ED;
	Thu, 19 Feb 2026 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M/jrC67g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058098634C;
	Thu, 19 Feb 2026 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771461052; cv=none; b=X+E6mM/3o3Dt/A0Ew4nKh/j2wx+lo93V4YqVL4d4u6VqJ3wG2p3skGzUs9LbncodhKWOab7mf/SWgoXGUiPv/n4+PGDhTmGjjxMCnp5Cx4b4WT9dtzn3IQiv/0BtMY/u9xaq9N/oWbVbA2qlff8zFuEIBHIByytoO5xI9Rr83bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771461052; c=relaxed/simple;
	bh=mTkDqMP+9MNID0dYPnCifQEPIsouDCKm+egbA17Kd+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LH4KoMUT7nQ6m/iNtkdctwMGXc3NMK/OrvMYEGUETOw97OPrE+SCzn5MbYVPW7v24bvdGq6KyTQGkQ/rIIMjM1WLNC6coXOr+n0+8+X/tncEP2rRWKxkSHfBBbJS08/K8Bsem3Gexw9f2e0ZCZkCY8N91D0DB843L33MOvcim/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=M/jrC67g; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 35cb3cb60d2a11f1b7fc4fdb8733b2bc-20260219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ezdfd9Sxz6JvC4abwic4pb6waxE2hSCcwIyWlcw82j8=;
	b=M/jrC67gDZlyvyZhDQ4Z8TRbXGK7lpsJ4yTWSTLZmnfET9wJnjFknn6j352YYs9QAaCdzil/X8F8jZfUGgxJAnQZeqU9a4quKD8q/kPG0hATCKM3PIA9k0x6cTvgOvSx2GGlODEK/Pg+QrmGQYx2F+ynfdTsxTooEb21+vxry0k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:be552c97-95fb-42c1-aa60-564a00e48517,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:8ac1645b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 35cb3cb60d2a11f1b7fc4fdb8733b2bc-20260219
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1827063204; Thu, 19 Feb 2026 08:30:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 19 Feb 2026 08:30:35 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 19 Feb 2026 08:30:34 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>
CC: <devicetree@vger.kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-wireless@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v8 2/3] dt-bindings: net: wireless: mt76: add mt79 PCI devices
Date: Wed, 18 Feb 2026 16:30:28 -0800
Message-ID: <5022737c82052132702004ab0fdc073f5cf6df69.1771205424.git.ryder.lee@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31990-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96BD815B266
X-Rspamd-Action: no action

Add mt79 series PCI compatibles. WiFi TX power settings must be provided
via the platform's DTS node. Different generations interpret these
settings differently, so we need to distinguish them using PCI IDs or
compatible strings in the documentation.

The following patches will further explain the differences in TX power
handling between generations.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v7: add missing dts mailing list and maintainers
v8: revise commit message
---
 .../devicetree/bindings/net/wireless/mediatek,mt76.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index ae6b97cdc..72cc30251 100644
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
-- 
2.45.2


