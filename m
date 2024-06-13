Return-Path: <linux-wireless+bounces-8935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F159906253
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C011C21606
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B11112BE84;
	Thu, 13 Jun 2024 03:03:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781612DD8A
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247821; cv=none; b=b17cwiaoDsQtAduj+ybONGue6l7dQ4MT7kvwP5l0gGmwR1q6zjVpnEugLf00JurDibWE/aAnKz+ZW5dSwVvcVZcJS6lVqvrC4MxPl7iOh5sB+yRW1a97H6vw29IvriwVH+WpB2BQL+CiFFuqFeaX6RZm5mLxIfOwN5FnLV9bDmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247821; c=relaxed/simple;
	bh=QuXNssCpr6iAI/MXCOOpedGnYZuNiZvHFAAtY/z+fWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aE2IYHNtbrhTg5haUYfBLL4cT0qwIPngzu8zKvFrAqjIvalqMcNFthCo2LwCG/cMS2/mUOGitW7xlDF/WxFsXD2q4SBAEBKmwdvMQS+Qcm7n1y++yxCy7D0MdKeMITfZB5ITRnZI4rDsdnEcS9Ek9s72YbYh2BmJaRflzTdxXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5bb24436f72so14145eaf.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247820; x=1718852620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dccZ5/3CuQxaIWTMPM2TCEJVGRDx3lSvYRxYcTANQJs=;
        b=r1lL94rwb1+kN2D6NiuIUcdEhdB+uUN0KMG76GbSG/1Z2QLlMMPrvkfqJVkJA+kQVz
         NYnHjAWsx54MrGFkr4lu0lf5Ds7ZHlwoEqrVuaS2+N+An8bu7qdWFwRt7x7bPq/GhNV0
         V10I1ppPVta5EXIdsTCwr1kvyfLErM/4tKgwHjeW686Klk7njI+U+pAuXR23MN3dW+ZC
         9Y0ET67iLo5JRT8aPuMRJLDZ1fyrPGDY3FomIbvQj2R1hnr2R/RJ/LayXFIeMuIRqng3
         /TAZ2OBsXOFHWCAhtLGhS85CAyIweTjk+E8iKCUTPD29MSlYqOubbE4ur0YjtIQb85yl
         gyxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW1O+X+tLFGDe96z7MS/VQhDf/0McKWjdT4oeDi+53zl2rndC10OiVhOyCWmcHGcrRDysywHQmApM4JPoccj2WwTmebiaCI/cCUdaSt3E=
X-Gm-Message-State: AOJu0YxQ3YYjK+4FVTZQ9KaAqG8AiSxCbnI+GgQQ6pgarPR5PA/vYqXB
	d4oi/y10E9zsJRwVlWNpbUy99kfVib2kKA7Rk1OPFwpcSIvAdwft
X-Google-Smtp-Source: AGHT+IEGIjZCwi/Tk7NiS9kdq5f92ZDbUb6ejmQj6BfYAZAXPkv/6SLbnmuPZp8+YJRlocNp/L52eQ==
X-Received: by 2002:a05:6820:f49:b0:5bb:815d:e2ab with SMTP id 006d021491bc7-5bb815de308mr3531890eaf.1.1718247819665;
        Wed, 12 Jun 2024 20:03:39 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:38 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 25/47] wifi: mt76: mt7925: extend mt7925_mcu_sta_state_v2_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:19 -0700
Message-Id: <20240613030241.5771-26-sean.wang@kernel.org>
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

Extend mt7925_mcu_sta_state_v2_tlv with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 9b69b4b178de..45437603763e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1540,7 +1540,7 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 
 static void
 mt7925_mcu_sta_state_v2_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
-			    struct ieee80211_sta *sta,
+			    struct ieee80211_link_sta *link_sta,
 			    struct ieee80211_vif *vif,
 			    u8 rcpi, u8 sta_state)
 {
@@ -1560,9 +1560,9 @@ mt7925_mcu_sta_state_v2_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 	state = (struct sta_rec_state_v2 *)tlv;
 	state->state = sta_state;
 
-	if (sta->deflink.vht_cap.vht_supported) {
-		state->vht_opmode = sta->deflink.bandwidth;
-		state->vht_opmode |= sta->deflink.rx_nss <<
+	if (link_sta->vht_cap.vht_supported) {
+		state->vht_opmode = link_sta->bandwidth;
+		state->vht_opmode |= link_sta->rx_nss <<
 			IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 	}
 }
@@ -1643,7 +1643,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		mt7925_mcu_sta_eht_tlv(skb, info->link_sta->sta);
 		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
 					     info->link_sta->sta);
-		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta->sta,
+		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta,
 					    info->vif, info->rcpi,
 					    info->state);
 		mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
-- 
2.34.1


