Return-Path: <linux-wireless+bounces-8945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037A190625D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD011C21945
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB7D12E1C7;
	Thu, 13 Jun 2024 03:04:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848C612F581
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247841; cv=none; b=aLVi5V3ukT0QpRdf5qX07zme9kMGJWbgLeM28r7xldhK2KONjaaeA+Am6Ht3iG7KTE5lhdyUdexe4A8W1akzq9sYguEQNnbvMJQKZuOdv91qtTF0Ab3mgc0owtHmDlKqgRbI7QhHCviLCbXuy5XXwxf/FpTjbTdA0toph9ShmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247841; c=relaxed/simple;
	bh=OpohjGWORn+9tgUxm4cgRzn0aFfbcIF+SLXROUKG8pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mi5wXiG3NdsGtP/1FFePGTGW7eh3e4YVo76Beaf4L5uXaP+h5LO6XDuFVHraqZcuWhKcKdP06gw8aXw0GrBQJp2hm369ab70O50Eu+MuWO3pQpUrU/p1lrkwOEumhjspfJJ/2RKsvHFzWcMBYFHMKpZX1gu5PqOTCh/FqdRNbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-254e7bdfac1so83263fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247840; x=1718852640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kqNpOQikz31Rvo98UCj21K+HMYQ5mjJ2R+HS/m16G4=;
        b=uywFnuaksJziRhiU+nStpnPemxM9BR1pwx3B+/6LGVlYGoXf3xS5wj+ArmznWrZpTo
         u44GI0O0h0kCx5c3wcUWUd43fU/rw49bLlELU17W/OzZbQ1dE0A7b/ABE8lnaKpNh3E1
         M3ITvKa4D4OPdeIR1jnQyZTkxbNirE/Ieq8B+7/XvquoPC1OoMEHsDfV7v/KvgHeWi0N
         Up59HijdHBdYBzeIkDmht74GN+L8r7aVf9BE/DBLoUfaV3hvC+yIcFusWFoge1gnQfx1
         7U8jRZFGsKkhXzJ7eKlsMny0iFShAuTiRLSZI8EplfGxybdy1ZwUS5ZoKbk81hnXn3H+
         SzmA==
X-Forwarded-Encrypted: i=1; AJvYcCXTpFqeZZIE2OzFrvtSNV3LZ9VLAazVWKwR5Jm/0MQoMcLEHiDe7/biZ000MjlPpkr8v3mBviRLFxqIGZK3DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfxLWpZi9zvTiWzHd52loNH7jlfVqr0J865kkkf1uKTSiHJlk/
	4/DDQtyNj/eXcFenDUTfsG0UYPEfEuGsDA96G8SpuFoX+tr6LX5c
X-Google-Smtp-Source: AGHT+IEtnVHuansGHURBC+LEKvMH3Jy7bWaeX+lPmpLCZZoarezi4l511KEJO27+VI+h1RFYRCfhew==
X-Received: by 2002:a4a:8552:0:b0:5ba:ca86:a025 with SMTP id 006d021491bc7-5bb3b7a9135mr3997374eaf.0.1718247839547;
        Wed, 12 Jun 2024 20:03:59 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:57 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 35/47] wifi: mt76: mt7925: extend mt7925_get_phy_mode for per-link STA
Date: Wed, 12 Jun 2024 20:02:29 -0700
Message-Id: <20240613030241.5771-36-sean.wang@kernel.org>
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

Extend mt7925_get_phy_mode with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 11 ++++++-----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      |  3 ++-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 87f918461051..f7ba3afb3ccf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1300,7 +1300,8 @@ int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba);
 
 u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
-			    enum nl80211_band band, struct ieee80211_sta *sta)
+			    enum nl80211_band band,
+			    struct ieee80211_link_sta *link_sta)
 {
 	struct mt76_dev *dev = phy->dev;
 	const struct ieee80211_sta_he_cap *he_cap;
@@ -1311,10 +1312,10 @@ u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	if (is_connac_v1(dev))
 		return 0x38;
 
-	if (sta) {
-		ht_cap = &sta->deflink.ht_cap;
-		vht_cap = &sta->deflink.vht_cap;
-		he_cap = &sta->deflink.he_cap;
+	if (link_sta) {
+		ht_cap = &link_sta->ht_cap;
+		vht_cap = &link_sta->vht_cap;
+		he_cap = &link_sta->he_cap;
 	} else {
 		struct ieee80211_supported_band *sband;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 2a858b1ca82e..5b40d51ee728 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1988,7 +1988,8 @@ mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif);
 const struct ieee80211_sta_eht_cap *
 mt76_connac_get_eht_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif);
 u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
-			    enum nl80211_band band, struct ieee80211_sta *sta);
+			    enum nl80211_band band,
+			    struct ieee80211_link_sta *sta);
 u8 mt76_connac_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
 				enum nl80211_band band);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 2c95c69f395d..0f50c6659802 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1503,7 +1503,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 
 	ra->valid = true;
 	ra->auto_rate = true;
-	ra->phy_mode = mt76_connac_get_phy_mode(mphy, vif, band, sta);
+	ra->phy_mode = mt76_connac_get_phy_mode(mphy, vif, band, &sta->deflink);
 	ra->channel = chandef->chan->hw_value;
 	ra->bw = sta->deflink.bandwidth;
 	ra->phy.bw = sta->deflink.bandwidth;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 32ea71128280..3cda538307b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2114,7 +2114,8 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_OFDM_INDEX);
 
 	memcpy(basic_req->bssid, link_conf->bssid, ETH_ALEN);
-	basic_req->phymode = mt76_connac_get_phy_mode(phy, vif, band, sta);
+	basic_req->phymode = mt76_connac_get_phy_mode(phy, vif, band,
+						      &sta->deflink);
 	basic_req->bcn_interval = cpu_to_le16(link_conf->beacon_int);
 	basic_req->dtim_period = link_conf->dtim_period;
 	basic_req->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
-- 
2.34.1


