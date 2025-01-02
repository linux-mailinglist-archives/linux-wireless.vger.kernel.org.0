Return-Path: <linux-wireless+bounces-17008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C17329FFBDA
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DC51627FC
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7381A2658;
	Thu,  2 Jan 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="XD1pcchW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96415539D
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835725; cv=none; b=gk05y72qcRtHTs2BrxEbxcpKGGAdE/4KcnazTnxql9LimnUO8UI/6KziVmWR0vRoOBVq8iCxIGO/n3XUAhJpSzD0ZbrUZ/MCc5YgpvgUCMPuyZ97Y31fwYHhxFMJnhrSoFX7XOOWkRhhQEZCDGiCiuPJBJtxxK/vRdVr+zDx5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835725; c=relaxed/simple;
	bh=We53+8D4QHLFH6XmKLyKPiGae63mszrUyTAi1D230j8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LM7FAkWzs2q5Caixr07FtPJ8UeNDXMmpdx+WMAUr7WbYcBx3OF3OWNNoPB7PeF9kxgxrFpT3PaUmjELN0wV4tA73A8BMqiK5PBKenMGDwoWymUjvmgBi1IkrerRbZHXp8B4pBlOvUz2RxGYk9xdnHb01EKzWyy8A9g8QgWdR0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=XD1pcchW; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iu+Ual7fZvqPDi/567/jzaN8TrKnYrFv0Qoj5yHRB3k=; b=XD1pcchWJnUJ9P90ErJjTcQGab
	PwkvkBIAglqdPK9zRdYeE+/kZFZ99jXwBgnuSXKerSEQup+aZST1/0gWfVYPEfSJ3Hbr1Gpg9Zt//
	cUjW20IXsLpNLgdLrDdQYvI07uIx+NjhH1U/4vC6N/zSKzXby9WQDk4COb7stlNpaJJ4=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAC-0008GS-1G
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:12 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 06/24] wifi: mt76: initialize more wcid fields mt76_wcid_init
Date: Thu,  2 Jan 2025 17:34:50 +0100
Message-ID: <20250102163508.52945-6-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduces code duplication and ensures that the phy index is always set.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c     | 12 ++++++++----
 drivers/net/wireless/mediatek/mt76/mt76.h         |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c  |  4 +---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  |  4 +---
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c |  3 +--
 drivers/net/wireless/mediatek/mt76/mt7915/main.c  |  5 +----
 drivers/net/wireless/mediatek/mt76/mt7921/main.c  |  4 +---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c  | 10 +++-------
 drivers/net/wireless/mediatek/mt76/mt7996/main.c  |  5 +----
 9 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5a77f94b7f82..8863d60dbd9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -742,7 +742,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	int ret;
 
 	dev_set_drvdata(dev->dev, dev);
-	mt76_wcid_init(&dev->global_wcid);
+	mt76_wcid_init(&dev->global_wcid, phy->band_idx);
 	ret = mt76_phy_init(phy, hw);
 	if (ret)
 		return ret;
@@ -1494,11 +1494,10 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	ewma_signal_init(&wcid->rssi);
 	if (phy->band_idx == MT_BAND1)
 		mt76_wcid_mask_set(dev->wcid_phy_mask, wcid->idx);
-	wcid->phy_idx = phy->band_idx;
 	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
 	phy->num_sta++;
 
-	mt76_wcid_init(wcid);
+	mt76_wcid_init(wcid, phy->band_idx);
 out:
 	mutex_unlock(&dev->mutex);
 
@@ -1588,14 +1587,19 @@ void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76_sta_pre_rcu_remove);
 
-void mt76_wcid_init(struct mt76_wcid *wcid)
+void mt76_wcid_init(struct mt76_wcid *wcid, u8 band_idx)
 {
+	wcid->hw_key_idx = -1;
+	wcid->phy_idx = band_idx;
+
 	INIT_LIST_HEAD(&wcid->tx_list);
 	skb_queue_head_init(&wcid->tx_pending);
 	skb_queue_head_init(&wcid->tx_offchannel);
 
 	INIT_LIST_HEAD(&wcid->list);
 	idr_init(&wcid->pktid);
+
+	INIT_LIST_HEAD(&wcid->poll_list);
 }
 EXPORT_SYMBOL_GPL(mt76_wcid_init);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 669cbd63f403..a9537131a074 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1764,7 +1764,7 @@ mt76_token_put(struct mt76_dev *dev, int token)
 	return txwi;
 }
 
-void mt76_wcid_init(struct mt76_wcid *wcid);
+void mt76_wcid_init(struct mt76_wcid *wcid, u8 band_idx);
 void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid);
 void mt76_wcid_add_poll(struct mt76_dev *dev, struct mt76_wcid *wcid);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 574f74ad325d..3e8b1ec76169 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -66,11 +66,9 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	idx = MT7603_WTBL_RESERVED - 1 - mvif->idx;
 	dev->mt76.vif_mask |= BIT_ULL(mvif->idx);
-	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.vif = mvif;
-	mt76_wcid_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid, 0);
 
 	eth_broadcast_addr(bc_addr);
 	mt7603_wtbl_init(dev, idx, mvif->idx, bc_addr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index e883cf4e1095..7acf3f4ad3c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -225,9 +225,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
-	mvif->sta.wcid.hw_key_idx = -1;
-	mt76_wcid_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid, mvif->mt76.band_idx);
 
 	mt7615_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 8020446be37b..4fb30589fa7a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -287,8 +287,7 @@ mt76x02_vif_init(struct mt76x02_dev *dev, struct ieee80211_vif *vif,
 
 	mvif->idx = idx;
 	mvif->group_wcid.idx = MT_VIF_WCID(idx);
-	mvif->group_wcid.hw_key_idx = -1;
-	mt76_wcid_init(&mvif->group_wcid);
+	mt76_wcid_init(&mvif->group_wcid, 0);
 
 	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 	rcu_assign_pointer(dev->mt76.wcid[MT_VIF_WCID(idx)], &mvif->group_wcid);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 565d22019aac..3aa31c5cefa6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -253,12 +253,9 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	}
 
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
-	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.phy_idx = ext_phy;
-	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_wcid_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid, phy->mt76->band_idx);
 
 	mt7915_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 8158357b86be..fccefda3bdb5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -325,10 +325,8 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	INIT_LIST_HEAD(&mvif->sta.deflink.wcid.poll_list);
 	mvif->sta.deflink.wcid.idx = idx;
-	mvif->sta.deflink.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
-	mvif->sta.deflink.wcid.hw_key_idx = -1;
 	mvif->sta.deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_wcid_init(&mvif->sta.deflink.wcid);
+	mt76_wcid_init(&mvif->sta.deflink.wcid, mvif->bss_conf.mt76.band_idx);
 
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a4a673637fa1..d0a91b3cdc27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -378,12 +378,9 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 
 	idx = MT792x_WTBL_RESERVED - mconf->mt76.idx;
 
-	INIT_LIST_HEAD(&mlink->wcid.poll_list);
 	mlink->wcid.idx = idx;
-	mlink->wcid.phy_idx = 0;
-	mlink->wcid.hw_key_idx = -1;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_wcid_init(&mlink->wcid);
+	mt76_wcid_init(&mlink->wcid, 0);
 
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -850,10 +847,9 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 		return -ENOSPC;
 
 	mconf = mt792x_vif_to_link(mvif, link_id);
-	INIT_LIST_HEAD(&mlink->wcid.poll_list);
+	mt76_wcid_init(&mlink->wcid, 0);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
-	mlink->wcid.phy_idx = 0;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mlink->last_txs = jiffies;
 	mlink->wcid.link_id = link_sta->link_id;
@@ -863,7 +859,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	wcid = &mlink->wcid;
 	ewma_signal_init(&wcid->rssi);
 	rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
-	mt76_wcid_init(wcid);
+	mt76_wcid_init(wcid, 0);
 	ewma_avg_signal_init(&mlink->avg_ack_signal);
 	memset(mlink->airtime_ac, 0,
 	       sizeof(msta->deflink.airtime_ac));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 8679f8a6d49f..9f1460eca4f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -214,12 +214,9 @@ mt7996_vif_link_add(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 	idx = MT7996_WTBL_RESERVED - mlink->mt76.idx;
 
 	INIT_LIST_HEAD(&mlink->sta.rc_list);
-	INIT_LIST_HEAD(&mlink->sta.wcid.poll_list);
 	mlink->sta.wcid.idx = idx;
-	mlink->sta.wcid.phy_idx = band_idx;
-	mlink->sta.wcid.hw_key_idx = -1;
 	mlink->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_wcid_init(&mlink->sta.wcid);
+	mt76_wcid_init(&mlink->sta.wcid, band_idx);
 
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-- 
2.47.1


