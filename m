Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63E526CE18
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 23:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgIPVJc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 17:09:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25630 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgIPPzs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 11:55:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600271731; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=73Fn94OQaY3cgNIXHiDjj9hn6feM8LNZAQPPTbDwk9M=; b=eDCV35Hzsowm2KP5dmXPDBTWeS2TkwOVRdXsCQaWqXfMGsCiEhoLLoxTGPzlEa/ByOXCQlVQ
 KxMCq3WYUuU374Bm+G76F2YTcu+a263mc5EnCRJ+GuMEedQV1+3lSAjnH5Y+WIsdlNlb9V6R
 1+e8850P1Aw49mKzW0zxEBewAH0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f62195573afa3417ef306bd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 13:55:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D768C433F0; Wed, 16 Sep 2020 13:55:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D4B2C433C8;
        Wed, 16 Sep 2020 13:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D4B2C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] ath11k: refactor debugfs code into debugfs.c
Date:   Wed, 16 Sep 2020 16:55:20 +0300
Message-Id: <1600264523-12939-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If CONFIG_ATH11K_DEBUGFS is disabled there are warnings debug.c:

drivers/net/wireless/ath/ath11k/debug.c:36:20: warning: 'htt_bp_lmac_ring' defined but not used [-Wunused-variable]
   36 | static const char *htt_bp_lmac_ring[HTT_SW_LMAC_RING_IDX_MAX] = {
      |                    ^~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath11k/debug.c:15:20: warning: 'htt_bp_umac_ring' defined but not used [-Wunused-variable]
   15 | static const char *htt_bp_umac_ring[HTT_SW_UMAC_RING_IDX_MAX] = {
      |                    ^~~~~~~~~~~~~~~~

Fix this by refactoring debugfs code to debugfs.c. This also reduces the number
of ifdefs in debug.c and makes it easier to maintain the code.

No functional changes. Compile tested only.

Reported-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Makefile  |    2 +-
 drivers/net/wireless/ath/ath11k/debug.c   | 1108 +---------------------------
 drivers/net/wireless/ath/ath11k/debug.h   |  244 +------
 drivers/net/wireless/ath/ath11k/debugfs.c | 1112 +++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/debugfs.h |  253 +++++++
 5 files changed, 1369 insertions(+), 1350 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/debugfs.c
 create mode 100644 drivers/net/wireless/ath/ath11k/debugfs.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index bc4911f0339d..bb57d0e2dd9f 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -18,7 +18,7 @@ ath11k-y += core.o \
 	    dbring.o \
 	    hw.o
 
-ath11k-$(CONFIG_ATH11K_DEBUGFS) += debug_htt_stats.o debugfs_sta.o
+ath11k-$(CONFIG_ATH11K_DEBUGFS) += debugfs.o debug_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
 ath11k-$(CONFIG_ATH11K_TRACING) += trace.o
 ath11k-$(CONFIG_THERMAL) += thermal.o
diff --git a/drivers/net/wireless/ath/ath11k/debug.c b/drivers/net/wireless/ath/ath11k/debug.c
index 0ba234ad99b2..c86de95fbdc5 100644
--- a/drivers/net/wireless/ath/ath11k/debug.c
+++ b/drivers/net/wireless/ath/ath11k/debug.c
@@ -6,48 +6,6 @@
 #include <linux/vmalloc.h>
 #include "core.h"
 #include "debug.h"
-#include "wmi.h"
-#include "hal_rx.h"
-#include "dp_tx.h"
-#include "debug_htt_stats.h"
-#include "peer.h"
-
-static const char *htt_bp_umac_ring[HTT_SW_UMAC_RING_IDX_MAX] = {
-	"REO2SW1_RING",
-	"REO2SW2_RING",
-	"REO2SW3_RING",
-	"REO2SW4_RING",
-	"WBM2REO_LINK_RING",
-	"REO2TCL_RING",
-	"REO2FW_RING",
-	"RELEASE_RING",
-	"PPE_RELEASE_RING",
-	"TCL2TQM_RING",
-	"TQM_RELEASE_RING",
-	"REO_RELEASE_RING",
-	"WBM2SW0_RELEASE_RING",
-	"WBM2SW1_RELEASE_RING",
-	"WBM2SW2_RELEASE_RING",
-	"WBM2SW3_RELEASE_RING",
-	"REO_CMD_RING",
-	"REO_STATUS_RING",
-};
-
-static const char *htt_bp_lmac_ring[HTT_SW_LMAC_RING_IDX_MAX] = {
-	"FW2RXDMA_BUF_RING",
-	"FW2RXDMA_STATUS_RING",
-	"FW2RXDMA_LINK_RING",
-	"SW2RXDMA_BUF_RING",
-	"WBM2RXDMA_LINK_RING",
-	"RXDMA2FW_RING",
-	"RXDMA2SW_RING",
-	"RXDMA2RELEASE_RING",
-	"RXDMA2REO_RING",
-	"MONITOR_STATUS_RING",
-	"MONITOR_BUF_RING",
-	"MONITOR_DESC_RING",
-	"MONITOR_DEST_RING",
-};
 
 void ath11k_info(struct ath11k_base *ab, const char *fmt, ...)
 {
@@ -95,6 +53,7 @@ void ath11k_warn(struct ath11k_base *ab, const char *fmt, ...)
 EXPORT_SYMBOL(ath11k_warn);
 
 #ifdef CONFIG_ATH11K_DEBUG
+
 void __ath11k_dbg(struct ath11k_base *ab, enum ath11k_debug_mask mask,
 		  const char *fmt, ...)
 {
@@ -144,1067 +103,4 @@ void ath11k_dbg_dump(struct ath11k_base *ab,
 }
 EXPORT_SYMBOL(ath11k_dbg_dump);
 
-#endif
-
-#ifdef CONFIG_ATH11K_DEBUGFS
-static void ath11k_fw_stats_pdevs_free(struct list_head *head)
-{
-	struct ath11k_fw_stats_pdev *i, *tmp;
-
-	list_for_each_entry_safe(i, tmp, head, list) {
-		list_del(&i->list);
-		kfree(i);
-	}
-}
-
-static void ath11k_fw_stats_vdevs_free(struct list_head *head)
-{
-	struct ath11k_fw_stats_vdev *i, *tmp;
-
-	list_for_each_entry_safe(i, tmp, head, list) {
-		list_del(&i->list);
-		kfree(i);
-	}
-}
-
-static void ath11k_fw_stats_bcn_free(struct list_head *head)
-{
-	struct ath11k_fw_stats_bcn *i, *tmp;
-
-	list_for_each_entry_safe(i, tmp, head, list) {
-		list_del(&i->list);
-		kfree(i);
-	}
-}
-
-static void ath11k_debug_fw_stats_reset(struct ath11k *ar)
-{
-	spin_lock_bh(&ar->data_lock);
-	ar->debug.fw_stats_done = false;
-	ath11k_fw_stats_pdevs_free(&ar->debug.fw_stats.pdevs);
-	ath11k_fw_stats_vdevs_free(&ar->debug.fw_stats.vdevs);
-	spin_unlock_bh(&ar->data_lock);
-}
-
-void ath11k_debug_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb)
-{
-	struct ath11k_fw_stats stats = {};
-	struct ath11k *ar;
-	struct ath11k_pdev *pdev;
-	bool is_end;
-	static unsigned int num_vdev, num_bcn;
-	size_t total_vdevs_started = 0;
-	int i, ret;
-
-	INIT_LIST_HEAD(&stats.pdevs);
-	INIT_LIST_HEAD(&stats.vdevs);
-	INIT_LIST_HEAD(&stats.bcn);
-
-	ret = ath11k_wmi_pull_fw_stats(ab, skb, &stats);
-	if (ret) {
-		ath11k_warn(ab, "failed to pull fw stats: %d\n", ret);
-		goto free;
-	}
-
-	rcu_read_lock();
-	ar = ath11k_mac_get_ar_by_pdev_id(ab, stats.pdev_id);
-	if (!ar) {
-		rcu_read_unlock();
-		ath11k_warn(ab, "failed to get ar for pdev_id %d: %d\n",
-			    stats.pdev_id, ret);
-		goto free;
-	}
-
-	spin_lock_bh(&ar->data_lock);
-
-	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
-		list_splice_tail_init(&stats.pdevs, &ar->debug.fw_stats.pdevs);
-		ar->debug.fw_stats_done = true;
-		goto complete;
-	}
-
-	if (stats.stats_id == WMI_REQUEST_VDEV_STAT) {
-		if (list_empty(&stats.vdevs)) {
-			ath11k_warn(ab, "empty vdev stats");
-			goto complete;
-		}
-		/* FW sends all the active VDEV stats irrespective of PDEV,
-		 * hence limit until the count of all VDEVs started
-		 */
-		for (i = 0; i < ab->num_radios; i++) {
-			pdev = rcu_dereference(ab->pdevs_active[i]);
-			if (pdev && pdev->ar)
-				total_vdevs_started += ar->num_started_vdevs;
-		}
-
-		is_end = ((++num_vdev) == total_vdevs_started);
-
-		list_splice_tail_init(&stats.vdevs,
-				      &ar->debug.fw_stats.vdevs);
-
-		if (is_end) {
-			ar->debug.fw_stats_done = true;
-			num_vdev = 0;
-		}
-		goto complete;
-	}
-
-	if (stats.stats_id == WMI_REQUEST_BCN_STAT) {
-		if (list_empty(&stats.bcn)) {
-			ath11k_warn(ab, "empty bcn stats");
-			goto complete;
-		}
-		/* Mark end until we reached the count of all started VDEVs
-		 * within the PDEV
-		 */
-		is_end = ((++num_bcn) == ar->num_started_vdevs);
-
-		list_splice_tail_init(&stats.bcn,
-				      &ar->debug.fw_stats.bcn);
-
-		if (is_end) {
-			ar->debug.fw_stats_done = true;
-			num_bcn = 0;
-		}
-	}
-complete:
-	complete(&ar->debug.fw_stats_complete);
-	rcu_read_unlock();
-	spin_unlock_bh(&ar->data_lock);
-
-free:
-	ath11k_fw_stats_pdevs_free(&stats.pdevs);
-	ath11k_fw_stats_vdevs_free(&stats.vdevs);
-	ath11k_fw_stats_bcn_free(&stats.bcn);
-}
-
-static int ath11k_debug_fw_stats_request(struct ath11k *ar,
-					 struct stats_request_params *req_param)
-{
-	struct ath11k_base *ab = ar->ab;
-	unsigned long timeout, time_left;
-	int ret;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	/* FW stats can get split when exceeding the stats data buffer limit.
-	 * In that case, since there is no end marking for the back-to-back
-	 * received 'update stats' event, we keep a 3 seconds timeout in case,
-	 * fw_stats_done is not marked yet
-	 */
-	timeout = jiffies + msecs_to_jiffies(3 * HZ);
-
-	ath11k_debug_fw_stats_reset(ar);
-
-	reinit_completion(&ar->debug.fw_stats_complete);
-
-	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
-
-	if (ret) {
-		ath11k_warn(ab, "could not request fw stats (%d)\n",
-			    ret);
-		return ret;
-	}
-
-	time_left =
-	wait_for_completion_timeout(&ar->debug.fw_stats_complete,
-				    1 * HZ);
-	if (!time_left)
-		return -ETIMEDOUT;
-
-	for (;;) {
-		if (time_after(jiffies, timeout))
-			break;
-
-		spin_lock_bh(&ar->data_lock);
-		if (ar->debug.fw_stats_done) {
-			spin_unlock_bh(&ar->data_lock);
-			break;
-		}
-		spin_unlock_bh(&ar->data_lock);
-	}
-	return 0;
-}
-
-static int ath11k_open_pdev_stats(struct inode *inode, struct file *file)
-{
-	struct ath11k *ar = inode->i_private;
-	struct ath11k_base *ab = ar->ab;
-	struct stats_request_params req_param;
-	void *buf = NULL;
-	int ret;
-
-	mutex_lock(&ar->conf_mutex);
-
-	if (ar->state != ATH11K_STATE_ON) {
-		ret = -ENETDOWN;
-		goto err_unlock;
-	}
-
-	buf = vmalloc(ATH11K_FW_STATS_BUF_SIZE);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto err_unlock;
-	}
-
-	req_param.pdev_id = ar->pdev->pdev_id;
-	req_param.vdev_id = 0;
-	req_param.stats_id = WMI_REQUEST_PDEV_STAT;
-
-	ret = ath11k_debug_fw_stats_request(ar, &req_param);
-	if (ret) {
-		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
-		goto err_free;
-	}
-
-	ath11k_wmi_fw_stats_fill(ar, &ar->debug.fw_stats, req_param.stats_id,
-				 buf);
-
-	file->private_data = buf;
-
-	mutex_unlock(&ar->conf_mutex);
-	return 0;
-
-err_free:
-	vfree(buf);
-
-err_unlock:
-	mutex_unlock(&ar->conf_mutex);
-	return ret;
-}
-
-static int ath11k_release_pdev_stats(struct inode *inode, struct file *file)
-{
-	vfree(file->private_data);
-
-	return 0;
-}
-
-static ssize_t ath11k_read_pdev_stats(struct file *file,
-				      char __user *user_buf,
-				      size_t count, loff_t *ppos)
-{
-	const char *buf = file->private_data;
-	size_t len = strlen(buf);
-
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
-}
-
-static const struct file_operations fops_pdev_stats = {
-	.open = ath11k_open_pdev_stats,
-	.release = ath11k_release_pdev_stats,
-	.read = ath11k_read_pdev_stats,
-	.owner = THIS_MODULE,
-	.llseek = default_llseek,
-};
-
-static int ath11k_open_vdev_stats(struct inode *inode, struct file *file)
-{
-	struct ath11k *ar = inode->i_private;
-	struct stats_request_params req_param;
-	void *buf = NULL;
-	int ret;
-
-	mutex_lock(&ar->conf_mutex);
-
-	if (ar->state != ATH11K_STATE_ON) {
-		ret = -ENETDOWN;
-		goto err_unlock;
-	}
-
-	buf = vmalloc(ATH11K_FW_STATS_BUF_SIZE);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto err_unlock;
-	}
-
-	req_param.pdev_id = ar->pdev->pdev_id;
-	/* VDEV stats is always sent for all active VDEVs from FW */
-	req_param.vdev_id = 0;
-	req_param.stats_id = WMI_REQUEST_VDEV_STAT;
-
-	ret = ath11k_debug_fw_stats_request(ar, &req_param);
-	if (ret) {
-		ath11k_warn(ar->ab, "failed to request fw vdev stats: %d\n", ret);
-		goto err_free;
-	}
-
-	ath11k_wmi_fw_stats_fill(ar, &ar->debug.fw_stats, req_param.stats_id,
-				 buf);
-
-	file->private_data = buf;
-
-	mutex_unlock(&ar->conf_mutex);
-	return 0;
-
-err_free:
-	vfree(buf);
-
-err_unlock:
-	mutex_unlock(&ar->conf_mutex);
-	return ret;
-}
-
-static int ath11k_release_vdev_stats(struct inode *inode, struct file *file)
-{
-	vfree(file->private_data);
-
-	return 0;
-}
-
-static ssize_t ath11k_read_vdev_stats(struct file *file,
-				      char __user *user_buf,
-				      size_t count, loff_t *ppos)
-{
-	const char *buf = file->private_data;
-	size_t len = strlen(buf);
-
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
-}
-
-static const struct file_operations fops_vdev_stats = {
-	.open = ath11k_open_vdev_stats,
-	.release = ath11k_release_vdev_stats,
-	.read = ath11k_read_vdev_stats,
-	.owner = THIS_MODULE,
-	.llseek = default_llseek,
-};
-
-static int ath11k_open_bcn_stats(struct inode *inode, struct file *file)
-{
-	struct ath11k *ar = inode->i_private;
-	struct ath11k_vif *arvif;
-	struct stats_request_params req_param;
-	void *buf = NULL;
-	int ret;
-
-	mutex_lock(&ar->conf_mutex);
-
-	if (ar->state != ATH11K_STATE_ON) {
-		ret = -ENETDOWN;
-		goto err_unlock;
-	}
-
-	buf = vmalloc(ATH11K_FW_STATS_BUF_SIZE);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto err_unlock;
-	}
-
-	req_param.stats_id = WMI_REQUEST_BCN_STAT;
-	req_param.pdev_id = ar->pdev->pdev_id;
-
-	/* loop all active VDEVs for bcn stats */
-	list_for_each_entry(arvif, &ar->arvifs, list) {
-		if (!arvif->is_up)
-			continue;
-
-		req_param.vdev_id = arvif->vdev_id;
-		ret = ath11k_debug_fw_stats_request(ar, &req_param);
-		if (ret) {
-			ath11k_warn(ar->ab, "failed to request fw bcn stats: %d\n", ret);
-			goto err_free;
-		}
-	}
-
-	ath11k_wmi_fw_stats_fill(ar, &ar->debug.fw_stats, req_param.stats_id,
-				 buf);
-
-	/* since beacon stats request is looped for all active VDEVs, saved fw
-	 * stats is not freed for each request until done for all active VDEVs
-	 */
-	spin_lock_bh(&ar->data_lock);
-	ath11k_fw_stats_bcn_free(&ar->debug.fw_stats.bcn);
-	spin_unlock_bh(&ar->data_lock);
-
-	file->private_data = buf;
-
-	mutex_unlock(&ar->conf_mutex);
-	return 0;
-
-err_free:
-	vfree(buf);
-
-err_unlock:
-	mutex_unlock(&ar->conf_mutex);
-	return ret;
-}
-
-static int ath11k_release_bcn_stats(struct inode *inode, struct file *file)
-{
-	vfree(file->private_data);
-
-	return 0;
-}
-
-static ssize_t ath11k_read_bcn_stats(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
-{
-	const char *buf = file->private_data;
-	size_t len = strlen(buf);
-
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
-}
-
-static const struct file_operations fops_bcn_stats = {
-	.open = ath11k_open_bcn_stats,
-	.release = ath11k_release_bcn_stats,
-	.read = ath11k_read_bcn_stats,
-	.owner = THIS_MODULE,
-	.llseek = default_llseek,
-};
-
-static ssize_t ath11k_read_simulate_fw_crash(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
-{
-	const char buf[] =
-		"To simulate firmware crash write one of the keywords to this file:\n"
-		"`assert` - this will send WMI_FORCE_FW_HANG_CMDID to firmware to cause assert.\n"
-		"`hw-restart` - this will simply queue hw restart without fw/hw actually crashing.\n";
-
-	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
-}
-
-/* Simulate firmware crash:
- * 'soft': Call wmi command causing firmware hang. This firmware hang is
- * recoverable by warm firmware reset.
- * 'hard': Force firmware crash by setting any vdev parameter for not allowed
- * vdev id. This is hard firmware crash because it is recoverable only by cold
- * firmware reset.
- */
-static ssize_t ath11k_write_simulate_fw_crash(struct file *file,
-					      const char __user *user_buf,
-					      size_t count, loff_t *ppos)
-{
-	struct ath11k_base *ab = file->private_data;
-	struct ath11k_pdev *pdev;
-	struct ath11k *ar = ab->pdevs[0].ar;
-	char buf[32] = {0};
-	ssize_t rc;
-	int i, ret, radioup = 0;
-
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = &ab->pdevs[i];
-		ar = pdev->ar;
-		if (ar && ar->state == ATH11K_STATE_ON) {
-			radioup = 1;
-			break;
-		}
-	}
-	/* filter partial writes and invalid commands */
-	if (*ppos != 0 || count >= sizeof(buf) || count == 0)
-		return -EINVAL;
-
-	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
-	if (rc < 0)
-		return rc;
-
-	/* drop the possible '\n' from the end */
-	if (buf[*ppos - 1] == '\n')
-		buf[*ppos - 1] = '\0';
-
-	if (radioup == 0) {
-		ret = -ENETDOWN;
-		goto exit;
-	}
-
-	if (!strcmp(buf, "assert")) {
-		ath11k_info(ab, "simulating firmware assert crash\n");
-		ret = ath11k_wmi_force_fw_hang_cmd(ar,
-						   ATH11K_WMI_FW_HANG_ASSERT_TYPE,
-						   ATH11K_WMI_FW_HANG_DELAY);
-	} else {
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	if (ret) {
-		ath11k_warn(ab, "failed to simulate firmware crash: %d\n", ret);
-		goto exit;
-	}
-
-	ret = count;
-
-exit:
-	return ret;
-}
-
-static const struct file_operations fops_simulate_fw_crash = {
-	.read = ath11k_read_simulate_fw_crash,
-	.write = ath11k_write_simulate_fw_crash,
-	.open = simple_open,
-	.owner = THIS_MODULE,
-	.llseek = default_llseek,
-};
-
-static ssize_t ath11k_write_enable_extd_tx_stats(struct file *file,
-						 const char __user *ubuf,
-						 size_t count, loff_t *ppos)
-{
-	struct ath11k *ar = file->private_data;
-	u32 filter;
-	int ret;
-
-	if (kstrtouint_from_user(ubuf, count, 0, &filter))
-		return -EINVAL;
-
-	mutex_lock(&ar->conf_mutex);
-
-	if (ar->state != ATH11K_STATE_ON) {
-		ret = -ENETDOWN;
-		goto out;
-	}
-
-	if (filter == ar->debug.extd_tx_stats) {
-		ret = count;
-		goto out;
-	}
-
-	ar->debug.extd_tx_stats = filter;
-	ret = count;
-
-out:
-	mutex_unlock(&ar->conf_mutex);
-	return ret;
-}
-
-static ssize_t ath11k_read_enable_extd_tx_stats(struct file *file,
-						char __user *ubuf,
-						size_t count, loff_t *ppos)
-
-{
-	char buf[32] = {0};
-	struct ath11k *ar = file->private_data;
-	int len = 0;
-
-	mutex_lock(&ar->conf_mutex);
-	len = scnprintf(buf, sizeof(buf) - len, "%08x\n",
-			ar->debug.extd_tx_stats);
-	mutex_unlock(&ar->conf_mutex);
-
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
-}
-
-static const struct file_operations fops_extd_tx_stats = {
-	.read = ath11k_read_enable_extd_tx_stats,
-	.write = ath11k_write_enable_extd_tx_stats,
-	.open = simple_open
-};
-
-static ssize_t ath11k_write_extd_rx_stats(struct file *file,
-					  const char __user *ubuf,
-					  size_t count, loff_t *ppos)
-{
-	struct ath11k *ar = file->private_data;
-	struct ath11k_base *ab = ar->ab;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
-	u32 enable, rx_filter = 0, ring_id;
-	int i;
-	int ret;
-
-	if (kstrtouint_from_user(ubuf, count, 0, &enable))
-		return -EINVAL;
-
-	mutex_lock(&ar->conf_mutex);
-
-	if (ar->state != ATH11K_STATE_ON) {
-		ret = -ENETDOWN;
-		goto exit;
-	}
-
-	if (enable > 1) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	if (enable == ar->debug.extd_rx_stats) {
-		ret = count;
-		goto exit;
-	}
-
-	if (enable) {
-		rx_filter =  HTT_RX_FILTER_TLV_FLAGS_MPDU_START;
-		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_START;
-		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END;
-		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS;
-		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT;
-		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE;
-
-		tlv_filter.rx_filter = rx_filter;
-		tlv_filter.pkt_filter_flags0 = HTT_RX_FP_MGMT_FILTER_FLAGS0;
-		tlv_filter.pkt_filter_flags1 = HTT_RX_FP_MGMT_FILTER_FLAGS1;
-		tlv_filter.pkt_filter_flags2 = HTT_RX_FP_CTRL_FILTER_FLASG2;
-		tlv_filter.pkt_filter_flags3 = HTT_RX_FP_CTRL_FILTER_FLASG3 |
-			HTT_RX_FP_DATA_FILTER_FLASG3;
-	} else {
-		tlv_filter = ath11k_mac_mon_status_filter_default;
-	}
-
-	ar->debug.rx_filter = tlv_filter.rx_filter;
-
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
-		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
-		ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, ar->dp.mac_id,
-						       HAL_RXDMA_MONITOR_STATUS,
-						       DP_RX_BUFFER_SIZE, &tlv_filter);
-
-		if (ret) {
-			ath11k_warn(ar->ab, "failed to set rx filter for monitor status ring\n");
-			goto exit;
-		}
-	}
-
-	ar->debug.extd_rx_stats = enable;
-	ret = count;
-exit:
-	mutex_unlock(&ar->conf_mutex);
-	return ret;
-}
-
-static ssize_t ath11k_read_extd_rx_stats(struct file *file,
-					 char __user *ubuf,
-					 size_t count, loff_t *ppos)
-{
-	struct ath11k *ar = file->private_data;
-	char buf[32];
-	int len = 0;
-
-	mutex_lock(&ar->conf_mutex);
-	len = scnprintf(buf, sizeof(buf) - len, "%d\n",
-			ar->debug.extd_rx_stats);
-	mutex_unlock(&ar->conf_mutex);
-
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
-}
-
-static const struct file_operations fops_extd_rx_stats = {
-	.read = ath11k_read_extd_rx_stats,
-	.write = ath11k_write_extd_rx_stats,
-	.open = simple_open,
-};
-
-static int ath11k_fill_bp_stats(struct ath11k_base *ab,
-				struct ath11k_bp_stats *bp_stats,
-				char *buf, int len, int size)
-{
-	lockdep_assert_held(&ab->base_lock);
-
-	len += scnprintf(buf + len, size - len, "count: %u\n",
-			 bp_stats->count);
-	len += scnprintf(buf + len, size - len, "hp: %u\n",
-			 bp_stats->hp);
-	len += scnprintf(buf + len, size - len, "tp: %u\n",
-			 bp_stats->tp);
-	len += scnprintf(buf + len, size - len, "seen before: %ums\n\n",
-			 jiffies_to_msecs(jiffies - bp_stats->jiffies));
-	return len;
-}
-
-static ssize_t ath11k_debug_dump_soc_ring_bp_stats(struct ath11k_base *ab,
-						   char *buf, int size)
-{
-	struct ath11k_bp_stats *bp_stats;
-	bool stats_rxd = false;
-	u8 i, pdev_idx;
-	int len = 0;
-
-	len += scnprintf(buf + len, size - len, "\nBackpressure Stats\n");
-	len += scnprintf(buf + len, size - len, "==================\n");
-
-	spin_lock_bh(&ab->base_lock);
-	for (i = 0; i < HTT_SW_UMAC_RING_IDX_MAX; i++) {
-		bp_stats = &ab->soc_stats.bp_stats.umac_ring_bp_stats[i];
-
-		if (!bp_stats->count)
-			continue;
-
-		len += scnprintf(buf + len, size - len, "Ring: %s\n",
-				 htt_bp_umac_ring[i]);
-		len = ath11k_fill_bp_stats(ab, bp_stats, buf, len, size);
-		stats_rxd = true;
-	}
-
-	for (i = 0; i < HTT_SW_LMAC_RING_IDX_MAX; i++) {
-		for (pdev_idx = 0; pdev_idx < MAX_RADIOS; pdev_idx++) {
-			bp_stats =
-				&ab->soc_stats.bp_stats.lmac_ring_bp_stats[i][pdev_idx];
-
-			if (!bp_stats->count)
-				continue;
-
-			len += scnprintf(buf + len, size - len, "Ring: %s\n",
-					 htt_bp_lmac_ring[i]);
-			len += scnprintf(buf + len, size - len, "pdev: %d\n",
-					 pdev_idx);
-			len = ath11k_fill_bp_stats(ab, bp_stats, buf, len, size);
-			stats_rxd = true;
-		}
-	}
-	spin_unlock_bh(&ab->base_lock);
-
-	if (!stats_rxd)
-		len += scnprintf(buf + len, size - len,
-				 "No Ring Backpressure stats received\n\n");
-
-	return len;
-}
-
-static ssize_t ath11k_debug_dump_soc_dp_stats(struct file *file,
-					      char __user *user_buf,
-					      size_t count, loff_t *ppos)
-{
-	struct ath11k_base *ab = file->private_data;
-	struct ath11k_soc_dp_stats *soc_stats = &ab->soc_stats;
-	int len = 0, i, retval;
-	const int size = 4096;
-	static const char *rxdma_err[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX] = {
-			"Overflow", "MPDU len", "FCS", "Decrypt", "TKIP MIC",
-			"Unencrypt", "MSDU len", "MSDU limit", "WiFi parse",
-			"AMSDU parse", "SA timeout", "DA timeout",
-			"Flow timeout", "Flush req"};
-	static const char *reo_err[HAL_REO_DEST_RING_ERROR_CODE_MAX] = {
-			"Desc addr zero", "Desc inval", "AMPDU in non BA",
-			"Non BA dup", "BA dup", "Frame 2k jump", "BAR 2k jump",
-			"Frame OOR", "BAR OOR", "No BA session",
-			"Frame SN equal SSN", "PN check fail", "2k err",
-			"PN err", "Desc blocked"};
-
-	char *buf;
-
-	buf = kzalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	len += scnprintf(buf + len, size - len, "SOC RX STATS:\n\n");
-	len += scnprintf(buf + len, size - len, "err ring pkts: %u\n",
-			 soc_stats->err_ring_pkts);
-	len += scnprintf(buf + len, size - len, "Invalid RBM: %u\n\n",
-			 soc_stats->invalid_rbm);
-	len += scnprintf(buf + len, size - len, "RXDMA errors:\n");
-	for (i = 0; i < HAL_REO_ENTR_RING_RXDMA_ECODE_MAX; i++)
-		len += scnprintf(buf + len, size - len, "%s: %u\n",
-				 rxdma_err[i], soc_stats->rxdma_error[i]);
-
-	len += scnprintf(buf + len, size - len, "\nREO errors:\n");
-	for (i = 0; i < HAL_REO_DEST_RING_ERROR_CODE_MAX; i++)
-		len += scnprintf(buf + len, size - len, "%s: %u\n",
-				 reo_err[i], soc_stats->reo_error[i]);
-
-	len += scnprintf(buf + len, size - len, "\nHAL REO errors:\n");
-	len += scnprintf(buf + len, size - len,
-			 "ring0: %u\nring1: %u\nring2: %u\nring3: %u\n",
-			 soc_stats->hal_reo_error[0],
-			 soc_stats->hal_reo_error[1],
-			 soc_stats->hal_reo_error[2],
-			 soc_stats->hal_reo_error[3]);
-
-	len += scnprintf(buf + len, size - len, "\nSOC TX STATS:\n");
-	len += scnprintf(buf + len, size - len, "\nTCL Ring Full Failures:\n");
-
-	for (i = 0; i < DP_TCL_NUM_RING_MAX; i++)
-		len += scnprintf(buf + len, size - len, "ring%d: %u\n",
-				 i, soc_stats->tx_err.desc_na[i]);
-
-	len += scnprintf(buf + len, size - len,
-			 "\nMisc Transmit Failures: %d\n",
-			 atomic_read(&soc_stats->tx_err.misc_fail));
-
-	len += ath11k_debug_dump_soc_ring_bp_stats(ab, buf + len, size - len);
-
-	if (len > size)
-		len = size;
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
-	kfree(buf);
-
-	return retval;
-}
-
-static const struct file_operations fops_soc_dp_stats = {
-	.read = ath11k_debug_dump_soc_dp_stats,
-	.open = simple_open,
-	.owner = THIS_MODULE,
-	.llseek = default_llseek,
-};
-
-int ath11k_debug_pdev_create(struct ath11k_base *ab)
-{
-	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
-		return 0;
-
-	ab->debugfs_soc = debugfs_create_dir(ab->hw_params.name, ab->debugfs_ath11k);
-
-	if (IS_ERR_OR_NULL(ab->debugfs_soc)) {
-		if (IS_ERR(ab->debugfs_soc))
-			return PTR_ERR(ab->debugfs_soc);
-		return -ENOMEM;
-	}
-
-	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
-			    &fops_simulate_fw_crash);
-
-	debugfs_create_file("soc_dp_stats", 0600, ab->debugfs_soc, ab,
-			    &fops_soc_dp_stats);
-
-	return 0;
-}
-
-void ath11k_debug_pdev_destroy(struct ath11k_base *ab)
-{
-	debugfs_remove_recursive(ab->debugfs_ath11k);
-	ab->debugfs_ath11k = NULL;
-}
-
-int ath11k_debug_soc_create(struct ath11k_base *ab)
-{
-	ab->debugfs_ath11k = debugfs_create_dir("ath11k", NULL);
-
-	if (IS_ERR_OR_NULL(ab->debugfs_ath11k)) {
-		if (IS_ERR(ab->debugfs_ath11k))
-			return PTR_ERR(ab->debugfs_ath11k);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-void ath11k_debug_soc_destroy(struct ath11k_base *ab)
-{
-	debugfs_remove_recursive(ab->debugfs_soc);
-	ab->debugfs_soc = NULL;
-}
-
-void ath11k_debug_fw_stats_init(struct ath11k *ar)
-{
-	struct dentry *fwstats_dir = debugfs_create_dir("fw_stats",
-							ar->debug.debugfs_pdev);
-
-	ar->debug.fw_stats.debugfs_fwstats = fwstats_dir;
-
-	/* all stats debugfs files created are under "fw_stats" directory
-	 * created per PDEV
-	 */
-	debugfs_create_file("pdev_stats", 0600, fwstats_dir, ar,
-			    &fops_pdev_stats);
-	debugfs_create_file("vdev_stats", 0600, fwstats_dir, ar,
-			    &fops_vdev_stats);
-	debugfs_create_file("beacon_stats", 0600, fwstats_dir, ar,
-			    &fops_bcn_stats);
-
-	INIT_LIST_HEAD(&ar->debug.fw_stats.pdevs);
-	INIT_LIST_HEAD(&ar->debug.fw_stats.vdevs);
-	INIT_LIST_HEAD(&ar->debug.fw_stats.bcn);
-
-	init_completion(&ar->debug.fw_stats_complete);
-}
-
-static ssize_t ath11k_write_pktlog_filter(struct file *file,
-					  const char __user *ubuf,
-					  size_t count, loff_t *ppos)
-{
-	struct ath11k *ar = file->private_data;
-	struct ath11k_base *ab = ar->ab;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
-	u32 rx_filter = 0, ring_id, filter, mode;
-	u8 buf[128] = {0};
-	int i, ret;
-	ssize_t rc;
-
-	mutex_lock(&ar->conf_mutex);
-	if (ar->state != ATH11K_STATE_ON) {
-		ret = -ENETDOWN;
-		goto out;
-	}
-
-	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
-	if (rc < 0) {
-		ret = rc;
-		goto out;
-	}
-	buf[rc] = '\0';
-
-	ret = sscanf(buf, "0x%x %u", &filter, &mode);
-	if (ret != 2) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (filter) {
-		ret = ath11k_wmi_pdev_pktlog_enable(ar, filter);
-		if (ret) {
-			ath11k_warn(ar->ab,
-				    "failed to enable pktlog filter %x: %d\n",
-				    ar->debug.pktlog_filter, ret);
-			goto out;
-		}
-	} else {
-		ret = ath11k_wmi_pdev_pktlog_disable(ar);
-		if (ret) {
-			ath11k_warn(ar->ab, "failed to disable pktlog: %d\n", ret);
-			goto out;
-		}
-	}
-
-#define HTT_RX_FILTER_TLV_LITE_MODE \
-			(HTT_RX_FILTER_TLV_FLAGS_PPDU_START | \
-			HTT_RX_FILTER_TLV_FLAGS_PPDU_END | \
-			HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS | \
-			HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT | \
-			HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE | \
-			HTT_RX_FILTER_TLV_FLAGS_MPDU_START)
-
-	if (mode == ATH11K_PKTLOG_MODE_FULL) {
-		rx_filter = HTT_RX_FILTER_TLV_LITE_MODE |
-			    HTT_RX_FILTER_TLV_FLAGS_MSDU_START |
-			    HTT_RX_FILTER_TLV_FLAGS_MSDU_END |
-			    HTT_RX_FILTER_TLV_FLAGS_MPDU_END |
-			    HTT_RX_FILTER_TLV_FLAGS_PACKET_HEADER |
-			    HTT_RX_FILTER_TLV_FLAGS_ATTENTION;
-	} else if (mode == ATH11K_PKTLOG_MODE_LITE) {
-		ret = ath11k_dp_tx_htt_h2t_ppdu_stats_req(ar,
-							  HTT_PPDU_STATS_TAG_PKTLOG);
-		if (ret) {
-			ath11k_err(ar->ab, "failed to enable pktlog lite: %d\n", ret);
-			goto out;
-		}
-
-		rx_filter = HTT_RX_FILTER_TLV_LITE_MODE;
-	} else {
-		ret = ath11k_dp_tx_htt_h2t_ppdu_stats_req(ar,
-							  HTT_PPDU_STATS_TAG_DEFAULT);
-		if (ret) {
-			ath11k_err(ar->ab, "failed to send htt ppdu stats req: %d\n",
-				   ret);
-			goto out;
-		}
-	}
-
-	tlv_filter.rx_filter = rx_filter;
-	if (rx_filter) {
-		tlv_filter.pkt_filter_flags0 = HTT_RX_FP_MGMT_FILTER_FLAGS0;
-		tlv_filter.pkt_filter_flags1 = HTT_RX_FP_MGMT_FILTER_FLAGS1;
-		tlv_filter.pkt_filter_flags2 = HTT_RX_FP_CTRL_FILTER_FLASG2;
-		tlv_filter.pkt_filter_flags3 = HTT_RX_FP_CTRL_FILTER_FLASG3 |
-					       HTT_RX_FP_DATA_FILTER_FLASG3;
-	}
-
-	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
-		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
-		ret = ath11k_dp_tx_htt_rx_filter_setup(ab, ring_id,
-						       ar->dp.mac_id + i,
-						       HAL_RXDMA_MONITOR_STATUS,
-						       DP_RX_BUFFER_SIZE, &tlv_filter);
-
-		if (ret) {
-			ath11k_warn(ab, "failed to set rx filter for monitor status ring\n");
-			goto out;
-		}
-	}
-
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "pktlog filter %d mode %s\n",
-		   filter, ((mode == ATH11K_PKTLOG_MODE_FULL) ? "full" : "lite"));
-
-	ar->debug.pktlog_filter = filter;
-	ar->debug.pktlog_mode = mode;
-	ret = count;
-
-out:
-	mutex_unlock(&ar->conf_mutex);
-	return ret;
-}
-
-static ssize_t ath11k_read_pktlog_filter(struct file *file,
-					 char __user *ubuf,
-					 size_t count, loff_t *ppos)
-
-{
-	char buf[32] = {0};
-	struct ath11k *ar = file->private_data;
-	int len = 0;
-
-	mutex_lock(&ar->conf_mutex);
-	len = scnprintf(buf, sizeof(buf) - len, "%08x %08x\n",
-			ar->debug.pktlog_filter,
-			ar->debug.pktlog_mode);
-	mutex_unlock(&ar->conf_mutex);
-
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
-}
-
-static const struct file_operations fops_pktlog_filter = {
-	.read = ath11k_read_pktlog_filter,
-	.write = ath11k_write_pktlog_filter,
-	.open = simple_open
-};
-
-static ssize_t ath11k_write_simulate_radar(struct file *file,
-					   const char __user *user_buf,
-					   size_t count, loff_t *ppos)
-{
-	struct ath11k *ar = file->private_data;
-	int ret;
-
-	ret = ath11k_wmi_simulate_radar(ar);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static const struct file_operations fops_simulate_radar = {
-	.write = ath11k_write_simulate_radar,
-	.open = simple_open
-};
-
-int ath11k_debug_register(struct ath11k *ar)
-{
-	struct ath11k_base *ab = ar->ab;
-	char pdev_name[5];
-	char buf[100] = {0};
-
-	snprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
-
-	ar->debug.debugfs_pdev = debugfs_create_dir(pdev_name, ab->debugfs_soc);
-
-	if (IS_ERR_OR_NULL(ar->debug.debugfs_pdev)) {
-		if (IS_ERR(ar->debug.debugfs_pdev))
-			return PTR_ERR(ar->debug.debugfs_pdev);
-
-		return -ENOMEM;
-	}
-
-	/* Create a symlink under ieee80211/phy* */
-	snprintf(buf, 100, "../../ath11k/%pd2", ar->debug.debugfs_pdev);
-	debugfs_create_symlink("ath11k", ar->hw->wiphy->debugfsdir, buf);
-
-	ath11k_debug_htt_stats_init(ar);
-
-	ath11k_debug_fw_stats_init(ar);
-
-	debugfs_create_file("ext_tx_stats", 0644,
-			    ar->debug.debugfs_pdev, ar,
-			    &fops_extd_tx_stats);
-	debugfs_create_file("ext_rx_stats", 0644,
-			    ar->debug.debugfs_pdev, ar,
-			    &fops_extd_rx_stats);
-	debugfs_create_file("pktlog_filter", 0644,
-			    ar->debug.debugfs_pdev, ar,
-			    &fops_pktlog_filter);
-
-	if (ar->hw->wiphy->bands[NL80211_BAND_5GHZ]) {
-		debugfs_create_file("dfs_simulate_radar", 0200,
-				    ar->debug.debugfs_pdev, ar,
-				    &fops_simulate_radar);
-		debugfs_create_bool("dfs_block_radar_events", 0200,
-				    ar->debug.debugfs_pdev,
-				    &ar->dfs_block_radar_events);
-	}
-
-	return 0;
-}
-
-void ath11k_debug_unregister(struct ath11k *ar)
-{
-}
-#endif /* CONFIG_ATH11K_DEBUGFS */
+#endif /* CONFIG_ATH11K_DEBUG */
diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index 55717278ec3f..659a275e2eb3 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -6,11 +6,8 @@
 #ifndef _ATH11K_DEBUG_H_
 #define _ATH11K_DEBUG_H_
 
-#include "hal_tx.h"
 #include "trace.h"
-
-#define ATH11K_TX_POWER_MAX_VAL	70
-#define ATH11K_TX_POWER_MIN_VAL	0
+#include "debugfs.h"
 
 enum ath11k_debug_mask {
 	ATH11K_DBG_AHB		= 0x00000001,
@@ -31,98 +28,6 @@ enum ath11k_debug_mask {
 	ATH11K_DBG_ANY		= 0xffffffff,
 };
 
-/* htt_dbg_ext_stats_type */
-enum ath11k_dbg_htt_ext_stats_type {
-	ATH11K_DBG_HTT_EXT_STATS_RESET                      =  0,
-	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX                    =  1,
-	ATH11K_DBG_HTT_EXT_STATS_PDEV_RX                    =  2,
-	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_HWQ                =  3,
-	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED              =  4,
-	ATH11K_DBG_HTT_EXT_STATS_PDEV_ERROR                 =  5,
-	ATH11K_DBG_HTT_EXT_STATS_PDEV_TQM                   =  6,
-	ATH11K_DBG_HTT_EXT_STATS_TQM_CMDQ                   =  7,
-	ATH11K_DBG_HTT_EXT_STATS_TX_DE_INFO                 =  8,
-	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_RATE               =  9,
-	ATH11K_DBG_HTT_EXT_STATS_PDEV_RX_RATE               =  10,
-	ATH11K_DBG_HTT_EXT_STATS_PEER_INFO                  =  11,
-	ATH11K_DBG_HTT_EXT_STATS_TX_SELFGEN_INFO            =  12,
-	ATH11K_DBG_HTT_EXT_STATS_TX_MU_HWQ                  =  13,
-	ATH11K_DBG_HTT_EXT_STATS_RING_IF_INFO               =  14,
-	ATH11K_DBG_HTT_EXT_STATS_SRNG_INFO                  =  15,
-	ATH11K_DBG_HTT_EXT_STATS_SFM_INFO                   =  16,
-	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_MU                 =  17,
-	ATH11K_DBG_HTT_EXT_STATS_ACTIVE_PEERS_LIST          =  18,
-	ATH11K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS             =  19,
-	ATH11K_DBG_HTT_EXT_STATS_TWT_SESSIONS               =  20,
-	ATH11K_DBG_HTT_EXT_STATS_REO_RESOURCE_STATS         =  21,
-	ATH11K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO           =  22,
-	ATH11K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	    =  23,
-	ATH11K_DBG_HTT_EXT_STATS_RING_BACKPRESSURE_STATS    =  24,
-
-	/* keep this last */
-	ATH11K_DBG_HTT_NUM_EXT_STATS,
-};
-
-struct debug_htt_stats_req {
-	bool done;
-	u8 pdev_id;
-	u8 type;
-	u8 peer_addr[ETH_ALEN];
-	struct completion cmpln;
-	u32 buf_len;
-	u8 buf[];
-};
-
-struct ath_pktlog_hdr {
-	u16 flags;
-	u16 missed_cnt;
-	u16 log_type;
-	u16 size;
-	u32 timestamp;
-	u32 type_specific_data;
-	u8 payload[];
-};
-
-#define ATH11K_HTT_PEER_STATS_RESET BIT(16)
-
-#define ATH11K_HTT_STATS_BUF_SIZE (1024 * 512)
-#define ATH11K_FW_STATS_BUF_SIZE (1024 * 1024)
-
-enum ath11k_pktlog_filter {
-	ATH11K_PKTLOG_RX		= 0x000000001,
-	ATH11K_PKTLOG_TX		= 0x000000002,
-	ATH11K_PKTLOG_RCFIND		= 0x000000004,
-	ATH11K_PKTLOG_RCUPDATE		= 0x000000008,
-	ATH11K_PKTLOG_EVENT_SMART_ANT	= 0x000000020,
-	ATH11K_PKTLOG_EVENT_SW		= 0x000000040,
-	ATH11K_PKTLOG_ANY		= 0x00000006f,
-};
-
-enum ath11k_pktlog_mode {
-	ATH11K_PKTLOG_MODE_LITE = 1,
-	ATH11K_PKTLOG_MODE_FULL = 2,
-};
-
-enum ath11k_pktlog_enum {
-	ATH11K_PKTLOG_TYPE_TX_CTRL      = 1,
-	ATH11K_PKTLOG_TYPE_TX_STAT      = 2,
-	ATH11K_PKTLOG_TYPE_TX_MSDU_ID   = 3,
-	ATH11K_PKTLOG_TYPE_RX_STAT      = 5,
-	ATH11K_PKTLOG_TYPE_RC_FIND      = 6,
-	ATH11K_PKTLOG_TYPE_RC_UPDATE    = 7,
-	ATH11K_PKTLOG_TYPE_TX_VIRT_ADDR = 8,
-	ATH11K_PKTLOG_TYPE_RX_CBF       = 10,
-	ATH11K_PKTLOG_TYPE_RX_STATBUF   = 22,
-	ATH11K_PKTLOG_TYPE_PPDU_STATS   = 23,
-	ATH11K_PKTLOG_TYPE_LITE_RX      = 24,
-};
-
-enum ath11k_dbg_aggr_mode {
-	ATH11K_DBG_AGGR_MODE_AUTO,
-	ATH11K_DBG_AGGR_MODE_MANUAL,
-	ATH11K_DBG_AGGR_MODE_MAX,
-};
-
 __printf(2, 3) void ath11k_info(struct ath11k_base *ab, const char *fmt, ...);
 __printf(2, 3) void ath11k_err(struct ath11k_base *ab, const char *fmt, ...);
 __printf(2, 3) void ath11k_warn(struct ath11k_base *ab, const char *fmt, ...);
@@ -153,153 +58,6 @@ static inline void ath11k_dbg_dump(struct ath11k_base *ab,
 }
 #endif /* CONFIG_ATH11K_DEBUG */
 
-#ifdef CONFIG_ATH11K_DEBUGFS
-int ath11k_debug_soc_create(struct ath11k_base *ab);
-void ath11k_debug_soc_destroy(struct ath11k_base *ab);
-int ath11k_debug_pdev_create(struct ath11k_base *ab);
-void ath11k_debug_pdev_destroy(struct ath11k_base *ab);
-int ath11k_debug_register(struct ath11k *ar);
-void ath11k_debug_unregister(struct ath11k *ar);
-void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
-				      struct sk_buff *skb);
-void ath11k_debug_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb);
-
-void ath11k_debug_fw_stats_init(struct ath11k *ar);
-int ath11k_dbg_htt_stats_req(struct ath11k *ar);
-
-static inline bool ath11k_debug_is_pktlog_lite_mode_enabled(struct ath11k *ar)
-{
-	return (ar->debug.pktlog_mode == ATH11K_PKTLOG_MODE_LITE);
-}
-
-static inline bool ath11k_debug_is_pktlog_rx_stats_enabled(struct ath11k *ar)
-{
-	return (!ar->debug.pktlog_peer_valid && ar->debug.pktlog_mode);
-}
-
-static inline bool ath11k_debug_is_pktlog_peer_valid(struct ath11k *ar, u8 *addr)
-{
-	return (ar->debug.pktlog_peer_valid && ar->debug.pktlog_mode &&
-		ether_addr_equal(addr, ar->debug.pktlog_peer_addr));
-}
-
-static inline int ath11k_debug_is_extd_tx_stats_enabled(struct ath11k *ar)
-{
-	return ar->debug.extd_tx_stats;
-}
-
-static inline int ath11k_debug_is_extd_rx_stats_enabled(struct ath11k *ar)
-{
-	return ar->debug.extd_rx_stats;
-}
-
-static inline int ath11k_debug_rx_filter(struct ath11k *ar)
-{
-	return ar->debug.rx_filter;
-}
-
-void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			    struct ieee80211_sta *sta, struct dentry *dir);
-void
-ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
-				    struct ath11k_per_peer_tx_stats *peer_stats,
-				    u8 legacy_rate_idx);
-void ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
-					       struct sk_buff *msdu,
-					       struct hal_tx_status *ts);
-#else
-static inline int ath11k_debug_soc_create(struct ath11k_base *ab)
-{
-	return 0;
-}
-
-static inline void ath11k_debug_soc_destroy(struct ath11k_base *ab)
-{
-}
-
-static inline int ath11k_debug_pdev_create(struct ath11k_base *ab)
-{
-	return 0;
-}
-
-static inline void ath11k_debug_pdev_destroy(struct ath11k_base *ab)
-{
-}
-
-static inline int ath11k_debug_register(struct ath11k *ar)
-{
-	return 0;
-}
-
-static inline void ath11k_debug_unregister(struct ath11k *ar)
-{
-}
-
-static inline void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
-						    struct sk_buff *skb)
-{
-}
-
-static inline void ath11k_debug_fw_stats_process(struct ath11k_base *ab,
-						 struct sk_buff *skb)
-{
-}
-
-static inline void ath11k_debug_fw_stats_init(struct ath11k *ar)
-{
-}
-
-static inline int ath11k_debug_is_extd_tx_stats_enabled(struct ath11k *ar)
-{
-	return 0;
-}
-
-static inline int ath11k_debug_is_extd_rx_stats_enabled(struct ath11k *ar)
-{
-	return 0;
-}
-
-static inline int ath11k_dbg_htt_stats_req(struct ath11k *ar)
-{
-	return 0;
-}
-
-static inline bool ath11k_debug_is_pktlog_lite_mode_enabled(struct ath11k *ar)
-{
-	return false;
-}
-
-static inline bool ath11k_debug_is_pktlog_rx_stats_enabled(struct ath11k *ar)
-{
-	return false;
-}
-
-static inline bool ath11k_debug_is_pktlog_peer_valid(struct ath11k *ar, u8 *addr)
-{
-	return false;
-}
-
-static inline int ath11k_debug_rx_filter(struct ath11k *ar)
-{
-	return 0;
-}
-
-static inline void
-ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
-				    struct ath11k_per_peer_tx_stats *peer_stats,
-				    u8 legacy_rate_idx)
-{
-}
-
-static inline void
-ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
-					  struct sk_buff *msdu,
-					  struct hal_tx_status *ts)
-{
-}
-
-#endif /* CONFIG_MAC80211_DEBUGFS*/
-
 #define ath11k_dbg(ar, dbg_mask, fmt, ...)			\
 do {								\
 	if (ath11k_debug_mask & dbg_mask)			\
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
new file mode 100644
index 000000000000..b6d00bd6bbd7
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -0,0 +1,1112 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
+ */
+
+#include "debugfs.h"
+
+#include "core.h"
+#include "debug.h"
+#include "wmi.h"
+#include "hal_rx.h"
+#include "dp_tx.h"
+#include "debug_htt_stats.h"
+#include "peer.h"
+
+static const char *htt_bp_umac_ring[HTT_SW_UMAC_RING_IDX_MAX] = {
+	"REO2SW1_RING",
+	"REO2SW2_RING",
+	"REO2SW3_RING",
+	"REO2SW4_RING",
+	"WBM2REO_LINK_RING",
+	"REO2TCL_RING",
+	"REO2FW_RING",
+	"RELEASE_RING",
+	"PPE_RELEASE_RING",
+	"TCL2TQM_RING",
+	"TQM_RELEASE_RING",
+	"REO_RELEASE_RING",
+	"WBM2SW0_RELEASE_RING",
+	"WBM2SW1_RELEASE_RING",
+	"WBM2SW2_RELEASE_RING",
+	"WBM2SW3_RELEASE_RING",
+	"REO_CMD_RING",
+	"REO_STATUS_RING",
+};
+
+static const char *htt_bp_lmac_ring[HTT_SW_LMAC_RING_IDX_MAX] = {
+	"FW2RXDMA_BUF_RING",
+	"FW2RXDMA_STATUS_RING",
+	"FW2RXDMA_LINK_RING",
+	"SW2RXDMA_BUF_RING",
+	"WBM2RXDMA_LINK_RING",
+	"RXDMA2FW_RING",
+	"RXDMA2SW_RING",
+	"RXDMA2RELEASE_RING",
+	"RXDMA2REO_RING",
+	"MONITOR_STATUS_RING",
+	"MONITOR_BUF_RING",
+	"MONITOR_DESC_RING",
+	"MONITOR_DEST_RING",
+};
+
+static void ath11k_fw_stats_pdevs_free(struct list_head *head)
+{
+	struct ath11k_fw_stats_pdev *i, *tmp;
+
+	list_for_each_entry_safe(i, tmp, head, list) {
+		list_del(&i->list);
+		kfree(i);
+	}
+}
+
+static void ath11k_fw_stats_vdevs_free(struct list_head *head)
+{
+	struct ath11k_fw_stats_vdev *i, *tmp;
+
+	list_for_each_entry_safe(i, tmp, head, list) {
+		list_del(&i->list);
+		kfree(i);
+	}
+}
+
+static void ath11k_fw_stats_bcn_free(struct list_head *head)
+{
+	struct ath11k_fw_stats_bcn *i, *tmp;
+
+	list_for_each_entry_safe(i, tmp, head, list) {
+		list_del(&i->list);
+		kfree(i);
+	}
+}
+
+static void ath11k_debug_fw_stats_reset(struct ath11k *ar)
+{
+	spin_lock_bh(&ar->data_lock);
+	ar->debug.fw_stats_done = false;
+	ath11k_fw_stats_pdevs_free(&ar->debug.fw_stats.pdevs);
+	ath11k_fw_stats_vdevs_free(&ar->debug.fw_stats.vdevs);
+	spin_unlock_bh(&ar->data_lock);
+}
+
+void ath11k_debug_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb)
+{
+	struct ath11k_fw_stats stats = {};
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
+	bool is_end;
+	static unsigned int num_vdev, num_bcn;
+	size_t total_vdevs_started = 0;
+	int i, ret;
+
+	INIT_LIST_HEAD(&stats.pdevs);
+	INIT_LIST_HEAD(&stats.vdevs);
+	INIT_LIST_HEAD(&stats.bcn);
+
+	ret = ath11k_wmi_pull_fw_stats(ab, skb, &stats);
+	if (ret) {
+		ath11k_warn(ab, "failed to pull fw stats: %d\n", ret);
+		goto free;
+	}
+
+	rcu_read_lock();
+	ar = ath11k_mac_get_ar_by_pdev_id(ab, stats.pdev_id);
+	if (!ar) {
+		rcu_read_unlock();
+		ath11k_warn(ab, "failed to get ar for pdev_id %d: %d\n",
+			    stats.pdev_id, ret);
+		goto free;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+
+	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
+		list_splice_tail_init(&stats.pdevs, &ar->debug.fw_stats.pdevs);
+		ar->debug.fw_stats_done = true;
+		goto complete;
+	}
+
+	if (stats.stats_id == WMI_REQUEST_VDEV_STAT) {
+		if (list_empty(&stats.vdevs)) {
+			ath11k_warn(ab, "empty vdev stats");
+			goto complete;
+		}
+		/* FW sends all the active VDEV stats irrespective of PDEV,
+		 * hence limit until the count of all VDEVs started
+		 */
+		for (i = 0; i < ab->num_radios; i++) {
+			pdev = rcu_dereference(ab->pdevs_active[i]);
+			if (pdev && pdev->ar)
+				total_vdevs_started += ar->num_started_vdevs;
+		}
+
+		is_end = ((++num_vdev) == total_vdevs_started);
+
+		list_splice_tail_init(&stats.vdevs,
+				      &ar->debug.fw_stats.vdevs);
+
+		if (is_end) {
+			ar->debug.fw_stats_done = true;
+			num_vdev = 0;
+		}
+		goto complete;
+	}
+
+	if (stats.stats_id == WMI_REQUEST_BCN_STAT) {
+		if (list_empty(&stats.bcn)) {
+			ath11k_warn(ab, "empty bcn stats");
+			goto complete;
+		}
+		/* Mark end until we reached the count of all started VDEVs
+		 * within the PDEV
+		 */
+		is_end = ((++num_bcn) == ar->num_started_vdevs);
+
+		list_splice_tail_init(&stats.bcn,
+				      &ar->debug.fw_stats.bcn);
+
+		if (is_end) {
+			ar->debug.fw_stats_done = true;
+			num_bcn = 0;
+		}
+	}
+complete:
+	complete(&ar->debug.fw_stats_complete);
+	rcu_read_unlock();
+	spin_unlock_bh(&ar->data_lock);
+
+free:
+	ath11k_fw_stats_pdevs_free(&stats.pdevs);
+	ath11k_fw_stats_vdevs_free(&stats.vdevs);
+	ath11k_fw_stats_bcn_free(&stats.bcn);
+}
+
+static int ath11k_debug_fw_stats_request(struct ath11k *ar,
+					 struct stats_request_params *req_param)
+{
+	struct ath11k_base *ab = ar->ab;
+	unsigned long timeout, time_left;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	/* FW stats can get split when exceeding the stats data buffer limit.
+	 * In that case, since there is no end marking for the back-to-back
+	 * received 'update stats' event, we keep a 3 seconds timeout in case,
+	 * fw_stats_done is not marked yet
+	 */
+	timeout = jiffies + msecs_to_jiffies(3 * HZ);
+
+	ath11k_debug_fw_stats_reset(ar);
+
+	reinit_completion(&ar->debug.fw_stats_complete);
+
+	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
+
+	if (ret) {
+		ath11k_warn(ab, "could not request fw stats (%d)\n",
+			    ret);
+		return ret;
+	}
+
+	time_left =
+	wait_for_completion_timeout(&ar->debug.fw_stats_complete,
+				    1 * HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	for (;;) {
+		if (time_after(jiffies, timeout))
+			break;
+
+		spin_lock_bh(&ar->data_lock);
+		if (ar->debug.fw_stats_done) {
+			spin_unlock_bh(&ar->data_lock);
+			break;
+		}
+		spin_unlock_bh(&ar->data_lock);
+	}
+	return 0;
+}
+
+static int ath11k_open_pdev_stats(struct inode *inode, struct file *file)
+{
+	struct ath11k *ar = inode->i_private;
+	struct ath11k_base *ab = ar->ab;
+	struct stats_request_params req_param;
+	void *buf = NULL;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto err_unlock;
+	}
+
+	buf = vmalloc(ATH11K_FW_STATS_BUF_SIZE);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	req_param.pdev_id = ar->pdev->pdev_id;
+	req_param.vdev_id = 0;
+	req_param.stats_id = WMI_REQUEST_PDEV_STAT;
+
+	ret = ath11k_debug_fw_stats_request(ar, &req_param);
+	if (ret) {
+		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
+		goto err_free;
+	}
+
+	ath11k_wmi_fw_stats_fill(ar, &ar->debug.fw_stats, req_param.stats_id,
+				 buf);
+
+	file->private_data = buf;
+
+	mutex_unlock(&ar->conf_mutex);
+	return 0;
+
+err_free:
+	vfree(buf);
+
+err_unlock:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static int ath11k_release_pdev_stats(struct inode *inode, struct file *file)
+{
+	vfree(file->private_data);
+
+	return 0;
+}
+
+static ssize_t ath11k_read_pdev_stats(struct file *file,
+				      char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	const char *buf = file->private_data;
+	size_t len = strlen(buf);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_pdev_stats = {
+	.open = ath11k_open_pdev_stats,
+	.release = ath11k_release_pdev_stats,
+	.read = ath11k_read_pdev_stats,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static int ath11k_open_vdev_stats(struct inode *inode, struct file *file)
+{
+	struct ath11k *ar = inode->i_private;
+	struct stats_request_params req_param;
+	void *buf = NULL;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto err_unlock;
+	}
+
+	buf = vmalloc(ATH11K_FW_STATS_BUF_SIZE);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	req_param.pdev_id = ar->pdev->pdev_id;
+	/* VDEV stats is always sent for all active VDEVs from FW */
+	req_param.vdev_id = 0;
+	req_param.stats_id = WMI_REQUEST_VDEV_STAT;
+
+	ret = ath11k_debug_fw_stats_request(ar, &req_param);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to request fw vdev stats: %d\n", ret);
+		goto err_free;
+	}
+
+	ath11k_wmi_fw_stats_fill(ar, &ar->debug.fw_stats, req_param.stats_id,
+				 buf);
+
+	file->private_data = buf;
+
+	mutex_unlock(&ar->conf_mutex);
+	return 0;
+
+err_free:
+	vfree(buf);
+
+err_unlock:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static int ath11k_release_vdev_stats(struct inode *inode, struct file *file)
+{
+	vfree(file->private_data);
+
+	return 0;
+}
+
+static ssize_t ath11k_read_vdev_stats(struct file *file,
+				      char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	const char *buf = file->private_data;
+	size_t len = strlen(buf);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_vdev_stats = {
+	.open = ath11k_open_vdev_stats,
+	.release = ath11k_release_vdev_stats,
+	.read = ath11k_read_vdev_stats,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static int ath11k_open_bcn_stats(struct inode *inode, struct file *file)
+{
+	struct ath11k *ar = inode->i_private;
+	struct ath11k_vif *arvif;
+	struct stats_request_params req_param;
+	void *buf = NULL;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto err_unlock;
+	}
+
+	buf = vmalloc(ATH11K_FW_STATS_BUF_SIZE);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	req_param.stats_id = WMI_REQUEST_BCN_STAT;
+	req_param.pdev_id = ar->pdev->pdev_id;
+
+	/* loop all active VDEVs for bcn stats */
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (!arvif->is_up)
+			continue;
+
+		req_param.vdev_id = arvif->vdev_id;
+		ret = ath11k_debug_fw_stats_request(ar, &req_param);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to request fw bcn stats: %d\n", ret);
+			goto err_free;
+		}
+	}
+
+	ath11k_wmi_fw_stats_fill(ar, &ar->debug.fw_stats, req_param.stats_id,
+				 buf);
+
+	/* since beacon stats request is looped for all active VDEVs, saved fw
+	 * stats is not freed for each request until done for all active VDEVs
+	 */
+	spin_lock_bh(&ar->data_lock);
+	ath11k_fw_stats_bcn_free(&ar->debug.fw_stats.bcn);
+	spin_unlock_bh(&ar->data_lock);
+
+	file->private_data = buf;
+
+	mutex_unlock(&ar->conf_mutex);
+	return 0;
+
+err_free:
+	vfree(buf);
+
+err_unlock:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static int ath11k_release_bcn_stats(struct inode *inode, struct file *file)
+{
+	vfree(file->private_data);
+
+	return 0;
+}
+
+static ssize_t ath11k_read_bcn_stats(struct file *file,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	const char *buf = file->private_data;
+	size_t len = strlen(buf);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_bcn_stats = {
+	.open = ath11k_open_bcn_stats,
+	.release = ath11k_release_bcn_stats,
+	.read = ath11k_read_bcn_stats,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_read_simulate_fw_crash(struct file *file,
+					     char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	const char buf[] =
+		"To simulate firmware crash write one of the keywords to this file:\n"
+		"`assert` - this will send WMI_FORCE_FW_HANG_CMDID to firmware to cause assert.\n"
+		"`hw-restart` - this will simply queue hw restart without fw/hw actually crashing.\n";
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+}
+
+/* Simulate firmware crash:
+ * 'soft': Call wmi command causing firmware hang. This firmware hang is
+ * recoverable by warm firmware reset.
+ * 'hard': Force firmware crash by setting any vdev parameter for not allowed
+ * vdev id. This is hard firmware crash because it is recoverable only by cold
+ * firmware reset.
+ */
+static ssize_t ath11k_write_simulate_fw_crash(struct file *file,
+					      const char __user *user_buf,
+					      size_t count, loff_t *ppos)
+{
+	struct ath11k_base *ab = file->private_data;
+	struct ath11k_pdev *pdev;
+	struct ath11k *ar = ab->pdevs[0].ar;
+	char buf[32] = {0};
+	ssize_t rc;
+	int i, ret, radioup = 0;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		if (ar && ar->state == ATH11K_STATE_ON) {
+			radioup = 1;
+			break;
+		}
+	}
+	/* filter partial writes and invalid commands */
+	if (*ppos != 0 || count >= sizeof(buf) || count == 0)
+		return -EINVAL;
+
+	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+	if (rc < 0)
+		return rc;
+
+	/* drop the possible '\n' from the end */
+	if (buf[*ppos - 1] == '\n')
+		buf[*ppos - 1] = '\0';
+
+	if (radioup == 0) {
+		ret = -ENETDOWN;
+		goto exit;
+	}
+
+	if (!strcmp(buf, "assert")) {
+		ath11k_info(ab, "simulating firmware assert crash\n");
+		ret = ath11k_wmi_force_fw_hang_cmd(ar,
+						   ATH11K_WMI_FW_HANG_ASSERT_TYPE,
+						   ATH11K_WMI_FW_HANG_DELAY);
+	} else {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (ret) {
+		ath11k_warn(ab, "failed to simulate firmware crash: %d\n", ret);
+		goto exit;
+	}
+
+	ret = count;
+
+exit:
+	return ret;
+}
+
+static const struct file_operations fops_simulate_fw_crash = {
+	.read = ath11k_read_simulate_fw_crash,
+	.write = ath11k_write_simulate_fw_crash,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_write_enable_extd_tx_stats(struct file *file,
+						 const char __user *ubuf,
+						 size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	u32 filter;
+	int ret;
+
+	if (kstrtouint_from_user(ubuf, count, 0, &filter))
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto out;
+	}
+
+	if (filter == ar->debug.extd_tx_stats) {
+		ret = count;
+		goto out;
+	}
+
+	ar->debug.extd_tx_stats = filter;
+	ret = count;
+
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static ssize_t ath11k_read_enable_extd_tx_stats(struct file *file,
+						char __user *ubuf,
+						size_t count, loff_t *ppos)
+
+{
+	char buf[32] = {0};
+	struct ath11k *ar = file->private_data;
+	int len = 0;
+
+	mutex_lock(&ar->conf_mutex);
+	len = scnprintf(buf, sizeof(buf) - len, "%08x\n",
+			ar->debug.extd_tx_stats);
+	mutex_unlock(&ar->conf_mutex);
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_extd_tx_stats = {
+	.read = ath11k_read_enable_extd_tx_stats,
+	.write = ath11k_write_enable_extd_tx_stats,
+	.open = simple_open
+};
+
+static ssize_t ath11k_write_extd_rx_stats(struct file *file,
+					  const char __user *ubuf,
+					  size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	struct ath11k_base *ab = ar->ab;
+	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	u32 enable, rx_filter = 0, ring_id;
+	int i;
+	int ret;
+
+	if (kstrtouint_from_user(ubuf, count, 0, &enable))
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto exit;
+	}
+
+	if (enable > 1) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (enable == ar->debug.extd_rx_stats) {
+		ret = count;
+		goto exit;
+	}
+
+	if (enable) {
+		rx_filter =  HTT_RX_FILTER_TLV_FLAGS_MPDU_START;
+		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_START;
+		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END;
+		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS;
+		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT;
+		rx_filter |= HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE;
+
+		tlv_filter.rx_filter = rx_filter;
+		tlv_filter.pkt_filter_flags0 = HTT_RX_FP_MGMT_FILTER_FLAGS0;
+		tlv_filter.pkt_filter_flags1 = HTT_RX_FP_MGMT_FILTER_FLAGS1;
+		tlv_filter.pkt_filter_flags2 = HTT_RX_FP_CTRL_FILTER_FLASG2;
+		tlv_filter.pkt_filter_flags3 = HTT_RX_FP_CTRL_FILTER_FLASG3 |
+			HTT_RX_FP_DATA_FILTER_FLASG3;
+	} else {
+		tlv_filter = ath11k_mac_mon_status_filter_default;
+	}
+
+	ar->debug.rx_filter = tlv_filter.rx_filter;
+
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+		ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, ar->dp.mac_id,
+						       HAL_RXDMA_MONITOR_STATUS,
+						       DP_RX_BUFFER_SIZE, &tlv_filter);
+
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set rx filter for monitor status ring\n");
+			goto exit;
+		}
+	}
+
+	ar->debug.extd_rx_stats = enable;
+	ret = count;
+exit:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static ssize_t ath11k_read_extd_rx_stats(struct file *file,
+					 char __user *ubuf,
+					 size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char buf[32];
+	int len = 0;
+
+	mutex_lock(&ar->conf_mutex);
+	len = scnprintf(buf, sizeof(buf) - len, "%d\n",
+			ar->debug.extd_rx_stats);
+	mutex_unlock(&ar->conf_mutex);
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_extd_rx_stats = {
+	.read = ath11k_read_extd_rx_stats,
+	.write = ath11k_write_extd_rx_stats,
+	.open = simple_open,
+};
+
+static int ath11k_fill_bp_stats(struct ath11k_base *ab,
+				struct ath11k_bp_stats *bp_stats,
+				char *buf, int len, int size)
+{
+	lockdep_assert_held(&ab->base_lock);
+
+	len += scnprintf(buf + len, size - len, "count: %u\n",
+			 bp_stats->count);
+	len += scnprintf(buf + len, size - len, "hp: %u\n",
+			 bp_stats->hp);
+	len += scnprintf(buf + len, size - len, "tp: %u\n",
+			 bp_stats->tp);
+	len += scnprintf(buf + len, size - len, "seen before: %ums\n\n",
+			 jiffies_to_msecs(jiffies - bp_stats->jiffies));
+	return len;
+}
+
+static ssize_t ath11k_debug_dump_soc_ring_bp_stats(struct ath11k_base *ab,
+						   char *buf, int size)
+{
+	struct ath11k_bp_stats *bp_stats;
+	bool stats_rxd = false;
+	u8 i, pdev_idx;
+	int len = 0;
+
+	len += scnprintf(buf + len, size - len, "\nBackpressure Stats\n");
+	len += scnprintf(buf + len, size - len, "==================\n");
+
+	spin_lock_bh(&ab->base_lock);
+	for (i = 0; i < HTT_SW_UMAC_RING_IDX_MAX; i++) {
+		bp_stats = &ab->soc_stats.bp_stats.umac_ring_bp_stats[i];
+
+		if (!bp_stats->count)
+			continue;
+
+		len += scnprintf(buf + len, size - len, "Ring: %s\n",
+				 htt_bp_umac_ring[i]);
+		len = ath11k_fill_bp_stats(ab, bp_stats, buf, len, size);
+		stats_rxd = true;
+	}
+
+	for (i = 0; i < HTT_SW_LMAC_RING_IDX_MAX; i++) {
+		for (pdev_idx = 0; pdev_idx < MAX_RADIOS; pdev_idx++) {
+			bp_stats =
+				&ab->soc_stats.bp_stats.lmac_ring_bp_stats[i][pdev_idx];
+
+			if (!bp_stats->count)
+				continue;
+
+			len += scnprintf(buf + len, size - len, "Ring: %s\n",
+					 htt_bp_lmac_ring[i]);
+			len += scnprintf(buf + len, size - len, "pdev: %d\n",
+					 pdev_idx);
+			len = ath11k_fill_bp_stats(ab, bp_stats, buf, len, size);
+			stats_rxd = true;
+		}
+	}
+	spin_unlock_bh(&ab->base_lock);
+
+	if (!stats_rxd)
+		len += scnprintf(buf + len, size - len,
+				 "No Ring Backpressure stats received\n\n");
+
+	return len;
+}
+
+static ssize_t ath11k_debug_dump_soc_dp_stats(struct file *file,
+					      char __user *user_buf,
+					      size_t count, loff_t *ppos)
+{
+	struct ath11k_base *ab = file->private_data;
+	struct ath11k_soc_dp_stats *soc_stats = &ab->soc_stats;
+	int len = 0, i, retval;
+	const int size = 4096;
+	static const char *rxdma_err[HAL_REO_ENTR_RING_RXDMA_ECODE_MAX] = {
+			"Overflow", "MPDU len", "FCS", "Decrypt", "TKIP MIC",
+			"Unencrypt", "MSDU len", "MSDU limit", "WiFi parse",
+			"AMSDU parse", "SA timeout", "DA timeout",
+			"Flow timeout", "Flush req"};
+	static const char *reo_err[HAL_REO_DEST_RING_ERROR_CODE_MAX] = {
+			"Desc addr zero", "Desc inval", "AMPDU in non BA",
+			"Non BA dup", "BA dup", "Frame 2k jump", "BAR 2k jump",
+			"Frame OOR", "BAR OOR", "No BA session",
+			"Frame SN equal SSN", "PN check fail", "2k err",
+			"PN err", "Desc blocked"};
+
+	char *buf;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	len += scnprintf(buf + len, size - len, "SOC RX STATS:\n\n");
+	len += scnprintf(buf + len, size - len, "err ring pkts: %u\n",
+			 soc_stats->err_ring_pkts);
+	len += scnprintf(buf + len, size - len, "Invalid RBM: %u\n\n",
+			 soc_stats->invalid_rbm);
+	len += scnprintf(buf + len, size - len, "RXDMA errors:\n");
+	for (i = 0; i < HAL_REO_ENTR_RING_RXDMA_ECODE_MAX; i++)
+		len += scnprintf(buf + len, size - len, "%s: %u\n",
+				 rxdma_err[i], soc_stats->rxdma_error[i]);
+
+	len += scnprintf(buf + len, size - len, "\nREO errors:\n");
+	for (i = 0; i < HAL_REO_DEST_RING_ERROR_CODE_MAX; i++)
+		len += scnprintf(buf + len, size - len, "%s: %u\n",
+				 reo_err[i], soc_stats->reo_error[i]);
+
+	len += scnprintf(buf + len, size - len, "\nHAL REO errors:\n");
+	len += scnprintf(buf + len, size - len,
+			 "ring0: %u\nring1: %u\nring2: %u\nring3: %u\n",
+			 soc_stats->hal_reo_error[0],
+			 soc_stats->hal_reo_error[1],
+			 soc_stats->hal_reo_error[2],
+			 soc_stats->hal_reo_error[3]);
+
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
+	len += ath11k_debug_dump_soc_ring_bp_stats(ab, buf + len, size - len);
+
+	if (len > size)
+		len = size;
+	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+
+	return retval;
+}
+
+static const struct file_operations fops_soc_dp_stats = {
+	.read = ath11k_debug_dump_soc_dp_stats,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+int ath11k_debug_pdev_create(struct ath11k_base *ab)
+{
+	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
+		return 0;
+
+	ab->debugfs_soc = debugfs_create_dir(ab->hw_params.name, ab->debugfs_ath11k);
+
+	if (IS_ERR_OR_NULL(ab->debugfs_soc)) {
+		if (IS_ERR(ab->debugfs_soc))
+			return PTR_ERR(ab->debugfs_soc);
+		return -ENOMEM;
+	}
+
+	debugfs_create_file("simulate_fw_crash", 0600, ab->debugfs_soc, ab,
+			    &fops_simulate_fw_crash);
+
+	debugfs_create_file("soc_dp_stats", 0600, ab->debugfs_soc, ab,
+			    &fops_soc_dp_stats);
+
+	return 0;
+}
+
+void ath11k_debug_pdev_destroy(struct ath11k_base *ab)
+{
+	debugfs_remove_recursive(ab->debugfs_ath11k);
+	ab->debugfs_ath11k = NULL;
+}
+
+int ath11k_debug_soc_create(struct ath11k_base *ab)
+{
+	ab->debugfs_ath11k = debugfs_create_dir("ath11k", NULL);
+
+	if (IS_ERR_OR_NULL(ab->debugfs_ath11k)) {
+		if (IS_ERR(ab->debugfs_ath11k))
+			return PTR_ERR(ab->debugfs_ath11k);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void ath11k_debug_soc_destroy(struct ath11k_base *ab)
+{
+	debugfs_remove_recursive(ab->debugfs_soc);
+	ab->debugfs_soc = NULL;
+}
+
+void ath11k_debug_fw_stats_init(struct ath11k *ar)
+{
+	struct dentry *fwstats_dir = debugfs_create_dir("fw_stats",
+							ar->debug.debugfs_pdev);
+
+	ar->debug.fw_stats.debugfs_fwstats = fwstats_dir;
+
+	/* all stats debugfs files created are under "fw_stats" directory
+	 * created per PDEV
+	 */
+	debugfs_create_file("pdev_stats", 0600, fwstats_dir, ar,
+			    &fops_pdev_stats);
+	debugfs_create_file("vdev_stats", 0600, fwstats_dir, ar,
+			    &fops_vdev_stats);
+	debugfs_create_file("beacon_stats", 0600, fwstats_dir, ar,
+			    &fops_bcn_stats);
+
+	INIT_LIST_HEAD(&ar->debug.fw_stats.pdevs);
+	INIT_LIST_HEAD(&ar->debug.fw_stats.vdevs);
+	INIT_LIST_HEAD(&ar->debug.fw_stats.bcn);
+
+	init_completion(&ar->debug.fw_stats_complete);
+}
+
+static ssize_t ath11k_write_pktlog_filter(struct file *file,
+					  const char __user *ubuf,
+					  size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	struct ath11k_base *ab = ar->ab;
+	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	u32 rx_filter = 0, ring_id, filter, mode;
+	u8 buf[128] = {0};
+	int i, ret;
+	ssize_t rc;
+
+	mutex_lock(&ar->conf_mutex);
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto out;
+	}
+
+	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	if (rc < 0) {
+		ret = rc;
+		goto out;
+	}
+	buf[rc] = '\0';
+
+	ret = sscanf(buf, "0x%x %u", &filter, &mode);
+	if (ret != 2) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (filter) {
+		ret = ath11k_wmi_pdev_pktlog_enable(ar, filter);
+		if (ret) {
+			ath11k_warn(ar->ab,
+				    "failed to enable pktlog filter %x: %d\n",
+				    ar->debug.pktlog_filter, ret);
+			goto out;
+		}
+	} else {
+		ret = ath11k_wmi_pdev_pktlog_disable(ar);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to disable pktlog: %d\n", ret);
+			goto out;
+		}
+	}
+
+#define HTT_RX_FILTER_TLV_LITE_MODE \
+			(HTT_RX_FILTER_TLV_FLAGS_PPDU_START | \
+			HTT_RX_FILTER_TLV_FLAGS_PPDU_END | \
+			HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS | \
+			HTT_RX_FILTER_TLV_FLAGS_PPDU_END_USER_STATS_EXT | \
+			HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE | \
+			HTT_RX_FILTER_TLV_FLAGS_MPDU_START)
+
+	if (mode == ATH11K_PKTLOG_MODE_FULL) {
+		rx_filter = HTT_RX_FILTER_TLV_LITE_MODE |
+			    HTT_RX_FILTER_TLV_FLAGS_MSDU_START |
+			    HTT_RX_FILTER_TLV_FLAGS_MSDU_END |
+			    HTT_RX_FILTER_TLV_FLAGS_MPDU_END |
+			    HTT_RX_FILTER_TLV_FLAGS_PACKET_HEADER |
+			    HTT_RX_FILTER_TLV_FLAGS_ATTENTION;
+	} else if (mode == ATH11K_PKTLOG_MODE_LITE) {
+		ret = ath11k_dp_tx_htt_h2t_ppdu_stats_req(ar,
+							  HTT_PPDU_STATS_TAG_PKTLOG);
+		if (ret) {
+			ath11k_err(ar->ab, "failed to enable pktlog lite: %d\n", ret);
+			goto out;
+		}
+
+		rx_filter = HTT_RX_FILTER_TLV_LITE_MODE;
+	} else {
+		ret = ath11k_dp_tx_htt_h2t_ppdu_stats_req(ar,
+							  HTT_PPDU_STATS_TAG_DEFAULT);
+		if (ret) {
+			ath11k_err(ar->ab, "failed to send htt ppdu stats req: %d\n",
+				   ret);
+			goto out;
+		}
+	}
+
+	tlv_filter.rx_filter = rx_filter;
+	if (rx_filter) {
+		tlv_filter.pkt_filter_flags0 = HTT_RX_FP_MGMT_FILTER_FLAGS0;
+		tlv_filter.pkt_filter_flags1 = HTT_RX_FP_MGMT_FILTER_FLAGS1;
+		tlv_filter.pkt_filter_flags2 = HTT_RX_FP_CTRL_FILTER_FLASG2;
+		tlv_filter.pkt_filter_flags3 = HTT_RX_FP_CTRL_FILTER_FLASG3 |
+					       HTT_RX_FP_DATA_FILTER_FLASG3;
+	}
+
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+		ret = ath11k_dp_tx_htt_rx_filter_setup(ab, ring_id,
+						       ar->dp.mac_id + i,
+						       HAL_RXDMA_MONITOR_STATUS,
+						       DP_RX_BUFFER_SIZE, &tlv_filter);
+
+		if (ret) {
+			ath11k_warn(ab, "failed to set rx filter for monitor status ring\n");
+			goto out;
+		}
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "pktlog filter %d mode %s\n",
+		   filter, ((mode == ATH11K_PKTLOG_MODE_FULL) ? "full" : "lite"));
+
+	ar->debug.pktlog_filter = filter;
+	ar->debug.pktlog_mode = mode;
+	ret = count;
+
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static ssize_t ath11k_read_pktlog_filter(struct file *file,
+					 char __user *ubuf,
+					 size_t count, loff_t *ppos)
+
+{
+	char buf[32] = {0};
+	struct ath11k *ar = file->private_data;
+	int len = 0;
+
+	mutex_lock(&ar->conf_mutex);
+	len = scnprintf(buf, sizeof(buf) - len, "%08x %08x\n",
+			ar->debug.pktlog_filter,
+			ar->debug.pktlog_mode);
+	mutex_unlock(&ar->conf_mutex);
+
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_pktlog_filter = {
+	.read = ath11k_read_pktlog_filter,
+	.write = ath11k_write_pktlog_filter,
+	.open = simple_open
+};
+
+static ssize_t ath11k_write_simulate_radar(struct file *file,
+					   const char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	int ret;
+
+	ret = ath11k_wmi_simulate_radar(ar);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations fops_simulate_radar = {
+	.write = ath11k_write_simulate_radar,
+	.open = simple_open
+};
+
+int ath11k_debug_register(struct ath11k *ar)
+{
+	struct ath11k_base *ab = ar->ab;
+	char pdev_name[5];
+	char buf[100] = {0};
+
+	snprintf(pdev_name, sizeof(pdev_name), "%s%d", "mac", ar->pdev_idx);
+
+	ar->debug.debugfs_pdev = debugfs_create_dir(pdev_name, ab->debugfs_soc);
+
+	if (IS_ERR_OR_NULL(ar->debug.debugfs_pdev)) {
+		if (IS_ERR(ar->debug.debugfs_pdev))
+			return PTR_ERR(ar->debug.debugfs_pdev);
+
+		return -ENOMEM;
+	}
+
+	/* Create a symlink under ieee80211/phy* */
+	snprintf(buf, 100, "../../ath11k/%pd2", ar->debug.debugfs_pdev);
+	debugfs_create_symlink("ath11k", ar->hw->wiphy->debugfsdir, buf);
+
+	ath11k_debug_htt_stats_init(ar);
+
+	ath11k_debug_fw_stats_init(ar);
+
+	debugfs_create_file("ext_tx_stats", 0644,
+			    ar->debug.debugfs_pdev, ar,
+			    &fops_extd_tx_stats);
+	debugfs_create_file("ext_rx_stats", 0644,
+			    ar->debug.debugfs_pdev, ar,
+			    &fops_extd_rx_stats);
+	debugfs_create_file("pktlog_filter", 0644,
+			    ar->debug.debugfs_pdev, ar,
+			    &fops_pktlog_filter);
+
+	if (ar->hw->wiphy->bands[NL80211_BAND_5GHZ]) {
+		debugfs_create_file("dfs_simulate_radar", 0200,
+				    ar->debug.debugfs_pdev, ar,
+				    &fops_simulate_radar);
+		debugfs_create_bool("dfs_block_radar_events", 0200,
+				    ar->debug.debugfs_pdev,
+				    &ar->dfs_block_radar_events);
+	}
+
+	return 0;
+}
+
+void ath11k_debug_unregister(struct ath11k *ar)
+{
+}
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
new file mode 100644
index 000000000000..ab21d9003938
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -0,0 +1,253 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _ATH11K_DEBUGFS_H_
+#define _ATH11K_DEBUGFS_H_
+
+#include "hal_tx.h"
+
+#define ATH11K_TX_POWER_MAX_VAL	70
+#define ATH11K_TX_POWER_MIN_VAL	0
+
+/* htt_dbg_ext_stats_type */
+enum ath11k_dbg_htt_ext_stats_type {
+	ATH11K_DBG_HTT_EXT_STATS_RESET                      =  0,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX                    =  1,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_RX                    =  2,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_HWQ                =  3,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED              =  4,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_ERROR                 =  5,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TQM                   =  6,
+	ATH11K_DBG_HTT_EXT_STATS_TQM_CMDQ                   =  7,
+	ATH11K_DBG_HTT_EXT_STATS_TX_DE_INFO                 =  8,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_RATE               =  9,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_RX_RATE               =  10,
+	ATH11K_DBG_HTT_EXT_STATS_PEER_INFO                  =  11,
+	ATH11K_DBG_HTT_EXT_STATS_TX_SELFGEN_INFO            =  12,
+	ATH11K_DBG_HTT_EXT_STATS_TX_MU_HWQ                  =  13,
+	ATH11K_DBG_HTT_EXT_STATS_RING_IF_INFO               =  14,
+	ATH11K_DBG_HTT_EXT_STATS_SRNG_INFO                  =  15,
+	ATH11K_DBG_HTT_EXT_STATS_SFM_INFO                   =  16,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_MU                 =  17,
+	ATH11K_DBG_HTT_EXT_STATS_ACTIVE_PEERS_LIST          =  18,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS             =  19,
+	ATH11K_DBG_HTT_EXT_STATS_TWT_SESSIONS               =  20,
+	ATH11K_DBG_HTT_EXT_STATS_REO_RESOURCE_STATS         =  21,
+	ATH11K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO           =  22,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	    =  23,
+	ATH11K_DBG_HTT_EXT_STATS_RING_BACKPRESSURE_STATS    =  24,
+
+	/* keep this last */
+	ATH11K_DBG_HTT_NUM_EXT_STATS,
+};
+
+struct debug_htt_stats_req {
+	bool done;
+	u8 pdev_id;
+	u8 type;
+	u8 peer_addr[ETH_ALEN];
+	struct completion cmpln;
+	u32 buf_len;
+	u8 buf[];
+};
+
+struct ath_pktlog_hdr {
+	u16 flags;
+	u16 missed_cnt;
+	u16 log_type;
+	u16 size;
+	u32 timestamp;
+	u32 type_specific_data;
+	u8 payload[];
+};
+
+#define ATH11K_HTT_PEER_STATS_RESET BIT(16)
+
+#define ATH11K_HTT_STATS_BUF_SIZE (1024 * 512)
+#define ATH11K_FW_STATS_BUF_SIZE (1024 * 1024)
+
+enum ath11k_pktlog_filter {
+	ATH11K_PKTLOG_RX		= 0x000000001,
+	ATH11K_PKTLOG_TX		= 0x000000002,
+	ATH11K_PKTLOG_RCFIND		= 0x000000004,
+	ATH11K_PKTLOG_RCUPDATE		= 0x000000008,
+	ATH11K_PKTLOG_EVENT_SMART_ANT	= 0x000000020,
+	ATH11K_PKTLOG_EVENT_SW		= 0x000000040,
+	ATH11K_PKTLOG_ANY		= 0x00000006f,
+};
+
+enum ath11k_pktlog_mode {
+	ATH11K_PKTLOG_MODE_LITE = 1,
+	ATH11K_PKTLOG_MODE_FULL = 2,
+};
+
+enum ath11k_pktlog_enum {
+	ATH11K_PKTLOG_TYPE_TX_CTRL      = 1,
+	ATH11K_PKTLOG_TYPE_TX_STAT      = 2,
+	ATH11K_PKTLOG_TYPE_TX_MSDU_ID   = 3,
+	ATH11K_PKTLOG_TYPE_RX_STAT      = 5,
+	ATH11K_PKTLOG_TYPE_RC_FIND      = 6,
+	ATH11K_PKTLOG_TYPE_RC_UPDATE    = 7,
+	ATH11K_PKTLOG_TYPE_TX_VIRT_ADDR = 8,
+	ATH11K_PKTLOG_TYPE_RX_CBF       = 10,
+	ATH11K_PKTLOG_TYPE_RX_STATBUF   = 22,
+	ATH11K_PKTLOG_TYPE_PPDU_STATS   = 23,
+	ATH11K_PKTLOG_TYPE_LITE_RX      = 24,
+};
+
+enum ath11k_dbg_aggr_mode {
+	ATH11K_DBG_AGGR_MODE_AUTO,
+	ATH11K_DBG_AGGR_MODE_MANUAL,
+	ATH11K_DBG_AGGR_MODE_MAX,
+};
+
+#ifdef CONFIG_ATH11K_DEBUGFS
+int ath11k_debug_soc_create(struct ath11k_base *ab);
+void ath11k_debug_soc_destroy(struct ath11k_base *ab);
+int ath11k_debug_pdev_create(struct ath11k_base *ab);
+void ath11k_debug_pdev_destroy(struct ath11k_base *ab);
+int ath11k_debug_register(struct ath11k *ar);
+void ath11k_debug_unregister(struct ath11k *ar);
+void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
+				      struct sk_buff *skb);
+void ath11k_debug_fw_stats_process(struct ath11k_base *ab, struct sk_buff *skb);
+
+void ath11k_debug_fw_stats_init(struct ath11k *ar);
+int ath11k_dbg_htt_stats_req(struct ath11k *ar);
+
+static inline bool ath11k_debug_is_pktlog_lite_mode_enabled(struct ath11k *ar)
+{
+	return (ar->debug.pktlog_mode == ATH11K_PKTLOG_MODE_LITE);
+}
+
+static inline bool ath11k_debug_is_pktlog_rx_stats_enabled(struct ath11k *ar)
+{
+	return (!ar->debug.pktlog_peer_valid && ar->debug.pktlog_mode);
+}
+
+static inline bool ath11k_debug_is_pktlog_peer_valid(struct ath11k *ar, u8 *addr)
+{
+	return (ar->debug.pktlog_peer_valid && ar->debug.pktlog_mode &&
+		ether_addr_equal(addr, ar->debug.pktlog_peer_addr));
+}
+
+static inline int ath11k_debug_is_extd_tx_stats_enabled(struct ath11k *ar)
+{
+	return ar->debug.extd_tx_stats;
+}
+
+static inline int ath11k_debug_is_extd_rx_stats_enabled(struct ath11k *ar)
+{
+	return ar->debug.extd_rx_stats;
+}
+
+static inline int ath11k_debug_rx_filter(struct ath11k *ar)
+{
+	return ar->debug.rx_filter;
+}
+
+void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, struct dentry *dir);
+void
+ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
+				    struct ath11k_per_peer_tx_stats *peer_stats,
+				    u8 legacy_rate_idx);
+void ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
+					       struct sk_buff *msdu,
+					       struct hal_tx_status *ts);
+#else
+static inline int ath11k_debug_soc_create(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+static inline void ath11k_debug_soc_destroy(struct ath11k_base *ab)
+{
+}
+
+static inline int ath11k_debug_pdev_create(struct ath11k_base *ab)
+{
+	return 0;
+}
+
+static inline void ath11k_debug_pdev_destroy(struct ath11k_base *ab)
+{
+}
+
+static inline int ath11k_debug_register(struct ath11k *ar)
+{
+	return 0;
+}
+
+static inline void ath11k_debug_unregister(struct ath11k *ar)
+{
+}
+
+static inline void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
+						    struct sk_buff *skb)
+{
+}
+
+static inline void ath11k_debug_fw_stats_process(struct ath11k_base *ab,
+						 struct sk_buff *skb)
+{
+}
+
+static inline void ath11k_debug_fw_stats_init(struct ath11k *ar)
+{
+}
+
+static inline int ath11k_debug_is_extd_tx_stats_enabled(struct ath11k *ar)
+{
+	return 0;
+}
+
+static inline int ath11k_debug_is_extd_rx_stats_enabled(struct ath11k *ar)
+{
+	return 0;
+}
+
+static inline int ath11k_dbg_htt_stats_req(struct ath11k *ar)
+{
+	return 0;
+}
+
+static inline bool ath11k_debug_is_pktlog_lite_mode_enabled(struct ath11k *ar)
+{
+	return false;
+}
+
+static inline bool ath11k_debug_is_pktlog_rx_stats_enabled(struct ath11k *ar)
+{
+	return false;
+}
+
+static inline bool ath11k_debug_is_pktlog_peer_valid(struct ath11k *ar, u8 *addr)
+{
+	return false;
+}
+
+static inline int ath11k_debug_rx_filter(struct ath11k *ar)
+{
+	return 0;
+}
+
+static inline void
+ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
+				    struct ath11k_per_peer_tx_stats *peer_stats,
+				    u8 legacy_rate_idx)
+{
+}
+
+static inline void
+ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
+					  struct sk_buff *msdu,
+					  struct hal_tx_status *ts)
+{
+}
+
+#endif /* CONFIG_MAC80211_DEBUGFS*/
+
+#endif /* _ATH11K_DEBUGFS_H_ */
-- 
2.7.4

