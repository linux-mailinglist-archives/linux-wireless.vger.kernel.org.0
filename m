Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1C67AD5
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jul 2019 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfGMPJ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jul 2019 11:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfGMPJ0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jul 2019 11:09:26 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA0E20838;
        Sat, 13 Jul 2019 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563030565;
        bh=Qds5aKkqJr/rN/yMaikHIu+MqZT7y3ZiqpVFfYxyV+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfntV4u9snUECeLMw5eWLkp9E+3oe39g50ACH7dFw8N7vXanvj4msOw/YTpeUoOKE
         20BY7ZzqGcBAqfTQIexbim9z2xysabB91305Fi1Nt172tgQw3dRfAj2yeg8E/iiJsW
         3Lrw7q3mhddMTuTWE+/T2snhMsPktV/uD+N3Isuo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        royluo@google.com, linux-wireless@vger.kernel.org
Subject: [PATCH 5/7] mt76: mt7615: add set_key_cmd and mt76_wcid to mt7615_mac_wtbl_set_key signature
Date:   Sat, 13 Jul 2019 17:09:05 +0200
Message-Id: <eb05952b13f62836a1a28bdd51c4a8fd94ad0471.1563029769.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563029769.git.lorenzo@kernel.org>
References: <cover.1563029769.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce set_key_cmd and mt76_wcid pointer to mt7615_mac_wtbl_set_key
signature and do not set key to NULL if cmd is DISABLE_KEY.
This is a preliminary patch to add BIP_CMAC_128 hw support to mt7615
driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 22 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 12 +++++-----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  5 +++--
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 1904e1a0a597..48473f480c70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -594,9 +594,12 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 
 static enum mt7615_cipher_type
 mt7615_mac_get_key_info(struct ieee80211_key_conf *key,
-			u8 *key_data)
+			u8 *key_data, enum set_key_cmd cmd)
 {
-	if (!key || key->keylen > 32)
+	if (cmd == DISABLE_KEY)
+		return MT_CIPHER_NONE;
+
+	if (key->keylen > 32)
 		return MT_CIPHER_NONE;
 
 	memcpy(key_data, key->key, key->keylen);
@@ -626,8 +629,9 @@ mt7615_mac_get_key_info(struct ieee80211_key_conf *key,
 	}
 }
 
-int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, int wcid,
-			    struct ieee80211_key_conf *key)
+int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
+			    struct ieee80211_key_conf *key,
+			    enum set_key_cmd cmd)
 {
 	enum mt7615_cipher_type cipher;
 	u8 key_data[32] = {};
@@ -640,13 +644,13 @@ int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, int wcid,
 		goto out;
 	}
 
-	cipher = mt7615_mac_get_key_info(key, key_data);
-	if (cipher == MT_CIPHER_NONE && key) {
+	cipher = mt7615_mac_get_key_info(key, key_data, cmd);
+	if (cipher == MT_CIPHER_NONE && cmd == SET_KEY) {
 		err = -EOPNOTSUPP;
 		goto out;
 	}
 
-	addr = mt7615_mac_wtbl_addr(wcid);
+	addr = mt7615_mac_wtbl_addr(wcid->idx);
 
 	mt76_wr_copy(dev, addr + 30 * 4, key_data, sizeof(key_data));
 
@@ -656,14 +660,14 @@ int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, int wcid,
 	w0 = mt76_rr(dev, addr);
 	w1 = mt76_rr(dev, addr + 4);
 	w0 &= ~(MT_WTBL_W0_KEY_IDX | MT_WTBL_W0_RX_KEY_VALID);
-	if (key)
+	if (cmd == SET_KEY)
 		w0 |= FIELD_PREP(MT_WTBL_W0_KEY_IDX, key->keyidx) |
 		      MT_WTBL_W0_RX_KEY_VALID;
 	mt76_wr(dev, MT_WTBL_RICR0, w0);
 	mt76_wr(dev, MT_WTBL_RICR1, w1);
 
 	mt76_wr(dev, MT_WTBL_UPDATE,
-		FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, wcid) |
+		FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, wcid->idx) |
 		MT_WTBL_UPDATE_RXINFO_UPDATE);
 
 	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 17920cb69874..1c365b02d7f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -196,15 +196,13 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	if (cmd == SET_KEY) {
 		key->hw_key_idx = wcid->idx;
 		wcid->hw_key_idx = idx;
-	} else {
-		if (idx == wcid->hw_key_idx)
-			wcid->hw_key_idx = -1;
-
-		key = NULL;
+	} else if (idx == wcid->hw_key_idx) {
+		wcid->hw_key_idx = -1;
 	}
-	mt76_wcid_key_setup(&dev->mt76, wcid, key);
+	mt76_wcid_key_setup(&dev->mt76, wcid,
+			    cmd == SET_KEY ? key : NULL);
 
-	return mt7615_mac_wtbl_set_key(dev, wcid->idx, key);
+	return mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
 }
 
 static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index e6067c88cbbd..9d2286be0700 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -219,8 +219,9 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb);
 void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data);
 void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb);
-int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, int wcid,
-			    struct ieee80211_key_conf *key);
+int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
+			    struct ieee80211_key_conf *key,
+			    enum set_key_cmd cmd);
 
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
 int mt7615_mcu_init_mac(struct mt7615_dev *dev);
-- 
2.21.0

