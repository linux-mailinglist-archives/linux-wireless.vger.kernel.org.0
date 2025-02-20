Return-Path: <linux-wireless+bounces-19202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E58A3DB22
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AA61889034
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8751F5425;
	Thu, 20 Feb 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZZTsprs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6251F540C
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057558; cv=none; b=Y9aMIZqtzoIp6wqP4LpE13WjxICxZjuyTRqwiyJIvERh5GuZ5UUyQl++nPQl95XfdhwanJHLpewwBt5FUsiDIAIRCDbQO5eqocIwUtFpXprSCUaTWSPk/l5mJRlPPI++MdQuSU0NJmASQ7Hz//hVwvXMQ5kdMVUukGuTw4lo3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057558; c=relaxed/simple;
	bh=wNvEobHYd177ihEzLnGgFku/EszYz80xyUis3WN7YYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gU4zqDOMtfRu8JRSGak1zOAIsIUpe8N1Pe/cpCI8tYLGhG8E2eoBUvhTKRVbbpc9PD1N4bXzKKQB+Pk6J+1BqHaqk/lgd/VIRz0NByakhGrcNpzBSJW1r+BBRvREmcWtFQMCElYo2b0LHR1YJjjLHa26Eze/DjZaVvuAcCignhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZZTsprs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0415DC4CED1;
	Thu, 20 Feb 2025 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057557;
	bh=wNvEobHYd177ihEzLnGgFku/EszYz80xyUis3WN7YYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tZZTsprschIjFwXUxfiL9HWJ7GYN81Ph6msU3YCsHTJPi4BkOumgauaeCCL52gX5s
	 eBirnLAIrQ6YNqct7b1fuXSfl9KayfCeIsL1wKdDFq0WkvQ4bP6Ip0Gld8OOGK4kee
	 BtNN8fg0ecM5VrFSfOFyNoI19IuUn8sSfPgOivtKNWMn3I0lcoPNFMAWwTCdVKTbzy
	 tT2lgYxwXuZXsLRBuI4cBznophndk1St4Ncqx5OO4NZmA0iJtDLd6mKQhV8xo21IwQ
	 +yFg0XrbC23Ybh4cT8N8Bgv5P/sCXRAWhqMlDhJMaz0x/B895i3h2mnE6mK6PFEMHx
	 jhY2GMGWM1aIg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:18:48 +0100
Subject: [PATCH 02/14] wifi: mt76: mt7996: Introduce mt7996_sta_link
 container
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-2-34c4abb37158@kernel.org>
References: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
In-Reply-To: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Similar to mt7996_vif_link, add mt7996_sta_link structure as driver
representation for sta links. This is a preliminary patch to introduce
MLO support for MT7996 driver.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 117 +++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 136 +++++++++++----------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  33 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  10 +-
 5 files changed, 181 insertions(+), 127 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 7b2bb72b407dac53e520f4220eedc5cc38702acd..d453c2fc97e4fad10a29093b70e2ede8375ee0d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -617,13 +617,14 @@ mt7996_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_dev *dev = msta->vif->deflink.phy->dev;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct seq_file *s = data;
 	u8 ac;
 
 	for (ac = 0; ac < 4; ac++) {
 		u32 qlen, ctrl, val;
-		u32 idx = msta->wcid.idx >> 5;
-		u8 offs = msta->wcid.idx & GENMASK(4, 0);
+		u32 idx = msta_link->wcid.idx >> 5;
+		u8 offs = msta_link->wcid.idx & GENMASK(4, 0);
 
 		ctrl = BIT(31) | BIT(11) | (ac << 24);
 		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(ac, idx));
@@ -631,11 +632,11 @@ mt7996_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 		if (val & BIT(offs))
 			continue;
 
-		mt76_wr(dev, MT_FL_Q0_CTRL, ctrl | msta->wcid.idx);
+		mt76_wr(dev, MT_FL_Q0_CTRL, ctrl | msta_link->wcid.idx);
 		qlen = mt76_get_field(dev, MT_FL_Q3_CTRL,
 				      GENMASK(11, 0));
 		seq_printf(s, "\tSTA %pM wcid %d: AC%d%d queued:%d\n",
-			   sta->addr, msta->wcid.idx,
+			   sta->addr, msta_link->wcid.idx,
 			   msta->vif->deflink.mt76.wmm_idx, ac, qlen);
 	}
 }
@@ -930,6 +931,7 @@ static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
 	struct ieee80211_sta *sta = file->private_data;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_dev *dev = msta->vif->deflink.phy->dev;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct ra_rate phy = {};
 	char buf[100];
 	int ret;
@@ -964,7 +966,7 @@ static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
 		goto out;
 	}
 
-	phy.wlan_idx = cpu_to_le16(msta->wcid.idx);
+	phy.wlan_idx = cpu_to_le16(msta_link->wcid.idx);
 	phy.gi = cpu_to_le16(gi);
 	phy.ltf = cpu_to_le16(ltf);
 	phy.ldpc = phy.ldpc ? 7 : 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index bc8cba4dca47cf7b0c9eb448740773f1d4e1dab9..a2983b23fbe1cef7512eb056b0dcefc9aa928b67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -55,7 +55,8 @@ static const struct mt7996_dfs_radar_spec jp_radar_specs = {
 static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
 					    u16 idx, bool unicast)
 {
-	struct mt7996_sta *sta;
+	struct mt7996_sta_link *msta_link;
+	struct mt7996_sta *msta;
 	struct mt76_wcid *wcid;
 
 	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
@@ -68,11 +69,13 @@ static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
 	if (!wcid->sta)
 		return NULL;
 
-	sta = container_of(wcid, struct mt7996_sta, wcid);
-	if (!sta->vif)
+	msta_link = container_of(wcid, struct mt7996_sta_link, wcid);
+	msta = msta_link->sta;
+
+	if (!msta->vif)
 		return NULL;
 
-	return &sta->vif->deflink.sta.wcid;
+	return &msta->vif->deflink.sta.deflink.wcid;
 }
 
 bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask)
@@ -100,6 +103,7 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		[IEEE80211_AC_VI] = 4,
 		[IEEE80211_AC_VO] = 6
 	};
+	struct mt7996_sta_link *msta_link;
 	struct ieee80211_sta *sta;
 	struct mt7996_sta *msta;
 	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
@@ -123,25 +127,27 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 			spin_unlock_bh(&dev->mt76.sta_poll_lock);
 			break;
 		}
-		msta = list_first_entry(&sta_poll_list,
-					struct mt7996_sta, wcid.poll_list);
-		list_del_init(&msta->wcid.poll_list);
+		msta_link = list_first_entry(&sta_poll_list,
+					     struct mt7996_sta_link,
+					     wcid.poll_list);
+		msta = msta_link->sta;
+		list_del_init(&msta_link->wcid.poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-		idx = msta->wcid.idx;
+		idx = msta_link->wcid.idx;
 
 		/* refresh peer's airtime reporting */
 		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 20);
 
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			u32 tx_last = msta->airtime_ac[i];
-			u32 rx_last = msta->airtime_ac[i + 4];
+			u32 tx_last = msta_link->airtime_ac[i];
+			u32 rx_last = msta_link->airtime_ac[i + 4];
 
-			msta->airtime_ac[i] = mt76_rr(dev, addr);
-			msta->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
+			msta_link->airtime_ac[i] = mt76_rr(dev, addr);
+			msta_link->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
 
-			tx_time[i] = msta->airtime_ac[i] - tx_last;
-			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
+			tx_time[i] = msta_link->airtime_ac[i] - tx_last;
+			rx_time[i] = msta_link->airtime_ac[i + 4] - rx_last;
 
 			if ((tx_last | rx_last) & BIT(30))
 				clear = true;
@@ -152,10 +158,11 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		if (clear) {
 			mt7996_mac_wtbl_update(dev, idx,
 					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+			memset(msta_link->airtime_ac, 0,
+			       sizeof(msta_link->airtime_ac));
 		}
 
-		if (!msta->wcid.sta)
+		if (!msta_link->wcid.sta)
 			continue;
 
 		sta = container_of((void *)msta, struct ieee80211_sta,
@@ -181,10 +188,11 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
 		rssi[3] = to_rssi(GENMASK(31, 14), val);
 
-		msta->ack_signal =
+		msta_link->ack_signal =
 			mt76_rx_signal(msta->vif->deflink.phy->mt76->antenna_mask, rssi);
 
-		ewma_avg_signal_add(&msta->avg_ack_signal, -msta->ack_signal);
+		ewma_avg_signal_add(&msta_link->avg_ack_signal,
+				    -msta_link->ack_signal);
 	}
 
 	rcu_read_unlock();
@@ -194,9 +202,10 @@ void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
 			      struct ieee80211_vif *vif, bool enable)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta_link *msta_link = &mvif->deflink.sta.deflink;
 	u32 addr;
 
-	addr = mt7996_mac_wtbl_lmac_addr(dev, mvif->deflink.sta.wcid.idx, 5);
+	addr = mt7996_mac_wtbl_lmac_addr(dev, msta_link->wcid.idx, 5);
 	if (enable)
 		mt76_set(dev, addr, BIT(5));
 	else
@@ -477,8 +486,12 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 	status->wcid = mt7996_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
-		msta = container_of(status->wcid, struct mt7996_sta, wcid);
-		mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
+		struct mt7996_sta_link *msta_link;
+
+		msta_link = container_of(status->wcid, struct mt7996_sta_link,
+					 wcid);
+		msta = msta_link->sta;
+		mt76_wcid_add_poll(&dev->mt76, &msta_link->wcid);
 	}
 
 	status->freq = mphy->chandef.chan->center_freq;
@@ -1027,9 +1040,10 @@ u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id)
 static void
 mt7996_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb)
 {
-	struct mt7996_sta *msta;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	struct mt7996_sta_link *msta_link;
+	struct mt7996_sta *msta;
 	u16 fc, tid;
 
 	if (!sta || !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
@@ -1058,7 +1072,9 @@ mt7996_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb)
 		return;
 
 	msta = (struct mt7996_sta *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &msta->wcid.ampdu_state))
+	msta_link = &msta->deflink;
+
+	if (!test_and_set_bit(tid, &msta_link->wcid.ampdu_state))
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
@@ -1136,7 +1152,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 		 */
 		info = le32_to_cpu(*cur_info);
 		if (info & MT_TXFREE_INFO_PAIR) {
-			struct mt7996_sta *msta;
+			struct mt7996_sta_link *msta_link;
 			u16 idx;
 
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
@@ -1145,8 +1161,9 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			if (!sta)
 				continue;
 
-			msta = container_of(wcid, struct mt7996_sta, wcid);
-			mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
+			msta_link = container_of(wcid, struct mt7996_sta_link,
+						 wcid);
+			mt76_wcid_add_poll(&dev->mt76, &msta_link->wcid);
 			continue;
 		} else if (info & MT_TXFREE_INFO_HEADER) {
 			u32 tx_retries = 0, tx_failed = 0;
@@ -1344,7 +1361,7 @@ mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid,
 
 static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 {
-	struct mt7996_sta *msta = NULL;
+	struct mt7996_sta_link *msta_link;
 	struct mt76_wcid *wcid;
 	__le32 *txs_data = data;
 	u16 wcidx;
@@ -1365,14 +1382,13 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	if (!wcid)
 		goto out;
 
-	msta = container_of(wcid, struct mt7996_sta, wcid);
-
 	mt7996_mac_add_txs_skb(dev, wcid, pid, txs_data);
 
 	if (!wcid->sta)
 		goto out;
 
-	mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
+	msta_link = container_of(wcid, struct mt7996_sta_link, wcid);
+	mt76_wcid_add_poll(&dev->mt76, &msta_link->wcid);
 
 out:
 	rcu_read_unlock();
@@ -2239,6 +2255,7 @@ void mt7996_mac_update_stats(struct mt7996_phy *phy)
 void mt7996_mac_sta_rc_work(struct work_struct *work)
 {
 	struct mt7996_dev *dev = container_of(work, struct mt7996_dev, rc_work);
+	struct mt7996_sta_link *msta_link;
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 	struct mt7996_sta *msta;
@@ -2249,12 +2266,15 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 	list_splice_init(&dev->sta_rc_list, &list);
 
 	while (!list_empty(&list)) {
-		msta = list_first_entry(&list, struct mt7996_sta, rc_list);
-		list_del_init(&msta->rc_list);
-		changed = msta->changed;
-		msta->changed = 0;
+		msta_link = list_first_entry(&list, struct mt7996_sta_link,
+					     rc_list);
+		list_del_init(&msta_link->rc_list);
+
+		changed = msta_link->changed;
+		msta_link->changed = 0;
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
+		msta = msta_link->sta;
 		sta = container_of((void *)msta, struct ieee80211_sta, drv_priv);
 		vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
 
@@ -2538,7 +2558,7 @@ static int mt7996_mac_check_twt_req(struct ieee80211_twt_setup *twt)
 }
 
 static bool
-mt7996_mac_twt_param_equal(struct mt7996_sta *msta,
+mt7996_mac_twt_param_equal(struct mt7996_sta_link *msta_link,
 			   struct ieee80211_twt_params *twt_agrt)
 {
 	u16 type = le16_to_cpu(twt_agrt->req_type);
@@ -2549,10 +2569,10 @@ mt7996_mac_twt_param_equal(struct mt7996_sta *msta,
 	for (i = 0; i < MT7996_MAX_STA_TWT_AGRT; i++) {
 		struct mt7996_twt_flow *f;
 
-		if (!(msta->twt.flowid_mask & BIT(i)))
+		if (!(msta_link->twt.flowid_mask & BIT(i)))
 			continue;
 
-		f = &msta->twt.flow[i];
+		f = &msta_link->twt.flow[i];
 		if (f->duration == twt_agrt->min_twt_dur &&
 		    f->mantissa == twt_agrt->mantissa &&
 		    f->exp == exp &&
@@ -2572,6 +2592,7 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	enum ieee80211_twt_setup_cmd setup_cmd = TWT_SETUP_CMD_REJECT;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct ieee80211_twt_params *twt_agrt = (void *)twt->params;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	u16 req_type = le16_to_cpu(twt_agrt->req_type);
 	enum ieee80211_twt_setup_cmd sta_setup_cmd;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
@@ -2586,7 +2607,8 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	if (dev->twt.n_agrt == MT7996_MAX_TWT_AGRT)
 		goto unlock;
 
-	if (hweight8(msta->twt.flowid_mask) == ARRAY_SIZE(msta->twt.flow))
+	if (hweight8(msta_link->twt.flowid_mask) ==
+	    ARRAY_SIZE(msta_link->twt.flow))
 		goto unlock;
 
 	if (twt_agrt->min_twt_dur < MT7996_MIN_TWT_DUR) {
@@ -2595,10 +2617,10 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 		goto unlock;
 	}
 
-	if (mt7996_mac_twt_param_equal(msta, twt_agrt))
+	if (mt7996_mac_twt_param_equal(msta_link, twt_agrt))
 		goto unlock;
 
-	flowid = ffs(~msta->twt.flowid_mask) - 1;
+	flowid = ffs(~msta_link->twt.flowid_mask) - 1;
 	twt_agrt->req_type &= ~cpu_to_le16(IEEE80211_TWT_REQTYPE_FLOWID);
 	twt_agrt->req_type |= le16_encode_bits(flowid,
 					       IEEE80211_TWT_REQTYPE_FLOWID);
@@ -2607,10 +2629,10 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, req_type);
 	sta_setup_cmd = FIELD_GET(IEEE80211_TWT_REQTYPE_SETUP_CMD, req_type);
 
-	flow = &msta->twt.flow[flowid];
+	flow = &msta_link->twt.flow[flowid];
 	memset(flow, 0, sizeof(*flow));
 	INIT_LIST_HEAD(&flow->list);
-	flow->wcid = msta->wcid.idx;
+	flow->wcid = msta_link->wcid.idx;
 	flow->table_id = table_id;
 	flow->id = flowid;
 	flow->duration = twt_agrt->min_twt_dur;
@@ -2642,7 +2664,7 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 
 	setup_cmd = TWT_SETUP_CMD_ACCEPT;
 	dev->twt.table_mask |= BIT(table_id);
-	msta->twt.flowid_mask |= BIT(flowid);
+	msta_link->twt.flowid_mask |= BIT(flowid);
 	dev->twt.n_agrt++;
 
 unlock:
@@ -2658,23 +2680,24 @@ void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
 				  struct mt7996_sta *msta,
 				  u8 flowid)
 {
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct mt7996_twt_flow *flow;
 
 	lockdep_assert_held(&dev->mt76.mutex);
 
-	if (flowid >= ARRAY_SIZE(msta->twt.flow))
+	if (flowid >= ARRAY_SIZE(msta_link->twt.flow))
 		return;
 
-	if (!(msta->twt.flowid_mask & BIT(flowid)))
+	if (!(msta_link->twt.flowid_mask & BIT(flowid)))
 		return;
 
-	flow = &msta->twt.flow[flowid];
+	flow = &msta_link->twt.flow[flowid];
 	if (mt7996_mcu_twt_agrt_update(dev, msta->vif, flow,
 				       MCU_TWT_AGRT_DELETE))
 		return;
 
 	list_del_init(&flow->list);
-	msta->twt.flowid_mask &= ~BIT(flowid);
+	msta_link->twt.flowid_mask &= ~BIT(flowid);
 	dev->twt.table_mask &= ~BIT(flow->table_id);
 	dev->twt.n_agrt--;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ae603f1c098e16bd989b7b1579d22e0ad7dfb49b..b1f325e062b84ad344836050ad0d5fa6ec414514 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -163,7 +163,7 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_sta *msta = sta ? (struct mt7996_sta *)sta->drv_priv :
 				  &mlink->sta;
-	struct mt76_wcid *wcid = &msta->wcid;
+	struct mt76_wcid *wcid = &msta->deflink.wcid;
 	u8 *wcid_keyidx = &wcid->hw_key_idx;
 	struct mt7996_phy *phy;
 	int idx = key->keyidx;
@@ -208,8 +208,7 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return mt7996_mcu_bcn_prot_enable(dev, vif, key);
 
 	return mt7996_mcu_add_key(&dev->mt76, vif, key,
-				  MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
-				  &msta->wcid, cmd);
+				  MCU_WMWA_UNI_CMD(STA_REC_UPDATE), wcid, cmd);
 }
 
 static void
@@ -230,6 +229,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 			struct mt76_vif_link *mlink)
 {
 	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
+	struct mt7996_sta_link *msta_link = &link->sta.deflink;
 	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
 	u8 band_idx = phy->mt76->band_idx;
@@ -248,7 +248,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	mlink->omac_idx = idx;
 	mlink->band_idx = band_idx;
 	mlink->wmm_idx = vif->type == NL80211_IFTYPE_AP ? 0 : 3;
-	mlink->wcid = &link->sta.wcid;
+	mlink->wcid = &msta_link->wcid;
 
 	ret = mt7996_mcu_add_dev_info(phy, vif, link_conf, mlink, true);
 	if (ret)
@@ -259,10 +259,11 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 	idx = MT7996_WTBL_RESERVED - mlink->idx;
 
-	INIT_LIST_HEAD(&link->sta.rc_list);
-	link->sta.wcid.idx = idx;
-	link->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_wcid_init(&link->sta.wcid, band_idx);
+	INIT_LIST_HEAD(&msta_link->rc_list);
+	msta_link->sta = &link->sta;
+	msta_link->wcid.idx = idx;
+	msta_link->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt76_wcid_init(&msta_link->wcid, band_idx);
 
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -289,7 +290,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	 */
 	if (vif->type != NL80211_IFTYPE_STATION)
 		mt7996_mcu_add_sta(dev, vif, mlink, NULL, CONN_STATE_PORT_SECURE, true);
-	rcu_assign_pointer(dev->mt76.wcid[idx], &link->sta.wcid);
+	rcu_assign_pointer(dev->mt76.wcid[idx], &msta_link->wcid);
 
 	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, link);
 
@@ -303,11 +304,10 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
 	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
-	struct mt7996_sta *msta;
-	int idx;
+	struct mt7996_sta *msta = &link->sta;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
+	int idx = msta_link->wcid.idx;
 
-	msta = &link->sta;
-	idx = msta->wcid.idx;
 	mt7996_mcu_add_sta(dev, vif, mlink, NULL, CONN_STATE_DISCONNECT, false);
 	mt7996_mcu_add_bss_info(phy, vif, link_conf, mlink, false);
 
@@ -319,11 +319,11 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	phy->omac_mask &= ~BIT_ULL(mlink->omac_idx);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (!list_empty(&msta->wcid.poll_list))
-		list_del_init(&msta->wcid.poll_list);
+	if (!list_empty(&msta_link->wcid.poll_list))
+		list_del_init(&msta_link->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
+	mt76_wcid_cleanup(&dev->mt76, &msta_link->wcid);
 }
 
 static void mt7996_phy_set_rxfilter(struct mt7996_phy *phy)
@@ -760,6 +760,7 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct mt7996_vif_link *link = &mvif->deflink;
 	u8 band_idx = link->phy->mt76->band_idx;
 	int idx;
@@ -768,14 +769,15 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
-	INIT_LIST_HEAD(&msta->rc_list);
-	INIT_LIST_HEAD(&msta->wcid.poll_list);
 	msta->vif = mvif;
-	msta->wcid.sta = 1;
-	msta->wcid.idx = idx;
-	msta->wcid.phy_idx = band_idx;
+	INIT_LIST_HEAD(&msta_link->rc_list);
+	INIT_LIST_HEAD(&msta_link->wcid.poll_list);
+	msta_link->sta = msta;
+	msta_link->wcid.sta = 1;
+	msta_link->wcid.idx = idx;
+	msta_link->wcid.phy_idx = band_idx;
 
-	ewma_avg_signal_init(&msta->avg_ack_signal);
+	ewma_avg_signal_init(&msta_link->avg_ack_signal);
 
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -790,6 +792,7 @@ int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_vif_link *link = &mvif->deflink;
 	int i, ret;
@@ -805,8 +808,8 @@ int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		if (ret)
 			return ret;
 
-		msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-		msta->wcid.sta = 1;
+		msta_link->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+		msta_link->wcid.sta = 1;
 
 		return 0;
 
@@ -815,13 +818,13 @@ int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 					  CONN_STATE_PORT_SECURE, false);
 
 	case MT76_STA_EVENT_DISASSOC:
-		for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
+		for (i = 0; i < ARRAY_SIZE(msta_link->twt.flow); i++)
 			mt7996_mac_twt_teardown_flow(dev, msta, i);
 
 		mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
 				   CONN_STATE_DISCONNECT, false);
-		msta->wcid.sta_disabled = 1;
-		msta->wcid.sta = 0;
+		msta_link->wcid.sta_disabled = 1;
+		msta_link->wcid.sta = 0;
 
 		return 0;
 	}
@@ -834,15 +837,16 @@ void mt7996_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 
-	mt7996_mac_wtbl_update(dev, msta->wcid.idx,
+	mt7996_mac_wtbl_update(dev, msta_link->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	spin_lock_bh(&mdev->sta_poll_lock);
-	if (!list_empty(&msta->wcid.poll_list))
-		list_del_init(&msta->wcid.poll_list);
-	if (!list_empty(&msta->rc_list))
-		list_del_init(&msta->rc_list);
+	if (!list_empty(&msta_link->wcid.poll_list))
+		list_del_init(&msta_link->wcid.poll_list);
+	if (!list_empty(&msta_link->rc_list))
+		list_del_init(&msta_link->rc_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
 }
 
@@ -860,7 +864,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 		struct mt7996_vif *mvif;
 
 		mvif = (struct mt7996_vif *)vif->drv_priv;
-		wcid = &mvif->deflink.sta.wcid;
+		wcid = &mvif->deflink.sta.deflink.wcid;
 
 		if (mvif->mt76.roc_phy &&
 		    (info->flags & IEEE80211_TX_CTL_TX_OFFCHAN)) {
@@ -873,10 +877,10 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 	}
 
 	if (control->sta) {
-		struct mt7996_sta *sta;
+		struct mt7996_sta_link *msta_link;
 
-		sta = (struct mt7996_sta *)control->sta->drv_priv;
-		wcid = &sta->wcid;
+		msta_link = (struct mt7996_sta_link *)control->sta->drv_priv;
+		wcid = &msta_link->wcid;
 	}
 
 	if (!mphy) {
@@ -916,6 +920,7 @@ mt7996_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct ieee80211_sta *sta = params->sta;
 	struct ieee80211_txq *txq = sta->txq[params->tid];
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	u16 tid = params->tid;
 	u16 ssn = params->ssn;
 	struct mt76_txq *mtxq;
@@ -929,12 +934,12 @@ mt7996_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mutex_lock(&dev->mt76.mutex);
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
-		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
+		mt76_rx_aggr_start(&dev->mt76, &msta_link->wcid, tid, ssn,
 				   params->buf_size);
 		ret = mt7996_mcu_add_rx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
-		mt76_rx_aggr_stop(&dev->mt76, &msta->wcid, tid);
+		mt76_rx_aggr_stop(&dev->mt76, &msta_link->wcid, tid);
 		ret = mt7996_mcu_add_rx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
@@ -945,16 +950,16 @@ mt7996_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->wcid.ampdu_state);
+		clear_bit(tid, &msta_link->wcid.ampdu_state);
 		ret = mt7996_mcu_add_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		set_bit(tid, &msta->wcid.ampdu_state);
+		set_bit(tid, &msta_link->wcid.ampdu_state);
 		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->wcid.ampdu_state);
+		clear_bit(tid, &msta_link->wcid.ampdu_state);
 		ret = mt7996_mcu_add_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
@@ -1145,7 +1150,8 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct rate_info *txrate = &msta->wcid.rate;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
+	struct rate_info *txrate = &msta_link->wcid.rate;
 
 	if (txrate->legacy || txrate->flags) {
 		if (txrate->legacy) {
@@ -1165,29 +1171,30 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->txrate.flags = txrate->flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 
-	sinfo->tx_failed = msta->wcid.stats.tx_failed;
+	sinfo->tx_failed = msta_link->wcid.stats.tx_failed;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 
-	sinfo->tx_retries = msta->wcid.stats.tx_retries;
+	sinfo->tx_retries = msta_link->wcid.stats.tx_retries;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 
-	sinfo->ack_signal = (s8)msta->ack_signal;
+	sinfo->ack_signal = (s8)msta_link->ack_signal;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
 
-	sinfo->avg_ack_signal = -(s8)ewma_avg_signal_read(&msta->avg_ack_signal);
+	sinfo->avg_ack_signal =
+		-(s8)ewma_avg_signal_read(&msta_link->avg_ack_signal);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
-		sinfo->tx_bytes = msta->wcid.stats.tx_bytes;
+		sinfo->tx_bytes = msta_link->wcid.stats.tx_bytes;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
 
-		sinfo->rx_bytes = msta->wcid.stats.rx_bytes;
+		sinfo->rx_bytes = msta_link->wcid.stats.rx_bytes;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
 
-		sinfo->tx_packets = msta->wcid.stats.tx_packets;
+		sinfo->tx_packets = msta_link->wcid.stats.tx_packets;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
 
-		sinfo->rx_packets = msta->wcid.stats.rx_packets;
+		sinfo->rx_packets = msta_link->wcid.stats.rx_packets;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
 	}
 }
@@ -1196,12 +1203,13 @@ static void mt7996_sta_rc_work(void *data, struct ieee80211_sta *sta)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_dev *dev = msta->vif->deflink.phy->dev;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	u32 *changed = data;
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	msta->changed |= *changed;
-	if (list_empty(&msta->rc_list))
-		list_add_tail(&msta->rc_list, &dev->sta_rc_list);
+	msta_link->changed |= *changed;
+	if (list_empty(&msta_link->rc_list))
+		list_add_tail(&msta_link->rc_list, &dev->sta_rc_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 }
 
@@ -1248,13 +1256,14 @@ static void mt7996_sta_set_4addr(struct ieee80211_hw *hw,
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 
 	if (enabled)
-		set_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
+		set_bit(MT_WCID_FLAG_4ADDR, &msta_link->wcid.flags);
 	else
-		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
+		clear_bit(MT_WCID_FLAG_4ADDR, &msta_link->wcid.flags);
 
-	if (!msta->wcid.sta)
+	if (!msta_link->wcid.sta)
 		return;
 
 	mt7996_mcu_wtbl_update_hdr_trans(dev, vif, sta);
@@ -1267,13 +1276,14 @@ static void mt7996_sta_set_decap_offload(struct ieee80211_hw *hw,
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 
 	if (enabled)
-		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta_link->wcid.flags);
 	else
-		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta_link->wcid.flags);
 
-	if (!msta->wcid.sta)
+	if (!msta_link->wcid.sta)
 		return;
 
 	mt7996_mcu_wtbl_update_hdr_trans(dev, vif, sta);
@@ -1408,11 +1418,12 @@ static void mt7996_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 {
 	struct mt76_ethtool_worker_info *wi = wi_data;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 
 	if (msta->vif->deflink.mt76.idx != wi->idx)
 		return;
 
-	mt76_ethtool_worker(wi, &msta->wcid.stats, true);
+	mt76_ethtool_worker(wi, &msta_link->wcid.stats, true);
 }
 
 static
@@ -1589,6 +1600,7 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct mt7996_vif_link *mlink = &mvif->deflink;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
@@ -1604,7 +1616,7 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	if (!mtk_wed_device_active(wed))
 		return -ENODEV;
 
-	if (!msta->wcid.sta || msta->wcid.idx > MT7996_WTBL_STA)
+	if (!msta_link->wcid.sta || msta_link->wcid.idx > MT7996_WTBL_STA)
 		return -EIO;
 
 	path->type = DEV_PATH_MTK_WDMA;
@@ -1612,7 +1624,7 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	path->mtk_wdma.wdma_idx = wed->wdma_idx;
 	path->mtk_wdma.bss = mvif->deflink.mt76.idx;
 	path->mtk_wdma.queue = 0;
-	path->mtk_wdma.wcid = msta->wcid.idx;
+	path->mtk_wdma.wcid = msta_link->wcid.idx;
 
 	path->mtk_wdma.amsdu = mtk_wed_is_amsdu_supported(wed);
 	ctx->dev = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index e4569d032221427bf845192acb07b87816b91fd7..51d2c541801f998014b2eecb8d34dd49e5598df7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1162,10 +1162,11 @@ int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 			 bool enable)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)params->sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct mt7996_vif *mvif = msta->vif;
 
 	if (enable && !params->amsdu)
-		msta->wcid.amsdu = false;
+		msta_link->wcid.amsdu = false;
 
 	return mt7996_mcu_sta_ba(dev, &mvif->deflink.mt76, params, enable, true);
 }
@@ -1322,6 +1323,7 @@ mt7996_mcu_sta_amsdu_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 			 struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct sta_rec_amsdu *amsdu;
 	struct tlv *tlv;
 
@@ -1337,7 +1339,7 @@ mt7996_mcu_sta_amsdu_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	amsdu = (struct sta_rec_amsdu *)tlv;
 	amsdu->max_amsdu_num = 8;
 	amsdu->amsdu_en = true;
-	msta->wcid.amsdu = true;
+	msta_link->wcid.amsdu = true;
 
 	switch (sta->deflink.agg.max_amsdu_len) {
 	case IEEE80211_MAX_MPDU_LEN_VHT_11454:
@@ -1879,13 +1881,14 @@ int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct sta_phy_uni *phy = data;
 	struct sta_rec_ra_fixed_uni *ra;
 	struct sk_buff *skb;
 	struct tlv *tlv;
 
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
-					      &msta->wcid,
+					      &msta_link->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -1972,14 +1975,14 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct ieee80211_vif *vif
 	/* fixed GI */
 	if (mask->control[band].gi != NL80211_TXRATE_DEFAULT_GI ||
 	    mask->control[band].he_gi != GENMASK(7, 0)) {
-		struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+		struct mt7996_sta_link *msta_link = (void *)sta->drv_priv;
 		u32 addr;
 
 		/* firmware updates only TXCMD but doesn't take WTBL into
 		 * account, so driver should update here to reflect the
 		 * actual txrate hardware sends out.
 		 */
-		addr = mt7996_mac_wtbl_lmac_addr(dev, msta->wcid.idx, 7);
+		addr = mt7996_mac_wtbl_lmac_addr(dev, msta_link->wcid.idx, 7);
 		if (sta->deflink.he_cap.has_he)
 			mt76_rmw_field(dev, addr, GENMASK(31, 24), phy.sgi);
 		else
@@ -2113,11 +2116,12 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct sk_buff *skb;
 	int ret;
 
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
-					      &msta->wcid,
+					      &msta_link->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -2148,6 +2152,7 @@ mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 {
 #define MT_STA_BSS_GROUP		1
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta_link *msta_link;
 	struct mt7996_sta *msta;
 	struct {
 		u8 __rsv1[4];
@@ -2167,7 +2172,8 @@ mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	};
 
 	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->deflink.sta;
-	req.wlan_idx = cpu_to_le16(msta->wcid.idx);
+	msta_link = &msta->deflink;
+	req.wlan_idx = cpu_to_le16(msta_link->wcid.idx);
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(VOW), &req,
 				 sizeof(req), true);
@@ -2184,8 +2190,9 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 
 	if (sta) {
 		struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+		struct mt7996_sta_link *msta_link = &msta->deflink;
 
-		wcid = &msta->wcid;
+		wcid = &msta_link->wcid;
 		link_sta = &sta->deflink;
 	}
 
@@ -2312,12 +2319,14 @@ static int mt7996_mcu_get_pn(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 {
 #define TSC_TYPE_BIGTK_PN 2
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta_link *msta_link = &mvif->deflink.sta.deflink;
 	struct sta_rec_pn_info *pn_info;
 	struct sk_buff *skb, *rskb;
 	struct tlv *tlv;
 	int ret;
 
-	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76, &mvif->deflink.sta.wcid);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
+					    &msta_link->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -4344,19 +4353,21 @@ int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 				     struct ieee80211_sta *sta)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta_link *msta_link;
 	struct mt7996_sta *msta;
 	struct sk_buff *skb;
 
 	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->deflink.sta;
+	msta_link = &msta->deflink;
 
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
-					      &msta->wcid,
+					      &msta_link->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
 	/* starec hdr trans */
-	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, &msta->wcid);
+	mt7996_mcu_sta_hdr_trans_tlv(dev, skb, vif, &msta_link->wcid);
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 29fabb9b04ae328d84a3479f76f6ee93900aef2a..d0a4240f12a482895659e3a359daadcdca7bf7c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -185,10 +185,10 @@ struct mt7996_twt_flow {
 
 DECLARE_EWMA(avg_signal, 10, 8)
 
-struct mt7996_sta {
+struct mt7996_sta_link {
 	struct mt76_wcid wcid; /* must be first */
 
-	struct mt7996_vif *vif;
+	struct mt7996_sta *sta;
 
 	struct list_head rc_list;
 	u32 airtime_ac[8];
@@ -206,6 +206,12 @@ struct mt7996_sta {
 	} twt;
 };
 
+struct mt7996_sta {
+	struct mt7996_sta_link deflink; /* must be first */
+
+	struct mt7996_vif *vif;
+};
+
 struct mt7996_vif_link {
 	struct mt76_vif_link mt76; /* must be first */
 

-- 
2.48.1


