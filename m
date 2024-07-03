Return-Path: <linux-wireless+bounces-9958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E8926A9E
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801611C20E4A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD32194ACF;
	Wed,  3 Jul 2024 21:43:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE07194AE0
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043009; cv=none; b=sB5eTaVVTnyCnDlm/6tH2HSFVZ4eh6MlES1HiyWpx/8qel8FuT6wibyzw+2hadSXay1F4uFXJ84Z8jHpbAzTIvHvfeWnQLhDf4qW2IIKO0QfuA0B4sIB5Y9UQJjfCo7Qj6jCzrUsIleBmaQByLH5DTYLsvKz3NmJTt73DS3s1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043009; c=relaxed/simple;
	bh=8Cw+Y3Rvc50icxpNiQ8eoyoLkq/z4vSUHDfCpbFCjCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWPpiooqxIvDsiEmj0uCEXxIF9fUQBPhecPw/hfcIsC9jXyuZZOpeNl0zOPwtTGWeU1AdBsCT9dm/Xp13TBN6exTqkNwglZISVz3pPacZJlh6y23FoeL7Na2n/cGmhjFEQMf28eK8OyASWu0cF4bcrQ0s9JkIhOVa9LWwkETd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-254c411d816so3752fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043007; x=1720647807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Erih5+NFArlq4U+QMfF/4G3Ja6X1QAPdgNncz1l2jKk=;
        b=XwqeeolOQMPAmK57IIyblLoFvckDwaEL5ENOjmh6FjSGlKR5h1HEeeXd9k2Lkmkrf9
         3sLlZnhmW2ITd7BDE1YeOhIteFYUuGlDmM16eB655DtjNsYsnZ5FRrgvboOeeH2EdUMg
         VKrCZC/v/AsAyw/8Zd5ZKHtSX9YNEOC1SMBjWSx6ZGCduirUAe9vG4xnn6xoU3YGSoNW
         eQzJai7WHxlyE+RGgBJDj1Z0ge0qPRMaeTcStyI3ePuGDK96Gf3s3HH6PngQQx0IJ4cC
         hCoXZ6+ppQ05Bs9wHqYv6i2NkI3eG/e7IDeWhSqSyAlhuNBlZo44NaJ9syhlUKcnlSrl
         5CtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk+ptOvAWJDRoLXXafDuEYZ/qYnkA4fbpIRobMBQtjuwjfDUaEFPXHCGLe1AgpJDhXDjHU7mQ8yHWlZOaKzIzPlBR8v+rA4TcTlCtxlcM=
X-Gm-Message-State: AOJu0Yz2jsL/MfemACRbfNNX+PiC0HNi05K6FIZFsYKyiwu+EK/5O9TX
	/W9cDJ50rSR0/2iUhuFGw2o7U78lW1N4WR4WCW7FFvV+b++5zBDE
X-Google-Smtp-Source: AGHT+IE2XP0Wra+Ep1R6FhpkFyT7lT9uipofVy38SxEXErnDmraYC0MmGSBrSm4GRN8CBQxS8S2Wiw==
X-Received: by 2002:a05:6808:1494:b0:3d5:618e:193f with SMTP id 5614622812f47-3d6b2935863mr14288644b6e.1.1720043007114;
        Wed, 03 Jul 2024 14:43:27 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:25 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 18/29] wifi: mt76: mt7925: add link handling in mt7925_sta_set_decap_offload
Date: Wed,  3 Jul 2024 14:42:23 -0700
Message-Id: <6e48351e9543d8225e09255f802732d635e533d0.1720042294.git.sean.wang@kernel.org>
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

add link handling in mt7925_sta_set_decap_offload

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 21 ++++++++++++----
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 24 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  3 ++-
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 3a9d526f8085..265ef7ade6e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1450,16 +1450,27 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
 					 bool enabled)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	unsigned long valid = mvif->valid_links;
+	u8 i;
 
 	mt792x_mutex_acquire(dev);
 
-	if (enabled)
-		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->deflink.wcid.flags);
-	else
-		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->deflink.wcid.flags);
+	valid = ieee80211_vif_is_mld(vif) ? mvif->valid_links : BIT(0);
+
+	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt792x_link_sta *mlink;
 
-	mt7925_mcu_wtbl_update_hdr_trans(dev, vif, sta);
+		mlink = mt792x_sta_to_link(msta, i);
+
+		if (enabled)
+			set_bit(MT_WCID_FLAG_HDR_TRANS, &mlink->wcid.flags);
+		else
+			clear_bit(MT_WCID_FLAG_HDR_TRANS, &mlink->wcid.flags);
+
+		mt7925_mcu_wtbl_update_hdr_trans(dev, vif, sta, i);
+	}
 
 	mt792x_mutex_release(dev);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cf0377d26752..75149baab7e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -887,10 +887,15 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 	else
 		hdr_trans->from_ds = true;
 
-	if (link_sta)
-		wcid = (struct mt76_wcid *)link_sta->sta->drv_priv;
-	else
+	if (link_sta) {
+		struct mt792x_sta *msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
+		struct mt792x_link_sta *mlink;
+
+		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+		wcid = &mlink->wcid;
+	} else {
 		wcid = &mvif->sta.deflink.wcid;
+	}
 
 	if (!wcid)
 		return;
@@ -904,17 +909,24 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 
 int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 				     struct ieee80211_vif *vif,
-				     struct ieee80211_sta *sta)
+				     struct ieee80211_sta *sta,
+				     int link_id)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_link_sta *link_sta = sta ? &sta->deflink : NULL;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_bss_conf *mconf;
 	struct mt792x_sta *msta;
 	struct sk_buff *skb;
 
 	msta = sta ? (struct mt792x_sta *)sta->drv_priv : &mvif->sta;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->bss_conf.mt76,
-					      &msta->deflink.wcid,
+	mlink = mt792x_sta_to_link(msta, link_id);
+	link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
+	mconf = mt792x_vif_to_link(mvif, link_id);
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mconf->mt76,
+					      &mlink->wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 252d9de81d99..4c0ecae8e49b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -315,6 +315,7 @@ int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 int mt7925_mcu_set_rts_thresh(struct mt792x_phy *phy, u32 val);
 int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 				     struct ieee80211_vif *vif,
-				     struct ieee80211_sta *sta);
+				     struct ieee80211_sta *sta,
+				     int link_id);
 
 #endif
-- 
2.25.1


