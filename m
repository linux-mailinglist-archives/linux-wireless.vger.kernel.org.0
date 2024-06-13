Return-Path: <linux-wireless+bounces-8916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91318906240
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B1AB22997
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17B12CD8C;
	Thu, 13 Jun 2024 03:03:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07312D215
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247783; cv=none; b=BkRCIbCVMvYic4dGXqZgxBxwNFKA+uMbUA7KsLcKY8vYRb6elcCcXneuYECGJvPy1kYRaPVUq5UvauVUvtcSS+nztmaf277NJe1eUnJ85LpDELZ0C7IqqWM5YN8zbUiuOS2IRURMYfsItpvE/Y2FIRgf3DVzMUq/verTOH4RE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247783; c=relaxed/simple;
	bh=1ruVmEVmKQx8cAu7E8MhKzBGokks8fRzgqeuPvj6ezc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVlPuz4cSD6qDzspOIGJYr7wtvSUACjmKc4wbR/PTZigxkuVyfMQdjRPxRCialIj7xt+tdA7Z4DKtiCsjXghu5jwB+JaDZHggmUnwLED2eoIpKz/xSJlWVRGn1ee5jHEewK4Bsd/TvJkw0JbEL0xxdyKVozu//ZPopt8BhcQIO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d21b50f8b4so68893b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247781; x=1718852581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNkelXTxxMMz4LGtUvEnp1jPMerysFzidVDadNvD4GE=;
        b=WRnWmy1i2KlGetlGoe2wmKHEcMRTAzFiV2k6DzwOT2HiDg06glbR4PYFVDRiefwWNm
         K53V/W0UWyg4vChy1UGo9WG6uZcIy005F+XtjXCXVqtxxxqJEzmxjjrFZwnd7KudYr7L
         qCVnnabB65D0pppZZ3zD6s+oNbc3ve0MojlMVUa3+6SpOCAQahm2FL/fMAXazmSujMQS
         qQGaU7o3yT5NCggjpbyZe76vnnPuyC0GhbNU3iEeFolijrfCA/A3A1mvhn6gsFC0igu1
         k6OCNuU20eJ8xQj7OH2NlSEqRSlj5By4+9J2f5CUHpyydJsrUYy1XxNYLRs0zsT0oLL4
         sb3g==
X-Forwarded-Encrypted: i=1; AJvYcCUO3psAzHAcbtOuhR53TEa2mmfpJaGVNNa6PTTuI30bk5+3SU1AIZqOQublotIoozoaMh5rDgI0R7YByEiFrVZhk02pSLiIJRyhSCfR1SE=
X-Gm-Message-State: AOJu0YxBBS+kba04WHASbpl9TGbmDBcDc2PFt1gw6AjkRk7t8kEpSbIN
	d6lqgqNyG5iqiFbzdpR5RlV/hQ+zxTXPb4EtITztPoR+GXoHFSi6//IKrXATy2w=
X-Google-Smtp-Source: AGHT+IGop7lIhBPZfEfsSFi5dcAXixU7dZnIGAt4G4oXUA5mCgEPT9L0Hbz4YM8vhZF8LA0Cyhk0zA==
X-Received: by 2002:a05:6820:d88:b0:5ba:ead2:c742 with SMTP id 006d021491bc7-5bb3b7a3d2bmr3670644eaf.0.1718247780534;
        Wed, 12 Jun 2024 20:03:00 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:02:58 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 06/47] wifi: mt76: mt7925: extend mt7925_mcu_set_tx with for per-link BSS
Date: Wed, 12 Jun 2024 20:02:00 -0700
Message-Id: <20240613030241.5771-7-sean.wang@kernel.org>
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

Extend mt7925_mcu_set_tx with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  9 ++++---
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   | 25 +++++++++++++++++++
 5 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 48425fc4e7fe..2be2ab914411 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1245,7 +1245,7 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf,
 				    &mvif->sta.deflink.wcid, true);
-	mt7925_mcu_set_tx(dev, vif);
+	mt7925_mcu_set_tx(dev, &vif->bss_conf);
 
 	if (vif->type == NL80211_IFTYPE_AP) {
 		mt76_connac_mcu_uni_add_bss(dev->phy.mt76, vif, &mvif->sta.deflink.wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index b0c8b090d2ce..d11919688bae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1410,7 +1410,7 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 
 	/* ensure that enable txcmd_mode after bss_info */
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
-		mt7925_mcu_set_tx(dev, vif);
+		mt7925_mcu_set_tx(dev, info);
 
 	mt792x_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 5e72f7278e8b..1c262a024dc8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -900,7 +900,8 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 }
 
-int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
+int mt7925_mcu_set_tx(struct mt792x_dev *dev,
+		      struct ieee80211_bss_conf *bss_conf)
 {
 #define MCU_EDCA_AC_PARAM	0
 #define WMM_AIFS_SET		BIT(0)
@@ -909,12 +910,12 @@ int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 #define WMM_TXOP_SET		BIT(3)
 #define WMM_PARAM_SET		(WMM_AIFS_SET | WMM_CW_MIN_SET | \
 				 WMM_CW_MAX_SET | WMM_TXOP_SET)
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(bss_conf);
 	struct {
 		u8 bss_idx;
 		u8 __rsv[3];
 	} __packed hdr = {
-		.bss_idx = mvif->bss_conf.mt76.idx,
+		.bss_idx = mconf->mt76.idx,
 	};
 	struct sk_buff *skb;
 	int len = sizeof(hdr) + IEEE80211_NUM_ACS * sizeof(struct edca);
@@ -927,7 +928,7 @@ int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 	skb_put_data(skb, &hdr, sizeof(hdr));
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		struct ieee80211_tx_queue_params *q = &mvif->bss_conf.queue_params[ac];
+		struct ieee80211_tx_queue_params *q = &mconf->queue_params[ac];
 		struct edca *e;
 		struct tlv *tlv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 8a4a71f6bcb6..f689f7a359ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -198,7 +198,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
 			  struct ieee80211_vif *vif, bool enable,
 			  enum mt76_sta_info_state state);
 int mt7925_mcu_set_chan_info(struct mt792x_phy *phy, u16 tag);
-int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif);
+int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_bss_conf *bss_conf);
 int mt7925_mcu_set_eeprom(struct mt792x_dev *dev);
 int mt7925_mcu_get_rx_rate(struct mt792x_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index b5eb574e8548..4a7526322c30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -112,6 +112,7 @@ struct mt792x_bss_conf {
 
 struct mt792x_vif {
 	struct mt792x_bss_conf bss_conf; /* must be first */
+	struct mt792x_bss_conf __rcu *link_conf[IEEE80211_MLD_MAX_NUM_LINKS];
 
 	struct mt792x_sta sta;
 	struct mt792x_sta *wep_sta;
@@ -219,6 +220,30 @@ struct mt792x_dev {
 	u32 backup_l2;
 };
 
+static inline struct mt792x_bss_conf *
+mt792x_vif_to_link(struct mt792x_vif *mvif, u8 link_id)
+{
+	struct ieee80211_vif *vif;
+
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+
+	if (!ieee80211_vif_is_mld(vif) ||
+	    link_id >= IEEE80211_LINK_UNSPECIFIED)
+		return &mvif->bss_conf;
+
+	return rcu_dereference_protected(mvif->link_conf[link_id],
+		lockdep_is_held(&mvif->phy->dev->mt76.mutex));
+}
+
+static inline struct mt792x_bss_conf *
+mt792x_link_conf_to_mconf(struct ieee80211_bss_conf *link_conf)
+{
+	struct ieee80211_vif *vif = link_conf->vif;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+	return mt792x_vif_to_link(mvif, link_conf->link_id);
+}
+
 static inline struct mt792x_dev *
 mt792x_hw_dev(struct ieee80211_hw *hw)
 {
-- 
2.34.1


