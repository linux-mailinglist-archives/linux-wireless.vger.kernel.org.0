Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A865E10C4E6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfK1IV7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:21:59 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:54782
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbfK1IV7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574929318;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=fYh+h0OLmMSbGrKdOftWyma26CCH4Pw5VCOMKmEOevE=;
        b=nAHENxwoIfys5OZTooOdwsjyhN2sfm8P4RWuNpwZkz+cVdCsaYR/DrdVNH9p5eGv
        x+ClDH/5izf9Xe5THba2ckqlf7QNI+/vrVAF1f5iUfFry0IehvZigN0+mFE8DFThHAN
        A4ZJ3eOriEVgz2RTL2Jwm50fARNyX7Vig5f3w9Lk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574929318;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=fYh+h0OLmMSbGrKdOftWyma26CCH4Pw5VCOMKmEOevE=;
        b=ZUty63nsWIbZkNZLZNaRqHEr0eB7jsX7FL7BAQdCx1zYjudSz6pocq6du2a0dSzv
        OqwuHYIu5HxJI4E80iaszbxbUU7mcPGlnfxUYFL0PgfM5vwiJrPe+ItqXALkrQDZz2K
        EIsM1cF/vC0FFqqiflLhEcebbeFnxBYuMyTLATZk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A945C48B38
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 8/9] ath11k: Setup REO destination ring before sending wmi_init command
Date:   Thu, 28 Nov 2019 08:21:58 +0000
Message-ID: <0101016eb11a409c-82b249a6-9f02-4f9e-bab1-c28e04c7bc1e-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
References: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.28-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>

Firmware expects all the required REO destination rings setup
while processing wmi_init command. Not doing this causes connected
stations getting disconnected and not able to connect back.

Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c  | 19 +++++++++++--
 drivers/net/wireless/ath/ath11k/dp.c    | 10 +++++--
 drivers/net/wireless/ath/ath11k/dp.h    |  1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c | 49 +++++++++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/dp_rx.h |  2 ++
 5 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c9c9e4b5ef6b..5cdc9b2aee51 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -10,6 +10,7 @@
 #include "ahb.h"
 #include "core.h"
 #include "dp_tx.h"
+#include "dp_rx.h"
 #include "debug.h"
 
 unsigned int ath11k_debug_mask;
@@ -325,6 +326,7 @@ static void ath11k_core_stop(struct ath11k_base *ab)
 		ath11k_qmi_firmware_stop(ab);
 	ath11k_ahb_stop(ab);
 	ath11k_wmi_detach(ab);
+	ath11k_dp_pdev_reo_cleanup(ab);
 
 	/* De-Init of components as needed */
 }
@@ -476,28 +478,38 @@ static int ath11k_core_start(struct ath11k_base *ab,
 		goto err_hif_stop;
 	}
 
+	ath11k_dp_pdev_pre_alloc(ab);
+
+	ret = ath11k_dp_pdev_reo_setup(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to initialize reo destination rings: %d\n", ret);
+		goto err_mac_destroy;
+	}
+
 	ret = ath11k_wmi_cmd_init(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to send wmi init cmd: %d\n", ret);
-		goto err_mac_destroy;
+		goto err_reo_cleanup;
 	}
 
 	ret = ath11k_wmi_wait_for_unified_ready(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to receive wmi unified ready event: %d\n",
 			   ret);
-		goto err_mac_destroy;
+		goto err_reo_cleanup;
 	}
 
 	ret = ath11k_dp_tx_htt_h2t_ver_req_msg(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to send htt version request message: %d\n",
 			   ret);
-		goto err_mac_destroy;
+		goto err_reo_cleanup;
 	}
 
 	return 0;
 
+err_reo_cleanup:
+	ath11k_dp_pdev_reo_cleanup(ab);
 err_mac_destroy:
 	ath11k_mac_destroy(ab);
 err_hif_stop:
@@ -561,6 +573,7 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	ath11k_dp_pdev_free(ab);
 	ath11k_ahb_stop(ab);
 	ath11k_wmi_detach(ab);
+	ath11k_dp_pdev_reo_cleanup(ab);
 	mutex_unlock(&ab->core_lock);
 
 	ath11k_dp_free(ab);
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 72c21cf6a352..b966a16a930f 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -684,11 +684,10 @@ void ath11k_dp_pdev_free(struct ath11k_base *ab)
 	}
 }
 
-int ath11k_dp_pdev_alloc(struct ath11k_base *ab)
+void ath11k_dp_pdev_pre_alloc(struct ath11k_base *ab)
 {
 	struct ath11k *ar;
 	struct ath11k_pdev_dp *dp;
-	int ret;
 	int i;
 
 	for (i = 0; i <  ab->num_radios; i++) {
@@ -704,6 +703,13 @@ int ath11k_dp_pdev_alloc(struct ath11k_base *ab)
 		idr_init(&dp->rxdma_mon_buf_ring.bufs_idr);
 		spin_lock_init(&dp->rxdma_mon_buf_ring.idr_lock);
 	}
+}
+
+int ath11k_dp_pdev_alloc(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	int ret;
+	int i;
 
 	/* TODO:Per-pdev rx ring unlike tx ring which is mapped to different AC's */
 	for (i = 0; i < ab->num_radios; i++) {
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 82ddd7017722..f7e53509ae07 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1507,6 +1507,7 @@ void ath11k_dp_vdev_tx_attach(struct ath11k *ar, struct ath11k_vif *arvif);
 void ath11k_dp_free(struct ath11k_base *ab);
 int ath11k_dp_alloc(struct ath11k_base *ab);
 int ath11k_dp_pdev_alloc(struct ath11k_base *ab);
+void ath11k_dp_pdev_pre_alloc(struct ath11k_base *ab);
 void ath11k_dp_pdev_free(struct ath11k_base *ab);
 int ath11k_dp_tx_htt_srng_setup(struct ath11k_base *ab, u32 ring_id,
 				int mac_id, enum hal_ring_type ring_type);
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index a380efb9caa6..1b3b65c0038c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -395,12 +395,51 @@ static void ath11k_dp_rx_pdev_srng_free(struct ath11k *ar)
 	struct ath11k_pdev_dp *dp = &ar->dp;
 
 	ath11k_dp_srng_cleanup(ar->ab, &dp->rx_refill_buf_ring.refill_buf_ring);
-	ath11k_dp_srng_cleanup(ar->ab, &dp->reo_dst_ring);
 	ath11k_dp_srng_cleanup(ar->ab, &dp->rxdma_err_dst_ring);
 	ath11k_dp_srng_cleanup(ar->ab, &dp->rx_mon_status_refill_ring.refill_buf_ring);
 	ath11k_dp_srng_cleanup(ar->ab, &dp->rxdma_mon_buf_ring.refill_buf_ring);
 }
 
+void ath11k_dp_pdev_reo_cleanup(struct ath11k_base *ab)
+{
+	struct ath11k_pdev_dp *dp;
+	struct ath11k *ar;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		dp = &ar->dp;
+		ath11k_dp_srng_cleanup(ab, &dp->reo_dst_ring);
+	}
+}
+
+int ath11k_dp_pdev_reo_setup(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	struct ath11k_pdev_dp *dp;
+	int ret;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		dp = &ar->dp;
+		ret = ath11k_dp_srng_setup(ab, &dp->reo_dst_ring, HAL_REO_DST,
+					   dp->mac_id, dp->mac_id,
+					   DP_REO_DST_RING_SIZE);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to setup reo_dst_ring\n");
+			goto err_reo_cleanup;
+		}
+	}
+
+	return 0;
+
+err_reo_cleanup:
+	ath11k_dp_pdev_reo_cleanup(ab);
+
+	return ret;
+}
+
 static int ath11k_dp_rx_pdev_srng_alloc(struct ath11k *ar)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
@@ -416,14 +455,6 @@ static int ath11k_dp_rx_pdev_srng_alloc(struct ath11k *ar)
 		return ret;
 	}
 
-	ret = ath11k_dp_srng_setup(ar->ab, &dp->reo_dst_ring, HAL_REO_DST,
-				   dp->mac_id, dp->mac_id,
-				   DP_REO_DST_RING_SIZE);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to setup reo_dst_ring\n");
-		return ret;
-	}
-
 	ret = ath11k_dp_srng_setup(ar->ab, &dp->rxdma_err_dst_ring,
 				   HAL_RXDMA_DST, 0, dp->mac_id,
 				   DP_RXDMA_ERR_DST_RING_SIZE);
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
index 026820fda568..eec5deaa59ad 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -48,6 +48,8 @@ int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 			     u8 tid, u32 ba_win_sz, u16 ssn);
 void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
 				       struct sk_buff *skb);
+int ath11k_dp_pdev_reo_setup(struct ath11k_base *ab);
+void ath11k_dp_pdev_reo_cleanup(struct ath11k_base *ab);
 int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int pdev_idx);
 void ath11k_dp_rx_pdev_free(struct ath11k_base *ab, int pdev_idx);
 void ath11k_dp_reo_cmd_list_cleanup(struct ath11k_base *ab);
-- 
2.7.4

