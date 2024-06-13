Return-Path: <linux-wireless+bounces-8913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0932190623D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5E81C21200
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559912CDBC;
	Thu, 13 Jun 2024 03:02:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A518028
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247776; cv=none; b=qCoa0eaK8TfD8ZfplG3cDZr3tJPpk8Jv7qzf2cXIwk+Y/+pskkgyb7kw9p7tE2vH1tDco3z9n2osVRDAf8j7E1C14K8x7fBfqW6pOm4SO0IJRUN9fbouVFJC933XrQpT1k7rLJEiHDjrTJsQxyhiBm5oxEU7KoYw08j9xXJSeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247776; c=relaxed/simple;
	bh=+TCZp3B3O6xA8eCnmYB9iXDzA0sqhxyarsjUp4q4gMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MiZ0jIChgdItfbfHlH6aGWTI49ZI0HE2kh8W8I7ClaNsew+6a39oHbIb92MYh3XhNNux+mfv7wE7m/DIsf6DXFmYKmQiHTNKI4ZrZnhTs+1+oiaa8lssQgwto4HCYKUvU06nZPWUBuwsTHIiYJDntfm3kv+CTFFoKvfiaFHwZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-250aa23752dso56614fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247774; x=1718852574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvb5AJFmYUTVY3+9AzIQTo1J8qEy+Vm/mbwCjCAQx2E=;
        b=O9ImI2RxAZAVj43akcbYEABWj6dMkUsxuz94TSRmnVJ+81LwXG9MBwCOgtfFJetibm
         N/WM7jL1nDZD9k+XmWhxlhq5UtGEAflBtgQiZuckhPdIsHaFqXAT4wY20hX3Y2fYC7IP
         sYEPLZcgQU/wfbmE6DX9nO4aq7jI+GLw81VrJwlYXGbhIWjZHyHAZhhcAWa4vr311369
         v76DBaOjYwagze6lHtOc9YmgPxtiUOYgvTfZYuT82yCDe/uBcCd0FTx2ujDGMBVpdyTW
         qOTltFBwji/d2A6DmBwezFZO1bZ2a8vTuzGbgqBDezsGp/5sscOmYsiFGH+FBKqUSwue
         qvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUa/5DyFrgMqkW4upr6JKQpJ8dnXiNKHORwhpk9kI0yb5Ay01vTUPSaaCw8emp0Uq2I90XWvB0AnoO9NPQvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3prDid9wYw36HasT79tNlqIbbxHW4N6G3R6bw5j8v4vDrJUI
	zMs4ynNjHoqZpnB7vOHKh0dQx/db1xuPqZX8JmctXTTV1J3lo8mD
X-Google-Smtp-Source: AGHT+IHzWVQJdCK0UMaB6vy18L88HksO71wTbhM59p53AnVFBNdYc8aDnqYc1k+Ee4AqA8mHWuc+ng==
X-Received: by 2002:a05:6820:2c86:b0:5aa:3e4f:f01e with SMTP id 006d021491bc7-5bb3b9c614cmr3867544eaf.1.1718247773727;
        Wed, 12 Jun 2024 20:02:53 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:02:51 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 03/47] wifi: mt76: mt792x: add struct mt792x_chanctx
Date: Wed, 12 Jun 2024 20:01:57 -0700
Message-Id: <20240613030241.5771-4-sean.wang@kernel.org>
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

From: Deren Wu <deren.wu@mediatek.com>

We are introducing a new structure, mt792x_chanctx, to quickly identify
the linked BSS it is working on. This eliminates the need to search in
mt7921_ctx_iter() or mt7925_ctx_iter() when the channel context changes.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 31 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 31 ++++++++-----------
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  4 +++
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  5 +++
 4 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3141807ec54b..89d47cce9e8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1346,32 +1346,27 @@ mt7921_remove_chanctx(struct ieee80211_hw *hw,
 {
 }
 
-static void mt7921_ctx_iter(void *priv, u8 *mac,
-			    struct ieee80211_vif *vif)
-{
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct ieee80211_chanctx_conf *ctx = priv;
-
-	if (ctx != mvif->bss_conf.mt76.ctx)
-		return;
-
-	if (vif->type == NL80211_IFTYPE_MONITOR)
-		mt7921_mcu_config_sniffer(mvif, ctx);
-	else
-		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
-}
-
 static void
 mt7921_change_chanctx(struct ieee80211_hw *hw,
 		      struct ieee80211_chanctx_conf *ctx,
 		      u32 changed)
 {
+	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct ieee80211_vif *vif;
+	struct mt792x_vif *mvif;
+
+	if (!mctx->bss_conf)
+		return;
+
+	mvif = container_of(mctx->bss_conf, struct mt792x_vif, bss_conf);
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
 
 	mt792x_mutex_acquire(phy->dev);
-	ieee80211_iterate_active_interfaces(phy->mt76->hw,
-					    IEEE80211_IFACE_ITER_ACTIVE,
-					    mt7921_ctx_iter, ctx);
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		mt7921_mcu_config_sniffer(mvif, ctx);
+	else
+		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
 	mt792x_mutex_release(phy->dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 504c2ecc3845..91edbe076c22 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1354,34 +1354,29 @@ mt7925_remove_chanctx(struct ieee80211_hw *hw,
 {
 }
 
-static void mt7925_ctx_iter(void *priv, u8 *mac,
-			    struct ieee80211_vif *vif)
+static void
+mt7925_change_chanctx(struct ieee80211_hw *hw,
+		      struct ieee80211_chanctx_conf *ctx,
+		      u32 changed)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct ieee80211_chanctx_conf *ctx = priv;
+	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct ieee80211_vif *vif;
+	struct mt792x_vif *mvif;
 
-	if (ctx != mvif->bss_conf.mt76.ctx)
+	if (!mctx->bss_conf)
 		return;
 
+	mvif = container_of(mctx->bss_conf, struct mt792x_vif, bss_conf);
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+
+	mt792x_mutex_acquire(phy->dev);
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
 		mt7925_mcu_set_sniffer(mvif->phy->dev, vif, true);
 		mt7925_mcu_config_sniffer(mvif, ctx);
 	} else {
 		mt7925_mcu_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76, ctx);
 	}
-}
-
-static void
-mt7925_change_chanctx(struct ieee80211_hw *hw,
-		      struct ieee80211_chanctx_conf *ctx,
-		      u32 changed)
-{
-	struct mt792x_phy *phy = mt792x_hw_phy(hw);
-
-	mt792x_mutex_acquire(phy->dev);
-	ieee80211_iterate_active_interfaces(phy->mt76->hw,
-					    IEEE80211_IFACE_ITER_ACTIVE,
-					    mt7925_ctx_iter, ctx);
 	mt792x_mutex_release(phy->dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index cb0bb06bef80..b5eb574e8548 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -100,6 +100,10 @@ struct mt792x_sta {
 
 DECLARE_EWMA(rssi, 10, 8);
 
+struct mt792x_chanctx {
+	struct mt792x_bss_conf *bss_conf;
+};
+
 struct mt792x_bss_conf {
 	struct mt76_vif mt76; /* must be first */
 	struct ewma_rssi rssi;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index ae21a2829c9c..a189ae38f2d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -261,11 +261,13 @@ int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
 			      struct ieee80211_bss_conf *link_conf,
 			      struct ieee80211_chanctx_conf *ctx)
 {
+	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
 	mvif->bss_conf.mt76.ctx = ctx;
+	mctx->bss_conf = &mvif->bss_conf;
 	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
@@ -277,10 +279,12 @@ void mt792x_unassign_vif_chanctx(struct ieee80211_hw *hw,
 				 struct ieee80211_bss_conf *link_conf,
 				 struct ieee80211_chanctx_conf *ctx)
 {
+	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
+	mctx->bss_conf = NULL;
 	mvif->bss_conf.mt76.ctx = NULL;
 	mutex_unlock(&dev->mt76.mutex);
 }
@@ -556,6 +560,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 
 	hw->sta_data_size = sizeof(struct mt792x_sta);
 	hw->vif_data_size = sizeof(struct mt792x_vif);
+	hw->chanctx_data_size = sizeof(struct mt792x_chanctx);
 
 	if (dev->fw_features & MT792x_FW_CAP_CNM) {
 		wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
-- 
2.34.1


