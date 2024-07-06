Return-Path: <linux-wireless+bounces-10037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193779291E2
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA60F283832
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4A6482F6;
	Sat,  6 Jul 2024 08:28:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FAA46556
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254535; cv=none; b=QbRgCurKkOdXoYGZ6xfvwNvRqBuk8codITfkevu/1XmvKi2afNvudt0GRe9zyRGMIsyTndf7Shc3TUOhP6zBeI3LAg6tlDU06sM7whUrAk5tSqVOVNOYBIODpUPTEyppKivTHsvK62GUQy3Y47PgkJPMCRl9Dp5TdBPKhVylI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254535; c=relaxed/simple;
	bh=w9VoeQqVXEkbaJJj8VQM7HcauiPDDZPdCZ0XhLuhcqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYfEXpfxrFFH1aVcjRFaaC+aZzTf7+NOjspTsV/gmAwMZMg02qTbK02UjLb+IvRZUJDgv4uT2xIEvRv2SpXBLjgWmnqe969VN4uEKxgYVrsbWAn19sxtzphoA3lWew7Z5X0QUJL+EI7dmzV6W6fHMjCTAfhQF4AASth3icnvLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25e3d71030cso261285fac.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254533; x=1720859333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHGyXk+WAR8WXx4VibOug2pcg/d+aFy2gVyJKaP8IFg=;
        b=CjK+QvWzEPR61TV/KQbtGNdmuJ6n0s4ZHnFT2nuM912858CMwOtABptjvcaFZL1BAG
         6udDjRLntiJQgsTZEjiFkL7VX+jyouRAFzLor7XMhgpmTyoDwL+PoawAXNqgGHy2Dv2b
         tVLQYaIzE28AaH/UH8sqBds1rz+Tpz7l6QVRePzgjx6pIgeSW/yyQm7GcOU5Zm8mhg5p
         wE4XBEuEkNWezW2FWhPnntkAyDAW7W9Pa5d8VzR41lvC1nWKKK0bcu/2KTwbvIeGjMc/
         EDA67B1C1jXKQhFsyXUQRVqPm9eW1B59we/bcL0EvwWljEAslQ0aoU1yB9agTevTsMHF
         84cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLRWYJTLSUojJXucu49dv4Esi7qpueJFbGuZNANRJtiEiLfN4VJ9G8bpPc3ep4Nk0obfPaPTCNkjmziXWBlwJdrIlWOaGm6g59yLFDQE0=
X-Gm-Message-State: AOJu0YwJf47dJDxdNBpIaSYf3diFMxM6rh/Kq80UMhUyDIxeXZ7Ja0V7
	zrCxLw7KwtDZxmVj2InAOG+VuqrHJDeYPb+zwy44I0ibC7gC1t4m
X-Google-Smtp-Source: AGHT+IFDLJSexFdKlH1kAQdK5WdFbGIt4Pp8bOhD5gqac9cia3oXrg+IFO5ZRDdOCGyTsNIUUu4nHw==
X-Received: by 2002:a05:6871:798e:b0:25e:15e1:35c6 with SMTP id 586e51a60fabf-25e2b5af44dmr6351746fac.0.1720254532685;
        Sat, 06 Jul 2024 01:28:52 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:51 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 18/37] wifi: mt76: mt7925: add link handling in mt7925_sta_set_decap_offload
Date: Sat,  6 Jul 2024 01:27:58 -0700
Message-Id: <df2524e3a63a93699bde441e4ab70a70bbac53ef.1720248331.git.sean.wang@kernel.org>
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
index 669f28a916c5..791e90f5760f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1464,16 +1464,27 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
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
index 9a4dfe53da17..0991af877434 100644
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
index bcf8541fa31d..1ae66629e39f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -316,6 +316,7 @@ int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 int mt7925_mcu_set_rts_thresh(struct mt792x_phy *phy, u32 val);
 int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 				     struct ieee80211_vif *vif,
-				     struct ieee80211_sta *sta);
+				     struct ieee80211_sta *sta,
+				     int link_id);
 
 #endif
-- 
2.25.1


