Return-Path: <linux-wireless+bounces-20186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BD3A5CC91
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851C6189CE0B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B8C25BAC2;
	Tue, 11 Mar 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKtBNNHU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE91EBA1E
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715132; cv=none; b=qTq1G+RhapSzIfNY6ai28cxl/U/dd1J62PbCSw8s7J1unsGSTPvlKYxKwVbzSjfJ8ZGdlDaZHja95gouQLtwXsxyudgHmoJWa/uIBfYJGpXVd4qTtsTnvt9UkSDu1+dr7SJiP/CWT+AMxkQqO/qxXWc1xaccNDgkhAZRGbv1K5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715132; c=relaxed/simple;
	bh=7U4lkh9psOGEQVk2YRmLO/Jv1VKok0SPnjomRCphiPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cqNDQ65R/cQ9onXUAounK72xQnTe4hRcdRuedg6RVa78T+kNaNPWfPxtaNEcou/ejeV48uT06p/fVs1L3P8gwZvLZ5eo9eWhNw/Tys1ZZUaGjIWjFyZa7w+Osthjc6dqoBjDLwhV63XDOPhY1xlRB0GyZHaSgUR9cu544JKtMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKtBNNHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02507C4CEE9;
	Tue, 11 Mar 2025 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715132;
	bh=7U4lkh9psOGEQVk2YRmLO/Jv1VKok0SPnjomRCphiPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nKtBNNHUOYG1wZf5kZLWTK/SuKNC1H/V7mbce4wnb+98yPlVGp8yzTv1aZgM3EkSk
	 qmgRSW7k9Q5BG/wVfc/n08rv86LGanmIHI3F4TMhsxYg6j+alQiKzXMNquCMlKDR9L
	 SNq1P01LtvCumktipC4ZPwRzm9+Shxoryosy9uvCzLyH75HqFRD9qCcBmKwXgdwVZ+
	 1umxhmPKYawGfmfUB9XySN7aEHxw2QylFsBCrHqVEsYUV3K6x6OD4ICI9CKY+jUswE
	 4doGy4/iHlSNazFUF1fAoC+IkmYsC5TDmlyDVUF7tAb7imvzzeB9FXlVuBQUiC1QdT
	 YOepqwOHnXcdg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 18:45:05 +0100
Subject: [PATCH v2 06/13] wifi: mt76: mt7996: Add mt7996_sta_state routine
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mt7996-mlo-v2-6-31df6972519b@kernel.org>
References: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
In-Reply-To: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce mt7996_sta_state routine in order to initialize wcid structure
in mt7996 codebase. This is a preliminary patch to enable MLO support in
MT7996 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   2 +
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 100 ++++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   3 -
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   6 --
 5 files changed, 91 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 2c98cc42cd7e6335e2a8c7f5dd8c386df004ae00..b88d7e10742ee621d2cc6f17576592c6793f2f6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -816,8 +816,8 @@ void mt76_free_device(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_free_device);
 
-static struct mt76_phy *
-mt76_vif_phy(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+struct mt76_phy *mt76_vif_phy(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif)
 {
 	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
 	struct mt76_chanctx *ctx;
@@ -831,6 +831,7 @@ mt76_vif_phy(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	ctx = (struct mt76_chanctx *)mlink->ctx->drv_priv;
 	return ctx->phy;
 }
+EXPORT_SYMBOL_GPL(mt76_vif_phy);
 
 static void mt76_rx_release_amsdu(struct mt76_phy *phy, enum mt76_rxq_id q)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b461273c33064259fa1bb61ea88c06a60cb07178..d7cd467b812fc799428f076efb9b72e7ff988db6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1228,6 +1228,8 @@ struct mt76_phy *mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
 				u8 band_idx);
 int mt76_register_phy(struct mt76_phy *phy, bool vht,
 		      struct ieee80211_rate *rates, int n_rates);
+struct mt76_phy *mt76_vif_phy(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif);
 
 struct dentry *mt76_register_debugfs_fops(struct mt76_phy *phy,
 					  const struct file_operations *ops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 81a13662db24ec268fdd7a9b3d6b1d829a91430f..d99a98d57142fb4826b68c78864614d2c9132fe7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -815,20 +815,26 @@ mt7996_channel_switch_beacon(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
-int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta)
+static int
+mt7996_mac_sta_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+		   struct ieee80211_sta *sta)
 {
+	struct mt76_dev *mdev = mphy->dev;
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct mt7996_vif_link *link = &mvif->deflink;
-	u8 band_idx = link->phy->mt76->band_idx;
-	int idx;
+	u8 band_idx = mphy->band_idx;
+	int i, idx, ret = 0;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
-	if (idx < 0)
-		return -ENOSPC;
+	mutex_lock(&mdev->mutex);
+
+	idx = mt76_wcid_alloc(mdev->wcid_mask, MT7996_WTBL_STA);
+	if (idx < 0) {
+		ret = -ENOSPC;
+		goto unlock;
+	}
 
 	msta->vif = mvif;
 	INIT_LIST_HEAD(&msta_link->rc_list);
@@ -838,20 +844,37 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta_link->wcid.idx = idx;
 	msta_link->wcid.phy_idx = band_idx;
 
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct mt76_txq *mtxq;
+
+		if (!sta->txq[i])
+			continue;
+
+		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
+		mtxq->wcid = idx;
+	}
+
 	ewma_avg_signal_init(&msta_link->avg_ack_signal);
+	ewma_signal_init(&msta_link->wcid.rssi);
 
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	mt7996_mcu_add_sta(dev, vif, &link->mt76, sta, CONN_STATE_DISCONNECT,
 			   true);
 
-	return 0;
+	rcu_assign_pointer(mdev->wcid[idx], &msta_link->wcid);
+	mt76_wcid_init(&msta_link->wcid, band_idx);
+	mphy->num_sta++;
+unlock:
+	mutex_unlock(&mdev->mutex);
+
+	return ret;
 }
 
-int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta, enum mt76_sta_event ev)
+static int
+mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta, enum mt76_sta_event ev)
 {
-	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
@@ -893,12 +916,20 @@ int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	return 0;
 }
 
-void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta)
+static void
+mt7996_mac_sta_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+		      struct ieee80211_sta *sta)
 {
+	struct mt76_dev *mdev = mphy->dev;
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_sta_link *msta_link = &msta->deflink;
+	int i, idx = msta_link->wcid.idx;
+
+	mutex_lock(&mdev->mutex);
+
+	for (i = 0; i < ARRAY_SIZE(msta_link->wcid.aggr); i++)
+		mt76_rx_aggr_stop(mdev, &msta_link->wcid, i);
 
 	mt7996_mac_wtbl_update(dev, msta_link->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -909,6 +940,47 @@ void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (!list_empty(&msta_link->rc_list))
 		list_del_init(&msta_link->rc_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
+
+	mt76_wcid_cleanup(mdev, &msta_link->wcid);
+	mt76_wcid_mask_clear(mdev->wcid_mask, idx);
+	mphy->num_sta--;
+
+	mutex_unlock(&mdev->mutex);
+}
+
+static int
+mt7996_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		 struct ieee80211_sta *sta, enum ieee80211_sta_state old_state,
+		 enum ieee80211_sta_state new_state)
+{
+	struct mt76_phy *mphy = mt76_vif_phy(hw, vif);
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	enum mt76_sta_event ev;
+
+	if (!mphy)
+		return -EINVAL;
+
+	if (old_state == IEEE80211_STA_NOTEXIST &&
+	    new_state == IEEE80211_STA_NONE)
+		return mt7996_mac_sta_add(mphy, vif, sta);
+
+	if (old_state == IEEE80211_STA_NONE &&
+	    new_state == IEEE80211_STA_NOTEXIST)
+		mt7996_mac_sta_remove(mphy, vif, sta);
+
+	if (old_state == IEEE80211_STA_AUTH &&
+	    new_state == IEEE80211_STA_ASSOC)
+		ev = MT76_STA_EVENT_ASSOC;
+	else if (old_state == IEEE80211_STA_ASSOC &&
+		 new_state == IEEE80211_STA_AUTHORIZED)
+		ev = MT76_STA_EVENT_AUTHORIZE;
+	else if (old_state == IEEE80211_STA_ASSOC &&
+		 new_state == IEEE80211_STA_AUTH)
+		ev = MT76_STA_EVENT_DISASSOC;
+	else
+		return 0;
+
+	return mt7996_mac_sta_event(dev, vif, sta, ev);
 }
 
 static void mt7996_tx(struct ieee80211_hw *hw,
@@ -1720,7 +1792,7 @@ const struct ieee80211_ops mt7996_ops = {
 	.configure_filter = mt7996_configure_filter,
 	.vif_cfg_changed = mt7996_vif_cfg_changed,
 	.link_info_changed = mt7996_link_info_changed,
-	.sta_state = mt76_sta_state,
+	.sta_state = mt7996_sta_state,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.link_sta_rc_update = mt7996_sta_rc_update,
 	.set_key = mt7996_set_key,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 9d37f823874643f7ff9121365b6dccd1d1653a99..13b188e281bdb9a1e0d029c9d739769a380a4723 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -618,9 +618,6 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 		.rx_skb = mt7996_queue_rx_skb,
 		.rx_check = mt7996_rx_check,
 		.rx_poll_complete = mt7996_rx_poll_complete,
-		.sta_add = mt7996_mac_sta_add,
-		.sta_event = mt7996_mac_sta_event,
-		.sta_remove = mt7996_mac_sta_remove,
 		.update_survey = mt7996_update_channel,
 		.set_channel = mt7996_set_channel,
 		.vif_link_add = mt7996_vif_link_add,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index ac5b94e1315ec610f5182563e3fb9d504a67c16f..117a9e6c49645e847c579d15809bb5553a64ccfd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -696,12 +696,6 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			   struct ieee80211_key_conf *key, int pid,
 			   enum mt76_txq_id qid, u32 changed);
 void mt7996_mac_set_coverage_class(struct mt7996_phy *phy);
-int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta);
-int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-			 struct ieee80211_sta *sta, enum mt76_sta_event ev);
-void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta);
 void mt7996_mac_work(struct work_struct *work);
 void mt7996_mac_reset_work(struct work_struct *work);
 void mt7996_mac_dump_work(struct work_struct *work);

-- 
2.48.1


