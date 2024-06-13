Return-Path: <linux-wireless+bounces-8954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49490906266
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72E61F227F8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B8912CDB1;
	Thu, 13 Jun 2024 03:04:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1F12E1DD
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247858; cv=none; b=m001Qj9wGxV43tnLinBZH9RLpYtMnHO8wGAVsYRBouLllS/Z8AhgD1nip9gLuEtSYTdpvXjv9GpLrjTk5zrVQDAV8ffyaAbec99tw7DSkxilYtJiP5W4p32AT1qZAd7JjqVMvVsd43ixqi6+Wl1kpBE9m298wvRdSfymFQLMhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247858; c=relaxed/simple;
	bh=5z174yjLLcOxyqogYbqkyN6D9woxICcSLMPBeFn0Eh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lr2Q+HPe6vqEppnDlFEkAEdJh75ucx9pGaITRDikODwbbfCHLHKWd599DDoebh1/SZj1VqxrM3EIJz/C+scEGABM2t6Xu8BMCZx3AnP6ZnYj0H1lqvaGcYo2CyjO9x8i5wdW7HIM77KDI/qcKVt13GA0bMK7Sv0w5nUs5bbgQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-254ceab70e3so84220fac.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247856; x=1718852656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9GNs6B5bu7pTah9Ud2+nU3M0TzPxJfZY98bb6SSuDs=;
        b=A7dyVBF/gHE9Qi/xontfaDkGZf4ID3OXf0aOisjFqbHiAhloZOtePKS+s0Gyoy80GX
         a2KWBza79XmYVdcQ8nZd57xUB4NatCrxjkSab5rx0N+ti5cOW/FLP0dvAthJxbDTL53U
         vSzQuIuZ05ajCRs3pGQ0xu3MqEJ+OxPnqHJr390lSJ4IdlW73V6ID/oC5UKkc/za0QUk
         PNZ94F1srcB8zkIEMQCdiOP0qfQUnTt7FmLX/B2/+TqFsWUTqPpjck2qRBENRZnn2ne4
         ZSIODdlv7g3cF60Tv0/r294Ck28PzIV4KXqxKUIOgy45+xZdrAsusyVAsp8JyyCHNXbG
         VTgw==
X-Forwarded-Encrypted: i=1; AJvYcCV4GOeGYsDO2124pkq09u9xHlaErkDFwzQQym7IjmXehXBFrg073GkR/7tVo9LCRBcHeNtx3vbHfWNXEBX1sAr9MPq0LxuqDwtY69+ElL0=
X-Gm-Message-State: AOJu0YwPiBrWU4YdVKe97Ha8NVAVUrVdh/e+4uh+ui3FH/9o7neqvySQ
	FiWS94VII0CWQRYaNR+P23IifJ/DTxXJj1xaF6YNgwDUb0r5uTGR
X-Google-Smtp-Source: AGHT+IFREIYX1Sd34i8E7irY+54INGBR1bLti4tXtswuJFCTubZVEPCyBjycPUyUsBH+7NegEAREQw==
X-Received: by 2002:a4a:3101:0:b0:5ba:ca8a:6598 with SMTP id 006d021491bc7-5bb3b7b972bmr3908721eaf.0.1718247856207;
        Wed, 12 Jun 2024 20:04:16 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:15 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 44/47] wifi: mt76: mt7925: add mt7925_mac_link_sta_remove to remove per-link STA
Date: Wed, 12 Jun 2024 20:02:38 -0700
Message-Id: <20240613030241.5771-45-sean.wang@kernel.org>
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

The mt7925_mac_link_sta_remove function currently removes the per-link STA.
We will extend this function when we implement the MLO functionality.

This patch only includes structural changes and does not involve any
logic changes.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 46 +++++++++++++------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index b159d26303ca..ce5379c4d55d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -805,39 +805,55 @@ void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_assoc);
 
-void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta)
+static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_link_sta *link_sta)
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
-	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct ieee80211_bss_conf *link_conf;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_sta *msta;
 
-	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
+	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
-	mt7925_mcu_sta_update(dev, &sta->deflink, vif, false, MT76_STA_INFO_STATE_NONE);
-	mt7925_mac_wtbl_update(dev, msta->deflink.wcid.idx,
+	mt7925_mcu_sta_update(dev, link_sta, vif, false,
+			      MT76_STA_INFO_STATE_NONE);
+	mt7925_mac_wtbl_update(dev, mlink->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
 
-	if (vif->type == NL80211_IFTYPE_STATION) {
+	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-
-		mvif->wep_sta = NULL;
-		ewma_rssi_init(&mvif->bss_conf.rssi);
-		if (!sta->tdls)
-			mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
-						link_conf, &sta->deflink, false);
+		mt7925_mcu_add_bss_info(&dev->phy,
+					mvif->bss_conf.mt76.ctx, link_conf,
+					link_sta, false);
 	}
 
 	spin_lock_bh(&mdev->sta_poll_lock);
-	if (!list_empty(&msta->deflink.wcid.poll_list))
-		list_del_init(&msta->deflink.wcid.poll_list);
+	if (!list_empty(&mlink->wcid.poll_list))
+		list_del_init(&mlink->wcid.poll_list);
 	spin_unlock_bh(&mdev->sta_poll_lock);
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
+
+void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
+{
+	mt7925_mac_link_sta_remove(mdev, vif, &sta->deflink);
+
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+		mvif->wep_sta = NULL;
+		ewma_rssi_init(&mvif->bss_conf.rssi);
+	}
+}
 EXPORT_SYMBOL_GPL(mt7925_mac_sta_remove);
 
 static int mt7925_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
-- 
2.34.1


