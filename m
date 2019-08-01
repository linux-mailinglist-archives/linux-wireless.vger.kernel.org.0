Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1DE7D78A
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 10:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfHAI0g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 04:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbfHAI0g (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 04:26:36 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A537D2087E;
        Thu,  1 Aug 2019 08:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564647995;
        bh=MRxF/WiOn3MCkp6vE6CqUB0rjER3bp7WCzVrN53Lb1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uqu2z48KkeQWa6IvBi5LL/2iWckijBBChPABZLylYjRG/cRIOvduACxNLoJk4iUzQ
         1eXYEP7g0UaG4KBTmu6o9AZ5ce6ZngqAT/wVJkbAlDEL9IX8wtPtNVAt5HuZHxIf5t
         fKj2JSk3DdToo5tvuR8nERT/jwwNza9Myy4n61/Y=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sgruszka@redhat.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt76x02: do not copy beacon skb in mt76x02_mac_set_beacon_enable
Date:   Thu,  1 Aug 2019 10:26:23 +0200
Message-Id: <7fa4e88611d1e76e8b0ef7ec1c438fcf3abee907.1564647482.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564647482.git.lorenzo@kernel.org>
References: <cover.1564647482.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not copy beacon skb in mt76x02_mac_set_beacon_enable for usb devices
since it will be done in mt76x02_update_beacon_iter. Moreover squash
mt76x02_mac_set_beacon_enable and __mt76x02_mac_set_beacon_enable since
the latter is run just by mt76x02_mac_set_beacon_enable

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 61 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  2 +-
 2 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index 089aab74ae99..ae2565071137 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -115,51 +115,40 @@ int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
 }
 EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon);
 
-static void
-__mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev, u8 vif_idx,
-				bool val, struct sk_buff *skb)
-{
-	u8 old_mask = dev->mt76.beacon_mask;
-	bool en;
-	u32 reg;
-
-	if (val) {
-		dev->mt76.beacon_mask |= BIT(vif_idx);
-		if (skb)
-			mt76x02_mac_set_beacon(dev, vif_idx, skb);
-	} else {
-		dev->mt76.beacon_mask &= ~BIT(vif_idx);
-		mt76x02_mac_set_beacon(dev, vif_idx, NULL);
-	}
-
-	if (!!old_mask == !!dev->mt76.beacon_mask)
-		return;
-
-	en = dev->mt76.beacon_mask;
-
-	reg = MT_BEACON_TIME_CFG_BEACON_TX |
-	      MT_BEACON_TIME_CFG_TBTT_EN |
-	      MT_BEACON_TIME_CFG_TIMER_EN;
-	mt76_rmw(dev, MT_BEACON_TIME_CFG, reg, reg * en);
-	mt76x02_beacon_enable(dev, en);
-}
-
 void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
-				   struct ieee80211_vif *vif, bool val)
+				   struct ieee80211_vif *vif, bool enable)
 {
-	u8 vif_idx = ((struct mt76x02_vif *)vif->drv_priv)->idx;
-	struct sk_buff *skb = NULL;
+	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
+	u8 old_mask = dev->mt76.beacon_mask;
 
 	mt76x02_pre_tbtt_enable(dev, false);
 
-	if (mt76_is_usb(dev))
-		skb = ieee80211_beacon_get(mt76_hw(dev), vif);
-
 	if (!dev->mt76.beacon_mask)
 		dev->tbtt_count = 0;
 
-	__mt76x02_mac_set_beacon_enable(dev, vif_idx, val, skb);
+	if (enable) {
+		dev->mt76.beacon_mask |= BIT(mvif->idx);
+	} else {
+		dev->mt76.beacon_mask &= ~BIT(mvif->idx);
+		mt76x02_mac_set_beacon(dev, mvif->idx, NULL);
+	}
 
+	if (!!old_mask == !!dev->mt76.beacon_mask)
+		goto out;
+
+	if (dev->mt76.beacon_mask)
+		mt76_set(dev, MT_BEACON_TIME_CFG,
+			 MT_BEACON_TIME_CFG_BEACON_TX |
+			 MT_BEACON_TIME_CFG_TBTT_EN |
+			 MT_BEACON_TIME_CFG_TIMER_EN);
+	else
+		mt76_clear(dev, MT_BEACON_TIME_CFG,
+			   MT_BEACON_TIME_CFG_BEACON_TX |
+			   MT_BEACON_TIME_CFG_TBTT_EN |
+			   MT_BEACON_TIME_CFG_TIMER_EN);
+	mt76x02_beacon_enable(dev, !!dev->mt76.beacon_mask);
+
+out:
 	mt76x02_pre_tbtt_enable(dev, true);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index cb39da79527a..4a84db7e8522 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -207,7 +207,7 @@ void mt76x02_mac_set_bssid(struct mt76x02_dev *dev, u8 idx, const u8 *addr);
 int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
 			   struct sk_buff *skb);
 void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
-				   struct ieee80211_vif *vif, bool val);
+				   struct ieee80211_vif *vif, bool enable);
 
 void mt76x02_edcca_init(struct mt76x02_dev *dev);
 #endif
-- 
2.21.0

