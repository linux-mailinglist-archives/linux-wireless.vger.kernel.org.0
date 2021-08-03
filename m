Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748513DF696
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Aug 2021 22:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhHCUsu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Aug 2021 16:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhHCUsq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Aug 2021 16:48:46 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A6C061757
        for <linux-wireless@vger.kernel.org>; Tue,  3 Aug 2021 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QWs3BH3XBPnXcej1dOOumZ/7syw392rAMk1Svfrefac=; b=fxkpdFbKaKvDZQ3Rqnx3WzWN0d
        KEA4Gk0OdzyvC6+JMly70STFMMqA5gaP4/XZER9xwyz+YzwJkqa1PaNxdAnZrX6/qx/EBr3Vszqz1
        hUdON951dKRKfUeWv+us+jZr7uoL7ihX/y/87gqNXKTb1cUAKwJ9WzYmuT7cVqNdLYlU=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mB1Ky-00074B-Ch
        for linux-wireless@vger.kernel.org; Tue, 03 Aug 2021 22:48:32 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: fix skb use-after-free on mac reset
Date:   Tue,  3 Aug 2021 22:48:30 +0200
Message-Id: <20210803204830.3862-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When clearing all existing pending tx slots, mt76_tx_complete_skb needs to
be used to free the skbs, to ensure that they are cleared from the status
list as well.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 5a8539d5f030..5455231f5188 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1497,32 +1497,41 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 }
 
 static void
-mt7615_mac_tx_free_token(struct mt7615_dev *dev, u16 token)
+mt7615_txwi_free(struct mt7615_dev *dev, struct mt76_txwi_cache *txwi)
 {
 	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_txwi_cache *txwi;
 	__le32 *txwi_data;
 	u32 val;
 	u8 wcid;
 
-	trace_mac_tx_free(dev, token);
-	txwi = mt76_token_put(mdev, token);
-	if (!txwi)
-		return;
+	mt7615_txp_skb_unmap(mdev, txwi);
+	if (!txwi->skb)
+		goto out;
 
 	txwi_data = (__le32 *)mt76_get_txwi_ptr(mdev, txwi);
 	val = le32_to_cpu(txwi_data[1]);
 	wcid = FIELD_GET(MT_TXD1_WLAN_IDX, val);
+	mt76_tx_complete_skb(mdev, wcid, txwi->skb);
 
-	mt7615_txp_skb_unmap(mdev, txwi);
-	if (txwi->skb) {
-		mt76_tx_complete_skb(mdev, wcid, txwi->skb);
-		txwi->skb = NULL;
-	}
-
+out:
+	txwi->skb = NULL;
 	mt76_put_txwi(mdev, txwi);
 }
 
+static void
+mt7615_mac_tx_free_token(struct mt7615_dev *dev, u16 token)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_txwi_cache *txwi;
+
+	trace_mac_tx_free(dev, token);
+	txwi = mt76_token_put(mdev, token);
+	if (!txwi)
+		return;
+
+	mt7615_txwi_free(dev, txwi);
+}
+
 static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt7615_tx_free *free = (struct mt7615_tx_free *)skb->data;
@@ -2029,16 +2038,8 @@ void mt7615_tx_token_put(struct mt7615_dev *dev)
 	int id;
 
 	spin_lock_bh(&dev->mt76.token_lock);
-	idr_for_each_entry(&dev->mt76.token, txwi, id) {
-		mt7615_txp_skb_unmap(&dev->mt76, txwi);
-		if (txwi->skb) {
-			struct ieee80211_hw *hw;
-
-			hw = mt76_tx_status_get_hw(&dev->mt76, txwi->skb);
-			ieee80211_free_txskb(hw, txwi->skb);
-		}
-		mt76_put_txwi(&dev->mt76, txwi);
-	}
+	idr_for_each_entry(&dev->mt76.token, txwi, id)
+		mt7615_txwi_free(dev, txwi);
 	spin_unlock_bh(&dev->mt76.token_lock);
 	idr_destroy(&dev->mt76.token);
 }
-- 
2.30.1

