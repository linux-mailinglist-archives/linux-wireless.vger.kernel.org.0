Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CED47409A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 11:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhLNKl0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 05:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhLNKlZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 05:41:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7BDC061574
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 02:41:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CA0B613F1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 10:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50387C34608;
        Tue, 14 Dec 2021 10:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639478484;
        bh=zBoxqt/Hs5dx6ZB3nxfdIfHiCjB0cfOy8DpnMrY0gI8=;
        h=From:To:Cc:Subject:Date:From;
        b=uJ9I4HnO8cVcXnhnXGIBTO6Ls/XjkRi6dJZnXAeCzSLHx+Uh7KP6KM9YLP468znyD
         LCeKciqQzMDKdS/tqQFtcuqXT2AVHK+KcBVb/bkgLGhULHbRS06wPFZ3RrkFL7Ap2O
         ejXZsKS3RsGUVKhC1bBZIbeOl6OOhrNTLj4BnzdHAhcDcEpL/0ViErUK4yV74tsPrN
         QhAtRND2MHjFejapkLKSTGt/gyRqRs57JRPhTdED+PIj4dB5vkFxNkMbyOFTpcE40e
         PtpdE7HoTfAo0qmVEoxwpP67XuzbDZgwUrJbDmM7OwfQqvECmWhTsVWrRtEhPStBYU
         P9gG3EXvXMWNg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH] mt76: mt7915: introduce mt76_vif in mt7915_vif
Date:   Tue, 14 Dec 2021 11:41:06 +0100
Message-Id: <f70304f186987074dbeb66ff7dd7d5f7a235ec51.1639477867.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Align mt7915_vif layout to mt7921_vif and mt7615_vif

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 43 ++++++++--------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 51 ++++++++++---------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 +-
 5 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index a15aa256d0cf..4c5a572cea92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -355,8 +355,8 @@ mt7915_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 		qlen = mt76_get_field(dev, MT_PLE_BASE + MT_FL_Q3_CTRL,
 				      GENMASK(11, 0));
 		seq_printf(s, "\tSTA %pM wcid %d: AC%d%d queued:%d\n",
-			   sta->addr, msta->wcid.idx, msta->vif->wmm_idx,
-			   ac, qlen);
+			   sta->addr, msta->wcid.idx,
+			   msta->vif->mt76.wmm_idx, ac, qlen);
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a1556fe2f421..352d9e80e247 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1149,8 +1149,8 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	if (vif) {
 		struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 
-		omac_idx = mvif->omac_idx;
-		wmm_idx = mvif->wmm_idx;
+		omac_idx = mvif->mt76.omac_idx;
+		wmm_idx = mvif->mt76.wmm_idx;
 	}
 
 	if (ext_phy && dev->mt76.phy2)
@@ -1286,7 +1286,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (vif) {
 		struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 
-		txp->bss_idx = mvif->idx;
+		txp->bss_idx = mvif->mt76.idx;
 	}
 
 	txp->token = cpu_to_le16(id);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 31fceeed1a72..8ac6f59af174 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -203,8 +203,8 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	    is_zero_ether_addr(vif->addr))
 		phy->monitor_vif = vif;
 
-	mvif->idx = ffs(~dev->mt76.vif_mask) - 1;
-	if (mvif->idx >= MT7915_MAX_INTERFACES) {
+	mvif->mt76.idx = ffs(~dev->mt76.vif_mask) - 1;
+	if (mvif->mt76.idx >= MT7915_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -214,27 +214,27 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 		ret = -ENOSPC;
 		goto out;
 	}
-	mvif->omac_idx = idx;
+	mvif->mt76.omac_idx = idx;
 	mvif->phy = phy;
-	mvif->band_idx = ext_phy;
+	mvif->mt76.band_idx = ext_phy;
 
-	mvif->wmm_idx = vif->type != NL80211_IFTYPE_AP;
+	mvif->mt76.wmm_idx = vif->type != NL80211_IFTYPE_AP;
 	if (ext_phy)
-		mvif->wmm_idx += 2;
+		mvif->mt76.wmm_idx += 2;
 
 	ret = mt7915_mcu_add_dev_info(phy, vif, true);
 	if (ret)
 		goto out;
 
-	dev->mt76.vif_mask |= BIT(mvif->idx);
-	phy->omac_mask |= BIT_ULL(mvif->omac_idx);
+	dev->mt76.vif_mask |= BIT(mvif->mt76.idx);
+	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
-	idx = MT7915_WTBL_RESERVED - mvif->idx;
+	idx = MT7915_WTBL_RESERVED - mvif->mt76.idx;
 
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.ext_phy = mvif->band_idx;
+	mvif->sta.wcid.ext_phy = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mt76_packet_id_init(&mvif->sta.wcid);
@@ -249,7 +249,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	}
 
 	if (vif->type != NL80211_IFTYPE_AP &&
-	    (!mvif->omac_idx || mvif->omac_idx > 3))
+	    (!mvif->mt76.omac_idx || mvif->mt76.omac_idx > 3))
 		vif->offload_flags = 0;
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
@@ -286,8 +286,8 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
 	mutex_lock(&dev->mt76.mutex);
-	dev->mt76.vif_mask &= ~BIT(mvif->idx);
-	phy->omac_mask &= ~BIT_ULL(mvif->omac_idx);
+	dev->mt76.vif_mask &= ~BIT(mvif->mt76.idx);
+	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
 	mutex_unlock(&dev->mt76.mutex);
 
 	spin_lock_bh(&dev->sta_poll_lock);
@@ -576,7 +576,7 @@ mt7915_update_bss_color(struct ieee80211_hw *hw,
 	case NL80211_IFTYPE_AP: {
 		struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 
-		if (mvif->omac_idx > HW_BSSID_MAX)
+		if (mvif->mt76.omac_idx > HW_BSSID_MAX)
 			return;
 		fallthrough;
 	}
@@ -675,7 +675,7 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
-	msta->wcid.ext_phy = mvif->band_idx;
+	msta->wcid.ext_phy = mvif->mt76.band_idx;
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->jiffies = jiffies;
 
@@ -858,7 +858,8 @@ u64 __mt7915_get_tsf(struct ieee80211_hw *hw, struct mt7915_vif *mvif)
 
 	lockdep_assert_held(&dev->mt76.mutex);
 
-	n = mvif->omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : mvif->omac_idx;
+	n = mvif->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : mvif->mt76.omac_idx;
 	/* TSF software read */
 	mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
 		 MT_LPON_TCR_SW_READ);
@@ -898,7 +899,8 @@ mt7915_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	n = mvif->omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : mvif->omac_idx;
+	n = mvif->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : mvif->mt76.omac_idx;
 	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1(band), tsf.t32[1]);
 	/* TSF software overwrite */
@@ -924,7 +926,8 @@ mt7915_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	n = mvif->omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : mvif->omac_idx;
+	n = mvif->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : mvif->mt76.omac_idx;
 	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1(band), tsf.t32[1]);
 	/* TSF software adjust*/
@@ -1215,7 +1218,7 @@ static void mt7915_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 	struct mt76_ethtool_worker_info *wi = wi_data;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 
-	if (msta->vif->idx != wi->idx)
+	if (msta->vif->mt76.idx != wi->idx)
 		return;
 
 	mt76_ethtool_worker(wi, &msta->stats);
@@ -1231,7 +1234,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt76_ethtool_worker_info wi = {
 		.data = data,
-		.idx = mvif->idx,
+		.idx = mvif->mt76.idx,
 	};
 	struct mib_stats *mib = &phy->mib;
 	/* See mt7915_ampdu_stat_read_phy, etc */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6f0f9925030a..403acfe7d314 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -582,10 +582,10 @@ mt7915_mcu_alloc_sta_req(struct mt7915_dev *dev, struct mt7915_vif *mvif,
 			 struct mt7915_sta *msta, int len)
 {
 	struct sta_req_hdr hdr = {
-		.bss_idx = mvif->idx,
+		.bss_idx = mvif->mt76.idx,
 		.wlan_idx_lo = msta ? to_wcid_lo(msta->wcid.idx) : 0,
 		.wlan_idx_hi = msta ? to_wcid_hi(msta->wcid.idx) : 0,
-		.muar_idx = msta && msta->wcid.sta ? mvif->omac_idx : 0xe,
+		.muar_idx = msta && msta->wcid.sta ? mvif->mt76.omac_idx : 0xe,
 		.is_tlv_append = 1,
 	};
 	struct sk_buff *skb;
@@ -725,7 +725,7 @@ mt7915_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	bss->network_type = cpu_to_le32(type);
 	bss->bmc_wcid_lo = to_wcid_lo(wlan_idx);
 	bss->bmc_wcid_hi = to_wcid_hi(wlan_idx);
-	bss->wmm_idx = mvif->wmm_idx;
+	bss->wmm_idx = mvif->mt76.wmm_idx;
 	bss->active = enable;
 
 	if (vif->type != NL80211_IFTYPE_MONITOR) {
@@ -769,10 +769,11 @@ mt7915_mcu_bss_omac_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 	}
 
 	omac = (struct bss_info_omac *)tlv;
-	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
+	idx = mvif->mt76.omac_idx > EXT_BSSID_START ? HW_BSSID_0
+						    : mvif->mt76.omac_idx;
 	omac->conn_type = cpu_to_le32(type);
-	omac->omac_idx = mvif->omac_idx;
-	omac->band_idx = mvif->band_idx;
+	omac->omac_idx = mvif->mt76.omac_idx;
+	omac->band_idx = mvif->mt76.band_idx;
 	omac->hw_bss_idx = idx;
 }
 
@@ -937,7 +938,7 @@ mt7915_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt7915_vif *mvif)
 	int ext_bss_idx, tsf_offset;
 	struct tlv *tlv;
 
-	ext_bss_idx = mvif->omac_idx - EXT_BSSID_START;
+	ext_bss_idx = mvif->mt76.omac_idx - EXT_BSSID_START;
 	if (ext_bss_idx < 0)
 		return;
 
@@ -973,7 +974,7 @@ mt7915_mcu_muar_config(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 {
 	struct mt7915_dev *dev = phy->dev;
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	u32 idx = mvif->omac_idx - REPEATER_BSSID_START;
+	u32 idx = mvif->mt76.omac_idx - REPEATER_BSSID_START;
 	u32 mask = phy->omac_mask >> 32 & ~BIT(idx);
 	const u8 *addr = vif->addr;
 	struct {
@@ -1011,7 +1012,7 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct sk_buff *skb;
 
-	if (mvif->omac_idx >= REPEATER_BSSID_START) {
+	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START) {
 		mt7915_mcu_muar_config(phy, vif, false, enable);
 		mt7915_mcu_muar_config(phy, vif, true, enable);
 	}
@@ -1039,8 +1040,8 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 		if (vif->bss_conf.he_support)
 			mt7915_mcu_bss_he_tlv(skb, vif, phy);
 
-		if (mvif->omac_idx >= EXT_BSSID_START &&
-		    mvif->omac_idx < REPEATER_BSSID_START)
+		if (mvif->mt76.omac_idx >= EXT_BSSID_START &&
+		    mvif->mt76.omac_idx < REPEATER_BSSID_START)
 			mt7915_mcu_bss_ext_tlv(skb, mvif);
 	}
 out:
@@ -1265,7 +1266,7 @@ mt7915_mcu_wtbl_generic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	if (sta) {
 		memcpy(generic->peer_addr, sta->addr, ETH_ALEN);
 		generic->partial_aid = cpu_to_le16(sta->aid);
-		generic->muar_idx = mvif->omac_idx;
+		generic->muar_idx = mvif->mt76.omac_idx;
 		generic->qos = sta->wme;
 	} else {
 		/* use BSSID in station mode */
@@ -1928,7 +1929,7 @@ mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_phy *phy =
-		mvif->band_idx ? mt7915_ext_phy(dev) : &dev->phy;
+		mvif->mt76.band_idx ? mt7915_ext_phy(dev) : &dev->phy;
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
@@ -1995,7 +1996,7 @@ mt7915_mcu_sta_bfee_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_phy *phy =
-		mvif->band_idx ? mt7915_ext_phy(dev) : &dev->phy;
+		mvif->mt76.band_idx ? mt7915_ext_phy(dev) : &dev->phy;
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 	struct sta_rec_bfee *bfee;
 	struct tlv *tlv;
@@ -2349,7 +2350,7 @@ mt7915_mcu_add_group(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		u8 rsv1[8];
 	} __packed req = {
 		.action = cpu_to_le32(MT_STA_BSS_GROUP),
-		.val = cpu_to_le32(mvif->idx % 16),
+		.val = cpu_to_le32(mvif->mt76.idx % 16),
 	};
 
 	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
@@ -2437,8 +2438,8 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 		} __packed tlv;
 	} data = {
 		.hdr = {
-			.omac_idx = mvif->omac_idx,
-			.dbdc_idx = mvif->band_idx,
+			.omac_idx = mvif->mt76.omac_idx,
+			.dbdc_idx = mvif->mt76.band_idx,
 			.tlv_num = cpu_to_le16(1),
 			.is_tlv_append = 1,
 		},
@@ -2446,11 +2447,11 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
 			.len = cpu_to_le16(sizeof(struct req_tlv)),
 			.active = enable,
-			.dbdc_idx = mvif->band_idx,
+			.dbdc_idx = mvif->mt76.band_idx,
 		},
 	};
 
-	if (mvif->omac_idx >= REPEATER_BSSID_START)
+	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START)
 		return mt7915_mcu_muar_config(phy, vif, false, enable);
 
 	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
@@ -2622,7 +2623,7 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 		return -EINVAL;
 	}
 
-	if (mvif->band_idx) {
+	if (mvif->mt76.band_idx) {
 		info = IEEE80211_SKB_CB(skb);
 		info->hw_queue |= MT_TX_HW_QUEUE_EXT_PHY;
 	}
@@ -3243,7 +3244,7 @@ int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif)
 		struct edca *e = &req.edca[ac];
 
 		e->set = WMM_PARAM_SET;
-		e->queue = ac + mvif->wmm_idx * MT7915_MAX_WMM_SETS;
+		e->queue = ac + mvif->mt76.wmm_idx * MT7915_MAX_WMM_SETS;
 		e->aifs = q->aifs;
 		e->txop = cpu_to_le16(q->txop);
 
@@ -4048,7 +4049,7 @@ int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	} __packed req = {
 		.action = MT_SPR_ENABLE,
 		.arg_num = 1,
-		.band_idx = mvif->band_idx,
+		.band_idx = mvif->mt76.band_idx,
 		.val = cpu_to_le32(enable),
 	};
 
@@ -4069,7 +4070,7 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		__le16 wcid;
 	} __packed req = {
 		.category = MCU_PHY_STATE_CONTENTION_RX_RATE,
-		.band = mvif->band_idx,
+		.band = mvif->mt76.band_idx,
 		.wcid = cpu_to_le16(msta->wcid.idx),
 	};
 	struct ieee80211_supported_band *sband;
@@ -4209,11 +4210,11 @@ int mt7915_mcu_twt_agrt_update(struct mt7915_dev *dev,
 	} __packed req = {
 		.tbl_idx = flow->table_id,
 		.cmd = cmd,
-		.own_mac_idx = mvif->omac_idx,
+		.own_mac_idx = mvif->mt76.omac_idx,
 		.flowid = flow->id,
 		.peer_id = cpu_to_le16(flow->wcid),
 		.duration = flow->duration,
-		.bss_idx = mvif->idx,
+		.bss_idx = mvif->mt76.idx,
 		.start_tsf = cpu_to_le64(flow->tsf),
 		.mantissa = flow->mantissa,
 		.exponent = flow->exp,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index d2fbe52772c9..cb564c74a8c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -124,10 +124,7 @@ struct mt7915_vif_cap {
 };
 
 struct mt7915_vif {
-	u16 idx;
-	u8 omac_idx;
-	u8 band_idx;
-	u8 wmm_idx;
+	struct mt76_vif mt76; /* must be first */
 
 	struct mt7915_vif_cap cap;
 	struct mt7915_sta sta;
-- 
2.33.1

