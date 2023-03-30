Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D15C6CFF87
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 11:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjC3JNd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjC3JND (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 05:13:03 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24B65AE
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ae1DAVQRohJC46gNOvad3F6ep2CxUs3oWyLACnA26Ek=; b=Ugav7OPq1LFLuQbCeYdEjejX1c
        b3Kqw+Cnc24Lz6z/ATfKrhHT8Je+xz8+HKHyEiy2WvzSD5hRgwKUGZtVdBPawP5Enkql42xadWqcI
        jqUbGnLFHWGuopYkPBTcVBcquJ7dts/gHdujZQvaXgVcqI3vapk2n06H1zJlpRL3mo3Q=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1phoL6-008UDR-5T; Thu, 30 Mar 2023 11:13:00 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org
Subject: [PATCH wireless] wifi: mt76: ignore key disable commands
Date:   Thu, 30 Mar 2023 11:12:59 +0200
Message-Id: <20230330091259.61378-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This helps avoid cleartext leakage of already queued or powersave buffered
packets, when a reassoc triggers the key deletion.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7603/main.c  | 10 +--
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 70 ++++++-------------
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 15 ++--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  6 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 18 ++---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 13 ++--
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 13 ++--
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 13 ++--
 8 files changed, 62 insertions(+), 96 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index ca50feb0b3a9..1b1358c6bb46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -512,15 +512,15 @@ mt7603_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		return -EOPNOTSUPP;
 
-	if (cmd == SET_KEY) {
-		key->hw_key_idx = wcid->idx;
-		wcid->hw_key_idx = idx;
-	} else {
+	if (cmd != SET_KEY) {
 		if (idx == wcid->hw_key_idx)
 			wcid->hw_key_idx = -1;
 
-		key = NULL;
+		return 0;
 	}
+
+	key->hw_key_idx = wcid->idx;
+	wcid->hw_key_idx = idx;
 	mt76_wcid_key_setup(&dev->mt76, wcid, key);
 
 	return mt7603_wtbl_set_key(dev, wcid->idx, key);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index a95602473359..51a968a6afdc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1193,8 +1193,7 @@ EXPORT_SYMBOL_GPL(mt7615_mac_enable_rtscts);
 static int
 mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key,
-			   enum mt76_cipher_type cipher, u16 cipher_mask,
-			   enum set_key_cmd cmd)
+			   enum mt76_cipher_type cipher, u16 cipher_mask)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx) + 30 * 4;
 	u8 data[32] = {};
@@ -1203,27 +1202,18 @@ mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 		return -EINVAL;
 
 	mt76_rr_copy(dev, addr, data, sizeof(data));
-	if (cmd == SET_KEY) {
-		if (cipher == MT_CIPHER_TKIP) {
-			/* Rx/Tx MIC keys are swapped */
-			memcpy(data, key->key, 16);
-			memcpy(data + 16, key->key + 24, 8);
-			memcpy(data + 24, key->key + 16, 8);
-		} else {
-			if (cipher_mask == BIT(cipher))
-				memcpy(data, key->key, key->keylen);
-			else if (cipher != MT_CIPHER_BIP_CMAC_128)
-				memcpy(data, key->key, 16);
-			if (cipher == MT_CIPHER_BIP_CMAC_128)
-				memcpy(data + 16, key->key, 16);
-		}
+	if (cipher == MT_CIPHER_TKIP) {
+		/* Rx/Tx MIC keys are swapped */
+		memcpy(data, key->key, 16);
+		memcpy(data + 16, key->key + 24, 8);
+		memcpy(data + 24, key->key + 16, 8);
 	} else {
+		if (cipher_mask == BIT(cipher))
+			memcpy(data, key->key, key->keylen);
+		else if (cipher != MT_CIPHER_BIP_CMAC_128)
+			memcpy(data, key->key, 16);
 		if (cipher == MT_CIPHER_BIP_CMAC_128)
-			memset(data + 16, 0, 16);
-		else if (cipher_mask)
-			memset(data, 0, 16);
-		if (!cipher_mask)
-			memset(data, 0, sizeof(data));
+			memcpy(data + 16, key->key, 16);
 	}
 
 	mt76_wr_copy(dev, addr, data, sizeof(data));
@@ -1234,7 +1224,7 @@ mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 static int
 mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			  enum mt76_cipher_type cipher, u16 cipher_mask,
-			  int keyidx, enum set_key_cmd cmd)
+			  int keyidx)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx), w0, w1;
 
@@ -1253,9 +1243,7 @@ mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 	else
 		w0 &= ~MT_WTBL_W0_RX_IK_VALID;
 
-	if (cmd == SET_KEY &&
-	    (cipher != MT_CIPHER_BIP_CMAC_128 ||
-	     cipher_mask == BIT(cipher))) {
+	if (cipher != MT_CIPHER_BIP_CMAC_128 || cipher_mask == BIT(cipher)) {
 		w0 &= ~MT_WTBL_W0_KEY_IDX;
 		w0 |= FIELD_PREP(MT_WTBL_W0_KEY_IDX, keyidx);
 	}
@@ -1272,19 +1260,10 @@ mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 
 static void
 mt7615_mac_wtbl_update_cipher(struct mt7615_dev *dev, struct mt76_wcid *wcid,
-			      enum mt76_cipher_type cipher, u16 cipher_mask,
-			      enum set_key_cmd cmd)
+			      enum mt76_cipher_type cipher, u16 cipher_mask)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx);
 
-	if (!cipher_mask) {
-		mt76_clear(dev, addr + 2 * 4, MT_WTBL_W2_KEY_TYPE);
-		return;
-	}
-
-	if (cmd != SET_KEY)
-		return;
-
 	if (cipher == MT_CIPHER_BIP_CMAC_128 &&
 	    cipher_mask & ~BIT(MT_CIPHER_BIP_CMAC_128))
 		return;
@@ -1295,8 +1274,7 @@ mt7615_mac_wtbl_update_cipher(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 
 int __mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
 			      struct mt76_wcid *wcid,
-			      struct ieee80211_key_conf *key,
-			      enum set_key_cmd cmd)
+			      struct ieee80211_key_conf *key)
 {
 	enum mt76_cipher_type cipher;
 	u16 cipher_mask = wcid->cipher;
@@ -1306,19 +1284,14 @@ int __mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
 	if (cipher == MT_CIPHER_NONE)
 		return -EOPNOTSUPP;
 
-	if (cmd == SET_KEY)
-		cipher_mask |= BIT(cipher);
-	else
-		cipher_mask &= ~BIT(cipher);
-
-	mt7615_mac_wtbl_update_cipher(dev, wcid, cipher, cipher_mask, cmd);
-	err = mt7615_mac_wtbl_update_key(dev, wcid, key, cipher, cipher_mask,
-					 cmd);
+	cipher_mask |= BIT(cipher);
+	mt7615_mac_wtbl_update_cipher(dev, wcid, cipher, cipher_mask);
+	err = mt7615_mac_wtbl_update_key(dev, wcid, key, cipher, cipher_mask);
 	if (err < 0)
 		return err;
 
 	err = mt7615_mac_wtbl_update_pk(dev, wcid, cipher, cipher_mask,
-					key->keyidx, cmd);
+					key->keyidx);
 	if (err < 0)
 		return err;
 
@@ -1329,13 +1302,12 @@ int __mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
 
 int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
 			    struct mt76_wcid *wcid,
-			    struct ieee80211_key_conf *key,
-			    enum set_key_cmd cmd)
+			    struct ieee80211_key_conf *key)
 {
 	int err;
 
 	spin_lock_bh(&dev->mt76.lock);
-	err = __mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
+	err = __mt7615_mac_wtbl_set_key(dev, wcid, key);
 	spin_unlock_bh(&dev->mt76.lock);
 
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index ab4c1b4478aa..dadb13f2ca09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -391,18 +391,17 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	if (cmd == SET_KEY)
 		*wcid_keyidx = idx;
-	else if (idx == *wcid_keyidx)
-		*wcid_keyidx = -1;
-	else
+	else {
+		if (idx == *wcid_keyidx)
+			*wcid_keyidx = -1;
 		goto out;
+	}
 
-	mt76_wcid_key_setup(&dev->mt76, wcid,
-			    cmd == SET_KEY ? key : NULL);
-
+	mt76_wcid_key_setup(&dev->mt76, wcid, key);
 	if (mt76_is_mmio(&dev->mt76))
-		err = mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
+		err = mt7615_mac_wtbl_set_key(dev, wcid, key);
 	else
-		err = __mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
+		err = __mt7615_mac_wtbl_set_key(dev, wcid, key);
 
 out:
 	mt7615_mutex_release(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 43591b4c1d9a..9e58f6924493 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -490,11 +490,9 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 void mt7615_mac_set_timing(struct mt7615_phy *phy);
 int __mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
 			      struct mt76_wcid *wcid,
-			      struct ieee80211_key_conf *key,
-			      enum set_key_cmd cmd);
+			      struct ieee80211_key_conf *key);
 int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
-			    struct ieee80211_key_conf *key,
-			    enum set_key_cmd cmd);
+			    struct ieee80211_key_conf *key);
 void mt7615_mac_reset_work(struct work_struct *work);
 u32 mt7615_mac_get_sta_tid_sn(struct mt7615_dev *dev, int wcid, u8 tid);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 7451a63206a5..dcbb5c605dfe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -454,20 +454,20 @@ int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	msta = sta ? (struct mt76x02_sta *)sta->drv_priv : NULL;
 	wcid = msta ? &msta->wcid : &mvif->group_wcid;
 
-	if (cmd == SET_KEY) {
-		key->hw_key_idx = wcid->idx;
-		wcid->hw_key_idx = idx;
-		if (key->flags & IEEE80211_KEY_FLAG_RX_MGMT) {
-			key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
-			wcid->sw_iv = true;
-		}
-	} else {
+	if (cmd != SET_KEY) {
 		if (idx == wcid->hw_key_idx) {
 			wcid->hw_key_idx = -1;
 			wcid->sw_iv = false;
 		}
 
-		key = NULL;
+		return 0;
+	}
+
+	key->hw_key_idx = wcid->idx;
+	wcid->hw_key_idx = idx;
+	if (key->flags & IEEE80211_KEY_FLAG_RX_MGMT) {
+		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
+		wcid->sw_iv = true;
 	}
 	mt76_wcid_key_setup(&dev->mt76, wcid, key);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3bbccbdfc5eb..784191ec4802 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -410,16 +410,15 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		mt7915_mcu_add_bss_info(phy, vif, true);
 	}
 
-	if (cmd == SET_KEY)
+	if (cmd == SET_KEY) {
 		*wcid_keyidx = idx;
-	else if (idx == *wcid_keyidx)
-		*wcid_keyidx = -1;
-	else
+	} else {
+		if (idx == *wcid_keyidx)
+			*wcid_keyidx = -1;
 		goto out;
+	}
 
-	mt76_wcid_key_setup(&dev->mt76, wcid,
-			    cmd == SET_KEY ? key : NULL);
-
+	mt76_wcid_key_setup(&dev->mt76, wcid, key);
 	err = mt76_connac_mcu_add_key(&dev->mt76, vif, &msta->bip,
 				      key, MCU_EXT_CMD(STA_REC_UPDATE),
 				      &msta->wcid, cmd);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 75eaf86c6a78..42933a6b7334 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -569,16 +569,15 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mt7921_mutex_acquire(dev);
 
-	if (cmd == SET_KEY)
+	if (cmd == SET_KEY) {
 		*wcid_keyidx = idx;
-	else if (idx == *wcid_keyidx)
-		*wcid_keyidx = -1;
-	else
+	} else {
+		if (idx == *wcid_keyidx)
+			*wcid_keyidx = -1;
 		goto out;
+	}
 
-	mt76_wcid_key_setup(&dev->mt76, wcid,
-			    cmd == SET_KEY ? key : NULL);
-
+	mt76_wcid_key_setup(&dev->mt76, wcid, key);
 	err = mt76_connac_mcu_add_key(&dev->mt76, vif, &msta->bip,
 				      key, MCU_UNI_CMD(STA_REC_UPDATE),
 				      &msta->wcid, cmd);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 3e4da0350d96..1ba22d147949 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -351,16 +351,15 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		mt7996_mcu_add_bss_info(phy, vif, true);
 	}
 
-	if (cmd == SET_KEY)
+	if (cmd == SET_KEY) {
 		*wcid_keyidx = idx;
-	else if (idx == *wcid_keyidx)
-		*wcid_keyidx = -1;
-	else
+	} else {
+		if (idx == *wcid_keyidx)
+			*wcid_keyidx = -1;
 		goto out;
+	}
 
-	mt76_wcid_key_setup(&dev->mt76, wcid,
-			    cmd == SET_KEY ? key : NULL);
-
+	mt76_wcid_key_setup(&dev->mt76, wcid, key);
 	err = mt7996_mcu_add_key(&dev->mt76, vif, &msta->bip,
 				 key, MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
 				 &msta->wcid, cmd);
-- 
2.39.0

