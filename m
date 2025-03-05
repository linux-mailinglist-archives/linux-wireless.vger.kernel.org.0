Return-Path: <linux-wireless+bounces-19786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D57A4F228
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 01:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CAD3A8DE9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37A4A1D;
	Wed,  5 Mar 2025 00:09:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A720C8F54;
	Wed,  5 Mar 2025 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133357; cv=none; b=p7EqolBV+peGaXZymkQEe1pAms1xwzCiNTOvwviXiE0IkyKC8BP7CKikX/ioV0Mxec4xBGFb0sX+QtbgwSzbKlO1bnsRVKi2Tnjmnass02xwnlV6sbxjyVuv0IWhGxs4FaCLI6hyUzExNKsQiM7eLPuUSxVeqFPaOLJuX5BJIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133357; c=relaxed/simple;
	bh=kFnZt6UvuIk1L2jaot7yjwh7OY22U1YoN/VBxIf1CqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HVvrhfYgB8VVR70W9fggRue4on6bFMlESP17Q7S1iC+VUlWP1g5iis2lGgDQbgH0OjiACMp4xN7up57nrg4DJouRwxgJ+wmkwRz+Jr2jvfW7WkgFl3zOOxAAX3p5xwc+H/XoBQ/nTuotujwsTav0Om1YIPa4G7339WwBTSOH8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f1c94936c5so176627b6e.1;
        Tue, 04 Mar 2025 16:09:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133355; x=1741738155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZq1QVFR2Y4L6SmWL/g11Hjl8Ghbc2LyxG/QBtnz4Ek=;
        b=Gr/fmIUZ32Lxr42yvQW/kgTFTKHi1Dhl+TlViWlld5+174ZegUGVlilkJCA8i9cdjN
         1Lz1uz3zjdVyaNy9JbyS2RWy7kU4lBxwuNKU9kWj4+XjPje41FvQV/ImUtSJAooJfDXm
         wxYK2SwTqRPQK109gbd3XyNxPexta0GTcC7T4Ep4qYR7mAA2/Xrn3QGQSprySwK/SKug
         a97DGpneHxJ8qZPZEslbek1Fa0RLCVp+AvoAmQHQJwM/dQ3Jv5+T0V9AeZ0aDxj/mDxA
         HCytALWxm/ddD3Iw4xPc5KT3QFZKHx7FddD2r3VGpoEBbBg+TxwC5N20/mCGKt39a4n3
         nV4g==
X-Forwarded-Encrypted: i=1; AJvYcCUxdglhGonCE/jhahEmcftpDShTTJMHb/cR2qT9BxaDEqMwjrUa2HYuq6hSF5mzADZmQJ4euh7chDBb0nBilA==@vger.kernel.org, AJvYcCXN5j/E67q5OZG1pHSRt2JpP+26ifohlPecG3H42s4JY+ORclWNh/3fZEiijzXVTXkCfP5XO9hM@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0GPMpJxbDLop6d5hE3Dp0FLQsMxXcUrT4HvHG8Y3nQT++OLK
	ggjeR+VQkp6n9/yYdiq6g5YnhYVmF11nfxqjzEhpZu8zrMXfzgYY
X-Gm-Gg: ASbGnctRRwB+YFfiVgRUyueuIPe3cpYgOzEZlim8yVBqNTRPXgMCWpra56qNamR4rZr
	qYRFo8v1L8Gt4xbcUEPrKQceUEWIAcXIeNweZLamqyFNOwXQTAMWArwjDxGzxgFqewMTTLpjoJB
	V9vuXuIe2Sye3uJhoAEneBsJWDc9oX1S6B7a88D4eTx6YKMKLUvCpGfzHyZwC1lM40AzWx1hQJ7
	r/W1JvlbvodrMWnuxzOePO93CwYD/jFzcMIxKBC8SxiONrP/OjdxoFuJ0TmFWnOLERuhKDAbqI/
	+VhiByPiSp5AFqQ9kt29bHXX1uvQcKx8QbjHMiT8drcwA+P2LoYEnwGJGliizQ==
X-Google-Smtp-Source: AGHT+IHRlYZehCnayI0/SSWxl0V/woi03L0dMl7UT9bDMYd2zx2ye4bxdeydVicDxirQtf76987GeQ==
X-Received: by 2002:a05:6808:38c5:b0:3ec:bf55:e33f with SMTP id 5614622812f47-3f682d02020mr776039b6e.9.1741133354724;
        Tue, 04 Mar 2025 16:09:14 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f67ee8f479sm299985b6e.40.2025.03.04.16.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:09:13 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Caleb Jorden <cjorden@gmail.com>
Subject: [PATCH v5 5/6] wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
Date: Tue,  4 Mar 2025 16:08:50 -0800
Message-Id: <20250305000851.493671-5-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305000851.493671-1-sean.wang@kernel.org>
References: <20250305000851.493671-1-sean.wang@kernel.org>
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
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
  1) generate the patch based on the latest mt76 tree
  2) update the commit message
v3:
  1) fixed the merge conflict
v4:
  1) added tested-by tag
  2) removed the unrelated files
v5:
  1) update co-developed-by tag
  2) rebase to wireless.git
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 64 ++-----------------
 1 file changed, 4 insertions(+), 60 deletions(-)

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
-- 
2.25.1


