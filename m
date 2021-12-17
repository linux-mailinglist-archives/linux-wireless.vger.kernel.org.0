Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BC7479311
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbhLQRtH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 12:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbhLQRtG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 12:49:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5773BC061574
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 09:49:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4BDACE2595
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 17:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F30C36AE7;
        Fri, 17 Dec 2021 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639763342;
        bh=FdR5Dth1ZoN4GM+AKGCIHDSIXCrV7udFLQnAG5CvLHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bw6EiaVC0D09GE63KxftnDx80LF0O0idKcOlbS+ehna521ePPJAtrvd0tbuC2SmxL
         NNfVu2yUkPTjW67a3FC6OYLwhtf0rCHu1i1qpVz1eCdai66RQ5vwmQgJhJmzH8N/1X
         5b8n9QvS3hcwAtmSb9ecnvwjfSyHL68mj1FxZE2jkN8lFw5DE4Or8le/etE+2Z2/gn
         Mxh4E8yOml7RZQr2JO9k/exn5gmd6WsR2yMvtJw1piGaPgLyB0xqVwN4T20ZRUwvVC
         WpD4xb6Knu48lfZfG7B0sf7roR+CQxiY2CuLuqHix5+B2XbtzsfeMz4MgyMjU3QN43
         se68wHMS5qEeg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 2/7] mt76: mt7915: rely on  mt76_connac_mcu_alloc_wtbl_req
Date:   Fri, 17 Dec 2021 18:48:46 +0100
Message-Id: <de5be711eae18d4d471ec142616a35a5247ab83b.1639763123.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639763123.git.lorenzo@kernel.org>
References: <cover.1639763123.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_alloc_wtbl_req routine and remove
duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  8 +++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 43 ++++---------------
 2 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fc5c870da420..ee512651d9f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -309,8 +309,12 @@ mt76_connac_mcu_alloc_wtbl_req(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		*skb = nskb;
 	}
 
-	if (sta_hdr)
-		sta_hdr->len = cpu_to_le16(sizeof(hdr));
+	if (sta_hdr) {
+		if (is_mt7915(dev))
+			le16_add_cpu(&sta_hdr->len, sizeof(hdr));
+		else
+			sta_hdr->len = cpu_to_le16(sizeof(hdr));
+	}
 
 	return skb_put_data(nskb, &hdr, sizeof(hdr));
 }
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

