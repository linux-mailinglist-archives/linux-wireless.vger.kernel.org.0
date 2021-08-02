Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D492D3DDC2B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 17:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhHBPRI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 11:17:08 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:47060 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234885AbhHBPRG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 11:17:06 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.137])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1FF9A1C0063
        for <linux-wireless@vger.kernel.org>; Mon,  2 Aug 2021 15:16:55 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F0C6314007F
        for <linux-wireless@vger.kernel.org>; Mon,  2 Aug 2021 15:16:54 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A9B5C13C2B8;
        Mon,  2 Aug 2021 08:16:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A9B5C13C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627917414;
        bh=8/xxWcMnXrZe/076QuRZyZRPaH3ABFRnG4Dv1prB9MM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7TDkfriSTEdUPjOjNqkWH54ZohJq+ddKTSP+Gy3TJek4ALUwRS56eFaG30GE+3FP
         F5WNWuaxB/YWS7aWDcE93fc3gX4lgW1oyiSZenjE+dCja2MX45L7MaFpg5/4JO52o7
         YWiyhrhpyisKJWgsqJkrjMd8CNLcPzVdjFjek0GQ=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v4 06/11] mt76: mt7915:  remove TXSFM 0x2 code
Date:   Mon,  2 Aug 2021 08:16:38 -0700
Message-Id: <20210802151643.32394-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802151643.32394-1-greearb@candelatech.com>
References: <20210802151643.32394-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627917415-9THXBQrsdKDC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This format is not supported by any current hardware, so
remove code referencing it.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 9 +--------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h | 3 +++
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index d81e3cbe1aad..bdcd1aae10d1 100644
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

