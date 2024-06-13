Return-Path: <linux-wireless+bounces-8914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A7890623E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BC5B22845
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701B12CDB1;
	Thu, 13 Jun 2024 03:02:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4212D770
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247778; cv=none; b=bFc3XSCfim/75WTjozEbGUXqwv3cpjc1mfRVWi0FCP8MjvK3TFDhpKEVhpBtJW2Q2+VXlkBML65tteEotPHgu+KpIYTj3ICwoQxXFv5/XWZz8IfCsws5NXeKGML+Ula3jR7jmk11U6yXXEAlsG+O9j/Mswk+ISYKou110To4ccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247778; c=relaxed/simple;
	bh=minu0oqIMObPMsMTH4Gr9qXoicCRhjR5zYsPGvDoU84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ehfLz/ru7Is59gCyxMwaE99ERMnxRXKF6lndvdoP2mKiKockiaRkN+DL593abePaXY962CxdsMajK5pMv4p+mxrvgNqzVel2WXZdegdf03p+E/0NukcYoEdPGSoosJjAsgTMZBS5f1RmrFMYg3UlWdnXyDcqBWYwcVbePRJUnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5bad4e45863so24356eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247776; x=1718852576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTbknuCcxBFM/pXAboNibD22DPmvjD+qglC+dC8qFos=;
        b=tn0FefnSvXtoiCwEpqo+8nx9cL3CsIeLY3zORYYYKofXOeK74s1ZJjL0Kb1emXOYmQ
         AxLrd5swTGS3Ag3YftsSDlm/39Hu90PnCdQxcTbgDtRVF9/udoZoDAbzYNdQjXuIXQ25
         L0ZUJ03T3pgWyjF8B2mSsSSYZnC5gVhqU2hhK3lzRBDYHeUOd4bpaReS06FqmZyl/2zd
         EMF144CrLkSWUqLemAp0/kzYXrVxe1WE1uWJ69kNSGEaND62CPSfUf+f1v3gEfe0ZPzt
         9VRYLaL1xU5aQMXKlGZeQKzQRKzKeGbXlKk4yvpl06INoGTVJKTucvBz1JYhZ+YwL47h
         ByTg==
X-Forwarded-Encrypted: i=1; AJvYcCUge/mMHfU+LxGHjEauu5ut3D0wRb+WXbHihzQsvkIEMzvE/VyFI+BloDiWxS0VxkZZ7AxWRQwb/j1EtHKP4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDC6FDDVo9rLYFQOTda5c6+cCuEYUlnuIyMF5vX+RAj7Wyc8q
	5BCpOIm8TcoiL2PobS56jApeQjLDBugxXi18KsP0PpmP3i9lz3u7
X-Google-Smtp-Source: AGHT+IFXaJzQHaYoUlzxItiYvtpBTUQMFf3XYeOAf7nO9GCdpTZw/Q9Zwh7hHRn5kHY1RrUgGCKcaQ==
X-Received: by 2002:a05:6820:2c86:b0:5aa:3e4f:f01e with SMTP id 006d021491bc7-5bb3b9c614cmr3867601eaf.1.1718247775640;
        Wed, 12 Jun 2024 20:02:55 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:02:54 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 04/47] wifi: mt76: mt7925: support for split bss_info_changed method
Date: Wed, 12 Jun 2024 20:01:58 -0700
Message-Id: <20240613030241.5771-5-sean.wang@kernel.org>
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

The .bss_info_changed method is being split into .vif_cfg_changed and
.link_info_changed to support MLD devices, but it will still support
non-MLD devices.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 132 ++++++++++--------
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |   7 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |   3 +-
 3 files changed, 76 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 91edbe076c22..397776ddf01a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -695,65 +695,6 @@ mt7925_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return mvif->basic_rates_idx;
 }
 
-static void mt7925_bss_info_changed(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_bss_conf *info,
-				    u64 changed)
-{
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
-	struct mt792x_phy *phy = mt792x_hw_phy(hw);
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-
-	mt792x_mutex_acquire(dev);
-
-	if (changed & BSS_CHANGED_ERP_SLOT) {
-		int slottime = info->use_short_slot ? 9 : 20;
-
-		if (slottime != phy->slottime) {
-			phy->slottime = slottime;
-			mt7925_mcu_set_timing(phy, vif);
-		}
-	}
-
-	if (changed & BSS_CHANGED_MCAST_RATE)
-		mvif->mcast_rates_idx =
-				mt7925_get_rates_table(hw, vif, false, true);
-
-	if (changed & BSS_CHANGED_BASIC_RATES)
-		mvif->basic_rates_idx =
-				mt7925_get_rates_table(hw, vif, false, false);
-
-	if (changed & (BSS_CHANGED_BEACON |
-		       BSS_CHANGED_BEACON_ENABLED)) {
-		mvif->beacon_rates_idx =
-				mt7925_get_rates_table(hw, vif, true, false);
-
-		mt7925_mcu_uni_add_beacon_offload(dev, hw, vif,
-						  info->enable_beacon);
-	}
-
-	/* ensure that enable txcmd_mode after bss_info */
-	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
-		mt7925_mcu_set_tx(dev, vif);
-
-	if (changed & BSS_CHANGED_PS)
-		mt7925_mcu_uni_bss_ps(dev, vif);
-
-	if (changed & BSS_CHANGED_ASSOC) {
-		mt7925_mcu_sta_update(dev, NULL, vif, true,
-				      MT76_STA_INFO_STATE_ASSOC);
-		mt7925_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
-	}
-
-	if (changed & BSS_CHANGED_ARP_FILTER) {
-		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-
-		mt7925_mcu_update_arp_filter(&dev->mt76, &mvif->bss_conf.mt76, info);
-	}
-
-	mt792x_mutex_release(dev);
-}
-
 int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta)
 {
@@ -1404,6 +1345,76 @@ static void mt7925_mgd_complete_tx(struct ieee80211_hw *hw,
 	mt7925_abort_roc(mvif->phy, mvif);
 }
 
+static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   u64 changed)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt792x_mutex_acquire(dev);
+
+	if (changed & BSS_CHANGED_ASSOC) {
+		mt7925_mcu_sta_update(dev, NULL, vif, true,
+				      MT76_STA_INFO_STATE_ASSOC);
+		mt7925_mcu_set_beacon_filter(dev, vif, vif->cfg.assoc);
+	}
+
+	if (changed & BSS_CHANGED_ARP_FILTER) {
+		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+		mt7925_mcu_update_arp_filter(&dev->mt76, &mvif->bss_conf.mt76);
+	}
+
+	if (changed & BSS_CHANGED_PS)
+		mt7925_mcu_uni_bss_ps(dev, vif);
+
+	mt792x_mutex_release(dev);
+}
+
+static void mt7925_link_info_changed(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *info,
+				     u64 changed)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt792x_mutex_acquire(dev);
+
+	if (changed & BSS_CHANGED_ERP_SLOT) {
+		int slottime = info->use_short_slot ? 9 : 20;
+
+		if (slottime != phy->slottime) {
+			phy->slottime = slottime;
+			mt7925_mcu_set_timing(phy, vif);
+		}
+	}
+
+	if (changed & BSS_CHANGED_MCAST_RATE)
+		mvif->mcast_rates_idx =
+				mt7925_get_rates_table(hw, vif, false, true);
+
+	if (changed & BSS_CHANGED_BASIC_RATES)
+		mvif->basic_rates_idx =
+				mt7925_get_rates_table(hw, vif, false, false);
+
+	if (changed & (BSS_CHANGED_BEACON |
+		       BSS_CHANGED_BEACON_ENABLED)) {
+		mvif->beacon_rates_idx =
+				mt7925_get_rates_table(hw, vif, true, false);
+
+		mt7925_mcu_uni_add_beacon_offload(dev, hw, vif,
+						  info->enable_beacon);
+	}
+
+	/* ensure that enable txcmd_mode after bss_info */
+	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
+		mt7925_mcu_set_tx(dev, vif);
+
+	mt792x_mutex_release(dev);
+}
+
 const struct ieee80211_ops mt7925_ops = {
 	.tx = mt792x_tx,
 	.start = mt7925_start,
@@ -1413,7 +1424,6 @@ const struct ieee80211_ops mt7925_ops = {
 	.config = mt7925_config,
 	.conf_tx = mt7925_conf_tx,
 	.configure_filter = mt7925_configure_filter,
-	.bss_info_changed = mt7925_bss_info_changed,
 	.start_ap = mt7925_start_ap,
 	.stop_ap = mt7925_stop_ap,
 	.sta_state = mt76_sta_state,
@@ -1461,6 +1471,8 @@ const struct ieee80211_ops mt7925_ops = {
 	.unassign_vif_chanctx = mt792x_unassign_vif_chanctx,
 	.mgd_prepare_tx = mt7925_mgd_prepare_tx,
 	.mgd_complete_tx = mt7925_mgd_complete_tx,
+	.vif_cfg_changed = mt7925_vif_cfg_changed,
+	.link_info_changed = mt7925_link_info_changed,
 };
 EXPORT_SYMBOL_GPL(mt7925_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 67c05f785190..5e72f7278e8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -121,11 +121,10 @@ int mt7925_mcu_regval(struct mt792x_dev *dev, u32 regidx, u32 *val, bool set)
 EXPORT_SYMBOL_GPL(mt7925_mcu_regval);
 
 int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
-				 struct mt76_vif *vif,
-				 struct ieee80211_bss_conf *info)
+				 struct mt76_vif *vif)
 {
-	struct ieee80211_vif *mvif = container_of(info, struct ieee80211_vif,
-						  bss_conf);
+	struct ieee80211_vif *mvif = container_of((void *)vif, struct ieee80211_vif,
+						  drv_priv);
 	struct sk_buff *skb;
 	int i, len = min_t(int, mvif->cfg.arp_addr_cnt,
 			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index b8315a89f4a9..b499b1d0531a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -590,6 +590,5 @@ int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
 			 struct ieee80211_chanctx_conf *ctx);
 int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy);
 int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
-				 struct mt76_vif *vif,
-				 struct ieee80211_bss_conf *info);
+				 struct mt76_vif *vif);
 #endif
-- 
2.34.1


