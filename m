Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444EF31AD6E
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Feb 2021 18:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBMRvr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Feb 2021 12:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhBMRvq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Feb 2021 12:51:46 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0CC0613D6
        for <linux-wireless@vger.kernel.org>; Sat, 13 Feb 2021 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NSsRx+vzKnYEk3PUy/E68l485jEqiElgFW1bUS2HOd8=; b=cf9UjxVRC5ML9hY3KyxfIBnStp
        OTGfMxIjYoZG6mkfyblTxSOFgCG65SY1a+a8K+Q7Ho8lemDnM0X82Y42ziqPc2NuyaKn9tnaxA1jU
        cBAbg9OCQ57PXp/DP6/BwGjRebYs6X+SkZ5SVpH4gqgP4SaJTWSyMYmwTY+z0cyhm/uc=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lAz4Q-0007si-QB
        for linux-wireless@vger.kernel.org; Sat, 13 Feb 2021 18:51:02 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/7] mt76: mt7615: fix key set/delete issues
Date:   Sat, 13 Feb 2021 18:50:58 +0100
Message-Id: <20210213175100.22608-5-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210213175100.22608-1-nbd@nbd.name>
References: <20210213175100.22608-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There were multiple issues in the current key set/remove code:
- deleting a key with the previous key index deletes the current key
- BIP key would only be uploaded correctly initially and corrupted on rekey

Rework the code to better keep track of multiple keys and check for the
key index before deleting the current key

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 97 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 18 ++--
 3 files changed, 65 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d0193cf2f1ce..5d3438d86d2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -223,6 +223,7 @@ struct mt76_wcid {
 
 	u16 idx;
 	u8 hw_key_idx;
+	u8 hw_key_idx2;
 
 	u8 sta:1;
 	u8 ext_phy:1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 6a835568f4a3..c97ec70772f3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1033,7 +1033,7 @@ EXPORT_SYMBOL_GPL(mt7615_mac_set_rates);
 static int
 mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key,
-			   enum mt7615_cipher_type cipher,
+			   enum mt7615_cipher_type cipher, u16 cipher_mask,
 			   enum set_key_cmd cmd)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx) + 30 * 4;
@@ -1050,22 +1050,22 @@ mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			memcpy(data + 16, key->key + 24, 8);
 			memcpy(data + 24, key->key + 16, 8);
 		} else {
-			if (cipher != MT_CIPHER_BIP_CMAC_128 && wcid->cipher)
-				memmove(data + 16, data, 16);
-			if (cipher != MT_CIPHER_BIP_CMAC_128 || !wcid->cipher)
+			if (cipher_mask == BIT(cipher))
 				memcpy(data, key->key, key->keylen);
-			else if (cipher == MT_CIPHER_BIP_CMAC_128)
+			else if (cipher != MT_CIPHER_BIP_CMAC_128)
+				memcpy(data, key->key, 16);
+			if (cipher == MT_CIPHER_BIP_CMAC_128)
 				memcpy(data + 16, key->key, 16);
 		}
 	} else {
-		if (wcid->cipher & ~BIT(cipher)) {
-			if (cipher != MT_CIPHER_BIP_CMAC_128)
-				memmove(data, data + 16, 16);
+		if (cipher == MT_CIPHER_BIP_CMAC_128)
 			memset(data + 16, 0, 16);
-		} else {
+		else if (cipher_mask)
+			memset(data, 0, 16);
+		if (!cipher_mask)
 			memset(data, 0, sizeof(data));
-		}
 	}
+
 	mt76_wr_copy(dev, addr, data, sizeof(data));
 
 	return 0;
@@ -1073,7 +1073,7 @@ mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 
 static int
 mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
-			  enum mt7615_cipher_type cipher,
+			  enum mt7615_cipher_type cipher, u16 cipher_mask,
 			  int keyidx, enum set_key_cmd cmd)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx), w0, w1;
@@ -1083,20 +1083,23 @@ mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 
 	w0 = mt76_rr(dev, addr);
 	w1 = mt76_rr(dev, addr + 4);
-	if (cmd == SET_KEY) {
-		w0 |= MT_WTBL_W0_RX_KEY_VALID |
-		      FIELD_PREP(MT_WTBL_W0_RX_IK_VALID,
-				 cipher == MT_CIPHER_BIP_CMAC_128);
-		if (cipher != MT_CIPHER_BIP_CMAC_128 ||
-		    !wcid->cipher)
-			w0 |= FIELD_PREP(MT_WTBL_W0_KEY_IDX, keyidx);
-	}  else {
-		if (!(wcid->cipher & ~BIT(cipher)))
-			w0 &= ~(MT_WTBL_W0_RX_KEY_VALID |
-				MT_WTBL_W0_KEY_IDX);
-		if (cipher == MT_CIPHER_BIP_CMAC_128)
-			w0 &= ~MT_WTBL_W0_RX_IK_VALID;
+
+	if (cipher_mask)
+		w0 |= MT_WTBL_W0_RX_KEY_VALID;
+	else
+		w0 &= ~(MT_WTBL_W0_RX_KEY_VALID | MT_WTBL_W0_KEY_IDX);
+	if (cipher_mask & BIT(MT_CIPHER_BIP_CMAC_128))
+		w0 |= MT_WTBL_W0_RX_IK_VALID;
+	else
+		w0 &= ~MT_WTBL_W0_RX_IK_VALID;
+
+	if (cmd == SET_KEY &&
+	    (cipher != MT_CIPHER_BIP_CMAC_128 ||
+	     cipher_mask == BIT(cipher))) {
+		w0 &= ~MT_WTBL_W0_KEY_IDX;
+		w0 |= FIELD_PREP(MT_WTBL_W0_KEY_IDX, keyidx);
 	}
+
 	mt76_wr(dev, MT_WTBL_RICR0, w0);
 	mt76_wr(dev, MT_WTBL_RICR1, w1);
 
@@ -1109,24 +1112,25 @@ mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 
 static void
 mt7615_mac_wtbl_update_cipher(struct mt7615_dev *dev, struct mt76_wcid *wcid,
-			      enum mt7615_cipher_type cipher,
+			      enum mt7615_cipher_type cipher, u16 cipher_mask,
 			      enum set_key_cmd cmd)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx);
 
-	if (cmd == SET_KEY) {
-		if (cipher != MT_CIPHER_BIP_CMAC_128 || !wcid->cipher)
-			mt76_rmw(dev, addr + 2 * 4, MT_WTBL_W2_KEY_TYPE,
-				 FIELD_PREP(MT_WTBL_W2_KEY_TYPE, cipher));
-	} else {
-		if (cipher != MT_CIPHER_BIP_CMAC_128 &&
-		    wcid->cipher & BIT(MT_CIPHER_BIP_CMAC_128))
-			mt76_rmw(dev, addr + 2 * 4, MT_WTBL_W2_KEY_TYPE,
-				 FIELD_PREP(MT_WTBL_W2_KEY_TYPE,
-					    MT_CIPHER_BIP_CMAC_128));
-		else if (!(wcid->cipher & ~BIT(cipher)))
-			mt76_clear(dev, addr + 2 * 4, MT_WTBL_W2_KEY_TYPE);
+	if (!cipher_mask) {
+		mt76_clear(dev, addr + 2 * 4, MT_WTBL_W2_KEY_TYPE);
+		return;
 	}
+
+	if (cmd != SET_KEY)
+		return;
+
+	if (cipher == MT_CIPHER_BIP_CMAC_128 &&
+	    cipher_mask & ~BIT(MT_CIPHER_BIP_CMAC_128))
+		return;
+
+	mt76_rmw(dev, addr + 2 * 4, MT_WTBL_W2_KEY_TYPE,
+		 FIELD_PREP(MT_WTBL_W2_KEY_TYPE, cipher));
 }
 
 int __mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
@@ -1135,25 +1139,30 @@ int __mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
 			      enum set_key_cmd cmd)
 {
 	enum mt7615_cipher_type cipher;
+	u16 cipher_mask = wcid->cipher;
 	int err;
 
 	cipher = mt7615_mac_get_cipher(key->cipher);
 	if (cipher == MT_CIPHER_NONE)
 		return -EOPNOTSUPP;
 
-	mt7615_mac_wtbl_update_cipher(dev, wcid, cipher, cmd);
-	err = mt7615_mac_wtbl_update_key(dev, wcid, key, cipher, cmd);
+	if (cmd == SET_KEY)
+		cipher_mask |= BIT(cipher);
+	else
+		cipher_mask &= ~BIT(cipher);
+
+	mt7615_mac_wtbl_update_cipher(dev, wcid, cipher, cipher_mask, cmd);
+	err = mt7615_mac_wtbl_update_key(dev, wcid, key, cipher, cipher_mask,
+					 cmd);
 	if (err < 0)
 		return err;
 
-	err = mt7615_mac_wtbl_update_pk(dev, wcid, cipher, key->keyidx, cmd);
+	err = mt7615_mac_wtbl_update_pk(dev, wcid, cipher, cipher_mask,
+					key->keyidx, cmd);
 	if (err < 0)
 		return err;
 
-	if (cmd == SET_KEY)
-		wcid->cipher |= BIT(cipher);
-	else
-		wcid->cipher &= ~BIT(cipher);
+	wcid->cipher = cipher_mask;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 25faf486d279..1aa6928f88fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -337,7 +337,8 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct mt7615_sta *msta = sta ? (struct mt7615_sta *)sta->drv_priv :
 				  &mvif->sta;
 	struct mt76_wcid *wcid = &msta->wcid;
-	int idx = key->keyidx, err;
+	int idx = key->keyidx, err = 0;
+	u8 *wcid_keyidx = &wcid->hw_key_idx;
 
 	/* The hardware does not support per-STA RX GTK, fallback
 	 * to software mode for these.
@@ -352,6 +353,7 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	/* fall back to sw encryption for unsupported ciphers */
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_AES_CMAC:
+		wcid_keyidx = &wcid->hw_key_idx2;
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
@@ -369,12 +371,13 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mt7615_mutex_acquire(dev);
 
-	if (cmd == SET_KEY) {
-		key->hw_key_idx = wcid->idx;
-		wcid->hw_key_idx = idx;
-	} else if (idx == wcid->hw_key_idx) {
-		wcid->hw_key_idx = -1;
-	}
+	if (cmd == SET_KEY)
+		*wcid_keyidx = idx;
+	else if (idx == *wcid_keyidx)
+		*wcid_keyidx = -1;
+	else
+		goto out;
+
 	mt76_wcid_key_setup(&dev->mt76, wcid,
 			    cmd == SET_KEY ? key : NULL);
 
@@ -383,6 +386,7 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	else
 		err = __mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
 
+out:
 	mt7615_mutex_release(dev);
 
 	return err;
-- 
2.28.0

