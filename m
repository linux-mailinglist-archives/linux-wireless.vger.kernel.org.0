Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB40947A199
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 18:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbhLSRlM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 12:41:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44526 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhLSRlL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 12:41:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F84760ED0
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 17:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79509C36AE8;
        Sun, 19 Dec 2021 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639935670;
        bh=3GMtdku24b04T95LZMqas9nbV0JhW+26AtoXAOvZQZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hXj4kKODkRLMtahvEplWGTuNRiV+4923hLwCyzUsjGI60By7ODmaF3yj7OVbp4ITh
         D5hj2I84iMO5kYxvK8AutyXh5kmlCpvsypcDLs3YazQ7LYL1sFhXteT/ePOD9hJLl6
         vnoACkYZ0XScMPNPHOMbsSWM72/Xhaes5iTYQjHXqABjzjImjw4O9A4Jpp6UHn5TI5
         bILRU/0atcq5kkZg460twTMPtD6YI989NFo6XAC4i0i6Hxk+aH34FRjELzfCxXlWC0
         QgNv+MXC9dRMvq00XHnqHN2vi+mrIomdWwB0iNLPUtFtInz/8b1/qpt5BAiAUKGf8U
         HsH0s97lFMrow==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH v2 9/9] mt76: connac: move mt76_connac_mcu_add_key in connac module
Date:   Sun, 19 Dec 2021 18:40:14 +0100
Message-Id: <189172e1cd10ff7818e61773f551543c4b06263a.1639935477.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639935477.git.lorenzo@kernel.org>
References: <cover.1639935477.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move key configuration code shared between mt7921 and mt7915 in
mt76-connac module and remove duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  5 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 88 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  5 ++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 89 -------------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 12 +--
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  9 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 89 -------------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 10 +--
 9 files changed, 111 insertions(+), 201 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 09165aed8845..e999d7182c8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -83,6 +83,11 @@ struct mt76_connac_coredump {
 	unsigned long last_activity;
 };
 
+struct mt76_connac_sta_key_conf {
+	s8 keyidx;
+	u8 key[16];
+};
+
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
 static inline bool is_mt7922(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 356fc14b888b..ac62a872b818 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2482,5 +2482,93 @@ void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val)
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_wr);
 
+static int
+mt76_connac_mcu_sta_key_tlv(struct mt76_connac_sta_key_conf *sta_key_conf,
+			    struct sk_buff *skb,
+			    struct ieee80211_key_conf *key,
+			    enum set_key_cmd cmd)
+{
+	struct sta_rec_sec *sec;
+	u32 len = sizeof(*sec);
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
+	sec = (struct sta_rec_sec *)tlv;
+	sec->add = cmd;
+
+	if (cmd == SET_KEY) {
+		struct sec_key *sec_key;
+		u8 cipher;
+
+		cipher = mt76_connac_mcu_get_cipher(key->cipher);
+		if (cipher == MCU_CIPHER_NONE)
+			return -EOPNOTSUPP;
+
+		sec_key = &sec->key[0];
+		sec_key->cipher_len = sizeof(*sec_key);
+
+		if (cipher == MCU_CIPHER_BIP_CMAC_128) {
+			sec_key->cipher_id = MCU_CIPHER_AES_CCMP;
+			sec_key->key_id = sta_key_conf->keyidx;
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, sta_key_conf->key, 16);
+
+			sec_key = &sec->key[1];
+			sec_key->cipher_id = MCU_CIPHER_BIP_CMAC_128;
+			sec_key->cipher_len = sizeof(*sec_key);
+			sec_key->key_len = 16;
+			memcpy(sec_key->key, key->key, 16);
+			sec->n_cipher = 2;
+		} else {
+			sec_key->cipher_id = cipher;
+			sec_key->key_id = key->keyidx;
+			sec_key->key_len = key->keylen;
+			memcpy(sec_key->key, key->key, key->keylen);
+
+			if (cipher == MCU_CIPHER_TKIP) {
+				/* Rx/Tx MIC keys are swapped */
+				memcpy(sec_key->key + 16, key->key + 24, 8);
+				memcpy(sec_key->key + 24, key->key + 16, 8);
+			}
+
+			/* store key_conf for BIP batch update */
+			if (cipher == MCU_CIPHER_AES_CCMP) {
+				memcpy(sta_key_conf->key, key->key, key->keylen);
+				sta_key_conf->keyidx = key->keyidx;
+			}
+
+			len -= sizeof(*sec_key);
+			sec->n_cipher = 1;
+		}
+	} else {
+		len -= sizeof(sec->key);
+		sec->n_cipher = 0;
+	}
+	sec->len = cpu_to_le16(len);
+
+	return 0;
+}
+
+int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
+			    struct mt76_connac_sta_key_conf *sta_key_conf,
+			    struct ieee80211_key_conf *key, int mcu_cmd,
+			    struct mt76_wcid *wcid, enum set_key_cmd cmd)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	ret = mt76_connac_mcu_sta_key_tlv(sta_key_conf, skb, key, cmd);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_key);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index d2981402630c..edad58383ed4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1587,4 +1587,9 @@ const struct ieee80211_sta_he_cap *
 mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif);
 u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			    enum nl80211_band band, struct ieee80211_sta *sta);
+
+int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
+			    struct mt76_connac_sta_key_conf *sta_key_conf,
+			    struct ieee80211_key_conf *key, int mcu_cmd,
+			    struct mt76_wcid *wcid, enum set_key_cmd cmd);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 8ac6f59af174..5fa4a0e8f0ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -415,8 +415,9 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	mt76_wcid_key_setup(&dev->mt76, wcid,
 			    cmd == SET_KEY ? key : NULL);
 
-	err = mt7915_mcu_add_key(dev, vif, msta, key, cmd);
-
+	err = mt76_connac_mcu_add_key(&dev->mt76, vif, &msta->bip,
+				      key, MCU_EXT_CMD(STA_REC_UPDATE),
+				      &msta->wcid, cmd);
 out:
 	mutex_unlock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6a414015c9c0..1c5b03bb09bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -863,95 +863,6 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 }
 
 /** starec & wtbl **/
-static int
-mt7915_mcu_sta_key_tlv(struct mt7915_sta *msta, struct sk_buff *skb,
-		       struct ieee80211_key_conf *key, enum set_key_cmd cmd)
-{
-	struct mt7915_sta_key_conf *bip = &msta->bip;
-	struct sta_rec_sec *sec;
-	struct tlv *tlv;
-	u32 len = sizeof(*sec);
-
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
-
-	sec = (struct sta_rec_sec *)tlv;
-	sec->add = cmd;
-
-	if (cmd == SET_KEY) {
-		struct sec_key *sec_key;
-		u8 cipher;
-
-		cipher = mt76_connac_mcu_get_cipher(key->cipher);
-		if (cipher == MCU_CIPHER_NONE)
-			return -EOPNOTSUPP;
-
-		sec_key = &sec->key[0];
-		sec_key->cipher_len = sizeof(*sec_key);
-
-		if (cipher == MCU_CIPHER_BIP_CMAC_128) {
-			sec_key->cipher_id = MCU_CIPHER_AES_CCMP;
-			sec_key->key_id = bip->keyidx;
-			sec_key->key_len = 16;
-			memcpy(sec_key->key, bip->key, 16);
-
-			sec_key = &sec->key[1];
-			sec_key->cipher_id = MCU_CIPHER_BIP_CMAC_128;
-			sec_key->cipher_len = sizeof(*sec_key);
-			sec_key->key_len = 16;
-			memcpy(sec_key->key, key->key, 16);
-
-			sec->n_cipher = 2;
-		} else {
-			sec_key->cipher_id = cipher;
-			sec_key->key_id = key->keyidx;
-			sec_key->key_len = key->keylen;
-			memcpy(sec_key->key, key->key, key->keylen);
-
-			if (cipher == MCU_CIPHER_TKIP) {
-				/* Rx/Tx MIC keys are swapped */
-				memcpy(sec_key->key + 16, key->key + 24, 8);
-				memcpy(sec_key->key + 24, key->key + 16, 8);
-			}
-
-			/* store key_conf for BIP batch update */
-			if (cipher == MCU_CIPHER_AES_CCMP) {
-				memcpy(bip->key, key->key, key->keylen);
-				bip->keyidx = key->keyidx;
-			}
-
-			len -= sizeof(*sec_key);
-			sec->n_cipher = 1;
-		}
-	} else {
-		len -= sizeof(sec->key);
-		sec->n_cipher = 0;
-	}
-	sec->len = cpu_to_le16(len);
-
-	return 0;
-}
-
-int mt7915_mcu_add_key(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		       struct mt7915_sta *msta, struct ieee80211_key_conf *key,
-		       enum set_key_cmd cmd)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct sk_buff *skb;
-	int ret;
-
-	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
-					    &msta->wcid);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	ret = mt7915_mcu_sta_key_tlv(msta, skb, key, cmd);
-	if (ret)
-		return ret;
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(STA_REC_UPDATE), true);
-}
-
 static void
 mt7915_mcu_sta_ba_tlv(struct sk_buff *skb,
 		      struct ieee80211_ampdu_params *params,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 79a1c1ddf157..f6ccf9eba4f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -6,7 +6,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/ktime.h>
-#include "../mt76.h"
+#include "../mt76_connac.h"
 #include "regs.h"
 
 #define MT7915_MAX_INTERFACES		19
@@ -68,11 +68,6 @@ enum mt7915_rxq_id {
 	MT7915_RXQ_MCU_WA_EXT,
 };
 
-struct mt7915_sta_key_conf {
-	s8 keyidx;
-	u8 key[16];
-};
-
 struct mt7915_twt_flow {
 	struct list_head list;
 	u64 start_tsf;
@@ -104,7 +99,7 @@ struct mt7915_sta {
 
 	struct mt76_sta_stats stats;
 
-	struct mt7915_sta_key_conf bip;
+	struct mt76_connac_sta_key_conf bip;
 
 	struct {
 		u8 flowid_mask;
@@ -387,9 +382,6 @@ int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
 int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool add);
-int mt7915_mcu_add_key(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		       struct mt7915_sta *msta, struct ieee80211_key_conf *key,
-		       enum set_key_cmd cmd);
 int mt7915_mcu_update_bss_color(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				struct cfg80211_he_bss_color *he_bss_color);
 int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3effe22f69c0..6073bedaa1c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -451,13 +451,18 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	mt76_wcid_key_setup(&dev->mt76, wcid,
 			    cmd == SET_KEY ? key : NULL);
 
-	err = mt7921_mcu_add_key(dev, vif, msta, key, cmd);
+	err = mt76_connac_mcu_add_key(&dev->mt76, vif, &msta->bip,
+				      key, MCU_UNI_CMD(STA_REC_UPDATE),
+				      &msta->wcid, cmd);
 	if (err)
 		goto out;
 
 	if (key->cipher == WLAN_CIPHER_SUITE_WEP104 ||
 	    key->cipher == WLAN_CIPHER_SUITE_WEP40)
-		err = mt7921_mcu_add_key(dev, vif, mvif->wep_sta, key, cmd);
+		err = mt76_connac_mcu_add_key(&dev->mt76, vif,
+					      &mvif->wep_sta->bip,
+					      key, MCU_UNI_CMD(STA_REC_UPDATE),
+					      &mvif->wep_sta->wcid, cmd);
 out:
 	mt7921_mutex_release(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index e14677f669c5..d014e574ce6a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -419,95 +419,6 @@ void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
 }
 
 /** starec & wtbl **/
-static int
-mt7921_mcu_sta_key_tlv(struct mt7921_sta *msta, struct sk_buff *skb,
-		       struct ieee80211_key_conf *key, enum set_key_cmd cmd)
-{
-	struct mt7921_sta_key_conf *bip = &msta->bip;
-	struct sta_rec_sec *sec;
-	struct tlv *tlv;
-	u32 len = sizeof(*sec);
-
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
-
-	sec = (struct sta_rec_sec *)tlv;
-	sec->add = cmd;
-
-	if (cmd == SET_KEY) {
-		struct sec_key *sec_key;
-		u8 cipher;
-
-		cipher = mt76_connac_mcu_get_cipher(key->cipher);
-		if (cipher == MCU_CIPHER_NONE)
-			return -EOPNOTSUPP;
-
-		sec_key = &sec->key[0];
-		sec_key->cipher_len = sizeof(*sec_key);
-
-		if (cipher == MCU_CIPHER_BIP_CMAC_128) {
-			sec_key->cipher_id = MCU_CIPHER_AES_CCMP;
-			sec_key->key_id = bip->keyidx;
-			sec_key->key_len = 16;
-			memcpy(sec_key->key, bip->key, 16);
-
-			sec_key = &sec->key[1];
-			sec_key->cipher_id = MCU_CIPHER_BIP_CMAC_128;
-			sec_key->cipher_len = sizeof(*sec_key);
-			sec_key->key_len = 16;
-			memcpy(sec_key->key, key->key, 16);
-
-			sec->n_cipher = 2;
-		} else {
-			sec_key->cipher_id = cipher;
-			sec_key->key_id = key->keyidx;
-			sec_key->key_len = key->keylen;
-			memcpy(sec_key->key, key->key, key->keylen);
-
-			if (cipher == MCU_CIPHER_TKIP) {
-				/* Rx/Tx MIC keys are swapped */
-				memcpy(sec_key->key + 16, key->key + 24, 8);
-				memcpy(sec_key->key + 24, key->key + 16, 8);
-			}
-
-			/* store key_conf for BIP batch update */
-			if (cipher == MCU_CIPHER_AES_CCMP) {
-				memcpy(bip->key, key->key, key->keylen);
-				bip->keyidx = key->keyidx;
-			}
-
-			len -= sizeof(*sec_key);
-			sec->n_cipher = 1;
-		}
-	} else {
-		len -= sizeof(sec->key);
-		sec->n_cipher = 0;
-	}
-	sec->len = cpu_to_le16(len);
-
-	return 0;
-}
-
-int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
-		       enum set_key_cmd cmd)
-{
-	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	struct sk_buff *skb;
-	int ret;
-
-	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
-					    &msta->wcid);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	ret = mt7921_mcu_sta_key_tlv(msta, skb, key, cmd);
-	if (ret)
-		return ret;
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_UNI_CMD(STA_REC_UPDATE), true);
-}
-
 int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 96647801850a..c0fcc5eda5ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -89,11 +89,6 @@ enum mt7921_rxq_id {
 	MT7921_RXQ_MCU_WM = 0,
 };
 
-struct mt7921_sta_key_conf {
-	s8 keyidx;
-	u8 key[16];
-};
-
 struct mt7921_sta {
 	struct mt76_wcid wcid; /* must be first */
 
@@ -106,7 +101,7 @@ struct mt7921_sta {
 	unsigned long ampdu_state;
 	struct mt76_sta_stats stats;
 
-	struct mt7921_sta_key_conf bip;
+	struct mt76_connac_sta_key_conf bip;
 };
 
 DECLARE_EWMA(rssi, 10, 8);
@@ -296,9 +291,6 @@ int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force);
 int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev);
 void mt7921_dma_cleanup(struct mt7921_dev *dev);
 int mt7921_run_firmware(struct mt7921_dev *dev);
-int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
-		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
-		       enum set_key_cmd cmd);
 int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 			  struct ieee80211_vif *vif, bool enable,
 			  enum mt76_sta_info_state state);
-- 
2.33.1

