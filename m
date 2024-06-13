Return-Path: <linux-wireless+bounces-8956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB13906268
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E89128456A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C1312D74B;
	Thu, 13 Jun 2024 03:04:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126913328E
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247862; cv=none; b=Vf5kJJGvS43Jxs8XhIgOK9xoEfecNJCEjLCFCcQroPV1b7hJdu1Q4ih+IVzw5gIR+kJTKeP0wx8Hat5V11NWfsDDbPTERvz6lyRr/hwhNjjyQ9KFCcZgtPWh0vZ4GGOYOZf1y99SG4/jWst76knNhveJjREkUMgqr/T8AY7FAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247862; c=relaxed/simple;
	bh=wNzCezZcC0hGKltgPFPRnaGVvcaTwPcC0hILtKXWoaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HffpFy84hVBH5z3TYbZ3phCPbYai4MGXbRmuDByRYhSwSOPFaoolGTAR/7eM1P3h0twU1wJeDoNv6bBx9AqtenGUPINAt8r1UOP2N2LrPVkChFbGIHq6/4qjpqOlpiRRq4ypDwz7/LZaaZYE2CV2a/Yu9iWNlcf0WEH/KGmKdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-254976d3327so77808fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247860; x=1718852660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qyCpY+byuISWjWQLZo5DP4pBOanX+F+FMRDfBJvu2s=;
        b=i8FbM7aaoCZtkNHCjVFDw/CdW2+1On5IA+9c5W7YSJ7ZEkgW7xTFMUDnntLYMCJSzm
         bD9aa6rb4PNDmLzjt/TuMO1go4ide6gnPPYcXAtCRhIoH7zE3f7XTT2MveZqLR/JR01/
         91IYKycBp3PMsPPJFDemee72iTyw9mggLuJpdC+tfWKez8RT2ogubL4lMiT+hzcXWWTN
         2UlCZpuNKX6KDrFDf1qKSxRy9KsV6AkiVILOXiOOeN0yZLD1rUJgRIA69HEGkOAToW8p
         GXnpHqLGBoieZYvk4YIZJLvQVSHBCLRzgw+Ym38x81u2zh84us9VTu1+Tv/ZlW0if/MD
         usTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLD3Mg/N3QR8W3xpp7E9AwjoTWPwdOReDxXM5ink77yr5hSBgL+AvmYy5OmLTAyFr3ZXJCmmx1Wl5lMxAADA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9cSGVDhUNWpcEyfmuc6nSntbVsYTsLl9phJgEcTLsbVfOXW8u
	mcJsm3Tc+0FuOp37qVYzZjVXxCEbesDZf2r0cv70HNenfk/gkR6EU7m/uih4M6U=
X-Google-Smtp-Source: AGHT+IESQ2jcgtgOmUDbQXdFBlFmVcT8fDwRZIVNyrs0Ci4sQ97lOJGCN79nGkpTnuurIm5NCcT95g==
X-Received: by 2002:a4a:d196:0:b0:5bd:87a0:66d with SMTP id 006d021491bc7-5bd87a01b93mr287315eaf.1.1718247859993;
        Wed, 12 Jun 2024 20:04:19 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:04:18 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 46/47] wifi: mt76: mt7925: add mt7925_mac_link_bss_remove to remove per-link BSS
Date: Wed, 12 Jun 2024 20:02:40 -0700
Message-Id: <20240613030241.5771-47-sean.wang@kernel.org>
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

The mt7925_mac_link_bss_remove function currently removes the per-link BSS.
We will extend this function when we implement the MLO functionality.

This patch only includes structural changes and does not involve any
logic changes.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 35 +++++++++++--------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 222204916b73..bec2c1eb5240 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -113,31 +113,38 @@ void mt792x_stop(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL_GPL(mt792x_stop);
 
-void mt792x_remove_interface(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif)
+static void mt792x_mac_link_bss_remove(struct mt792x_dev *dev,
+				       struct ieee80211_bss_conf *link_conf,
+				       struct mt792x_link_sta *mlink)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_sta *msta = &mvif->sta;
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt792x_phy *phy = mt792x_hw_phy(hw);
-	int idx = msta->deflink.wcid.idx;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	int idx = mlink->wcid.idx;
 
 	mt792x_mutex_acquire(dev);
-	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, &vif->bss_conf, &mvif->sta.deflink.wcid, false);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mlink->wcid, false);
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	dev->mt76.vif_mask &= ~BIT_ULL(mvif->bss_conf.mt76.idx);
-	phy->omac_mask &= ~BIT_ULL(mvif->bss_conf.mt76.omac_idx);
+	dev->mt76.vif_mask &= ~BIT_ULL(mconf->mt76.idx);
+	mconf->vif->phy->omac_mask &= ~BIT_ULL(mconf->mt76.omac_idx);
 	mt792x_mutex_release(dev);
 
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (!list_empty(&msta->deflink.wcid.poll_list))
-		list_del_init(&msta->deflink.wcid.poll_list);
+	if (!list_empty(&mlink->wcid.poll_list))
+		list_del_init(&mlink->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	mt76_wcid_cleanup(&dev->mt76, &msta->deflink.wcid);
+	mt76_wcid_cleanup(&dev->mt76, &mlink->wcid);
+}
+
+void mt792x_remove_interface(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mt792x_mac_link_bss_remove(dev, &vif->bss_conf, &mvif->sta.deflink);
 }
 EXPORT_SYMBOL_GPL(mt792x_remove_interface);
 
-- 
2.34.1


