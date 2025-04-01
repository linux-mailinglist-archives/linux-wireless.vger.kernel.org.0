Return-Path: <linux-wireless+bounces-21023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D572DA77692
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 10:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7673A4FE1
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 08:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B0F1E47DD;
	Tue,  1 Apr 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VvRBqnaS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457381A83E4
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496538; cv=none; b=JUfNOn0QWd9lXSSfTPiux3rXPvf61jia4E7uQ5Fby+0MObTe/uLyBEP/F/F/dhJiGwPz2KQ5yg9DyWi/K1LpdnkNHy+ubtlJnULFSLEHw7EdkBjlzZVuaNcHZvZkpJUPGz7GmjGc/65sHHWq6+IhOMbB5SNd4DLZrpgnniGP8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496538; c=relaxed/simple;
	bh=IvDDBv3pcTaWH5JmwoTPGEsKi0rJqHx0QW3Qicpi/yE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F+G8TgzzhYqpor+6Ys6mu4ME2+bwYdS7+GJQUT4+Bkvl8Lfl1G5G/1yyjFANrzsZOAZX0PCBODRmIyHH9A/d1EhsjhDu1UuhSjpXRaWEqEeQWwI36lbzTOEfqkf1EXoKYe2YWzdfuJ8jirEoIDs9GXUJ6UOSLjlr1nncmHxbIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VvRBqnaS; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 441c8a2c0ed411f0aae1fd9735fae912-20250401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TcarTI4q4IM41MZDd1UR+Ub2gKdC3FXHi7aVCTSwG1k=;
	b=VvRBqnaSylN42w+p7BNPFVyT7FaWVovmzoAXcEGWBabPAsfvceoi9HjxdYQZW0TBU2/G9+rnx8URjmZfOEoh+jM7qCHyF3mmTvfqChul/Z+Vj5lSiepkpGKwJLjyuBwuuXvf9gPknDGDepiOZjE81MARuNxKjx9tjkMd5UHV/bU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:4ff98b50-45de-414e-866f-53f5cbf8eae9,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:115f0dc7-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 441c8a2c0ed411f0aae1fd9735fae912-20250401
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <allan.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 763517916; Tue, 01 Apr 2025 16:35:28 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 1 Apr 2025 16:35:27 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 1 Apr 2025 16:35:27 +0800
From: Allan Wang <allan.wang@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <mingyen.hsieh@mediatek.com>,
	<Sean.Wang@mediatek.com>, <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Allan Wang <allan.wang@mediatek.com>
Subject: [v2] wifi: mt76: mt7925: add EHT preamble puncturing
Date: Tue, 1 Apr 2025 16:35:25 +0800
Message-ID: <20250401083525.2734333-1-allan.wang@mediatek.com>
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
v2: fix __le16 assignment
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
index e61da76b2097..286f602623c0 100644
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
+	req->eht_dis_sub_chan_bitmap = cpu_to_le16(chandef->punctured);
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


