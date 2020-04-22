Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722101B4092
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 12:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbgDVKql (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 06:46:41 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:31200 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731924AbgDVKqh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 06:46:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587552397; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=nF2mqe2X2heMFqxh+/wjXi7j4eUpyCSqzGllj8/TdTw=; b=O+uIRDVfHuYVWwVt5X16f5Nc5wWKeU76aj0zwgbuTx8f1W2Xaas1jE2VyfeTECDaggiHT9Ks
 RRYJ5pl0ZY8iJb5T6kh+GoSm7wDY4Urs7RxJnn0FiMrUXeNN4baWm8dutnwbobyKbTol7nRx
 8+pAHUH1tbG/cla7zM/uUbHIb8k=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea0208c.7f933c8bf030-smtp-out-n05;
 Wed, 22 Apr 2020 10:46:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49D55C433F2; Wed, 22 Apr 2020 10:46:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from CHECSTP284781-LIN.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C855BC433BA;
        Wed, 22 Apr 2020 10:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C855BC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] ath11k: fix reo flush send
Date:   Wed, 22 Apr 2020 16:16:18 +0530
Message-Id: <1587552378-4884-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

we are sending the reo flush command for the deleted peer
tid after the ageout period reaches 1 second. This handling
causes reo ring get full when more than 128 clients are
disconnected continuously. so added the count for flush list
and reo flush command is triggered after the list count reaches
the threshold value, it is configured as 64 (half of the reo ring).
This will avoid the situation where reo ring get full.

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.c    | 2 ++
 drivers/net/wireless/ath/ath11k/dp.h    | 9 ++++++++-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 6 +++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 50350f7..8d6fb84 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -880,6 +880,8 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 	INIT_LIST_HEAD(&dp->reo_cmd_cache_flush_list);
 	spin_lock_init(&dp->reo_cmd_lock);
 
+	dp->reo_cmd_cache_flush_count = 0;
+
 	ret = ath11k_wbm_idle_ring_setup(ab, &n_link_desc);
 	if (ret) {
 		ath11k_warn(ab, "failed to setup wbm_idle_ring: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index d4e19dc..222de10 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -36,6 +36,7 @@ struct dp_rx_tid {
 	struct ath11k_base *ab;
 };
 
+#define DP_REO_DESC_FREE_THRESHOLD  64
 #define DP_REO_DESC_FREE_TIMEOUT_MS 1000
 
 struct dp_reo_cache_flush_elem {
@@ -222,7 +223,13 @@ struct ath11k_dp {
 	struct hal_wbm_idle_scatter_list scatter_list[DP_IDLE_SCATTER_BUFS_MAX];
 	struct list_head reo_cmd_list;
 	struct list_head reo_cmd_cache_flush_list;
-	/* protects access to reo_cmd_list and reo_cmd_cache_flush_list */
+	u32 reo_cmd_cache_flush_count;
+	/**
+	 * protects access to below fields,
+	 * - reo_cmd_list
+	 * - reo_cmd_cache_flush_list
+	 * - reo_cmd_cache_flush_count
+	 */
 	spinlock_t reo_cmd_lock;
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index bbd7da4..d3d2a33 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -565,6 +565,7 @@ void ath11k_dp_reo_cmd_list_cleanup(struct ath11k_base *ab)
 	list_for_each_entry_safe(cmd_cache, tmp_cache,
 				 &dp->reo_cmd_cache_flush_list, list) {
 		list_del(&cmd_cache->list);
+		dp->reo_cmd_cache_flush_count--;
 		dma_unmap_single(ab->dev, cmd_cache->data.paddr,
 				 cmd_cache->data.size, DMA_BIDIRECTIONAL);
 		kfree(cmd_cache->data.vaddr);
@@ -651,15 +652,18 @@ static void ath11k_dp_rx_tid_del_func(struct ath11k_dp *dp, void *ctx,
 
 	spin_lock_bh(&dp->reo_cmd_lock);
 	list_add_tail(&elem->list, &dp->reo_cmd_cache_flush_list);
+	dp->reo_cmd_cache_flush_count++;
 	spin_unlock_bh(&dp->reo_cmd_lock);
 
 	/* Flush and invalidate aged REO desc from HW cache */
 	spin_lock_bh(&dp->reo_cmd_lock);
 	list_for_each_entry_safe(elem, tmp, &dp->reo_cmd_cache_flush_list,
 				 list) {
-		if (time_after(jiffies, elem->ts +
+		if (dp->reo_cmd_cache_flush_count > DP_REO_DESC_FREE_THRESHOLD ||
+		    time_after(jiffies, elem->ts +
 			       msecs_to_jiffies(DP_REO_DESC_FREE_TIMEOUT_MS))) {
 			list_del(&elem->list);
+			dp->reo_cmd_cache_flush_count--;
 			spin_unlock_bh(&dp->reo_cmd_lock);
 
 			ath11k_dp_reo_cache_flush(ab, &elem->data);
-- 
1.9.1
