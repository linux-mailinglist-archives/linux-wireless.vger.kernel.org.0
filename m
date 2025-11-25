Return-Path: <linux-wireless+bounces-29312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BC4C83447
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 04:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C546C3AEDD0
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 03:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04EA283C87;
	Tue, 25 Nov 2025 03:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OcL+QCZi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AC27FD59
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042454; cv=none; b=hVauS9+qaTgsavtPTJLVGVeSfAfTMRMj7LjRqpOWl6WqyK0arBWbgwi8rdy4Ov5m76R/8Qfr1bCC+KShETyKu9UQ7i9YdEA6SoVDWAunbMhzMIuxHyJCr6z38gGqy6pAluiu3DYHC6atlAH4wmUYRBwdY6DkXwdnSlIu0iRnHlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042454; c=relaxed/simple;
	bh=u+laBWX1oagfD8y1NEHKfeliF3vdWdVHS61uNWfcizU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RG9QjuUQ3SqxmSXWHLnMQeWgGVG0G99D8iTlvfXN1g44NPI/ZfQQ4sTzlZBFDt/iMvP7ZefA4jHulh39Q1dEWyjZuVf4mZJNwxCSyGFwnJFnW2USE7Jh0kau+hkKTHDMRGoJ9o70JsxHW0CnrNBv0x97kttHda4yZUioOWkyz9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OcL+QCZi; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 74ce403cc9b111f0b33aeb1e7f16c2b6-20251125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VRutTgWiFsY/ANndouOE9D1C02+484u/Y3DsWLLZ6BM=;
	b=OcL+QCZiJ402RC9rgyPsRhu2DTb/y70nTIs39UvE4r1i8Lz0YwtYXUcFy2Cc+2HVPWrBAvxmD6aktWnPtL657i8ab8pDEjsplWV9LnXB+kxT07VEW+ccRSklPs/VG8BShM0tphAOORKu3BTXsywChBASX2sHTSv5zXyQk4P7qv0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f7d55265-9e6c-4fa7-8be9-e942cb2ebaa5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:63152abb-0c02-41a0-92a3-94dc7dc7eeca,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 74ce403cc9b111f0b33aeb1e7f16c2b6-20251125
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1124357827; Tue, 25 Nov 2025 11:47:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 25 Nov 2025 11:47:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 25 Nov 2025 11:47:24 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 4/7] wifi: mt76: mt7996: abort CCA when CSA is starting
Date: Tue, 25 Nov 2025 11:46:36 +0800
Message-ID: <20251125034639.1416214-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251125034639.1416214-1-shayne.chen@mediatek.com>
References: <20251125034639.1416214-1-shayne.chen@mediatek.com>
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
index 8f2b3f4f25ab..4e78f8e585d9 100644
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


