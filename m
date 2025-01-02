Return-Path: <linux-wireless+bounces-17015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7539FFBE3
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C64D7A1AFD
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F147015B102;
	Thu,  2 Jan 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="O9PGpwXv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701F17DE2D
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835727; cv=none; b=K4/ZXs5sXFPuDPAkXAzel3EKICJRjIVm1dslOopJw1JZ2pc6qzaqiVrXUC0/CF52fW+6Y7bXKULupY8hlEqiz8/ugEC4t2fZzs+b0BNiMb+wqsqRQgcq2+6tPG8o8xikyz5OzvsL98UoYzhKT/pU+aqiFwcWzcPRtMGAy7Vb9LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835727; c=relaxed/simple;
	bh=gtKQLquaJW3bLhwKWnIgZ6UNjbleaohRBXN0g+VMFHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZM3lOIswWtUtoa3azMT0EregmPwIiINxa1e0m0w9b2uriz6c05rzyOZMvAXIbnh0ugbrDSFvCpwCOLO/c92uq3i2lZMcDHuOVvs4pdDrNYbpUngsJcQIYAfzJtePKnDhIR8SE55WkKTT5KSYo6W+Ko/uJyFpoHrjy0w4EWY+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=O9PGpwXv; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UD5oa82Ctj/lANEgxFjY6N2Zds6PFFCOC/CYa2zN+pU=; b=O9PGpwXvhJ681IfrmGZjIVVrpf
	N+K8iNDwJDb1QoKXLSsL7WuoMHUVb1VAS1Hz1OPkepppsxmOxk/RTy8vFid1x6i3bpf3DvcggKQoS
	nP9Hw1cNFOa6/QhbSDSxj0iLP4XxCv2ExbaU+m2YYyM33rr6HMaX9pISAmrLHo/CdMhc=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAE-0008GS-2V;
	Thu, 02 Jan 2025 17:35:14 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH 21/24] wifi: mt76: connac: rework connac helpers
Date: Thu,  2 Jan 2025 17:35:05 +0100
Message-ID: <20250102163508.52945-21-nbd@nbd.name>
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

From: Shayne Chen <shayne.chen@mediatek.com>

Rework connac helpers related to rate and phymode.
This is a preliminary patch to add MLO support for mt7996 chipsets.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h |  2 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c | 16 ++++++++--------
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c |  6 +++---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 16 +++++++---------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c  |  2 +-
 7 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 445d0f0ab779..f7766a9815fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -427,7 +427,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 				 struct ieee80211_key_conf *key, int pid,
 				 enum mt76_txq_id qid, u32 changed);
 u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
-				 struct ieee80211_vif *vif,
+				 struct ieee80211_bss_conf *conf,
 				 bool beacon, bool mcast);
 bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 			       __le32 *txs_data);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 5170af3e3428..6d30f4fc3526 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -291,28 +291,28 @@ EXPORT_SYMBOL_GPL(mt76_connac_init_tx_queues);
 })
 
 u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
-				 struct ieee80211_vif *vif,
+				 struct ieee80211_bss_conf *conf,
 				 bool beacon, bool mcast)
 {
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_link *mvif = mt76_vif_conf_link(mphy->dev, conf->vif, conf);
 	struct cfg80211_chan_def *chandef = mvif->ctx ?
 					    &mvif->ctx->def : &mphy->chandef;
 	u8 nss = 0, mode = 0, band = chandef->chan->band;
 	int rateidx = 0, mcast_rate;
 	int offset = 0;
 
-	if (!vif)
+	if (!conf)
 		goto legacy;
 
 	if (is_mt7921(mphy->dev)) {
-		rateidx = ffs(vif->bss_conf.basic_rates) - 1;
+		rateidx = ffs(conf->basic_rates) - 1;
 		goto legacy;
 	}
 
 	if (beacon) {
 		struct cfg80211_bitrate_mask *mask;
 
-		mask = &vif->bss_conf.beacon_tx_rate;
+		mask = &conf->beacon_tx_rate;
 
 		__bitrate_mask_check(he_mcs, HE_SU);
 		__bitrate_mask_check(vht_mcs, VHT);
@@ -324,11 +324,11 @@ u16 mt76_connac2_mac_tx_rate_val(struct mt76_phy *mphy,
 		}
 	}
 
-	mcast_rate = vif->bss_conf.mcast_rate[band];
+	mcast_rate = conf->mcast_rate[band];
 	if (mcast && mcast_rate > 0)
 		rateidx = mcast_rate - 1;
 	else
-		rateidx = ffs(vif->bss_conf.basic_rates) - 1;
+		rateidx = ffs(conf->basic_rates) - 1;
 
 legacy:
 	if (band != NL80211_BAND_2GHZ)
@@ -581,7 +581,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 		bool multicast = ieee80211_is_data(hdr->frame_control) &&
 				 is_multicast_ether_addr(hdr->addr1);
-		u16 rate = mt76_connac2_mac_tx_rate_val(mphy, vif, beacon,
+		u16 rate = mt76_connac2_mac_tx_rate_val(mphy, &vif->bss_conf, beacon,
 							multicast);
 		u32 val = MT_TXD6_FIXED_BW;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 6e52e184aa20..e9ec9b7e0acb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1371,7 +1371,7 @@ u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_get_phy_mode);
 
-u8 mt76_connac_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
+u8 mt76_connac_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_bss_conf *conf,
 				enum nl80211_band band)
 {
 	const struct ieee80211_sta_eht_cap *eht_cap;
@@ -1382,9 +1382,9 @@ u8 mt76_connac_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		mode |= PHY_MODE_AX_6G;
 
 	sband = phy->hw->wiphy->bands[band];
-	eht_cap = ieee80211_get_eht_iftype_cap(sband, vif->type);
+	eht_cap = ieee80211_get_eht_iftype_cap(sband, conf->vif->type);
 
-	if (!eht_cap || !eht_cap->has_eht || !vif->bss_conf.eht_support)
+	if (!eht_cap || !eht_cap->has_eht || !conf->eht_support)
 		return mode;
 
 	switch (band) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 541b3c17168b..894b27cb6185 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -2018,7 +2018,7 @@ mt76_connac_get_eht_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif);
 u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			    enum nl80211_band band,
 			    struct ieee80211_link_sta *sta);
-u8 mt76_connac_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
+u8 mt76_connac_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_bss_conf *conf,
 				enum nl80211_band band);
 
 int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index c58838ad0189..7b93e8fb28ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -805,7 +805,7 @@ mt7925_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	u16 rate;
 	u8 i, idx, ht;
 
-	rate = mt76_connac2_mac_tx_rate_val(mphy, vif, beacon, mcast);
+	rate = mt76_connac2_mac_tx_rate_val(mphy, &vif->bss_conf, beacon, mcast);
 	ht = FIELD_GET(MT_TX_RATE_MODE, rate) > MT_PHY_TYPE_OFDM;
 
 	if (beacon && ht) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ab875abfbd0a..1bf45888ea1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -541,19 +541,17 @@ static void mt7996_configure_filter(struct ieee80211_hw *hw,
 }
 
 static u8
-mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+mt7996_get_rates_table(struct mt7996_phy *phy, struct ieee80211_bss_conf *conf,
 		       bool beacon, bool mcast)
 {
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
-	struct mt76_phy *mphy = hw->priv;
+	struct mt7996_dev *dev = phy->dev;
+	struct mt76_vif_link *mvif = mt76_vif_conf_link(&dev->mt76, conf->vif, conf);
 	u16 rate;
 	u8 i, idx;
 
-	rate = mt76_connac2_mac_tx_rate_val(mphy, vif, beacon, mcast);
+	rate = mt76_connac2_mac_tx_rate_val(phy->mt76, conf, beacon, mcast);
 
 	if (beacon) {
-		struct mt7996_phy *phy = mphy->priv;
-
 		/* odd index for driver, even index for firmware */
 		idx = MT7996_BEACON_RATES_TBL + 2 * phy->mt76->band_idx;
 		if (phy->beacon_rate != rate)
@@ -626,11 +624,11 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_MCAST_RATE)
 		mvif->mcast_rates_idx =
-			mt7996_get_rates_table(hw, vif, false, true);
+			mt7996_get_rates_table(phy, info, false, true);
 
 	if (changed & BSS_CHANGED_BASIC_RATES)
 		mvif->basic_rates_idx =
-			mt7996_get_rates_table(hw, vif, false, false);
+			mt7996_get_rates_table(phy, info, false, false);
 
 	/* ensure that enable txcmd_mode after bss_info */
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
@@ -650,7 +648,7 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & (BSS_CHANGED_BEACON |
 		       BSS_CHANGED_BEACON_ENABLED)) {
 		mvif->beacon_rates_idx =
-			mt7996_get_rates_table(hw, vif, true, false);
+			mt7996_get_rates_table(phy, info, true, false);
 
 		mt7996_mcu_add_beacon(hw, vif, info);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 83c079debf9a..ada019e44712 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1039,7 +1039,7 @@ mt7996_mcu_bss_basic_tlv(struct sk_buff *skb,
 	bss->dtim_period = vif->bss_conf.dtim_period;
 	bss->phymode = mt76_connac_get_phy_mode(phy, vif,
 						chandef->chan->band, NULL);
-	bss->phymode_ext = mt76_connac_get_phy_mode_ext(phy, vif,
+	bss->phymode_ext = mt76_connac_get_phy_mode_ext(phy, &vif->bss_conf,
 							chandef->chan->band);
 
 	return 0;
-- 
2.47.1


