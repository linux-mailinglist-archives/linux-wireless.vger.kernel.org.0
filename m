Return-Path: <linux-wireless+bounces-29743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 827B2CBCA94
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 07:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D4C1302EA0A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 06:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B47630BF70;
	Mon, 15 Dec 2025 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fc56RGhL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEB82F1FED
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765780689; cv=none; b=XEZRxa+qedpbylFYnVNPINPpp/y/z94fxOJ9uXbn1zwxcxopvkvdS0w9cCwqdwk6LCOJbrlsJDL3HJe9hOQSiq8qM72lO00jKhjHgm2K2M+QF2O45mTlBss+4OnIIXajJtWEdZUTDRe5/kMwlOu0MO7lG+O7HQEMBz0vNKyXDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765780689; c=relaxed/simple;
	bh=RETnmELVKrBEugR67KznkK1o62nOXvlTNiCpbJ+/U34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7ias86DXrPWKoNUIU7HSmqtdyH5woDr2Hu8rSUvJLr3X/iVElyr+X78h8G0/PpL9LuydtLAnFM4Efy+IVBlGYGn2Ncjlb42nhxfUZoy4m4H022FvRxFx6e07+da2NGDquvCIK4b58dh66x8qP7PEdeVpsBatI7cSKgqWdZ6HKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fc56RGhL; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 99e4fc56d98011f0b2bf0b349165d6e0-20251215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=e+EYT2mUwkDDgBM3uPCtiIrJtFGpEl9FNkQxtU/d7BY=;
	b=fc56RGhLzFXQ1raJkA4HlAoT5gwhb2fUVA5f8IpUvXgMPtVoQjStzQMrzPDseqVQ0IgsQAuOcYK5SahCP8AgGtRtTQjk+itw6TW/euNXU6dvpRfxdyFljTonzHbe/nZ4Pa6PTcWLQ4X545ZZRfYKHbF0hSP4TLpnM8cV8W7fbew=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c3b63774-7320-482f-9578-8cfa0a7da8e2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:ae7ac602-1fa9-44eb-b231-4afc61466396,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 99e4fc56d98011f0b2bf0b349165d6e0-20251215
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 513346095; Mon, 15 Dec 2025 14:38:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 14:37:59 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 14:37:59 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 v2 4/7] wifi: mt76: mt7996: abort CCA when CSA is starting
Date: Mon, 15 Dec 2025 14:37:25 +0800
Message-ID: <20251215063728.3013365-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251215063728.3013365-1-shayne.chen@mediatek.com>
References: <20251215063728.3013365-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

When CSA countdown is going to start, carry UNI_BSS_INFO_BCN_BCC tag to
abort any CCA countdown.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 10 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h | 11 ++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 0e514b818d0f..73c3741b532e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2796,6 +2796,16 @@ mt7996_mcu_beacon_cntdwn(struct sk_buff *rskb, struct sk_buff *skb,
 
 	info = (struct bss_bcn_cntdwn_tlv *)tlv;
 	info->cnt = skb->data[offs->cntdwn_counter_offs[0]];
+
+	/* abort the CCA countdown when starting CSA countdown */
+	if (csa) {
+		struct bss_bcn_cntdwn_tlv *cca_info;
+
+		tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_BCN_BCC,
+					     sizeof(*cca_info));
+		cca_info = (struct bss_bcn_cntdwn_tlv *)tlv;
+		cca_info->cca.abort = true;
+	}
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 5b3597ca79be..1283beb0dc19 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -412,7 +412,16 @@ struct bss_bcn_cntdwn_tlv {
 	__le16 tag;
 	__le16 len;
 	u8 cnt;
-	u8 rsv[3];
+	union {
+		struct {
+			bool static_pp;
+			bool abort;
+		} csa;
+		struct {
+			bool abort;
+		} cca;
+	};
+	u8 rsv;
 } __packed;
 
 struct bss_bcn_mbss_tlv {
-- 
2.51.0


