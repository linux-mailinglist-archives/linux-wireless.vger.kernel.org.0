Return-Path: <linux-wireless+bounces-8943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1253490625B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0356B22E63
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3165612DDBC;
	Thu, 13 Jun 2024 03:03:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC068130E40
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247838; cv=none; b=S+/zJEH4Cpb7eVpySugRFW398gbRoyauoNryNowHhv3WWCI7oC3n+3HiSTniNQ1WPH545wEfJIAJ7rvjB3eGVxOBSr9d6OWVL9Q421LcuFoMgjVGTIsNxSQiI4dCI/Ho6YYd4GcGMNFfK7VIjMQq1NZ6kWbNA+oMCNOQbXPS3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247838; c=relaxed/simple;
	bh=QAFFfGwYLEnHEqo6FXQCBcr2gQrBP3p0URnnZQPLooc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0ukhixrlykWMAKFjRfKEV0vTeeV81dqSK0xbU1zz/fOaOS36QuKkzZR3B1RsnNJjRAmLltH34hxwUx2eTmCVuqR8E5dM8hizG/M3VDdTH/UCDXbFuQ7yOFZtN7eFgXAkeeAaw6DQ1bugACEI255CyxW5vtAkysPFnQArVQOZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d21b50f8b4so68984b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247836; x=1718852636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nye+j/7qGy0YUA+JVCM3jZJLUrkoBzYEWb5GNp1RVTA=;
        b=oo+NAC7wagG43D49s6aezElTku5RbbEM9/2jhdfIK5cle4o94wIOYWw9fTU8L17UIM
         RZBkHtczBtlOYCfaMzVE3YQP79xSazpAh9fHPEwRYuvQV9TLPfv3I11aCTM1741S/Dvy
         r94aBig7q9ZSLInVb5UP1rBrh3hl0xNO7rskcpFatefIV0e7gTh8b7yP3HpIPU8rHIyW
         byUMgzsDqIxJAcgKbsCNoje6Ual/EkY0S2xn4Wxi+j2DntFoBBnsAB2HUbKW/SkKP7at
         mOIMA8tOZD3PIPG7bEvGBZmtIrqecv1CaWNJHLtYWEOtWBW9wt6HziwFl5GACg2vwSA0
         riWw==
X-Forwarded-Encrypted: i=1; AJvYcCUmVy2UvTI+Vb65dS5I5gM6kd3eKLNOjAuSKFNWjVtHI/wvSgroAwLSoOZC5BYXIPsf2a6E2KvXnR0XC5JbXuKbI741rDibY7dA3OxNw8g=
X-Gm-Message-State: AOJu0YzRZOltHoTJHtUQEYdz+tCXSauM/ii4qzjZBezSlAPPKDxDarVo
	XF9u0M4vYxbo4u+uhBXt5Q9nxxlXyNS+nbJwcGVj+V6eFybsg0j2
X-Google-Smtp-Source: AGHT+IGqVf629ydu9/AlFHfkI+1bnq4OcapyfrCu+zhwMgh2RiZt82PM5g9cxvOIWlbsU+N3cPN4Bg==
X-Received: by 2002:a05:6820:d88:b0:5ba:ead2:c742 with SMTP id 006d021491bc7-5bb3b7a3d2bmr3672840eaf.0.1718247835702;
        Wed, 12 Jun 2024 20:03:55 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:54 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 33/47] wifi: mt76: mt7925: extend mt7925_mcu_sta_phy_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:27 -0700
Message-Id: <20240613030241.5771-34-sean.wang@kernel.org>
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

Extend mt7925_mcu_sta_phy_tlv with per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 35 ++++++++++++-------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 66d45d676739..a0fd02dd9551 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1507,34 +1507,43 @@ mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
 
 static void
 mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
-		       struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+		       struct ieee80211_vif *vif,
+		       struct ieee80211_link_sta *link_sta)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->bss_conf.mt76.ctx->def;
+	struct ieee80211_bss_conf *link_conf;
+	struct cfg80211_chan_def *chandef;
+	struct mt792x_bss_conf *mconf;
 	struct sta_rec_phy *phy;
 	struct tlv *tlv;
 	u8 af = 0, mm = 0;
 
+	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
+	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+	chandef = &mconf->mt76.ctx->def;
+
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
 	phy = (struct sta_rec_phy *)tlv;
-	phy->phy_type = mt76_connac_get_phy_mode_v2(mvif->phy->mt76, vif, chandef->chan->band, sta);
-	phy->basic_rate = cpu_to_le16((u16)vif->bss_conf.basic_rates);
-	if (sta->deflink.ht_cap.ht_supported) {
-		af = sta->deflink.ht_cap.ampdu_factor;
-		mm = sta->deflink.ht_cap.ampdu_density;
+	phy->phy_type = mt76_connac_get_phy_mode_v2(mvif->phy->mt76, vif,
+						    chandef->chan->band,
+						    link_sta->sta);
+	phy->basic_rate = cpu_to_le16((u16)link_conf->basic_rates);
+	if (link_sta->ht_cap.ht_supported) {
+		af = link_sta->ht_cap.ampdu_factor;
+		mm = link_sta->ht_cap.ampdu_density;
 	}
 
-	if (sta->deflink.vht_cap.vht_supported) {
+	if (link_sta->vht_cap.vht_supported) {
 		u8 vht_af = FIELD_GET(IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
-				      sta->deflink.vht_cap.cap);
+				      link_sta->vht_cap.cap);
 
 		af = max_t(u8, af, vht_af);
 	}
 
-	if (sta->deflink.he_6ghz_capa.capa) {
-		af = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+	if (link_sta->he_6ghz_capa.capa) {
+		af = le16_get_bits(link_sta->he_6ghz_capa.capa,
 				   IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
-		mm = le16_get_bits(sta->deflink.he_6ghz_capa.capa,
+		mm = le16_get_bits(link_sta->he_6ghz_capa.capa,
 				   IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
 	}
 
@@ -1639,7 +1648,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 					      info->link_sta->sta,
 					      info->enable, info->newly);
 	if (info->link_sta && info->enable) {
-		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta->sta);
+		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
 		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
-- 
2.34.1


