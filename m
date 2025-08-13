Return-Path: <linux-wireless+bounces-26361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF2BB24940
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 14:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCED567AC2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3132F5323;
	Wed, 13 Aug 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="C+5Pxxih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D818F2F746C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087077; cv=none; b=c1XoYFmNNADEUAoq4NFAfl+pYKm97tO7cXfj7AlwsWCrFmOy6X/K2bYSGJ8YGBMB2RTuwBR7gn64ymmkbg+PBnmpIlbbeeo0HFPG7/DIN8upD877L0ec/eWbY0+WROLkCt+aOhVFiV0EPmQ3Ld5jibb4SbRXlKWF7QiqWb7DAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087077; c=relaxed/simple;
	bh=JYHZrFpT8fjrbjai2cyJpv5L3/EToj9LbUsSiAxA6fI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RL5DOjFXray4gbpIvEuh80v8dl09a7/h7XQUi15h2SWAlSAomrjS0Bhwr0Rbo4T3nU5UxwPStGCjvVm/yklzoYFCe32n705CCIfiqf/XoM4xajvP1E7IldxEtvfpTrg0OBodNSaKn/aq0D9eIojROYZ2fDLLlx+roGXxI+uwiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=C+5Pxxih; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PQX4zwe2mkvFP+go8Q2YWvHW4f0Sjau2b/jsTDUzatM=; b=C+5PxxihGITEQbRlSYx0wzTgUa
	KMpmUgc98oDV+KBPAkBFfFB/PKPZov08+pWLbtsELCeZL/v9TNixi4eTaGzEVjF3R11xh8lrEavtQ
	rF+aY7oyq4BadJERbiybTz4lXSC1Hpx+NCXnE6+OFicx+JhtgWwGmNIFkvdvyUIcD/58=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1umAJu-009tKb-2F
	for linux-wireless@vger.kernel.org;
	Wed, 13 Aug 2025 14:11:06 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] wifi: mt76: mt7996: disable beacons when going offchannel
Date: Wed, 13 Aug 2025 14:11:05 +0200
Message-ID: <20250813121106.81559-1-nbd@nbd.name>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid leaking beacons on unrelated channels during scanning/roc

Fixes: c56d6edebc1f ("wifi: mt76: mt7996: use emulated hardware scan support")
Reported-by: Chad Monroe <chad.monroe@adtran.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 46 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  5 ++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 11 +++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
 4 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 6333a064c4f7..d3d3b96f7dd2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1698,17 +1698,37 @@ mt7996_wait_reset_state(struct mt7996_dev *dev, u32 state)
 static void
 mt7996_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
-	struct ieee80211_hw *hw = priv;
+	struct ieee80211_bss_conf *link_conf;
+	struct mt7996_phy *phy = priv;
+	struct mt7996_dev *dev = phy->dev;
+	unsigned int link_id;
+
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_ADHOC:
 	case NL80211_IFTYPE_AP:
-		mt7996_mcu_add_beacon(hw, vif, &vif->bss_conf);
 		break;
 	default:
-		break;
+		return;
 	}
+
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		struct mt7996_vif_link *link;
+
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (link->phy != phy)
+			continue;
+
+		mt7996_mcu_add_beacon(dev->mt76.hw, vif, link_conf);
+	}
+}
+
+void mt7996_mac_update_beacons(struct mt7996_phy *phy)
+{
+	ieee80211_iterate_active_interfaces(phy->mt76->hw,
+					    IEEE80211_IFACE_ITER_RESUME_ALL,
+					    mt7996_update_vif_beacon, phy);
 }
 
 static void
@@ -1716,25 +1736,15 @@ mt7996_update_beacons(struct mt7996_dev *dev)
 {
 	struct mt76_phy *phy2, *phy3;
 
-	ieee80211_iterate_active_interfaces(dev->mt76.hw,
-					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt7996_update_vif_beacon, dev->mt76.hw);
+	mt7996_mac_update_beacons(&dev->phy);
 
 	phy2 = dev->mt76.phys[MT_BAND1];
-	if (!phy2)
-		return;
-
-	ieee80211_iterate_active_interfaces(phy2->hw,
-					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt7996_update_vif_beacon, phy2->hw);
+	if (phy2)
+		mt7996_mac_update_beacons(phy2->priv);
 
 	phy3 = dev->mt76.phys[MT_BAND2];
-	if (!phy3)
-		return;
-
-	ieee80211_iterate_active_interfaces(phy3->hw,
-					    IEEE80211_IFACE_ITER_RESUME_ALL,
-					    mt7996_update_vif_beacon, phy3->hw);
+	if (phy3)
+		mt7996_mac_update_beacons(phy3->priv);
 }
 
 void mt7996_tx_token_put(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 3d5ba568243b..38d15963ec58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -558,6 +558,9 @@ int mt7996_set_channel(struct mt76_phy *mphy)
 	struct mt7996_phy *phy = mphy->priv;
 	int ret;
 
+	if (mphy->offchannel)
+		mt7996_mac_update_beacons(phy);
+
 	ret = mt7996_mcu_set_chan_info(phy, UNI_CHANNEL_SWITCH);
 	if (ret)
 		goto out;
@@ -575,6 +578,8 @@ int mt7996_set_channel(struct mt76_phy *mphy)
 
 	mt7996_mac_reset_counters(phy);
 	phy->noise = 0;
+	if (!mphy->offchannel)
+		mt7996_mac_update_beacons(phy);
 
 out:
 	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index a6cd82ccf5e4..64ac45920509 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2770,13 +2770,15 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *link_conf)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
-	struct mt76_vif_link *mlink = mt76_vif_conf_link(&dev->mt76, vif, link_conf);
+	struct mt7996_vif_link *link = mt7996_vif_conf_link(dev, vif, link_conf);
+	struct mt76_vif_link *mlink = link ? &link->mt76 : NULL;
 	struct ieee80211_mutable_offsets offs;
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb, *rskb;
 	struct tlv *tlv;
 	struct bss_bcn_content_tlv *bcn;
 	int len, extra_len = 0;
+	bool enabled = link_conf->enable_beacon;
 
 	if (link_conf->nontransmitted)
 		return 0;
@@ -2784,13 +2786,16 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (!mlink)
 		return -EINVAL;
 
+	if (link->phy && link->phy->mt76->offchannel)
+		enabled = false;
+
 	rskb = __mt7996_mcu_alloc_bss_req(&dev->mt76, mlink,
 					  MT7996_MAX_BSS_OFFLOAD_SIZE);
 	if (IS_ERR(rskb))
 		return PTR_ERR(rskb);
 
 	skb = ieee80211_beacon_get_template(hw, vif, &offs, link_conf->link_id);
-	if (link_conf->enable_beacon && !skb) {
+	if (enabled && !skb) {
 		dev_kfree_skb(rskb);
 		return -EINVAL;
 	}
@@ -2809,7 +2814,7 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	len = ALIGN(sizeof(*bcn) + MT_TXD_SIZE + extra_len, 4);
 	tlv = mt7996_mcu_add_uni_tlv(rskb, UNI_BSS_INFO_BCN_CONTENT, len);
 	bcn = (struct bss_bcn_content_tlv *)tlv;
-	bcn->enable = link_conf->enable_beacon;
+	bcn->enable = enabled;
 	if (!bcn->enable)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index a7b6f328af39..b98cfe6e5be8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -741,6 +741,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, int pid,
 			   enum mt76_txq_id qid, u32 changed);
+void mt7996_mac_update_beacons(struct mt7996_phy *phy);
 void mt7996_mac_set_coverage_class(struct mt7996_phy *phy);
 void mt7996_mac_work(struct work_struct *work);
 void mt7996_mac_reset_work(struct work_struct *work);
-- 
2.50.1


