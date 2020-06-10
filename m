Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6561F4D52
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 07:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgFJFyK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 01:54:10 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:25221 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbgFJFyJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 01:54:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591768448; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=44MuQsyGhEukp7LqAVk9UQ93IDmOZMstEIdoDinpIr8=; b=F5QP1I1YFLgQzqmrZjSjyhAvNsMeodofQuUgn4HMyxUJAkG0QRgg4wXXod7PkVo1B5t2YP/H
 lxRBe9SObbUgzLsUeL2pSasFpteiB14VKgJwak5TynFx0ODRALCJC4SRakirfYhDwLPNw+JV
 UBMu6vzX+s/7A8Nk4qw6WZGToDc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ee0757686de6ccd440c8a91 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Jun 2020 05:53:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3ADB8C43387; Wed, 10 Jun 2020 05:53:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1FC5C43391;
        Wed, 10 Jun 2020 05:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1FC5C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>
Subject: [PATCH 1/2] ath11k: Add dp tx err stats
Date:   Wed, 10 Jun 2020 11:21:47 +0530
Message-Id: <1591768308-32005-2-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591768308-32005-1-git-send-email-srirrama@codeaurora.org>
References: <1591768308-32005-1-git-send-email-srirrama@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for dp tx error stats which logs tx failure reasons due
to ring full condition, etc. This stats is added in soc_dp_stats
which was earlier used as soc_rx_stats so that all dp related info
are logged in same file.

Below is an example usage,

root@OpenWrt:/# cat /sys/kernel/debug/ath11k/ipq8074/soc_dp_stats
SOC RX STATS:

err ring pkts: 0
Invalid RBM: 0
<snip>

SOC TX STATS:

Ring Full Failures:
ring0: 4
ring1: 3
ring2: 5

Misc Transmit Failures: 2

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01213-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sriram R <srirrama@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h  | 14 ++++++++++++--
 drivers/net/wireless/ath/ath11k/debug.c | 23 +++++++++++++++++------
 drivers/net/wireless/ath/ath11k/dp_tx.c |  7 ++++++-
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index f9e0f30..c50c832 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -582,12 +582,22 @@ struct ath11k_board_data {
 /* IPQ8074 HW channel counters frequency value in hertz */
 #define IPQ8074_CC_FREQ_HERTZ 320000
 
-struct ath11k_soc_dp_rx_stats {
+struct ath11k_soc_dp_tx_err_stats {
+	/* TCL Ring Descriptor unavailable */
+	u32 desc_na[DP_TCL_NUM_RING_MAX];
+	/* Other failures during dp_tx due to mem allocation failure
+	 * idr unavailable etc.
+	 */
+	atomic_t misc_fail;
+};
+
+struct ath11k_soc_dp_stats {
 	u32 err_ring_pkts;
 	u32 invalid_rbm;
 	u32 rxdma_error[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX];
 	u32 reo_error[HAL_REO_DEST_RING_ERROR_CODE_MAX];
 	u32 hal_reo_error[DP_REO_DST_RING_MAX];
+	struct ath11k_soc_dp_tx_err_stats tx_err;
 };
 
 /* Master structure to hold the hw data which may be used in core module */
@@ -656,7 +666,7 @@ struct ath11k_base {
 	struct dentry *debugfs_soc;
 	struct dentry *debugfs_ath11k;
 #endif
-	struct ath11k_soc_dp_rx_stats soc_stats;
+	struct ath11k_soc_dp_stats soc_stats;
 
 	unsigned long dev_flags;
 	struct completion driver_recovery;
diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 3fd6b5a..647d5a5 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -739,12 +739,12 @@ static const struct file_operations fops_extd_rx_stats = {
 	.open = simple_open,
 };
 
-static ssize_t ath11k_debug_dump_soc_rx_stats(struct file *file,
+static ssize_t ath11k_debug_dump_soc_dp_stats(struct file *file,
 					      char __user *user_buf,
 					      size_t count, loff_t *ppos)
 {
 	struct ath11k_base *ab = file->private_data;
-	struct ath11k_soc_dp_rx_stats *soc_stats = &ab->soc_stats;
+	struct ath11k_soc_dp_stats *soc_stats = &ab->soc_stats;
 	int len = 0, i, retval;
 	const int size = 4096;
 	static const char *rxdma_err[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX] = {
@@ -788,6 +788,17 @@ static ssize_t ath11k_debug_dump_soc_rx_stats(struct file *file,
 			 soc_stats->hal_reo_error[2],
 			 soc_stats->hal_reo_error[3]);
 
+	len += scnprintf(buf + len, size - len, "\nSOC TX STATS:\n");
+	len += scnprintf(buf + len, size - len, "\nTCL Ring Full Failures:\n");
+
+	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
+		len += scnprintf(buf + len, size - len, "ring%d: %u\n",
+				 i, soc_stats->tx_err.desc_na[i]);
+
+	len += scnprintf(buf + len, size - len,
+			 "\nMisc Transmit Failures: %d\n",
+			 atomic_read(&soc_stats->tx_err.misc_fail));
+
 	if (len > size)
 		len = size;
 	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
@@ -796,8 +807,8 @@ static ssize_t ath11k_debug_dump_soc_rx_stats(struct file *file,
 	return retval;
 }
 
-static const struct file_operations fops_soc_rx_stats = {
-	.read = ath11k_debug_dump_soc_rx_stats,
+static const struct file_operations fops_soc_dp_stats = {
+	.read = ath11k_debug_dump_soc_dp_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -819,8 +830,8 @@ int ath11k_debug_pdev_create(struct ath11k_base *ab)
 	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
 			    &fops_simulate_fw_crash);
 
-	debugfs_create_file("soc_rx_stats", 0600, ab->debugfs_soc, ab,
-			    &fops_soc_rx_stats);
+	debugfs_create_file("soc_dp_stats", 0600, ab->debugfs_soc, ab,
+			    &fops_soc_dp_stats);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 41c990a..1af7677 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -121,8 +121,10 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	spin_unlock_bh(&tx_ring->tx_idr_lock);
 
 	if (ret < 0) {
-		if (ring_map == (BIT(DP_TCL_NUM_RING_MAX) - 1))
+		if (ring_map == (BIT(DP_TCL_NUM_RING_MAX) - 1)) {
+			atomic_inc(&ab->soc_stats.tx_err.misc_fail);
 			return -ENOSPC;
+		}
 
 		/* Check if the next ring is available */
 		ring_selector++;
@@ -180,11 +182,13 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	default:
 		/* TODO: Take care of other encap modes as well */
 		ret = -EINVAL;
+		atomic_inc(&ab->soc_stats.tx_err.misc_fail);
 		goto fail_remove_idr;
 	}
 
 	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
 	if (dma_mapping_error(ab->dev, ti.paddr)) {
+		atomic_inc(&ab->soc_stats.tx_err.misc_fail);
 		ath11k_warn(ab, "failed to DMA map data Tx buffer\n");
 		ret = -ENOMEM;
 		goto fail_remove_idr;
@@ -208,6 +212,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		 * desc because the desc is directly enqueued onto hw queue.
 		 */
 		ath11k_hal_srng_access_end(ab, tcl_ring);
+		ab->soc_stats.tx_err.desc_na[ti.ring_id]++;
 		spin_unlock_bh(&tcl_ring->lock);
 		ret = -ENOMEM;
 
-- 
2.7.4

