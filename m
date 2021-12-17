Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECFB479310
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbhLQRtL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 12:49:11 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44386 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbhLQRtL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 12:49:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6CB9CE2612
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 17:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4005C36AE9;
        Fri, 17 Dec 2021 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639763347;
        bh=v4FpN0Vl/V9lywV3Tte93VNZnGkSW9gDkcSXC8eYC9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCuBbb7I+gssUwz+4/wJd0BXViJhlmWMVQIxJh2Nd6Z3TqyBYNQM0nKf2OcO8gP6l
         KsNxf2x78T16rBfyj59ilKNEGjxBGxMqVh+DrfpjmzLJ1TE6pj4jtUjJ/ZVftgfkAf
         PmAQ0N1fTbkPxLbp7phjjt4PPXiOD+WA0+EumbLluTo7wYgIxI/TsqR4AiPR56NbcW
         VBTpSw6My+cqgPjxL5vAvdXuRk9sbZE1/l8qwtyBl8cJjB0yYUh30UREyYIlpp2kAq
         R/KXqsFd92RKG1CylhWnLXRWO52TGXaGR4Z3iSHG17sca2ARjT3g4b0RBpDzrl1+U6
         TSGL5KFRxIFJg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 4/7] mt76: connac: move mt76_connac_mcu_get_cipher in common code
Date:   Fri, 17 Dec 2021 18:48:48 +0100
Message-Id: <4ddc383a9472d9502cc07ed6be371583d94c8749.1639763123.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639763123.git.lorenzo@kernel.org>
References: <cover.1639763123.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac_mcu_get_cipher in mt76-connac code and remove
duplicated code from mt7921 and mt7915 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 27 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 29 +------------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 29 +------------------
 3 files changed, 29 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 4c0220df18b4..07dfde25dbd7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1428,6 +1428,33 @@ struct mt76_connac_config {
 	u8 data[320];
 } __packed;
 
+static inline enum mcu_cipher_type
+mt76_connac_mcu_get_cipher(int cipher)
+{
+	switch (cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		return MCU_CIPHER_WEP40;
+	case WLAN_CIPHER_SUITE_WEP104:
+		return MCU_CIPHER_WEP104;
+	case WLAN_CIPHER_SUITE_TKIP:
+		return MCU_CIPHER_TKIP;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		return MCU_CIPHER_BIP_CMAC_128;
+	case WLAN_CIPHER_SUITE_CCMP:
+		return MCU_CIPHER_AES_CCMP;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		return MCU_CIPHER_CCMP_256;
+	case WLAN_CIPHER_SUITE_GCMP:
+		return MCU_CIPHER_GCMP;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		return MCU_CIPHER_GCMP_256;
+	case WLAN_CIPHER_SUITE_SMS4:
+		return MCU_CIPHER_WAPI;
+	default:
+		return MCU_CIPHER_NONE;
+	}
+}
+
 #define to_wcid_lo(id)		FIELD_GET(GENMASK(7, 0), (u16)id)
 #define to_wcid_hi(id)		FIELD_GET(GENMASK(9, 8), (u16)id)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 771dae905864..b29f03409587 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -85,33 +85,6 @@ struct mt7915_fw_region {
 #define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
 #define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
 
-static enum mcu_cipher_type
-mt7915_mcu_get_cipher(int cipher)
-{
-	switch (cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-		return MCU_CIPHER_WEP40;
-	case WLAN_CIPHER_SUITE_WEP104:
-		return MCU_CIPHER_WEP104;
-	case WLAN_CIPHER_SUITE_TKIP:
-		return MCU_CIPHER_TKIP;
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-		return MCU_CIPHER_BIP_CMAC_128;
-	case WLAN_CIPHER_SUITE_CCMP:
-		return MCU_CIPHER_AES_CCMP;
-	case WLAN_CIPHER_SUITE_CCMP_256:
-		return MCU_CIPHER_CCMP_256;
-	case WLAN_CIPHER_SUITE_GCMP:
-		return MCU_CIPHER_GCMP;
-	case WLAN_CIPHER_SUITE_GCMP_256:
-		return MCU_CIPHER_GCMP_256;
-	case WLAN_CIPHER_SUITE_SMS4:
-		return MCU_CIPHER_WAPI;
-	default:
-		return MCU_CIPHER_NONE;
-	}
-}
-
 static u8 mt7915_mcu_chan_bw(struct cfg80211_chan_def *chandef)
 {
 	static const u8 width_to_bw[] = {
@@ -984,7 +957,7 @@ mt7915_mcu_sta_key_tlv(struct mt7915_sta *msta, struct sk_buff *skb,
 		struct sec_key *sec_key;
 		u8 cipher;
 
-		cipher = mt7915_mcu_get_cipher(key->cipher);
+		cipher = mt76_connac_mcu_get_cipher(key->cipher);
 		if (cipher == MCU_CIPHER_NONE)
 			return -EOPNOTSUPP;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index ef1e1ef91611..0858b026de2d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -93,33 +93,6 @@ struct mt7921_fw_region {
 #define PATCH_SEC_ENC_SCRAMBLE_INFO_MASK	GENMASK(15, 0)
 #define PATCH_SEC_ENC_AES_KEY_MASK		GENMASK(7, 0)
 
-static enum mcu_cipher_type
-mt7921_mcu_get_cipher(int cipher)
-{
-	switch (cipher) {
-	case WLAN_CIPHER_SUITE_WEP40:
-		return MCU_CIPHER_WEP40;
-	case WLAN_CIPHER_SUITE_WEP104:
-		return MCU_CIPHER_WEP104;
-	case WLAN_CIPHER_SUITE_TKIP:
-		return MCU_CIPHER_TKIP;
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-		return MCU_CIPHER_BIP_CMAC_128;
-	case WLAN_CIPHER_SUITE_CCMP:
-		return MCU_CIPHER_AES_CCMP;
-	case WLAN_CIPHER_SUITE_CCMP_256:
-		return MCU_CIPHER_CCMP_256;
-	case WLAN_CIPHER_SUITE_GCMP:
-		return MCU_CIPHER_GCMP;
-	case WLAN_CIPHER_SUITE_GCMP_256:
-		return MCU_CIPHER_GCMP_256;
-	case WLAN_CIPHER_SUITE_SMS4:
-		return MCU_CIPHER_WAPI;
-	default:
-		return MCU_CIPHER_NONE;
-	}
-}
-
 static u8 mt7921_mcu_chan_bw(struct cfg80211_chan_def *chandef)
 {
 	static const u8 width_to_bw[] = {
@@ -483,7 +456,7 @@ mt7921_mcu_sta_key_tlv(struct mt7921_sta *msta, struct sk_buff *skb,
 		struct sec_key *sec_key;
 		u8 cipher;
 
-		cipher = mt7921_mcu_get_cipher(key->cipher);
+		cipher = mt76_connac_mcu_get_cipher(key->cipher);
 		if (cipher == MCU_CIPHER_NONE)
 			return -EOPNOTSUPP;
 
-- 
2.33.1

