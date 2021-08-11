Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415C03E9A7C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhHKVpV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:45:21 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:40948 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232013AbhHKVpP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:15 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.129])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3ACDA1A0073
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0FFBE500066
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A2A1A13C2B3;
        Wed, 11 Aug 2021 14:44:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A2A1A13C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718289;
        bh=cdsBliRRKVxgzD0bwAznLRhIM/EAncugm59L8twjgg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRm8YRR5pDbdJJ6LMKKSWexspRNZxCq7Z7ldsl0suaimFTZ+3IXbIEpmjo4QXnSUW
         FEkNoA6d/2X9A0fcWbukC1FpE/q+ItzSv54DQRz4tbzLJxK72wN8tffIcOqC9+imbb
         /fj0jFT2firsED2SGkJHNh0TnZ//A/oTm7JUFNqI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 01/15] mt76: mt7915:  add comments about rx descriptor parsing
Date:   Wed, 11 Aug 2021 14:44:25 -0700
Message-Id: <20210811214439.17458-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718290-1BiIlejMYKML
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This is a tricky beast to understand, so add some notes for
next time someone is looking at this code and trying to compare
against documents.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2c5b47766949..d836c665ddaf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -410,6 +410,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	__le32 *rxd = (__le32 *)skb->data;
 	__le32 *rxv = NULL;
 	u32 mode = 0;
+	/* table "PP -> HOST / X-CPU"  RX Format */
 	u32 rxd0 = le32_to_cpu(rxd[0]);
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
@@ -489,7 +490,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	rxd += 6;
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
-		u32 v0 = le32_to_cpu(rxd[0]);
+		u32 v0 = le32_to_cpu(rxd[0]); /* DW6 */
 		u32 v2 = le32_to_cpu(rxd[2]);
 
 		fc = cpu_to_le16(FIELD_GET(MT_RXD6_FRAME_CONTROL, v0));
@@ -502,6 +503,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	}
 
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
+		/* DW10, assuming Group-4 enabled */
 		u8 *data = (u8 *)rxd;
 
 		if (status->flag & RX_FLAG_DECRYPTED) {
@@ -533,6 +535,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	}
 
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
+		/* DW14, assuming group-1,4 */
 		status->timestamp = le32_to_cpu(rxd[0]);
 		status->flag |= RX_FLAG_MACTIME_START;
 
@@ -558,18 +561,22 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
 		u32 v0, v1, v2;
 
-		rxv = rxd;
+		rxv = rxd; /* DW16 assuming group 1,2,3,4 */
 		rxd += 2;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
 
-		v0 = le32_to_cpu(rxv[0]);
+		v0 = le32_to_cpu(rxv[0]);  /* DW16, P-VEC1 31:0 */
+		/* DW17, RX_RCPI copied over P-VEC 64:32 Per RX Format doc. */
 		v1 = le32_to_cpu(rxv[1]);
-		v2 = le32_to_cpu(rxv[2]);
+		v2 = le32_to_cpu(rxv[2]); /* first DW of group-5, C-RXV */
 
 		if (v0 & MT_PRXV_HT_AD_CODE)
 			status->enc_flags |= RX_ENC_FLAG_LDPC;
 
+		/* TODO:  When group-5 is enabled, use nss (and stbc) to
+		 * calculate chains properly for this particular skb.
+		 */
 		status->chains = mphy->antenna_mask;
 		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
 		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
@@ -581,12 +588,18 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 			if (!(status->chains & BIT(i)))
 				continue;
 
+			/* TODO:  Use db sum logic instead of max. */
 			status->signal = max(status->signal,
 					     status->chain_signal[i]);
 		}
 
-		/* RXD Group 5 - C-RXV */
+		/* RXD Group 5 - C-RXV.
+		 * Group 5 Not currently enabled for 7915 except in
+		 * monitor mode.
+		 *   See MT_DMA_DCR0_RXD_G5_EN
+		 */
 		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
+			/* See RXV document ... */
 			u8 stbc = FIELD_GET(MT_CRXV_HT_STBC, v2);
 			u8 gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
 			bool cck = false;
-- 
2.20.1

