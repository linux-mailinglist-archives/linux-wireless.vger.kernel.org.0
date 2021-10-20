Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC184354D5
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 22:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhJTVAR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 17:00:17 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:39778 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230020AbhJTVAR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 17:00:17 -0400
X-UUID: c0a10afce2aa4203a96df76fda67dac7-20211021
X-UUID: c0a10afce2aa4203a96df76fda67dac7-20211021
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1228912606; Thu, 21 Oct 2021 04:57:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 21 Oct 2021 04:57:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Oct 2021 04:57:58 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH v4 1/3] mt76: mt7915: remove mt7915_mcu_add_he()
Date:   Thu, 21 Oct 2021 04:57:54 +0800
Message-ID: <142086982cd0a7d701e1b6d8891865113d019349.1634755281.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make mt7915_mcu_sta_he_tlv() as a part of mt7915_mcu_add_rate_ctrl() as
firmware rate control should get HE rate information from sta_rec_he,
and reduce a global function accordingly.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v4 - rebase.
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  6 ++--
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 36 ++++++-------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +--
 4 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 21e6ef07814c..6fc12e45a012 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2077,10 +2077,8 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
 
 		if (changed & (IEEE80211_RC_SUPP_RATES_CHANGED |
 			       IEEE80211_RC_NSS_CHANGED |
-			       IEEE80211_RC_BW_CHANGED)) {
-			mt7915_mcu_add_he(dev, vif, sta);
-			mt7915_mcu_add_rate_ctrl(dev, vif, sta);
-		}
+			       IEEE80211_RC_BW_CHANGED))
+			mt7915_mcu_add_rate_ctrl(dev, vif, sta, true);
 
 		if (changed & IEEE80211_RC_SMPS_CHANGED)
 			mt7915_mcu_add_smps(dev, vif, sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 8be78917dee9..ca44f68c5434 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -663,7 +663,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	return mt7915_mcu_add_rate_ctrl(dev, vif, sta);
+	return mt7915_mcu_add_rate_ctrl(dev, vif, sta, false);
 }
 
 void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b4cc4cb35762..27b741e38920 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2149,41 +2149,25 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 }
 
 int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta)
+			     struct ieee80211_sta *sta, bool changed)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct sk_buff *skb;
-	int len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_ra);
 
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
+	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7915_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt7915_mcu_sta_rate_ctrl_tlv(skb, dev, vif, sta);
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(STA_REC_UPDATE), true);
-}
-
-int mt7915_mcu_add_he(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		      struct ieee80211_sta *sta)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct sk_buff *skb;
-	int len;
-
-	if (!sta->he_cap.has_he)
-		return 0;
-
-	len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_he);
-
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
+	/* firmware rc algorithm refers to sta_rec_he for HE control.
+	 * once dev->rc_work changes the settings driver should also
+	 * update sta_rec_he here.
+	 */
+	if (sta->he_cap.has_he && changed)
+		mt7915_mcu_sta_he_tlv(skb, sta, vif);
 
-	mt7915_mcu_sta_he_tlv(skb, sta, vif);
+	mt7915_mcu_sta_rate_ctrl_tlv(skb, dev, vif, sta);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index fff15f6b9cad..79a33afc5920 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -409,9 +409,7 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
                             bool enable);
 int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-			     struct ieee80211_sta *sta);
-int mt7915_mcu_add_he(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		      struct ieee80211_sta *sta);
+			     struct ieee80211_sta *sta, bool changed);
 int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta);
 int mt7915_set_channel(struct mt7915_phy *phy);
-- 
2.29.2

