Return-Path: <linux-wireless+bounces-10024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3149291D5
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB5E1F21E52
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE8C46B91;
	Sat,  6 Jul 2024 08:28:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8F46556
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254513; cv=none; b=TL6YcD+N4eIxif71jpVSycDsbn5VdTvD03xQnme1nWeGu4WHTftApWCgk9jPWrUm9otf8KyzWN8B+MhgsUQxm5xOxecpAQ5sCboyV6SG81K07QwyqSjb09hY9ztxpsNZr7yIAlHG0xIqgNz/wvSMWngJ/GR+h5GSjCmOd81Dr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254513; c=relaxed/simple;
	bh=aQIiKbepJz6b/ITgp6lpJbWpkUslyBBOhHSwmkI5VEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ipWNgUv8UVDB3uAcftVl0N+6pyhlFY3cT5O504L9k/diqoIVZezV2wd5pb2mC5tCRPkSPfUZ6dyum0H+0/lVciassHPmMU539F6f12nEDLD/w3iVQyO8Ysbvmbwj0nRFon0UYzwTiRwmEIe1KnkEjQ4mtXSfb5KiksUJoy4G7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25075f3f472so367173fac.2
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254510; x=1720859310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1Y0KCWfIIgPouNmUpNwTith6gb3NivXxQnRCB1BWZk=;
        b=qg1cBoKnzawumdwAg09QOAz9znKyXm0YtCu5yEXRiMAcp1i5Lt5bJtqPdKzpoPGAiL
         5dOGeYi1ve2Glow7yGXKtpH1c7R1z8C/PrJ7DSIikULvV9eD0mFf8D7q80hvNZnjPo2M
         fEFpWFxhSCNM+10O9oMznPr6AP9BP0XXbKgm4ejBVtc4rkqyWLnUOFJpm8VTO+1+lRo8
         9CdyJQMgz5GNok04GkAFzo0+VmVgZoxpbUNCdS6AOobDewP+kf1Eg2NLJ0IBRpkXpd+A
         aLkhvUTYKYsv3T741hkbFjlv/1il8cu5PhA9Q+eQEiRilDL8Wd4UuA0RYhy7TbPmXHfq
         EhYg==
X-Forwarded-Encrypted: i=1; AJvYcCX+Y1sxu1KaQ2HUWW7t2ROTvUGmHU8mdMzRaeajcFWZl0Te43wnMguGG1n6uVYUlsgECB18/CcZdIJDnjhrGYgo9n8AtS1JB7+4vNKBrcM=
X-Gm-Message-State: AOJu0YysUlFo207dB7m3Zv7RMkPadOTkP3hw85PQkPMm8laTSucKZH+Y
	6www7hvg36da4ip9REJ0DSFDs1cTR/0JwpdsgRk5dYyU9ObQFfhE
X-Google-Smtp-Source: AGHT+IEQuqBNE4O9ygl1LhpCjiqP0kPykNMCGmW8fwh6NKVKSgPtHgb2U6ilu63Gjl43/x4WYAQ26A==
X-Received: by 2002:a05:6870:5590:b0:25e:1817:e4a8 with SMTP id 586e51a60fabf-25e2bf93ebcmr7013356fac.4.1720254509830;
        Sat, 06 Jul 2024 01:28:29 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:28 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 05/37] wifi: mt76: mt7925: add mt7925_set_link_key
Date: Sat,  6 Jul 2024 01:27:45 -0700
Message-Id: <e8cd7d37484be238a4eb9e500ef2b8aa46e43667.1720248331.git.sean.wang@kernel.org>
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

add mt7925_set_link_key to set up the key according to the link id

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 70 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 25 ++++---
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  3 +-
 3 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 59b1e920bb4a..7c7452729710 100644
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
@@ -547,13 +544,11 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		return -EOPNOTSUPP;
 	}
 
-	mt792x_mutex_acquire(dev);
-
-	if (cmd == SET_KEY && !mvif->bss_conf.mt76.cipher) {
+	if (cmd == SET_KEY && !mconf->mt76.cipher) {
 		struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
-		mvif->bss_conf.mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
-		mt7925_mcu_add_bss_info(phy, mvif->bss_conf.mt76.ctx, link_conf,
+		mconf->mt76.cipher = mt7925_mcu_get_cipher(key->cipher);
+		mt7925_mcu_add_bss_info(phy, mconf->mt76.ctx, link_conf,
 					link_sta, true);
 	}
 
@@ -567,9 +562,9 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	mt76_wcid_key_setup(&dev->mt76, wcid,
 			    cmd == SET_KEY ? key : NULL);
 
-	err = mt7925_mcu_add_key(&dev->mt76, vif, &msta->deflink.bip,
+	err = mt7925_mcu_add_key(&dev->mt76, vif, &mlink->bip,
 				 key, MCU_UNI_CMD(STA_REC_UPDATE),
-				 &msta->deflink.wcid, cmd);
+				 &mlink->wcid, cmd, msta);
 
 	if (err)
 		goto out;
@@ -578,9 +573,32 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    key->cipher == WLAN_CIPHER_SUITE_WEP40)
 		err = mt7925_mcu_add_key(&dev->mt76, vif, &mvif->wep_sta->deflink.bip,
 					 key, MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
-					 &mvif->wep_sta->deflink.wcid, cmd);
-
+					 &mvif->wep_sta->deflink.wcid, cmd, msta);
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index ba91c8e37dff..1db81cf4d71d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -961,13 +961,12 @@ mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 		       struct mt76_connac_sta_key_conf *sta_key_conf,
 		       struct sk_buff *skb,
 		       struct ieee80211_key_conf *key,
-		       enum set_key_cmd cmd)
+		       enum set_key_cmd cmd,
+		       struct mt792x_sta *msta)
 {
-	struct mt792x_link_sta *mlink = container_of(wcid, struct mt792x_link_sta, wcid);
-	struct mt792x_sta *msta = container_of(mlink, struct mt792x_sta, deflink);
-	struct sta_rec_sec_uni *sec;
 	struct mt792x_vif *mvif = msta->vif;
 	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif, wcid->link_id);
+	struct sta_rec_sec_uni *sec;
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 	struct tlv *tlv;
@@ -990,12 +989,16 @@ mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 		sec->tx_key = 1;
 		sec->key_type = 1;
 		link_sta = mt792x_sta_to_link_sta(vif, sta, wcid->link_id);
-		memcpy(sec->peer_addr, link_sta->addr, ETH_ALEN);
+
+		if (link_sta)
+			memcpy(sec->peer_addr, link_sta->addr, ETH_ALEN);
 	} else {
 		struct ieee80211_bss_conf *link_conf;
 
 		link_conf = mt792x_vif_to_bss_conf(vif, wcid->link_id);
-		memcpy(sec->peer_addr, link_conf->bssid, ETH_ALEN);
+
+		if (link_conf)
+			memcpy(sec->peer_addr, link_conf->bssid, ETH_ALEN);
 	}
 
 	if (cmd == SET_KEY) {
@@ -1040,18 +1043,20 @@ mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		       struct mt76_connac_sta_key_conf *sta_key_conf,
 		       struct ieee80211_key_conf *key, int mcu_cmd,
-		       struct mt76_wcid *wcid, enum set_key_cmd cmd)
+		       struct mt76_wcid *wcid, enum set_key_cmd cmd,
+		       struct mt792x_sta *msta)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif, wcid->link_id);
 	struct sk_buff *skb;
 	int ret;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid,
+	skb = __mt76_connac_mcu_alloc_sta_req(dev, &mconf->mt76, wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	ret = mt7925_mcu_sta_key_tlv(wcid, sta_key_conf, skb, key, cmd);
+	ret = mt7925_mcu_sta_key_tlv(wcid, sta_key_conf, skb, key, cmd, msta);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 8ec5a3a20202..7750049c42f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -304,7 +304,8 @@ int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		       struct mt76_connac_sta_key_conf *sta_key_conf,
 		       struct ieee80211_key_conf *key, int mcu_cmd,
-		       struct mt76_wcid *wcid, enum set_key_cmd cmd);
+		       struct mt76_wcid *wcid, enum set_key_cmd cmd,
+		       struct mt792x_sta *msta);
 int mt7925_mcu_set_rts_thresh(struct mt792x_phy *phy, u32 val);
 int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 				     struct ieee80211_vif *vif,
-- 
2.25.1


