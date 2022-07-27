Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEEB58357A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 01:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiG0XBw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 19:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiG0XBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 19:01:44 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C985F2126D
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 16:01:42 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.218])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4A8831C0083;
        Wed, 27 Jul 2022 23:01:41 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 11AB2840082;
        Wed, 27 Jul 2022 23:01:41 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C535013C2B4;
        Wed, 27 Jul 2022 16:01:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C535013C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1658962900;
        bh=U62uDKXFG/RFxHiwu6VCFhIYD7bBNOqB1YVAhzed3QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMhmCRVCxL6DzhlsQU32qOOvq6hxMk01bRidq3Vn3sotonGUNGYmD5m0xwE0wxpBy
         wW3hpuoDcc6kQql1VZbRuaD7jvGao/lP5u7LV1gw+51rfc206/6pPSgkj1f56/8Jwi
         EdJccFmSEAjxXXA9R15vcUDUHaNANsNL0hKlrsdc=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 10/12] wifi: mt76: mt7915: ethtool counters for driver rx path
Date:   Wed, 27 Jul 2022 16:01:20 -0700
Message-Id: <20220727230122.29842-10-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220727230122.29842-1-greearb@candelatech.com>
References: <20220727230122.29842-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1658962901-Sv54ik0-xyn5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Add some per-phy counters for rx errors in the driver.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 48 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 22 +++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 11 +++++
 3 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index ca6748d67ce0..408121c4260f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -488,6 +488,7 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			struct mt76_rx_status *status,
 			struct ieee80211_supported_band *sband,
 			__le32 *rxv, u8 *mode, u8 *nss,
+			struct mib_stats *mib,
 			struct mt76_sta_stats *stats)
 {
 	u32 v0, v2;
@@ -527,15 +528,19 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 		status->encoding = RX_ENC_HT;
 		if (gi)
 			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-		if (i > 31)
+		if (i > 31) {
+			mib->rx_d_bad_ht_rix++;
 			return -EINVAL;
+		}
 		break;
 	case MT_PHY_TYPE_VHT:
 		status->encoding = RX_ENC_VHT;
 		if (gi)
 			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-		if (i > 11)
+		if (i > 11) {
+			mib->rx_d_bad_vht_rix++;
 			return -EINVAL;
+		}
 		break;
 	case MT_PHY_TYPE_HE_MU:
 	case MT_PHY_TYPE_HE_SU:
@@ -550,6 +555,7 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 		status->he_dcm = dcm;
 		break;
 	default:
+		mib->rx_d_bad_mode++;
 		return -EINVAL;
 	}
 	status->rate_idx = i;
@@ -587,6 +593,7 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			stats->rx_bw_160++;
 		break;
 	default:
+		mib->rx_d_bad_bw++;
 		return -EINVAL;
 	}
 
@@ -642,9 +649,12 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	__le16 fc = 0;
 	int idx;
 	struct mt76_sta_stats *stats = NULL;
+	struct mib_stats *mib = &phy->mib;
 
 	memset(status, 0, sizeof(*status));
 
+	mib->rx_d_skb++;
+
 	if ((rxd1 & MT_RXD1_NORMAL_BAND_IDX) && !phy->band_idx) {
 		mphy = dev->mt76.phy2;
 		if (!mphy)
@@ -657,8 +667,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
 		return -EINVAL;
 
-	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
+	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR) {
+		mib->rx_d_rxd2_amsdu_err++;
 		return -EINVAL;
+	}
 
 	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
 	if (hdr_trans && (rxd1 & MT_RXD1_NORMAL_CM))
@@ -692,8 +704,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	else
 		sband = &mphy->sband_2g.sband;
 
-	if (!sband->channels)
+	if (!sband->channels) {
+		mib->rx_d_null_channels++;
 		return -EINVAL;
+	}
 
 	if ((rxd0 & csum_mask) == csum_mask)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -713,8 +727,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	remove_pad = FIELD_GET(MT_RXD2_NORMAL_HDR_OFFSET, rxd2);
 
-	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
+	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR) {
+		mib->rx_d_max_len_err++;
 		return -EINVAL;
+	}
 
 	rxd += 6;
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
@@ -726,8 +742,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, v2);
 
 		rxd += 4;
-		if ((u8 *)rxd - skb->data >= skb->len)
+		if ((u8 *)rxd - skb->data >= skb->len) {
+			mib->rx_d_too_short++;
 			return -EINVAL;
+		}
 	}
 
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
@@ -758,8 +776,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			}
 		}
 		rxd += 4;
-		if ((u8 *)rxd - skb->data >= skb->len)
+		if ((u8 *)rxd - skb->data >= skb->len) {
+			mib->rx_d_too_short++;
 			return -EINVAL;
+		}
 	}
 
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
@@ -781,8 +801,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		}
 
 		rxd += 2;
-		if ((u8 *)rxd - skb->data >= skb->len)
+		if ((u8 *)rxd - skb->data >= skb->len) {
+			mib->rx_d_too_short++;
 			return -EINVAL;
+		}
 	}
 
 	/* RXD Group 3 - P-RXV */
@@ -794,8 +816,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 		rxv = rxd; /* DW16 assuming group 1,2,3,4 */
 		rxd += 2;
-		if ((u8 *)rxd - skb->data >= skb->len)
+		if ((u8 *)rxd - skb->data >= skb->len) {
+			mib->rx_d_too_short++;
 			return -EINVAL;
+		}
 
 		v0 = le32_to_cpu(rxv[0]);  /* DW16, P-VEC1 31:0 */
 		/* DW17, RX_RCPI copied over P-VEC 64:32 Per RX Format doc. */
@@ -816,13 +840,15 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		/* RXD Group 5 - C-RXV */
 		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
 			rxd += 18;
-			if ((u8 *)rxd - skb->data >= skb->len)
+			if ((u8 *)rxd - skb->data >= skb->len) {
+				mib->rx_d_too_short++;
 				return -EINVAL;
+			}
 		}
 
 		if (!is_mt7915(&dev->mt76) || (rxd1 & MT_RXD1_NORMAL_GROUP_5)) {
 			ret = mt7915_mac_fill_rx_rate(dev, status, sband, rxv,
-						      &mode, &nss, stats);
+						      &mode, &nss, mib, stats);
 			if (ret < 0)
 				return ret;
 		} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index db3c32eebb04..b99a667ff251 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1157,6 +1157,17 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"rx_vec_queue_overflow_drop_cnt",
 	"rx_ba_cnt",
 
+	/* driver rx counters */
+	"d_rx_skb",
+	"d_rx_rxd2_amsdu_err",
+	"d_rx_null_channels",
+	"d_rx_max_len_err",
+	"d_rx_too_short",
+	"d_rx_bad_ht_rix",
+	"d_rx_bad_vht_rix",
+	"d_rx_bad_mode",
+	"d_rx_bad_bw",
+
 	/* per vif counters */
 	"v_tx_mpdu_attempts", /* counting any retries */
 	"v_tx_mpdu_fail",  /* frames that failed even after retry */
@@ -1323,6 +1334,17 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->rx_vec_queue_overflow_drop_cnt;
 	data[ei++] = mib->rx_ba_cnt;
 
+	/* rx stats from driver */
+	data[ei++] = mib->rx_d_skb;
+	data[ei++] = mib->rx_d_rxd2_amsdu_err;
+	data[ei++] = mib->rx_d_null_channels;
+	data[ei++] = mib->rx_d_max_len_err;
+	data[ei++] = mib->rx_d_too_short;
+	data[ei++] = mib->rx_d_bad_ht_rix;
+	data[ei++] = mib->rx_d_bad_vht_rix;
+	data[ei++] = mib->rx_d_bad_mode;
+	data[ei++] = mib->rx_d_bad_bw;
+
 	/* Add values for all stations owned by this vif */
 	wi.initial_stat_idx = ei;
 	ieee80211_iterate_stations_atomic(hw, mt7915_ethtool_worker, &wi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 39757e7f00e7..c5401e6e3cda 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -216,6 +216,17 @@ struct mib_stats {
 
 	u32 tx_amsdu[8];
 	u32 tx_amsdu_cnt;
+
+	/* rx stats from the driver */
+	u32 rx_d_skb; /* total skb received in rx path */
+	u32 rx_d_rxd2_amsdu_err;
+	u32 rx_d_null_channels;
+	u32 rx_d_max_len_err;
+	u32 rx_d_too_short;
+	u32 rx_d_bad_ht_rix;
+	u32 rx_d_bad_vht_rix;
+	u32 rx_d_bad_mode;
+	u32 rx_d_bad_bw;
 };
 
 struct mt7915_hif {
-- 
2.20.1

