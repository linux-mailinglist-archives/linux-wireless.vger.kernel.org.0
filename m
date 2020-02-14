Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7AD15CFD9
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 03:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgBNCTJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 21:19:09 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:23776 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728193AbgBNCTJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 21:19:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581646748; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+HxkQdsTCXATviJnL//XWBLKBXvbK4ggK5lI1KkfSzw=; b=Y1Dv9LEldCUvHujjVNZyUKBd41F68WBgn0b/DvRgjSuQSGV+qgfFmPUXcE9cFJ0TD4RtSeq+
 ZtT9440qPX2ivC34UliXtBBZeAFVkd1c6vO23GnC9SI7eIuQ9Ee2i4Gq1gcZ4ZfBzhb4ItDI
 X9Po0fl7qyEgzERIv9vuo+aWlVM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e46039b.7f635c6fe998-smtp-out-n03;
 Fri, 14 Feb 2020 02:19:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 89CBEC433A2; Fri, 14 Feb 2020 02:19:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from cheath10p342229-lin.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ADAADC43383;
        Fri, 14 Feb 2020 02:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADAADC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH] ath11k: config reorder queue for all tids during peer setup
Date:   Fri, 14 Feb 2020 07:48:44 +0530
Message-Id: <1581646724-23098-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govindaraj Saminathan <gsamin@codeaurora.org>

Currently rx tid setup is happening for TID 0 and TID 16
during peer setup. And if other TID packets received for
the peer it will be redirected to rx error ring and not through
reo ring. And this rx tid configuration cannot be done
in the rx error ring path since it is a atomic context.
So moving the rx tid setup for all tids during the peer setup.
This is required to enable PN offload functionality to route
all packets through reo ring.

Co-developed-by: Tamizh Chelvam <tamizhr@codeaurora.org>
Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.c    | 41 ++++++++++++++++++++++-----------
 drivers/net/wireless/ath/ath11k/dp.h    |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c |  4 ++--
 drivers/net/wireless/ath/ath11k/dp_rx.h |  2 ++
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index b112825..ce76341 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -39,8 +39,9 @@ void ath11k_dp_peer_cleanup(struct ath11k *ar, int vdev_id, const u8 *addr)
 int ath11k_dp_peer_setup(struct ath11k *ar, int vdev_id, const u8 *addr)
 {
 	struct ath11k_base *ab = ar->ab;
+	struct ath11k_peer *peer;
 	u32 reo_dest;
-	int ret;
+	int ret = 0, tid;
 
 	/* NOTE: reo_dest ring id starts from 1 unlike mac_id which starts from 0 */
 	reo_dest = ar->dp.mac_id + 1;
@@ -54,24 +55,36 @@ int ath11k_dp_peer_setup(struct ath11k *ar, int vdev_id, const u8 *addr)
 		return ret;
 	}
 
-	ret = ath11k_peer_rx_tid_setup(ar, addr, vdev_id,
-				       HAL_DESC_REO_NON_QOS_TID, 1, 0);
-	if (ret) {
-		ath11k_warn(ab, "failed to setup rxd tid queue for non-qos tid %d\n",
-			    ret);
-		return ret;
-	}
-
-	ret = ath11k_peer_rx_tid_setup(ar, addr, vdev_id, 0, 1, 0);
-	if (ret) {
-		ath11k_warn(ab, "failed to setup rxd tid queue for tid 0 %d\n",
-			    ret);
-		return ret;
+	for (tid = 0; tid <= IEEE80211_NUM_TIDS; tid++) {
+		ret = ath11k_peer_rx_tid_setup(ar, addr, vdev_id,
+					       tid, 1, 0);
+		if (ret) {
+			ath11k_warn(ab, "failed to setup rxd tid queue for tid %d: %d\n",
+				    tid, ret);
+			goto peer_clean;
+		}
 	}
 
 	/* TODO: Setup other peer specific resource used in data path */
 
 	return 0;
+
+peer_clean:
+	spin_lock_bh(&ab->base_lock);
+
+	peer = ath11k_peer_find(ab, vdev_id, addr);
+	if (!peer) {
+		ath11k_warn(ab, "failed to find the peer to del rx tid\n");
+		spin_unlock_bh(&ab->base_lock);
+		return -ENOENT;
+	}
+
+	for (; tid >= 0; tid--)
+		ath11k_peer_rx_tid_delete(ar, peer, tid);
+
+	spin_unlock_bh(&ab->base_lock);
+
+	return ret;
 }
 
 void ath11k_dp_srng_cleanup(struct ath11k_base *ab, struct dp_srng *ring)
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 3592c39..4f9e4ce 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -168,7 +168,7 @@ struct ath11k_pdev_dp {
 #define DP_RX_RELEASE_RING_SIZE		1024
 #define DP_REO_EXCEPTION_RING_SIZE	128
 #define DP_REO_CMD_RING_SIZE		128
-#define DP_REO_STATUS_RING_SIZE		256
+#define DP_REO_STATUS_RING_SIZE		2048
 #define DP_RXDMA_BUF_RING_SIZE		4096
 #define DP_RXDMA_REFILL_RING_SIZE	2048
 #define DP_RXDMA_ERR_DST_RING_SIZE	1024
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 6dfaea1..dc7881b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -633,8 +633,8 @@ static void ath11k_dp_rx_tid_del_func(struct ath11k_dp *dp, void *ctx,
 	kfree(rx_tid->vaddr);
 }
 
-static void ath11k_peer_rx_tid_delete(struct ath11k *ar,
-				      struct ath11k_peer *peer, u8 tid)
+void ath11k_peer_rx_tid_delete(struct ath11k *ar,
+			       struct ath11k_peer *peer, u8 tid)
 {
 	struct ath11k_hal_reo_cmd cmd = {0};
 	struct dp_rx_tid *rx_tid = &peer->rx_tid[tid];
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
index eec5dea..1b08b7d 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -44,6 +44,8 @@ int ath11k_dp_rx_ampdu_start(struct ath11k *ar,
 int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 			    struct ieee80211_ampdu_params *params);
 void ath11k_peer_rx_tid_cleanup(struct ath11k *ar, struct ath11k_peer *peer);
+void ath11k_peer_rx_tid_delete(struct ath11k *ar,
+			       struct ath11k_peer *peer, u8 tid);
 int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
 			     u8 tid, u32 ba_win_sz, u16 ssn);
 void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
-- 
1.9.1
