Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113FB34B54D
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Mar 2021 08:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhC0H4O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Mar 2021 03:56:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41834 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231249AbhC0Hzh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Mar 2021 03:55:37 -0400
X-UUID: 1b9b066949cb4885866729e023c9e9fd-20210327
X-UUID: 1b9b066949cb4885866729e023c9e9fd-20210327
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1489641134; Sat, 27 Mar 2021 15:55:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 27 Mar 2021 15:55:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 27 Mar 2021 15:55:29 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: report Rx timestamp
Date:   Sat, 27 Mar 2021 15:55:27 +0800
Message-ID: <ae8caa3a01d527e464b09b4932d6cca14b1d49a2.1616831454.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Frame reception timestamp (low 32-bits) that indicates the value of the
local TSF timer value at the time the first bit of the MAC header in the
received frame (PPDU unit) arriving at the MAC.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 31 ++++++++++--------
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 32 ++++++++++---------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 29 +++++++++--------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 29 +++++++++--------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
 11 files changed, 74 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 144e8a8910ba..a37b8db979c6 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -77,7 +77,7 @@ mt76_rx_aggr_check_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames)
 		nframes--;
 		status = (struct mt76_rx_status *)skb->cb;
 		if (!time_after(jiffies,
-				status->reorder_time +
+				(unsigned long)status->reorder_time +
 				mt76_aggr_tid_to_timeo(tid->num)))
 			continue;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 7684a8cf00fb..9a42b0adafaa 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -761,6 +761,7 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 	status->signal = mstat.signal;
 	status->chains = mstat.chains;
 	status->ampdu_reference = mstat.ampdu_ref;
+	status->mactime = mstat.mactime;
 
 	BUILD_BUG_ON(sizeof(mstat) > sizeof(skb->cb));
 	BUILD_BUG_ON(sizeof(status->chain_signal) !=
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b09b0f5ffd6d..3d31a47b5ded 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -498,9 +498,10 @@ struct mt76_rx_status {
 		u16 wcid_idx;
 	};
 
-	unsigned long reorder_time;
+	u32 reorder_time;
 
 	u32 ampdu_ref;
+	u32 mactime;
 
 	u8 iv[6];
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index c29b60a87819..f3803a5eb950 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -532,20 +532,6 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
 	}
 
-	if (!(rxd2 & (MT_RXD2_NORMAL_NON_AMPDU_SUB |
-		      MT_RXD2_NORMAL_NON_AMPDU))) {
-		status->flag |= RX_FLAG_AMPDU_DETAILS;
-
-		/* all subframes of an A-MPDU have the same timestamp */
-		if (dev->rx_ampdu_ts != rxd[12]) {
-			if (!++dev->ampdu_ref)
-				dev->ampdu_ref++;
-		}
-		dev->rx_ampdu_ts = rxd[12];
-
-		status->ampdu_ref = dev->ampdu_ref;
-	}
-
 	remove_pad = rxd1 & MT_RXD1_NORMAL_HDR_OFFSET;
 
 	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
@@ -579,6 +565,23 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 			return -EINVAL;
 	}
 	if (rxd0 & MT_RXD0_NORMAL_GROUP_2) {
+		status->mactime = le32_to_cpu(rxd[0]);
+		status->flag |= RX_FLAG_MACTIME_START;
+
+		if (!(rxd2 & (MT_RXD2_NORMAL_NON_AMPDU_SUB |
+			      MT_RXD2_NORMAL_NON_AMPDU))) {
+			status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+			/* all subframes of an A-MPDU have the same timestamp */
+			if (dev->rx_ampdu_ts != status->mactime) {
+				if (!++dev->ampdu_ref)
+					dev->ampdu_ref++;
+			}
+			dev->rx_ampdu_ts = status->mactime;
+
+			status->ampdu_ref = dev->ampdu_ref;
+		}
+
 		rxd += 2;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index b787c56fd8d6..1df5b9fed2bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -120,7 +120,7 @@ struct mt7603_dev {
 	unsigned long last_cca_adj;
 
 	u32 ampdu_ref;
-	__le32 rx_ampdu_ts;
+	u32 rx_ampdu_ts;
 	u8 rssi_offset[3];
 
 	u8 slottime;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 6a1395de3066..6ee8f6709191 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -235,7 +235,6 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
-	__le32 rxd12 = rxd[12];
 	bool unicast, hdr_trans, remove_pad, insert_ccmp_hdr = false;
 	int phy_idx;
 	int i, idx;
@@ -329,6 +328,23 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	}
 
 	if (rxd0 & MT_RXD0_NORMAL_GROUP_2) {
+		status->mactime = le32_to_cpu(rxd[0]);
+		status->flag |= RX_FLAG_MACTIME_START;
+
+		if (!(rxd2 & (MT_RXD2_NORMAL_NON_AMPDU_SUB |
+			      MT_RXD2_NORMAL_NON_AMPDU))) {
+			status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+			/* all subframes of an A-MPDU have the same timestamp */
+			if (phy->rx_ampdu_ts != status->mactime) {
+				if (!++phy->ampdu_ref)
+					phy->ampdu_ref++;
+			}
+			phy->rx_ampdu_ts = status->mactime;
+
+			status->ampdu_ref = phy->ampdu_ref;
+		}
+
 		rxd += 2;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
@@ -372,20 +388,6 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	if (!sband->channels)
 		return -EINVAL;
 
-	if (!(rxd2 & (MT_RXD2_NORMAL_NON_AMPDU_SUB |
-		      MT_RXD2_NORMAL_NON_AMPDU))) {
-		status->flag |= RX_FLAG_AMPDU_DETAILS;
-
-		/* all subframes of an A-MPDU have the same timestamp */
-		if (phy->rx_ampdu_ts != rxd12) {
-			if (!++phy->ampdu_ref)
-				phy->ampdu_ref++;
-		}
-		phy->rx_ampdu_ts = rxd12;
-
-		status->ampdu_ref = phy->ampdu_ref;
-	}
-
 	if (rxd0 & MT_RXD0_NORMAL_GROUP_3) {
 		u32 rxdg0 = le32_to_cpu(rxd[0]);
 		u32 rxdg1 = le32_to_cpu(rxd[1]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index dbabdeef4e0b..6a50338ec9f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -168,7 +168,7 @@ struct mt7615_phy {
 	u8 rdd_state;
 	int dfs_state;
 
-	__le32 rx_ampdu_ts;
+	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
 
 	struct mib_stats mib;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 0924ae074db2..559f81801f53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -389,19 +389,6 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
 	}
 
-	if (!(rxd2 & MT_RXD2_NORMAL_NON_AMPDU)) {
-		status->flag |= RX_FLAG_AMPDU_DETAILS;
-
-		/* all subframes of an A-MPDU have the same timestamp */
-		if (phy->rx_ampdu_ts != rxd[14]) {
-			if (!++phy->ampdu_ref)
-				phy->ampdu_ref++;
-		}
-		phy->rx_ampdu_ts = rxd[14];
-
-		status->ampdu_ref = phy->ampdu_ref;
-	}
-
 	remove_pad = FIELD_GET(MT_RXD2_NORMAL_HDR_OFFSET, rxd2);
 
 	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
@@ -440,6 +427,22 @@ int mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	}
 
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
+		status->mactime = le32_to_cpu(rxd[0]);
+		status->flag |= RX_FLAG_MACTIME_START;
+
+		if (!(rxd2 & MT_RXD2_NORMAL_NON_AMPDU)) {
+			status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+			/* all subframes of an A-MPDU have the same timestamp */
+			if (phy->rx_ampdu_ts != status->mactime) {
+				if (!++phy->ampdu_ref)
+					phy->ampdu_ref++;
+			}
+			phy->rx_ampdu_ts = status->mactime;
+
+			status->ampdu_ref = phy->ampdu_ref;
+		}
+
 		rxd += 2;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 1160d1bf8a7c..455c84cd99c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -142,7 +142,7 @@ struct mt7915_phy {
 	u8 rdd_state;
 	int dfs_state;
 
-	__le32 rx_ampdu_ts;
+	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
 
 	struct mib_stats mib;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 6f13eef96078..3ee81afcb535 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -370,19 +370,6 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
 	}
 
-	if (!(rxd2 & MT_RXD2_NORMAL_NON_AMPDU)) {
-		status->flag |= RX_FLAG_AMPDU_DETAILS;
-
-		/* all subframes of an A-MPDU have the same timestamp */
-		if (phy->rx_ampdu_ts != rxd[14]) {
-			if (!++phy->ampdu_ref)
-				phy->ampdu_ref++;
-		}
-		phy->rx_ampdu_ts = rxd[14];
-
-		status->ampdu_ref = phy->ampdu_ref;
-	}
-
 	remove_pad = FIELD_GET(MT_RXD2_NORMAL_HDR_OFFSET, rxd2);
 
 	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
@@ -414,6 +401,22 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	}
 
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
+		status->mactime = le32_to_cpu(rxd[0]);
+		status->flag |= RX_FLAG_MACTIME_START;
+
+		if (!(rxd2 & MT_RXD2_NORMAL_NON_AMPDU)) {
+			status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+			/* all subframes of an A-MPDU have the same timestamp */
+			if (phy->rx_ampdu_ts != status->mactime) {
+				if (!++phy->ampdu_ref)
+					phy->ampdu_ref++;
+			}
+			phy->rx_ampdu_ts = status->mactime;
+
+			status->ampdu_ref = phy->ampdu_ref;
+		}
+
 		rxd += 2;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 5cedefc41416..816d54374e8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -132,7 +132,7 @@ struct mt7921_phy {
 	s16 coverage_class;
 	u8 slottime;
 
-	__le32 rx_ampdu_ts;
+	u32 rx_ampdu_ts;
 	u32 ampdu_ref;
 
 	struct mib_stats mib;
-- 
2.18.0

