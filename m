Return-Path: <linux-wireless+bounces-8922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B726C906246
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36409B227C4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3E212BE84;
	Thu, 13 Jun 2024 03:03:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3F12DD91
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247795; cv=none; b=GIsOBfSS2uEl5c/52Ij1W4Fjs4mC7vpB67Ch8iwwipRPuIzrHhpgYFEa0U6+TYSpsM7vo66vUMFP9gQU95CaM/+ASNivG0HufU3LyAnYe2uuoFDePxLc4r0B+aRoIvBePnykO7PnyT7EKfgbS971GEKoRvdfsoFbc+1HP7rwEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247795; c=relaxed/simple;
	bh=eJrl3zB1MWyLL5OTl7sp0AaDJbq7t+qWEuWzXKYyhZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=It4byYNjYJTPg41sQ9NaJQIA5BlA1/cavpDsTpXTLueJlO6pMjXvA9YydhSQcnv0GmZGvSD0x02p5egonhwhoUd74U5FBR7fSFGun7tX0d+0QvBSOQrib3Qy/g3DGOX8Z/q8sk2DlQ4nc+SCdcEcZNb9xMIm8U1DNC4ukfvz5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b3364995b4so54759eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247793; x=1718852593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdCy5+kMixwBbPegp0qJ0hHaXxWnfbk8yzhAroU2gIE=;
        b=tLD+LYkRDfvFdMHnbAxXaPQMeVp7NAxIKlhjEdjSn6LAihcjA4CmxOLWc+pw1rcVjM
         GjwIlBpEjv9tLiPJk63kuGbczUtvpBIJ8f8bYLMORTQFAFYVCR/F6/Zd1Wq95Cf97x1t
         YrG9eTwi5jDBc/ZiDjy29yYdDRv3AO3hjsZm9zio/cVGIcugT1XPzY5CBIRUteW/0QBN
         Eyd9VYo/W8TWZVNGirFaINKBPAEQFjWvKCFd+Pg2lYUZe9mDZ9jjFiPhhE5HAwvCRSdR
         /zS6H0HHLcyKkYn66frz9ovPogzhI9ZuxmuJeRGddEZedl7o0tvcUWS/T3DhLrFKDW3T
         06lQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2HBebUkIdfQnufYYmOs4xgdtrWrX/wT0pjgJw5/T+3efDPWB8VB8J+iiQoRwsPXY1o8k+LaNVglPAUqIi7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYbVhGAi7DtderChkgmoVyfizQjStYd+V0UAzycSKzjFofF8IF
	FYGtOPjBQFy4xHUbbAL3DdKpeiJwv3wj5P6pETL0zfV6yJ9otVtV
X-Google-Smtp-Source: AGHT+IGU09NrhHqyYkv/BhQS695UYCYhdc72/gkJHzuGqM75JEta2qBWPeccLaUVq7xGy2O10RRDWA==
X-Received: by 2002:a05:6820:2c86:b0:5aa:3e4f:f01e with SMTP id 006d021491bc7-5bb3b9c614cmr3867976eaf.1.1718247792708;
        Wed, 12 Jun 2024 20:03:12 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:11 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 12/47] wifi: mt76: mt7925: extend mt7925_mcu_bss_qos_tlv for per-link BSS
Date: Wed, 12 Jun 2024 20:02:06 -0700
Message-Id: <20240613030241.5771-13-sean.wang@kernel.org>
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

Extend mt7925_mcu_bss_qos_tlv with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 533214403008..d6a590061e36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2227,14 +2227,14 @@ mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
 }
 
 static void
-mt7925_mcu_bss_qos_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+mt7925_mcu_bss_qos_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf)
 {
 	struct mt76_connac_bss_qos_tlv *qos;
 	struct tlv *tlv;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_QBSS, sizeof(*qos));
 	qos = (struct mt76_connac_bss_qos_tlv *)tlv;
-	qos->qos = vif->bss_conf.qos;
+	qos->qos = link_conf->qos;
 }
 
 static void
@@ -2336,7 +2336,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	mt7925_mcu_bss_sec_tlv(skb, link_conf->vif);
 
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf->vif, sta);
-	mt7925_mcu_bss_qos_tlv(skb, link_conf->vif);
+	mt7925_mcu_bss_qos_tlv(skb, link_conf);
 	mt7925_mcu_bss_mld_tlv(skb, link_conf->vif, sta);
 	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
 
-- 
2.34.1


