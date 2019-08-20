Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C419633F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 16:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfHTO4h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 10:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTO4h (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 10:56:37 -0400
Received: from localhost.localdomain (unknown [151.66.62.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B8C22DA7;
        Tue, 20 Aug 2019 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566312995;
        bh=fWPHi2G90VrGYB2psSLnFH2aE2tL9JstkqH0Dr2SBgg=;
        h=From:To:Cc:Subject:Date:From;
        b=SxwJu3RSm07ZizYkpQdom6MkIKw6vX+4lGN7XwGQntse3KsHX6aozzTApBkZAkYkX
         LpqZjKoGzfoWnkKcK16VK2wCKtTcHXyf0WK6daUNoLTWXh7NE/ru9vKIeIjOduyqCx
         6l7nvPryRyWJJ4l4qDNKn28NFIOFqHwecZZhvd9c=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH v2] mt76: mt7615: add BIP_CMAC_128 cipher support
Date:   Tue, 20 Aug 2019 16:56:25 +0200
Message-Id: <0b91d401306199aab40b7d4ea3a94aa6a4b37f62.1566312764.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Refactor mt7615_mac_wtbl_set_key and introduce
the following routines in order to configure wtbl entries
and properly add hw support to BIP_CMAC_128 cipher:
- mt7615_mac_wtbl_update_cipher
- mt7615_mac_wtbl_update_pk
- mt7615_mac_wtbl_update_key

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- rebase ontop of 'mac80211: add IEEE80211_KEY_FLAG_GENERATE_MMIE to
  ieee80211_key_flags'
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 173 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   3 +
 4 files changed, 135 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 581415425cd6..b97249898e9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -476,9 +476,10 @@ void mt76_wcid_key_setup(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	if (!key)
 		return;
 
-	if (key->cipher == WLAN_CIPHER_SUITE_CCMP)
-		wcid->rx_check_pn = true;
+	if (key->cipher != WLAN_CIPHER_SUITE_CCMP)
+		return;
 
+	wcid->rx_check_pn = true;
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
 		ieee80211_get_key_rx_seq(key, i, &seq);
 		memcpy(wcid->rx_key_pn[i], seq.ccmp.pn, sizeof(seq.ccmp.pn));
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 95ba6e98afa2..59ddfb3fcbae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -204,6 +204,7 @@ struct mt76_wcid {
 
 	u8 rx_check_pn;
 	u8 rx_key_pn[IEEE80211_NUM_TIDS][6];
+	u16 cipher;
 
 	u32 tx_info;
 	bool sw_iv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 0554aa2dbe2f..24d21f788bd3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -312,6 +312,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_tx_rate *rate = &info->control.rates[0];
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	struct ieee80211_vif *vif = info->control.vif;
 	int tx_count = 8;
 	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
@@ -364,8 +365,18 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 
 	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
 	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
-	      FIELD_PREP(MT_TXD2_MULTICAST,
-			 is_multicast_ether_addr(hdr->addr1));
+	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
+	if (key) {
+		if (multicast && ieee80211_is_robust_mgmt_frame(skb) &&
+		    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
+			val |= MT_TXD2_BIP;
+			txwi[3] = 0;
+		} else {
+			txwi[3] = cpu_to_le32(MT_TXD3_PROTECT_FRAME);
+		}
+	} else {
+		txwi[3] = 0;
+	}
 	txwi[2] = cpu_to_le32(val);
 
 	if (!(info->flags & IEEE80211_TX_CTL_AMPDU))
@@ -422,14 +433,11 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	}
 	val |= FIELD_PREP(MT_TXD3_SEQ, seqno);
 
-	txwi[3] = cpu_to_le32(val);
+	txwi[3] |= cpu_to_le32(val);
 
 	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
 		txwi[3] |= cpu_to_le32(MT_TXD3_NO_ACK);
 
-	if (key)
-		txwi[3] |= cpu_to_le32(MT_TXD3_PROTECT_FRAME);
-
 	txwi[7] = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
 		  FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
 
@@ -593,27 +601,17 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 }
 
 static enum mt7615_cipher_type
-mt7615_mac_get_key_info(struct ieee80211_key_conf *key,
-			u8 *key_data, enum set_key_cmd cmd)
+mt7615_mac_get_cipher(int cipher)
 {
-	if (cmd == DISABLE_KEY)
-		return MT_CIPHER_NONE;
-
-	if (key->keylen > 32)
-		return MT_CIPHER_NONE;
-
-	memcpy(key_data, key->key, key->keylen);
-
-	switch (key->cipher) {
+	switch (cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 		return MT_CIPHER_WEP40;
 	case WLAN_CIPHER_SUITE_WEP104:
 		return MT_CIPHER_WEP104;
 	case WLAN_CIPHER_SUITE_TKIP:
-		/* Rx/Tx MIC keys are swapped */
-		memcpy(key_data + 16, key->key + 24, 8);
-		memcpy(key_data + 24, key->key + 16, 8);
 		return MT_CIPHER_TKIP;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		return MT_CIPHER_BIP_CMAC_128;
 	case WLAN_CIPHER_SUITE_CCMP:
 		return MT_CIPHER_AES_CCMP;
 	case WLAN_CIPHER_SUITE_CCMP_256:
@@ -629,40 +627,71 @@ mt7615_mac_get_key_info(struct ieee80211_key_conf *key,
 	}
 }
 
-int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
-			    struct ieee80211_key_conf *key,
-			    enum set_key_cmd cmd)
+static int
+mt7615_mac_wtbl_update_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
+			   struct ieee80211_key_conf *key,
+			   enum mt7615_cipher_type cipher,
+			   enum set_key_cmd cmd)
 {
-	enum mt7615_cipher_type cipher;
-	u8 key_data[32] = {};
-	u32 addr, w0, w1;
-	int err = 0;
+	u32 addr = mt7615_mac_wtbl_addr(wcid->idx) + 30 * 4;
+	u8 data[32] = {};
 
-	spin_lock_bh(&dev->mt76.lock);
-	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000)) {
-		err = -ETIMEDOUT;
-		goto out;
-	}
+	if (key->keylen > sizeof(data))
+		return -EINVAL;
 
-	cipher = mt7615_mac_get_key_info(key, key_data, cmd);
-	if (cipher == MT_CIPHER_NONE && cmd == SET_KEY) {
-		err = -EOPNOTSUPP;
-		goto out;
+	mt76_rr_copy(dev, addr, data, sizeof(data));
+	if (cmd == SET_KEY) {
+		if (cipher == MT_CIPHER_TKIP) {
+			/* Rx/Tx MIC keys are swapped */
+			memcpy(data + 16, key->key + 24, 8);
+			memcpy(data + 24, key->key + 16, 8);
+		}
+		if (cipher != MT_CIPHER_BIP_CMAC_128 && wcid->cipher)
+			memmove(data + 16, data, 16);
+		if (cipher != MT_CIPHER_BIP_CMAC_128 || !wcid->cipher)
+			memcpy(data, key->key, key->keylen);
+		else if (cipher == MT_CIPHER_BIP_CMAC_128)
+			memcpy(data + 16, key->key, 16);
+	} else {
+		if (wcid->cipher & ~BIT(cipher)) {
+			if (cipher != MT_CIPHER_BIP_CMAC_128)
+				memmove(data, data + 16, 16);
+			memset(data + 16, 0, 16);
+		} else {
+			memset(data, 0, sizeof(data));
+		}
 	}
+	mt76_wr_copy(dev, addr, data, sizeof(data));
 
-	addr = mt7615_mac_wtbl_addr(wcid->idx);
+	return 0;
+}
 
-	mt76_wr_copy(dev, addr + 30 * 4, key_data, sizeof(key_data));
+static int
+mt7615_mac_wtbl_update_pk(struct mt7615_dev *dev, struct mt76_wcid *wcid,
+			  enum mt7615_cipher_type cipher, int keyidx,
+			  enum set_key_cmd cmd)
+{
+	u32 addr = mt7615_mac_wtbl_addr(wcid->idx), w0, w1;
 
-	mt76_rmw(dev, addr + 2 * 4, MT_WTBL_W2_KEY_TYPE,
-		 FIELD_PREP(MT_WTBL_W2_KEY_TYPE, cipher));
+	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
+		return -ETIMEDOUT;
 
 	w0 = mt76_rr(dev, addr);
 	w1 = mt76_rr(dev, addr + 4);
-	w0 &= ~(MT_WTBL_W0_KEY_IDX | MT_WTBL_W0_RX_KEY_VALID);
-	if (cmd == SET_KEY)
-		w0 |= FIELD_PREP(MT_WTBL_W0_KEY_IDX, key->keyidx) |
-		      MT_WTBL_W0_RX_KEY_VALID;
+	if (cmd == SET_KEY) {
+		w0 |= MT_WTBL_W0_RX_KEY_VALID |
+		      FIELD_PREP(MT_WTBL_W0_RX_IK_VALID,
+				 cipher == MT_CIPHER_BIP_CMAC_128);
+		if (cipher != MT_CIPHER_BIP_CMAC_128 ||
+		    !wcid->cipher)
+			w0 |= FIELD_PREP(MT_WTBL_W0_KEY_IDX, keyidx);
+	}  else {
+		if (!(wcid->cipher & ~BIT(cipher)))
+			w0 &= ~(MT_WTBL_W0_RX_KEY_VALID |
+				MT_WTBL_W0_KEY_IDX);
+		if (cipher == MT_CIPHER_BIP_CMAC_128)
+			w0 &= ~MT_WTBL_W0_RX_IK_VALID;
+	}
 	mt76_wr(dev, MT_WTBL_RICR0, w0);
 	mt76_wr(dev, MT_WTBL_RICR1, w1);
 
@@ -671,7 +700,61 @@ int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 		MT_WTBL_UPDATE_RXINFO_UPDATE);
 
 	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
-		err = -ETIMEDOUT;
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void
+mt7615_mac_wtbl_update_cipher(struct mt7615_dev *dev, struct mt76_wcid *wcid,
+			      enum mt7615_cipher_type cipher,
+			      enum set_key_cmd cmd)
+{
+	u32 addr = mt7615_mac_wtbl_addr(wcid->idx);
+
+	if (cmd == SET_KEY) {
+		if (cipher != MT_CIPHER_BIP_CMAC_128 || !wcid->cipher)
+			mt76_rmw(dev, addr + 2 * 4, MT_WTBL_W2_KEY_TYPE,
+				 FIELD_PREP(MT_WTBL_W2_KEY_TYPE, cipher));
+	} else {
+		if (cipher != MT_CIPHER_BIP_CMAC_128 &&
+		    wcid->cipher & BIT(MT_CIPHER_BIP_CMAC_128))
+			mt76_rmw(dev, addr + 2 * 4, MT_WTBL_W2_KEY_TYPE,
+				 FIELD_PREP(MT_WTBL_W2_KEY_TYPE,
+					    MT_CIPHER_BIP_CMAC_128));
+		else if (!(wcid->cipher & ~BIT(cipher)))
+			mt76_clear(dev, addr + 2 * 4, MT_WTBL_W2_KEY_TYPE);
+	}
+}
+
+int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
+			    struct mt76_wcid *wcid,
+			    struct ieee80211_key_conf *key,
+			    enum set_key_cmd cmd)
+{
+	enum mt7615_cipher_type cipher;
+	int err;
+
+	cipher = mt7615_mac_get_cipher(key->cipher);
+	if (cipher == MT_CIPHER_NONE)
+		return -EOPNOTSUPP;
+
+	spin_lock_bh(&dev->mt76.lock);
+
+	mt7615_mac_wtbl_update_cipher(dev, wcid, cipher, cmd);
+	err = mt7615_mac_wtbl_update_key(dev, wcid, key, cipher, cmd);
+	if (err < 0)
+		goto out;
+
+	err = mt7615_mac_wtbl_update_pk(dev, wcid, cipher, key->keyidx,
+					cmd);
+	if (err < 0)
+		goto out;
+
+	if (cmd == SET_KEY)
+		wcid->cipher |= BIT(cipher);
+	else
+		wcid->cipher &= ~BIT(cipher);
 
 out:
 	spin_unlock_bh(&dev->mt76.lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 5fdda85175c0..9347e0fe99bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -183,6 +183,9 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	/* fall back to sw encryption for unsupported ciphers */
 	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_MMIE;
+		break;
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104:
 	case WLAN_CIPHER_SUITE_TKIP:
-- 
2.21.0

