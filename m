Return-Path: <linux-wireless+bounces-10044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1209291E9
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12021C211DF
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200AE50284;
	Sat,  6 Jul 2024 08:29:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ECF50269
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254547; cv=none; b=PfaNlbID9KLLlUgT/ALAnHibkbe3y1VBLlzxP1Gp3eVVr+plMtWC7iyruzyjazpQJrfUxg6DMOal74zqk357LxpWw1JPHLcfM5ZrP/XXvRXPaLpOpNmmonVj9ZyTMKQrwBHv3DkOU3suZuwTYHHnaD7/0hYaUtNTypP6G6vG4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254547; c=relaxed/simple;
	bh=gdPTHpHiFE2DNSWwLGzXiaCbdCMfuHxhMwZdI2UPL08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OzC4N0VUC8z7FxB7tFlfiYe4MGr0hSIlX4ZwnAGLf27CD0VxmnVg3Sw4Adtp3jLUE4Xn6W6p2iQzC1ZiySRa4vwGWQhHVLmqxD3pFUZ2D/icY0gwRxXRhDCY5WJJFTN/ms87fLbD0hLIn4pW0Tjzwy5rFctZHBU5gy29MiHtaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25e23e0492dso341286fac.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254544; x=1720859344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qypwLl0mwyWHqK5nU8Jdk8GJ4MWZIRMXr/vMXZfeI4o=;
        b=kkWB51poUvR+52gFUho6oForKxSBFhPPLaQ4lKZkCN49Yfo6WAiSGotjlRq+LR8nNP
         mYTAWg+1oOnnB6TyPNl37IkPUvssQHw69SRjhT47FVz/n2cGaU4oO+FUzsPH0hNVoPBs
         vxNCwkYL2x+O/NRkdCaCKCPVmc02QHUWGkzJOH/ZkTxquIoGs5h9zfIdvKkBHZslBzTq
         lsCe9c5V59uhapbcVWJlbEX5HgyMpy6VHfiZNp6h+jEbXW+VELHy7CLsibTGfKY9erZq
         fi9BM/Onqik49P6JDPOrkA/AVw5vZ+Yhaxlo58hD3dLIzT1ia8r+NKNoclHs//7KbX7v
         3Umg==
X-Forwarded-Encrypted: i=1; AJvYcCWwDlixRaNya6LRMvekS9k5/3P/Du6Q//Bhbjydxawo3E1rl7TSgQYvsO/I9hHqK1KFYJJBMQr4Q/UbBMGh0YEdiqX+ZM67HZuhKNBL7R0=
X-Gm-Message-State: AOJu0Yz9azA7600yn45HgcZtBpdP/SdYu1GmUW3c9JJsdn/KYAMTeH5D
	YyMu32Vh1wRh/9yJcQX/Dmoeq+koxlJSwg1omOlAOyuv1OeB4WE4
X-Google-Smtp-Source: AGHT+IFAu8L9vVPgIY5YNB7KoDorB2YZHSKha+nUgCsbxCPIACTWoPEncAfPQH/TpDKqm/w6cbkeBg==
X-Received: by 2002:a05:6871:24d9:b0:254:affe:5a08 with SMTP id 586e51a60fabf-25e2ba1b287mr6407103fac.2.1720254544551;
        Sat, 06 Jul 2024 01:29:04 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:03 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 25/37] wifi: mt76: mt7925: add mt7925_[assign,unassign]_vif_chanctx
Date: Sat,  6 Jul 2024 01:28:05 -0700
Message-Id: <15261879a16cb12674d6dea7703410baa6883799.1720248331.git.sean.wang@kernel.org>
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
index dabfb8eca686..44d9da5aadd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1730,8 +1730,13 @@ mt7925_change_chanctx(struct ieee80211_hw *hw,
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
@@ -1978,6 +1983,68 @@ mt7925_change_sta_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
+	mctx->bss_conf = mconf;
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
@@ -2030,8 +2097,8 @@ const struct ieee80211_ops mt7925_ops = {
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
index 3d5eaeb96047..5979e47ec142 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2083,9 +2083,11 @@ mt7925_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
 
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
@@ -2152,6 +2154,7 @@ __mt7925_mcu_alloc_bss_req(struct mt76_dev *dev, struct mt76_vif *mvif, int len)
 }
 
 int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
+			 struct ieee80211_bss_conf *link_conf,
 			 struct ieee80211_chanctx_conf *ctx)
 {
 	struct sk_buff *skb;
@@ -2161,7 +2164,7 @@ int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt7925_mcu_bss_rlm_tlv(skb, phy, ctx);
+	mt7925_mcu_bss_rlm_tlv(skb, phy, link_conf, ctx);
 
 	return mt76_mcu_skb_send_msg(phy->dev, skb,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
@@ -2223,7 +2226,8 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 {
 	struct ieee80211_vif *vif = link_conf->vif;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
-	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
+						  &link_conf->chanreq.oper;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_connac_bss_basic_tlv *basic_req;
 	struct mt792x_link_sta *mlink;
@@ -2348,7 +2352,8 @@ mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 		       struct ieee80211_chanctx_conf *ctx,
 		       struct ieee80211_bss_conf *link_conf)
 {
-	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->mt76->chandef;
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def :
+						  &link_conf->chanreq.oper;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_vif *mvif = &mconf->mt76;
@@ -2488,8 +2493,6 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    int enable)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
-	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif,
-							   link_conf->link_id);
 	struct mt792x_dev *dev = phy->dev;
 	struct sk_buff *skb;
 
@@ -2513,7 +2516,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		mt7925_mcu_bss_color_tlv(skb, link_conf, enable);
 	}
 
-	mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, mconf->mt76.ctx);
+	mt7925_mcu_bss_rlm_tlv(skb, phy->mt76, link_conf, ctx);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 7fb46cad9157..6ae5286385d9 100644
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


