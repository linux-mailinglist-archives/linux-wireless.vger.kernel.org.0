Return-Path: <linux-wireless+bounces-17182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCC4A05097
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 03:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311293A283A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 02:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655F013CA81;
	Wed,  8 Jan 2025 02:25:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A197118F2EF
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303132; cv=none; b=mBQstJLn9Idb1N3P48S0tGXLvYwiRj2reQzLkEs2xElNLwbf9QhP4XmRhaXJOvJl3li+MT+w8EXc7hssMu1BFMzcuCr6rPLjDAtI3glRp+tnU5JfeENGEtzR/yeLTx6taHGANDknt55AHkCtz+rJixUJ27QdcHQROZZs4LJAGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303132; c=relaxed/simple;
	bh=v7iAjK9sTwkWI816wvLAaEWO0xC+oVi8HjC0AWEIRCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxP2+aQrnNjBfZ1ZHt/CDcEkpDXpfCl6SjYOlSTcm0ODTKbqAaGrat+xxG1rk5utytClClqJUiQnTvI9ar9ByIyCDtHh6OrU8eOVuxhioEgpGWkkIS7aaCfw0QHSt20USZfXW+U4H+lQz2jM03is/OvoSchfjxkW16aVLNUqZ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f31e8c2bfaso3535824eaf.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 18:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736303129; x=1736907929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9stJebzoNziG0WiLpxtOlGj1x2TuJPr5flN8guCLCsI=;
        b=cL1gt41y1Iwzr7nGvWnxwlvoOM3kf6yPPElAbJJb9doswRUHb/VGgFkoA49iThf24d
         kRmTMi2H+puY3PeHunQHD6LRcBAsh7k+YrN7frkCiVhloVzlBriJtzqJ09KMdi7iYHCH
         dDyP5zuUOheDsfq707ak79evE9KKwM/jkjZwaqyH3ywzrbIRJvZgjKztgmj3dM/uQAlJ
         99aFtNV3PqmalJY+UHStccwOpmDkUqeAAfUx8uqnUyEWTHrGEZwrb6ZWLQChjaUnSQaC
         2CuOWsWQVAwdTtU2Wlnc4RphcHChWwB0zBv2zNVcKGwLIJmK+p9VPUMcN+J4PPAjBlzy
         Zpgw==
X-Forwarded-Encrypted: i=1; AJvYcCXNK0aSAemj20f11VBF0T7OvUvz50x+b30dDN9jup+vswFw6tuZ7iQ/mAjctEeYemg43VhJxnj3TbKBOowxtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47IIKr0Kf+q0rXsyNhk7iFlJJBP+kNMhfqG6K3o99zQb5iWXX
	z+V+othwYHnK0dbwAIeAnImJGasQ3Edo3WnPsBBK+LM2HwtntK3D
X-Gm-Gg: ASbGncvo9w+N0GzTm4ONY1F8KlQVMkkpHSmLq/gvU57mY4dk8jSnV4uVd8lDp1EJKjE
	KF6D9XFfaVsZ6S2ofT6AzVyeyPjr4garYjqZBppF/vCbM9UlDsa6LV8AS1SPae8D2CRnzf01fuT
	xec6yIf3yz7Qd9VDS910nM2Gvk/iup18Nc0QW93vTQdhbf2AjvYZC3qP2n/I1E+vQYjNLj78S6g
	kAmyBRnZRrBtTuGSPUBk8mjqvkXBF8bjhVeyvd7NdYUFLCUz6AopERFMkKcCoDq7Qnv+BkzPA==
X-Google-Smtp-Source: AGHT+IF7R/DBuJXSH1eYBsGIosh+Urgb9KslzXHh+w0QlXaYbxMxDbthj6GNEsubQTP51gSeFHxYOQ==
X-Received: by 2002:a05:6870:9c83:b0:259:88b4:976 with SMTP id 586e51a60fabf-2aa069c9598mr557803fac.43.1736303129588;
        Tue, 07 Jan 2025 18:25:29 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d77f6340sm13072862fac.48.2025.01.07.18.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:25:28 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 5/6] wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
Date: Tue,  7 Jan 2025 18:25:08 -0800
Message-Id: <20250108022509.217803-5-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108022509.217803-1-sean.wang@kernel.org>
References: <20250108022509.217803-1-sean.wang@kernel.org>
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
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 64 ++-----------------
 1 file changed, 4 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index ad6174c07fe5..2fb8a6a7d252 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1771,49 +1771,6 @@ mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 	}
 }
 
-static int
-mt7925_mcu_sta_cmd(struct mt76_phy *phy,
-		   struct mt76_sta_cmd_info *info)
-{
-	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
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
-		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
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
@@ -1826,8 +1783,8 @@ mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
 }
 
 static int
-mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
-		       struct mt76_sta_cmd_info *info)
+mt7925_mcu_sta_cmd(struct mt76_phy *phy,
+		  struct mt76_sta_cmd_info *info)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
@@ -1841,12 +1798,10 @@ mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	if (info->enable)
+	if (info->enable && info->link_sta) {
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
 					      info->link_sta,
 					      info->enable, info->newly);
-
-	if (info->enable && info->link_sta) {
 		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
@@ -1896,7 +1851,6 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	};
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink;
-	int err;
 
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
@@ -1904,17 +1858,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
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
-- 
2.25.1


