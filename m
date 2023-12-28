Return-Path: <linux-wireless+bounces-1303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE27A81F63A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 10:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10135B2266E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 09:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72E579C3;
	Thu, 28 Dec 2023 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pfbSjwLh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6606FB6
	for <linux-wireless@vger.kernel.org>; Thu, 28 Dec 2023 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9547f730a56011eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=v9IUnzR4+uh6bT4Ug4gRTMnPbzcyRaI/G9G16gpsVTU=;
	b=pfbSjwLhig0EParneczqaYoeUcM37BmfA1UXWlToGnnyARYW0IdO0DOdtXdqCQrMQZnLo7bOiHmbA1+MnOpFxX2dXTVtX1xoNFT+9ipIPgqaWtYnu7fsqHUIXbNwDEJLQNvZW0+Cz6vWxFm70FcRu491xUeHjxdnfUtG4UEQwvE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:6ecc004c-22b4-4c54-82ff-23506e41bac6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:a37ca98d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9547f730a56011eea2298b7352fd921d-20231228
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1339548835; Thu, 28 Dec 2023 17:07:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
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
Subject: [PATCH 06/10] wifi: mt76: mt7925: fix WoW failed in encrypted mode
Date: Thu, 28 Dec 2023 17:07:45 +0800
Message-ID: <20231228090749.15191-7-mingyen.hsieh@mediatek.com>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

When in suspend mode, WoW (Wake-on-WLAN) fails to wake the system remotely
due to incorrect encryption mode settings. For the new mt7925 chipset, the
old STA_REC_KEY_V2 command will send incorrect parameters to the firmware.
Therefore, STA_REC_KEY_V3 has been introduced as a replacement for it.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 86 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 70 +++++++++++----
 4 files changed, 103 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index db96ddbeb9e7..657a4d1f856b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -808,6 +808,7 @@ enum {
 	STA_REC_MLD = 0x20,
 	STA_REC_EHT = 0x22,
 	STA_REC_PN_INFO = 0x26,
+	STA_REC_KEY_V3 = 0x27,
 	STA_REC_HDRT = 0x28,
 	STA_REC_HDR_TRANS = 0x2B,
 	STA_REC_MAX_NUM
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index b832dd8adee5..96c3302fdc53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -359,6 +359,7 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mvif->sta.vif = mvif;
 	mt76_wcid_init(&mvif->sta.wcid);
 
 	mt7925_mac_wtbl_update(dev, idx,
@@ -526,7 +527,7 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	if (cmd == SET_KEY && !mvif->mt76.cipher) {
 		struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
-		mvif->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
+		mvif->mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
 		mt7925_mcu_add_bss_info(phy, mvif->mt76.ctx, vif, sta, true);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0299045b4b83..8c3233182083 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -921,61 +921,67 @@ mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 		       struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd)
 {
+	struct mt792x_sta *msta = container_of(wcid, struct mt792x_sta, wcid);
 	struct sta_rec_sec_uni *sec;
+	struct mt792x_vif *mvif = msta->vif;
+	struct ieee80211_sta *sta;
+	struct ieee80211_vif *vif;
 	struct tlv *tlv;
 
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
+	sta = msta == &mvif->sta ?
+		      NULL :
+		      container_of((void *)msta, struct ieee80211_sta, drv_priv);
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V3, sizeof(*sec));
 	sec = (struct sta_rec_sec_uni *)tlv;
-	sec->add = cmd;
+	sec->bss_idx = mvif->mt76.idx;
+	sec->is_authenticator = 0;
+	sec->mgmt_prot = 0;
+	sec->wlan_idx = (u8)wcid->idx;
+
+	if (sta) {
+		sec->tx_key = 1;
+		sec->key_type = 1;
+		memcpy(sec->peer_addr, sta->addr, ETH_ALEN);
+	} else {
+		memcpy(sec->peer_addr, vif->bss_conf.bssid, ETH_ALEN);
+	}
 
 	if (cmd == SET_KEY) {
-		struct sec_key_uni *sec_key;
 		u8 cipher;
 
-		cipher = mt76_connac_mcu_get_cipher(key->cipher);
-		if (cipher == MCU_CIPHER_NONE)
+		sec->add = 1;
+		cipher = mt7925_mcu_get_cipher(key->cipher);
+		if (cipher == CONNAC3_CIPHER_NONE)
 			return -EOPNOTSUPP;
 
-		sec_key = &sec->key[0];
-		sec_key->cipher_len = sizeof(*sec_key);
-
-		if (cipher == MCU_CIPHER_BIP_CMAC_128) {
-			sec_key->wlan_idx = cpu_to_le16(wcid->idx);
-			sec_key->cipher_id = MCU_CIPHER_AES_CCMP;
-			sec_key->key_id = sta_key_conf->keyidx;
-			sec_key->key_len = 16;
-			memcpy(sec_key->key, sta_key_conf->key, 16);
-
-			sec_key = &sec->key[1];
-			sec_key->wlan_idx = cpu_to_le16(wcid->idx);
-			sec_key->cipher_id = MCU_CIPHER_BIP_CMAC_128;
-			sec_key->cipher_len = sizeof(*sec_key);
-			sec_key->key_len = 16;
-			memcpy(sec_key->key, key->key, 16);
-			sec->n_cipher = 2;
+		if (cipher == CONNAC3_CIPHER_BIP_CMAC_128) {
+			sec->cipher_id = CONNAC3_CIPHER_BIP_CMAC_128;
+			sec->key_id = sta_key_conf->keyidx;
+			sec->key_len = 32;
+			memcpy(sec->key, sta_key_conf->key, 16);
+			memcpy(sec->key + 16, key->key, 16);
 		} else {
-			sec_key->wlan_idx = cpu_to_le16(wcid->idx);
-			sec_key->cipher_id = cipher;
-			sec_key->key_id = key->keyidx;
-			sec_key->key_len = key->keylen;
-			memcpy(sec_key->key, key->key, key->keylen);
+			sec->cipher_id = cipher;
+			sec->key_id = key->keyidx;
+			sec->key_len = key->keylen;
+			memcpy(sec->key, key->key, key->keylen);
 
-			if (cipher == MCU_CIPHER_TKIP) {
+			if (cipher == CONNAC3_CIPHER_TKIP) {
 				/* Rx/Tx MIC keys are swapped */
-				memcpy(sec_key->key + 16, key->key + 24, 8);
-				memcpy(sec_key->key + 24, key->key + 16, 8);
+				memcpy(sec->key + 16, key->key + 24, 8);
+				memcpy(sec->key + 24, key->key + 16, 8);
 			}
 
 			/* store key_conf for BIP batch update */
-			if (cipher == MCU_CIPHER_AES_CCMP) {
+			if (cipher == CONNAC3_CIPHER_AES_CCMP) {
 				memcpy(sta_key_conf->key, key->key, key->keylen);
 				sta_key_conf->keyidx = key->keyidx;
 			}
-
-			sec->n_cipher = 1;
 		}
 	} else {
-		sec->n_cipher = 0;
+		sec->add = 0;
 	}
 
 	return 0;
@@ -2122,21 +2128,21 @@ mt7925_mcu_bss_sec_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 	sec = (struct bss_sec_tlv *)tlv;
 
 	switch (mvif->cipher) {
-	case MCU_CIPHER_GCMP_256:
-	case MCU_CIPHER_GCMP:
+	case CONNAC3_CIPHER_GCMP_256:
+	case CONNAC3_CIPHER_GCMP:
 		sec->mode = MODE_WPA3_SAE;
 		sec->status = 8;
 		break;
-	case MCU_CIPHER_AES_CCMP:
+	case CONNAC3_CIPHER_AES_CCMP:
 		sec->mode = MODE_WPA2_PSK;
 		sec->status = 6;
 		break;
-	case MCU_CIPHER_TKIP:
+	case CONNAC3_CIPHER_TKIP:
 		sec->mode = MODE_WPA2_PSK;
 		sec->status = 4;
 		break;
-	case MCU_CIPHER_WEP104:
-	case MCU_CIPHER_WEP40:
+	case CONNAC3_CIPHER_WEP104:
+	case CONNAC3_CIPHER_WEP40:
 		sec->mode = MODE_SHARED;
 		sec->status = 0;
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 0218fd2a0eb0..9fce054e5065 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -159,6 +159,20 @@ enum {
 	UNI_EVENT_SCAN_DONE_NLO = 3,
 };
 
+enum connac3_mcu_cipher_type {
+	CONNAC3_CIPHER_NONE = 0,
+	CONNAC3_CIPHER_WEP40 = 1,
+	CONNAC3_CIPHER_TKIP = 2,
+	CONNAC3_CIPHER_AES_CCMP = 4,
+	CONNAC3_CIPHER_WEP104 = 5,
+	CONNAC3_CIPHER_BIP_CMAC_128 = 6,
+	CONNAC3_CIPHER_WEP128 = 7,
+	CONNAC3_CIPHER_WAPI = 8,
+	CONNAC3_CIPHER_CCMP_256 = 10,
+	CONNAC3_CIPHER_GCMP = 11,
+	CONNAC3_CIPHER_GCMP_256 = 12,
+};
+
 struct mt7925_mcu_scan_chinfo_event {
 	u8 nr_chan;
 	u8 alpha2[3];
@@ -383,25 +397,22 @@ struct sta_rec_eht {
 	u8 _rsv2[3];
 } __packed;
 
-struct sec_key_uni {
-	__le16 wlan_idx;
-	u8 mgmt_prot;
-	u8 cipher_id;
-	u8 cipher_len;
-	u8 key_id;
-	u8 key_len;
-	u8 need_resp;
-	u8 key[32];
-} __packed;
-
 struct sta_rec_sec_uni {
 	__le16 tag;
 	__le16 len;
 	u8 add;
-	u8 n_cipher;
-	u8 rsv[2];
-
-	struct sec_key_uni key[2];
+	u8 tx_key;
+	u8 key_type;
+	u8 is_authenticator;
+	u8 peer_addr[6];
+	u8 bss_idx;
+	u8 cipher_id;
+	u8 key_id;
+	u8 key_len;
+	u8 wlan_idx;
+	u8 mgmt_prot;
+	u8 key[32];
+	u8 key_rsc[16];
 } __packed;
 
 struct sta_rec_hdr_trans {
@@ -441,7 +452,7 @@ struct sta_rec_mld {
 					 sizeof(struct sta_rec_bfee) +		\
 					 sizeof(struct sta_rec_phy) +		\
 					 sizeof(struct sta_rec_ra) +		\
-					 sizeof(struct sta_rec_sec) +		\
+					 sizeof(struct sta_rec_sec_uni) +   \
 					 sizeof(struct sta_rec_ra_fixed) +	\
 					 sizeof(struct sta_rec_he_6g_capa) +	\
 					 sizeof(struct sta_rec_eht) +		\
@@ -510,6 +521,33 @@ struct mt7925_wow_pattern_tlv {
 	u8 rsv[4];
 } __packed;
 
+static inline enum connac3_mcu_cipher_type
+mt7925_mcu_get_cipher(int cipher)
+{
+	switch (cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		return CONNAC3_CIPHER_WEP40;
+	case WLAN_CIPHER_SUITE_WEP104:
+		return CONNAC3_CIPHER_WEP104;
+	case WLAN_CIPHER_SUITE_TKIP:
+		return CONNAC3_CIPHER_TKIP;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		return CONNAC3_CIPHER_BIP_CMAC_128;
+	case WLAN_CIPHER_SUITE_CCMP:
+		return CONNAC3_CIPHER_AES_CCMP;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		return CONNAC3_CIPHER_CCMP_256;
+	case WLAN_CIPHER_SUITE_GCMP:
+		return CONNAC3_CIPHER_GCMP;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		return CONNAC3_CIPHER_GCMP_256;
+	case WLAN_CIPHER_SUITE_SMS4:
+		return CONNAC3_CIPHER_WAPI;
+	default:
+		return CONNAC3_CIPHER_NONE;
+	}
+}
+
 int mt7925_mcu_set_dbdc(struct mt76_phy *phy);
 int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req);
-- 
2.18.0


