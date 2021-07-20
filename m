Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D23D019F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jul 2021 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhGTRot (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 13:44:49 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:49714 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234895AbhGTRmk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 13:42:40 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.50.13])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 29F74A0075
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jul 2021 18:23:02 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E16DD440078
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jul 2021 18:23:01 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 98E6613C2BF;
        Tue, 20 Jul 2021 11:23:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 98E6613C2BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626805381;
        bh=fw9TM9+Q8hYX5+vRYc6jd+aPv37P3LU4jYTF/w/Hljw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dG5gAQ420CDO8EE3gPRoPhnGGEUmJo5PUf1D3bQqz7Al6QlQkGjm8qWJE7S5j/708
         +ie1i+juif3twLnIy3tEe1vAccRT2H2kUIcV0aKazd/A3tX6rccbxlTHrFsCmZlQHR
         7RuvmUPM8T7qMBwQNy4xr6nXpkmRG+FO1L9i5tz8=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 10/11] mt76: mt7915:  Report tx-retries
Date:   Tue, 20 Jul 2021 11:22:54 -0700
Message-Id: <20210720182256.30536-10-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720182256.30536-1-greearb@candelatech.com>
References: <20210720182256.30536-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626805382-y1kZPqiwyYpE
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

mac80211 stack will only report tx-status for skb claiming to be ampdu heads,
so lie a bit in mt7915 and set the flag so that mac80211 will record status
for each skb.

mt7915 appears to report retry status on an individual per-skb manner,
so that method above seems to work.

Re-constitute the txinfo status rate info so that the rix and flags
is also at least close to correct.  No direct way to report HE
rates that way, so mac80211 might could use some tweaking in
the ieee80211_tx_status_ext to take both info and status->rate
into account.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 82 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  4 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |  6 +-
 4 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index fb3161c08baf..8f4f41db5ef8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -217,6 +217,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	struct wiphy *wiphy = hw->wiphy;
 
 	hw->queues = 4;
+	hw->max_report_rates = 1;
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
 	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
 	hw->netdev_features = NETIF_F_RXCSUM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 0cacfdf91a11..e77341ca127c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1260,17 +1260,22 @@ mt7915_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 
 static void
 mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
-		 struct ieee80211_sta *sta, struct list_head *free_list)
+		 struct ieee80211_sta *sta, struct list_head *free_list,
+		 u32 tx_cnt, u32 tx_status, u32 ampdu)
 {
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_wcid *wcid;
 	__le32 *txwi;
 	u16 wcid_idx;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_tx_rate *rate;
 
 	mt7915_txp_skb_unmap(mdev, t);
 	if (!t->skb)
 		goto out;
 
+	rcu_read_lock();
+
 	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
 	if (sta) {
 		wcid = (struct mt76_wcid *)sta->drv_priv;
@@ -1280,10 +1285,68 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 			mt7915_tx_check_aggr(sta, txwi);
 	} else {
 		wcid_idx = FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
+		wcid = rcu_dereference(mdev->wcid[wcid_idx]);
+	}
+
+	info = IEEE80211_SKB_CB(t->skb);
+	memset(&info->status, 0, sizeof(info->status));
+
+	rate = &info->status.rates[0];
+	rate->idx = -1; /* will over-write below if we found wcid */
+	info->status.rates[1].idx = -1; /* terminate rate list */
+
+	/* force TX_STAT_AMPDU to be set, or mac80211 will ignore status */
+	if (ampdu || (info->flags & IEEE80211_TX_CTL_AMPDU)) {
+		info->flags |= IEEE80211_TX_STAT_AMPDU | IEEE80211_TX_CTL_AMPDU;
+		info->status.ampdu_len = 1;
+	}
+
+	/* update info status based on cached wcid rate info since
+	 * txfree path doesn't give us a lot of info.
+	 */
+	if (wcid) {
+		if (wcid->rate.flags & RATE_INFO_FLAGS_MCS) {
+			rate->flags |= IEEE80211_TX_RC_MCS;
+			rate->idx = wcid->rate.mcs + wcid->rate.nss * 8;
+		}
+		else if (wcid->rate.flags & RATE_INFO_FLAGS_VHT_MCS) {
+			rate->flags |= IEEE80211_TX_RC_VHT_MCS;
+			rate->idx = (wcid->rate.nss << 4) | wcid->rate.mcs;
+		}
+		else if (wcid->rate.flags & RATE_INFO_FLAGS_HE_MCS) {
+			rate->idx = (wcid->rate.nss << 4) | wcid->rate.mcs;
+		}
+		else {
+			rate->idx = wcid->rate.mcs;
+		}
+
+		switch (wcid->rate.bw) {
+		case RATE_INFO_BW_160:
+			rate->flags |= IEEE80211_TX_RC_160_MHZ_WIDTH;
+			break;
+		case RATE_INFO_BW_80:
+			rate->flags |= IEEE80211_TX_RC_80_MHZ_WIDTH;
+			break;
+		case RATE_INFO_BW_40:
+			rate->flags |= IEEE80211_TX_RC_40_MHZ_WIDTH;
+			break;
+		}
+	}
+
+	/* Apply the values that this txfree path reports */
+	rate->count = tx_cnt;
+	if (tx_status == 0) {
+		info->flags |= IEEE80211_TX_STAT_ACK;
+		info->status.ampdu_ack_len = 1;
+	}
+	else {
+		info->flags &= ~IEEE80211_TX_STAT_ACK;
 	}
 
 	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
 
+	rcu_read_unlock();
+
 out:
 	t->skb = NULL;
 	mt76_put_txwi(mdev, t);
@@ -1299,7 +1362,8 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	struct ieee80211_sta *sta = NULL;
 	LIST_HEAD(free_list);
 	struct sk_buff *tmp;
-	u8 i, count;
+	u8 i;
+	u16 count;
 	bool wake = false;
 
 	/* clean DMA queues and unmap buffers first */
@@ -1315,9 +1379,12 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	 * to the time ack is received or dropped by hw (air + hw queue time).
 	 * Should avoid accessing WTBL to get Tx airtime, and use it instead.
 	 */
+	/* free->ctrl is high u16 of first DW in the txfree struct */
 	count = FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
 	for (i = 0; i < count; i++) {
-		u32 msdu, info = le32_to_cpu(free->info[i]);
+		u32 msdu, tx_cnt, tx_status;
+		u32 info = le32_to_cpu(free->info[i]); /* DW3+ */
+		u32 ampdu;
 
 		/*
 		 * 1'b1: new wcid pair.
@@ -1348,7 +1415,12 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 		if (!txwi)
 			continue;
 
-		mt7915_txwi_free(dev, txwi, sta, &free_list);
+		tx_cnt = FIELD_GET(MT_TX_FREE_TXCNT, info);
+		/* 0 = success, 1 dropped-by-hw, 2 dropped-by-cpu */
+		tx_status = FIELD_GET(MT_TX_FREE_STATUS, info);
+		ampdu = FIELD_GET(MT_TX_FREE_HEAD_OF_PAGE, info);
+
+		mt7915_txwi_free(dev, txwi, sta, &free_list, tx_cnt, tx_status, ampdu);
 	}
 
 	mt7915_mac_sta_poll(dev);
@@ -1876,7 +1948,7 @@ void mt7915_tx_token_put(struct mt7915_dev *dev)
 
 	spin_lock_bh(&dev->mt76.token_lock);
 	idr_for_each_entry(&dev->mt76.token, txwi, id) {
-		mt7915_txwi_free(dev, txwi, NULL, NULL);
+		mt7915_txwi_free(dev, txwi, NULL, NULL, 0, 1, 0);
 		dev->mt76.token_count--;
 	}
 	spin_unlock_bh(&dev->mt76.token_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 741d51b0fa06..3f8fbed144df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -299,7 +299,7 @@ struct mt7915_tx_free {
 	__le16 ctrl;
 	u8 txd_cnt;
 	u8 rsv[3];
-	__le32 info[];
+	__le32 info[]; /* DW3+ */
 } __packed __aligned(4);
 
 #define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
@@ -311,6 +311,8 @@ struct mt7915_tx_free {
 /* when configured for txcount mode.  See MT_PLE_HOST_RPT0_TX_LATENCY. */
 #define MT_TX_FREE_TXCNT		GENMASK(12, 0)
 #define MT_TX_FREE_STATUS		GENMASK(14, 13)
+/* 0:  not MPDU, 1:  MSDU is head pkt of TXD page (MPDU) */
+#define MT_TX_FREE_HEAD_OF_PAGE		BIT(15)
 #define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
 #define MT_TX_FREE_PAIR			BIT(31)
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 971f6e2e0c80..cba6d8109377 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -263,6 +263,7 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 	struct ieee80211_tx_status status = {
 		.skb = skb,
 		.free_list = free_list,
+		.info = IEEE80211_SKB_CB(skb),
 	};
 	struct mt76_wcid *wcid = NULL;
 	struct ieee80211_hw *hw;
@@ -270,8 +271,11 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 
 	rcu_read_lock();
 
-	if (wcid_idx < ARRAY_SIZE(dev->wcid))
+	if (wcid_idx < ARRAY_SIZE(dev->wcid)) {
 		wcid = rcu_dereference(dev->wcid[wcid_idx]);
+		if (wcid)
+			status.rate = &wcid->rate;
+	}
 
 	mt76_tx_check_non_aql(dev, wcid, skb);
 
-- 
2.20.1

