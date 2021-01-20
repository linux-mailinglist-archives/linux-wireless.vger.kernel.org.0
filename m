Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35F32FD0E8
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 14:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733147AbhATM7J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jan 2021 07:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731843AbhATMML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jan 2021 07:12:11 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA8AC0613D6
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jan 2021 04:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fWfTrjDx7nnrxHjaig9y2YnjGwprp0wt/BtnbwpArqg=; b=PXsmRoOxk7L/F0j2m31q63bHNI
        6qkPsvrZUlKfYYE0qMhB2hMQfcoIkUzT40+zpB5It+/UTZWUHOb1o8DHWE31lAPF+tA5PM6XkiPj9
        CV8zRixjvI2EglnDUvVCu4YdeRFEQXPrXg+AQnK4fs9SRXvPsqGjFv5bwfLmXQeookKo=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l2CKe-0008Rx-OQ
        for linux-wireless@vger.kernel.org; Wed, 20 Jan 2021 13:11:28 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: move vif_mask back from mt76_phy to mt76_dev
Date:   Wed, 20 Jan 2021 13:11:24 +0100
Message-Id: <20210120121124.81306-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210120121124.81306-1-nbd@nbd.name>
References: <20210120121124.81306-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since it is global for all drivers, it belongs to the main device

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h         | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/main.c  | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/main.c  | 6 +++---
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 90fbdaec8b89..3e2191efc4f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -582,8 +582,6 @@ struct mt76_phy {
 
 	u8 macaddr[ETH_ALEN];
 
-	u32 vif_mask;
-
 	int txpower_cur;
 	u8 antenna_mask;
 	u16 chainmask;
@@ -641,6 +639,8 @@ struct mt76_dev {
 	u32 wcid_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
 	u32 wcid_phy_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
 
+	u32 vif_mask;
+
 	struct mt76_wcid global_wcid;
 	struct mt76_wcid __rcu *wcid[MT76_N_WCIDS];
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index d7e4bb29f5bb..8edea1e7a602 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -44,7 +44,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mvif->idx = ffs(~dev->mphy.vif_mask) - 1;
+	mvif->idx = ffs(~dev->mt76.vif_mask) - 1;
 	if (mvif->idx >= MT7603_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
@@ -65,7 +65,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	}
 
 	idx = MT7603_WTBL_RESERVED - 1 - mvif->idx;
-	dev->mphy.vif_mask |= BIT(mvif->idx);
+	dev->mt76.vif_mask |= BIT(mvif->idx);
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.hw_key_idx = -1;
@@ -105,7 +105,7 @@ mt7603_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	spin_unlock_bh(&dev->sta_poll_lock);
 
 	mutex_lock(&dev->mt76.mutex);
-	dev->mphy.vif_mask &= ~BIT(mvif->idx);
+	dev->mt76.vif_mask &= ~BIT(mvif->idx);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 3f6c752957b0..d655604b2993 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -187,7 +187,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	    is_zero_ether_addr(vif->addr))
 		phy->monitor_vif = vif;
 
-	mvif->idx = ffs(~dev->mphy.vif_mask) - 1;
+	mvif->idx = ffs(~dev->mt76.vif_mask) - 1;
 	if (mvif->idx >= MT7615_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
@@ -207,7 +207,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	else
 		mvif->wmm_idx = mvif->idx % MT7615_MAX_WMM_SETS;
 
-	dev->mphy.vif_mask |= BIT(mvif->idx);
+	dev->mt76.vif_mask |= BIT(mvif->idx);
 	dev->omac_mask |= BIT_ULL(mvif->omac_idx);
 	phy->omac_mask |= BIT_ULL(mvif->omac_idx);
 
@@ -263,7 +263,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	dev->mphy.vif_mask &= ~BIT(mvif->idx);
+	dev->mt76.vif_mask &= ~BIT(mvif->idx);
 	dev->omac_mask &= ~BIT_ULL(mvif->omac_idx);
 	phy->omac_mask &= ~BIT_ULL(mvif->omac_idx);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index e7e87311d355..e7a46ac97f51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -416,7 +416,7 @@ static void mt76x02_reset_state(struct mt76x02_dev *dev)
 		memset(msta, 0, sizeof(*msta));
 	}
 
-	dev->mphy.vif_mask = 0;
+	dev->mt76.vif_mask = 0;
 	dev->mt76.beacon_mask = 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 1852b6c9add6..ab671e21f882 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -304,7 +304,7 @@ mt76x02_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	unsigned int idx = 0;
 
 	/* Allow to change address in HW if we create first interface. */
-	if (!dev->mphy.vif_mask &&
+	if (!dev->mt76.vif_mask &&
 	    (((vif->addr[0] ^ dev->mphy.macaddr[0]) & ~GENMASK(4, 1)) ||
 	     memcmp(vif->addr + 1, dev->mphy.macaddr + 1, ETH_ALEN - 1)))
 		mt76x02_mac_setaddr(dev, vif->addr);
@@ -329,11 +329,11 @@ mt76x02_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 		idx += 8;
 
 	/* vif is already set or idx is 8 for AP/Mesh/... */
-	if (dev->mphy.vif_mask & BIT(idx) ||
+	if (dev->mt76.vif_mask & BIT(idx) ||
 	    (vif->type != NL80211_IFTYPE_STATION && idx > 7))
 		return -EBUSY;
 
-	dev->mphy.vif_mask |= BIT(idx);
+	dev->mt76.vif_mask |= BIT(idx);
 
 	mt76x02_vif_init(dev, vif, idx);
 	return 0;
@@ -346,7 +346,7 @@ void mt76x02_remove_interface(struct ieee80211_hw *hw,
 	struct mt76x02_dev *dev = hw->priv;
 	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 
-	dev->mphy.vif_mask &= ~BIT(mvif->idx);
+	dev->mt76.vif_mask &= ~BIT(mvif->idx);
 }
 EXPORT_SYMBOL_GPL(mt76x02_remove_interface);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index a38f52c87977..6666e94aa936 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -161,7 +161,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	    is_zero_ether_addr(vif->addr))
 		phy->monitor_vif = vif;
 
-	mvif->idx = ffs(~dev->mphy.vif_mask) - 1;
+	mvif->idx = ffs(~dev->mt76.vif_mask) - 1;
 	if (mvif->idx >= MT7915_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
@@ -186,7 +186,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		goto out;
 
-	dev->mphy.vif_mask |= BIT(mvif->idx);
+	dev->mt76.vif_mask |= BIT(mvif->idx);
 	phy->omac_mask |= BIT_ULL(mvif->omac_idx);
 
 	idx = MT7915_WTBL_RESERVED - mvif->idx -
@@ -242,7 +242,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
 	mutex_lock(&dev->mt76.mutex);
-	dev->mphy.vif_mask &= ~BIT(mvif->idx);
+	dev->mt76.vif_mask &= ~BIT(mvif->idx);
 	phy->omac_mask &= ~BIT_ULL(mvif->omac_idx);
 	mutex_unlock(&dev->mt76.mutex);
 
-- 
2.28.0

