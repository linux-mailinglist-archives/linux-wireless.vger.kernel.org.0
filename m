Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328A43D01A0
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jul 2021 20:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhGTRpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 13:45:16 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:58248 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234900AbhGTRmn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 13:42:43 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.18])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A30D91A006F
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jul 2021 18:23:01 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6881F34006A
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jul 2021 18:23:01 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id EC74C13C2B8;
        Tue, 20 Jul 2021 11:23:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EC74C13C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626805381;
        bh=eNdlRsYWV/WJ2w8j1JZPs7GMw4hHlll06Ygo1d2j37Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZst0WdZkjp1LfW2Um+tKKjpOejjO2A5EfEs9eXPcpMTUttIbYrzWmaXNyj2+T/gh
         W+1NGY8ba8D/tiOtMzZk5wElbyDsB+QRAYjb046S1cnBmGyqLTlOyZrYmi+EXVvLQ+
         V0EqE0gHQ6R7Tc7rAQ5eDFnz6S2Y7ACbJNexxpsI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 06/11] mt76: mt7915:  Support parsing TXSFM 0x2.
Date:   Tue, 20 Jul 2021 11:22:50 -0700
Message-Id: <20210720182256.30536-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720182256.30536-1-greearb@candelatech.com>
References: <20210720182256.30536-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626805382-0KkZvMCzHkCk
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
index 41247fe4ff8c..80acc07c0180 100644
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
@@ -1418,6 +1411,19 @@ mt7915_mac_parse_txs(struct mt7915_dev *dev, struct mt76_wcid *wcid,
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
@@ -1469,8 +1475,6 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
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

