Return-Path: <linux-wireless+bounces-8938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E757906256
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C6D1C212EE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32B12D755;
	Thu, 13 Jun 2024 03:03:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AD12DD9F
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247828; cv=none; b=Sgg2qLsC9ZgtVo9v2a/7UstcI6Fv0V78LgfkSs1rOJHwXXJXPI3i116WAEavKLBph09oNuryrOA34ovoLiourAlJ8U/hEc9u0/cFV4cBsTWINltR8R9nh370ZlGFAqwLd/Tov2H+V6kTNOeYJdmPhv+35xPjMHt68/mMihf3MeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247828; c=relaxed/simple;
	bh=/TdxytPw+HcqbotxdzWcjrgM/Dd+D2SprKJCoBdPAJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLvOIAJezX37mN10AJWqtmXuy2GfHZ69EPrtAW5S69YnzRYSXdhlkvJf0v12eJHoU5SpYPgMCwmJtGywz70u9qh5pMWIhHvUa7qec9sDVUjF/iT8DRbg0PT8emaYBOTMvB1/z5eyh9MgEg1tzbOK2cfav97fC+oNeZDEApLdS4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5bad7941dcfso26257eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247826; x=1718852626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoEs7B6T1gVNEXMq3665UB7KgLCGFV0A9uQvetVLP78=;
        b=dx2CX6ToAkvInjKIxfGV3vI2BCOxsxY2dcBHjibuSukWWQRT3KWmAsRikxhlATx/MR
         g7EOH0rim3LfimNlFJBmN23+0CJoDeNJRZ1V/FqW3hZdOoGjxj5nKkcpm+34rl42e1L1
         g3z1WYs9ui5naOjuWSk/bAKaz6jP0rDM+Z9sVElF9ZhULkmm0PKQUGfdaDUHF8DYQY9a
         CuaqneYV8m0rJyspLlar0sjXAQwn0jqk7FleUEUOTjQLQuJDiBo0NANJapFgQMbxN5XB
         X65gSCcCn8HUd2BoRyjP4XmmDk2GbO7bESwugfrGb/7WElQiFPHCqBud0ISgtiCoJ4iv
         UIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFxDBeFBroXHriTmi4Zh7DEyP30wmx1HPHjWttuvGreFNR0/8eHbCzf1X60ttn5Z03Fv3k0/lRvM3L+ESDX00AphMe+eVH2PF1HCa+mzo=
X-Gm-Message-State: AOJu0YzKNYh/JpsSXNCXAMqTcJuZSxosmxeZfuYTQrCbccg0N51msMi3
	ZmbhzNmMtxJ4RaaXLS+DCvvHdHHvu0sWqFLvzA/ZFvzYgnvnuiKU
X-Google-Smtp-Source: AGHT+IEN8+hwX0caiHOXoNsbUeCYOepGoMV0RHhVHb9esDQ1cKY7FqH5AHqh3LPL9I2YtyitVrYS3A==
X-Received: by 2002:a4a:d196:0:b0:5bd:87a0:66d with SMTP id 006d021491bc7-5bd87a01b93mr286222eaf.1.1718247825880;
        Wed, 12 Jun 2024 20:03:45 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:44 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 28/47] wifi: mt76: mt7925: extend mt7925_mcu_sta_he_6g_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:22 -0700
Message-Id: <20240613030241.5771-29-sean.wang@kernel.org>
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

Extend mt7925_mcu_sta_he_6g_tlv with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0c9cebd3ee71..e1dc8452468c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1389,18 +1389,19 @@ mt7925_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 }
 
 static void
-mt7925_mcu_sta_he_6g_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7925_mcu_sta_he_6g_tlv(struct sk_buff *skb,
+			 struct ieee80211_link_sta *link_sta)
 {
 	struct sta_rec_he_6g_capa *he_6g;
 	struct tlv *tlv;
 
-	if (!sta->deflink.he_6ghz_capa.capa)
+	if (!link_sta->he_6ghz_capa.capa)
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE_6G, sizeof(*he_6g));
 
 	he_6g = (struct sta_rec_he_6g_capa *)tlv;
-	he_6g->capa = sta->deflink.he_6ghz_capa.capa;
+	he_6g->capa = link_sta->he_6ghz_capa.capa;
 }
 
 static void
@@ -1640,7 +1641,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
 		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta->sta);
 		mt7925_mcu_sta_he_tlv(skb, info->link_sta->sta);
-		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta->sta);
+		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
 					     info->link_sta);
-- 
2.34.1


