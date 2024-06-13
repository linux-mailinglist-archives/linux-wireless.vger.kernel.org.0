Return-Path: <linux-wireless+bounces-8917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D08D906241
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5131F21225
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9DE12D762;
	Thu, 13 Jun 2024 03:03:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D412DDAF
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247785; cv=none; b=F+VthvDzunbb5R6JHwhSNnvck5g291BN1uHjWTbUd/Q9gXIUZSPPr1MRyNywo4Sw7a7zyOuZVeknMHgdVaI9N1bx4cglw4Ud4TUmGiR0iMKsIjFcm/MbSZ1nG06r7h5pTGi+OCNu7svv18prA+8eylVVugq+MLQkAMYPp8w6WA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247785; c=relaxed/simple;
	bh=f0Yj9Qav+gS/rUjYbDo1fVvj7IJEiDmnA7A/e9xJ3QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ym8IDUWS5v+EXG0RbaZRJOu8FAvq2JGGCXSMO/fACF2iwVUmYMS9SAyjpqN3EH7tUDXbQTT2YcvxUqePMxupAuJlH+7c5ZH48WxZ950Plh+lpujWaMtxlXdu0fNM/oE1d2YBzuBzqsB11CS6YoHUCmZ3Vb3xpeEaDMunxMKV0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5bb33237b60so22127eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247783; x=1718852583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGyztoV59eBgCzUwmK/mPi8RZNmVgI7WAXgbEweQmNE=;
        b=bFCAs5dahkSmqwZcPgmhfpzIieUor7QKflPttt5ANCKvxjDnZy3Kuo6RvrJjzJUYCs
         Osjkp5qVVZNxQ76U/SRH/kqh0LYFTkyS+fEwyEsHUjQW2cZAXmdwaRVkl5GPw9dhwQrc
         iwpQGGTnmcbONS0NYvWu9AUdh4kLk1daVDvBF57jHlOwAHOEffGOOJMdsgebPtBWUPCi
         ks9imtEuEWcF4giN6XM+a5GYRFrfD9dvENjkcQr9MAT/BTse8YDNYaZbU6G9cnVA5CMV
         ti9KGsXTmjQpBhlPcnYXxdQHzrzpxC6LA4yGU79/5tcmpMaYoO9GkRfrdvjv/P4ijVB7
         TH0g==
X-Forwarded-Encrypted: i=1; AJvYcCX+o0E1sAqaxDOGpm/LFEe5CS+QmANYLe+Usv8qb+dGvqzsuFvDgV3ELu9eDcp7P57jLGB5zgh5Zs1irnW4ODoKpg2+62vkQdkTvQqMeSQ=
X-Gm-Message-State: AOJu0YysxYS/GairB35gNQ8i3BC6Gt2OTqUssrr0//pggASZAkQbxFIS
	0egGPbClDZkAof9cBLGDATZ+KNCmvbRZ+gREQckJ+NikL/jVjII8
X-Google-Smtp-Source: AGHT+IFrMv3xLHoSpDVd44dAULyXTz2vPfVhq0zPat0nnHQtgJfz3ZUt37AbIegOho4HaYLardyU/g==
X-Received: by 2002:a4a:a5ca:0:b0:5ba:e11d:a2ae with SMTP id 006d021491bc7-5bb3b9f4ef7mr3670975eaf.1.1718247782656;
        Wed, 12 Jun 2024 20:03:02 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:01 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 07/47] wifi: mt76: mt7925: extend mt7925_mcu_add_bss_info for per-link BSS
Date: Wed, 12 Jun 2024 20:02:01 -0700
Message-Id: <20240613030241.5771-8-sean.wang@kernel.org>
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

Extend mt7925_mcu_add_bss_info with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 35 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 22 ++++++------
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   | 10 ++++++
 4 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index d11919688bae..7b9deb586b34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -487,9 +487,12 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
 				  &mvif->sta;
 	struct mt76_wcid *wcid = &msta->deflink.wcid;
+	struct ieee80211_bss_conf *link_conf;
 	u8 *wcid_keyidx = &wcid->hw_key_idx;
 	int idx = key->keyidx, err = 0;
 
+	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+
 	/* The hardware does not support per-STA RX GTK, fallback
 	 * to software mode for these.
 	 */
@@ -528,7 +531,8 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
 		mvif->bss_conf.mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
-		mt7925_mcu_add_bss_info(phy, mvif->bss_conf.mt76.ctx, vif, sta, true);
+		mt7925_mcu_add_bss_info(phy, mvif->bss_conf.mt76.ctx, link_conf,
+					sta, true);
 	}
 
 	if (cmd == SET_KEY)
@@ -701,6 +705,7 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_bss_conf *link_conf;
 	int ret, idx;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
@@ -725,10 +730,12 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
+	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
-		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, vif, sta,
-					false);
+		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
+					link_conf, sta, false);
 
 	ret = mt7925_mcu_sta_update(dev, sta, vif, true,
 				    MT76_STA_INFO_STATE_NONE);
@@ -747,12 +754,15 @@ void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_bss_conf *link_conf;
 
 	mt792x_mutex_acquire(dev);
 
+	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
-		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, vif, sta,
-					true);
+		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
+					link_conf, sta, true);
 
 	ewma_avg_signal_init(&msta->deflink.avg_ack_signal);
 
@@ -771,6 +781,7 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct ieee80211_bss_conf *link_conf;
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
@@ -779,14 +790,16 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7925_mac_wtbl_update(dev, msta->deflink.wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
+	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
 		mvif->wep_sta = NULL;
 		ewma_rssi_init(&mvif->bss_conf.rssi);
 		if (!sta->tdls)
-			mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, vif, sta,
-						false);
+			mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
+						link_conf, sta, false);
 	}
 
 	spin_lock_bh(&mdev->sta_poll_lock);
@@ -1244,8 +1257,8 @@ mt7925_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mt792x_mutex_acquire(dev);
 
-	err = mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, vif, NULL,
-				      true);
+	err = mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
+				      link_conf, NULL, true);
 	if (err)
 		goto out;
 
@@ -1275,8 +1288,8 @@ mt7925_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (err)
 		goto out;
 
-	mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, vif, NULL,
-				false);
+	mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx, link_conf,
+				NULL, false);
 
 out:
 	mt792x_mutex_release(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 1c262a024dc8..fb261ee525be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2315,11 +2315,11 @@ int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
-			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
 			    struct ieee80211_sta *sta,
 			    int enable)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
 	struct mt792x_dev *dev = phy->dev;
 	struct sk_buff *skb;
 	int err;
@@ -2330,18 +2330,18 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 		return PTR_ERR(skb);
 
 	/* bss_basic must be first */
-	mt7925_mcu_bss_basic_tlv(skb, vif, sta, ctx, phy->mt76,
+	mt7925_mcu_bss_basic_tlv(skb, link_conf->vif, sta, ctx, phy->mt76,
 				 mvif->sta.deflink.wcid.idx, enable);
-	mt7925_mcu_bss_sec_tlv(skb, vif);
+	mt7925_mcu_bss_sec_tlv(skb, link_conf->vif);
 
-	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, vif, sta);
-	mt7925_mcu_bss_qos_tlv(skb, vif);
-	mt7925_mcu_bss_mld_tlv(skb, vif, sta);
-	mt7925_mcu_bss_ifs_tlv(skb, vif);
+	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf->vif, sta);
+	mt7925_mcu_bss_qos_tlv(skb, link_conf->vif);
+	mt7925_mcu_bss_mld_tlv(skb, link_conf->vif, sta);
+	mt7925_mcu_bss_ifs_tlv(skb, link_conf->vif);
 
-	if (vif->bss_conf.he_support) {
-		mt7925_mcu_bss_he_tlv(skb, vif, phy);
-		mt7925_mcu_bss_color_tlv(skb, vif, enable);
+	if (link_conf->he_support) {
+		mt7925_mcu_bss_he_tlv(skb, link_conf->vif, phy);
+		mt7925_mcu_bss_color_tlv(skb, link_conf->vif, enable);
 	}
 
 	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index b499b1d0531a..c692996e057c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -578,7 +578,7 @@ int mt7925_mcu_sched_scan_enable(struct mt76_phy *phy,
 				 bool enable);
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
-			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
 			    struct ieee80211_sta *sta,
 			    int enable);
 int mt7925_mcu_set_timing(struct mt792x_phy *phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 4a7526322c30..f675709f419a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -244,6 +244,16 @@ mt792x_link_conf_to_mconf(struct ieee80211_bss_conf *link_conf)
 	return mt792x_vif_to_link(mvif, link_conf->link_id);
 }
 
+static inline struct ieee80211_bss_conf *
+mt792x_vif_to_bss_conf(struct ieee80211_vif *vif, unsigned int link_id)
+{
+	if (!ieee80211_vif_is_mld(vif) ||
+	    link_id >= IEEE80211_LINK_UNSPECIFIED)
+		return &vif->bss_conf;
+
+	return link_conf_dereference_protected(vif, link_id);
+}
+
 static inline struct mt792x_dev *
 mt792x_hw_dev(struct ieee80211_hw *hw)
 {
-- 
2.34.1


