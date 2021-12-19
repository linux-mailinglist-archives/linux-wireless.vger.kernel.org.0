Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC8A47A197
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 18:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhLSRlH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 12:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhLSRlH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 12:41:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02ACC061574
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 09:41:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8150860ECF
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 17:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAADAC36AE9;
        Sun, 19 Dec 2021 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639935666;
        bh=pMrQGJWLRHCBBPGN/OrqRc4cJwNOTtlmxjVeDDqvm78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnuU5cvpSTemoy0Vd22Tc+I3EWQYm5CpbspwQ64i865IjkdKEfgsuSrdlHbnS5GGO
         Q+9IJ5MoaLIbydscYwErAHk8n/GHP9sl37kZKtLzD/yXvK4QV+zSdRv6fBB6p4+raU
         7uNOsZPbbEg1j1Q/LjOqIPMkgt7QFxnLZhx4yi8mu7RQk6/vTXoHSNRQ9ieSS2RuN+
         dOIIlAhSEADEt2Ntv+Lh+Z8yAVVNjEytenvbE8antYi9oTaTdYL/Y5oRxwjwhvlFGP
         vNiUAv4m7bNEWqAWDv50btSU/9xEd5nhi99Z7/CJVdz4ZOTHqSnth54WGYNqm/WJBI
         sP9E7bqVewkhA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH v2 6/9] mt76: connac: move mt76_connac_mcu_get_cipher in common code
Date:   Sun, 19 Dec 2021 18:40:11 +0100
Message-Id: <77146c32b9e409a2cec1d62fc73a32ab770fca0d.1639935477.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639935477.git.lorenzo@kernel.org>
References: <cover.1639935477.git.lorenzo@kernel.org>
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
index bd93697b7d4b..756daf1ce6b8 100644
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

