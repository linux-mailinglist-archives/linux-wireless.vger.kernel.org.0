Return-Path: <linux-wireless+bounces-9956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE07926A9A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237352843E8
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0351940AA;
	Wed,  3 Jul 2024 21:43:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB421194AC1
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043005; cv=none; b=DOIR5ZCuTg3upmQxfOIwsd6Y6UrxSDre+1ZqWod5QVGgyrsLx/sBrD20IhoSVdB4yzesgDXNRztepLqk/U2wLZL50ejIjWHOochozxxW1vHrwB5Wb6foQYTlghoOfLwKPlG9snLGU08TPATtXUAYAeJvFTlPyRfjq6BOAr/kP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043005; c=relaxed/simple;
	bh=z2R7bu+zU5L3zkRr31kvRE2fDKNGIHI3mkPpKhvKgb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRzfYvnuLzgH8ij326dPdWjGh+ned7A7hH9/bOCep3alZXQekTRhtKuP8lEiN7bqVik2bJGezyk3DP+jVtlKrzUsc6pHjGbdEfDJGyaMVBqkRhRklhU2s8XetZED9XHH0kaoml5iMHxXLQkq7WyNETu2ar9f6swA9JMJ+HR7i14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d561131a3cso3575b6e.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043003; x=1720647803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtG0qWg5QbR5VYZF/R9pSkSDu8jWaNi65JIbi2fadJs=;
        b=kgJl/8fgLP/FrocEXk7m9mgBTztg5wa387bhr8a1Qo7qox+RGLMUxbL9Q/5DCresR9
         ivAoDDDGuToVXy1KV/ZhCLXPAU3c5odqcblkAfn9NquEVgN+K5QVp2HgoK9u6mbJRByD
         krnTfcXym19oS3OPepDu3DmFIOlTD2TFOFb0Bv9WAbOZj6PSydLXJLuAX1C1SDhPI8qf
         DOvQX+YXS2UherYTLFo0QmXDxhob0tZ3EMpBP3v6riTpQMNd3qEZv5Pc2UVHIKlOhWtd
         4yCiihs89HIwPDyGP++x6e86RnIj5IQWtJwNBEogO6HtVshsoAnP2cMKMMVOVI/qzas8
         m+DA==
X-Forwarded-Encrypted: i=1; AJvYcCXZiS0MTefoKjxCeCbBgBvq4eTkk9ea8mS+yAiJYnmbyotklE6G6eoRQ7tx3Q6fQNsJIerbCCF8l/AhjTVUhHVQu+XcVkrUo/Xh7GlaTRc=
X-Gm-Message-State: AOJu0YylTZAqsa7NKzVPHUM1Gh+BmKXvKHu06ELUvxvxsu2e+xIDHpW1
	Wwxog0/BHaKporjjDNIQSldcXahInM3fssS6NdXXTrTN6WPwKQwB
X-Google-Smtp-Source: AGHT+IHcOT2ePMPmXXvJS0IdwhfyVS1tVzOxF6uH1qeSR+V7tKTr7QafSgJ6K+RsYA6EQXkV3+UWow==
X-Received: by 2002:a05:6870:a511:b0:259:f03c:4e90 with SMTP id 586e51a60fabf-25db36a52edmr13771890fac.4.1720043002793;
        Wed, 03 Jul 2024 14:43:22 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:21 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 16/29] wifi: mt76: mt7925: add link handling in mt7925_txwi_free
Date: Wed,  3 Jul 2024 14:42:21 -0700
Message-Id: <2b70dccb2735f4ca02db102bb6bd02cdbd539c2f.1720042294.git.sean.wang@kernel.org>
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

add link handling in mt7925_txwi_free.

MT7996 should have the similar the logic, we try to copy from there to
ensure consistency between both.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mac.c   | 54 +++++++++++++------
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  2 +-
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 6f5f2130420e..0cb9031e9fdd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -839,27 +839,53 @@ mt7925_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 }
 EXPORT_SYMBOL_GPL(mt7925_mac_write_txwi);
 
-static void mt7925_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
+static void mt7925_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb,
+				 struct mt76_wcid *wcid)
 {
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_link_sta *link_sta;
+	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
+	bool is_8023;
 	u16 fc, tid;
-	u32 val;
 
-	if (!sta || !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
+	link_sta = rcu_dereference(sta->link[wcid->link_id]);
+	if (!link_sta)
 		return;
 
-	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
-	if (tid >= 6) /* skip VO queue */
+	if (!sta || !(link_sta->ht_cap.ht_supported || link_sta->he_cap.has_he))
 		return;
 
-	val = le32_to_cpu(txwi[2]);
-	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
-	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
+	tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+
+	if (is_8023) {
+		fc = IEEE80211_FTYPE_DATA |
+		     (sta->wme ? IEEE80211_STYPE_QOS_DATA :
+		      IEEE80211_STYPE_DATA);
+	} else {
+		/* No need to get precise TID for Action/Management Frame,
+		 * since it will not meet the following Frame Control
+		 * condition anyway.
+		 */
+
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+		fc = le16_to_cpu(hdr->frame_control) &
+		     (IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE);
+	}
+
 	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
 		return;
 
 	msta = (struct mt792x_sta *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &msta->deflink.wcid.ampdu_state))
+
+	if (sta->mlo && msta->deflink_id != IEEE80211_LINK_UNSPECIFIED)
+		mlink = rcu_dereference(msta->link[msta->deflink_id]);
+	else
+		mlink = &msta->deflink;
+
+	if (!test_and_set_bit(tid, &mlink->wcid.ampdu_state))
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
@@ -1039,7 +1065,7 @@ void mt7925_mac_add_txs(struct mt792x_dev *dev, void *data)
 }
 
 void mt7925_txwi_free(struct mt792x_dev *dev, struct mt76_txwi_cache *t,
-		      struct ieee80211_sta *sta, bool clear_status,
+		      struct ieee80211_sta *sta, struct mt76_wcid *wcid,
 		      struct list_head *free_list)
 {
 	struct mt76_dev *mdev = &dev->mt76;
@@ -1052,10 +1078,8 @@ void mt7925_txwi_free(struct mt792x_dev *dev, struct mt76_txwi_cache *t,
 
 	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
 	if (sta) {
-		struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
-
 		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-			mt7925_tx_check_aggr(sta, txwi);
+			mt7925_tx_check_aggr(sta, t->skb, wcid);
 
 		wcid_idx = wcid->idx;
 	} else {
@@ -1140,7 +1164,7 @@ mt7925_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 			if (!txwi)
 				continue;
 
-			mt7925_txwi_free(dev, txwi, sta, 0, &free_list);
+			mt7925_txwi_free(dev, txwi, sta, wcid, &free_list);
 		}
 	}
 
@@ -1426,7 +1450,7 @@ void mt7925_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
 	sta = wcid_to_sta(wcid);
 
 	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-		mt7925_tx_check_aggr(sta, txwi);
+		mt76_connac2_tx_check_aggr(sta, txwi);
 
 	skb_pull(e->skb, headroom);
 	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 54693624b182..252d9de81d99 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -260,7 +260,7 @@ void mt7925_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 			   struct ieee80211_key_conf *key, int pid,
 			   enum mt76_txq_id qid, u32 changed);
 void mt7925_txwi_free(struct mt792x_dev *dev, struct mt76_txwi_cache *t,
-		      struct ieee80211_sta *sta, bool clear_status,
+		      struct ieee80211_sta *sta, struct mt76_wcid *wcid,
 		      struct list_head *free_list);
 int mt7925_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq);
-- 
2.25.1


