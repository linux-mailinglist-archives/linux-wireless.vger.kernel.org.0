Return-Path: <linux-wireless+bounces-8937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD05906255
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6421C21370
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230BD12D770;
	Thu, 13 Jun 2024 03:03:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06981304BD
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247826; cv=none; b=nxUHhM+HQDG8bambrxudRMD4eKl33f3JB6snHHUq02kUs3OLDf7SXW0pRPf3S7rx3PJPboFqujIpqDy4PaShb5IYsW2Q+52WOMy198C6f7RfdWL/jA/09aGRWd3ErZSvc37tpIxRXVdzTSGeiziMfzNcNn437vwRwAaiy34bnl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247826; c=relaxed/simple;
	bh=5f3xBgEo8bnZ39r1NcCnXBqNXSBm/9KCeQWCmGwLIlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X+0a26iX+rzTgQnAUqqTCQ4jBAkWCPOeCK9nJB0g4nPepaTDIbz10w7uB9YT1GU6uhb+GUjWCpcgzcN4FYNAmHZhXOl5zCJjExWCQPj18DkvFBiY2YXRH8g5WQSB4l0E0jcpx+7Esd3kCItL7V1ryo1V4yTfKdYKJxieNLmigZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5bb10cfe7daso36871eaf.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247824; x=1718852624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQSrmyJur9VJtGLBvyCZFOXsDoRyiS3K1mbJIGVLmGY=;
        b=REYypW7ez0R/HIvYpcC0rDBCDaivPD5EX5ai/X+J5B/TWgAzhiJMgBtLWokoCZAYQg
         zQXtUMGFRw7LyMXwCQ2PMD3+xDgwBhTKor/9mdptQBzHEgB6Tjrucf09HxqeTYcwz+UZ
         vRv50Gtb10IoQ+KcLYkk0l6TmUXL7MT5m0GLgYb5GMsKoHmqLXXP0liQ851NwfLQuB0Y
         eNXTnA5hXhpqygUA1Kxaf9p+GWyCwU+ZhS92k+prTQCaLy5fL27Z/3Vgf670TEtlHWSe
         UmLpqVrpeUuGMu8PC+d4MLFyi8ADENySknbekDBYekaQQIkOAUaNz0/Y11i/zC2Wi2xC
         DrEw==
X-Forwarded-Encrypted: i=1; AJvYcCVrBxXV7zEr/7VW0CA+hJM4RNl2Aadf+q6K8DNiCM8EFRSi5TNQLXZx9qZX6e516+KS6FpxPVmnVzQIpstGxvrXyg7naMV651+HY9VVb28=
X-Gm-Message-State: AOJu0YysypFdkS+aeYBcKOfLSRdQ73CW2ExjHUjt3mnxxrEq86bAaK+M
	O3GHa3GJMwRHrM0EgcpPFdbRvt8gYWXEt8/XVT27iQCuYknWu4fR
X-Google-Smtp-Source: AGHT+IEQwqpW1E/BUpJ0H742faaHw0baC1m9x6eKJRhLlzj4oh0zMKhrV7eM1ZIuaJf1+DJyS56xTQ==
X-Received: by 2002:a4a:d196:0:b0:5bd:87a0:66d with SMTP id 006d021491bc7-5bd87a01b93mr286160eaf.1.1718247823766;
        Wed, 12 Jun 2024 20:03:43 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:42 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 27/47] wifi: mt76: mt7925: extend mt7925_mcu_sta_eht_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:21 -0700
Message-Id: <20240613030241.5771-28-sean.wang@kernel.org>
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

Extend mt7925_mcu_sta_eht_tlv with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 266010c0e00a..0c9cebd3ee71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1404,18 +1404,18 @@ mt7925_mcu_sta_he_6g_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 }
 
 static void
-mt7925_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7925_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
 {
 	struct ieee80211_eht_mcs_nss_supp *mcs_map;
 	struct ieee80211_eht_cap_elem_fixed *elem;
 	struct sta_rec_eht *eht;
 	struct tlv *tlv;
 
-	if (!sta->deflink.eht_cap.has_eht)
+	if (!link_sta->eht_cap.has_eht)
 		return;
 
-	mcs_map = &sta->deflink.eht_cap.eht_mcs_nss_supp;
-	elem = &sta->deflink.eht_cap.eht_cap_elem;
+	mcs_map = &link_sta->eht_cap.eht_mcs_nss_supp;
+	elem = &link_sta->eht_cap.eht_cap_elem;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_EHT, sizeof(*eht));
 
@@ -1425,7 +1425,7 @@ mt7925_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	eht->phy_cap = cpu_to_le64(*(u64 *)elem->phy_cap_info);
 	eht->phy_cap_ext = cpu_to_le64(elem->phy_cap_info[8]);
 
-	if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_20)
+	if (link_sta->bandwidth == IEEE80211_STA_RX_BW_20)
 		memcpy(eht->mcs_map_bw20, &mcs_map->only_20mhz, sizeof(eht->mcs_map_bw20));
 	memcpy(eht->mcs_map_bw80, &mcs_map->bw._80, sizeof(eht->mcs_map_bw80));
 	memcpy(eht->mcs_map_bw160, &mcs_map->bw._160, sizeof(eht->mcs_map_bw160));
@@ -1641,7 +1641,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta->sta);
 		mt7925_mcu_sta_he_tlv(skb, info->link_sta->sta);
 		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta->sta);
-		mt7925_mcu_sta_eht_tlv(skb, info->link_sta->sta);
+		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
 					     info->link_sta);
 		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta,
-- 
2.34.1


