Return-Path: <linux-wireless+bounces-8924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A5906248
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A241F219E7
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640112CD9C;
	Thu, 13 Jun 2024 03:03:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED412CD8C
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247800; cv=none; b=laxXQNy+B0lAPQJ4RB/Q0T9P1yeqDXf7zxfh5f+T2kr/V14p1W+lNlrkKRf3d+nGPAh1nU4fE9eJ56nRoNIQFPIGsXHRPerhTfu7lQoq1nPzvFvfK+w9/9fSvvn80BNekHHfUvjt2WWsr2h1SWWwUH8lcRo6teZCA/PCoIKkod8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247800; c=relaxed/simple;
	bh=Vz9/+vS6VagISSSbERmOmBtfES76GZ4w6Psiu7WAJ3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=enkBx38gObZc86oaMq8C8K/58vIqPr+DOORGEMe5fMZLe67fGGjUuHwLIbgNb5kN9Ml8919dMHQJdmTIhYxgNHgOLrNXkSDNoFnCo1wz25bYQpVfwf8pV3nbGerSHtcGKPvVHhocFCkCqY/HRVV+YRi9b3x8ED4sFJQyMUJBSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5bb10cfe7daso36862eaf.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247798; x=1718852598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7fyLN2eTcT5yVDs+Za/KLYWdVcVwhKyVQJ642fwgMc=;
        b=TwJ1+PiE1/R7XTcqgZg6DPer2Ad8Wt99Fjzx3vhrOvs2SjeEXSUquTWj7IifKbBkOb
         N5qnjyKKojTd8d1N/Lod45OEcKNiolJOpCeCo5Z33VjmYiyV3+tUtePy00I7q0ONIpFG
         L6pl65le+TXI0M1LKl0yTIGH1ft05pD4nMECi/spfzTyDyVc7eYnMGZvDBFI8R00aG6z
         AZexR3RgKx7SyqYq0o3ly5s8rm3N7yLu8T+qNZHslp2DteKyRPLr0cZ2ymF3n1c8uuub
         FwRkWxyz4pSZVJtHU6eNIkNV5D9wptrQRKELaprgVH24KHJ2+1969o8hrF8GmT3q/7W2
         AxtA==
X-Forwarded-Encrypted: i=1; AJvYcCWepgUdab4DI+IPvxwoV1JPyyD3ymRySsaCidFXFKUWsE8rz7FCjLJ/FdMvxQBV4ym60ozf+MhJy5O2FqRe4gua+uOVDzWKlYQqp1oAhOs=
X-Gm-Message-State: AOJu0YwKWp4j54PPMrzt7U6yDbcwK6RvbKGXcPjuZbAknRZnTcDoNAFx
	6F1wduZ0bzQMrKq4tUAAb6OTZF1Wll1dBf6DPkvnAHUPZoR+KvLb
X-Google-Smtp-Source: AGHT+IF3tKvAO7O2wwRJgNy6xEVfg8yq+WFBOGurkxFmdxTHX8HN8CopPZp2U0FN7ExMmIvLd10M3Q==
X-Received: by 2002:a4a:8552:0:b0:5ba:ca86:a025 with SMTP id 006d021491bc7-5bb3b7a9135mr3996007eaf.0.1718247797718;
        Wed, 12 Jun 2024 20:03:17 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:15 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 14/47] wifi: mt76: mt7925: extend mt7925_mcu_bss_bmc_tlv for per-link BSS
Date: Wed, 12 Jun 2024 20:02:08 -0700
Message-Id: <20240613030241.5771-15-sean.wang@kernel.org>
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

Extend mt7925_mcu_bss_bmc_tlv with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 93ce018a0801..48b157f42db9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2179,12 +2179,13 @@ mt7925_mcu_bss_sec_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 static void
 mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 		       struct ieee80211_chanctx_conf *ctx,
-			   struct ieee80211_vif *vif,
+		       struct ieee80211_bss_conf *link_conf,
 			   struct ieee80211_sta *sta)
 {
 	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->mt76->chandef;
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	enum nl80211_band band = chandef->chan->band;
+	struct mt76_vif *mvif = &mconf->mt76;
 	struct bss_rate_tlv *bmc;
 	struct tlv *tlv;
 	u8 idx = mvif->mcast_rates_idx ?
@@ -2335,7 +2336,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 				 mvif->sta.deflink.wcid.idx, enable);
 	mt7925_mcu_bss_sec_tlv(skb, link_conf->vif);
 
-	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf->vif, sta);
+	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf, sta);
 	mt7925_mcu_bss_qos_tlv(skb, link_conf);
 	mt7925_mcu_bss_mld_tlv(skb, link_conf, sta);
 	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
-- 
2.34.1


