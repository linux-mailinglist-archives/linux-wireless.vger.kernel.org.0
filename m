Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2DA47A195
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 18:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhLSRlG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 12:41:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51328 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbhLSRlF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 12:41:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 647C1B80D3F
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 17:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB74EC36AE8;
        Sun, 19 Dec 2021 17:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639935662;
        bh=QdYEDLewBGWIdQMhp+/m4C2l62N1peQVXDHa0cfwhvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNptNLoyj40ClvvUmygZz/qyInDI+U25yg0CLC4UhQIG4dVAgvZNpaiBAdJlKeweS
         f+KDjRKGZU2czvwFIgalN5SK0CAr/qOBBIeCi6QFagqkIy68QOInPBNTD6/HoMMJ6t
         5nLFVtL9BKN5b2D4PQwgiXT/2SAzx9UaFLZJ2bCd4ST4oT67AYLjih2l11yAHTfiHX
         WNK6AMhACIDTSaDQXNJIKrrXNaZSWUFTv559k1FLLqs4rOIMrTkTvqosncfaoL3BY6
         ffygFvMOM/uRfpjJ+tsJoFTGL4nFq0pG4jcqvf4Q3gY2YoSdeQLtOLVPY/lDQWzv9C
         PqPlAfAzB7BLQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH v2 4/9] mt76: mt7915: rely on  mt76_connac_mcu_alloc_wtbl_req
Date:   Sun, 19 Dec 2021 18:40:09 +0100
Message-Id: <ecbd2bb3a2c68be6c5bd2426a3052607fb6b20a3.1639935477.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639935477.git.lorenzo@kernel.org>
References: <cover.1639935477.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_alloc_wtbl_req routine and remove
duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 43 ++++---------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 6ad6eaef3c87..840df0498676 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -574,33 +574,6 @@ void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb)
 		mt76_mcu_rx_event(&dev->mt76, skb);
 }
 
-static struct wtbl_req_hdr *
-mt7915_mcu_alloc_wtbl_req(struct mt7915_dev *dev, struct mt7915_sta *msta,
-			  int cmd, void *sta_wtbl, struct sk_buff **skb)
-{
-	struct tlv *sta_hdr = sta_wtbl;
-	struct wtbl_req_hdr hdr = {
-		.wlan_idx_lo = to_wcid_lo(msta->wcid.idx),
-		.wlan_idx_hi = to_wcid_hi(msta->wcid.idx),
-		.operation = cmd,
-	};
-	struct sk_buff *nskb = *skb;
-
-	if (!nskb) {
-		nskb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-					  MT76_CONNAC_WTBL_UPDATE_MAX_SIZE);
-		if (!nskb)
-			return ERR_PTR(-ENOMEM);
-
-		*skb = nskb;
-	}
-
-	if (sta_hdr)
-		le16_add_cpu(&sta_hdr->len, sizeof(hdr));
-
-	return skb_put_data(nskb, &hdr, sizeof(hdr));
-}
-
 static struct tlv *
 mt7915_mcu_add_nested_tlv(struct sk_buff *skb, int tag, int len,
 			  void *sta_ntlv, void *sta_wtbl)
@@ -1187,8 +1160,8 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 
 	sta_wtbl = mt7915_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
-	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
-					     &skb);
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
+						  WTBL_SET, sta_wtbl, &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
@@ -1693,8 +1666,9 @@ mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
 
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
-	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_RESET_AND_SET,
-					     tlv, &skb);
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
+						  WTBL_RESET_AND_SET, tlv,
+						  &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
@@ -1720,7 +1694,8 @@ int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
 	if (!skb)
 		return -ENOMEM;
 
-	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
+						  WTBL_SET, NULL, &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
@@ -2074,8 +2049,8 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 	sta_wtbl = mt7915_mcu_add_tlv(skb, STA_REC_WTBL, sizeof(struct tlv));
 
-	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, sta_wtbl,
-					     &skb);
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
+						  WTBL_SET, sta_wtbl, &skb);
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
-- 
2.33.1

