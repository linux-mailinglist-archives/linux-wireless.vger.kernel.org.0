Return-Path: <linux-wireless+bounces-8942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B690625A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FBA1F22743
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C46D12F37B;
	Thu, 13 Jun 2024 03:03:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEF3130A68
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247836; cv=none; b=kl1bEG3KKR846qlnSmRK5IudyT4WlG9sA47W5+X8ZS4UJIlr2GbEO/mPjWdMpTYZ1Kor6LzdESaeBr5YVLTkane4MIX5VAhAtcMth2/3hU3rbiGnufFqC2UTwY1khwn/jp8S3G+T+Wfg+noOKDlbu7svqvyUgsHM6dnWkt5tSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247836; c=relaxed/simple;
	bh=50MFFmWO/ZMIS5cZIt5jyUeGaFz137k4IkheypCC1Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bq13ruYhcb8iBD+vkmx8leDnpW1jyKUq52OjnlcaCAQgfbFpwhJvfwlaXUMzu/s9TXWgyhm4JfK1aTIOncjYZpiWniC8CgM/rCC6mt6UbhwBTdZwqYhWZOPPaht8z02npWfLcVWSrNo4QuRcKaCa2SiyZ7v1DfGg/YXJVEied6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-254976d3327so77741fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247834; x=1718852634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7OsvxRZu1eH3rdvc+37NIE+pK4g9A8AD+jv6tlQz/U=;
        b=k0/OX6IYqmOZR/z0/Cu6KvtJaVy7gFd3SCOdSubrXYm99OFopXwlxQjesA1ds/qEIu
         hW0e0gWozJfeStvW0GL89QGg63dMolqQkH27JRNj2jY9c1f8MB3qY+JrnbTUvaivGObj
         jOPuOOQJjBahuiSv43eE4xlUXXO+t7PS8bc2sAkugm+58P2RQGgxukmGy+Wxl8+30Sqh
         UYGp1nquMnQw8yBQIXA3dILXSHXXWZaIv9cdsPIfyL3n4qmpCUglFiXddQ4nH6rOjG3J
         Gintkghi9AO1uWifYE1ZGhKtbqnc3Ds3N8bjcMpOjEA5ziP5qdg/cDrmYil7rMUW8ywv
         vKeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrRXWAFUNu7YeOW3ZyiG+vgZKCoL7uWVdxHIY9lNhXJJ1Wi3q9sFLYQsLG/gDFq0A6GGZtCqZoutBL76lCkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxplT2iCHM1/VZ5tlaumuHK3fRbonU34EmOxoU52kKP5L6PZ7O0
	XpsirKdbW84qet2ZOLcOOerET1XgCWSHxtNTzaRHd8LnhPkRxjpN
X-Google-Smtp-Source: AGHT+IE5cSfFw0Tv8T3gXQeOhSzuuOvBA5v7PhZB9lPUmMjA6fWy7PnkWJW0q3qEHs38JHYZsnq3kw==
X-Received: by 2002:a4a:d196:0:b0:5bd:87a0:66d with SMTP id 006d021491bc7-5bd87a01b93mr286464eaf.1.1718247833853;
        Wed, 12 Jun 2024 20:03:53 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:52 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 32/47] wifi: mt76: mt7925: extend mt7925_mcu_sta_ht_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:26 -0700
Message-Id: <20240613030241.5771-33-sean.wang@kernel.org>
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

Extend mt7925_mcu_sta_ht_tlv with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 1b66dd26bd1e..66d45d676739 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1433,18 +1433,18 @@ mt7925_mcu_sta_eht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
 }
 
 static void
-mt7925_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
+mt7925_mcu_sta_ht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
 {
 	struct sta_rec_ht *ht;
 	struct tlv *tlv;
 
-	if (!sta->deflink.ht_cap.ht_supported)
+	if (!link_sta->ht_cap.ht_supported)
 		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HT, sizeof(*ht));
 
 	ht = (struct sta_rec_ht *)tlv;
-	ht->ht_cap = cpu_to_le16(sta->deflink.ht_cap.cap);
+	ht->ht_cap = cpu_to_le16(link_sta->ht_cap.cap);
 }
 
 static void
@@ -1640,7 +1640,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 					      info->enable, info->newly);
 	if (info->link_sta && info->enable) {
 		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta->sta);
-		mt7925_mcu_sta_ht_tlv(skb, info->link_sta->sta);
+		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
 		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
 		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta);
-- 
2.34.1


