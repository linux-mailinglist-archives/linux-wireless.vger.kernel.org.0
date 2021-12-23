Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAA547E2F1
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348136AbhLWMIZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50380 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348129AbhLWMIZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED1ABB81FDE
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDC8C36AEA;
        Thu, 23 Dec 2021 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261302;
        bh=zQM7XedUOelllWwYsAgfjMsU/GasgPvmBy4fxqO8e4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmSEEKDE3PFAp1ytO1jejE8l3Nv4dNNpmP1fM7T4XXtJK2Yo1saXKAWba3bbG/vFs
         N9hDhmwXTuCcW5LmZMAz5h8Ptjb3HF/PuWptnFLmJjfLesSved6c9JvP0aOnTkm4Gk
         3V0HmQh9q60uKVWl70vfC+eZvJJ3Fu5aixi5Nw7hja+F6s+Fb8kSEI3mNfexoeiUAW
         sFYeqOhYCDIAszPpAhn8/v7UKlLpOgmWtEp0OyqoncnYDLFUh/0/XVslRZFvFCyi5d
         YRlH9Jy2Dv58ycJ9BPfWIic68MI+GX+fOrssGvd135Olx8l9I3sv2eNn8o9ec26UES
         CuQaDBeChGR/A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 13/15] mt76: mt7915: rely on mt76_connac_mcu_wtbl_hdr_trans_tlv
Date:   Thu, 23 Dec 2021 13:07:41 +0100
Message-Id: <bee8e36c1810b371668a1b0649cd2463c4149a90.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_wtbl_hdr_trans_tlv routine and
remove duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  6 ++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 38 +++----------------
 2 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 8d9d9d449175..425414d803f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -462,13 +462,17 @@ void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 					     sizeof(*htr),
 					     wtbl_tlv, sta_wtbl);
 	htr = (struct wtbl_hdr_trans *)tlv;
-	htr->no_rx_trans = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
+	htr->no_rx_trans = true;
 
 	if (vif->type == NL80211_IFTYPE_STATION)
 		htr->to_ds = true;
 	else
 		htr->from_ds = true;
 
+	if (!wcid)
+		return;
+
+	htr->no_rx_trans = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
 	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags)) {
 		htr->to_ds = true;
 		htr->from_ds = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index c307c79fd80c..95e80c45607d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1022,35 +1022,6 @@ mt7915_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	msta->wcid.amsdu = true;
 }
 
-static void
-mt7915_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
-			      struct ieee80211_sta *sta,
-			      void *sta_wtbl, void *wtbl_tlv)
-{
-	struct mt7915_sta *msta;
-	struct wtbl_hdr_trans *htr = NULL;
-	struct tlv *tlv;
-
-	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_HDR_TRANS, sizeof(*htr),
-					     wtbl_tlv, sta_wtbl);
-	htr = (struct wtbl_hdr_trans *)tlv;
-	htr->no_rx_trans = true;
-	if (vif->type == NL80211_IFTYPE_STATION)
-		htr->to_ds = true;
-	else
-		htr->from_ds = true;
-
-	if (!sta)
-		return;
-
-	msta = (struct mt7915_sta *)sta->drv_priv;
-	htr->no_rx_trans = !test_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
-	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags)) {
-		htr->to_ds = true;
-		htr->from_ds = true;
-	}
-}
-
 static int
 mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
@@ -1058,9 +1029,11 @@ mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct mt7915_sta *msta;
 	struct wtbl_req_hdr *wtbl_hdr;
+	struct mt76_wcid *wcid;
 	struct tlv *tlv;
 
 	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
+	wcid = sta ? &msta->wcid : NULL;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
@@ -1071,8 +1044,7 @@ mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 
 	mt76_connac_mcu_wtbl_generic_tlv(&dev->mt76, skb, vif, sta, tlv,
 					 wtbl_hdr);
-	mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, tlv, wtbl_hdr);
-
+	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, wcid, tlv, wtbl_hdr);
 	if (sta)
 		mt76_connac_mcu_wtbl_ht_tlv(&dev->mt76, skb, sta, tlv,
 					    wtbl_hdr, mvif->cap.ldpc);
@@ -1098,8 +1070,8 @@ int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
-	mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, NULL, wtbl_hdr);
-
+	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, &msta->wcid, NULL,
+					   wtbl_hdr);
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD(WTBL_UPDATE),
 				     true);
 }
-- 
2.33.1

