Return-Path: <linux-wireless+bounces-2237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1618B83260B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDB02858EC
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722902577F;
	Fri, 19 Jan 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y8qwCwFc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D51E89E
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705654666; cv=none; b=VGMrLuQgdCXqIPo91Bbwj1v7rpw9esJ40uhDpZA7ZzwS/TmIWyZy7Wr1Ijps/6BL+Dr9u2QD+EJT9z7R7ImeIOy/qQpRO3rz598+c8URuDu9PU9QK6sHZBjcRRGG5sQMfZWU3gEr/hMu+beYuq/9Zfd2ORgFxkdISHs+lMypKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705654666; c=relaxed/simple;
	bh=eTo00LLUX4fGQz/GzKvUMjg9vDEF0BvFRqBk9LptcpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gz6g1ILeidtIbhVH7l3LDxx5uw2pyeBDaWgU0jsbEn2jcgAuIMeC8xs8PtsiPgomy30CEOTDDVM7FY1p8UCYX2BnV3vkbKj/lI2lTSlQcxvgBOQsKJuqQsqgMgO52Y+SxCUdDRq2VjmNdncBfm4WypFsYJnZNnJ4Iy4ZDllXgG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Y8qwCwFc; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cb37f102b6a811ee9e680517dc993faa-20240119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=79BOp+QHnp/WxXVwhfhRQ9gIIlNiACRXFjaRcN9R2c8=;
	b=Y8qwCwFcIrdt+eQTftQPPMjWGdih6qDMcBE11VXo7CBWaAcu0brz5hBBC7pharLvSAn92gvAzMe3NVUI7yMsAsMjOazOG/znX7sx3PtT5F5Yb5y938rUbLAiolunKC/ODB3WvK/xIATSLB2whaPUiQoCFL75lBSkgsTU/GCO2Ys=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:01415272-04fe-4455-9408-ad7fd857238f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:3a6b0783-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cb37f102b6a811ee9e680517dc993faa-20240119
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1712855622; Fri, 19 Jan 2024 16:57:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Jan 2024 16:57:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Jan 2024 16:57:36 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Benjamin Lin
	<benjamin-jw.lin@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 05/12] wifi: mt76: mt7996: ensure 4-byte alignment for beacon commands
Date: Fri, 19 Jan 2024 16:57:01 +0800
Message-ID: <20240119085708.23592-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240119085708.23592-1-shayne.chen@mediatek.com>
References: <20240119085708.23592-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.804500-8.000000
X-TMASE-MatchedRID: Zok17GuDVgvTm7y7XCZFTx+WEMjoO9WWVBDQSDMig9HRLEyE6G4DRFox
	ssqv49ULvvJoxo0uTMRllySiYBqj+uhKL24lXrDJnu1HSadECDWH7D1bP/FcOpp5yGjWmTixpc2
	xgJAY6Lq463ONS2fYMqwnY0RVRjvrHxPMjOKY7A8LbigRnpKlKTpcQTtiHDgWGdlMygVSuKdKFh
	SceqvE0Zr5KEpDlo92xdYxpLkQ//+0nTThA/TZTg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.804500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4BAEB2BEE94BDFD346D406AC53E4F62A38E620559B6013BE1A6E31E033C927162000:8
X-MTK: N

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

If TLV includes beacon content, its length might not be 4-byte aligned.
Make sure the length is aligned before sending beacon commands to FW.

Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 14 +++++---------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h |  4 ++--
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 02d858fdc9fe..55512e62f98b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -732,13 +732,10 @@ void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb)
 static struct tlv *
 mt7996_mcu_add_uni_tlv(struct sk_buff *skb, u16 tag, u16 len)
 {
-	struct tlv *ptlv, tlv = {
-		.tag = cpu_to_le16(tag),
-		.len = cpu_to_le16(len),
-	};
+	struct tlv *ptlv = skb_put(skb, len);
 
-	ptlv = skb_put(skb, len);
-	memcpy(ptlv, &tlv, sizeof(tlv));
+	ptlv->tag = cpu_to_le16(tag);
+	ptlv->len = cpu_to_le16(len);
 
 	return ptlv;
 }
@@ -2522,7 +2519,7 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 	info = IEEE80211_SKB_CB(skb);
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->mt76->band_idx);
 
-	len = sizeof(*bcn) + MT_TXD_SIZE + skb->len;
+	len = ALIGN(sizeof(*bcn) + MT_TXD_SIZE + skb->len, 4);
 	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_BCN_CONTENT, len);
 	bcn = (struct bss_bcn_content_tlv *)tlv;
 	bcn->enable = en;
@@ -2591,8 +2588,7 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 	info->band = band;
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->mt76->band_idx);
 
-	len = sizeof(*discov) + MT_TXD_SIZE + skb->len;
-
+	len = ALIGN(sizeof(*discov) + MT_TXD_SIZE + skb->len, 4);
 	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_OFFLOAD, len);
 
 	discov = (struct bss_inband_discovery_tlv *)tlv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 36cacc495c75..43468bcaffc6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -800,10 +800,10 @@ enum {
 					 sizeof(struct sta_rec_hdr_trans) +	\
 					 sizeof(struct tlv))
 
-#define MT7996_MAX_BEACON_SIZE		1342
+#define MT7996_MAX_BEACON_SIZE		1338
 #define MT7996_BEACON_UPDATE_SIZE	(sizeof(struct bss_req_hdr) +		\
 					 sizeof(struct bss_bcn_content_tlv) +	\
-					 MT_TXD_SIZE +				\
+					 4 + MT_TXD_SIZE +			\
 					 sizeof(struct bss_bcn_cntdwn_tlv) +	\
 					 sizeof(struct bss_bcn_mbss_tlv))
 #define MT7996_MAX_BSS_OFFLOAD_SIZE	(MT7996_MAX_BEACON_SIZE +		\
-- 
2.39.2


