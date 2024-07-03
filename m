Return-Path: <linux-wireless+bounces-9962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C489C926AA3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23107B26245
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31707194159;
	Wed,  3 Jul 2024 21:43:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB281946D0
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043016; cv=none; b=rNIq0Fc0mbMhka8sXYRQzJ6O433cThyxDfnak2eEVnxEKr+o6c6UTxRXHPfHGWd6tVqqdkyCwOWZLgc3qvyE0x0DVNtVIjVk8cFcxWfd/4BlNtU4lGWdj/znTyfzhNTjhoYXfdRVF0LyGRks2pigDJpIGtqRne+hBhJlyhyMhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043016; c=relaxed/simple;
	bh=Ou+L2suKHd+wAVFlMzZ0GQFhFXdymWxbOC6vZOUviq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTna4dRrLKEeqkOnxUniZ3JihllKSBk5Bzo2UxKzRg2zyMan0X0MxfW3FBbJlNU270G62dogmooaimM1H0+u3UCqqdU9XkALz9HKIw56NaRV8knNXDfMxFEyfQqMApisFXklFj8gWdWxih9135z6AX/n0qx7O6ybLu4YzVtrd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d56754a4ceso4543b6e.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043014; x=1720647814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/u1Acf2UXke2/1kGXt/5Ovbf/IwEe45D/E6XFOOEDQ=;
        b=CWALsCmjpdyY1Tuz17i2IQ544ZeQyzy1Kpr1AtkxQjHs2jFj+SK+opjidfEMm9rAn0
         otangBB1LmJOZwy44QtXR30b8obvCsxXnpKheW+KVZk70e2OImYIX7CxjS+x9lUWc/NV
         jGPmwnGSyAHYL+PQZ4LkMEnl1q0whyZYhbL7roRDqCYkSuLnwxpH042l8ju7NmCC5Ygy
         BCvim71d62ym6eQletKNJJ9TH3yD0co6a5GcL16eRmSu2rtg3W6QpXtGkEkGPcJRTE14
         waRkAg1Mzo+n8/tao7a4AHQ3+ECAzsm4L2nrpjDcxIaiS1r6GeDobU4oj87JUIh3Ku3Y
         Cc0A==
X-Forwarded-Encrypted: i=1; AJvYcCVAnqOL8bEATdKb3aLgAT6blhYe1IOEWrAEIUqjNmzpHRq4IweWZR1LFH6oPDKQQWiKnLlA06BNoK+zNiHPp7GsVE3W9z1LgLMLcN1yYyM=
X-Gm-Message-State: AOJu0YwveXLacAv/cJ/S6ymU8sfLzsR5hqRHZo09QDCHWdzAl9+1eEs7
	WVxVOrIrCG1ogSZMr8ttjDSKMPXcZFFwzUyWzUPWl38ga81Pl11E
X-Google-Smtp-Source: AGHT+IGwBzpGzOI8UnmzyhZbE1IyHQCB/GWkLPI3zSldgtr6vXIrNvfGhEM715WnuXcqelbUbUaHDQ==
X-Received: by 2002:a05:6830:100d:b0:702:1e62:8698 with SMTP id 46e09a7af769-7021e629011mr7518817a34.0.1720043013632;
        Wed, 03 Jul 2024 14:43:33 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:32 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 22/29] wifi: mt76: mt7925: add mt7925_[assign,unassign]_vif_chanctx
Date: Wed,  3 Jul 2024 14:42:27 -0700
Message-Id: <1f856d6529a62f64be23e7c9fd5f255f1d9c0127.1720042294.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720042294.git.sean.wang@kernel.org>
References: <cover.1720042294.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

add mt7925_[assign,unassign]_vif_chanctx to assign and unassign
chanctx to the specific link configuration. If the chctx is not
pass in the parameter, we will look up the channel information
from link_conf->chanreq.oper.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 75 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 17 +++--
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  1 +
 3 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 339888086076..13b40032cd72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1698,8 +1698,13 @@ mt7925_change_chanctx(struct ieee80211_hw *hw,
 			mconf = &mvif->bss_conf;
 		}
 
-		if (mconf)
-			mt7925_mcu_set_chctx(mvif->phy->mt76, &mconf->mt76, ctx);
+		if (mconf) {
+			struct ieee80211_bss_conf *link_conf;
+
+			link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
+			mt7925_mcu_set_chctx(mvif->phy->mt76, &mconf->mt76,
+					     link_conf, ctx);
+		}
 	}
 	mt792x_mutex_release(phy->dev);
 }
@@ -1945,6 +1950,68 @@ mt7925_change_sta_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return err;
 }
 
+static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_bss_conf *link_conf,
+				     struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct ieee80211_bss_conf *pri_link_conf;
+	struct mt792x_bss_conf *mconf;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (ieee80211_vif_is_mld(vif)) {
+		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
+		pri_link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
+
+		if (vif->type == NL80211_IFTYPE_STATION &&
+		    mconf == &mvif->bss_conf)
+			mt7925_mcu_add_bss_info(&dev->phy, NULL, pri_link_conf,
+						NULL, true);
+	} else {
+		mconf = &mvif->bss_conf;
+	}
+
+	mconf->mt76.ctx = ctx;
+	mctx->bss_conf = &mvif->bss_conf;
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static void mt7925_unassign_vif_chanctx(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *link_conf,
+					struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt792x_chanctx *mctx = (struct mt792x_chanctx *)ctx->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct ieee80211_bss_conf *pri_link_conf;
+	struct mt792x_bss_conf *mconf;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (ieee80211_vif_is_mld(vif)) {
+		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
+		pri_link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
+
+		if (vif->type == NL80211_IFTYPE_STATION &&
+		    mconf == &mvif->bss_conf)
+			mt7925_mcu_add_bss_info(&dev->phy, NULL, pri_link_conf,
+						NULL, false);
+	} else {
+		mconf = &mvif->bss_conf;
+	}
+
+	mctx->bss_conf = NULL;
+	mconf->mt76.ctx = NULL;
+	mutex_unlock(&dev->mt76.mutex);
+}
+
 const struct ieee80211_ops mt7925_ops = {
 	.tx = mt792x_tx,
 	.start = mt7925_start,
@@ -1997,8 +2064,8 @@ const struct ieee80211_ops mt7925_ops = {
 	.add_chanctx = mt7925_add_chanctx,
 	.remove_chanctx = mt7925_remove_chanctx,
 	.change_chanctx = mt7925_change_chanctx,
-	.assign_vif_chanctx = mt792x_assign_vif_chanctx,
-	.unassign_vif_chanctx = mt792x_unassign_vif_chanctx,
+	.assign_vif_chanctx = mt7925_assign_vif_chanctx,
+	.unassign_vif_chanctx = mt7925_unassign_vif_chanctx,
 	.mgd_prepare_tx = mt7925_mgd_prepare_tx,
 	.mgd_complete_tx = mt7925_mgd_complete_tx,
 	.vif_cfg_changed = mt7925_vif_cfg_changed,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 75149baab7e5..3f0ceebed2f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2074,9 +2074,11 @@ mt7925_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
 
 static
 void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
+			    struct ieee80211_bss_conf *link_conf,
 			    struct ieee80211_chanctx_conf *ctx)
 {
-	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
+						  &link_conf->chanreq.oper;
 	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
 	enum nl80211_band band = chandef->chan->band;
 	struct bss_rlm_tlv *req;
@@ -2143,6 +2145,7 @@ __mt7925_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif *mvif, int len)
 }
 
 int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
+			 struct ieee80211_bss_conf *link_conf,
 			 struct ieee80211_chanctx_conf *ctx)
 {
 	struct sk_buff *skb;
@@ -2152,7 +2155,7 @@ int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt7925_mcu_bss_rlm_tlv(skb, phy, ctx);
+	mt7925_mcu_bss_rlm_tlv(skb, phy, link_conf, ctx);
 
 	return mt76_mcu_skb_send_msg(phy->dev, skb,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
@@ -2214,7 +2217,8 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 {
 	struct ieee80211_vif *vif = link_conf->vif;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
-	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
+						  &link_conf->chanreq.oper;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_connac_bss_basic_tlv *basic_req;
 	struct mt792x_link_sta *mlink;
@@ -2339,7 +2343,8 @@ mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 		       struct ieee80211_chanctx_conf *ctx,
 		       struct ieee80211_bss_conf *link_conf)
 {
-	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->mt76->chandef;
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
+						  &link_conf->chanreq.oper;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_vif *mvif = &mconf->mt76;
@@ -2479,8 +2484,6 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    int enable)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
-	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif,
-							   link_conf->link_id);
 	struct mt792x_dev *dev = phy->dev;
 	struct sk_buff *skb;
 
@@ -2504,7 +2507,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		mt7925_mcu_bss_color_tlv(skb, link_conf, enable);
 	}
 
-	mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, mconf->mt76.ctx);
+	mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, link_conf, ctx);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index fefb6ab384bb..f0b890ad43e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -623,6 +623,7 @@ int mt7925_mcu_set_deep_sleep(struct mt792x_dev *dev, bool enable);
 int mt7925_mcu_set_channel_domain(struct mt76_phy *phy);
 int mt7925_mcu_set_radio_en(struct mt792x_phy *phy, bool enable);
 int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
+			 struct ieee80211_bss_conf *link_conf,
 			 struct ieee80211_chanctx_conf *ctx);
 int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy);
 int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
-- 
2.25.1


