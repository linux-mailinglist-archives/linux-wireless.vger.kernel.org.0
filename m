Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4F032C117
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbhCCVQu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:16:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47167 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234106AbhCCKwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 05:52:34 -0500
X-UUID: 007660557151438fb654858e47d4244e-20210303
X-UUID: 007660557151438fb654858e47d4244e-20210303
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 138093793; Wed, 03 Mar 2021 18:38:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Mar 2021 18:38:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Mar 2021 18:38:03 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/4] mt76: mt7915: fix rxrate reporting
Date:   Wed, 3 Mar 2021 18:37:59 +0800
Message-ID: <a379bb8534b2b8c24e30313b97aa8cfdf79c315b.1614753100.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 43E5F3BEE6F3F98E75647AB33B32E3F3AE7269CA5AC11EC62DD68CEED2F3F8FE2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid directly updating sinfo->rxrate from firmware since rate_info might
be overwritten by wrong results even mt7915_mcu_get_rx_rate() fails check.

Add more error handlings accordingly.

Fixes: 11553d88d0b9 ("mt76: mt7915: query station rx rate from firmware")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 47 ++++++++++---------
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index cacc9b6933ca..bb49ea9307e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -839,9 +839,12 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct mt7915_sta_stats *stats = &msta->stats;
+	struct rate_info rxrate = {};
 
-	if (mt7915_mcu_get_rx_rate(phy, vif, sta, &sinfo->rxrate) == 0)
+	if (!mt7915_mcu_get_rx_rate(phy, vif, sta, &rxrate)) {
+		sinfo->rxrate = rxrate;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+	}
 
 	if (!stats->tx_rate.legacy && !stats->tx_rate.flags)
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index e0c03b7f278d..b204c5dd7914 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3552,9 +3552,8 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 	struct ieee80211_supported_band *sband;
 	struct mt7915_mcu_phy_rx_info *res;
 	struct sk_buff *skb;
-	u16 flags = 0;
 	int ret;
-	int i;
+	bool cck = false;
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD(PHY_STAT_INFO),
 					&req, sizeof(req), true, &skb);
@@ -3568,48 +3567,53 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 
 	switch (res->mode) {
 	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
 	case MT_PHY_TYPE_OFDM:
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
 			sband = &mphy->sband_5g.sband;
 		else
 			sband = &mphy->sband_2g.sband;
 
-		for (i = 0; i < sband->n_bitrates; i++) {
-			if (rate->mcs != (sband->bitrates[i].hw_value & 0xf))
-				continue;
-
-			rate->legacy = sband->bitrates[i].bitrate;
-			break;
-		}
+		rate->mcs = mt76_get_rate(&dev->mt76, sband, rate->mcs, cck);
+		rate->legacy = sband->bitrates[rate->mcs].bitrate;
 		break;
 	case MT_PHY_TYPE_HT:
 	case MT_PHY_TYPE_HT_GF:
-		if (rate->mcs > 31)
-			return -EINVAL;
-
-		flags |= RATE_INFO_FLAGS_MCS;
+		if (rate->mcs > 31) {
+			ret = -EINVAL;
+			goto out;
+		}
 
+		rate->flags = RATE_INFO_FLAGS_MCS;
 		if (res->gi)
-			flags |= RATE_INFO_FLAGS_SHORT_GI;
+			rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case MT_PHY_TYPE_VHT:
-		flags |= RATE_INFO_FLAGS_VHT_MCS;
+		if (rate->mcs > 9) {
+			ret = -EINVAL;
+			goto out;
+		}
 
+		rate->flags = RATE_INFO_FLAGS_VHT_MCS;
 		if (res->gi)
-			flags |= RATE_INFO_FLAGS_SHORT_GI;
+			rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case MT_PHY_TYPE_HE_SU:
 	case MT_PHY_TYPE_HE_EXT_SU:
 	case MT_PHY_TYPE_HE_TB:
 	case MT_PHY_TYPE_HE_MU:
+		if (res->gi > NL80211_RATE_INFO_HE_GI_3_2 || rate->mcs > 11) {
+			ret = -EINVAL;
+			goto out;
+		}
 		rate->he_gi = res->gi;
-
-		flags |= RATE_INFO_FLAGS_HE_MCS;
+		rate->flags = RATE_INFO_FLAGS_HE_MCS;
 		break;
 	default:
-		break;
+		ret = -EINVAL;
+		goto out;
 	}
-	rate->flags = flags;
 
 	switch (res->bw) {
 	case IEEE80211_STA_RX_BW_160:
@@ -3626,7 +3630,8 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		break;
 	}
 
+out:
 	dev_kfree_skb(skb);
 
-	return 0;
+	return ret;
 }
-- 
2.18.0

