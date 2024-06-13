Return-Path: <linux-wireless+bounces-8946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B01C90625E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8971F226EE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECE412F5BB;
	Thu, 13 Jun 2024 03:04:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883512F581
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247844; cv=none; b=CymL6f6XtiJj/5DsALU0LZ+aTVhyCQQV/kBWb/RAmN8A/oX+nvI6/Q7r9YU4EQModzDqkwOSxIOv/z6DvCM8doL3MVjUMlVZF9XQzxLx3TSpUG5M963rG9/Pt4fbkMcQOzxrqSS5WPoy+4N4X76zksISgIY6NmEcTGVSaukv1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247844; c=relaxed/simple;
	bh=1XlpFy4MeRr74FlI3nmmKEk8xATYQ0bvPWD8h6Ns8Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZUELG6G75UUeVHMkiBE0F7O+bb7F+pswxgSmgbc6krrz+QzggeEpN981t6utCuOf+VM18s4UV9Z2uFmOiVviMchy+S8wAS7oq4ir7KXVEwaeNqnoKpy5jJVYuhWmWQh1NpaOHi6pwO4fJCap0cMG6etjI3b/g8XFFdLlsWv/Fn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5bb24436f72so14148eaf.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247842; x=1718852642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkHDBlOkDJ0JO9nw4+ATjhclLWfJKvnEvDbeM9MFnc4=;
        b=t+lsbTbnDWCbj6sVfdVgHp/CM3XfoYt7WstFXo6bHF0od5I3Q/oSe++1gRWRUQmLT3
         cyc99pj1ohpd9VlNLBCuI+PwuqoK351J8rnCUEe3h1E3nTDrq07iw5nddju30QX64n60
         HlP+za7kAMaX65ftm70bITtck2OXFhsn9zXNgpR36hYh4TlArARnNeSjgyd6oKMVsXQQ
         1oNMSzestAiumnZGesXS6wucziLz0XTBMyN2Cqn82WPOoE0LgasEmd9twKFp+sRMdU/a
         EUlvo3tSyxf2oHxNeWd8IKGwmDAsCPW08NjXCUhE6t0oMN1VLISPfgRfpeoZkpORda1y
         NZZw==
X-Forwarded-Encrypted: i=1; AJvYcCXExvjBRwhPZqn6R7OiUPLMz8kkm3DkKLP7/OO2pvqbQIQoBDSH8zyV0Qt/xo0VgcIFAdHnXNoNyb9VOkQlfkM3j+GUQmo5TPS0Opjoe/c=
X-Gm-Message-State: AOJu0YynfM4eJomDz0Ezm89lvYg8X21zA1Xlhhn4hvcJzHtQlKg/QKJl
	lv13jKc1qHShOxSW3gC5wnyj5tzh3Wo+e/k+/Rqp6sYSYnkOZvUA
X-Google-Smtp-Source: AGHT+IEC7RP+/DIV32Apb3dYvlXNUgZrif0a/bIJWXgUP/56rqQwGaQ3rLescw43Rs0OCodd5k4AZQ==
X-Received: by 2002:a05:6820:d88:b0:5ba:ead2:c742 with SMTP id 006d021491bc7-5bb3b7a3d2bmr3673097eaf.0.1718247841693;
        Wed, 12 Jun 2024 20:04:01 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:00 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 36/47] wifi: mt76: mt792x: extend mt76_connac_get_phy_mode_v2 for per-link STA
Date: Wed, 12 Jun 2024 20:02:30 -0700
Message-Id: <20240613030241.5771-37-sean.wang@kernel.org>
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

Extend mt76_connac_get_phy_mode_v2 with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c | 16 +++++++++-------
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  |  2 +-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index f7ba3afb3ccf..294f79ab7ca6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -786,7 +786,8 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_he_tlv_v2);
 
 u8
 mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
-			    enum nl80211_band band, struct ieee80211_sta *sta)
+			    enum nl80211_band band,
+			    struct ieee80211_link_sta *link_sta)
 {
 	struct ieee80211_sta_ht_cap *ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap;
@@ -794,11 +795,11 @@ mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	const struct ieee80211_sta_eht_cap *eht_cap;
 	u8 mode = 0;
 
-	if (sta) {
-		ht_cap = &sta->deflink.ht_cap;
-		vht_cap = &sta->deflink.vht_cap;
-		he_cap = &sta->deflink.he_cap;
-		eht_cap = &sta->deflink.eht_cap;
+	if (link_sta) {
+		ht_cap = &link_sta->ht_cap;
+		vht_cap = &link_sta->vht_cap;
+		he_cap = &link_sta->he_cap;
+		eht_cap = &link_sta->eht_cap;
 	} else {
 		struct ieee80211_supported_band *sband;
 
@@ -904,7 +905,8 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_PHY, sizeof(*phy));
 	phy = (struct sta_rec_phy *)tlv;
-	phy->phy_type = mt76_connac_get_phy_mode_v2(mphy, vif, band, sta);
+	phy->phy_type = mt76_connac_get_phy_mode_v2(mphy, vif, band,
+						    &sta->deflink);
 	phy->basic_rate = cpu_to_le16((u16)vif->bss_conf.basic_rates);
 	phy->rcpi = rcpi;
 	phy->ampdu = FIELD_PREP(IEEE80211_HT_AMPDU_PARM_FACTOR,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 5b40d51ee728..2c939468d141 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1894,7 +1894,8 @@ int mt76_connac_mcu_sta_update_hdr_trans(struct mt76_dev *dev,
 					 struct mt76_wcid *wcid, int cmd);
 void mt76_connac_mcu_sta_he_tlv_v2(struct sk_buff *skb, struct ieee80211_sta *sta);
 u8 mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
-			       enum nl80211_band band, struct ieee80211_sta *sta);
+			       enum nl80211_band band,
+			       struct ieee80211_link_sta *link_sta);
 int mt76_connac_mcu_wtbl_update_hdr_trans(struct mt76_dev *dev,
 					  struct ieee80211_vif *vif,
 					  struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 3cda538307b5..321a164a6e14 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1526,7 +1526,7 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 	phy = (struct sta_rec_phy *)tlv;
 	phy->phy_type = mt76_connac_get_phy_mode_v2(mvif->phy->mt76, vif,
 						    chandef->chan->band,
-						    link_sta->sta);
+						    link_sta);
 	phy->basic_rate = cpu_to_le16((u16)link_conf->basic_rates);
 	if (link_sta->ht_cap.ht_supported) {
 		af = link_sta->ht_cap.ampdu_factor;
-- 
2.34.1


