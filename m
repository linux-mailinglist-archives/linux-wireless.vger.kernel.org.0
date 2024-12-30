Return-Path: <linux-wireless+bounces-16920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613759FEA6A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248C71882BF7
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EBD19D093;
	Mon, 30 Dec 2024 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="gnBCp0nM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F119ABA3
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587735; cv=none; b=ANOJhlmJgxrwFX4R1N3c9+Z1INNu0xsoeBIGv/CE3gcfIMpBj0g8J4bQiSNy1fRMNyIdt2f46Mv0sfaoiA6As+fcSWwyFcQNSHLLgj+UyRC3/JghdillT/S5E51ElhdA2tt6TqO92A32tVc17UQcefeJh1vpAW/kk5znpYwxQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587735; c=relaxed/simple;
	bh=io7N2MmPWWcDg7fxr8+p2eGOIFzyDBNutco1dOZACOg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pi3u6lGzEkOs8SldP7oLjac9gtKIknG4/jLgwObOB+FQpAzgdLPaRAG706r0v8P4Ht1YTlshd0gu5FHBkM7oE7bsJFsSZSKNqwGQTkPDbegVQmdwZbR3P3G1bjGhsx+21hifUTOWISS2jrj22/wEL4GrRVNba9CQdJTArbrw65s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=gnBCp0nM; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iUi1I6JzvhVPgnA+V+11KUAcbmqf2+1Hp/JBd0dbOJY=; b=gnBCp0nMejsNmmjHF4ozpqXNw+
	pLferni0JUFCbNqsE312tGWG466rf09X6f+6W+chZhH8cwt7g6k+2NkySgLIVU7ksgK7TABC1CrO7
	1xr77kHaGU/qgf1eaQ3qcjx8XKH3DQxiloIvC1XgKL4qGMz+S6A1HZwlQFByXf7Szc6A=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeV-00GKzc-1w
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:11 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 13/14] wifi: mt76: mt7996: use mac80211 .sta_state op
Date: Mon, 30 Dec 2024 20:42:01 +0100
Message-ID: <20241230194202.95065-13-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230194202.95065-1-nbd@nbd.name>
References: <20241230194202.95065-1-nbd@nbd.name>
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
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 89 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  6 +-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |  1 +
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  4 +-
 4 files changed, 61 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index d76a9dcfd148..a1f091dff26a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -246,7 +246,7 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	 * interface, since firmware only records BSSID when the entry is new
 	 */
 	if (vif->type != NL80211_IFTYPE_STATION)
-		mt7996_mcu_add_sta(dev, vif, NULL, true, true);
+		mt7996_mcu_add_sta(dev, vif, NULL, CONN_STATE_PORT_SECURE, true);
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
 
 out:
@@ -264,7 +264,7 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	int idx = msta->wcid.idx;
 
-	mt7996_mcu_add_sta(dev, vif, NULL, false, false);
+	mt7996_mcu_add_sta(dev, vif, NULL, CONN_STATE_DISCONNECT, false);
 	mt7996_mcu_add_bss_info(phy, vif, false);
 	mt7996_mcu_add_dev_info(phy, vif, false);
 
@@ -333,6 +333,9 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		return -EOPNOTSUPP;
 
+	if (sta && !wcid->sta)
+		return -EOPNOTSUPP;
+
 	/* fall back to sw encryption for unsupported ciphers */
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
@@ -592,7 +595,7 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 	    (changed & BSS_CHANGED_ASSOC && vif->cfg.assoc) ||
 	    (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon)) {
 		mt7996_mcu_add_bss_info(phy, vif, true);
-		mt7996_mcu_add_sta(dev, vif, NULL, true,
+		mt7996_mcu_add_sta(dev, vif, NULL, CONN_STATE_PORT_SECURE,
 				   !!(changed & BSS_CHANGED_BSSID));
 	}
 
@@ -663,7 +666,7 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	u8 band_idx = mvif->phy->mt76->band_idx;
-	int ret, idx;
+	int idx;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
 	if (idx < 0)
@@ -675,18 +678,53 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
 	msta->wcid.phy_idx = band_idx;
-	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 
 	ewma_avg_signal_init(&msta->avg_ack_signal);
 
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	mt7996_mcu_add_sta(dev, vif, sta, CONN_STATE_DISCONNECT, true);
 
-	ret = mt7996_mcu_add_sta(dev, vif, sta, true, true);
-	if (ret)
-		return ret;
+	return 0;
+}
 
-	return mt7996_mcu_add_rate_ctrl(dev, vif, sta, false);
+int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	int i, ret;
+
+	switch (ev) {
+	case MT76_STA_EVENT_ASSOC:
+		ret = mt7996_mcu_add_sta(dev, vif, sta, CONN_STATE_CONNECT, true);
+		if (ret)
+			return ret;
+
+		ret = mt7996_mcu_add_rate_ctrl(dev, vif, sta, false);
+		if (ret)
+			return ret;
+
+		msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+		msta->wcid.sta = 1;
+
+		return 0;
+
+	case MT76_STA_EVENT_AUTHORIZE:
+		return mt7996_mcu_add_sta(dev, vif, sta, CONN_STATE_PORT_SECURE, false);
+
+	case MT76_STA_EVENT_DISASSOC:
+		for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
+			mt7996_mac_twt_teardown_flow(dev, msta, i);
+
+		mt7996_mcu_add_sta(dev, vif, sta, CONN_STATE_DISCONNECT, false);
+		msta->wcid.sta_disabled = 1;
+		msta->wcid.sta = 0;
+
+		return 0;
+	}
+
+	return 0;
 }
 
 void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
@@ -694,16 +732,10 @@ void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	int i;
-
-	mt7996_mcu_add_sta(dev, vif, sta, false, false);
 
 	mt7996_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
-		mt7996_mac_twt_teardown_flow(dev, msta, i);
-
 	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&msta->wcid.poll_list))
 		list_del_init(&msta->wcid.poll_list);
@@ -808,22 +840,6 @@ mt7996_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return ret;
 }
 
-static int
-mt7996_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-	       struct ieee80211_sta *sta)
-{
-	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NOTEXIST,
-			      IEEE80211_STA_NONE);
-}
-
-static int
-mt7996_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		  struct ieee80211_sta *sta)
-{
-	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NONE,
-			      IEEE80211_STA_NOTEXIST);
-}
-
 static int
 mt7996_get_stats(struct ieee80211_hw *hw,
 		 struct ieee80211_low_level_stats *stats)
@@ -1100,6 +1116,9 @@ static void mt7996_sta_set_4addr(struct ieee80211_hw *hw,
 	else
 		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
 
+	if (!msta->wcid.sta)
+		return;
+
 	mt7996_mcu_wtbl_update_hdr_trans(dev, vif, sta);
 }
 
@@ -1116,6 +1135,9 @@ static void mt7996_sta_set_decap_offload(struct ieee80211_hw *hw,
 	else
 		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
 
+	if (!msta->wcid.sta)
+		return;
+
 	mt7996_mcu_wtbl_update_hdr_trans(dev, vif, sta);
 }
 
@@ -1429,7 +1451,7 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	if (!mtk_wed_device_active(wed))
 		return -ENODEV;
 
-	if (msta->wcid.idx > MT7996_WTBL_STA)
+	if (!msta->wcid.sta || msta->wcid.idx > MT7996_WTBL_STA)
 		return -EIO;
 
 	path->type = DEV_PATH_MTK_WDMA;
@@ -1461,8 +1483,7 @@ const struct ieee80211_ops mt7996_ops = {
 	.conf_tx = mt7996_conf_tx,
 	.configure_filter = mt7996_configure_filter,
 	.bss_info_changed = mt7996_bss_info_changed,
-	.sta_add = mt7996_sta_add,
-	.sta_remove = mt7996_sta_remove,
+	.sta_state = mt76_sta_state,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.link_sta_rc_update = mt7996_sta_rc_update,
 	.set_key = mt7996_set_key,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 29b6e0565868..b3c7f4196ab4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2169,13 +2169,12 @@ mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 }
 
 int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable, bool newly)
+		       struct ieee80211_sta *sta, int conn_state, bool newly)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct ieee80211_link_sta *link_sta;
 	struct mt7996_sta *msta;
 	struct sk_buff *skb;
-	int conn_state;
 	int ret;
 
 	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->sta;
@@ -2188,11 +2187,10 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	conn_state = enable ? CONN_STATE_PORT_SECURE : CONN_STATE_DISCONNECT;
 	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, link_sta,
 				      conn_state, newly);
 
-	if (!enable)
+	if (conn_state == CONN_STATE_DISCONNECT)
 		goto out;
 
 	/* starec hdr trans */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 40e45fb2b626..f9aa12866a2e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -618,6 +618,7 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 		.rx_check = mt7996_rx_check,
 		.rx_poll_complete = mt7996_rx_poll_complete,
 		.sta_add = mt7996_mac_sta_add,
+		.sta_event = mt7996_mac_sta_event,
 		.sta_remove = mt7996_mac_sta_remove,
 		.update_survey = mt7996_update_channel,
 		.set_channel = mt7996_set_channel,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index ad10329d6b44..d2bc96877797 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -502,7 +502,7 @@ int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
 int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
 			    struct ieee80211_vif *vif, int enable);
 int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta, bool enable, bool newly);
+		       struct ieee80211_sta *sta, int conn_state, bool newly);
 int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool add);
@@ -626,6 +626,8 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 void mt7996_mac_set_coverage_class(struct mt7996_phy *phy);
 int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
+int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev);
 void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7996_mac_work(struct work_struct *work);
-- 
2.47.1


