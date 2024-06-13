Return-Path: <linux-wireless+bounces-8949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB50906261
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FE928405A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4091312D215;
	Thu, 13 Jun 2024 03:04:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBB912E1CD
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247850; cv=none; b=CXMVbaz+sVZUWCPLqGpPa9mKkvdvTvmjr3D+HTIqWBh8V3c4b/e0cl5siIFXYcvtqyXpAV44fCAttFh6B5VHvn2UFRJvsgBLaeP1ZL96ED73M/ul7yI7oQUYANCtgk7U2/sZMS2gOzsxZyvl2Gl2PcQBcLM32gIMxietFbTz090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247850; c=relaxed/simple;
	bh=1Y9vt2Mk38k910Z3qBrcOP0Tdxk2qdlTBl+XtGZkGV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LYO/0HBN8LhFmuA75cK+93tLwycO80UhZ7/kGeoWjVYqO3Mcc/ChEl3I7c+0ZHdsYmTlEY7mlFzw9qjPU7oRoc2MF5zIzCGcJGpwIYRO8t02YWMbAMU6Sc2P9GP8HWqvrYNfOWxG9FJw+4a2B1zkH2q4e038jrEkaPsXeTdL/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5bad7941dcfso26266eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247848; x=1718852648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpNMqJkAA2wzb/wI14GkcWcUpOPlO27N/TMsWpf1FR0=;
        b=FHh0j2u1KbeUvqskOAXjnpi3uiUH0/51sGWUu3RR+kZ03ImJ3IzcAQvbGNCDHjQ2Bf
         X/Y5ce2Z9MRhwG20tg7xwTxJ8+tJFmzFeZ2L9itZIQEui8IEyZBJlQjEJVw9vashs6EC
         M35KW4c83usJ9+hnmE2BfjVEncgxlhqesPiiW6M1bM9/2yoLexvmpYCS/Jn+vB3xxpMk
         VH/AFCQrh+Pt46h4aq2+U89d1tamgOXkq15Ynl+Oi12vXpu3CKuU4VAk8gXb349gsDlS
         ji21vLr7+oYP9FnQRj9N5imJEiBfljkuYyfy0mpMnMqyHdXARDadvKyMMJqMRVmJZl3e
         ObtA==
X-Forwarded-Encrypted: i=1; AJvYcCWRexptQb7mwyXBZLR6UPElIEEaG57Y1g5ixrLMr+IO3/GF5aJT8QiwCoz5zSGttZJHNxkja9zQrpvX9wHBDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgfH9H3OptIsABLjy5EHOss7jXZCYIcR56FGprHZsvZrqNsJTm
	6NvQrwZo5q+Ov9iIoEPSPGnQ77u24gKTi7rXuQjtJhc6dJkEfLQJ
X-Google-Smtp-Source: AGHT+IHYPct9Rt5bxYHHJDkUc4nkQhYW7M7rTF1uzIU6UJKM5FsSWXS7AnJkTQ26FXuJ+SfmYJE3IQ==
X-Received: by 2002:a4a:d196:0:b0:5bd:87a0:66d with SMTP id 006d021491bc7-5bd87a01b93mr286829eaf.1.1718247847820;
        Wed, 12 Jun 2024 20:04:07 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:07 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 39/47] wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link STA
Date: Wed, 12 Jun 2024 20:02:33 -0700
Message-Id: <20240613030241.5771-40-sean.wang@kernel.org>
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

Extend mt7925_mcu_add_bss_info with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h  | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index f3a32fe9a754..b91992745462 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -535,7 +535,7 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 		mvif->bss_conf.mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
 		mt7925_mcu_add_bss_info(phy, mvif->bss_conf.mt76.ctx, link_conf,
-					sta, true);
+					&sta->deflink, true);
 	}
 
 	if (cmd == SET_KEY)
@@ -738,7 +738,7 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
-					link_conf, sta, false);
+					link_conf, &sta->deflink, false);
 
 	ret = mt7925_mcu_sta_update(dev, &sta->deflink, vif, true,
 				    MT76_STA_INFO_STATE_NONE);
@@ -765,7 +765,7 @@ void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
-					link_conf, sta, true);
+					link_conf, &sta->deflink, true);
 
 	ewma_avg_signal_init(&msta->deflink.avg_ack_signal);
 
@@ -802,7 +802,7 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		ewma_rssi_init(&mvif->bss_conf.rssi);
 		if (!sta->tdls)
 			mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
-						link_conf, sta, false);
+						link_conf, &sta->deflink, false);
 	}
 
 	spin_lock_bh(&mdev->sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 667ecd44392d..d5f94ee78623 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2337,7 +2337,7 @@ int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
 			    struct ieee80211_bss_conf *link_conf,
-			    struct ieee80211_sta *sta,
+			    struct ieee80211_link_sta *link_sta,
 			    int enable)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
@@ -2352,13 +2352,13 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		return PTR_ERR(skb);
 
 	/* bss_basic must be first */
-	mt7925_mcu_bss_basic_tlv(skb, link_conf, sta, ctx, phy->mt76,
+	mt7925_mcu_bss_basic_tlv(skb, link_conf, link_sta->sta, ctx, phy->mt76,
 				 mvif->sta.deflink.wcid.idx, enable);
 	mt7925_mcu_bss_sec_tlv(skb, link_conf);
 
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf);
 	mt7925_mcu_bss_qos_tlv(skb, link_conf);
-	mt7925_mcu_bss_mld_tlv(skb, link_conf, sta);
+	mt7925_mcu_bss_mld_tlv(skb, link_conf, link_sta->sta);
 	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
 
 	if (link_conf->he_support) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index c5197577cdc8..da4e84f468d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -595,7 +595,7 @@ int mt7925_mcu_sched_scan_enable(struct mt76_phy *phy,
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
 			    struct ieee80211_bss_conf *link_conf,
-			    struct ieee80211_sta *sta,
+			    struct ieee80211_link_sta *link_sta,
 			    int enable);
 int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 			  struct ieee80211_bss_conf *link_conf);
-- 
2.34.1


