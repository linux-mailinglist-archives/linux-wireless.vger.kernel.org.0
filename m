Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E184E25117E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 07:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgHYF3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 01:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgHYF3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 01:29:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D1C061574
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ji4VBIcwno29gBLF3yej07qC7lixrXX1GXJhNwV01B8=; b=ob2fivK1XvgLcTO5MS05uABedY
        vXkpkd3perzzhrZL/WbUK3SXsc+8foFWBpfUOQip/3uVorl0Pxn5K2ehbpkIBPf2OtHkFVqhW9nNc
        zn2ISKZtPfwLiKKBQ6+Qc9/e0YPopN7V4G+cu5dGjIGzGAe/Y7Jy9t10fivizhm0FdrI=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kARWB-0006jr-DB
        for linux-wireless@vger.kernel.org; Tue, 25 Aug 2020 07:29:11 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/9] mt76: mt7915: optimize mt7915_mac_sta_poll
Date:   Tue, 25 Aug 2020 07:29:02 +0200
Message-Id: <20200825052909.36955-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825052909.36955-1-nbd@nbd.name>
References: <20200825052909.36955-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since DMA completion does not imply tx completion, it makes more sense to
poll for airtime from mt7915_mac_tx_free.
Reduce the runtime of the function by moving all items from dev->sta_poll_list
to a local list once and process any stations that were added afterwards
on the next run

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |  1 -
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 13 ++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |  1 -
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 8a1ae08d9572..f6c18a08d414 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -95,7 +95,6 @@ static int mt7915_poll_tx(struct napi_struct *napi, int budget)
 	dev = container_of(napi, struct mt7915_dev, mt76.tx_napi);
 
 	mt7915_tx_cleanup(dev);
-	mt7915_mac_sta_poll(dev);
 
 	tasklet_schedule(&dev->mt76.tx_tasklet);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index ff08a59c747c..06bb8d0103ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -97,7 +97,7 @@ static u32 mt7915_mac_wtbl_lmac_addr(struct mt7915_dev *dev, u16 wcid)
 }
 
 /* TODO: use txfree airtime info to avoid runtime accessing in the long run */
-void mt7915_mac_sta_poll(struct mt7915_dev *dev)
+static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 {
 	static const u8 ac_to_tid[] = {
 		[IEEE80211_AC_BE] = 0,
@@ -114,8 +114,13 @@ void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 	struct ieee80211_sta *sta;
 	struct mt7915_sta *msta;
 	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
+	LIST_HEAD(sta_poll_list);
 	int i;
 
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
 	rcu_read_lock();
 
 	while (true) {
@@ -124,11 +129,11 @@ void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		u16 idx;
 
 		spin_lock_bh(&dev->sta_poll_lock);
-		if (list_empty(&dev->sta_poll_list)) {
+		if (list_empty(&sta_poll_list)) {
 			spin_unlock_bh(&dev->sta_poll_lock);
 			break;
 		}
-		msta = list_first_entry(&dev->sta_poll_list,
+		msta = list_first_entry(&sta_poll_list,
 					struct mt7915_sta, poll_list);
 		list_del_init(&msta->poll_list);
 		spin_unlock_bh(&dev->sta_poll_lock);
@@ -929,6 +934,8 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 		mt76_put_txwi(mdev, txwi);
 	}
 	dev_kfree_skb(skb);
+
+	mt7915_mac_sta_poll(dev);
 }
 
 void mt7915_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index cbe84c4aac75..63d4802b4df4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -436,7 +436,6 @@ mt7915_l2_rmw(struct mt7915_dev *dev, u32 addr, u32 mask, u32 val)
 bool mt7915_mac_wtbl_update(struct mt7915_dev *dev, int idx, u32 mask);
 void mt7915_mac_reset_counters(struct mt7915_phy *phy);
 void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy);
-void mt7915_mac_sta_poll(struct mt7915_dev *dev);
 void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, bool beacon);
-- 
2.28.0

