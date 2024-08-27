Return-Path: <linux-wireless+bounces-12056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D503796065B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587B61F22199
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107319CCE6;
	Tue, 27 Aug 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="S/M6vU5K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5C19D8A4
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752542; cv=none; b=GdSMOYcosw7Hi1kpDgUwzMi1wxJXkLrAQ7GMXTU7BmHIs4X63uquPVN5sjsIPSVvtXyCYDnoeRvCidQU4YCXrCmJ/ByRj+wY2J8X72u4qi5+WmGE9zWQSwDVraw4AGNQMdLVoConrTZmVXFnsfb9y1k9VdMG7X4lUngWQqkywSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752542; c=relaxed/simple;
	bh=Ub7wW+lpEFlW9sYhYWxBU5Y/2GZP1GOFMEM6PhbZPaU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrPYPf9HLGIA8YvnW+UoVudh8iQUc1rR0wfDPaO4phcrzWKr9lOzF8IMEEZByoFGl+3Af4c34Vg+o36cj7GS4l7AA5AqjBEiOZaSrCHR8MxOwsrxUpTAevodgI01GbZk3k9n0NOqJBqCm29/WpibuTHCR9jV8J7xA5+0dr/eIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=S/M6vU5K; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+iCuPNzA8vAH4d4hXU4WlER5k5mfCXXDVI3hZl3VZe0=; b=S/M6vU5KAtpYchWFOg57Mre5cQ
	womKanTxjLE2P+ePQO8ZTXUAe0f32/NU+Dpkhqm0bXoHU0MO/aU3I6yLo4A4pMNK0+hG2l1rl7tsq
	dE5DZKovvHid3uAB8gvc2BNT6OE4bLSzCmc8HeEw1a/FYjnhQauU3HtpU/NzSuQw9JxQ=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWm-004Ww8-00
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:16 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 12/24] wifi: mt76: mt7915: use mac80211 .sta_state op
Date: Tue, 27 Aug 2024 11:29:59 +0200
Message-ID: <20240827093011.18621-12-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
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
v2:
- fix regressions in vif sta entry update
- avoid using vif sta wcid for unicast tx packets
- fix wcid flag update

 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 105 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  26 ++---
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |   1 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   4 +-
 .../wireless/mediatek/mt76/mt7915/testmode.c  |   4 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |   3 +
 8 files changed, 90 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f1cd9dc86b42..43e743b510ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -347,6 +347,7 @@ struct mt76_wcid {
 	u8 hw_key_idx2;
 
 	u8 sta:1;
+	u8 sta_disabled:1;
 	u8 amsdu:1;
 	u8 phy_idx:2;
 	u8 link_id:4;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 7afb9ac30ab9..3a575cebe4a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -283,7 +283,7 @@ __mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
 	};
 	struct sk_buff *skb;
 
-	if (wcid && !wcid->sta)
+	if (wcid && !wcid->sta && !wcid->sta_disabled)
 		hdr.muar_idx = 0xe;
 
 	mt76_connac_mcu_get_wlan_idx(dev, wcid, &hdr.wlan_idx_lo,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index a89674d6b602..9bf308429db3 100644
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
+	mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_DISCONNECT, false);
 	mt76_wcid_mask_clear(dev->mt76.wcid_mask, mvif->sta.wcid.idx);
 
 	mutex_lock(&dev->mt76.mutex);
@@ -366,6 +366,9 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	int idx = key->keyidx;
 	int err = 0;
 
+	if (sta && !wcid->sta)
+		return -EOPNOTSUPP;
+
 	/* The hardware does not support per-STA RX GTK, fallback
 	 * to software mode for these.
 	 */
@@ -623,7 +626,7 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	if (set_bss_info == 1)
 		mt7915_mcu_add_bss_info(phy, vif, true);
 	if (set_sta == 1)
-		mt7915_mcu_add_sta(dev, vif, NULL, true);
+		mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_PORT_SECURE, false);
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT)
 		mt7915_mac_enable_rtscts(dev, vif, info->use_cts_prot);
@@ -658,7 +661,7 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	if (set_bss_info == 0)
 		mt7915_mcu_add_bss_info(phy, vif, false);
 	if (set_sta == 0)
-		mt7915_mcu_add_sta(dev, vif, NULL, false);
+		mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_DISCONNECT, false);
 
 	mutex_unlock(&dev->mt76.mutex);
 }
@@ -696,7 +699,7 @@ mt7915_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	err = mt7915_mcu_add_bss_info(phy, vif, true);
 	if (err)
 		goto out;
-	err = mt7915_mcu_add_sta(dev, vif, NULL, true);
+	err = mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_PORT_SECURE, false);
 out:
 	mutex_unlock(&dev->mt76.mutex);
 
@@ -710,7 +713,7 @@ mt7915_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7915_mcu_add_sta(dev, vif, NULL, false);
+	mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_DISCONNECT, false);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
@@ -733,8 +736,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	bool ext_phy = mvif->phy != &dev->phy;
-	int ret, idx;
-	u32 addr;
+	int idx;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA);
 	if (idx < 0)
@@ -743,25 +745,61 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	INIT_LIST_HEAD(&msta->rc_list);
 	INIT_LIST_HEAD(&msta->wcid.poll_list);
 	msta->vif = mvif;
-	msta->wcid.sta = 1;
+	msta->wcid.sta_disabled = 1;
 	msta->wcid.idx = idx;
 	msta->wcid.phy_idx = ext_phy;
-	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->jiffies = jiffies;
 
 	ewma_avg_signal_init(&msta->avg_ack_signal);
 
 	mt7915_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+	mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_DISCONNECT, true);
 
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
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	int i, ret;
+	u32 addr;
 
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
+		msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+		msta->wcid.sta = 1;
+		msta->wcid.sta_disabled = 0;
+
+		return 0;
+
+	case MT76_STA_EVENT_AUTHORIZE:
+		return mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_PORT_SECURE, false);
+
+	case MT76_STA_EVENT_DISASSOC:
+		for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
+			mt7915_mac_twt_teardown_flow(dev, msta, i);
+
+		mt7915_mcu_add_sta(dev, vif, sta, CONN_STATE_DISCONNECT, false);
+		msta->wcid.sta_disabled = 1;
+		msta->wcid.sta = 0;
+		return 0;
+	}
+
+	return 0;
 }
 
 void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
@@ -769,16 +807,10 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	int i;
-
-	mt7915_mcu_add_sta(dev, vif, sta, false);
 
 	mt7915_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
-		mt7915_mac_twt_teardown_flow(dev, msta, i);
-
 	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&msta->wcid.poll_list))
 		list_del_init(&msta->wcid.poll_list);
@@ -885,22 +917,6 @@ mt7915_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
@@ -1154,6 +1170,10 @@ static void mt7915_sta_rc_update(struct ieee80211_hw *hw,
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_dev *dev = phy->dev;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+
+	if (!msta->wcid.sta)
+		return;
 
 	mt7915_sta_rc_work(&changed, sta);
 	ieee80211_queue_work(hw, &dev->rc_work);
@@ -1197,6 +1217,9 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 	else
 		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
 
+	if (!msta->wcid.sta)
+		return;
+
 	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
@@ -1213,6 +1236,9 @@ static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
 	else
 		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
 
+	if (!msta->wcid.sta)
+		return;
+
 	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
@@ -1666,8 +1692,7 @@ const struct ieee80211_ops mt7915_ops = {
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
index 10de8b994e2e..2ef8d90132dd 100644
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
@@ -1675,14 +1674,10 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	conn_state = enable ? CONN_STATE_PORT_SECURE : CONN_STATE_DISCONNECT;
-	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, link_sta, conn_state,
-				      !rcu_access_pointer(dev->mt76.wcid[msta->wcid.idx]));
-	if (!enable)
-		goto out;
-
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, link_sta,
+				      conn_state, newly);
 	/* tag order is in accordance with firmware dependency. */
-	if (sta) {
+	if (sta && conn_state != CONN_STATE_DISCONNECT) {
 		/* starec bfer */
 		mt7915_mcu_sta_bfer_tlv(dev, skb, vif, sta);
 		/* starec ht */
@@ -1693,12 +1688,17 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		mt76_connac_mcu_sta_uapsd(skb, vif, sta);
 	}
 
-	ret = mt7915_mcu_sta_wtbl_tlv(dev, skb, vif, sta);
-	if (ret) {
-		dev_kfree_skb(skb);
-		return ret;
+	if (newly || conn_state != CONN_STATE_DISCONNECT) {
+		ret = mt7915_mcu_sta_wtbl_tlv(dev, skb, vif, sta);
+		if (ret) {
+			dev_kfree_skb(skb);
+			return ret;
+		}
 	}
 
+	if (conn_state == CONN_STATE_DISCONNECT)
+		goto out;
+
 	if (sta) {
 		/* starec amsdu */
 		mt7915_mcu_sta_amsdu_tlv(dev, skb, vif, sta);
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
index 7f7783f7d977..7521e739fd37 100644
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
2.46.0


