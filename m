Return-Path: <linux-wireless+bounces-8950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD1906262
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B85283F0A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0589F12D775;
	Thu, 13 Jun 2024 03:04:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784A13211F
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247851; cv=none; b=bAD/n/1dvjj5I45qJxGoKws3I/Irwf/6qOyCu/GYw6MRjrH+Azz/EF7Dp2QtdsintgYKUTi0WB64yqoTL+sYhAw6sVSJBoENgSRGLrMKyBNm4B2wcVXgcl8H3/N8geKqd87wyWbG+DeM3oq854YHNxYVfnxLdpwSAIEWXgBFbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247851; c=relaxed/simple;
	bh=nXRBtK+jM78Cdvlf8ebSYhFJLavAGGbg5hDvKxhXsWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FcZ57Y7fxNo99f5GGAxVwZsb2NC+ZQ63YDkUNNzZmn/Jth/2IFavcSAxo6nz0fdMrrjbzr+DUtgmeJD3+C4aRLO5LdcG700ro2uhZwTnrKLfYGQHxgYfvxMg0lfG90HjtlfmtBCnaMv5k6M3TxJn7erIXromdcxt8SH3jM2gMcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5bb33237b60so22152eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247850; x=1718852650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QluQbYsRthrq2TjY99xwQmJ0DyLFnyarxriaOvZB7dE=;
        b=lXfwUIz1bcqRI7Mj2sRmfZaxzkmgMh5TA5/kiZRHfvFBf322BSUq51c7ETr0+kQuYX
         PwS5Gt7reYPN7tjprq21oh7v7YpcolVx9Z/GKu95RdQVS8BLZyAIRH40wg5HU6KNO2X3
         1tDDzvhGoeQPWNbgDJNlnyOybR2X51IDJMUlRg4kemadlBh/HZygcc+MRtNjdtL4JeCW
         A6mUJv3afr2yNw6kqT6YvPHoKGbf7LMs3zNWUx084+3bTyr8ebNNovK0CSPGM6bHvd3/
         xk3CLYfHwE6nu+UnDUWFOmF0hXlKbVzX3N1YV5nsFv3HD8VKgs8C/uH3V00zGcHhlbeU
         ZP7A==
X-Forwarded-Encrypted: i=1; AJvYcCXewGoKjvhMHAOkkx+6rFIuDoGmHK00+FAwZY9Gb07q2JW8Lt8f49JF5IYe9Iny90riwJrK/Rt1qjoMViBNdguxNoDkZE6U7o+7j0JMilk=
X-Gm-Message-State: AOJu0Yzk79lNI6jdlJwpygFDLDeaOkYJ2FKPnn7fxVAfhK+u2heTztOU
	Cz8orLUFoNU/MzO2IHCtQDCGVS28YL72aZoW9rGrxIi3BKzWOsQum3SmBAJzKiA=
X-Google-Smtp-Source: AGHT+IHHJAHArvkNLNdoaLuxrn6Rn+tkoIm65xYZGjX4Jf85vYwD0NOU2/HuFivJiJE18UYq80YE7A==
X-Received: by 2002:a4a:3101:0:b0:5ba:ca8a:6598 with SMTP id 006d021491bc7-5bb3b7b972bmr3908503eaf.0.1718247849788;
        Wed, 12 Jun 2024 20:04:09 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:08 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 40/47] wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link STA
Date: Wed, 12 Jun 2024 20:02:34 -0700
Message-Id: <20240613030241.5771-41-sean.wang@kernel.org>
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

Extend mt7925_mcu_bss_mld_tlv with the per-link STA configuration.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index d5f94ee78623..24966e614303 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2227,7 +2227,7 @@ mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 static void
 mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
 		       struct ieee80211_bss_conf *link_conf,
-		       struct ieee80211_sta *sta)
+		       struct ieee80211_link_sta *link_sta)
 {
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	bool is_mld = ieee80211_vif_is_mld(link_conf->vif);
@@ -2237,13 +2237,13 @@ mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_MLD, sizeof(*mld));
 	mld = (struct bss_mld_tlv *)tlv;
 
-	mld->link_id = sta ? (is_mld ? link_conf->link_id : 0) : 0xff;
+	mld->link_id = link_sta ? (is_mld ? link_conf->link_id : 0) : 0xff;
 	mld->group_mld_id = is_mld ? mconf->mt76.idx : 0xff;
 	mld->own_mld_id = mconf->mt76.idx + 32;
 	mld->remap_idx = 0xff;
 
-	if (sta)
-		memcpy(mld->mac_addr, sta->addr, ETH_ALEN);
+	if (link_sta)
+		memcpy(mld->mac_addr, link_sta->addr, ETH_ALEN);
 }
 
 static void
@@ -2358,7 +2358,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf);
 	mt7925_mcu_bss_qos_tlv(skb, link_conf);
-	mt7925_mcu_bss_mld_tlv(skb, link_conf, link_sta->sta);
+	mt7925_mcu_bss_mld_tlv(skb, link_conf, link_sta);
 	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
 
 	if (link_conf->he_support) {
-- 
2.34.1


