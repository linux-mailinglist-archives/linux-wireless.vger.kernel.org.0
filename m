Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8C1A48C8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 19:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDJRFg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 13:05:36 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47827 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgDJRFg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 13:05:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586538335; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=TI264FmlRMIEDjqWeS2Hwvh7QW6HEg4XFbSy1GYz9fQ=; b=ttndIKf/baUx+ZaGKEbs7vHMXHTWStHgk+Bbpy/X6tCyVC/aRfMY4JvXVEmf/8xUYtgmxmMM
 77dIGOCYduzg+nJQKUXNo2Nv7/wJ6d+FsYw8gcI6i7eJY9EQiQwjGoRN73PLHn1cnNnXCw0T
 7YtkDt2S9jH6aPUW0jtPFz7lXSg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e90a757.7f220de0aab0-smtp-out-n05;
 Fri, 10 Apr 2020 17:05:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 00836C432C2; Fri, 10 Apr 2020 17:05:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from che-swdbs-01.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B542C433CB;
        Fri, 10 Apr 2020 17:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B542C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH] ath11k: Fix rx_filter flags setting for per peer rx_stats
Date:   Fri, 10 Apr 2020 22:36:45 +0530
Message-Id: <1586538405-16226-3-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1586538405-16226-1-git-send-email-mkenna@codeaurora.org>
References: <1586538405-16226-1-git-send-email-mkenna@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rx_filter flags are set with default filter flags during
wifi up/down sequence even though the 'ext_rx_stats' debugfs
is enabled as 1. So, that we are not getting proper per peer
rx_stats.
Hence, fixing this by setting the missing rx_filter when
ext_rx_stats is already set/enabled.

Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h  |  1 +
 drivers/net/wireless/ath/ath11k/debug.c |  2 ++
 drivers/net/wireless/ath/ath11k/debug.h | 10 ++++++++++
 drivers/net/wireless/ath/ath11k/mac.c   |  4 +++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b4c3e041..a8ef95f 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -392,6 +392,7 @@ struct ath11k_debug {
 	u32 pktlog_mode;
 	u32 pktlog_peer_valid;
 	u8 pktlog_peer_addr[ETH_ALEN];
+	u32 rx_filter;
 };
 
 struct ath11k_per_peer_tx_stats {
diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 8d48517..e479504 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -698,6 +698,8 @@ static ssize_t ath11k_write_extd_rx_stats(struct file *file,
 		tlv_filter = ath11k_mac_mon_status_filter_default;
 	}
 
+	ar->debug.rx_filter = tlv_filter.rx_filter;
+
 	ring_id = ar->dp.rx_mon_status_refill_ring.refill_buf_ring.ring_id;
 	ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, ar->dp.mac_id,
 					       HAL_RXDMA_MONITOR_STATUS,
diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index 4a3ff82..45454fc 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -188,6 +188,11 @@ static inline int ath11k_debug_is_extd_rx_stats_enabled(struct ath11k *ar)
 	return ar->debug.extd_rx_stats;
 }
 
+static inline int ath11k_debug_rx_filter(struct ath11k *ar)
+{
+	return ar->debug.rx_filter;
+}
+
 void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir);
 void
@@ -269,6 +274,11 @@ static inline bool ath11k_debug_is_pktlog_peer_valid(struct ath11k *ar, u8 *addr
 	return false;
 }
 
+static inline int ath11k_debug_rx_filter(struct ath11k *ar)
+{
+	return 0;
+}
+
 static inline void
 ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
 				    struct ath11k_per_peer_tx_stats *peer_stats,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9f8bc19..3665e72 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3877,8 +3877,10 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 ring_id;
 
-	if (enable)
+	if (enable) {
 		tlv_filter = ath11k_mac_mon_status_filter_default;
+		tlv_filter.rx_filter = ath11k_debug_rx_filter(ar);
+	}
 
 	ring_id = ar->dp.rx_mon_status_refill_ring.refill_buf_ring.ring_id;
 
-- 
1.9.1
