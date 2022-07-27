Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A71583579
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 01:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbiG0XBx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 19:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiG0XBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 19:01:44 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A18520F57
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 16:01:42 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.137])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 180711C0083;
        Wed, 27 Jul 2022 23:01:41 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CE47114007E;
        Wed, 27 Jul 2022 23:01:40 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 7091013C2B1;
        Wed, 27 Jul 2022 16:01:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7091013C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1658962900;
        bh=CB4r0epo/phmbdAeqdcdoUPvSqWWQK2NG+odvpWXl2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=To/Tjs0sZSCdA1SFEwXRFAy9HWAJdW9Kzxwq8NFoGcCFfZ6bYXjIC3IFOyUUbX+Cs
         JgI83ufa/MZwc2EkpuGxIKFH7/WiewgSX8IWZEZ5d7xgfO+ysz3LWcYGjSiEfZ9FpP
         nLqJWpWLCwJCmYQKR6tUy1CjAfMZb6JQl9TNsQHg=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 08/12] wifi: mt76: mt7915: use nss for calculating rx-chains
Date:   Wed, 27 Jul 2022 16:01:18 -0700
Message-Id: <20220727230122.29842-8-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220727230122.29842-1-greearb@candelatech.com>
References: <20220727230122.29842-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1658962901-xjM6_qNSDwyJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
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
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 30 ++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 17bc64960f04..1d2909c0c04c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -487,10 +487,10 @@ static int
 mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			struct mt76_rx_status *status,
 			struct ieee80211_supported_band *sband,
-			__le32 *rxv, u8 *mode)
+			__le32 *rxv, u8 *mode, u8 *nss)
 {
 	u32 v0, v2;
-	u8 stbc, gi, bw, dcm, nss;
+	u8 stbc, gi, bw, dcm;
 	int i, idx;
 	bool cck = false;
 
@@ -498,7 +498,7 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 	v2 = le32_to_cpu(rxv[2]);
 
 	idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
-	nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+	*nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
 
 	if (!is_mt7915(&dev->mt76)) {
 		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
@@ -530,7 +530,6 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			return -EINVAL;
 		break;
 	case MT_PHY_TYPE_VHT:
-		status->nss = nss;
 		status->encoding = RX_ENC_VHT;
 		if (gi)
 			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
@@ -541,7 +540,6 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 	case MT_PHY_TYPE_HE_SU:
 	case MT_PHY_TYPE_HE_EXT_SU:
 	case MT_PHY_TYPE_HE_TB:
-		status->nss = nss;
 		status->encoding = RX_ENC_HE;
 		i &= GENMASK(3, 0);
 
@@ -582,6 +580,17 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
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
 
@@ -755,6 +764,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
 		u32 v0, v1;
 		int ret;
+		int i;
+		u8 nss;
 
 		rxv = rxd; /* DW16 assuming group 1,2,3,4 */
 		rxd += 2;
@@ -771,11 +782,11 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		/* TODO:  When group-5 is enabled, use nss (and stbc) to
 		 * calculate chains properly for this particular skb.
 		 */
-		status->chains = mphy->antenna_mask;
 		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
 		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
 		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
 		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v1);
+		nss = hweight8(mphy->antenna_mask);
 
 		/* RXD Group 5 - C-RXV */
 		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
@@ -786,10 +797,15 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 		if (!is_mt7915(&dev->mt76) || (rxd1 & MT_RXD1_NORMAL_GROUP_5)) {
 			ret = mt7915_mac_fill_rx_rate(dev, status, sband, rxv,
-						      &mode);
+						      &mode, &nss);
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
-- 
2.20.1

