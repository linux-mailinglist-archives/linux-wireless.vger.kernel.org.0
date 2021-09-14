Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD140B50A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 18:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhINQjI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 12:39:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41168 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhINQjG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 12:39:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631637468; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=sLaQzkNRo7oJJ9nFi+ZgDsCCfbqUKv/mSo110VKOCkk=; b=omofv5qcQeecxRConzVOFdv6ghiSlYaCEX6QycpTFa6fq6FPSFUJGeH2NLjiGyjpAlnHlPMj
 4YRa3A6rHi1AmXcHu49ETARfFH+ELCiEluf1vB7kAsTlJP7fC1z4ZYj2b5EY97Wq8kOybyMP
 I6ByKi545FYJ9pZAcUtCrkyMaGs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6140cfcf648642cc1c5cb55f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Sep 2021 16:37:35
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4FCE0C43619; Tue, 14 Sep 2021 16:37:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D69BC43618;
        Tue, 14 Sep 2021 16:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8D69BC43618
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/3] ath11k: Change number of TCL rings to one for QCA6390
Date:   Tue, 14 Sep 2021 19:37:24 +0300
Message-Id: <20210914163726.38604-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

Some targets, QCA6390 for example, use only one TCL ring,
it is better to initialize only one ring and leave others
untouched for such targets.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c    | 10 +++++-----
 drivers/net/wireless/ath/ath11k/debugfs.c |  2 +-
 drivers/net/wireless/ath/ath11k/dp.c      | 10 +++++-----
 drivers/net/wireless/ath/ath11k/dp.h      |  1 +
 drivers/net/wireless/ath/ath11k/dp_tx.c   | 13 +++++--------
 drivers/net/wireless/ath/ath11k/hw.h      |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c     |  2 +-
 7 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a8c6f7cf33d5..af76e37d11ae 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -58,7 +58,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.rx_mac_buf_ring = false,
 		.vdev_start_delay = false,
 		.htt_peer_map_v2 = true,
-		.tcl_0_only = false,
 		.spectral = {
 			.fft_sz = 2,
 			/* HW bug, expected BIN size is 2 bytes but HW report as 4 bytes.
@@ -82,6 +81,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
 		.sram_dump = NULL,
+		.max_tx_ring = DP_TCL_NUM_RING_MAX,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -110,7 +110,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.rx_mac_buf_ring = false,
 		.vdev_start_delay = false,
 		.htt_peer_map_v2 = true,
-		.tcl_0_only = false,
 		.spectral = {
 			.fft_sz = 4,
 			.fft_pad_sz = 0,
@@ -131,6 +130,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
 		.sram_dump = NULL,
+		.max_tx_ring = DP_TCL_NUM_RING_MAX,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -159,7 +159,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
 		.htt_peer_map_v2 = false,
-		.tcl_0_only = true,
 		.spectral = {
 			.fft_sz = 0,
 			.fft_pad_sz = 0,
@@ -179,6 +178,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
 		.sram_dump = &sram_dump_qca6390,
+		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -206,7 +206,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.rx_mac_buf_ring = false,
 		.vdev_start_delay = false,
 		.htt_peer_map_v2 = true,
-		.tcl_0_only = false,
 		.spectral = {
 			.fft_sz = 2,
 			.fft_pad_sz = 0,
@@ -227,6 +226,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 		.fix_l1ss = true,
 		.sram_dump = NULL,
+		.max_tx_ring = DP_TCL_NUM_RING_MAX,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -255,7 +255,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
 		.htt_peer_map_v2 = false,
-		.tcl_0_only = true,
 		.spectral = {
 			.fft_sz = 0,
 			.fft_pad_sz = 0,
@@ -274,6 +273,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.fix_l1ss = false,
 		.sram_dump = &sram_dump_wcn6855,
+		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 871445f4e96a..0b42df65e4dc 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -807,7 +807,7 @@ static ssize_t ath11k_debugfs_dump_soc_dp_stats(struct file *file,
 	len += scnprintf(buf + len, size - len, "\nSOC TX STATS:\n");
 	len += scnprintf(buf + len, size - len, "\nTCL Ring Full Failures:\n");
 
-	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
+	for (i = 0; i < ab->hw_params.max_tx_ring; i++)
 		len += scnprintf(buf + len, size - len, "ring%d: %u\n",
 				 i, soc_stats->tx_err.desc_na[i]);
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index dd69ba8f7d80..f7049a13973d 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -311,7 +311,7 @@ void ath11k_dp_stop_shadow_timers(struct ath11k_base *ab)
 	if (!ab->hw_params.supports_shadow_regs)
 		return;
 
-	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
+	for (i = 0; i < ab->hw_params.max_tx_ring; i++)
 		ath11k_dp_shadow_stop_timer(ab, &ab->dp.tx_ring_timer[i]);
 
 	ath11k_dp_shadow_stop_timer(ab, &ab->dp.reo_cmd_timer);
@@ -326,7 +326,7 @@ static void ath11k_dp_srng_common_cleanup(struct ath11k_base *ab)
 	ath11k_dp_srng_cleanup(ab, &dp->wbm_desc_rel_ring);
 	ath11k_dp_srng_cleanup(ab, &dp->tcl_cmd_ring);
 	ath11k_dp_srng_cleanup(ab, &dp->tcl_status_ring);
-	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++) {
+	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
 		ath11k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_data_ring);
 		ath11k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_comp_ring);
 	}
@@ -366,7 +366,7 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
 		goto err;
 	}
 
-	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++) {
+	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
 		ret = ath11k_dp_srng_setup(ab, &dp->tx_ring[i].tcl_data_ring,
 					   HAL_TCL_DATA, i, 0,
 					   DP_TCL_DATA_RING_SIZE);
@@ -996,7 +996,7 @@ void ath11k_dp_free(struct ath11k_base *ab)
 
 	ath11k_dp_reo_cmd_list_cleanup(ab);
 
-	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++) {
+	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
 		spin_lock_bh(&dp->tx_ring[i].tx_idr_lock);
 		idr_for_each(&dp->tx_ring[i].txbuf_idr,
 			     ath11k_dp_tx_pending_cleanup, ab);
@@ -1047,7 +1047,7 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 
 	size = sizeof(struct hal_wbm_release_ring) * DP_TX_COMP_RING_SIZE;
 
-	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++) {
+	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
 		idr_init(&dp->tx_ring[i].txbuf_idr);
 		spin_lock_init(&dp->tx_ring[i].tx_idr_lock);
 		dp->tx_ring[i].tcl_data_ring_id = i;
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 36ef85e9515a..64c90cfd9c38 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -193,6 +193,7 @@ struct ath11k_pdev_dp {
 #define DP_BA_WIN_SZ_MAX	256
 
 #define DP_TCL_NUM_RING_MAX	3
+#define DP_TCL_NUM_RING_MAX_QCA6390	1
 
 #define DP_IDLE_SCATTER_BUFS_MAX 16
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 125a9a8a5b0a..6ef9b5d0b11a 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -115,11 +115,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 
 tcl_ring_sel:
 	tcl_ring_retry = false;
-	/* For some chip, it can only use tcl0 to tx */
-	if (ar->ab->hw_params.tcl_0_only)
-		ti.ring_id = 0;
-	else
-		ti.ring_id = ring_selector % DP_TCL_NUM_RING_MAX;
+
+	ti.ring_id = ring_selector % ab->hw_params.max_tx_ring;
 
 	ring_map |= BIT(ti.ring_id);
 
@@ -131,7 +128,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	spin_unlock_bh(&tx_ring->tx_idr_lock);
 
 	if (ret < 0) {
-		if (ring_map == (BIT(DP_TCL_NUM_RING_MAX) - 1)) {
+		if (ring_map == (BIT(ab->hw_params.max_tx_ring) - 1)) {
 			atomic_inc(&ab->soc_stats.tx_err.misc_fail);
 			return -ENOSPC;
 		}
@@ -248,8 +245,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		 * checking this ring earlier for each pkt tx.
 		 * Restart ring selection if some rings are not checked yet.
 		 */
-		if (ring_map != (BIT(DP_TCL_NUM_RING_MAX) - 1) &&
-		    !ar->ab->hw_params.tcl_0_only) {
+		if (ring_map != (BIT(ab->hw_params.max_tx_ring) - 1) &&
+		    ab->hw_params.max_tx_ring > 1) {
 			tcl_ring_retry = true;
 			ring_selector++;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 484c0bcec86d..6e68c5b60eaa 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -158,7 +158,6 @@ struct ath11k_hw_params {
 	bool rx_mac_buf_ring;
 	bool vdev_start_delay;
 	bool htt_peer_map_v2;
-	bool tcl_0_only;
 
 	struct {
 		u8 fft_sz;
@@ -179,6 +178,7 @@ struct ath11k_hw_params {
 	u32 hal_desc_sz;
 	bool fix_l1ss;
 	const struct ath11k_hw_sram_dump *sram_dump;
+	u8 max_tx_ring;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 155ca6af1b45..1f4765e43546 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5731,7 +5731,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	idr_for_each(&ar->txmgmt_idr,
 		     ath11k_mac_vif_txmgmt_idr_remove, vif);
 
-	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++) {
+	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
 		spin_lock_bh(&ab->dp.tx_ring[i].tx_idr_lock);
 		idr_for_each(&ab->dp.tx_ring[i].txbuf_idr,
 			     ath11k_mac_vif_unref, vif);
-- 
2.25.1

