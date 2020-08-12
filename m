Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA5242B9A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgHLOts (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 10:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgHLOtr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 10:49:47 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F21C061383
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zZQFy3/TzGRf8SjBOx/sRbPojS/zlFBTacvk+sj69gs=; b=mRlspWhIk6sdv2snscICdRLvMd
        pPZcSzmp1fm1KJHuqwa/ZZmBegFjjS2UXkquYvOgsIDlteuRfPNJc0yv85nU8MGHX4QLYIwOkGFbq
        urVtMerQr/5jV6yYHP4DxU+nU1VND9NgjhGypya4myAvxylRNKbymavL2CP7ZRDJjVU4=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k5s4X-0001Xm-0C; Wed, 12 Aug 2020 16:49:45 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH 5.9] mt76: mt7915: use ieee80211_free_txskb to free tx skbs
Date:   Wed, 12 Aug 2020 16:49:43 +0200
Message-Id: <20200812144943.91974-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Using dev_kfree_skb for tx skbs breaks AQL. This worked until now only
by accident, because a mac80211 issue breaks AQL on drivers with firmware
rate control that report the rate via ieee80211_tx_status_ext as struct
rate_info.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 8 ++++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c  | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index aadf56e80bae..d7a3b05ab50c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -691,8 +691,12 @@ void mt7915_unregister_device(struct mt7915_dev *dev)
 	spin_lock_bh(&dev->token_lock);
 	idr_for_each_entry(&dev->token, txwi, id) {
 		mt7915_txp_skb_unmap(&dev->mt76, txwi);
-		if (txwi->skb)
-			dev_kfree_skb_any(txwi->skb);
+		if (txwi->skb) {
+			struct ieee80211_hw *hw;
+
+			hw = mt76_tx_status_get_hw(&dev->mt76, txwi->skb);
+			ieee80211_free_txskb(hw, txwi->skb);
+		}
 		mt76_put_txwi(&dev->mt76, txwi);
 	}
 	spin_unlock_bh(&dev->token_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index a264e304a3df..5800b2d1fb23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -844,7 +844,7 @@ mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (sta || !(info->flags & IEEE80211_TX_CTL_NO_ACK))
 		mt7915_tx_status(sta, hw, info, NULL);
 
-	dev_kfree_skb(skb);
+	ieee80211_free_txskb(hw, skb);
 }
 
 void mt7915_txp_skb_unmap(struct mt76_dev *dev,
-- 
2.28.0

