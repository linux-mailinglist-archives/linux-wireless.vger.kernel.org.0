Return-Path: <linux-wireless+bounces-1312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD9C81FC77
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 03:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A191F24716
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Dec 2023 02:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7220E1;
	Fri, 29 Dec 2023 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ya063YL5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CB6138D
	for <linux-wireless@vger.kernel.org>; Fri, 29 Dec 2023 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 031587cca5ee11ee9e680517dc993faa-20231229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w08/Rxjuid5oE+Yps/4AYcSPOyeNny7bcCjYA9jCEN4=;
	b=Ya063YL5m7f/lRYadhE4vJGbSEYlZp2V0A/J9rFR4Tlj96BFaSnKrf9Y1MkynbpTf56dJAxgb5eCa1uRYwJ0x5rL7VNtgF7kR2FLK+TUDqjR15Or7RLTPyJaa9Tc6Eg1cOsTUSfeATAEEL5i+VHF2O+iAjh6i1/Jo9hydnnPGjk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:7b7535ed-53bc-4b07-8153-c0e11272fe3d,IP:0,U
	RL:-32768,TC:0,Content:-32768,EDM:-32768,RT:0,SF:-32768,FILE:0,BULK:-32768
	,RULE:Release_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ae364882-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:nil,EDM:nil,IP:ni
	l,URL:nil,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 031587cca5ee11ee9e680517dc993faa-20231229
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1123208922; Fri, 29 Dec 2023 10:00:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 29 Dec 2023 10:00:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 29 Dec 2023 10:00:16 +0800
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
Subject: [PATCH v1 09/10] wifi: mt76: mt7925: add support to set ifs time by mcu command
Date: Fri, 29 Dec 2023 10:00:08 +0800
Message-ID: <20231229020009.12385-10-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231229020009.12385-1-mingyen.hsieh@mediatek.com>
References: <20231229020009.12385-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

There's a race between driver and fw on some tx/rx control registers
when setting ifs, which will cause accidental hw queue pause problems.
Avoid this by setting ifs time with bss_info mcu command.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 33 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 19 +++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 46c913511359..1f07ec5a2072 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -711,7 +711,7 @@ static void mt7925_bss_info_changed(struct ieee80211_hw *hw,
 
 		if (slottime != phy->slottime) {
 			phy->slottime = slottime;
-			mt792x_mac_set_timeing(phy);
+			mt7925_mcu_set_timing(phy, vif);
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 932ecf38672c..e1dd89a7a79c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2244,6 +2244,38 @@ mt7925_mcu_bss_color_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		vif->bss_conf.he_bss_color.color : 0;
 }
 
+static void
+mt7925_mcu_bss_ifs_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = mvif->phy;
+	struct bss_ifs_time_tlv *ifs_time;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_IFS_TIME, sizeof(*ifs_time));
+	ifs_time = (struct bss_ifs_time_tlv *)tlv;
+	ifs_time->slot_valid = true;
+	ifs_time->slot_time = cpu_to_le16(phy->slottime);
+}
+
+int mt7925_mcu_set_timing(struct mt792x_phy *phy,
+			  struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = phy->dev;
+	struct sk_buff *skb;
+
+	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+					 MT7925_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt7925_mcu_bss_ifs_tlv(skb, vif);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
 			    struct ieee80211_vif *vif,
@@ -2268,6 +2300,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, vif, sta);
 	mt7925_mcu_bss_qos_tlv(skb, vif);
 	mt7925_mcu_bss_mld_tlv(skb, vif, sta);
+	mt7925_mcu_bss_ifs_tlv(skb, vif);
 
 	if (vif->bss_conf.he_support) {
 		mt7925_mcu_bss_he_tlv(skb, vif, phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 9fce054e5065..2cf39276118e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -440,6 +440,22 @@ struct sta_rec_mld {
 	} __packed link[2];
 } __packed;
 
+struct bss_ifs_time_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 slot_valid;
+	u8 sifs_valid;
+	u8 rifs_valid;
+	u8 eifs_valid;
+	__le16 slot_time;
+	__le16 sifs_time;
+	__le16 rifs_time;
+	__le16 eifs_time;
+	u8 eifs_cck_valid;
+	u8 rsv;
+	__le16 eifs_cck_time;
+} __packed;
+
 #define MT7925_STA_UPDATE_MAX_SIZE	(sizeof(struct sta_req_hdr) +		\
 					 sizeof(struct sta_rec_basic) +		\
 					 sizeof(struct sta_rec_bf) +		\
@@ -467,6 +483,7 @@ struct sta_rec_mld {
 					 sizeof(struct bss_mld_tlv) +			\
 					 sizeof(struct bss_info_uni_he) +		\
 					 sizeof(struct bss_info_uni_bss_color) +	\
+					 sizeof(struct bss_ifs_time_tlv) +		\
 					 sizeof(struct tlv))
 
 #define MT_CONNAC3_SKU_POWER_LIMIT      449
@@ -564,6 +581,8 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta,
 			    int enable);
+int mt7925_mcu_set_timing(struct mt792x_phy *phy,
+			  struct ieee80211_vif *vif);
 int mt7925_mcu_set_deep_sleep(struct mt792x_dev *dev, bool enable);
 int mt7925_mcu_set_channel_domain(struct mt76_phy *phy);
 int mt7925_mcu_set_radio_en(struct mt792x_phy *phy, bool enable);
-- 
2.18.0


