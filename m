Return-Path: <linux-wireless+bounces-10030-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1BD9291DB
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47E4B21AD7
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5625E4D5BD;
	Sat,  6 Jul 2024 08:28:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1241A94
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254523; cv=none; b=LyyGVmBnSjjroYZhKVHXZJ3Llu/WmBE8EnSPX9FlpK8t2DJzM/kBA7cuSvGAAOVTwT9h4BhmUEM44Cgc2oUFSeQwNoeMNgHMUSfd2Hb8D0qwqoiDTpoEGbA/KfazESZWfBVAkTtSbX6LJjlniSlRyV1DDCPO/+S4gp2HwyXf0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254523; c=relaxed/simple;
	bh=JsfggounGl8/Va5lkoe5OefWPYNuj1XOjPdGm9QMewE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uClVCgvILGwbCgCZRz0k573TLfpA5jthaTEvY1EosQcC4sMM+OpTqcrsuS1YL+gUg+/8y1DNI1Zk8Ks4wKGChgaWGVttZJXdIajnOY5DnkwzLM1ZMteseru6str2HEEHu3SOCuhi4AzRFRfALX84SjojynOdBgJbb8slydZGwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c41370121bso62986eaf.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254521; x=1720859321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EEPHIPorQ9nGaiT0HOjyRcsXyquZCZmG1NVm4BqrTE=;
        b=ex3QVAOifjgYPm3LztCwpL24OxFhBvViOAv7IzruEwBNt2SEccKQmz4BH8FU9ho5UQ
         OvtVhUmPrHoRTg75DQh8DsYZaGT0kg4ZlTJtR2PpBTK8kHA9cBKhFaGeZ5BWMTI9JlYA
         BadRwi6JXY0rM31h4o2ZeWL7xBsHJO8P7bUNtieRtSUA0wf3x32VM9iC015PQ9bnO68R
         sm4KKicwVvpTudZathg523cy2243Qw8ayfuExbX8I4oKz0YJ3Pt6rXiBW73cZrgqRwg7
         jtTinFQsBnoC6/IqdlS34SnFJxQZvrdtflRZcxKSTsiZM5KXjYKCaJIAhdo9g3QF4TzN
         0tUg==
X-Forwarded-Encrypted: i=1; AJvYcCXMhfJ7qd8ZtRDTGDnj1dtHpdco+0m6e68EsAo1a+ODtsUpm68GOLWFEWVM/YlzVjZ/LoG9/25aEMZJHTtGedG5BYz/Sin5yKJfMWBcOxE=
X-Gm-Message-State: AOJu0YzdxpJ877381CqQkawAlYnTqcBlti3M8uhcbNx2baSz6kO6ekM9
	0AqCAmTwLRZFlAWyuseXQ1UIs6OW3yqwXySC+p9wJNzLQEhK+vvNFFHoFLTk
X-Google-Smtp-Source: AGHT+IFGruGjSYGcF0rQjezfDS/4IewsUW1utrN/aXSU0wtpByTzFbu7DhEZCK82MXReCqpKT+41hg==
X-Received: by 2002:a05:6871:5229:b0:25e:dce:491b with SMTP id 586e51a60fabf-25e2b8b79abmr6843436fac.1.1720254520934;
        Sat, 06 Jul 2024 01:28:40 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:39 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 11/37] wifi: mt76: mt7925: add link handling to txwi
Date: Sat,  6 Jul 2024 01:27:51 -0700
Message-Id: <c0a7c0b33ea2640bcb4f13a5f79a8976b73fa8f2.1720248331.git.sean.wang@kernel.org>
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

add link handling to mt792x_tx and writing txwi.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mac.c   | 12 ++++++---
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 26 +++++++++++++++++--
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 2be2ab914411..6f5f2130420e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -740,8 +740,12 @@ mt7925_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 				    BSS_CHANGED_BEACON_ENABLED));
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
 					 BSS_CHANGED_FILS_DISCOVERY));
+	struct mt792x_bss_conf *mconf;
+
+	mconf = vif ? mt792x_vif_to_link((struct mt792x_vif *)vif->drv_priv,
+					 wcid->link_id) : NULL;
+	mvif = mconf ? (struct mt76_vif *)&mconf->mt76 : NULL;
 
-	mvif = vif ? (struct mt76_vif *)vif->drv_priv : NULL;
 	if (mvif) {
 		omac_idx = mvif->omac_idx;
 		wmm_idx = mvif->wmm_idx;
@@ -802,8 +806,10 @@ mt7925_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 
 	txwi[5] = cpu_to_le32(val);
 
-	val = MT_TXD6_DIS_MAT | MT_TXD6_DAS |
-	      FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
+	val = MT_TXD6_DAS | FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
+	if (!ieee80211_vif_is_mld(vif) ||
+	    (q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0))
+		val |= MT_TXD6_DIS_MAT;
 	txwi[6] = cpu_to_le32(val);
 	txwi[7] = 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 62f471b5498f..ae2ac146a7f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -59,13 +59,17 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	u8 link_id;
 	int qid;
 
 	if (control->sta) {
+		struct mt792x_link_sta *mlink;
 		struct mt792x_sta *sta;
-
+		link_id = u32_get_bits(info->control.flags,
+				       IEEE80211_TX_CTRL_MLO_LINK);
 		sta = (struct mt792x_sta *)control->sta->drv_priv;
-		wcid = &sta->deflink.wcid;
+		mlink = mt792x_sta_to_link(sta, link_id);
+		wcid = &mlink->wcid;
 	}
 
 	if (vif && !control->sta) {
@@ -75,6 +79,24 @@ void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 		wcid = &mvif->sta.deflink.wcid;
 	}
 
+	if (vif && control->sta && ieee80211_vif_is_mld(vif)) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		struct ieee80211_link_sta *link_sta;
+		struct ieee80211_bss_conf *conf;
+
+		link_id = wcid->link_id;
+		rcu_read_lock();
+		conf = rcu_dereference(vif->link_conf[link_id]);
+		memcpy(hdr->addr2, conf->addr, ETH_ALEN);
+
+		link_sta = rcu_dereference(control->sta->link[link_id]);
+		memcpy(hdr->addr1, link_sta->addr, ETH_ALEN);
+
+		if (vif->type == NL80211_IFTYPE_STATION)
+			memcpy(hdr->addr3, conf->bssid, ETH_ALEN);
+		rcu_read_unlock();
+	}
+
 	if (mt76_connac_pm_ref(mphy, &dev->pm)) {
 		mt76_tx(mphy, control->sta, wcid, skb);
 		mt76_connac_pm_unref(mphy, &dev->pm);
-- 
2.25.1


