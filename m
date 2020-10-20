Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E43429365B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 10:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbgJTID3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 04:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732632AbgJTID0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 04:03:26 -0400
Received: from lore-desk.redhat.com (unknown [151.66.125.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B2422247;
        Tue, 20 Oct 2020 08:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603181005;
        bh=JJNxqZsjIdWgjTppb6Ln7rCRpzc/R4U6iG5rXdFQ4tU=;
        h=From:To:Cc:Subject:Date:From;
        b=sYXeB789U37447b4qnP3tNwJSnhytGioVhcte9pgespqsDtcv4qpyqXMrWod0hVES
         VjdDP80fDLGSG59EzABXsHMTMOg+kSKsuUfiahVCZ+Rp3oj3y+u9pMlWQBnsYPW5d0
         aG4zUa4Lt7skwLWwbHmuFUhinhZhphcwcDhgSyTU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, yn.chen@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7615: run key configuration in mt7615_set_key for usb/sdio devices
Date:   Tue, 20 Oct 2020 10:03:17 +0200
Message-Id: <39105deff6f6ec8e5563ceb9537ded9d3d49b595.1603180869.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since rate configuration is run holding dev mutex, we can run key
configuration in mt7615_set_key for usb/sdio devices avoiding to
schedule the workqueue

Tested-by: Tested-by: YN Chen <yn.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on "mt76: fix tkip configuration for mt7615/7663 devices"
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 74 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 35 +--------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    | 27 +------
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  | 49 ------------
 4 files changed, 44 insertions(+), 141 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 09da41cbdc6d..9df28608d6bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1030,32 +1030,32 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 }
 EXPORT_SYMBOL_GPL(mt7615_mac_set_rates);
 
-int mt7615_mac_wtbl_update_key(struct mt7615_dev *dev,
-			       struct mt76_wcid *wcid,
-			       u8 *key, u8 keylen,
-			       enum mt7615_cipher_type cipher,
-			       enum set_key_cmd cmd)
+static int
+mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
+			   struct ieee80211_key_conf *key,
+			   enum mt7615_cipher_type cipher,
+			   enum set_key_cmd cmd)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx) + 30 * 4;
 	u8 data[32] = {};
 
-	if (keylen > sizeof(data))
+	if (key->keylen > sizeof(data))
 		return -EINVAL;
 
 	mt76_rr_copy(dev, addr, data, sizeof(data));
 	if (cmd == SET_KEY) {
 		if (cipher == MT_CIPHER_TKIP) {
 			/* Rx/Tx MIC keys are swapped */
-			memcpy(data, key, 16);
-			memcpy(data + 16, key + 24, 8);
-			memcpy(data + 24, key + 16, 8);
+			memcpy(data, key->key, 16);
+			memcpy(data + 16, key->key + 24, 8);
+			memcpy(data + 24, key->key + 16, 8);
 		} else {
 			if (cipher != MT_CIPHER_BIP_CMAC_128 && wcid->cipher)
 				memmove(data + 16, data, 16);
 			if (cipher != MT_CIPHER_BIP_CMAC_128 || !wcid->cipher)
-				memcpy(data, key, keylen);
+				memcpy(data, key->key, key->keylen);
 			else if (cipher == MT_CIPHER_BIP_CMAC_128)
-				memcpy(data + 16, key, 16);
+				memcpy(data + 16, key->key, 16);
 		}
 	} else {
 		if (wcid->cipher & ~BIT(cipher)) {
@@ -1070,12 +1070,11 @@ int mt7615_mac_wtbl_update_key(struct mt7615_dev *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mt7615_mac_wtbl_update_key);
 
-int mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev,
-			      struct mt76_wcid *wcid,
-			      enum mt7615_cipher_type cipher,
-			      int keyidx, enum set_key_cmd cmd)
+static int
+mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
+			  enum mt7615_cipher_type cipher,
+			  int keyidx, enum set_key_cmd cmd)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx), w0, w1;
 
@@ -1107,12 +1106,11 @@ int mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mt7615_mac_wtbl_update_pk);
 
-void mt7615_mac_wtbl_update_cipher(struct mt7615_dev *dev,
-				   struct mt76_wcid *wcid,
-				   enum mt7615_cipher_type cipher,
-				   enum set_key_cmd cmd)
+static void
+mt7615_mac_wtbl_update_cipher(struct mt7615_dev *dev, struct mt76_wcid *wcid,
+			      enum mt7615_cipher_type cipher,
+			      enum set_key_cmd cmd)
 {
 	u32 addr = mt7615_mac_wtbl_addr(dev, wcid->idx);
 
@@ -1130,12 +1128,11 @@ void mt7615_mac_wtbl_update_cipher(struct mt7615_dev *dev,
 			mt76_clear(dev, addr + 2 * 4, MT_WTBL_W2_KEY_TYPE);
 	}
 }
-EXPORT_SYMBOL_GPL(mt7615_mac_wtbl_update_cipher);
 
-int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
-			    struct mt76_wcid *wcid,
-			    struct ieee80211_key_conf *key,
-			    enum set_key_cmd cmd)
+int __mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
+			      struct mt76_wcid *wcid,
+			      struct ieee80211_key_conf *key,
+			      enum set_key_cmd cmd)
 {
 	enum mt7615_cipher_type cipher;
 	int err;
@@ -1144,25 +1141,32 @@ int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
 	if (cipher == MT_CIPHER_NONE)
 		return -EOPNOTSUPP;
 
-	spin_lock_bh(&dev->mt76.lock);
-
 	mt7615_mac_wtbl_update_cipher(dev, wcid, cipher, cmd);
-	err = mt7615_mac_wtbl_update_key(dev, wcid, key->key, key->keylen,
-					 cipher, cmd);
+	err = mt7615_mac_wtbl_update_key(dev, wcid, key, cipher, cmd);
 	if (err < 0)
-		goto out;
+		return err;
 
-	err = mt7615_mac_wtbl_update_pk(dev, wcid, cipher, key->keyidx,
-					cmd);
+	err = mt7615_mac_wtbl_update_pk(dev, wcid, cipher, key->keyidx, cmd);
 	if (err < 0)
-		goto out;
+		return err;
 
 	if (cmd == SET_KEY)
 		wcid->cipher |= BIT(cipher);
 	else
 		wcid->cipher &= ~BIT(cipher);
 
-out:
+	return 0;
+}
+
+int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
+			    struct mt76_wcid *wcid,
+			    struct ieee80211_key_conf *key,
+			    enum set_key_cmd cmd)
+{
+	int err;
+
+	spin_lock_bh(&dev->mt76.lock);
+	err = __mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
 	spin_unlock_bh(&dev->mt76.lock);
 
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index e395470fbf80..8ac6798ba44d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -320,39 +320,6 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 	return ret;
 }
 
-static int
-mt7615_queue_key_update(struct mt7615_dev *dev, enum set_key_cmd cmd,
-			struct mt7615_sta *msta,
-			struct ieee80211_key_conf *key)
-{
-	struct mt7615_wtbl_desc *wd;
-
-	wd = kzalloc(sizeof(*wd), GFP_KERNEL);
-	if (!wd)
-		return -ENOMEM;
-
-	wd->type = MT7615_WTBL_KEY_DESC;
-	wd->sta = msta;
-
-	wd->key.key = kmemdup(key->key, key->keylen, GFP_KERNEL);
-	if (!wd->key.key) {
-		kfree(wd);
-		return -ENOMEM;
-	}
-	wd->key.cipher = key->cipher;
-	wd->key.keyidx = key->keyidx;
-	wd->key.keylen = key->keylen;
-	wd->key.cmd = cmd;
-
-	spin_lock_bh(&dev->mt76.lock);
-	list_add_tail(&wd->node, &dev->wd_head);
-	spin_unlock_bh(&dev->mt76.lock);
-
-	queue_work(dev->mt76.wq, &dev->wtbl_work);
-
-	return 0;
-}
-
 static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 			  struct ieee80211_key_conf *key)
@@ -406,7 +373,7 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	if (mt76_is_mmio(&dev->mt76))
 		err = mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
 	else
-		err = mt7615_queue_key_update(dev, cmd, msta, key);
+		err = __mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
 
 	mt7615_mutex_release(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index c04d16946a9f..73000d7f0d84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -108,15 +108,6 @@ struct mt7615_rate_desc {
 
 enum mt7615_wtbl_desc_type {
 	MT7615_WTBL_RATE_DESC,
-	MT7615_WTBL_KEY_DESC
-};
-
-struct mt7615_key_desc {
-	enum set_key_cmd cmd;
-	u32 cipher;
-	s8 keyidx;
-	u8 keylen;
-	u8 *key;
 };
 
 struct mt7615_wtbl_desc {
@@ -127,7 +118,6 @@ struct mt7615_wtbl_desc {
 
 	union {
 		struct mt7615_rate_desc rate;
-		struct mt7615_key_desc key;
 	};
 };
 
@@ -571,22 +561,13 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct ieee80211_sta *sta, int pid,
 			  struct ieee80211_key_conf *key, bool beacon);
 void mt7615_mac_set_timing(struct mt7615_phy *phy);
+int __mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
+			      struct mt76_wcid *wcid,
+			      struct ieee80211_key_conf *key,
+			      enum set_key_cmd cmd);
 int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			    struct ieee80211_key_conf *key,
 			    enum set_key_cmd cmd);
-int mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev,
-			      struct mt76_wcid *wcid,
-			      enum mt7615_cipher_type cipher,
-			      int keyidx, enum set_key_cmd cmd);
-void mt7615_mac_wtbl_update_cipher(struct mt7615_dev *dev,
-				   struct mt76_wcid *wcid,
-				   enum mt7615_cipher_type cipher,
-				   enum set_key_cmd cmd);
-int mt7615_mac_wtbl_update_key(struct mt7615_dev *dev,
-			       struct mt76_wcid *wcid,
-			       u8 *key, u8 keylen,
-			       enum mt7615_cipher_type cipher,
-			       enum set_key_cmd cmd);
 void mt7615_mac_reset_work(struct work_struct *work);
 u32 mt7615_mac_get_sta_tid_sn(struct mt7615_dev *dev, int wcid, u8 tid);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 3b29a6d3dc64..eb3a14cb6cc1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -132,52 +132,6 @@ mt7663_usb_sdio_set_rates(struct mt7615_dev *dev,
 	return 0;
 }
 
-static int
-mt7663_usb_sdio_set_key(struct mt7615_dev *dev,
-			struct mt7615_wtbl_desc *wd)
-{
-	struct mt7615_key_desc *key = &wd->key;
-	struct mt7615_sta *sta = wd->sta;
-	enum mt7615_cipher_type cipher;
-	struct mt76_wcid *wcid;
-	int err;
-
-	lockdep_assert_held(&dev->mt76.mutex);
-
-	if (!sta) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	cipher = mt7615_mac_get_cipher(key->cipher);
-	if (cipher == MT_CIPHER_NONE) {
-		err = -EOPNOTSUPP;
-		goto out;
-	}
-
-	wcid = &wd->sta->wcid;
-
-	mt7615_mac_wtbl_update_cipher(dev, wcid, cipher, key->cmd);
-	err = mt7615_mac_wtbl_update_key(dev, wcid, key->key, key->keylen,
-					 cipher, key->cmd);
-	if (err < 0)
-		goto out;
-
-	err = mt7615_mac_wtbl_update_pk(dev, wcid, cipher, key->keyidx,
-					key->cmd);
-	if (err < 0)
-		goto out;
-
-	if (key->cmd == SET_KEY)
-		wcid->cipher |= BIT(cipher);
-	else
-		wcid->cipher &= ~BIT(cipher);
-out:
-	kfree(key->key);
-
-	return err;
-}
-
 void mt7663_usb_sdio_wtbl_work(struct work_struct *work)
 {
 	struct mt7615_wtbl_desc *wd, *wd_next;
@@ -201,9 +155,6 @@ void mt7663_usb_sdio_wtbl_work(struct work_struct *work)
 		case MT7615_WTBL_RATE_DESC:
 			mt7663_usb_sdio_set_rates(dev, wd);
 			break;
-		case MT7615_WTBL_KEY_DESC:
-			mt7663_usb_sdio_set_key(dev, wd);
-			break;
 		}
 
 		mt7615_mutex_release(dev);
-- 
2.26.2

