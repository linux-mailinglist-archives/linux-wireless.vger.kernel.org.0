Return-Path: <linux-wireless+bounces-19443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A103EA45193
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 01:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2533A8283
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 00:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549F813B293;
	Wed, 26 Feb 2025 00:36:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2B3B19A;
	Wed, 26 Feb 2025 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530196; cv=none; b=SF/kbcU2ZR2b2oLL8u0bVp0n5nUvRlB1JXHEOUkKhIH/i13OThfkEPTEETvAUII5iPrlvZN1n0QJWN3fkTJg4BnXiKktFr/+UB4nyX5p2YC8fN96l8swovlZ+aTjLXquEy/ivP1d4xg+n+I6f/ZDAtSvh6r8lS9vXXZ8vHDieU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530196; c=relaxed/simple;
	bh=dme1SMkQpm8xduaZuOWMLTfrU+fLPDYjwc/DmDcjZQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=um2YT5VPM6BVqwcqC1bmuB0tbqCzi9kkScq/fuejSD9A6Bq9edmL1BmQTa267sawLiLD9IIz/2lcG844TSIp6KXHOKGMpRMrF8dgaHWg4csa/leogqR/F/iYXXc6k0up4yhbH1MYGCyiDQf1UUBP0PHYPjgWDGh7kyQMk3Sb3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2b8f09669bdso1314728fac.0;
        Tue, 25 Feb 2025 16:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530193; x=1741134993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1XBpgqtT7Jisq7gLwkmRDRZc9Mx4bguTuo9qD7Avjc=;
        b=EsRHLlyDjr+wPSX8ce9haLnDhYYwG7ELJQ47fY9Fdg3HwNDkOO4F2TDbW8EH7WWgZw
         3iCVEYeBY903l4OzQLLaDgf0e/s5y8O5Qht2ujtXxwobk9TXz5lkIi6Whn/BxH8O8F7F
         0XB9m3X27YgXZPoOoZAJL5LUND9pNSkl8Nbw16zgk/0M6L4NHyEOl4TXdLgMvG/FqykC
         h0mSOn7gt19VUI+eUKIgy+OZ8DONObGWdu9uZeuRGlnnGbjvGPyL3Ld0x6nkppblvfPt
         PjhAUrMgiQp7wS2/N/8LsQPY4KYXjN4rIvqXuMa5DCWYMlxFiYvZ4dZODhh+w2HoKwTz
         XshA==
X-Forwarded-Encrypted: i=1; AJvYcCUWfB2vDn7IkriDLPKOYy1Gn9oo/7iSwKRlvrc2wZ2zrxs4Ssn8imsu5Tu6eZkG3My2wmIqH1h1@vger.kernel.org, AJvYcCXyE0bfQgSBGIxETvRdYOsgWNkDilu0G2aKSoCps66Mm3acNtHOk/T+NppXUbolrAIQF0VbsQ0jSKjt8yy6Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5kbiCHNzT53CHm5OZ0ouA/Qph0+QyuqzWf/mEbT8wF0/SUBQY
	mEPnuylqHg5saDXqDW+5z45GIduAnwBBc80AhYtTZBZQF/ouRBa4HaoUFRvx
X-Gm-Gg: ASbGnctdEDlBJ7xV39eyz/GTcTigc+OQz6ISZlv5tL3KawEyIC7QtHVahQx3v9+i4/o
	BD8i9yym9nh91DZ2r4BqT3Fna+hNBlFoqm0LsSCmPOlrd8RPb27c2XPkZ9ucegVFcw7H5knt7n/
	C9ROLHZus1p757EuOSvOqgepLR4YyplgxC5pLHQZdazy8p3zaKLzKT93D0svnM+UJbq3bgtsYSK
	rQMobbL3Mmbzoc2vi0ssCLS2CLIRAA9IAu5R17RFXUc/WawZDNbrTI9OBLPDCppR6iMtOGcxrtD
	zL+oAosnSVtkbUjJbU7AEhnfeDiNyv9YuVjnTwfyLuk=
X-Google-Smtp-Source: AGHT+IHQd94LMGWgRxKw5KrTvuxsUUJxnmjSeo3lNBOjf2cJcBcupyo6xLqDI9An5k+L2lz6Ru1pTQ==
X-Received: by 2002:a05:6871:5317:b0:2bc:9116:8856 with SMTP id 586e51a60fabf-2bd5187e0f5mr14532741fac.36.1740530193497;
        Tue, 25 Feb 2025 16:36:33 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7289dedfcd8sm507149a34.16.2025.02.25.16.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 16:36:32 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v3 5/6] wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
Date: Tue, 25 Feb 2025 16:35:55 -0800
Message-Id: <20250226003556.82644-5-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226003556.82644-1-sean.wang@kernel.org>
References: <20250226003556.82644-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Integrate *mlo_sta_cmd and *sta_cmd for the MLO firmware.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: generate the patch based on the latest mt76 tree
v3: fixed merge error
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  64 +--------
 .../wireless/mediatek/mt76/mt7925/mcu.c.rej   | 131 +++++++++++++-----
 2 files changed, 104 insertions(+), 91 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 4c133200c70b..34e7165d1a0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1820,49 +1820,6 @@ mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 	}
 }
 
-static int
-mt7925_mcu_sta_cmd(struct mt76_phy *phy,
-		   struct mt76_sta_cmd_info *info)
-{
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)info->vif->drv_priv;
-	struct mt76_dev *dev = phy->dev;
-	struct sk_buff *skb;
-	int conn_state;
-
-	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid,
-					      MT7925_STA_UPDATE_MAX_SIZE);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	conn_state = info->enable ? CONN_STATE_PORT_SECURE :
-				    CONN_STATE_DISCONNECT;
-	if (info->link_sta)
-		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
-					      info->link_sta,
-					      conn_state, info->newly);
-	if (info->link_sta && info->enable) {
-		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
-		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
-		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
-		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta);
-		mt7925_mcu_sta_he_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
-		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
-					     info->link_sta);
-		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta,
-					    info->vif, info->rcpi,
-					    info->state);
-		mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
-	}
-
-	if (info->enable)
-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
-
-	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
-}
-
 static void
 mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
 {
@@ -1875,8 +1832,8 @@ mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
 }
 
 static int
-mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
-		       struct mt76_sta_cmd_info *info)
+mt7925_mcu_sta_cmd(struct mt76_phy *phy,
+		   struct mt76_sta_cmd_info *info)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
@@ -1890,12 +1847,10 @@ mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	if (info->enable)
+	if (info->enable && info->link_sta) {
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
 					      info->link_sta,
 					      info->enable, info->newly);
-
-	if (info->enable && info->link_sta) {
 		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
@@ -1946,7 +1901,6 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	};
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink;
-	int err;
 
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
@@ -1954,17 +1908,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	}
 	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
 
-	if (link_sta)
-		info.newly = state != MT76_STA_INFO_STATE_ASSOC;
-	else
-		info.newly = state == MT76_STA_INFO_STATE_ASSOC ? false : true;
-
-	if (ieee80211_vif_is_mld(vif))
-		err = mt7925_mcu_mlo_sta_cmd(&dev->mphy, &info);
-	else
-		err = mt7925_mcu_sta_cmd(&dev->mphy, &info);
-
-	return err;
+	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
 }
 
 int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.rej b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.rej
index 3cdfc4e9a45f..dea7e7b3755a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.rej
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c.rej
@@ -1,35 +1,104 @@
 --- drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
 +++ drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
-@@ -2176,13 +2178,26 @@ void mt7925_mcu_bss_rlm_tlv(struct sk_buff *skb, struct mt76_phy *phy,
+@@ -1771,49 +1771,6 @@ mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
+ 	}
+ }
  
- 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_RLM, sizeof(*req));
- 	req = (struct bss_rlm_tlv *)tlv;
--	req->control_channel = chandef->chan->hw_value,
--	req->center_chan = ieee80211_frequency_to_channel(freq1),
--	req->center_chan2 = ieee80211_frequency_to_channel(freq2),
--	req->tx_streams = hweight8(phy->antenna_mask),
-+	req->control_channel = chandef->chan->hw_value;
-+	req->center_chan = ieee80211_frequency_to_channel(freq1);
-+	req->center_chan2 = 0;
-+	req->tx_streams = hweight8(phy->antenna_mask);
- 	req->ht_op_info = 4, /* set HT 40M allowed */
--	req->rx_streams = hweight8(phy->antenna_mask),
--	req->band = band;
-+	req->rx_streams = hweight8(phy->antenna_mask);
-+	req->center_chan2 = 0;
-+	req->sco = 0;
-+
-+	switch (band) {
-+	case NL80211_BAND_2GHZ:
-+		req->band = 1;
-+		break;
-+	case NL80211_BAND_5GHZ:
-+		req->band = 2;
-+		break;
-+	case NL80211_BAND_6GHZ:
-+		req->band = 3;
-+		break;
-+	}
+-static int
+-mt7925_mcu_sta_cmd(struct mt76_phy *phy,
+-		   struct mt76_sta_cmd_info *info)
+-{
+-	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
+-	struct mt76_dev *dev = phy->dev;
+-	struct sk_buff *skb;
+-	int conn_state;
+-
+-	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid,
+-					      MT7925_STA_UPDATE_MAX_SIZE);
+-	if (IS_ERR(skb))
+-		return PTR_ERR(skb);
+-
+-	conn_state = info->enable ? CONN_STATE_PORT_SECURE :
+-				    CONN_STATE_DISCONNECT;
+-	if (info->link_sta)
+-		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
+-					      info->link_sta,
+-					      conn_state, info->newly);
+-	if (info->link_sta && info->enable) {
+-		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
+-		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
+-		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
+-		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
+-		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta);
+-		mt7925_mcu_sta_he_tlv(skb, info->link_sta);
+-		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta);
+-		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
+-		mt7925_mcu_sta_rate_ctrl_tlv(skb, info->vif,
+-					     info->link_sta);
+-		mt7925_mcu_sta_state_v2_tlv(phy, skb, info->link_sta,
+-					    info->vif, info->rcpi,
+-					    info->state);
+-		mt7925_mcu_sta_mld_tlv(skb, info->vif, info->link_sta->sta);
+-	}
+-
+-	if (info->enable)
+-		mt7925_mcu_sta_hdr_trans_tlv(skb, info->vif, info->link_sta);
+-
+-	return mt76_mcu_skb_send_msg(dev, skb, info->cmd, true);
+-}
+-
+ static void
+ mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
+ {
+@@ -1826,8 +1783,8 @@ mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
+ }
  
- 	switch (chandef->width) {
- 	case NL80211_CHAN_WIDTH_40:
+ static int
+-mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
+-		       struct mt76_sta_cmd_info *info)
++mt7925_mcu_sta_cmd(struct mt76_phy *phy,
++		  struct mt76_sta_cmd_info *info)
+ {
+ 	struct mt792x_vif *mvif = (struct mt792x_vif *)info->vif->drv_priv;
+ 	struct mt76_dev *dev = phy->dev;
+@@ -1841,12 +1798,10 @@ mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
+ 	if (IS_ERR(skb))
+ 		return PTR_ERR(skb);
+ 
+-	if (info->enable)
++	if (info->enable && info->link_sta) {
+ 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
+ 					      info->link_sta,
+ 					      info->enable, info->newly);
+-
+-	if (info->enable && info->link_sta) {
+ 		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
+ 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
+ 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
+@@ -1896,7 +1851,6 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
+ 	};
+ 	struct mt792x_sta *msta;
+ 	struct mt792x_link_sta *mlink;
+-	int err;
+ 
+ 	if (link_sta) {
+ 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+@@ -1904,17 +1858,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
+ 	}
+ 	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
+ 
+-	if (link_sta)
+-		info.newly = state != MT76_STA_INFO_STATE_ASSOC;
+-	else
+-		info.newly = state == MT76_STA_INFO_STATE_ASSOC ? false : true;
+-
+-	if (ieee80211_vif_is_mld(vif))
+-		err = mt7925_mcu_mlo_sta_cmd(&dev->mphy, &info);
+-	else
+-		err = mt7925_mcu_sta_cmd(&dev->mphy, &info);
+-
+-	return err;
++	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
+ }
+ 
+ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
-- 
2.25.1


