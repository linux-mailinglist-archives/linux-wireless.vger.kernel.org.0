Return-Path: <linux-wireless+bounces-8911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE790623B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A511C214E1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC3312D748;
	Thu, 13 Jun 2024 03:02:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67C18028
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247773; cv=none; b=FOcLVMyggG6kkVzpgcKu0HGenmHqxmWPXXTtK1mNFhJtCx9RYD73vkjHokY91H0fQuN/MDlaj9eqHGAxr0yJmi0LYgoHxVdIzKw3Ya2E9w0bmj1+5j+BDKLJRs/Wneoy/jwkJ7ZCO05M66DRXXqfy4qDsTKjgLhlGStbXnUeyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247773; c=relaxed/simple;
	bh=grK/4tRDfE93owfEyVKZmvvDccAIt76l8dMlcHLNj9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AnShhi38N12ckBzMuG5Mh282oF2+jywuh/wRlWGaGTezFYg6HmEpX3uRdDM4lb1XV/g6M2zweuYNE4criOY1WbQF9KVLewXyViyMcyzNexxx4HNhWfWjiBgPqlWEcGj/UjtSUe7tMfFEWYHEY7RHsZLhHsk4Qqd336YSlWYc8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5bad42fec2dso30450eaf.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247770; x=1718852570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrIB9nmZ0mM4VWUa4rBGVpAGtlPIy7BctTXo1Pu6SMg=;
        b=TtvGTPM78NPm1FjVwjZCEbpXfoua6g+YjLdepFn6zCFw8UYikystuvrdM6mWLkbuOk
         YFwE1X8dlHRU7tmh6X1NP+OEj7fRAIeFsZh6VuLibgwZ2GkxIeMfMk4KqCSqzWRuexIq
         P+BSekmQ1+htUW4UhCA3RHu8B47RdS4R3GOAQ2ikY2jSOPnUoc+OQBO5MYueG+5B3EnZ
         yzV6IQp8plruZSBHK1K5pkBW/duPBzbm829RUqmjy2ZMeFZHV93tiJLw3ZLQ0G9PgtJt
         Fg6P7xaqTrA8CNxYKYytgOPgok7BlcTG6TqxIi97ugYe8pP1h0YlRTC717tZAhk10FxQ
         Xsyg==
X-Forwarded-Encrypted: i=1; AJvYcCWSvKa3zSvUfBmlXJWYkk4wucyTmGDopomhwzk9hHUB9tklvvL4XIVyg6IFOkuxB1ZzM/25U7nK6Q+nIi8MksMCiBSBHhiMrjs1SktQIKE=
X-Gm-Message-State: AOJu0Yyy1OvAN8ArdXuF6+7N8Fiaq8pY76YvghyoTp4/aT+QYtPzAzJO
	0Cxz9aWsFEEqPdblKUMvzAXJ4D2i+47FjFaMixz4PwchpHdbswJT
X-Google-Smtp-Source: AGHT+IF0HkgmqiTaSKojhJVnTG/nx36GXl3UgEYrHzjefWtGXCenBiB7AEY1M29ATTKNjgtOVF/PUA==
X-Received: by 2002:a4a:a5ca:0:b0:5ba:e11d:a2ae with SMTP id 006d021491bc7-5bb3b9f4ef7mr3670526eaf.1.1718247769530;
        Wed, 12 Jun 2024 20:02:49 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:02:46 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 01/47] wifi: mt76: mt792x: add struct mt792x_bss_conf
Date: Wed, 12 Jun 2024 20:01:55 -0700
Message-Id: <20240613030241.5771-2-sean.wang@kernel.org>
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

We are introducing a new structure, mt792x_bss_conf, to manage per-link
configurations in preparation for future STA support of Multi-Link
Operation (MLO).

The patch does not include any logic changes, only structural changes.

We have moved relevant parameters from the mt7921x_vif structure such
as to mt76 of mt76_vif structure, rssi and Tx queue parameters to
mt7921x_bss_conf structure. We can access those members to configure the
BSS for this interface, whether it is our own BSS or the one we are
associated with.

However, we have not yet created the per-link BSS configuration indexed by
link ID for Multi-Link Device (MLD) support. This step needs to be
extended before adding MLD support for AP mode.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 42 +++++++-------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 42 +++++++-------
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 56 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 56 +++++++++----------
 drivers/net/wireless/mediatek/mt76/mt792x.h   | 12 ++--
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 18 +++---
 .../net/wireless/mediatek/mt76/mt792x_mac.c   |  2 +-
 7 files changed, 115 insertions(+), 113 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3e3ad3518d85..2752e1735575 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -295,30 +295,30 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	mt792x_mutex_acquire(dev);
 
-	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
-	if (mvif->mt76.idx >= MT792x_MAX_INTERFACES) {
+	mvif->bss_conf.mt76.idx = __ffs64(~dev->mt76.vif_mask);
+	if (mvif->bss_conf.mt76.idx >= MT792x_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
 	}
 
-	mvif->mt76.omac_idx = mvif->mt76.idx;
+	mvif->bss_conf.mt76.omac_idx = mvif->bss_conf.mt76.idx;
 	mvif->phy = phy;
-	mvif->mt76.band_idx = 0;
-	mvif->mt76.wmm_idx = mvif->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+	mvif->bss_conf.mt76.band_idx = 0;
+	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
 	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid,
 					  true);
 	if (ret)
 		goto out;
 
-	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
-	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
+	dev->mt76.vif_mask |= BIT_ULL(mvif->bss_conf.mt76.idx);
+	phy->omac_mask |= BIT_ULL(mvif->bss_conf.mt76.omac_idx);
 
-	idx = MT792x_WTBL_RESERVED - mvif->mt76.idx;
+	idx = MT792x_WTBL_RESERVED - mvif->bss_conf.mt76.idx;
 
 	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
+	mvif->sta.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mt76_wcid_init(&mvif->sta.wcid);
@@ -326,7 +326,7 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	ewma_rssi_init(&mvif->rssi);
+	ewma_rssi_init(&mvif->bss_conf.rssi);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
 	if (vif->txq) {
@@ -718,7 +718,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ARP_FILTER) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
-		mt76_connac_mcu_update_arp_filter(&dev->mt76, &mvif->mt76,
+		mt76_connac_mcu_update_arp_filter(&dev->mt76, &mvif->bss_conf.mt76,
 						  info);
 	}
 
@@ -803,7 +803,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
-	msta->wcid.phy_idx = mvif->mt76.band_idx;
+	msta->wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->last_txs = jiffies;
 
@@ -841,7 +841,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt76_connac_mcu_uni_add_bss(&dev->mphy, vif, &mvif->sta.wcid,
-					    true, mvif->mt76.ctx);
+					    true, mvif->bss_conf.mt76.ctx);
 
 	ewma_avg_signal_init(&msta->avg_ack_signal);
 
@@ -872,11 +872,11 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
 		mvif->wep_sta = NULL;
-		ewma_rssi_init(&mvif->rssi);
+		ewma_rssi_init(&mvif->bss_conf.rssi);
 		if (!sta->tdls)
 			mt76_connac_mcu_uni_add_bss(&dev->mphy, vif,
 						    &mvif->sta.wcid, false,
-						    mvif->mt76.ctx);
+						    mvif->bss_conf.mt76.ctx);
 	}
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
@@ -1196,7 +1196,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
 		struct mt76_connac_arpns_tlv arpns;
 	} req_hdr = {
 		.hdr = {
-			.bss_idx = mvif->mt76.idx,
+			.bss_idx = mvif->bss_conf.mt76.idx,
 		},
 		.arpns = {
 			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ND),
@@ -1295,7 +1295,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	mt792x_mutex_acquire(dev);
 
 	err = mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
-					  true, mvif->mt76.ctx);
+					  true, mvif->bss_conf.mt76.ctx);
 	if (err)
 		goto out;
 
@@ -1327,7 +1327,7 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto out;
 
 	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false,
-				    mvif->mt76.ctx);
+				    mvif->bss_conf.mt76.ctx);
 
 out:
 	mt792x_mutex_release(dev);
@@ -1352,13 +1352,13 @@ static void mt7921_ctx_iter(void *priv, u8 *mac,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_chanctx_conf *ctx = priv;
 
-	if (ctx != mvif->mt76.ctx)
+	if (ctx != mvif->bss_conf.mt76.ctx)
 		return;
 
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		mt7921_mcu_config_sniffer(mvif, ctx);
 	else
-		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->mt76, ctx);
+		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
 }
 
 static void
@@ -1385,7 +1385,7 @@ static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
 		       jiffies_to_msecs(HZ);
 
 	mt792x_mutex_acquire(dev);
-	mt7921_set_roc(mvif->phy, mvif, mvif->mt76.ctx->def.chan, duration,
+	mt7921_set_roc(mvif->phy, mvif, mvif->bss_conf.mt76.ctx->def.chan, duration,
 		       MT7921_ROC_REQ_JOIN);
 	mt792x_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index bdd8b5f19b24..0453af012016 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -105,7 +105,7 @@ mt7921_mcu_set_ipv6_ns_filter(struct mt76_dev *dev,
 		struct mt76_connac_arpns_tlv arpns;
 	} req = {
 		.hdr = {
-			.bss_idx = mvif->mt76.idx,
+			.bss_idx = mvif->bss_conf.mt76.idx,
 		},
 		.arpns = {
 			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ND),
@@ -260,7 +260,7 @@ mt7921_mcu_rssi_monitor_iter(void *priv, u8 *mac,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt76_connac_rssi_notify_event *event = priv;
 	enum nl80211_cqm_rssi_threshold_event nl_event;
-	s32 rssi = le32_to_cpu(event->rssi[mvif->mt76.idx]);
+	s32 rssi = le32_to_cpu(event->rssi[mvif->bss_conf.mt76.idx]);
 
 	if (!rssi)
 		return;
@@ -388,7 +388,7 @@ int mt7921_mcu_uni_tx_ba(struct mt792x_dev *dev,
 	if (enable && !params->amsdu)
 		msta->wcid.amsdu = false;
 
-	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->mt76, params,
+	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->bss_conf.mt76, params,
 				      MCU_UNI_CMD(STA_REC_UPDATE),
 				      enable, true);
 }
@@ -399,7 +399,7 @@ int mt7921_mcu_uni_rx_ba(struct mt792x_dev *dev,
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
 
-	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->mt76, params,
+	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->bss_conf.mt76, params,
 				      MCU_UNI_CMD(STA_REC_UPDATE),
 				      enable, false);
 }
@@ -678,9 +678,9 @@ int mt7921_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 		u8 wmm_idx;
 		u8 pad;
 	} __packed req = {
-		.bss_idx = mvif->mt76.idx,
+		.bss_idx = mvif->bss_conf.mt76.idx,
 		.qos = vif->bss_conf.qos,
-		.wmm_idx = mvif->mt76.wmm_idx,
+		.wmm_idx = mvif->bss_conf.mt76.wmm_idx,
 	};
 	struct mu_edca {
 		u8 cw_min;
@@ -701,15 +701,15 @@ int mt7921_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 		struct mu_edca edca[IEEE80211_NUM_ACS];
 		u8 pad3[32];
 	} __packed req_mu = {
-		.bss_idx = mvif->mt76.idx,
+		.bss_idx = mvif->bss_conf.mt76.idx,
 		.qos = vif->bss_conf.qos,
-		.wmm_idx = mvif->mt76.wmm_idx,
+		.wmm_idx = mvif->bss_conf.mt76.wmm_idx,
 	};
 	static const int to_aci[] = { 1, 0, 2, 3 };
 	int ac, ret;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		struct ieee80211_tx_queue_params *q = &mvif->queue_params[ac];
+		struct ieee80211_tx_queue_params *q = &mvif->bss_conf.queue_params[ac];
 		struct edca *e = &req.edca[to_aci[ac]];
 
 		e->aifs = cpu_to_le16(q->aifs);
@@ -738,10 +738,10 @@ int mt7921_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 		struct ieee80211_he_mu_edca_param_ac_rec *q;
 		struct mu_edca *e;
 
-		if (!mvif->queue_params[ac].mu_edca)
+		if (!mvif->bss_conf.queue_params[ac].mu_edca)
 			break;
 
-		q = &mvif->queue_params[ac].mu_edca_param_rec;
+		q = &mvif->bss_conf.queue_params[ac].mu_edca_param_rec;
 		e = &(req_mu.edca[to_aci[ac]]);
 
 		e->cw_min = q->ecw_min_max & 0xf;
@@ -790,7 +790,7 @@ int mt7921_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			.tokenid = token_id,
 			.reqtype = type,
 			.maxinterval = cpu_to_le32(duration),
-			.bss_idx = vif->mt76.idx,
+			.bss_idx = vif->bss_conf.mt76.idx,
 			.control_channel = chan->hw_value,
 			.bw = CMD_CBW_20MHZ,
 			.bw_from_ap = CMD_CBW_20MHZ,
@@ -842,7 +842,7 @@ int mt7921_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			.tag = cpu_to_le16(UNI_ROC_ABORT),
 			.len = cpu_to_le16(sizeof(struct roc_abort_tlv)),
 			.tokenid = token_id,
-			.bss_idx = vif->mt76.idx,
+			.bss_idx = vif->bss_conf.mt76.idx,
 			.dbdcband = 0xff, /* auto*/
 		},
 	};
@@ -947,7 +947,7 @@ int mt7921_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 		} __packed ps;
 	} __packed ps_req = {
 		.hdr = {
-			.bss_idx = mvif->mt76.idx,
+			.bss_idx = mvif->bss_conf.mt76.idx,
 		},
 		.ps = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_PS),
@@ -982,7 +982,7 @@ mt7921_mcu_uni_bss_bcnft(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		} __packed bcnft;
 	} __packed bcnft_req = {
 		.hdr = {
-			.bss_idx = mvif->mt76.idx,
+			.bss_idx = mvif->bss_conf.mt76.idx,
 		},
 		.bcnft = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_BCNFT),
@@ -1015,7 +1015,7 @@ mt7921_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		u8 bmc_triggered_ac;
 		u8 pad;
 	} req = {
-		.bss_idx = mvif->mt76.idx,
+		.bss_idx = mvif->bss_conf.mt76.idx,
 		.aid = cpu_to_le16(vif->cfg.aid),
 		.dtim_period = vif->bss_conf.dtim_period,
 		.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
@@ -1024,7 +1024,7 @@ mt7921_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		u8 bss_idx;
 		u8 pad[3];
 	} req_hdr = {
-		.bss_idx = mvif->mt76.idx,
+		.bss_idx = mvif->bss_conf.mt76.idx,
 	};
 	int err;
 
@@ -1042,7 +1042,7 @@ int mt7921_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
 			  enum mt76_sta_info_state state)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	int rssi = -ewma_rssi_read(&mvif->rssi);
+	int rssi = -ewma_rssi_read(&mvif->bss_conf.rssi);
 	struct mt76_sta_cmd_info info = {
 		.sta = sta,
 		.vif = vif,
@@ -1190,7 +1190,7 @@ int mt7921_mcu_config_sniffer(struct mt792x_vif *vif,
 		} __packed tlv;
 	} __packed req = {
 		.hdr = {
-			.band_idx = vif->mt76.band_idx,
+			.band_idx = vif->bss_conf.mt76.band_idx,
 		},
 		.tlv = {
 			.tag = cpu_to_le16(1),
@@ -1251,7 +1251,7 @@ mt7921_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
 		} __packed beacon_tlv;
 	} req = {
 		.hdr = {
-			.bss_idx = mvif->mt76.idx,
+			.bss_idx = mvif->bss_conf.mt76.idx,
 		},
 		.beacon_tlv = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_BCN_CONTENT),
@@ -1460,7 +1460,7 @@ int mt7921_mcu_set_rssimonitor(struct mt792x_dev *dev, struct ieee80211_vif *vif
 		.enable = vif->cfg.assoc,
 		.cqm_rssi_high = vif->bss_conf.cqm_rssi_thold + vif->bss_conf.cqm_rssi_hyst,
 		.cqm_rssi_low = vif->bss_conf.cqm_rssi_thold - vif->bss_conf.cqm_rssi_hyst,
-		.bss_idx = mvif->mt76.idx,
+		.bss_idx = mvif->bss_conf.mt76.idx,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(RSSI_MONITOR),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 6179798a8845..dfc606cc9bdd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -328,35 +328,35 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	mt792x_mutex_acquire(dev);
 
-	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
-	if (mvif->mt76.idx >= MT792x_MAX_INTERFACES) {
+	mvif->bss_conf.mt76.idx = __ffs64(~dev->mt76.vif_mask);
+	if (mvif->bss_conf.mt76.idx >= MT792x_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
 	}
 
-	mvif->mt76.omac_idx = mvif->mt76.idx;
+	mvif->bss_conf.mt76.omac_idx = mvif->bss_conf.mt76.idx;
 	mvif->phy = phy;
-	mvif->mt76.band_idx = 0;
-	mvif->mt76.wmm_idx = mvif->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+	mvif->bss_conf.mt76.band_idx = 0;
+	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
 	if (phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
-		mvif->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
+		mvif->bss_conf.mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
 	else
-		mvif->mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL;
+		mvif->bss_conf.mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL;
 
 	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid,
 					  true);
 	if (ret)
 		goto out;
 
-	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
-	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
+	dev->mt76.vif_mask |= BIT_ULL(mvif->bss_conf.mt76.idx);
+	phy->omac_mask |= BIT_ULL(mvif->bss_conf.mt76.omac_idx);
 
-	idx = MT792x_WTBL_RESERVED - mvif->mt76.idx;
+	idx = MT792x_WTBL_RESERVED - mvif->bss_conf.mt76.idx;
 
 	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
-	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
+	mvif->sta.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mvif->sta.vif = mvif;
@@ -365,7 +365,7 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	ewma_rssi_init(&mvif->rssi);
+	ewma_rssi_init(&mvif->bss_conf.rssi);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], &mvif->sta.wcid);
 	if (vif->txq) {
@@ -524,11 +524,11 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mt792x_mutex_acquire(dev);
 
-	if (cmd == SET_KEY && !mvif->mt76.cipher) {
+	if (cmd == SET_KEY && !mvif->bss_conf.mt76.cipher) {
 		struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
-		mvif->mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
-		mt7925_mcu_add_bss_info(phy, mvif->mt76.ctx, vif, sta, true);
+		mvif->bss_conf.mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
+		mt7925_mcu_add_bss_info(phy, mvif->bss_conf.mt76.ctx, vif, sta, true);
 	}
 
 	if (cmd == SET_KEY)
@@ -748,7 +748,7 @@ static void mt7925_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ARP_FILTER) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
-		mt7925_mcu_update_arp_filter(&dev->mt76, &mvif->mt76, info);
+		mt7925_mcu_update_arp_filter(&dev->mt76, &mvif->bss_conf.mt76, info);
 	}
 
 	mt792x_mutex_release(dev);
@@ -770,7 +770,7 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
-	msta->wcid.phy_idx = mvif->mt76.band_idx;
+	msta->wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->last_txs = jiffies;
 
@@ -786,7 +786,7 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
-		mt7925_mcu_add_bss_info(&dev->phy, mvif->mt76.ctx, vif, sta,
+		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, vif, sta,
 					false);
 
 	ret = mt7925_mcu_sta_update(dev, sta, vif, true,
@@ -810,7 +810,7 @@ void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt792x_mutex_acquire(dev);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
-		mt7925_mcu_add_bss_info(&dev->phy, mvif->mt76.ctx, vif, sta,
+		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, vif, sta,
 					true);
 
 	ewma_avg_signal_init(&msta->avg_ack_signal);
@@ -842,9 +842,9 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
 		mvif->wep_sta = NULL;
-		ewma_rssi_init(&mvif->rssi);
+		ewma_rssi_init(&mvif->bss_conf.rssi);
 		if (!sta->tdls)
-			mt7925_mcu_add_bss_info(&dev->phy, mvif->mt76.ctx, vif, sta,
+			mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, vif, sta,
 						false);
 	}
 
@@ -1190,7 +1190,7 @@ static void mt7925_ipv6_addr_change(struct ieee80211_hw *hw,
 		struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
 	} req_hdr = {
 		.hdr = {
-			.bss_idx = mvif->mt76.idx,
+			.bss_idx = mvif->bss_conf.mt76.idx,
 		},
 		.arpns = {
 			.tag = cpu_to_le16(UNI_OFFLOAD_OFFLOAD_ND),
@@ -1288,7 +1288,7 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	};
 
 	/* firmware uses access class index */
-	mvif->queue_params[mq_to_aci[queue]] = *params;
+	mvif->bss_conf.queue_params[mq_to_aci[queue]] = *params;
 
 	return 0;
 }
@@ -1303,7 +1303,7 @@ mt7925_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mt792x_mutex_acquire(dev);
 
-	err = mt7925_mcu_add_bss_info(&dev->phy, mvif->mt76.ctx, vif, NULL,
+	err = mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, vif, NULL,
 				      true);
 	if (err)
 		goto out;
@@ -1334,7 +1334,7 @@ mt7925_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (err)
 		goto out;
 
-	mt7925_mcu_add_bss_info(&dev->phy, mvif->mt76.ctx, vif, NULL,
+	mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, vif, NULL,
 				false);
 
 out:
@@ -1360,14 +1360,14 @@ static void mt7925_ctx_iter(void *priv, u8 *mac,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_chanctx_conf *ctx = priv;
 
-	if (ctx != mvif->mt76.ctx)
+	if (ctx != mvif->bss_conf.mt76.ctx)
 		return;
 
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
 		mt7925_mcu_set_sniffer(mvif->phy->dev, vif, true);
 		mt7925_mcu_config_sniffer(mvif, ctx);
 	} else {
-		mt7925_mcu_set_chctx(mvif->phy->mt76, &mvif->mt76, ctx);
+		mt7925_mcu_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
 	}
 }
 
@@ -1395,7 +1395,7 @@ static void mt7925_mgd_prepare_tx(struct ieee80211_hw *hw,
 		       jiffies_to_msecs(HZ);
 
 	mt792x_mutex_acquire(dev);
-	mt7925_set_roc(mvif->phy, mvif, mvif->mt76.ctx->def.chan, duration,
+	mt7925_set_roc(mvif->phy, mvif, mvif->bss_conf.mt76.ctx->def.chan, duration,
 		       MT7925_ROC_REQ_JOIN);
 	mt792x_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 652a9accc43c..c259aedb96e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -546,7 +546,7 @@ int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
 	if (enable && !params->amsdu)
 		msta->wcid.amsdu = false;
 
-	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
 				 enable, true);
 }
 
@@ -557,7 +557,7 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
 	struct mt792x_vif *mvif = msta->vif;
 
-	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
 				 enable, false);
 }
 
@@ -889,7 +889,7 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 
 	msta = sta ? (struct mt792x_sta *)sta->drv_priv : &mvif->sta;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->bss_conf.mt76,
 					      &msta->wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
@@ -915,7 +915,7 @@ int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 		u8 bss_idx;
 		u8 __rsv[3];
 	} __packed hdr = {
-		.bss_idx = mvif->mt76.idx,
+		.bss_idx = mvif->bss_conf.mt76.idx,
 	};
 	struct sk_buff *skb;
 	int len = sizeof(hdr) + IEEE80211_NUM_ACS * sizeof(struct edca);
@@ -928,7 +928,7 @@ int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 	skb_put_data(skb, &hdr, sizeof(hdr));
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		struct ieee80211_tx_queue_params *q = &mvif->queue_params[ac];
+		struct ieee80211_tx_queue_params *q = &mvif->bss_conf.queue_params[ac];
 		struct edca *e;
 		struct tlv *tlv;
 
@@ -976,7 +976,7 @@ mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V3, sizeof(*sec));
 	sec = (struct sta_rec_sec_uni *)tlv;
-	sec->bss_idx = mvif->mt76.idx;
+	sec->bss_idx = mvif->bss_conf.mt76.idx;
 	sec->is_authenticator = 0;
 	sec->mgmt_prot = 0;
 	sec->wlan_idx = (u8)wcid->idx;
@@ -1085,7 +1085,7 @@ int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			.tokenid = token_id,
 			.reqtype = type,
 			.maxinterval = cpu_to_le32(duration),
-			.bss_idx = vif->mt76.idx,
+			.bss_idx = vif->bss_conf.mt76.idx,
 			.control_channel = chan->hw_value,
 			.bw = CMD_CBW_20MHZ,
 			.bw_from_ap = CMD_CBW_20MHZ,
@@ -1137,7 +1137,7 @@ int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			.tag = cpu_to_le16(UNI_ROC_ABORT),
 			.len = cpu_to_le16(sizeof(struct roc_abort_tlv)),
 			.tokenid = token_id,
-			.bss_idx = vif->mt76.idx,
+			.bss_idx = vif->bss_conf.mt76.idx,
 			.dbdcband = 0xff, /* auto*/
 		},
 	};
@@ -1263,7 +1263,7 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 		} __packed ps;
 	} __packed ps_req = {
 		.hdr = {
-			.bss_idx = mvif->mt76.idx,
+			.bss_idx = mvif->bss_conf.mt76.idx,
 		},
 		.ps = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_PS),
@@ -1300,7 +1300,7 @@ mt7925_mcu_uni_bss_bcnft(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		} __packed bcnft;
 	} __packed bcnft_req = {
 		.hdr = {
-			.bss_idx = mvif->mt76.idx,
+			.bss_idx = mvif->bss_conf.mt76.idx,
 		},
 		.bcnft = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_BCNFT),
@@ -1338,7 +1338,7 @@ mt7925_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		} __packed enable;
 	} req = {
 		.hdr = {
-			.bss_idx = mvif->mt76.idx,
+			.bss_idx = mvif->bss_conf.mt76.idx,
 		},
 		.enable = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_BCNFT),
@@ -1358,7 +1358,7 @@ mt7925_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		} __packed disable;
 	} req1 = {
 		.hdr = {
-			.bss_idx = mvif->mt76.idx,
+			.bss_idx = mvif->bss_conf.mt76.idx,
 		},
 		.disable = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_PM_DISABLE),
@@ -1502,7 +1502,7 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 		       struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->mt76.ctx->def;
+	struct cfg80211_chan_def *chandef = &mvif->bss_conf.mt76.ctx->def;
 	struct sta_rec_phy *phy;
 	struct tlv *tlv;
 	u8 af = 0, mm = 0;
@@ -1569,7 +1569,7 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->mt76.ctx->def;
+	struct cfg80211_chan_def *chandef = &mvif->bss_conf.mt76.ctx->def;
 	enum nl80211_band band = chandef->chan->band;
 	struct sta_rec_ra_info *ra_info;
 	struct tlv *tlv;
@@ -1655,7 +1655,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
 			  enum mt76_sta_info_state state)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	int rssi = -ewma_rssi_read(&mvif->rssi);
+	int rssi = -ewma_rssi_read(&mvif->bss_conf.rssi);
 	struct mt76_sta_cmd_info info = {
 		.sta = sta,
 		.vif = vif,
@@ -1746,7 +1746,7 @@ int mt7925_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		} __packed enable;
 	} __packed req = {
 		.hdr = {
-			.band_idx = mvif->mt76.band_idx,
+			.band_idx = mvif->bss_conf.mt76.band_idx,
 		},
 		.enable = {
 			.tag = cpu_to_le16(UNI_SNIFFER_ENABLE),
@@ -1805,7 +1805,7 @@ int mt7925_mcu_config_sniffer(struct mt792x_vif *vif,
 		} __packed tlv;
 	} __packed req = {
 		.hdr = {
-			.band_idx = vif->mt76.band_idx,
+			.band_idx = vif->bss_conf.mt76.band_idx,
 		},
 		.tlv = {
 			.tag = cpu_to_le16(UNI_SNIFFER_CONFIG),
@@ -1866,7 +1866,7 @@ mt7925_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
 		} __packed beacon_tlv;
 	} req = {
 		.hdr = {
-			.bss_idx = mvif->mt76.idx,
+			.bss_idx = mvif->bss_conf.mt76.idx,
 		},
 		.beacon_tlv = {
 			.tag = cpu_to_le16(UNI_BSS_INFO_BCN_CONTENT),
@@ -2080,8 +2080,8 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_BASIC, sizeof(*basic_req));
 	basic_req = (struct mt76_connac_bss_basic_tlv *)tlv;
 
-	idx = mvif->mt76.omac_idx > EXT_BSSID_START ? HW_BSSID_0 :
-						      mvif->mt76.omac_idx;
+	idx = mvif->bss_conf.mt76.omac_idx > EXT_BSSID_START ? HW_BSSID_0 :
+						      mvif->bss_conf.mt76.omac_idx;
 	basic_req->hw_bss_idx = idx;
 
 	basic_req->phymode_ext = mt7925_get_phy_mode_ext(phy, vif, band, sta);
@@ -2097,9 +2097,9 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	basic_req->dtim_period = vif->bss_conf.dtim_period;
 	basic_req->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
 	basic_req->sta_idx = cpu_to_le16(msta->wcid.idx);
-	basic_req->omac_idx = mvif->mt76.omac_idx;
-	basic_req->band_idx = mvif->mt76.band_idx;
-	basic_req->wmm_idx = mvif->mt76.wmm_idx;
+	basic_req->omac_idx = mvif->bss_conf.mt76.omac_idx;
+	basic_req->band_idx = mvif->bss_conf.mt76.band_idx;
+	basic_req->wmm_idx = mvif->bss_conf.mt76.wmm_idx;
 	basic_req->conn_state = !enable;
 
 	switch (vif->type) {
@@ -2217,8 +2217,8 @@ mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
 	mld = (struct bss_mld_tlv *)tlv;
 
 	mld->link_id = sta ? (is_mld ? vif->bss_conf.link_id : 0) : 0xff;
-	mld->group_mld_id = is_mld ? mvif->mt76.idx : 0xff;
-	mld->own_mld_id = mvif->mt76.idx + 32;
+	mld->group_mld_id = is_mld ? mvif->bss_conf.mt76.idx : 0xff;
+	mld->own_mld_id = mvif->bss_conf.mt76.idx + 32;
 	mld->remap_idx = 0xff;
 
 	if (sta)
@@ -2301,7 +2301,7 @@ int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 	struct mt792x_dev *dev = phy->dev;
 	struct sk_buff *skb;
 
-	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mvif->bss_conf.mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -2323,7 +2323,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	struct sk_buff *skb;
 	int err;
 
-	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mvif->mt76,
+	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mvif->bss_conf.mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -2348,7 +2348,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	if (err < 0)
 		return err;
 
-	return mt7925_mcu_set_chctx(phy->mt76, &mvif->mt76, ctx);
+	return mt7925_mcu_set_chctx(phy->mt76, &mvif->bss_conf.mt76, ctx);
 }
 
 int mt7925_mcu_set_dbdc(struct mt76_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 4c14e2c5da5b..e377f8ea9782 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -96,17 +96,19 @@ struct mt792x_sta {
 
 DECLARE_EWMA(rssi, 10, 8);
 
-struct mt792x_vif {
+struct mt792x_bss_conf {
 	struct mt76_vif mt76; /* must be first */
+	struct ewma_rssi rssi;
+	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+};
+
+struct mt792x_vif {
+	struct mt792x_bss_conf bss_conf; /* must be first */
 
 	struct mt792x_sta sta;
 	struct mt792x_sta *wep_sta;
 
 	struct mt792x_phy *phy;
-
-	struct ewma_rssi rssi;
-
-	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 };
 
 struct mt792x_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index a405af8d9052..4b4afc1add6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -128,8 +128,8 @@ void mt792x_remove_interface(struct ieee80211_hw *hw,
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
-	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
+	dev->mt76.vif_mask &= ~BIT_ULL(mvif->bss_conf.mt76.idx);
+	phy->omac_mask &= ~BIT_ULL(mvif->bss_conf.mt76.omac_idx);
 	mt792x_mutex_release(dev);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
@@ -149,7 +149,7 @@ int mt792x_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	/* no need to update right away, we'll get BSS_CHANGED_QOS */
 	queue = mt76_connac_lmac_mapping(queue);
-	mvif->queue_params[queue] = *params;
+	mvif->bss_conf.queue_params[queue] = *params;
 
 	return 0;
 }
@@ -178,7 +178,7 @@ u64 mt792x_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	u8 omac_idx = mvif->mt76.omac_idx;
+	u8 omac_idx = mvif->bss_conf.mt76.omac_idx;
 	union {
 		u64 t64;
 		u32 t32[2];
@@ -204,7 +204,7 @@ void mt792x_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	u8 omac_idx = mvif->mt76.omac_idx;
+	u8 omac_idx = mvif->bss_conf.mt76.omac_idx;
 	union {
 		u64 t64;
 		u32 t32[2];
@@ -265,7 +265,7 @@ int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mvif->mt76.ctx = ctx;
+	mvif->bss_conf.mt76.ctx = ctx;
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
@@ -281,7 +281,7 @@ void mt792x_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mvif->mt76.ctx = NULL;
+	mvif->bss_conf.mt76.ctx = NULL;
 	mutex_unlock(&dev->mt76.mutex);
 }
 EXPORT_SYMBOL_GPL(mt792x_unassign_vif_chanctx);
@@ -405,7 +405,7 @@ mt792x_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt76_ethtool_worker_info *wi = wi_data;
 
-	if (msta->vif->mt76.idx != wi->idx)
+	if (msta->vif->bss_conf.mt76.idx != wi->idx)
 		return;
 
 	mt76_ethtool_worker(wi, &msta->wcid.stats, true);
@@ -421,7 +421,7 @@ void mt792x_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_mib_stats *mib = &phy->mib;
 	struct mt76_ethtool_worker_info wi = {
 		.data = data,
-		.idx = mvif->mt76.idx,
+		.idx = mvif->bss_conf.mt76.idx,
 	};
 	int i, ei = 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index eb29434abee1..45dd94ff386d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -173,7 +173,7 @@ mt792x_mac_rssi_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!ether_addr_equal(vif->addr, hdr->addr1))
 		return;
 
-	ewma_rssi_add(&mvif->rssi, -status->signal);
+	ewma_rssi_add(&mvif->bss_conf.rssi, -status->signal);
 }
 
 void mt792x_mac_assoc_rssi(struct mt792x_dev *dev, struct sk_buff *skb)
-- 
2.34.1


