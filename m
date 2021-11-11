Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D444DC49
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 20:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhKKTs1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 14:48:27 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44162 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229710AbhKKTs0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 14:48:26 -0500
X-UUID: dd39996186e64deab35f5291ed5187f2-20211112
X-UUID: dd39996186e64deab35f5291ed5187f2-20211112
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1803779097; Fri, 12 Nov 2021 03:45:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 12 Nov 2021 03:45:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Nov 2021 03:45:32 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Fang Zhao <fang.zhao@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: fix SMPS operation fail
Date:   Fri, 12 Nov 2021 03:45:31 +0800
Message-ID: <71786d2c0201ca3304fd67c4a3ba9adb6c32bd2d.1636658341.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TGn fails sending SM power save mode action frame to the AP to switch
from dynamic SMPS mode to static mode.

Reported-by: Fang Zhao <fang.zhao@mediatek.com>
Signed-off-by: Fang Zhao <fang.zhao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2 - move RATE_PARAM_MMPS_UPDATE operation into mt7915_mcu_add_smps
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 66 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 2 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 3a496046fe21..72fffce3f24d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1753,33 +1753,6 @@ int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
 				     true);
 }
 
-int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-			struct ieee80211_sta *sta)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct wtbl_req_hdr *wtbl_hdr;
-	struct tlv *sta_wtbl;
-	struct sk_buff *skb;
-
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
-				       MT7915_STA_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	sta_wtbl = mt7915_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
-
-	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
-					     &skb);
-	if (IS_ERR(wtbl_hdr))
-		return PTR_ERR(wtbl_hdr);
-
-	mt7915_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_hdr);
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(STA_REC_UPDATE), true);
-}
-
 static inline bool
 mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, bool bfee)
@@ -2077,7 +2050,11 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 	case RATE_PARAM_FIXED_MCS:
 	case RATE_PARAM_FIXED_GI:
 	case RATE_PARAM_FIXED_HE_LTF:
-		ra->phy = *phy;
+		if (phy)
+			ra->phy = *phy;
+		break;
+	case RATE_PARAM_MMPS_UPDATE:
+		ra->mmps_mode = (sta->smps_mode == IEEE80211_SMPS_DYNAMIC);
 		break;
 	default:
 		break;
@@ -2088,6 +2065,39 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
+int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct tlv *sta_wtbl;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7915_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	sta_wtbl = mt7915_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
+
+	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
+					     &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt7915_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_hdr);
+
+	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_EXT_CMD(STA_REC_UPDATE), true);
+	if (ret)
+		return ret;
+
+	return mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, NULL,
+					      RATE_PARAM_MMPS_UPDATE);
+}
+
 static int
 mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
 			       struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index e8501234f686..11728454b92c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -960,6 +960,7 @@ struct sta_rec_ra_fixed {
 
 enum {
 	RATE_PARAM_FIXED = 3,
+	RATE_PARAM_MMPS_UPDATE = 5,
 	RATE_PARAM_FIXED_HE_LTF = 7,
 	RATE_PARAM_FIXED_MCS,
 	RATE_PARAM_FIXED_GI = 11,
-- 
2.29.2

