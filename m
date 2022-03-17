Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BEE4DC0E6
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 09:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiCQIXW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 04:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiCQIXV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 04:23:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D89F1C64A3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 01:22:04 -0700 (PDT)
X-UUID: 9ae37de569334bdbbf6ec96aecf9978e-20220317
X-UUID: 9ae37de569334bdbbf6ec96aecf9978e-20220317
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <evelyn.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1535954546; Thu, 17 Mar 2022 16:21:58 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Mar 2022 16:21:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Mar
 2022 16:21:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 16:21:57 +0800
From:   Evelyn Tsai <evelyn.tsai@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>
Subject: [PATCH v2] mt76: fix MBSS index condition in DBDC mode
Date:   Thu, 17 Mar 2022 16:21:50 +0800
Message-ID: <20220317082150.20280-1-evelyn.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT7915_MAX_INTERFACES is per-band declaration in MT7915/MT7986/MT7916.
Enlarge vif_mask to 64 bits wide, including the bit operation.

Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
---
v2: fix bitops for u64 and update commit message

This patch is based on https://patchwork.kernel.org/project/linux-wireless/patch/20220309140249.10285-1-evelyn.tsai@mediatek.com/
---
 drivers/net/wireless/mediatek/mt76/mt76.h         | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c  | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c  | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7921/main.c  | 6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 882fb5d2517f..71bcee3a8d59 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -727,7 +727,7 @@ struct mt76_dev {
 	u32 wcid_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
 	u32 wcid_phy_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
 
-	u32 vif_mask;
+	u64 vif_mask;
 
 	struct mt76_wcid global_wcid;
 	struct mt76_wcid __rcu *wcid[MT76_N_WCIDS];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 83c5eec5b163..86ddab140207 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -44,7 +44,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mvif->idx = ffs(~dev->mt76.vif_mask) - 1;
+	mvif->idx = __ffs64(~dev->mt76.vif_mask);
 	if (mvif->idx >= MT7603_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
@@ -65,7 +65,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	}
 
 	idx = MT7603_WTBL_RESERVED - 1 - mvif->idx;
-	dev->mt76.vif_mask |= BIT(mvif->idx);
+	dev->mt76.vif_mask |= BIT_ULL(mvif->idx);
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.hw_key_idx = -1;
@@ -106,7 +106,7 @@ mt7603_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	spin_unlock_bh(&dev->sta_poll_lock);
 
 	mutex_lock(&dev->mt76.mutex);
-	dev->mt76.vif_mask &= ~BIT(mvif->idx);
+	dev->mt76.vif_mask &= ~BIT_ULL(mvif->idx);
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76_packet_id_flush(&dev->mt76, &mvif->sta.wcid);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index d79cbdbd5a05..1fd88a0f03a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -194,7 +194,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	    is_zero_ether_addr(vif->addr))
 		phy->monitor_vif = vif;
 
-	mvif->mt76.idx = ffs(~dev->mt76.vif_mask) - 1;
+	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
 	if (mvif->mt76.idx >= MT7615_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
@@ -212,7 +212,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	if (ext_phy)
 		mvif->mt76.wmm_idx += 2;
 
-	dev->mt76.vif_mask |= BIT(mvif->mt76.idx);
+	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
 	dev->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
@@ -268,7 +268,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	dev->mt76.vif_mask &= ~BIT(mvif->mt76.idx);
+	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
 	dev->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
 	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index dd30f537676d..32f1fe3e1d15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -327,11 +327,11 @@ mt76x02_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 		idx += 8;
 
 	/* vif is already set or idx is 8 for AP/Mesh/... */
-	if (dev->mt76.vif_mask & BIT(idx) ||
+	if (dev->mt76.vif_mask & BIT_ULL(idx) ||
 	    (vif->type != NL80211_IFTYPE_STATION && idx > 7))
 		return -EBUSY;
 
-	dev->mt76.vif_mask |= BIT(idx);
+	dev->mt76.vif_mask |= BIT_ULL(idx);
 
 	mt76x02_vif_init(dev, vif, idx);
 	return 0;
@@ -344,7 +344,7 @@ void mt76x02_remove_interface(struct ieee80211_hw *hw,
 	struct mt76x02_dev *dev = hw->priv;
 	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 
-	dev->mt76.vif_mask &= ~BIT(mvif->idx);
+	dev->mt76.vif_mask &= ~BIT_ULL(mvif->idx);
 	mt76_packet_id_flush(&dev->mt76, &mvif->group_wcid);
 }
 EXPORT_SYMBOL_GPL(mt76x02_remove_interface);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index c3f44d801e7f..edfb5428796a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -204,8 +204,8 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	    is_zero_ether_addr(vif->addr))
 		phy->monitor_vif = vif;
 
-	mvif->mt76.idx = ffs(~dev->mt76.vif_mask) - 1;
-	if (mvif->mt76.idx >= MT7915_MAX_INTERFACES) {
+	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
+	if (mvif->mt76.idx >= (MT7915_MAX_INTERFACES << dev->dbdc_support)) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -227,7 +227,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		goto out;
 
-	dev->mt76.vif_mask |= BIT(mvif->mt76.idx);
+	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
 	idx = MT7915_WTBL_RESERVED - mvif->mt76.idx;
@@ -290,7 +290,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
 	mutex_lock(&dev->mt76.mutex);
-	dev->mt76.vif_mask &= ~BIT(mvif->mt76.idx);
+	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
 	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
 	mutex_unlock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3a16a966d9d3..e383168ba124 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -294,7 +294,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 
 	mt7921_mutex_acquire(dev);
 
-	mvif->mt76.idx = ffs(~dev->mt76.vif_mask) - 1;
+	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
 	if (mvif->mt76.idx >= MT7921_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
@@ -310,7 +310,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		goto out;
 
-	dev->mt76.vif_mask |= BIT(mvif->mt76.idx);
+	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
 	idx = MT7921_WTBL_RESERVED - mvif->mt76.idx;
@@ -354,7 +354,7 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	dev->mt76.vif_mask &= ~BIT(mvif->mt76.idx);
+	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
 	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
 	mt7921_mutex_release(dev);
 
-- 
2.18.0

