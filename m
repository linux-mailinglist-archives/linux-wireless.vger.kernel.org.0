Return-Path: <linux-wireless+bounces-19207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E8A3DB23
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1A61793A2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490D88F6D;
	Thu, 20 Feb 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLogvY8l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506D1F5612
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057571; cv=none; b=ryKNQEAbGOTPCCwB8uHq67tGrEusX3LRUlKmcROK16V0REYW9ND752sEO3NzlbxN18nxIxT1R++JT/svcxtHR7nMLy+92IlxM4n49dQ1XFvP5LStjfKeRdeiYZkb5Jlq+lEFMf56CjI8l/j26m9wHk0LwijQ83uuoVJXGk56UJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057571; c=relaxed/simple;
	bh=N6ZDwvGT0PB/a7T/e4Is6asa8QfefM7wSZYDz8tW3dE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTm3QuAlOP8dZS4Vcrmp45W2YjZO+wFHS3N+dCjNENeEjXaMnB9oPVScd31z467+L34psTyKNKqaRf7V3BkXjb51lt2wtyZnFBf7PTA7d5xdb7YiUIElEDW2kVGRDv9sXqYNXu5n7BcTihh5YX42+Qx1RF/Tiai0RGV1VrWgbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLogvY8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B7EC4CEDD;
	Thu, 20 Feb 2025 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057570;
	bh=N6ZDwvGT0PB/a7T/e4Is6asa8QfefM7wSZYDz8tW3dE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FLogvY8lTGC6VlTUGutSQSD8XYMlW0ypmdrLFB5cNtbdIjam/aStCiiuJ3kMCW3/p
	 FWauYoz4qGwtZ8nx1YJfivI+CSgeFxA3Ciat74O0jeK5344QyInRjx0Tspih/cOkgf
	 3pAn3+EXefbU6HLCVEKdNgYiiypLsYFTkVmgp8EMgCZiV1Gs344TZ4b4q8JONFPA7R
	 X0UiskWjG/GGWUxz5tosoHgqYWq531QaBBTrXt5NpDCCNpQEAGxHuTyDIsF7GouaWL
	 fBB8Ps70Qws693gJu4qWdpql4WG96kzWsReExQDTm0fDcT/XmQyTDKindoDl0bLDdk
	 Fc6Q0Xo3BkKFQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:18:53 +0100
Subject: [PATCH 07/14] wifi: mt76: Move wcid cleanup logic in SoC driver
 codebase
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-7-34c4abb37158@kernel.org>
References: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
In-Reply-To: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Move wcid remove logic in hw specific driver codebase.
This change is needed to allow the SoC driver to select the proper wcid
identifying the sta link.
This is a preliminary patch to introduce MLO support for MT7996 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c     | 24 +++--------------------
 drivers/net/wireless/mediatek/mt76/mt76.h         |  2 --
 drivers/net/wireless/mediatek/mt76/mt7603/main.c  |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c |  8 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c  |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c  |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c  |  7 +++++++
 drivers/net/wireless/mediatek/mt76/mt7996/main.c  |  7 +++++++
 10 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index e1d923ab46a27faab5768968b6fdc95c92527fd7..15483961db3d4390a56b7930efa23498a4af287e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1554,26 +1554,6 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	return ret;
 }
 
-void __mt76_sta_remove(struct mt76_phy *phy, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta)
-{
-	struct mt76_dev *dev = phy->dev;
-	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
-	int i, idx = wcid->idx;
-
-	for (i = 0; i < ARRAY_SIZE(wcid->aggr); i++)
-		mt76_rx_aggr_stop(dev, wcid, i);
-
-	if (dev->drv->sta_remove)
-		dev->drv->sta_remove(dev, vif, sta);
-
-	mt76_wcid_cleanup(dev, wcid);
-
-	mt76_wcid_mask_clear(dev->wcid_mask, idx);
-	phy->num_sta--;
-}
-EXPORT_SYMBOL_GPL(__mt76_sta_remove);
-
 static void
 mt76_sta_remove(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta)
@@ -1581,7 +1561,9 @@ mt76_sta_remove(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	struct mt76_dev *dev = phy->dev;
 
 	mutex_lock(&dev->mutex);
-	__mt76_sta_remove(phy, vif, sta);
+	if (dev->drv->sta_remove)
+		dev->drv->sta_remove(dev, vif, sta);
+	phy->num_sta--;
 	mutex_unlock(&dev->mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 019422cf6e739cf5487ed7d73d000afa1ec6066f..92de136fdebaa19c3b21448e8c5f0e19d8702c8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1484,8 +1484,6 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta,
 		   enum ieee80211_sta_state old_state,
 		   enum ieee80211_sta_state new_state);
-void __mt76_sta_remove(struct mt76_phy *phy, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta);
 void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 212d1ad0c40549ae426a5bf2abf1ff917236f186..670f9fa484213556f6e65d019b779a7135427da6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -378,6 +378,10 @@ mt7603_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7603_vif *mvif = (struct mt7603_vif *)vif->drv_priv;
 	struct mt7603_sta *msta = (struct mt7603_sta *)sta->drv_priv;
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	int i, idx = wcid->idx;
+
+	for (i = 0; i < ARRAY_SIZE(wcid->aggr); i++)
+		mt76_rx_aggr_stop(mdev, wcid, i);
 
 	spin_lock_bh(&dev->ps_lock);
 	__skb_queue_purge(&msta->psq);
@@ -390,6 +394,9 @@ mt7603_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	spin_unlock_bh(&mdev->sta_poll_lock);
 
 	mt7603_wtbl_clear(dev, wcid->idx);
+
+	mt76_wcid_cleanup(mdev, wcid);
+	mt76_wcid_mask_clear(mdev->wcid_mask, idx);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 5ede906c9624fa0d30e6eba2fad7a437fe50a040..182f85f6a91647712a400f5976858d38fdc8a29a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -679,8 +679,12 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+	int i, idx = msta->wcid.idx;
 	struct mt7615_phy *phy;
 
+	for (i = 0; i < ARRAY_SIZE(msta->wcid.aggr); i++)
+		mt76_rx_aggr_stop(mdev, &msta->wcid, i);
+
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 
 	phy = mvif->mt76.band_idx ? mt7615_ext_phy(dev) : &dev->phy;
@@ -698,6 +702,9 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	spin_unlock_bh(&mdev->sta_poll_lock);
 
 	mt76_connac_power_save_sched(phy->mt76, &dev->pm);
+
+	mt76_wcid_cleanup(mdev, &msta->wcid);
+	mt76_wcid_mask_clear(mdev->wcid_mask, idx);
 }
 EXPORT_SYMBOL_GPL(mt7615_mac_sta_remove);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 7d840ad4ae65e7b700a5f0b05c1c35f6d64ecaa3..a87806b3675832ea04072213fc779b49f77076b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -423,7 +423,7 @@ static void mt76x02_reset_state(struct mt76x02_dev *dev)
 		priv = msta->vif;
 		vif = container_of(priv, struct ieee80211_vif, drv_priv);
 
-		__mt76_sta_remove(&dev->mphy, vif, sta);
+		mt76x02_sta_remove(&dev->mt76, vif, sta);
 		memset(msta, 0, sizeof(*msta));
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index ce9f4335525e21fd3cb70ebc96348bc986dcfff9..92545c9f9d9b6e9f4d63ffcbd764182d6e5f0ade 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -271,10 +271,16 @@ void mt76x02_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
-	int idx = wcid->idx;
+	int i, idx = wcid->idx;
+
+	for (i = 0; i < ARRAY_SIZE(wcid->aggr); i++)
+		mt76_rx_aggr_stop(mdev, wcid, i);
 
 	mt76x02_mac_wcid_set_drop(dev, idx, true);
 	mt76x02_mac_wcid_setup(dev, idx, 0, NULL);
+
+	mt76_wcid_cleanup(mdev, wcid);
+	mt76_wcid_mask_clear(mdev->wcid_mask, idx);
 }
 EXPORT_SYMBOL_GPL(mt76x02_sta_remove);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 41d2334771654173dd48db321f350b4939b58b04..38bfb6608af4c52063a3978006ee0fdd6c96ee6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -868,6 +868,10 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	int i, idx = msta->wcid.idx;
+
+	for (i = 0; i < ARRAY_SIZE(msta->wcid.aggr); i++)
+		mt76_rx_aggr_stop(mdev, &msta->wcid, i);
 
 	mt7915_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -878,6 +882,9 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (!list_empty(&msta->rc_list))
 		list_del_init(&msta->rc_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
+
+	mt76_wcid_cleanup(mdev, &msta->wcid);
+	mt76_wcid_mask_clear(mdev->wcid_mask, idx);
 }
 
 static void mt7915_tx(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 33228e33235f5dc15d5cd724a97d6d9ea93f2acf..d6f2f79fcd10e65b57f322b577cee0cea8e70f84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -871,6 +871,10 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	int i, idx = msta->deflink.wcid.idx;
+
+	for (i = 0; i < ARRAY_SIZE(msta->deflink.wcid.aggr); i++)
+		mt76_rx_aggr_stop(mdev, &msta->deflink.wcid, i);
 
 	mt7921_roc_abort_sync(dev);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
@@ -899,6 +903,9 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7921_regd_set_6ghz_power_type(vif, false);
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
+
+	mt76_wcid_cleanup(mdev, &msta->deflink.wcid);
+	mt76_wcid_mask_clear(mdev->wcid_mask, idx);
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 1be4dcd0c4c220a8822fbaaaf3fb94774e168fd4..891180ad1470da91fc656c8b9a2598c93a3f13da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1231,8 +1231,12 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			.active = true,
 		},
 	};
+	int i, idx = msta->deflink.wcid.idx;
 	unsigned long rem;
 
+	for (i = 0; i < ARRAY_SIZE(msta->deflink.wcid.aggr); i++)
+		mt76_rx_aggr_stop(mdev, &msta->deflink.wcid, i);
+
 	rem = ieee80211_vif_is_mld(vif) ? msta->valid_links : BIT(0);
 
 	mt7925_mac_sta_remove_links(dev, vif, sta, rem);
@@ -1252,6 +1256,9 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		mvif->wep_sta = NULL;
 		ewma_rssi_init(&mvif->bss_conf.rssi);
 	}
+
+	mt76_wcid_cleanup(mdev, &msta->deflink.wcid);
+	mt76_wcid_mask_clear(mdev->wcid_mask, idx);
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_remove);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 7572e6090b2f03427c104d42183f6e0a7e2de250..eb923c17220eb2ac8d6c916f250c618ebd90c311 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -873,6 +873,10 @@ void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_sta_link *msta_link = &msta->deflink;
+	int i, idx = msta_link->wcid.idx;
+
+	for (i = 0; i < ARRAY_SIZE(msta_link->wcid.aggr); i++)
+		mt76_rx_aggr_stop(mdev, &msta_link->wcid, i);
 
 	mt7996_mac_wtbl_update(dev, msta_link->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -883,6 +887,9 @@ void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (!list_empty(&msta_link->rc_list))
 		list_del_init(&msta_link->rc_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
+
+	mt76_wcid_cleanup(mdev, &msta_link->wcid);
+	mt76_wcid_mask_clear(mdev->wcid_mask, idx);
 }
 
 static void mt7996_tx(struct ieee80211_hw *hw,

-- 
2.48.1


