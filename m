Return-Path: <linux-wireless+bounces-10021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2A9291D2
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FD81C210CB
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5E5487BC;
	Sat,  6 Jul 2024 08:28:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAF41A94
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254506; cv=none; b=nhm309BZSu1ipajiftBcgqcJDHygrq15mumOzjTtaLir2JD31S+Aev2UEs4jNw68MvcL3kdCuZQvUl/sSOK/1q3CJldyTHrgY3BnfcDOnpdXDngUWkKJHHPFaoQawfJEoWgjAztwTe9JEtgglGhtRdTco9/HzqP1tACx4FXOjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254506; c=relaxed/simple;
	bh=aiD47GrNtXjLEcGKE8JaIFJfED7rLmzxOiwKyKH4vvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p3MJR5qOiAHZ5FQ7AdloUZR0+uLmTczFy4BfMaVm84R3E4T9nCm3i9vZlWllsdaVn/0rADa9rzKViqWIPTrn1na+F6/Ftf2QOlIeXl8eTgrs1Kk56L588tTn8o+jJFToMb71/vcezRVMtB2rrICB39orkn1XvCCWajTFAoZ5kYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c4540f1944so40768eaf.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254504; x=1720859304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0AqvqvX1XnawEbT1CZxbW1N0nw9RHpYcHRkl50qL/k=;
        b=iwAAcjHTFsu4OxN9Y6Q4tA3Fed4v5/69j+TkQAwmi8PVWiFhnt9ZiAE5pYnCUUZ5yr
         SmVvIm4J3s8P8eFqiBIyNFL0PS3zv6vtTYbebOc0IVRH9YwmRmREcS25tinm95ibvMPo
         vAGMbGYClmJq1Z0mojlWegRM0Xdh4+uf/VOQqUqXCBZBZ19GSRbM5KR6pnOIj05gjyku
         G0bMhS0pFLOnOrprKeGcrmT87ucA1rkktFhVlyl0npiCV780bmVprQLT6P0ol/9k92zX
         Rwm2x3ZdCwoAd/3poRr2RIzlrK3GUZJGsBRP2XOyE6R22WpQtFl8IaEjp2GZQnFLexHL
         nsHg==
X-Forwarded-Encrypted: i=1; AJvYcCXoLwCTX41jzK9g39BSjHfBRT5LclCmYVrmoCY0qesR3D8LG6ILKDWCovn3gT1bQszdi/WyAWPLLVGEVKMGuH50VzgPI8cAhqn8/r9+Rlk=
X-Gm-Message-State: AOJu0YyQrSXpT1un2HwYq17x3uICghgM7l63YDMyvC0D1+rD4gwtF81B
	5ovgHsrJjeFEEeTnK6VyYLWsCi90Wi8ZpQyNsC45LxBg+HBjKqH9PlEoaU7j
X-Google-Smtp-Source: AGHT+IGNdZ/1sIor3R57hAlhxrzJbk4ui2gjH+E4YJ1N0eT/zRwXtj5JuC6ek9LLKjnf7JbaT/WYfg==
X-Received: by 2002:a05:6870:eca3:b0:25e:c0b:82c5 with SMTP id 586e51a60fabf-25e2bf101admr6655751fac.3.1720254504111;
        Sat, 06 Jul 2024 01:28:24 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:22 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 02/37] wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, assoc, remove] for MLO
Date: Sat,  6 Jul 2024 01:27:42 -0700
Message-Id: <2410cc73eec3849c2185b5cfa613b7e903e68abb.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

[add, assoc, remove] the per-link STA from the corresponding to per-link
BSS with the same link id. The change remains compatible with the non-MLO
mode.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 32 ++++++++++++-------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 8b10b63bc98d..a043d93f3e1d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -728,21 +728,24 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_bss_conf *link_conf;
+	struct mt792x_bss_conf *mconf;
+	u8 link_id = link_sta->link_id;
 	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
 	int ret, idx;
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
-	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	mlink = mt792x_sta_to_link(msta, link_id);
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
 		return -ENOSPC;
 
+	mconf = mt792x_vif_to_link(mvif, link_id);
 	INIT_LIST_HEAD(&mlink->wcid.poll_list);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
-	mlink->wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
+	mlink->wcid.phy_idx = mconf->mt76.band_idx;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mlink->last_txs = jiffies;
 
@@ -753,11 +756,11 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls)
-		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
+		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
 					link_conf, link_sta, false);
 
 	ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
@@ -790,7 +793,6 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 				      struct ieee80211_link_sta *link_sta)
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_bss_conf *link_conf;
 	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
@@ -802,9 +804,13 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
 
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls)
-		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
+	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+		struct mt792x_bss_conf *mconf;
+
+		mconf = mt792x_link_conf_to_mconf(link_conf);
+		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
 					link_conf, link_sta, true);
+	}
 
 	ewma_avg_signal_init(&mlink->avg_ack_signal);
 
@@ -830,11 +836,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct ieee80211_bss_conf *link_conf;
+	u8 link_id = link_sta->link_id;
 	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
-	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	mlink = mt792x_sta_to_link(msta, link_id);
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
@@ -844,12 +851,13 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 	mt7925_mac_wtbl_update(dev, mlink->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
-		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-		mt7925_mcu_add_bss_info(&dev->phy,
-					mvif->bss_conf.mt76.ctx, link_conf,
+		struct mt792x_bss_conf *mconf;
+
+		mconf = mt792x_link_conf_to_mconf(link_conf);
+		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
 					link_sta, false);
 	}
 
-- 
2.25.1


