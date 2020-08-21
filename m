Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B1924CCCF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 06:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgHUEbl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 00:31:41 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:10490 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725270AbgHUEbj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 00:31:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597984298; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=7hrMHQuHOZZyvXrcYPfzMJdqsvtpraFgN7+jKb7CmFE=; b=d/fwJT6CUKOWcqt26QIY2/btpRWe8Tx5Syh0aIejU47wM50XrIY3U9uTbzJuuhyWloYt/nkO
 zHmb4y4+51gz3l+KCXOotUfqTsEV9TJIT5z6T1NIPbPd9kD7wB6SrD4wr0BOvhEER0iKxFd/
 ggUjffBStXCFv2PApWmhpEWyFrg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f3f4e0d949572eafb2081b1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 Aug 2020 04:31:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61DA7C433CB; Fri, 21 Aug 2020 04:31:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from localhost.localdomain (unknown [183.192.23.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D7D5C433CA;
        Fri, 21 Aug 2020 04:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D7D5C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v5] ath10k: add atomic protection for device recovery
Date:   Fri, 21 Aug 2020 12:31:28 +0800
Message-Id: <1597984288-4141-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When it has more than one restart_work queued meanwhile, the 2nd
restart_work is very easy to break the 1st restart work and lead
recovery fail.

Add a flag to allow only one restart work running untill
device successfully recovered.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v5: change ref count to BIT dev flag, change all 
queue_work(ar->workqueue, &ar->restart_work) to ath10k_core_start_recovery

v4: add atomic_dec(&ar->restart_count) if state is not on

v3: change atomic_inc_and_test to atomic_add_return, remove check of ATH10K_STATE_ON

v2: add "add refcount for ath10k_core_restart" and remove ar_sdio->can_recovery
 drivers/net/wireless/ath/ath10k/core.c  | 11 +++++++++++
 drivers/net/wireless/ath/ath10k/core.h  |  4 ++++
 drivers/net/wireless/ath/ath10k/debug.c |  6 +++---
 drivers/net/wireless/ath/ath10k/mac.c   |  1 +
 drivers/net/wireless/ath/ath10k/pci.c   |  2 +-
 drivers/net/wireless/ath/ath10k/sdio.c  |  6 +++---
 drivers/net/wireless/ath/ath10k/snoc.c  |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c   |  2 +-
 8 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index cfffd20df0cc..a9c3cbb400be 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2277,6 +2277,17 @@ static int ath10k_init_hw_params(struct ath10k *ar)
 	return 0;
 }
 
+void ath10k_core_start_recovery(struct ath10k *ar)
+{
+	if (test_and_set_bit(ATH10K_FLAG_RESTARTING, &ar->dev_flags)) {
+		ath10k_warn(ar, "already restarting\n");
+		return;
+	}
+
+	queue_work(ar->workqueue, &ar->restart_work);
+}
+EXPORT_SYMBOL(ath10k_core_start_recovery);
+
 static void ath10k_core_restart(struct work_struct *work)
 {
 	struct ath10k *ar = container_of(work, struct ath10k, restart_work);
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 5c18f6c20462..347137ab7c09 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -837,6 +837,9 @@ enum ath10k_dev_flags {
 
 	/* Per Station statistics service */
 	ATH10K_FLAG_PEER_STATS,
+
+	/* Indicates that ath10k device is during recovery process and not complete */
+	ATH10K_FLAG_RESTARTING,
 };
 
 enum ath10k_cal_mode {
@@ -1291,6 +1294,7 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 		      const struct ath10k_fw_components *fw_components);
 int ath10k_wait_for_suspend(struct ath10k *ar, u32 suspend_opt);
 void ath10k_core_stop(struct ath10k *ar);
+void ath10k_core_start_recovery(struct ath10k *ar);
 int ath10k_core_register(struct ath10k *ar,
 			 const struct ath10k_bus_params *bus_params);
 void ath10k_core_unregister(struct ath10k *ar);
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index e8250a665433..6b6dde513bab 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -583,7 +583,7 @@ static ssize_t ath10k_write_simulate_fw_crash(struct file *file,
 		ret = ath10k_debug_fw_assert(ar);
 	} else if (!strcmp(buf, "hw-restart")) {
 		ath10k_info(ar, "user requested hw restart\n");
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 		ret = 0;
 	} else {
 		ret = -EINVAL;
@@ -2005,7 +2005,7 @@ static ssize_t ath10k_write_btcoex(struct file *file,
 		}
 	} else {
 		ath10k_info(ar, "restarting firmware due to btcoex change");
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 	}
 
 	if (val)
@@ -2136,7 +2136,7 @@ static ssize_t ath10k_write_peer_stats(struct file *file,
 
 	ath10k_info(ar, "restarting firmware due to Peer stats change");
 
-	queue_work(ar->workqueue, &ar->restart_work);
+	ath10k_core_start_recovery(ar);
 	ret = count;
 
 exit:
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 82b4bf5ba612..9980011feea8 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7268,6 +7268,7 @@ static void ath10k_reconfig_complete(struct ieee80211_hw *hw,
 		ath10k_info(ar, "device successfully recovered\n");
 		ar->state = ATH10K_STATE_ON;
 		ieee80211_wake_queues(ar->hw);
+		clear_bit(ATH10K_FLAG_RESTARTING, &ar->dev_flags);
 	}
 
 	mutex_unlock(&ar->conf_mutex);
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 36426efdb2ea..a21b44ea04ab 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1774,7 +1774,7 @@ static void ath10k_pci_fw_dump_work(struct work_struct *work)
 
 	mutex_unlock(&ar->dump_mutex);
 
-	queue_work(ar->workqueue, &ar->restart_work);
+	ath10k_core_start_recovery(ar);
 }
 
 static void ath10k_pci_fw_crashed_dump(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 81ddaafb6721..eef96dd1e1ff 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -561,7 +561,7 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 				    ATH10K_HTC_MBOX_MAX_PAYLOAD_LENGTH);
 			ret = -ENOMEM;
 
-			queue_work(ar->workqueue, &ar->restart_work);
+			ath10k_core_start_recovery(ar);
 			ath10k_warn(ar, "exceeds length, start recovery\n");
 
 			goto err;
@@ -960,7 +960,7 @@ static int ath10k_sdio_mbox_read_int_status(struct ath10k *ar,
 	ret = ath10k_sdio_read(ar, MBOX_HOST_INT_STATUS_ADDRESS,
 			       irq_proc_reg, sizeof(*irq_proc_reg));
 	if (ret) {
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 		ath10k_warn(ar, "read int status fail, start recovery\n");
 		goto out;
 	}
@@ -2501,7 +2501,7 @@ void ath10k_sdio_fw_crashed_dump(struct ath10k *ar)
 
 	ath10k_sdio_enable_intrs(ar);
 
-	queue_work(ar->workqueue, &ar->restart_work);
+	ath10k_core_start_recovery(ar);
 }
 
 static int ath10k_sdio_probe(struct sdio_func *func,
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 645ed5f63ef8..9ab696f758bd 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1295,7 +1295,7 @@ int ath10k_snoc_fw_indication(struct ath10k *ar, u64 type)
 	switch (type) {
 	case ATH10K_QMI_EVENT_FW_READY_IND:
 		if (test_bit(ATH10K_SNOC_FLAG_REGISTERED, &ar_snoc->flags)) {
-			queue_work(ar->workqueue, &ar->restart_work);
+			ath10k_core_start_recovery(ar);
 			break;
 		}
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index a81a1ab2de19..c6be27ad7543 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1936,7 +1936,7 @@ int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id)
 	if (ret == -EAGAIN) {
 		ath10k_warn(ar, "wmi command %d timeout, restarting hardware\n",
 			    cmd_id);
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 	}
 
 	return ret;
-- 
2.23.0

