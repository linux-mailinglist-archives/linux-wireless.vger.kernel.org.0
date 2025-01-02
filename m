Return-Path: <linux-wireless+bounces-17013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840699FFBE1
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDF71883C32
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE4D1B6CE9;
	Thu,  2 Jan 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="kW2hgWaj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC86A15534D
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835726; cv=none; b=NxrfhaVL3b+38mLjr1zDwgkREtoIXMUSQOAzMw+7jT6QI94v6IbyzO7vcbPoJ9nVZ+aE9ERBo8NElzAGSC1m1BRoTxGRK1JlaIcrJ0KOevlVnfCuveTIORlGi44YCwvRGtSytvUaim9BTko+gaJx/aijmaG2pxsPPBpGbh6IT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835726; c=relaxed/simple;
	bh=wcrNqz0yoLUjKnn0wCQ5swGrDvRjRiyJ4vwAfuBLp+c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BheiQtIwKmS+HZMMksj2ZNwVERHPAZwoEWSZlTNG81UNgqc3haUhL6JDyQ/NB5kJ+4NBuCBTI9A0i4lbR5qQtJ+q4vqWv7Mf2g0lIFPsc3de4ijvsXkLzv5Rkv6rRe9hk49tyEPjVldcLFc8p1vlKv2oUHRRA8rDH/XHr4hrfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=kW2hgWaj; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+AkgBRlI1wR5/9HgM2wnHoGZh0zkn3gpjiIf/cqRg78=; b=kW2hgWajSvoamAjwkCCVpgd2Mx
	eq3Bc3aSby8JIQ9kWKb/jOKaFrvHK2zR15ZMoNPjCu7giQe79b22t3vr5fd6WQLLKv/bGdIkOdBdW
	7SxZCZfMA0BQWFRS72vDuoQ/XMzPT+JA3/GsdN3EW4bWn96cRt0yB2p2ph9DWK20ZOsQ=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAC-0008GS-0h
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:12 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 05/24] wifi: mt76: mt7996: split link specific data from struct mt7996_vif
Date: Thu,  2 Jan 2025 17:34:49 +0100
Message-ID: <20250102163508.52945-5-nbd@nbd.name>
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

Preparation for MLO support.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |   6 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |   8 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 202 ++++++++++--------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  80 +++----
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  21 +-
 5 files changed, 185 insertions(+), 132 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 62c03d088925..335699405ac7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -601,7 +601,7 @@ static void
 mt7996_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_dev *dev = msta->vif->phy->dev;
+	struct mt7996_dev *dev = msta->vif->deflink.phy->dev;
 	struct seq_file *s = data;
 	u8 ac;
 
@@ -621,7 +621,7 @@ mt7996_sta_hw_queue_read(void *data, struct ieee80211_sta *sta)
 				      GENMASK(11, 0));
 		seq_printf(s, "\tSTA %pM wcid %d: AC%d%d queued:%d\n",
 			   sta->addr, msta->wcid.idx,
-			   msta->vif->mt76.wmm_idx, ac, qlen);
+			   msta->vif->deflink.mt76.wmm_idx, ac, qlen);
 	}
 }
 
@@ -899,7 +899,7 @@ static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
 #define LONG_PREAMBLE 1
 	struct ieee80211_sta *sta = file->private_data;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_dev *dev = msta->vif->phy->dev;
+	struct mt7996_dev *dev = msta->vif->deflink.phy->dev;
 	struct ra_rate phy = {};
 	char buf[100];
 	int ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index fb6ab96cdeab..2656e3f85bdc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -72,7 +72,7 @@ static struct mt76_wcid *mt7996_rx_get_wcid(struct mt7996_dev *dev,
 	if (!sta->vif)
 		return NULL;
 
-	return &sta->vif->sta.wcid;
+	return &sta->vif->deflink.sta.wcid;
 }
 
 bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask)
@@ -182,7 +182,7 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		rssi[3] = to_rssi(GENMASK(31, 14), val);
 
 		msta->ack_signal =
-			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
+			mt76_rx_signal(msta->vif->deflink.phy->mt76->antenna_mask, rssi);
 
 		ewma_avg_signal_add(&msta->avg_ack_signal, -msta->ack_signal);
 	}
@@ -196,7 +196,7 @@ void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	u32 addr;
 
-	addr = mt7996_mac_wtbl_lmac_addr(dev, mvif->sta.wcid.idx, 5);
+	addr = mt7996_mac_wtbl_lmac_addr(dev, mvif->deflink.sta.wcid.idx, 5);
 	if (enable)
 		mt76_set(dev, addr, BIT(5));
 	else
@@ -984,7 +984,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (vif) {
 		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 
-		txp->fw.bss_idx = mvif->mt76.idx;
+		txp->fw.bss_idx = mvif->deflink.mt76.idx;
 	}
 
 	txp->fw.token = cpu_to_le16(id);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index e0589b029167..8679f8a6d49f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -157,70 +157,69 @@ static int get_omac_idx(enum nl80211_iftype type, u64 mask)
 	return -1;
 }
 
-static void mt7996_init_bitrate_mask(struct ieee80211_vif *vif)
+static void
+mt7996_init_bitrate_mask(struct ieee80211_vif *vif, struct mt7996_vif_link *mlink)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mvif->bitrate_mask.control); i++) {
-		mvif->bitrate_mask.control[i].gi = NL80211_TXRATE_DEFAULT_GI;
-		mvif->bitrate_mask.control[i].he_gi = 0xff;
-		mvif->bitrate_mask.control[i].he_ltf = 0xff;
-		mvif->bitrate_mask.control[i].legacy = GENMASK(31, 0);
-		memset(mvif->bitrate_mask.control[i].ht_mcs, 0xff,
-		       sizeof(mvif->bitrate_mask.control[i].ht_mcs));
-		memset(mvif->bitrate_mask.control[i].vht_mcs, 0xff,
-		       sizeof(mvif->bitrate_mask.control[i].vht_mcs));
-		memset(mvif->bitrate_mask.control[i].he_mcs, 0xff,
-		       sizeof(mvif->bitrate_mask.control[i].he_mcs));
+	for (i = 0; i < ARRAY_SIZE(mlink->bitrate_mask.control); i++) {
+		mlink->bitrate_mask.control[i].gi = NL80211_TXRATE_DEFAULT_GI;
+		mlink->bitrate_mask.control[i].he_gi = 0xff;
+		mlink->bitrate_mask.control[i].he_ltf = 0xff;
+		mlink->bitrate_mask.control[i].legacy = GENMASK(31, 0);
+		memset(mlink->bitrate_mask.control[i].ht_mcs, 0xff,
+		       sizeof(mlink->bitrate_mask.control[i].ht_mcs));
+		memset(mlink->bitrate_mask.control[i].vht_mcs, 0xff,
+		       sizeof(mlink->bitrate_mask.control[i].vht_mcs));
+		memset(mlink->bitrate_mask.control[i].he_mcs, 0xff,
+		       sizeof(mlink->bitrate_mask.control[i].he_mcs));
 	}
 }
 
-static int mt7996_add_interface(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif)
+static int
+mt7996_vif_link_add(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+		    struct ieee80211_bss_conf *link_conf)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	struct mt76_txq *mtxq;
+	struct mt7996_dev *dev = phy->dev;
 	u8 band_idx = phy->mt76->band_idx;
-	int idx, ret = 0;
+	struct mt7996_vif_link *mlink;
+	struct mt76_txq *mtxq;
+	int idx, ret;
 
-	mutex_lock(&dev->mt76.mutex);
+	mlink = mt7996_vif_conf_link(dev, vif, link_conf);
+	if (!mlink)
+		return -EINVAL;
 
-	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
-	if (mvif->mt76.idx >= mt7996_max_interface_num(dev)) {
-		ret = -ENOSPC;
-		goto out;
-	}
+	mlink->mt76.idx = __ffs64(~dev->mt76.vif_mask);
+	if (mlink->mt76.idx >= mt7996_max_interface_num(dev))
+		return -ENOSPC;
 
 	idx = get_omac_idx(vif->type, phy->omac_mask);
-	if (idx < 0) {
-		ret = -ENOSPC;
-		goto out;
-	}
-	mvif->mt76.omac_idx = idx;
-	mvif->phy = phy;
-	mvif->mt76.band_idx = band_idx;
-	mvif->mt76.wmm_idx = vif->type == NL80211_IFTYPE_AP ? 0 : 3;
-	mvif->mt76.wcid = &mvif->sta.wcid;
+	if (idx < 0)
+		return -ENOSPC;
+
+	mlink->mt76.omac_idx = idx;
+	mlink->phy = phy;
+	mlink->mt76.band_idx = band_idx;
+	mlink->mt76.wmm_idx = vif->type == NL80211_IFTYPE_AP ? 0 : 3;
+	mlink->mt76.wcid = &mlink->sta.wcid;
 
 	ret = mt7996_mcu_add_dev_info(phy, vif, true);
 	if (ret)
-		goto out;
+		return ret;
 
-	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
-	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
+	dev->mt76.vif_mask |= BIT_ULL(mlink->mt76.idx);
+	phy->omac_mask |= BIT_ULL(mlink->mt76.omac_idx);
 
-	idx = MT7996_WTBL_RESERVED - mvif->mt76.idx;
+	idx = MT7996_WTBL_RESERVED - mlink->mt76.idx;
 
-	INIT_LIST_HEAD(&mvif->sta.rc_list);
-	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
-	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.phy_idx = band_idx;
-	mvif->sta.wcid.hw_key_idx = -1;
-	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_wcid_init(&mvif->sta.wcid);
+	INIT_LIST_HEAD(&mlink->sta.rc_list);
+	INIT_LIST_HEAD(&mlink->sta.wcid.poll_list);
+	mlink->sta.wcid.idx = idx;
+	mlink->sta.wcid.phy_idx = band_idx;
+	mlink->sta.wcid.hw_key_idx = -1;
+	mlink->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt76_wcid_init(&mlink->sta.wcid);
 
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -231,16 +230,15 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	}
 
 	if (vif->type != NL80211_IFTYPE_AP &&
-	    (!mvif->mt76.omac_idx || mvif->mt76.omac_idx > 3))
+	    (!mlink->mt76.omac_idx || mlink->mt76.omac_idx > 3))
 		vif->offload_flags = 0;
-	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
 	if (phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
-		mvif->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL + 4;
+		mlink->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL + 4;
 	else
-		mvif->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL;
+		mlink->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL;
 
-	mt7996_init_bitrate_mask(vif);
+	mt7996_init_bitrate_mask(vif, mlink);
 
 	mt7996_mcu_add_bss_info(phy, vif, true);
 	/* defer the first STA_REC of BMC entry to BSS_CHANGED_BSSID for STA
@@ -248,32 +246,37 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	 */
 	if (vif->type != NL80211_IFTYPE_STATION)
 		mt7996_mcu_add_sta(dev, vif, NULL, CONN_STATE_PORT_SECURE, true);
-	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
+	rcu_assign_pointer(dev->mt76.wcid[idx], &mlink->sta.wcid);
 
-out:
-	mutex_unlock(&dev->mt76.mutex);
-
-	return ret;
+	return 0;
 }
 
-static void mt7996_remove_interface(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif)
+static void
+mt7996_vif_link_remove(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_bss_conf *link_conf)
 {
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_sta *msta = &mvif->sta;
-	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt7996_phy *phy = mt7996_hw_phy(hw);
-	int idx = msta->wcid.idx;
+	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_vif_link *mlink;
+	struct mt7996_sta *msta;
+	int idx;
 
+	mlink = mt7996_vif_conf_link(dev, vif, link_conf);
+	if (!mlink)
+		return;
+
+	mlink->phy = NULL;
+	msta = &mlink->sta;
+	idx = msta->wcid.idx;
 	mt7996_mcu_add_sta(dev, vif, NULL, CONN_STATE_DISCONNECT, false);
 	mt7996_mcu_add_bss_info(phy, vif, false);
+
 	mt7996_mcu_add_dev_info(phy, vif, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
 	mutex_lock(&dev->mt76.mutex);
-	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
-	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
+	dev->mt76.vif_mask &= ~BIT_ULL(mlink->mt76.idx);
+	phy->omac_mask &= ~BIT_ULL(mlink->mt76.omac_idx);
 	mutex_unlock(&dev->mt76.mutex);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
@@ -284,6 +287,36 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
 	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
 }
 
+static int mt7996_add_interface(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	int ret = 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	mt76_vif_init(vif, &mvif->mt76);
+
+	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
+	ret = mt7996_vif_link_add(phy, vif, &vif->bss_conf);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static void mt7996_remove_interface(struct ieee80211_hw *hw,
+				    struct ieee80211_vif *vif)
+{
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+
+	mt7996_vif_link_remove(phy, vif, &vif->bss_conf);
+	mt76_vif_cleanup(&dev->mt76, vif);
+}
+
 int mt7996_set_channel(struct mt76_phy *mphy)
 {
 	struct mt7996_phy *phy = mphy->priv;
@@ -317,8 +350,9 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_vif_link *mlink = &mvif->deflink;
 	struct mt7996_sta *msta = sta ? (struct mt7996_sta *)sta->drv_priv :
-				  &mvif->sta;
+				  &mlink->sta;
 	struct mt76_wcid *wcid = &msta->wcid;
 	u8 *wcid_keyidx = &wcid->hw_key_idx;
 	int idx = key->keyidx;
@@ -364,8 +398,8 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	if (cmd == SET_KEY && !sta && !mvif->mt76.cipher) {
-		mvif->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
+	if (cmd == SET_KEY && !sta && !mlink->mt76.cipher) {
+		mlink->mt76.cipher = mt76_connac_mcu_get_cipher(key->cipher);
 		mt7996_mcu_add_bss_info(phy, vif, true);
 	}
 
@@ -444,7 +478,7 @@ mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	};
 
 	/* firmware uses access class index */
-	mvif->queue_params[mq_to_aci[queue]] = *params;
+	mvif->deflink.queue_params[mq_to_aci[queue]] = *params;
 	/* no need to update right away, we'll get BSS_CHANGED_QOS */
 
 	return 0;
@@ -516,7 +550,7 @@ mt7996_update_bss_color(struct ieee80211_hw *hw,
 	case NL80211_IFTYPE_AP: {
 		struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 
-		if (mvif->mt76.omac_idx > HW_BSSID_MAX)
+		if (mvif->deflink.mt76.omac_idx > HW_BSSID_MAX)
 			return;
 		fallthrough;
 	}
@@ -564,7 +598,7 @@ mt7996_update_mu_group(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	u8 band = mvif->mt76.band_idx;
+	u8 band = mvif->deflink.mt76.band_idx;
 	u32 *mu;
 
 	mu = (u32 *)info->mu_group.membership;
@@ -666,7 +700,7 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	u8 band_idx = mvif->phy->mt76->band_idx;
+	u8 band_idx = mvif->deflink.phy->mt76->band_idx;
 	int idx;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
@@ -766,7 +800,7 @@ static void mt7996_tx(struct ieee80211_hw *hw,
 		struct mt7996_vif *mvif;
 
 		mvif = (struct mt7996_vif *)vif->drv_priv;
-		wcid = &mvif->sta.wcid;
+		wcid = &mvif->deflink.sta.wcid;
 	}
 
 	mt76_tx(mphy, control->sta, wcid, skb);
@@ -873,8 +907,8 @@ u64 __mt7996_get_tsf(struct ieee80211_hw *hw, struct mt7996_vif *mvif)
 
 	lockdep_assert_held(&dev->mt76.mutex);
 
-	n = mvif->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
-					       : mvif->mt76.omac_idx;
+	n = mvif->deflink.mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : mvif->deflink.mt76.omac_idx;
 	/* TSF software read */
 	mt76_rmw(dev, MT_LPON_TCR(phy->mt76->band_idx, n), MT_LPON_TCR_SW_MODE,
 		 MT_LPON_TCR_SW_READ);
@@ -913,8 +947,8 @@ mt7996_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	n = mvif->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
-					       : mvif->mt76.omac_idx;
+	n = mvif->deflink.mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : mvif->deflink.mt76.omac_idx;
 	mt76_wr(dev, MT_LPON_UTTR0(phy->mt76->band_idx), tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1(phy->mt76->band_idx), tsf.t32[1]);
 	/* TSF software overwrite */
@@ -939,8 +973,8 @@ mt7996_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	n = mvif->mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
-					       : mvif->mt76.omac_idx;
+	n = mvif->deflink.mt76.omac_idx > HW_BSSID_MAX ? HW_BSSID_0
+					       : mvif->deflink.mt76.omac_idx;
 	mt76_wr(dev, MT_LPON_UTTR0(phy->mt76->band_idx), tsf.t32[0]);
 	mt76_wr(dev, MT_LPON_UTTR1(phy->mt76->band_idx), tsf.t32[1]);
 	/* TSF software adjust*/
@@ -1056,7 +1090,7 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 static void mt7996_sta_rc_work(void *data, struct ieee80211_sta *sta)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_dev *dev = msta->vif->phy->dev;
+	struct mt7996_dev *dev = msta->vif->deflink.phy->dev;
 	u32 *changed = data;
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
@@ -1088,7 +1122,7 @@ mt7996_set_bitrate_mask(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7996_dev *dev = phy->dev;
 	u32 changed = IEEE80211_RC_SUPP_RATES_CHANGED;
 
-	mvif->bitrate_mask = *mask;
+	mvif->deflink.bitrate_mask = *mask;
 
 	/* if multiple rates across different preambles are given we can
 	 * reconfigure this info with all peers using sta_rec command with
@@ -1272,7 +1306,7 @@ static void mt7996_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 	struct mt76_ethtool_worker_info *wi = wi_data;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 
-	if (msta->vif->mt76.idx != wi->idx)
+	if (msta->vif->deflink.mt76.idx != wi->idx)
 		return;
 
 	mt76_ethtool_worker(wi, &msta->wcid.stats, true);
@@ -1289,7 +1323,7 @@ void mt7996_get_et_stats(struct ieee80211_hw *hw,
 	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt76_ethtool_worker_info wi = {
 		.data = data,
-		.idx = mvif->mt76.idx,
+		.idx = mvif->deflink.mt76.idx,
 	};
 	/* See mt7996_ampdu_stat_read_phy, etc */
 	int i, ei = 0;
@@ -1458,7 +1492,7 @@ mt7996_net_fill_forward_path(struct ieee80211_hw *hw,
 	path->type = DEV_PATH_MTK_WDMA;
 	path->dev = ctx->dev;
 	path->mtk_wdma.wdma_idx = wed->wdma_idx;
-	path->mtk_wdma.bss = mvif->mt76.idx;
+	path->mtk_wdma.bss = mvif->deflink.mt76.idx;
 	path->mtk_wdma.queue = 0;
 	path->mtk_wdma.wcid = msta->wcid.idx;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index d25afd1f67fc..1f0090c97e9c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -122,8 +122,8 @@ mt7996_mcu_set_sta_he_mcs(struct ieee80211_sta *sta, __le16 *he_mcs,
 			  u16 mcs_map)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	enum nl80211_band band = msta->vif->phy->mt76->chandef.chan->band;
-	const u16 *mask = msta->vif->bitrate_mask.control[band].he_mcs;
+	enum nl80211_band band = msta->vif->deflink.phy->mt76->chandef.chan->band;
+	const u16 *mask = msta->vif->deflink.bitrate_mask.control[band].he_mcs;
 	int nss, max_nss = sta->deflink.rx_nss > 3 ? 4 : sta->deflink.rx_nss;
 
 	for (nss = 0; nss < max_nss; nss++) {
@@ -892,7 +892,7 @@ mt7996_mcu_bss_mld_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 
 	mld = (struct bss_mld_tlv *)tlv;
 	mld->group_mld_id = 0xff;
-	mld->own_mld_id = mvif->mt76.idx;
+	mld->own_mld_id = mvif->deflink.mt76.idx;
 	mld->remap_idx = 0xff;
 }
 
@@ -916,7 +916,7 @@ mt7996_mcu_muar_config(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 #define UNI_MUAR_ENTRY 2
 	struct mt7996_dev *dev = phy->dev;
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	u32 idx = mvif->mt76.omac_idx - REPEATER_BSSID_START;
+	u32 idx = mvif->deflink.mt76.omac_idx - REPEATER_BSSID_START;
 	const u8 *addr = vif->addr;
 
 	struct {
@@ -957,7 +957,7 @@ static void
 mt7996_mcu_bss_ifs_timing_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_phy *phy = mvif->phy;
+	struct mt7996_phy *phy = mvif->deflink.phy;
 	struct bss_ifs_time_tlv *ifs_time;
 	struct tlv *tlv;
 	bool is_2ghz = phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ;
@@ -1083,19 +1083,19 @@ int mt7996_mcu_add_bss_info(struct mt7996_phy *phy,
 	struct mt7996_dev *dev = phy->dev;
 	struct sk_buff *skb;
 
-	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START) {
+	if (mvif->deflink.mt76.omac_idx >= REPEATER_BSSID_START) {
 		mt7996_mcu_muar_config(phy, vif, false, enable);
 		mt7996_mcu_muar_config(phy, vif, true, enable);
 	}
 
-	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->deflink.mt76,
 					 MT7996_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
 	/* bss_basic must be first */
 	mt7996_mcu_bss_basic_tlv(skb, vif, NULL, phy->mt76,
-				 mvif->sta.wcid.idx, enable);
+				 mvif->deflink.sta.wcid.idx, enable);
 	mt7996_mcu_bss_sec_tlv(skb, vif);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR)
@@ -1128,7 +1128,7 @@ int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif)
 	struct mt7996_dev *dev = phy->dev;
 	struct sk_buff *skb;
 
-	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->deflink.mt76,
 					 MT7996_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -1180,7 +1180,7 @@ int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 	if (enable && !params->amsdu)
 		msta->wcid.amsdu = false;
 
-	return mt7996_mcu_sta_ba(dev, &mvif->mt76, params, enable, true);
+	return mt7996_mcu_sta_ba(dev, &mvif->deflink.mt76, params, enable, true);
 }
 
 int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
@@ -1190,7 +1190,7 @@ int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
 	struct mt7996_sta *msta = (struct mt7996_sta *)params->sta->drv_priv;
 	struct mt7996_vif *mvif = msta->vif;
 
-	return mt7996_mcu_sta_ba(dev, &mvif->mt76, params, enable, false);
+	return mt7996_mcu_sta_ba(dev, &mvif->deflink.mt76, params, enable, false);
 }
 
 static void
@@ -1667,7 +1667,7 @@ mt7996_mcu_sta_bfer_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_phy *phy = mvif->phy;
+	struct mt7996_phy *phy = mvif->deflink.phy;
 	int tx_ant = hweight16(phy->mt76->chainmask) - 1;
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
@@ -1738,7 +1738,7 @@ mt7996_mcu_sta_bfee_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_phy *phy = mvif->phy;
+	struct mt7996_phy *phy = mvif->deflink.phy;
 	int tx_ant = hweight8(phy->mt76->antenna_mask) - 1;
 	struct sta_rec_bfee *bfee;
 	struct tlv *tlv;
@@ -1879,7 +1879,7 @@ int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif
 	struct sk_buff *skb;
 	struct tlv *tlv;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
 					      &msta->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
@@ -1915,8 +1915,8 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct ieee80211_vif *vif
 			       struct ieee80211_sta *sta)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
-	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
+	struct cfg80211_chan_def *chandef = &mvif->deflink.phy->mt76->chandef;
+	struct cfg80211_bitrate_mask *mask = &mvif->deflink.bitrate_mask;
 	enum nl80211_band band = chandef->chan->band;
 	struct sta_phy_uni phy = {};
 	int ret, nrates = 0;
@@ -2003,9 +2003,9 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 {
 #define INIT_RCPI 180
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt76_phy *mphy = mvif->phy->mt76;
+	struct mt76_phy *mphy = mvif->deflink.phy->mt76;
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
-	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
+	struct cfg80211_bitrate_mask *mask = &mvif->deflink.bitrate_mask;
 	enum nl80211_band band = chandef->chan->band;
 	struct sta_rec_ra_uni *ra;
 	struct tlv *tlv;
@@ -2111,7 +2111,7 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	struct sk_buff *skb;
 	int ret;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
 					      &msta->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
@@ -2158,10 +2158,10 @@ mt7996_mcu_add_group(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		.tag = cpu_to_le16(UNI_VOW_DRR_CTRL),
 		.len = cpu_to_le16(sizeof(req) - 4),
 		.action = cpu_to_le32(MT_STA_BSS_GROUP),
-		.val = cpu_to_le32(mvif->mt76.idx % 16),
+		.val = cpu_to_le32(mvif->deflink.mt76.idx % 16),
 	};
 
-	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->sta;
+	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->deflink.sta;
 	req.wlan_idx = cpu_to_le16(msta->wcid.idx);
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(VOW), &req,
@@ -2177,10 +2177,10 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	struct sk_buff *skb;
 	int ret;
 
-	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->sta;
+	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->deflink.sta;
 	link_sta = sta ? &sta->deflink : NULL;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
 					      &msta->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
@@ -2309,7 +2309,7 @@ static int mt7996_mcu_get_pn(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 	int ret;
 
-	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76, &mvif->sta.wcid);
+	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76, &mvif->deflink.sta.wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2345,7 +2345,7 @@ int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev, struct ieee80211_vif *vif
 		  sizeof(struct mt7996_mcu_bcn_prot_tlv);
 	int ret;
 
-	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76, len);
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->deflink.mt76, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2405,8 +2405,8 @@ int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
 		} __packed tlv;
 	} data = {
 		.hdr = {
-			.omac_idx = mvif->mt76.omac_idx,
-			.band_idx = mvif->mt76.band_idx,
+			.omac_idx = mvif->deflink.mt76.omac_idx,
+			.band_idx = mvif->deflink.mt76.band_idx,
 		},
 		.tlv = {
 			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
@@ -2415,7 +2415,7 @@ int mt7996_mcu_add_dev_info(struct mt7996_phy *phy,
 		},
 	};
 
-	if (mvif->mt76.omac_idx >= REPEATER_BSSID_START)
+	if (mvif->deflink.mt76.omac_idx >= REPEATER_BSSID_START)
 		return mt7996_mcu_muar_config(phy, vif, false, enable);
 
 	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
@@ -2540,7 +2540,7 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw,
 	if (vif->bss_conf.nontransmitted)
 		return 0;
 
-	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->deflink.mt76,
 					  MT7996_MAX_BSS_OFFLOAD_SIZE);
 	if (IS_ERR(rskb))
 		return PTR_ERR(rskb);
@@ -2585,7 +2585,7 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
+	struct cfg80211_chan_def *chandef = &mvif->deflink.phy->mt76->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
 	struct bss_inband_discovery_tlv *discov;
@@ -2598,7 +2598,7 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 	if (vif->bss_conf.nontransmitted)
 		return 0;
 
-	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->deflink.mt76,
 					  MT7996_MAX_BSS_OFFLOAD_SIZE);
 	if (IS_ERR(rskb))
 		return PTR_ERR(rskb);
@@ -3171,7 +3171,7 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif)
 		u8 bss_idx;
 		u8 __rsv[3];
 	} __packed hdr = {
-		.bss_idx = mvif->mt76.idx,
+		.bss_idx = mvif->deflink.mt76.idx,
 	};
 	struct sk_buff *skb;
 	int len = sizeof(hdr) + IEEE80211_NUM_ACS * sizeof(struct edca);
@@ -3184,7 +3184,7 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif)
 	skb_put_data(skb, &hdr, sizeof(hdr));
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		struct ieee80211_tx_queue_params *q = &mvif->queue_params[ac];
+		struct ieee80211_tx_queue_params *q = &mvif->deflink.queue_params[ac];
 		struct edca *e;
 		struct tlv *tlv;
 
@@ -4039,7 +4039,7 @@ mt7996_mcu_set_obss_spr_siga(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_dev *dev = phy->dev;
-	u8 omac = mvif->mt76.omac_idx;
+	u8 omac = mvif->deflink.mt76.omac_idx;
 	struct {
 		u8 band_idx;
 		u8 __rsv[3];
@@ -4162,7 +4162,7 @@ int mt7996_mcu_update_bss_color(struct mt7996_dev *dev, struct ieee80211_vif *vi
 	struct sk_buff *skb;
 	struct tlv *tlv;
 
-	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76, len);
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &mvif->deflink.mt76, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -4212,12 +4212,12 @@ int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
 		.len = cpu_to_le16(sizeof(req) - 4),
 		.tbl_idx = flow->table_id,
 		.cmd = cmd,
-		.own_mac_idx = mvif->mt76.omac_idx,
+		.own_mac_idx = mvif->deflink.mt76.omac_idx,
 		.flowid = flow->id,
 		.peer_id = cpu_to_le16(flow->wcid),
 		.duration = flow->duration,
-		.bss = mvif->mt76.idx,
-		.bss_idx = mvif->mt76.idx,
+		.bss = mvif->deflink.mt76.idx,
+		.bss_idx = mvif->deflink.mt76.idx,
 		.start_tsf = cpu_to_le64(flow->tsf),
 		.mantissa = flow->mantissa,
 		.exponent = flow->exp,
@@ -4313,9 +4313,9 @@ int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 	struct mt7996_sta *msta;
 	struct sk_buff *skb;
 
-	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->sta;
+	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->deflink.sta;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->deflink.mt76,
 					      &msta->wcid,
 					      MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 465e3d9fd26d..31d1fdd61de6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -199,7 +199,7 @@ struct mt7996_sta {
 	} twt;
 };
 
-struct mt7996_vif {
+struct mt7996_vif_link {
 	struct mt76_vif_link mt76; /* must be first */
 
 	struct mt7996_sta sta;
@@ -209,6 +209,11 @@ struct mt7996_vif {
 	struct cfg80211_bitrate_mask bitrate_mask;
 };
 
+struct mt7996_vif {
+	struct mt7996_vif_link deflink; /* must be first */
+	struct mt76_vif_data mt76;
+};
+
 /* crash-dump */
 struct mt7996_crash_data {
 	guid_t guid;
@@ -464,6 +469,20 @@ mt7996_has_background_radar(struct mt7996_dev *dev)
 	return true;
 }
 
+static inline struct mt7996_vif_link *
+mt7996_vif_link(struct mt7996_dev *dev, struct ieee80211_vif *vif, int link_id)
+{
+	return (struct mt7996_vif_link *)mt76_vif_link(&dev->mt76, vif, link_id);
+}
+
+static inline struct mt7996_vif_link *
+mt7996_vif_conf_link(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+		     struct ieee80211_bss_conf *link_conf)
+{
+	return (struct mt7996_vif_link *)mt76_vif_conf_link(&dev->mt76, vif,
+							    link_conf);
+}
+
 extern const struct ieee80211_ops mt7996_ops;
 extern struct pci_driver mt7996_pci_driver;
 extern struct pci_driver mt7996_hif_driver;
-- 
2.47.1


