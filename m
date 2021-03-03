Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B311032C11B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbhCCVQw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:16:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:47279 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234085AbhCCKwg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 05:52:36 -0500
X-UUID: b637ef33057a47d1a6096b71a48714d4-20210303
X-UUID: b637ef33057a47d1a6096b71a48714d4-20210303
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1580396949; Wed, 03 Mar 2021 18:38:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Mar 2021 18:38:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Mar 2021 18:38:04 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/4] mt76: mt7915: fix txrate reporting
Date:   Wed, 3 Mar 2021 18:38:00 +0800
Message-ID: <a64485b9e1cfb90b9514977f26b83b76236eafe2.1614753100.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <a379bb8534b2b8c24e30313b97aa8cfdf79c315b.1614753100.git.ryder.lee@mediatek.com>
References: <a379bb8534b2b8c24e30313b97aa8cfdf79c315b.1614753100.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Properly check rate_info to fix unexpected reporting.

[ 1215.161863] Call trace:
[ 1215.164307]  cfg80211_calculate_bitrate+0x124/0x200 [cfg80211]
[ 1215.170139]  ieee80211s_update_metric+0x80/0xc0 [mac80211]
[ 1215.175624]  ieee80211_tx_status_ext+0x508/0x838 [mac80211]
[ 1215.181190]  mt7915_mcu_get_rx_rate+0x28c/0x8d0 [mt7915e]
[ 1215.186580]  mt7915_mac_tx_free+0x324/0x7c0 [mt7915e]
[ 1215.191623]  mt7915_queue_rx_skb+0xa8/0xd0 [mt7915e]
[ 1215.196582]  mt76_dma_cleanup+0x7b0/0x11d0 [mt76]
[ 1215.201276]  __napi_poll+0x38/0xf8
[ 1215.204668]  napi_workfn+0x40/0x80
[ 1215.208062]  process_one_work+0x1fc/0x390
[ 1215.212062]  worker_thread+0x48/0x4d0
[ 1215.215715]  kthread+0x120/0x128
[ 1215.218935]  ret_from_fork+0x10/0x1c

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Fixes: e4c5ead632ff ("mt76: mt7915: rename mt7915_mcu_get_rate_info to mt7915_mcu_get_tx_rate")
Reported-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 38 ++++++++++++-------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b204c5dd7914..edb58f6f2640 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -364,54 +364,62 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 	dev->hw_pattern++;
 }
 
-static void
+static int
 mt7915_mcu_tx_rate_parse(struct mt76_phy *mphy, struct mt7915_mcu_ra_info *ra,
 			 struct rate_info *rate, u16 r)
 {
 	struct ieee80211_supported_band *sband;
 	u16 ru_idx = le16_to_cpu(ra->ru_idx);
-	u16 flags = 0;
+	bool cck = false;
 
 	rate->mcs = FIELD_GET(MT_RA_RATE_MCS, r);
 	rate->nss = FIELD_GET(MT_RA_RATE_NSS, r) + 1;
 
 	switch (FIELD_GET(MT_RA_RATE_TX_MODE, r)) {
 	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
 	case MT_PHY_TYPE_OFDM:
 		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
 			sband = &mphy->sband_5g.sband;
 		else
 			sband = &mphy->sband_2g.sband;
 
+		rate->mcs = mt76_get_rate(mphy->dev, sband, rate->mcs, cck);
 		rate->legacy = sband->bitrates[rate->mcs].bitrate;
 		break;
 	case MT_PHY_TYPE_HT:
 	case MT_PHY_TYPE_HT_GF:
 		rate->mcs += (rate->nss - 1) * 8;
-		flags |= RATE_INFO_FLAGS_MCS;
+		if (rate->mcs > 31)
+			return -EINVAL;
 
+		rate->flags = RATE_INFO_FLAGS_MCS;
 		if (ra->gi)
-			flags |= RATE_INFO_FLAGS_SHORT_GI;
+			rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case MT_PHY_TYPE_VHT:
-		flags |= RATE_INFO_FLAGS_VHT_MCS;
+		if (rate->mcs > 9)
+			return -EINVAL;
 
+		rate->flags = RATE_INFO_FLAGS_VHT_MCS;
 		if (ra->gi)
-			flags |= RATE_INFO_FLAGS_SHORT_GI;
+			rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case MT_PHY_TYPE_HE_SU:
 	case MT_PHY_TYPE_HE_EXT_SU:
 	case MT_PHY_TYPE_HE_TB:
 	case MT_PHY_TYPE_HE_MU:
+		if (ra->gi > NL80211_RATE_INFO_HE_GI_3_2 || rate->mcs > 11)
+			return -EINVAL;
+
 		rate->he_gi = ra->gi;
 		rate->he_dcm = FIELD_GET(MT_RA_RATE_DCM_EN, r);
-
-		flags |= RATE_INFO_FLAGS_HE_MCS;
+		rate->flags = RATE_INFO_FLAGS_HE_MCS;
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
-	rate->flags = flags;
 
 	if (ru_idx) {
 		switch (ru_idx) {
@@ -448,6 +456,8 @@ mt7915_mcu_tx_rate_parse(struct mt76_phy *mphy, struct mt7915_mcu_ra_info *ra,
 			break;
 		}
 	}
+
+	return 0;
 }
 
 static void
@@ -478,12 +488,12 @@ mt7915_mcu_tx_rate_report(struct mt7915_dev *dev, struct sk_buff *skb)
 		mphy = dev->mt76.phy2;
 
 	/* current rate */
-	mt7915_mcu_tx_rate_parse(mphy, ra, &rate, curr);
-	stats->tx_rate = rate;
+	if(!mt7915_mcu_tx_rate_parse(mphy, ra, &rate, curr))
+		stats->tx_rate = rate;
 
 	/* probing rate */
-	mt7915_mcu_tx_rate_parse(mphy, ra, &prob_rate, probe);
-	stats->prob_rate = prob_rate;
+	if(!mt7915_mcu_tx_rate_parse(mphy, ra, &prob_rate, probe))
+		stats->prob_rate = prob_rate;
 
 	if (attempts) {
 		u16 success = le16_to_cpu(ra->success);
-- 
2.18.0

