Return-Path: <linux-wireless+bounces-8940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E42906258
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671D3283C29
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950A12DDA1;
	Thu, 13 Jun 2024 03:03:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C2130A68
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247831; cv=none; b=D+xWcxC8VRYogFTjmZoJNIahcXDYzfDU6/nfRnXbnooWt6uMYLebhv5ez0lvLKz8XV0eiQyXhjej4EZ5/k2cEFi9y3r43buCTEpm72SWlxF9UZj9TCHg7Q8oSkp+DqmhsBG05K6qB31/Y/+EpaEUZPnBJQEvBdM+cbtz/tk8KVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247831; c=relaxed/simple;
	bh=ubdindo0k4LskTEOE1Nr+qK/zBV/Gxp+XLAFzhxbKto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GbSAorDXr3OSRnuHnB7P26ugjr2ey0ezFxgPCpqatO9aYJKCv9KwslGLiQ6kHUn/n5scfhYd0IdBfE5R4CqrHYIMugwM9o0zeDXPFd4uPVCdBnUtK2LhSkDd/8EPSdlQ5hS+DRVXyEokfLybqNPc/u/21Aiol97bB5JllH8ReoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d21a80b8ceso76368b6e.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247829; x=1718852629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHk3C2PwpK+oygytSYiJpUDeuuAoM9zKNfmYXO0m1ZQ=;
        b=Ypc3ccMI37YNFUWpXT4YYD1+emH8TGGC8MDOmfFYdOcRZy9E61q1MFbglKdI8VNV4k
         rCIKqbk1v6F1+fcEgGvHV52rnyNRo0h/WhDlHOndIT1GgPSLqtIB141iVQ6vn4M+NjgR
         b2VRWuwJDmsg8jUe/mj3u50P+gOuMqoTVfnHFn9ISKm9rtykUP9ze+SLI6rsiY/Ip1lf
         Q1yP2E0a9RGxcdE2fttIMX3Vdnv7VgYwHpM76cU8ppWQmsuNB0TfkJpGXEP/+SNqIWtX
         U0LG4rFWZl2aSs/vbUY4ULt2IFBQAr8KPR2cp9LOgE6K1Jvk1dvLghF35wVW6vKAsOjM
         1tCA==
X-Forwarded-Encrypted: i=1; AJvYcCWmt40rHmjn97mYrxJVy03LCzOx9k9fpsWvEO/6Wgx+Qpd9Tlx3vBGwm6RKEpxAgzt+H4ftEwJyq7f9WdQQsM5jOV1U+C2hpYKWQFLFxTg=
X-Gm-Message-State: AOJu0Yyc+GA2Z8NHTX1PyRx1utL7WWYaXp3Xkgmel12HbZA6AyGOWqxO
	bvat5b9ixb2QDJ5O0S4C4Az7jNwiH+j3WqX0oPZUPHulV2cEYJBoeHV6JQ3bX4I=
X-Google-Smtp-Source: AGHT+IEOfTMldWJhfu6oE3jsE+ovd09HiMqJ50xG/cVQ1nKISjkL9wPBGCmp2S8krtzhzoEZy2hTyA==
X-Received: by 2002:a05:6820:f49:b0:5bb:815d:e2ab with SMTP id 006d021491bc7-5bb815de308mr3532229eaf.1.1718247829399;
        Wed, 12 Jun 2024 20:03:49 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:48 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 30/47] wifi: mt76: mt7925: extend mt7925_mcu_sta_amsdu_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:24 -0700
Message-Id: <20240613030241.5771-31-sean.wang@kernel.org>
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

Extend mt7925_mcu_sta_amsdu_tlv with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a57620aed63b..57b89eca4e21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1467,9 +1467,11 @@ mt7925_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 
 static void
 mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
-			 struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+			 struct ieee80211_vif *vif,
+			 struct ieee80211_link_sta *link_sta)
 {
-	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+	struct mt792x_link_sta *mlink;
 	struct sta_rec_amsdu *amsdu;
 	struct tlv *tlv;
 
@@ -1477,16 +1479,18 @@ mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
 	    vif->type != NL80211_IFTYPE_AP)
 		return;
 
-	if (!sta->deflink.agg.max_amsdu_len)
+	if (!link_sta->agg.max_amsdu_len)
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HW_AMSDU, sizeof(*amsdu));
 	amsdu = (struct sta_rec_amsdu *)tlv;
 	amsdu->max_amsdu_num = 8;
 	amsdu->amsdu_en = true;
-	msta->deflink.wcid.amsdu = true;
 
-	switch (sta->deflink.agg.max_amsdu_len) {
+	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	mlink->wcid.amsdu = true;
+
+	switch (link_sta->agg.max_amsdu_len) {
 	case IEEE80211_MAX_MPDU_LEN_VHT_11454:
 		amsdu->max_mpdu_size =
 			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
@@ -1639,7 +1643,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta->sta);
 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta->sta);
 		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
-		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta->sta);
+		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta);
 		mt7925_mcu_sta_he_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
-- 
2.34.1


