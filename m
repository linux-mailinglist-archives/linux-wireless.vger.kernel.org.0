Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A427D73DB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjJYTEM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbjJYTEJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:04:09 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D2F116
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:04:06 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 97D919C0075
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 19:04:04 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id F2A5813C2B3;
        Wed, 25 Oct 2023 12:04:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F2A5813C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698260641;
        bh=3j8MjGTN6+UEz8MVhNqOsHKE1Zfhzxsxckxc+MhtE7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zq8Pj+XnwwXr3dW7fG9qUevmKLKVnKToWfm7HE5QIhxQnlYVU1c5E5dJbAXDQ76AL
         iLzxh1NpCI89y1VwZS+jWVKSFOr4TOQolDU5b5csTDJMVpOpiuo6QBnLEqGdhxH2Zt
         6tm3IS7sbaruFZC3i668dYNbI5Bl8Zc4cHlTRqP8=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 08/12] wifi: mt76: mt7915: use nss for calculating rx-chains
Date:   Wed, 25 Oct 2023 12:03:50 -0700
Message-Id: <20231025190351.2141832-8-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231025190351.2141832-1-greearb@candelatech.com>
References: <20231025190351.2141832-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698260645-aTFqekqXLyG1
X-MDID-O: us5;at1;1698260645;aTFqekqXLyG1;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

When group-5 is enabled, we can find the actuall NSS used.
In that case, update the rx chains info so that the upper
stack can give better idea of actual antenna usage.

In case of stbc, the hardware already double nss, but rssi
is not reported properly (it is '17') for the secondary chains.
So, decrease nss in the status msg so that mac80211 does not try
to average the invalid RSSI.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  2 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 24 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 15 ++++++++++--
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 17 +++++++++++--
 4 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 6c052e6703a4..774911c52686 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -424,7 +424,7 @@ int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80211_vif *vif,
 int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 				  struct mt76_rx_status *status,
 				  struct ieee80211_supported_band *sband,
-				  __le32 *rxv, u8 *mode);
+				  __le32 *rxv, u8 *mode, u8 *nss);
 void mt76_connac2_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
 void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 			    struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index ae52e10331c5..ccd82943cdd1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1014,10 +1014,10 @@ EXPORT_SYMBOL_GPL(mt76_connac2_reverse_frag0_hdr_trans);
 int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 				  struct mt76_rx_status *status,
 				  struct ieee80211_supported_band *sband,
-				  __le32 *rxv, u8 *mode)
+				  __le32 *rxv, u8 *mode, u8 *nss)
 {
 	u32 v0, v2;
-	u8 stbc, gi, bw, dcm, nss;
+	u8 stbc, gi, bw, dcm;
 	int i, idx;
 	bool cck = false;
 
@@ -1025,7 +1025,7 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 	v2 = le32_to_cpu(rxv[2]);
 
 	idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
-	nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+	*nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
 
 	if (!is_mt7915(dev)) {
 		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
@@ -1050,17 +1050,21 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 		fallthrough;
 	case MT_PHY_TYPE_OFDM:
 		i = mt76_get_rate(dev, sband, i, cck);
+		if (stbc)
+			*nss = 2;
+		else
+			*nss = 1;
 		break;
 	case MT_PHY_TYPE_HT_GF:
 	case MT_PHY_TYPE_HT:
 		status->encoding = RX_ENC_HT;
+		*nss = i / 8 + 1;
 		if (gi)
 			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 		if (i > 31)
 			return -EINVAL;
 		break;
 	case MT_PHY_TYPE_VHT:
-		status->nss = nss;
 		status->encoding = RX_ENC_VHT;
 		if (gi)
 			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
@@ -1071,7 +1075,6 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 	case MT_PHY_TYPE_HE_SU:
 	case MT_PHY_TYPE_HE_EXT_SU:
 	case MT_PHY_TYPE_HE_TB:
-		status->nss = nss;
 		status->encoding = RX_ENC_HE;
 		i &= GENMASK(3, 0);
 
@@ -1112,6 +1115,17 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 	if (*mode < MT_PHY_TYPE_HE_SU && gi)
 		status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 
+	/* in case stbc is set, the nss value returned by hardware is already
+	 * correct (ie, 2 instead of 1 for 1 spatial stream).  But, at least in cases
+	 * where we are configured for a single antenna, then the second chain RSSI is '17',
+	 * which I take to mean 'not set'.  To keep from adding this to the average rssi up in
+	 * mac80211 rx logic, decrease nss here.
+	 */
+	if (stbc)
+		*nss >>= 1;
+
+	status->nss = *nss;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_fill_rx_rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 5776d47afba9..be983a1bfe20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -451,6 +451,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
 		u32 v0, v1;
 		int ret;
+		int i;
+		u8 nss;
 
 		rxv = rxd;
 		rxd += 2;
@@ -463,11 +465,14 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 		if (v0 & MT_PRXV_HT_AD_CODE)
 			status->enc_flags |= RX_ENC_FLAG_LDPC;
 
-		status->chains = mphy->antenna_mask;
+		/* TODO:  When group-5 is enabled, use nss (and stbc) to
+		 * calculate chains properly for this particular skb.
+		 */
 		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
 		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
 		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
 		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v1);
+		nss = hweight8(mphy->antenna_mask);
 
 		/* RXD Group 5 - C-RXV */
 		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
@@ -478,10 +483,16 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 
 		if (!is_mt7915(&dev->mt76) || (rxd1 & MT_RXD1_NORMAL_GROUP_5)) {
 			ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status,
-							    sband, rxv, &mode);
+							    sband, rxv, &mode,
+							    &nss);
 			if (ret < 0)
 				return ret;
+		} else {
+			status->nss = nss;
 		}
+
+		for (i = 0; i < nss; i++)
+			status->chains |= BIT(i);
 	}
 
 	amsdu_info = FIELD_GET(MT_RXD4_NORMAL_PAYLOAD_FORMAT, rxd4);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index f3d61e77fa4a..52bbd7b98710 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -333,6 +333,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
 		u32 v0, v1;
 		int ret;
+		u8 nss;
 
 		rxv = rxd;
 		rxd += 2;
@@ -346,7 +347,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 			status->enc_flags |= RX_ENC_FLAG_LDPC;
 
 		ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status, sband,
-						    rxv, &mode);
+						    rxv, &mode, &nss);
 		if (ret < 0)
 			return ret;
 
@@ -366,12 +367,24 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 				return -EINVAL;
 		}
 
-		status->chains = mphy->antenna_mask;
 		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
 		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
 		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
 		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v1);
 		status->signal = -128;
+
+		if (nss == 1) {
+			if (status->chain_signal[0] >= status->chain_signal[1])
+				status->chains |= BIT(0);
+			else
+				status->chains |= BIT(1);
+		} else if (status->nss == 2) {
+			status->chains = BIT(0) | BIT(1);
+		} else {
+			WARN_ON_ONCE(1); /* this driver is for only 2x2 AFAIK */
+			status->chains = BIT(0);
+		}
+
 		for (i = 0; i < hweight8(mphy->antenna_mask); i++) {
 			if (!(status->chains & BIT(i)) ||
 			    status->chain_signal[i] >= 0)
-- 
2.40.0

