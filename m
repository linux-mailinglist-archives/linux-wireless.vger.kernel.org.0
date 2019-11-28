Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8B210C4E4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfK1IV4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:21:56 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:54578
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbfK1IVz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574929314;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=QEsyDzKGcwXw7o//8GjjRGe83FqjCYiLKw/dfUTQGc0=;
        b=AopF1mM5kknDmaHP1Ji9WUaSMj1gvYmlZHyGso3DZnYm7HRcUCLEYr/hPV9ymXM/
        YINbH2YMb4Km9/IeIUqZx0N6AY6BVXPOmN8QHddnj0GkdfSnMMIDNfiZghq8kNrmMd4
        Qlr0HzWwfdjwAN0L+sON1NfKG8tW6spJwkEkr+DU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574929314;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=QEsyDzKGcwXw7o//8GjjRGe83FqjCYiLKw/dfUTQGc0=;
        b=TdybZrm82jlzW0Xwselrt5vGR58ajJQBsI+V75MHToXgb/ERp0EYrM4KJ0ME5J3a
        SycwKq5NenaT0NjOwPT2ns9+5jDZONYVRXghE9SR8ABG/AOINc3zwOE1nfwUjMyWKs0
        JVJrydHMPABtXFreY5Bpgt3wdnBAla16IOJuJ6V8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35A64C447B4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 6/9] ath11k: Skip update peer stats for management packets
Date:   Thu, 28 Nov 2019 08:21:54 +0000
Message-ID: <0101016eb11a33ac-09205b3e-5960-452d-8478-b6a52f3a12c5-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
References: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.28-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <vnaralas@codeaurora.org>

Currently HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS tag of PPDU stats
doesn't have valid success bytes info of management frames.
So skip update peer stats for management packets.

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.h    |  4 +++-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 33 ++++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index db216f055c42..82ddd7017722 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1176,7 +1176,9 @@ struct htt_ppdu_stats_usr_cmpltn_cmn {
 
 #define HTT_PPDU_STATS_ACK_BA_INFO_NUM_MPDU_M	GENMASK(8, 0)
 #define HTT_PPDU_STATS_ACK_BA_INFO_NUM_MSDU_M	GENMASK(24, 9)
-#define HTT_PPDU_STATS_ACK_BA_INFO_TID_NUM	GENMASK(3, 0)
+#define HTT_PPDU_STATS_ACK_BA_INFO_TID_NUM	GENMASK(31, 25)
+
+#define HTT_PPDU_STATS_NON_QOS_TID	16
 
 struct htt_ppdu_stats_usr_cmpltn_ack_ba_status {
 	u32 ppdu_id;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 8f69de594ada..a380efb9caa6 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1034,6 +1034,7 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 	u32 succ_bytes = 0;
 	u16 rate = 0, succ_pkts = 0;
 	u32 tx_duration = 0;
+	u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
 	bool is_ampdu = false;
 
 	if (!usr_stats)
@@ -1051,6 +1052,8 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 		succ_bytes = usr_stats->ack_ba.success_bytes;
 		succ_pkts = FIELD_GET(HTT_PPDU_STATS_ACK_BA_INFO_NUM_MSDU_M,
 				      usr_stats->ack_ba.info);
+		tid = FIELD_GET(HTT_PPDU_STATS_ACK_BA_INFO_TID_NUM,
+				usr_stats->ack_ba.info);
 	}
 
 	if (common->fes_duration_us)
@@ -1156,19 +1159,23 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 		ieee80211_tx_rate_update(ar->hw, sta, &arsta->tx_info);
 	}
 
-	memset(peer_stats, 0, sizeof(*peer_stats));
-
-	peer_stats->succ_pkts = succ_pkts;
-	peer_stats->succ_bytes = succ_bytes;
-	peer_stats->is_ampdu = is_ampdu;
-	peer_stats->duration = tx_duration;
-	peer_stats->ba_fails =
-		HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
-		HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
-
-	if (ath11k_debug_is_extd_tx_stats_enabled(ar))
-		ath11k_accumulate_per_peer_tx_stats(arsta,
-						    peer_stats, rate_idx);
+	/* PPDU stats reported for mgmt packet doesn't have valid tx bytes.
+	 * So skip peer stats update for mgmt packets.
+	 */
+	if (tid < HTT_PPDU_STATS_NON_QOS_TID) {
+		memset(peer_stats, 0, sizeof(*peer_stats));
+		peer_stats->succ_pkts = succ_pkts;
+		peer_stats->succ_bytes = succ_bytes;
+		peer_stats->is_ampdu = is_ampdu;
+		peer_stats->duration = tx_duration;
+		peer_stats->ba_fails =
+			HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
+			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
+
+		if (ath11k_debug_is_extd_tx_stats_enabled(ar))
+			ath11k_accumulate_per_peer_tx_stats(arsta,
+							    peer_stats, rate_idx);
+	}
 
 	spin_unlock_bh(&ab->base_lock);
 	rcu_read_unlock();
-- 
2.7.4

