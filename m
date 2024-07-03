Return-Path: <linux-wireless+bounces-9951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27893926A95
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F0FB253E6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AC21946A5;
	Wed,  3 Jul 2024 21:43:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F851194A4C
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042995; cv=none; b=rWuVusiCIn7PrkzkomNx6jJ6EX9ObJ56ZcUZbQKSPPwHKvgsVbj4tLuza8N7WpJHLjSUZoti6hQ9VnU4e8wp17SlmhVN7jrYs/31Mi1N4PjAnD010f9/Ll9mB2mAg14qhOL6QXZCuodxXJcU3JtWnZDo1YnvRzYVhp0VTLqKR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042995; c=relaxed/simple;
	bh=JsfggounGl8/Va5lkoe5OefWPYNuj1XOjPdGm9QMewE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFFwgukUk1a0unwZq5aEYw57cD501+XwTmToKUWV0UvrzH7D7c+YSEAOalATMLipM7+g54aYs5gI9TIa5nzL2HrQtEXsu/L9v7cA2VO9cS5WJNsTglLCBKGQVPBjIJrbkbdK5r3vf0TDg/m4LXQbgZaUTUt/7ybFXJbppdnYiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-700d281dcecso104219a34.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042993; x=1720647793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EEPHIPorQ9nGaiT0HOjyRcsXyquZCZmG1NVm4BqrTE=;
        b=wdImUY6nKdF34TMxXuP5JViWit3TxrwVxCszyCL/Feyq3JlDk9ZVy9XFjmA2Tc7ECJ
         lKxGlVAQz84f2aUABnLwJ+kA/vbhproTCjv02NERVjKBS9TZV6iR7iiwvGb9/zgdeqZv
         Zk6uQpfNYATqkptkDL/ZPOYxg7BTAismc6Z4IxVALSMnhNXehv0bQQzQaY7vOMxyWDoU
         eAGLhbFMpXLEkC3LRateEUOX9TzTCZcL1MdOtECSwMZUr4CCCHzwE7/I0nGTv+masE/l
         WwexKdQ1YsI3IF/CaZYgTxyYlBuLQXa4E8+n12DpxDOXxFRC91Dd81ILHF3sLIIzAzLe
         dA/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdEOa4uVBjc2APihUSo8B2knMVMbk1+pCf0HYl5AYfTmZHIx7TJdJWcfsPnsAYfDN6E0LbeZ11p2U5bUyGvh/1F5n4NLjOKj40hzMOwdE=
X-Gm-Message-State: AOJu0Yz7/S3QNUj71Wkr6wcvoJQLVxgcYuDxjEEM1Sz5WnvjXHCi+M9b
	JguqR1dFpwHDLlsMWHjV1d+MJc3XbSpdVu9CGVN4QsdHVGhYJFHOqmLP6usF
X-Google-Smtp-Source: AGHT+IHggK4Kg30dd8NLdj3jI1DxXMyqkfqDw4O6ut1WvmHHhY2tP43NFyj/9iepNGjGPUI4kHOJCg==
X-Received: by 2002:a9d:5c89:0:b0:701:f366:71d7 with SMTP id 46e09a7af769-7020767ab30mr12877738a34.1.1720042993253;
        Wed, 03 Jul 2024 14:43:13 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:12 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 11/29] wifi: mt76: mt7925: add link handling to txwi
Date: Wed,  3 Jul 2024 14:42:16 -0700
Message-Id: <c2b4cb1e721425d71282df5b750c580452042d56.1720042294.git.sean.wang@kernel.org>
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


