Return-Path: <linux-wireless+bounces-31880-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CPTH3GhkmlmvwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31880-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 05:47:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FF4140DFE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 05:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DDBB300794D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 04:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECBC2DE717;
	Mon, 16 Feb 2026 04:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YOdqci8r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1C24503F
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 04:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771217261; cv=none; b=XBc1RpFA8wWvuaEftpV/Nh00E4XmahT5ARp3/sPxQXZRVc8SAZatHoet4XinUv9Khnq20yrtaZgZ+JLGw0PkTIQzbFA23QQT2kg0i9cFZLjD0ZRy9wsEx6QGGeIrcFr8qH4Gj7PsGJEqR04LgTX81k+nh8ziRfCDW9K2i+Z8k4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771217261; c=relaxed/simple;
	bh=DJgakD/v93Mmn5PnIzbx+5nz1sSmg6SZ5FFm1e//Hns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXPr57k3xDnX8wYkaNUP048lkjMTDKzdQKJVbQeh0UbocrBTyBKQqDoQOAOXGQaPF83KeomktznUaYF5TXg0AaxOM0i7AmCcXnWdFrao8hdpaTU8f3EmNK+dT1r1PEtAOnGzQ7ToRj7X0C5UZMCttNOmeLX40biu/DachHPMwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YOdqci8r; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 97514dd40af211f185319dbc3099e8fb-20260216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pCwVfReCAGlJke9yJfTfhK+baPf+TTVwuEOOqiV5je0=;
	b=YOdqci8r02faVl7NU142Qg+yhT0oM/k1DU4bF1BIQ8Mvg1EYC6S0bPwHoP/SDd6OIw1mKttsW2nkN0RynZvsu2CWAYPAPixnBDNommcox7LYeENXMQIaptIvX0hZ881j/Bi/2DTm13GRQm1KiRzRajpkfhghWH2NvsARf4I/YpA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:ef6a4f1d-d578-46f7-b9ec-27679ef15302,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:9a55b5e9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 97514dd40af211f185319dbc3099e8fb-20260216
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 907443429; Mon, 16 Feb 2026 12:47:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 16 Feb 2026 12:47:24 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 16 Feb 2026 12:47:24 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: <linux-mediatek@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v6 2/3] dt-bindings: net: wireless: mt76: add more PCI devices
Date: Sun, 15 Feb 2026 20:47:19 -0800
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31880-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:email]
X-Rspamd-Queue-Id: E7FF4140DFE
X-Rspamd-Action: no action

This adds support for mt7915/mt7916/mt7990/mt7992/mt7996 PCI devices.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
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


