Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1480826CA47
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 21:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgIPTxo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 15:53:44 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:42049 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727497AbgIPTw5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 15:52:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600285974; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=IT9UQsEPpdqEsMlHAttksCI8ETPdfRlAtRrXCa84qnk=; b=NvElFUUbh41StXSyfWI4xHxq5UJuJAxSfPoZXU1dKFhVPBNXR+WHKZAN54C1p5C03Hn1GJBL
 oiHxbcYyH+XBBidDzqKuDDsbWIK4nMhhxjiEbTnECd8SDVPWp2v/8ttVR1jtpvpWJRlwyklH
 w0GA8EGur62mf/KAydcQzz23nP8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f621955d2819a18460104d1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 13:55:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A197C433FE; Wed, 16 Sep 2020 13:55:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11741C433CA;
        Wed, 16 Sep 2020 13:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11741C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] ath11k: debugfs: use ath11k_debugfs_ prefix
Date:   Wed, 16 Sep 2020 16:55:21 +0300
Message-Id: <1600264523-12939-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600264523-12939-1-git-send-email-kvalo@codeaurora.org>
References: <1600264523-12939-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As these functions are now defined in debugfs.c change the prefix to use
ath11k_debugfs_ as well.

No functional changes. Compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c        | 12 +++---
 drivers/net/wireless/ath/ath11k/debugfs.c     | 46 ++++++++++-----------
 drivers/net/wireless/ath/ath11k/debugfs.h     | 58 +++++++++++++--------------
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |  4 +-
 drivers/net/wireless/ath/ath11k/dp.c          |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  8 ++--
 drivers/net/wireless/ath/ath11k/dp_tx.c       |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c         |  6 +--
 drivers/net/wireless/ath/ath11k/wmi.c         |  2 +-
 9 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index ce81702b27d2..1277f5117548 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -412,7 +412,7 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 		return ret;
 	}
 
-	ret = ath11k_debug_soc_create(ab);
+	ret = ath11k_debugfs_soc_create(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to create ath11k debugfs\n");
 		goto err_qmi_deinit;
@@ -427,7 +427,7 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 	return 0;
 
 err_debugfs_reg:
-	ath11k_debug_soc_destroy(ab);
+	ath11k_debugfs_soc_destroy(ab);
 err_qmi_deinit:
 	ath11k_qmi_deinit_service(ab);
 	return ret;
@@ -435,7 +435,7 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 
 static void ath11k_core_soc_destroy(struct ath11k_base *ab)
 {
-	ath11k_debug_soc_destroy(ab);
+	ath11k_debugfs_soc_destroy(ab);
 	ath11k_dp_free(ab);
 	ath11k_reg_free(ab);
 	ath11k_qmi_deinit_service(ab);
@@ -445,7 +445,7 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 {
 	int ret;
 
-	ret = ath11k_debug_pdev_create(ab);
+	ret = ath11k_debugfs_pdev_create(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to create core pdev debugfs: %d\n", ret);
 		return ret;
@@ -485,7 +485,7 @@ static int ath11k_core_pdev_create(struct ath11k_base *ab)
 err_mac_unregister:
 	ath11k_mac_unregister(ab);
 err_pdev_debug:
-	ath11k_debug_pdev_destroy(ab);
+	ath11k_debugfs_pdev_destroy(ab);
 
 	return ret;
 }
@@ -497,7 +497,7 @@ static void ath11k_core_pdev_destroy(struct ath11k_base *ab)
 	ath11k_mac_unregister(ab);
 	ath11k_hif_irq_disable(ab);
 	ath11k_dp_pdev_free(ab);
-	ath11k_debug_pdev_destroy(ab);
+	ath11k_debugfs_pdev_destroy(ab);
 }
 
 static int ath11k_core_start(struct ath11k_base *ab,
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index b6d00bd6bbd7..7ac5f69cb6ad 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -80,7 +80,7 @@ static void ath11k_fw_stats_bcn_free(struct list_head *head)
 	}
 }
 
-static void ath11k_debug_fw_stats_reset(struct ath11k *ar)
+static void ath11k_debugfs_fw_stats_reset(struct ath11k *ar)
 {
 	spin_lock_bh(&ar->data_lock);
 	ar->debug.fw_stats_done = false;
@@ -89,7 +89,7 @@ static void ath11k_debug_fw_stats_reset(struct ath11k *ar)
 	spin_unlock_bh(&ar->data_lock);
 }
 
-void ath11k_debug_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb)
+void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct ath11k_fw_stats stats = {};
 	struct ath11k *ar;
@@ -181,8 +181,8 @@ void ath11k_debug_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb)
 	ath11k_fw_stats_bcn_free(&stats.bcn);
 }
 
-static int ath11k_debug_fw_stats_request(struct ath11k *ar,
-					 struct stats_request_params *req_param)
+static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
+					   struct stats_request_params *req_param)
 {
 	struct ath11k_base *ab = ar->ab;
 	unsigned long timeout, time_left;
@@ -197,7 +197,7 @@ static int ath11k_debug_fw_stats_request(struct ath11k *ar,
 	 */
 	timeout = jiffies + msecs_to_jiffies(3 * HZ);
 
-	ath11k_debug_fw_stats_reset(ar);
+	ath11k_debugfs_fw_stats_reset(ar);
 
 	reinit_completion(&ar->debug.fw_stats_complete);
 
@@ -254,7 +254,7 @@ static int ath11k_open_pdev_stats(struct inode *inode, struct file *file)
 	req_param.vdev_id = 0;
 	req_param.stats_id = WMI_REQUEST_PDEV_STAT;
 
-	ret = ath11k_debug_fw_stats_request(ar, &req_param);
+	ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
 	if (ret) {
 		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
 		goto err_free;
@@ -326,7 +326,7 @@ static int ath11k_open_vdev_stats(struct inode *inode, struct file *file)
 	req_param.vdev_id = 0;
 	req_param.stats_id = WMI_REQUEST_VDEV_STAT;
 
-	ret = ath11k_debug_fw_stats_request(ar, &req_param);
+	ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to request fw vdev stats: %d\n", ret);
 		goto err_free;
@@ -403,7 +403,7 @@ static int ath11k_open_bcn_stats(struct inode *inode, struct file *file)
 			continue;
 
 		req_param.vdev_id = arvif->vdev_id;
-		ret = ath11k_debug_fw_stats_request(ar, &req_param);
+		ret = ath11k_debugfs_fw_stats_request(ar, &req_param);
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to request fw bcn stats: %d\n", ret);
 			goto err_free;
@@ -705,8 +705,8 @@ static int ath11k_fill_bp_stats(struct ath11k_base *ab,
 	return len;
 }
 
-static ssize_t ath11k_debug_dump_soc_ring_bp_stats(struct ath11k_base *ab,
-						   char *buf, int size)
+static ssize_t ath11k_debugfs_dump_soc_ring_bp_stats(struct ath11k_base *ab,
+						     char *buf, int size)
 {
 	struct ath11k_bp_stats *bp_stats;
 	bool stats_rxd = false;
@@ -754,9 +754,9 @@ static ssize_t ath11k_debug_dump_soc_ring_bp_stats(struct ath11k_base *ab,
 	return len;
 }
 
-static ssize_t ath11k_debug_dump_soc_dp_stats(struct file *file,
-					      char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath11k_debugfs_dump_soc_dp_stats(struct file *file,
+						char __user *user_buf,
+						size_t count, loff_t *ppos)
 {
 	struct ath11k_base *ab = file->private_data;
 	struct ath11k_soc_dp_stats *soc_stats = &ab->soc_stats;
@@ -814,7 +814,7 @@ static ssize_t ath11k_debug_dump_soc_dp_stats(struct file *file,
 			 "\nMisc Transmit Failures: %d\n",
 			 atomic_read(&soc_stats->tx_err.misc_fail));
 
-	len += ath11k_debug_dump_soc_ring_bp_stats(ab, buf + len, size - len);
+	len += ath11k_debugfs_dump_soc_ring_bp_stats(ab, buf + len, size - len);
 
 	if (len > size)
 		len = size;
@@ -825,13 +825,13 @@ static ssize_t ath11k_debug_dump_soc_dp_stats(struct file *file,
 }
 
 static const struct file_operations fops_soc_dp_stats = {
-	.read = ath11k_debug_dump_soc_dp_stats,
+	.read = ath11k_debugfs_dump_soc_dp_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-int ath11k_debug_pdev_create(struct ath11k_base *ab)
+int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
 {
 	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
 		return 0;
@@ -853,13 +853,13 @@ int ath11k_debug_pdev_create(struct ath11k_base *ab)
 	return 0;
 }
 
-void ath11k_debug_pdev_destroy(struct ath11k_base *ab)
+void ath11k_debugfs_pdev_destroy(struct ath11k_base *ab)
 {
 	debugfs_remove_recursive(ab->debugfs_ath11k);
 	ab->debugfs_ath11k = NULL;
 }
 
-int ath11k_debug_soc_create(struct ath11k_base *ab)
+int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 {
 	ab->debugfs_ath11k = debugfs_create_dir("ath11k", NULL);
 
@@ -872,13 +872,13 @@ int ath11k_debug_soc_create(struct ath11k_base *ab)
 	return 0;
 }
 
-void ath11k_debug_soc_destroy(struct ath11k_base *ab)
+void ath11k_debugfs_soc_destroy(struct ath11k_base *ab)
 {
 	debugfs_remove_recursive(ab->debugfs_soc);
 	ab->debugfs_soc = NULL;
 }
 
-void ath11k_debug_fw_stats_init(struct ath11k *ar)
+void ath11k_debugfs_fw_stats_init(struct ath11k *ar)
 {
 	struct dentry *fwstats_dir = debugfs_create_dir("fw_stats",
 							ar->debug.debugfs_pdev);
@@ -1060,7 +1060,7 @@ static const struct file_operations fops_simulate_radar = {
 	.open = simple_open
 };
 
-int ath11k_debug_register(struct ath11k *ar)
+int ath11k_debugfs_register(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
 	char pdev_name[5];
@@ -1083,7 +1083,7 @@ int ath11k_debug_register(struct ath11k *ar)
 
 	ath11k_debug_htt_stats_init(ar);
 
-	ath11k_debug_fw_stats_init(ar);
+	ath11k_debugfs_fw_stats_init(ar);
 
 	debugfs_create_file("ext_tx_stats", 0644,
 			    ar->debug.debugfs_pdev, ar,
@@ -1107,6 +1107,6 @@ int ath11k_debug_register(struct ath11k *ar)
 	return 0;
 }
 
-void ath11k_debug_unregister(struct ath11k *ar)
+void ath11k_debugfs_unregister(struct ath11k *ar)
 {
 }
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index ab21d9003938..4b7867c5f26f 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -104,46 +104,46 @@ enum ath11k_dbg_aggr_mode {
 };
 
 #ifdef CONFIG_ATH11K_DEBUGFS
-int ath11k_debug_soc_create(struct ath11k_base *ab);
-void ath11k_debug_soc_destroy(struct ath11k_base *ab);
-int ath11k_debug_pdev_create(struct ath11k_base *ab);
-void ath11k_debug_pdev_destroy(struct ath11k_base *ab);
-int ath11k_debug_register(struct ath11k *ar);
-void ath11k_debug_unregister(struct ath11k *ar);
+int ath11k_debugfs_soc_create(struct ath11k_base *ab);
+void ath11k_debugfs_soc_destroy(struct ath11k_base *ab);
+int ath11k_debugfs_pdev_create(struct ath11k_base *ab);
+void ath11k_debugfs_pdev_destroy(struct ath11k_base *ab);
+int ath11k_debugfs_register(struct ath11k *ar);
+void ath11k_debugfs_unregister(struct ath11k *ar);
 void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
 				      struct sk_buff *skb);
-void ath11k_debug_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb);
+void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb);
 
-void ath11k_debug_fw_stats_init(struct ath11k *ar);
+void ath11k_debugfs_fw_stats_init(struct ath11k *ar);
 int ath11k_dbg_htt_stats_req(struct ath11k *ar);
 
-static inline bool ath11k_debug_is_pktlog_lite_mode_enabled(struct ath11k *ar)
+static inline bool ath11k_debugfs_is_pktlog_lite_mode_enabled(struct ath11k *ar)
 {
 	return (ar->debug.pktlog_mode == ATH11K_PKTLOG_MODE_LITE);
 }
 
-static inline bool ath11k_debug_is_pktlog_rx_stats_enabled(struct ath11k *ar)
+static inline bool ath11k_debugfs_is_pktlog_rx_stats_enabled(struct ath11k *ar)
 {
 	return (!ar->debug.pktlog_peer_valid && ar->debug.pktlog_mode);
 }
 
-static inline bool ath11k_debug_is_pktlog_peer_valid(struct ath11k *ar, u8 *addr)
+static inline bool ath11k_debugfs_is_pktlog_peer_valid(struct ath11k *ar, u8 *addr)
 {
 	return (ar->debug.pktlog_peer_valid && ar->debug.pktlog_mode &&
 		ether_addr_equal(addr, ar->debug.pktlog_peer_addr));
 }
 
-static inline int ath11k_debug_is_extd_tx_stats_enabled(struct ath11k *ar)
+static inline int ath11k_debugfs_is_extd_tx_stats_enabled(struct ath11k *ar)
 {
 	return ar->debug.extd_tx_stats;
 }
 
-static inline int ath11k_debug_is_extd_rx_stats_enabled(struct ath11k *ar)
+static inline int ath11k_debugfs_is_extd_rx_stats_enabled(struct ath11k *ar)
 {
 	return ar->debug.extd_rx_stats;
 }
 
-static inline int ath11k_debug_rx_filter(struct ath11k *ar)
+static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 {
 	return ar->debug.rx_filter;
 }
@@ -158,30 +158,30 @@ void ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
 					       struct sk_buff *msdu,
 					       struct hal_tx_status *ts);
 #else
-static inline int ath11k_debug_soc_create(struct ath11k_base *ab)
+static inline int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 {
 	return 0;
 }
 
-static inline void ath11k_debug_soc_destroy(struct ath11k_base *ab)
+static inline void ath11k_debugfs_soc_destroy(struct ath11k_base *ab)
 {
 }
 
-static inline int ath11k_debug_pdev_create(struct ath11k_base *ab)
+static inline int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
 {
 	return 0;
 }
 
-static inline void ath11k_debug_pdev_destroy(struct ath11k_base *ab)
+static inline void ath11k_debugfs_pdev_destroy(struct ath11k_base *ab)
 {
 }
 
-static inline int ath11k_debug_register(struct ath11k *ar)
+static inline int ath11k_debugfs_register(struct ath11k *ar)
 {
 	return 0;
 }
 
-static inline void ath11k_debug_unregister(struct ath11k *ar)
+static inline void ath11k_debugfs_unregister(struct ath11k *ar)
 {
 }
 
@@ -190,21 +190,21 @@ static inline void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
 {
 }
 
-static inline void ath11k_debug_fw_stats_process(struct ath11k_base *ab,
-						 struct sk_buff *skb)
+static inline void ath11k_debugfs_fw_stats_process(struct ath11k_base *ab,
+						   struct sk_buff *skb)
 {
 }
 
-static inline void ath11k_debug_fw_stats_init(struct ath11k *ar)
+static inline void ath11k_debugfs_fw_stats_init(struct ath11k *ar)
 {
 }
 
-static inline int ath11k_debug_is_extd_tx_stats_enabled(struct ath11k *ar)
+static inline int ath11k_debugfs_is_extd_tx_stats_enabled(struct ath11k *ar)
 {
 	return 0;
 }
 
-static inline int ath11k_debug_is_extd_rx_stats_enabled(struct ath11k *ar)
+static inline int ath11k_debugfs_is_extd_rx_stats_enabled(struct ath11k *ar)
 {
 	return 0;
 }
@@ -214,22 +214,22 @@ static inline int ath11k_dbg_htt_stats_req(struct ath11k *ar)
 	return 0;
 }
 
-static inline bool ath11k_debug_is_pktlog_lite_mode_enabled(struct ath11k *ar)
+static inline bool ath11k_debugfs_is_pktlog_lite_mode_enabled(struct ath11k *ar)
 {
 	return false;
 }
 
-static inline bool ath11k_debug_is_pktlog_rx_stats_enabled(struct ath11k *ar)
+static inline bool ath11k_debugfs_is_pktlog_rx_stats_enabled(struct ath11k *ar)
 {
 	return false;
 }
 
-static inline bool ath11k_debug_is_pktlog_peer_valid(struct ath11k *ar, u8 *addr)
+static inline bool ath11k_debugfs_is_pktlog_peer_valid(struct ath11k *ar, u8 *addr)
 {
 	return false;
 }
 
-static inline int ath11k_debug_rx_filter(struct ath11k *ar)
+static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 {
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 7308ed254232..d189cc80805a 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -825,10 +825,10 @@ void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct ath11k *ar = hw->priv;
 
-	if (ath11k_debug_is_extd_tx_stats_enabled(ar))
+	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar))
 		debugfs_create_file("tx_stats", 0400, dir, sta,
 				    &fops_tx_stats);
-	if (ath11k_debug_is_extd_rx_stats_enabled(ar))
+	if (ath11k_debugfs_is_extd_rx_stats_enabled(ar))
 		debugfs_create_file("rx_stats", 0400, dir, sta,
 				    &fops_rx_stats);
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 2617ec221775..677e2d9fec11 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -832,7 +832,7 @@ void ath11k_dp_pdev_free(struct ath11k_base *ab)
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
 		ath11k_dp_rx_pdev_free(ab, i);
-		ath11k_debug_unregister(ar);
+		ath11k_debugfs_unregister(ar);
 		ath11k_dp_rx_pdev_mon_detach(ar);
 	}
 }
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index a507c1231a59..2c9251bde78b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1433,7 +1433,7 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 			HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
 			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
 
-		if (ath11k_debug_is_extd_tx_stats_enabled(ar))
+		if (ath11k_debugfs_is_extd_tx_stats_enabled(ar))
 			ath11k_accumulate_per_peer_tx_stats(arsta,
 							    peer_stats, rate_idx);
 	}
@@ -1511,7 +1511,7 @@ static int ath11k_htt_pull_ppdu_stats(struct ath11k_base *ab,
 		goto exit;
 	}
 
-	if (ath11k_debug_is_pktlog_lite_mode_enabled(ar))
+	if (ath11k_debugfs_is_pktlog_lite_mode_enabled(ar))
 		trace_ath11k_htt_ppdu_stats(ar, skb->data, len);
 
 	ppdu_info = ath11k_dp_htt_get_ppdu_desc(ar, ppdu_id);
@@ -2909,7 +2909,7 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		memset(&ppdu_info, 0, sizeof(ppdu_info));
 		ppdu_info.peer_id = HAL_INVALID_PEERID;
 
-		if (ath11k_debug_is_pktlog_rx_stats_enabled(ar))
+		if (ath11k_debugfs_is_pktlog_rx_stats_enabled(ar))
 			trace_ath11k_htt_rxdesc(ar, skb->data, DP_RX_BUFFER_SIZE);
 
 		hal_status = ath11k_hal_rx_parse_mon_status(ab, &ppdu_info, skb);
@@ -2937,7 +2937,7 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		arsta = (struct ath11k_sta *)peer->sta->drv_priv;
 		ath11k_dp_rx_update_peer_stats(arsta, &ppdu_info);
 
-		if (ath11k_debug_is_pktlog_peer_valid(ar, peer->addr))
+		if (ath11k_debugfs_is_pktlog_peer_valid(ar, peer->addr))
 			trace_ath11k_htt_rxdesc(ar, skb->data, DP_RX_BUFFER_SIZE);
 
 		spin_unlock_bh(&ab->base_lock);
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 6565d9808042..7975cc036ba4 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -457,7 +457,7 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 	    (info->flags & IEEE80211_TX_CTL_NO_ACK))
 		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
 
-	if (ath11k_debug_is_extd_tx_stats_enabled(ar)) {
+	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar)) {
 		if (ts->flags & HAL_TX_STATUS_FLAGS_FIRST_MSDU) {
 			if (ar->last_ppdu_id == 0) {
 				ar->last_ppdu_id = ts->ppdu_id;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c1217e3b3b98..69621160cb62 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2967,7 +2967,7 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 	ath11k_dbg(ab, ATH11K_DBG_MAC, "Added peer: %pM for VDEV: %d\n",
 		   sta->addr, arvif->vdev_id);
 
-	if (ath11k_debug_is_extd_tx_stats_enabled(ar)) {
+	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar)) {
 		arsta->tx_stats = kzalloc(sizeof(*arsta->tx_stats), GFP_KERNEL);
 		if (!arsta->tx_stats) {
 			ret = -ENOMEM;
@@ -4101,7 +4101,7 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 
 	if (enable) {
 		tlv_filter = ath11k_mac_mon_status_filter_default;
-		tlv_filter.rx_filter = ath11k_debug_rx_filter(ar);
+		tlv_filter.rx_filter = ath11k_debugfs_rx_filter(ar);
 	}
 
 	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
@@ -6226,7 +6226,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 		goto err_free;
 	}
 
-	ret = ath11k_debug_register(ar);
+	ret = ath11k_debugfs_register(ar);
 	if (ret) {
 		ath11k_err(ar->ab, "debugfs registration failed: %d\n", ret);
 		goto err_free;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index adde14a390ec..078f88371ff1 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6301,7 +6301,7 @@ static void ath11k_peer_assoc_conf_event(struct ath11k_base *ab, struct sk_buff
 
 static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
-	ath11k_debug_fw_stats_process(ab, skb);
+	ath11k_debugfs_fw_stats_process(ab, skb);
 }
 
 /* PDEV_CTL_FAILSAFE_CHECK_EVENT is received from FW when the frequency scanned
-- 
2.7.4

