Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452871F61B2
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2020 08:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFKGVJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jun 2020 02:21:09 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:33042 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgFKGVJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jun 2020 02:21:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591856469; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=arJl3QKKFQ/Hf8CbmhE3qTDRC4mgtRDbif79Ci3z+eM=; b=s71AmKlp//JoQarCxJFaMaYuT8Xh98lSRHY/cnxp/+/VLWYXSa1TL/JafI7EMne4UYrOUCB0
 3sV//EKj/u1ufh6135rEfGN2i0dYtYs83NJjhmcP2LwGV50x4brwKnABl/R+POCWxUJuNDJ5
 akd993hWMDeDAXeJ6xoMlwKfixA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ee1cd4f0206ad41d1f6fc9e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 06:21:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 45DFBC43387; Thu, 11 Jun 2020 06:21:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83848C433CA;
        Thu, 11 Jun 2020 06:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83848C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vnaralas@codeaurora.org
From:   Venkateswara Naralasetty <vnaralas@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
Subject: [PATCH] ath10k: fix retry packets update in station dump
Date:   Thu, 11 Jun 2020 11:50:46 +0530
Message-Id: <1591856446-26977-1-git-send-email-vnaralas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When tx status enabled, retry count is updated from tx completion status.
which is not working as expected due to firmware limitation where
firmware can not provide per MSDU rate statistics from tx completion
status. Due to this tx retry count is always 0 in station dump.

Fix this issue by updating the retry packet count from per peer
statistics. This patch will not break on SDIO devices since, this retry
count is already updating from peer statistics for SDIO devices.

HW used: QCA9984
FW version: 10.4-3.6-00104

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 8 +++++---
 drivers/net/wireless/ath/ath10k/mac.c    | 5 +++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index d787cbe..cac05e7 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3575,12 +3575,14 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
 	}
 
 	if (ar->htt.disable_tx_comp) {
-		arsta->tx_retries += peer_stats->retry_pkts;
 		arsta->tx_failed += peer_stats->failed_pkts;
-		ath10k_dbg(ar, ATH10K_DBG_HTT, "htt tx retries %d tx failed %d\n",
-			   arsta->tx_retries, arsta->tx_failed);
+		ath10k_dbg(ar, ATH10K_DBG_HTT, "tx failed %d\n",
+			   arsta->tx_failed);
 	}
 
+	arsta->tx_retries += peer_stats->retry_pkts;
+	ath10k_dbg(ar, ATH10K_DBG_HTT, "htt tx retries %d", arsta->tx_retries);
+
 	if (ath10k_debug_is_extd_tx_stats_enabled(ar))
 		ath10k_accumulate_per_peer_tx_stats(ar, arsta, peer_stats,
 						    rate_idx);
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 919d155..d9d4b15 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8547,12 +8547,13 @@ static void ath10k_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 
 	if (ar->htt.disable_tx_comp) {
-		sinfo->tx_retries = arsta->tx_retries;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
 		sinfo->tx_failed = arsta->tx_failed;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 	}
 
+	sinfo->tx_retries = arsta->tx_retries;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+
 	ath10k_mac_sta_get_peer_stats_info(ar, sta, sinfo);
 }
 
-- 
2.7.4

