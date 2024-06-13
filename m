Return-Path: <linux-wireless+bounces-8912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212FB90623C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E5FB22737
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE94612CD8C;
	Thu, 13 Jun 2024 03:02:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336AA12D741
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247774; cv=none; b=WYv5bijxVlyoRvvJG7RQOSIb4+zVUKFJEgXZVyJQo8qQ3PvjSeoh50OtvelkxBs2//BVZT/l9b5jejdmKuyC42eTnJMXcyWkXgLLyxFl6HYRVQI0QPHwr/AUnQJSEDL14y8veyqJzd3UlDc3H+O7RIj581wcjhi2cwrViDATP8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247774; c=relaxed/simple;
	bh=mln26U6Mfnu2Q9VQ3uPHRr3DVWs292ziok5fMOCawsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hj/iQFuUVH7EdMuLSmofVuTKMXUzM82Jb/me8Qtl9DLkxHfmuCGm8UZMCii1P9qf6asFzo2P0LOeS4XgS1/ZZJ7JNgIE/bxJ4QPS2oFVSf7U3+6emhP6v1Q/cMVs/UX5K/6JVNPhH665u9qf3ZJUXrA6kftA34KAnm2aDgU7+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5bad97708efso31419eaf.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247771; x=1718852571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJs+pWA0FK/vqrreddQoIY2LJaLCDK8lojdOWHfMP+4=;
        b=jMqWtUYOHGKyKgOe6w9nFk8yX4y9/VWh2Ur2B8jNcnKjntuW6pAVn1AeWtEDCSs9dv
         1MJ0TvN46pUzvBDRpraGeZ1JesmPFSb7zfylgXzdhF1FCoDXZGvdHkKoFpt5mEwQ3v1+
         UkPZFE7g68A1DQq6DqWiDA6Angm5HC+fp4LrrFzoyno1QFkyASi2KJbKsY94b92VBadW
         EaQybFnMpf2KmysUH3uaPq2dBmBKy6YQIOjXStXz4zgeJ7xaaGMVHAHDZrvsvpKNBEEk
         aC+v6TE/Ru2l4m0ItZ0Z4VRm37yxOnwhzGPBu2Mmy/wnFCi0gtz+0RMXuWVzr8ipwB6i
         4VvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDVKIESq1CxFfC1GQdzsbK9EIPdAEFWKxHRXTVqEzLA+49HpWmdQJW3RPVbSc5Pnk0OYFD2O0EJjHv8R/UG211Z8v0MoIbGE3T1BW8xUI=
X-Gm-Message-State: AOJu0Yw11jARz+OYSp+1piyAIsotiM+Ml3CB5X2bsOk5xuELvBm4zZ2i
	kVL7RAJ1BSE1SdBSRA24zvslKsFFCNA4ndVbyNB95FXVJM9XBB0fOb+XTdprXuw=
X-Google-Smtp-Source: AGHT+IGyiUOWNetC4oWMDxs3+zNOSXbCfx0lDtCFW5uxgzZE+dNIdDR+LHPiy/rQfzTY2iMgrx2oZw==
X-Received: by 2002:a4a:3101:0:b0:5ba:ca8a:6598 with SMTP id 006d021491bc7-5bb3b7b972bmr3905843eaf.0.1718247770704;
        Wed, 12 Jun 2024 20:02:50 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:02:50 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 02/47] wifi: mt76: mt792x: add struct mt792x_link_sta
Date: Wed, 12 Jun 2024 20:01:56 -0700
Message-Id: <20240613030241.5771-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613030241.5771-1-sean.wang@kernel.org>
References: <20240613030241.5771-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deren Wu <deren.wu@mediatek.com>

We are introducing a new structure, mt792x_link_sta, to manage per-link
configurations in preparation for future station (STA) support of
Multi-Link Operation (MLO).

This patch only includes structural changes and does not involve any
logic changes.

We have moved relevant parameters, such as the wcid from the mt76_wcid
structure, from the mt7921x_sta structure to the mt792x_link_sta structure.

For current drivers that do not support MLO, there is only one link STA,
and link information is accessed via the deflink member.

However, we have not yet created the per-link BSS configuration indexed
by link ID for Multi-Link Device (MLD) support in mt7921x_sta.
This step needs to be completed before adding MLD support for STA mode.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 65 ++++++++--------
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 76 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  4 +-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7925/mac.c   | 66 ++++++++--------
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 66 ++++++++--------
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 17 +++--
 .../wireless/mediatek/mt76/mt7925/pci_mac.c   |  4 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   | 10 ++-
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 28 +++----
 .../net/wireless/mediatek/mt76/mt792x_mac.c   |  6 +-
 11 files changed, 180 insertions(+), 166 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 867e14f6b93a..5ea01c39e2e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -39,6 +39,7 @@ static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 	};
 	struct ieee80211_sta *sta;
 	struct mt792x_sta *msta;
+	struct mt792x_link_sta *mlink;
 	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
 	LIST_HEAD(sta_poll_list);
 	struct rate_info *rate;
@@ -60,23 +61,25 @@ static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 			spin_unlock_bh(&dev->mt76.sta_poll_lock);
 			break;
 		}
-		msta = list_first_entry(&sta_poll_list,
-					struct mt792x_sta, wcid.poll_list);
-		list_del_init(&msta->wcid.poll_list);
+		mlink = list_first_entry(&sta_poll_list,
+					 struct mt792x_link_sta,
+					 wcid.poll_list);
+		msta = container_of(mlink, struct mt792x_sta, deflink);
+		list_del_init(&mlink->wcid.poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-		idx = msta->wcid.idx;
+		idx = mlink->wcid.idx;
 		addr = mt7921_mac_wtbl_lmac_addr(idx, MT_WTBL_AC0_CTT_OFFSET);
 
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			u32 tx_last = msta->airtime_ac[i];
-			u32 rx_last = msta->airtime_ac[i + 4];
+			u32 tx_last = mlink->airtime_ac[i];
+			u32 rx_last = mlink->airtime_ac[i + 4];
 
-			msta->airtime_ac[i] = mt76_rr(dev, addr);
-			msta->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
+			mlink->airtime_ac[i] = mt76_rr(dev, addr);
+			mlink->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
 
-			tx_time[i] = msta->airtime_ac[i] - tx_last;
-			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
+			tx_time[i] = mlink->airtime_ac[i] - tx_last;
+			rx_time[i] = mlink->airtime_ac[i + 4] - rx_last;
 
 			if ((tx_last | rx_last) & BIT(30))
 				clear = true;
@@ -87,10 +90,10 @@ static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 		if (clear) {
 			mt7921_mac_wtbl_update(dev, idx,
 					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+			memset(mlink->airtime_ac, 0, sizeof(mlink->airtime_ac));
 		}
 
-		if (!msta->wcid.sta)
+		if (!mlink->wcid.sta)
 			continue;
 
 		sta = container_of((void *)msta, struct ieee80211_sta,
@@ -113,7 +116,7 @@ static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 		 * we need to make sure that flags match so polling GI
 		 * from per-sta counters directly.
 		 */
-		rate = &msta->wcid.rate;
+		rate = &mlink->wcid.rate;
 		addr = mt7921_mac_wtbl_lmac_addr(idx,
 						 MT_WTBL_TXRX_CAP_RATE_OFFSET);
 		val = mt76_rr(dev, addr);
@@ -154,10 +157,10 @@ static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
 		rssi[3] = to_rssi(GENMASK(31, 14), val);
 
-		msta->ack_signal =
+		mlink->ack_signal =
 			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
 
-		ewma_avg_signal_add(&msta->avg_ack_signal, -msta->ack_signal);
+		ewma_avg_signal_add(&mlink->avg_ack_signal, -mlink->ack_signal);
 	}
 }
 
@@ -180,6 +183,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	u32 rxd3 = le32_to_cpu(rxd[3]);
 	u32 rxd4 = le32_to_cpu(rxd[4]);
 	struct mt792x_sta *msta = NULL;
+	struct mt792x_link_sta *mlink;
 	u16 seq_ctrl = 0;
 	__le16 fc = 0;
 	u8 mode = 0;
@@ -210,10 +214,11 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	status->wcid = mt792x_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
-		msta = container_of(status->wcid, struct mt792x_sta, wcid);
+		mlink = container_of(status->wcid, struct mt792x_link_sta, wcid);
+		msta = container_of(mlink, struct mt792x_sta, deflink);
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&msta->wcid.poll_list))
-			list_add_tail(&msta->wcid.poll_list,
+		if (list_empty(&mlink->wcid.poll_list))
+			list_add_tail(&mlink->wcid.poll_list,
 				      &dev->mt76.sta_poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
@@ -444,7 +449,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 
 void mt7921_mac_add_txs(struct mt792x_dev *dev, void *data)
 {
-	struct mt792x_sta *msta = NULL;
+	struct mt792x_link_sta *mlink;
 	struct mt76_wcid *wcid;
 	__le32 *txs_data = data;
 	u16 wcidx;
@@ -468,15 +473,15 @@ void mt7921_mac_add_txs(struct mt792x_dev *dev, void *data)
 	if (!wcid)
 		goto out;
 
-	msta = container_of(wcid, struct mt792x_sta, wcid);
+	mlink = container_of(wcid, struct mt792x_link_sta, wcid);
 
 	mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data);
 	if (!wcid->sta)
 		goto out;
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->wcid.poll_list))
-		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
+	if (list_empty(&mlink->wcid.poll_list))
+		list_add_tail(&mlink->wcid.poll_list, &dev->mt76.sta_poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 out:
@@ -513,7 +518,7 @@ static void mt7921_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 		 * 1'b0: msdu_id with the same 'wcid pair' as above.
 		 */
 		if (info & MT_TX_FREE_PAIR) {
-			struct mt792x_sta *msta;
+			struct mt792x_link_sta *mlink;
 			u16 idx;
 
 			count++;
@@ -523,10 +528,10 @@ static void mt7921_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 			if (!sta)
 				continue;
 
-			msta = container_of(wcid, struct mt792x_sta, wcid);
+			mlink = container_of(wcid, struct mt792x_link_sta, wcid);
 			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&msta->wcid.poll_list))
-				list_add_tail(&msta->wcid.poll_list,
+			if (list_empty(&mlink->wcid.poll_list))
+				list_add_tail(&mlink->wcid.poll_list,
 					      &mdev->sta_poll_list);
 			spin_unlock_bh(&mdev->sta_poll_lock);
 			continue;
@@ -641,11 +646,11 @@ mt7921_vif_connect_iter(void *priv, u8 *mac,
 	if (vif->type == NL80211_IFTYPE_STATION)
 		ieee80211_disconnect(vif, true);
 
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, true);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.deflink.wcid, true);
 	mt7921_mcu_set_tx(dev, vif);
 
 	if (vif->type == NL80211_IFTYPE_AP) {
-		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.wcid,
+		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.deflink.wcid,
 					    true, NULL);
 		mt7921_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_NONE);
@@ -784,9 +789,9 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (sta) {
 		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
-		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
+		if (time_after(jiffies, msta->deflink.last_txs + HZ / 4)) {
 			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-			msta->last_txs = jiffies;
+			msta->deflink.last_txs = jiffies;
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 2752e1735575..3141807ec54b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -306,7 +306,7 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->bss_conf.mt76.band_idx = 0;
 	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
-	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid,
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.deflink.wcid,
 					  true);
 	if (ret)
 		goto out;
@@ -316,19 +316,19 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	idx = MT792x_WTBL_RESERVED - mvif->bss_conf.mt76.idx;
 
-	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
-	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
-	mvif->sta.wcid.hw_key_idx = -1;
-	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_wcid_init(&mvif->sta.wcid);
+	INIT_LIST_HEAD(&mvif->sta.deflink.wcid.poll_list);
+	mvif->sta.deflink.wcid.idx = idx;
+	mvif->sta.deflink.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
+	mvif->sta.deflink.wcid.hw_key_idx = -1;
+	mvif->sta.deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mt76_wcid_init(&mvif->sta.deflink.wcid);
 
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	ewma_rssi_init(&mvif->bss_conf.rssi);
 
-	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
+	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.deflink.wcid);
 	if (vif->txq) {
 		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 		mtxq->wcid = idx;
@@ -494,7 +494,7 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
 				  &mvif->sta;
-	struct mt76_wcid *wcid = &msta->wcid;
+	struct mt76_wcid *wcid = &msta->deflink.wcid;
 	u8 *wcid_keyidx = &wcid->hw_key_idx;
 	int idx = key->keyidx, err = 0;
 
@@ -541,18 +541,18 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	}
 
 	mt76_wcid_key_setup(&dev->mt76, wcid, key);
-	err = mt76_connac_mcu_add_key(&dev->mt76, vif, &msta->bip,
+	err = mt76_connac_mcu_add_key(&dev->mt76, vif, &msta->deflink.bip,
 				      key, MCU_UNI_CMD(STA_REC_UPDATE),
-				      &msta->wcid, cmd);
+				      &msta->deflink.wcid, cmd);
 	if (err)
 		goto out;
 
 	if (key->cipher == WLAN_CIPHER_SUITE_WEP104 ||
 	    key->cipher == WLAN_CIPHER_SUITE_WEP40)
 		err = mt76_connac_mcu_add_key(&dev->mt76, vif,
-					      &mvif->wep_sta->bip,
+					      &mvif->wep_sta->deflink.bip,
 					      key, MCU_UNI_CMD(STA_REC_UPDATE),
-					      &mvif->wep_sta->wcid, cmd);
+					      &mvif->wep_sta->deflink.wcid, cmd);
 out:
 	mt792x_mutex_release(dev);
 
@@ -799,13 +799,13 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
-	INIT_LIST_HEAD(&msta->wcid.poll_list);
+	INIT_LIST_HEAD(&msta->deflink.wcid.poll_list);
 	msta->vif = mvif;
-	msta->wcid.sta = 1;
-	msta->wcid.idx = idx;
-	msta->wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
-	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	msta->last_txs = jiffies;
+	msta->deflink.wcid.sta = 1;
+	msta->deflink.wcid.idx = idx;
+	msta->deflink.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
+	msta->deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	msta->deflink.last_txs = jiffies;
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
@@ -840,14 +840,14 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt792x_mutex_acquire(dev);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
-		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
+		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.deflink.wcid,
 					    true, mvif->bss_conf.mt76.ctx);
 
-	ewma_avg_signal_init(&msta->avg_ack_signal);
+	ewma_avg_signal_init(&msta->deflink.avg_ack_signal);
 
-	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
+	mt7921_mac_wtbl_update(dev, msta->deflink.wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-	memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+	memset(msta->deflink.airtime_ac, 0, sizeof(msta->deflink.airtime_ac));
 
 	mt7921_mcu_sta_update(dev, sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
 
@@ -861,11 +861,11 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
-	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
 	mt7921_mcu_sta_update(dev, sta, vif, false, MT76_STA_INFO_STATE_NONE);
-	mt7921_mac_wtbl_update(dev, msta->wcid.idx,
+	mt7921_mac_wtbl_update(dev, msta->deflink.wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
@@ -875,13 +875,13 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		ewma_rssi_init(&mvif->bss_conf.rssi);
 		if (!sta->tdls)
 			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
-						    &mvif->sta.wcid, false,
+						    &mvif->sta.deflink.wcid, false,
 						    mvif->bss_conf.mt76.ctx);
 	}
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (!list_empty(&msta->wcid.poll_list))
-		list_del_init(&msta->wcid.poll_list);
+	if (!list_empty(&msta->deflink.wcid.poll_list))
+		list_del_init(&msta->deflink.wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mt7921_regd_set_6ghz_power_type(vif, false);
@@ -923,12 +923,12 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt792x_mutex_acquire(dev);
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
-		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
+		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
 				   params->buf_size);
 		mt7921_mcu_uni_rx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
-		mt76_rx_aggr_stop(&dev->mt76, &msta->wcid, tid);
+		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
 		mt7921_mcu_uni_rx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
@@ -939,16 +939,16 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->wcid.ampdu_state);
+		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
 		mt7921_mcu_uni_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		set_bit(tid, &msta->wcid.ampdu_state);
+		set_bit(tid, &msta->deflink.wcid.ampdu_state);
 		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->wcid.ampdu_state);
+		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
 		mt7921_mcu_uni_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
@@ -1166,11 +1166,11 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 	mt792x_mutex_acquire(dev);
 
 	if (enabled)
-		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->deflink.wcid.flags);
 	else
-		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->deflink.wcid.flags);
 
-	mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76, vif, &msta->wcid,
+	mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76, vif, &msta->deflink.wcid,
 					     MCU_UNI_CMD(STA_REC_UPDATE));
 
 	mt792x_mutex_release(dev);
@@ -1294,7 +1294,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mt792x_mutex_acquire(dev);
 
-	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
+	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.deflink.wcid,
 					  true, mvif->bss_conf.mt76.ctx);
 	if (err)
 		goto out;
@@ -1326,7 +1326,7 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (err)
 		goto out;
 
-	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false,
+	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.deflink.wcid, false,
 				    mvif->bss_conf.mt76.ctx);
 
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 0453af012016..394fcd799345 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -386,7 +386,7 @@ int mt7921_mcu_uni_tx_ba(struct mt792x_dev *dev,
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
 
 	if (enable && !params->amsdu)
-		msta->wcid.amsdu = false;
+		msta->deflink.wcid.amsdu = false;
 
 	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->bss_conf.mt76, params,
 				      MCU_UNI_CMD(STA_REC_UPDATE),
@@ -1055,7 +1055,7 @@ int mt7921_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
 	struct mt792x_sta *msta;
 
 	msta = sta ? (struct mt792x_sta *)sta->drv_priv : NULL;
-	info.wcid = msta ? &msta->wcid : &mvif->sta.wcid;
+	info.wcid = msta ? &msta->deflink.wcid : &mvif->sta.deflink.wcid;
 	info.newly = msta ? state != MT76_STA_INFO_STATE_ASSOC : true;
 
 	return mt76_connac_mcu_sta_cmd(&dev->mphy, &info);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index c866144ff061..a0c19e861ce1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -34,9 +34,9 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (sta) {
 		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
-		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
+		if (time_after(jiffies, msta->deflink.last_txs + HZ / 4)) {
 			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-			msta->last_txs = jiffies;
+			msta->deflink.last_txs = jiffies;
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index c2460ef4993d..88e7b2ff4593 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -28,6 +28,7 @@ static void mt7925_mac_sta_poll(struct mt792x_dev *dev)
 	};
 	struct ieee80211_sta *sta;
 	struct mt792x_sta *msta;
+	struct mt792x_link_sta *mlink;
 	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
 	LIST_HEAD(sta_poll_list);
 	struct rate_info *rate;
@@ -46,24 +47,25 @@ static void mt7925_mac_sta_poll(struct mt792x_dev *dev)
 
 		if (list_empty(&sta_poll_list))
 			break;
-		msta = list_first_entry(&sta_poll_list,
-					struct mt792x_sta, wcid.poll_list);
+		mlink = list_first_entry(&sta_poll_list,
+					 struct mt792x_link_sta, wcid.poll_list);
+		msta = container_of(mlink, struct mt792x_sta, deflink);
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		list_del_init(&msta->wcid.poll_list);
+		list_del_init(&mlink->wcid.poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-		idx = msta->wcid.idx;
+		idx = mlink->wcid.idx;
 		addr = mt7925_mac_wtbl_lmac_addr(dev, idx, MT_WTBL_AC0_CTT_OFFSET);
 
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			u32 tx_last = msta->airtime_ac[i];
-			u32 rx_last = msta->airtime_ac[i + 4];
+			u32 tx_last = mlink->airtime_ac[i];
+			u32 rx_last = mlink->airtime_ac[i + 4];
 
-			msta->airtime_ac[i] = mt76_rr(dev, addr);
-			msta->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
+			mlink->airtime_ac[i] = mt76_rr(dev, addr);
+			mlink->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
 
-			tx_time[i] = msta->airtime_ac[i] - tx_last;
-			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
+			tx_time[i] = mlink->airtime_ac[i] - tx_last;
+			rx_time[i] = mlink->airtime_ac[i + 4] - rx_last;
 
 			if ((tx_last | rx_last) & BIT(30))
 				clear = true;
@@ -74,10 +76,10 @@ static void mt7925_mac_sta_poll(struct mt792x_dev *dev)
 		if (clear) {
 			mt7925_mac_wtbl_update(dev, idx,
 					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+			memset(mlink->airtime_ac, 0, sizeof(mlink->airtime_ac));
 		}
 
-		if (!msta->wcid.sta)
+		if (!mlink->wcid.sta)
 			continue;
 
 		sta = container_of((void *)msta, struct ieee80211_sta,
@@ -100,7 +102,7 @@ static void mt7925_mac_sta_poll(struct mt792x_dev *dev)
 		 * we need to make sure that flags match so polling GI
 		 * from per-sta counters directly.
 		 */
-		rate = &msta->wcid.rate;
+		rate = &mlink->wcid.rate;
 
 		switch (rate->bw) {
 		case RATE_INFO_BW_160:
@@ -144,10 +146,10 @@ static void mt7925_mac_sta_poll(struct mt792x_dev *dev)
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
 		rssi[3] = to_rssi(GENMASK(31, 14), val);
 
-		msta->ack_signal =
+		mlink->ack_signal =
 			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
 
-		ewma_avg_signal_add(&msta->avg_ack_signal, -msta->ack_signal);
+		ewma_avg_signal_add(&mlink->avg_ack_signal, -mlink->ack_signal);
 	}
 }
 
@@ -365,7 +367,7 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
 	u32 rxd4 = le32_to_cpu(rxd[4]);
-	struct mt792x_sta *msta = NULL;
+	struct mt792x_link_sta *mlink;
 	u8 mode = 0; /* , band_idx; */
 	u16 seq_ctrl = 0;
 	__le16 fc = 0;
@@ -393,10 +395,10 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	status->wcid = mt792x_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
-		msta = container_of(status->wcid, struct mt792x_sta, wcid);
+		mlink = container_of(status->wcid, struct mt792x_link_sta, wcid);
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&msta->wcid.poll_list))
-			list_add_tail(&msta->wcid.poll_list,
+		if (list_empty(&mlink->wcid.poll_list))
+			list_add_tail(&mlink->wcid.poll_list,
 				      &dev->mt76.sta_poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 	}
@@ -851,7 +853,7 @@ static void mt7925_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		return;
 
 	msta = (struct mt792x_sta *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &msta->wcid.ampdu_state))
+	if (!test_and_set_bit(tid, &msta->deflink.wcid.ampdu_state))
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
@@ -991,7 +993,7 @@ mt7925_mac_add_txs_skb(struct mt792x_dev *dev, struct mt76_wcid *wcid,
 
 void mt7925_mac_add_txs(struct mt792x_dev *dev, void *data)
 {
-	struct mt792x_sta *msta = NULL;
+	struct mt792x_link_sta *mlink = NULL;
 	struct mt76_wcid *wcid;
 	__le32 *txs_data = data;
 	u16 wcidx;
@@ -1015,15 +1017,15 @@ void mt7925_mac_add_txs(struct mt792x_dev *dev, void *data)
 	if (!wcid)
 		goto out;
 
-	msta = container_of(wcid, struct mt792x_sta, wcid);
+	mlink = container_of(wcid, struct mt792x_link_sta, wcid);
 
 	mt7925_mac_add_txs_skb(dev, wcid, pid, txs_data);
 	if (!wcid->sta)
 		goto out;
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->wcid.poll_list))
-		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
+	if (list_empty(&mlink->wcid.poll_list))
+		list_add_tail(&mlink->wcid.poll_list, &dev->mt76.sta_poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 out:
@@ -1094,7 +1096,7 @@ mt7925_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 		 */
 		info = le32_to_cpu(*cur_info);
 		if (info & MT_TXFREE_INFO_PAIR) {
-			struct mt792x_sta *msta;
+			struct mt792x_link_sta *mlink;
 			u16 idx;
 
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
@@ -1103,10 +1105,10 @@ mt7925_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 			if (!sta)
 				continue;
 
-			msta = container_of(wcid, struct mt792x_sta, wcid);
+			mlink = container_of(wcid, struct mt792x_link_sta, wcid);
 			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&msta->wcid.poll_list))
-				list_add_tail(&msta->wcid.poll_list,
+			if (list_empty(&mlink->wcid.poll_list))
+				list_add_tail(&mlink->wcid.poll_list,
 					      &mdev->sta_poll_list);
 			spin_unlock_bh(&mdev->sta_poll_lock);
 			continue;
@@ -1241,11 +1243,11 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 	if (vif->type == NL80211_IFTYPE_STATION)
 		ieee80211_disconnect(vif, true);
 
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, true);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.deflink.wcid, true);
 	mt7925_mcu_set_tx(dev, vif);
 
 	if (vif->type == NL80211_IFTYPE_AP) {
-		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.wcid,
+		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.deflink.wcid,
 					    true, NULL);
 		mt7925_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_NONE);
@@ -1380,9 +1382,9 @@ int mt7925_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (sta) {
 		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
-		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
+		if (time_after(jiffies, msta->deflink.last_txs + HZ / 4)) {
 			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-			msta->last_txs = jiffies;
+			msta->deflink.last_txs = jiffies;
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index dfc606cc9bdd..504c2ecc3845 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -344,7 +344,7 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	else
 		mvif->bss_conf.mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL;
 
-	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid,
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.deflink.wcid,
 					  true);
 	if (ret)
 		goto out;
@@ -354,20 +354,20 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	idx = MT792x_WTBL_RESERVED - mvif->bss_conf.mt76.idx;
 
-	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
-	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
-	mvif->sta.wcid.hw_key_idx = -1;
-	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	INIT_LIST_HEAD(&mvif->sta.deflink.wcid.poll_list);
+	mvif->sta.deflink.wcid.idx = idx;
+	mvif->sta.deflink.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
+	mvif->sta.deflink.wcid.hw_key_idx = -1;
+	mvif->sta.deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mvif->sta.vif = mvif;
-	mt76_wcid_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.deflink.wcid);
 
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	ewma_rssi_init(&mvif->bss_conf.rssi);
 
-	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
+	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.deflink.wcid);
 	if (vif->txq) {
 		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 		mtxq->wcid = idx;
@@ -486,7 +486,7 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
 				  &mvif->sta;
-	struct mt76_wcid *wcid = &msta->wcid;
+	struct mt76_wcid *wcid = &msta->deflink.wcid;
 	u8 *wcid_keyidx = &wcid->hw_key_idx;
 	int idx = key->keyidx, err = 0;
 
@@ -541,18 +541,18 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	mt76_wcid_key_setup(&dev->mt76, wcid,
 			    cmd == SET_KEY ? key : NULL);
 
-	err = mt7925_mcu_add_key(&dev->mt76, vif, &msta->bip,
+	err = mt7925_mcu_add_key(&dev->mt76, vif, &msta->deflink.bip,
 				 key, MCU_UNI_CMD(STA_REC_UPDATE),
-				 &msta->wcid, cmd);
+				 &msta->deflink.wcid, cmd);
 
 	if (err)
 		goto out;
 
 	if (key->cipher == WLAN_CIPHER_SUITE_WEP104 ||
 	    key->cipher == WLAN_CIPHER_SUITE_WEP40)
-		err = mt7925_mcu_add_key(&dev->mt76, vif, &mvif->wep_sta->bip,
+		err = mt7925_mcu_add_key(&dev->mt76, vif, &mvif->wep_sta->deflink.bip,
 					 key, MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
-					 &mvif->wep_sta->wcid, cmd);
+					 &mvif->wep_sta->deflink.wcid, cmd);
 
 out:
 	mt792x_mutex_release(dev);
@@ -766,13 +766,13 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
-	INIT_LIST_HEAD(&msta->wcid.poll_list);
+	INIT_LIST_HEAD(&msta->deflink.wcid.poll_list);
 	msta->vif = mvif;
-	msta->wcid.sta = 1;
-	msta->wcid.idx = idx;
-	msta->wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
-	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	msta->last_txs = jiffies;
+	msta->deflink.wcid.sta = 1;
+	msta->deflink.wcid.idx = idx;
+	msta->deflink.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
+	msta->deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	msta->deflink.last_txs = jiffies;
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
@@ -813,11 +813,11 @@ void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, vif, sta,
 					true);
 
-	ewma_avg_signal_init(&msta->avg_ack_signal);
+	ewma_avg_signal_init(&msta->deflink.avg_ack_signal);
 
-	mt7925_mac_wtbl_update(dev, msta->wcid.idx,
+	mt7925_mac_wtbl_update(dev, msta->deflink.wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-	memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+	memset(msta->deflink.airtime_ac, 0, sizeof(msta->deflink.airtime_ac));
 
 	mt7925_mcu_sta_update(dev, sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
 
@@ -831,11 +831,11 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
-	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
 	mt7925_mcu_sta_update(dev, sta, vif, false, MT76_STA_INFO_STATE_NONE);
-	mt7925_mac_wtbl_update(dev, msta->wcid.idx,
+	mt7925_mac_wtbl_update(dev, msta->deflink.wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
@@ -849,8 +849,8 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	}
 
 	spin_lock_bh(&mdev->sta_poll_lock);
-	if (!list_empty(&msta->wcid.poll_list))
-		list_del_init(&msta->wcid.poll_list);
+	if (!list_empty(&msta->deflink.wcid.poll_list))
+		list_del_init(&msta->deflink.wcid.poll_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
@@ -890,12 +890,12 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt792x_mutex_acquire(dev);
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
-		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
+		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
 				   params->buf_size);
 		mt7925_mcu_uni_rx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
-		mt76_rx_aggr_stop(&dev->mt76, &msta->wcid, tid);
+		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
 		mt7925_mcu_uni_rx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
@@ -906,16 +906,16 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->wcid.ampdu_state);
+		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
 		mt7925_mcu_uni_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		set_bit(tid, &msta->wcid.ampdu_state);
+		set_bit(tid, &msta->deflink.wcid.ampdu_state);
 		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
-		clear_bit(tid, &msta->wcid.ampdu_state);
+		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
 		mt7925_mcu_uni_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
@@ -1161,9 +1161,9 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
 	mt792x_mutex_acquire(dev);
 
 	if (enabled)
-		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->deflink.wcid.flags);
 	else
-		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->deflink.wcid.flags);
 
 	mt7925_mcu_wtbl_update_hdr_trans(dev, vif, sta);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index c259aedb96e0..67c05f785190 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -544,7 +544,7 @@ int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
 	struct mt792x_vif *mvif = msta->vif;
 
 	if (enable && !params->amsdu)
-		msta->wcid.amsdu = false;
+		msta->deflink.wcid.amsdu = false;
 
 	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
 				 enable, true);
@@ -867,7 +867,7 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 	if (sta)
 		wcid = (struct mt76_wcid *)sta->drv_priv;
 	else
-		wcid = &mvif->sta.wcid;
+		wcid = &mvif->sta.deflink.wcid;
 
 	if (!wcid)
 		return;
@@ -890,7 +890,7 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 	msta = sta ? (struct mt792x_sta *)sta->drv_priv : &mvif->sta;
 
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->bss_conf.mt76,
-					      &msta->wcid,
+					      &msta->deflink.wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -962,7 +962,8 @@ mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 		       struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd)
 {
-	struct mt792x_sta *msta = container_of(wcid, struct mt792x_sta, wcid);
+	struct mt792x_link_sta *mlink = container_of(wcid, struct mt792x_link_sta, wcid);
+	struct mt792x_sta *msta = container_of(mlink, struct mt792x_sta, deflink);
 	struct sta_rec_sec_uni *sec;
 	struct mt792x_vif *mvif = msta->vif;
 	struct ieee80211_sta *sta;
@@ -1480,7 +1481,7 @@ mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
 	amsdu = (struct sta_rec_amsdu *)tlv;
 	amsdu->max_amsdu_num = 8;
 	amsdu->amsdu_en = true;
-	msta->wcid.amsdu = true;
+	msta->deflink.wcid.amsdu = true;
 
 	switch (sta->deflink.agg.max_amsdu_len) {
 	case IEEE80211_MAX_MPDU_LEN_VHT_11454:
@@ -1668,7 +1669,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
 	struct mt792x_sta *msta;
 
 	msta = sta ? (struct mt792x_sta *)sta->drv_priv : NULL;
-	info.wcid = msta ? &msta->wcid : &mvif->sta.wcid;
+	info.wcid = msta ? &msta->deflink.wcid : &mvif->sta.deflink.wcid;
 	info.newly = msta ? state != MT76_STA_INFO_STATE_ASSOC : true;
 
 	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
@@ -2096,7 +2097,7 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	basic_req->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
 	basic_req->dtim_period = vif->bss_conf.dtim_period;
 	basic_req->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
-	basic_req->sta_idx = cpu_to_le16(msta->wcid.idx);
+	basic_req->sta_idx = cpu_to_le16(msta->deflink.wcid.idx);
 	basic_req->omac_idx = mvif->bss_conf.mt76.omac_idx;
 	basic_req->band_idx = mvif->bss_conf.mt76.band_idx;
 	basic_req->wmm_idx = mvif->bss_conf.mt76.wmm_idx;
@@ -2330,7 +2331,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 
 	/* bss_basic must be first */
 	mt7925_mcu_bss_basic_tlv(skb, vif, sta, ctx, phy->mt76,
-				 mvif->sta.wcid.idx, enable);
+				 mvif->sta.deflink.wcid.idx, enable);
 	mt7925_mcu_bss_sec_tlv(skb, vif);
 
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, vif, sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
index 9fca887977d2..ef631a68005d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
@@ -34,9 +34,9 @@ int mt7925e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (sta) {
 		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
-		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
+		if (time_after(jiffies, msta->deflink.last_txs + HZ / 4)) {
 			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-			msta->last_txs = jiffies;
+			msta->deflink.last_txs = jiffies;
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index e377f8ea9782..cb0bb06bef80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -79,11 +79,9 @@ enum mt792x_reg_power_type {
 
 DECLARE_EWMA(avg_signal, 10, 8)
 
-struct mt792x_sta {
+struct mt792x_link_sta {
 	struct mt76_wcid wcid; /* must be first */
 
-	struct mt792x_vif *vif;
-
 	u32 airtime_ac[8];
 
 	int ack_signal;
@@ -94,6 +92,12 @@ struct mt792x_sta {
 	struct mt76_connac_sta_key_conf bip;
 };
 
+struct mt792x_sta {
+	struct mt792x_link_sta deflink; /* must be first */
+
+	struct mt792x_vif *vif;
+};
+
 DECLARE_EWMA(rssi, 10, 8);
 
 struct mt792x_bss_conf {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 4b4afc1add6e..ae21a2829c9c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -65,14 +65,14 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 		struct mt792x_sta *sta;
 
 		sta = (struct mt792x_sta *)control->sta->drv_priv;
-		wcid = &sta->wcid;
+		wcid = &sta->deflink.wcid;
 	}
 
 	if (vif && !control->sta) {
 		struct mt792x_vif *mvif;
 
 		mvif = (struct mt792x_vif *)vif->drv_priv;
-		wcid = &mvif->sta.wcid;
+		wcid = &mvif->sta.deflink.wcid;
 	}
 
 	if (mt76_connac_pm_ref(mphy, &dev->pm)) {
@@ -120,11 +120,11 @@ void mt792x_remove_interface(struct ieee80211_hw *hw,
 	struct mt792x_sta *msta = &mvif->sta;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
-	int idx = msta->wcid.idx;
+	int idx = msta->deflink.wcid.idx;
 
 	mt792x_mutex_acquire(dev);
-	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, false);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.deflink.wcid, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
@@ -133,11 +133,11 @@ void mt792x_remove_interface(struct ieee80211_hw *hw,
 	mt792x_mutex_release(dev);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (!list_empty(&msta->wcid.poll_list))
-		list_del_init(&msta->wcid.poll_list);
+	if (!list_empty(&msta->deflink.wcid.poll_list))
+		list_del_init(&msta->deflink.wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
+	mt76_wcid_cleanup(&dev->mt76, &msta->deflink.wcid);
 }
 EXPORT_SYMBOL_GPL(mt792x_remove_interface);
 
@@ -408,7 +408,7 @@ mt792x_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 	if (msta->vif->bss_conf.mt76.idx != wi->idx)
 		return;
 
-	mt76_ethtool_worker(wi, &msta->wcid.stats, true);
+	mt76_ethtool_worker(wi, &msta->deflink.wcid.stats, true);
 }
 
 void mt792x_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
@@ -487,7 +487,7 @@ void mt792x_sta_statistics(struct ieee80211_hw *hw,
 			   struct station_info *sinfo)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-	struct rate_info *txrate = &msta->wcid.rate;
+	struct rate_info *txrate = &msta->deflink.wcid.rate;
 
 	if (!txrate->legacy && !txrate->flags)
 		return;
@@ -502,19 +502,19 @@ void mt792x_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->txrate.he_dcm = txrate->he_dcm;
 		sinfo->txrate.he_ru_alloc = txrate->he_ru_alloc;
 	}
-	sinfo->tx_failed = msta->wcid.stats.tx_failed;
+	sinfo->tx_failed = msta->deflink.wcid.stats.tx_failed;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 
-	sinfo->tx_retries = msta->wcid.stats.tx_retries;
+	sinfo->tx_retries = msta->deflink.wcid.stats.tx_retries;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 
 	sinfo->txrate.flags = txrate->flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 
-	sinfo->ack_signal = (s8)msta->ack_signal;
+	sinfo->ack_signal = (s8)msta->deflink.ack_signal;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
 
-	sinfo->avg_ack_signal = -(s8)ewma_avg_signal_read(&msta->avg_ack_signal);
+	sinfo->avg_ack_signal = -(s8)ewma_avg_signal_read(&msta->deflink.avg_ack_signal);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
 }
 EXPORT_SYMBOL_GPL(mt792x_sta_statistics);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 45dd94ff386d..106273935b26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -138,6 +138,7 @@ EXPORT_SYMBOL_GPL(mt792x_mac_update_mib_stats);
 struct mt76_wcid *mt792x_rx_get_wcid(struct mt792x_dev *dev, u16 idx,
 				     bool unicast)
 {
+	struct mt792x_link_sta *link;
 	struct mt792x_sta *sta;
 	struct mt76_wcid *wcid;
 
@@ -151,11 +152,12 @@ struct mt76_wcid *mt792x_rx_get_wcid(struct mt792x_dev *dev, u16 idx,
 	if (!wcid->sta)
 		return NULL;
 
-	sta = container_of(wcid, struct mt792x_sta, wcid);
+	link = container_of(wcid, struct mt792x_link_sta, wcid);
+	sta = container_of(link, struct mt792x_sta, deflink);
 	if (!sta->vif)
 		return NULL;
 
-	return &sta->vif->sta.wcid;
+	return &sta->vif->sta.deflink.wcid;
 }
 EXPORT_SYMBOL_GPL(mt792x_rx_get_wcid);
 
-- 
2.34.1


