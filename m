Return-Path: <linux-wireless+bounces-8920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EE5906244
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3541F20F99
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17F12CDB1;
	Thu, 13 Jun 2024 03:03:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0A012D1F6
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247791; cv=none; b=NbM6rm1GcVGX9qfYl+Fw82ogwMmmu2MP5sNELtRtQlbdvXHydbXIw3+MpigyXXsqx/dZ3BfELx5O0qdmtP3kffHMoW8ZbKrSZ5COmuw5tk7f1En6GvAiSxJ7Gp2fJPHvHNz8eQnKjNqjcIL0Ba/+Qo8KooMR5RybKkkX/zHJoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247791; c=relaxed/simple;
	bh=AWHkzmAg0Cbs9Xt67eFSMn7aCnzcllmnn0ULn8S6iNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LmRhmd6+A6ItFjYzD2T9Y6aY7RbJVpnLqfTm+F6B11DX2Vyi8ZkUNABwGaOW6HEMq1WoVsFGOP81wIoXfm1nclv/OhHGQt/5bRWHECe2KjCUomwMihWQgPAWdPLl9+W+7afcsUR+YpBz4WvF3Mc7R/JZFYSENcX04THPgcJ1z4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5bad7941dcfso26248eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247789; x=1718852589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8wZ9LqPMT7Xzyb/TNy4z9TySRR4HAhftUt/beLfrpU=;
        b=O8YdoYlWNHaw9xEex6NzzW5Z9bFrpmwDzFNSO6qZiBk/v3vPTAVvUre37M0tC21ip2
         YMUUFnpsroKF46mP+rqbANjHeW5BkXlDVjVK1aFO2UbyeqlrPIKfzqAL92xTt70GB17G
         4FDBqGyUrs6k59LdQJwQMIe/77eP1Bu5+nYwQXTcWeUz8Q4f5v7l1Fic9lpFezrIpl4p
         LcClBYNnTTLEv79VaOAhtuPdt4BN1yEpAzrrnxCWTEP3zXbb2Mm4xFqt4zv8icDsrnqr
         EtOLwRDcBXsQHiFbvwHFbJEWov4UtH1fT+skLPx3EFlcdbdaWvggr1TLddnnCRr0iAeu
         SbRw==
X-Forwarded-Encrypted: i=1; AJvYcCXbDADy13VEmrFhCu7wQymoKG4Mp3GgkMTq/WxodEQYF+ejHXA7WajMCLwKwXsDg5BpVtQxnWCyPVk53HGtzBNMWS1z7cSXpHn3vMCJn04=
X-Gm-Message-State: AOJu0YzFd6PfPHI6Fh8oudZKBTAb6PopEGKTMxrjhFGZVAC/uBJOBn/Z
	nJc4saR7WuQESqAJXwtEU3aSPDnZxj2h5lI++tK9d3Ho+huo92Jl3I9p1n6C0+c=
X-Google-Smtp-Source: AGHT+IHqadgzrZGoLgoJFK/NJvS0x3ikV8MhU9hCl6gI/OhLxrrMkqmc1SPmCVhc+zJdhP2h5XcNqw==
X-Received: by 2002:a4a:d196:0:b0:5bd:87a0:66d with SMTP id 006d021491bc7-5bd87a01b93mr285198eaf.1.1718247788980;
        Wed, 12 Jun 2024 20:03:08 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:07 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 10/47] wifi: mt76: mt7925: extend mt7925_mcu_bss_color_tlv for per-link BSS
Date: Wed, 12 Jun 2024 20:02:04 -0700
Message-Id: <20240613030241.5771-11-sean.wang@kernel.org>
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

Extend mt7925_mcu_bss_color_tlv with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 7cde18e273d8..10e38637eb83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2266,7 +2266,7 @@ mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 }
 
 static void
-mt7925_mcu_bss_color_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+mt7925_mcu_bss_color_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
 			 bool enable)
 {
 	struct bss_info_uni_bss_color *color;
@@ -2276,9 +2276,9 @@ mt7925_mcu_bss_color_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	color = (struct bss_info_uni_bss_color *)tlv;
 
 	color->enable = enable ?
-		vif->bss_conf.he_bss_color.enabled : 0;
+		link_conf->he_bss_color.enabled : 0;
 	color->bss_color = enable ?
-		vif->bss_conf.he_bss_color.color : 0;
+		link_conf->he_bss_color.color : 0;
 }
 
 static void
@@ -2342,7 +2342,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 
 	if (link_conf->he_support) {
 		mt7925_mcu_bss_he_tlv(skb, link_conf->vif, phy);
-		mt7925_mcu_bss_color_tlv(skb, link_conf->vif, enable);
+		mt7925_mcu_bss_color_tlv(skb, link_conf, enable);
 	}
 
 	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-- 
2.34.1


