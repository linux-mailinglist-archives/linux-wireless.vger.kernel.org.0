Return-Path: <linux-wireless+bounces-1300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B08F81F637
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 10:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC20B22795
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F77F7477;
	Thu, 28 Dec 2023 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bq8Q/9A0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571966FA3
	for <linux-wireless@vger.kernel.org>; Thu, 28 Dec 2023 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 94bb8930a56011ee9e680517dc993faa-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/vDByupUfyISXXTWuopoR7VUqbCKko4NXwHDyQ6l7KU=;
	b=bq8Q/9A0ihGhgNMnH5jmXdk0fGBVNO0enInG6ciMa72aoNDFf7PJzr4fLzLuRFHDpBCOmYwZqLbKBQ+/CCzh10jydLYFNRvsH6EHqPDotMyps5jZJb+raeGqYrERqcP9fcjbW8Y/bV6YMGDBB3jpyeIuP3qLaPZdMKyfOMKDYT8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:6aac890a-5051-4e60-86b6-47e94203a1db,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:b07ca98d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 94bb8930a56011ee9e680517dc993faa-20231228
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 924546400; Thu, 28 Dec 2023 17:07:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 17:07:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 17:07:52 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 07/10] wifi: mt76: mt7925: fix the wrong header translation config
Date: Thu, 28 Dec 2023 17:07:46 +0800
Message-ID: <20231228090749.15191-8-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231228090749.15191-1-mingyen.hsieh@mediatek.com>
References: <20231228090749.15191-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.733100-8.000000
X-TMASE-MatchedRID: QMK8gM4dfEMUhfC/ipzRk2k5BPvE0+6WK70vctTSAAccwojTLz1sEtAY
	WUo4HSIkc46ToSz0LLxr4juqG1HKuzEV1fJb8/5dbc297PAGtWZMkOX0UoduuQCGaccd4ae9Q09
	1A4TyNpoR4d+Uvhl0qjVKsMbHn8GJvycUQR1kwKaeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8jfhP
	1xgyx3DCGV0CE3FLpC1980gzEE6UbPR3p2NEv4v1WMtCORztjQRNSZlxZuNFzP3raw2QuvZl5Y/
	Jlwxz0+G/GKqjU34EkWUQpFBvThUo6H7DI0GsVcMmI24qiENwrMpIbcl3IoA+q1XYAYw09qIdY9
	jOi4lTI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.733100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	8DC4502D9B22A98703EE3C7E6AD2104ABBC70AE491ACBE0DF9A9DE8FBBC5D6902000:8

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The header translation config should set to broadcast and unicast
cases correctly, not only unicast case. And also remove the cmds
of wtbl (wlan table) series, because these MCU commands have
already been replaced by other commands in mt7925.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 32 +++++--------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 8c3233182083..932ecf38672c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -814,6 +814,7 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta)
 {
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct sta_rec_hdr_trans *hdr_trans;
 	struct mt76_wcid *wcid;
 	struct tlv *tlv;
@@ -827,7 +828,11 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 	else
 		hdr_trans->from_ds = true;
 
-	wcid = (struct mt76_wcid *)sta->drv_priv;
+	if (sta)
+		wcid = (struct mt76_wcid *)sta->drv_priv;
+	else
+		wcid = &mvif->sta.wcid;
+
 	if (!wcid)
 		return;
 
@@ -1577,8 +1582,6 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 {
 	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
-	struct wtbl_req_hdr *wtbl_hdr;
-	struct tlv *sta_wtbl;
 	struct sk_buff *skb;
 
 	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid,
@@ -1602,30 +1605,11 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->sta,
 					    info->vif, info->rcpi,
 					    info->state);
-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->sta);
 		mt7925_mcu_sta_mld_tlv(skb, info->vif, info->sta);
 	}
 
-	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
-					   sizeof(struct tlv));
-
-	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, info->wcid,
-						  WTBL_RESET_AND_SET,
-						  sta_wtbl, &skb);
-	if (IS_ERR(wtbl_hdr))
-		return PTR_ERR(wtbl_hdr);
-
-	if (info->enable) {
-		mt76_connac_mcu_wtbl_generic_tlv(dev, skb, info->vif,
-						 info->sta, sta_wtbl,
-						 wtbl_hdr);
-		mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, info->vif, info->wcid,
-						   sta_wtbl, wtbl_hdr);
-		if (info->sta)
-			mt76_connac_mcu_wtbl_ht_tlv(dev, skb, info->sta,
-						    sta_wtbl, wtbl_hdr,
-						    true, true);
-	}
+	if (info->enable)
+		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->sta);
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
 }
-- 
2.18.0


