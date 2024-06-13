Return-Path: <linux-wireless+bounces-8951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B7906263
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F421C219B2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571B12DD83;
	Thu, 13 Jun 2024 03:04:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB1132126
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247853; cv=none; b=HPXc7RjWkFPz57b8mfPU91C7nQX9jA6Dry8fR+0I2oPVckRIShqZmij9BVJne/gBEAh5R1KVkH3Y5Kuhw80dWjJxHW/0PjvUmHE4tUtjzhAOGpWoK9nKiE9QZBhrsUnb9t9YkGNT1S8pYiPzMg7HEEEEnZqJL0fQ4yfZaukjac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247853; c=relaxed/simple;
	bh=3CFbMNhzsMvrEU1ryLOSFPueoi4oBV149xAb0jwplL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgWm6t1M6V1vJDvr7GkFSzZmxypHdppq3Ajs503jTUQgK+QoYonyBN8UmpZt0hOwHGF2NPSemJp00vQRX7gBumd25eu+uTuouc3mFtz07Yn9ZsCl/UhmQluIMeuHz1FWCdctESVVgWGhiLi/xYGkNHkBaRFIf5x+zS/cAPLh4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b97f09cde3so43170eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247851; x=1718852651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgMigc2VAhtdTb1uu0yJ7C/V9AuPVgLB5PjEnDvYkH8=;
        b=l3vnCQoUxih4iJnZMrThccuNNZeCYgCD00Ghga8p8IkQtebk06z3HTBHnhftq+t3lH
         ksC19vhwSxC8avfdbGc6wpmnvrZg4qcyteCu/Kw2Ym6QzG4jUY3g08No5W0eObNWO8mX
         rw4jBe3cGBC8kcAUQXD/2MsdeNKCmFgZ0HgpADBU5zHL6uQJ42UHnxwB/1G3PqBvrjA8
         tkrf08spUKZ8wubK8rUZF8CHn9nUhjqcS0CV71bOJB/A0Y5IOTJKyqQi7Pjt92rQWZTG
         OWQIzocdKUsMj24U6x/3PEX261BunislH53oj7dSaDa03jglBaI8Yvx1fC2DXhonTDYb
         jV7w==
X-Forwarded-Encrypted: i=1; AJvYcCWmVOcK0ldV6jzLmRlBzVKnnj8EXE0IxbgZepsRirEmCm1G1cQEh9CAKwdasczOX1fQyxbB5Koc+LXRoFi4+qxT0+ruixZqZ+UEhiiUhiU=
X-Gm-Message-State: AOJu0YzOf6wmEEm95VkUzm0D4OHiahkS4XQaKQmOdZNTfPgXSIB/J/Td
	c+/N521N6agEl+ZzdB4N+FtUO1MacSs5whVoDjbscl4U33UTW+zV
X-Google-Smtp-Source: AGHT+IELnhgtggY4/ayU1vQAw9jcuSekNmvxXHACEAQ0mYwcUJ76ywNVecENM/8BKUBdyqxm5HkDdQ==
X-Received: by 2002:a4a:d196:0:b0:5bd:87a0:66d with SMTP id 006d021491bc7-5bd87a01b93mr286964eaf.1.1718247851492;
        Wed, 12 Jun 2024 20:04:11 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:10 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 41/47] wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:35 -0700
Message-Id: <20240613030241.5771-42-sean.wang@kernel.org>
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

Extend mt7925_mcu_bss_basic_tlv with the per-link STA configuration.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 24966e614303..7156ba092302 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2078,18 +2078,17 @@ mt7925_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
 static void
 mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 			 struct ieee80211_bss_conf *link_conf,
-			 struct ieee80211_sta *sta,
+			 struct ieee80211_link_sta *link_sta,
 			 struct ieee80211_chanctx_conf *ctx,
 			 struct mt76_phy *phy, u16 wlan_idx,
 			 bool enable)
 {
 	struct ieee80211_vif *vif = link_conf->vif;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
-	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
-				  &mconf->vif->sta;
 	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_connac_bss_basic_tlv *basic_req;
+	struct mt792x_link_sta *mlink;
 	struct tlv *tlv;
 	int conn_type;
 	u8 idx;
@@ -2102,7 +2101,7 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	basic_req->hw_bss_idx = idx;
 
 	basic_req->phymode_ext = mt7925_get_phy_mode_ext(phy, vif, band,
-							 &sta->deflink);
+							 link_sta);
 
 	if (band == NL80211_BAND_2GHZ)
 		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_ERP_INDEX);
@@ -2110,12 +2109,22 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_OFDM_INDEX);
 
 	memcpy(basic_req->bssid, link_conf->bssid, ETH_ALEN);
-	basic_req->phymode = mt76_connac_get_phy_mode(phy, vif, band,
-						      &sta->deflink);
+	basic_req->phymode = mt76_connac_get_phy_mode(phy, vif, band, link_sta);
 	basic_req->bcn_interval = cpu_to_le16(link_conf->beacon_int);
 	basic_req->dtim_period = link_conf->dtim_period;
 	basic_req->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
-	basic_req->sta_idx = cpu_to_le16(msta->deflink.wcid.idx);
+
+	if (link_sta) {
+		struct mt792x_sta *msta;
+
+		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+
+	} else {
+		mlink = &mconf->vif->sta.deflink;
+	}
+
+	basic_req->sta_idx = cpu_to_le16(mlink->wcid.idx);
 	basic_req->omac_idx = mconf->mt76.omac_idx;
 	basic_req->band_idx = mconf->mt76.band_idx;
 	basic_req->wmm_idx = mconf->mt76.wmm_idx;
@@ -2352,7 +2361,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		return PTR_ERR(skb);
 
 	/* bss_basic must be first */
-	mt7925_mcu_bss_basic_tlv(skb, link_conf, link_sta->sta, ctx, phy->mt76,
+	mt7925_mcu_bss_basic_tlv(skb, link_conf, link_sta, ctx, phy->mt76,
 				 mvif->sta.deflink.wcid.idx, enable);
 	mt7925_mcu_bss_sec_tlv(skb, link_conf);
 
-- 
2.34.1


