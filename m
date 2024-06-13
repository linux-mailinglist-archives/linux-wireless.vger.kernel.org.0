Return-Path: <linux-wireless+bounces-8926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC50690624A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2B41C212B0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95212D765;
	Thu, 13 Jun 2024 03:03:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0AE12CD8C
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247804; cv=none; b=eMl72iKerW6KZJZDxvH7bBJJRq4mXrZe99XIx297hRA+6pWY3AGULDZPZmYRjaHJ1ZIOVS/9UsCElcuMdJcenRf+kmpnfussTtyVU90412IR/spkiwjjltabszf45G4XulT0Rg9adt89iAk+YhdP6Ggv0u6dlfPx9VvwqGokeXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247804; c=relaxed/simple;
	bh=ciQq9D93uUHuPsItTuQh0x4IWvDkFuu1Qs0Ahwml7F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NorBuwwWoHjqbIbZShSTriKA8OKMtXIBUpcUV1Oi3V96OF8xN0EVZPqoglrRmrcBU6y3wBMQIIwl/wUcPJXmS5FKqmrp0ScU5TLFVhMTss4I6KRDjaqfFFTQpb0ZFyhSYRBJA3Li3CJNP+JOy4Wryd2D11ZAVhB1NIx906G02LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5bafec9ad2eso25668eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247802; x=1718852602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4ipyO6QmN5fpxt1fsns5qX+Z2OCd3HAfhcBpiCjpsI=;
        b=izCnNgwr28gph2i3oZDOIpOHxhbOK0pbOlHeayYODZKHSlXsXOywrHMJBijeQWe58D
         ILi81NUCAQuwM8GWXZK7NxXfrZJeMldkcNpADGIUJ+MMLNt+Usav9mNNulgjhYFhO0Cp
         6zzSjL9MzZ4qvpHlv/dwTVsbqMbcQDYNqZeVif1WU3BATY8WDYv1P6O9VkOIz2z6uESv
         ZHSd+m/D7QYKZ3PgQtPQc0IgPY51/QbeifLdGeu6CL3DgB72uq0XNhjTtucOdcmLPk9W
         2MHIZPS12UhjO0KK5wuXn5653Juk2Yhgfu0A7FKHD1YtZO6k/bbWEgRUvf1Mr7L01FLU
         j1pA==
X-Forwarded-Encrypted: i=1; AJvYcCXJHkrWExE+SXVF7MbbMaq6GljFAYLcZpMQpW3Mqc/3K5SeiFWR0Qk9Kr8BappWjfEiw5/oFGGmjlxch7PHzaZKLGV9Nfm/PrQ5cz0QUC4=
X-Gm-Message-State: AOJu0YxisAgaYSow/d+phOBo47KYfnZEUts/tH5MPMt/ygIzveKaDsm3
	CdY9otXyrWTWJjGHmls41c9SjTFj54h6D7xiZLH8FBhrOWz/gWwM
X-Google-Smtp-Source: AGHT+IFhWFellQ8sEWpUCo0Tcq9fcIuLBFa3mmXqjo9a9JvDP51OBREHjytgdBFwum1XIR64B6bkUg==
X-Received: by 2002:a05:6820:d88:b0:5ba:ead2:c742 with SMTP id 006d021491bc7-5bb3b7a3d2bmr3671460eaf.0.1718247802154;
        Wed, 12 Jun 2024 20:03:22 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:20 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 16/47] wifi: mt76: mt7925: extend mt7925_mcu_bss_sec_tlv for per-link BSS
Date: Wed, 12 Jun 2024 20:02:10 -0700
Message-Id: <20240613030241.5771-17-sean.wang@kernel.org>
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

Extend mt7925_mcu_bss_sec_tlv with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 797d4c936fec..028c94d8c21f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2132,9 +2132,11 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 }
 
 static void
-mt7925_mcu_bss_sec_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
+mt7925_mcu_bss_sec_tlv(struct sk_buff *skb,
+		       struct ieee80211_bss_conf *link_conf)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct mt76_vif *mvif = &mconf->mt76;
 	struct bss_sec_tlv {
 		__le16 tag;
 		__le16 len;
@@ -2333,7 +2335,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	/* bss_basic must be first */
 	mt7925_mcu_bss_basic_tlv(skb, link_conf->vif, sta, ctx, phy->mt76,
 				 mvif->sta.deflink.wcid.idx, enable);
-	mt7925_mcu_bss_sec_tlv(skb, link_conf->vif);
+	mt7925_mcu_bss_sec_tlv(skb, link_conf);
 
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf);
 	mt7925_mcu_bss_qos_tlv(skb, link_conf);
-- 
2.34.1


