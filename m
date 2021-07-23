Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4843D3D1C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 18:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhGWP0T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 11:26:19 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:58805 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhGWP0S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 11:26:18 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.27])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D6302A007B
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 16:06:50 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 986BC60006F
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 16:06:50 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 7D16713C2B8;
        Fri, 23 Jul 2021 09:06:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7D16713C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627056393;
        bh=2yION9utzsWOrixr1s4WbP7MXMWnYIUoMuy9J0qBbhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkJmQTHim9qRUBXJhIOX8U6bwgP3qvWTOSmXLskjnzdZr9/wwKLdpJFti7NHMvMWH
         h7M/RrFP3gfaLHGUFlb3Y+CySMyNQ6EGtBKmaeIU7Mmn4bxB+u16trECPMJG9yNP5D
         ki7yZz2kc8rNpeHJPj/pYOG15pFbsU3AK7RSsSbs=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3 06/11] mt76: mt7915:  Support parsing TXSFM 0x2.
Date:   Fri, 23 Jul 2021 09:06:18 -0700
Message-Id: <20210723160623.14709-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723160623.14709-1-greearb@candelatech.com>
References: <20210723160623.14709-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627056411-ryhl9yyA9rKQ
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Add code to support this format, but I don't actually
see any of these TXS format frames on my test system.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 24 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  3 +++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index d81e3cbe1aad..03c85bd0750e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1317,13 +1317,10 @@ mt7915_mac_parse_txs(struct mt7915_dev *dev, struct mt76_wcid *wcid,
 {
 	struct ieee80211_supported_band *sband;
 	struct mt76_phy *mphy;
-	u32 txrate, txs, txs5, txs6, txs7, mode;
+	u32 txrate, txs, mode;
 	bool cck = false;
 
 	txs = le32_to_cpu(txs_data[0]);
-	txs5 = le32_to_cpu(txs_data[5]);
-	txs6 = le32_to_cpu(txs_data[6]);
-	txs7 = le32_to_cpu(txs_data[7]);
 
 	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
 		info->flags |= IEEE80211_TX_STAT_ACK;
@@ -1334,10 +1331,6 @@ mt7915_mac_parse_txs(struct mt7915_dev *dev, struct mt76_wcid *wcid,
 
 	info->status.rates[0].idx = -1;
 
-	stats->tx_mpdu_attempts += FIELD_GET(MT_TXS5_F1_MPDU_TX_COUNT, txs5);
-	stats->tx_mpdu_fail += FIELD_GET(MT_TXS6_F1_MPDU_FAIL_COUNT, txs6);
-	stats->tx_mpdu_retry += FIELD_GET(MT_TXS7_F1_MPDU_RETRY_COUNT, txs7);
-
 	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
 
 	rate->mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
@@ -1425,6 +1418,19 @@ mt7915_mac_parse_txs(struct mt7915_dev *dev, struct mt76_wcid *wcid,
 		stats->tx_bw[0]++;
 		break;
 	}
+
+	if (FIELD_GET(MT_TXS0_TXS_FORMAT, txs) == 2) {
+		/* TXSFM == 10 */
+		u32 txs5, txs6, txs7;
+
+		txs5 = le32_to_cpu(txs_data[5]);
+		txs6 = le32_to_cpu(txs_data[6]);
+		txs7 = le32_to_cpu(txs_data[7]);
+
+		stats->tx_mpdu_attempts += FIELD_GET(MT_TXS5_F1_MPDU_TX_COUNT, txs5);
+		stats->tx_mpdu_fail += FIELD_GET(MT_TXS6_F1_MPDU_FAIL_COUNT, txs6);
+		stats->tx_mpdu_retry += FIELD_GET(MT_TXS7_F1_MPDU_RETRY_COUNT, txs7);
+	}
 }
 
 static void
@@ -1476,8 +1482,6 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	u8 pid;
 
 	txs = le32_to_cpu(txs_data[0]);
-	if (FIELD_GET(MT_TXS0_TXS_FORMAT, txs) > 1)
-		return;
 
 	txs = le32_to_cpu(txs_data[2]);
 	wcidx = FIELD_GET(MT_TXS2_WCID, txs);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index ccce994dc07a..986a65badd1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -347,6 +347,9 @@ struct mt7915_tx_free {
 
 #define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
 
+/* The F0 variables are for TXSFM 0x0 and 0x1.  The F1 variables
+ * are for TXSFM 0x2 aka PPDU format.
+ */
 #define MT_TXS5_F0_FINAL_MPDU		BIT(31)
 #define MT_TXS5_F0_QOS			BIT(30)
 #define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
-- 
2.20.1

