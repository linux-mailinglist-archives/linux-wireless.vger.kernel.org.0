Return-Path: <linux-wireless+bounces-19206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E48A3DB27
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2F519C092F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02CA1F4262;
	Thu, 20 Feb 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFk3t9mA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7788F6D
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057568; cv=none; b=Czn1xftsF/J6nJjhuMTTL5rac38alfSUyoaumYVn/kdMGv1NOPkmwN2034oTZLLb4/t4XhtdrkiWsH49UEPTuodpdKPNlE6D+eIW7Jov86Cvn/iyzhyanbyk9rpJaBluqLTGe+rYa2OsNqXZPtpEBuMMy7/nkHZ+AvesuuU7zMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057568; c=relaxed/simple;
	bh=Ct7X8pYG0gIP7eN5xCeB4h4t2wSlawgPD/tO/+ZGuZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZ7OtK625U20bUiuoyUGgO+yAKjwG9c89TSni0iWoqhkcLbWP0Q/lktcuWk1FaGD8zsUNsTwckWEk+zZYIJioRuk7shAfR/nx9BpBa3Dg38eJEEaBbLI0XA932xYPNh8atKf6GdgYsqHWO7JjfM1eSV2ks5jRa/xSIaVpH93Rcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFk3t9mA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B2CC4CED1;
	Thu, 20 Feb 2025 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057568;
	bh=Ct7X8pYG0gIP7eN5xCeB4h4t2wSlawgPD/tO/+ZGuZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BFk3t9mAhqQbMLw5R+lSqW7zxdpWSmR63f5R10SM6UGKtAlDyrJrET9Q/6ySwKgcc
	 SapQ1dHkr/niJAC6VF74EeeCoeyL50+SmVt/psuDwh9Jp6dGFl8sp6yOsVohk5o+gQ
	 6qlpGAyxxlTXcMDK379L3IPNGtJzZjFxGt0RQ6uYSGBrxTbMVSqrAkdcCr0p4JcJQw
	 NOvJjM9TAxMLPXT/5QeqU2CcRjpBTVwzhLgCW5Rqfzc8Kt1xTfz5nvzy/YIMOlFCWu
	 g1V3ez4+TlUfaYj6VyC5MGY2JHqhajOJNlu4KmdV4Agc/N7K8rt+sLAGYfzQu5cISN
	 oILZk+NXkqqgg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:18:52 +0100
Subject: [PATCH 06/14] wifi: mt76: Add mt76_sta_common_init utility routine
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-6-34c4abb37158@kernel.org>
References: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
In-Reply-To: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Move sta common initialization in sta_add callback introducing
mt76_sta_common_init utility routine. This change is needed to allow the
SoC driver to select the proper wcid identifying the sta link.
This is a preliminary patch to add MLO support for MT7996 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c     | 44 ++++++++++++-----------
 drivers/net/wireless/mediatek/mt76/mt76.h         |  9 +++++
 drivers/net/wireless/mediatek/mt76/mt7603/main.c  |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt7996/main.c  |  4 ++-
 9 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 508b472408c200d330b5c8678d3b50679ffcbc53..e1d923ab46a27faab5768968b6fdc95c92527fd7 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1516,37 +1516,39 @@ void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
 }
 EXPORT_SYMBOL_GPL(mt76_rx_poll_complete);
 
-static int
-mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
-	     struct ieee80211_sta *sta)
+void __mt76_sta_common_init(struct mt76_phy *phy, struct mt76_wcid *wcid,
+			    struct ieee80211_sta *sta, bool primary_link)
 {
-	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
 	struct mt76_dev *dev = phy->dev;
-	int ret;
 	int i;
 
-	mutex_lock(&dev->mutex);
-
-	ret = dev->drv->sta_add(dev, vif, sta);
-	if (ret)
-		goto out;
+	if (primary_link) {
+		for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+			struct mt76_txq *mtxq;
 
-	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
-		struct mt76_txq *mtxq;
+			if (!sta->txq[i])
+				continue;
 
-		if (!sta->txq[i])
-			continue;
-
-		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
-		mtxq->wcid = wcid->idx;
+			mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
+			mtxq->wcid = wcid->idx;
+		}
+		phy->num_sta++;
 	}
-
 	ewma_signal_init(&wcid->rssi);
 	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
-	phy->num_sta++;
-
 	mt76_wcid_init(wcid, phy->band_idx);
-out:
+}
+EXPORT_SYMBOL_GPL(__mt76_sta_common_init);
+
+static int
+mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
+	     struct ieee80211_sta *sta)
+{
+	struct mt76_dev *dev = phy->dev;
+	int ret;
+
+	mutex_lock(&dev->mutex);
+	ret = dev->drv->sta_add(dev, vif, sta);
 	mutex_unlock(&dev->mutex);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 132148f7b107018a2a315b0bde8dabd1e26eb01b..019422cf6e739cf5487ed7d73d000afa1ec6066f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1471,6 +1471,15 @@ mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid, struct sk_buff *skb)
 }
 
 void mt76_tx_status_check(struct mt76_dev *dev, bool flush);
+void __mt76_sta_common_init(struct mt76_phy *phy, struct mt76_wcid *wcid,
+			    struct ieee80211_sta *sta, bool primary_link);
+static inline void mt76_sta_common_init(struct mt76_phy *phy,
+					struct mt76_wcid *wcid,
+					struct ieee80211_sta *sta)
+{
+	__mt76_sta_common_init(phy, wcid, sta, true);
+}
+
 int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta,
 		   enum ieee80211_sta_state old_state,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 3e8b1ec761691c9410aa43e7b7ee0e09b799711d..212d1ad0c40549ae426a5bf2abf1ff917236f186 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -350,6 +350,8 @@ mt7603_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (vif->type == NL80211_IFTYPE_AP)
 		set_bit(MT_WCID_FLAG_CHECK_PS, &msta->wcid.flags);
 
+	mt76_sta_common_init(&dev->mphy, &msta->wcid, sta);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 2e7b05eeef7a048ff5c41fc690f483d2301a28d5..5ede906c9624fa0d30e6eba2fad7a437fe50a040 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -666,6 +666,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (err)
 		return err;
 
+	mt76_sta_common_init(phy->mt76, &msta->wcid, sta);
 	mt76_connac_power_save_sched(phy->mt76, &dev->pm);
 
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 4fb30589fa7a098ff0145282329c6fc4d37f0297..ce9f4335525e21fd3cb70ebc96348bc986dcfff9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -260,6 +260,8 @@ int mt76x02_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (vif->type == NL80211_IFTYPE_AP)
 		set_bit(MT_WCID_FLAG_CHECK_PS, &msta->wcid.flags);
 
+	mt76_sta_common_init(&dev->mphy, &msta->wcid, sta);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76x02_sta_add);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3aa31c5cefa6a57cced8d5ed34b9fcc8cd02d401..41d2334771654173dd48db321f350b4939b58b04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -763,6 +763,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7915_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_DISCONNECT, true);
+	mt76_sta_common_init(mvif->phy->mt76, &msta->wcid, sta);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 13e58c328aff4dda2c4bf81741c7c77460ec0926..33228e33235f5dc15d5cd724a97d6d9ea93f2acf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -829,6 +829,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	mt7921_regd_set_6ghz_power_type(vif, true);
 
+	mt76_sta_common_init(&dev->mphy, &msta->deflink.wcid, sta);
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 98daf80ac131367b71ab925d3ed5c6064f0f3823..1be4dcd0c4c220a8822fbaaaf3fb94774e168fd4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -972,6 +972,7 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	} else {
 		err = mt7925_mac_link_sta_add(mdev, vif, &sta->deflink);
 	}
+	mt76_sta_common_init(&dev->mphy, &msta->deflink.wcid, sta);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 06ee426db62dab78b171b097f7bd2ca690b41ac4..7572e6090b2f03427c104d42183f6e0a7e2de250 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -795,7 +795,8 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct mt7996_vif_link *link = &mvif->deflink;
-	u8 band_idx = link->phy->mt76->band_idx;
+	struct mt7996_phy *phy = link->phy;
+	u8 band_idx = phy->mt76->band_idx;
 	int idx;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
@@ -816,6 +817,7 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	mt7996_mcu_add_sta(dev, vif, &link->mt76, sta, CONN_STATE_DISCONNECT,
 			   true);
+	mt76_sta_common_init(phy->mt76, &msta_link->wcid, sta);
 
 	return 0;
 }

-- 
2.48.1


