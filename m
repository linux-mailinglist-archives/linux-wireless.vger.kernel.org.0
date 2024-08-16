Return-Path: <linux-wireless+bounces-11576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1478195506D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397441C222A3
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C22180034;
	Fri, 16 Aug 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="qdHBOa+I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528E1BDAA0
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831055; cv=none; b=MMNGbtmRoBO9Hu8f73v+YTUMe38jf3WgI3k26r8pVqmKQB1Rs9SlBh12W9r43FjoLA6T3uaVQ8lWRH3wcoi8Nko8lG5LN9I50MQiTLrYLMlIjx+WN3lSZXejgDy5B1JN4oh0KU35jtthhEUh3dzij9rv2Yp6jti10bLuTcNDtPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831055; c=relaxed/simple;
	bh=1pG44B0zOaStYsmLKk0+XP4L8J1KZBASCDcAOiraXWs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4EOo0Tn2C8NqLvSMTyvWuq5nQDfnxzYRlVfeLkF4ufr1xrOIwUgcFqt7lv1TLGthgXQJ1Cq/KLL7JnplbtQqAhGTzxR+LWw1q/aNJ2U7L+BM4LrBDcUDHqQMRFaq6NTib9OA5wUHSdl0YKAIavfrJ61kIG8AMav5GE90NG3DGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=qdHBOa+I; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9VfOBJIzT/AHJUaINHIwHFUoKF3g+tDfXDgkBYeX++0=; b=qdHBOa+IZaliJdp5H0HEo3xGvB
	h8WOCWGgxijViVkyxeBiU0KMGrkTZ1LS1tFmWIot5i6f0TlSbv0tb1NSjl5pT+oVTmK+T3CTpkTP1
	ioDF6CV5+EWhd5Hs3ka/7spWvB7XyAGI64MRHswPpqn0wl2IIAB+2mk4F7BX0wx9Y4mA=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rS-000ObE-2I
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:38 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 12/16] wifi: mt76: mt7915: use mac80211 .sta_state op
Date: Fri, 16 Aug 2024 19:35:25 +0200
Message-ID: <20240816173529.17873-12-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816173529.17873-1-nbd@nbd.name>
References: <20240816173529.17873-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows adding stations before assoc, though they are not passed to the
firmware yet at that point.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  3 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     | 16 +++
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 98 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 10 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  1 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +-
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  4 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |  3 +
 8 files changed, 94 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 9d5561f44134..7aefc9182b36 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1458,7 +1458,8 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			continue;
 
 		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
-		mtxq->wcid = wcid->idx;
+		if (!mtxq->wcid)
+			mtxq->wcid = wcid->idx;
 	}
 
 	ewma_signal_init(&wcid->rssi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f1cd9dc86b42..5dca8f0cd760 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1262,6 +1262,22 @@ mtxq_to_txq(struct mt76_txq *mtxq)
 	return container_of(ptr, struct ieee80211_txq, drv_priv);
 }
 
+static inline void
+mt76_sta_set_txq_wcid(struct ieee80211_sta *sta, int idx)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct mt76_txq *mtxq;
+
+		if (!sta->txq[i])
+			continue;
+
+		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
+		mtxq->wcid = idx;
+	}
+}
+
 static inline struct ieee80211_sta *
 wcid_to_sta(struct mt76_wcid *wcid)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 34af1ea16ada..ac8924f9209c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -274,7 +274,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	memset(&mvif->cap, -1, sizeof(mvif->cap));
 
 	mt7915_mcu_add_bss_info(phy, vif, true);
-	mt7915_mcu_add_sta(dev, vif, NULL, true);
+	mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_PORT_SECURE, true);
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
 
 out:
@@ -293,7 +293,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	int idx = msta->wcid.idx;
 
 	mt7915_mcu_add_bss_info(phy, vif, false);
-	mt7915_mcu_add_sta(dev, vif, NULL, false);
+	mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_DISCONNECT, true);
 
 	mutex_lock(&dev->mt76.mutex);
 	mt76_testmode_reset(phy->mt76, true);
@@ -365,6 +365,9 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	int idx = key->keyidx;
 	int err = 0;
 
+	if (sta && !wcid->sta)
+		return -EOPNOTSUPP;
+
 	/* The hardware does not support per-STA RX GTK, fallback
 	 * to software mode for these.
 	 */
@@ -622,7 +625,7 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	if (set_bss_info == 1)
 		mt7915_mcu_add_bss_info(phy, vif, true);
 	if (set_sta == 1)
-		mt7915_mcu_add_sta(dev, vif, NULL, true);
+		mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_PORT_SECURE, true);
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT)
 		mt7915_mac_enable_rtscts(dev, vif, info->use_cts_prot);
@@ -657,7 +660,7 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	if (set_bss_info == 0)
 		mt7915_mcu_add_bss_info(phy, vif, false);
 	if (set_sta == 0)
-		mt7915_mcu_add_sta(dev, vif, NULL, false);
+		mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_DISCONNECT, true);
 
 	mutex_unlock(&dev->mt76.mutex);
 }
@@ -695,7 +698,7 @@ mt7915_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	err = mt7915_mcu_add_bss_info(phy, vif, true);
 	if (err)
 		goto out;
-	err = mt7915_mcu_add_sta(dev, vif, NULL, true);
+	err = mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_PORT_SECURE, true);
 out:
 	mutex_unlock(&dev->mt76.mutex);
 
@@ -709,7 +712,7 @@ mt7915_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7915_mcu_add_sta(dev, vif, NULL, false);
+	mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_DISCONNECT, true);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
@@ -732,8 +735,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	bool ext_phy = mvif->phy != &dev->phy;
-	int ret, idx;
-	u32 addr;
+	int idx;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
 	if (idx < 0)
@@ -742,7 +744,6 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	INIT_LIST_HEAD(&msta->rc_list);
 	INIT_LIST_HEAD(&msta->wcid.poll_list);
 	msta->vif = mvif;
-	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
 	msta->wcid.phy_idx = ext_phy;
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
@@ -752,15 +753,49 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	mt7915_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	mt76_sta_set_txq_wcid(sta, mvif->sta.wcid.idx);
 
-	ret = mt7915_mcu_add_sta(dev, vif, sta, true);
-	if (ret)
-		return ret;
+	return 0;
+}
 
-	addr = mt7915_mac_wtbl_lmac_addr(dev, msta->wcid.idx, 30);
-	mt76_rmw_field(dev, addr, GENMASK(7, 0), 0xa0);
+int mt7915_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev)
+{
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	u32 addr;
+	int ret;
 
-	return mt7915_mcu_add_rate_ctrl(dev, vif, sta, false);
+	switch (ev) {
+	case MT76_STA_EVENT_ASSOC:
+		ret = mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_CONNECT, true);
+		if (ret)
+			return ret;
+
+		addr = mt7915_mac_wtbl_lmac_addr(dev, msta->wcid.idx, 30);
+		mt76_rmw_field(dev, addr, GENMASK(7, 0), 0xa0);
+
+		ret = mt7915_mcu_add_rate_ctrl(dev, vif, sta, false);
+		if (ret)
+			return ret;
+
+		msta->wcid.sta = 1;
+		mt76_sta_set_txq_wcid(sta, msta->wcid.idx);
+
+		return 0;
+
+	case MT76_STA_EVENT_AUTHORIZE:
+		return mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_PORT_SECURE, false);
+
+	case MT76_STA_EVENT_DISASSOC:
+		mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_DISCONNECT, false);
+		mt76_sta_set_txq_wcid(sta, mvif->sta.wcid.idx);
+		msta->wcid.sta = 0;
+		return 0;
+	}
+
+	return 0;
 }
 
 void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
@@ -770,8 +805,6 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	int i;
 
-	mt7915_mcu_add_sta(dev, vif, sta, false);
-
 	mt7915_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
@@ -803,7 +836,7 @@ static void mt7915_tx(struct ieee80211_hw *hw,
 		wcid = &sta->wcid;
 	}
 
-	if (vif && !control->sta) {
+	if (vif && !wcid->sta) {
 		struct mt7915_vif *mvif;
 
 		mvif = (struct mt7915_vif *)vif->drv_priv;
@@ -884,22 +917,6 @@ mt7915_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return ret;
 }
 
-static int
-mt7915_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-	       struct ieee80211_sta *sta)
-{
-	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NOTEXIST,
-			      IEEE80211_STA_NONE);
-}
-
-static int
-mt7915_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		  struct ieee80211_sta *sta)
-{
-	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NONE,
-			      IEEE80211_STA_NOTEXIST);
-}
-
 static int
 mt7915_get_stats(struct ieee80211_hw *hw,
 		 struct ieee80211_low_level_stats *stats)
@@ -1153,6 +1170,10 @@ static void mt7915_sta_rc_update(struct ieee80211_hw *hw,
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_dev *dev = phy->dev;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+
+	if (!msta->wcid.sta)
+		return;
 
 	mt7915_sta_rc_work(&changed, sta);
 	ieee80211_queue_work(hw, &dev->rc_work);
@@ -1191,6 +1212,9 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 
+	if (!msta->wcid.sta)
+		return;
+
 	if (enabled)
 		set_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
 	else
@@ -1207,6 +1231,9 @@ static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 
+	if (!msta->wcid.sta)
+		return;
+
 	if (enabled)
 		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
 	else
@@ -1665,8 +1692,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.bss_info_changed = mt7915_bss_info_changed,
 	.start_ap = mt7915_start_ap,
 	.stop_ap = mt7915_stop_ap,
-	.sta_add = mt7915_sta_add,
-	.sta_remove = mt7915_sta_remove,
+	.sta_state = mt76_sta_state,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.sta_rc_update = mt7915_sta_rc_update,
 	.set_key = mt7915_set_key,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 10de8b994e2e..7abf6cacdaae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1657,13 +1657,12 @@ mt7915_mcu_add_group(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 }
 
 int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable)
+		       struct ieee80211_sta *sta, int conn_state, bool newly)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct ieee80211_link_sta *link_sta;
 	struct mt7915_sta *msta;
 	struct sk_buff *skb;
-	int conn_state;
 	int ret;
 
 	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
@@ -1675,10 +1674,9 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	conn_state = enable ? CONN_STATE_PORT_SECURE : CONN_STATE_DISCONNECT;
-	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, link_sta, conn_state,
-				      !rcu_access_pointer(dev->mt76.wcid[msta->wcid.idx]));
-	if (!enable)
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, link_sta,
+				      conn_state, newly);
+	if (conn_state == CONN_STATE_DISCONNECT)
 		goto out;
 
 	/* tag order is in accordance with firmware dependency. */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index ec7cf57521d9..44e112b8b5b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -927,6 +927,7 @@ struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
 		.rx_check = mt7915_rx_check,
 		.rx_poll_complete = mt7915_rx_poll_complete,
 		.sta_add = mt7915_mac_sta_add,
+		.sta_event = mt7915_mac_sta_event,
 		.sta_remove = mt7915_mac_sta_remove,
 		.update_survey = mt7915_update_channel,
 		.set_channel = mt7915_set_channel,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 712471c2a8e9..ac0b1f0eb27c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -444,7 +444,7 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, int enable);
 int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable);
+		       struct ieee80211_sta *sta, int conn_state, bool newly);
 int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool add);
@@ -560,6 +560,8 @@ void mt7915_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 void mt7915_mac_set_timing(struct mt7915_phy *phy);
 int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
+int mt7915_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev);
 void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7915_mac_work(struct work_struct *work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 1ed8e77eb549..d534fff5c952 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -404,6 +404,7 @@ static void
 mt7915_tm_init(struct mt7915_phy *phy, bool en)
 {
 	struct mt7915_dev *dev = phy->dev;
+	int state;
 
 	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
@@ -415,7 +416,8 @@ mt7915_tm_init(struct mt7915_phy *phy, bool en)
 	mt7915_tm_set_trx(phy, TM_MAC_TXRX, !en);
 
 	mt7915_mcu_add_bss_info(phy, phy->monitor_vif, en);
-	mt7915_mcu_add_sta(dev, phy->monitor_vif, NULL, en);
+	state = en ? CONN_STATE_PORT_SECURE : CONN_STATE_DISCONNECT;
+	mt7915_mcu_add_sta(dev, phy->monitor_vif, NULL, state, true);
 
 	if (!en)
 		mt7915_tm_set_tam_arb(phy, en, 0);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 1d61d3c62fbb..5f6fb5e3ec5b 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -313,6 +313,9 @@ __mt76_tx_queue_skb(struct mt76_phy *phy, int qid, struct sk_buff *skb,
 		return idx;
 
 	wcid = (struct mt76_wcid *)sta->drv_priv;
+	if (!wcid->sta)
+		return idx;
+
 	q->entry[idx].wcid = wcid->idx;
 
 	if (!non_aql)
-- 
2.44.0


