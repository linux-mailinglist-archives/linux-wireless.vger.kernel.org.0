Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FAD3D2DA9
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 22:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhGVTsI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 15:48:08 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:36886 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230430AbhGVTsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 15:48:07 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.218])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 317572006C
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 20:28:41 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F010984007F
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 20:28:40 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 65D7813C2B8;
        Thu, 22 Jul 2021 13:28:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 65D7813C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626985720;
        bh=RYDgFmKktXlmzIt/0/hrcKaV3R5bIJuEK4Argrg8BNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cklPTmw96XgY+mZJ1LsUqAm/VI2KP0ntih8mByqgUKJHkFUby6STE4PjqIgOl8YDT
         uuKdB8cZ4otZPWo/8Ez/r6rDjPWPEsYlguPfIfG31I5tmiJpxUm9lUQ7tu00NwanMU
         z3LGBr8k36oD5sMSkpLR/EZc+uUD4K5J8wESt7yg=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 06/11] mt76: mt7915:  Support parsing TXSFM 0x2.
Date:   Thu, 22 Jul 2021 13:28:29 -0700
Message-Id: <20210722202834.6826-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722202834.6826-1-greearb@candelatech.com>
References: <20210722202834.6826-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626985721-TYXG4-X8sZxe
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
index 9bd2a5e795b8..073891850c0c 100644
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

