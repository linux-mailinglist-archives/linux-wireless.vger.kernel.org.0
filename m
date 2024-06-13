Return-Path: <linux-wireless+bounces-8936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A548E906254
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8D51C21534
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1726112D750;
	Thu, 13 Jun 2024 03:03:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C9112DD8A
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247824; cv=none; b=g7o8BaoEQmZrhsJDmx6dc8gCVpJUPBAwwk6s513VA8NwQRw1sSf3YWE8ydhS/d6bl/Pef62bRhlfquD5j6yDTHk//pTNGOctzntZ5PRBwI36g8uAMtKvugH3lMSRl6e/d/TduYxyPR2bvg754I+yXbTl0FhZM6VBKe+6tHMFwpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247824; c=relaxed/simple;
	bh=DK554dI4bUoL0OVe2QAi/Qyg81kf0SM2Y0xzVX4ve0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IOQdFY66RqHpDd9+8dXnvx5fphIf33AyjhlD7XUxcPDtGvu58glxSYyuQl6q8yl4ZWvZ7vtOOpSMPJulOWq4yFABLcX4VEiPThl2CZ43VJSEFR34Ku6IPhy0J54optdaL/8JZbKiQ7we0PdS7q97QyeYjSdJ0bMAl//kO/E2ha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5bad112b623so17433eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247822; x=1718852622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvAGAozLAf9+Dd5l/jq2X8brfnVJfxZN/757XdNNGMA=;
        b=WzcSKFffXRH964+7DTMbM4DZyUzgk9ust1lpH8Orjy9varNB1TVYfeLnWk2TkCA7Vw
         7OeOn1c6fIS3xupbgUOiJjZ8UwpctTd2SuhjqK3uCZ6X+S2ZbymxezxeiHjnngMHirjl
         39xd/Yv/6eJX5tK5uu5nnTXUmxpnppKY7mbrbPJI1WcH07WtjdjZX99SRElrr261T+r8
         9/ynG2dsus9jKdsbtLKQAzt696kjSiEj1NhM7HqYMFLPib4GqILk082VPgsHwVAg9nLP
         5tBqHYvNfx3tO1jCgWsZvaVClWrWYXgFONuIxZt9j8A0TDPfnrOVGy2hE/bvl3LItwuF
         RdHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUJZUrq1iKaFAno3PvvOcckssaFfRATvMauafVVqCCafIhaSIr6v41em5btSveyRhy4QopKnC5tojb9D+uuYyAFhOYBOSS6lIyY77oAi8=
X-Gm-Message-State: AOJu0YzYEnS1vDcADP/HbwWDr/6HiEBq8Ea9ZG3Wjqh6jJvxmlbeTMP+
	EpFRLz+3BORx56QdvC62/bf7lZShBRtihY4g2i4VzuPjuAjWJB8J
X-Google-Smtp-Source: AGHT+IGpMQ5S/mhrKCSARUVCIn4Jo9kDC1V91P56i1wTQJz8siUBroHJtRJ4cj+F8W+b4BJC3NgdeA==
X-Received: by 2002:a05:6820:f49:b0:5bb:815d:e2ab with SMTP id 006d021491bc7-5bb815de308mr3531966eaf.1.1718247821798;
        Wed, 12 Jun 2024 20:03:41 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:40 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 26/47] wifi: mt76: mt7925: extend mt7925_mcu_sta_rate_ctrl_tlv with per-link STA
Date: Wed, 12 Jun 2024 20:02:20 -0700
Message-Id: <20240613030241.5771-27-sean.wang@kernel.org>
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

Extend mt7925_mcu_sta_rate_ctrl_tlv with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 45437603763e..266010c0e00a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1569,7 +1569,8 @@ mt7925_mcu_sta_state_v2_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 
 static void
 mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
-			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_link_sta *link_sta)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct cfg80211_chan_def *chandef = &mvif->bss_conf.mt76.ctx->def;
@@ -1581,7 +1582,7 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
 	ra_info = (struct sta_rec_ra_info *)tlv;
 
-	supp_rates = sta->deflink.supp_rates[band];
+	supp_rates = link_sta->supp_rates[band];
 	if (band == NL80211_BAND_2GHZ)
 		supp_rates = FIELD_PREP(RA_LEGACY_OFDM, supp_rates >> 4) |
 			     FIELD_PREP(RA_LEGACY_CCK, supp_rates & 0xf);
@@ -1590,9 +1591,9 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 
 	ra_info->legacy = cpu_to_le16(supp_rates);
 
-	if (sta->deflink.ht_cap.ht_supported)
+	if (link_sta->ht_cap.ht_supported)
 		memcpy(ra_info->rx_mcs_bitmask,
-		       sta->deflink.ht_cap.mcs.rx_mask,
+		       link_sta->ht_cap.mcs.rx_mask,
 		       HT_MCS_MASK_NUM);
 }
 
@@ -1642,7 +1643,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta->sta);
 		mt7925_mcu_sta_eht_tlv(skb, info->link_sta->sta);
 		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
-					     info->link_sta->sta);
+					     info->link_sta);
 		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta,
 					    info->vif, info->rcpi,
 					    info->state);
-- 
2.34.1


