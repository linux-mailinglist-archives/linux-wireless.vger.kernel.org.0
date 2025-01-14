Return-Path: <linux-wireless+bounces-17467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34359A0FE78
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 03:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F09169CE9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 02:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2C8493;
	Tue, 14 Jan 2025 02:07:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCEF22FE18
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820453; cv=none; b=gfXGd9/aruZf0qGqh4oYet7skceRVAtznr30SeTk2GDAu8sp/haJWOfstDcIrLmiLuyIsBZ6jTb6E6iKEOFO19139L9cvO53t8t26l6XMgRy+DU2lZlnYwKV/cFXoAXURXv/GHrqZcRzbU5TodDJmcmRxrDQlTFrVtv4htJB4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820453; c=relaxed/simple;
	bh=hf+s/5NfjGiXcaz4X9tkfJO4jXLQxhhFYtBGO1SkiIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoHAcQBsPU5gTYxD71+Na20b2eZ0kxTn2CglOKgXmYoYpSM81p8zwqX/q2TwxyVdMd8JpR1B4y+RjQfvATPf+yG0HbeSg/XQzRI1SZBXzHcQC9tcfWU9XESM7puTUZdMObbGvdABIA86yzKN/qThSCdz5TI2HqOI6KgjUF2Mzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f31841c6f6so2350834eaf.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 18:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820451; x=1737425251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFXCH5TGHGDDGFUTwj/Hv5bd0CEyH7LmcN4nsFXhtFk=;
        b=ZPYoQh20hWyIf5tgIfRC+odGZccdVlmMWtLD/re2BiadyREtRuD1PpKKHEkOOX7KBm
         4nl4ctBAAMgdEXAWVEAWa0iwjzgTy+at98OkZMhGXmbwtQuNBmQOqo8dM1iDYKg+s7Zw
         f8pc3DHfl3akS84CL97MvhZkvG/8A9C/OsLHy4IUBArY6t2i92GSPTXyVx2DuKFBESjD
         7fWbxzjy/UtEONPZ5HCzFYcRRY5MLv0pe3yIi8EuFmiLjruRHLxNvSQ2ptikiMbuT8Ii
         mEjCRGRzfYU5HbM5496BUSw4W9IZujHo0A53lMk8TjpuKkv5W16na1f81x6eEr9KrQG6
         Uz9w==
X-Forwarded-Encrypted: i=1; AJvYcCVYa3YnfAaL6G00DubHVPeejxZ29esIv+dV2tN/QOJthvzpy3QH5U+KqU4XF00PlF93uS4Fu5ZqTVIk4oys1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCbm36m0ulXh1Ew2p/FC+JYHESmKZkihZ0/CiSPRfTmfxM3jMm
	RFBZC2ivlBwPBmd384WpkgxdMmVCOyj3Gyl4fSAN7j9LjgqLm5wv
X-Gm-Gg: ASbGncualVLMqRyHXf/VH5jxe18MzIGAQqJf14QNUe6VoMJB+P7rMIthBYDVGxFEz4c
	b/TJq3MNpYk5hZdFRxlG7TB3pDvM7ElKq/nNH4191mscvwwpJAQ3PtTgNB1cI91OFJh34+txH/D
	VR2HDeXJcnI0qFw+EeusD0HXAS437u6GHvJ9Btb9twmUp1TBK+yHXndfukI343wTNxLhqmwz8b6
	+OXvhZfy2EqxuIFxD6OyAGYaDujgomSVZRWAShyGecXZh4I0D2U78ptKwF1FozuLRm5G5BAsg==
X-Google-Smtp-Source: AGHT+IHyBRGCjRrWK9gKiZPubfswmZcfYLk4XED6ZZc435DX/3BAuAAebMsGzbgjSLwJ+fCyZrcXjw==
X-Received: by 2002:a05:6820:1b0d:b0:5f8:8917:b6fc with SMTP id 006d021491bc7-5f88917b7e3mr10727061eaf.1.1736820450742;
        Mon, 13 Jan 2025 18:07:30 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f882755172sm3915340eaf.27.2025.01.13.18.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 18:07:29 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 5/6] wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
Date: Mon, 13 Jan 2025 18:07:11 -0800
Message-Id: <20250114020712.704254-5-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114020712.704254-1-sean.wang@kernel.org>
References: <20250114020712.704254-1-sean.wang@kernel.org>
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
igned-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: generate the patch based on the latest mt76 tree
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 64 ++-----------------
 1 file changed, 4 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index d1506ee977a4..38a29a1a1a66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1818,49 +1818,6 @@ mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
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
@@ -1873,8 +1830,8 @@ mt7925_mcu_sta_remove_tlv(struct sk_buff *skb)
 }
 
 static int
-mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
-		       struct mt76_sta_cmd_info *info)
+mt7925_mcu_sta_cmd(struct mt76_phy *phy,
+		   struct mt76_sta_cmd_info *info)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
@@ -1888,12 +1845,10 @@ mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
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
@@ -1944,7 +1899,6 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	};
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink;
-	int err;
 
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
@@ -1952,17 +1906,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
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


