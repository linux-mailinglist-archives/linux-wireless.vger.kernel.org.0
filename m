Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F5149C2D2
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 05:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiAZEuz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jan 2022 23:50:55 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:34900 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235383AbiAZEux (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jan 2022 23:50:53 -0500
X-UUID: 3696be57b7984cd0ac608b2dbc8fc246-20220126
X-UUID: 3696be57b7984cd0ac608b2dbc8fc246-20220126
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1300246445; Wed, 26 Jan 2022 12:50:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 26 Jan 2022 12:50:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 12:50:44 +0800
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: update max_mpdu_size in mt7915_mcu_sta_amsdu_tlv()
Date:   Wed, 26 Jan 2022 12:50:34 +0800
Message-ID: <20220126045034.13400-1-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The maximum max_mpdu_size of mt7915 is 7991, whereas mt7916 can
support 11454.

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
v2:
update commit message
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 66f8daf3168c..8086af34a701 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -986,8 +986,8 @@ mt7915_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 }
 
 static void
-mt7915_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta)
+mt7915_mcu_sta_amsdu_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
+			 struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct sta_rec_amsdu *amsdu;
@@ -1004,9 +1004,24 @@ mt7915_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	amsdu = (struct sta_rec_amsdu *)tlv;
 	amsdu->max_amsdu_num = 8;
 	amsdu->amsdu_en = true;
-	amsdu->max_mpdu_size = sta->max_amsdu_len >=
-			       IEEE80211_MAX_MPDU_LEN_VHT_7991;
 	msta->wcid.amsdu = true;
+
+	switch (sta->max_amsdu_len) {
+	case IEEE80211_MAX_MPDU_LEN_VHT_11454:
+		if (!is_mt7915(&dev->mt76)) {
+			amsdu->max_mpdu_size =
+				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
+			return;
+		}
+		fallthrough;
+	case IEEE80211_MAX_MPDU_LEN_HT_7935:
+	case IEEE80211_MAX_MPDU_LEN_VHT_7991:
+		amsdu->max_mpdu_size = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991;
+		return;
+	default:
+		amsdu->max_mpdu_size = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895;
+		return;
+	}
 }
 
 static int
@@ -1686,7 +1701,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 	if (sta && sta->ht_cap.ht_supported) {
 		/* starec amsdu */
-		mt7915_mcu_sta_amsdu_tlv(skb, vif, sta);
+		mt7915_mcu_sta_amsdu_tlv(dev, skb, vif, sta);
 		/* starec he */
 		mt7915_mcu_sta_he_tlv(skb, sta, vif);
 		/* starec muru */
-- 
2.29.2

