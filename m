Return-Path: <linux-wireless+bounces-20187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35958A5CC92
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BBF179CA3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71E91E9B26;
	Tue, 11 Mar 2025 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9owl/yQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3E41C72
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715135; cv=none; b=QlK24+Qnkond+AJzMLldfBf0d3qowUGRd+s4Cttrz+aH0dG7LrJth06KWq5NnbcmD05TF46hTOnknmH8pDhjmhNYSWIscdm0NwCarWnPVL1HKyru8K+x9ChlfIiGIgsJZLIGgInJ/RYqcPJOQMPHpqDeQJ1kRIZ7VhWQHBtxYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715135; c=relaxed/simple;
	bh=WiSiQt/8p6iw9Vai6lwBuEr3mqR4pqcErC0Asy+CIpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LseH2B1z/hDD20VaiwwyhSDYfU/CCCHXoRBUu3SRYrohjr6Hqn/dxsf9ccw7qIwEHeGybc7ySJJmarN6YipLPDhlUGTOeRaQkS15rb7YQhOfOCgcT1N9+m2HB+OB3CthAQzDPhcIYbnIKUbHSc6eaPrvbTXPsgibSLmXSEA3wFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9owl/yQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4657C4CEE9;
	Tue, 11 Mar 2025 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715135;
	bh=WiSiQt/8p6iw9Vai6lwBuEr3mqR4pqcErC0Asy+CIpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n9owl/yQYB63ttXTcrRu7AX3Ixqueb2ZenTAxQ7+npiNQ1zMpFitrMrseDkxbGC9B
	 MlEF3eua5Q9L00TxG96f89ks89ud3ZjRVHMe1tnV7TtdkEFoA6SS5u8JHz4HMJh9tp
	 hjda4dQnkaNROV4W3eLn6xu027EVGB6526FaIlVvRdf2A/RNrtmqeOka0kE5tCYjjc
	 Dg6S2NpToyfjdnLB6f860U2bN+Hq1roU6emzaHHsQZ4WjajOgS7PIyHuGkCRhhwPW3
	 yR/pLqas7SLWzJM7WqA52hqK3gKT7AH7W2NiaVUKGO49i0WKqSba0DJ3vbFbEUEoS9
	 7K4sVotSWr1tQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 18:45:06 +0100
Subject: [PATCH v2 07/13] wifi: mt76: mt7996: Rely on mt7996_sta_link in
 sta_add/sta_remove callbacks
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mt7996-mlo-v2-7-31df6972519b@kernel.org>
References: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
In-Reply-To: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>
X-Mailer: b4 0.14.2

Generalize mt7996_mac_sta_add() and mt7996_mac_sta_remove() routines to
deal with mt7996_sta_link structure.
This is a preliminary patch to introduce MLO support for MT7996 driver.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 189 +++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   4 +
 2 files changed, 143 insertions(+), 50 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index d99a98d57142fb4826b68c78864614d2c9132fe7..1bca444d2d02333cabd31ba2c8565769a42ab581 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -816,59 +816,164 @@ mt7996_channel_switch_beacon(struct ieee80211_hw *hw,
 }
 
 static int
-mt7996_mac_sta_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
-		   struct ieee80211_sta *sta)
+mt7996_mac_sta_init_link(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			 struct mt7996_vif_link *link,
+			 struct ieee80211_sta *sta, unsigned int link_id)
 {
-	struct mt76_dev *mdev = mphy->dev;
-	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
-	struct mt7996_vif_link *link = &mvif->deflink;
-	u8 band_idx = mphy->band_idx;
-	int i, idx, ret = 0;
+	struct mt7996_phy *phy = link->phy;
+	struct mt7996_sta_link *msta_link;
+	int idx;
 
-	mutex_lock(&mdev->mutex);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
+	if (idx < 0)
+		return -ENOSPC;
+
+	if (msta->deflink_id == IEEE80211_LINK_UNSPECIFIED) {
+		int i;
+
+		msta_link = &msta->deflink;
+		msta->deflink_id = link_id;
+
+		for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+			struct mt76_txq *mtxq;
+
+			if (!sta->txq[i])
+				continue;
 
-	idx = mt76_wcid_alloc(mdev->wcid_mask, MT7996_WTBL_STA);
-	if (idx < 0) {
-		ret = -ENOSPC;
-		goto unlock;
+			mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
+			mtxq->wcid = idx;
+		}
+	} else {
+		msta_link = kzalloc(sizeof(*msta_link), GFP_KERNEL);
+		if (!msta_link)
+			return -ENOMEM;
 	}
 
-	msta->vif = mvif;
 	INIT_LIST_HEAD(&msta_link->rc_list);
 	INIT_LIST_HEAD(&msta_link->wcid.poll_list);
 	msta_link->sta = msta;
 	msta_link->wcid.sta = 1;
 	msta_link->wcid.idx = idx;
-	msta_link->wcid.phy_idx = band_idx;
+	msta_link->wcid.link_id = link_id;
+
+	ewma_avg_signal_init(&msta_link->avg_ack_signal);
+	ewma_signal_init(&msta_link->wcid.rssi);
 
-	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
-		struct mt76_txq *mtxq;
+	rcu_assign_pointer(msta->link[link_id], msta_link);
 
-		if (!sta->txq[i])
+	mt7996_mac_wtbl_update(dev, idx, MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	mt7996_mcu_add_sta(dev, vif, &link->mt76, sta, CONN_STATE_DISCONNECT,
+			   true);
+
+	rcu_assign_pointer(dev->mt76.wcid[idx], &msta_link->wcid);
+	mt76_wcid_init(&msta_link->wcid, phy->mt76->band_idx);
+
+	return 0;
+}
+
+static void
+mt7996_mac_sta_deinit_link(struct mt7996_dev *dev,
+			   struct mt7996_sta_link *msta_link)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(msta_link->wcid.aggr); i++)
+		mt76_rx_aggr_stop(&dev->mt76, &msta_link->wcid, i);
+
+	mt7996_mac_wtbl_update(dev, msta_link->wcid.idx,
+			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	if (!list_empty(&msta_link->wcid.poll_list))
+		list_del_init(&msta_link->wcid.poll_list);
+	if (!list_empty(&msta_link->rc_list))
+		list_del_init(&msta_link->rc_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+
+	mt76_wcid_cleanup(&dev->mt76, &msta_link->wcid);
+	mt76_wcid_mask_clear(dev->mt76.wcid_mask, msta_link->wcid.idx);
+}
+
+static void
+mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_sta *sta,
+			    unsigned long links)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt76_dev *mdev = &dev->mt76;
+	unsigned int link_id;
+
+	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt7996_sta_link *msta_link = NULL;
+
+		msta_link = rcu_replace_pointer(msta->link[link_id], msta_link,
+						lockdep_is_held(&mdev->mutex));
+		if (!msta_link)
 			continue;
 
-		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
-		mtxq->wcid = idx;
+		mt7996_mac_sta_deinit_link(dev, msta_link);
+		if (msta->deflink_id == link_id) {
+			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+			continue;
+		}
+
+		kfree_rcu(msta_link, rcu_head);
 	}
+}
 
-	ewma_avg_signal_init(&msta_link->avg_ack_signal);
-	ewma_signal_init(&msta_link->wcid.rssi);
+static int
+mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, unsigned long new_links)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	unsigned int link_id;
+	int err;
 
-	mt7996_mac_wtbl_update(dev, idx,
-			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-	mt7996_mcu_add_sta(dev, vif, &link->mt76, sta, CONN_STATE_DISCONNECT,
-			   true);
+	for_each_set_bit(link_id, &new_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt7996_vif_link *link;
+
+		if (rcu_access_pointer(msta->link[link_id]))
+			continue;
+
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			goto error_unlink;
+
+		err = mt7996_mac_sta_init_link(dev, vif, link, sta, link_id);
+		if (err)
+			goto error_unlink;
+	}
+
+	return 0;
+
+error_unlink:
+	mt7996_mac_sta_remove_links(dev, sta, new_links);
+
+	return err;
+}
+
+static int
+mt7996_mac_sta_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
+		   struct ieee80211_sta *sta)
+{
+	struct mt76_dev *mdev = mphy->dev;
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	unsigned long links = sta->mlo ? sta->valid_links : BIT(0);
+	int err;
+
+	mutex_lock(&mdev->mutex);
+
+	msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+	msta->vif = mvif;
+	err = mt7996_mac_sta_add_links(dev, vif, sta, links);
+	if (!err)
+		mphy->num_sta++;
 
-	rcu_assign_pointer(mdev->wcid[idx], &msta_link->wcid);
-	mt76_wcid_init(&msta_link->wcid, band_idx);
-	mphy->num_sta++;
-unlock:
 	mutex_unlock(&mdev->mutex);
 
-	return ret;
+	return err;
 }
 
 static int
@@ -922,27 +1027,11 @@ mt7996_mac_sta_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 {
 	struct mt76_dev *mdev = mphy->dev;
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
-	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
-	int i, idx = msta_link->wcid.idx;
+	unsigned long links = sta->mlo ? sta->valid_links : BIT(0);
 
 	mutex_lock(&mdev->mutex);
 
-	for (i = 0; i < ARRAY_SIZE(msta_link->wcid.aggr); i++)
-		mt76_rx_aggr_stop(mdev, &msta_link->wcid, i);
-
-	mt7996_mac_wtbl_update(dev, msta_link->wcid.idx,
-			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-
-	spin_lock_bh(&mdev->sta_poll_lock);
-	if (!list_empty(&msta_link->wcid.poll_list))
-		list_del_init(&msta_link->wcid.poll_list);
-	if (!list_empty(&msta_link->rc_list))
-		list_del_init(&msta_link->rc_list);
-	spin_unlock_bh(&mdev->sta_poll_lock);
-
-	mt76_wcid_cleanup(mdev, &msta_link->wcid);
-	mt76_wcid_mask_clear(mdev->wcid_mask, idx);
+	mt7996_mac_sta_remove_links(dev, sta, links);
 	mphy->num_sta--;
 
 	mutex_unlock(&mdev->mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 117a9e6c49645e847c579d15809bb5553a64ccfd..cf37baa91a8ba1cfafb07a4166aed0a0e84968fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -204,10 +204,14 @@ struct mt7996_sta_link {
 		u8 flowid_mask;
 		struct mt7996_twt_flow flow[MT7996_MAX_STA_TWT_AGRT];
 	} twt;
+
+	struct rcu_head rcu_head;
 };
 
 struct mt7996_sta {
 	struct mt7996_sta_link deflink; /* must be first */
+	struct mt7996_sta_link __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	u8 deflink_id;
 
 	struct mt7996_vif *vif;
 };

-- 
2.48.1


