Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C2210C4E3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfK1IVw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:21:52 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:41290
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbfK1IVw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574929311;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=aUv0KBO7HVmsZw5SfF+y8ankZYJlZjOYIXnZE05cXVo=;
        b=OCUdyCprPA9riOM3fZrNpLnSKtTTr7t1C5KpTKmxNSE8oWRXGDT4amwZvFpixo2U
        c0MHWfVFqXtAw1I1YDUJFqO60LtxBCAFdJfAGRRAgVWN3UfuXZOVQFDTOTrY94+61gP
        3uDLOQrjSFrnTD01ysOwhq7Z958MKf68DXD12bm4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574929311;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=aUv0KBO7HVmsZw5SfF+y8ankZYJlZjOYIXnZE05cXVo=;
        b=Be6RcJtuhdc2d4pmlSrpZDokC22e2OC7ANyteJVdZyPCoutE4qYfTpZSu6V2sUnZ
        YrUzIQqUHPoYMyc0hSq7PPxlRzIlisVRieJAQXw8BF6xKWuXTkZ6nI+7OmRCPEkMty6
        hoH+zXd8yXJC3t930eY72SM/KNOUQsxhI75VPJWU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CFCBFC447BB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 5/9] ath11k: update tx duration in station info
Date:   Thu, 28 Nov 2019 08:21:51 +0000
Message-ID: <0101016eb11a27fd-1680b7b5-4be4-48b1-8259-c9e83a16bcbb-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
References: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.28-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <vnaralas@codeaurora.org>

Update tx duration in station info form PPDU stats
so that users can dump tx duration of the station.

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h  | 1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 drivers/net/wireless/ath/ath11k/mac.c   | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 065cb9dc880b..06482a5c102d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -335,6 +335,7 @@ struct ath11k_sta {
 	struct rate_info txrate;
 	struct rate_info last_txrate;
 	u64 rx_duration;
+	u64 tx_duration;
 	u8 rssi_comb;
 	struct ath11k_htt_tx_stats *tx_stats;
 	struct ath11k_rx_peer_stats *rx_stats;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 85e999c7a238..8f69de594ada 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1147,7 +1147,7 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 	arsta->txrate.nss = nss;
 	arsta->txrate.bw = ath11k_mac_bw_to_mac80211_bw(bw);
 	arsta->tx_info.status.rates[0].flags |= ath11k_bw_to_mac80211_bwflags(bw);
-
+	arsta->tx_duration += tx_duration;
 	memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
 
 	if (succ_pkts) {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b048057b398f..624534d4c33a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5316,6 +5316,9 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->rx_duration = arsta->rx_duration;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
 
+	sinfo->tx_duration = arsta->tx_duration;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
+
 	if (!arsta->txrate.legacy && !arsta->txrate.nss)
 		return;
 
-- 
2.7.4

