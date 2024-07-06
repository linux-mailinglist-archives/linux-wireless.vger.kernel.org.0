Return-Path: <linux-wireless+bounces-10035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADAB9291E0
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D61C20FF1
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF53C4D8C8;
	Sat,  6 Jul 2024 08:28:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EACE58ABF
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254531; cv=none; b=kzbUvnKn/UQuGPqFBX8u3QOdcfIPvsKMSV/bE71dlHHK+/z+cuxD+NTkQx/2MupO9RuvjKfu64J0nSAr2R53JQb7+Ku2cc13GZRU5ENvrnrw5VjtEox6JVovN+1kyTDx0BQJVR9uGEZyB9g3JxFK27pR0pAxn0W+ojY5rcv0VC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254531; c=relaxed/simple;
	bh=QJfzwSgY2brjky/cq/XvVIAa+0dZbHkv+pGqusEjSHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VtT8EHWBrTOdWs5wOuq3mTXkFl8uSwU41vXuXdMZqLqNmObs6H1rpnHj9j8jztnwXt17SnLZjyeCVeQXYc/1l1G+1W4XM0rH7p51HnnGptPMxZE7LvwJS5ywHoCtKq3W1gXRO0E5xvm2McRy1y87aV3oxrRDgAfOA/HQlSRvkEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25e3d71030cso261280fac.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254529; x=1720859329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI2TnPxCSt+IPX/3LOylsuRUtyZmNywOOwGJZo4oaeY=;
        b=C7fTVZB6QyC1Y+QjbVzQ2GQ0UO90JD9tmaMtZYz5bcnaIenXQUfnZu2BKp6pg6PrOP
         QSNek+k+TLkxMcjEDrXE9oKmc/SWWptIW27DPPFY9Ht014hO+R/sTuttqbj2PD5lgXd6
         o+WqPEgRFrbBiZKr0W2+eEoxvu9wpf2Pm+02q9ybZd63mljkzQ5RZSO47LL2HnZbfi9Y
         Q8jeIpNVDRP/xOy5uJiA8B7EnoM03/zjhzCp5q0dxz0KXo25OlAO2qSVywFDANAxK2QZ
         pUXW8Hc97renX0kbKlZYY5KhuNf2Wqr702QlrW1ORroGf1++rc0qUR9QXSvlZxoP6QMz
         GoHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqMtU6TbdvwudAQSdTvOfc/uzZmyfYtID3HYx1uQxf7v+mn8855Dnckh4uM7uJeLNd/sF+ARV3jAoKl0T23wtlQv5VbdRqu8n+WaWrGwE=
X-Gm-Message-State: AOJu0Yx6V5wFy/wT4hyvOECvjjDL1iqF3PYV2AlDPbJBd05jZKFuqCYF
	5Ao9O9twpm/+sMg2UXatKPHoC9imc3njQV0EhCtqU7KfpIN1DDk6
X-Google-Smtp-Source: AGHT+IEXpb8lA49aI/oP6Yv6S25n3obCNnYl2lfER1bVAUm/n7WmA4bCU2b5oIPzgS/Et3O0HlKWbw==
X-Received: by 2002:a05:6871:798e:b0:25e:15e1:35c6 with SMTP id 586e51a60fabf-25e2b5af44dmr6351702fac.0.1720254529375;
        Sat, 06 Jul 2024 01:28:49 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:48 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 16/37] wifi: mt76: mt7925: add link handling in mt7925_txwi_free
Date: Sat,  6 Jul 2024 01:27:56 -0700
Message-Id: <f8084e19d388c6b0807618ac6d1bb8ac633dc8cd.1720248331.git.sean.wang@kernel.org>
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
index dbc9e3d426e9..bcf8541fa31d 100644
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


