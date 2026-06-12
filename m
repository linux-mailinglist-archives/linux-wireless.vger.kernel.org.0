Return-Path: <linux-wireless+bounces-37705-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NXAPG0G7K2okDgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37705-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:54:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F27996777B1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:54:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=kVejCrlu;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37705-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37705-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02A9130E3F3A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB1F2E6CCD;
	Fri, 12 Jun 2026 07:51:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2C3E4507
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:51:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250710; cv=none; b=fiFLU98JJ2b2IG8+gpezQOQU2x9KJ/JEeOuCfi9sMwtJwjo5AtnGG7KRJDrakwfjuj5GKQdJTqmUa//LGGB4qceSyfJrh9rXof3neghjmTmfNYT6wXwfpg4Ap86usEug5J0kNInyp13vA7JPSouIKn9GEUec9aIMUvirEZTbSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250710; c=relaxed/simple;
	bh=dupvXjL1YC+0tpuXfMIOT2tCsrO5SnvZ+mmJx3ubJmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyYU4gkjoG4RJi0kh1BjODyy4SGCpmGThB7raBk4+fAxLKv0tRIiaTQkOial3kvtFGkkFcJBfM/GJPIwzx1qRbMrz+3bS2qhe91B9p4Qxm8LAQUxRiBAf11b/AamANrWX/Oz79BYRuWMax1H68uJOPw+jRuEDRqxIbQPYkVoFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kVejCrlu; arc=none smtp.client-ip=60.244.123.138
X-UUID: 8c47513a663311f1b1788b6acf885367-20260612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=O0kfyfv4ta4qYQpadkoa8xGJxSxkjjSObeU1cL1n3M4=;
	b=kVejCrlukeycXMMz08J2CPKKMN2iAi9wRvAE1RSreoot4QMRNGa4bkMqFuuwEJqrFPi6bsftPIF6XC+fb80vttPUGMzPZCGp6CFaUa2uwUtNRumPcLxEEmIe3qywz9zU52EhuRwrv3jOyGvmF40ZdmqW5lcyNVkPMirzGXoQOfM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:1c79154b-7716-4534-9736-2e0ec2929a63,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e276073,CLOUDID:c248fda4-9ef7-4489-861a-e83b251ece46,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8c47513a663311f1b1788b6acf885367-20260612
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1307775472; Fri, 12 Jun 2026 15:51:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Jun 2026 15:51:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 12 Jun 2026 15:51:39 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <emery.hsin@mediatek.com>,
	<jb.tsai@mediatek.com>
Subject: [PATCH 09/20] wifi: mt76: mt7925: rename WTBL registers to chip-specific format
Date: Fri, 12 Jun 2026 15:51:35 +0800
Message-ID: <20260612075136.2577553-4-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260612075136.2577553-1-jb.tsai@mediatek.com>
References: <20260612075136.2577553-1-jb.tsai@mediatek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-37705-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,mediatek.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F27996777B1

From: Emery Hsin <emery.hsin@mediatek.com>

Rename MT_WTBLON_TOP_WDUCR and MT_WTBL_UPDATE to MT7925-prefixed
versions since MT7928 uses different WTBL register offsets.

This is a preparation patch before enabling MT7928 PCIe support.

Signed-off-by: Emery Hsin <emery.hsin@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7925/mac.h  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 5dd895c3f205..44d5a1e7e415 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -12,10 +12,10 @@
 
 bool mt7925_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask)
 {
-	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
+	mt76_rmw(dev, MT7925_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
 		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
 
-	return mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
+	return mt76_poll(dev, MT7925_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
 			 0, 5000);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.h b/drivers/net/wireless/mediatek/mt76/mt7925/mac.h
index 83ea9021daea..67148c87de76 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.h
@@ -14,7 +14,7 @@
 
 static inline u32 mt7925_mac_wtbl_lmac_addr(struct mt792x_dev *dev, u16 wcid, u8 dw)
 {
-	mt76_wr(dev, MT_WTBLON_TOP_WDUCR,
+	mt76_wr(dev, MT7925_WTBLON_TOP_WDUCR,
 		FIELD_PREP(MT_WTBLON_TOP_WDUCR_GROUP, (wcid >> 7)));
 
 	return MT_WTBL_LMAC_OFFS(wcid, dw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index 85adde2ad597..0bcfd1cf0338 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -90,10 +90,10 @@
 
 #define MT_WFSYS_SW_RST_B		0x7c000140
 
-#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x370)
+#define MT7925_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x370)
 #define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(4, 0)
 
-#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x380)
+#define MT7925_WTBL_UPDATE		MT_WTBLON_TOP(0x380)
 #define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(11, 0)
 #define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(14)
 
-- 
2.45.2


