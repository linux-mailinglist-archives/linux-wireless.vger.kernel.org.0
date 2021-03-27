Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E512B34B597
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Mar 2021 10:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhC0JK5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Mar 2021 05:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhC0JK3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Mar 2021 05:10:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 192E5619C9;
        Sat, 27 Mar 2021 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616836229;
        bh=jpGfudS3XIaY1+wnBRLaZ63cR4rZ0792GRG0qOc/tsE=;
        h=From:To:Cc:Subject:Date:From;
        b=D2suNFkDKfuYPi9f4sgL0QejJpnak5RUoAmiAkuRomyjhXoEWMMyVVKH3qzG0o8+j
         ePTTADBtJkVUq8EOmRhrW1ozI2oE42m/vAfxoMD4KSq1SoXeIwb92C/+5I5AgXn2t3
         3u0H2sZQ1sI/BerUgaxOsKvrFujVLld3jDQWXOVWsx0qkI7HVePRAP4uFwJwZ8Bwjc
         OnfQ0tSh53rf6bUpkQ+4VrDKlozrEq57Ky/Q89dgGFGd2owpqzkMs25HQWwyufZOEv
         fCDVs5AISrkS6/FxG3Ctk042C0/nNdqzMYkU4/NB08C5FQbKZxCGaaefelLx4vlFZ2
         gCEQ+Oi0Y33LA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: fix key set/delete issue
Date:   Sat, 27 Mar 2021 10:10:14 +0100
Message-Id: <03ae98875c71f593e6290c7e87a41fea7e374465.1616836088.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to the mt7915 driver, deleting a key with the previous key index
deletes the current key. Rework the code to better keep track of
multiple keys and check for the key index before deleting the current
key

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 92775f98a80c..c0ebb6077fa8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -418,7 +418,8 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct mt7921_sta *msta = sta ? (struct mt7921_sta *)sta->drv_priv :
 				  &mvif->sta;
 	struct mt76_wcid *wcid = &msta->wcid;
-	int idx = key->keyidx;
+	u8 *wcid_keyidx = &wcid->hw_key_idx;
+	int idx = key->keyidx, err = 0;
 
 	/* The hardware does not support per-STA RX GTK, fallback
 	 * to software mode for these.
@@ -434,6 +435,7 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+		wcid_keyidx = &wcid->hw_key_idx2;
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
 	case WLAN_CIPHER_SUITE_CCMP:
@@ -448,16 +450,23 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return -EOPNOTSUPP;
 	}
 
-	if (cmd == SET_KEY) {
-		key->hw_key_idx = wcid->idx;
-		wcid->hw_key_idx = idx;
-	} else if (idx == wcid->hw_key_idx) {
-		wcid->hw_key_idx = -1;
-	}
+	mt7921_mutex_acquire(dev);
+
+	if (cmd == SET_KEY)
+		*wcid_keyidx = idx;
+	else if (idx == *wcid_keyidx)
+		*wcid_keyidx = -1;
+	else
+		goto out;
+
 	mt76_wcid_key_setup(&dev->mt76, wcid,
 			    cmd == SET_KEY ? key : NULL);
 
-	return mt7921_mcu_add_key(dev, vif, msta, key, cmd);
+	err = mt7921_mcu_add_key(dev, vif, msta, key, cmd);
+out:
+	mt7921_mutex_release(dev);
+
+	return err;
 }
 
 static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
-- 
2.30.2

