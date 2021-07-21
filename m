Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82A43D18F2
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 23:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhGUUkX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 16:40:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:59079 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGUUkX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 16:40:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626902459; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Ggt97fu/Cj/UvFw7ZpzBspFgBHsb5c6WnND4cxYkuBI=; b=HiuuXJ8P6uTOEui1CoBpA0QRQKZgSaimCupItQRZN7PmMHxP1wm11niDgzAdxWAZMLZsF3DR
 oDKxCKCX43+ojuglnIF06JCALCR4baj0xbIbit6rHAfC6p+Ehe3D7v+LTFylGar8z5tAvJvb
 S5aZXgN9cwK5+oIuRu1GJgmLT90=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60f88fae290ea35ee641561c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 21:20:46
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B73AFC4338A; Wed, 21 Jul 2021 21:20:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7EEFC433F1;
        Wed, 21 Jul 2021 21:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7EEFC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 02/12] ath11k: Update pdev tx and rx firmware stats
Date:   Thu, 22 Jul 2021 00:20:19 +0300
Message-Id: <20210721212029.142388-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721212029.142388-1-jouni@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sriram R <srirrama@codeaurora.org>

Update the fields of pdev tx and tx firmware stats structure.
Missing fields resulted in wrong fw stats to be displayed as below.

root@OpenWrt:/# cat /sys/kernel/debug/ath11k/
		ipq8074\ hw2.0/mac0/fw_stats/pdev_stats | grep Illegal
Illegal rate phy errors   36839112

Note that this struct was missing its members from initial driver
support and this change doesn't introduce/modify the structure for
firmware changes.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1 v2

Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h | 29 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 41 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h  | 42 ++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9d97da2a3ba8..394ba7b9c8ab 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -802,12 +802,15 @@ struct ath11k_fw_stats_pdev {
 	s32 hw_reaped;
 	/* Num underruns */
 	s32 underrun;
+	/* Num hw paused */
+	u32 hw_paused;
 	/* Num PPDUs cleaned up in TX abort */
 	s32 tx_abort;
 	/* Num MPDUs requeued by SW */
 	s32 mpdus_requeued;
 	/* excessive retries */
 	u32 tx_ko;
+	u32 tx_xretry;
 	/* data hw rate code */
 	u32 data_rc;
 	/* Scheduler self triggers */
@@ -828,6 +831,30 @@ struct ath11k_fw_stats_pdev {
 	u32 phy_underrun;
 	/* MPDU is more than txop limit */
 	u32 txop_ovf;
+	/* Num sequences posted */
+	u32 seq_posted;
+	/* Num sequences failed in queueing */
+	u32 seq_failed_queueing;
+	/* Num sequences completed */
+	u32 seq_completed;
+	/* Num sequences restarted */
+	u32 seq_restarted;
+	/* Num of MU sequences posted */
+	u32 mu_seq_posted;
+	/* Num MPDUs flushed by SW, HWPAUSED, SW TXABORT
+	 * (Reset,channel change)
+	 */
+	s32 mpdus_sw_flush;
+	/* Num MPDUs filtered by HW, all filter condition (TTL expired) */
+	s32 mpdus_hw_filter;
+	/* Num MPDUs truncated by PDG (TXOP, TBTT,
+	 * PPDU_duration based on rate, dyn_bw)
+	 */
+	s32 mpdus_truncated;
+	/* Num MPDUs that was tried but didn't receive ACK or BA */
+	s32 mpdus_ack_failed;
+	/* Num MPDUs that was dropped du to expiry. */
+	s32 mpdus_expired;
 
 	/* PDEV RX stats */
 	/* Cnts any change in ring routing mid-ppdu */
@@ -853,6 +880,8 @@ struct ath11k_fw_stats_pdev {
 	s32 phy_err_drop;
 	/* Number of mpdu errors - FCS, MIC, ENC etc. */
 	s32 mpdu_errs;
+	/* Num overflow errors */
+	s32 rx_ovfl_errs;
 };
 
 struct ath11k_fw_stats_vdev {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 7ac84ac86aab..a95756dc14a1 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5251,9 +5251,11 @@ ath11k_wmi_pull_pdev_stats_tx(const struct wmi_pdev_stats_tx *src,
 	dst->hw_queued = src->hw_queued;
 	dst->hw_reaped = src->hw_reaped;
 	dst->underrun = src->underrun;
+	dst->hw_paused = src->hw_paused;
 	dst->tx_abort = src->tx_abort;
 	dst->mpdus_requeued = src->mpdus_requeued;
 	dst->tx_ko = src->tx_ko;
+	dst->tx_xretry = src->tx_xretry;
 	dst->data_rc = src->data_rc;
 	dst->self_triggers = src->self_triggers;
 	dst->sw_retry_failure = src->sw_retry_failure;
@@ -5264,6 +5266,16 @@ ath11k_wmi_pull_pdev_stats_tx(const struct wmi_pdev_stats_tx *src,
 	dst->stateless_tid_alloc_failure = src->stateless_tid_alloc_failure;
 	dst->phy_underrun = src->phy_underrun;
 	dst->txop_ovf = src->txop_ovf;
+	dst->seq_posted = src->seq_posted;
+	dst->seq_failed_queueing = src->seq_failed_queueing;
+	dst->seq_completed = src->seq_completed;
+	dst->seq_restarted = src->seq_restarted;
+	dst->mu_seq_posted = src->mu_seq_posted;
+	dst->mpdus_sw_flush = src->mpdus_sw_flush;
+	dst->mpdus_hw_filter = src->mpdus_hw_filter;
+	dst->mpdus_truncated = src->mpdus_truncated;
+	dst->mpdus_ack_failed = src->mpdus_ack_failed;
+	dst->mpdus_expired = src->mpdus_expired;
 }
 
 static void ath11k_wmi_pull_pdev_stats_rx(const struct wmi_pdev_stats_rx *src,
@@ -5283,6 +5295,7 @@ static void ath11k_wmi_pull_pdev_stats_rx(const struct wmi_pdev_stats_rx *src,
 	dst->phy_errs = src->phy_errs;
 	dst->phy_err_drop = src->phy_err_drop;
 	dst->mpdu_errs = src->mpdu_errs;
+	dst->rx_ovfl_errs = src->rx_ovfl_errs;
 }
 
 static void
@@ -5519,12 +5532,16 @@ ath11k_wmi_fw_pdev_tx_stats_fill(const struct ath11k_fw_stats_pdev *pdev,
 			 "PPDUs reaped", pdev->hw_reaped);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
 			 "Num underruns", pdev->underrun);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Num HW Paused", pdev->hw_paused);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
 			 "PPDUs cleaned", pdev->tx_abort);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
 			 "MPDUs requeued", pdev->mpdus_requeued);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
-			 "Excessive retries", pdev->tx_ko);
+			 "PPDU OK", pdev->tx_ko);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Excessive retries", pdev->tx_xretry);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
 			 "HW rate", pdev->data_rc);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
@@ -5548,6 +5565,26 @@ ath11k_wmi_fw_pdev_tx_stats_fill(const struct ath11k_fw_stats_pdev *pdev,
 			 "PHY underrun", pdev->phy_underrun);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
 			 "MPDU is more than txop limit", pdev->txop_ovf);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Num sequences posted", pdev->seq_posted);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Num seq failed queueing ", pdev->seq_failed_queueing);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Num sequences completed ", pdev->seq_completed);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Num sequences restarted ", pdev->seq_restarted);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Num of MU sequences posted ", pdev->mu_seq_posted);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Num of MPDUS SW flushed ", pdev->mpdus_sw_flush);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Num of MPDUS HW filtered ", pdev->mpdus_hw_filter);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Num of MPDUS truncated ", pdev->mpdus_truncated);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Num of MPDUS ACK failed ", pdev->mpdus_ack_failed);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10u\n",
+			 "Num of MPDUS expired ", pdev->mpdus_expired);
 	*length = len;
 }
 
@@ -5592,6 +5629,8 @@ ath11k_wmi_fw_pdev_rx_stats_fill(const struct ath11k_fw_stats_pdev *pdev,
 			 "PHY errors drops", pdev->phy_err_drop);
 	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
 			 "MPDU errors (FCS, MIC, ENC)", pdev->mpdu_errs);
+	len += scnprintf(buf + len, buf_len - len, "%30s %10d\n",
+			 "Overflow errors", pdev->rx_ovfl_errs);
 	*length = len;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index fb27a8d0f0fd..1fff74b2b476 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4221,6 +4221,9 @@ struct wmi_pdev_stats_tx {
 	/* Num underruns */
 	s32 underrun;
 
+	/* Num hw paused */
+	u32 hw_paused;
+
 	/* Num PPDUs cleaned up in TX abort */
 	s32 tx_abort;
 
@@ -4230,6 +4233,8 @@ struct wmi_pdev_stats_tx {
 	/* excessive retries */
 	u32 tx_ko;
 
+	u32 tx_xretry;
+
 	/* data hw rate code */
 	u32 data_rc;
 
@@ -4259,6 +4264,40 @@ struct wmi_pdev_stats_tx {
 
 	/* MPDU is more than txop limit */
 	u32 txop_ovf;
+
+	/* Num sequences posted */
+	u32 seq_posted;
+
+	/* Num sequences failed in queueing */
+	u32 seq_failed_queueing;
+
+	/* Num sequences completed */
+	u32 seq_completed;
+
+	/* Num sequences restarted */
+	u32 seq_restarted;
+
+	/* Num of MU sequences posted */
+	u32 mu_seq_posted;
+
+	/* Num MPDUs flushed by SW, HWPAUSED, SW TXABORT
+	 * (Reset,channel change)
+	 */
+	s32 mpdus_sw_flush;
+
+	/* Num MPDUs filtered by HW, all filter condition (TTL expired) */
+	s32 mpdus_hw_filter;
+
+	/* Num MPDUs truncated by PDG (TXOP, TBTT,
+	 * PPDU_duration based on rate, dyn_bw)
+	 */
+	s32 mpdus_truncated;
+
+	/* Num MPDUs that was tried but didn't receive ACK or BA */
+	s32 mpdus_ack_failed;
+
+	/* Num MPDUs that was dropped du to expiry. */
+	s32 mpdus_expired;
 } __packed;
 
 struct wmi_pdev_stats_rx {
@@ -4293,6 +4332,9 @@ struct wmi_pdev_stats_rx {
 
 	/* Number of mpdu errors - FCS, MIC, ENC etc. */
 	s32 mpdu_errs;
+
+	/* Num overflow errors */
+	s32 rx_ovfl_errs;
 } __packed;
 
 struct wmi_pdev_stats {
-- 
2.25.1

