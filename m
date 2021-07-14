Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1411C3C8158
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 11:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhGNJVt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 05:21:49 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44846 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238189AbhGNJVr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 05:21:47 -0400
X-UUID: 4acdac72081246e1ac85ae3f3386b137-20210714
X-UUID: 4acdac72081246e1ac85ae3f3386b137-20210714
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1332684793; Wed, 14 Jul 2021 17:18:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Jul 2021 17:18:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 17:18:53 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 4/4] mt76: mt7915: remove mt7915_sta_stats
Date:   Wed, 14 Jul 2021 17:18:51 +0800
Message-ID: <017ded88cbff92fda442fff721ab3c17e82e5690.1626253921.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <50730853fe09fb75418484770a0c95c23b44deb5.1626253920.git.ryder.lee@mediatek.com>
References: <50730853fe09fb75418484770a0c95c23b44deb5.1626253920.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7915_sta_stats is no longer needed after tx rate reworking.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 9 ++-------
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6de79d646ca1..45a8614c5343 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1058,9 +1058,9 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 		msta = (struct mt7915_sta *)sta->drv_priv;
 
-		if (time_after(jiffies, msta->stats.jiffies + HZ / 4)) {
+		if (time_after(jiffies, msta->jiffies + HZ / 4)) {
 			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-			msta->stats.jiffies = jiffies;
+			msta->jiffies = jiffies;
 		}
 	}
 
@@ -1868,8 +1868,8 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
 	while (!list_empty(&list)) {
 		msta = list_first_entry(&list, struct mt7915_sta, rc_list);
 		list_del_init(&msta->rc_list);
-		changed = msta->stats.changed;
-		msta->stats.changed = 0;
+		changed = msta->changed;
+		msta->changed = 0;
 		spin_unlock_bh(&dev->sta_poll_lock);
 
 		sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 953d5caae5c2..825cb44c9107 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -623,7 +623,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.idx = idx;
 	msta->wcid.ext_phy = mvif->band_idx;
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	msta->stats.jiffies = jiffies;
+	msta->jiffies = jiffies;
 
 	mt7915_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -955,7 +955,7 @@ static void mt7915_sta_rc_work(void *data, struct ieee80211_sta *sta)
 	u32 *changed = data;
 
 	spin_lock_bh(&dev->sta_poll_lock);
-	msta->stats.changed |= *changed;
+	msta->changed |= *changed;
 	if (list_empty(&msta->rc_list))
 		list_add_tail(&msta->rc_list, &dev->sta_rc_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index a9c36b515aa6..33be449309e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -64,11 +64,6 @@ enum mt7915_rxq_id {
 	MT7915_RXQ_MCU_WA_EXT,
 };
 
-struct mt7915_sta_stats {
-	unsigned long changed;
-	unsigned long jiffies;
-};
-
 struct mt7915_sta_key_conf {
 	s8 keyidx;
 	u8 key[16];
@@ -83,8 +78,8 @@ struct mt7915_sta {
 	struct list_head rc_list;
 	u32 airtime_ac[8];
 
-	struct mt7915_sta_stats stats;
-
+	unsigned long changed;
+	unsigned long jiffies;
 	unsigned long ampdu_state;
 
 	struct mt7915_sta_key_conf bip;
-- 
2.29.2

