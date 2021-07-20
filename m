Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864403D01A8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jul 2021 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhGTRqR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 13:46:17 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:58204 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234864AbhGTRmi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 13:42:38 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.48.6])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3BE7CA0074
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jul 2021 18:23:01 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E8D39900086
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jul 2021 18:23:00 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 7D12713C2B4;
        Tue, 20 Jul 2021 11:23:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7D12713C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626805380;
        bh=ka623cxXkdseAethMYgwElhWxgxYXr1PvpL8BeI4ha8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hX+adLLkKrndQjOUWp412GJCNCaNPaMJSDYfTl/z+LxdqXRArF7S1d4+U9jXbHfeX
         ncT4vjfgf9aIKBarf3XosSMTV+nnrZUZ/2g+DH+ACig04pahwj4MAV2cHd5o44YxKF
         vDqzd0JZKZMpjel9HALwFrDbFbfgvjpxyBCydaRs=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 03/11] mt76 - mt7915:  Move TXS parsing to its own method.
Date:   Tue, 20 Jul 2021 11:22:47 -0700
Message-Id: <20210720182256.30536-3-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720182256.30536-1-greearb@candelatech.com>
References: <20210720182256.30536-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626805381-vi5210lMQTnC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This will allow us to also parse TXS when we have no skb on
the status callback list in future patches.

Explicitly cache short_gi and he_gi in wcid, don't try to store
it in the wcid.rate object.  Slightly less confusing and less fragile
when TXS starts parsing lots of frames.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   5 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 123 ++++++++++--------
 2 files changed, 75 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 7ac7d5dc30f8..c7c33d8f984a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -253,7 +253,12 @@ struct mt76_wcid {
 	struct ewma_signal rssi;
 	int inactive_count;
 
+	/* cached rate, updated from mac_sta_poll() and from TXS callback logic, in 7915
+	 * at least.
+	 */
 	struct rate_info rate;
+	bool rate_short_gi; /* cached HT/VHT short_gi, from mac_sta_poll() */
+	u8 rate_he_gi; /* cached HE GI, from mac_sta_poll() */
 
 	struct sk_buff *skb_status_array[MT_PACKET_ID_MAX + 1] ;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1f644c4f3686..0dcbe7403831 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -205,12 +205,18 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 			u8 offs = 24 + 2 * bw;
 
 			rate->he_gi = (val & (0x3 << offs)) >> offs;
+			msta->wcid.rate_he_gi = rate->he_gi; /* cache for later */
 		} else if (rate->flags & RATE_INFO_FLAGS_VHT_MCS) {
-			if (val & BIT(12 + bw))
+			if (val & BIT(12 + bw)) {
 				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
-			else
+				msta->wcid.rate_short_gi = 1;
+			}
+			else {
 				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
+				msta->wcid.rate_short_gi = 0;
+			}
 		}
+		/* TODO:  Deal with HT_MCS */
 	}
 
 	rcu_read_unlock();
@@ -1302,33 +1308,22 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	}
 }
 
-static bool
-mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
-		       __le32 *txs_data, struct mt7915_sta_stats *stats)
+static void
+mt7915_mac_parse_txs(struct mt7915_dev *dev, struct mt76_wcid *wcid,
+		     __le32 *txs_data, struct mt7915_sta_stats *stats,
+		     struct rate_info *rate,
+		     struct ieee80211_tx_info *info)
 {
 	struct ieee80211_supported_band *sband;
-	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_phy *mphy;
-	struct ieee80211_tx_info *info;
-	struct sk_buff_head list;
-	struct rate_info rate = {};
-	struct sk_buff *skb;
-	bool cck = false;
+        struct mt76_phy *mphy;
 	u32 txrate, txs, txs5, txs6, txs7, mode;
-
-	mt76_tx_status_lock(mdev, &list);
-	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
-
-	/* TODO:  Gather stats anyway, even if we are not matching on an skb. */
-	if (!skb)
-		goto out_no_skb;
+	bool cck = false;
 
 	txs = le32_to_cpu(txs_data[0]);
 	txs5 = le32_to_cpu(txs_data[5]);
 	txs6 = le32_to_cpu(txs_data[6]);
 	txs7 = le32_to_cpu(txs_data[7]);
 
-	info = IEEE80211_SKB_CB(skb);
 	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
 		info->flags |= IEEE80211_TX_STAT_ACK;
 
@@ -1344,11 +1339,11 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
 
-	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
-	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
+	rate->mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
+	rate->nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
 
-	stats->tx_nss[rate.nss - 1]++;
-	stats->tx_mcs[rate.mcs]++;
+	stats->tx_nss[rate->nss - 1]++;
+	stats->tx_mcs[rate->mcs]++;
 
 	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
 	switch (mode) {
@@ -1365,73 +1360,95 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		else
 			sband = &mphy->sband_2g.sband;
 
-		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
-		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		rate->mcs = mt76_get_rate(mphy->dev, sband, rate->mcs, cck);
+		rate->legacy = sband->bitrates[rate->mcs].bitrate;
 		break;
 	case MT_PHY_TYPE_HT:
 	case MT_PHY_TYPE_HT_GF:
-		rate.mcs += (rate.nss - 1) * 8;
-		if (rate.mcs > 31)
-			goto out;
+		rate->mcs += (rate->nss - 1) * 8;
+		if (rate->mcs > 31)
+			break;
 
-		rate.flags = RATE_INFO_FLAGS_MCS;
-		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
-			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		rate->flags = RATE_INFO_FLAGS_MCS;
+		if (wcid->rate_short_gi)
+			rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case MT_PHY_TYPE_VHT:
-		if (rate.mcs > 9)
-			goto out;
+		if (rate->mcs > 9)
+			break;
 
-		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		rate->flags = RATE_INFO_FLAGS_VHT_MCS;
+		if (wcid->rate_short_gi)
+			rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case MT_PHY_TYPE_HE_SU:
 	case MT_PHY_TYPE_HE_EXT_SU:
 	case MT_PHY_TYPE_HE_TB:
 	case MT_PHY_TYPE_HE_MU:
-		if (rate.mcs > 11)
-			goto out;
+		if (rate->mcs > 11)
+			break;
 
-		rate.he_gi = wcid->rate.he_gi;
-		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
-		rate.flags = RATE_INFO_FLAGS_HE_MCS;
+		rate->he_gi = wcid->rate_he_gi;
+		rate->he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
+		rate->flags = RATE_INFO_FLAGS_HE_MCS;
 		break;
 	default:
-		goto out;
+		WARN_ON_ONCE(true);
+		mode = 0;
 	}
 
 	stats->tx_mode[mode]++;
 
 	switch (FIELD_GET(MT_TXS0_BW, txs)) {
 	case IEEE80211_STA_RX_BW_160:
-		rate.bw = RATE_INFO_BW_160;
+		rate->bw = RATE_INFO_BW_160;
 		stats->tx_bw[3]++;
 		break;
 	case IEEE80211_STA_RX_BW_80:
-		rate.bw = RATE_INFO_BW_80;
+		rate->bw = RATE_INFO_BW_80;
 		stats->tx_bw[2]++;
 		break;
 	case IEEE80211_STA_RX_BW_40:
-		rate.bw = RATE_INFO_BW_40;
+		rate->bw = RATE_INFO_BW_40;
 		stats->tx_bw[1]++;
 		break;
 	default:
-		rate.bw = RATE_INFO_BW_20;
+		rate->bw = RATE_INFO_BW_20;
 		stats->tx_bw[0]++;
 		break;
 	}
+}
 
-	/* Cache rate for packets that don't get a TXS callback for some
-	 * reason.
+static void
+mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
+		       __le32 *txs_data, struct mt7915_sta_stats *stats)
+{
+        struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_tx_info info_stack;
+	struct sk_buff_head list;
+	/* rate is cached in wcid->rate for skbs that do not request to be
+	 * paired with TXS data.  This is normal datapath.
 	 */
-	wcid->rate = rate;
+	struct rate_info *rate = &wcid->rate;
+	struct sk_buff *skb;
 
-out:
-	mt76_tx_status_skb_done(mdev, skb, &list, wcid);
+	mt76_tx_status_lock(mdev, &list);
+	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
 
-out_no_skb:
-	mt76_tx_status_unlock(mdev, &list);
+	memset(rate, 0, sizeof(*rate));
 
-	return !!skb;
+	if (skb)
+		info = IEEE80211_SKB_CB(skb);
+	else
+		info = &info_stack;
+
+	mt7915_mac_parse_txs(dev, wcid, txs_data, stats, rate, info);
+
+	if (skb)
+		mt76_tx_status_skb_done(mdev, skb, &list, wcid);
+
+	mt76_tx_status_unlock(mdev, &list);
 }
 
 static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
-- 
2.20.1

