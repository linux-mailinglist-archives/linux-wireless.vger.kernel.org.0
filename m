Return-Path: <linux-wireless+bounces-9945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9F3926A8F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18E71C20E98
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4337619309C;
	Wed,  3 Jul 2024 21:43:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA2D191F8E
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042983; cv=none; b=r7l8UWu7Xf8827OaeLvf94Qfgv5jr3n50Pd1UILOum+VKkFW2PGG+u9LRORWd2/+59QevC3Oavj5z9EQPv8zqhhe6MSBa8UBZOGIev8gK9S9NDQHBrFAXox06/zq3+vfJ/kanB6L4l7TgKA4bdZVL9cwRfl/K3lnW47yjk1cE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042983; c=relaxed/simple;
	bh=fZ+q4k6EtyTiCawLAsLQ7QOu69VREGmdTk46T5kSjPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSHm+QwTRTHEkhmjUnmK23sc6mdfrWlcbdqYp3TBSd/bIAwDHQSA8LYv+MVKm53yYH74wl/M3IZeSbKxI1SramvfTyj6SSFp/e+c8qDGOh205lBNdhoialoi0lQRpCzj3KpY7Vbf5myKCuyE9MuZdy6nhzpwOxupBFdhSqoIdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-700cd6afa3eso204787a34.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042981; x=1720647781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7PGupETUQJAUNPNhJLXB9UGMjXfuQAyAWBEVi1wM2c=;
        b=dWAgxzLnttu1hnlz6Mw6yBGSy/EXgVzfYqwct4O73/JPJgpSea3+miMInZqsA+nlhs
         44WwUPb9v8JvxHEHwU8Oi43rMGWUuOL1qjF12TNu2NwB9jwUsnVJA45+Jbzku6I9IUbx
         +LbVwbFa3Nhmrqai+613SWSl2soSaQrOAfsEw/NHckhGXxZyodH3eWHhySyxDyLFSQpg
         qbGytLPGYw2whVMxIPj9Ann77rWppM9e57oqVM6xkv6DXdsTBNbHwePro2/CQa9CZQ3f
         ozvT365n+FGBE1txiNauBUhmdIwSyX6cyth2Ga6wwKR5VOHZBYJIP9WAMyF6eDPcZyVB
         Fm/A==
X-Forwarded-Encrypted: i=1; AJvYcCV35KrdjZNpkzmEhjMnmMTKr4uT36h0/+X7nnZ8fFSX8RSY+8xI+Yyrg9Ln8NPzlA9fHROdOmCtaIluBXYi5m6xX8QFZYxS3gdnLubHBbk=
X-Gm-Message-State: AOJu0YzyjaMcEJtqeqJu+HmxLw6cI6B4EQhLB7yIWC+L0uJKC+Y92xmx
	/WIc0Y6qiKRM3VlBedlnCY0Nh5sAgW1nHFQZ5nSPQuJw0Liu4a2lCIPEbGF4
X-Google-Smtp-Source: AGHT+IFs8z5tFdp9iaiINsY/W0pW70iwOppFb6clHGmnsTdd61oxtC5rmZXGAMjMJWq4P01yGijDAg==
X-Received: by 2002:a9d:5c89:0:b0:701:f366:71d7 with SMTP id 46e09a7af769-7020767ab30mr12877316a34.1.1720042980638;
        Wed, 03 Jul 2024 14:43:00 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:42:59 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 05/29] wifi: mt76: mt7925: add mt7925_set_link_key
Date: Wed,  3 Jul 2024 14:42:10 -0700
Message-Id: <6526aeab0d71104fff8453e086f8afe0d5eec70c.1720042294.git.sean.wang@kernel.org>
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

add mt7925_set_link_key to set up the key according to the link id

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 66 ++++++++++++-------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 0b486afe9352..264517fd3bf7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -499,31 +499,28 @@ static int mt7925_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	return mt7925_abort_roc(phy, &mvif->bss_conf);
 }
 
-static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
-			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
-			  struct ieee80211_key_conf *key)
+static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			       struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			       struct ieee80211_key_conf *key, int link_id)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
 				  &mvif->sta;
-	struct ieee80211_link_sta *link_sta = sta ? &sta->deflink : NULL;
-	struct mt76_wcid *wcid = &msta->deflink.wcid;
 	struct ieee80211_bss_conf *link_conf;
-	u8 *wcid_keyidx = &wcid->hw_key_idx;
+	struct ieee80211_link_sta *link_sta;
 	int idx = key->keyidx, err = 0;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_bss_conf *mconf;
+	struct mt76_wcid *wcid;
+	u8 *wcid_keyidx;
 
-	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
-
-	/* The hardware does not support per-STA RX GTK, fallback
-	 * to software mode for these.
-	 */
-	if ((vif->type == NL80211_IFTYPE_ADHOC ||
-	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
-	    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
-	     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
-	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
-		return -EOPNOTSUPP;
+	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+	link_sta = sta ? mt792x_sta_to_link_sta(vif, sta, link_id) : NULL;
+	mconf = mt792x_vif_to_link(mvif, link_id);
+	mlink = mt792x_sta_to_link(msta, link_id);
+	wcid = &mlink->wcid;
+	wcid_keyidx = &wcid->hw_key_idx;
 
 	/* fall back to sw encryption for unsupported ciphers */
 	switch (key->cipher) {
@@ -547,12 +544,10 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return -EOPNOTSUPP;
 	}
 
-	mt792x_mutex_acquire(dev);
-
-	if (cmd == SET_KEY && !mvif->bss_conf.mt76.cipher) {
+	if (cmd == SET_KEY && !mconf->mt76.cipher) {
 		struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
-		mvif->bss_conf.mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
+		mconf->mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
 		mt7925_mcu_add_bss_info(phy, mvif->bss_conf.mt76.ctx, link_conf,
 					link_sta, true);
 	}
@@ -567,9 +562,9 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	mt76_wcid_key_setup(&dev->mt76, wcid,
 			    cmd == SET_KEY ? key : NULL);
 
-	err = mt7925_mcu_add_key(&dev->mt76, vif, &msta->deflink.bip,
+	err = mt7925_mcu_add_key(&dev->mt76, vif, &mlink->bip,
 				 key, MCU_UNI_CMD(STA_REC_UPDATE),
-				 &msta->deflink.wcid, cmd);
+				 &mlink->wcid, cmd);
 
 	if (err)
 		goto out;
@@ -579,8 +574,31 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		err = mt7925_mcu_add_key(&dev->mt76, vif, &mvif->wep_sta->deflink.bip,
 					 key, MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
 					 &mvif->wep_sta->deflink.wcid, cmd);
-
 out:
+	return err;
+}
+
+static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err;
+
+	/* The hardware does not support per-STA RX GTK, fallback
+	 * to software mode for these.
+	 */
+	if ((vif->type == NL80211_IFTYPE_ADHOC ||
+	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
+	    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
+	     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
+	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		return -EOPNOTSUPP;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt7925_set_link_key(hw, cmd, vif, sta, key, vif->bss_conf.link_id);
+
 	mt792x_mutex_release(dev);
 
 	return err;
-- 
2.25.1


