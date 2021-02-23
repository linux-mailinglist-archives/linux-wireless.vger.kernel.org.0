Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932C6322BDE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 15:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhBWOCV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 09:02:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52590 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232671AbhBWOBZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 09:01:25 -0500
X-UUID: 71f617731a8b4e628233531c4dab162b-20210223
X-UUID: 71f617731a8b4e628233531c4dab162b-20210223
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 142299449; Tue, 23 Feb 2021 22:00:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Feb 2021 22:00:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Feb 2021 22:00:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix mib stats counter reporting to mac80211
Date:   Tue, 23 Feb 2021 22:00:36 +0800
Message-ID: <536a2749ead6b0d44560492aefccedf0606c31e5.1614088652.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to properly report MIB counters to mac80211, resets stats in
mt7915_get_stats routine() and hold mt76 mutex accessing MIB counters.
Sum up MIB counters in mt7915_mac_update_mib_stats routine.

Fixes: c6b002bcdfa6 ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 35 +++++++------------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  6 ++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 10 +++---
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b3168dd3baed..6b6ea33bd320 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1678,39 +1678,30 @@ mt7915_mac_update_mib_stats(struct mt7915_phy *phy)
 	bool ext_phy = phy != &dev->phy;
 	int i, aggr0, aggr1;
 
-	memset(mib, 0, sizeof(*mib));
-
-	mib->fcs_err_cnt = mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
-					  MT_MIB_SDR3_FCS_ERR_MASK);
+	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
+					   MT_MIB_SDR3_FCS_ERR_MASK);
 
 	aggr0 = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
-		u32 val, val2;
+		u32 val;
 
 		val = mt76_rr(dev, MT_MIB_MB_SDR1(ext_phy, i));
-
-		val2 = FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
-		if (val2 > mib->ack_fail_cnt)
-			mib->ack_fail_cnt = val2;
-
-		val2 = FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
-		if (val2 > mib->ba_miss_cnt)
-			mib->ba_miss_cnt = val2;
+		mib->ba_miss_cnt += FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
+		mib->ack_fail_cnt +=
+			FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
 
 		val = mt76_rr(dev, MT_MIB_MB_SDR0(ext_phy, i));
-		val2 = FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
-		if (val2 > mib->rts_retries_cnt) {
-			mib->rts_cnt = FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
-			mib->rts_retries_cnt = val2;
-		}
+		mib->rts_cnt += FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
+		mib->rts_retries_cnt +=
+			FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
 
 		val = mt76_rr(dev, MT_TX_AGG_CNT(ext_phy, i));
-		val2 = mt76_rr(dev, MT_TX_AGG_CNT2(ext_phy, i));
-
 		dev->mt76.aggr_stats[aggr0++] += val & 0xffff;
 		dev->mt76.aggr_stats[aggr0++] += val >> 16;
-		dev->mt76.aggr_stats[aggr1++] += val2 & 0xffff;
-		dev->mt76.aggr_stats[aggr1++] += val2 >> 16;
+
+		val = mt76_rr(dev, MT_TX_AGG_CNT2(ext_phy, i));
+		dev->mt76.aggr_stats[aggr1++] += val & 0xffff;
+		dev->mt76.aggr_stats[aggr1++] += val >> 16;
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 2406733f542d..cacc9b6933ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -717,13 +717,19 @@ mt7915_get_stats(struct ieee80211_hw *hw,
 		 struct ieee80211_low_level_stats *stats)
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mib_stats *mib = &phy->mib;
 
+	mutex_lock(&dev->mt76.mutex);
 	stats->dot11RTSSuccessCount = mib->rts_cnt;
 	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
 	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
 	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
 
+	memset(mib, 0, sizeof(*mib));
+
+	mutex_unlock(&dev->mt76.mutex);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 5c7eefdf2013..1160d1bf8a7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -108,11 +108,11 @@ struct mt7915_vif {
 };
 
 struct mib_stats {
-	u16 ack_fail_cnt;
-	u16 fcs_err_cnt;
-	u16 rts_cnt;
-	u16 rts_retries_cnt;
-	u16 ba_miss_cnt;
+	u32 ack_fail_cnt;
+	u32 fcs_err_cnt;
+	u32 rts_cnt;
+	u32 rts_retries_cnt;
+	u32 ba_miss_cnt;
 };
 
 struct mt7915_hif {
-- 
2.18.0

