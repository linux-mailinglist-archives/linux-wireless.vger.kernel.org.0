Return-Path: <linux-wireless+bounces-8923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6374A906247
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D581F21225
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4D12D770;
	Thu, 13 Jun 2024 03:03:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885912D753
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247797; cv=none; b=bKpvIzVo92UZYSwJ4BVfpynqx682WevBbvNtE9ToQiROnrFkWI0uNVIjPdAF62TlVqI+1fPn0OqZvjB46pWwS0SUY+pP5/bF5+aON1Honi/dL4F/Zepf1BhmPJr/vd7+FIUdLvs+7uOdMfU8/a0YhpoO85uY3g0xR4Q57VVDUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247797; c=relaxed/simple;
	bh=fwklTUj8LvAulrXJGPhl2UerJxxra8C2AtYaHL4F10A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mmfrau+lCyKnnmMC0zBiM1CsGcK+NcUYYgx9ACMJ/lRLfBO5HL38XMtd1fUpnPxYzHoNBWvEZktkIAWLZfbS3W2hJ10W389CRk8NfYoKPi2bYNXJp16ouMg7tVVihbNeVi59/CyM0vPULo1nQMPNWMgbYewRouyKzEl4wy6r/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24c5ec50da1so92009fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247795; x=1718852595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKy4Q0CaWzGta6AQsmEkVzO4cC46jn6FmQGCDe6kxjc=;
        b=D96yhPkyBllpgTUTw8TmUtGIQvUSHs7QcRPqcPhyxRlrAHbMy75o1RN9fY5nvILp+S
         2xP0S7FTG/jQbw0ETUP819ZwtVx6qeOqu3konWbeZkA9jw3bOc3GHfkFYQYsG0C5mOjK
         VY5N1jLLCVq7PMADEqw42hNaE95U/fR5cNOFjdFYsD4AjJv5mSwWqNESqIU7IlJRrWY0
         Oosm1OVq80koYDrw/oTeL/u8wEwfYM488v8iK3Qm/7+USr5rYBDZy4+M+rFugqmjIqzi
         S3Cw8ZKCZd5yrHC6LonZ7DAae4r396TQBlPMyANzxGzUBEfeSJwSVCzfgo4kN14pe9re
         fZsg==
X-Forwarded-Encrypted: i=1; AJvYcCUFQ6wB9YDSNFXquJDf2P2JJfqLlkUR5cVPMRia+cNaFwVHy1M8X0SFiOGBC3HeShOV7Dz9Clw558Lxk1w5NdD69mWQUcfql5G56jebyDA=
X-Gm-Message-State: AOJu0YxyWOVA/RD5T/mPbUxB6/ke6p+nZVe73r9AX3I1AEUK/uQiI3Ys
	h5NQtXGIHfxfLS0WI9C9DEsjqczZNRppF78ajwkfxCzyzuJPI1ZW
X-Google-Smtp-Source: AGHT+IEXh4X1g1pv0SmYU/zclu0zjOlYL845YMFZJX7tNiyr8Vn0dBv54YcBpoycu/jPsHItinsd2w==
X-Received: by 2002:a4a:d196:0:b0:5bd:87a0:66d with SMTP id 006d021491bc7-5bd87a01b93mr285392eaf.1.1718247795013;
        Wed, 12 Jun 2024 20:03:15 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:13 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 13/47] wifi: mt76: mt7925: extend mt7925_mcu_bss_mld_tlv for per-link BSS
Date: Wed, 12 Jun 2024 20:02:07 -0700
Message-Id: <20240613030241.5771-14-sean.wang@kernel.org>
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

Extend mt7925_mcu_bss_mld_tlv with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index d6a590061e36..93ce018a0801 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2206,20 +2206,20 @@ mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 
 static void
 mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
-		       struct ieee80211_vif *vif,
+		       struct ieee80211_bss_conf *link_conf,
 		       struct ieee80211_sta *sta)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	bool is_mld = ieee80211_vif_is_mld(vif);
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	bool is_mld = ieee80211_vif_is_mld(link_conf->vif);
 	struct bss_mld_tlv *mld;
 	struct tlv *tlv;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_MLD, sizeof(*mld));
 	mld = (struct bss_mld_tlv *)tlv;
 
-	mld->link_id = sta ? (is_mld ? vif->bss_conf.link_id : 0) : 0xff;
-	mld->group_mld_id = is_mld ? mvif->bss_conf.mt76.idx : 0xff;
-	mld->own_mld_id = mvif->bss_conf.mt76.idx + 32;
+	mld->link_id = sta ? (is_mld ? link_conf->link_id : 0) : 0xff;
+	mld->group_mld_id = is_mld ? mconf->mt76.idx : 0xff;
+	mld->own_mld_id = mconf->mt76.idx + 32;
 	mld->remap_idx = 0xff;
 
 	if (sta)
@@ -2337,7 +2337,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf->vif, sta);
 	mt7925_mcu_bss_qos_tlv(skb, link_conf);
-	mt7925_mcu_bss_mld_tlv(skb, link_conf->vif, sta);
+	mt7925_mcu_bss_mld_tlv(skb, link_conf, sta);
 	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
 
 	if (link_conf->he_support) {
-- 
2.34.1


