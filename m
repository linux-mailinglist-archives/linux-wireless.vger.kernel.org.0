Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7832041B0
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 22:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgFVUNl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 16:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgFVUNk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 16:13:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F48C061797
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=J2gao2Rv7Wizjgxh8K11dV02glWeP07KyVpcU5YWxho=; b=ee3t1wexGs73bVpn/Py6TPMBNJ
        Q6iB7vbwX/imkqqksXzVjxaD+gfAuD2rT+J/rKHvLyGaybfjyvD7d7mntdNmB9C5XsBfSmhd01Q6Z
        tAI0raqP7Bc8TEus1ea0BqWeNVbBPG8aSBJ+A8g+/1DxWacbH6i78u2dvG9dj/Km0KV8=;
Received: from p54ae948c.dip0.t-ipconnect.de ([84.174.148.140] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jnSp0-0000qE-DZ
        for linux-wireless@vger.kernel.org; Mon, 22 Jun 2020 22:13:38 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/7] mt76: vif_mask to struct mt76_phy
Date:   Mon, 22 Jun 2020 22:13:25 +0200
Message-Id: <20200622201327.94414-5-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200622201327.94414-1-nbd@nbd.name>
References: <20200622201327.94414-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All drivers use this in pretty much the same way. Moving it to core helps with
some checks for the upcoming testmode support

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h          | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h | 2 --
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x02.h       | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 1 -
 10 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3d7db6ffb599..ece462e9c9ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -491,6 +491,8 @@ struct mt76_phy {
 	struct mt76_sband sband_2g;
 	struct mt76_sband sband_5g;
 
+	u32 vif_mask;
+
 	int txpower_cur;
 	u8 antenna_mask;
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 83dfa6da4761..447f2c63ef38 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -44,7 +44,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mvif->idx = ffs(~dev->vif_mask) - 1;
+	mvif->idx = ffs(~dev->mphy.vif_mask) - 1;
 	if (mvif->idx >= MT7603_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
@@ -65,7 +65,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	}
 
 	idx = MT7603_WTBL_RESERVED - 1 - mvif->idx;
-	dev->vif_mask |= BIT(mvif->idx);
+	dev->mphy.vif_mask |= BIT(mvif->idx);
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.hw_key_idx = -1;
@@ -107,7 +107,7 @@ mt7603_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	spin_unlock_bh(&dev->sta_poll_lock);
 
 	mutex_lock(&dev->mt76.mutex);
-	dev->vif_mask &= ~BIT(mvif->idx);
+	dev->mphy.vif_mask &= ~BIT(mvif->idx);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 7fadf094e9be..c86305241e66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -108,8 +108,6 @@ struct mt7603_dev {
 
 	u32 rxfilter;
 
-	u8 vif_mask;
-
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index f8ce485c8d19..abb9853eaa8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -137,7 +137,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mvif->idx = ffs(~dev->vif_mask) - 1;
+	mvif->idx = ffs(~dev->mphy.vif_mask) - 1;
 	if (mvif->idx >= MT7615_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
@@ -157,7 +157,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	else
 		mvif->wmm_idx = mvif->idx % MT7615_MAX_WMM_SETS;
 
-	dev->vif_mask |= BIT(mvif->idx);
+	dev->mphy.vif_mask |= BIT(mvif->idx);
 	dev->omac_mask |= BIT(mvif->omac_idx);
 	phy->omac_mask |= BIT(mvif->omac_idx);
 
@@ -204,7 +204,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 		mt76_txq_remove(&dev->mt76, vif->txq);
 
 	mutex_lock(&dev->mt76.mutex);
-	dev->vif_mask &= ~BIT(mvif->idx);
+	dev->mphy.vif_mask &= ~BIT(mvif->idx);
 	dev->omac_mask &= ~BIT(mvif->omac_idx);
 	phy->omac_mask &= ~BIT(mvif->omac_idx);
 	mutex_unlock(&dev->mt76.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 6e423f45b63f..af86cf6925dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -244,7 +244,6 @@ struct mt7615_dev {
 	struct tasklet_struct irq_tasklet;
 
 	struct mt7615_phy phy;
-	u32 vif_mask;
 	u32 omac_mask;
 
 	u16 chainmask;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index 4c9bbc7ce023..4660b9691ec3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -80,7 +80,6 @@ struct mt76x02_dev {
 
 	struct mutex phy_mutex;
 
-	u16 vif_mask;
 	u16 chainmask;
 
 	u8 txdone_seq;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index cbbe986655fe..99611515a093 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -439,7 +439,7 @@ static void mt76x02_reset_state(struct mt76x02_dev *dev)
 		memset(msta, 0, sizeof(*msta));
 	}
 
-	dev->vif_mask = 0;
+	dev->mphy.vif_mask = 0;
 	dev->mt76.beacon_mask = 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 44822a849eb1..dbd4077ea283 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -305,7 +305,7 @@ mt76x02_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	unsigned int idx = 0;
 
 	/* Allow to change address in HW if we create first interface. */
-	if (!dev->vif_mask &&
+	if (!dev->mphy.vif_mask &&
 	    (((vif->addr[0] ^ dev->mt76.macaddr[0]) & ~GENMASK(4, 1)) ||
 	     memcmp(vif->addr + 1, dev->mt76.macaddr + 1, ETH_ALEN - 1)))
 		mt76x02_mac_setaddr(dev, vif->addr);
@@ -330,11 +330,11 @@ mt76x02_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 		idx += 8;
 
 	/* vif is already set or idx is 8 for AP/Mesh/... */
-	if (dev->vif_mask & BIT(idx) ||
+	if (dev->mphy.vif_mask & BIT(idx) ||
 	    (vif->type != NL80211_IFTYPE_STATION && idx > 7))
 		return -EBUSY;
 
-	dev->vif_mask |= BIT(idx);
+	dev->mphy.vif_mask |= BIT(idx);
 
 	mt76x02_vif_init(dev, vif, idx);
 	return 0;
@@ -348,7 +348,7 @@ void mt76x02_remove_interface(struct ieee80211_hw *hw,
 	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 
 	mt76_txq_remove(&dev->mt76, vif->txq);
-	dev->vif_mask &= ~BIT(mvif->idx);
+	dev->mphy.vif_mask &= ~BIT(mvif->idx);
 }
 EXPORT_SYMBOL_GPL(mt76x02_remove_interface);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index d0af025d2db9..889f5f93ce30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -125,7 +125,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mvif->idx = ffs(~phy->vif_mask) - 1;
+	mvif->idx = ffs(~phy->mt76->vif_mask) - 1;
 	if (mvif->idx >= MT7915_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
@@ -150,7 +150,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		goto out;
 
-	phy->vif_mask |= BIT(mvif->idx);
+	phy->mt76->vif_mask |= BIT(mvif->idx);
 	phy->omac_mask |= BIT(mvif->omac_idx);
 
 	idx = MT7915_WTBL_RESERVED - mvif->idx;
@@ -194,7 +194,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 		mt76_txq_remove(&dev->mt76, vif->txq);
 
 	mutex_lock(&dev->mt76.mutex);
-	phy->vif_mask &= ~BIT(mvif->idx);
+	phy->mt76->vif_mask &= ~BIT(mvif->idx);
 	phy->omac_mask &= ~BIT(mvif->omac_idx);
 	mutex_unlock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 6d038deee0ea..3eaf5e64b0b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -116,7 +116,6 @@ struct mt7915_phy {
 	struct ieee80211_sband_iftype_data iftype[2][NUM_NL80211_IFTYPES];
 
 	u32 rxfilter;
-	u32 vif_mask;
 	u32 omac_mask;
 
 	u16 noise;
-- 
2.24.0

