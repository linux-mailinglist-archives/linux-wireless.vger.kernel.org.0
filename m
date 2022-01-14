Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E66C48F0F8
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 21:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244184AbiANU2O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 15:28:14 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:36834 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244215AbiANU2O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 15:28:14 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.177])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 595C920061
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 20:28:12 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1F55E680079
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 20:28:12 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5DD4913C2B1;
        Fri, 14 Jan 2022 12:28:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5DD4913C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1642192091;
        bh=Dgw59BzgiLf4z04sz9gBa3wtV6UtokSCxSkGAnDsVJA=;
        h=From:To:Cc:Subject:Date:From;
        b=rMsdEhTP2S0eraGTvI6ZqVd6W4UaoxP/qiMvTy4fad4rPPpjVFglhassotaRSlLs3
         LQ1NHHVWs+pjImgSFeWUhf70p4A1qDQeEIF4lMSkDUkbSiW/U8w74WjdcIVq92zK+4
         zKNEntUiXEM9vTH79eKbedlSuxevSekPmFKB+HF8=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mt76: mt7921:  improve signal reporting.
Date:   Fri, 14 Jan 2022 12:28:09 -0800
Message-Id: <20220114202809.29249-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1642192092-HB4prbY9TP-T
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Sum up individual chains to provide more accurate
total power reporting.

Use reported NSS to determine chains.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 32 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 36 ++++++++++++-------
 2 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3c0e2cda36acf..96587680b6fa4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1425,4 +1425,36 @@ mt76_packet_id_flush(struct mt76_dev *dev, struct mt76_wcid *wcid)
 	idr_destroy(&wcid->pktid);
 }
 
+/* Estimated summing of dbm without resorting to log(10) business */
+static inline int mt76_sum_sigs_2(int a, int b)
+{
+	int diff;
+
+	/* 0x80 means value-is-not-set */
+	if (b == 0x80)
+		return a;
+
+	if (a >= b) {
+		/* a is largest value, add to it. */
+		diff = a - b;
+		if (diff == 0)
+			return a + 3;
+		else if (diff == 1)
+			return a + 2;
+		else if (diff == 2)
+			return a + 1;
+		return a;
+	} else {
+		/* b is largest value, add to it. */
+		diff = b - a;
+		if (diff == 0)
+			return b + 3;
+		else if (diff == 1)
+			return b + 2;
+		else if (diff == 2)
+			return b + 1;
+		return b;
+	}
+}
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 609497a85942f..b8ce9d1e10cc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -648,23 +648,10 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 		if (v0 & MT_PRXV_HT_AD_CODE)
 			status->enc_flags |= RX_ENC_FLAG_LDPC;
 
-		status->chains = mphy->antenna_mask;
 		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
 		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
 		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
 		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v1);
-		status->signal = -128;
-		for (i = 0; i < hweight8(mphy->antenna_mask); i++) {
-			if (!(status->chains & BIT(i)) ||
-			    status->chain_signal[i] >= 0)
-				continue;
-
-			status->signal = max(status->signal,
-					     status->chain_signal[i]);
-		}
-
-		if (status->signal == -128)
-			status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 
 		stbc = FIELD_GET(MT_PRXV_STBC, v0);
 		gi = FIELD_GET(MT_PRXV_SGI, v0);
@@ -679,10 +666,15 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 			fallthrough;
 		case MT_PHY_TYPE_OFDM:
 			i = mt76_get_rate(&dev->mt76, sband, i, cck);
+			if (stbc)
+				status->nss = 2;
+			else
+				status->nss = 1;
 			break;
 		case MT_PHY_TYPE_HT_GF:
 		case MT_PHY_TYPE_HT:
 			status->encoding = RX_ENC_HT;
+			status->nss = i / 8 + 1;
 			if (i > 31)
 				return -EINVAL;
 			break;
@@ -745,6 +737,24 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 			if ((u8 *)rxd - skb->data >= skb->len)
 				return -EINVAL;
 		}
+
+		for (i = 0; i < status->nss; i++) {
+			if (status->chain_signal[i] < 0)
+				status->chains |= BIT(i);
+		}
+
+		if (status->nss == 1) {
+			status->signal = status->chain_signal[0];
+		} else if (status->nss == 2) {
+			status->signal = mt76_sum_sigs_2(status->chain_signal[0],
+							 status->chain_signal[1]);
+		} else {
+			WARN_ON_ONCE(1); /* this driver is for only 2x2 AFAIK */
+			status->signal = status->chain_signal[0];
+		}
+
+		if (!status->chains)
+			status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 	}
 
 	amsdu_info = FIELD_GET(MT_RXD4_NORMAL_PAYLOAD_FORMAT, rxd4);
-- 
2.26.3

