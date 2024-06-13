Return-Path: <linux-wireless+bounces-8934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E70906252
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A04D282C01
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861B12D74D;
	Thu, 13 Jun 2024 03:03:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844312D1F4
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247820; cv=none; b=XT1mpNhTeWnAK/J7GpCtF+qvxBdXTCbWrL0j247++wgcvU+o0DM6vYCnERKSO5TcHpSG7FS2Gp4aQvSrhMadjioD6l3OvlhR+IokR9RASNYRcB4Wh3dmJ7RxB1OeoK/caCNMM6OxhrqtHLHR35juxEvdq1uHQAMv3XNqugcloCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247820; c=relaxed/simple;
	bh=0rnURhqMRYABx24z02+KWQ7Hwct2rhM9keFUjK6qrmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sBawbsnBw3mZVL5l2ozv+3uTPOExtTjSgb2kOWrYWAc2dhtB3i75V7QhURy3WA8UAewGPCvjzMDRsvawrbfTT+rzJEK9lQCvkNafsFgDkpocY/TeVaOH9kn1OUC8Wvg0bLTbjF8LVcwn4EJehBL4vMy9k+z5yw0pOFZunwjIYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b97f09cde3so43144eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247818; x=1718852618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jvwi7Fx3xoxbV9NOG7xyDKaLAxBj0fbFHV1JoEAsvCs=;
        b=VfoLejMHOgtEhjhCyEbk/xez/PxdGDcKnLmftPDvvtXXm5yfU7n5k6a1HvUQ0CN8NQ
         1+YqHT3WIkM0YVey2L2AJfvmv1yPIGJhKqH1lMJlkPVDcPoPEOAMpjsSvGRIg+UpM3se
         vBxmc7jCO72fy/YKtxbk6+4645AkNXD9rW7s1WKymEySYZ+H3PXeS2wNqMTA4gLxZuLw
         lz8cnTdXy1h0w/Wp2s+rqNqOEHmYekCLxjHctUTWAq7XhWK+DkrOWGXIoDk0ffA9VnDR
         pelxHPxaje/6S7YkLQJUkTokUfDUunmsAKb4AIybu60qFr5w7B90gSmAUt2E7SJjuIFn
         t4mg==
X-Forwarded-Encrypted: i=1; AJvYcCVqJd6pi7E3Xg0vSISlObzZLcsBc5UxQ3dsqlVfGg16xXcoYyVvrIInSP2/yzY6vLLe5ie0vtwdxL9yY+KLHlLfLQ3X5vYYVy8z2d3StD8=
X-Gm-Message-State: AOJu0YxmnW31roSUUVA+2yNGuFDbfjMT91qNFpL/bVZonJpbQL0X8orz
	d/b8twFBNidPihqxIiSog4q8N/e4qJ4HR3ot3b+ZL/UMMKdvQnk8
X-Google-Smtp-Source: AGHT+IGqKH/kAuaGnt4Ilmb7WN9NEAB6zcIR69b034yjIhxRh0d2jGBQAhKQh6F9jeIPASIXgtNNwg==
X-Received: by 2002:a4a:8552:0:b0:5ba:ca86:a025 with SMTP id 006d021491bc7-5bb3b7a9135mr3996624eaf.0.1718247817902;
        Wed, 12 Jun 2024 20:03:37 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:36 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 24/47] wifi: mt76: mt7925: extend mt7925_mcu_sta_update for per-link STA
Date: Wed, 12 Jun 2024 20:02:18 -0700
Message-Id: <20240613030241.5771-25-sean.wang@kernel.org>
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

From: Sean Wang <sean.wang@mediatek.com>

Extend mt7925_mcu_sta_update with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  5 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  6 +--
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 53 +++++++++++--------
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  3 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   | 16 ++++++
 5 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index e6e8824c828e..2a858b1ca82e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1726,7 +1726,10 @@ enum mt76_sta_info_state {
 };
 
 struct mt76_sta_cmd_info {
-	struct ieee80211_sta *sta;
+	union {
+		struct ieee80211_sta *sta;
+		struct ieee80211_link_sta *link_sta;
+	};
 	struct mt76_wcid *wcid;
 
 	struct ieee80211_vif *vif;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index cd20b85109b9..f3a32fe9a754 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -740,7 +740,7 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
 					link_conf, sta, false);
 
-	ret = mt7925_mcu_sta_update(dev, sta, vif, true,
+	ret = mt7925_mcu_sta_update(dev, &sta->deflink, vif, true,
 				    MT76_STA_INFO_STATE_NONE);
 	if (ret)
 		return ret;
@@ -773,7 +773,7 @@ void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	memset(msta->deflink.airtime_ac, 0, sizeof(msta->deflink.airtime_ac));
 
-	mt7925_mcu_sta_update(dev, sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
+	mt7925_mcu_sta_update(dev, &sta->deflink, vif, true, MT76_STA_INFO_STATE_ASSOC);
 
 	mt792x_mutex_release(dev);
 }
@@ -789,7 +789,7 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
-	mt7925_mcu_sta_update(dev, sta, vif, false, MT76_STA_INFO_STATE_NONE);
+	mt7925_mcu_sta_update(dev, &sta->deflink, vif, false, MT76_STA_INFO_STATE_NONE);
 	mt7925_mac_wtbl_update(dev, msta->deflink.wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 9d56013b2f55..9b69b4b178de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1628,39 +1628,46 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	if (info->sta || !info->offload_fw)
-		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif, info->sta,
+	if (info->link_sta || !info->offload_fw)
+		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
+					      info->link_sta->sta,
 					      info->enable, info->newly);
-	if (info->sta && info->enable) {
-		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->sta);
-		mt7925_mcu_sta_ht_tlv(skb, info->sta);
-		mt7925_mcu_sta_vht_tlv(skb, info->sta);
-		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->sta);
-		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->sta);
-		mt7925_mcu_sta_he_tlv(skb, info->sta);
-		mt7925_mcu_sta_he_6g_tlv(skb, info->sta);
-		mt7925_mcu_sta_eht_tlv(skb, info->sta);
-		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif, info->sta);
-		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->sta,
+	if (info->link_sta && info->enable) {
+		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta->sta);
+		mt7925_mcu_sta_ht_tlv(skb, info->link_sta->sta);
+		mt7925_mcu_sta_vht_tlv(skb, info->link_sta->sta);
+		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
+		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta->sta);
+		mt7925_mcu_sta_he_tlv(skb, info->link_sta->sta);
+		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta->sta);
+		mt7925_mcu_sta_eht_tlv(skb, info->link_sta->sta);
+		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
+					     info->link_sta->sta);
+		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta->sta,
 					    info->vif, info->rcpi,
 					    info->state);
-		mt7925_mcu_sta_mld_tlv(skb, info->vif, info->sta);
+		mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
 	}
 
-	if (info->enable)
-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->sta);
+	if (info->enable) {
+		struct ieee80211_sta *sta = info->link_sta ?
+			info->link_sta->sta : NULL;
+
+		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, sta);
+	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
 }
 
-int mt7925_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
+int mt7925_mcu_sta_update(struct mt792x_dev *dev,
+			  struct ieee80211_link_sta *link_sta,
 			  struct ieee80211_vif *vif, bool enable,
 			  enum mt76_sta_info_state state)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	int rssi = -ewma_rssi_read(&mvif->bss_conf.rssi);
 	struct mt76_sta_cmd_info info = {
-		.sta = sta,
+		.link_sta = link_sta,
 		.vif = vif,
 		.enable = enable,
 		.cmd = MCU_UNI_CMD(STA_REC_UPDATE),
@@ -1669,10 +1676,14 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
 		.rcpi = to_rcpi(rssi),
 	};
 	struct mt792x_sta *msta;
+	struct mt792x_link_sta *mlink;
 
-	msta = sta ? (struct mt792x_sta *)sta->drv_priv : NULL;
-	info.wcid = msta ? &msta->deflink.wcid : &mvif->sta.deflink.wcid;
-	info.newly = msta ? state != MT76_STA_INFO_STATE_ASSOC : true;
+	if (link_sta) {
+		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	}
+	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
+	info.newly = link_sta ? state != MT76_STA_INFO_STATE_ASSOC : true;
 
 	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index ef37951f69d5..8ec5a3a20202 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -195,7 +195,8 @@ int mt7925_run_firmware(struct mt792x_dev *dev);
 int mt7925_mcu_set_bss_pm(struct mt792x_dev *dev,
 			  struct ieee80211_bss_conf *link_conf,
 			  bool enable);
-int mt7925_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
+int mt7925_mcu_sta_update(struct mt792x_dev *dev,
+			  struct ieee80211_link_sta *link_sta,
 			  struct ieee80211_vif *vif, bool enable,
 			  enum mt76_sta_info_state state);
 int mt7925_mcu_set_chan_info(struct mt792x_phy *phy, u16 tag);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 9452a3592950..185d56a1db11 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -94,6 +94,7 @@ struct mt792x_link_sta {
 
 struct mt792x_sta {
 	struct mt792x_link_sta deflink; /* must be first */
+	struct mt792x_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
 	struct mt792x_vif *vif;
 };
@@ -236,6 +237,21 @@ mt792x_vif_to_link(struct mt792x_vif *mvif, u8 link_id)
 		lockdep_is_held(&mvif->phy->dev->mt76.mutex));
 }
 
+static inline struct mt792x_link_sta *
+mt792x_sta_to_link(struct mt792x_sta *msta, u8 link_id)
+{
+	struct ieee80211_vif *vif;
+
+	vif = container_of((void *)msta->vif, struct ieee80211_vif, drv_priv);
+
+	if (!ieee80211_vif_is_mld(vif) ||
+	    link_id >= IEEE80211_LINK_UNSPECIFIED)
+		return &msta->deflink;
+
+	return rcu_dereference_protected(msta->link[link_id],
+		lockdep_is_held(&msta->vif->phy->dev->mt76.mutex));
+}
+
 static inline struct mt792x_bss_conf *
 mt792x_link_conf_to_mconf(struct ieee80211_bss_conf *link_conf)
 {
-- 
2.34.1


