Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733653E9A7D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhHKVp1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:45:27 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:52194 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232191AbhHKVpQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:16 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.133])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D86C61C0069
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ABCE2B0007D
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 574B613C2B8;
        Wed, 11 Aug 2021 14:44:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 574B613C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718290;
        bh=4D/biQnMez0QMS5CXxavsZkq+zZ/e2cZoSHmp4kxnb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qm7/2rkyebnSRjSaetDj+X2JXt3ROzF7HYfPcRTsvsYDzzuTVYldRCljBnoBlL2Hy
         KBmvaYnaU0Ae4KY+kp2GRJKJFYUarDzOh9ZvyG3qAfm6GJO0I4rN/YWyuaNCIKjQ8J
         c4XeZgLwyTupeUBSSgOKzzv5q9qRwUIYP6TeMnJY=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 05/15] mt76: mt7915:  use nss for calculating rx-chains
Date:   Wed, 11 Aug 2021 14:44:29 -0700
Message-Id: <20210811214439.17458-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718291-Q4KSLCW02wfa
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

When group-5 is enabled, we can find the actuall NSS used.
In that case, update the rx chains info so that the upper
stack can give better idea of actual antenna usage.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 32 +++++++++++++------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 7d5156a9e48d..b44ca71e7d06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -560,6 +560,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	/* RXD Group 3 - P-RXV */
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
 		u32 v0, v1, v2;
+		u8 nss;
 
 		rxv = rxd; /* DW16 assuming group 1,2,3,4 */
 		rxd += 2;
@@ -577,21 +578,12 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		/* TODO:  When group-5 is enabled, use nss (and stbc) to
 		 * calculate chains properly for this particular skb.
 		 */
-		status->chains = mphy->antenna_mask;
 		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
 		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
 		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
 		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v1);
-		status->signal = status->chain_signal[0];
 
-		for (i = 1; i < hweight8(mphy->antenna_mask); i++) {
-			if (!(status->chains & BIT(i)))
-				continue;
-
-			/* TODO:  Use db sum logic instead of max. */
-			status->signal = max(status->signal,
-					     status->chain_signal[i]);
-		}
+		nss = hweight8(mphy->antenna_mask);
 
 		/* RXD Group 5 - C-RXV.
 		 * Group 5 Not currently enabled for 7915 except in
@@ -604,6 +596,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			u8 gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
 			bool cck = false;
 
+			nss = 1;
 			rxd += 18;
 			if ((u8 *)rxd - skb->data >= skb->len)
 				return -EINVAL;
@@ -623,6 +616,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 				status->encoding = RX_ENC_HT;
 				if (i > 31)
 					return -EINVAL;
+				nss = i / 8 + 1;
 				break;
 			case MT_PHY_TYPE_VHT:
 				status->nss =
@@ -630,6 +624,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 				status->encoding = RX_ENC_VHT;
 				if (i > 9)
 					return -EINVAL;
+				nss = status->nss;
 				break;
 			case MT_PHY_TYPE_HE_MU:
 				status->flag |= RX_FLAG_RADIOTAP_HE_MU;
@@ -639,6 +634,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			case MT_PHY_TYPE_HE_TB:
 				status->nss =
 					FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+				nss = status->nss;
 				status->encoding = RX_ENC_HE;
 				status->flag |= RX_FLAG_RADIOTAP_HE;
 				i &= GENMASK(3, 0);
@@ -653,6 +649,11 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			}
 			status->rate_idx = i;
 
+			if (stbc) {
+				nss *= 2;
+				WARN_ON_ONCE(nss > 4);
+			}
+
 			switch (FIELD_GET(MT_CRXV_FRAME_MODE, v2)) {
 			case IEEE80211_STA_RX_BW_20:
 				break;
@@ -680,6 +681,17 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			if (mode < MT_PHY_TYPE_HE_SU && gi)
 				status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 		}
+
+		status->chains = 1;
+		status->signal = status->chain_signal[0];
+
+		for (i = 1; i < nss; i++) {
+			status->chains |= BIT(i);
+
+			/* TODO:  Use db sum logic instead of max. */
+			status->signal = max(status->signal,
+					     status->chain_signal[i]);
+		}
 	}
 
 	skb_pull(skb, (u8 *)rxd - skb->data + 2 * remove_pad);
-- 
2.20.1

