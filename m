Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD937D73E9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjJYTJ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjJYTJ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:09:28 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2616BB
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:09:25 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 795CF1C0068
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 19:09:23 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id E486313C2B0;
        Wed, 25 Oct 2023 12:09:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E486313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698260963;
        bh=Jbo2b+T/36bXvFtNdxUhXAe+mNPJtj/XmB/ehahsWLo=;
        h=From:To:Cc:Subject:Date:From;
        b=R3zqX5DPZG9upic0pilwi4VwNEZ1Ye6mZLckW5Un1w0F6av70dOu8qweI0yxefNuH
         Fn5p47uyb1B3ZDak7yiusfjQayrA0y2OoG86Af+av4WfsQVktmLKQkhFvfKbTBIZ/c
         /jMdK2uuYjPDCwq3I2QAndCkjFCAWExqpy9G/q8U=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 10/12] wifi: mt76: mt7915: ethtool counters for driver rx path
Date:   Wed, 25 Oct 2023 12:09:18 -0700
Message-Id: <20231025190920.2142693-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698260964-r06CzG6CDeEt
X-MDID-O: us5;ut7;1698260964;r06CzG6CDeEt;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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
 drivers/net/wireless/mediatek/mt76/mt76.h     | 11 ++++++
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  1 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 11 +++++-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 38 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 22 +++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  4 +-
 6 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 35a333ae3d84..299d6f1f9649 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -961,6 +961,17 @@ struct mt76_mib_stats {
 	u32 tx_amsdu[8];
 	u32 tx_amsdu_cnt;
 
+	/* rx stats from the driver */
+	unsigned long rx_d_skb; /* total skb received in rx path */
+	u32 rx_d_rxd2_amsdu_err;
+	u32 rx_d_null_channels;
+	u32 rx_d_max_len_err;
+	u32 rx_d_too_short;
+	u32 rx_d_bad_ht_rix;
+	u32 rx_d_bad_vht_rix;
+	u32 rx_d_bad_mode;
+	u32 rx_d_bad_bw;
+
 	/* mcu_muru_stats */
 	u32 dl_cck_cnt;
 	u32 dl_ofdm_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 8d501db26c5a..631d349ace82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -425,6 +425,7 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 				  struct mt76_rx_status *status,
 				  struct ieee80211_supported_band *sband,
 				  __le32 *rxv, u8 *mode, u8 *nss,
+				  struct mt76_mib_stats *mib,
 				  struct mt76_sta_stats *stats);
 void mt76_connac2_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
 void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index d349329a8168..c56881bc2ab3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1015,6 +1015,7 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 				  struct mt76_rx_status *status,
 				  struct ieee80211_supported_band *sband,
 				  __le32 *rxv, u8 *mode, u8 *nss,
+				  struct mt76_mib_stats *mib,
 				  struct mt76_sta_stats *stats)
 {
 	u32 v0, v2;
@@ -1062,15 +1063,19 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 		*nss = i / 8 + 1;
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
@@ -1085,6 +1090,7 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 		status->he_dcm = dcm;
 		break;
 	default:
+		mib->rx_d_bad_mode++;
 		return -EINVAL;
 	}
 	status->rate_idx = i;
@@ -1121,6 +1127,7 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 			stats->rx_bw_160++;
 		break;
 	default:
+		mib->rx_d_bad_bw++;
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 40f3320edc02..05f1b1fa4080 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -308,9 +308,12 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 	__le16 fc = 0;
 	int idx;
 	struct mt76_sta_stats *stats = NULL;
+	struct mt76_mib_stats *mib = &phy->mib;
 
 	memset(status, 0, sizeof(*status));
 
+	mib->rx_d_skb++;
+
 	if ((rxd1 & MT_RXD1_NORMAL_BAND_IDX) && !phy->mt76->band_idx) {
 		mphy = dev->mt76.phys[MT_BAND1];
 		if (!mphy)
@@ -323,8 +326,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
 		return -EINVAL;
 
-	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
+	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR) {
+		mib->rx_d_rxd2_amsdu_err++;
 		return -EINVAL;
+	}
 
 	hdr_trans = rxd2 & MT_RXD2_NORMAL_HDR_TRANS;
 	if (hdr_trans && (rxd1 & MT_RXD1_NORMAL_CM))
@@ -357,8 +362,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 	else
 		sband = &mphy->sband_2g.sband;
 
-	if (!sband->channels)
+	if (!sband->channels) {
+		mib->rx_d_null_channels++;
 		return -EINVAL;
+	}
 
 	if ((rxd0 & csum_mask) == csum_mask &&
 	    !(csum_status & (BIT(0) | BIT(2) | BIT(3))))
@@ -379,8 +386,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 
 	remove_pad = FIELD_GET(MT_RXD2_NORMAL_HDR_OFFSET, rxd2);
 
-	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
+	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR) {
+		mib->rx_d_max_len_err++;
 		return -EINVAL;
+	}
 
 	rxd += 6;
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
@@ -392,8 +401,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 		seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, v2);
 
 		rxd += 4;
-		if ((u8 *)rxd - skb->data >= skb->len)
+		if ((u8 *)rxd - skb->data >= skb->len) {
+			mib->rx_d_too_short++;
 			return -EINVAL;
+		}
 	}
 
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
@@ -423,8 +434,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
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
@@ -445,8 +458,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 		}
 
 		rxd += 2;
-		if ((u8 *)rxd - skb->data >= skb->len)
+		if ((u8 *)rxd - skb->data >= skb->len) {
+			mib->rx_d_too_short++;
 			return -EINVAL;
+		}
 	}
 
 	/* RXD Group 3 - P-RXV */
@@ -458,8 +473,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 
 		rxv = rxd;
 		rxd += 2;
-		if ((u8 *)rxd - skb->data >= skb->len)
+		if ((u8 *)rxd - skb->data >= skb->len) {
+			mib->rx_d_too_short++;
 			return -EINVAL;
+		}
 
 		v0 = le32_to_cpu(rxv[0]);
 		v1 = le32_to_cpu(rxv[1]);
@@ -479,14 +496,17 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
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
 			ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status,
 							    sband, rxv, &mode,
-							    &nss, stats);
+							    &nss, mib,
+							    stats);
 			if (ret < 0)
 				return ret;
 		} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 05b633932e16..7fb60178939b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1357,6 +1357,17 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"ul_hetrig_3mu_cnt",
 	"ul_hetrig_4mu_cnt",
 
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
@@ -1567,6 +1578,17 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->ul_hetrig_3mu_cnt;
 	data[ei++] = mib->ul_hetrig_4mu_cnt;
 
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 9f2c8a3a4202..26defc8930ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -190,6 +190,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	u8 mode = 0;
 	int i, idx;
 	struct mt76_sta_stats *stats = NULL;
+	struct mt76_mib_stats *mib = &phy->mib;
 
 	memset(status, 0, sizeof(*status));
 
@@ -349,7 +350,8 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 			status->enc_flags |= RX_ENC_FLAG_LDPC;
 
 		ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status, sband,
-						    rxv, &mode, &nss, stats);
+						    rxv, &mode, &nss,
+						    mib, stats);
 		if (ret < 0)
 			return ret;
 
-- 
2.40.0

