Return-Path: <linux-wireless+bounces-8927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C5C90624B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74311C21360
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F3512CDBC;
	Thu, 13 Jun 2024 03:03:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600112CD8C
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247806; cv=none; b=CokHEgILl/UJOJpBoqM/4Pz7qcXFl5vyWzIP58kG7MEWbFQAbelPLFvLkurzgnnxARWIyisSwkHeVeLeHtMrUsYkO1QCmU8bpbdqglocSOE4Fo11Z274+yB4Ou5ON8PkM7ki50ZRWuwRxl+0Sh4LpvvOV5hsmUtyH4EFw2fAv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247806; c=relaxed/simple;
	bh=ODXpW3X/SSSF6rGUMLn2B4enf/lat8O0hxPL7PgaD40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aWoKltsYUZDjl3mJ9YdKZVaBAmYxAXEcQWFJaK9pxqYujzr+X+IrjGg4f4IGuMe0GHvxfsxjolH4hNcgOx1LXhFacsxH6W0ENoXhhvBJ8kKdzzjcU0glyJ+WG+2FiP6GB54hZgks0peuLa4mCxXzh8XxTuV9d+0SoLOWmAf46Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5bb33237b60so22137eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247804; x=1718852604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vv6e/GvblL0RsnLWjjsfrvHkKEUobVf9bh+1TtsfTcE=;
        b=n9BFe6EHnzlLsYOGYE+wQu3MO55o1ZdOJGK9hsHWE1Z8SHieWLyfN14jDgv06BjF7O
         rv8QPjQuS6W3UpkY133WHgl57AOklQ0hj/DiMJ9boHTsh8u+rHm/G7cpZExCjxOHkXq9
         9HzvOa+sAvJQSpp6y9yHYCAwieHzdpYwn4HIRME8oWQ70uJPuYRdADqMR9gaHiWdDwWH
         kVNY+RjKJ0fy9yK90i00AnEHgi01LEwiuvvh4Xc7KL8Qv+juhG5aHzzwEPOuXFHBLoqG
         G20dyWJlDnRDIpYZqXwmRiXld+N+7oWWft9194AZo7gq02OIZjJ3cPQCOnPUsT85zkNH
         4gEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX85WT94tEokcCxjV89wQUBRnHnaxLCAK+5sCmaZob9v/uE/AEdrflAFqbE4RHRQrb3yDShIaWITct/kUISU+Y489MxwBg79+Ou2RfJDh4=
X-Gm-Message-State: AOJu0YwvWEcwR38kq8m1EV8JvaCoRp5LPcbRMd+HE6wrX7mdjJ1Mgquq
	ZZjZ/MEpiuYa1WWEIxi+0wAQ0l4fQwci/ANI+dLCV8TMX1+uNsRq
X-Google-Smtp-Source: AGHT+IEKchg4RAPKv1w2iVq2otrOKx7P35BjC4n9Lr47n3pV1QU6C/eh0GgoM8TtNqpFehq/1WeJ3A==
X-Received: by 2002:a4a:3101:0:b0:5ba:ca8a:6598 with SMTP id 006d021491bc7-5bb3b7b972bmr3906975eaf.0.1718247803868;
        Wed, 12 Jun 2024 20:03:23 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:22 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 17/47] wifi: mt76: mt7925: extend mt7925_mcu_bss_basic_tlv for per-link BSS
Date: Wed, 12 Jun 2024 20:02:11 -0700
Message-Id: <20240613030241.5771-18-sean.wang@kernel.org>
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

Extend mt7925_mcu_bss_basic_tlv with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 25 ++++++++++---------
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  1 +
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 6a1afff92399..457e1fa2fde1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -338,6 +338,7 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->phy = phy;
 	mvif->bss_conf.mt76.band_idx = 0;
 	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
+	mvif->bss_conf.vif = mvif;
 
 	if (phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
 		mvif->bss_conf.mt76.basic_rates_idx = MT792x_BASIC_RATES_TBL + 4;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 028c94d8c21f..18e19ffdbb7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2062,15 +2062,16 @@ mt7925_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
 
 static void
 mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
-			 struct ieee80211_vif *vif,
+			 struct ieee80211_bss_conf *link_conf,
 			 struct ieee80211_sta *sta,
 			 struct ieee80211_chanctx_conf *ctx,
 			 struct mt76_phy *phy, u16 wlan_idx,
 			 bool enable)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_vif *vif = link_conf->vif;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
-				  &mvif->sta;
+				  &mconf->vif->sta;
 	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_connac_bss_basic_tlv *basic_req;
@@ -2081,8 +2082,8 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_BASIC, sizeof(*basic_req));
 	basic_req = (struct mt76_connac_bss_basic_tlv *)tlv;
 
-	idx = mvif->bss_conf.mt76.omac_idx > EXT_BSSID_START ? HW_BSSID_0 :
-						      mvif->bss_conf.mt76.omac_idx;
+	idx = mconf->mt76.omac_idx > EXT_BSSID_START ? HW_BSSID_0 :
+						      mconf->mt76.omac_idx;
 	basic_req->hw_bss_idx = idx;
 
 	basic_req->phymode_ext = mt7925_get_phy_mode_ext(phy, vif, band, sta);
@@ -2092,15 +2093,15 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	else
 		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_OFDM_INDEX);
 
-	memcpy(basic_req->bssid, vif->bss_conf.bssid, ETH_ALEN);
+	memcpy(basic_req->bssid, link_conf->bssid, ETH_ALEN);
 	basic_req->phymode = mt76_connac_get_phy_mode(phy, vif, band, sta);
-	basic_req->bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int);
-	basic_req->dtim_period = vif->bss_conf.dtim_period;
+	basic_req->bcn_interval = cpu_to_le16(link_conf->beacon_int);
+	basic_req->dtim_period = link_conf->dtim_period;
 	basic_req->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
 	basic_req->sta_idx = cpu_to_le16(msta->deflink.wcid.idx);
-	basic_req->omac_idx = mvif->bss_conf.mt76.omac_idx;
-	basic_req->band_idx = mvif->bss_conf.mt76.band_idx;
-	basic_req->wmm_idx = mvif->bss_conf.mt76.wmm_idx;
+	basic_req->omac_idx = mconf->mt76.omac_idx;
+	basic_req->band_idx = mconf->mt76.band_idx;
+	basic_req->wmm_idx = mconf->mt76.wmm_idx;
 	basic_req->conn_state = !enable;
 
 	switch (vif->type) {
@@ -2333,7 +2334,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		return PTR_ERR(skb);
 
 	/* bss_basic must be first */
-	mt7925_mcu_bss_basic_tlv(skb, link_conf->vif, sta, ctx, phy->mt76,
+	mt7925_mcu_bss_basic_tlv(skb, link_conf, sta, ctx, phy->mt76,
 				 mvif->sta.deflink.wcid.idx, enable);
 	mt7925_mcu_bss_sec_tlv(skb, link_conf);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index f675709f419a..9452a3592950 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -106,6 +106,7 @@ struct mt792x_chanctx {
 
 struct mt792x_bss_conf {
 	struct mt76_vif mt76; /* must be first */
+	struct mt792x_vif *vif;
 	struct ewma_rssi rssi;
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
 };
-- 
2.34.1


