Return-Path: <linux-wireless+bounces-8952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4FA906264
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA98B22585
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2512FF70;
	Thu, 13 Jun 2024 03:04:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628812DD8E
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247855; cv=none; b=OJkUn7XX07nmCN+JYE5tNfDAzOTAKCig+cG6In8MC6iu9EwjKmF+KFFJEBfaU9rGuMf23HT1mTR9dTOMKNdIziXOi4O+hRDDMqpvHqLhSfQ+4FOGCjKGPelQYg8P053BwdIRjC7d5uebGW9lvvJlqwxzkJxdgwr026rnXf1IfhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247855; c=relaxed/simple;
	bh=3cLBQ63A8u3bk0OK3TnuLG6ZqvBhomYNSLmfhGFS2i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGfXJ03OvyjRMx0ucvNveGgo7mGJEo179m/LkUTvHZt72AlFUS+uTuaKGRsO6yliDWxXJEm+A4JWURI8jUE4NOAyzEwRkEube/J88d/AmjjMKOFIfhPdjkd2cZxjhApDQX3lLhjF6GCvq3M2UK9ViTezrlQ2ubrzx8KJNcghQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25496e90cf5so70208fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247853; x=1718852653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qaT8b7yGtuN3JUwjHPR4rGNkOaYwHk+6PNJhQjqaCo=;
        b=N6m1GAONk0i+LqOQC1+zeB7qFPUA6eBHW6sC3Snsv8kiQ3GP9iMFGpSBKyRcVDtrV/
         SbZj5d76lrqdENd0N7QaRZljTC8e7hazEKfXxOVAmJsxGuolJwbeILtbO9VposqSEU9q
         zHFDwSBDXgqgR+Tzyweb/KptKCn96xePA7l6ToHUb9pVrkE6mPxo0Au9NreBNRxDFYLI
         A/Qz6MjtCs68cTWC2daYr6amhIUCr+qEWwU/2lwR5CXqYEKl+scPRe8Fp2f8RdAd9xY0
         7qKTR/YRpjE1o3KKuKiZDd7blylHC2ch/BBlcutEqwa8HtK6iqVXaBOuE/qg7FgPeCEO
         39sw==
X-Forwarded-Encrypted: i=1; AJvYcCVhCSzuiHHm8ZVecOOEgrvDe/VJDDyy2nxspE1ChIyZX091XU1lXssbG0U7yWrzKrSwweeEHlPVQOkMPEDCIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvf0NyVnUyOYTCYk9cMbbjOltOWVVYDbthNnleMyB1hQuytqgO
	EaVWvOmyTsgC9AzboXstp5exX/i7+QJER4lynzIxhJcye/+C5WGfC8ytO1zdmfk=
X-Google-Smtp-Source: AGHT+IEqhSHMsARTCevRepG4Bai6+yCrp4bNWqrV+fqylm24sKnywEbKk5XYKWvL19S43sQzF1dk/A==
X-Received: by 2002:a05:6820:b0b:b0:5ba:c4ed:ee98 with SMTP id 006d021491bc7-5bb3b7a4c51mr3591290eaf.0.1718247853048;
        Wed, 12 Jun 2024 20:04:13 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:11 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 42/47] wifi: mt76: mt7925: add mt7925_mac_link_sta_add to create per-link STA
Date: Wed, 12 Jun 2024 20:02:36 -0700
Message-Id: <20240613030241.5771-43-sean.wang@kernel.org>
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

The mt7925_mac_link_sta_add function currently adds the per-link STA.
We will extend this function when we implement the MLO functionality.

This patch only includes structural changes and does not involve any
logic changes.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 47 ++++++++++++-------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index b91992745462..3911cf71462f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -702,45 +702,46 @@ mt7925_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return mvif->basic_rates_idx;
 }
 
-int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta)
+static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_link_sta *link_sta)
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
-	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_bss_conf *link_conf;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_sta *msta;
 	int ret, idx;
 
+	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
 		return -ENOSPC;
 
-	INIT_LIST_HEAD(&msta->deflink.wcid.poll_list);
-	msta->vif = mvif;
-	msta->deflink.wcid.sta = 1;
-	msta->deflink.wcid.idx = idx;
-	msta->deflink.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
-	msta->deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	msta->deflink.last_txs = jiffies;
+	INIT_LIST_HEAD(&mlink->wcid.poll_list);
+	mlink->wcid.sta = 1;
+	mlink->wcid.idx = idx;
+	mlink->wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
+	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+	mlink->last_txs = jiffies;
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
 		return ret;
 
-	if (vif->type == NL80211_IFTYPE_STATION)
-		mvif->wep_sta = msta;
-
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
 
 	/* should update bss info before STA add */
-	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls)
 		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
-					link_conf, &sta->deflink, false);
+					link_conf, link_sta, false);
 
-	ret = mt7925_mcu_sta_update(dev, &sta->deflink, vif, true,
+	ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 				    MT76_STA_INFO_STATE_NONE);
 	if (ret)
 		return ret;
@@ -749,6 +750,20 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	return 0;
 }
+
+int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+
+	msta->vif = mvif;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		mvif->wep_sta = msta;
+
+	return mt7925_mac_link_sta_add(mdev, vif, &sta->deflink);
+}
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_add);
 
 void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-- 
2.34.1


