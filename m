Return-Path: <linux-wireless+bounces-20994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072F3A76313
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 11:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA9916615B
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD271D6DBC;
	Mon, 31 Mar 2025 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lwgvSqGU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBF15624B
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743412686; cv=none; b=cLsp8UOhksTBxGXiYEvYr3YIXapDlrY1jEI5DkVeLed9Ula8Tr+21qIyfKoh2KHvLc2QuETfbXbTthSa7FzSNZd1xBxxplwtAzk8KvwqkFFZ9J4k0EaYFLcCMSHLOwvWyMB6qnn+h1OBsZEDcpeEassSl3eq6KDvj0lxEakeDwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743412686; c=relaxed/simple;
	bh=g5WOXN7tjirS3hQ6eNbzOY9d+LjZVtNhw9bW5KtTAmg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DXGibCzOYjEXESOunxxKdvNTbRX4YCJl+fBFj7v+6EBEIbgI5Q3xLdRlnPfxNdYc8WNKUB/hL+9ybEqAozJCQab15yF7bl9v81514K2NId0C3yLu5EOeL3T6Iqyfv8XJkqkHXaDS+Rx2srrAOQzNMZuc8psnp9fqJaotP/Xh2t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lwgvSqGU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 06cf0f5a0e1111f08eb9c36241bbb6fb-20250331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KHqToERv4Tac/mm0zbgftvUdTtlwe0Vgt811wXQWxJA=;
	b=lwgvSqGUYAexeXfi4lCm+52S1LIuLdxAYy8ULhA19qQS8NII+DW+kEvdyP5Q16hquezoJGx2rLeDMw8Bpk33lnvUaNEAL9qPjd9Iaw3Fyc2306VcA9Lcakd+aQ7A59sn+Qsv259NLYvVGnPCvj/nMqRMZlOmaHtQARxLYVIwqeY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:10fb91f7-5ae7-4fa4-96a7-35f4f1cd7127,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:457500c7-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 06cf0f5a0e1111f08eb9c36241bbb6fb-20250331
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <allan.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 63356197; Mon, 31 Mar 2025 17:17:53 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 31 Mar 2025 17:17:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 31 Mar 2025 17:17:52 +0800
From: Allan Wang <allan.wang@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <mingyen.hsieh@mediatek.com>,
	<Sean.Wang@mediatek.com>, <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Allan Wang <allan.wang@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: add EHT preamble puncturing
Date: Mon, 31 Mar 2025 17:17:47 +0800
Message-ID: <20250331091747.2592021-1-allan.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add mt7925 EHT preamble puncturing.

Signed-off-by: Allan Wang <allan.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 10 ++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 34 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 16 +++++++++
 4 files changed, 61 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 43237e518373..e57287a9e41d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1369,6 +1369,7 @@ enum {
 	UNI_BSS_INFO_OFFLOAD = 25,
 	UNI_BSS_INFO_MLD = 26,
 	UNI_BSS_INFO_PM_DISABLE = 27,
+	UNI_BSS_INFO_EHT = 30,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index e79364ac129e..83f93f9e002c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1865,6 +1865,10 @@ mt7925_change_chanctx(struct ieee80211_hw *hw,
 			link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
 			mt7925_mcu_set_chctx(mvif->phy->mt76, &mconf->mt76,
 					     link_conf, ctx);
+
+			if (changed & IEEE80211_CHANCTX_CHANGE_PUNCTURING)
+				mt7925_mcu_set_eht_pp(mvif->phy->mt76, &mconf->mt76,
+						      link_conf, ctx);
 		}
 	}
 
@@ -1954,8 +1958,10 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_bss_conf *mconf;
+	struct ieee80211_bss_conf *link_conf;
 
 	mconf = mt792x_vif_to_link(mvif, info->link_id);
+	link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
 
 	mt792x_mutex_acquire(dev);
 
@@ -1997,6 +2003,10 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 		mvif->mlo_pm_state = MT792x_MLO_CHANGED_PS;
 	}
 
+	if (changed & IEEE80211_CHANCTX_CHANGE_PUNCTURING)
+		mt7925_mcu_set_eht_pp(mvif->phy->mt76, &mconf->mt76,
+				      link_conf, NULL);
+
 	mt792x_mutex_release(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index e61da76b2097..46f7e30232d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2298,6 +2298,40 @@ __mt7925_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif_link *mvif, int
 	return skb;
 }
 
+static
+void mt7925_mcu_bss_eht_tlv(struct sk_buff *skb, struct mt76_phy *phy,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct ieee80211_chanctx_conf *ctx)
+{
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
+						  &link_conf->chanreq.oper;
+
+	struct bss_eht_tlv *req;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_EHT, sizeof(*req));
+	req = (struct bss_eht_tlv *)tlv;
+	req->is_eth_dscb_present = chandef->punctured ? 1 : 0;
+	req->eht_dis_sub_chan_bitmap = chandef->punctured;
+}
+
+int mt7925_mcu_set_eht_pp(struct mt76_phy *phy, struct mt76_vif_link *mvif,
+			  struct ieee80211_bss_conf *link_conf,
+			  struct ieee80211_chanctx_conf *ctx)
+{
+	struct sk_buff *skb;
+
+	skb = __mt7925_mcu_alloc_bss_req(phy->dev, mvif,
+					 MT7925_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7925_mcu_bss_eht_tlv(skb, phy, link_conf, ctx);
+
+	return mt76_mcu_skb_send_msg(phy->dev, skb,
+				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
 int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif_link *mvif,
 			 struct ieee80211_bss_conf *link_conf,
 			 struct ieee80211_chanctx_conf *ctx)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 8ac43feb26d6..d55ea59bda7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -372,6 +372,19 @@ struct bss_mld_tlv {
 	u8 __rsv[3];
 } __packed;
 
+struct bss_eht_tlv {
+	__le16 tag;
+	__le16 len;
+	u8  is_eht_op_present;
+	u8  is_eth_dscb_present;
+	u8  eht_ctrl;
+	u8  eht_ccfs0;
+	u8  eht_ccfs1;
+	u8  pad1;
+	__le16 eht_dis_sub_chan_bitmap;
+	u8  pad2[4];
+} __packed;
+
 struct sta_rec_ba_uni {
 	__le16 tag;
 	__le16 len;
@@ -642,6 +655,9 @@ int mt7925_mcu_set_radio_en(struct mt792x_phy *phy, bool enable);
 int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif_link *mvif,
 			 struct ieee80211_bss_conf *link_conf,
 			 struct ieee80211_chanctx_conf *ctx);
+int mt7925_mcu_set_eht_pp(struct mt76_phy *phy, struct mt76_vif_link *mvif,
+			  struct ieee80211_bss_conf *link_conf,
+			  struct ieee80211_chanctx_conf *ctx);
 int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy);
 int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
 				 struct ieee80211_bss_conf *link_conf);
-- 
2.45.2


