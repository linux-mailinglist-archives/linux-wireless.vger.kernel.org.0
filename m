Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734FC67AD1
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jul 2019 17:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfGMPJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jul 2019 11:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfGMPJU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jul 2019 11:09:20 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9BBF20850;
        Sat, 13 Jul 2019 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563030559;
        bh=JiSvgiO9SW/1bVG/vzCd9VkmLXMok0hQ4NToo0rFSV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDFtWcPt1UPsNFHcF4FP5eE0LGZqGKAI0/0zCPHqhnPJb7MYDXWPgNXIwL9h/tjQv
         gQzqoWSSLu4Y444JWKX6N1TCIvMEKjygbT2vULxlQYBD6UAIREoLfpq3soB2sgkupR
         IHNkbiRZNX5n6L4HWB+OBYX0sT811CXxbdcQzyq4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        royluo@google.com, linux-wireless@vger.kernel.org
Subject: [PATCH 1/7] mt76: mt7615: move mt7615_mac_get_key_info in mac.c
Date:   Sat, 13 Jul 2019 17:09:01 +0200
Message-Id: <397b03da25fa8df659ea41fd872287e319dad021.1563029769.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563029769.git.lorenzo@kernel.org>
References: <cover.1563029769.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to update wtbl key directly from host
processor

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 35 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mac.h   | 19 ++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 35 +------------------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 15 --------
 4 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index b3e8ee06a783..53937573662f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -586,6 +586,41 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 	sta->rate_count = 2 * MT7615_RATE_RETRY * n_rates;
 	sta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 }
+
+enum mt7615_cipher_type
+mt7615_mac_get_key_info(struct ieee80211_key_conf *key,
+			u8 *key_data)
+{
+	if (!key || key->keylen > 32)
+		return MT_CIPHER_NONE;
+
+	memcpy(key_data, key->key, key->keylen);
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		return MT_CIPHER_WEP40;
+	case WLAN_CIPHER_SUITE_WEP104:
+		return MT_CIPHER_WEP104;
+	case WLAN_CIPHER_SUITE_TKIP:
+		/* Rx/Tx MIC keys are swapped */
+		memcpy(key_data + 16, key->key + 24, 8);
+		memcpy(key_data + 24, key->key + 16, 8);
+		return MT_CIPHER_TKIP;
+	case WLAN_CIPHER_SUITE_CCMP:
+		return MT_CIPHER_AES_CCMP;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		return MT_CIPHER_CCMP_256;
+	case WLAN_CIPHER_SUITE_GCMP:
+		return MT_CIPHER_GCMP;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		return MT_CIPHER_GCMP_256;
+	case WLAN_CIPHER_SUITE_SMS4:
+		return MT_CIPHER_WAPI;
+	default:
+		return MT_CIPHER_NONE;
+	}
+}
+
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index b00ce8db58e9..358ab51270f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -302,4 +302,23 @@ struct mt7615_tx_free {
 #define MT_TXS6_F1_RCPI_1		GENMASK(15, 8)
 #define MT_TXS6_F1_RCPI_0		GENMASK(7, 0)
 
+enum mt7615_cipher_type {
+	MT_CIPHER_NONE,
+	MT_CIPHER_WEP40,
+	MT_CIPHER_TKIP,
+	MT_CIPHER_TKIP_NO_MIC,
+	MT_CIPHER_AES_CCMP,
+	MT_CIPHER_WEP104,
+	MT_CIPHER_BIP_CMAC_128,
+	MT_CIPHER_WEP128,
+	MT_CIPHER_WAPI,
+	MT_CIPHER_CCMP_256 = 10,
+	MT_CIPHER_GCMP,
+	MT_CIPHER_GCMP_256,
+};
+
+enum mt7615_cipher_type
+mt7615_mac_get_key_info(struct ieee80211_key_conf *key,
+			u8 *key_data);
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e57b51290c61..e05ef57441a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -877,39 +877,6 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 	return ret;
 }
 
-static enum mt7615_cipher_type
-mt7615_get_key_info(struct ieee80211_key_conf *key, u8 *key_data)
-{
-	if (!key || key->keylen > 32)
-		return MT_CIPHER_NONE;
-
-	memcpy(key_data, key->key, key->keylen);
-
-	switch (key->cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-		return MT_CIPHER_WEP40;
-	case WLAN_CIPHER_SUITE_WEP104:
-		return MT_CIPHER_WEP104;
-	case WLAN_CIPHER_SUITE_TKIP:
-		/* Rx/Tx MIC keys are swapped */
-		memcpy(key_data + 16, key->key + 24, 8);
-		memcpy(key_data + 24, key->key + 16, 8);
-		return MT_CIPHER_TKIP;
-	case WLAN_CIPHER_SUITE_CCMP:
-		return MT_CIPHER_AES_CCMP;
-	case WLAN_CIPHER_SUITE_CCMP_256:
-		return MT_CIPHER_CCMP_256;
-	case WLAN_CIPHER_SUITE_GCMP:
-		return MT_CIPHER_GCMP;
-	case WLAN_CIPHER_SUITE_GCMP_256:
-		return MT_CIPHER_GCMP_256;
-	case WLAN_CIPHER_SUITE_SMS4:
-		return MT_CIPHER_WAPI;
-	default:
-		return MT_CIPHER_NONE;
-	}
-}
-
 int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 			    struct ieee80211_key_conf *key,
 			    enum set_key_cmd cmd)
@@ -933,7 +900,7 @@ int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 	if (cmd == SET_KEY) {
 		u8 cipher;
 
-		cipher = mt7615_get_key_info(key, req.key.key_material);
+		cipher = mt7615_mac_get_key_info(key, req.key.key_material);
 		if (cipher == MT_CIPHER_NONE)
 			return -EOPNOTSUPP;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 17d22bfb1722..ef0cd81b822a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -288,21 +288,6 @@ struct wtbl_hdr_trans {
 	u8 rsv;
 } __packed;
 
-enum mt7615_cipher_type {
-	MT_CIPHER_NONE,
-	MT_CIPHER_WEP40,
-	MT_CIPHER_TKIP,
-	MT_CIPHER_TKIP_NO_MIC,
-	MT_CIPHER_AES_CCMP,
-	MT_CIPHER_WEP104,
-	MT_CIPHER_BIP_CMAC_128,
-	MT_CIPHER_WEP128,
-	MT_CIPHER_WAPI,
-	MT_CIPHER_CCMP_256 = 10,
-	MT_CIPHER_GCMP,
-	MT_CIPHER_GCMP_256,
-};
-
 struct wtbl_sec_key {
 	__le16 tag;
 	__le16 len;
-- 
2.21.0

