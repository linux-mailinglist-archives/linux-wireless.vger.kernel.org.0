Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD5E2D2FED
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 17:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgLHQjw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 11:39:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51509 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730264AbgLHQjw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 11:39:52 -0500
X-UUID: 12cb5184cc0444f7b932f9ac09d1acaf-20201209
X-UUID: 12cb5184cc0444f7b932f9ac09d1acaf-20201209
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1393703589; Wed, 09 Dec 2020 00:39:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Dec 2020 00:39:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Dec 2020 00:39:05 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix MT_CIPHER_BIP_CMAC_128 setkey
Date:   Wed, 9 Dec 2020 00:39:04 +0800
Message-ID: <fc6abcd810a74bb4e8568b0f46bfc851fdcfd800.1607445161.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C0C557279579C781CBF29A7B5D208ABA8F1597C2BB9689007CBEA438C2709D8B2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MCU expects to set WLAN_CIPHER_SUITE_CCMP and WLAN_CIPHER_SUITE_AES_CMAC
at the same time, so adding an intermediate buffer for batch update.

Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 20 +++++++++++++------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  7 +++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6097653abda4..6f242d55dba3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1016,9 +1016,10 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 
 /** starec & wtbl **/
 static int
-mt7915_mcu_sta_key_tlv(struct sk_buff *skb, struct ieee80211_key_conf *key,
-		       enum set_key_cmd cmd)
+mt7915_mcu_sta_key_tlv(struct mt7915_sta *msta, struct sk_buff *skb,
+		       struct ieee80211_key_conf *key, enum set_key_cmd cmd)
 {
+	struct mt7915_sta_key_conf *bip = &msta->bip;
 	struct sta_rec_sec *sec;
 	struct tlv *tlv;
 	u32 len = sizeof(*sec);
@@ -1038,22 +1039,23 @@ mt7915_mcu_sta_key_tlv(struct sk_buff *skb, struct ieee80211_key_conf *key,
 
 		sec_key = &sec->key[0];
 		sec_key->cipher_len = sizeof(*sec_key);
-		sec_key->key_id = key->keyidx;
 
 		if (cipher == MT_CIPHER_BIP_CMAC_128) {
 			sec_key->cipher_id = MT_CIPHER_AES_CCMP;
+			sec_key->key_id = bip->keyidx;
 			sec_key->key_len = 16;
-			memcpy(sec_key->key, key->key, 16);
+			memcpy(sec_key->key, bip->key, 16);
 
 			sec_key = &sec->key[1];
 			sec_key->cipher_id = MT_CIPHER_BIP_CMAC_128;
 			sec_key->cipher_len = sizeof(*sec_key);
 			sec_key->key_len = 16;
-			memcpy(sec_key->key, key->key + 16, 16);
+			memcpy(sec_key->key, key->key, 16);
 
 			sec->n_cipher = 2;
 		} else {
 			sec_key->cipher_id = cipher;
+			sec_key->key_id = key->keyidx;
 			sec_key->key_len = key->keylen;
 			memcpy(sec_key->key, key->key, key->keylen);
 
@@ -1063,6 +1065,12 @@ mt7915_mcu_sta_key_tlv(struct sk_buff *skb, struct ieee80211_key_conf *key,
 				memcpy(sec_key->key + 24, key->key + 16, 8);
 			}
 
+			/* sotre key_conf for BIP batch update */
+			if (cipher == MT_CIPHER_AES_CCMP) {
+				memcpy(bip->key, key->key, key->keylen);
+				bip->keyidx = key->keyidx;
+			}
+
 			len -= sizeof(*sec_key);
 			sec->n_cipher = 1;
 		}
@@ -1088,7 +1096,7 @@ int mt7915_mcu_add_key(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	ret = mt7915_mcu_sta_key_tlv(skb, key, cmd);
+	ret = mt7915_mcu_sta_key_tlv(msta, skb, key, cmd);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 30e53a0f01fb..5bf76c74373f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -71,6 +71,11 @@ struct mt7915_sta_stats {
 	unsigned long jiffies;
 };
 
+struct mt7915_sta_key_conf {
+	s8 keyidx;
+	u8 key[16];
+};
+
 struct mt7915_sta {
 	struct mt76_wcid wcid; /* must be first */
 
@@ -84,6 +89,8 @@ struct mt7915_sta {
 	struct mt7915_sta_stats stats;
 
 	unsigned long ampdu_state;
+
+	struct mt7915_sta_key_conf bip;
 };
 
 struct mt7915_vif {
-- 
2.18.0

