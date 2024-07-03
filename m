Return-Path: <linux-wireless+bounces-9944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FBA926A8E
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F2FB24D65
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D14F191F8F;
	Wed,  3 Jul 2024 21:43:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B9191F8E
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042980; cv=none; b=dSA5BR335tH8O91D8qbbL9dUeSC6dg/pVols07uBVf9EvfAymp+n7PepEaqTeVav9yZrJdq6Kqsmm0tuXL51l1SsmRbtMb8c7OSqtdmGopA1BWHTt60rWUCCB8geao1kCim0/pPHp1ElNJepEmfbWV79ImfUC0JQey8z5X1CAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042980; c=relaxed/simple;
	bh=lk19O4waW96WYRN+73b/SbS4Casl06tEnEn0RWitTQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpG5en35MiMEFkO8e2nMB/VUQV1u0oVzNECXE+uEjliBr5ZDsZeFhbAczE7CeUmAWVa1FCLqIVH2tkuqfDOS85gVA5qfvIMRTKWSJyiXcjR29Y4UzH4ePEu0Ucl3qrpFXgw/1KTDpM86l2L9TA3eBwytIKc3NW8LuX7rN8JrcQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-700cf03febfso89113a34.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042978; x=1720647778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goXkALOp2QwxSb3F7DJoCuE/hHvbXbI8e1rMayLRwD8=;
        b=N9UyIpK6lrAekYTOAxTYR1xBQe+1LXY95DTa1zSDwB/1M6WKpMikkoPfEOb1DW1tsA
         cdLWBV3siI+lpRvEmT7lCIMHTsVJjfg1+U0DX7hvXZc0ORMzrSew4I0bsqAEupaeAkQh
         ags8O3htqrSskHcTvHhzH7f5/8a9EXjKpHa0QI+0Gzpw8fXJVFagGiEHA71jHkhaQeJv
         js2A3pnlGtn2MSeWZ9erDr48c4YumtxWg8eLnMom2RM0c9oqLGg8lAWbGdaFFCl8C2Ef
         jaifd7ev9UcJmx4BjYuKjv9fKsQ3S/+z55xjr54etBRIObOSGM27HKVuQYLcAdqk2qrL
         eaFA==
X-Forwarded-Encrypted: i=1; AJvYcCWoc7KBlj95SHA2zQFBakL5Oxe4F1ZbDw0zH6/HTZ1Y4ec3xWitZbnxP0XpA+/6p2cSMP+/5KqFhqviC1n6miiiby1J/DOXtMbga39cQ0I=
X-Gm-Message-State: AOJu0YylgRcwqbY8Qxo6DLTRZBSGdv7ew3lPUS70tf3cRMCMNH98+DBO
	FIDG5FSbA1EsIrvZdAy8BvaxT/fYKV3TGLgiE5GjKKEb7PcPWk7pZTJt3xd6
X-Google-Smtp-Source: AGHT+IFuEHcrEkFGiG9Dyf8kec2Kt4DL7xC2+P5Vzquxj3GgGa3ypEjfwcD1TpMXK4x8XZb03jfDgw==
X-Received: by 2002:a05:6830:1095:b0:701:f306:ad39 with SMTP id 46e09a7af769-7020768b4a0mr12292209a34.1.1720042977460;
        Wed, 03 Jul 2024 14:42:57 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:42:53 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 04/29] wifi: mt76: mt7925: set mt7925_mcu_sta_key_tlv according to link id
Date: Wed,  3 Jul 2024 14:42:09 -0700
Message-Id: <2a6000f8e280ceacc4e19240ff41863426839776.1720042294.git.sean.wang@kernel.org>
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

configure mt7925_mcu_sta_key_tlv according to link id

We created a link id field in the common structure mt76_wcid so that
mt7925_mcu_sta_key_tlv can access per-link STA/BSS. Additionally,
.link_id will be required when reporting the link information of Rx status
to mac80211. We will submit the changes for reporting the Rx status in
a separate patch.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 15 +++++++++++----
 drivers/net/wireless/mediatek/mt76/mt792x.h      | 11 +++++++++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 11b9f22ca7f3..01646538087a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -349,6 +349,7 @@ struct mt76_wcid {
 	u8 sta:1;
 	u8 amsdu:1;
 	u8 phy_idx:2;
+	u8 link_id:4;
 
 	u8 rx_check_pn;
 	u8 rx_key_pn[IEEE80211_NUM_TIDS + 1][6];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 4e5868cd2a97..0b486afe9352 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -746,6 +746,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	mlink->wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mlink->last_txs = jiffies;
+	mlink->wcid.link_id = link_sta->link_id;
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a67d8dd6075f..ba91c8e37dff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -967,6 +967,7 @@ mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 	struct mt792x_sta *msta = container_of(mlink, struct mt792x_sta, deflink);
 	struct sta_rec_sec_uni *sec;
 	struct mt792x_vif *mvif = msta->vif;
+	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif, wcid->link_id);
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 	struct tlv *tlv;
@@ -978,17 +979,23 @@ mt7925_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V3, sizeof(*sec));
 	sec = (struct sta_rec_sec_uni *)tlv;
-	sec->bss_idx = mvif->bss_conf.mt76.idx;
+	sec->bss_idx = mconf->mt76.idx;
 	sec->is_authenticator = 0;
-	sec->mgmt_prot = 0;
+	sec->mgmt_prot = 1; /* only used in MLO mode */
 	sec->wlan_idx = (u8)wcid->idx;
 
 	if (sta) {
+		struct ieee80211_link_sta *link_sta;
+
 		sec->tx_key = 1;
 		sec->key_type = 1;
-		memcpy(sec->peer_addr, sta->addr, ETH_ALEN);
+		link_sta = mt792x_sta_to_link_sta(vif, sta, wcid->link_id);
+		memcpy(sec->peer_addr, link_sta->addr, ETH_ALEN);
 	} else {
-		memcpy(sec->peer_addr, vif->bss_conf.bssid, ETH_ALEN);
+		struct ieee80211_bss_conf *link_conf;
+
+		link_conf = mt792x_vif_to_bss_conf(vif, wcid->link_id);
+		memcpy(sec->peer_addr, link_conf->bssid, ETH_ALEN);
 	}
 
 	if (cmd == SET_KEY) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 69eb8dac0b70..fe5a6c932705 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -273,6 +273,17 @@ mt792x_vif_to_bss_conf(struct ieee80211_vif *vif, unsigned int link_id)
 	return link_conf_dereference_protected(vif, link_id);
 }
 
+static inline struct ieee80211_link_sta *
+mt792x_sta_to_link_sta(struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		       unsigned int link_id)
+{
+	if (!ieee80211_vif_is_mld(vif) ||
+	    link_id >= IEEE80211_LINK_UNSPECIFIED)
+		return &sta->deflink;
+
+	return link_sta_dereference_protected(sta, link_id);
+}
+
 static inline struct mt792x_dev *
 mt792x_hw_dev(struct ieee80211_hw *hw)
 {
-- 
2.25.1


