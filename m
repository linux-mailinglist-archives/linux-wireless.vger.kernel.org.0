Return-Path: <linux-wireless+bounces-8947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D676A90625F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E43A283F73
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2847A12D76D;
	Thu, 13 Jun 2024 03:04:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF012D215
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247847; cv=none; b=aZ8t1YlpgKmocT1v/S0YbW30gLJXfW6rgS8tFXpjLT6bYdg4ThyT/FceIlZ05XqWozESymj9MCUJ4hSpGny5WbLEh8peemntz8/NULJiY/1txUYuPQDaLbJecZHr57i/DBJ8SRPXviSmSV1QukAMAjA53NeZOVJlRC8WaQZ+hMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247847; c=relaxed/simple;
	bh=dRFSpXecaz+yAtBqC2XnBGsyDKX1s3wc1rwv0K9d8rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uEGpsw5VmqDNu1KnMMSlMVQaDnsR8EbM6kO4PUY9LSNdREDj8L0dQP9I2XxYKk++Sqg2JKy6Sm08aH0Qc3aXpc455NSDD6S+bUYf7HIKFtKA1kW7LrfyQUTshS0pj3QNZMCx+Y8NvjrMIbQZQZ5ppFMewZaSJ6INIOi5+0sr5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5bae827df63so40165eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247844; x=1718852644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdsOWdunEX8Yk5T3pweRV+cWYeKKmyqWhAt3rUAD9qE=;
        b=b1DxuR3na+VM/FI5tsMyqMiBPmiB+iRRykW7QGCaGqCguF4Lil5q41TrMumIhunLU+
         1jUuoV0wErgWCAOCPw+S9nYf5V0T1GeUDH8zdRTZVkECCZIcPZ8ECv1hggeR2pgqcyBs
         gOMzzU82C5MagWzLSxVRfCjhCz6okj2Rijsw/OU/JOxqacfNlG4Z3sMPYApOw+jjLfFL
         KX74Nnpw4Lt/K0wJ4xz/IapLUTvldzrU6ta4c5NWln6+mAim/lSDB5FrjCz68ejvoncR
         rzOLpiwcfLVF0H5WT0uqejHCsB0nc9lvLaDNs82h0xvCwU0lGtcZZVA1Pv7YGSvRew2g
         sRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9OZuv++vWTJR4voeWV14GM5KIYS9h6K7/sc82Rqeoqs4UJvG46JmTxDPVy4TZLsrhAXvHWE5QhFao29Y6tsYDN7KXxIitiOD5kY8g9ck=
X-Gm-Message-State: AOJu0YwtdbSVv7+JKhkZ+oxWw13agLPxiMaySAlOoV5v4XDZZpTBiPCL
	u3PZFp77q1r+/jzDFfGcgn0xk56x5juDWJ3n2P1qTsl5qVJtzNO1
X-Google-Smtp-Source: AGHT+IF+ml4MUeGV/i5XQwGw5xQ+DdY5QC2s4B4v6GTVWptW20U5JH/pw2wtkJ+TOE2Qar4pevwQ5A==
X-Received: by 2002:a4a:3101:0:b0:5ba:ca8a:6598 with SMTP id 006d021491bc7-5bb3b7b972bmr3908348eaf.0.1718247844497;
        Wed, 12 Jun 2024 20:04:04 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:02 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 37/47] wifi: mt76: mt762x:  extend mt76_connac_mcu_sta_basic_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:31 -0700
Message-Id: <20240613030241.5771-38-sean.wang@kernel.org>
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

Extend mt76_connac_mcu_sta_basic_tlv with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c |  4 ++--
 .../wireless/mediatek/mt76/mt76_connac_mcu.c    | 17 +++++++++--------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h    |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c |  2 +-
 6 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 792ae41f7c69..25670eeaecb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -861,8 +861,8 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		else
 			mvif->sta_added = true;
 	}
-	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, sskb, vif, sta, enable,
-				      new_entry);
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, sskb, vif, &sta->deflink,
+				      enable, new_entry);
 	if (enable && sta)
 		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0,
 					MT76_STA_INFO_STATE_ASSOC);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 294f79ab7ca6..b8ad080ad2c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -370,7 +370,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_omac_tlv);
 
 void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta,
+				   struct ieee80211_link_sta *link_sta,
 				   bool enable, bool newly)
 {
 	struct sta_rec_basic *basic;
@@ -390,7 +390,7 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		basic->conn_state = CONN_STATE_DISCONNECT;
 	}
 
-	if (!sta) {
+	if (!link_sta) {
 		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
 		eth_broadcast_addr(basic->peer_addr);
 		return;
@@ -404,7 +404,7 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		else
 			conn_type = CONNECTION_INFRA_STA;
 		basic->conn_type = cpu_to_le32(conn_type);
-		basic->aid = cpu_to_le16(sta->aid);
+		basic->aid = cpu_to_le16(link_sta->sta->aid);
 		break;
 	case NL80211_IFTYPE_STATION:
 		if (vif->p2p && !is_mt7921(dev))
@@ -416,15 +416,15 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
-		basic->aid = cpu_to_le16(sta->aid);
+		basic->aid = cpu_to_le16(link_sta->sta->aid);
 		break;
 	default:
 		WARN_ON(1);
 		break;
 	}
 
-	memcpy(basic->peer_addr, sta->addr, ETH_ALEN);
-	basic->qos = sta->wme;
+	memcpy(basic->peer_addr, link_sta->addr, ETH_ALEN);
+	basic->qos = link_sta->sta->wme;
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_basic_tlv);
 
@@ -1049,8 +1049,9 @@ int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
 		return PTR_ERR(skb);
 
 	if (info->sta || !info->offload_fw)
-		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif, info->sta,
-					      info->enable, info->newly);
+		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
+					      &info->sta->deflink, info->enable,
+					      info->newly);
 	if (info->sta && info->enable)
 		mt76_connac_mcu_sta_tlv(phy, skb, info->sta,
 					info->vif, info->rcpi,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 2c939468d141..4857c31cfb23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1879,8 +1879,8 @@ int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy);
 int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif);
 void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta, bool enable,
-				   bool newly);
+				   struct ieee80211_link_sta *link_sta,
+				   bool enable, bool newly);
 void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta, void *sta_wtbl,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0f50c6659802..7204866437ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1668,7 +1668,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, sta, enable,
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, &sta->deflink, enable,
 				      !rcu_access_pointer(dev->mt76.wcid[msta->wcid.idx]));
 	if (!enable)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 321a164a6e14..5a40979c0bba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1645,7 +1645,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 
 	if (info->link_sta || !info->offload_fw)
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
-					      info->link_sta->sta,
+					      info->link_sta,
 					      info->enable, info->newly);
 	if (info->link_sta && info->enable) {
 		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index f4c59eafb537..038c4a140ec8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2152,7 +2152,7 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, sta, enable,
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, &sta->deflink, enable,
 				      !rcu_access_pointer(dev->mt76.wcid[msta->wcid.idx]));
 	if (!enable)
 		goto out;
-- 
2.34.1


