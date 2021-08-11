Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818483E9A86
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhHKVpw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:45:52 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:58448 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232216AbhHKVpV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:21 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.27])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0F8251A0076
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:52 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C9E9360006B
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:51 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5EAAC13C2BE;
        Wed, 11 Aug 2021 14:44:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5EAAC13C2BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718291;
        bh=flcwtPFA3edlqttHyeqI79Rf6DJL8Di85lNgGz2Kzg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGvw0N1T1pLoYOqVy/0/HxKtLUZlQJzSwQuN+/9k4NTgS/++ce/Tp65rhfiSFc2P9
         Le915hpVmVu8+Z0HvGrxybh6JN3a7LX0PHes6lJqWB17iva3Me/spmYEkCi/jJO2+1
         /p8cbOWKXgNRvf/hxs3nb4/YBbcU2hPOIlEs5Oas=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 08/15] mt76: mt7915:  ethtool counters for driver rx path
Date:   Wed, 11 Aug 2021 14:44:32 -0700
Message-Id: <20210811214439.17458-9-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718292-onZbYx6dOtqc
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Add some per-phy counters for rx errors in the driver.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 45 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 22 +++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 11 +++++
 3 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 697dbf62c35f..138059278ac0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -425,9 +425,12 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	__le16 fc = 0;
 	int i, idx;
 	struct mt7915_sta_stats *mstats = NULL;
+	struct mib_stats *mib = &phy->mib;
 
 	memset(status, 0, sizeof(*status));
 
+	mib->rx_d_skb++;
+
 	if (rxd1 & MT_RXD1_NORMAL_BAND_IDX) {
 		mphy = dev->mt76.phy2;
 		if (!mphy)
@@ -440,8 +443,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
 		return -EINVAL;
 
-	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
+	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR) {
+		mib->rx_d_rxd2_amsdu_err++;
 		return -EINVAL;
+	}
 
 	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
@@ -466,8 +471,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	else
 		sband = &mphy->sband_2g.sband;
 
-	if (!sband->channels)
+	if (!sband->channels) {
+		mib->rx_d_null_channels++;
 		return -EINVAL;
+	}
 
 	if ((rxd0 & csum_mask) == csum_mask)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -487,8 +494,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	remove_pad = FIELD_GET(MT_RXD2_NORMAL_HDR_OFFSET, rxd2);
 
-	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
+	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR) {
+		mib->rx_d_max_len_err++;
 		return -EINVAL;
+	}
 
 	rxd += 6;
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
@@ -500,8 +509,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		seq_ctrl = FIELD_GET(MT_RXD8_SEQ_CTRL, v2);
 
 		rxd += 4;
-		if ((u8 *)rxd - skb->data >= skb->len)
+		if ((u8 *)rxd - skb->data >= skb->len) {
+			mib->rx_d_too_short++;
 			return -EINVAL;
+		}
 	}
 
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
@@ -532,8 +543,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
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
@@ -555,8 +568,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		}
 
 		rxd += 2;
-		if ((u8 *)rxd - skb->data >= skb->len)
+		if ((u8 *)rxd - skb->data >= skb->len) {
+			mib->rx_d_too_short++;
 			return -EINVAL;
+		}
 	}
 
 	/* RXD Group 3 - P-RXV */
@@ -566,8 +581,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 		rxv = rxd; /* DW16 assuming group 1,2,3,4 */
 		rxd += 2;
-		if ((u8 *)rxd - skb->data >= skb->len)
+		if ((u8 *)rxd - skb->data >= skb->len) {
+			mib->rx_d_too_short++;
 			return -EINVAL;
+		}
 
 		v0 = le32_to_cpu(rxv[0]);  /* DW16, P-VEC1 31:0 */
 		/* DW17, RX_RCPI copied over P-VEC 64:32 Per RX Format doc. */
@@ -600,8 +617,10 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 			nss = 1;
 			rxd += 18;
-			if ((u8 *)rxd - skb->data >= skb->len)
+			if ((u8 *)rxd - skb->data >= skb->len) {
+				mib->rx_d_too_short++;
 				return -EINVAL;
+			}
 
 			idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
 			mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
@@ -616,16 +635,20 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			case MT_PHY_TYPE_HT_GF:
 			case MT_PHY_TYPE_HT:
 				status->encoding = RX_ENC_HT;
-				if (i > 31)
+				if (i > 31) {
+					mib->rx_d_bad_ht_rix++;
 					return -EINVAL;
+				}
 				nss = i / 8 + 1;
 				break;
 			case MT_PHY_TYPE_VHT:
 				status->nss =
 					FIELD_GET(MT_PRXV_NSTS, v0) + 1;
 				status->encoding = RX_ENC_VHT;
-				if (i > 9)
+				if (i > 9) {
+					mib->rx_d_bad_vht_rix++;
 					return -EINVAL;
+				}
 				nss = status->nss;
 				break;
 			case MT_PHY_TYPE_HE_MU:
@@ -647,6 +670,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 				status->he_dcm = !!(idx & MT_PRXV_TX_DCM);
 				break;
 			default:
+				mib->rx_d_bad_mode++;
 				return -EINVAL;
 			}
 			status->rate_idx = i;
@@ -697,6 +721,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 				status->bw = RATE_INFO_BW_160;
 				break;
 			default:
+				mib->rx_d_bad_bw++;
 				return -EINVAL;
 			}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 1ce4260557c7..22ceb46be4bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1093,6 +1093,17 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
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
@@ -1314,6 +1325,17 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
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
 	wi.data = data;
 	wi.mvif = mvif;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 1f0be4fbee35..2d7c84946e40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -173,6 +173,17 @@ struct mib_stats {
 	u32 rx_pfdrop_cnt;
 	u32 rx_vec_queue_overflow_drop_cnt;
 	u32 rx_ba_cnt;
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

